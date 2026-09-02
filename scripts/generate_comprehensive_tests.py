import os
import re

def parse_args(args_str):
    args = []
    current_arg = ""
    depth = 0
    for char in args_str:
        if char in '([{<': depth += 1
        elif char in ')]}>': depth -= 1
        if char == ',' and depth == 0:
            if current_arg.strip(): args.append(current_arg.strip())
            current_arg = ""
        else: current_arg += char
    if current_arg.strip(): args.append(current_arg.strip())
        
    parsed_args = []
    for arg_str in args:
        is_comptime = False
        if "comptime " in arg_str:
            is_comptime = True
            arg_str = arg_str.replace("comptime ", "")
            
        parts = arg_str.split(':', 1)
        arg_name = parts[0].strip()
        arg_type = parts[1].strip() if len(parts) > 1 else ""
        
        parsed_args.append({"name": arg_name, "type": arg_type, "is_comptime": is_comptime})
    return parsed_args

def fix_type(t):
    for p in ["p8", "p16", "p64", "p128"]: t = re.sub(rf'\b{p}\b', f'neon.{p}', t)
    if re.search(r'x\d+$', t) or re.search(r'_t$', t):
        if not t.startswith("neon."): t = "neon." + t
    return t

def parse_functions(content):
    functions = []
    idx = 0
    while True:
        idx = content.find("pub inline fn ", idx)
        if idx == -1: break
        idx += len("pub inline fn ")
        name_end = content.find("(", idx)
        if name_end == -1: break
        func_name = content[idx:name_end].strip()
        
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
        
        ret_start = idx
        ret_end = content.find("{", ret_start)
        if ret_end == -1: break
        ret_type = content[ret_start:ret_end].strip()
        
        args = parse_args(args_str)
        functions.append({"name": func_name, "args": args, "ret_type": ret_type})
        idx = ret_end
        
    return functions

def main():
    intrinsics_dir = "src/intrinsics"
    out_file = "tests/comprehensive_tests.zig"
    functions = []
    
    for filename in os.listdir(intrinsics_dir):
        if not filename.endswith(".zig"): continue
        filepath = os.path.join(intrinsics_dir, filename)
        with open(filepath, "r") as f:
            content = f.read()
        functions.extend(parse_functions(content))

    print(f"Generating comprehensive tests for {len(functions)} functions.")
    
    with open(out_file, "w") as f:
        f.write('const neon = @import("zeon");\n')
        f.write('const std = @import("std");\n\nvar global_buffer: [1024]u8 = undefined;\n\n')
        
        # Generator function inside Zig
        f.write('''
fn makeData(comptime T: type, offset: usize) T {
    switch (@typeInfo(T)) {
        .@"struct" => {
            var res: T = undefined;
            const fields = std.meta.fields(T);
            inline for (0..fields.len) |i| {
                res[i] = makeData(fields[i].type, offset + i * 10);
            }
            return res;
        },
        .vector => |v| {
            var res: T = undefined;
            const len = v.len;
            const Child = v.child;
            inline for (0..len) |i| {
                const val: usize = (i + offset) % 127;
                switch (@typeInfo(Child)) {
                    .float => res[i] = @as(Child, @floatFromInt(val)),
                    else => res[i] = @as(Child, @intCast(val)),
                }
            }
            return res;
        },
        .int => return @as(T, @intCast(offset % 127)),
        else => if (@typeInfo(T) == .int) return @as(T, @intCast(offset % 127)) else @compileError("Unsupported type for makeData"),
    }
}

fn expectEqualApprox(expected: anytype, actual: @TypeOf(expected)) !void {
    const T = @TypeOf(expected);
    switch (@typeInfo(T)) {
        .@"struct" => {
            const fields = std.meta.fields(T);
            inline for (0..fields.len) |i| {
                try expectEqualApprox(expected[i], actual[i]);
            }
            return;
        },
        .vector => |v| {
            const Child = v.child;
            const len = v.len;
            inline for (0..len) |i| {
                switch (@typeInfo(Child)) {
                    .float => {
                        if (!(std.math.isNan(expected[i]) and std.math.isNan(actual[i]))) {
                            try std.testing.expectApproxEqAbs(expected[i], actual[i], 0.0001);
                        }
                    },
                    else => try std.testing.expectEqual(expected[i], actual[i]),
                }
            }
        },
        else => return std.testing.expectEqual(expected, actual),
    }
}
''')

        for func in functions:
            func_name = func["name"]
            
            f.write(f'test "{func_name}" {{\n')
            call_args = []
            
            for i, arg in enumerate(func["args"]):
                arg_name = f"arg{i}"
                if arg["is_comptime"]:
                    f.write(f'    const {arg_name}: usize = 0;\n')
                    call_args.append(arg_name)
                elif arg["type"].startswith("comptime"):
                    f.write(f'    const {arg_name} = 0;\n')
                    call_args.append(arg_name)
                else:
                    arg_type = fix_type(arg["type"])
                    # If arg is just scalar, like u32
                    if "[*]" in arg_type:
                        f.write(f'    const {arg_name}: {arg_type} = @ptrCast(@alignCast(&global_buffer));\n')
                    elif not "x" in arg_type and not "neon." in arg_type:
                        f.write(f'    const {arg_name}: {arg_type} = 1;\n')
                    else:
                        f.write(f'    const {arg_name} = comptime makeData({arg_type}, {i * 13});\n')
                    call_args.append(arg_name)
                    
            ret_type = fix_type(func["ret_type"])
            if "aes" in func_name or "sha" in func_name or "vld" in func_name or "vst" in func_name or (func_name.startswith("vshl") and not "_n_" in func_name):
                f.write(f'    _ = neon.{func_name}({", ".join(call_args)});\n')
            elif ret_type == "void":
                f.write(f'    comptime neon.{func_name}({", ".join(call_args)});\n')
                f.write(f'    neon.{func_name}({", ".join(call_args)});\n')
            else:
                f.write(f'    const expected = comptime neon.{func_name}({", ".join(call_args)});\n')
                f.write(f'    const actual = neon.{func_name}({", ".join(call_args)});\n')
                f.write(f'    try expectEqualApprox(expected, actual);\n')
            
            f.write('}\n\n')

if __name__ == "__main__":
    main()
