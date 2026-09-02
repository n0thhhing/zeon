const arch = @import("../arch.zig");
const std = @import("std");
const types = @import("../types.zig");
const common = @import("../common.zig");

const u8x16 = types.u8x16;
const p8x8 = types.p8x8;
const p8x16 = types.p8x16;
const p16x8 = types.p16x8;
const p64 = types.p64;
const p128 = types.p128;

const aarch64 = common.aarch64;
const AES_SBOX = common.AES_SBOX;
const AES_INV_SBOX = common.AES_INV_SBOX;
const GF_MUL_TABLE = common.GF_MUL_TABLE;

inline fn AESSubBytes(op: u8x16, comptime box: [256]u8) u8x16 {
    var out: u8x16 = @splat(0);
    inline for (0..16) |i| {
        out[i] = box[op[i]];
    }
    return out;
}

inline fn AESShiftRows(data: u8x16, comptime inverse: bool) u8x16 {
    const shift_pattern = if (inverse)
        u8x16{ 0, 13, 10, 7, 4, 1, 14, 11, 8, 5, 2, 15, 12, 9, 6, 3 }
    else
        u8x16{ 0, 5, 10, 15, 4, 9, 14, 3, 8, 13, 2, 7, 12, 1, 6, 11 };

    return u8x16{
        data[shift_pattern[0]],  data[shift_pattern[1]],  data[shift_pattern[2]],  data[shift_pattern[3]],
        data[shift_pattern[4]],  data[shift_pattern[5]],  data[shift_pattern[6]],  data[shift_pattern[7]],
        data[shift_pattern[8]],  data[shift_pattern[9]],  data[shift_pattern[10]], data[shift_pattern[11]],
        data[shift_pattern[12]], data[shift_pattern[13]], data[shift_pattern[14]], data[shift_pattern[15]],
    };
}

/// AES Single Round Encryption (AESE)
pub inline fn vaeseq_u8(data: u8x16, key: u8x16) u8x16 {
    if (comptime common.has_llvm_backend and aarch64.hasFeatures(&.{.aes})) {
        return struct {
            extern fn @"llvm.aarch64.crypto.aese"(u8x16, u8x16) u8x16;
        }.@"llvm.aarch64.crypto.aese"(data, key);
    } else if (comptime aarch64.hasFeatures(&.{.aes})) {
        var result = data;
        asm ("aese %[ret].16b, %[key].16b"
            : [ret] "+w" (result),
            : [key] "w" (key),
        );
        return result;
    } else {
        return AESShiftRows(AESSubBytes(data ^ key, AES_SBOX), false);
    }
}

/// AES Single Round Decryption (AESD)
pub inline fn vaesdq_u8(data: u8x16, key: u8x16) u8x16 {
    if (comptime common.has_llvm_backend and aarch64.hasFeatures(&.{.aes})) {
        return struct {
            extern fn @"llvm.aarch64.crypto.aesd"(u8x16, u8x16) u8x16;
        }.@"llvm.aarch64.crypto.aesd"(data, key);
    } else if (comptime aarch64.hasFeatures(&.{.aes})) {
        var result = data;
        asm ("aesd %[ret].16b, %[key].16b"
            : [ret] "+w" (result),
            : [key] "w" (key),
        );
        return result;
    } else {
        return AESShiftRows(AESSubBytes(data ^ key, AES_INV_SBOX), true);
    }
}

/// AES MixColumns (AESMC)
pub inline fn vaesmcq_u8(data: u8x16) u8x16 {
    if (comptime common.has_llvm_backend and aarch64.hasFeatures(&.{.aes})) {
        return struct {
            extern fn @"llvm.aarch64.crypto.aesmc"(u8x16) u8x16;
        }.@"llvm.aarch64.crypto.aesmc"(data);
    } else if (comptime aarch64.hasFeatures(&.{.aes})) {
        var result = data;
        asm ("aesmc %[ret].16b, %[data].16b"
            : [ret] "=w" (result),
            : [data] "w" (data),
        );
        return result;
    } else {
        var out: u8x16 = undefined;
        inline for (0..4) |col| {
            const s0 = data[col * 4 + 0];
            const s1 = data[col * 4 + 1];
            const s2 = data[col * 4 + 2];
            const s3 = data[col * 4 + 3];

            out[col * 4 + 0] = GF_MUL_TABLE[2][s0] ^ GF_MUL_TABLE[3][s1] ^ s2 ^ s3;
            out[col * 4 + 1] = s0 ^ GF_MUL_TABLE[2][s1] ^ GF_MUL_TABLE[3][s2] ^ s3;
            out[col * 4 + 2] = s0 ^ s1 ^ GF_MUL_TABLE[2][s2] ^ GF_MUL_TABLE[3][s3];
            out[col * 4 + 3] = GF_MUL_TABLE[3][s0] ^ s1 ^ s2 ^ GF_MUL_TABLE[2][s3];
        }
        return out;
    }
}

