import subprocess
import sys
import re

def main():
    print("Running assembly verification...")
    
    # Run zig build-obj to emit assembly
    cmd = [
        "zig", "build-obj", 
        "-O", "ReleaseFast", 
        "-target", "aarch64-linux",
        "-mcpu=generic+aes", 
        "--dep", "zeon", 
        "-Mroot=tests/check_asm.zig", 
        "-Mzeon=src/zeon.zig", 
        "-femit-asm=check_asm.s"
    ]
    
    try:
        subprocess.run(cmd, check=True, capture_output=True, text=True)
    except subprocess.CalledProcessError as e:
        print(f"Failed to compile tests/check_asm.zig:\n{e.stderr}")
        sys.exit(1)
        
    try:
        with open("check_asm.s", "r") as f:
            asm = f.read()
    except FileNotFoundError:
        print("Failed to find check_asm.s")
        sys.exit(1)
        
    # We parse the assembly to find the body of each function
    func_pattern = re.compile(r'check_asm\.([a-zA-Z0-9_]+):(.*?)(\.size|\.Lfunc_end)', re.DOTALL)
    
    expected_instructions = {
        "test_vadd_u8": ["add\t"],
        "test_aese": ["aese\t"],
        "test_vld1_u8": ["ldr\t"],
        "test_vand_u32": ["and\t"],
        "test_vceq_s16": ["cmeq\t"],
        "test_vrev64q_s8": ["rev64\t"]
    }
    
    matches = func_pattern.findall(asm)
    found_funcs = {}
    for func_name, func_body, _ in matches:
        found_funcs[func_name] = func_body
        
    all_passed = True
    
    for func, instrs in expected_instructions.items():
        if func not in found_funcs:
            print(f"❌ Function {func} not found in assembly!")
            all_passed = False
            continue
            
        body = found_funcs[func]
        for instr in instrs:
            if instr not in body:
                print(f"❌ Expected instruction '{instr.strip()}' in {func}, but it was missing.")
                print(f"   Assembly body:\n{body.strip()}")
                all_passed = False
            else:
                print(f"✅ {func} correctly compiled to target intrinsic '{instr.strip()}'")
                
    if not all_passed:
        sys.exit(1)
    else:
        print("All assembly verifications passed! 🎉")

if __name__ == "__main__":
    main()
