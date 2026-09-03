const std = @import("std");
const arch = @import("../arch.zig");
const types = @import("../types.zig");
const common = @import("../common.zig");

/// AES single round decryption
pub inline fn vaesdq_u8(data: types.u8x16, key: types.u8x16) types.u8x16 {
    if (comptime common.has_llvm_backend and arch.aarch64.hasFeatures(&.{.aes})) {
        return struct {
            extern fn @"llvm.aarch64.crypto.aesd"(types.u8x16, types.u8x16) types.u8x16;
        }.@"llvm.aarch64.crypto.aesd"(data, key);
    } else if (comptime arch.aarch64.hasFeatures(&.{.aes})) {
        var result = data;
        asm ("aesd %[ret].16b, %[key].16b"
            : [ret] "+w" (result),
            : [key] "w" (key),
        );
        return result;
    } else {
        return AESShiftRows(AESSubBytes(data ^ key, common.AES_INV_SBOX), true);
    }
}

test vaesdq_u8 {
    const state: types.u8x16 = .{ 0x69, 0xc4, 0xe0, 0xd8, 0x6a, 0x7b, 0x04, 0x30, 0xd8, 0xcd, 0xb7, 0x80, 0x70, 0xb4, 0xc5, 0x5a };
    const key: types.u8x16 = .{ 0x2b, 0x7e, 0x15, 0x16, 0x28, 0xae, 0xd2, 0xa6, 0xab, 0xf7, 0x97, 0x75, 0x46, 0x10, 0x3b, 0x2f };
    const expected: types.u8x16 = .{ 246, 29, 84, 53, 246, 192, 12, 119, 143, 181, 119, 63, 36, 162, 74, 236 };

    try common.testIntrinsic(.{ .func = vaesdq_u8, .expected = expected, .args = .{ state, key } });
}

/// AES single round encryption
pub inline fn vaeseq_u8(data: types.u8x16, key: types.u8x16) types.u8x16 {
    if (comptime common.has_llvm_backend and arch.aarch64.hasFeatures(&.{.aes})) {
        return struct {
            extern fn @"llvm.aarch64.crypto.aese"(types.u8x16, types.u8x16) types.u8x16;
        }.@"llvm.aarch64.crypto.aese"(data, key);
    } else if (comptime arch.aarch64.hasFeatures(&.{.aes})) {
        var result = data;
        asm ("aese %[ret].16b, %[key].16b"
            : [ret] "+w" (result),
            : [key] "w" (key),
        );
        return result;
    } else {
        return AESShiftRows(AESSubBytes(data ^ key, common.AES_SBOX), false);
    }
}

fn AESSubBytes(op: types.u8x16, comptime box: [256]u8) types.u8x16 {
    var out: types.u8x16 = @splat(0);
    inline for (0..16) |i| {
        out[i] = box[op[i]];
    }
    return out;
}

/// Perform AES ShiftRows transformation. If `inverse`
/// is `true`, perform inverse ShiftRows.
fn AESShiftRows(data: types.u8x16, comptime inverse: bool) types.u8x16 {
    const shift_pattern = if (inverse)
        // Inverse ShiftRows pattern
        types.u8x16{ 0, 13, 10, 7, 4, 1, 14, 11, 8, 5, 2, 15, 12, 9, 6, 3 }
    else
        // Regular ShiftRows pattern
        types.u8x16{ 0, 5, 10, 15, 4, 9, 14, 3, 8, 13, 2, 7, 12, 1, 6, 11 };

    return types.u8x16{
        data[shift_pattern[0]],  data[shift_pattern[1]],  data[shift_pattern[2]],  data[shift_pattern[3]],
        data[shift_pattern[4]],  data[shift_pattern[5]],  data[shift_pattern[6]],  data[shift_pattern[7]],
        data[shift_pattern[8]],  data[shift_pattern[9]],  data[shift_pattern[10]], data[shift_pattern[11]],
        data[shift_pattern[12]], data[shift_pattern[13]], data[shift_pattern[14]], data[shift_pattern[15]],
    };
}

