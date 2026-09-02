import os
import glob

def process_file(filename, get_instruction_func):
    with open(filename, 'r') as f:
        content = f.read()

    # We will manually parse to find 'pub inline fn'
    out = []
    idx = 0
    modified = False

    while True:
        pos = content.find('pub inline fn ', idx)
        if pos == -1:
            out.append(content[idx:])
            break
        
        # Append everything before the function
        out.append(content[idx:pos])
        
        # Find the open brace
        brace_pos = content.find('{', pos)
        if brace_pos == -1:
            break
            
        decl = content[pos:brace_pos+1]
        
        # Extract function name and arguments
        sig = decl[14:decl.find(')')+1]
        func_name = sig.split('(')[0]
        args_str = sig.split('(')[1].rstrip(')')
        
        ret_part = decl[decl.find(')')+1:-1].strip()
        ret_type = ret_part
        
        # Find closing brace by counting
        count = 1
        curr = brace_pos + 1
        while count > 0 and curr < len(content):
            if content[curr] == '{': count += 1
            elif content[curr] == '}': count -= 1
            curr += 1
            
        body_with_close = content[brace_pos+1:curr]
        
        idx = curr
        
        # Now we process
        if 'return asm (' in body_with_close:
            out.append(decl + body_with_close)
            continue
            
        if 'p128' in args_str or 'p128' in ret_type:
            out.append(decl + body_with_close)
            continue
        args = [arg.strip().split(':')[0].strip() for arg in args_str.split(',') if arg.strip()]
        
        inst_info = get_instruction_func(func_name, args_str, ret_type)
        if not inst_info:
            out.append(decl + body_with_close)
            continue
            
        inst, suffix, special_format = inst_info
        
        is_scalar = (suffix == ".1d")
        if is_scalar:
            out.append(decl + body_with_close)
            continue
            
        rfmt = "%"
        suf = suffix
        
        if special_format:
            asm_stmt = special_format.format(inst=inst, suffix=suf, a=args[0] if len(args)>0 else '', b=args[1] if len(args)>1 else '', c=args[2] if len(args)>2 else '', ret_type=ret_type, r=rfmt)
        elif len(args) == 2:
            asm_stmt = f'return asm ("{inst} {rfmt}[res]{suf}, {rfmt}[a]{suf}, {rfmt}[b]{suf}" : [res] "=w" (-> {ret_type}) : [a] "w" ({args[0]}), [b] "w" ({args[1]}));'
        elif len(args) == 1:
            asm_stmt = f'return asm ("{inst} {rfmt}[res]{suf}, {rfmt}[a]{suf}" : [res] "=w" (-> {ret_type}) : [a] "w" ({args[0]}));'
        elif len(args) == 3:
            asm_stmt = f'return asm ("{inst} {rfmt}[res]{suf}, {rfmt}[b]{suf}, {rfmt}[c]{suf}" : [res] "=w" (-> {ret_type}) : [a_in] "0" ({args[0]}), [b] "w" ({args[1]}), [c] "w" ({args[2]}));'
        else:
            out.append(decl + body_with_close)
            continue
            
        # Strip old manual asm blocks
        import re
        body_with_close = re.sub(r'if \([^\)]*arch == \.aarch64\)\s*return asm \([^\)]*\);', '', body_with_close)
        
        new_body = f' if (!@inComptime() and comptime arch.is_aarch64) {{ {asm_stmt} }} ' + body_with_close
        if body_with_close.startswith('\n'):
            new_body = f'\n    if (!@inComptime() and comptime arch.is_aarch64) {{ {asm_stmt} }}' + body_with_close
            
        out.append(decl + new_body)
        modified = True

    if modified:
        with open(filename, 'w') as f:
            f.write("".join(out))
        print(f"Updated {filename}")

def get_suffix(func_name, ret_type, args_str):
    s = ".16b"
    if "8x8" in ret_type or ("8x8" in args_str and "16x8" not in ret_type): s = ".8b"
    if "16x4" in ret_type or ("16x4" in args_str and "32x4" not in ret_type): s = ".4h"
    if "16x8" in ret_type: s = ".8h"
    if "32x2" in ret_type or ("32x2" in args_str and "64x2" not in ret_type): s = ".2s"
    if "32x4" in ret_type: s = ".4s"
    if "64x1" in ret_type: s = ".1d"
    if "64x2" in ret_type: s = ".2d"
    return s