/// AES Inverse MixColumns (AESIMC)
pub inline fn vaesimcq_u8(data: u8x16) u8x16 {
    if (comptime common.has_llvm_backend and aarch64.hasFeatures(&.{.aes})) {
        return struct {
            extern fn @"llvm.aarch64.crypto.aesimc"(u8x16) u8x16;
        }.@"llvm.aarch64.crypto.aesimc"(data);
    } else if (comptime aarch64.hasFeatures(&.{.aes})) {
        var result = data;
        asm ("aesimc %[ret].16b, %[data].16b"
            : [ret] "=w" (result),
            : [data] "w" (data),
        );
        return result;
    } else {
        var out: u8x16 = undefined;
        inline for (0..4) |col| {
            const s0 = data[col * 4 + 0];
            const s1 = data[col * 4 + 1];
            const s2 = data[col * 4 + 2];
            const s3 = data[col * 4 + 3];

            out[col * 4 + 0] = GF_MUL_TABLE[14][s0] ^ GF_MUL_TABLE[11][s1] ^ GF_MUL_TABLE[13][s2] ^ GF_MUL_TABLE[9][s3];
            out[col * 4 + 1] = GF_MUL_TABLE[9][s0] ^ GF_MUL_TABLE[14][s1] ^ GF_MUL_TABLE[11][s2] ^ GF_MUL_TABLE[13][s3];
            out[col * 4 + 2] = GF_MUL_TABLE[13][s0] ^ GF_MUL_TABLE[9][s1] ^ GF_MUL_TABLE[14][s2] ^ GF_MUL_TABLE[11][s3];
            out[col * 4 + 3] = GF_MUL_TABLE[11][s0] ^ GF_MUL_TABLE[13][s1] ^ GF_MUL_TABLE[9][s2] ^ GF_MUL_TABLE[14][s3];
        }
        return out;
    }
}

/// Carryless Polynomial Multiplication (VMULL_P8)
pub inline fn vmull_p8(a: p8x8, b: p8x8) p16x8 {
    if (!@inComptime() and comptime @import("builtin").cpu.arch == .aarch64)
        return asm ("pmull %[res].8h, %[a].8b, %[b].8b" : [res] "=w" (-> p16x8) : [a] "w" (a), [b] "w" (b));
    // Portable: carryless multiply per element
    var res: p16x8 = undefined;
    inline for (0..8) |i| {
        var prod: u16 = 0;
        const a_val: u16 = a[i];
        const b_val = b[i];
        inline for (0..8) |j| {
            if ((b_val & (@as(u8, 1) << j)) != 0) prod ^= (a_val << j);
        }
        res[i] = prod;
    }
    return res;
}

/// Carryless Polynomial Multiplication (VMULL_P64)
pub inline fn vmull_p64(a: p64, b: p64) p128 {
    if (!@inComptime() and comptime @import("builtin").cpu.arch == .aarch64) {
        const va: @Vector(1, p64) = .{a};
        const vb: @Vector(1, p64) = .{b};
        const vres = asm ("pmull %[res].1q, %[a].1d, %[b].1d" : [res] "=w" (-> @Vector(1, p128)) : [a] "w" (va), [b] "w" (vb));
        return vres[0];
    }
    // Portable: carryless multiply
    var prod: u128 = 0;
    const a_val: u128 = a;
    for (0..64) |j| {
        if ((b & (@as(u64, 1) << @intCast(j))) != 0) prod ^= (a_val << @intCast(j));
    }
    return prod;
}

test "crypto intrinsics" {
    const data: u8x16 = @splat(0);
    const key: u8x16 = @splat(0);
    const encrypted = vaeseq_u8(data, key);
    try std.testing.expectEqual(@as(u8, 0x63), encrypted[0]);

    const mixed = vaesmcq_u8(encrypted);
    const unmixed = vaesimcq_u8(mixed);
    try std.testing.expectEqual(encrypted, unmixed);

    const pa: p8x8 = @splat(3);
    const pb: p8x8 = @splat(5);
    const pmul = vmull_p8(pa, pb);
    // 3 = 0b0011, 5 = 0b0101 => (x+1)*(x^2+1) = x^3 + x^2 + x + 1 = 0b1111 = 15
    try std.testing.expectEqual(@as(u16, 15), pmul[0]);
}