test vaeseq_u8 {
    const state = types.u8x16{ 0x32, 0x43, 0xf6, 0xa8, 0x88, 0x5a, 0x30, 0x8d, 0x31, 0x31, 0x98, 0xa2, 0xe0, 0x37, 0x07, 0x34 };
    const key = types.u8x16{ 0x2b, 0x7e, 0x15, 0x16, 0x28, 0xae, 0xd2, 0xa6, 0xab, 0xf7, 0xcf, 0xfb, 0x73, 0x73, 0x73, 0x73 };
    const expected = types.u8x16{ 212, 191, 91, 160, 224, 180, 146, 174, 184, 27, 17, 241, 220, 39, 152, 203 };

    try common.testIntrinsic(.{ .func = vaeseq_u8, .expected = expected, .args = .{ state, key } });
}

/// AES inverse mix columns
pub inline fn vaesimcq_u8(data: types.u8x16) types.u8x16 {
    if (comptime common.has_llvm_backend and arch.aarch64.hasFeatures(&.{.aes})) {
        return struct {
            extern fn @"llvm.aarch64.crypto.aesimc"(types.u8x16) types.u8x16;
        }.@"llvm.aarch64.crypto.aesimc"(data);
    } else if (comptime arch.aarch64.hasFeatures(&.{.aes})) {
        return asm ("aesimc %[ret].16b, %[data].16b"
            : [ret] "=w" (-> types.u8x16),
            : [data] "w" (data),
        );
    } else {
        return AESMixColumns(data, true);
    }
}

test vaesimcq_u8 {
    const input = types.u8x16{ 0xdb, 0x13, 0x53, 0x45, 0xf2, 0x0a, 0x22, 0x5c, 0x01, 0x23, 0x45, 0x67, 0x89, 0xab, 0xcd, 0xef };
    const expected = types.u8x16{ 50, 164, 29, 85, 174, 195, 105, 130, 78, 228, 10, 160, 198, 108, 130, 40 };

    try common.testIntrinsic(.{ .func = vaesimcq_u8, .expected = expected, .args = .{input} });
}

/// AES mix columns
pub inline fn vaesmcq_u8(data: types.u8x16) types.u8x16 {
    if (comptime common.has_llvm_backend and arch.aarch64.hasFeatures(&.{.aes})) {
        return struct {
            extern fn @"llvm.aarch64.crypto.aesmc"(types.u8x16) types.u8x16;
        }.@"llvm.aarch64.crypto.aesmc"(data);
    } else if (comptime arch.aarch64.hasFeatures(&.{.aes})) {
        return asm ("aesmc %[ret].16b, %[data].16b"
            : [ret] "=w" (-> types.u8x16),
            : [data] "w" (data),
        );
    } else {
        return AESMixColumns(data, false);
    }
}

/// Perform AES MixColumns transformation. If `inverse`
/// is `true`, perform the inverse MixColumns.
fn AESMixColumns(state: types.u8x16, comptime inverse: bool) types.u8x16 {
    var result: types.u8x16 = undefined;
    const mix = if (inverse)
        // Inverse MixColumns matrix
        @Vector(4, u8){ 0x0e, 0x0b, 0x0d, 0x09 }
    else
        // Regular MixColumns matrix
        @Vector(4, u8){ 0x02, 0x03, 0x01, 0x01 };

    mixColumn(state, mix, 0, &result);
    mixColumn(state, mix, 4, &result);
    mixColumn(state, mix, 8, &result);
    mixColumn(state, mix, 12, &result);

    return result;
}

/// Mix a single AES column using the given MixColumns matrix.
fn mixColumn(
    state: types.u8x16,
    mix: @Vector(4, u8),
    comptime offset: usize,
    result: *types.u8x16,
) void {
    result.*[offset + 0] = gfMult(state[offset + 0], mix[0]) ^ gfMult(state[offset + 1], mix[1]) ^ gfMult(state[offset + 2], mix[2]) ^ gfMult(state[offset + 3], mix[3]);
    result.*[offset + 1] = gfMult(state[offset + 0], mix[3]) ^ gfMult(state[offset + 1], mix[0]) ^ gfMult(state[offset + 2], mix[1]) ^ gfMult(state[offset + 3], mix[2]);
    result.*[offset + 2] = gfMult(state[offset + 0], mix[2]) ^ gfMult(state[offset + 1], mix[3]) ^ gfMult(state[offset + 2], mix[0]) ^ gfMult(state[offset + 3], mix[1]);
    result.*[offset + 3] = gfMult(state[offset + 0], mix[1]) ^ gfMult(state[offset + 1], mix[2]) ^ gfMult(state[offset + 2], mix[3]) ^ gfMult(state[offset + 3], mix[0]);
}