def map_arithmetic(func_name, args_str, ret_type):
    suffix = get_suffix(func_name, ret_type, args_str)
    is_signed = "_s" in func_name
    is_unsigned = "_u" in func_name
    is_float = "_f" in func_name
    inst = None
    special = None
    
    if func_name.startswith("vadd_") or func_name.startswith("vaddq_"):
        if is_float: inst = "fadd"
        elif "p8" in func_name or "p16" in func_name or "p64" in func_name: inst = "eor"
        else: inst = "add" 
    elif func_name.startswith("vsub_") or func_name.startswith("vsubq_"):
        inst = "fsub" if is_float else "sub"
    elif func_name.startswith("vmul_") or func_name.startswith("vmulq_"):
        if is_float: inst = "fmul"
        elif "p8" in func_name: inst = "pmul"
        else:
            if suffix == ".2d": inst = None
            else: inst = "mul"
    elif func_name.startswith("vneg_") or func_name.startswith("vnegq_"):
        inst = "fneg" if is_float else "neg"
    elif func_name.startswith("vabs_") or func_name.startswith("vabsq_"):
        inst = "fabs" if is_float else "abs"
        if not is_float:
            if suffix == ".2d": inst = None
            else: inst = "abs"
    elif func_name.startswith("vqadd"):
        inst = "sqadd" if is_signed else "uqadd"
    elif func_name.startswith("vqsub"):
        inst = "sqsub" if is_signed else "uqsub"
    elif func_name.startswith("vabd_") or func_name.startswith("vabdq_"):
        if is_float: inst = "fabd"
        elif is_signed:
            if suffix == ".2d": inst = None
            else: inst = "sabd"
        elif is_unsigned:
            if suffix == ".2d": inst = None
            else: inst = "uabd"
    elif func_name.startswith("vaba_") or func_name.startswith("vabaq_"):
        if is_signed:
            if suffix == ".2d": inst = None
            else: inst = "saba"
        elif is_unsigned:
            if suffix == ".2d": inst = None
            else: inst = "uaba"
        special = 'return asm ("{inst} {r}[res]{suffix}, {r}[b]{suffix}, {r}[c]{suffix}" : [res] "=w" (-> {ret_type}) : [a_in] "0" ({a}), [b] "w" ({b}), [c] "w" ({c}));'
    elif func_name.startswith("vabdl_"):
        inst = "sabdl" if is_signed else "uabdl"
        half_suffix = suffix.replace("8h", "8b").replace("4s", "4h").replace("2d", "2s")
        special = f'return asm ("{{inst}} {{r}}[res]{{suffix}}, {{r}}[a]{half_suffix}, {{r}}[b]{half_suffix}" : [res] "=w" (-> {{ret_type}}) : [a] "w" ({{a}}), [b] "w" ({{b}}));'
    elif func_name.startswith("vabal_"):
        inst = "sabal" if is_signed else "uabal"
        half_suffix = suffix.replace("8h", "8b").replace("4s", "4h").replace("2d", "2s")
        special = f'return asm ("{{inst}} {{r}}[res]{{suffix}}, {{r}}[b]{half_suffix}, {{r}}[c]{half_suffix}" : [res] "=w" (-> {{ret_type}}) : [a_in] "0" ({{a}}), [b] "w" ({{b}}), [c] "w" ({{c}}));'
    elif func_name.startswith("vaddl_"):
        inst = "saddl" if is_signed else "uaddl"
        half_suffix = suffix.replace('8h', '8b').replace('4s', '4h').replace('2d', '2s')
        special = f'return asm ("{{inst}} {{r}}[res]{{suffix}}, {{r}}[a]{half_suffix}, {{r}}[b]{half_suffix}" : [res] "=w" (-> {{ret_type}}) : [a] "w" ({{a}}), [b] "w" ({{b}}));'
    elif func_name.startswith("vaddw_"):
        inst = "saddw" if is_signed else "uaddw"
        half_suffix = suffix.replace('8h', '8b').replace('4s', '4h').replace('2d', '2s')
        special = f'return asm ("{{inst}} {{r}}[res]{{suffix}}, {{r}}[a]{{suffix}}, {{r}}[b]{half_suffix}" : [res] "=w" (-> {{ret_type}}) : [a] "w" ({{a}}), [b] "w" ({{b}}));'
    elif func_name.startswith("vaddhn_"):
        inst = "addhn"
        double_suffix = suffix.replace('8b', '8h').replace('4h', '4s').replace('2s', '2d')
        special = f'return asm ("{{inst}} {{r}}[res]{{suffix}}, {{r}}[a]{double_suffix}, {{r}}[b]{double_suffix}" : [res] "=w" (-> {{ret_type}}) : [a] "w" ({{a}}), [b] "w" ({{b}}));'
    elif func_name.startswith("vmull_"):
        if "p8" in func_name: inst = "pmull"
        else: inst = "smull" if is_signed else "umull"
        half_suffix = suffix.replace('8h', '8b').replace('4s', '4h').replace('2d', '2s')
        special = f'return asm ("{{inst}} {{r}}[res]{{suffix}}, {{r}}[a]{half_suffix}, {{r}}[b]{half_suffix}" : [res] "=w" (-> {{ret_type}}) : [a] "w" ({{a}}), [b] "w" ({{b}}));'
    elif func_name.startswith("vfma"):
        inst = "fmla"
    elif func_name.startswith("vfms"):
        inst = "fmls"
    elif func_name.startswith("vmla") and not "lane" in func_name:
        if suffix != ".2d": inst = "fmla" if "f" in func_name else "mla"
    elif func_name.startswith("vmls") and not "lane" in func_name:
        if suffix != ".2d": inst = "fmls" if "f" in func_name else "mls" 

    if inst == "eor":
        if suffix in [".8h", ".4s", ".2d"]: suffix = ".16b"
        if suffix in [".4h", ".2s", ".1d"]: suffix = ".8b"
    if inst: return (inst, suffix, special)
    return None

