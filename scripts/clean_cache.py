import sys
import shutil
from pathlib import Path

def clean(preserve_handles=True):
    shutil.rmtree("zig-out", ignore_errors=True)

    cache = Path(".zig-cache")
    if not cache.exists():
        return

    if not preserve_handles:
        shutil.rmtree(cache, ignore_errors=True)
        return

    # When preserve_handles is True, purge cached manifests and temporary outputs
    # but preserve the directory inodes (.zig-cache, .zig-cache/h, .zig-cache/z, etc.)
    # that the running zig build runner process keeps open.
    for sub in ["h", "z", "tmp"]:
        subdir = cache / sub
        if subdir.exists():
            for item in subdir.iterdir():
                try:
                    if item.is_dir():
                        shutil.rmtree(item, ignore_errors=True)
                    else:
                        item.unlink(missing_ok=True)
                except Exception:
                    pass

if __name__ == "__main__":
    all_clean = "--all" in sys.argv
    clean(preserve_handles=not all_clean)