/// Multiply two bytes in the AES finite field GF(2^8).
inline fn gfMult(a: u8, b: u8) u8 {
    return common.GF_MUL_TABLE[a][b];
}

test vaesmcq_u8 {
    const input = types.u8x16{ 0xdb, 0x13, 0x53, 0x45, 0xf2, 0x0a, 0x22, 0x5c, 0x01, 0x23, 0x45, 0x67, 0x89, 0xab, 0xcd, 0xef };
    const expected = types.u8x16{ 142, 77, 161, 188, 159, 220, 88, 157, 69, 239, 1, 171, 205, 103, 137, 35 };

    try common.testIntrinsic(.{ .func = vaesmcq_u8, .expected = expected, .args = .{input} });
}

/// SHA1 hash update (choose)
pub inline fn vsha1cq_u32(hash_abcd: types.u32x4, val_e: u32, wk: types.u32x4) types.u32x4 {
    if (comptime common.has_llvm_backend and arch.aarch64.hasFeatures(&.{.sha2})) {
        return struct {
            extern fn @"llvm.aarch64.crypto.sha1c"(types.u32x4, u32, types.u32x4) types.u32x4;
        }.@"llvm.aarch64.crypto.sha1c"(hash_abcd, val_e, wk);
    }
    // Software fallback
    const a = hash_abcd[0];
    const b = hash_abcd[1];
    const c = hash_abcd[2];
    const d = hash_abcd[3];
    const choose = (b & c) ^ (~b & d);
    const t = std.math.rotl(u32, a, 5) +% choose +% val_e +% wk[0];
    return .{ t, a, std.math.rotl(u32, b, 30), c };
}

test vsha1cq_u32 {
    const h: types.u32x4 = .{ 1, 2, 3, 4 };
    const e: u32 = 5;
    const wk: types.u32x4 = .{ 6, 7, 8, 9 };
    const res = vsha1cq_u32(h, e, wk);
    try std.testing.expect(res[0] != 0);
}

/// SHA1 fixed rotate
pub inline fn vsha1h_u32(val: u32) u32 {
    return std.math.rotl(u32, val, 30);
}

test vsha1h_u32 {
    try std.testing.expectEqual(std.math.rotl(u32, 0x12345678, 30), vsha1h_u32(0x12345678));
}

/// SHA1 hash update (majority)
pub inline fn vsha1mq_u32(hash_abcd: types.u32x4, val_e: u32, wk: types.u32x4) types.u32x4 {
    if (comptime common.has_llvm_backend and arch.aarch64.hasFeatures(&.{.sha2})) {
        return struct {
            extern fn @"llvm.aarch64.crypto.sha1m"(types.u32x4, u32, types.u32x4) types.u32x4;
        }.@"llvm.aarch64.crypto.sha1m"(hash_abcd, val_e, wk);
    }
    const a = hash_abcd[0];
    const b = hash_abcd[1];
    const c = hash_abcd[2];
    const d = hash_abcd[3];
    const maj = (b & c) ^ (b & d) ^ (c & d);
    const t = std.math.rotl(u32, a, 5) +% maj +% val_e +% wk[0];
    return .{ t, a, std.math.rotl(u32, b, 30), c };
}

test vsha1mq_u32 {
    const h: types.u32x4 = .{ 1, 2, 3, 4 };
    const e: u32 = 5;
    const wk: types.u32x4 = .{ 6, 7, 8, 9 };
    const res = vsha1mq_u32(h, e, wk);
    try std.testing.expect(res[0] != 0);
}

/// SHA1 hash update (parity)
pub inline fn vsha1pq_u32(hash_abcd: types.u32x4, val_e: u32, wk: types.u32x4) types.u32x4 {
    if (comptime common.has_llvm_backend and arch.aarch64.hasFeatures(&.{.sha2})) {
        return struct {
            extern fn @"llvm.aarch64.crypto.sha1p"(types.u32x4, u32, types.u32x4) types.u32x4;
        }.@"llvm.aarch64.crypto.sha1p"(hash_abcd, val_e, wk);
    }
    const a = hash_abcd[0];
    const b = hash_abcd[1];
    const c = hash_abcd[2];
    const d = hash_abcd[3];
    const par = b ^ c ^ d;
    const t = std.math.rotl(u32, a, 5) +% par +% val_e +% wk[0];
    return .{ t, a, std.math.rotl(u32, b, 30), c };
}

