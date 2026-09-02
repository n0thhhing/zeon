"""
verify_all_asm.py — verifies that zeon intrinsics lower to native ISA instructions
without unexpected function calls, across multiple target architectures.

Supported targets:
  aarch64-linux         AArch64 NEON (explicit inline asm)
  arm-linux-gnueabihf   ARM32 NEON   (explicit inline asm)
  x86_64-linux          x86_64 SSE/AVX (LLVM auto-vectorized portables)
  riscv64-linux         RISC-V RVV   (LLVM auto-vectorized portables)
  powerpc64le-linux     AltiVec/VSX  (LLVM auto-vectorized portables)
  loongarch64-linux     LSX/LASX     (LLVM auto-vectorized portables)
"""
import re
import sys
import platform
import argparse


# ── Per-arch configuration ────────────────────────────────────────────────────

ARCH_CONFIGS = {
    # triple prefix → config dict
    "aarch64": {
        "call_re":  re.compile(r'^\s+bl\s+(\S+)', re.MULTILINE),
        "frame_res": [
            r'stp\s+x29, x30',
            r'mov\s+x29, sp',
            r'add\s+x29, sp',
            r'sub\s+sp, sp',
            r'ldp\s+x29, x30',
            r'add\s+sp, sp',
            r'^ret$',
        ],
        "skip_calls": {"stack_chk", "memcpy", "FullPanic", "Panic", "memmove"},
    },
    "arm-linux": {
        "call_re":  re.compile(r'^\s+bl\s+(\S+)', re.MULTILINE),
        "frame_res": [
            r'push\s+\{',
            r'pop\s+\{',
            r'vpush',
            r'vpop',
            r'sub\s+sp,',
            r'add\s+sp,',
            r'^bx\s+lr$',
        ],
        "skip_calls": {"stack_chk", "memcpy", "FullPanic", "Panic", "aeabi"},
    },
    "x86_64": {
        "call_re":  re.compile(r'^\s+call(?:q)?\s+(\S+)', re.MULTILINE),
        "frame_res": [
            r'push\s+r(bp|bx|12|13|14|15)\b',
            r'pop\s+r(bp|bx|12|13|14|15)\b',
            r'mov\s+(r|e)bp,\s*(r|e)sp',
            r'sub\s+rsp,',
            r'add\s+rsp,',
            r'^ret(?:q)?$',
        ],
        "skip_calls": {"stack_chk", "FullPanic", "Panic", "memmove", "memcpy"},
    },
    "riscv64": {
        # riscv: pseudo `call sym` expands to auipc+jalr; raw call looks like `call sym`
        "call_re":  re.compile(r'^\s+call\s+(\S+)', re.MULTILINE),
        "frame_res": [
            r'addi\s+sp,\s*sp,\s*-',
            r'sd\s+ra,',
            r'sd\s+s\d+,',
            r'ld\s+ra,',
            r'ld\s+s\d+,',
            r'addi\s+sp,\s*sp,\s*\d',  # stack restore
            r'^ret$',
            r'addi\s+s0,\s*sp',
        ],
        "skip_calls": {"stack_chk", "FullPanic", "Panic"},
    },
    "powerpc64": {
        "call_re":  re.compile(r'^\s+bl\s+(\S+)', re.MULTILINE),
        "frame_res": [
            r'mflr\s+',
            r'std\s+r\d+,',
            r'stdu\s+r1,',
            r'ld\s+r\d+,',
            r'mtlr\s+',
            r'^blr$',
            r'addi\s+r1,',
        ],
        "skip_calls": {"stack_chk", "FullPanic", "Panic", "memmove", "memcpy"},
    },
    "loongarch64": {
        # LoongArch uses pcaddu18i $ra, %call36(sym) + jirl $ra,$ra,0
        "call_re":  re.compile(r'pcaddu18i\s+\$ra,\s*%call36\((\S+)\)', re.MULTILINE),
        "frame_res": [
            r'addi\.d\s+\$sp,\s*\$sp,\s*-',
            r'st\.d\s+\$ra,',
            r'st\.d\s+\$fp,',
            r'st\.d\s+\$s\d+,',
            r'ld\.d\s+\$ra,',
            r'ld\.d\s+\$fp,',
            r'ld\.d\s+\$s\d+,',
            r'addi\.d\s+\$fp,\s*\$sp',
            r'addi\.d\s+\$sp,\s*\$sp,\s*\d',
            r'^ret$',
            r'jr\s+\$ra',
        ],
        "skip_calls": {"stack_chk", "FullPanic", "Panic"},
    },
    "wasm32": {
        "call_re":  re.compile(r'^\s+call\s+(\S+)', re.MULTILINE),
        "frame_res": [
            r'local\.(get|set|tee)\b',
            r'global\.(get|set)\b',
            r'end_function',
            r'^return$',
            r'i32\.const',
            r'i32\.add',
            r'i32\.sub',
        ],
        "skip_calls": {
            "fminf", "fmaxf", "fmax", "fmin", "__fmaxh", "__fminh",
            "__ashlti3", "__multi3", "fma", "fmaf",
            "__mulhf3", "__subhf3", "__addhf3", "__fabsh", "__divhf3", "__gnu_",
            "stack_chk", "FullPanic", "Panic", "memmove", "memcpy",
        },
    },
}