def map_bitwise(func_name, args_str, ret_type):
    suffix = get_suffix(func_name, ret_type, args_str)
    # AArch64 clz is element-wise, but bitwise are vector-wide.
    if func_name.startswith("vclz"): return ("clz", suffix, None)
    if func_name.startswith("vcnt"): return ("cnt", suffix, None)
    
    if suffix in [".8h", ".4s", ".2d"]: suffix = ".16b"
    if suffix in [".4h", ".2s", ".1d"]: suffix = ".8b"
    
    inst = None
    if func_name.startswith("vand"): inst = "and"
    elif func_name.startswith("vorr"): inst = "orr"
    elif func_name.startswith("veor"): inst = "eor"
    elif func_name.startswith("vbic"): inst = "bic"
    elif func_name.startswith("vmvn"): inst = "mvn"
    if inst: return (inst, suffix, None)
    return None

def map_compare(func_name, args_str, ret_type):
    suffix = get_suffix(func_name, ret_type, args_str)
    inst = None
    is_float = "_f" in func_name
    
    if func_name.startswith("vceq"): inst = "fcmeq" if is_float else "cmeq"
    elif func_name.startswith("vcge"): inst = "fcmge" if is_float else "cmge"
    elif func_name.startswith("vcle"): inst = "fcmle" if is_float else "cmle"
    elif func_name.startswith("vcgt"): inst = "fcmgt" if is_float else "cmgt"
    elif func_name.startswith("vclt"): inst = "fcmlt" if is_float else "cmlt"
    elif func_name.startswith("vtst"): inst = "cmtst"
    
    if inst:
        special = None
        if inst in ("cmle", "fcmle"):
            actual_inst = "fcmge" if is_float else "cmge"
            special = 'return asm ("{actual_inst} {r}[res]{suffix}, {r}[b]{suffix}, {r}[a]{suffix}" : [res] "=w" (-> {ret_type}) : [a] "w" ({a}), [b] "w" ({b}));'.replace("{actual_inst}", actual_inst)
        elif inst in ("cmlt", "fcmlt"):
            actual_inst = "fcmgt" if is_float else "cmgt"
            special = 'return asm ("{actual_inst} {r}[res]{suffix}, {r}[b]{suffix}, {r}[a]{suffix}" : [res] "=w" (-> {ret_type}) : [a] "w" ({a}), [b] "w" ({b}));'.replace("{actual_inst}", actual_inst)
        return (inst, suffix, special)
    return None

def map_shift(func_name, args_str, ret_type):
    suffix = get_suffix(func_name, ret_type, args_str)
    is_signed = "_s" in func_name
    inst = None
    special = None
    
    if func_name.startswith("vshr_n"):
        inst = "sshr" if is_signed else "ushr"
        special = 'if (comptime n == 0) return {a}; return asm ("{inst} {r}[res]{suffix}, {r}[a]{suffix}, #%[b]" : [res] "=w" (-> {ret_type}) : [a] "w" ({a}), [b] "i" (comptime n));'
    elif func_name.startswith("vshl_n") or func_name.startswith("vshlq_n"):
        inst = "shl"
        special = 'if (comptime n == 0) return {a}; return asm ("{inst} {r}[res]{suffix}, {r}[a]{suffix}, #%[b]" : [res] "=w" (-> {ret_type}) : [a] "w" ({a}), [b] "i" (comptime n));'
    elif func_name.startswith("vshl_") or func_name.startswith("vshlq_"):
        inst = "sshl" if is_signed else "ushl"
    elif func_name.startswith("vsra_n") or func_name.startswith("vsraq_n"):
        inst = "ssra" if is_signed else "usra"
        special = 'if (comptime n == 0) return {a} +% {b}; return asm ("{inst} {r}[res]{suffix}, {r}[b]{suffix}, #%[c]" : [res] "=w" (-> {ret_type}) : [a_in] "0" ({a}), [b] "w" ({b}), [c] "i" (comptime n));'

    if inst == "eor":
        if suffix in [".8h", ".4s", ".2d"]: suffix = ".16b"
        if suffix in [".4h", ".2s", ".1d"]: suffix = ".8b"
    if inst: return (inst, suffix, special)
    return None

if __name__ == "__main__":
    process_file("src/intrinsics/arithmetic.zig", map_arithmetic)
    process_file("src/intrinsics/bitwise.zig", map_bitwise)
    process_file("src/intrinsics/compare.zig", map_compare)
    process_file("src/intrinsics/shift.zig", map_shift)
