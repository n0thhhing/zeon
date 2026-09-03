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

    try common.testIntrinsic("vaesdq_u8", vaesdq_u8, expected, .{ state, key }, null);
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

    try common.testIntrinsic("vaeseq_u8", vaeseq_u8, expected, .{ state, key }, null);
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

    try common.testIntrinsic("vaesimcq_u8", vaesimcq_u8, expected, .{input}, null);
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

    try common.testIntrinsic("vaesmcq_u8", vaesmcq_u8, expected, .{input}, null);
}
