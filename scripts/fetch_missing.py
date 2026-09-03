import re
import glob
import sys

def get_implemented_intrinsics():
    implemented = set()
    for f in glob.glob('src/intrinsics/*.zig'):
        with open(f, 'r') as file:
            content = file.read()
            # match `pub inline fn v...(`
            matches = re.findall(r'pub inline fn (v[a-zA-Z0-9_]+)\(', content)
            implemented.update(matches)
    return implemented

def get_all_neon_intrinsics(header_path='/opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/include/arm_neon.h'):
    try:
        with open(header_path, 'r') as f:
            content = f.read()
    except FileNotFoundError:
        print(f"Could not find {header_path}")
        sys.exit(1)
        
    # Matches `__ai __attribute__... ret_type vfunc_name(...)`
    # Also match `__ai ret_type vfunc_name(...)`
    definitions = re.findall(r'__ai\s+.*?([a-zA-Z0-9_]+)\s*\([^)]*\)\s*\{', content)
    
    intrinsics = set()
    for d in definitions:
        if d.startswith('v'):
            intrinsics.add(d)
            
    # Some might not have __ai but static __inline__
    more_defs = re.findall(r'static __inline__[^;\n]*?\s+(v[a-zA-Z0-9_]+)\s*\(', content)
    for d in more_defs:
        intrinsics.add(d)
        
    return intrinsics

if __name__ == '__main__':
    implemented = get_implemented_intrinsics()
    all_neon = get_all_neon_intrinsics()
    
    missing = all_neon - implemented
    
    print(f"Total ARM NEON intrinsics in clang header: {len(all_neon)}")
    print(f"Total implemented in zeon: {len(implemented)}")
    print(f"Missing intrinsics to implement: {len(missing)}")
    
    with open('missing_intrinsics.txt', 'w') as f:
        f.write('\n'.join(sorted(missing)))
        
    print("\nWrote full list of missing intrinsics to `missing_intrinsics.txt`.")
    print("Here is a sample of 20 missing intrinsics:")
    for m in sorted(list(missing))[:20]:
        print(f"  - {m}")
