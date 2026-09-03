#!/usr/bin/env python3
"""
ARM NEON Intrinsics Coverage & Gap Analyzer for Zeon.

Compares functions implemented in `src/intrinsics/*.zig` against clang's `arm_neon.h`
header to track implementation progress and update `scripts/missing_intrinsics.txt`.
"""

from __future__ import annotations

import argparse
import glob
import json
import os
import re
import subprocess
import sys
from pathlib import Path


def get_project_root() -> Path:
    """Returns the repository root directory."""
    return Path(__file__).resolve().parent.parent


def find_arm_neon_header(custom_path: str | None = None) -> Path:
    """Dynamically locates the arm_neon.h header across environments and OSes."""
    if custom_path:
        p = Path(custom_path).resolve()
        if p.is_file():
            return p
        raise FileNotFoundError(f"Specified header path does not exist: {custom_path}")

    # 1. Try querying Zig directly via `zig env`
    try:
        out = subprocess.check_output(["zig", "env"], text=True, stderr=subprocess.DEVNULL)
        m = re.search(r'\.lib_dir\s*=\s*"([^"]+)"', out)
        if m:
            candidate = Path(m.group(1)) / "include" / "arm_neon.h"
            if candidate.is_file():
                return candidate
    except Exception:
        pass

    # 2. Check ZIG_LIB_DIR environment variable
    if "ZIG_LIB_DIR" in os.environ:
        candidate = Path(os.environ["ZIG_LIB_DIR"]) / "include" / "arm_neon.h"
        if candidate.is_file():
            return candidate

    # 3. Known platform locations & wildcards
    search_patterns = [
        "/opt/homebrew/Cellar/zig/*/lib/zig/include/arm_neon.h",
        "/opt/homebrew/opt/zig/lib/zig/include/arm_neon.h",
        "/usr/local/Cellar/zig/*/lib/zig/include/arm_neon.h",
        "/usr/local/lib/zig/include/arm_neon.h",
        "/usr/lib/zig/include/arm_neon.h",
        str(Path.home() / ".zig/include/arm_neon.h"),
    ]

    for pattern in search_patterns:
        matches = sorted(glob.glob(pattern), reverse=True)
        if matches:
            return Path(matches[0])

    raise FileNotFoundError(
        "Could not automatically locate `arm_neon.h`.\n"
        "Please ensure `zig` is in your PATH or specify the header via `--header /path/to/arm_neon.h`."
    )


def get_implemented_intrinsics(root_dir: Path) -> dict[str, str]:
    """Extracts all implemented intrinsics mapped to their defining module file."""
    implemented: dict[str, str] = {}
    intrinsics_dir = root_dir / "src" / "intrinsics"

    for file_path in sorted(intrinsics_dir.glob("*.zig")):
        content = file_path.read_text(encoding="utf-8")
        matches = re.findall(r"pub\s+(?:inline\s+)?fn\s+(v[a-zA-Z0-9_]+)\s*\(", content)
        for fn in matches:
            implemented[fn] = file_path.name

    return implemented


def get_all_neon_intrinsics(header_path: Path) -> set[str]:
    """Parses all NEON intrinsic function names from arm_neon.h."""
    content = header_path.read_text(encoding="utf-8", errors="ignore")

    intrinsics: set[str] = set()

    # Match `__ai ... vfunc_name(...) {`
    definitions = re.findall(r"__ai\s+.*?([a-zA-Z0-9_]+)\s*\([^)]*\)\s*\{", content)
    for d in definitions:
        if d.startswith("v"):
            intrinsics.add(d)

    # Match `static __inline__ ... vfunc_name(...)`
    more_defs = re.findall(r"static\s+__inline__[^;\n]*?\s+(v[a-zA-Z0-9_]+)\s*\(", content)
    for d in more_defs:
        if d.startswith("v"):
            intrinsics.add(d)

    return intrinsics


def format_progress_bar(percentage: float, width: int = 30) -> str:
    """Formats a modern visual ASCII progress bar."""
    filled = int(width * percentage / 100.0)
    bar = "=" * filled + (">" if filled < width else "") + "." * (width - filled - (1 if filled < width else 0))
    return f"[{bar}] {percentage:.1f}%"


def count_total_tests(root_dir: Path) -> int:
    """Counts all `test` declarations across src/."""
    total = 0
    for f in (root_dir / "src").rglob("*.zig"):
        content = f.read_text(encoding="utf-8")
        total += len(re.findall(r"^test(?:\s+\"?[a-zA-Z0-9_]*\"?)?\s*\{", content, re.MULTILINE))
    return total


def update_readme_status(
    root_dir: Path, impl_count: int, total_count: int, test_count: int, write: bool = True
) -> tuple[bool, bool]:
    """
    Checks and optionally updates the implementation status line in README.md.
    Returns (is_different, was_written).
    """
    readme_path = root_dir / "README.md"
    if not readme_path.is_file():
        return False, False

    content = readme_path.read_text(encoding="utf-8")
    pattern = r"\*\*[0-9,]+\s*/\s*[0-9,]+\*\*\s+intrinsics implemented(?:,\s+with\s+[0-9,]+\+?\s+unit tests passing)?"
    replacement = f"**{impl_count:,} / {total_count:,}** intrinsics implemented, with {test_count:,}+ unit tests passing"

    new_content = re.sub(pattern, replacement, content)
    is_different = new_content != content

    if is_different and write:
        readme_path.write_text(new_content, encoding="utf-8")
        return is_different, True

    return is_different, False


