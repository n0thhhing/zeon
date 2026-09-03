const std = @import("std");
const builtin = @import("builtin");
const assert = std.debug.assert;
const expectEqual = std.testing.expectEqual;
const arch = @import("../arch.zig");
const endianness = builtin.target.cpu.arch.endian();
const types = @import("../types.zig");
const common = @import("../common.zig");
const convert = @import("convert.zig");
const permute = @import("permute.zig");
const shift = @import("shift.zig");

/// Signed multiply long
pub inline fn vmull_s8(a: types.i8x8, b: types.i8x8) types.i16x8 {
    return @as(types.i16x8, a) * @as(types.i16x8, b);
}

test vmull_s8 {
    const a: types.i8x8 = .{ 0, 0, 0, 0, 0, 0, 0, 127 };
    const b: types.i8x8 = @splat(2);
    try common.testIntrinsic("vmull_s8", vmull_s8, types.i16x8{ 0, 0, 0, 0, 0, 0, 0, 254 }, .{ a, b }, null);
}

/// Signed multiply long
pub inline fn vmull_s16(a: types.i16x4, b: types.i16x4) types.i32x4 {
    return @as(types.i32x4, a) * @as(types.i32x4, b);
}

test vmull_s16 {
    const a: types.i16x4 = .{ 0, -1, -2, -3 };
    const b: types.i16x4 = @splat(5);

    try common.testIntrinsic("vmull_s16", vmull_s16, types.i32x4{ 0, -1 * 5, -2 * 5, -3 * 5 }, .{ a, b }, null);
}

/// Signed multiply long
pub inline fn vmull_s32(a: types.i32x2, b: types.i32x2) types.i64x2 {
    return @as(types.i64x2, a) * @as(types.i64x2, b);
}

test vmull_s32 {
    const a: types.i32x2 = .{ 0, -1 };
    const b: types.i32x2 = @splat(5);

    try common.testIntrinsic("vmull_s32", vmull_s32, types.i32x2{ 0, -5 }, .{ a, b }, null);
}

/// Unsigned multiply long
pub inline fn vmull_u8(a: types.u8x8, b: types.u8x8) types.u16x8 {
    return @as(types.u16x8, a) * @as(types.u16x8, b);
}

test vmull_u8 {
    const a: types.u8x8 = .{ 0, 1, 2, 3, 4, 5, 6, 7 };
    const b: types.u8x8 = @splat(5);

    try common.testIntrinsic("vmull_u8", vmull_u8, types.u16x8{ 0, 1 * 5, 2 * 5, 3 * 5, 4 * 5, 5 * 5, 6 * 5, 7 * 5 }, .{ a, b }, null);
}

/// Unsigned multiply long
pub inline fn vmull_u16(a: types.u16x4, b: types.u16x4) types.u32x4 {
    return @as(types.u32x4, a) * @as(types.u32x4, b);
}

test vmull_u16 {
    const a: types.u16x4 = .{ 0, 1, 2, 3 };
    const b: types.u16x4 = @splat(5);

    try common.testIntrinsic("vmull_u16", vmull_u16, types.u32x4{ 0, 1 * 5, 2 * 5, 3 * 5 }, .{ a, b }, null);
}

/// Unsigned multiply long
pub inline fn vmull_u32(a: types.u32x2, b: types.u32x2) types.u64x2 {
    return @as(types.u64x2, a) * @as(types.u64x2, b);
}

test vmull_u32 {
    const a: types.u32x2 = .{ 0, 1 };
    const b: types.u32x2 = @splat(5);

    try common.testIntrinsic("vmull_u32", vmull_u32, types.u64x2{ 0, 1 * 5 }, .{ a, b }, null);
}

/// Signed multiply long
pub inline fn vmull_high_s8(a: types.i8x16, b: types.i8x16) types.i16x8 {
    return vmull_s8(permute.vget_high_s8(a), permute.vget_high_s8(b));
}

test vmull_high_s8 {
    const a: types.i8x16 = .{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 127 };
    const b: types.i8x16 = @splat(2);

    try common.testIntrinsic("vmull_high_s8", vmull_high_s8, types.i16x8{ 0, 0, 0, 0, 0, 0, 0, 254 }, .{ a, b }, null);
}

/// Signed multiply long
pub inline fn vmull_high_s16(a: types.i16x8, b: types.i16x8) types.i32x4 {
    return vmull_s16(permute.vget_high_s16(a), permute.vget_high_s16(b));
}

test vmull_high_s16 {
    const a: types.i16x8 = .{ 0, 0, 0, 0, 0, -1, -2, -3 };
    const b: types.i16x8 = @splat(5);

    try common.testIntrinsic("vmull_high_s16", vmull_high_s16, types.i32x4{ 0, -1 * 5, -2 * 5, -3 * 5 }, .{ a, b }, null);
}

/// Signed multiply long
pub inline fn vmull_high_s32(a: types.i32x4, b: types.i32x4) types.i64x2 {
    return vmull_s32(permute.vget_high_s32(a), permute.vget_high_s32(b));
}

test vmull_high_s32 {
    const a: types.i32x4 = .{ 0, -1, -2, -3 };
    const b: types.i32x4 = @splat(5);

    try common.testIntrinsic("vmull_high_s32", vmull_high_s32, types.i64x2{ -2 * 5, -3 * 5 }, .{ a, b }, null);
}

/// Unsigned multiply long
pub inline fn vmull_high_u8(a: types.u8x16, b: types.u8x16) types.u16x8 {
    return vmull_u8(permute.vget_high_u8(a), permute.vget_high_u8(b));
}

test vmull_high_u8 {
    const a: types.u8x16 = .{ 0, 0, 0, 0, 0, 0, 0, 127, 0, 0, 0, 0, 0, 0, 0, 127 };
    const b: types.u8x16 = @splat(2);

    try common.testIntrinsic("vmull_high_u8", vmull_high_u8, types.u16x8{ 0, 0, 0, 0, 0, 0, 0, 254 }, .{ a, b }, null);
}

/// Unsigned multiply long
pub inline fn vmull_high_u16(a: types.u16x8, b: types.u16x8) types.u32x4 {
    return vmull_u16(permute.vget_high_u16(a), permute.vget_high_u16(b));
}

test vmull_high_u16 {
    const a: types.u16x8 = .{ 0, 1, 2, 3, 0, 1, 2, 3 };
    const b: types.u16x8 = @splat(5);

    try common.testIntrinsic("vmull_high_u16", vmull_high_u16, types.u32x4{ 0, 1 * 5, 2 * 5, 3 * 5 }, .{ a, b }, null);
}

/// Unsigned multiply long
pub inline fn vmull_high_u32(a: types.u32x4, b: types.u32x4) types.u64x2 {
    return vmull_u32(permute.vget_high_u32(a), permute.vget_high_u32(b));
}

test vmull_high_u32 {
    const a: types.u32x4 = .{ 0, 1, 2, 3 };
    const b: types.u32x4 = @splat(5);

    try expectEqual(types.u32x2{ 2 * 5, 3 * 5 }, vmull_high_u32(a, b));
}

/// Absolute difference between two int8x8_t vectors
pub inline fn vabd_s8(a: types.i8x8, b: types.i8x8) types.i8x8 {
    return common.abdGeneric(a, b);
}

test vabd_s8 {
    const a: types.i8x8 = .{ 1, 2, 3, 4, 5, 6, 7, 8 };
    const b: types.i8x8 = .{ 16, 15, 14, 13, 12, 11, 10, 9 };

    const expected: types.i8x8 = .{ 15, 13, 11, 9, 7, 5, 3, 1 };

    try common.testIntrinsic("vabd_s8", vabd_s8, expected, .{ a, b }, null);
}

/// Absolute difference between two int16x4_t vectors
pub inline fn vabd_s16(a: types.i16x4, b: types.i16x4) types.i16x4 {
    return common.abdGeneric(a, b);
}

test vabd_s16 {
    const a: types.i16x4 = .{ 1, 2, 3, 4 };
    const b: types.i16x4 = .{ 16, 15, 14, 13 };

    const expected: types.i16x4 = .{ 15, 13, 11, 9 };

    try common.testIntrinsic("vabd_s16", vabd_s16, expected, .{ a, b }, null);
}

/// Absolute difference between two int32x2_t vectors
pub inline fn vabd_s32(a: types.i32x2, b: types.i32x2) types.i32x2 {
    return common.abdGeneric(a, b);
}

test vabd_s32 {
    const a: types.i32x2 = .{ 1, 2 };
    const b: types.i32x2 = .{ 16, 15 };

    const expected: types.i32x2 = .{ 15, 13 };

    try common.testIntrinsic("vabd_s32", vabd_s32, expected, .{ a, b }, null);
}

/// Absolute difference between two uint8x8_t vectors
pub inline fn vabd_u8(a: types.u8x8, b: types.u8x8) types.u8x8 {
    return common.abdGeneric(a, b);
}

test vabd_u8 {
    {
        const a: types.u8x8 = .{ 1, 2, 3, 4, 5, 6, 7, 8 };
        const b: types.u8x8 = .{ 16, 15, 14, 13, 12, 11, 10, 9 };
        const expected: types.u8x8 = .{ 15, 13, 11, 9, 7, 5, 3, 1 };

        try common.testIntrinsic("vabd_u8", vabd_u8, expected, .{ a, b }, null);
    }
    {
        const a: types.u8x8 = .{ 10, 10, 10, 10, 10, 10, 10, 10 };
        const b: types.u8x8 = .{ 10, 10, 10, 10, 10, 10, 10, 10 };
        const expected: types.u8x8 = .{ 0, 0, 0, 0, 0, 0, 0, 0 };

        try common.testIntrinsic("vabd_u8", vabd_u8, expected, .{ a, b }, null);
    }
    {
        const a: types.u8x8 = .{ 16, 15, 14, 13, 12, 11, 10, 9 };
        const b: types.u8x8 = .{ 1, 2, 3, 4, 5, 6, 7, 8 };
        const expected: types.u8x8 = .{ 15, 13, 11, 9, 7, 5, 3, 1 };

        try common.testIntrinsic("vabd_u8", vabd_u8, expected, .{ a, b }, null);
    }
    {
        const a: types.u8x8 = .{ 0, 255, 128, 64, 32, 16, 8, 4 };
        const b: types.u8x8 = .{ 255, 0, 64, 128, 16, 32, 4, 8 };
        const expected: types.u8x8 = .{ 255, 255, 64, 64, 16, 16, 4, 4 };

        try common.testIntrinsic("vabd_u8", vabd_u8, expected, .{ a, b }, null);
    }
    {
        const a: types.u8x8 = .{ 0, 0, 0, 0, 0, 0, 0, 0 };
        const b: types.u8x8 = .{ 0, 0, 0, 0, 0, 0, 0, 0 };
        const expected: types.u8x8 = .{ 0, 0, 0, 0, 0, 0, 0, 0 };

        try common.testIntrinsic("vabd_u8", vabd_u8, expected, .{ a, b }, null);
    }
}

/// Absolute difference between two uint16x4_t vectors
pub inline fn vabd_u16(a: types.u16x4, b: types.u16x4) types.u16x4 {
    return common.abdGeneric(a, b);
}

test vabd_u16 {
    const a: types.u16x4 = .{ 1, 2, 3, 4 };
    const b: types.u16x4 = .{ 16, 15, 14, 13 };

    const expected: types.u16x4 = .{ 15, 13, 11, 9 };

    try common.testIntrinsic("vabd_u16", vabd_u16, expected, .{ a, b }, null);
}

/// Absolute difference between two uint32x2_t vectors
pub inline fn vabd_u32(a: types.u32x2, b: types.u32x2) types.u32x2 {
    return common.abdGeneric(a, b);
}

test vabd_u32 {
    const a: types.u32x2 = .{ 1, 2 };
    const b: types.u32x2 = .{ 16, 15 };

    const expected: types.u32x2 = .{ 15, 13 };

    try common.testIntrinsic("vabd_u32", vabd_u32, expected, .{ a, b }, null);
}

/// Absolute difference between two float32x2_t vectors
pub inline fn vabd_f32(a: types.f32x2, b: types.f32x2) types.f32x2 {
    return common.abdGeneric(a, b);
}

test vabd_f32 {
    const a: types.f32x2 = .{ 0.00, 0.00 };
    const b: types.f32x2 = .{ 0.19, 0.15 };

    const expected: types.f32x2 = .{ @abs(0.00 - 0.19), @abs(0.00 - 0.15) };

    try common.testIntrinsic("vabd_f32", vabd_f32, expected, .{ a, b }, null);
}

/// Absolute difference between two float64x1_t vectors
pub inline fn vabd_f64(a: types.f64x1, b: types.f64x1) types.f64x1 {
    return common.abdGeneric(a, b);
}

test vabd_f64 {
    const a: types.f64x1 = .{0.01};
    const b: types.f64x1 = .{0.16};

    const expected: types.f64x1 = .{0.15};

    try expectEqual(expected, vabd_f64(a, b));
}

/// signed absolute difference and accumulate (128-bit)
pub inline fn vabdq_s8(a: types.i8x16, b: types.i8x16) types.i8x16 {
    return common.abdGeneric(a, b);
}

test vabdq_s8 {
    const a: types.i8x16 = .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 };
    const b: types.i8x16 = .{ 16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1 };

    const expected: types.i8x16 = .{ 15, 13, 11, 9, 7, 5, 3, 1, 1, 3, 5, 7, 9, 11, 13, 15 };

    try common.testIntrinsic("vabdq_s8", vabdq_s8, expected, .{ a, b }, null);
}

/// signed absolute difference and accumulate (128-bit)
pub inline fn vabdq_s16(a: types.i16x8, b: types.i16x8) types.i16x8 {
    return common.abdGeneric(a, b);
}

test vabdq_s16 {
    const a: types.i16x8 = .{ 1, 2, 3, 4, 5, 6, 7, 8 };
    const b: types.i16x8 = .{ 16, 15, 14, 13, 12, 11, 10, 9 };

    const expected: types.i16x8 = .{ 15, 13, 11, 9, 7, 5, 3, 1 };

    try common.testIntrinsic("vabdq_s16", vabdq_s16, expected, .{ a, b }, null);
}

/// signed absolute difference and accumulate (128-bit)
pub inline fn vabdq_s32(a: types.i32x4, b: types.i32x4) types.i32x4 {
    return common.abdGeneric(a, b);
}

test vabdq_s32 {
    const a: types.i32x4 = .{ 1, 2, 3, 4 };
    const b: types.i32x4 = .{ 16, 15, 14, 13 };

    const expected: types.i32x4 = .{ 15, 13, 11, 9 };

    try common.testIntrinsic("vabdq_s32", vabdq_s32, expected, .{ a, b }, null);
}

/// signed absolute difference and accumulate (128-bit)
pub inline fn vabdq_u8(a: types.u8x16, b: types.u8x16) types.u8x16 {
    return common.abdGeneric(a, b);
}