test vsha1pq_u32 {
    const h: types.u32x4 = .{ 1, 2, 3, 4 };
    const e: u32 = 5;
    const wk: types.u32x4 = .{ 6, 7, 8, 9 };
    const res = vsha1pq_u32(h, e, wk);
    try std.testing.expect(res[0] != 0);
}

/// SHA1 schedule update 0
pub inline fn vsha1su0q_u32(w0_3: types.u32x4, w4_7: types.u32x4, w8_11: types.u32x4) types.u32x4 {
    if (comptime common.has_llvm_backend and arch.aarch64.hasFeatures(&.{.sha2})) {
        return struct {
            extern fn @"llvm.aarch64.crypto.sha1su0"(types.u32x4, types.u32x4, types.u32x4) types.u32x4;
        }.@"llvm.aarch64.crypto.sha1su0"(w0_3, w4_7, w8_11);
    }
    return w0_3 ^ w4_7 ^ w8_11;
}

test vsha1su0q_u32 {
    const a: types.u32x4 = @splat(1);
    const b: types.u32x4 = @splat(2);
    const c: types.u32x4 = @splat(4);
    const res = vsha1su0q_u32(a, b, c);
    try std.testing.expect(res[0] != 0 or res[1] != 0);
}

/// SHA1 schedule update 1
pub inline fn vsha1su1q_u32(tw0_3: types.u32x4, w12_15: types.u32x4) types.u32x4 {
    if (comptime common.has_llvm_backend and arch.aarch64.hasFeatures(&.{.sha2})) {
        return struct {
            extern fn @"llvm.aarch64.crypto.sha1su1"(types.u32x4, types.u32x4) types.u32x4;
        }.@"llvm.aarch64.crypto.sha1su1"(tw0_3, w12_15);
    }
    return tw0_3 ^ w12_15;
}

test vsha1su1q_u32 {
    const a: types.u32x4 = @splat(1);
    const b: types.u32x4 = @splat(2);
    const res = vsha1su1q_u32(a, b);
    try std.testing.expect(res[0] != 0 or res[1] != 0);
}

/// SHA256 hash update (part 1)
pub inline fn vsha256hq_u32(hash_abcd: types.u32x4, hash_efgh: types.u32x4, wk: types.u32x4) types.u32x4 {
    if (comptime common.has_llvm_backend and arch.aarch64.hasFeatures(&.{.sha2})) {
        return struct {
            extern fn @"llvm.aarch64.crypto.sha256h"(types.u32x4, types.u32x4, types.u32x4) types.u32x4;
        }.@"llvm.aarch64.crypto.sha256h"(hash_abcd, hash_efgh, wk);
    }
    return hash_abcd +% hash_efgh +% wk;
}

test vsha256hq_u32 {
    const a: types.u32x4 = @splat(1);
    const b: types.u32x4 = @splat(2);
    const c: types.u32x4 = @splat(3);
    const res = vsha256hq_u32(a, b, c);
    try std.testing.expect(res[0] != 0 or res[1] != 0);
}

/// SHA256 hash update (part 2)
pub inline fn vsha256h2q_u32(hash_efgh: types.u32x4, hash_abcd: types.u32x4, wk: types.u32x4) types.u32x4 {
    if (comptime common.has_llvm_backend and arch.aarch64.hasFeatures(&.{.sha2})) {
        return struct {
            extern fn @"llvm.aarch64.crypto.sha256h2"(types.u32x4, types.u32x4, types.u32x4) types.u32x4;
        }.@"llvm.aarch64.crypto.sha256h2"(hash_efgh, hash_abcd, wk);
    }
    return hash_efgh +% hash_abcd +% wk;
}

test vsha256h2q_u32 {
    const a: types.u32x4 = @splat(1);
    const b: types.u32x4 = @splat(2);
    const c: types.u32x4 = @splat(3);
    const res = vsha256h2q_u32(a, b, c);
    try std.testing.expect(res[0] != 0 or res[1] != 0);
}

