import os

def parse_args(args_str):
    args = []
    current_arg = ""
    depth = 0
    for char in args_str:
        if char in '([{<':
            depth += 1
        elif char in ')]}>':
            depth -= 1
            
        if char == ',' and depth == 0:
            if current_arg.strip():
                args.append(current_arg.strip())
            current_arg = ""
        else:
            current_arg += char
            
    if current_arg.strip():
        args.append(current_arg.strip())
        
    parsed_args = []
    for arg_str in args:
        is_comptime = False
        if "comptime " in arg_str:
            is_comptime = True
            arg_str = arg_str.replace("comptime ", "")
            
        parts = arg_str.split(':', 1)
        arg_name = parts[0].strip()
        arg_type = parts[1].strip() if len(parts) > 1 else ""
        
        parsed_args.append({
            "name": arg_name,
            "type": arg_type,
            "is_comptime": is_comptime
        })
    return parsed_args

def fix_type(t):
    import re
    for p in ["p8", "p16", "p64", "p128"]:
        t = re.sub(rf'\b{p}\b', f'neon.{p}', t)
    
    if t.endswith("x1") or t.endswith("x2") or t.endswith("x3") or t.endswith("x4") or t.endswith("x8") or t.endswith("x16") or t.endswith("_t"):
        if not t.startswith("neon."):
            t = "neon." + t
    return t

def parse_functions(content):
    functions = []
    idx = 0
    while True:
        idx = content.find("pub inline fn ", idx)
        if idx == -1:
            break
        idx += len("pub inline fn ")
        
        # Parse func_name
        name_end = content.find("(", idx)
        if name_end == -1: break
        func_name = content[idx:name_end].strip()
        
        # Parse arguments (count parentheses)
        idx = name_end + 1
        depth = 1
        args_start = idx
        while depth > 0 and idx < len(content):
            char = content[idx]
            if char == '(': depth += 1
            elif char == ')': depth -= 1
            idx += 1
        args_end = idx - 1
        args_str = content[args_start:args_end]
        
        # Parse return type (from end of args to '{')
        ret_start = idx
        ret_end = content.find("{", ret_start)
        if ret_end == -1: break
        ret_type = content[ret_start:ret_end].strip()
        
        args = parse_args(args_str)
        
        functions.append({
            "name": func_name,
            "args": args,
            "ret_type": ret_type
        })
        idx = ret_end
        
    return functions

def main():
    intrinsics_dir = "src/intrinsics"
    out_file = "tests/asm_verification/check_all_asm.zig"
    
    functions = []
    
    for filename in os.listdir(intrinsics_dir):
        if not filename.endswith(".zig"):
            continue
        filepath = os.path.join(intrinsics_dir, filename)
        with open(filepath, "r") as f:
            content = f.read()
            
        functions.extend(parse_functions(content))

    print(f"Found {len(functions)} intrinsic functions.")
    
    with open(out_file, "w") as f:
        f.write('const neon = @import("zeon");\n')
        f.write('const std = @import("std");\n\n')
        
        for func in functions:
            func_name = func["name"]
            
            wrapper_args = []
            call_args = []
            for i, arg in enumerate(func["args"]):
                arg_name = f"arg{i}"
                if arg["is_comptime"]:
                    call_args.append("0")
                else:
                    arg_type = fix_type(arg["type"])
                    if "x2" in arg_type or "x3" in arg_type or "x4" in arg_type:
                        wrapper_args.append(f"{arg_name}: *const {arg_type}")
                        call_args.append(f"{arg_name}.*")
                    else:
                        wrapper_args.append(f"{arg_name}: {arg_type}")
                        call_args.append(arg_name)
                    
            ret_type = fix_type(func["ret_type"])
            is_ptr_ret = False
            if "x2" in ret_type or "x3" in ret_type or "x4" in ret_type:
                is_ptr_ret = True
                wrapper_args.append(f"out_ptr: *{ret_type}")
                ret_type = "void"
                
            f.write(f'export fn check_{func_name}({", ".join(wrapper_args)}) {ret_type} {{\n')
            if ret_type == "void":
                if is_ptr_ret:
                    f.write(f'    out_ptr.* = neon.{func_name}({", ".join(call_args)});\n')
                else:
                    f.write(f'    neon.{func_name}({", ".join(call_args)});\n')
            else:
                f.write(f'    return neon.{func_name}({", ".join(call_args)});\n')
            f.write('}\n\n')

if __name__ == "__main__":
    main()