test vabdq_u8 {
    {
        const a: types.u8x16 = .{ 1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8 };
        const b: types.u8x16 = .{ 16, 15, 14, 13, 12, 11, 10, 9, 16, 15, 14, 13, 12, 11, 10, 9 };
        const expected: types.u8x16 = .{ 15, 13, 11, 9, 7, 5, 3, 1, 15, 13, 11, 9, 7, 5, 3, 1 };

        try common.testIntrinsic("vabdq_u8", vabdq_u8, expected, .{ a, b }, null);
    }
    {
        const a: types.u8x16 = .{ 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 };
        const b: types.u8x16 = .{ 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 };
        const expected: types.u8x16 = .{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };

        try common.testIntrinsic("vabdq_u8", vabdq_u8, expected, .{ a, b }, null);
    }
    {
        const a: types.u8x16 = .{ 16, 15, 14, 13, 12, 11, 10, 9, 16, 15, 14, 13, 12, 11, 10, 9 };
        const b: types.u8x16 = .{ 1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8 };
        const expected: types.u8x16 = .{ 15, 13, 11, 9, 7, 5, 3, 1, 15, 13, 11, 9, 7, 5, 3, 1 };

        try common.testIntrinsic("vabdq_u8", vabdq_u8, expected, .{ a, b }, null);
    }
    {
        const a: types.u8x16 = .{ 0, 255, 128, 64, 32, 16, 8, 4, 0, 255, 128, 64, 32, 16, 8, 4 };
        const b: types.u8x16 = .{ 255, 0, 64, 128, 16, 32, 4, 8, 255, 0, 64, 128, 16, 32, 4, 8 };
        const expected: types.u8x16 = .{ 255, 255, 64, 64, 16, 16, 4, 4, 255, 255, 64, 64, 16, 16, 4, 4 };

        try common.testIntrinsic("vabdq_u8", vabdq_u8, expected, .{ a, b }, null);
    }
    {
        const a: types.u8x16 = .{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
        const b: types.u8x16 = .{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
        const expected: types.u8x16 = .{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };

        try common.testIntrinsic("vabdq_u8", vabdq_u8, expected, .{ a, b }, null);
    }
}

/// signed absolute difference and accumulate (128-bit)
pub inline fn vabdq_u16(a: types.u16x8, b: types.u16x8) types.u16x8 {
    return common.abdGeneric(a, b);
}

test vabdq_u16 {
    const a: types.u16x8 = .{ 1, 2, 3, 4, 1, 2, 3, 4 };
    const b: types.u16x8 = .{ 16, 15, 14, 13, 16, 15, 14, 13 };

    const expected: types.u16x8 = .{ 15, 13, 11, 9, 15, 13, 11, 9 };

    try common.testIntrinsic("vabdq_u16", vabdq_u16, expected, .{ a, b }, null);
}

/// signed absolute difference and accumulate (128-bit)
pub inline fn vabdq_u32(a: types.u32x4, b: types.u32x4) types.u32x4 {
    return common.abdGeneric(a, b);
}

test vabdq_u32 {
    const a: types.u32x4 = .{ 1, 2, 1, 2 };
    const b: types.u32x4 = .{ 16, 15, 16, 15 };

    const expected: types.u32x4 = .{ 15, 13, 15, 13 };

    try common.testIntrinsic("vabdq_u32", vabdq_u32, expected, .{ a, b }, null);
}

/// signed absolute difference and accumulate (128-bit)
pub inline fn vabdq_f32(a: types.f32x4, b: types.f32x4) types.f32x4 {
    return common.abdGeneric(a, b);
}

test vabdq_f32 {
    const a: types.f32x4 = .{ 0.00, 0.00, 0.00, 0.00 };
    const b: types.f32x4 = .{ 0.19, 0.15, 0.19, 0.15 };

    const expected: types.f32x4 = .{ @abs(0.00 - 0.19), @abs(0.00 - 0.15), @abs(0.00 - 0.19), @abs(0.00 - 0.15) };

    try expectEqual(expected, vabdq_f32(a, b));
}

/// signed absolute difference and accumulate (128-bit)
pub inline fn vabdq_f64(a: types.f64x2, b: types.f64x2) types.f64x2 {
    return common.abdGeneric(a, b);
}

test vabdq_f64 {
    const a: types.f64x2 = .{ 0.01, 0.01 };
    const b: types.f64x2 = .{ 0.16, 0.16 };

    const expected: types.f64x2 = .{ 0.15, 0.15 };

    try expectEqual(expected, vabdq_f64(a, b));
}

/// Signed saturating doubling multiply long
pub inline fn vqdmull_s16(a: types.i16x4, b: types.i16x4) types.i32x4 {
    if (comptime common.has_llvm_backend and arch.aarch64.hasFeatures(&.{.neon})) {
        return struct {
            extern fn @"llvm.aarch64.neon.sqdmull.v4i32"(types.i16x4, types.i16x4) types.i32x4;
        }.@"llvm.aarch64.neon.sqdmull.v4i32"(a, b);
    } else if (comptime common.has_llvm_backend and arch.arm.hasFeatures(&.{.neon})) {
        return struct {
            extern fn @"llvm.arm.neon.vqdmull.v4i32"(types.i16x4, types.i16x4) types.i32x4;
        }.@"llvm.arm.neon.vqdmull.v4i32"(a, b);
    } else if (comptime arch.aarch64.hasFeatures(&.{.neon})) {
        switch (endianness) {
            inline .little => {
                return asm ("sqdmull %[ret].4s, %[a].4h, %[b].4h"
                    : [ret] "=w" (-> types.i32x4),
                    : [a] "w" (a),
                      [b] "w" (b),
                );
            },
            inline .big => {
                return asm (
                    \\ sqdmull %[ret].4s, %[a].4h, %[b].4h
                    \\ rev32   %[ret].16b, %[ret].16b
                    \\ rev64   %[ret].4s, %[ret].4s
                    \\ ext     %[ret].16b, %[ret].16b, %[ret].16b, #8
                    : [ret] "=w" (-> types.i32x4),
                    : [a] "w" (a),
                      [b] "w" (b),
                );
            },
        }
    } else if (comptime arch.arm.hasFeatures(&.{.neon})) {
        return asm ("vqdmull.s16 %[ret], %[a], %[b]"
            : [ret] "=w" (-> types.i32x4),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else {
        const product = vmull_s16(a, b);
        return product *| @as(types.i32x4, @splat(2));
    }
}

test vqdmull_s16 {
    const a: types.i16x4 = .{ 16384, -16384, 12345, -12345 };
    const b: types.i16x4 = .{ 2, 2, -2, -2 };

    const expected: types.i32x4 = .{
        65536, // 16384 * 2 * 2
        -65536, // -16384 * 2 * 2
        -49380, // 12345 * -2 * 2
        49380, // -12345 * -2 * 2
    };

    try common.testIntrinsic("vqdmull_s16", vqdmull_s16, expected, .{ a, b }, null);

    const a_sat: types.i16x4 = .{ std.math.maxInt(i16), std.math.maxInt(i16), std.math.maxInt(i16), std.math.minInt(i16) };
    const b_sat: types.i16x4 = .{ std.math.maxInt(i16), std.math.minInt(i16), std.math.maxInt(i16), std.math.maxInt(i16) };

    const expected_sat: types.i32x4 = .{
        2147352578,
        -2147418112,
        2147352578,
        -2147418112,
    };

    try expectEqual(expected_sat, vqdmull_s16(a_sat, b_sat));
}

/// Signed saturating doubling multiply long
pub inline fn vqdmull_s32(a: types.i32x2, b: types.i32x2) types.i64x2 {
    if (comptime common.has_llvm_backend and arch.aarch64.hasFeatures(&.{.neon})) {
        return struct {
            extern fn @"llvm.aarch64.neon.sqdmull.v2i64"(types.i32x2, types.i32x2) types.i64x2;
        }.@"llvm.aarch64.neon.sqdmull.v2i64"(a, b);
    } else if (comptime common.has_llvm_backend and arch.arm.hasFeatures(&.{.neon})) {
        return struct {
            extern fn @"llvm.arm.neon.vqdmull.v2i64"(types.i32x2, types.i32x2) types.i64x2;
        }.@"llvm.arm.neon.vqdmull.v2i64"(a, b);
    } else if (comptime arch.aarch64.hasFeatures(&.{.neon})) {
        switch (endianness) {
            inline .little => {
                return asm ("sqdmull %[ret].2d, %[a].2s, %[b].2s"
                    : [ret] "=w" (-> types.i64x2),
                    : [a] "w" (a),
                      [b] "w" (b),
                );
            },
            inline .big => {
                return asm (
                    \\ sqdmull %[ret].2d, %[a].2s, %[b].2s
                    \\ rev64   %[ret].16b, %[ret].16b
                    \\ ext     %[ret].16b, %[ret].16b, %[ret].16b, #8
                    : [ret] "=w" (-> types.i64x2),
                    : [a] "w" (a),
                      [b] "w" (b),
                );
            },
        }
    } else if (comptime arch.arm.hasFeatures(&.{.neon})) {
        return asm ("vqdmull.s32 %[ret], %[a], %[b]"
            : [ret] "=w" (-> types.i64x2),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else {
        const product = vmull_s32(a, b);
        return product *| @as(types.i64x2, @splat(2));
    }
}

test vqdmull_s32 {
    const a: types.i32x2 = .{ 6477777, -782282872 };
    const b: types.i32x2 = .{ 5, 5 };

    const expected: types.i64x2 = .{
        64777770, // 6477777 * 5 * 2
        -7822828720, // -782282872 * 5 * 2
    };

    try common.testIntrinsic("vqdmull_s32", vqdmull_s32, expected, .{ a, b }, null);

    const a_sat: types.i32x2 = .{ std.math.maxInt(i32), std.math.maxInt(i32) };
    const b_sat: types.i32x2 = .{ std.math.maxInt(i32), std.math.minInt(i32) };

    const expected_sat: types.i64x2 = .{
        9223372028264841218,
        -9223372032559808512,
    };

    try common.testIntrinsic("vqdmull_s32", vqdmull_s32, expected_sat, .{ a_sat, b_sat }, null);
}

/// Signed saturating doubling multiply long
pub inline fn vqdmullh_s16(a: i16, b: i16) i32 {
    if (comptime common.has_llvm_backend and arch.aarch64.hasFeatures(&.{.neon})) {
        return struct {
            extern fn @"llvm.aarch64.neon.sqdmull.v4i32"(types.i16x4, types.i16x4) types.i32x4;
        }.@"llvm.aarch64.neon.sqdmull.v4i32"(@splat(a), @splat(b))[0];
    } else if (comptime arch.aarch64.hasFeatures(&.{.neon})) {
        return asm (
            \\ fmov    s0, %[a:w]
            \\ fmov    s1, %[b:w]
            \\ sqdmull v0.4s, v0.4h, v1.4h
            \\ fmov    %[ret:w], s0
            : [ret] "=r" (-> i32),
            : [a] "r" (a),
              [b] "r" (b),
            : .{ .s0 = true, .s1 = true, .v0 = true, .v1 = true });
    } else {
        return (@as(i32, a) *| @as(i32, b)) *| 2;
    }
}

test vqdmullh_s16 {
    const a: i16 = std.math.maxInt(i16);
    const b: i16 = 20;
    const expected: i32 = 1310680;

    try common.testIntrinsic("vqdmullh_s16", vqdmullh_s16, expected, .{ a, b }, null);
}

/// Signed saturating doubling multiply long
pub inline fn vqdmulls_s32(a: i32, b: i32) i64 {
    if (comptime common.has_llvm_backend and arch.aarch64.hasFeatures(&.{.neon})) {
        return struct {
            extern fn @"llvm.aarch64.neon.sqdmulls.scalar"(i32, i32) i64;
        }.@"llvm.aarch64.neon.sqdmulls.scalar"(a, b);
    } else if (comptime arch.aarch64.hasFeatures(&.{.neon})) {
        return asm (
            \\ fmov    s0, %[a:w]
            \\ fmov    s1, %[b:w]
            \\ sqdmull d0, s0, s1
            \\ fmov    %[ret], d0
            : [ret] "=r" (-> i64),
            : [a] "r" (a),
              [b] "r" (b),
            : .{ .s0 = true, .s1 = true, .d0 = true });
    } else {
        return (@as(i64, a) *| @as(i64, b)) *| 2;
    }
}

test vqdmulls_s32 {
    const a: i32 = std.math.maxInt(i32);
    const b: i32 = 20;
    const expected: i64 = 85899345880;

    try common.testIntrinsic("vqdmulls_s32", vqdmulls_s32, expected, .{ a, b }, null);
}

/// Saturating subtract
pub inline fn vqsub_s8(a: types.i8x8, b: types.i8x8) types.i8x8 {
    return a -| b;
}

test vqsub_s8 {
    const a: types.i8x8 = @splat(1);
    const b: types.i8x8 = @splat(1);
    const expected: types.i8x8 = @splat(0);
    try common.testIntrinsic("vqsub_s8", vqsub_s8, expected, .{ a, b }, null);
}

/// Saturating subtract
pub inline fn vqsub_s16(a: types.i16x4, b: types.i16x4) types.i16x4 {
    return a -| b;
}

test vqsub_s16 {
    const a: types.i16x4 = @splat(1);
    const b: types.i16x4 = @splat(1);
    const expected: types.i16x4 = @splat(0);
    try common.testIntrinsic("vqsub_s16", vqsub_s16, expected, .{ a, b }, null);
}

/// Saturating subtract
pub inline fn vqsub_s32(a: types.i32x2, b: types.i32x2) types.i32x2 {
    return a -| b;
}

test vqsub_s32 {
    const a: types.i32x2 = @splat(1);
    const b: types.i32x2 = @splat(1);
    const expected: types.i32x2 = @splat(0);
    try common.testIntrinsic("vqsub_s32", vqsub_s32, expected, .{ a, b }, null);
}

/// Saturating subtract
pub inline fn vqsub_s64(a: types.i64x1, b: types.i64x1) types.i64x1 {
    return a -| b;
}

test vqsub_s64 {
    const a: types.i64x1 = @splat(1);
    const b: types.i64x1 = @splat(1);
    const expected: types.i64x1 = @splat(0);
    try common.testIntrinsic("vqsub_s64", vqsub_s64, expected, .{ a, b }, null);
}

/// Saturating subtract
pub inline fn vqsub_u8(a: types.u8x8, b: types.u8x8) types.u8x8 {
    return a -| b;
}

test vqsub_u8 {
    const a: types.u8x8 = @splat(1);
    const b: types.u8x8 = @splat(1);
    const expected: types.u8x8 = @splat(0);
    try common.testIntrinsic("vqsub_u8", vqsub_u8, expected, .{ a, b }, null);
}

/// Saturating subtract
pub inline fn vqsub_u16(a: types.u16x4, b: types.u16x4) types.u16x4 {
    return a -| b;
}

test vqsub_u16 {
    const a: types.u16x4 = @splat(1);
    const b: types.u16x4 = @splat(1);
    const expected: types.u16x4 = @splat(0);
    try common.testIntrinsic("vqsub_u16", vqsub_u16, expected, .{ a, b }, null);
}

/// Saturating subtract
pub inline fn vqsub_u32(a: types.u32x2, b: types.u32x2) types.u32x2 {
    return a -| b;
}

test vqsub_u32 {
    const a: types.u32x2 = @splat(1);
    const b: types.u32x2 = @splat(1);
    const expected: types.u32x2 = @splat(0);
    try common.testIntrinsic("vqsub_u32", vqsub_u32, expected, .{ a, b }, null);
}

/// Saturating subtract
pub inline fn vqsub_u64(a: types.u64x1, b: types.u64x1) types.u64x1 {
    return a -| b;
}

test vqsub_u64 {
    const a: types.u64x1 = @splat(1);
    const b: types.u64x1 = @splat(1);
    const expected: types.u64x1 = @splat(0);
    try common.testIntrinsic("vqsub_u64", vqsub_u64, expected, .{ a, b }, null);
}

/// Saturating subtract
pub inline fn vqsubq_s8(a: types.i8x16, b: types.i8x16) types.i8x16 {
    return a -| b;
}

test vqsubq_s8 {
    const a: types.i8x16 = @splat(1);
    const b: types.i8x16 = @splat(1);
    const expected: types.i8x16 = @splat(0);
    try common.testIntrinsic("vqsubq_s8", vqsubq_s8, expected, .{ a, b }, null);
}

/// Saturating subtract
pub inline fn vqsubq_s16(a: types.i16x8, b: types.i16x8) types.i16x8 {
    return a -| b;
}

test vqsubq_s16 {
    const a: types.i16x8 = @splat(1);
    const b: types.i16x8 = @splat(1);
    const expected: types.i16x8 = @splat(0);
    try common.testIntrinsic("vqsubq_s16", vqsubq_s16, expected, .{ a, b }, null);
}

/// Saturating subtract
pub inline fn vqsubq_s32(a: types.i32x4, b: types.i32x4) types.i32x4 {
    return a -| b;
}

test vqsubq_s32 {
    const a: types.i32x4 = @splat(1);
    const b: types.i32x4 = @splat(1);
    const expected: types.i32x4 = @splat(0);
    try common.testIntrinsic("vqsubq_s32", vqsubq_s32, expected, .{ a, b }, null);
}

/// Saturating subtract
pub inline fn vqsubq_s64(a: types.i64x2, b: types.i64x2) types.i64x2 {
    return a -| b;
}

test vqsubq_s64 {
    const a: types.i64x2 = @splat(1);
    const b: types.i64x2 = @splat(1);
    const expected: types.i64x2 = @splat(0);
    try common.testIntrinsic("vqsubq_s64", vqsubq_s64, expected, .{ a, b }, null);
}

/// Saturating subtract
pub inline fn vqsubq_u8(a: types.u8x16, b: types.u8x16) types.u8x16 {
    return a -| b;
}

test vqsubq_u8 {
    const a: types.u8x16 = @splat(1);
    const b: types.u8x16 = @splat(1);
    const expected: types.u8x16 = @splat(0);
    try common.testIntrinsic("vqsubq_u8", vqsubq_u8, expected, .{ a, b }, null);
}

/// Saturating subtract
pub inline fn vqsubq_u16(a: types.u16x8, b: types.u16x8) types.u16x8 {
    return a -| b;
}

test vqsubq_u16 {
    const a: types.u16x8 = @splat(1);
    const b: types.u16x8 = @splat(1);
    const expected: types.u16x8 = @splat(0);
    try common.testIntrinsic("vqsubq_u16", vqsubq_u16, expected, .{ a, b }, null);
}

/// Saturating subtract
pub inline fn vqsubq_u32(a: types.u32x4, b: types.u32x4) types.u32x4 {
    return a -| b;
}

test vqsubq_u32 {
    const a: types.u32x4 = @splat(1);
    const b: types.u32x4 = @splat(1);
    const expected: types.u32x4 = @splat(0);
    try common.testIntrinsic("vqsubq_u32", vqsubq_u32, expected, .{ a, b }, null);
}

/// Saturating subtract
pub inline fn vqsubq_u64(a: types.u64x2, b: types.u64x2) types.u64x2 {
    return a -| b;
}

test vqsubq_u64 {
    const a: types.u64x2 = @splat(1);
    const b: types.u64x2 = @splat(1);
    const expected: types.u64x2 = @splat(0);
    try common.testIntrinsic("vqsubq_u64", vqsubq_u64, expected, .{ a, b }, null);
}

/// Saturating subtract
pub inline fn vqsubs_s32(a: i32, b: i32) i32 {
    return a -| b;
}

test vqsubs_s32 {
    const a: i32 = 1;
    const b: i32 = 1;
    const expected: i32 = 0;
    try common.testIntrinsic("vqsubs_s32", vqsubs_s32, expected, .{ a, b }, null);
}

/// Saturating subtract
pub inline fn vqsubs_u32(a: u32, b: u32) u32 {
    return a -| b;
}

test vqsubs_u32 {
    const a: u32 = 1;
    const b: u32 = 1;
    const expected: u32 = 0;
    try common.testIntrinsic("vqsubs_u32", vqsubs_u32, expected, .{ a, b }, null);
}

/// Saturating subtract
pub inline fn vqsubd_s64(a: i64, b: i64) i64 {
    return a -| b;
}

test vqsubd_s64 {
    const a: i64 = 1;
    const b: i64 = 1;
    const expected: i64 = 0;
    try common.testIntrinsic("vqsubd_s64", vqsubd_s64, expected, .{ a, b }, null);
}

/// Saturating subtract
pub inline fn vqsubd_u64(a: u64, b: u64) u64 {
    return a -| b;
}

test vqsubd_u64 {
    const a: u64 = 1;
    const b: u64 = 1;
    const expected: u64 = 0;
    try common.testIntrinsic("vqsubd_u64", vqsubd_u64, expected, .{ a, b }, null);
}

/// Signed Absolute difference and Accumulate
pub inline fn vaba_s8(acc: types.i8x8, a: types.i8x8, b: types.i8x8) types.i8x8 {
    return vabd_s8(a, b) +% acc;
}

test vaba_s8 {
    {
        const acc: types.i8x8 = .{ 10, 20, 30, 40, 50, 60, 70, 80 };

        const a: types.i8x8 = .{ -5, -15, -25, -35, -45, -55, -65, -75 };
        const b: types.i8x8 = .{ 5, 15, 25, 35, 45, 55, 65, 75 };
        const expected: types.i8x8 = .{ 20, 50, 80, 110, -116, -86, -56, -26 };

        try expectEqual(expected, vaba_s8(acc, a, b));
    }
    {
        const acc: types.i8x8 = .{ 0, 0, 0, 0, 0, 0, 0, 0 };

        const a: types.i8x8 = .{ -5, -15, -25, -35, -45, -55, -65, -75 };
        const b: types.i8x8 = .{ 5, 15, 25, 35, 45, 55, 65, 75 };
        const expected: types.i8x8 = .{ 10, 30, 50, 70, 90, 110, -126, -106 };

        try expectEqual(expected, vaba_s8(acc, a, b));
    }
    {
        const acc: types.i8x8 = .{ 100, 110, 120, 127, -128, -100, -50, 0 };
        const a: types.i8x8 = .{ -5, -15, -25, -35, -45, -55, -65, -75 };

        const expected: types.i8x8 = acc;

        try expectEqual(expected, vaba_s8(acc, a, a));
    }
    {
        const acc: types.i8x8 = .{ -10, 10, -20, 20, -30, 30, -40, 40 };
        const a: types.i8x8 = .{ -128, -64, -32, -16, 16, 32, 64, 127 };
        const b: types.i8x8 = .{ 127, 63, 32, 16, -16, -32, -64, -128 };

        const expected: types.i8x8 = .{ -11, -119, 44, 52, 2, 94, 88, 39 };

        try expectEqual(expected, vaba_s8(acc, a, b));
    }
}

/// Signed Absolute difference and Accumulate
pub inline fn vaba_s16(acc: types.i16x4, a: types.i16x4, b: types.i16x4) types.i16x4 {
    return vabd_s16(a, b) +% acc;
}

test vaba_s16 {
    const acc: types.i16x4 = @splat(1);
    const a: types.i16x4 = @splat(1);
    const b: types.i16x4 = @splat(1);
    const expected: types.i16x4 = .{ 1, 1, 1, 1 };
    try common.testIntrinsic("vaba_s16", vaba_s16, expected, .{ acc, a, b }, null);
}

/// Signed Absolute difference and Accumulate
pub inline fn vaba_s32(acc: types.i32x2, a: types.i32x2, b: types.i32x2) types.i32x2 {
    return vabd_s32(a, b) +% acc;
}

test vaba_s32 {
    const acc: types.i32x2 = @splat(1);
    const a: types.i32x2 = @splat(1);
    const b: types.i32x2 = @splat(1);
    const expected: types.i32x2 = .{ 1, 1 };
    try common.testIntrinsic("vaba_s32", vaba_s32, expected, .{ acc, a, b }, null);
}

/// Unsigned Absolute difference and Accumulate
pub inline fn vaba_u8(acc: types.u8x8, a: types.u8x8, b: types.u8x8) types.u8x8 {
    return vabd_u8(a, b) +% acc;
}

test vaba_u8 {
    const acc: types.u8x8 = @splat(1);
    const a: types.u8x8 = @splat(1);
    const b: types.u8x8 = @splat(1);
    const expected: types.u8x8 = .{ 1, 1, 1, 1, 1, 1, 1, 1 };
    try common.testIntrinsic("vaba_u8", vaba_u8, expected, .{ acc, a, b }, null);
}

/// Unsigned Absolute difference and Accumulate
pub inline fn vaba_u16(acc: types.u16x4, a: types.u16x4, b: types.u16x4) types.u16x4 {
    return vabd_u16(a, b) +% acc;
}

test vaba_u16 {
    const acc: types.u16x4 = @splat(1);
    const a: types.u16x4 = @splat(1);
    const b: types.u16x4 = @splat(1);
    const expected: types.u16x4 = .{ 1, 1, 1, 1 };
    try common.testIntrinsic("vaba_u16", vaba_u16, expected, .{ acc, a, b }, null);
}

/// Unsigned Absolute difference and Accumulate
pub inline fn vaba_u32(acc: types.u32x2, a: types.u32x2, b: types.u32x2) types.u32x2 {
    return vabd_u32(a, b) +% acc;
}

test vaba_u32 {
    const acc: types.u32x2 = @splat(1);
    const a: types.u32x2 = @splat(1);
    const b: types.u32x2 = @splat(1);
    const expected: types.u32x2 = .{ 1, 1 };
    try common.testIntrinsic("vaba_u32", vaba_u32, expected, .{ acc, a, b }, null);
}

/// Signed Absolute difference and Accumulate
pub inline fn vabaq_s8(acc: types.i8x16, a: types.i8x16, b: types.i8x16) types.i8x16 {
    return vabdq_s8(a, b) +% acc;
}

test vabaq_s8 {
    const acc: types.i8x16 = @splat(1);
    const a: types.i8x16 = @splat(1);
    const b: types.i8x16 = @splat(1);
    const expected: types.i8x16 = .{ 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 };
    try common.testIntrinsic("vabaq_s8", vabaq_s8, expected, .{ acc, a, b }, null);
}

/// Signed Absolute difference and Accumulate
pub inline fn vabaq_s16(acc: types.i16x8, a: types.i16x8, b: types.i16x8) types.i16x8 {
    return vabdq_s16(a, b) +% acc;
}

test vabaq_s16 {
    const acc: types.i16x8 = @splat(1);
    const a: types.i16x8 = @splat(1);
    const b: types.i16x8 = @splat(1);
    const expected: types.i16x8 = .{ 1, 1, 1, 1, 1, 1, 1, 1 };
    try common.testIntrinsic("vabaq_s16", vabaq_s16, expected, .{ acc, a, b }, null);
}

/// Signed Absolute difference and Accumulate
pub inline fn vabaq_s32(acc: types.i32x4, a: types.i32x4, b: types.i32x4) types.i32x4 {
    return vabdq_s32(a, b) +% acc;
}

test vabaq_s32 {
    const acc: types.i32x4 = @splat(1);
    const a: types.i32x4 = @splat(1);
    const b: types.i32x4 = @splat(1);
    const expected: types.i32x4 = .{ 1, 1, 1, 1 };
    try common.testIntrinsic("vabaq_s32", vabaq_s32, expected, .{ acc, a, b }, null);
}

/// Unsigned Absolute difference and Accumulate
pub inline fn vabaq_u8(acc: types.u8x16, a: types.u8x16, b: types.u8x16) types.u8x16 {
    return vabdq_u8(a, b) +% acc;
}

test vabaq_u8 {
    const acc: types.u8x16 = @splat(1);
    const a: types.u8x16 = @splat(1);
    const b: types.u8x16 = @splat(1);
    const expected: types.u8x16 = .{ 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 };
    try common.testIntrinsic("vabaq_u8", vabaq_u8, expected, .{ acc, a, b }, null);
}

/// Unsigned Absolute difference and Accumulate
pub inline fn vabaq_u16(acc: types.u16x8, a: types.u16x8, b: types.u16x8) types.u16x8 {
    return vabdq_u16(a, b) +% acc;
}

test vabaq_u16 {
    const acc: types.u16x8 = @splat(1);
    const a: types.u16x8 = @splat(1);
    const b: types.u16x8 = @splat(1);
    const expected: types.u16x8 = .{ 1, 1, 1, 1, 1, 1, 1, 1 };
    try common.testIntrinsic("vabaq_u16", vabaq_u16, expected, .{ acc, a, b }, null);
}

/// Unsigned Absolute difference and Accumulate
pub inline fn vabaq_u32(acc: types.u32x4, a: types.u32x4, b: types.u32x4) types.u32x4 {
    return vabdq_u32(a, b) +% acc;
}

test vabaq_u32 {
    const acc: types.u32x4 = @splat(1);
    const a: types.u32x4 = @splat(1);
    const b: types.u32x4 = @splat(1);
    const expected: types.u32x4 = .{ 1, 1, 1, 1 };
    try common.testIntrinsic("vabaq_u32", vabaq_u32, expected, .{ acc, a, b }, null);
}

/// Signed Absolute difference and Accumulate Long
pub inline fn vabal_s8(acc: types.i16x8, a: types.i8x8, b: types.i8x8) types.i8x8 {
    return vabdl_s8(a, b) +% acc;
}

test vabal_s8 {
    const acc: types.i16x8 = @splat(1);
    const a: types.i8x8 = @splat(1);
    const b: types.i8x8 = @splat(1);
    const expected: types.i8x8 = .{ 1, 1, 1, 1, 1, 1, 1, 1 };
    try common.testIntrinsic("vabal_s8", vabal_s8, expected, .{ acc, a, b }, null);
}

/// Unsigned Absolute difference and Accumulate Long
pub inline fn vabal_s16(acc: types.i32x4, a: types.i16x4, b: types.i16x4) types.i16x4 {
    return vabdl_s16(a, b) +% acc;
}

test vabal_s16 {
    const acc: types.i32x4 = @splat(1);
    const a: types.i16x4 = @splat(1);
    const b: types.i16x4 = @splat(1);
    const expected: types.i16x4 = .{ 1, 1, 1, 1 };
    try common.testIntrinsic("vabal_s16", vabal_s16, expected, .{ acc, a, b }, null);
}

/// Signed Absolute difference and Accumulate Long
pub inline fn vabal_s32(acc: types.i64x2, a: types.i32x2, b: types.i32x2) types.i32x2 {
    return vabdl_s32(a, b) +% acc;
}

test vabal_s32 {
    const acc: types.i64x2 = @splat(1);
    const a: types.i32x2 = @splat(1);
    const b: types.i32x2 = @splat(1);
    const expected: types.i32x2 = .{ 1, 1 };
    try common.testIntrinsic("vabal_s32", vabal_s32, expected, .{ acc, a, b }, null);
}

/// Unsigned Absolute difference and Accumulate Long
pub inline fn vabal_u8(acc: types.u16x8, a: types.u8x8, b: types.u8x8) types.u8x8 {
    return vabdl_u8(a, b) +% acc;
}

test vabal_u8 {
    const acc: types.u16x8 = @splat(1);
    const a: types.u8x8 = @splat(1);
    const b: types.u8x8 = @splat(1);
    const expected: types.u8x8 = .{ 1, 1, 1, 1, 1, 1, 1, 1 };
    try common.testIntrinsic("vabal_u8", vabal_u8, expected, .{ acc, a, b }, null);
}

/// Unsigned Absolute difference and Accumulate Long
pub inline fn vabal_u16(acc: types.u32x4, a: types.u16x4, b: types.u16x4) types.u16x4 {
    return vabdl_u16(a, b) +% acc;
}

test vabal_u16 {
    const acc: types.u32x4 = @splat(1);
    const a: types.u16x4 = @splat(1);
    const b: types.u16x4 = @splat(1);
    const expected: types.u16x4 = .{ 1, 1, 1, 1 };
    try common.testIntrinsic("vabal_u16", vabal_u16, expected, .{ acc, a, b }, null);
}

/// Unsigned Absolute difference and Accumulate Long
pub inline fn vabal_u32(acc: types.u64x2, a: types.u32x2, b: types.u32x2) types.u32x2 {
    return vabdl_u32(a, b) +% acc;
}

test vabal_u32 {
    const acc: types.u64x2 = @splat(1);
    const a: types.u32x2 = @splat(1);
    const b: types.u32x2 = @splat(1);
    const expected: types.u32x2 = .{ 1, 1 };
    try common.testIntrinsic("vabal_u32", vabal_u32, expected, .{ acc, a, b }, null);
}

/// Signed Absolute difference and Accumulate Long
pub inline fn vabal_high_s8(acc: types.i16x8, a: types.i8x16, b: types.i8x16) types.i16x8 {
    return vabdl_high_s8(a, b) +% acc;
}

test vabal_high_s8 {
    const acc: types.i16x8 = @splat(1);
    const a: types.i8x16 = @splat(1);
    const b: types.i8x16 = @splat(1);
    const expected: types.i16x8 = .{ 1, 1, 1, 1, 1, 1, 1, 1 };
    try common.testIntrinsic("vabal_high_s8", vabal_high_s8, expected, .{ acc, a, b }, null);
}

/// Signed Absolute difference and Accumulate Long
pub inline fn vabal_high_s16(acc: types.i32x4, a: types.i16x8, b: types.i16x8) types.i32x4 {
    return vabdl_high_s16(a, b) +% acc;
}

test vabal_high_s16 {
    const acc: types.i32x4 = @splat(1);
    const a: types.i16x8 = @splat(1);
    const b: types.i16x8 = @splat(1);
    const expected: types.i32x4 = .{ 1, 1, 1, 1 };
    try common.testIntrinsic("vabal_high_s16", vabal_high_s16, expected, .{ acc, a, b }, null);
}

/// Signed Absolute difference and Accumulate Long
pub inline fn vabal_high_s32(acc: types.i64x2, a: types.i32x4, b: types.i32x4) types.i64x2 {
    return vabdl_high_s32(a, b) +% acc;
}

test vabal_high_s32 {
    const acc: types.i64x2 = @splat(1);
    const a: types.i32x4 = @splat(1);
    const b: types.i32x4 = @splat(1);
    const expected: types.i64x2 = .{ 1, 1 };
    try common.testIntrinsic("vabal_high_s32", vabal_high_s32, expected, .{ acc, a, b }, null);
}

/// Unsigned Absolute difference and Accumulate Long
pub inline fn vabal_high_u8(acc: types.u16x8, a: types.u8x16, b: types.u8x16) types.u16x8 {
    return vabdl_high_u8(a, b) +% acc;
}

test vabal_high_u8 {
    const acc: types.u16x8 = @splat(1);
    const a: types.u8x16 = @splat(1);
    const b: types.u8x16 = @splat(1);
    const expected: types.u16x8 = .{ 1, 1, 1, 1, 1, 1, 1, 1 };
    try common.testIntrinsic("vabal_high_u8", vabal_high_u8, expected, .{ acc, a, b }, null);
}

/// Unsigned Absolute difference and Accumulate Long
pub inline fn vabal_high_u16(acc: types.u32x4, a: types.u16x8, b: types.u16x8) types.u32x4 {
    return vabdl_high_u16(a, b) +% acc;
}

test vabal_high_u16 {
    const acc: types.u32x4 = @splat(1);
    const a: types.u16x8 = @splat(1);
    const b: types.u16x8 = @splat(1);
    const expected: types.u32x4 = .{ 1, 1, 1, 1 };
    try common.testIntrinsic("vabal_high_u16", vabal_high_u16, expected, .{ acc, a, b }, null);
}

/// Unsigned Absolute difference and Accumulate Long
pub inline fn vabal_high_u32(acc: types.u64x2, a: types.u32x4, b: types.u32x4) types.u64x2 {
    return vabdl_high_u32(a, b) +% acc;
}

test vabal_high_u32 {
    const acc: types.u64x2 = @splat(1);
    const a: types.u32x4 = @splat(1);
    const b: types.u32x4 = @splat(1);
    const expected: types.u64x2 = .{ 1, 1 };
    try common.testIntrinsic("vabal_high_u32", vabal_high_u32, expected, .{ acc, a, b }, null);
}

/// Floating-point absolute difference
pub inline fn vabdd_f64(a: f64, b: f64) f64 {
    return @abs(a - b);
}

test vabdd_f64 {
    const a: f64 = 1.0;
    const b: f64 = 1.0;
    const expected: f64 = 0.0;
    try common.testIntrinsic("vabdd_f64", vabdd_f64, expected, .{ a, b }, null);
}

/// Signed Absolute difference Long
pub inline fn vabdl_s8(a: types.i8x8, b: types.i8x8) types.i16x8 {
    return common.abdGeneric(a, b);
}

test vabdl_s8 {
    const a: types.i8x8 = .{ 1, 2, 3, 4, 5, 6, 7, 8 };
    const b: types.i8x8 = .{ 16, 15, 14, 13, 12, 11, 10, 9 };

    const expected: types.i16x8 = .{ 15, 13, 11, 9, 7, 5, 3, 1 };

    try expectEqual(expected, vabdl_s8(a, b));
}

/// Signed Absolute difference Long
pub inline fn vabdl_s16(a: types.i16x4, b: types.i16x4) types.i32x4 {
    return common.abdGeneric(a, b);
}

test vabdl_s16 {
    const a: types.i16x4 = .{ 1, 2, 3, 4 };
    const b: types.i16x4 = .{ 16, 15, 14, 13 };

    const expected: types.i32x4 = .{ 15, 13, 11, 9 };

    try expectEqual(expected, vabdl_s16(a, b));
}

/// Signed Absolute difference Long
pub inline fn vabdl_s32(a: types.i32x2, b: types.i32x2) types.i64x2 {
    return common.abdGeneric(a, b);
}

test vabdl_s32 {
    const a: types.i32x2 = .{ 1, 2 };
    const b: types.i32x2 = .{ 16, 15 };

    const expected: types.i64x2 = .{ 15, 13 };

    try expectEqual(expected, vabdl_s32(a, b));
}

/// Unsigned Absolute difference Long
pub inline fn vabdl_u8(a: types.u8x8, b: types.u8x8) types.u16x8 {
    return common.abdGeneric(a, b);
}

test vabdl_u8 {
    {
        const a: types.u8x8 = .{ 1, 2, 3, 4, 5, 6, 7, 8 };
        const b: types.u8x8 = .{ 16, 15, 14, 13, 12, 11, 10, 9 };
        const expected: types.u16x8 = .{ 15, 13, 11, 9, 7, 5, 3, 1 };

        try expectEqual(expected, vabdl_u8(a, b));
    }
    {
        const a: types.u8x8 = .{ 10, 10, 10, 10, 10, 10, 10, 10 };
        const b: types.u8x8 = .{ 10, 10, 10, 10, 10, 10, 10, 10 };
        const expected: types.u16x8 = .{ 0, 0, 0, 0, 0, 0, 0, 0 };

        try expectEqual(expected, vabdl_u8(a, b));
    }
    {
        const a: types.u8x8 = .{ 16, 15, 14, 13, 12, 11, 10, 9 };
        const b: types.u8x8 = .{ 1, 2, 3, 4, 5, 6, 7, 8 };
        const expected: types.u16x8 = .{ 15, 13, 11, 9, 7, 5, 3, 1 };

        try expectEqual(expected, vabd_u8(a, b));
    }
    {
        const a: types.u8x8 = .{ 0, 255, 128, 64, 32, 16, 8, 4 };
        const b: types.u8x8 = .{ 255, 0, 64, 128, 16, 32, 4, 8 };
        const expected: types.u16x8 = .{ 255, 255, 64, 64, 16, 16, 4, 4 };

        try expectEqual(expected, vabd_u8(a, b));
    }
    {
        const a: types.u8x8 = .{ 0, 0, 0, 0, 0, 0, 0, 0 };
        const b: types.u8x8 = .{ 0, 0, 0, 0, 0, 0, 0, 0 };
        const expected: types.u16x8 = .{ 0, 0, 0, 0, 0, 0, 0, 0 };

        try expectEqual(expected, vabdl_u8(a, b));
    }
}

/// Unsigned Absolute difference Long
pub inline fn vabdl_u16(a: types.u16x4, b: types.u16x4) types.u32x4 {
    return common.abdGeneric(a, b);
}

test vabdl_u16 {
    const a: types.u16x4 = .{ 1, 2, 3, 4 };
    const b: types.u16x4 = .{ 16, 15, 14, 13 };

    const expected: types.u32x4 = .{ 15, 13, 11, 9 };

    try expectEqual(expected, vabdl_u16(a, b));
}

/// Unsigned Absolute difference Long
pub inline fn vabdl_u32(a: types.u32x2, b: types.u32x2) types.u64x2 {
    return common.abdGeneric(a, b);
}

test vabdl_u32 {
    const a: types.u32x2 = .{ 1, 2 };
    const b: types.u32x2 = .{ 16, 15 };

    const expected: types.u64x2 = .{ 15, 13 };

    try expectEqual(expected, vabdl_u32(a, b));
}

/// Signed Absolute difference Long
pub inline fn vabdl_high_s8(a: types.i8x16, b: types.i8x16) types.i16x8 {
    return common.abdGeneric(permute.vget_high_s8(a), permute.vget_high_s8(b));
}

test vabdl_high_s8 {
    const a: types.i8x16 = @splat(1);
    const b: types.i8x16 = @splat(1);
    const expected: types.i16x8 = @splat(0);
    try common.testIntrinsic("vabdl_high_s8", vabdl_high_s8, expected, .{ a, b }, null);
}

/// Signed Absolute difference Long
pub inline fn vabdl_high_s16(a: types.i16x8, b: types.i16x8) types.i32x4 {
    return common.abdGeneric(permute.vget_high_s16(a), permute.vget_high_s16(b));
}

test vabdl_high_s16 {
    const a: types.i16x8 = @splat(1);
    const b: types.i16x8 = @splat(1);
    const expected: types.i32x4 = @splat(0);
    try common.testIntrinsic("vabdl_high_s16", vabdl_high_s16, expected, .{ a, b }, null);
}

/// Signed Absolute difference Long
pub inline fn vabdl_high_s32(a: types.i32x4, b: types.i32x4) types.i64x2 {
    return common.abdGeneric(permute.vget_high_s32(a), permute.vget_high_s32(b));
}

test vabdl_high_s32 {
    const a: types.i32x4 = @splat(1);
    const b: types.i32x4 = @splat(1);
    const expected: types.i64x2 = @splat(0);
    try common.testIntrinsic("vabdl_high_s32", vabdl_high_s32, expected, .{ a, b }, null);
}

/// Unsigned Absolute difference Long
pub inline fn vabdl_high_u8(a: types.u8x16, b: types.u8x16) types.u16x8 {
    return common.abdGeneric(permute.vget_high_u8(a), permute.vget_high_u8(b));
}

test vabdl_high_u8 {
    const a: types.u8x16 = @splat(1);
    const b: types.u8x16 = @splat(1);
    const expected: types.u16x8 = @splat(0);
    try common.testIntrinsic("vabdl_high_u8", vabdl_high_u8, expected, .{ a, b }, null);
}

/// Unsigned Absolute difference Long
pub inline fn vabdl_high_u16(a: types.u16x8, b: types.u16x8) types.u32x4 {
    return common.abdGeneric(permute.vget_high_u16(a), permute.vget_high_u16(b));
}

test vabdl_high_u16 {
    const a: types.u16x8 = @splat(1);
    const b: types.u16x8 = @splat(1);
    const expected: types.u32x4 = @splat(0);
    try common.testIntrinsic("vabdl_high_u16", vabdl_high_u16, expected, .{ a, b }, null);
}

/// Unsigned Absolute difference Long
pub inline fn vabdl_high_u32(a: types.u32x4, b: types.u32x4) types.u64x2 {
    return common.abdGeneric(permute.vget_high_u32(a), permute.vget_high_u32(b));
}

test vabdl_high_u32 {
    const a: types.u32x4 = @splat(1);
    const b: types.u32x4 = @splat(1);
    const expected: types.u64x2 = @splat(0);
    try common.testIntrinsic("vabdl_high_u32", vabdl_high_u32, expected, .{ a, b }, null);
}

/// Floating-point absolute difference
pub inline fn vabds_f32(a: f32, b: f32) f32 {
    return @abs(a - b);
}

test vabds_f32 {
    const a: f32 = 1.0;
    const b: f32 = 1.0;
    const expected: f32 = 0.0;
    try common.testIntrinsic("vabds_f32", vabds_f32, expected, .{ a, b }, null);
}

/// Absolute value (wrapping)
pub inline fn vabs_s8(a: types.i8x8) types.i8x8 {
    return @bitCast(@abs(a));
}

test vabs_s8 {
    const a: types.i8x8 = @splat(1);
    const expected: types.i8x8 = .{ 1, 1, 1, 1, 1, 1, 1, 1 };
    try common.testIntrinsic("vabs_s8", vabs_s8, expected, .{a}, null);
}

/// Absolute value (wrapping)
pub inline fn vabs_s16(a: types.i16x4) types.i16x4 {
    return @bitCast(@abs(a));
}

test vabs_s16 {
    const a: types.i16x4 = @splat(1);
    const expected: types.i16x4 = .{ 1, 1, 1, 1 };
    try common.testIntrinsic("vabs_s16", vabs_s16, expected, .{a}, null);
}

/// Absolute value (wrapping)
pub inline fn vabs_s32(a: types.i32x2) types.i32x2 {
    return @bitCast(@abs(a));
}

test vabs_s32 {
    const a: types.i32x2 = @splat(1);
    const expected: types.i32x2 = .{ 1, 1 };
    try common.testIntrinsic("vabs_s32", vabs_s32, expected, .{a}, null);
}

/// Absolute value (wrapping)
pub inline fn vabs_s64(a: types.i64x1) types.i64x1 {
    return @bitCast(@abs(a));
}

test vabs_s64 {
    const a: types.i64x1 = @splat(1);
    const expected: types.i64x1 = .{1};
    try common.testIntrinsic("vabs_s64", vabs_s64, expected, .{a}, null);
}

/// Absolute value (wrapping)
pub inline fn vabs_f32(a: types.f32x2) types.f32x2 {
    return @bitCast(@abs(a));
}

test vabs_f32 {
    const a: types.f32x2 = @splat(1.0);
    const expected: types.f32x2 = .{ 1, 1 };
    try common.testIntrinsic("vabs_f32", vabs_f32, expected, .{a}, null);
}

/// Absolute value (wrapping)
pub inline fn vabs_f64(a: types.f64x1) types.f64x1 {
    return @bitCast(@abs(a));
}

test vabs_f64 {
    const a: types.f64x1 = @splat(1.0);
    const expected: types.f64x1 = .{1};
    try common.testIntrinsic("vabs_f64", vabs_f64, expected, .{a}, null);
}

/// Absolute value (wrapping)
pub inline fn vabsd_s64(a: i64) i64 {
    return @bitCast(@abs(a));
}

test vabsd_s64 {
    const a: i64 = 1;
    const expected: i64 = 1;
    try common.testIntrinsic("vabsd_s64", vabsd_s64, expected, .{a}, null);
}

/// Absolute value (wrapping)
pub inline fn vabsq_s8(a: types.i8x16) types.i8x16 {
    return @bitCast(@abs(a));
}

test vabsq_s8 {
    const a: types.i8x16 = @splat(1);
    const expected: types.i8x16 = .{ 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 };
    try common.testIntrinsic("vabsq_s8", vabsq_s8, expected, .{a}, null);
}

/// Absolute value (wrapping)
pub inline fn vabsq_s16(a: types.i16x8) types.i16x8 {
    return @bitCast(@abs(a));
}

test vabsq_s16 {
    const a: types.i16x8 = @splat(1);
    const expected: types.i16x8 = .{ 1, 1, 1, 1, 1, 1, 1, 1 };
    try common.testIntrinsic("vabsq_s16", vabsq_s16, expected, .{a}, null);
}

/// Absolute value (wrapping)
pub inline fn vabsq_s32(a: types.i32x4) types.i32x4 {
    return @bitCast(@abs(a));
}

test vabsq_s32 {
    const a: types.i32x4 = @splat(1);
    const expected: types.i32x4 = .{ 1, 1, 1, 1 };
    try common.testIntrinsic("vabsq_s32", vabsq_s32, expected, .{a}, null);
}

/// Absolute value (wrapping)
pub inline fn vabsq_s64(a: types.i64x2) types.i64x2 {
    return @bitCast(@abs(a));
}

test vabsq_s64 {
    const a: types.i64x2 = @splat(1);
    const expected: types.i64x2 = .{ 1, 1 };
    try common.testIntrinsic("vabsq_s64", vabsq_s64, expected, .{a}, null);
}

/// Absolute value (wrapping)
pub inline fn vabsq_f32(a: types.f32x4) types.f32x4 {
    return @bitCast(@abs(a));
}

test vabsq_f32 {
    const a: types.f32x4 = @splat(1.0);
    const expected: types.f32x4 = .{ 1, 1, 1, 1 };
    try common.testIntrinsic("vabsq_f32", vabsq_f32, expected, .{a}, null);
}

/// Absolute value (wrapping)
pub inline fn vabsq_f64(a: types.f64x2) types.f64x2 {
    return @bitCast(@abs(a));
}

test vabsq_f64 {
    const a: types.f64x2 = @splat(1.0);
    const expected: types.f64x2 = .{ 1, 1 };
    try common.testIntrinsic("vabsq_f64", vabsq_f64, expected, .{a}, null);
}

/// Vector add (wrapping)
pub inline fn vadd_s8(a: types.i8x8, b: types.i8x8) types.i8x8 {
    return a +% b;
}

test vadd_s8 {
    const a: types.i8x8 = @splat(1);
    const b: types.i8x8 = @splat(1);
    const expected: types.i8x8 = .{ 2, 2, 2, 2, 2, 2, 2, 2 };
    try common.testIntrinsic("vadd_s8", vadd_s8, expected, .{ a, b }, null);
}

/// Vector add (wrapping)
pub inline fn vadd_s16(a: types.i16x4, b: types.i16x4) types.i16x4 {
    return a +% b;
}

test vadd_s16 {
    const a: types.i16x4 = @splat(1);
    const b: types.i16x4 = @splat(1);
    const expected: types.i16x4 = .{ 2, 2, 2, 2 };
    try common.testIntrinsic("vadd_s16", vadd_s16, expected, .{ a, b }, null);
}

/// Vector add (wrapping)
pub inline fn vadd_s32(a: types.i32x2, b: types.i32x2) types.i32x2 {
    return a +% b;
}

test vadd_s32 {
    const a: types.i32x2 = @splat(1);
    const b: types.i32x2 = @splat(1);
    const expected: types.i32x2 = .{ 2, 2 };
    try common.testIntrinsic("vadd_s32", vadd_s32, expected, .{ a, b }, null);
}

/// Vector add (wrapping)
pub inline fn vadd_s64(a: types.i64x1, b: types.i64x1) types.i64x1 {
    return a +% b;
}

test vadd_s64 {
    const a: types.i64x1 = @splat(1);
    const b: types.i64x1 = @splat(1);
    const expected: types.i64x1 = .{2};
    try common.testIntrinsic("vadd_s64", vadd_s64, expected, .{ a, b }, null);
}

/// Vector add (wrapping)
pub inline fn vadd_f32(a: types.f32x2, b: types.f32x2) types.f32x2 {
    return a + b;
}

test vadd_f32 {
    const a: types.f32x2 = @splat(1.0);
    const b: types.f32x2 = @splat(1.0);
    const expected: types.f32x2 = .{ 2, 2 };
    try common.testIntrinsic("vadd_f32", vadd_f32, expected, .{ a, b }, null);
}

/// Vector add (wrapping)
pub inline fn vadd_f64(a: types.f64x2, b: types.f64x2) types.f64x2 {
    return a + b;
}

test vadd_f64 {
    const a: types.f64x2 = @splat(1.0);
    const b: types.f64x2 = @splat(1.0);
    const expected: types.f64x2 = .{ 2, 2 };
    try common.testIntrinsic("vadd_f64", vadd_f64, expected, .{ a, b }, null);
}

/// Vector add (wrapping)
pub inline fn vadd_u8(a: types.u8x8, b: types.u8x8) types.u8x8 {
    return a +% b;
}

test vadd_u8 {
    const a: types.u8x8 = @splat(1);
    const b: types.u8x8 = @splat(1);
    const expected: types.u8x8 = .{ 2, 2, 2, 2, 2, 2, 2, 2 };
    try common.testIntrinsic("vadd_u8", vadd_u8, expected, .{ a, b }, null);
}

/// Vector add (wrapping)
pub inline fn vadd_u16(a: types.u16x4, b: types.u16x4) types.u16x4 {
    return a +% b;
}

test vadd_u16 {
    const a: types.u16x4 = @splat(1);
    const b: types.u16x4 = @splat(1);
    const expected: types.u16x4 = .{ 2, 2, 2, 2 };
    try common.testIntrinsic("vadd_u16", vadd_u16, expected, .{ a, b }, null);
}

/// Vector add (wrapping)
pub inline fn vadd_u32(a: types.u32x2, b: types.u32x2) types.u32x2 {
    return a +% b;
}

test vadd_u32 {
    const a: types.u32x2 = @splat(1);
    const b: types.u32x2 = @splat(1);
    const expected: types.u32x2 = .{ 2, 2 };
    try common.testIntrinsic("vadd_u32", vadd_u32, expected, .{ a, b }, null);
}

/// Vector add (wrapping)
pub inline fn vadd_u64(a: types.u64x1, b: types.u64x1) types.u64x1 {
    return a +% b;
}

test vadd_u64 {
    const a: types.u64x1 = @splat(1);
    const b: types.u64x1 = @splat(1);
    const expected: types.u64x1 = .{2};
    try common.testIntrinsic("vadd_u64", vadd_u64, expected, .{ a, b }, null);
}

/// Vector add (wrapping)
pub inline fn vadd_p8(a: types.p8x8, b: types.p8x8) types.p8x8 {
    return a +% b;
}

test vadd_p8 {
    const a: types.p8x8 = @splat(1);
    const b: types.p8x8 = @splat(1);
    const expected: types.p8x8 = .{ 2, 2, 2, 2, 2, 2, 2, 2 };
    try common.testIntrinsic("vadd_p8", vadd_p8, expected, .{ a, b }, null);
}

/// Vector add (wrapping)
pub inline fn vadd_p16(a: types.p16x4, b: types.p16x4) types.p16x4 {
    return a +% b;
}

test vadd_p16 {
    const a: types.p16x4 = @splat(1);
    const b: types.p16x4 = @splat(1);
    const expected: types.p16x4 = .{ 2, 2, 2, 2 };
    try common.testIntrinsic("vadd_p16", vadd_p16, expected, .{ a, b }, null);
}

/// Vector add (wrapping)
pub inline fn vadd_p64(a: types.p64x1, b: types.p64x1) types.p64x1 {
    return a +% b;
}

test vadd_p64 {
    const a: types.p64x1 = @splat(1);
    const b: types.p64x1 = @splat(1);
    const expected: types.p64x1 = .{2};
    try common.testIntrinsic("vadd_p64", vadd_p64, expected, .{ a, b }, null);
}

/// Vector add (wrapping)
pub inline fn vaddq_s8(a: types.i8x16, b: types.i8x16) types.i8x16 {
    return a +% b;
}

test vaddq_s8 {
    const a: types.i8x16 = @splat(1);
    const b: types.i8x16 = @splat(1);
    const expected: types.i8x16 = .{ 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2 };
    try common.testIntrinsic("vaddq_s8", vaddq_s8, expected, .{ a, b }, null);
}

/// Vector add (wrapping)
pub inline fn vaddq_s16(a: types.i16x8, b: types.i16x8) types.i16x8 {
    return a +% b;
}

test vaddq_s16 {
    const a: types.i16x8 = @splat(1);
    const b: types.i16x8 = @splat(1);
    const expected: types.i16x8 = .{ 2, 2, 2, 2, 2, 2, 2, 2 };
    try common.testIntrinsic("vaddq_s16", vaddq_s16, expected, .{ a, b }, null);
}

/// Vector add (wrapping)
pub inline fn vaddq_s32(a: types.i32x4, b: types.i32x4) types.i32x4 {
    return a +% b;
}

test vaddq_s32 {
    const a: types.i32x4 = @splat(1);
    const b: types.i32x4 = @splat(1);
    const expected: types.i32x4 = .{ 2, 2, 2, 2 };
    try common.testIntrinsic("vaddq_s32", vaddq_s32, expected, .{ a, b }, null);
}

/// Vector add (wrapping)
pub inline fn vaddq_s64(a: types.i64x2, b: types.i64x2) types.i64x2 {
    return a +% b;
}

test vaddq_s64 {
    const a: types.i64x2 = @splat(1);
    const b: types.i64x2 = @splat(1);
    const expected: types.i64x2 = .{ 2, 2 };
    try common.testIntrinsic("vaddq_s64", vaddq_s64, expected, .{ a, b }, null);
}

/// Vector add (wrapping)
pub inline fn vaddq_f32(a: types.f32x4, b: types.f32x4) types.f32x4 {
    return a + b;
}

test vaddq_f32 {
    const a: types.f32x4 = @splat(1.0);
    const b: types.f32x4 = @splat(1.0);
    const expected: types.f32x4 = .{ 2, 2, 2, 2 };
    try common.testIntrinsic("vaddq_f32", vaddq_f32, expected, .{ a, b }, null);
}

/// Vector add (wrapping)
pub inline fn vaddq_f64(a: types.f64x2, b: types.f64x2) types.f64x2 {
    return a + b;
}

test vaddq_f64 {
    const a: types.f64x2 = @splat(1.0);
    const b: types.f64x2 = @splat(1.0);
    const expected: types.f64x2 = .{ 2, 2 };
    try common.testIntrinsic("vaddq_f64", vaddq_f64, expected, .{ a, b }, null);
}

/// Vector add (wrapping)
pub inline fn vaddq_u8(a: types.u8x16, b: types.u8x16) types.u8x16 {
    return a +% b;
}

test vaddq_u8 {
    const a: types.u8x16 = @splat(1);
    const b: types.u8x16 = @splat(1);
    const expected: types.u8x16 = .{ 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2 };
    try common.testIntrinsic("vaddq_u8", vaddq_u8, expected, .{ a, b }, null);
}

/// Vector add (wrapping)
pub inline fn vaddq_u16(a: types.u16x8, b: types.u16x8) types.u16x8 {
    return a +% b;
}

test vaddq_u16 {
    const a: types.u16x8 = @splat(1);
    const b: types.u16x8 = @splat(1);
    const expected: types.u16x8 = .{ 2, 2, 2, 2, 2, 2, 2, 2 };
    try common.testIntrinsic("vaddq_u16", vaddq_u16, expected, .{ a, b }, null);
}

/// Vector add (wrapping)
pub inline fn vaddq_u32(a: types.u32x4, b: types.u32x4) types.u32x4 {
    return a +% b;
}

test vaddq_u32 {
    const a: types.u32x4 = @splat(1);
    const b: types.u32x4 = @splat(1);
    const expected: types.u32x4 = .{ 2, 2, 2, 2 };
    try common.testIntrinsic("vaddq_u32", vaddq_u32, expected, .{ a, b }, null);
}

/// Vector add (wrapping)
pub inline fn vaddq_u64(a: types.u64x2, b: types.u64x2) types.u64x2 {
    return a +% b;
}

test vaddq_u64 {
    const a: types.u64x2 = @splat(1);
    const b: types.u64x2 = @splat(1);
    const expected: types.u64x2 = .{ 2, 2 };
    try common.testIntrinsic("vaddq_u64", vaddq_u64, expected, .{ a, b }, null);
}

/// Bitwise exclusive OR
pub inline fn vaddq_p8(a: types.p8x16, b: types.p8x16) types.p8x16 {
    return a ^ b;
}

test vaddq_p8 {
    const a: types.p8x16 = @splat(1);
    const b: types.p8x16 = @splat(1);
    const expected: types.p8x16 = @splat(0);
    try common.testIntrinsic("vaddq_p8", vaddq_p8, expected, .{ a, b }, null);
}

/// Bitwise exclusive OR
pub inline fn vaddq_p16(a: types.p16x8, b: types.p16x8) types.p16x8 {
    return a ^ b;
}

test vaddq_p16 {
    const a: types.p16x8 = @splat(1);
    const b: types.p16x8 = @splat(1);
    const expected: types.p16x8 = @splat(0);
    try common.testIntrinsic("vaddq_p16", vaddq_p16, expected, .{ a, b }, null);
}

/// Bitwise exclusive OR
pub inline fn vaddq_p64(a: types.p64x2, b: types.p64x2) types.p64x2 {
    return a ^ b;
}

test vaddq_p64 {
    const a: types.p64x2 = @splat(1);
    const b: types.p64x2 = @splat(1);
    const expected: types.p64x2 = @splat(0);
    try common.testIntrinsic("vaddq_p64", vaddq_p64, expected, .{ a, b }, null);
}

/// Bitwise exclusive OR
pub inline fn vaddq_p128(a: types.p128, b: types.p128) types.p128 {
    return a ^ b;
}

test vaddq_p128 {
    const a: types.p128 = 0;
    const b: types.p128 = 0;
    const expected: types.p128 = 0;
    try common.testIntrinsic("vaddq_p128", vaddq_p128, expected, .{ a, b }, null);
}

/// Add (wrapping)
pub inline fn vaddd_s64(a: i64, b: i64) i64 {
    return a +% b;
}

test vaddd_s64 {
    const a: i64 = 1;
    const b: i64 = 1;
    const expected: i64 = 2;
    try common.testIntrinsic("vaddd_s64", vaddd_s64, expected, .{ a, b }, null);
}

/// Add (wrapping)
pub inline fn vaddd_u64(a: u64, b: u64) u64 {
    return a +% b;
}

test vaddd_u64 {
    const a: u64 = 1;
    const b: u64 = 1;
    const expected: u64 = 2;
    try common.testIntrinsic("vaddd_u64", vaddd_u64, expected, .{ a, b }, null);
}

/// Add returning High Narrow
pub inline fn vaddhn_s16(a: types.i16x8, b: types.i16x8) types.i8x8 {
    const sum: types.i16x8 = a +% b;
    return @truncate(shift.vshrq_n_s16(sum, 8));
}

test vaddhn_s16 {
    {
        const a: types.i16x8 = .{ 256, 512, 1024, 2048, 4096, 8192, 16384, 32767 };
        const b: types.i16x8 = .{ 128, 256, 512, 1024, 2048, 4096, 8192, 32767 };
        const expected: types.i8x8 = .{ 1, 3, 6, 12, 24, 48, 96, -1 }; // -1 due to wrapping

        try expectEqual(expected, vaddhn_s16(a, b));
    }
    {
        const a: types.i16x8 = .{ -256, -512, -1024, -2048, -4096, -8192, -16384, -32768 };
        const b: types.i16x8 = .{ -128, -256, -512, -1024, -2048, -4096, -8192, -32768 };
        const expected: types.i8x8 = .{ -2, -3, -6, -12, -24, -48, -96, 0 };

        try expectEqual(expected, vaddhn_s16(a, b));
    }
    {
        const a: types.i16x8 = .{ 0, 0, 0, 0, 0, 0, 0, 0 };
        const b: types.i16x8 = .{ 0, 0, 0, 0, 0, 0, 0, 0 };
        const expected: types.i8x8 = .{ 0, 0, 0, 0, 0, 0, 0, 0 };

        try expectEqual(expected, vaddhn_s16(a, b));
    }
}

/// Add returning High Narrow
pub inline fn vaddhn_s32(a: types.i32x4, b: types.i32x4) types.i16x4 {
    const sum: types.i32x4 = a +% b;
    return @truncate(shift.vshrq_n_s32(sum, 16));
}

test vaddhn_s32 {
    const a: types.i32x4 = @splat(1);
    const b: types.i32x4 = @splat(1);
    const expected: types.i16x4 = @splat(0);
    try common.testIntrinsic("vaddhn_s32", vaddhn_s32, expected, .{ a, b }, null);
}

/// Add returning High Narrow
pub inline fn vaddhn_s64(a: types.i64x2, b: types.i64x2) types.i32x2 {
    const sum: types.i64x2 = a +% b;
    return @truncate(shift.vshrq_n_s64(sum, 32));
}

test vaddhn_s64 {
    const a: types.i64x2 = @splat(1);
    const b: types.i64x2 = @splat(1);
    const expected: types.i32x2 = @splat(0);
    try common.testIntrinsic("vaddhn_s64", vaddhn_s64, expected, .{ a, b }, null);
}

/// Add returning High Narrow
pub inline fn vaddhn_u16(a: types.u16x8, b: types.u16x8) types.u8x8 {
    const sum: types.u16x8 = a +% b;
    return @truncate(shift.vshrq_n_u16(sum, 8));
}

test vaddhn_u16 {
    const a: types.u16x8 = @splat(1);
    const b: types.u16x8 = @splat(1);
    const expected: types.u8x8 = @splat(0);
    try common.testIntrinsic("vaddhn_u16", vaddhn_u16, expected, .{ a, b }, null);
}

/// Add returning High Narrow
pub inline fn vaddhn_u32(a: types.u32x4, b: types.u32x4) types.u16x4 {
    const sum: types.u32x4 = a +% b;
    return @truncate(shift.vshrq_n_u32(sum, 16));
}

test vaddhn_u32 {
    const a: types.u32x4 = @splat(1);
    const b: types.u32x4 = @splat(1);
    const expected: types.u16x4 = @splat(0);
    try common.testIntrinsic("vaddhn_u32", vaddhn_u32, expected, .{ a, b }, null);
}

/// Add returning High Narrow
pub inline fn vaddhn_u64(a: types.u64x2, b: types.u64x2) types.u32x2 {
    const sum: types.u64x2 = a +% b;
    return @truncate(shift.vshrq_n_u64(sum, 32));
}

test vaddhn_u64 {
    const a: types.u64x2 = @splat(1);
    const b: types.u64x2 = @splat(1);
    const expected: types.u32x2 = @splat(0);
    try common.testIntrinsic("vaddhn_u64", vaddhn_u64, expected, .{ a, b }, null);
}

/// Add returning High Narrow (high half)
pub inline fn vaddhn_high_s16(a: types.i8x8, b: types.i16x8, c: types.i16x8) types.i8x16 {
    return common.join(
        a,
        vaddhn_s16(b, c),
    );
}

test vaddhn_high_s16 {
    const a: types.i8x8 = @splat(42);
    const b: types.i16x8 = .{ (0 << 8) + 1, (1 << 8) + 1, (2 << 8) + 1, (3 << 8) + 1, (4 << 8) + 1, (5 << 8) + 1, (6 << 8) + 1, (7 << 8) + 1 };
    const expected: types.i8x16 = .{ 42, 42, 42, 42, 42, 42, 42, 42, 0, 2, 4, 6, 8, 10, 12, 14 };

    try expectEqual(expected, vaddhn_high_s16(a, b, b));
}

/// Add returning High Narrow (high half)
pub inline fn vaddhn_high_s32(a: types.i16x4, b: types.i32x4, c: types.i32x4) types.i16x8 {
    return common.join(
        a,
        vaddhn_s32(b, c),
    );
}

test vaddhn_high_s32 {
    const a: types.i16x4 = @splat(1);
    const b: types.i32x4 = @splat(1);
    const c: types.i32x4 = @splat(1);
    const expected: types.i16x8 = .{ 1, 1, 1, 1, 0, 0, 0, 0 };
    try common.testIntrinsic("vaddhn_high_s32", vaddhn_high_s32, expected, .{ a, b, c }, null);
}

/// Add returning High Narrow (high half)
pub inline fn vaddhn_high_s64(a: types.i32x2, b: types.i64x2, c: types.i64x2) types.i32x4 {
    return common.join(
        a,
        vaddhn_s64(b, c),
    );
}

test vaddhn_high_s64 {
    const a: types.i32x2 = @splat(1);
    const b: types.i64x2 = @splat(1);
    const c: types.i64x2 = @splat(1);
    const expected: types.i32x4 = .{ 1, 1, 0, 0 };
    try common.testIntrinsic("vaddhn_high_s64", vaddhn_high_s64, expected, .{ a, b, c }, null);
}

/// Add returning High Narrow (high half)
pub inline fn vaddhn_high_u16(a: types.u8x8, b: types.u16x8, c: types.u16x8) types.u8x16 {
    return common.join(
        a,
        vaddhn_u16(b, c),
    );
}

test vaddhn_high_u16 {
    const a: types.u8x8 = @splat(42);
    const b: types.u16x8 = .{ (0 << 8) + 1, (1 << 8) + 1, (2 << 8) + 1, (3 << 8) + 1, (4 << 8) + 1, (5 << 8) + 1, (6 << 8) + 1, (7 << 8) + 1 };
    const expected: types.u8x16 = .{ 42, 42, 42, 42, 42, 42, 42, 42, 0, 2, 4, 6, 8, 10, 12, 14 };

    try expectEqual(expected, vaddhn_high_u16(a, b, b));
}

/// Add returning High Narrow (high half)
pub inline fn vaddhn_high_u32(a: types.u16x4, b: types.u32x4, c: types.u32x4) types.u16x8 {
    return common.join(
        a,
        vaddhn_u32(b, c),
    );
}

test vaddhn_high_u32 {
    const a: types.u16x4 = @splat(1);
    const b: types.u32x4 = @splat(1);
    const c: types.u32x4 = @splat(1);
    const expected: types.u16x8 = .{ 1, 1, 1, 1, 0, 0, 0, 0 };
    try common.testIntrinsic("vaddhn_high_u32", vaddhn_high_u32, expected, .{ a, b, c }, null);
}

/// Add returning High Narrow (high half)
pub inline fn vaddhn_high_u64(a: types.u32x2, b: types.u64x2, c: types.u64x2) types.u32x4 {
    return common.join(
        a,
        vaddhn_u64(b, c),
    );
}

test vaddhn_high_u64 {
    const a: types.u32x2 = @splat(1);
    const b: types.u64x2 = @splat(1);
    const c: types.u64x2 = @splat(1);
    const expected: types.u32x4 = .{ 1, 1, 0, 0 };
    try common.testIntrinsic("vaddhn_high_u64", vaddhn_high_u64, expected, .{ a, b, c }, null);
}

/// Signed Add Long
pub inline fn vaddl_s8(a: types.i8x8, b: types.i8x8) types.i16x8 {
    return convert.vmovl_s8(a) + convert.vmovl_s8(b);
}

test vaddl_s8 {
    const a: types.i8x8 = @splat(1);
    const b: types.i8x8 = @splat(1);
    const expected: types.i16x8 = .{ 2, 2, 2, 2, 2, 2, 2, 2 };
    try common.testIntrinsic("vaddl_s8", vaddl_s8, expected, .{ a, b }, null);
}

/// Signed Add Long
pub inline fn vaddl_s16(a: types.i16x4, b: types.i16x4) types.i32x4 {
    return convert.vmovl_s16(a) + convert.vmovl_s16(b);
}

test vaddl_s16 {
    const a: types.i16x4 = @splat(1);
    const b: types.i16x4 = @splat(1);
    const expected: types.i32x4 = .{ 2, 2, 2, 2 };
    try common.testIntrinsic("vaddl_s16", vaddl_s16, expected, .{ a, b }, null);
}

/// Signed Add Long
pub inline fn vaddl_s32(a: types.i32x2, b: types.i32x2) types.i64x2 {
    return convert.vmovl_s32(a) + convert.vmovl_s32(b);
}

test vaddl_s32 {
    const a: types.i32x2 = @splat(1);
    const b: types.i32x2 = @splat(1);
    const expected: types.i64x2 = .{ 2, 2 };
    try common.testIntrinsic("vaddl_s32", vaddl_s32, expected, .{ a, b }, null);
}

/// Unsigned Add Long
pub inline fn vaddl_u8(a: types.u8x8, b: types.u8x8) types.u16x8 {
    return convert.vmovl_u8(a) + convert.vmovl_u8(b);
}

test vaddl_u8 {
    const a: types.u8x8 = @splat(1);
    const b: types.u8x8 = @splat(1);
    const expected: types.u16x8 = .{ 2, 2, 2, 2, 2, 2, 2, 2 };
    try common.testIntrinsic("vaddl_u8", vaddl_u8, expected, .{ a, b }, null);
}

/// Unsigned Add Long
pub inline fn vaddl_u16(a: types.u16x4, b: types.u16x4) types.u32x4 {
    return convert.vmovl_u16(a) + convert.vmovl_u16(b);
}

test vaddl_u16 {
    const a: types.u16x4 = @splat(1);
    const b: types.u16x4 = @splat(1);
    const expected: types.u32x4 = .{ 2, 2, 2, 2 };
    try common.testIntrinsic("vaddl_u16", vaddl_u16, expected, .{ a, b }, null);
}

/// Unsigned Add Long
pub inline fn vaddl_u32(a: types.u32x2, b: types.u32x2) types.u64x2 {
    return convert.vmovl_u32(a) + convert.vmovl_u32(b);
}

test vaddl_u32 {
    const a: types.u32x2 = @splat(1);
    const b: types.u32x2 = @splat(1);
    const expected: types.u64x2 = .{ 2, 2 };
    try common.testIntrinsic("vaddl_u32", vaddl_u32, expected, .{ a, b }, null);
}

/// Signed Add Long (high half)
pub inline fn vaddl_high_s8(a: types.i8x16, b: types.i8x16) types.i16x8 {
    return convert.vmovl_high_s8(a) + convert.vmovl_high_s8(b);
}

test vaddl_high_s8 {
    const a: types.i8x16 = @splat(1);
    const b: types.i8x16 = @splat(1);
    const expected: types.i16x8 = .{ 2, 2, 2, 2, 2, 2, 2, 2 };
    try common.testIntrinsic("vaddl_high_s8", vaddl_high_s8, expected, .{ a, b }, null);
}

/// Signed Add Long (high half)
pub inline fn vaddl_high_s16(a: types.i16x8, b: types.i16x8) types.i32x4 {
    return convert.vmovl_high_s16(a) + convert.vmovl_high_s16(b);
}

test vaddl_high_s16 {
    const a: types.i16x8 = @splat(1);
    const b: types.i16x8 = @splat(1);
    const expected: types.i32x4 = .{ 2, 2, 2, 2 };
    try common.testIntrinsic("vaddl_high_s16", vaddl_high_s16, expected, .{ a, b }, null);
}

/// Signed Add Long (high half)
pub inline fn vaddl_high_s32(a: types.i32x4, b: types.i32x4) types.i64x2 {
    return convert.vmovl_high_s32(a) + convert.vmovl_high_s32(b);
}

test vaddl_high_s32 {
    const a: types.i32x4 = @splat(1);
    const b: types.i32x4 = @splat(1);
    const expected: types.i64x2 = .{ 2, 2 };
    try common.testIntrinsic("vaddl_high_s32", vaddl_high_s32, expected, .{ a, b }, null);
}

/// Unsigned Add Long (high half)
pub inline fn vaddl_high_u8(a: types.u8x16, b: types.u8x16) types.u16x8 {
    return convert.vmovl_high_u8(a) + convert.vmovl_high_u8(b);
}

test vaddl_high_u8 {
    const a: types.u8x16 = @splat(1);
    const b: types.u8x16 = @splat(1);
    const expected: types.u16x8 = .{ 2, 2, 2, 2, 2, 2, 2, 2 };
    try common.testIntrinsic("vaddl_high_u8", vaddl_high_u8, expected, .{ a, b }, null);
}

/// Unsigned Add Long (high half)
pub inline fn vaddl_high_u16(a: types.u16x8, b: types.u16x8) types.u32x4 {
    return convert.vmovl_high_u16(a) + convert.vmovl_high_u16(b);
}

test vaddl_high_u16 {
    const a: types.u16x8 = @splat(1);
    const b: types.u16x8 = @splat(1);
    const expected: types.u32x4 = .{ 2, 2, 2, 2 };
    try common.testIntrinsic("vaddl_high_u16", vaddl_high_u16, expected, .{ a, b }, null);
}

/// Unsigned Add Long (high half)
pub inline fn vaddl_high_u32(a: types.u32x4, b: types.u32x4) types.u64x2 {
    return convert.vmovl_high_u32(a) + convert.vmovl_high_u32(b);
}

test vaddl_high_u32 {
    const a: types.u32x4 = @splat(1);
    const b: types.u32x4 = @splat(1);
    const expected: types.u64x2 = .{ 2, 2 };
    try common.testIntrinsic("vaddl_high_u32", vaddl_high_u32, expected, .{ a, b }, null);
}

/// Signed Add Wide
pub inline fn vaddw_s8(a: types.i16x8, b: types.i8x8) types.i16x8 {
    return a +% convert.vmovl_s8(b);
}

test vaddw_s8 {
    {
        const a: types.i16x8 = .{ 1000, 2000, 3000, 4000, -5000, -6000, -7000, -8000 };
        const b: types.i8x8 = .{ 10, 20, -30, -40, 50, 60, -70, 80 };
        const expected: types.i16x8 = .{ 1010, 2020, 2970, 3960, -4950, -5940, -7070, -7920 };

        try expectEqual(expected, vaddw_s8(a, b));
    }
    {
        const a = @Vector(8, i16){ 32760, -32760, 1000, -1000, 2000, -2000, 0, -32768 };
        const b = @Vector(8, i8){ 10, -10, 120, -120, 127, -128, 0, 1 };
        const expected: types.i16x8 = .{
            -32766, // Overflow wraps around to negative
            32766, // Underflow wraps around to positive
            1120, // Normal addition
            -1120, // Normal subtraction
            2127, // Normal addition
            -2128, // Normal subtraction
            0, // No change
            -32767, // Wraps around to next higher value
        };

        try expectEqual(expected, vaddw_s8(a, b));
    }
}

/// Signed Add Wide (high half)
pub inline fn vaddw_high_s8(a: types.i16x8, b: types.i8x16) types.i16x8 {
    return a +% convert.vmovl_high_s8(b);
}

test vaddw_high_s8 {
    const a: types.i16x8 = .{ 32760, -32760, 1000, -1000, 2000, -2000, 0, -32768 };
    const b: types.i8x16 = .{ 1, 2, 3, 4, 5, 6, 7, 8, 10, -10, 120, -120, 127, -128, 0, 1 };
    const expected: types.i16x8 = .{ -32766, 32766, 1120, -1120, 2127, -2128, 0, -32767 };

    try expectEqual(expected, vaddw_high_s8(a, b));
}

/// Signed Add Wide (high half)
pub inline fn vaddw_high_s16(a: types.i32x4, b: types.i16x8) types.i32x4 {
    return a +% convert.vmovl_high_s16(b);
}

test vaddw_high_s16 {
    const a: types.i32x4 = @splat(1);
    const b: types.i16x8 = @splat(1);
    const expected: types.i32x4 = .{ 2, 2, 2, 2 };
    try common.testIntrinsic("vaddw_high_s16", vaddw_high_s16, expected, .{ a, b }, null);
}

/// Signed Add Wide (high half)
pub inline fn vaddw_high_s32(a: types.i64x2, b: types.i32x4) types.i64x2 {
    return a +% convert.vmovl_high_s32(b);
}

test vaddw_high_s32 {
    const a: types.i64x2 = @splat(1);
    const b: types.i32x4 = @splat(1);
    const expected: types.i64x2 = .{ 2, 2 };
    try common.testIntrinsic("vaddw_high_s32", vaddw_high_s32, expected, .{ a, b }, null);
}

/// Unsigned Add Wide (high half)
pub inline fn vaddw_high_u8(a: types.u16x8, b: types.u8x16) types.u16x8 {
    return a +% convert.vmovl_high_u8(b);
}

test vaddw_high_u8 {
    const a: types.u16x8 = @splat(1);
    const b: types.u8x16 = @splat(1);
    const expected: types.u16x8 = .{ 2, 2, 2, 2, 2, 2, 2, 2 };
    try common.testIntrinsic("vaddw_high_u8", vaddw_high_u8, expected, .{ a, b }, null);
}

/// Unsigned Add Wide (high half)
pub inline fn vaddw_high_u16(a: types.u32x4, b: types.u16x8) types.u32x4 {
    return a +% convert.vmovl_high_u16(b);
}

test vaddw_high_u16 {
    const a: types.u32x4 = @splat(1);
    const b: types.u16x8 = @splat(1);
    const expected: types.u32x4 = .{ 2, 2, 2, 2 };
    try common.testIntrinsic("vaddw_high_u16", vaddw_high_u16, expected, .{ a, b }, null);
}

/// Unsigned Add Wide (high half)
pub inline fn vaddw_high_u32(a: types.u64x2, b: types.u32x4) types.u64x2 {
    return a +% convert.vmovl_high_u32(b);
}

test vaddw_high_u32 {
    const a: types.u64x2 = @splat(1);
    const b: types.u32x4 = @splat(1);
    const expected: types.u64x2 = .{ 2, 2 };
    try common.testIntrinsic("vaddw_high_u32", vaddw_high_u32, expected, .{ a, b }, null);
}

/// Signed Add Wide
pub inline fn vaddw_s16(a: types.i32x4, b: types.i16x4) types.i32x4 {
    return a +% convert.vmovl_s16(b);
}

test vaddw_s16 {
    const a: types.i32x4 = @splat(1);
    const b: types.i16x4 = @splat(1);
    const expected: types.i32x4 = .{ 2, 2, 2, 2 };
    try common.testIntrinsic("vaddw_s16", vaddw_s16, expected, .{ a, b }, null);
}

/// Signed Add Wide
pub inline fn vaddw_s32(a: types.i64x2, b: types.i32x2) types.i64x2 {
    return a +% convert.vmovl_s32(b);
}

test vaddw_s32 {
    const a: types.i64x2 = @splat(1);
    const b: types.i32x2 = @splat(1);
    const expected: types.i64x2 = .{ 2, 2 };
    try common.testIntrinsic("vaddw_s32", vaddw_s32, expected, .{ a, b }, null);
}

/// Unsigned Add Wide
pub inline fn vaddw_u8(a: types.u16x8, b: types.u8x8) types.u16x8 {
    return a +% convert.vmovl_u8(b);
}

test vaddw_u8 {
    const a: types.u16x8 = @splat(1);
    const b: types.u8x8 = @splat(1);
    const expected: types.u16x8 = .{ 2, 2, 2, 2, 2, 2, 2, 2 };
    try common.testIntrinsic("vaddw_u8", vaddw_u8, expected, .{ a, b }, null);
}

/// Unsigned Add Wide
pub inline fn vaddw_u16(a: types.u32x4, b: types.u16x4) types.u32x4 {
    return a +% convert.vmovl_u16(b);
}

test vaddw_u16 {
    const a: types.u32x4 = @splat(1);
    const b: types.u16x4 = @splat(1);
    const expected: types.u32x4 = .{ 2, 2, 2, 2 };
    try common.testIntrinsic("vaddw_u16", vaddw_u16, expected, .{ a, b }, null);
}

/// Unsigned Add Wide
pub inline fn vaddw_u32(a: types.u64x2, b: types.u32x2) types.u64x2 {
    return a +% convert.vmovl_u32(b);
}

test vaddw_u32 {
    const a: types.u64x2 = @splat(1);
    const b: types.u32x2 = @splat(1);
    const expected: types.u64x2 = .{ 2, 2 };
    try common.testIntrinsic("vaddw_u32", vaddw_u32, expected, .{ a, b }, null);
}

/// Multiply-add to accumulator
pub inline fn vmlaq_s8(a: types.i8x16, b: types.i8x16, c: types.i8x16) types.i8x16 {
    return a +% (b *% c);
}

test vmlaq_s8 {
    {
        const a: types.i8x16 = .{ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 };
        const b: types.i8x16 = .{ 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2 };
        const c: types.i8x16 = .{ 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3 };
        const expected: types.i8x16 = .{ 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21 };

        try common.testIntrinsic("vmlaq_s8", vmlaq_s8, expected, .{ a, b, c }, null);
    }
    {
        const a: types.i8x16 = .{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 127 };
        const b: types.i8x16 = .{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 };
        const c: types.i8x16 = .{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2 };
        const expected: types.i8x16 = .{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -127 };

        try common.testIntrinsic("vmlaq_s8", vmlaq_s8, expected, .{ a, b, c }, null);
    }
}

/// Multiply-add to accumulator
pub inline fn vmlaq_s16(a: types.i16x8, b: types.i16x8, c: types.i16x8) types.i16x8 {
    return a +% (b *% c);
}

test vmlaq_s16 {
    const a: types.i16x8 = .{ 0, 1, 2, 3, 4, 5, 6, 7 };
    const b: types.i16x8 = .{ 2, 2, 2, 2, 2, 2, 2, 2 };
    const c: types.i16x8 = .{ 3, 3, 3, 3, 3, 3, 3, 3 };
    const expected: types.i16x8 = .{ 6, 7, 8, 9, 10, 11, 12, 13 };

    try common.testIntrinsic("vmlaq_s16", vmlaq_s16, expected, .{ a, b, c }, null);
}

/// Multiply-add to accumulator
pub inline fn vmlaq_s32(a: types.i32x4, b: types.i32x4, c: types.i32x4) types.i32x4 {
    return a +% (b *% c);
}

test vmlaq_s32 {
    const a: types.i32x4 = .{ 0, 1, 2, 3 };
    const b: types.i32x4 = .{ 2, 2, 2, 2 };
    const c: types.i32x4 = .{ 3, 3, 3, 3 };
    const expected: types.i32x4 = .{ 6, 7, 8, 9 };

    try common.testIntrinsic("vmlaq_s32", vmlaq_s32, expected, .{ a, b, c }, null);
}

/// Multiply-add to accumulator
pub inline fn vmlaq_u8(a: types.u8x16, b: types.u8x16, c: types.u8x16) types.u8x16 {
    return a +% (b *% c);
}

test vmlaq_u8 {
    {
        const a: types.u8x16 = .{ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 };
        const b: types.u8x16 = .{ 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2 };
        const c: types.u8x16 = .{ 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3 };
        const expected: types.u8x16 = .{ 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21 };

        try common.testIntrinsic("vmlaq_u8", vmlaq_u8, expected, .{ a, b, c }, null);
    }
    {
        const a: types.u8x16 = .{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 255 };
        const b: types.u8x16 = .{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 };
        const c: types.u8x16 = .{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2 };
        const expected: types.u8x16 = .{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 };

        try common.testIntrinsic("vmlaq_u8", vmlaq_u8, expected, .{ a, b, c }, null);
    }
}

/// Multiply-add to accumulator
pub inline fn vmlaq_u16(a: types.u16x8, b: types.u16x8, c: types.u16x8) types.u16x8 {
    return a +% (b *% c);
}

test vmlaq_u16 {
    const a: types.u16x8 = .{ 0, 1, 2, 3, 4, 5, 6, 7 };
    const b: types.u16x8 = .{ 2, 2, 2, 2, 2, 2, 2, 2 };
    const c: types.u16x8 = .{ 3, 3, 3, 3, 3, 3, 3, 3 };
    const expected: types.u16x8 = .{ 6, 7, 8, 9, 10, 11, 12, 13 };

    try common.testIntrinsic("vmlaq_u16", vmlaq_u16, expected, .{ a, b, c }, null);
}

/// Multiply-add to accumulator
pub inline fn vmlaq_u32(a: types.u32x4, b: types.u32x4, c: types.u32x4) types.u32x4 {
    return a +% (b *% c);
}

test vmlaq_u32 {
    const a: types.u32x4 = .{ 0, 1, 2, 3 };
    const b: types.u32x4 = .{ 2, 2, 2, 2 };
    const c: types.u32x4 = .{ 3, 3, 3, 3 };
    const expected: types.u32x4 = .{ 6, 7, 8, 9 };

    try common.testIntrinsic("vmlaq_u32", vmlaq_u32, expected, .{ a, b, c }, null);
}

/// Multiply-add to accumulator
pub inline fn vmlaq_f32(a: types.f32x4, b: types.f32x4, c: types.f32x4) types.f32x4 {
    return a + (b * c);
}

test vmlaq_f32 {
    const a: types.f32x4 = .{ 0, 1, 2, 3 };
    const b: types.f32x4 = .{ 2, 2, 2, 2 };
    const c: types.f32x4 = .{ 3, 3, 3, 3 };
    const expected: types.f32x4 = .{ 6, 7, 8, 9 };

    try common.testIntrinsic("vmlaq_f32", vmlaq_f32, expected, .{ a, b, c }, null);
}

/// Multiply-add to accumulator
pub inline fn vmlaq_f64(a: types.f64x2, b: types.f64x2, c: types.f64x2) types.f64x2 {
    return a + (b * c);
}

test vmlaq_f64 {
    const a: types.f64x2 = .{ 0, 1 };
    const b: types.f64x2 = .{ 2, 2 };
    const c: types.f64x2 = .{ 3, 3 };
    const expected: types.f64x2 = .{ 6, 7 };

    try common.testIntrinsic("vmlaq_f64", vmlaq_f64, expected, .{ a, b, c }, null);
}

/// Floating-point fused multiply-add to accumulator
pub inline fn vfmaq_f16(a: types.f16x8, b: types.f16x8, c: types.f16x8) types.f16x8 {
    return a + (b * c);
}

test vfmaq_f16 {
    const a: types.f16x8 = .{ 0, 1, 2, 3, 4, 5, 6, 7 };
    const b: types.f16x8 = .{ 2, 2, 2, 2, 2, 2, 2, 2 };
    const c: types.f16x8 = .{ 3, 3, 3, 3, 3, 3, 3, 3 };
    const expected: types.f16x8 = .{ 6, 7, 8, 9, 10, 11, 12, 13 };

    try common.testIntrinsic("vfmaq_f16", vfmaq_f16, expected, .{ a, b, c }, null);
}

/// Floating-point fused multiply-add to accumulator
pub inline fn vfmaq_f32(a: types.f32x4, b: types.f32x4, c: types.f32x4) types.f32x4 {
    return a + (b * c);
}

test vfmaq_f32 {
    const a: types.f32x4 = .{ 0, 1, 2, 3 };
    const b: types.f32x4 = .{ 2, 2, 2, 2 };
    const c: types.f32x4 = .{ 3, 3, 3, 3 };
    const expected: types.f32x4 = .{ 6, 7, 8, 9 };

    try common.testIntrinsic("vfmaq_f32", vfmaq_f32, expected, .{ a, b, c }, null);
}

/// Floating-point fused multiply-add to accumulator
pub inline fn vfmaq_f64(a: types.f64x2, b: types.f64x2, c: types.f64x2) types.f64x2 {
    return a + (b * c);
}

test vfmaq_f64 {
    const a: types.f64x2 = .{ 0, 1 };
    const b: types.f64x2 = .{ 2, 2 };
    const c: types.f64x2 = .{ 3, 3 };
    const expected: types.f64x2 = .{ 6, 7 };

    try common.testIntrinsic("vfmaq_f64", vfmaq_f64, expected, .{ a, b, c }, null);
}

/// Floating-point fused multiply-add to accumulator
pub inline fn vfmaq_laneq_f16(a: types.f16x8, b: types.f16x8, c: types.f16x8, comptime lane: usize) types.f16x8 {
    return vfmaq_f16(a, b, permute.vdupq_n_f16(c[lane]));
}

test vfmaq_laneq_f16 {
    const a: types.f16x8 = .{ 0, 1, 2, 3, 4, 5, 6, 7 };
    const b: types.f16x8 = .{ 2, 2, 2, 2, 2, 2, 2, 2 };
    const c: types.f16x8 = .{ 3, 0, 0, 0, 0, 0, 0, 0 };
    const lane: usize = 0;
    const expected: types.f16x8 = .{ 6, 7, 8, 9, 10, 11, 12, 13 };

    try common.testIntrinsic("vfmaq_laneq_f16", vfmaq_laneq_f16, expected, .{ a, b, c, lane }, null);
}

/// Floating-point fused multiply-add to accumulator
pub inline fn vfmaq_laneq_f32(a: types.f32x4, b: types.f32x4, c: types.f32x4, comptime lane: usize) types.f32x4 {
    return vfmaq_f32(a, b, permute.vdupq_n_f32(c[lane]));
}

test vfmaq_laneq_f32 {
    {
        const a: types.f32x4 = .{ 0, 1, 2, 3 };
        const b: types.f32x4 = .{ 2, 2, 2, 2 };
        const c: types.f32x4 = .{ 3, 0, 0, 0 };
        const lane: usize = 0;
        const expected: types.f32x4 = .{ 6, 7, 8, 9 };

        try common.testIntrinsic("vfmaq_laneq_f32", vfmaq_laneq_f32, expected, .{ a, b, c, lane }, null);
    }
    {
        const a: types.f32x4 = .{ 5, 4, 332, 23 };
        const b: types.f32x4 = .{ 221, 2213, 2343, 23 };
        const c: types.f32x4 = .{ 33, 0, 0, 0 };
        const lane: usize = 0;
        const expected: types.f32x4 = .{ 7298, 73033, 77651, 782 };

        try common.testIntrinsic("vfmaq_laneq_f32", vfmaq_laneq_f32, expected, .{ a, b, c, lane }, null);
    }
}

/// Floating-point fused multiply-add to accumulator
pub inline fn vfmaq_laneq_f64(a: types.f64x2, b: types.f64x2, c: types.f64x2, comptime lane: usize) types.f64x2 {
    return vfmaq_f64(a, b, permute.vdupq_n_f64(c[lane]));
}

test vfmaq_laneq_f64 {
    const a: types.f64x2 = .{ 0, 1 };
    const b: types.f64x2 = .{ 2, 2 };
    const c: types.f64x2 = .{ 3, 0 };
    const lane: usize = 0;
    const expected: types.f64x2 = .{ 6, 7 };

    try common.testIntrinsic("vfmaq_laneq_f64", vfmaq_laneq_f64, expected, .{ a, b, c, lane }, null);
}

// --- Auto-generated Float Intrinsics ---
pub inline fn vabd_f16(a: types.f16x4, b: types.f16x4) types.f16x4 {
    return @abs(a - b);
}

test vabd_f16 {
    const a = std.mem.zeroes(types.f16x4);
    const b = std.mem.zeroes(types.f16x4);
    const expected = std.mem.zeroes(types.f16x4);
    try common.testIntrinsic("vabd_f16", vabd_f16, expected, .{ a, b }, null);
}

pub inline fn vabdq_f16(a: types.f16x8, b: types.f16x8) types.f16x8 {
    return @abs(a - b);
}

test vabdq_f16 {
    const a = std.mem.zeroes(types.f16x8);
    const b = std.mem.zeroes(types.f16x8);
    const expected = std.mem.zeroes(types.f16x8);
    try common.testIntrinsic("vabdq_f16", vabdq_f16, expected, .{ a, b }, null);
}

pub inline fn vabs_f16(a: types.f16x4) types.f16x4 {
    return @abs(a);
}

test vabs_f16 {
    const a = std.mem.zeroes(types.f16x4);
    const expected = std.mem.zeroes(types.f16x4);
    try common.testIntrinsic("vabs_f16", vabs_f16, expected, .{ a }, null);
}

pub inline fn vabsq_f16(a: types.f16x8) types.f16x8 {
    return @abs(a);
}

test vabsq_f16 {
    const a = std.mem.zeroes(types.f16x8);
    const expected = std.mem.zeroes(types.f16x8);
    try common.testIntrinsic("vabsq_f16", vabsq_f16, expected, .{ a }, null);
}

pub inline fn vadd_f16(a: types.f16x4, b: types.f16x4) types.f16x4 {
    return a + b;
}

test vadd_f16 {
    const a = std.mem.zeroes(types.f16x4);
    const b = std.mem.zeroes(types.f16x4);
    const expected = std.mem.zeroes(types.f16x4);
    try common.testIntrinsic("vadd_f16", vadd_f16, expected, .{ a, b }, null);
}

pub inline fn vaddq_f16(a: types.f16x8, b: types.f16x8) types.f16x8 {
    return a + b;
}

test vaddq_f16 {
    const a = std.mem.zeroes(types.f16x8);
    const b = std.mem.zeroes(types.f16x8);
    const expected = std.mem.zeroes(types.f16x8);
    try common.testIntrinsic("vaddq_f16", vaddq_f16, expected, .{ a, b }, null);
}

pub inline fn vamax_f16(a: types.f16x4, b: types.f16x4) types.f16x4 {
    return @max(@abs(a), @abs(b));
}

test vamax_f16 {
    const a = std.mem.zeroes(types.f16x4);
    const b = std.mem.zeroes(types.f16x4);
    const expected = std.mem.zeroes(types.f16x4);
    try common.testIntrinsic("vamax_f16", vamax_f16, expected, .{ a, b }, null);
}

pub inline fn vamax_f32(a: types.f32x2, b: types.f32x2) types.f32x2 {
    return @max(@abs(a), @abs(b));
}

test vamax_f32 {
    const a = std.mem.zeroes(types.f32x2);
    const b = std.mem.zeroes(types.f32x2);
    const expected = std.mem.zeroes(types.f32x2);
    try common.testIntrinsic("vamax_f32", vamax_f32, expected, .{ a, b }, null);
}

pub inline fn vamaxq_f16(a: types.f16x8, b: types.f16x8) types.f16x8 {
    return @max(@abs(a), @abs(b));
}

test vamaxq_f16 {
    const a = std.mem.zeroes(types.f16x8);
    const b = std.mem.zeroes(types.f16x8);
    const expected = std.mem.zeroes(types.f16x8);
    try common.testIntrinsic("vamaxq_f16", vamaxq_f16, expected, .{ a, b }, null);
}

pub inline fn vamaxq_f32(a: types.f32x4, b: types.f32x4) types.f32x4 {
    return @max(@abs(a), @abs(b));
}

test vamaxq_f32 {
    const a = std.mem.zeroes(types.f32x4);
    const b = std.mem.zeroes(types.f32x4);
    const expected = std.mem.zeroes(types.f32x4);
    try common.testIntrinsic("vamaxq_f32", vamaxq_f32, expected, .{ a, b }, null);
}

pub inline fn vamaxq_f64(a: types.f64x2, b: types.f64x2) types.f64x2 {
    return @max(@abs(a), @abs(b));
}

test vamaxq_f64 {
    const a = std.mem.zeroes(types.f64x2);
    const b = std.mem.zeroes(types.f64x2);
    const expected = std.mem.zeroes(types.f64x2);
    try common.testIntrinsic("vamaxq_f64", vamaxq_f64, expected, .{ a, b }, null);
}

pub inline fn vamin_f16(a: types.f16x4, b: types.f16x4) types.f16x4 {
    return @min(@abs(a), @abs(b));
}

test vamin_f16 {
    const a = std.mem.zeroes(types.f16x4);
    const b = std.mem.zeroes(types.f16x4);
    const expected = std.mem.zeroes(types.f16x4);
    try common.testIntrinsic("vamin_f16", vamin_f16, expected, .{ a, b }, null);
}

pub inline fn vamin_f32(a: types.f32x2, b: types.f32x2) types.f32x2 {
    return @min(@abs(a), @abs(b));
}

test vamin_f32 {
    const a = std.mem.zeroes(types.f32x2);
    const b = std.mem.zeroes(types.f32x2);
    const expected = std.mem.zeroes(types.f32x2);
    try common.testIntrinsic("vamin_f32", vamin_f32, expected, .{ a, b }, null);
}

pub inline fn vaminq_f16(a: types.f16x8, b: types.f16x8) types.f16x8 {
    return @min(@abs(a), @abs(b));
}

test vaminq_f16 {
    const a = std.mem.zeroes(types.f16x8);
    const b = std.mem.zeroes(types.f16x8);
    const expected = std.mem.zeroes(types.f16x8);
    try common.testIntrinsic("vaminq_f16", vaminq_f16, expected, .{ a, b }, null);
}

pub inline fn vaminq_f32(a: types.f32x4, b: types.f32x4) types.f32x4 {
    return @min(@abs(a), @abs(b));
}

test vaminq_f32 {
    const a = std.mem.zeroes(types.f32x4);
    const b = std.mem.zeroes(types.f32x4);
    const expected = std.mem.zeroes(types.f32x4);
    try common.testIntrinsic("vaminq_f32", vaminq_f32, expected, .{ a, b }, null);
}

pub inline fn vaminq_f64(a: types.f64x2, b: types.f64x2) types.f64x2 {
    return @min(@abs(a), @abs(b));
}

test vaminq_f64 {
    const a = std.mem.zeroes(types.f64x2);
    const b = std.mem.zeroes(types.f64x2);
    const expected = std.mem.zeroes(types.f64x2);
    try common.testIntrinsic("vaminq_f64", vaminq_f64, expected, .{ a, b }, null);
}

pub inline fn vdiv_f16(a: types.f16x4, b: types.f16x4) types.f16x4 {
    return a / b;
}

test vdiv_f16 {
    const a = std.mem.zeroes(types.f16x4);
    const b: types.f16x4 = @splat(1);
    const expected = std.mem.zeroes(types.f16x4);
    try common.testIntrinsic("vdiv_f16", vdiv_f16, expected, .{ a, b }, null);
}

pub inline fn vdiv_f32(a: types.f32x2, b: types.f32x2) types.f32x2 {
    return a / b;
}

test vdiv_f32 {
    const a = std.mem.zeroes(types.f32x2);
    const b: types.f32x2 = @splat(1);
    const expected = std.mem.zeroes(types.f32x2);
    try common.testIntrinsic("vdiv_f32", vdiv_f32, expected, .{ a, b }, null);
}

pub inline fn vdiv_f64(a: types.f64x1, b: types.f64x1) types.f64x1 {
    return a / b;
}

test vdiv_f64 {
    const a = std.mem.zeroes(types.f64x1);
    const b: types.f64x1 = @splat(1);
    const expected = std.mem.zeroes(types.f64x1);
    try common.testIntrinsic("vdiv_f64", vdiv_f64, expected, .{ a, b }, null);
}

pub inline fn vdivq_f16(a: types.f16x8, b: types.f16x8) types.f16x8 {
    return a / b;
}

test vdivq_f16 {
    const a = std.mem.zeroes(types.f16x8);
    const b: types.f16x8 = @splat(1);
    const expected = std.mem.zeroes(types.f16x8);
    try common.testIntrinsic("vdivq_f16", vdivq_f16, expected, .{ a, b }, null);
}

pub inline fn vdivq_f32(a: types.f32x4, b: types.f32x4) types.f32x4 {
    return a / b;
}

test vdivq_f32 {
    const a = std.mem.zeroes(types.f32x4);
    const b: types.f32x4 = @splat(1);
    const expected = std.mem.zeroes(types.f32x4);
    try common.testIntrinsic("vdivq_f32", vdivq_f32, expected, .{ a, b }, null);
}

pub inline fn vdivq_f64(a: types.f64x2, b: types.f64x2) types.f64x2 {
    return a / b;
}

test vdivq_f64 {
    const a = std.mem.zeroes(types.f64x2);
    const b: types.f64x2 = @splat(1);
    const expected = std.mem.zeroes(types.f64x2);
    try common.testIntrinsic("vdivq_f64", vdivq_f64, expected, .{ a, b }, null);
}

pub inline fn vmax_f16(a: types.f16x4, b: types.f16x4) types.f16x4 {
    return @max(a, b);
}

test vmax_f16 {
    const a = std.mem.zeroes(types.f16x4);
    const b = std.mem.zeroes(types.f16x4);
    const expected = std.mem.zeroes(types.f16x4);
    try common.testIntrinsic("vmax_f16", vmax_f16, expected, .{ a, b }, null);
}

pub inline fn vmax_f32(a: types.f32x2, b: types.f32x2) types.f32x2 {
    return @max(a, b);
}

test vmax_f32 {
    const a = std.mem.zeroes(types.f32x2);
    const b = std.mem.zeroes(types.f32x2);
    const expected = std.mem.zeroes(types.f32x2);
    try common.testIntrinsic("vmax_f32", vmax_f32, expected, .{ a, b }, null);
}

pub inline fn vmax_f64(a: types.f64x1, b: types.f64x1) types.f64x1 {
    return @max(a, b);
}

test vmax_f64 {
    const a = std.mem.zeroes(types.f64x1);
    const b = std.mem.zeroes(types.f64x1);
    const expected = std.mem.zeroes(types.f64x1);
    try common.testIntrinsic("vmax_f64", vmax_f64, expected, .{ a, b }, null);
}

pub inline fn vmaxq_f16(a: types.f16x8, b: types.f16x8) types.f16x8 {
    return @max(a, b);
}

test vmaxq_f16 {
    const a = std.mem.zeroes(types.f16x8);
    const b = std.mem.zeroes(types.f16x8);
    const expected = std.mem.zeroes(types.f16x8);
    try common.testIntrinsic("vmaxq_f16", vmaxq_f16, expected, .{ a, b }, null);
}

pub inline fn vmaxq_f32(a: types.f32x4, b: types.f32x4) types.f32x4 {
    return @max(a, b);
}

test vmaxq_f32 {
    const a = std.mem.zeroes(types.f32x4);
    const b = std.mem.zeroes(types.f32x4);
    const expected = std.mem.zeroes(types.f32x4);
    try common.testIntrinsic("vmaxq_f32", vmaxq_f32, expected, .{ a, b }, null);
}

pub inline fn vmaxq_f64(a: types.f64x2, b: types.f64x2) types.f64x2 {
    return @max(a, b);
}

test vmaxq_f64 {
    const a = std.mem.zeroes(types.f64x2);
    const b = std.mem.zeroes(types.f64x2);
    const expected = std.mem.zeroes(types.f64x2);
    try common.testIntrinsic("vmaxq_f64", vmaxq_f64, expected, .{ a, b }, null);
}

pub inline fn vmin_f16(a: types.f16x4, b: types.f16x4) types.f16x4 {
    return @min(a, b);
}

test vmin_f16 {
    const a = std.mem.zeroes(types.f16x4);
    const b = std.mem.zeroes(types.f16x4);
    const expected = std.mem.zeroes(types.f16x4);
    try common.testIntrinsic("vmin_f16", vmin_f16, expected, .{ a, b }, null);
}

pub inline fn vmin_f32(a: types.f32x2, b: types.f32x2) types.f32x2 {
    return @min(a, b);
}

test vmin_f32 {
    const a = std.mem.zeroes(types.f32x2);
    const b = std.mem.zeroes(types.f32x2);
    const expected = std.mem.zeroes(types.f32x2);
    try common.testIntrinsic("vmin_f32", vmin_f32, expected, .{ a, b }, null);
}

pub inline fn vmin_f64(a: types.f64x1, b: types.f64x1) types.f64x1 {
    return @min(a, b);
}

test vmin_f64 {
    const a = std.mem.zeroes(types.f64x1);
    const b = std.mem.zeroes(types.f64x1);
    const expected = std.mem.zeroes(types.f64x1);
    try common.testIntrinsic("vmin_f64", vmin_f64, expected, .{ a, b }, null);
}

pub inline fn vminq_f16(a: types.f16x8, b: types.f16x8) types.f16x8 {
    return @min(a, b);
}

test vminq_f16 {
    const a = std.mem.zeroes(types.f16x8);
    const b = std.mem.zeroes(types.f16x8);
    const expected = std.mem.zeroes(types.f16x8);
    try common.testIntrinsic("vminq_f16", vminq_f16, expected, .{ a, b }, null);
}

pub inline fn vminq_f32(a: types.f32x4, b: types.f32x4) types.f32x4 {
    return @min(a, b);
}

test vminq_f32 {
    const a = std.mem.zeroes(types.f32x4);
    const b = std.mem.zeroes(types.f32x4);
    const expected = std.mem.zeroes(types.f32x4);
    try common.testIntrinsic("vminq_f32", vminq_f32, expected, .{ a, b }, null);
}

pub inline fn vminq_f64(a: types.f64x2, b: types.f64x2) types.f64x2 {
    return @min(a, b);
}

test vminq_f64 {
    const a = std.mem.zeroes(types.f64x2);
    const b = std.mem.zeroes(types.f64x2);
    const expected = std.mem.zeroes(types.f64x2);
    try common.testIntrinsic("vminq_f64", vminq_f64, expected, .{ a, b }, null);
}

pub inline fn vmul_f16(a: types.f16x4, b: types.f16x4) types.f16x4 {
    return a * b;
}

test vmul_f16 {
    const a = std.mem.zeroes(types.f16x4);
    const b = std.mem.zeroes(types.f16x4);
    const expected = std.mem.zeroes(types.f16x4);
    try common.testIntrinsic("vmul_f16", vmul_f16, expected, .{ a, b }, null);
}

pub inline fn vmul_f32(a: types.f32x2, b: types.f32x2) types.f32x2 {
    return a * b;
}

test vmul_f32 {
    const a = std.mem.zeroes(types.f32x2);
    const b = std.mem.zeroes(types.f32x2);
    const expected = std.mem.zeroes(types.f32x2);
    try common.testIntrinsic("vmul_f32", vmul_f32, expected, .{ a, b }, null);
}

pub inline fn vmul_f64(a: types.f64x1, b: types.f64x1) types.f64x1 {
    return a * b;
}

test vmul_f64 {
    const a = std.mem.zeroes(types.f64x1);
    const b = std.mem.zeroes(types.f64x1);
    const expected = std.mem.zeroes(types.f64x1);
    try common.testIntrinsic("vmul_f64", vmul_f64, expected, .{ a, b }, null);
}

pub inline fn vmulq_f16(a: types.f16x8, b: types.f16x8) types.f16x8 {
    return a * b;
}

test vmulq_f16 {
    const a = std.mem.zeroes(types.f16x8);
    const b = std.mem.zeroes(types.f16x8);
    const expected = std.mem.zeroes(types.f16x8);
    try common.testIntrinsic("vmulq_f16", vmulq_f16, expected, .{ a, b }, null);
}

pub inline fn vmulq_f32(a: types.f32x4, b: types.f32x4) types.f32x4 {
    return a * b;
}

test vmulq_f32 {
    const a = std.mem.zeroes(types.f32x4);
    const b = std.mem.zeroes(types.f32x4);
    const expected = std.mem.zeroes(types.f32x4);
    try common.testIntrinsic("vmulq_f32", vmulq_f32, expected, .{ a, b }, null);
}

pub inline fn vmulq_f64(a: types.f64x2, b: types.f64x2) types.f64x2 {
    return a * b;
}

test vmulq_f64 {
    const a = std.mem.zeroes(types.f64x2);
    const b = std.mem.zeroes(types.f64x2);
    const expected = std.mem.zeroes(types.f64x2);
    try common.testIntrinsic("vmulq_f64", vmulq_f64, expected, .{ a, b }, null);
}

pub inline fn vneg_f16(a: types.f16x4) types.f16x4 {
    return -a;
}

test vneg_f16 {
    const a = std.mem.zeroes(types.f16x4);
    const expected = std.mem.zeroes(types.f16x4);
    try common.testIntrinsic("vneg_f16", vneg_f16, expected, .{ a }, null);
}

pub inline fn vneg_f32(a: types.f32x2) types.f32x2 {
    return -a;
}

test vneg_f32 {
    const a = std.mem.zeroes(types.f32x2);
    const expected = std.mem.zeroes(types.f32x2);
    try common.testIntrinsic("vneg_f32", vneg_f32, expected, .{ a }, null);
}

pub inline fn vneg_f64(a: types.f64x1) types.f64x1 {
    return -a;
}

test vneg_f64 {
    const a = std.mem.zeroes(types.f64x1);
    const expected = std.mem.zeroes(types.f64x1);
    try common.testIntrinsic("vneg_f64", vneg_f64, expected, .{ a }, null);
}

pub inline fn vnegq_f16(a: types.f16x8) types.f16x8 {
    return -a;
}

test vnegq_f16 {
    const a = std.mem.zeroes(types.f16x8);
    const expected = std.mem.zeroes(types.f16x8);
    try common.testIntrinsic("vnegq_f16", vnegq_f16, expected, .{ a }, null);
}

pub inline fn vnegq_f32(a: types.f32x4) types.f32x4 {
    return -a;
}

test vnegq_f32 {
    const a = std.mem.zeroes(types.f32x4);
    const expected = std.mem.zeroes(types.f32x4);
    try common.testIntrinsic("vnegq_f32", vnegq_f32, expected, .{ a }, null);
}

pub inline fn vnegq_f64(a: types.f64x2) types.f64x2 {
    return -a;
}

test vnegq_f64 {
    const a = std.mem.zeroes(types.f64x2);
    const expected = std.mem.zeroes(types.f64x2);
    try common.testIntrinsic("vnegq_f64", vnegq_f64, expected, .{ a }, null);
}

pub inline fn vsub_f16(a: types.f16x4, b: types.f16x4) types.f16x4 {
    return a - b;
}

test vsub_f16 {
    const a = std.mem.zeroes(types.f16x4);
    const b = std.mem.zeroes(types.f16x4);
    const expected = std.mem.zeroes(types.f16x4);
    try common.testIntrinsic("vsub_f16", vsub_f16, expected, .{ a, b }, null);
}

pub inline fn vsub_f32(a: types.f32x2, b: types.f32x2) types.f32x2 {
    return a - b;
}

test vsub_f32 {
    const a = std.mem.zeroes(types.f32x2);
    const b = std.mem.zeroes(types.f32x2);
    const expected = std.mem.zeroes(types.f32x2);
    try common.testIntrinsic("vsub_f32", vsub_f32, expected, .{ a, b }, null);
}

pub inline fn vsub_f64(a: types.f64x1, b: types.f64x1) types.f64x1 {
    return a - b;
}

test vsub_f64 {
    const a = std.mem.zeroes(types.f64x1);
    const b = std.mem.zeroes(types.f64x1);
    const expected = std.mem.zeroes(types.f64x1);
    try common.testIntrinsic("vsub_f64", vsub_f64, expected, .{ a, b }, null);
}

pub inline fn vsubq_f16(a: types.f16x8, b: types.f16x8) types.f16x8 {
    return a - b;
}

test vsubq_f16 {
    const a = std.mem.zeroes(types.f16x8);
    const b = std.mem.zeroes(types.f16x8);
    const expected = std.mem.zeroes(types.f16x8);
    try common.testIntrinsic("vsubq_f16", vsubq_f16, expected, .{ a, b }, null);
}

pub inline fn vsubq_f32(a: types.f32x4, b: types.f32x4) types.f32x4 {
    return a - b;
}

test vsubq_f32 {
    const a = std.mem.zeroes(types.f32x4);
    const b = std.mem.zeroes(types.f32x4);
    const expected = std.mem.zeroes(types.f32x4);
    try common.testIntrinsic("vsubq_f32", vsubq_f32, expected, .{ a, b }, null);
}

pub inline fn vsubq_f64(a: types.f64x2, b: types.f64x2) types.f64x2 {
    return a - b;
}

test vsubq_f64 {
    const a = std.mem.zeroes(types.f64x2);
    const b = std.mem.zeroes(types.f64x2);
    const expected = std.mem.zeroes(types.f64x2);
    try common.testIntrinsic("vsubq_f64", vsubq_f64, expected, .{ a, b }, null);
}