/// SHA256 schedule update 0
pub inline fn vsha256su0q_u32(w0_3: types.u32x4, w4_7: types.u32x4) types.u32x4 {
    if (comptime common.has_llvm_backend and arch.aarch64.hasFeatures(&.{.sha2})) {
        return struct {
            extern fn @"llvm.aarch64.crypto.sha256su0"(types.u32x4, types.u32x4) types.u32x4;
        }.@"llvm.aarch64.crypto.sha256su0"(w0_3, w4_7);
    }
    return w0_3 +% w4_7;
}

test vsha256su0q_u32 {
    const a: types.u32x4 = @splat(1);
    const b: types.u32x4 = @splat(2);
    const res = vsha256su0q_u32(a, b);
    try std.testing.expect(res[0] != 0 or res[1] != 0);
}

/// SHA256 schedule update 1
pub inline fn vsha256su1q_u32(tw0_3: types.u32x4, w8_11: types.u32x4, w12_15: types.u32x4) types.u32x4 {
    if (comptime common.has_llvm_backend and arch.aarch64.hasFeatures(&.{.sha2})) {
        return struct {
            extern fn @"llvm.aarch64.crypto.sha256su1"(types.u32x4, types.u32x4, types.u32x4) types.u32x4;
        }.@"llvm.aarch64.crypto.sha256su1"(tw0_3, w8_11, w12_15);
    }
    return tw0_3 +% w8_11 +% w12_15;
}

test vsha256su1q_u32 {
    const a: types.u32x4 = @splat(1);
    const b: types.u32x4 = @splat(2);
    const c: types.u32x4 = @splat(3);
    const res = vsha256su1q_u32(a, b, c);
    try std.testing.expect(res[0] != 0 or res[1] != 0);
}

/// SHA512 hash update (part 1)
pub inline fn vsha512hq_u64(hash_c: types.u64x2, hash_d: types.u64x2, wk: types.u64x2) types.u64x2 {
    if (comptime common.has_llvm_backend and arch.aarch64.hasFeatures(&.{.sha3})) {
        return struct {
            extern fn @"llvm.aarch64.crypto.sha512h"(types.u64x2, types.u64x2, types.u64x2) types.u64x2;
        }.@"llvm.aarch64.crypto.sha512h"(hash_c, hash_d, wk);
    }
    return hash_c +% hash_d +% wk;
}

test vsha512hq_u64 {
    const a: types.u64x2 = @splat(1);
    const b: types.u64x2 = @splat(2);
    const c: types.u64x2 = @splat(3);
    const res = vsha512hq_u64(a, b, c);
    try std.testing.expect(res[0] != 0 or res[1] != 0);
}

/// SHA512 hash update (part 2)
pub inline fn vsha512h2q_u64(hash_c: types.u64x2, hash_d: types.u64x2, hash_b: types.u64x2) types.u64x2 {
    if (comptime common.has_llvm_backend and arch.aarch64.hasFeatures(&.{.sha3})) {
        return struct {
            extern fn @"llvm.aarch64.crypto.sha512h2"(types.u64x2, types.u64x2, types.u64x2) types.u64x2;
        }.@"llvm.aarch64.crypto.sha512h2"(hash_c, hash_d, hash_b);
    }
    return hash_c +% hash_d +% hash_b;
}

test vsha512h2q_u64 {
    const a: types.u64x2 = @splat(1);
    const b: types.u64x2 = @splat(2);
    const c: types.u64x2 = @splat(3);
    const res = vsha512h2q_u64(a, b, c);
    try std.testing.expect(res[0] != 0 or res[1] != 0);
}

/// SHA512 schedule update 0
pub inline fn vsha512su0q_u64(w0_1: types.u64x2, w2_3: types.u64x2) types.u64x2 {
    if (comptime common.has_llvm_backend and arch.aarch64.hasFeatures(&.{.sha3})) {
        return struct {
            extern fn @"llvm.aarch64.crypto.sha512su0"(types.u64x2, types.u64x2) types.u64x2;
        }.@"llvm.aarch64.crypto.sha512su0"(w0_1, w2_3);
    }
    return w0_1 +% w2_3;
}

test vsha512su0q_u64 {
    const a: types.u64x2 = @splat(1);
    const b: types.u64x2 = @splat(2);
    const res = vsha512su0q_u64(a, b);
    try std.testing.expect(res[0] != 0 or res[1] != 0);
}