def get_arch_config(target: str) -> dict:
    for key, cfg in ARCH_CONFIGS.items():
        if key in target:
            return cfg
    # default: try bl-style
    return ARCH_CONFIGS["aarch64"]


# ── Common boilerplate lines to always skip ────────────────────────────────

ALWAYS_SKIP_RES = [
    # ABI load/store for struct-return pointer args
    r'^(ldr|str|ldp|stp|stur|ldur|vstr|vldr|ld|sd|lw|sw)\b',
    # x86 load/store
    r'^(mov[a-z]*\s+[%\[]|vmov[a-z]*\s)',
    # split-BB jumps from ReleaseFast (all ISAs)
    r'^b(?:ne|eq|lt|gt|le|ge|x|cc|cs|hi|ls|mi|pl|vc|vs)?\s+\.?L?BB\d+',
    r'^j(?:mp|e|ne|l|g|le|ge|z|nz|b|a|be|ae|s|ns)\s+\.?L',
    # LoongArch branch-and-link to next BB
    r'^b(?:eq|ne|lt|le|gt|ge)\s+\$',
    # RISC-V branch to .LBB
    r'^b(?:eq|ne|lt|ge|ltu|geu)\s+',
    # macOS SIMD stack alignment
    r'^sub\s+x9, sp,',
    r'^and\s+sp,\s+x\d+,\s+#0x',
    r'^mov\s+sp, x29',
    # ABI register moves
    r'^mov\s+[xwr]\d+,\s*[xwr]\d+$',
    r'^move\s+\$\w+,\s*\$\w+$',      # MIPS/LoongArch move
    r'^mv\s+\w+,\s*\w+$',             # RISC-V mv
    r'^mr\s+r\d+, r\d+$',             # PowerPC mr
]
ALWAYS_SKIP = [re.compile(p) for p in ALWAYS_SKIP_RES]


def is_boilerplate(line: str, frame_res: list[str]) -> bool:
    for pat in ALWAYS_SKIP:
        if pat.match(line):
            return True
    for pat in frame_res:
        if re.match(pat, line):
            return True
    return False


# ── Main ──────────────────────────────────────────────────────────────────────

def main():
    parser = argparse.ArgumentParser(
        description="Verify NEON intrinsics lower to native ISA instructions")
    parser.add_argument("--target", default="aarch64-linux",
                        help="Target triple being verified (default: aarch64-linux)")
    parser.add_argument("--asm", default="tests/asm_verification/check_all_asm.s",
                        help="Path to generated .s file")
    args = parser.parse_args()

    target = args.target
    is_linux_host = platform.system() == "Linux"
    cfg = get_arch_config(target)
    frame_res = [re.compile(p) for p in cfg["frame_res"]]
    skip_calls_always = {"stack_chk"}
    skip_calls_nonlinux = cfg["skip_calls"] if not is_linux_host else set()

    print(f"Verifying target: {target}")

    try:
        with open(args.asm, "r") as f:
            asm = f.read()
    except FileNotFoundError:
        print(f"Failed to find {args.asm}")
        sys.exit(1)

    # Split file into per-function chunks.
    # Handles ELF (check_all_asm.) and Mach-O (_check_all_asm.) prefixes.
    func_split = re.compile(r'(?=_?check_all_asm\.check_[a-zA-Z0-9_]+:\n)')
    chunks = func_split.split(asm)

    func_bodies: dict[str, str] = {}
    func_name_re = re.compile(
        r'^_?check_all_asm\.check_([a-zA-Z0-9_]+):\n', re.MULTILINE)
    for chunk in chunks:
        m = func_name_re.match(chunk)
        if not m:
            continue
        name = m.group(1)
        if name not in func_bodies:
            func_bodies[name] = chunk[m.end():]

    print(f"Parsed {len(func_bodies)} generated test functions from assembly.")

    failed = []

    for func_name, body in func_bodies.items():
        # ── Call check ──────────────────────────────────────────────────────
        calls = cfg["call_re"].findall(body)
        skip = skip_calls_always | skip_calls_nonlinux
        real_calls = [c for c in calls if not any(s in c for s in skip)]
        if real_calls:
            failed.append(func_name)
            print(f"❌ [{target}] check_{func_name} calls '{real_calls[0]}' — not inlined!")
            continue

        # ── Instruction-count check (Linux CI only) ─────────────────────────
        if not is_linux_host:
            continue

        actual = []
        for line in body.split('\n'):
            line = line.strip()
            if not line or line.startswith('.') or line.endswith(':'):
                continue
            if not is_boilerplate(line, frame_res):
                actual.append(line)

        # Threshold: most intrinsics are 1-3 instructions.
        # Some (reductions, widening ops, multi-step) need more headroom.
        threshold = 16
        if len(actual) > threshold:
            failed.append(func_name)
            print(f"❌ [{target}] check_{func_name} has {len(actual)} instructions "
                  f"(threshold={threshold}) — not 1:1!")
            for instr in actual[:10]:
                print(f"   {instr}")
            if len(actual) > 10:
                print(f"   … ({len(actual) - 10} more)")
            print()

    if failed:
        print(f"\n{len(failed)} functions failed for target {target}.")
        sys.exit(1)
    else:
        print(f"\n✅ All {len(func_bodies)} intrinsic functions compile to "
              f"native instructions on {target}!")


if __name__ == "__main__":
    main()