def main():
    parser = argparse.ArgumentParser(
        description="Track and inspect ARM NEON intrinsics coverage in Zeon.",
        formatter_class=argparse.RawDescriptionHelpFormatter,
    )
    parser.add_argument(
        "--header",
        metavar="PATH",
        help="Explicit path to arm_neon.h if not discoverable via `zig env`.",
    )
    parser.add_argument(
        "-s",
        "--summary",
        action="store_true",
        help="Display missing intrinsics grouped by category/prefix with counts.",
    )
    parser.add_argument(
        "-f",
        "--filter",
        metavar="PATTERN",
        help="Filter and display missing intrinsics matching a substring or regex.",
    )
    parser.add_argument(
        "--check",
        action="store_true",
        help="Check whether scripts/missing_intrinsics.txt is up-to-date (exits with code 1 if out of sync).",
    )
    parser.add_argument(
        "--json",
        action="store_true",
        help="Output coverage metrics in JSON format.",
    )
    parser.add_argument(
        "-q",
        "--quiet",
        action="store_true",
        help="Suppress console output unless an error occurs.",
    )
    parser.add_argument(
        "-n",
        "--sample-count",
        type=int,
        default=20,
        help="Number of missing intrinsic samples to preview (default: 20).",
    )

    args = parser.parse_args()
    root_dir = get_project_root()
    output_path = root_dir / "scripts" / "missing_intrinsics.txt"

    try:
        header_path = find_arm_neon_header(args.header)
    except FileNotFoundError as e:
        sys.stderr.write(f"Error: {e}\n")
        sys.exit(1)

    implemented_map = get_implemented_intrinsics(root_dir)
    implemented = set(implemented_map.keys())
    all_neon = get_all_neon_intrinsics(header_path)
    missing = sorted(all_neon - implemented)

    total_count = len(all_neon)
    impl_count = len(implemented)
    miss_count = len(missing)
    pct = (impl_count / total_count * 100.0) if total_count > 0 else 0.0

    # JSON export
    if args.json:
        report = {
            "header_path": str(header_path),
            "total_intrinsics": total_count,
            "implemented_count": impl_count,
            "missing_count": miss_count,
            "coverage_percent": round(pct, 2),
            "implemented": sorted(implemented),
            "missing": missing,
        }
        print(json.dumps(report, indent=2))
        return

    # Check mode for CI
    new_content = "\n".join(missing) + "\n"
    is_different = True
    if output_path.is_file():
        existing = output_path.read_text(encoding="utf-8")
        is_different = existing != new_content

    total_tests = count_total_tests(root_dir)
    readme_different, _ = update_readme_status(root_dir, impl_count, total_count, total_tests, write=False)

    if args.check:
        errs = []
        if is_different:
            errs.append("scripts/missing_intrinsics.txt is out of date!")
        if readme_different:
            errs.append("README.md Status section is out of date!")
        if errs:
            for err in errs:
                sys.stderr.write(f"{err}\n")
            sys.stderr.write("Run `python3 scripts/fetch_missing.py` to synchronize.\n")
            sys.exit(1)
        if not args.quiet:
            print("scripts/missing_intrinsics.txt and README.md are up-to-date.")
        sys.exit(0)

    # Idempotent write: only update file if content changed
    if is_different:
        output_path.write_text(new_content, encoding="utf-8")

    _, readme_updated = update_readme_status(root_dir, impl_count, total_count, total_tests, write=True)

    if args.quiet:
        return

    print("Zeon ARM NEON Intrinsics Coverage")
    print("=" * 45)
    print(f"Header Source    : {header_path}")
    print(f"Total in Header  : {total_count:,}")
    print(f"Implemented      : {impl_count:,}")
    print(f"Missing          : {miss_count:,}")
    print(f"Progress         : {format_progress_bar(pct)}")
    print("=" * 45)

    # Filter mode
    if args.filter:
        regex = re.compile(args.filter, re.IGNORECASE)
        filtered = [m for m in missing if regex.search(m)]
        print(f"\nMissing intrinsics matching '{args.filter}' ({len(filtered)} found):")
        for m in filtered[: args.sample_count]:
            print(f"  - {m}")
        if len(filtered) > args.sample_count:
            print(f"  ... and {len(filtered) - args.sample_count} more")
        return

    # Summary by family/prefix
    if args.summary:
        prefix_counts: dict[str, int] = {}
        for m in missing:
            prefix = m.split("_")[0]
            prefix_counts[prefix] = prefix_counts.get(prefix, 0) + 1

        print("\nMissing Intrinsics by Family (Top 25):")
        print(f"{'Family':<20} | {'Missing Count':<14}")
        print("-" * 37)
        for prefix, count in sorted(prefix_counts.items(), key=lambda x: -x[1])[:25]:
            print(f"{prefix:<20} | {count:<14}")
        return

    # Default sample preview
    sample_to_show = missing[: args.sample_count]
    print(f"\nFirst {len(sample_to_show)} missing intrinsics:")
    for m in sample_to_show:
        print(f"  - {m}")

    if is_different:
        print(f"\nUpdated `{output_path.relative_to(root_dir)}` with {miss_count:,} missing intrinsics.")
    else:
        print(f"\n`{output_path.relative_to(root_dir)}` is already up-to-date.")

    if readme_updated:
        print(f"Updated `README.md` Status: **{impl_count:,} / {total_count:,}** ({total_tests:,}+ unit tests).")
    else:
        print("`README.md` Status is already up-to-date.")


if __name__ == "__main__":
    main()