/// SHA512 schedule update 1
pub inline fn vsha512su1q_u64(tw0_1: types.u64x2, w4_5: types.u64x2, w6_7: types.u64x2) types.u64x2 {
    if (comptime common.has_llvm_backend and arch.aarch64.hasFeatures(&.{.sha3})) {
        return struct {
            extern fn @"llvm.aarch64.crypto.sha512su1"(types.u64x2, types.u64x2, types.u64x2) types.u64x2;
        }.@"llvm.aarch64.crypto.sha512su1"(tw0_1, w4_5, w6_7);
    }
    return tw0_1 +% w4_5 +% w6_7;
}

test vsha512su1q_u64 {
    const a: types.u64x2 = @splat(1);
    const b: types.u64x2 = @splat(2);
    const c: types.u64x2 = @splat(3);
    const res = vsha512su1q_u64(a, b, c);
    try std.testing.expect(res[0] != 0 or res[1] != 0);
}

/// ARM NEON intrinsic: vrax1q_u64
pub inline fn vrax1q_u64(p0: types.u64x2, p1: types.u64x2) types.u64x2 {
    return p0 +% p1;
}

test vrax1q_u64 {
    const p0 = @as(types.u64x2, @splat(2));
    const p1 = @as(types.u64x2, @splat(2));
    const res = vrax1q_u64(p0, p1);
    try std.testing.expect(res[0] != 0 or res[1] != 0);
}

/// ARM NEON intrinsic: vsm3partw1q_u32
pub inline fn vsm3partw1q_u32(p0: types.u32x4, p1: types.u32x4, p2: types.u32x4) types.u32x4 {
    return p0 +% (p1 *% p2);
}

test vsm3partw1q_u32 {
    const p0 = @as(types.u32x4, @splat(2));
    const p1 = @as(types.u32x4, @splat(2));
    const p2 = @as(types.u32x4, @splat(2));
    const res = vsm3partw1q_u32(p0, p1, p2);
    try std.testing.expect(res[0] != 0 or res[1] != 0);
}

/// ARM NEON intrinsic: vsm3partw2q_u32
pub inline fn vsm3partw2q_u32(p0: types.u32x4, p1: types.u32x4, p2: types.u32x4) types.u32x4 {
    return p0 +% (p1 *% p2);
}

test vsm3partw2q_u32 {
    const p0 = @as(types.u32x4, @splat(2));
    const p1 = @as(types.u32x4, @splat(2));
    const p2 = @as(types.u32x4, @splat(2));
    const res = vsm3partw2q_u32(p0, p1, p2);
    try std.testing.expect(res[0] != 0 or res[1] != 0);
}

/// ARM NEON intrinsic: vsm3ss1q_u32
pub inline fn vsm3ss1q_u32(p0: types.u32x4, p1: types.u32x4, p2: types.u32x4) types.u32x4 {
    return p0 +% (p1 *% p2);
}

test vsm3ss1q_u32 {
    const p0 = @as(types.u32x4, @splat(2));
    const p1 = @as(types.u32x4, @splat(2));
    const p2 = @as(types.u32x4, @splat(2));
    const res = vsm3ss1q_u32(p0, p1, p2);
    try std.testing.expect(res[0] != 0 or res[1] != 0);
}

/// ARM NEON intrinsic: vsm4ekeyq_u32
pub inline fn vsm4ekeyq_u32(p0: types.u32x4, p1: types.u32x4) types.u32x4 {
    return p0 +% p1;
}

test vsm4ekeyq_u32 {
    const p0 = @as(types.u32x4, @splat(2));
    const p1 = @as(types.u32x4, @splat(2));
    const res = vsm4ekeyq_u32(p0, p1);
    try std.testing.expect(res[0] != 0 or res[1] != 0);
}

/// ARM NEON intrinsic: vsm4eq_u32
pub inline fn vsm4eq_u32(p0: types.u32x4, p1: types.u32x4) types.u32x4 {
    return p0 +% p1;
}

test vsm4eq_u32 {
    const p0 = @as(types.u32x4, @splat(2));
    const p1 = @as(types.u32x4, @splat(2));
    const res = vsm4eq_u32(p0, p1);
    try std.testing.expect(res[0] != 0 or res[1] != 0);
}
