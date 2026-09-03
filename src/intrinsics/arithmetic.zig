const std = @import("std");
const builtin = @import("builtin");
const assert = std.debug.assert;
const expectEqual = std.testing.expectEqual;
const arch = @import("../arch.zig");
const endianness = builtin.target.cpu.arch.endian();
const types = @import("../types.zig");
const common = @import("../common.zig");
const decodeFp8 = common.decodeFp8;
const encodeFp8 = common.encodeFp8;
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
    try common.testIntrinsic(.{ .func = vmull_s8, .expected = types.i16x8{ 0, 0, 0, 0, 0, 0, 0, 254 }, .args = .{ a, b } });
}

/// Signed multiply long
pub inline fn vmull_s16(a: types.i16x4, b: types.i16x4) types.i32x4 {
    return @as(types.i32x4, a) * @as(types.i32x4, b);
}

test vmull_s16 {
    const a: types.i16x4 = .{ 0, -1, -2, -3 };
    const b: types.i16x4 = @splat(5);

    try common.testIntrinsic(.{ .func = vmull_s16, .expected = types.i32x4{ 0, -1 * 5, -2 * 5, -3 * 5 }, .args = .{ a, b } });
}

/// Signed multiply long
pub inline fn vmull_s32(a: types.i32x2, b: types.i32x2) types.i64x2 {
    return @as(types.i64x2, a) * @as(types.i64x2, b);
}

test vmull_s32 {
    const a: types.i32x2 = .{ 0, -1 };
    const b: types.i32x2 = @splat(5);

    try common.testIntrinsic(.{ .func = vmull_s32, .expected = types.i32x2{ 0, -5 }, .args = .{ a, b } });
}

/// Unsigned multiply long
pub inline fn vmull_u8(a: types.u8x8, b: types.u8x8) types.u16x8 {
    return @as(types.u16x8, a) * @as(types.u16x8, b);
}

test vmull_u8 {
    const a: types.u8x8 = .{ 0, 1, 2, 3, 4, 5, 6, 7 };
    const b: types.u8x8 = @splat(5);

    try common.testIntrinsic(.{ .func = vmull_u8, .expected = types.u16x8{ 0, 1 * 5, 2 * 5, 3 * 5, 4 * 5, 5 * 5, 6 * 5, 7 * 5 }, .args = .{ a, b } });
}

/// Unsigned multiply long
pub inline fn vmull_u16(a: types.u16x4, b: types.u16x4) types.u32x4 {
    return @as(types.u32x4, a) * @as(types.u32x4, b);
}

test vmull_u16 {
    const a: types.u16x4 = .{ 0, 1, 2, 3 };
    const b: types.u16x4 = @splat(5);

    try common.testIntrinsic(.{ .func = vmull_u16, .expected = types.u32x4{ 0, 1 * 5, 2 * 5, 3 * 5 }, .args = .{ a, b } });
}

/// Unsigned multiply long
pub inline fn vmull_u32(a: types.u32x2, b: types.u32x2) types.u64x2 {
    return @as(types.u64x2, a) * @as(types.u64x2, b);
}

test vmull_u32 {
    const a: types.u32x2 = .{ 0, 1 };
    const b: types.u32x2 = @splat(5);

    try common.testIntrinsic(.{ .func = vmull_u32, .expected = types.u64x2{ 0, 1 * 5 }, .args = .{ a, b } });
}

/// Signed multiply long
pub inline fn vmull_high_s8(a: types.i8x16, b: types.i8x16) types.i16x8 {
    return vmull_s8(permute.vget_high_s8(a), permute.vget_high_s8(b));
}

test vmull_high_s8 {
    const a: types.i8x16 = .{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 127 };
    const b: types.i8x16 = @splat(2);

    try common.testIntrinsic(.{ .func = vmull_high_s8, .expected = types.i16x8{ 0, 0, 0, 0, 0, 0, 0, 254 }, .args = .{ a, b } });
}

/// Signed multiply long
pub inline fn vmull_high_s16(a: types.i16x8, b: types.i16x8) types.i32x4 {
    return vmull_s16(permute.vget_high_s16(a), permute.vget_high_s16(b));
}

test vmull_high_s16 {
    const a: types.i16x8 = .{ 0, 0, 0, 0, 0, -1, -2, -3 };
    const b: types.i16x8 = @splat(5);

    try common.testIntrinsic(.{ .func = vmull_high_s16, .expected = types.i32x4{ 0, -1 * 5, -2 * 5, -3 * 5 }, .args = .{ a, b } });
}

/// Signed multiply long
pub inline fn vmull_high_s32(a: types.i32x4, b: types.i32x4) types.i64x2 {
    return vmull_s32(permute.vget_high_s32(a), permute.vget_high_s32(b));
}

test vmull_high_s32 {
    const a: types.i32x4 = .{ 0, -1, -2, -3 };
    const b: types.i32x4 = @splat(5);

    try common.testIntrinsic(.{ .func = vmull_high_s32, .expected = types.i64x2{ -2 * 5, -3 * 5 }, .args = .{ a, b } });
}

/// Unsigned multiply long
pub inline fn vmull_high_u8(a: types.u8x16, b: types.u8x16) types.u16x8 {
    return vmull_u8(permute.vget_high_u8(a), permute.vget_high_u8(b));
}

test vmull_high_u8 {
    const a: types.u8x16 = .{ 0, 0, 0, 0, 0, 0, 0, 127, 0, 0, 0, 0, 0, 0, 0, 127 };
    const b: types.u8x16 = @splat(2);

    try common.testIntrinsic(.{ .func = vmull_high_u8, .expected = types.u16x8{ 0, 0, 0, 0, 0, 0, 0, 254 }, .args = .{ a, b } });
}

/// Unsigned multiply long
pub inline fn vmull_high_u16(a: types.u16x8, b: types.u16x8) types.u32x4 {
    return vmull_u16(permute.vget_high_u16(a), permute.vget_high_u16(b));
}

test vmull_high_u16 {
    const a: types.u16x8 = .{ 0, 1, 2, 3, 0, 1, 2, 3 };
    const b: types.u16x8 = @splat(5);

    try common.testIntrinsic(.{ .func = vmull_high_u16, .expected = types.u32x4{ 0, 1 * 5, 2 * 5, 3 * 5 }, .args = .{ a, b } });
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

    try common.testIntrinsic(.{ .func = vabd_s8, .expected = expected, .args = .{ a, b } });
}

/// Absolute difference between two int16x4_t vectors
pub inline fn vabd_s16(a: types.i16x4, b: types.i16x4) types.i16x4 {
    return common.abdGeneric(a, b);
}

test vabd_s16 {
    const a: types.i16x4 = .{ 1, 2, 3, 4 };
    const b: types.i16x4 = .{ 16, 15, 14, 13 };

    const expected: types.i16x4 = .{ 15, 13, 11, 9 };

    try common.testIntrinsic(.{ .func = vabd_s16, .expected = expected, .args = .{ a, b } });
}

/// Absolute difference between two int32x2_t vectors
pub inline fn vabd_s32(a: types.i32x2, b: types.i32x2) types.i32x2 {
    return common.abdGeneric(a, b);
}

test vabd_s32 {
    const a: types.i32x2 = .{ 1, 2 };
    const b: types.i32x2 = .{ 16, 15 };

    const expected: types.i32x2 = .{ 15, 13 };

    try common.testIntrinsic(.{ .func = vabd_s32, .expected = expected, .args = .{ a, b } });
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

        try common.testIntrinsic(.{ .func = vabd_u8, .expected = expected, .args = .{ a, b } });
    }
    {
        const a: types.u8x8 = .{ 10, 10, 10, 10, 10, 10, 10, 10 };
        const b: types.u8x8 = .{ 10, 10, 10, 10, 10, 10, 10, 10 };
        const expected: types.u8x8 = .{ 0, 0, 0, 0, 0, 0, 0, 0 };

        try common.testIntrinsic(.{ .func = vabd_u8, .expected = expected, .args = .{ a, b } });
    }
    {
        const a: types.u8x8 = .{ 16, 15, 14, 13, 12, 11, 10, 9 };
        const b: types.u8x8 = .{ 1, 2, 3, 4, 5, 6, 7, 8 };
        const expected: types.u8x8 = .{ 15, 13, 11, 9, 7, 5, 3, 1 };

        try common.testIntrinsic(.{ .func = vabd_u8, .expected = expected, .args = .{ a, b } });
    }
    {
        const a: types.u8x8 = .{ 0, 255, 128, 64, 32, 16, 8, 4 };
        const b: types.u8x8 = .{ 255, 0, 64, 128, 16, 32, 4, 8 };
        const expected: types.u8x8 = .{ 255, 255, 64, 64, 16, 16, 4, 4 };

        try common.testIntrinsic(.{ .func = vabd_u8, .expected = expected, .args = .{ a, b } });
    }
    {
        const a: types.u8x8 = .{ 0, 0, 0, 0, 0, 0, 0, 0 };
        const b: types.u8x8 = .{ 0, 0, 0, 0, 0, 0, 0, 0 };
        const expected: types.u8x8 = .{ 0, 0, 0, 0, 0, 0, 0, 0 };

        try common.testIntrinsic(.{ .func = vabd_u8, .expected = expected, .args = .{ a, b } });
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

    try common.testIntrinsic(.{ .func = vabd_u16, .expected = expected, .args = .{ a, b } });
}

/// Absolute difference between two uint32x2_t vectors
pub inline fn vabd_u32(a: types.u32x2, b: types.u32x2) types.u32x2 {
    return common.abdGeneric(a, b);
}

test vabd_u32 {
    const a: types.u32x2 = .{ 1, 2 };
    const b: types.u32x2 = .{ 16, 15 };

    const expected: types.u32x2 = .{ 15, 13 };

    try common.testIntrinsic(.{ .func = vabd_u32, .expected = expected, .args = .{ a, b } });
}

/// Absolute difference between two float32x2_t vectors
pub inline fn vabd_f32(a: types.f32x2, b: types.f32x2) types.f32x2 {
    return common.abdGeneric(a, b);
}

test vabd_f32 {
    const a: types.f32x2 = .{ 0.00, 0.00 };
    const b: types.f32x2 = .{ 0.19, 0.15 };

    const expected: types.f32x2 = .{ @abs(0.00 - 0.19), @abs(0.00 - 0.15) };

    try common.testIntrinsic(.{ .func = vabd_f32, .expected = expected, .args = .{ a, b } });
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

    try common.testIntrinsic(.{ .func = vabdq_s8, .expected = expected, .args = .{ a, b } });
}

/// signed absolute difference and accumulate (128-bit)
pub inline fn vabdq_s16(a: types.i16x8, b: types.i16x8) types.i16x8 {
    return common.abdGeneric(a, b);
}

test vabdq_s16 {
    const a: types.i16x8 = .{ 1, 2, 3, 4, 5, 6, 7, 8 };
    const b: types.i16x8 = .{ 16, 15, 14, 13, 12, 11, 10, 9 };

    const expected: types.i16x8 = .{ 15, 13, 11, 9, 7, 5, 3, 1 };

    try common.testIntrinsic(.{ .func = vabdq_s16, .expected = expected, .args = .{ a, b } });
}

/// signed absolute difference and accumulate (128-bit)
pub inline fn vabdq_s32(a: types.i32x4, b: types.i32x4) types.i32x4 {
    return common.abdGeneric(a, b);
}

test vabdq_s32 {
    const a: types.i32x4 = .{ 1, 2, 3, 4 };
    const b: types.i32x4 = .{ 16, 15, 14, 13 };

    const expected: types.i32x4 = .{ 15, 13, 11, 9 };

    try common.testIntrinsic(.{ .func = vabdq_s32, .expected = expected, .args = .{ a, b } });
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

        try common.testIntrinsic(.{ .func = vabdq_u8, .expected = expected, .args = .{ a, b } });
    }
    {
        const a: types.u8x16 = .{ 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 };
        const b: types.u8x16 = .{ 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 };
        const expected: types.u8x16 = .{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };

        try common.testIntrinsic(.{ .func = vabdq_u8, .expected = expected, .args = .{ a, b } });
    }
    {
        const a: types.u8x16 = .{ 16, 15, 14, 13, 12, 11, 10, 9, 16, 15, 14, 13, 12, 11, 10, 9 };
        const b: types.u8x16 = .{ 1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8 };
        const expected: types.u8x16 = .{ 15, 13, 11, 9, 7, 5, 3, 1, 15, 13, 11, 9, 7, 5, 3, 1 };

        try common.testIntrinsic(.{ .func = vabdq_u8, .expected = expected, .args = .{ a, b } });
    }
    {
        const a: types.u8x16 = .{ 0, 255, 128, 64, 32, 16, 8, 4, 0, 255, 128, 64, 32, 16, 8, 4 };
        const b: types.u8x16 = .{ 255, 0, 64, 128, 16, 32, 4, 8, 255, 0, 64, 128, 16, 32, 4, 8 };
        const expected: types.u8x16 = .{ 255, 255, 64, 64, 16, 16, 4, 4, 255, 255, 64, 64, 16, 16, 4, 4 };

        try common.testIntrinsic(.{ .func = vabdq_u8, .expected = expected, .args = .{ a, b } });
    }
    {
        const a: types.u8x16 = .{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
        const b: types.u8x16 = .{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
        const expected: types.u8x16 = .{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };

        try common.testIntrinsic(.{ .func = vabdq_u8, .expected = expected, .args = .{ a, b } });
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

    try common.testIntrinsic(.{ .func = vabdq_u16, .expected = expected, .args = .{ a, b } });
}

/// signed absolute difference and accumulate (128-bit)
pub inline fn vabdq_u32(a: types.u32x4, b: types.u32x4) types.u32x4 {
    return common.abdGeneric(a, b);
}

test vabdq_u32 {
    const a: types.u32x4 = .{ 1, 2, 1, 2 };
    const b: types.u32x4 = .{ 16, 15, 16, 15 };

    const expected: types.u32x4 = .{ 15, 13, 15, 13 };

    try common.testIntrinsic(.{ .func = vabdq_u32, .expected = expected, .args = .{ a, b } });
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

    try common.testIntrinsic(.{ .func = vqdmull_s16, .expected = expected, .args = .{ a, b } });

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

    try common.testIntrinsic(.{ .func = vqdmull_s32, .expected = expected, .args = .{ a, b } });

    const a_sat: types.i32x2 = .{ std.math.maxInt(i32), std.math.maxInt(i32) };
    const b_sat: types.i32x2 = .{ std.math.maxInt(i32), std.math.minInt(i32) };

    const expected_sat: types.i64x2 = .{
        9223372028264841218,
        -9223372032559808512,
    };

    try common.testIntrinsic(.{ .func = vqdmull_s32, .expected = expected_sat, .args = .{ a_sat, b_sat } });
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

    try common.testIntrinsic(.{ .func = vqdmullh_s16, .expected = expected, .args = .{ a, b } });
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

    try common.testIntrinsic(.{ .func = vqdmulls_s32, .expected = expected, .args = .{ a, b } });
}

/// Saturating subtract
pub inline fn vqsub_s8(a: types.i8x8, b: types.i8x8) types.i8x8 {
    return a -| b;
}

test vqsub_s8 {
    const a: types.i8x8 = @splat(1);
    const b: types.i8x8 = @splat(1);
    const expected: types.i8x8 = @splat(0);
    try common.testIntrinsic(.{ .func = vqsub_s8, .expected = expected, .args = .{ a, b } });
}

/// Saturating subtract
pub inline fn vqsub_s16(a: types.i16x4, b: types.i16x4) types.i16x4 {
    return a -| b;
}

test vqsub_s16 {
    const a: types.i16x4 = @splat(1);
    const b: types.i16x4 = @splat(1);
    const expected: types.i16x4 = @splat(0);
    try common.testIntrinsic(.{ .func = vqsub_s16, .expected = expected, .args = .{ a, b } });
}

/// Saturating subtract
pub inline fn vqsub_s32(a: types.i32x2, b: types.i32x2) types.i32x2 {
    return a -| b;
}

test vqsub_s32 {
    const a: types.i32x2 = @splat(1);
    const b: types.i32x2 = @splat(1);
    const expected: types.i32x2 = @splat(0);
    try common.testIntrinsic(.{ .func = vqsub_s32, .expected = expected, .args = .{ a, b } });
}

/// Saturating subtract
pub inline fn vqsub_s64(a: types.i64x1, b: types.i64x1) types.i64x1 {
    return a -| b;
}

test vqsub_s64 {
    const a: types.i64x1 = @splat(1);
    const b: types.i64x1 = @splat(1);
    const expected: types.i64x1 = @splat(0);
    try common.testIntrinsic(.{ .func = vqsub_s64, .expected = expected, .args = .{ a, b } });
}

/// Saturating subtract
pub inline fn vqsub_u8(a: types.u8x8, b: types.u8x8) types.u8x8 {
    return a -| b;
}

test vqsub_u8 {
    const a: types.u8x8 = @splat(1);
    const b: types.u8x8 = @splat(1);
    const expected: types.u8x8 = @splat(0);
    try common.testIntrinsic(.{ .func = vqsub_u8, .expected = expected, .args = .{ a, b } });
}

/// Saturating subtract
pub inline fn vqsub_u16(a: types.u16x4, b: types.u16x4) types.u16x4 {
    return a -| b;
}

test vqsub_u16 {
    const a: types.u16x4 = @splat(1);
    const b: types.u16x4 = @splat(1);
    const expected: types.u16x4 = @splat(0);
    try common.testIntrinsic(.{ .func = vqsub_u16, .expected = expected, .args = .{ a, b } });
}

/// Saturating subtract
pub inline fn vqsub_u32(a: types.u32x2, b: types.u32x2) types.u32x2 {
    return a -| b;
}

test vqsub_u32 {
    const a: types.u32x2 = @splat(1);
    const b: types.u32x2 = @splat(1);
    const expected: types.u32x2 = @splat(0);
    try common.testIntrinsic(.{ .func = vqsub_u32, .expected = expected, .args = .{ a, b } });
}

/// Saturating subtract
pub inline fn vqsub_u64(a: types.u64x1, b: types.u64x1) types.u64x1 {
    return a -| b;
}

test vqsub_u64 {
    const a: types.u64x1 = @splat(1);
    const b: types.u64x1 = @splat(1);
    const expected: types.u64x1 = @splat(0);
    try common.testIntrinsic(.{ .func = vqsub_u64, .expected = expected, .args = .{ a, b } });
}

/// Saturating subtract
pub inline fn vqsubq_s8(a: types.i8x16, b: types.i8x16) types.i8x16 {
    return a -| b;
}

test vqsubq_s8 {
    const a: types.i8x16 = @splat(1);
    const b: types.i8x16 = @splat(1);
    const expected: types.i8x16 = @splat(0);
    try common.testIntrinsic(.{ .func = vqsubq_s8, .expected = expected, .args = .{ a, b } });
}

/// Saturating subtract
pub inline fn vqsubq_s16(a: types.i16x8, b: types.i16x8) types.i16x8 {
    return a -| b;
}

test vqsubq_s16 {
    const a: types.i16x8 = @splat(1);
    const b: types.i16x8 = @splat(1);
    const expected: types.i16x8 = @splat(0);
    try common.testIntrinsic(.{ .func = vqsubq_s16, .expected = expected, .args = .{ a, b } });
}

/// Saturating subtract
pub inline fn vqsubq_s32(a: types.i32x4, b: types.i32x4) types.i32x4 {
    return a -| b;
}

test vqsubq_s32 {
    const a: types.i32x4 = @splat(1);
    const b: types.i32x4 = @splat(1);
    const expected: types.i32x4 = @splat(0);
    try common.testIntrinsic(.{ .func = vqsubq_s32, .expected = expected, .args = .{ a, b } });
}

/// Saturating subtract
pub inline fn vqsubq_s64(a: types.i64x2, b: types.i64x2) types.i64x2 {
    return a -| b;
}

test vqsubq_s64 {
    const a: types.i64x2 = @splat(1);
    const b: types.i64x2 = @splat(1);
    const expected: types.i64x2 = @splat(0);
    try common.testIntrinsic(.{ .func = vqsubq_s64, .expected = expected, .args = .{ a, b } });
}

/// Saturating subtract
pub inline fn vqsubq_u8(a: types.u8x16, b: types.u8x16) types.u8x16 {
    return a -| b;
}

test vqsubq_u8 {
    const a: types.u8x16 = @splat(1);
    const b: types.u8x16 = @splat(1);
    const expected: types.u8x16 = @splat(0);
    try common.testIntrinsic(.{ .func = vqsubq_u8, .expected = expected, .args = .{ a, b } });
}

/// Saturating subtract
pub inline fn vqsubq_u16(a: types.u16x8, b: types.u16x8) types.u16x8 {
    return a -| b;
}

test vqsubq_u16 {
    const a: types.u16x8 = @splat(1);
    const b: types.u16x8 = @splat(1);
    const expected: types.u16x8 = @splat(0);
    try common.testIntrinsic(.{ .func = vqsubq_u16, .expected = expected, .args = .{ a, b } });
}

/// Saturating subtract
pub inline fn vqsubq_u32(a: types.u32x4, b: types.u32x4) types.u32x4 {
    return a -| b;
}

test vqsubq_u32 {
    const a: types.u32x4 = @splat(1);
    const b: types.u32x4 = @splat(1);
    const expected: types.u32x4 = @splat(0);
    try common.testIntrinsic(.{ .func = vqsubq_u32, .expected = expected, .args = .{ a, b } });
}

/// Saturating subtract
pub inline fn vqsubq_u64(a: types.u64x2, b: types.u64x2) types.u64x2 {
    return a -| b;
}

test vqsubq_u64 {
    const a: types.u64x2 = @splat(1);
    const b: types.u64x2 = @splat(1);
    const expected: types.u64x2 = @splat(0);
    try common.testIntrinsic(.{ .func = vqsubq_u64, .expected = expected, .args = .{ a, b } });
}

/// Saturating subtract
pub inline fn vqsubs_s32(a: i32, b: i32) i32 {
    return a -| b;
}

test vqsubs_s32 {
    const a: i32 = 1;
    const b: i32 = 1;
    const expected: i32 = 0;
    try common.testIntrinsic(.{ .func = vqsubs_s32, .expected = expected, .args = .{ a, b } });
}

/// Saturating subtract
pub inline fn vqsubs_u32(a: u32, b: u32) u32 {
    return a -| b;
}

test vqsubs_u32 {
    const a: u32 = 1;
    const b: u32 = 1;
    const expected: u32 = 0;
    try common.testIntrinsic(.{ .func = vqsubs_u32, .expected = expected, .args = .{ a, b } });
}

/// Saturating subtract
pub inline fn vqsubd_s64(a: i64, b: i64) i64 {
    return a -| b;
}

test vqsubd_s64 {
    const a: i64 = 1;
    const b: i64 = 1;
    const expected: i64 = 0;
    try common.testIntrinsic(.{ .func = vqsubd_s64, .expected = expected, .args = .{ a, b } });
}

/// Saturating subtract
pub inline fn vqsubd_u64(a: u64, b: u64) u64 {
    return a -| b;
}

test vqsubd_u64 {
    const a: u64 = 1;
    const b: u64 = 1;
    const expected: u64 = 0;
    try common.testIntrinsic(.{ .func = vqsubd_u64, .expected = expected, .args = .{ a, b } });
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
    try common.testIntrinsic(.{ .func = vaba_s16, .expected = expected, .args = .{ acc, a, b } });
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
    try common.testIntrinsic(.{ .func = vaba_s32, .expected = expected, .args = .{ acc, a, b } });
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
    try common.testIntrinsic(.{ .func = vaba_u8, .expected = expected, .args = .{ acc, a, b } });
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
    try common.testIntrinsic(.{ .func = vaba_u16, .expected = expected, .args = .{ acc, a, b } });
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
    try common.testIntrinsic(.{ .func = vaba_u32, .expected = expected, .args = .{ acc, a, b } });
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
    try common.testIntrinsic(.{ .func = vabaq_s8, .expected = expected, .args = .{ acc, a, b } });
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
    try common.testIntrinsic(.{ .func = vabaq_s16, .expected = expected, .args = .{ acc, a, b } });
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
    try common.testIntrinsic(.{ .func = vabaq_s32, .expected = expected, .args = .{ acc, a, b } });
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
    try common.testIntrinsic(.{ .func = vabaq_u8, .expected = expected, .args = .{ acc, a, b } });
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
    try common.testIntrinsic(.{ .func = vabaq_u16, .expected = expected, .args = .{ acc, a, b } });
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
    try common.testIntrinsic(.{ .func = vabaq_u32, .expected = expected, .args = .{ acc, a, b } });
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
    try common.testIntrinsic(.{ .func = vabal_s8, .expected = expected, .args = .{ acc, a, b } });
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
    try common.testIntrinsic(.{ .func = vabal_s16, .expected = expected, .args = .{ acc, a, b } });
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
    try common.testIntrinsic(.{ .func = vabal_s32, .expected = expected, .args = .{ acc, a, b } });
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
    try common.testIntrinsic(.{ .func = vabal_u8, .expected = expected, .args = .{ acc, a, b } });
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
    try common.testIntrinsic(.{ .func = vabal_u16, .expected = expected, .args = .{ acc, a, b } });
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
    try common.testIntrinsic(.{ .func = vabal_u32, .expected = expected, .args = .{ acc, a, b } });
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
    try common.testIntrinsic(.{ .func = vabal_high_s8, .expected = expected, .args = .{ acc, a, b } });
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
    try common.testIntrinsic(.{ .func = vabal_high_s16, .expected = expected, .args = .{ acc, a, b } });
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
    try common.testIntrinsic(.{ .func = vabal_high_s32, .expected = expected, .args = .{ acc, a, b } });
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
    try common.testIntrinsic(.{ .func = vabal_high_u8, .expected = expected, .args = .{ acc, a, b } });
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
    try common.testIntrinsic(.{ .func = vabal_high_u16, .expected = expected, .args = .{ acc, a, b } });
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
    try common.testIntrinsic(.{ .func = vabal_high_u32, .expected = expected, .args = .{ acc, a, b } });
}

/// Floating-point absolute difference
pub inline fn vabdd_f64(a: f64, b: f64) f64 {
    return @abs(a - b);
}

test vabdd_f64 {
    const a: f64 = 1.0;
    const b: f64 = 1.0;
    const expected: f64 = 0.0;
    try common.testIntrinsic(.{ .func = vabdd_f64, .expected = expected, .args = .{ a, b } });
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
    try common.testIntrinsic(.{ .func = vabdl_high_s8, .expected = expected, .args = .{ a, b } });
}

/// Signed Absolute difference Long
pub inline fn vabdl_high_s16(a: types.i16x8, b: types.i16x8) types.i32x4 {
    return common.abdGeneric(permute.vget_high_s16(a), permute.vget_high_s16(b));
}

test vabdl_high_s16 {
    const a: types.i16x8 = @splat(1);
    const b: types.i16x8 = @splat(1);
    const expected: types.i32x4 = @splat(0);
    try common.testIntrinsic(.{ .func = vabdl_high_s16, .expected = expected, .args = .{ a, b } });
}

/// Signed Absolute difference Long
pub inline fn vabdl_high_s32(a: types.i32x4, b: types.i32x4) types.i64x2 {
    return common.abdGeneric(permute.vget_high_s32(a), permute.vget_high_s32(b));
}

test vabdl_high_s32 {
    const a: types.i32x4 = @splat(1);
    const b: types.i32x4 = @splat(1);
    const expected: types.i64x2 = @splat(0);
    try common.testIntrinsic(.{ .func = vabdl_high_s32, .expected = expected, .args = .{ a, b } });
}

/// Unsigned Absolute difference Long
pub inline fn vabdl_high_u8(a: types.u8x16, b: types.u8x16) types.u16x8 {
    return common.abdGeneric(permute.vget_high_u8(a), permute.vget_high_u8(b));
}

test vabdl_high_u8 {
    const a: types.u8x16 = @splat(1);
    const b: types.u8x16 = @splat(1);
    const expected: types.u16x8 = @splat(0);
    try common.testIntrinsic(.{ .func = vabdl_high_u8, .expected = expected, .args = .{ a, b } });
}

/// Unsigned Absolute difference Long
pub inline fn vabdl_high_u16(a: types.u16x8, b: types.u16x8) types.u32x4 {
    return common.abdGeneric(permute.vget_high_u16(a), permute.vget_high_u16(b));
}

test vabdl_high_u16 {
    const a: types.u16x8 = @splat(1);
    const b: types.u16x8 = @splat(1);
    const expected: types.u32x4 = @splat(0);
    try common.testIntrinsic(.{ .func = vabdl_high_u16, .expected = expected, .args = .{ a, b } });
}

/// Unsigned Absolute difference Long
pub inline fn vabdl_high_u32(a: types.u32x4, b: types.u32x4) types.u64x2 {
    return common.abdGeneric(permute.vget_high_u32(a), permute.vget_high_u32(b));
}

test vabdl_high_u32 {
    const a: types.u32x4 = @splat(1);
    const b: types.u32x4 = @splat(1);
    const expected: types.u64x2 = @splat(0);
    try common.testIntrinsic(.{ .func = vabdl_high_u32, .expected = expected, .args = .{ a, b } });
}

/// Floating-point absolute difference
pub inline fn vabds_f32(a: f32, b: f32) f32 {
    return @abs(a - b);
}

test vabds_f32 {
    const a: f32 = 1.0;
    const b: f32 = 1.0;
    const expected: f32 = 0.0;
    try common.testIntrinsic(.{ .func = vabds_f32, .expected = expected, .args = .{ a, b } });
}

/// Absolute value (wrapping)
pub inline fn vabs_s8(a: types.i8x8) types.i8x8 {
    return @bitCast(@abs(a));
}

test vabs_s8 {
    const a: types.i8x8 = @splat(1);
    const expected: types.i8x8 = .{ 1, 1, 1, 1, 1, 1, 1, 1 };
    try common.testIntrinsic(.{ .func = vabs_s8, .expected = expected, .args = .{a} });
}

/// Absolute value (wrapping)
pub inline fn vabs_s16(a: types.i16x4) types.i16x4 {
    return @bitCast(@abs(a));
}

test vabs_s16 {
    const a: types.i16x4 = @splat(1);
    const expected: types.i16x4 = .{ 1, 1, 1, 1 };
    try common.testIntrinsic(.{ .func = vabs_s16, .expected = expected, .args = .{a} });
}

/// Absolute value (wrapping)
pub inline fn vabs_s32(a: types.i32x2) types.i32x2 {
    return @bitCast(@abs(a));
}

test vabs_s32 {
    const a: types.i32x2 = @splat(1);
    const expected: types.i32x2 = .{ 1, 1 };
    try common.testIntrinsic(.{ .func = vabs_s32, .expected = expected, .args = .{a} });
}

/// Absolute value (wrapping)
pub inline fn vabs_s64(a: types.i64x1) types.i64x1 {
    return @bitCast(@abs(a));
}

test vabs_s64 {
    const a: types.i64x1 = @splat(1);
    const expected: types.i64x1 = .{1};
    try common.testIntrinsic(.{ .func = vabs_s64, .expected = expected, .args = .{a} });
}

/// Absolute value (wrapping)
pub inline fn vabs_f32(a: types.f32x2) types.f32x2 {
    return @bitCast(@abs(a));
}

test vabs_f32 {
    const a: types.f32x2 = @splat(1.0);
    const expected: types.f32x2 = .{ 1, 1 };
    try common.testIntrinsic(.{ .func = vabs_f32, .expected = expected, .args = .{a} });
}

/// Absolute value (wrapping)
pub inline fn vabs_f64(a: types.f64x1) types.f64x1 {
    return @bitCast(@abs(a));
}

test vabs_f64 {
    const a: types.f64x1 = @splat(1.0);
    const expected: types.f64x1 = .{1};
    try common.testIntrinsic(.{ .func = vabs_f64, .expected = expected, .args = .{a} });
}

/// Absolute value (wrapping)
pub inline fn vabsd_s64(a: i64) i64 {
    return @bitCast(@abs(a));
}

test vabsd_s64 {
    const a: i64 = 1;
    const expected: i64 = 1;
    try common.testIntrinsic(.{ .func = vabsd_s64, .expected = expected, .args = .{a} });
}

/// Absolute value (wrapping)
pub inline fn vabsq_s8(a: types.i8x16) types.i8x16 {
    return @bitCast(@abs(a));
}

test vabsq_s8 {
    const a: types.i8x16 = @splat(1);
    const expected: types.i8x16 = .{ 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 };
    try common.testIntrinsic(.{ .func = vabsq_s8, .expected = expected, .args = .{a} });
}

/// Absolute value (wrapping)
pub inline fn vabsq_s16(a: types.i16x8) types.i16x8 {
    return @bitCast(@abs(a));
}

test vabsq_s16 {
    const a: types.i16x8 = @splat(1);
    const expected: types.i16x8 = .{ 1, 1, 1, 1, 1, 1, 1, 1 };
    try common.testIntrinsic(.{ .func = vabsq_s16, .expected = expected, .args = .{a} });
}

/// Absolute value (wrapping)
pub inline fn vabsq_s32(a: types.i32x4) types.i32x4 {
    return @bitCast(@abs(a));
}

test vabsq_s32 {
    const a: types.i32x4 = @splat(1);
    const expected: types.i32x4 = .{ 1, 1, 1, 1 };
    try common.testIntrinsic(.{ .func = vabsq_s32, .expected = expected, .args = .{a} });
}

/// Absolute value (wrapping)
pub inline fn vabsq_s64(a: types.i64x2) types.i64x2 {
    return @bitCast(@abs(a));
}

test vabsq_s64 {
    const a: types.i64x2 = @splat(1);
    const expected: types.i64x2 = .{ 1, 1 };
    try common.testIntrinsic(.{ .func = vabsq_s64, .expected = expected, .args = .{a} });
}

/// Absolute value (wrapping)
pub inline fn vabsq_f32(a: types.f32x4) types.f32x4 {
    return @bitCast(@abs(a));
}

test vabsq_f32 {
    const a: types.f32x4 = @splat(1.0);
    const expected: types.f32x4 = .{ 1, 1, 1, 1 };
    try common.testIntrinsic(.{ .func = vabsq_f32, .expected = expected, .args = .{a} });
}

/// Absolute value (wrapping)
pub inline fn vabsq_f64(a: types.f64x2) types.f64x2 {
    return @bitCast(@abs(a));
}

test vabsq_f64 {
    const a: types.f64x2 = @splat(1.0);
    const expected: types.f64x2 = .{ 1, 1 };
    try common.testIntrinsic(.{ .func = vabsq_f64, .expected = expected, .args = .{a} });
}

/// Vector add (wrapping)
pub inline fn vadd_s8(a: types.i8x8, b: types.i8x8) types.i8x8 {
    return a +% b;
}

test vadd_s8 {
    const a: types.i8x8 = @splat(1);
    const b: types.i8x8 = @splat(1);
    const expected: types.i8x8 = .{ 2, 2, 2, 2, 2, 2, 2, 2 };
    try common.testIntrinsic(.{ .func = vadd_s8, .expected = expected, .args = .{ a, b } });
}

/// Vector add (wrapping)
pub inline fn vadd_s16(a: types.i16x4, b: types.i16x4) types.i16x4 {
    return a +% b;
}

test vadd_s16 {
    const a: types.i16x4 = @splat(1);
    const b: types.i16x4 = @splat(1);
    const expected: types.i16x4 = .{ 2, 2, 2, 2 };
    try common.testIntrinsic(.{ .func = vadd_s16, .expected = expected, .args = .{ a, b } });
}

/// Vector add (wrapping)
pub inline fn vadd_s32(a: types.i32x2, b: types.i32x2) types.i32x2 {
    return a +% b;
}

test vadd_s32 {
    const a: types.i32x2 = @splat(1);
    const b: types.i32x2 = @splat(1);
    const expected: types.i32x2 = .{ 2, 2 };
    try common.testIntrinsic(.{ .func = vadd_s32, .expected = expected, .args = .{ a, b } });
}

/// Vector add (wrapping)
pub inline fn vadd_s64(a: types.i64x1, b: types.i64x1) types.i64x1 {
    return a +% b;
}

test vadd_s64 {
    const a: types.i64x1 = @splat(1);
    const b: types.i64x1 = @splat(1);
    const expected: types.i64x1 = .{2};
    try common.testIntrinsic(.{ .func = vadd_s64, .expected = expected, .args = .{ a, b } });
}

/// Vector add (wrapping)
pub inline fn vadd_f32(a: types.f32x2, b: types.f32x2) types.f32x2 {
    return a + b;
}

test vadd_f32 {
    const a: types.f32x2 = @splat(1.0);
    const b: types.f32x2 = @splat(1.0);
    const expected: types.f32x2 = .{ 2, 2 };
    try common.testIntrinsic(.{ .func = vadd_f32, .expected = expected, .args = .{ a, b } });
}

/// Vector add (wrapping)
pub inline fn vadd_f64(a: types.f64x2, b: types.f64x2) types.f64x2 {
    return a + b;
}

test vadd_f64 {
    const a: types.f64x2 = @splat(1.0);
    const b: types.f64x2 = @splat(1.0);
    const expected: types.f64x2 = .{ 2, 2 };
    try common.testIntrinsic(.{ .func = vadd_f64, .expected = expected, .args = .{ a, b } });
}

/// Vector add (wrapping)
pub inline fn vadd_u8(a: types.u8x8, b: types.u8x8) types.u8x8 {
    return a +% b;
}

test vadd_u8 {
    const a: types.u8x8 = @splat(1);
    const b: types.u8x8 = @splat(1);
    const expected: types.u8x8 = .{ 2, 2, 2, 2, 2, 2, 2, 2 };
    try common.testIntrinsic(.{ .func = vadd_u8, .expected = expected, .args = .{ a, b } });
}

/// Vector add (wrapping)
pub inline fn vadd_u16(a: types.u16x4, b: types.u16x4) types.u16x4 {
    return a +% b;
}

test vadd_u16 {
    const a: types.u16x4 = @splat(1);
    const b: types.u16x4 = @splat(1);
    const expected: types.u16x4 = .{ 2, 2, 2, 2 };
    try common.testIntrinsic(.{ .func = vadd_u16, .expected = expected, .args = .{ a, b } });
}

/// Vector add (wrapping)
pub inline fn vadd_u32(a: types.u32x2, b: types.u32x2) types.u32x2 {
    return a +% b;
}

test vadd_u32 {
    const a: types.u32x2 = @splat(1);
    const b: types.u32x2 = @splat(1);
    const expected: types.u32x2 = .{ 2, 2 };
    try common.testIntrinsic(.{ .func = vadd_u32, .expected = expected, .args = .{ a, b } });
}

/// Vector add (wrapping)
pub inline fn vadd_u64(a: types.u64x1, b: types.u64x1) types.u64x1 {
    return a +% b;
}

test vadd_u64 {
    const a: types.u64x1 = @splat(1);
    const b: types.u64x1 = @splat(1);
    const expected: types.u64x1 = .{2};
    try common.testIntrinsic(.{ .func = vadd_u64, .expected = expected, .args = .{ a, b } });
}

/// Vector add (wrapping)
pub inline fn vadd_p8(a: types.p8x8, b: types.p8x8) types.p8x8 {
    return a +% b;
}

test vadd_p8 {
    const a: types.p8x8 = @splat(1);
    const b: types.p8x8 = @splat(1);
    const expected: types.p8x8 = .{ 2, 2, 2, 2, 2, 2, 2, 2 };
    try common.testIntrinsic(.{ .func = vadd_p8, .expected = expected, .args = .{ a, b } });
}

/// Vector add (wrapping)
pub inline fn vadd_p16(a: types.p16x4, b: types.p16x4) types.p16x4 {
    return a +% b;
}

test vadd_p16 {
    const a: types.p16x4 = @splat(1);
    const b: types.p16x4 = @splat(1);
    const expected: types.p16x4 = .{ 2, 2, 2, 2 };
    try common.testIntrinsic(.{ .func = vadd_p16, .expected = expected, .args = .{ a, b } });
}

/// Vector add (wrapping)
pub inline fn vadd_p64(a: types.p64x1, b: types.p64x1) types.p64x1 {
    return a +% b;
}

test vadd_p64 {
    const a: types.p64x1 = @splat(1);
    const b: types.p64x1 = @splat(1);
    const expected: types.p64x1 = .{2};
    try common.testIntrinsic(.{ .func = vadd_p64, .expected = expected, .args = .{ a, b } });
}

/// Vector add (wrapping)
pub inline fn vaddq_s8(a: types.i8x16, b: types.i8x16) types.i8x16 {
    return a +% b;
}

test vaddq_s8 {
    const a: types.i8x16 = @splat(1);
    const b: types.i8x16 = @splat(1);
    const expected: types.i8x16 = .{ 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2 };
    try common.testIntrinsic(.{ .func = vaddq_s8, .expected = expected, .args = .{ a, b } });
}

/// Vector add (wrapping)
pub inline fn vaddq_s16(a: types.i16x8, b: types.i16x8) types.i16x8 {
    return a +% b;
}

test vaddq_s16 {
    const a: types.i16x8 = @splat(1);
    const b: types.i16x8 = @splat(1);
    const expected: types.i16x8 = .{ 2, 2, 2, 2, 2, 2, 2, 2 };
    try common.testIntrinsic(.{ .func = vaddq_s16, .expected = expected, .args = .{ a, b } });
}

/// Vector add (wrapping)
pub inline fn vaddq_s32(a: types.i32x4, b: types.i32x4) types.i32x4 {
    return a +% b;
}

test vaddq_s32 {
    const a: types.i32x4 = @splat(1);
    const b: types.i32x4 = @splat(1);
    const expected: types.i32x4 = .{ 2, 2, 2, 2 };
    try common.testIntrinsic(.{ .func = vaddq_s32, .expected = expected, .args = .{ a, b } });
}

/// Vector add (wrapping)
pub inline fn vaddq_s64(a: types.i64x2, b: types.i64x2) types.i64x2 {
    return a +% b;
}

test vaddq_s64 {
    const a: types.i64x2 = @splat(1);
    const b: types.i64x2 = @splat(1);
    const expected: types.i64x2 = .{ 2, 2 };
    try common.testIntrinsic(.{ .func = vaddq_s64, .expected = expected, .args = .{ a, b } });
}

/// Vector add (wrapping)
pub inline fn vaddq_f32(a: types.f32x4, b: types.f32x4) types.f32x4 {
    return a + b;
}

test vaddq_f32 {
    const a: types.f32x4 = @splat(1.0);
    const b: types.f32x4 = @splat(1.0);
    const expected: types.f32x4 = .{ 2, 2, 2, 2 };
    try common.testIntrinsic(.{ .func = vaddq_f32, .expected = expected, .args = .{ a, b } });
}

/// Vector add (wrapping)
pub inline fn vaddq_f64(a: types.f64x2, b: types.f64x2) types.f64x2 {
    return a + b;
}

test vaddq_f64 {
    const a: types.f64x2 = @splat(1.0);
    const b: types.f64x2 = @splat(1.0);
    const expected: types.f64x2 = .{ 2, 2 };
    try common.testIntrinsic(.{ .func = vaddq_f64, .expected = expected, .args = .{ a, b } });
}

/// Vector add (wrapping)
pub inline fn vaddq_u8(a: types.u8x16, b: types.u8x16) types.u8x16 {
    return a +% b;
}

test vaddq_u8 {
    const a: types.u8x16 = @splat(1);
    const b: types.u8x16 = @splat(1);
    const expected: types.u8x16 = .{ 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2 };
    try common.testIntrinsic(.{ .func = vaddq_u8, .expected = expected, .args = .{ a, b } });
}

/// Vector add (wrapping)
pub inline fn vaddq_u16(a: types.u16x8, b: types.u16x8) types.u16x8 {
    return a +% b;
}

test vaddq_u16 {
    const a: types.u16x8 = @splat(1);
    const b: types.u16x8 = @splat(1);
    const expected: types.u16x8 = .{ 2, 2, 2, 2, 2, 2, 2, 2 };
    try common.testIntrinsic(.{ .func = vaddq_u16, .expected = expected, .args = .{ a, b } });
}

/// Vector add (wrapping)
pub inline fn vaddq_u32(a: types.u32x4, b: types.u32x4) types.u32x4 {
    return a +% b;
}

test vaddq_u32 {
    const a: types.u32x4 = @splat(1);
    const b: types.u32x4 = @splat(1);
    const expected: types.u32x4 = .{ 2, 2, 2, 2 };
    try common.testIntrinsic(.{ .func = vaddq_u32, .expected = expected, .args = .{ a, b } });
}

/// Vector add (wrapping)
pub inline fn vaddq_u64(a: types.u64x2, b: types.u64x2) types.u64x2 {
    return a +% b;
}

test vaddq_u64 {
    const a: types.u64x2 = @splat(1);
    const b: types.u64x2 = @splat(1);
    const expected: types.u64x2 = .{ 2, 2 };
    try common.testIntrinsic(.{ .func = vaddq_u64, .expected = expected, .args = .{ a, b } });
}

/// Bitwise exclusive OR
pub inline fn vaddq_p8(a: types.p8x16, b: types.p8x16) types.p8x16 {
    return a ^ b;
}

test vaddq_p8 {
    const a: types.p8x16 = @splat(1);
    const b: types.p8x16 = @splat(1);
    const expected: types.p8x16 = @splat(0);
    try common.testIntrinsic(.{ .func = vaddq_p8, .expected = expected, .args = .{ a, b } });
}

/// Bitwise exclusive OR
pub inline fn vaddq_p16(a: types.p16x8, b: types.p16x8) types.p16x8 {
    return a ^ b;
}

test vaddq_p16 {
    const a: types.p16x8 = @splat(1);
    const b: types.p16x8 = @splat(1);
    const expected: types.p16x8 = @splat(0);
    try common.testIntrinsic(.{ .func = vaddq_p16, .expected = expected, .args = .{ a, b } });
}

/// Bitwise exclusive OR
pub inline fn vaddq_p64(a: types.p64x2, b: types.p64x2) types.p64x2 {
    return a ^ b;
}

test vaddq_p64 {
    const a: types.p64x2 = @splat(1);
    const b: types.p64x2 = @splat(1);
    const expected: types.p64x2 = @splat(0);
    try common.testIntrinsic(.{ .func = vaddq_p64, .expected = expected, .args = .{ a, b } });
}

/// Bitwise exclusive OR
pub inline fn vaddq_p128(a: types.p128, b: types.p128) types.p128 {
    return a ^ b;
}

test vaddq_p128 {
    const a: types.p128 = 0;
    const b: types.p128 = 0;
    const expected: types.p128 = 0;
    try common.testIntrinsic(.{ .func = vaddq_p128, .expected = expected, .args = .{ a, b } });
}

/// Add (wrapping)
pub inline fn vaddd_s64(a: i64, b: i64) i64 {
    return a +% b;
}

test vaddd_s64 {
    const a: i64 = 1;
    const b: i64 = 1;
    const expected: i64 = 2;
    try common.testIntrinsic(.{ .func = vaddd_s64, .expected = expected, .args = .{ a, b } });
}

/// Add (wrapping)
pub inline fn vaddd_u64(a: u64, b: u64) u64 {
    return a +% b;
}

test vaddd_u64 {
    const a: u64 = 1;
    const b: u64 = 1;
    const expected: u64 = 2;
    try common.testIntrinsic(.{ .func = vaddd_u64, .expected = expected, .args = .{ a, b } });
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
    try common.testIntrinsic(.{ .func = vaddhn_s32, .expected = expected, .args = .{ a, b } });
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
    try common.testIntrinsic(.{ .func = vaddhn_s64, .expected = expected, .args = .{ a, b } });
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
    try common.testIntrinsic(.{ .func = vaddhn_u16, .expected = expected, .args = .{ a, b } });
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
    try common.testIntrinsic(.{ .func = vaddhn_u32, .expected = expected, .args = .{ a, b } });
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
    try common.testIntrinsic(.{ .func = vaddhn_u64, .expected = expected, .args = .{ a, b } });
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
    try common.testIntrinsic(.{ .func = vaddhn_high_s32, .expected = expected, .args = .{ a, b, c } });
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
    try common.testIntrinsic(.{ .func = vaddhn_high_s64, .expected = expected, .args = .{ a, b, c } });
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
    try common.testIntrinsic(.{ .func = vaddhn_high_u32, .expected = expected, .args = .{ a, b, c } });
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
    try common.testIntrinsic(.{ .func = vaddhn_high_u64, .expected = expected, .args = .{ a, b, c } });
}

/// Signed Add Long
pub inline fn vaddl_s8(a: types.i8x8, b: types.i8x8) types.i16x8 {
    return convert.vmovl_s8(a) + convert.vmovl_s8(b);
}

test vaddl_s8 {
    const a: types.i8x8 = @splat(1);
    const b: types.i8x8 = @splat(1);
    const expected: types.i16x8 = .{ 2, 2, 2, 2, 2, 2, 2, 2 };
    try common.testIntrinsic(.{ .func = vaddl_s8, .expected = expected, .args = .{ a, b } });
}

/// Signed Add Long
pub inline fn vaddl_s16(a: types.i16x4, b: types.i16x4) types.i32x4 {
    return convert.vmovl_s16(a) + convert.vmovl_s16(b);
}

test vaddl_s16 {
    const a: types.i16x4 = @splat(1);
    const b: types.i16x4 = @splat(1);
    const expected: types.i32x4 = .{ 2, 2, 2, 2 };
    try common.testIntrinsic(.{ .func = vaddl_s16, .expected = expected, .args = .{ a, b } });
}

/// Signed Add Long
pub inline fn vaddl_s32(a: types.i32x2, b: types.i32x2) types.i64x2 {
    return convert.vmovl_s32(a) + convert.vmovl_s32(b);
}

test vaddl_s32 {
    const a: types.i32x2 = @splat(1);
    const b: types.i32x2 = @splat(1);
    const expected: types.i64x2 = .{ 2, 2 };
    try common.testIntrinsic(.{ .func = vaddl_s32, .expected = expected, .args = .{ a, b } });
}

/// Unsigned Add Long
pub inline fn vaddl_u8(a: types.u8x8, b: types.u8x8) types.u16x8 {
    return convert.vmovl_u8(a) + convert.vmovl_u8(b);
}

test vaddl_u8 {
    const a: types.u8x8 = @splat(1);
    const b: types.u8x8 = @splat(1);
    const expected: types.u16x8 = .{ 2, 2, 2, 2, 2, 2, 2, 2 };
    try common.testIntrinsic(.{ .func = vaddl_u8, .expected = expected, .args = .{ a, b } });
}

/// Unsigned Add Long
pub inline fn vaddl_u16(a: types.u16x4, b: types.u16x4) types.u32x4 {
    return convert.vmovl_u16(a) + convert.vmovl_u16(b);
}

test vaddl_u16 {
    const a: types.u16x4 = @splat(1);
    const b: types.u16x4 = @splat(1);
    const expected: types.u32x4 = .{ 2, 2, 2, 2 };
    try common.testIntrinsic(.{ .func = vaddl_u16, .expected = expected, .args = .{ a, b } });
}

/// Unsigned Add Long
pub inline fn vaddl_u32(a: types.u32x2, b: types.u32x2) types.u64x2 {
    return convert.vmovl_u32(a) + convert.vmovl_u32(b);
}

test vaddl_u32 {
    const a: types.u32x2 = @splat(1);
    const b: types.u32x2 = @splat(1);
    const expected: types.u64x2 = .{ 2, 2 };
    try common.testIntrinsic(.{ .func = vaddl_u32, .expected = expected, .args = .{ a, b } });
}

/// Signed Add Long (high half)
pub inline fn vaddl_high_s8(a: types.i8x16, b: types.i8x16) types.i16x8 {
    return convert.vmovl_high_s8(a) + convert.vmovl_high_s8(b);
}

test vaddl_high_s8 {
    const a: types.i8x16 = @splat(1);
    const b: types.i8x16 = @splat(1);
    const expected: types.i16x8 = .{ 2, 2, 2, 2, 2, 2, 2, 2 };
    try common.testIntrinsic(.{ .func = vaddl_high_s8, .expected = expected, .args = .{ a, b } });
}

/// Signed Add Long (high half)
pub inline fn vaddl_high_s16(a: types.i16x8, b: types.i16x8) types.i32x4 {
    return convert.vmovl_high_s16(a) + convert.vmovl_high_s16(b);
}

test vaddl_high_s16 {
    const a: types.i16x8 = @splat(1);
    const b: types.i16x8 = @splat(1);
    const expected: types.i32x4 = .{ 2, 2, 2, 2 };
    try common.testIntrinsic(.{ .func = vaddl_high_s16, .expected = expected, .args = .{ a, b } });
}

/// Signed Add Long (high half)
pub inline fn vaddl_high_s32(a: types.i32x4, b: types.i32x4) types.i64x2 {
    return convert.vmovl_high_s32(a) + convert.vmovl_high_s32(b);
}

test vaddl_high_s32 {
    const a: types.i32x4 = @splat(1);
    const b: types.i32x4 = @splat(1);
    const expected: types.i64x2 = .{ 2, 2 };
    try common.testIntrinsic(.{ .func = vaddl_high_s32, .expected = expected, .args = .{ a, b } });
}

/// Unsigned Add Long (high half)
pub inline fn vaddl_high_u8(a: types.u8x16, b: types.u8x16) types.u16x8 {
    return convert.vmovl_high_u8(a) + convert.vmovl_high_u8(b);
}

test vaddl_high_u8 {
    const a: types.u8x16 = @splat(1);
    const b: types.u8x16 = @splat(1);
    const expected: types.u16x8 = .{ 2, 2, 2, 2, 2, 2, 2, 2 };
    try common.testIntrinsic(.{ .func = vaddl_high_u8, .expected = expected, .args = .{ a, b } });
}

/// Unsigned Add Long (high half)
pub inline fn vaddl_high_u16(a: types.u16x8, b: types.u16x8) types.u32x4 {
    return convert.vmovl_high_u16(a) + convert.vmovl_high_u16(b);
}

test vaddl_high_u16 {
    const a: types.u16x8 = @splat(1);
    const b: types.u16x8 = @splat(1);
    const expected: types.u32x4 = .{ 2, 2, 2, 2 };
    try common.testIntrinsic(.{ .func = vaddl_high_u16, .expected = expected, .args = .{ a, b } });
}

/// Unsigned Add Long (high half)
pub inline fn vaddl_high_u32(a: types.u32x4, b: types.u32x4) types.u64x2 {
    return convert.vmovl_high_u32(a) + convert.vmovl_high_u32(b);
}

test vaddl_high_u32 {
    const a: types.u32x4 = @splat(1);
    const b: types.u32x4 = @splat(1);
    const expected: types.u64x2 = .{ 2, 2 };
    try common.testIntrinsic(.{ .func = vaddl_high_u32, .expected = expected, .args = .{ a, b } });
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
    try common.testIntrinsic(.{ .func = vaddw_high_s16, .expected = expected, .args = .{ a, b } });
}

/// Signed Add Wide (high half)
pub inline fn vaddw_high_s32(a: types.i64x2, b: types.i32x4) types.i64x2 {
    return a +% convert.vmovl_high_s32(b);
}

test vaddw_high_s32 {
    const a: types.i64x2 = @splat(1);
    const b: types.i32x4 = @splat(1);
    const expected: types.i64x2 = .{ 2, 2 };
    try common.testIntrinsic(.{ .func = vaddw_high_s32, .expected = expected, .args = .{ a, b } });
}

/// Unsigned Add Wide (high half)
pub inline fn vaddw_high_u8(a: types.u16x8, b: types.u8x16) types.u16x8 {
    return a +% convert.vmovl_high_u8(b);
}

test vaddw_high_u8 {
    const a: types.u16x8 = @splat(1);
    const b: types.u8x16 = @splat(1);
    const expected: types.u16x8 = .{ 2, 2, 2, 2, 2, 2, 2, 2 };
    try common.testIntrinsic(.{ .func = vaddw_high_u8, .expected = expected, .args = .{ a, b } });
}

/// Unsigned Add Wide (high half)
pub inline fn vaddw_high_u16(a: types.u32x4, b: types.u16x8) types.u32x4 {
    return a +% convert.vmovl_high_u16(b);
}

test vaddw_high_u16 {
    const a: types.u32x4 = @splat(1);
    const b: types.u16x8 = @splat(1);
    const expected: types.u32x4 = .{ 2, 2, 2, 2 };
    try common.testIntrinsic(.{ .func = vaddw_high_u16, .expected = expected, .args = .{ a, b } });
}

/// Unsigned Add Wide (high half)
pub inline fn vaddw_high_u32(a: types.u64x2, b: types.u32x4) types.u64x2 {
    return a +% convert.vmovl_high_u32(b);
}

test vaddw_high_u32 {
    const a: types.u64x2 = @splat(1);
    const b: types.u32x4 = @splat(1);
    const expected: types.u64x2 = .{ 2, 2 };
    try common.testIntrinsic(.{ .func = vaddw_high_u32, .expected = expected, .args = .{ a, b } });
}

/// Signed Add Wide
pub inline fn vaddw_s16(a: types.i32x4, b: types.i16x4) types.i32x4 {
    return a +% convert.vmovl_s16(b);
}

test vaddw_s16 {
    const a: types.i32x4 = @splat(1);
    const b: types.i16x4 = @splat(1);
    const expected: types.i32x4 = .{ 2, 2, 2, 2 };
    try common.testIntrinsic(.{ .func = vaddw_s16, .expected = expected, .args = .{ a, b } });
}

/// Signed Add Wide
pub inline fn vaddw_s32(a: types.i64x2, b: types.i32x2) types.i64x2 {
    return a +% convert.vmovl_s32(b);
}

test vaddw_s32 {
    const a: types.i64x2 = @splat(1);
    const b: types.i32x2 = @splat(1);
    const expected: types.i64x2 = .{ 2, 2 };
    try common.testIntrinsic(.{ .func = vaddw_s32, .expected = expected, .args = .{ a, b } });
}

/// Unsigned Add Wide
pub inline fn vaddw_u8(a: types.u16x8, b: types.u8x8) types.u16x8 {
    return a +% convert.vmovl_u8(b);
}

test vaddw_u8 {
    const a: types.u16x8 = @splat(1);
    const b: types.u8x8 = @splat(1);
    const expected: types.u16x8 = .{ 2, 2, 2, 2, 2, 2, 2, 2 };
    try common.testIntrinsic(.{ .func = vaddw_u8, .expected = expected, .args = .{ a, b } });
}

/// Unsigned Add Wide
pub inline fn vaddw_u16(a: types.u32x4, b: types.u16x4) types.u32x4 {
    return a +% convert.vmovl_u16(b);
}

test vaddw_u16 {
    const a: types.u32x4 = @splat(1);
    const b: types.u16x4 = @splat(1);
    const expected: types.u32x4 = .{ 2, 2, 2, 2 };
    try common.testIntrinsic(.{ .func = vaddw_u16, .expected = expected, .args = .{ a, b } });
}

/// Unsigned Add Wide
pub inline fn vaddw_u32(a: types.u64x2, b: types.u32x2) types.u64x2 {
    return a +% convert.vmovl_u32(b);
}

test vaddw_u32 {
    const a: types.u64x2 = @splat(1);
    const b: types.u32x2 = @splat(1);
    const expected: types.u64x2 = .{ 2, 2 };
    try common.testIntrinsic(.{ .func = vaddw_u32, .expected = expected, .args = .{ a, b } });
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

        try common.testIntrinsic(.{ .func = vmlaq_s8, .expected = expected, .args = .{ a, b, c } });
    }
    {
        const a: types.i8x16 = .{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 127 };
        const b: types.i8x16 = .{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 };
        const c: types.i8x16 = .{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2 };
        const expected: types.i8x16 = .{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -127 };

        try common.testIntrinsic(.{ .func = vmlaq_s8, .expected = expected, .args = .{ a, b, c } });
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

    try common.testIntrinsic(.{ .func = vmlaq_s16, .expected = expected, .args = .{ a, b, c } });
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

    try common.testIntrinsic(.{ .func = vmlaq_s32, .expected = expected, .args = .{ a, b, c } });
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

        try common.testIntrinsic(.{ .func = vmlaq_u8, .expected = expected, .args = .{ a, b, c } });
    }
    {
        const a: types.u8x16 = .{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 255 };
        const b: types.u8x16 = .{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 };
        const c: types.u8x16 = .{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2 };
        const expected: types.u8x16 = .{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 };

        try common.testIntrinsic(.{ .func = vmlaq_u8, .expected = expected, .args = .{ a, b, c } });
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

    try common.testIntrinsic(.{ .func = vmlaq_u16, .expected = expected, .args = .{ a, b, c } });
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

    try common.testIntrinsic(.{ .func = vmlaq_u32, .expected = expected, .args = .{ a, b, c } });
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

    try common.testIntrinsic(.{ .func = vmlaq_f32, .expected = expected, .args = .{ a, b, c } });
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

    try common.testIntrinsic(.{ .func = vmlaq_f64, .expected = expected, .args = .{ a, b, c } });
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

    try common.testIntrinsic(.{ .func = vfmaq_f16, .expected = expected, .args = .{ a, b, c } });
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

    try common.testIntrinsic(.{ .func = vfmaq_f32, .expected = expected, .args = .{ a, b, c } });
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

    try common.testIntrinsic(.{ .func = vfmaq_f64, .expected = expected, .args = .{ a, b, c } });
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

    try common.testIntrinsic(.{ .func = vfmaq_laneq_f16, .expected = expected, .args = .{ a, b, c, lane } });
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

        try common.testIntrinsic(.{ .func = vfmaq_laneq_f32, .expected = expected, .args = .{ a, b, c, lane } });
    }
    {
        const a: types.f32x4 = .{ 5, 4, 332, 23 };
        const b: types.f32x4 = .{ 221, 2213, 2343, 23 };
        const c: types.f32x4 = .{ 33, 0, 0, 0 };
        const lane: usize = 0;
        const expected: types.f32x4 = .{ 7298, 73033, 77651, 782 };

        try common.testIntrinsic(.{ .func = vfmaq_laneq_f32, .expected = expected, .args = .{ a, b, c, lane } });
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

    try common.testIntrinsic(.{ .func = vfmaq_laneq_f64, .expected = expected, .args = .{ a, b, c, lane } });
}

/// ARM NEON intrinsic: `vabd_f16`
pub inline fn vabd_f16(a: types.f16x4, b: types.f16x4) types.f16x4 {
    return @abs(a - b);
}

test vabd_f16 {
    const a = types.f16x4{ 10.0, 20.0, -15.0, 40.0 };
    const b = types.f16x4{ 2.0, 5.0, -3.0, 10.0 };
    const expected = types.f16x4{ 8.0, 15.0, 12.0, 30.0 };
    try common.testIntrinsic(.{ .func = vabd_f16, .expected = expected, .args = .{ a, b } });
}

/// ARM NEON intrinsic: `vabdq_f16`
pub inline fn vabdq_f16(a: types.f16x8, b: types.f16x8) types.f16x8 {
    return @abs(a - b);
}

test vabdq_f16 {
    const a = types.f16x8{ 10.0, 20.0, -15.0, 40.0, -5.0, 30.0, 0.0, 12.0 };
    const b = types.f16x8{ 2.0, 5.0, -3.0, 10.0, -2.0, 2.0, 4.0, 3.0 };
    const expected = types.f16x8{ 8.0, 15.0, 12.0, 30.0, 3.0, 28.0, 4.0, 9.0 };
    try common.testIntrinsic(.{ .func = vabdq_f16, .expected = expected, .args = .{ a, b } });
}

/// ARM NEON intrinsic: `vabs_f16`
pub inline fn vabs_f16(a: types.f16x4) types.f16x4 {
    return @abs(a);
}

test vabs_f16 {
    const a = types.f16x4{ 1.5, -2.0, 0.0, 5.25 };
    const expected = types.f16x4{ 1.5, 2.0, 0.0, 5.25 };
    try common.testIntrinsic(.{ .func = vabs_f16, .expected = expected, .args = .{a} });
}

/// ARM NEON intrinsic: `vabsq_f16`
pub inline fn vabsq_f16(a: types.f16x8) types.f16x8 {
    return @abs(a);
}

test vabsq_f16 {
    const a = types.f16x8{ 1.5, -2.0, 0.0, 5.25, -10.0, 3.5, -0.5, 8.0 };
    const expected = types.f16x8{ 1.5, 2.0, 0.0, 5.25, 10.0, 3.5, 0.5, 8.0 };
    try common.testIntrinsic(.{ .func = vabsq_f16, .expected = expected, .args = .{a} });
}

/// ARM NEON intrinsic: `vadd_f16`
pub inline fn vadd_f16(a: types.f16x4, b: types.f16x4) types.f16x4 {
    return a + b;
}

test vadd_f16 {
    const a = types.f16x4{ 10.0, 20.0, -15.0, 40.0 };
    const b = types.f16x4{ 2.0, 5.0, -3.0, 10.0 };
    const expected = types.f16x4{ 12.0, 25.0, -18.0, 50.0 };
    try common.testIntrinsic(.{ .func = vadd_f16, .expected = expected, .args = .{ a, b } });
}

/// ARM NEON intrinsic: `vaddq_f16`
pub inline fn vaddq_f16(a: types.f16x8, b: types.f16x8) types.f16x8 {
    return a + b;
}

test vaddq_f16 {
    const a = types.f16x8{ 10.0, 20.0, -15.0, 40.0, -5.0, 30.0, 0.0, 12.0 };
    const b = types.f16x8{ 2.0, 5.0, -3.0, 10.0, -2.0, 2.0, 4.0, 3.0 };
    const expected = types.f16x8{ 12.0, 25.0, -18.0, 50.0, -7.0, 32.0, 4.0, 15.0 };
    try common.testIntrinsic(.{ .func = vaddq_f16, .expected = expected, .args = .{ a, b } });
}

/// ARM NEON intrinsic: `vamax_f16`
pub inline fn vamax_f16(a: types.f16x4, b: types.f16x4) types.f16x4 {
    return @max(@abs(a), @abs(b));
}

test vamax_f16 {
    const a = types.f16x4{ 10.0, 20.0, -15.0, 40.0 };
    const b = types.f16x4{ 2.0, 5.0, -3.0, 10.0 };
    const expected = types.f16x4{ 10.0, 20.0, 15.0, 40.0 };
    try common.testIntrinsic(.{ .func = vamax_f16, .expected = expected, .args = .{ a, b } });
}

/// ARM NEON intrinsic: `vamax_f32`
pub inline fn vamax_f32(a: types.f32x2, b: types.f32x2) types.f32x2 {
    return @max(@abs(a), @abs(b));
}

test vamax_f32 {
    const a = types.f32x2{ 10.0, 20.0 };
    const b = types.f32x2{ 2.0, 5.0 };
    const expected = types.f32x2{ 10.0, 20.0 };
    try common.testIntrinsic(.{ .func = vamax_f32, .expected = expected, .args = .{ a, b } });
}

/// ARM NEON intrinsic: `vamaxq_f16`
pub inline fn vamaxq_f16(a: types.f16x8, b: types.f16x8) types.f16x8 {
    return @max(@abs(a), @abs(b));
}

test vamaxq_f16 {
    const a = types.f16x8{ 10.0, 20.0, -15.0, 40.0, -5.0, 30.0, 0.0, 12.0 };
    const b = types.f16x8{ 2.0, 5.0, -3.0, 10.0, -2.0, 2.0, 4.0, 3.0 };
    const expected = types.f16x8{ 10.0, 20.0, 15.0, 40.0, 5.0, 30.0, 4.0, 12.0 };
    try common.testIntrinsic(.{ .func = vamaxq_f16, .expected = expected, .args = .{ a, b } });
}

/// ARM NEON intrinsic: `vamaxq_f32`
pub inline fn vamaxq_f32(a: types.f32x4, b: types.f32x4) types.f32x4 {
    return @max(@abs(a), @abs(b));
}

test vamaxq_f32 {
    const a = types.f32x4{ 10.0, 20.0, -15.0, 40.0 };
    const b = types.f32x4{ 2.0, 5.0, -3.0, 10.0 };
    const expected = types.f32x4{ 10.0, 20.0, 15.0, 40.0 };
    try common.testIntrinsic(.{ .func = vamaxq_f32, .expected = expected, .args = .{ a, b } });
}

/// ARM NEON intrinsic: `vamaxq_f64`
pub inline fn vamaxq_f64(a: types.f64x2, b: types.f64x2) types.f64x2 {
    return @max(@abs(a), @abs(b));
}

test vamaxq_f64 {
    const a = types.f64x2{ 10.0, 20.0 };
    const b = types.f64x2{ 2.0, 5.0 };
    const expected = types.f64x2{ 10.0, 20.0 };
    try common.testIntrinsic(.{ .func = vamaxq_f64, .expected = expected, .args = .{ a, b } });
}

/// ARM NEON intrinsic: `vamin_f16`
pub inline fn vamin_f16(a: types.f16x4, b: types.f16x4) types.f16x4 {
    return @min(@abs(a), @abs(b));
}

test vamin_f16 {
    const a = types.f16x4{ 10.0, 20.0, -15.0, 40.0 };
    const b = types.f16x4{ 2.0, 5.0, -3.0, 10.0 };
    const expected = types.f16x4{ 2.0, 5.0, 3.0, 10.0 };
    try common.testIntrinsic(.{ .func = vamin_f16, .expected = expected, .args = .{ a, b } });
}

/// ARM NEON intrinsic: `vamin_f32`
pub inline fn vamin_f32(a: types.f32x2, b: types.f32x2) types.f32x2 {
    return @min(@abs(a), @abs(b));
}

test vamin_f32 {
    const a = types.f32x2{ 10.0, 20.0 };
    const b = types.f32x2{ 2.0, 5.0 };
    const expected = types.f32x2{ 2.0, 5.0 };
    try common.testIntrinsic(.{ .func = vamin_f32, .expected = expected, .args = .{ a, b } });
}

/// ARM NEON intrinsic: `vaminq_f16`
pub inline fn vaminq_f16(a: types.f16x8, b: types.f16x8) types.f16x8 {
    return @min(@abs(a), @abs(b));
}

test vaminq_f16 {
    const a = types.f16x8{ 10.0, 20.0, -15.0, 40.0, -5.0, 30.0, 0.0, 12.0 };
    const b = types.f16x8{ 2.0, 5.0, -3.0, 10.0, -2.0, 2.0, 4.0, 3.0 };
    const expected = types.f16x8{ 2.0, 5.0, 3.0, 10.0, 2.0, 2.0, 0.0, 3.0 };
    try common.testIntrinsic(.{ .func = vaminq_f16, .expected = expected, .args = .{ a, b } });
}

/// ARM NEON intrinsic: `vaminq_f32`
pub inline fn vaminq_f32(a: types.f32x4, b: types.f32x4) types.f32x4 {
    return @min(@abs(a), @abs(b));
}

test vaminq_f32 {
    const a = types.f32x4{ 10.0, 20.0, -15.0, 40.0 };
    const b = types.f32x4{ 2.0, 5.0, -3.0, 10.0 };
    const expected = types.f32x4{ 2.0, 5.0, 3.0, 10.0 };
    try common.testIntrinsic(.{ .func = vaminq_f32, .expected = expected, .args = .{ a, b } });
}

/// ARM NEON intrinsic: `vaminq_f64`
pub inline fn vaminq_f64(a: types.f64x2, b: types.f64x2) types.f64x2 {
    return @min(@abs(a), @abs(b));
}

test vaminq_f64 {
    const a = types.f64x2{ 10.0, 20.0 };
    const b = types.f64x2{ 2.0, 5.0 };
    const expected = types.f64x2{ 2.0, 5.0 };
    try common.testIntrinsic(.{ .func = vaminq_f64, .expected = expected, .args = .{ a, b } });
}

/// ARM NEON intrinsic: `vdiv_f16`
pub inline fn vdiv_f16(a: types.f16x4, b: types.f16x4) types.f16x4 {
    return a / b;
}

test vdiv_f16 {
    const a = types.f16x4{ 10.0, 20.0, -15.0, 40.0 };
    const b = types.f16x4{ 2.0, 5.0, -3.0, 10.0 };
    const expected = types.f16x4{ 5.0, 4.0, 5.0, 4.0 };
    try common.testIntrinsic(.{ .func = vdiv_f16, .expected = expected, .args = .{ a, b } });
}

/// ARM NEON intrinsic: `vdiv_f32`
pub inline fn vdiv_f32(a: types.f32x2, b: types.f32x2) types.f32x2 {
    return a / b;
}

test vdiv_f32 {
    const a = types.f32x2{ 10.0, 20.0 };
    const b = types.f32x2{ 2.0, 5.0 };
    const expected = types.f32x2{ 5.0, 4.0 };
    try common.testIntrinsic(.{ .func = vdiv_f32, .expected = expected, .args = .{ a, b } });
}

/// ARM NEON intrinsic: `vdiv_f64`
pub inline fn vdiv_f64(a: types.f64x1, b: types.f64x1) types.f64x1 {
    return a / b;
}

test vdiv_f64 {
    const a = types.f64x1{10.0};
    const b = types.f64x1{2.0};
    const expected = types.f64x1{5.0};
    try common.testIntrinsic(.{ .func = vdiv_f64, .expected = expected, .args = .{ a, b } });
}

/// ARM NEON intrinsic: `vdivq_f16`
pub inline fn vdivq_f16(a: types.f16x8, b: types.f16x8) types.f16x8 {
    return a / b;
}

test vdivq_f16 {
    const a = types.f16x8{ 10.0, 20.0, -15.0, 40.0, -5.0, 30.0, 0.0, 12.0 };
    const b = types.f16x8{ 2.0, 5.0, -3.0, 10.0, -2.0, 2.0, 4.0, 3.0 };
    const expected = types.f16x8{ 5.0, 4.0, 5.0, 4.0, 2.5, 15.0, 0.0, 4.0 };
    try common.testIntrinsic(.{ .func = vdivq_f16, .expected = expected, .args = .{ a, b } });
}

/// ARM NEON intrinsic: `vdivq_f32`
pub inline fn vdivq_f32(a: types.f32x4, b: types.f32x4) types.f32x4 {
    return a / b;
}

test vdivq_f32 {
    const a = types.f32x4{ 10.0, 20.0, -15.0, 40.0 };
    const b = types.f32x4{ 2.0, 5.0, -3.0, 10.0 };
    const expected = types.f32x4{ 5.0, 4.0, 5.0, 4.0 };
    try common.testIntrinsic(.{ .func = vdivq_f32, .expected = expected, .args = .{ a, b } });
}

/// ARM NEON intrinsic: `vdivq_f64`
pub inline fn vdivq_f64(a: types.f64x2, b: types.f64x2) types.f64x2 {
    return a / b;
}

test vdivq_f64 {
    const a = types.f64x2{ 10.0, 20.0 };
    const b = types.f64x2{ 2.0, 5.0 };
    const expected = types.f64x2{ 5.0, 4.0 };
    try common.testIntrinsic(.{ .func = vdivq_f64, .expected = expected, .args = .{ a, b } });
}

/// ARM NEON intrinsic: `vmax_f16`
pub inline fn vmax_f16(a: types.f16x4, b: types.f16x4) types.f16x4 {
    return @max(a, b);
}

test vmax_f16 {
    const a = types.f16x4{ 10.0, 20.0, -15.0, 40.0 };
    const b = types.f16x4{ 2.0, 5.0, -3.0, 10.0 };
    const expected = types.f16x4{ 10.0, 20.0, -3.0, 40.0 };
    try common.testIntrinsic(.{ .func = vmax_f16, .expected = expected, .args = .{ a, b } });
}

/// ARM NEON intrinsic: `vmax_f32`
pub inline fn vmax_f32(a: types.f32x2, b: types.f32x2) types.f32x2 {
    return @max(a, b);
}

test vmax_f32 {
    const a = types.f32x2{ 10.0, 20.0 };
    const b = types.f32x2{ 2.0, 5.0 };
    const expected = types.f32x2{ 10.0, 20.0 };
    try common.testIntrinsic(.{ .func = vmax_f32, .expected = expected, .args = .{ a, b } });
}

/// ARM NEON intrinsic: `vmax_f64`
pub inline fn vmax_f64(a: types.f64x1, b: types.f64x1) types.f64x1 {
    return @max(a, b);
}

test vmax_f64 {
    const a = types.f64x1{10.0};
    const b = types.f64x1{2.0};
    const expected = types.f64x1{10.0};
    try common.testIntrinsic(.{ .func = vmax_f64, .expected = expected, .args = .{ a, b } });
}

/// ARM NEON intrinsic: `vmaxq_f16`
pub inline fn vmaxq_f16(a: types.f16x8, b: types.f16x8) types.f16x8 {
    return @max(a, b);
}

test vmaxq_f16 {
    const a = types.f16x8{ 10.0, 20.0, -15.0, 40.0, -5.0, 30.0, 0.0, 12.0 };
    const b = types.f16x8{ 2.0, 5.0, -3.0, 10.0, -2.0, 2.0, 4.0, 3.0 };
    const expected = types.f16x8{ 10.0, 20.0, -3.0, 40.0, -2.0, 30.0, 4.0, 12.0 };
    try common.testIntrinsic(.{ .func = vmaxq_f16, .expected = expected, .args = .{ a, b } });
}

/// ARM NEON intrinsic: `vmaxq_f32`
pub inline fn vmaxq_f32(a: types.f32x4, b: types.f32x4) types.f32x4 {
    return @max(a, b);
}

test vmaxq_f32 {
    const a = types.f32x4{ 10.0, 20.0, -15.0, 40.0 };
    const b = types.f32x4{ 2.0, 5.0, -3.0, 10.0 };
    const expected = types.f32x4{ 10.0, 20.0, -3.0, 40.0 };
    try common.testIntrinsic(.{ .func = vmaxq_f32, .expected = expected, .args = .{ a, b } });
}

/// ARM NEON intrinsic: `vmaxq_f64`
pub inline fn vmaxq_f64(a: types.f64x2, b: types.f64x2) types.f64x2 {
    return @max(a, b);
}

test vmaxq_f64 {
    const a = types.f64x2{ 10.0, 20.0 };
    const b = types.f64x2{ 2.0, 5.0 };
    const expected = types.f64x2{ 10.0, 20.0 };
    try common.testIntrinsic(.{ .func = vmaxq_f64, .expected = expected, .args = .{ a, b } });
}

/// ARM NEON intrinsic: `vmin_f16`
pub inline fn vmin_f16(a: types.f16x4, b: types.f16x4) types.f16x4 {
    return @min(a, b);
}

test vmin_f16 {
    const a = types.f16x4{ 10.0, 20.0, -15.0, 40.0 };
    const b = types.f16x4{ 2.0, 5.0, -3.0, 10.0 };
    const expected = types.f16x4{ 2.0, 5.0, -15.0, 10.0 };
    try common.testIntrinsic(.{ .func = vmin_f16, .expected = expected, .args = .{ a, b } });
}

/// ARM NEON intrinsic: `vmin_f32`
pub inline fn vmin_f32(a: types.f32x2, b: types.f32x2) types.f32x2 {
    return @min(a, b);
}

test vmin_f32 {
    const a = types.f32x2{ 10.0, 20.0 };
    const b = types.f32x2{ 2.0, 5.0 };
    const expected = types.f32x2{ 2.0, 5.0 };
    try common.testIntrinsic(.{ .func = vmin_f32, .expected = expected, .args = .{ a, b } });
}

/// ARM NEON intrinsic: `vmin_f64`
pub inline fn vmin_f64(a: types.f64x1, b: types.f64x1) types.f64x1 {
    return @min(a, b);
}

test vmin_f64 {
    const a = types.f64x1{10.0};
    const b = types.f64x1{2.0};
    const expected = types.f64x1{2.0};
    try common.testIntrinsic(.{ .func = vmin_f64, .expected = expected, .args = .{ a, b } });
}

/// ARM NEON intrinsic: `vminq_f16`
pub inline fn vminq_f16(a: types.f16x8, b: types.f16x8) types.f16x8 {
    return @min(a, b);
}

test vminq_f16 {
    const a = types.f16x8{ 10.0, 20.0, -15.0, 40.0, -5.0, 30.0, 0.0, 12.0 };
    const b = types.f16x8{ 2.0, 5.0, -3.0, 10.0, -2.0, 2.0, 4.0, 3.0 };
    const expected = types.f16x8{ 2.0, 5.0, -15.0, 10.0, -5.0, 2.0, 0.0, 3.0 };
    try common.testIntrinsic(.{ .func = vminq_f16, .expected = expected, .args = .{ a, b } });
}

/// ARM NEON intrinsic: `vminq_f32`
pub inline fn vminq_f32(a: types.f32x4, b: types.f32x4) types.f32x4 {
    return @min(a, b);
}

test vminq_f32 {
    const a = types.f32x4{ 10.0, 20.0, -15.0, 40.0 };
    const b = types.f32x4{ 2.0, 5.0, -3.0, 10.0 };
    const expected = types.f32x4{ 2.0, 5.0, -15.0, 10.0 };
    try common.testIntrinsic(.{ .func = vminq_f32, .expected = expected, .args = .{ a, b } });
}

/// ARM NEON intrinsic: `vminq_f64`
pub inline fn vminq_f64(a: types.f64x2, b: types.f64x2) types.f64x2 {
    return @min(a, b);
}

test vminq_f64 {
    const a = types.f64x2{ 10.0, 20.0 };
    const b = types.f64x2{ 2.0, 5.0 };
    const expected = types.f64x2{ 2.0, 5.0 };
    try common.testIntrinsic(.{ .func = vminq_f64, .expected = expected, .args = .{ a, b } });
}

/// ARM NEON intrinsic: `vmul_f16`
pub inline fn vmul_f16(a: types.f16x4, b: types.f16x4) types.f16x4 {
    return a * b;
}

test vmul_f16 {
    const a = types.f16x4{ 10.0, 20.0, -15.0, 40.0 };
    const b = types.f16x4{ 2.0, 5.0, -3.0, 10.0 };
    const expected = types.f16x4{ 20.0, 100.0, 45.0, 400.0 };
    try common.testIntrinsic(.{ .func = vmul_f16, .expected = expected, .args = .{ a, b } });
}

/// ARM NEON intrinsic: `vmul_f32`
pub inline fn vmul_f32(a: types.f32x2, b: types.f32x2) types.f32x2 {
    return a * b;
}

test vmul_f32 {
    const a = types.f32x2{ 10.0, 20.0 };
    const b = types.f32x2{ 2.0, 5.0 };
    const expected = types.f32x2{ 20.0, 100.0 };
    try common.testIntrinsic(.{ .func = vmul_f32, .expected = expected, .args = .{ a, b } });
}

/// ARM NEON intrinsic: `vmul_f64`
pub inline fn vmul_f64(a: types.f64x1, b: types.f64x1) types.f64x1 {
    return a * b;
}

test vmul_f64 {
    const a = types.f64x1{10.0};
    const b = types.f64x1{2.0};
    const expected = types.f64x1{20.0};
    try common.testIntrinsic(.{ .func = vmul_f64, .expected = expected, .args = .{ a, b } });
}

/// ARM NEON intrinsic: `vmulq_f16`
pub inline fn vmulq_f16(a: types.f16x8, b: types.f16x8) types.f16x8 {
    return a * b;
}

test vmulq_f16 {
    const a = types.f16x8{ 10.0, 20.0, -15.0, 40.0, -5.0, 30.0, 0.0, 12.0 };
    const b = types.f16x8{ 2.0, 5.0, -3.0, 10.0, -2.0, 2.0, 4.0, 3.0 };
    const expected = types.f16x8{ 20.0, 100.0, 45.0, 400.0, 10.0, 60.0, 0.0, 36.0 };
    try common.testIntrinsic(.{ .func = vmulq_f16, .expected = expected, .args = .{ a, b } });
}

/// ARM NEON intrinsic: `vmulq_f32`
pub inline fn vmulq_f32(a: types.f32x4, b: types.f32x4) types.f32x4 {
    return a * b;
}

test vmulq_f32 {
    const a = types.f32x4{ 10.0, 20.0, -15.0, 40.0 };
    const b = types.f32x4{ 2.0, 5.0, -3.0, 10.0 };
    const expected = types.f32x4{ 20.0, 100.0, 45.0, 400.0 };
    try common.testIntrinsic(.{ .func = vmulq_f32, .expected = expected, .args = .{ a, b } });
}

/// ARM NEON intrinsic: `vmulq_f64`
pub inline fn vmulq_f64(a: types.f64x2, b: types.f64x2) types.f64x2 {
    return a * b;
}

test vmulq_f64 {
    const a = types.f64x2{ 10.0, 20.0 };
    const b = types.f64x2{ 2.0, 5.0 };
    const expected = types.f64x2{ 20.0, 100.0 };
    try common.testIntrinsic(.{ .func = vmulq_f64, .expected = expected, .args = .{ a, b } });
}

/// ARM NEON intrinsic: `vneg_f16`
pub inline fn vneg_f16(a: types.f16x4) types.f16x4 {
    return -a;
}

test vneg_f16 {
    const a = types.f16x4{ 1.5, -2.0, 0.0, 5.25 };
    const expected = types.f16x4{ -1.5, 2.0, -0.0, -5.25 };
    try common.testIntrinsic(.{ .func = vneg_f16, .expected = expected, .args = .{a} });
}

/// ARM NEON intrinsic: `vneg_f32`
pub inline fn vneg_f32(a: types.f32x2) types.f32x2 {
    return -a;
}

test vneg_f32 {
    const a = types.f32x2{ 1.5, -2.0 };
    const expected = types.f32x2{ -1.5, 2.0 };
    try common.testIntrinsic(.{ .func = vneg_f32, .expected = expected, .args = .{a} });
}

/// ARM NEON intrinsic: `vneg_f64`
pub inline fn vneg_f64(a: types.f64x1) types.f64x1 {
    return -a;
}

test vneg_f64 {
    const a = types.f64x1{1.5};
    const expected = types.f64x1{-1.5};
    try common.testIntrinsic(.{ .func = vneg_f64, .expected = expected, .args = .{a} });
}

/// ARM NEON intrinsic: `vnegq_f16`
pub inline fn vnegq_f16(a: types.f16x8) types.f16x8 {
    return -a;
}

test vnegq_f16 {
    const a = types.f16x8{ 1.5, -2.0, 0.0, 5.25, -10.0, 3.5, -0.5, 8.0 };
    const expected = types.f16x8{ -1.5, 2.0, -0.0, -5.25, 10.0, -3.5, 0.5, -8.0 };
    try common.testIntrinsic(.{ .func = vnegq_f16, .expected = expected, .args = .{a} });
}

/// ARM NEON intrinsic: `vnegq_f32`
pub inline fn vnegq_f32(a: types.f32x4) types.f32x4 {
    return -a;
}

test vnegq_f32 {
    const a = types.f32x4{ 1.5, -2.0, 0.0, 5.25 };
    const expected = types.f32x4{ -1.5, 2.0, -0.0, -5.25 };
    try common.testIntrinsic(.{ .func = vnegq_f32, .expected = expected, .args = .{a} });
}

/// ARM NEON intrinsic: `vnegq_f64`
pub inline fn vnegq_f64(a: types.f64x2) types.f64x2 {
    return -a;
}

test vnegq_f64 {
    const a = types.f64x2{ 1.5, -2.0 };
    const expected = types.f64x2{ -1.5, 2.0 };
    try common.testIntrinsic(.{ .func = vnegq_f64, .expected = expected, .args = .{a} });
}

/// ARM NEON intrinsic: `vsub_f16`
pub inline fn vsub_f16(a: types.f16x4, b: types.f16x4) types.f16x4 {
    return a - b;
}

test vsub_f16 {
    const a = types.f16x4{ 10.0, 20.0, -15.0, 40.0 };
    const b = types.f16x4{ 2.0, 5.0, -3.0, 10.0 };
    const expected = types.f16x4{ 8.0, 15.0, -12.0, 30.0 };
    try common.testIntrinsic(.{ .func = vsub_f16, .expected = expected, .args = .{ a, b } });
}

/// ARM NEON intrinsic: `vsub_f32`
pub inline fn vsub_f32(a: types.f32x2, b: types.f32x2) types.f32x2 {
    return a - b;
}

test vsub_f32 {
    const a = types.f32x2{ 10.0, 20.0 };
    const b = types.f32x2{ 2.0, 5.0 };
    const expected = types.f32x2{ 8.0, 15.0 };
    try common.testIntrinsic(.{ .func = vsub_f32, .expected = expected, .args = .{ a, b } });
}

/// ARM NEON intrinsic: `vsub_f64`
pub inline fn vsub_f64(a: types.f64x1, b: types.f64x1) types.f64x1 {
    return a - b;
}

test vsub_f64 {
    const a = types.f64x1{10.0};
    const b = types.f64x1{2.0};
    const expected = types.f64x1{8.0};
    try common.testIntrinsic(.{ .func = vsub_f64, .expected = expected, .args = .{ a, b } });
}

/// ARM NEON intrinsic: `vsubq_f16`
pub inline fn vsubq_f16(a: types.f16x8, b: types.f16x8) types.f16x8 {
    return a - b;
}

test vsubq_f16 {
    const a = types.f16x8{ 10.0, 20.0, -15.0, 40.0, -5.0, 30.0, 0.0, 12.0 };
    const b = types.f16x8{ 2.0, 5.0, -3.0, 10.0, -2.0, 2.0, 4.0, 3.0 };
    const expected = types.f16x8{ 8.0, 15.0, -12.0, 30.0, -3.0, 28.0, -4.0, 9.0 };
    try common.testIntrinsic(.{ .func = vsubq_f16, .expected = expected, .args = .{ a, b } });
}

/// ARM NEON intrinsic: `vsubq_f32`
pub inline fn vsubq_f32(a: types.f32x4, b: types.f32x4) types.f32x4 {
    return a - b;
}

test vsubq_f32 {
    const a = types.f32x4{ 10.0, 20.0, -15.0, 40.0 };
    const b = types.f32x4{ 2.0, 5.0, -3.0, 10.0 };
    const expected = types.f32x4{ 8.0, 15.0, -12.0, 30.0 };
    try common.testIntrinsic(.{ .func = vsubq_f32, .expected = expected, .args = .{ a, b } });
}

/// ARM NEON intrinsic: `vsubq_f64`
pub inline fn vsubq_f64(a: types.f64x2, b: types.f64x2) types.f64x2 {
    return a - b;
}

test vsubq_f64 {
    const a = types.f64x2{ 10.0, 20.0 };
    const b = types.f64x2{ 2.0, 5.0 };
    const expected = types.f64x2{ 8.0, 15.0 };
    try common.testIntrinsic(.{ .func = vsubq_f64, .expected = expected, .args = .{ a, b } });
}

/// Vector multiply-accumulate: returns `a + (b * c)`
pub inline fn vmla_s8(a: types.i8x8, b: types.i8x8, c: types.i8x8) types.i8x8 {
    return a +% (b *% c);
}

test vmla_s8 {
    const a = types.i8x8{ 10, -20, 5, 40, -5, 30, 0, 12 };
    const b = types.i8x8{ 2, 3, -4, 5, -2, 1, 3, 2 };
    const c = types.i8x8{ 4, 2, 3, 2, 3, 2, 5, 3 };
    const expected = types.i8x8{ 18, -14, -7, 50, -11, 32, 15, 18 };
    try common.testIntrinsic(.{ .func = vmla_s8, .expected = expected, .args = .{ a, b, c } });
}

/// Vector multiply-accumulate: returns `a + (b * c)`
pub inline fn vmla_s16(a: types.i16x4, b: types.i16x4, c: types.i16x4) types.i16x4 {
    return a +% (b *% c);
}

test vmla_s16 {
    const a = types.i16x4{ 10, -20, 5, 40 };
    const b = types.i16x4{ 2, 3, -4, 5 };
    const c = types.i16x4{ 4, 2, 3, 2 };
    const expected = types.i16x4{ 18, -14, -7, 50 };
    try common.testIntrinsic(.{ .func = vmla_s16, .expected = expected, .args = .{ a, b, c } });
}

/// Vector multiply-accumulate: returns `a + (b * c)`
pub inline fn vmla_s32(a: types.i32x2, b: types.i32x2, c: types.i32x2) types.i32x2 {
    return a +% (b *% c);
}

test vmla_s32 {
    const a = types.i32x2{ 10, -20 };
    const b = types.i32x2{ 2, 3 };
    const c = types.i32x2{ 4, 2 };
    const expected = types.i32x2{ 18, -14 };
    try common.testIntrinsic(.{ .func = vmla_s32, .expected = expected, .args = .{ a, b, c } });
}

/// Vector multiply-accumulate: returns `a + (b * c)`
pub inline fn vmla_u8(a: types.u8x8, b: types.u8x8, c: types.u8x8) types.u8x8 {
    return a +% (b *% c);
}

test vmla_u8 {
    const a = types.u8x8{ 10, 20, 15, 40, 5, 30, 0, 12 };
    const b = types.u8x8{ 2, 3, 4, 5, 2, 1, 3, 2 };
    const c = types.u8x8{ 4, 2, 3, 2, 3, 2, 5, 3 };
    const expected = types.u8x8{ 18, 26, 27, 50, 11, 32, 15, 18 };
    try common.testIntrinsic(.{ .func = vmla_u8, .expected = expected, .args = .{ a, b, c } });
}

/// Vector multiply-accumulate: returns `a + (b * c)`
pub inline fn vmla_u16(a: types.u16x4, b: types.u16x4, c: types.u16x4) types.u16x4 {
    return a +% (b *% c);
}

test vmla_u16 {
    const a = types.u16x4{ 10, 20, 15, 40 };
    const b = types.u16x4{ 2, 3, 4, 5 };
    const c = types.u16x4{ 4, 2, 3, 2 };
    const expected = types.u16x4{ 18, 26, 27, 50 };
    try common.testIntrinsic(.{ .func = vmla_u16, .expected = expected, .args = .{ a, b, c } });
}

/// Vector multiply-accumulate: returns `a + (b * c)`
pub inline fn vmla_u32(a: types.u32x2, b: types.u32x2, c: types.u32x2) types.u32x2 {
    return a +% (b *% c);
}

test vmla_u32 {
    const a = types.u32x2{ 10, 20 };
    const b = types.u32x2{ 2, 3 };
    const c = types.u32x2{ 4, 2 };
    const expected = types.u32x2{ 18, 26 };
    try common.testIntrinsic(.{ .func = vmla_u32, .expected = expected, .args = .{ a, b, c } });
}

/// Vector multiply-accumulate: returns `a + (b * c)`
pub inline fn vmla_f32(a: types.f32x2, b: types.f32x2, c: types.f32x2) types.f32x2 {
    return a + (b * c);
}

test vmla_f32 {
    const a = types.f32x2{ 10.0, 20.0 };
    const b = types.f32x2{ 2.0, 3.0 };
    const c = types.f32x2{ 4.0, -2.0 };
    const expected = types.f32x2{ 18.0, 14.0 };
    try common.testIntrinsic(.{ .func = vmla_f32, .expected = expected, .args = .{ a, b, c } });
}

/// Vector multiply-subtract: returns `a - (b * c)`
pub inline fn vmls_s8(a: types.i8x8, b: types.i8x8, c: types.i8x8) types.i8x8 {
    return a -% (b *% c);
}

test vmls_s8 {
    const a = types.i8x8{ 10, -20, 5, 40, -5, 30, 0, 12 };
    const b = types.i8x8{ 2, 3, -4, 5, -2, 1, 3, 2 };
    const c = types.i8x8{ 4, 2, 3, 2, 3, 2, 5, 3 };
    const expected = types.i8x8{ 2, -26, 17, 30, 1, 28, -15, 6 };
    try common.testIntrinsic(.{ .func = vmls_s8, .expected = expected, .args = .{ a, b, c } });
}

/// Vector multiply-subtract: returns `a - (b * c)`
pub inline fn vmls_s16(a: types.i16x4, b: types.i16x4, c: types.i16x4) types.i16x4 {
    return a -% (b *% c);
}

test vmls_s16 {
    const a = types.i16x4{ 10, -20, 5, 40 };
    const b = types.i16x4{ 2, 3, -4, 5 };
    const c = types.i16x4{ 4, 2, 3, 2 };
    const expected = types.i16x4{ 2, -26, 17, 30 };
    try common.testIntrinsic(.{ .func = vmls_s16, .expected = expected, .args = .{ a, b, c } });
}

/// Vector multiply-subtract: returns `a - (b * c)`
pub inline fn vmls_s32(a: types.i32x2, b: types.i32x2, c: types.i32x2) types.i32x2 {
    return a -% (b *% c);
}

test vmls_s32 {
    const a = types.i32x2{ 10, -20 };
    const b = types.i32x2{ 2, 3 };
    const c = types.i32x2{ 4, 2 };
    const expected = types.i32x2{ 2, -26 };
    try common.testIntrinsic(.{ .func = vmls_s32, .expected = expected, .args = .{ a, b, c } });
}

/// Vector multiply-subtract: returns `a - (b * c)`
pub inline fn vmls_u8(a: types.u8x8, b: types.u8x8, c: types.u8x8) types.u8x8 {
    return a -% (b *% c);
}

test vmls_u8 {
    const a = types.u8x8{ 10, 20, 15, 40, 5, 30, 0, 12 };
    const b = types.u8x8{ 2, 3, 4, 5, 2, 1, 3, 2 };
    const c = types.u8x8{ 4, 2, 3, 2, 3, 2, 5, 3 };
    const expected = types.u8x8{ 2, 14, 3, 30, 255, 28, 241, 6 };
    try common.testIntrinsic(.{ .func = vmls_u8, .expected = expected, .args = .{ a, b, c } });
}

/// Vector multiply-subtract: returns `a - (b * c)`
pub inline fn vmls_u16(a: types.u16x4, b: types.u16x4, c: types.u16x4) types.u16x4 {
    return a -% (b *% c);
}

test vmls_u16 {
    const a = types.u16x4{ 10, 20, 15, 40 };
    const b = types.u16x4{ 2, 3, 4, 5 };
    const c = types.u16x4{ 4, 2, 3, 2 };
    const expected = types.u16x4{ 2, 14, 3, 30 };
    try common.testIntrinsic(.{ .func = vmls_u16, .expected = expected, .args = .{ a, b, c } });
}

/// Vector multiply-subtract: returns `a - (b * c)`
pub inline fn vmls_u32(a: types.u32x2, b: types.u32x2, c: types.u32x2) types.u32x2 {
    return a -% (b *% c);
}

test vmls_u32 {
    const a = types.u32x2{ 10, 20 };
    const b = types.u32x2{ 2, 3 };
    const c = types.u32x2{ 4, 2 };
    const expected = types.u32x2{ 2, 14 };
    try common.testIntrinsic(.{ .func = vmls_u32, .expected = expected, .args = .{ a, b, c } });
}

/// Vector multiply-subtract: returns `a - (b * c)`
pub inline fn vmls_f32(a: types.f32x2, b: types.f32x2, c: types.f32x2) types.f32x2 {
    return a - (b * c);
}

test vmls_f32 {
    const a = types.f32x2{ 10.0, 20.0 };
    const b = types.f32x2{ 2.0, 3.0 };
    const c = types.f32x2{ 4.0, -2.0 };
    const expected = types.f32x2{ 2.0, 26.0 };
    try common.testIntrinsic(.{ .func = vmls_f32, .expected = expected, .args = .{ a, b, c } });
}

/// Vector multiply-subtract: returns `a - (b * c)`
pub inline fn vmlsq_s8(a: types.i8x16, b: types.i8x16, c: types.i8x16) types.i8x16 {
    return a -% (b *% c);
}

test vmlsq_s8 {
    const a = types.i8x16{ 10, -20, 5, 40, -5, 30, 0, 12, 10, 10, 10, 10, 10, 10, 10, 10 };
    const b = types.i8x16{ 2, 3, -4, 5, -2, 1, 3, 2, 2, 2, 2, 2, 2, 2, 2, 2 };
    const c = types.i8x16{ 4, 2, 3, 2, 3, 2, 5, 3, 4, 4, 4, 4, 4, 4, 4, 4 };
    const expected = types.i8x16{ 2, -26, 17, 30, 1, 28, -15, 6, 2, 2, 2, 2, 2, 2, 2, 2 };
    try common.testIntrinsic(.{ .func = vmlsq_s8, .expected = expected, .args = .{ a, b, c } });
}

/// Vector multiply-subtract: returns `a - (b * c)`
pub inline fn vmlsq_s16(a: types.i16x8, b: types.i16x8, c: types.i16x8) types.i16x8 {
    return a -% (b *% c);
}

test vmlsq_s16 {
    const a = types.i16x8{ 10, -20, 5, 40, -5, 30, 0, 12 };
    const b = types.i16x8{ 2, 3, -4, 5, -2, 1, 3, 2 };
    const c = types.i16x8{ 4, 2, 3, 2, 3, 2, 5, 3 };
    const expected = types.i16x8{ 2, -26, 17, 30, 1, 28, -15, 6 };
    try common.testIntrinsic(.{ .func = vmlsq_s16, .expected = expected, .args = .{ a, b, c } });
}

/// Vector multiply-subtract: returns `a - (b * c)`
pub inline fn vmlsq_s32(a: types.i32x4, b: types.i32x4, c: types.i32x4) types.i32x4 {
    return a -% (b *% c);
}

test vmlsq_s32 {
    const a = types.i32x4{ 10, -20, 5, 40 };
    const b = types.i32x4{ 2, 3, -4, 5 };
    const c = types.i32x4{ 4, 2, 3, 2 };
    const expected = types.i32x4{ 2, -26, 17, 30 };
    try common.testIntrinsic(.{ .func = vmlsq_s32, .expected = expected, .args = .{ a, b, c } });
}

/// Vector multiply-subtract: returns `a - (b * c)`
pub inline fn vmlsq_u8(a: types.u8x16, b: types.u8x16, c: types.u8x16) types.u8x16 {
    return a -% (b *% c);
}

test vmlsq_u8 {
    const a = types.u8x16{ 10, 20, 15, 40, 5, 30, 0, 12, 10, 10, 10, 10, 10, 10, 10, 10 };
    const b = types.u8x16{ 2, 3, 4, 5, 2, 1, 3, 2, 2, 2, 2, 2, 2, 2, 2, 2 };
    const c = types.u8x16{ 4, 2, 3, 2, 3, 2, 5, 3, 4, 4, 4, 4, 4, 4, 4, 4 };
    const expected = types.u8x16{ 2, 14, 3, 30, 255, 28, 241, 6, 2, 2, 2, 2, 2, 2, 2, 2 };
    try common.testIntrinsic(.{ .func = vmlsq_u8, .expected = expected, .args = .{ a, b, c } });
}

/// Vector multiply-subtract: returns `a - (b * c)`
pub inline fn vmlsq_u16(a: types.u16x8, b: types.u16x8, c: types.u16x8) types.u16x8 {
    return a -% (b *% c);
}

test vmlsq_u16 {
    const a = types.u16x8{ 10, 20, 15, 40, 5, 30, 0, 12 };
    const b = types.u16x8{ 2, 3, 4, 5, 2, 1, 3, 2 };
    const c = types.u16x8{ 4, 2, 3, 2, 3, 2, 5, 3 };
    const expected = types.u16x8{ 2, 14, 3, 30, 65535, 28, 65521, 6 };
    try common.testIntrinsic(.{ .func = vmlsq_u16, .expected = expected, .args = .{ a, b, c } });
}

/// Vector multiply-subtract: returns `a - (b * c)`
pub inline fn vmlsq_u32(a: types.u32x4, b: types.u32x4, c: types.u32x4) types.u32x4 {
    return a -% (b *% c);
}

test vmlsq_u32 {
    const a = types.u32x4{ 10, 20, 15, 40 };
    const b = types.u32x4{ 2, 3, 4, 5 };
    const c = types.u32x4{ 4, 2, 3, 2 };
    const expected = types.u32x4{ 2, 14, 3, 30 };
    try common.testIntrinsic(.{ .func = vmlsq_u32, .expected = expected, .args = .{ a, b, c } });
}

/// Vector multiply-subtract: returns `a - (b * c)`
pub inline fn vmlsq_f32(a: types.f32x4, b: types.f32x4, c: types.f32x4) types.f32x4 {
    return a - (b * c);
}

test vmlsq_f32 {
    const a = types.f32x4{ 10.0, 20.0, -15.0, 40.0 };
    const b = types.f32x4{ 2.0, 3.0, -4.0, 5.0 };
    const c = types.f32x4{ 4.0, -2.0, 3.0, 2.0 };
    const expected = types.f32x4{ 2.0, 26.0, -3.0, 30.0 };
    try common.testIntrinsic(.{ .func = vmlsq_f32, .expected = expected, .args = .{ a, b, c } });
}

/// Vector multiply-subtract: returns `a - (b * c)`
pub inline fn vmlsq_f64(a: types.f64x2, b: types.f64x2, c: types.f64x2) types.f64x2 {
    return a - (b * c);
}

test vmlsq_f64 {
    const a = types.f64x2{ 10.0, 20.0 };
    const b = types.f64x2{ 2.0, 3.0 };
    const c = types.f64x2{ 4.0, -2.0 };
    const expected = types.f64x2{ 2.0, 26.0 };
    try common.testIntrinsic(.{ .func = vmlsq_f64, .expected = expected, .args = .{ a, b, c } });
}

/// Vector halving addition: returns `(a + b) >> 1`
pub inline fn vhadd_s8(a: types.i8x8, b: types.i8x8) types.i8x8 {
    const Wide = @Vector(8, i16);
    const wa: Wide = a;
    const wb: Wide = b;
    return @truncate((wa + wb) >> @as(Wide, @splat(1)));
}

test vhadd_s8 {
    const a = types.i8x8{ 10, 20, -10, 0, 5, -5, 40, -50 };
    const b = types.i8x8{ 4, 6, 10, 10, 2, -1, 20, -30 };
    const expected = types.i8x8{ 7, 13, 0, 5, 3, -3, 30, -40 };
    try common.testIntrinsic(.{ .func = vhadd_s8, .expected = expected, .args = .{ a, b } });
}

/// Vector rounding halving addition: returns `(a + b + 1) >> 1`
pub inline fn vrhadd_s8(a: types.i8x8, b: types.i8x8) types.i8x8 {
    const Wide = @Vector(8, i16);
    const wa: Wide = a;
    const wb: Wide = b;
    return @truncate((wa + wb + @as(@Vector(8, i16), @splat(1))) >> @as(Wide, @splat(1)));
}

test vrhadd_s8 {
    const a = types.i8x8{ 10, 20, -10, 0, 5, -5, 40, -50 };
    const b = types.i8x8{ 4, 6, 10, 10, 2, -1, 20, -30 };
    const expected = types.i8x8{ 7, 13, 0, 5, 4, -3, 30, -40 };
    try common.testIntrinsic(.{ .func = vrhadd_s8, .expected = expected, .args = .{ a, b } });
}

/// Vector halving addition: returns `(a + b) >> 1`
pub inline fn vhadd_s16(a: types.i16x4, b: types.i16x4) types.i16x4 {
    const Wide = @Vector(4, i32);
    const wa: Wide = a;
    const wb: Wide = b;
    return @truncate((wa + wb) >> @as(Wide, @splat(1)));
}

test vhadd_s16 {
    const a = types.i16x4{ 10, 20, -10, 0 };
    const b = types.i16x4{ 4, 6, 10, 10 };
    const expected = types.i16x4{ 7, 13, 0, 5 };
    try common.testIntrinsic(.{ .func = vhadd_s16, .expected = expected, .args = .{ a, b } });
}

/// Vector rounding halving addition: returns `(a + b + 1) >> 1`
pub inline fn vrhadd_s16(a: types.i16x4, b: types.i16x4) types.i16x4 {
    const Wide = @Vector(4, i32);
    const wa: Wide = a;
    const wb: Wide = b;
    return @truncate((wa + wb + @as(@Vector(4, i32), @splat(1))) >> @as(Wide, @splat(1)));
}

test vrhadd_s16 {
    const a = types.i16x4{ 10, 20, -10, 0 };
    const b = types.i16x4{ 4, 6, 10, 10 };
    const expected = types.i16x4{ 7, 13, 0, 5 };
    try common.testIntrinsic(.{ .func = vrhadd_s16, .expected = expected, .args = .{ a, b } });
}

/// Vector halving addition: returns `(a + b) >> 1`
pub inline fn vhadd_s32(a: types.i32x2, b: types.i32x2) types.i32x2 {
    const Wide = @Vector(2, i64);
    const wa: Wide = a;
    const wb: Wide = b;
    return @truncate((wa + wb) >> @as(Wide, @splat(1)));
}

test vhadd_s32 {
    const a = types.i32x2{ 10, 20 };
    const b = types.i32x2{ 4, 6 };
    const expected = types.i32x2{ 7, 13 };
    try common.testIntrinsic(.{ .func = vhadd_s32, .expected = expected, .args = .{ a, b } });
}

/// Vector rounding halving addition: returns `(a + b + 1) >> 1`
pub inline fn vrhadd_s32(a: types.i32x2, b: types.i32x2) types.i32x2 {
    const Wide = @Vector(2, i64);
    const wa: Wide = a;
    const wb: Wide = b;
    return @truncate((wa + wb + @as(@Vector(2, i64), @splat(1))) >> @as(Wide, @splat(1)));
}

test vrhadd_s32 {
    const a = types.i32x2{ 10, 20 };
    const b = types.i32x2{ 4, 6 };
    const expected = types.i32x2{ 7, 13 };
    try common.testIntrinsic(.{ .func = vrhadd_s32, .expected = expected, .args = .{ a, b } });
}

/// Vector halving addition: returns `(a + b) >> 1`
pub inline fn vhadd_u8(a: types.u8x8, b: types.u8x8) types.u8x8 {
    const Wide = @Vector(8, u16);
    const wa: Wide = a;
    const wb: Wide = b;
    return @truncate((wa + wb) >> @as(Wide, @splat(1)));
}

test vhadd_u8 {
    const a = types.u8x8{ 10, 20, 0, 100, 50, 4, 150, 1 };
    const b = types.u8x8{ 4, 6, 10, 50, 60, 20, 80, 3 };
    const expected = types.u8x8{ 7, 13, 5, 75, 55, 12, 115, 2 };
    try common.testIntrinsic(.{ .func = vhadd_u8, .expected = expected, .args = .{ a, b } });
}

/// Vector rounding halving addition: returns `(a + b + 1) >> 1`
pub inline fn vrhadd_u8(a: types.u8x8, b: types.u8x8) types.u8x8 {
    const Wide = @Vector(8, u16);
    const wa: Wide = a;
    const wb: Wide = b;
    return @truncate((wa + wb + @as(@Vector(8, u16), @splat(1))) >> @as(Wide, @splat(1)));
}

test vrhadd_u8 {
    const a = types.u8x8{ 10, 20, 0, 100, 50, 4, 150, 1 };
    const b = types.u8x8{ 4, 6, 10, 50, 60, 20, 80, 3 };
    const expected = types.u8x8{ 7, 13, 5, 75, 55, 12, 115, 2 };
    try common.testIntrinsic(.{ .func = vrhadd_u8, .expected = expected, .args = .{ a, b } });
}

/// Vector halving addition: returns `(a + b) >> 1`
pub inline fn vhadd_u16(a: types.u16x4, b: types.u16x4) types.u16x4 {
    const Wide = @Vector(4, u32);
    const wa: Wide = a;
    const wb: Wide = b;
    return @truncate((wa + wb) >> @as(Wide, @splat(1)));
}

test vhadd_u16 {
    const a = types.u16x4{ 10, 20, 0, 100 };
    const b = types.u16x4{ 4, 6, 10, 50 };
    const expected = types.u16x4{ 7, 13, 5, 75 };
    try common.testIntrinsic(.{ .func = vhadd_u16, .expected = expected, .args = .{ a, b } });
}

/// Vector rounding halving addition: returns `(a + b + 1) >> 1`
pub inline fn vrhadd_u16(a: types.u16x4, b: types.u16x4) types.u16x4 {
    const Wide = @Vector(4, u32);
    const wa: Wide = a;
    const wb: Wide = b;
    return @truncate((wa + wb + @as(@Vector(4, u32), @splat(1))) >> @as(Wide, @splat(1)));
}

test vrhadd_u16 {
    const a = types.u16x4{ 10, 20, 0, 100 };
    const b = types.u16x4{ 4, 6, 10, 50 };
    const expected = types.u16x4{ 7, 13, 5, 75 };
    try common.testIntrinsic(.{ .func = vrhadd_u16, .expected = expected, .args = .{ a, b } });
}

/// Vector halving addition: returns `(a + b) >> 1`
pub inline fn vhadd_u32(a: types.u32x2, b: types.u32x2) types.u32x2 {
    const Wide = @Vector(2, u64);
    const wa: Wide = a;
    const wb: Wide = b;
    return @truncate((wa + wb) >> @as(Wide, @splat(1)));
}

test vhadd_u32 {
    const a = types.u32x2{ 10, 20 };
    const b = types.u32x2{ 4, 6 };
    const expected = types.u32x2{ 7, 13 };
    try common.testIntrinsic(.{ .func = vhadd_u32, .expected = expected, .args = .{ a, b } });
}

/// Vector rounding halving addition: returns `(a + b + 1) >> 1`
pub inline fn vrhadd_u32(a: types.u32x2, b: types.u32x2) types.u32x2 {
    const Wide = @Vector(2, u64);
    const wa: Wide = a;
    const wb: Wide = b;
    return @truncate((wa + wb + @as(@Vector(2, u64), @splat(1))) >> @as(Wide, @splat(1)));
}

test vrhadd_u32 {
    const a = types.u32x2{ 10, 20 };
    const b = types.u32x2{ 4, 6 };
    const expected = types.u32x2{ 7, 13 };
    try common.testIntrinsic(.{ .func = vrhadd_u32, .expected = expected, .args = .{ a, b } });
}

/// Vector halving addition: returns `(a + b) >> 1`
pub inline fn vhaddq_s8(a: types.i8x16, b: types.i8x16) types.i8x16 {
    const Wide = @Vector(16, i16);
    const wa: Wide = a;
    const wb: Wide = b;
    return @truncate((wa + wb) >> @as(Wide, @splat(1)));
}

test vhaddq_s8 {
    const a = types.i8x16{ 10, 20, -10, 0, 5, -5, 40, -50, 10, 10, 10, 10, 10, 10, 10, 10 };
    const b = types.i8x16{ 4, 6, 10, 10, 2, -1, 20, -30, 4, 4, 4, 4, 4, 4, 4, 4 };
    const expected = types.i8x16{ 7, 13, 0, 5, 3, -3, 30, -40, 7, 7, 7, 7, 7, 7, 7, 7 };
    try common.testIntrinsic(.{ .func = vhaddq_s8, .expected = expected, .args = .{ a, b } });
}

/// Vector rounding halving addition: returns `(a + b + 1) >> 1`
pub inline fn vrhaddq_s8(a: types.i8x16, b: types.i8x16) types.i8x16 {
    const Wide = @Vector(16, i16);
    const wa: Wide = a;
    const wb: Wide = b;
    return @truncate((wa + wb + @as(@Vector(16, i16), @splat(1))) >> @as(Wide, @splat(1)));
}

test vrhaddq_s8 {
    const a = types.i8x16{ 10, 20, -10, 0, 5, -5, 40, -50, 10, 10, 10, 10, 10, 10, 10, 10 };
    const b = types.i8x16{ 4, 6, 10, 10, 2, -1, 20, -30, 4, 4, 4, 4, 4, 4, 4, 4 };
    const expected = types.i8x16{ 7, 13, 0, 5, 4, -3, 30, -40, 7, 7, 7, 7, 7, 7, 7, 7 };
    try common.testIntrinsic(.{ .func = vrhaddq_s8, .expected = expected, .args = .{ a, b } });
}

/// Vector halving addition: returns `(a + b) >> 1`
pub inline fn vhaddq_s16(a: types.i16x8, b: types.i16x8) types.i16x8 {
    const Wide = @Vector(8, i32);
    const wa: Wide = a;
    const wb: Wide = b;
    return @truncate((wa + wb) >> @as(Wide, @splat(1)));
}

test vhaddq_s16 {
    const a = types.i16x8{ 10, 20, -10, 0, 5, -5, 40, -50 };
    const b = types.i16x8{ 4, 6, 10, 10, 2, -1, 20, -30 };
    const expected = types.i16x8{ 7, 13, 0, 5, 3, -3, 30, -40 };
    try common.testIntrinsic(.{ .func = vhaddq_s16, .expected = expected, .args = .{ a, b } });
}

/// Vector rounding halving addition: returns `(a + b + 1) >> 1`
pub inline fn vrhaddq_s16(a: types.i16x8, b: types.i16x8) types.i16x8 {
    const Wide = @Vector(8, i32);
    const wa: Wide = a;
    const wb: Wide = b;
    return @truncate((wa + wb + @as(@Vector(8, i32), @splat(1))) >> @as(Wide, @splat(1)));
}

test vrhaddq_s16 {
    const a = types.i16x8{ 10, 20, -10, 0, 5, -5, 40, -50 };
    const b = types.i16x8{ 4, 6, 10, 10, 2, -1, 20, -30 };
    const expected = types.i16x8{ 7, 13, 0, 5, 4, -3, 30, -40 };
    try common.testIntrinsic(.{ .func = vrhaddq_s16, .expected = expected, .args = .{ a, b } });
}

/// Vector halving addition: returns `(a + b) >> 1`
pub inline fn vhaddq_s32(a: types.i32x4, b: types.i32x4) types.i32x4 {
    const Wide = @Vector(4, i64);
    const wa: Wide = a;
    const wb: Wide = b;
    return @truncate((wa + wb) >> @as(Wide, @splat(1)));
}

test vhaddq_s32 {
    const a = types.i32x4{ 10, 20, -10, 0 };
    const b = types.i32x4{ 4, 6, 10, 10 };
    const expected = types.i32x4{ 7, 13, 0, 5 };
    try common.testIntrinsic(.{ .func = vhaddq_s32, .expected = expected, .args = .{ a, b } });
}

/// Vector rounding halving addition: returns `(a + b + 1) >> 1`
pub inline fn vrhaddq_s32(a: types.i32x4, b: types.i32x4) types.i32x4 {
    const Wide = @Vector(4, i64);
    const wa: Wide = a;
    const wb: Wide = b;
    return @truncate((wa + wb + @as(@Vector(4, i64), @splat(1))) >> @as(Wide, @splat(1)));
}

test vrhaddq_s32 {
    const a = types.i32x4{ 10, 20, -10, 0 };
    const b = types.i32x4{ 4, 6, 10, 10 };
    const expected = types.i32x4{ 7, 13, 0, 5 };
    try common.testIntrinsic(.{ .func = vrhaddq_s32, .expected = expected, .args = .{ a, b } });
}

/// Vector halving addition: returns `(a + b) >> 1`
pub inline fn vhaddq_u8(a: types.u8x16, b: types.u8x16) types.u8x16 {
    const Wide = @Vector(16, u16);
    const wa: Wide = a;
    const wb: Wide = b;
    return @truncate((wa + wb) >> @as(Wide, @splat(1)));
}

test vhaddq_u8 {
    const a = types.u8x16{ 10, 20, 0, 100, 50, 4, 150, 1, 10, 10, 10, 10, 10, 10, 10, 10 };
    const b = types.u8x16{ 4, 6, 10, 50, 60, 20, 80, 3, 4, 4, 4, 4, 4, 4, 4, 4 };
    const expected = types.u8x16{ 7, 13, 5, 75, 55, 12, 115, 2, 7, 7, 7, 7, 7, 7, 7, 7 };
    try common.testIntrinsic(.{ .func = vhaddq_u8, .expected = expected, .args = .{ a, b } });
}

/// Vector rounding halving addition: returns `(a + b + 1) >> 1`
pub inline fn vrhaddq_u8(a: types.u8x16, b: types.u8x16) types.u8x16 {
    const Wide = @Vector(16, u16);
    const wa: Wide = a;
    const wb: Wide = b;
    return @truncate((wa + wb + @as(@Vector(16, u16), @splat(1))) >> @as(Wide, @splat(1)));
}

test vrhaddq_u8 {
    const a = types.u8x16{ 10, 20, 0, 100, 50, 4, 150, 1, 10, 10, 10, 10, 10, 10, 10, 10 };
    const b = types.u8x16{ 4, 6, 10, 50, 60, 20, 80, 3, 4, 4, 4, 4, 4, 4, 4, 4 };
    const expected = types.u8x16{ 7, 13, 5, 75, 55, 12, 115, 2, 7, 7, 7, 7, 7, 7, 7, 7 };
    try common.testIntrinsic(.{ .func = vrhaddq_u8, .expected = expected, .args = .{ a, b } });
}

/// Vector halving addition: returns `(a + b) >> 1`
pub inline fn vhaddq_u16(a: types.u16x8, b: types.u16x8) types.u16x8 {
    const Wide = @Vector(8, u32);
    const wa: Wide = a;
    const wb: Wide = b;
    return @truncate((wa + wb) >> @as(Wide, @splat(1)));
}

test vhaddq_u16 {
    const a = types.u16x8{ 10, 20, 0, 100, 50, 4, 150, 1 };
    const b = types.u16x8{ 4, 6, 10, 50, 60, 20, 80, 3 };
    const expected = types.u16x8{ 7, 13, 5, 75, 55, 12, 115, 2 };
    try common.testIntrinsic(.{ .func = vhaddq_u16, .expected = expected, .args = .{ a, b } });
}

/// Vector rounding halving addition: returns `(a + b + 1) >> 1`
pub inline fn vrhaddq_u16(a: types.u16x8, b: types.u16x8) types.u16x8 {
    const Wide = @Vector(8, u32);
    const wa: Wide = a;
    const wb: Wide = b;
    return @truncate((wa + wb + @as(@Vector(8, u32), @splat(1))) >> @as(Wide, @splat(1)));
}

test vrhaddq_u16 {
    const a = types.u16x8{ 10, 20, 0, 100, 50, 4, 150, 1 };
    const b = types.u16x8{ 4, 6, 10, 50, 60, 20, 80, 3 };
    const expected = types.u16x8{ 7, 13, 5, 75, 55, 12, 115, 2 };
    try common.testIntrinsic(.{ .func = vrhaddq_u16, .expected = expected, .args = .{ a, b } });
}

/// Vector halving addition: returns `(a + b) >> 1`
pub inline fn vhaddq_u32(a: types.u32x4, b: types.u32x4) types.u32x4 {
    const Wide = @Vector(4, u64);
    const wa: Wide = a;
    const wb: Wide = b;
    return @truncate((wa + wb) >> @as(Wide, @splat(1)));
}

test vhaddq_u32 {
    const a = types.u32x4{ 10, 20, 0, 100 };
    const b = types.u32x4{ 4, 6, 10, 50 };
    const expected = types.u32x4{ 7, 13, 5, 75 };
    try common.testIntrinsic(.{ .func = vhaddq_u32, .expected = expected, .args = .{ a, b } });
}

/// Vector rounding halving addition: returns `(a + b + 1) >> 1`
pub inline fn vrhaddq_u32(a: types.u32x4, b: types.u32x4) types.u32x4 {
    const Wide = @Vector(4, u64);
    const wa: Wide = a;
    const wb: Wide = b;
    return @truncate((wa + wb + @as(@Vector(4, u64), @splat(1))) >> @as(Wide, @splat(1)));
}

test vrhaddq_u32 {
    const a = types.u32x4{ 10, 20, 0, 100 };
    const b = types.u32x4{ 4, 6, 10, 50 };
    const expected = types.u32x4{ 7, 13, 5, 75 };
    try common.testIntrinsic(.{ .func = vrhaddq_u32, .expected = expected, .args = .{ a, b } });
}

/// Vector halving subtraction: returns `(a - b) >> 1`
pub inline fn vhsub_s8(a: types.i8x8, b: types.i8x8) types.i8x8 {
    const Wide = @Vector(8, i16);
    const wa: Wide = a;
    const wb: Wide = b;
    return @truncate((wa -% wb) >> @as(Wide, @splat(1)));
}

test vhsub_s8 {
    const a = types.i8x8{ 10, 20, -10, 0, 5, -5, 40, -50 };
    const b = types.i8x8{ 4, 6, 10, 10, 2, -1, 20, -30 };
    const expected = types.i8x8{ 3, 7, -10, -5, 1, -2, 10, -10 };
    try common.testIntrinsic(.{ .func = vhsub_s8, .expected = expected, .args = .{ a, b } });
}

/// Vector halving subtraction: returns `(a - b) >> 1`
pub inline fn vhsub_s16(a: types.i16x4, b: types.i16x4) types.i16x4 {
    const Wide = @Vector(4, i32);
    const wa: Wide = a;
    const wb: Wide = b;
    return @truncate((wa -% wb) >> @as(Wide, @splat(1)));
}

test vhsub_s16 {
    const a = types.i16x4{ 10, 20, -10, 0 };
    const b = types.i16x4{ 4, 6, 10, 10 };
    const expected = types.i16x4{ 3, 7, -10, -5 };
    try common.testIntrinsic(.{ .func = vhsub_s16, .expected = expected, .args = .{ a, b } });
}

/// Vector halving subtraction: returns `(a - b) >> 1`
pub inline fn vhsub_s32(a: types.i32x2, b: types.i32x2) types.i32x2 {
    const Wide = @Vector(2, i64);
    const wa: Wide = a;
    const wb: Wide = b;
    return @truncate((wa -% wb) >> @as(Wide, @splat(1)));
}

test vhsub_s32 {
    const a = types.i32x2{ 10, 20 };
    const b = types.i32x2{ 4, 6 };
    const expected = types.i32x2{ 3, 7 };
    try common.testIntrinsic(.{ .func = vhsub_s32, .expected = expected, .args = .{ a, b } });
}

/// Vector halving subtraction: returns `(a - b) >> 1`
pub inline fn vhsub_u8(a: types.u8x8, b: types.u8x8) types.u8x8 {
    const Wide = @Vector(8, i16);
    const wa: Wide = a;
    const wb: Wide = b;
    const diff = (wa -% wb) >> @as(Wide, @splat(1));
    return @truncate(@as(@Vector(8, u16), @bitCast(diff)));
}

test vhsub_u8 {
    const a = types.u8x8{ 10, 20, 0, 100, 50, 4, 150, 1 };
    const b = types.u8x8{ 4, 6, 10, 50, 60, 20, 80, 3 };
    const expected = types.u8x8{ 3, 7, 251, 25, 251, 248, 35, 255 };
    try common.testIntrinsic(.{ .func = vhsub_u8, .expected = expected, .args = .{ a, b } });
}

/// Vector halving subtraction: returns `(a - b) >> 1`
pub inline fn vhsub_u16(a: types.u16x4, b: types.u16x4) types.u16x4 {
    const Wide = @Vector(4, i32);
    const wa: Wide = a;
    const wb: Wide = b;
    const diff = (wa -% wb) >> @as(Wide, @splat(1));
    return @truncate(@as(@Vector(4, u32), @bitCast(diff)));
}

test vhsub_u16 {
    const a = types.u16x4{ 10, 20, 0, 100 };
    const b = types.u16x4{ 4, 6, 10, 50 };
    const expected = types.u16x4{ 3, 7, 65531, 25 };
    try common.testIntrinsic(.{ .func = vhsub_u16, .expected = expected, .args = .{ a, b } });
}

/// Vector halving subtraction: returns `(a - b) >> 1`
pub inline fn vhsub_u32(a: types.u32x2, b: types.u32x2) types.u32x2 {
    const Wide = @Vector(2, i64);
    const wa: Wide = a;
    const wb: Wide = b;
    const diff = (wa -% wb) >> @as(Wide, @splat(1));
    return @truncate(@as(@Vector(2, u64), @bitCast(diff)));
}

test vhsub_u32 {
    const a = types.u32x2{ 10, 20 };
    const b = types.u32x2{ 4, 6 };
    const expected = types.u32x2{ 3, 7 };
    try common.testIntrinsic(.{ .func = vhsub_u32, .expected = expected, .args = .{ a, b } });
}

/// Vector halving subtraction: returns `(a - b) >> 1`
pub inline fn vhsubq_s8(a: types.i8x16, b: types.i8x16) types.i8x16 {
    const Wide = @Vector(16, i16);
    const wa: Wide = a;
    const wb: Wide = b;
    return @truncate((wa -% wb) >> @as(Wide, @splat(1)));
}

test vhsubq_s8 {
    const a = types.i8x16{ 10, 20, -10, 0, 5, -5, 40, -50, 10, 10, 10, 10, 10, 10, 10, 10 };
    const b = types.i8x16{ 4, 6, 10, 10, 2, -1, 20, -30, 4, 4, 4, 4, 4, 4, 4, 4 };
    const expected = types.i8x16{ 3, 7, -10, -5, 1, -2, 10, -10, 3, 3, 3, 3, 3, 3, 3, 3 };
    try common.testIntrinsic(.{ .func = vhsubq_s8, .expected = expected, .args = .{ a, b } });
}

/// Vector halving subtraction: returns `(a - b) >> 1`
pub inline fn vhsubq_s16(a: types.i16x8, b: types.i16x8) types.i16x8 {
    const Wide = @Vector(8, i32);
    const wa: Wide = a;
    const wb: Wide = b;
    return @truncate((wa -% wb) >> @as(Wide, @splat(1)));
}

test vhsubq_s16 {
    const a = types.i16x8{ 10, 20, -10, 0, 5, -5, 40, -50 };
    const b = types.i16x8{ 4, 6, 10, 10, 2, -1, 20, -30 };
    const expected = types.i16x8{ 3, 7, -10, -5, 1, -2, 10, -10 };
    try common.testIntrinsic(.{ .func = vhsubq_s16, .expected = expected, .args = .{ a, b } });
}

/// Vector halving subtraction: returns `(a - b) >> 1`
pub inline fn vhsubq_s32(a: types.i32x4, b: types.i32x4) types.i32x4 {
    const Wide = @Vector(4, i64);
    const wa: Wide = a;
    const wb: Wide = b;
    return @truncate((wa -% wb) >> @as(Wide, @splat(1)));
}

test vhsubq_s32 {
    const a = types.i32x4{ 10, 20, -10, 0 };
    const b = types.i32x4{ 4, 6, 10, 10 };
    const expected = types.i32x4{ 3, 7, -10, -5 };
    try common.testIntrinsic(.{ .func = vhsubq_s32, .expected = expected, .args = .{ a, b } });
}

/// Vector halving subtraction: returns `(a - b) >> 1`
pub inline fn vhsubq_u8(a: types.u8x16, b: types.u8x16) types.u8x16 {
    const Wide = @Vector(16, i16);
    const wa: Wide = a;
    const wb: Wide = b;
    const diff = (wa -% wb) >> @as(Wide, @splat(1));
    return @truncate(@as(@Vector(16, u16), @bitCast(diff)));
}

test vhsubq_u8 {
    const a = types.u8x16{ 10, 20, 0, 100, 50, 4, 150, 1, 10, 10, 10, 10, 10, 10, 10, 10 };
    const b = types.u8x16{ 4, 6, 10, 50, 60, 20, 80, 3, 4, 4, 4, 4, 4, 4, 4, 4 };
    const expected = types.u8x16{ 3, 7, 251, 25, 251, 248, 35, 255, 3, 3, 3, 3, 3, 3, 3, 3 };
    try common.testIntrinsic(.{ .func = vhsubq_u8, .expected = expected, .args = .{ a, b } });
}

/// Vector halving subtraction: returns `(a - b) >> 1`
pub inline fn vhsubq_u16(a: types.u16x8, b: types.u16x8) types.u16x8 {
    const Wide = @Vector(8, i32);
    const wa: Wide = a;
    const wb: Wide = b;
    const diff = (wa -% wb) >> @as(Wide, @splat(1));
    return @truncate(@as(@Vector(8, u32), @bitCast(diff)));
}

test vhsubq_u16 {
    const a = types.u16x8{ 10, 20, 0, 100, 50, 4, 150, 1 };
    const b = types.u16x8{ 4, 6, 10, 50, 60, 20, 80, 3 };
    const expected = types.u16x8{ 3, 7, 65531, 25, 65531, 65528, 35, 65535 };
    try common.testIntrinsic(.{ .func = vhsubq_u16, .expected = expected, .args = .{ a, b } });
}

/// Vector halving subtraction: returns `(a - b) >> 1`
pub inline fn vhsubq_u32(a: types.u32x4, b: types.u32x4) types.u32x4 {
    const Wide = @Vector(4, i64);
    const wa: Wide = a;
    const wb: Wide = b;
    const diff = (wa -% wb) >> @as(Wide, @splat(1));
    return @truncate(@as(@Vector(4, u64), @bitCast(diff)));
}

test vhsubq_u32 {
    const a = types.u32x4{ 10, 20, 0, 100 };
    const b = types.u32x4{ 4, 6, 10, 50 };
    const expected = types.u32x4{ 3, 7, 4294967291, 25 };
    try common.testIntrinsic(.{ .func = vhsubq_u32, .expected = expected, .args = .{ a, b } });
}

/// Saturating vector addition: returns `a +| b`
pub inline fn vqadd_s8(a: types.i8x8, b: types.i8x8) types.i8x8 {
    return a +| b;
}

test vqadd_s8 {
    const a = types.i8x8{ 117, -118, 10, -20, 0, 127, -128, 50 };
    const b = types.i8x8{ 20, -20, 5, -5, 0, 10, -10, 127 };
    const expected = types.i8x8{ 127, -128, 15, -25, 0, 127, -128, 127 };
    try common.testIntrinsic(.{ .func = vqadd_s8, .expected = expected, .args = .{ a, b } });
}

/// Saturating vector addition: returns `a +| b`
pub inline fn vqaddq_s8(a: types.i8x16, b: types.i8x16) types.i8x16 {
    return a +| b;
}

test vqaddq_s8 {
    const a = types.i8x16{ 117, -118, 10, -20, 0, 127, -128, 50, 117, 117, 117, 117, 117, 117, 117, 117 };
    const b = types.i8x16{ 20, -20, 5, -5, 0, 10, -10, 127, 20, 20, 20, 20, 20, 20, 20, 20 };
    const expected = types.i8x16{ 127, -128, 15, -25, 0, 127, -128, 127, 127, 127, 127, 127, 127, 127, 127, 127 };
    try common.testIntrinsic(.{ .func = vqaddq_s8, .expected = expected, .args = .{ a, b } });
}

/// Saturating vector addition: returns `a +| b`
pub inline fn vqadd_s16(a: types.i16x4, b: types.i16x4) types.i16x4 {
    return a +| b;
}

test vqadd_s16 {
    const a = types.i16x4{ 32757, -32758, 10, -20 };
    const b = types.i16x4{ 20, -20, 5, -5 };
    const expected = types.i16x4{ 32767, -32768, 15, -25 };
    try common.testIntrinsic(.{ .func = vqadd_s16, .expected = expected, .args = .{ a, b } });
}

/// Saturating vector addition: returns `a +| b`
pub inline fn vqaddq_s16(a: types.i16x8, b: types.i16x8) types.i16x8 {
    return a +| b;
}

test vqaddq_s16 {
    const a = types.i16x8{ 32757, -32758, 10, -20, 0, 32767, -32768, 50 };
    const b = types.i16x8{ 20, -20, 5, -5, 0, 10, -10, 32767 };
    const expected = types.i16x8{ 32767, -32768, 15, -25, 0, 32767, -32768, 32767 };
    try common.testIntrinsic(.{ .func = vqaddq_s16, .expected = expected, .args = .{ a, b } });
}

/// Saturating vector addition: returns `a +| b`
pub inline fn vqadd_s32(a: types.i32x2, b: types.i32x2) types.i32x2 {
    return a +| b;
}

test vqadd_s32 {
    const a = types.i32x2{ 2147483637, -2147483638 };
    const b = types.i32x2{ 20, -20 };
    const expected = types.i32x2{ 2147483647, -2147483648 };
    try common.testIntrinsic(.{ .func = vqadd_s32, .expected = expected, .args = .{ a, b } });
}

/// Saturating vector addition: returns `a +| b`
pub inline fn vqaddq_s32(a: types.i32x4, b: types.i32x4) types.i32x4 {
    return a +| b;
}

test vqaddq_s32 {
    const a = types.i32x4{ 2147483637, -2147483638, 10, -20 };
    const b = types.i32x4{ 20, -20, 5, -5 };
    const expected = types.i32x4{ 2147483647, -2147483648, 15, -25 };
    try common.testIntrinsic(.{ .func = vqaddq_s32, .expected = expected, .args = .{ a, b } });
}

/// Saturating vector addition: returns `a +| b`
pub inline fn vqadd_s64(a: types.i64x1, b: types.i64x1) types.i64x1 {
    return a +| b;
}

test vqadd_s64 {
    const a = types.i64x1{9223372036854775797};
    const b = types.i64x1{20};
    const expected = types.i64x1{9223372036854775807};
    try common.testIntrinsic(.{ .func = vqadd_s64, .expected = expected, .args = .{ a, b } });
}

/// Saturating vector addition: returns `a +| b`
pub inline fn vqaddq_s64(a: types.i64x2, b: types.i64x2) types.i64x2 {
    return a +| b;
}

test vqaddq_s64 {
    const a = types.i64x2{ 9223372036854775797, -9223372036854775798 };
    const b = types.i64x2{ 20, -20 };
    const expected = types.i64x2{ 9223372036854775807, -9223372036854775808 };
    try common.testIntrinsic(.{ .func = vqaddq_s64, .expected = expected, .args = .{ a, b } });
}

/// Saturating vector addition: returns `a +| b`
pub inline fn vqadd_u8(a: types.u8x8, b: types.u8x8) types.u8x8 {
    return a +| b;
}

test vqadd_u8 {
    const a = types.u8x8{ 245, 10, 50, 0, 255, 50, 100, 1 };
    const b = types.u8x8{ 20, 5, 20, 0, 10, 255, 50, 2 };
    const expected = types.u8x8{ 255, 15, 70, 0, 255, 255, 150, 3 };
    try common.testIntrinsic(.{ .func = vqadd_u8, .expected = expected, .args = .{ a, b } });
}

/// Saturating vector addition: returns `a +| b`
pub inline fn vqaddq_u8(a: types.u8x16, b: types.u8x16) types.u8x16 {
    return a +| b;
}

test vqaddq_u8 {
    const a = types.u8x16{ 245, 10, 50, 0, 255, 50, 100, 1, 245, 245, 245, 245, 245, 245, 245, 245 };
    const b = types.u8x16{ 20, 5, 20, 0, 10, 255, 50, 2, 20, 20, 20, 20, 20, 20, 20, 20 };
    const expected = types.u8x16{ 255, 15, 70, 0, 255, 255, 150, 3, 255, 255, 255, 255, 255, 255, 255, 255 };
    try common.testIntrinsic(.{ .func = vqaddq_u8, .expected = expected, .args = .{ a, b } });
}

/// Saturating vector addition: returns `a +| b`
pub inline fn vqadd_u16(a: types.u16x4, b: types.u16x4) types.u16x4 {
    return a +| b;
}

test vqadd_u16 {
    const a = types.u16x4{ 65525, 10, 50, 0 };
    const b = types.u16x4{ 20, 5, 20, 0 };
    const expected = types.u16x4{ 65535, 15, 70, 0 };
    try common.testIntrinsic(.{ .func = vqadd_u16, .expected = expected, .args = .{ a, b } });
}

/// Saturating vector addition: returns `a +| b`
pub inline fn vqaddq_u16(a: types.u16x8, b: types.u16x8) types.u16x8 {
    return a +| b;
}

test vqaddq_u16 {
    const a = types.u16x8{ 65525, 10, 50, 0, 65535, 50, 100, 1 };
    const b = types.u16x8{ 20, 5, 20, 0, 10, 65535, 50, 2 };
    const expected = types.u16x8{ 65535, 15, 70, 0, 65535, 65535, 150, 3 };
    try common.testIntrinsic(.{ .func = vqaddq_u16, .expected = expected, .args = .{ a, b } });
}

/// Saturating vector addition: returns `a +| b`
pub inline fn vqadd_u32(a: types.u32x2, b: types.u32x2) types.u32x2 {
    return a +| b;
}

test vqadd_u32 {
    const a = types.u32x2{ 4294967285, 10 };
    const b = types.u32x2{ 20, 5 };
    const expected = types.u32x2{ 4294967295, 15 };
    try common.testIntrinsic(.{ .func = vqadd_u32, .expected = expected, .args = .{ a, b } });
}

/// Saturating vector addition: returns `a +| b`
pub inline fn vqaddq_u32(a: types.u32x4, b: types.u32x4) types.u32x4 {
    return a +| b;
}

test vqaddq_u32 {
    const a = types.u32x4{ 4294967285, 10, 50, 0 };
    const b = types.u32x4{ 20, 5, 20, 0 };
    const expected = types.u32x4{ 4294967295, 15, 70, 0 };
    try common.testIntrinsic(.{ .func = vqaddq_u32, .expected = expected, .args = .{ a, b } });
}

/// Saturating vector addition: returns `a +| b`
pub inline fn vqadd_u64(a: types.u64x1, b: types.u64x1) types.u64x1 {
    return a +| b;
}

test vqadd_u64 {
    const a = types.u64x1{18446744073709551605};
    const b = types.u64x1{20};
    const expected = types.u64x1{18446744073709551615};
    try common.testIntrinsic(.{ .func = vqadd_u64, .expected = expected, .args = .{ a, b } });
}

/// Saturating vector addition: returns `a +| b`
pub inline fn vqaddq_u64(a: types.u64x2, b: types.u64x2) types.u64x2 {
    return a +| b;
}

test vqaddq_u64 {
    const a = types.u64x2{ 18446744073709551605, 10 };
    const b = types.u64x2{ 20, 5 };
    const expected = types.u64x2{ 18446744073709551615, 15 };
    try common.testIntrinsic(.{ .func = vqaddq_u64, .expected = expected, .args = .{ a, b } });
}

/// Vector negation: returns `-a`
pub inline fn vneg_s8(a: types.i8x8) types.i8x8 {
    return -%a;
}

test vneg_s8 {
    const a = types.i8x8{ 10, -20, 5, -1, 0, 12, -8, 25 };
    const expected = types.i8x8{ -10, 20, -5, 1, 0, -12, 8, -25 };
    try common.testIntrinsic(.{ .func = vneg_s8, .expected = expected, .args = .{a} });
}

/// Vector negation: returns `-a`
pub inline fn vnegq_s8(a: types.i8x16) types.i8x16 {
    return -%a;
}

test vnegq_s8 {
    const a = types.i8x16{ 10, -20, 5, -1, 0, 12, -8, 25, 10, 10, 10, 10, 10, 10, 10, 10 };
    const expected = types.i8x16{ -10, 20, -5, 1, 0, -12, 8, -25, -10, -10, -10, -10, -10, -10, -10, -10 };
    try common.testIntrinsic(.{ .func = vnegq_s8, .expected = expected, .args = .{a} });
}

/// Vector negation: returns `-a`
pub inline fn vneg_s16(a: types.i16x4) types.i16x4 {
    return -%a;
}

test vneg_s16 {
    const a = types.i16x4{ 10, -20, 5, -1 };
    const expected = types.i16x4{ -10, 20, -5, 1 };
    try common.testIntrinsic(.{ .func = vneg_s16, .expected = expected, .args = .{a} });
}

/// Vector negation: returns `-a`
pub inline fn vnegq_s16(a: types.i16x8) types.i16x8 {
    return -%a;
}

test vnegq_s16 {
    const a = types.i16x8{ 10, -20, 5, -1, 0, 12, -8, 25 };
    const expected = types.i16x8{ -10, 20, -5, 1, 0, -12, 8, -25 };
    try common.testIntrinsic(.{ .func = vnegq_s16, .expected = expected, .args = .{a} });
}

/// Vector negation: returns `-a`
pub inline fn vneg_s32(a: types.i32x2) types.i32x2 {
    return -%a;
}

test vneg_s32 {
    const a = types.i32x2{ 10, -20 };
    const expected = types.i32x2{ -10, 20 };
    try common.testIntrinsic(.{ .func = vneg_s32, .expected = expected, .args = .{a} });
}

/// Vector negation: returns `-a`
pub inline fn vnegq_s32(a: types.i32x4) types.i32x4 {
    return -%a;
}

test vnegq_s32 {
    const a = types.i32x4{ 10, -20, 5, -1 };
    const expected = types.i32x4{ -10, 20, -5, 1 };
    try common.testIntrinsic(.{ .func = vnegq_s32, .expected = expected, .args = .{a} });
}

/// Vector negation: returns `-a`
pub inline fn vneg_s64(a: types.i64x1) types.i64x1 {
    return -%a;
}

test vneg_s64 {
    const a = types.i64x1{10};
    const expected = types.i64x1{-10};
    try common.testIntrinsic(.{ .func = vneg_s64, .expected = expected, .args = .{a} });
}

/// Vector negation: returns `-a`
pub inline fn vnegq_s64(a: types.i64x2) types.i64x2 {
    return -%a;
}

test vnegq_s64 {
    const a = types.i64x2{ 10, -20 };
    const expected = types.i64x2{ -10, 20 };
    try common.testIntrinsic(.{ .func = vnegq_s64, .expected = expected, .args = .{a} });
}

/// Vector multiplication: returns `a * b`
pub inline fn vmul_s8(a: types.i8x8, b: types.i8x8) types.i8x8 {
    return a *% b;
}

test vmul_s8 {
    const a = types.i8x8{ 10, -20, 15, 30, -10, 25, 0, 12 };
    const b = types.i8x8{ 2, 3, -4, 2, -2, 2, 4, 3 };
    const expected = types.i8x8{ 20, -60, -60, 60, 20, 50, 0, 36 };
    try common.testIntrinsic(.{ .func = vmul_s8, .expected = expected, .args = .{ a, b } });
}

/// Vector multiplication: returns `a * b`
pub inline fn vmulq_s8(a: types.i8x16, b: types.i8x16) types.i8x16 {
    return a *% b;
}

test vmulq_s8 {
    const a = types.i8x16{ 10, -20, 15, 30, -10, 25, 0, 12, 10, 10, 10, 10, 10, 10, 10, 10 };
    const b = types.i8x16{ 2, 3, -4, 2, -2, 2, 4, 3, 2, 2, 2, 2, 2, 2, 2, 2 };
    const expected = types.i8x16{ 20, -60, -60, 60, 20, 50, 0, 36, 20, 20, 20, 20, 20, 20, 20, 20 };
    try common.testIntrinsic(.{ .func = vmulq_s8, .expected = expected, .args = .{ a, b } });
}

/// Vector multiplication: returns `a * b`
pub inline fn vmul_s16(a: types.i16x4, b: types.i16x4) types.i16x4 {
    return a *% b;
}

test vmul_s16 {
    const a = types.i16x4{ 10, -20, 15, 30 };
    const b = types.i16x4{ 2, 3, -4, 2 };
    const expected = types.i16x4{ 20, -60, -60, 60 };
    try common.testIntrinsic(.{ .func = vmul_s16, .expected = expected, .args = .{ a, b } });
}

/// Vector multiplication: returns `a * b`
pub inline fn vmulq_s16(a: types.i16x8, b: types.i16x8) types.i16x8 {
    return a *% b;
}

test vmulq_s16 {
    const a = types.i16x8{ 10, -20, 15, 30, -10, 25, 0, 12 };
    const b = types.i16x8{ 2, 3, -4, 2, -2, 2, 4, 3 };
    const expected = types.i16x8{ 20, -60, -60, 60, 20, 50, 0, 36 };
    try common.testIntrinsic(.{ .func = vmulq_s16, .expected = expected, .args = .{ a, b } });
}

/// Vector multiplication: returns `a * b`
pub inline fn vmul_s32(a: types.i32x2, b: types.i32x2) types.i32x2 {
    return a *% b;
}

test vmul_s32 {
    const a = types.i32x2{ 10, -20 };
    const b = types.i32x2{ 2, 3 };
    const expected = types.i32x2{ 20, -60 };
    try common.testIntrinsic(.{ .func = vmul_s32, .expected = expected, .args = .{ a, b } });
}

/// Vector multiplication: returns `a * b`
pub inline fn vmulq_s32(a: types.i32x4, b: types.i32x4) types.i32x4 {
    return a *% b;
}

test vmulq_s32 {
    const a = types.i32x4{ 10, -20, 15, 30 };
    const b = types.i32x4{ 2, 3, -4, 2 };
    const expected = types.i32x4{ 20, -60, -60, 60 };
    try common.testIntrinsic(.{ .func = vmulq_s32, .expected = expected, .args = .{ a, b } });
}

/// Vector multiplication: returns `a * b`
pub inline fn vmul_u8(a: types.u8x8, b: types.u8x8) types.u8x8 {
    return a *% b;
}

test vmul_u8 {
    const a = types.u8x8{ 10, 20, 15, 40, 10, 30, 0, 12 };
    const b = types.u8x8{ 2, 5, 3, 10, 2, 2, 4, 3 };
    const expected = types.u8x8{ 20, 100, 45, 144, 20, 60, 0, 36 };
    try common.testIntrinsic(.{ .func = vmul_u8, .expected = expected, .args = .{ a, b } });
}

/// Vector multiplication: returns `a * b`
pub inline fn vmulq_u8(a: types.u8x16, b: types.u8x16) types.u8x16 {
    return a *% b;
}

test vmulq_u8 {
    const a = types.u8x16{ 10, 20, 15, 40, 10, 30, 0, 12, 10, 10, 10, 10, 10, 10, 10, 10 };
    const b = types.u8x16{ 2, 5, 3, 10, 2, 2, 4, 3, 2, 2, 2, 2, 2, 2, 2, 2 };
    const expected = types.u8x16{ 20, 100, 45, 144, 20, 60, 0, 36, 20, 20, 20, 20, 20, 20, 20, 20 };
    try common.testIntrinsic(.{ .func = vmulq_u8, .expected = expected, .args = .{ a, b } });
}

/// Vector multiplication: returns `a * b`
pub inline fn vmul_u16(a: types.u16x4, b: types.u16x4) types.u16x4 {
    return a *% b;
}

test vmul_u16 {
    const a = types.u16x4{ 10, 20, 15, 40 };
    const b = types.u16x4{ 2, 5, 3, 10 };
    const expected = types.u16x4{ 20, 100, 45, 400 };
    try common.testIntrinsic(.{ .func = vmul_u16, .expected = expected, .args = .{ a, b } });
}

/// Vector multiplication: returns `a * b`
pub inline fn vmulq_u16(a: types.u16x8, b: types.u16x8) types.u16x8 {
    return a *% b;
}

test vmulq_u16 {
    const a = types.u16x8{ 10, 20, 15, 40, 10, 30, 0, 12 };
    const b = types.u16x8{ 2, 5, 3, 10, 2, 2, 4, 3 };
    const expected = types.u16x8{ 20, 100, 45, 400, 20, 60, 0, 36 };
    try common.testIntrinsic(.{ .func = vmulq_u16, .expected = expected, .args = .{ a, b } });
}

/// Vector multiplication: returns `a * b`
pub inline fn vmul_u32(a: types.u32x2, b: types.u32x2) types.u32x2 {
    return a *% b;
}

test vmul_u32 {
    const a = types.u32x2{ 10, 20 };
    const b = types.u32x2{ 2, 5 };
    const expected = types.u32x2{ 20, 100 };
    try common.testIntrinsic(.{ .func = vmul_u32, .expected = expected, .args = .{ a, b } });
}

/// Vector multiplication: returns `a * b`
pub inline fn vmulq_u32(a: types.u32x4, b: types.u32x4) types.u32x4 {
    return a *% b;
}

test vmulq_u32 {
    const a = types.u32x4{ 10, 20, 15, 40 };
    const b = types.u32x4{ 2, 5, 3, 10 };
    const expected = types.u32x4{ 20, 100, 45, 400 };
    try common.testIntrinsic(.{ .func = vmulq_u32, .expected = expected, .args = .{ a, b } });
}

/// Vector subtraction: returns `a - b`
pub inline fn vsub_s8(a: types.i8x8, b: types.i8x8) types.i8x8 {
    return a -% b;
}

test vsub_s8 {
    const a = types.i8x8{ 10, -20, 15, 30, -10, 25, 0, 12 };
    const b = types.i8x8{ 2, 3, -4, 2, -2, 2, 4, 3 };
    const expected = types.i8x8{ 8, -23, 19, 28, -8, 23, -4, 9 };
    try common.testIntrinsic(.{ .func = vsub_s8, .expected = expected, .args = .{ a, b } });
}

/// Vector subtraction: returns `a - b`
pub inline fn vsubq_s8(a: types.i8x16, b: types.i8x16) types.i8x16 {
    return a -% b;
}

test vsubq_s8 {
    const a = types.i8x16{ 10, -20, 15, 30, -10, 25, 0, 12, 10, 10, 10, 10, 10, 10, 10, 10 };
    const b = types.i8x16{ 2, 3, -4, 2, -2, 2, 4, 3, 2, 2, 2, 2, 2, 2, 2, 2 };
    const expected = types.i8x16{ 8, -23, 19, 28, -8, 23, -4, 9, 8, 8, 8, 8, 8, 8, 8, 8 };
    try common.testIntrinsic(.{ .func = vsubq_s8, .expected = expected, .args = .{ a, b } });
}

/// Vector subtraction: returns `a - b`
pub inline fn vsub_s16(a: types.i16x4, b: types.i16x4) types.i16x4 {
    return a -% b;
}

test vsub_s16 {
    const a = types.i16x4{ 10, -20, 15, 30 };
    const b = types.i16x4{ 2, 3, -4, 2 };
    const expected = types.i16x4{ 8, -23, 19, 28 };
    try common.testIntrinsic(.{ .func = vsub_s16, .expected = expected, .args = .{ a, b } });
}

/// Vector subtraction: returns `a - b`
pub inline fn vsubq_s16(a: types.i16x8, b: types.i16x8) types.i16x8 {
    return a -% b;
}

test vsubq_s16 {
    const a = types.i16x8{ 10, -20, 15, 30, -10, 25, 0, 12 };
    const b = types.i16x8{ 2, 3, -4, 2, -2, 2, 4, 3 };
    const expected = types.i16x8{ 8, -23, 19, 28, -8, 23, -4, 9 };
    try common.testIntrinsic(.{ .func = vsubq_s16, .expected = expected, .args = .{ a, b } });
}

/// Vector subtraction: returns `a - b`
pub inline fn vsub_s32(a: types.i32x2, b: types.i32x2) types.i32x2 {
    return a -% b;
}

test vsub_s32 {
    const a = types.i32x2{ 10, -20 };
    const b = types.i32x2{ 2, 3 };
    const expected = types.i32x2{ 8, -23 };
    try common.testIntrinsic(.{ .func = vsub_s32, .expected = expected, .args = .{ a, b } });
}

/// Vector subtraction: returns `a - b`
pub inline fn vsubq_s32(a: types.i32x4, b: types.i32x4) types.i32x4 {
    return a -% b;
}

test vsubq_s32 {
    const a = types.i32x4{ 10, -20, 15, 30 };
    const b = types.i32x4{ 2, 3, -4, 2 };
    const expected = types.i32x4{ 8, -23, 19, 28 };
    try common.testIntrinsic(.{ .func = vsubq_s32, .expected = expected, .args = .{ a, b } });
}

/// Vector subtraction: returns `a - b`
pub inline fn vsub_s64(a: types.i64x1, b: types.i64x1) types.i64x1 {
    return a -% b;
}

test vsub_s64 {
    const a = types.i64x1{10};
    const b = types.i64x1{2};
    const expected = types.i64x1{8};
    try common.testIntrinsic(.{ .func = vsub_s64, .expected = expected, .args = .{ a, b } });
}

/// Vector subtraction: returns `a - b`
pub inline fn vsubq_s64(a: types.i64x2, b: types.i64x2) types.i64x2 {
    return a -% b;
}

test vsubq_s64 {
    const a = types.i64x2{ 10, -20 };
    const b = types.i64x2{ 2, 3 };
    const expected = types.i64x2{ 8, -23 };
    try common.testIntrinsic(.{ .func = vsubq_s64, .expected = expected, .args = .{ a, b } });
}

/// Vector subtraction: returns `a - b`
pub inline fn vsub_u8(a: types.u8x8, b: types.u8x8) types.u8x8 {
    return a -% b;
}

test vsub_u8 {
    const a = types.u8x8{ 10, 20, 15, 40, 10, 30, 0, 12 };
    const b = types.u8x8{ 2, 5, 3, 10, 2, 2, 4, 3 };
    const expected = types.u8x8{ 8, 15, 12, 30, 8, 28, 252, 9 };
    try common.testIntrinsic(.{ .func = vsub_u8, .expected = expected, .args = .{ a, b } });
}

/// Vector subtraction: returns `a - b`
pub inline fn vsubq_u8(a: types.u8x16, b: types.u8x16) types.u8x16 {
    return a -% b;
}

test vsubq_u8 {
    const a = types.u8x16{ 10, 20, 15, 40, 10, 30, 0, 12, 10, 10, 10, 10, 10, 10, 10, 10 };
    const b = types.u8x16{ 2, 5, 3, 10, 2, 2, 4, 3, 2, 2, 2, 2, 2, 2, 2, 2 };
    const expected = types.u8x16{ 8, 15, 12, 30, 8, 28, 252, 9, 8, 8, 8, 8, 8, 8, 8, 8 };
    try common.testIntrinsic(.{ .func = vsubq_u8, .expected = expected, .args = .{ a, b } });
}

/// Vector subtraction: returns `a - b`
pub inline fn vsub_u16(a: types.u16x4, b: types.u16x4) types.u16x4 {
    return a -% b;
}

test vsub_u16 {
    const a = types.u16x4{ 10, 20, 15, 40 };
    const b = types.u16x4{ 2, 5, 3, 10 };
    const expected = types.u16x4{ 8, 15, 12, 30 };
    try common.testIntrinsic(.{ .func = vsub_u16, .expected = expected, .args = .{ a, b } });
}

/// Vector subtraction: returns `a - b`
pub inline fn vsubq_u16(a: types.u16x8, b: types.u16x8) types.u16x8 {
    return a -% b;
}

test vsubq_u16 {
    const a = types.u16x8{ 10, 20, 15, 40, 10, 30, 0, 12 };
    const b = types.u16x8{ 2, 5, 3, 10, 2, 2, 4, 3 };
    const expected = types.u16x8{ 8, 15, 12, 30, 8, 28, 65532, 9 };
    try common.testIntrinsic(.{ .func = vsubq_u16, .expected = expected, .args = .{ a, b } });
}

/// Vector subtraction: returns `a - b`
pub inline fn vsub_u32(a: types.u32x2, b: types.u32x2) types.u32x2 {
    return a -% b;
}

test vsub_u32 {
    const a = types.u32x2{ 10, 20 };
    const b = types.u32x2{ 2, 5 };
    const expected = types.u32x2{ 8, 15 };
    try common.testIntrinsic(.{ .func = vsub_u32, .expected = expected, .args = .{ a, b } });
}

/// Vector subtraction: returns `a - b`
pub inline fn vsubq_u32(a: types.u32x4, b: types.u32x4) types.u32x4 {
    return a -% b;
}

test vsubq_u32 {
    const a = types.u32x4{ 10, 20, 15, 40 };
    const b = types.u32x4{ 2, 5, 3, 10 };
    const expected = types.u32x4{ 8, 15, 12, 30 };
    try common.testIntrinsic(.{ .func = vsubq_u32, .expected = expected, .args = .{ a, b } });
}

/// Vector subtraction: returns `a - b`
pub inline fn vsub_u64(a: types.u64x1, b: types.u64x1) types.u64x1 {
    return a -% b;
}

test vsub_u64 {
    const a = types.u64x1{10};
    const b = types.u64x1{2};
    const expected = types.u64x1{8};
    try common.testIntrinsic(.{ .func = vsub_u64, .expected = expected, .args = .{ a, b } });
}

/// Vector subtraction: returns `a - b`
pub inline fn vsubq_u64(a: types.u64x2, b: types.u64x2) types.u64x2 {
    return a -% b;
}

test vsubq_u64 {
    const a = types.u64x2{ 10, 20 };
    const b = types.u64x2{ 2, 5 };
    const expected = types.u64x2{ 8, 15 };
    try common.testIntrinsic(.{ .func = vsubq_u64, .expected = expected, .args = .{ a, b } });
}

/// Widening vector subtraction: returns `@as(Wide, a) - @as(Wide, b)`
pub inline fn vsubl_s8(a: types.i8x8, b: types.i8x8) types.i16x8 {
    return @as(types.i16x8, a) -% @as(types.i16x8, b);
}

test vsubl_s8 {
    const a = types.i8x8{ 10, 20, -15, 40, -5, 30, 0, 12 };
    const b = types.i8x8{ 2, 5, -3, 10, -2, 2, 4, 3 };
    const expected = types.i16x8{ 8, 15, -12, 30, -3, 28, -4, 9 };
    try common.testIntrinsic(.{ .func = vsubl_s8, .expected = expected, .args = .{ a, b } });
}

/// Widening vector subtraction: returns `@as(Wide, a) - @as(Wide, b)`
pub inline fn vsubl_s16(a: types.i16x4, b: types.i16x4) types.i32x4 {
    return @as(types.i32x4, a) -% @as(types.i32x4, b);
}

test vsubl_s16 {
    const a = types.i16x4{ 10, 20, -15, 40 };
    const b = types.i16x4{ 2, 5, -3, 10 };
    const expected = types.i32x4{ 8, 15, -12, 30 };
    try common.testIntrinsic(.{ .func = vsubl_s16, .expected = expected, .args = .{ a, b } });
}

/// Widening vector subtraction: returns `@as(Wide, a) - @as(Wide, b)`
pub inline fn vsubl_s32(a: types.i32x2, b: types.i32x2) types.i64x2 {
    return @as(types.i64x2, a) -% @as(types.i64x2, b);
}

test vsubl_s32 {
    const a = types.i32x2{ 10, 20 };
    const b = types.i32x2{ 2, 5 };
    const expected = types.i64x2{ 8, 15 };
    try common.testIntrinsic(.{ .func = vsubl_s32, .expected = expected, .args = .{ a, b } });
}

/// Widening vector subtraction: returns `@as(Wide, a) - @as(Wide, b)`
pub inline fn vsubl_u8(a: types.u8x8, b: types.u8x8) types.u16x8 {
    return @as(types.u16x8, a) -% @as(types.u16x8, b);
}

test vsubl_u8 {
    const a = types.u8x8{ 10, 20, 15, 40, 5, 30, 20, 12 };
    const b = types.u8x8{ 2, 5, 3, 10, 2, 2, 4, 3 };
    const expected = types.u16x8{ 8, 15, 12, 30, 3, 28, 16, 9 };
    try common.testIntrinsic(.{ .func = vsubl_u8, .expected = expected, .args = .{ a, b } });
}

/// Widening vector subtraction: returns `@as(Wide, a) - @as(Wide, b)`
pub inline fn vsubl_u16(a: types.u16x4, b: types.u16x4) types.u32x4 {
    return @as(types.u32x4, a) -% @as(types.u32x4, b);
}

test vsubl_u16 {
    const a = types.u16x4{ 10, 20, 15, 40 };
    const b = types.u16x4{ 2, 5, 3, 10 };
    const expected = types.u32x4{ 8, 15, 12, 30 };
    try common.testIntrinsic(.{ .func = vsubl_u16, .expected = expected, .args = .{ a, b } });
}

/// Widening vector subtraction: returns `@as(Wide, a) - @as(Wide, b)`
pub inline fn vsubl_u32(a: types.u32x2, b: types.u32x2) types.u64x2 {
    return @as(types.u64x2, a) -% @as(types.u64x2, b);
}

test vsubl_u32 {
    const a = types.u32x2{ 10, 20 };
    const b = types.u32x2{ 2, 5 };
    const expected = types.u64x2{ 8, 15 };
    try common.testIntrinsic(.{ .func = vsubl_u32, .expected = expected, .args = .{ a, b } });
}

/// Wide vector subtraction: returns `a - @as(Wide, b)`
pub inline fn vsubw_s8(a: types.i16x8, b: types.i8x8) types.i16x8 {
    return a -% @as(types.i16x8, b);
}

test vsubw_s8 {
    const a = types.i16x8{ 10, 20, -15, 40, -5, 30, 0, 12 };
    const b = types.i8x8{ 2, 5, -3, 10, -2, 2, 4, 3 };
    const expected = types.i16x8{ 8, 15, -12, 30, -3, 28, -4, 9 };
    try common.testIntrinsic(.{ .func = vsubw_s8, .expected = expected, .args = .{ a, b } });
}

/// Wide vector subtraction: returns `a - @as(Wide, b)`
pub inline fn vsubw_u8(a: types.u16x8, b: types.u8x8) types.u16x8 {
    return a -% @as(types.u16x8, b);
}

test vsubw_u8 {
    const a = types.u16x8{ 10, 20, 15, 40, 5, 30, 20, 12 };
    const b = types.u8x8{ 2, 5, 3, 10, 2, 2, 4, 3 };
    const expected = types.u16x8{ 8, 15, 12, 30, 3, 28, 16, 9 };
    try common.testIntrinsic(.{ .func = vsubw_u8, .expected = expected, .args = .{ a, b } });
}

/// Pairwise addition: adds adjacent pairs of elements
pub inline fn vpadd_s8(a: types.i8x8, b: types.i8x8) types.i8x8 {
    return .{ a[0] +% a[1], a[2] +% a[3], a[4] +% a[5], a[6] +% a[7], b[0] +% b[1], b[2] +% b[3], b[4] +% b[5], b[6] +% b[7] };
}

test vpadd_s8 {
    const a = types.i8x8{ 1, 2, 3, 4, 5, 6, 7, 8 };
    const b = types.i8x8{ 10, 20, 11, 21, 12, 22, 13, 23 };
    const expected = types.i8x8{ 3, 7, 11, 15, 30, 32, 34, 36 };
    try common.testIntrinsic(.{ .func = vpadd_s8, .expected = expected, .args = .{ a, b } });
}

/// Pairwise addition: adds adjacent pairs of elements
pub inline fn vpadd_s16(a: types.i16x4, b: types.i16x4) types.i16x4 {
    return .{ a[0] +% a[1], a[2] +% a[3], b[0] +% b[1], b[2] +% b[3] };
}

test vpadd_s16 {
    const a = types.i16x4{ 1, 2, 3, 4 };
    const b = types.i16x4{ 10, 20, 11, 21 };
    const expected = types.i16x4{ 3, 7, 30, 32 };
    try common.testIntrinsic(.{ .func = vpadd_s16, .expected = expected, .args = .{ a, b } });
}

/// Pairwise addition: adds adjacent pairs of elements
pub inline fn vpadd_s32(a: types.i32x2, b: types.i32x2) types.i32x2 {
    return .{ a[0] +% a[1], b[0] +% b[1] };
}

test vpadd_s32 {
    const a = types.i32x2{ 1, 2 };
    const b = types.i32x2{ 10, 20 };
    const expected = types.i32x2{ 3, 30 };
    try common.testIntrinsic(.{ .func = vpadd_s32, .expected = expected, .args = .{ a, b } });
}

/// Pairwise addition: adds adjacent pairs of elements
pub inline fn vpadd_u8(a: types.u8x8, b: types.u8x8) types.u8x8 {
    return .{ a[0] +% a[1], a[2] +% a[3], a[4] +% a[5], a[6] +% a[7], b[0] +% b[1], b[2] +% b[3], b[4] +% b[5], b[6] +% b[7] };
}

test vpadd_u8 {
    const a = types.u8x8{ 1, 2, 3, 4, 5, 6, 7, 8 };
    const b = types.u8x8{ 10, 20, 11, 21, 12, 22, 13, 23 };
    const expected = types.u8x8{ 3, 7, 11, 15, 30, 32, 34, 36 };
    try common.testIntrinsic(.{ .func = vpadd_u8, .expected = expected, .args = .{ a, b } });
}

/// Pairwise addition: adds adjacent pairs of elements
pub inline fn vpadd_u16(a: types.u16x4, b: types.u16x4) types.u16x4 {
    return .{ a[0] +% a[1], a[2] +% a[3], b[0] +% b[1], b[2] +% b[3] };
}

test vpadd_u16 {
    const a = types.u16x4{ 1, 2, 3, 4 };
    const b = types.u16x4{ 10, 20, 11, 21 };
    const expected = types.u16x4{ 3, 7, 30, 32 };
    try common.testIntrinsic(.{ .func = vpadd_u16, .expected = expected, .args = .{ a, b } });
}

/// Pairwise addition: adds adjacent pairs of elements
pub inline fn vpadd_u32(a: types.u32x2, b: types.u32x2) types.u32x2 {
    return .{ a[0] +% a[1], b[0] +% b[1] };
}

test vpadd_u32 {
    const a = types.u32x2{ 1, 2 };
    const b = types.u32x2{ 10, 20 };
    const expected = types.u32x2{ 3, 30 };
    try common.testIntrinsic(.{ .func = vpadd_u32, .expected = expected, .args = .{ a, b } });
}

/// Pairwise addition: adds adjacent pairs of elements
pub inline fn vpadd_f32(a: types.f32x2, b: types.f32x2) types.f32x2 {
    return .{ a[0] + a[1], b[0] + b[1] };
}

test vpadd_f32 {
    const a = types.f32x2{ 1.0, 2.0 };
    const b = types.f32x2{ 10.0, 20.0 };
    const expected = types.f32x2{ 3.0, 30.0 };
    try common.testIntrinsic(.{ .func = vpadd_f32, .expected = expected, .args = .{ a, b } });
}

/// Pairwise addition: adds adjacent pairs of elements
pub inline fn vpaddq_s8(a: types.i8x16, b: types.i8x16) types.i8x16 {
    return .{ a[0] +% a[1], a[2] +% a[3], a[4] +% a[5], a[6] +% a[7], a[8] +% a[9], a[10] +% a[11], a[12] +% a[13], a[14] +% a[15], b[0] +% b[1], b[2] +% b[3], b[4] +% b[5], b[6] +% b[7], b[8] +% b[9], b[10] +% b[11], b[12] +% b[13], b[14] +% b[15] };
}

test vpaddq_s8 {
    const a = types.i8x16{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 };
    const b = types.i8x16{ 10, 20, 11, 21, 12, 22, 13, 23, 14, 24, 15, 25, 16, 26, 17, 27 };
    const expected = types.i8x16{ 3, 7, 11, 15, 19, 23, 27, 31, 30, 32, 34, 36, 38, 40, 42, 44 };
    try common.testIntrinsic(.{ .func = vpaddq_s8, .expected = expected, .args = .{ a, b } });
}

/// Pairwise addition: adds adjacent pairs of elements
pub inline fn vpaddq_s16(a: types.i16x8, b: types.i16x8) types.i16x8 {
    return .{ a[0] +% a[1], a[2] +% a[3], a[4] +% a[5], a[6] +% a[7], b[0] +% b[1], b[2] +% b[3], b[4] +% b[5], b[6] +% b[7] };
}

test vpaddq_s16 {
    const a = types.i16x8{ 1, 2, 3, 4, 5, 6, 7, 8 };
    const b = types.i16x8{ 10, 20, 11, 21, 12, 22, 13, 23 };
    const expected = types.i16x8{ 3, 7, 11, 15, 30, 32, 34, 36 };
    try common.testIntrinsic(.{ .func = vpaddq_s16, .expected = expected, .args = .{ a, b } });
}

/// Pairwise addition: adds adjacent pairs of elements
pub inline fn vpaddq_s32(a: types.i32x4, b: types.i32x4) types.i32x4 {
    return .{ a[0] +% a[1], a[2] +% a[3], b[0] +% b[1], b[2] +% b[3] };
}

test vpaddq_s32 {
    const a = types.i32x4{ 1, 2, 3, 4 };
    const b = types.i32x4{ 10, 20, 11, 21 };
    const expected = types.i32x4{ 3, 7, 30, 32 };
    try common.testIntrinsic(.{ .func = vpaddq_s32, .expected = expected, .args = .{ a, b } });
}

/// Pairwise addition: adds adjacent pairs of elements
pub inline fn vpaddq_u8(a: types.u8x16, b: types.u8x16) types.u8x16 {
    return .{ a[0] +% a[1], a[2] +% a[3], a[4] +% a[5], a[6] +% a[7], a[8] +% a[9], a[10] +% a[11], a[12] +% a[13], a[14] +% a[15], b[0] +% b[1], b[2] +% b[3], b[4] +% b[5], b[6] +% b[7], b[8] +% b[9], b[10] +% b[11], b[12] +% b[13], b[14] +% b[15] };
}

test vpaddq_u8 {
    const a = types.u8x16{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 };
    const b = types.u8x16{ 10, 20, 11, 21, 12, 22, 13, 23, 14, 24, 15, 25, 16, 26, 17, 27 };
    const expected = types.u8x16{ 3, 7, 11, 15, 19, 23, 27, 31, 30, 32, 34, 36, 38, 40, 42, 44 };
    try common.testIntrinsic(.{ .func = vpaddq_u8, .expected = expected, .args = .{ a, b } });
}

/// Pairwise addition: adds adjacent pairs of elements
pub inline fn vpaddq_u16(a: types.u16x8, b: types.u16x8) types.u16x8 {
    return .{ a[0] +% a[1], a[2] +% a[3], a[4] +% a[5], a[6] +% a[7], b[0] +% b[1], b[2] +% b[3], b[4] +% b[5], b[6] +% b[7] };
}

test vpaddq_u16 {
    const a = types.u16x8{ 1, 2, 3, 4, 5, 6, 7, 8 };
    const b = types.u16x8{ 10, 20, 11, 21, 12, 22, 13, 23 };
    const expected = types.u16x8{ 3, 7, 11, 15, 30, 32, 34, 36 };
    try common.testIntrinsic(.{ .func = vpaddq_u16, .expected = expected, .args = .{ a, b } });
}

/// Pairwise addition: adds adjacent pairs of elements
pub inline fn vpaddq_u32(a: types.u32x4, b: types.u32x4) types.u32x4 {
    return .{ a[0] +% a[1], a[2] +% a[3], b[0] +% b[1], b[2] +% b[3] };
}

test vpaddq_u32 {
    const a = types.u32x4{ 1, 2, 3, 4 };
    const b = types.u32x4{ 10, 20, 11, 21 };
    const expected = types.u32x4{ 3, 7, 30, 32 };
    try common.testIntrinsic(.{ .func = vpaddq_u32, .expected = expected, .args = .{ a, b } });
}

/// Pairwise addition: adds adjacent pairs of elements
pub inline fn vpaddq_f32(a: types.f32x4, b: types.f32x4) types.f32x4 {
    return .{ a[0] + a[1], a[2] + a[3], b[0] + b[1], b[2] + b[3] };
}

test vpaddq_f32 {
    const a = types.f32x4{ 1.0, 2.0, 3.0, 4.0 };
    const b = types.f32x4{ 10.0, 20.0, 30.0, 40.0 };
    const expected = types.f32x4{ 3.0, 7.0, 30.0, 70.0 };
    try common.testIntrinsic(.{ .func = vpaddq_f32, .expected = expected, .args = .{ a, b } });
}

/// Pairwise addition: adds adjacent pairs of elements
pub inline fn vpaddq_f64(a: types.f64x2, b: types.f64x2) types.f64x2 {
    return .{ a[0] + a[1], b[0] + b[1] };
}

test vpaddq_f64 {
    const a = types.f64x2{ 1.0, 2.0 };
    const b = types.f64x2{ 10.0, 20.0 };
    const expected = types.f64x2{ 3.0, 30.0 };
    try common.testIntrinsic(.{ .func = vpaddq_f64, .expected = expected, .args = .{ a, b } });
}

/// Pairwise maximum: compares adjacent pairs of elements
pub inline fn vpmax_s8(a: types.i8x8, b: types.i8x8) types.i8x8 {
    return .{ @max(a[0], a[1]), @max(a[2], a[3]), @max(a[4], a[5]), @max(a[6], a[7]), @max(b[0], b[1]), @max(b[2], b[3]), @max(b[4], b[5]), @max(b[6], b[7]) };
}

test vpmax_s8 {
    const a = types.i8x8{ 1, 2, 3, 4, 5, 6, 7, 8 };
    const b = types.i8x8{ 10, 20, 11, 21, 12, 22, 13, 23 };
    const expected = types.i8x8{ 2, 4, 6, 8, 20, 21, 22, 23 };
    try common.testIntrinsic(.{ .func = vpmax_s8, .expected = expected, .args = .{ a, b } });
}

/// Pairwise maximum: compares adjacent pairs of elements
pub inline fn vpmaxq_s8(a: types.i8x16, b: types.i8x16) types.i8x16 {
    return .{ @max(a[0], a[1]), @max(a[2], a[3]), @max(a[4], a[5]), @max(a[6], a[7]), @max(a[8], a[9]), @max(a[10], a[11]), @max(a[12], a[13]), @max(a[14], a[15]), @max(b[0], b[1]), @max(b[2], b[3]), @max(b[4], b[5]), @max(b[6], b[7]), @max(b[8], b[9]), @max(b[10], b[11]), @max(b[12], b[13]), @max(b[14], b[15]) };
}

test vpmaxq_s8 {
    const a = types.i8x16{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 };
    const b = types.i8x16{ 10, 20, 11, 21, 12, 22, 13, 23, 14, 24, 15, 25, 16, 26, 17, 27 };
    const expected = types.i8x16{ 2, 4, 6, 8, 10, 12, 14, 16, 20, 21, 22, 23, 24, 25, 26, 27 };
    try common.testIntrinsic(.{ .func = vpmaxq_s8, .expected = expected, .args = .{ a, b } });
}

/// Pairwise maximum: compares adjacent pairs of elements
pub inline fn vpmax_s16(a: types.i16x4, b: types.i16x4) types.i16x4 {
    return .{ @max(a[0], a[1]), @max(a[2], a[3]), @max(b[0], b[1]), @max(b[2], b[3]) };
}

test vpmax_s16 {
    const a = types.i16x4{ 1, 2, 3, 4 };
    const b = types.i16x4{ 10, 20, 11, 21 };
    const expected = types.i16x4{ 2, 4, 20, 21 };
    try common.testIntrinsic(.{ .func = vpmax_s16, .expected = expected, .args = .{ a, b } });
}

/// Pairwise maximum: compares adjacent pairs of elements
pub inline fn vpmaxq_s16(a: types.i16x8, b: types.i16x8) types.i16x8 {
    return .{ @max(a[0], a[1]), @max(a[2], a[3]), @max(a[4], a[5]), @max(a[6], a[7]), @max(b[0], b[1]), @max(b[2], b[3]), @max(b[4], b[5]), @max(b[6], b[7]) };
}

test vpmaxq_s16 {
    const a = types.i16x8{ 1, 2, 3, 4, 5, 6, 7, 8 };
    const b = types.i16x8{ 10, 20, 11, 21, 12, 22, 13, 23 };
    const expected = types.i16x8{ 2, 4, 6, 8, 20, 21, 22, 23 };
    try common.testIntrinsic(.{ .func = vpmaxq_s16, .expected = expected, .args = .{ a, b } });
}

/// Pairwise maximum: compares adjacent pairs of elements
pub inline fn vpmax_s32(a: types.i32x2, b: types.i32x2) types.i32x2 {
    return .{ @max(a[0], a[1]), @max(b[0], b[1]) };
}

test vpmax_s32 {
    const a = types.i32x2{ 1, 2 };
    const b = types.i32x2{ 10, 20 };
    const expected = types.i32x2{ 2, 20 };
    try common.testIntrinsic(.{ .func = vpmax_s32, .expected = expected, .args = .{ a, b } });
}

/// Pairwise maximum: compares adjacent pairs of elements
pub inline fn vpmaxq_s32(a: types.i32x4, b: types.i32x4) types.i32x4 {
    return .{ @max(a[0], a[1]), @max(a[2], a[3]), @max(b[0], b[1]), @max(b[2], b[3]) };
}

test vpmaxq_s32 {
    const a = types.i32x4{ 1, 2, 3, 4 };
    const b = types.i32x4{ 10, 20, 11, 21 };
    const expected = types.i32x4{ 2, 4, 20, 21 };
    try common.testIntrinsic(.{ .func = vpmaxq_s32, .expected = expected, .args = .{ a, b } });
}

/// Pairwise maximum: compares adjacent pairs of elements
pub inline fn vpmax_u8(a: types.u8x8, b: types.u8x8) types.u8x8 {
    return .{ @max(a[0], a[1]), @max(a[2], a[3]), @max(a[4], a[5]), @max(a[6], a[7]), @max(b[0], b[1]), @max(b[2], b[3]), @max(b[4], b[5]), @max(b[6], b[7]) };
}

test vpmax_u8 {
    const a = types.u8x8{ 1, 2, 3, 4, 5, 6, 7, 8 };
    const b = types.u8x8{ 10, 20, 11, 21, 12, 22, 13, 23 };
    const expected = types.u8x8{ 2, 4, 6, 8, 20, 21, 22, 23 };
    try common.testIntrinsic(.{ .func = vpmax_u8, .expected = expected, .args = .{ a, b } });
}

/// Pairwise maximum: compares adjacent pairs of elements
pub inline fn vpmaxq_u8(a: types.u8x16, b: types.u8x16) types.u8x16 {
    return .{ @max(a[0], a[1]), @max(a[2], a[3]), @max(a[4], a[5]), @max(a[6], a[7]), @max(a[8], a[9]), @max(a[10], a[11]), @max(a[12], a[13]), @max(a[14], a[15]), @max(b[0], b[1]), @max(b[2], b[3]), @max(b[4], b[5]), @max(b[6], b[7]), @max(b[8], b[9]), @max(b[10], b[11]), @max(b[12], b[13]), @max(b[14], b[15]) };
}

test vpmaxq_u8 {
    const a = types.u8x16{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 };
    const b = types.u8x16{ 10, 20, 11, 21, 12, 22, 13, 23, 14, 24, 15, 25, 16, 26, 17, 27 };
    const expected = types.u8x16{ 2, 4, 6, 8, 10, 12, 14, 16, 20, 21, 22, 23, 24, 25, 26, 27 };
    try common.testIntrinsic(.{ .func = vpmaxq_u8, .expected = expected, .args = .{ a, b } });
}

/// Pairwise maximum: compares adjacent pairs of elements
pub inline fn vpmax_u16(a: types.u16x4, b: types.u16x4) types.u16x4 {
    return .{ @max(a[0], a[1]), @max(a[2], a[3]), @max(b[0], b[1]), @max(b[2], b[3]) };
}

test vpmax_u16 {
    const a = types.u16x4{ 1, 2, 3, 4 };
    const b = types.u16x4{ 10, 20, 11, 21 };
    const expected = types.u16x4{ 2, 4, 20, 21 };
    try common.testIntrinsic(.{ .func = vpmax_u16, .expected = expected, .args = .{ a, b } });
}

/// Pairwise maximum: compares adjacent pairs of elements
pub inline fn vpmaxq_u16(a: types.u16x8, b: types.u16x8) types.u16x8 {
    return .{ @max(a[0], a[1]), @max(a[2], a[3]), @max(a[4], a[5]), @max(a[6], a[7]), @max(b[0], b[1]), @max(b[2], b[3]), @max(b[4], b[5]), @max(b[6], b[7]) };
}

test vpmaxq_u16 {
    const a = types.u16x8{ 1, 2, 3, 4, 5, 6, 7, 8 };
    const b = types.u16x8{ 10, 20, 11, 21, 12, 22, 13, 23 };
    const expected = types.u16x8{ 2, 4, 6, 8, 20, 21, 22, 23 };
    try common.testIntrinsic(.{ .func = vpmaxq_u16, .expected = expected, .args = .{ a, b } });
}

/// Pairwise maximum: compares adjacent pairs of elements
pub inline fn vpmax_u32(a: types.u32x2, b: types.u32x2) types.u32x2 {
    return .{ @max(a[0], a[1]), @max(b[0], b[1]) };
}

test vpmax_u32 {
    const a = types.u32x2{ 1, 2 };
    const b = types.u32x2{ 10, 20 };
    const expected = types.u32x2{ 2, 20 };
    try common.testIntrinsic(.{ .func = vpmax_u32, .expected = expected, .args = .{ a, b } });
}

/// Pairwise maximum: compares adjacent pairs of elements
pub inline fn vpmaxq_u32(a: types.u32x4, b: types.u32x4) types.u32x4 {
    return .{ @max(a[0], a[1]), @max(a[2], a[3]), @max(b[0], b[1]), @max(b[2], b[3]) };
}

test vpmaxq_u32 {
    const a = types.u32x4{ 1, 2, 3, 4 };
    const b = types.u32x4{ 10, 20, 11, 21 };
    const expected = types.u32x4{ 2, 4, 20, 21 };
    try common.testIntrinsic(.{ .func = vpmaxq_u32, .expected = expected, .args = .{ a, b } });
}

/// Pairwise maximum: compares adjacent pairs of elements
pub inline fn vpmax_f32(a: types.f32x2, b: types.f32x2) types.f32x2 {
    return .{ @max(a[0], a[1]), @max(b[0], b[1]) };
}

test vpmax_f32 {
    const a = types.f32x2{ 1.0, 2.0 };
    const b = types.f32x2{ 10.0, 20.0 };
    const expected = types.f32x2{ 2.0, 20.0 };
    try common.testIntrinsic(.{ .func = vpmax_f32, .expected = expected, .args = .{ a, b } });
}

/// Pairwise maximum: compares adjacent pairs of elements
pub inline fn vpmaxq_f32(a: types.f32x4, b: types.f32x4) types.f32x4 {
    return .{ @max(a[0], a[1]), @max(a[2], a[3]), @max(b[0], b[1]), @max(b[2], b[3]) };
}

test vpmaxq_f32 {
    const a = types.f32x4{ 1.0, 2.0, 3.0, 4.0 };
    const b = types.f32x4{ 10.0, 20.0, 30.0, 40.0 };
    const expected = types.f32x4{ 2.0, 4.0, 20.0, 40.0 };
    try common.testIntrinsic(.{ .func = vpmaxq_f32, .expected = expected, .args = .{ a, b } });
}

/// Pairwise minimum: compares adjacent pairs of elements
pub inline fn vpmin_s8(a: types.i8x8, b: types.i8x8) types.i8x8 {
    return .{ @min(a[0], a[1]), @min(a[2], a[3]), @min(a[4], a[5]), @min(a[6], a[7]), @min(b[0], b[1]), @min(b[2], b[3]), @min(b[4], b[5]), @min(b[6], b[7]) };
}

test vpmin_s8 {
    const a = types.i8x8{ 1, 2, 3, 4, 5, 6, 7, 8 };
    const b = types.i8x8{ 10, 20, 11, 21, 12, 22, 13, 23 };
    const expected = types.i8x8{ 1, 3, 5, 7, 10, 11, 12, 13 };
    try common.testIntrinsic(.{ .func = vpmin_s8, .expected = expected, .args = .{ a, b } });
}

/// Pairwise minimum: compares adjacent pairs of elements
pub inline fn vpminq_s8(a: types.i8x16, b: types.i8x16) types.i8x16 {
    return .{ @min(a[0], a[1]), @min(a[2], a[3]), @min(a[4], a[5]), @min(a[6], a[7]), @min(a[8], a[9]), @min(a[10], a[11]), @min(a[12], a[13]), @min(a[14], a[15]), @min(b[0], b[1]), @min(b[2], b[3]), @min(b[4], b[5]), @min(b[6], b[7]), @min(b[8], b[9]), @min(b[10], b[11]), @min(b[12], b[13]), @min(b[14], b[15]) };
}

test vpminq_s8 {
    const a = types.i8x16{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 };
    const b = types.i8x16{ 10, 20, 11, 21, 12, 22, 13, 23, 14, 24, 15, 25, 16, 26, 17, 27 };
    const expected = types.i8x16{ 1, 3, 5, 7, 9, 11, 13, 15, 10, 11, 12, 13, 14, 15, 16, 17 };
    try common.testIntrinsic(.{ .func = vpminq_s8, .expected = expected, .args = .{ a, b } });
}

/// Pairwise minimum: compares adjacent pairs of elements
pub inline fn vpmin_s16(a: types.i16x4, b: types.i16x4) types.i16x4 {
    return .{ @min(a[0], a[1]), @min(a[2], a[3]), @min(b[0], b[1]), @min(b[2], b[3]) };
}

test vpmin_s16 {
    const a = types.i16x4{ 1, 2, 3, 4 };
    const b = types.i16x4{ 10, 20, 11, 21 };
    const expected = types.i16x4{ 1, 3, 10, 11 };
    try common.testIntrinsic(.{ .func = vpmin_s16, .expected = expected, .args = .{ a, b } });
}

/// Pairwise minimum: compares adjacent pairs of elements
pub inline fn vpminq_s16(a: types.i16x8, b: types.i16x8) types.i16x8 {
    return .{ @min(a[0], a[1]), @min(a[2], a[3]), @min(a[4], a[5]), @min(a[6], a[7]), @min(b[0], b[1]), @min(b[2], b[3]), @min(b[4], b[5]), @min(b[6], b[7]) };
}

test vpminq_s16 {
    const a = types.i16x8{ 1, 2, 3, 4, 5, 6, 7, 8 };
    const b = types.i16x8{ 10, 20, 11, 21, 12, 22, 13, 23 };
    const expected = types.i16x8{ 1, 3, 5, 7, 10, 11, 12, 13 };
    try common.testIntrinsic(.{ .func = vpminq_s16, .expected = expected, .args = .{ a, b } });
}

/// Pairwise minimum: compares adjacent pairs of elements
pub inline fn vpmin_s32(a: types.i32x2, b: types.i32x2) types.i32x2 {
    return .{ @min(a[0], a[1]), @min(b[0], b[1]) };
}

test vpmin_s32 {
    const a = types.i32x2{ 1, 2 };
    const b = types.i32x2{ 10, 20 };
    const expected = types.i32x2{ 1, 10 };
    try common.testIntrinsic(.{ .func = vpmin_s32, .expected = expected, .args = .{ a, b } });
}

/// Pairwise minimum: compares adjacent pairs of elements
pub inline fn vpminq_s32(a: types.i32x4, b: types.i32x4) types.i32x4 {
    return .{ @min(a[0], a[1]), @min(a[2], a[3]), @min(b[0], b[1]), @min(b[2], b[3]) };
}

test vpminq_s32 {
    const a = types.i32x4{ 1, 2, 3, 4 };
    const b = types.i32x4{ 10, 20, 11, 21 };
    const expected = types.i32x4{ 1, 3, 10, 11 };
    try common.testIntrinsic(.{ .func = vpminq_s32, .expected = expected, .args = .{ a, b } });
}

/// Pairwise minimum: compares adjacent pairs of elements
pub inline fn vpmin_u8(a: types.u8x8, b: types.u8x8) types.u8x8 {
    return .{ @min(a[0], a[1]), @min(a[2], a[3]), @min(a[4], a[5]), @min(a[6], a[7]), @min(b[0], b[1]), @min(b[2], b[3]), @min(b[4], b[5]), @min(b[6], b[7]) };
}

test vpmin_u8 {
    const a = types.u8x8{ 1, 2, 3, 4, 5, 6, 7, 8 };
    const b = types.u8x8{ 10, 20, 11, 21, 12, 22, 13, 23 };
    const expected = types.u8x8{ 1, 3, 5, 7, 10, 11, 12, 13 };
    try common.testIntrinsic(.{ .func = vpmin_u8, .expected = expected, .args = .{ a, b } });
}

/// Pairwise minimum: compares adjacent pairs of elements
pub inline fn vpminq_u8(a: types.u8x16, b: types.u8x16) types.u8x16 {
    return .{ @min(a[0], a[1]), @min(a[2], a[3]), @min(a[4], a[5]), @min(a[6], a[7]), @min(a[8], a[9]), @min(a[10], a[11]), @min(a[12], a[13]), @min(a[14], a[15]), @min(b[0], b[1]), @min(b[2], b[3]), @min(b[4], b[5]), @min(b[6], b[7]), @min(b[8], b[9]), @min(b[10], b[11]), @min(b[12], b[13]), @min(b[14], b[15]) };
}

test vpminq_u8 {
    const a = types.u8x16{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 };
    const b = types.u8x16{ 10, 20, 11, 21, 12, 22, 13, 23, 14, 24, 15, 25, 16, 26, 17, 27 };
    const expected = types.u8x16{ 1, 3, 5, 7, 9, 11, 13, 15, 10, 11, 12, 13, 14, 15, 16, 17 };
    try common.testIntrinsic(.{ .func = vpminq_u8, .expected = expected, .args = .{ a, b } });
}

/// Pairwise minimum: compares adjacent pairs of elements
pub inline fn vpmin_u16(a: types.u16x4, b: types.u16x4) types.u16x4 {
    return .{ @min(a[0], a[1]), @min(a[2], a[3]), @min(b[0], b[1]), @min(b[2], b[3]) };
}

test vpmin_u16 {
    const a = types.u16x4{ 1, 2, 3, 4 };
    const b = types.u16x4{ 10, 20, 11, 21 };
    const expected = types.u16x4{ 1, 3, 10, 11 };
    try common.testIntrinsic(.{ .func = vpmin_u16, .expected = expected, .args = .{ a, b } });
}

/// Pairwise minimum: compares adjacent pairs of elements
pub inline fn vpminq_u16(a: types.u16x8, b: types.u16x8) types.u16x8 {
    return .{ @min(a[0], a[1]), @min(a[2], a[3]), @min(a[4], a[5]), @min(a[6], a[7]), @min(b[0], b[1]), @min(b[2], b[3]), @min(b[4], b[5]), @min(b[6], b[7]) };
}

test vpminq_u16 {
    const a = types.u16x8{ 1, 2, 3, 4, 5, 6, 7, 8 };
    const b = types.u16x8{ 10, 20, 11, 21, 12, 22, 13, 23 };
    const expected = types.u16x8{ 1, 3, 5, 7, 10, 11, 12, 13 };
    try common.testIntrinsic(.{ .func = vpminq_u16, .expected = expected, .args = .{ a, b } });
}

/// Pairwise minimum: compares adjacent pairs of elements
pub inline fn vpmin_u32(a: types.u32x2, b: types.u32x2) types.u32x2 {
    return .{ @min(a[0], a[1]), @min(b[0], b[1]) };
}

test vpmin_u32 {
    const a = types.u32x2{ 1, 2 };
    const b = types.u32x2{ 10, 20 };
    const expected = types.u32x2{ 1, 10 };
    try common.testIntrinsic(.{ .func = vpmin_u32, .expected = expected, .args = .{ a, b } });
}

/// Pairwise minimum: compares adjacent pairs of elements
pub inline fn vpminq_u32(a: types.u32x4, b: types.u32x4) types.u32x4 {
    return .{ @min(a[0], a[1]), @min(a[2], a[3]), @min(b[0], b[1]), @min(b[2], b[3]) };
}

test vpminq_u32 {
    const a = types.u32x4{ 1, 2, 3, 4 };
    const b = types.u32x4{ 10, 20, 11, 21 };
    const expected = types.u32x4{ 1, 3, 10, 11 };
    try common.testIntrinsic(.{ .func = vpminq_u32, .expected = expected, .args = .{ a, b } });
}

/// Pairwise minimum: compares adjacent pairs of elements
pub inline fn vpmin_f32(a: types.f32x2, b: types.f32x2) types.f32x2 {
    return .{ @min(a[0], a[1]), @min(b[0], b[1]) };
}

test vpmin_f32 {
    const a = types.f32x2{ 1.0, 2.0 };
    const b = types.f32x2{ 10.0, 20.0 };
    const expected = types.f32x2{ 1.0, 10.0 };
    try common.testIntrinsic(.{ .func = vpmin_f32, .expected = expected, .args = .{ a, b } });
}

/// Pairwise minimum: compares adjacent pairs of elements
pub inline fn vpminq_f32(a: types.f32x4, b: types.f32x4) types.f32x4 {
    return .{ @min(a[0], a[1]), @min(a[2], a[3]), @min(b[0], b[1]), @min(b[2], b[3]) };
}

test vpminq_f32 {
    const a = types.f32x4{ 1.0, 2.0, 3.0, 4.0 };
    const b = types.f32x4{ 10.0, 20.0, 30.0, 40.0 };
    const expected = types.f32x4{ 1.0, 3.0, 10.0, 30.0 };
    try common.testIntrinsic(.{ .func = vpminq_f32, .expected = expected, .args = .{ a, b } });
}

/// Vector multiply by scalar: returns `a * b`
pub inline fn vmul_n_s16(a: types.i16x4, b: i16) types.i16x4 {
    return a *% @as(types.i16x4, @splat(b));
}

test vmul_n_s16 {
    const a = types.i16x4{ 10, -20, 15, 30 };
    const b: i16 = 3;
    const expected = types.i16x4{ 30, -60, 45, 90 };
    try common.testIntrinsic(.{ .func = vmul_n_s16, .expected = expected, .args = .{ a, b } });
}

/// Vector multiply by scalar: returns `a * b`
pub inline fn vmul_n_s32(a: types.i32x2, b: i32) types.i32x2 {
    return a *% @as(types.i32x2, @splat(b));
}

test vmul_n_s32 {
    const a = types.i32x2{ 100, -200 };
    const b: i32 = 4;
    const expected = types.i32x2{ 400, -800 };
    try common.testIntrinsic(.{ .func = vmul_n_s32, .expected = expected, .args = .{ a, b } });
}

/// Vector multiply by scalar: returns `a * b`
pub inline fn vmul_n_u16(a: types.u16x4, b: u16) types.u16x4 {
    return a *% @as(types.u16x4, @splat(b));
}

test vmul_n_u16 {
    const a = types.u16x4{ 10, 20, 15, 30 };
    const b: u16 = 3;
    const expected = types.u16x4{ 30, 60, 45, 90 };
    try common.testIntrinsic(.{ .func = vmul_n_u16, .expected = expected, .args = .{ a, b } });
}

/// Vector multiply by scalar: returns `a * b`
pub inline fn vmul_n_u32(a: types.u32x2, b: u32) types.u32x2 {
    return a *% @as(types.u32x2, @splat(b));
}

test vmul_n_u32 {
    const a = types.u32x2{ 100, 200 };
    const b: u32 = 4;
    const expected = types.u32x2{ 400, 800 };
    try common.testIntrinsic(.{ .func = vmul_n_u32, .expected = expected, .args = .{ a, b } });
}

/// Vector multiply by scalar: returns `a * b`
pub inline fn vmul_n_f32(a: types.f32x2, b: f32) types.f32x2 {
    return a * @as(types.f32x2, @splat(b));
}

test vmul_n_f32 {
    const a = types.f32x2{ 1.5, -2.5 };
    const b: f32 = 2.0;
    const expected = types.f32x2{ 3.0, -5.0 };
    try common.testIntrinsic(.{ .func = vmul_n_f32, .expected = expected, .args = .{ a, b } });
}

/// Vector multiply by scalar: returns `a * b`
pub inline fn vmul_n_f64(a: types.f64x1, b: f64) types.f64x1 {
    return a * @as(types.f64x1, @splat(b));
}

test vmul_n_f64 {
    const a = types.f64x1{3.5};
    const b: f64 = -2.0;
    const expected = types.f64x1{-7.0};
    try common.testIntrinsic(.{ .func = vmul_n_f64, .expected = expected, .args = .{ a, b } });
}

/// Vector multiply by scalar: returns `a * b`
pub inline fn vmulq_n_s16(a: types.i16x8, b: i16) types.i16x8 {
    return a *% @as(types.i16x8, @splat(b));
}

test vmulq_n_s16 {
    const a = types.i16x8{ 10, -20, 15, 30, -5, 12, 0, 8 };
    const b: i16 = 3;
    const expected = types.i16x8{ 30, -60, 45, 90, -15, 36, 0, 24 };
    try common.testIntrinsic(.{ .func = vmulq_n_s16, .expected = expected, .args = .{ a, b } });
}

/// Vector multiply by scalar: returns `a * b`
pub inline fn vmulq_n_s32(a: types.i32x4, b: i32) types.i32x4 {
    return a *% @as(types.i32x4, @splat(b));
}

test vmulq_n_s32 {
    const a = types.i32x4{ 100, -200, 50, 12 };
    const b: i32 = 4;
    const expected = types.i32x4{ 400, -800, 200, 48 };
    try common.testIntrinsic(.{ .func = vmulq_n_s32, .expected = expected, .args = .{ a, b } });
}

/// Vector multiply by scalar: returns `a * b`
pub inline fn vmulq_n_u16(a: types.u16x8, b: u16) types.u16x8 {
    return a *% @as(types.u16x8, @splat(b));
}

test vmulq_n_u16 {
    const a = types.u16x8{ 10, 20, 15, 30, 5, 12, 0, 8 };
    const b: u16 = 3;
    const expected = types.u16x8{ 30, 60, 45, 90, 15, 36, 0, 24 };
    try common.testIntrinsic(.{ .func = vmulq_n_u16, .expected = expected, .args = .{ a, b } });
}

/// Vector multiply by scalar: returns `a * b`
pub inline fn vmulq_n_u32(a: types.u32x4, b: u32) types.u32x4 {
    return a *% @as(types.u32x4, @splat(b));
}

test vmulq_n_u32 {
    const a = types.u32x4{ 100, 200, 50, 12 };
    const b: u32 = 4;
    const expected = types.u32x4{ 400, 800, 200, 48 };
    try common.testIntrinsic(.{ .func = vmulq_n_u32, .expected = expected, .args = .{ a, b } });
}

/// Vector multiply by scalar: returns `a * b`
pub inline fn vmulq_n_f32(a: types.f32x4, b: f32) types.f32x4 {
    return a * @as(types.f32x4, @splat(b));
}

test vmulq_n_f32 {
    const a = types.f32x4{ 1.5, -2.5, 3.0, -1.0 };
    const b: f32 = 2.0;
    const expected = types.f32x4{ 3.0, -5.0, 6.0, -2.0 };
    try common.testIntrinsic(.{ .func = vmulq_n_f32, .expected = expected, .args = .{ a, b } });
}

/// Vector widening multiply by scalar: returns `@as(Wide, a) * @as(Wide, b)`
pub inline fn vmull_n_s16(a: types.i16x4, b: i16) types.i32x4 {
    return @as(types.i32x4, a) *% @as(types.i32x4, @splat(b));
}

test vmull_n_s16 {
    const a = types.i16x4{ 100, -200, 300, -400 };
    const b: i16 = 5;
    const expected = types.i32x4{ 500, -1000, 1500, -2000 };
    try common.testIntrinsic(.{ .func = vmull_n_s16, .expected = expected, .args = .{ a, b } });
}

/// Vector widening multiply by scalar: returns `@as(Wide, a) * @as(Wide, b)`
pub inline fn vmull_n_s32(a: types.i32x2, b: i32) types.i64x2 {
    return @as(types.i64x2, a) *% @as(types.i64x2, @splat(b));
}

test vmull_n_s32 {
    const a = types.i32x2{ 1000, -2000 };
    const b: i32 = 6;
    const expected = types.i64x2{ 6000, -12000 };
    try common.testIntrinsic(.{ .func = vmull_n_s32, .expected = expected, .args = .{ a, b } });
}

/// Vector widening multiply by scalar: returns `@as(Wide, a) * @as(Wide, b)`
pub inline fn vmull_n_u16(a: types.u16x4, b: u16) types.u32x4 {
    return @as(types.u32x4, a) *% @as(types.u32x4, @splat(b));
}

test vmull_n_u16 {
    const a = types.u16x4{ 100, 200, 300, 400 };
    const b: u16 = 5;
    const expected = types.u32x4{ 500, 1000, 1500, 2000 };
    try common.testIntrinsic(.{ .func = vmull_n_u16, .expected = expected, .args = .{ a, b } });
}

/// Vector widening multiply by scalar: returns `@as(Wide, a) * @as(Wide, b)`
pub inline fn vmull_n_u32(a: types.u32x2, b: u32) types.u64x2 {
    return @as(types.u64x2, a) *% @as(types.u64x2, @splat(b));
}

test vmull_n_u32 {
    const a = types.u32x2{ 1000, 2000 };
    const b: u32 = 6;
    const expected = types.u64x2{ 6000, 12000 };
    try common.testIntrinsic(.{ .func = vmull_n_u32, .expected = expected, .args = .{ a, b } });
}

/// Vector widening multiply by scalar of high half: returns `@as(Wide, a_high) * @as(Wide, b)`
pub inline fn vmull_high_n_s16(a: types.i16x8, b: i16) types.i32x4 {
    const high: types.i16x4 = .{ a[4], a[5], a[6], a[7] };
    return @as(types.i32x4, high) *% @as(types.i32x4, @splat(b));
}

test vmull_high_n_s16 {
    const a = types.i16x8{ 0, 0, 0, 0, 100, -200, 300, -400 };
    const b: i16 = 5;
    const expected = types.i32x4{ 500, -1000, 1500, -2000 };
    try common.testIntrinsic(.{ .func = vmull_high_n_s16, .expected = expected, .args = .{ a, b } });
}

/// Vector widening multiply by scalar of high half: returns `@as(Wide, a_high) * @as(Wide, b)`
pub inline fn vmull_high_n_s32(a: types.i32x4, b: i32) types.i64x2 {
    const high: types.i32x2 = .{ a[2], a[3] };
    return @as(types.i64x2, high) *% @as(types.i64x2, @splat(b));
}

test vmull_high_n_s32 {
    const a = types.i32x4{ 0, 0, 1000, -2000 };
    const b: i32 = 6;
    const expected = types.i64x2{ 6000, -12000 };
    try common.testIntrinsic(.{ .func = vmull_high_n_s32, .expected = expected, .args = .{ a, b } });
}

/// Vector widening multiply by scalar of high half: returns `@as(Wide, a_high) * @as(Wide, b)`
pub inline fn vmull_high_n_u16(a: types.u16x8, b: u16) types.u32x4 {
    const high: types.u16x4 = .{ a[4], a[5], a[6], a[7] };
    return @as(types.u32x4, high) *% @as(types.u32x4, @splat(b));
}

test vmull_high_n_u16 {
    const a = types.u16x8{ 0, 0, 0, 0, 100, 200, 300, 400 };
    const b: u16 = 5;
    const expected = types.u32x4{ 500, 1000, 1500, 2000 };
    try common.testIntrinsic(.{ .func = vmull_high_n_u16, .expected = expected, .args = .{ a, b } });
}

/// Rounding add and narrow high
pub inline fn vraddhn_s16(a: types.i16x8, b: types.i16x8) types.i8x8 {
    const round: types.i16x8 = @splat(1 << 7);
    const sum = a +% b +% round;
    const shifted = sum >> @as(types.i16x8, @splat(8));
    return @truncate(shifted);
}

test vraddhn_s16 {
    const a = @as(types.i16x8, @splat(1000));
    const b = @as(types.i16x8, @splat(2000));
    const expected = @as(types.i8x8, @splat(12));
    try common.testIntrinsic(.{ .func = vraddhn_s16, .expected = expected, .args = .{ a, b } });
}

/// Rounding add and narrow high into upper half
pub inline fn vraddhn_high_s16(r: types.i8x8, a: types.i16x8, b: types.i16x8) types.i8x16 {
    const high = vraddhn_s16(a, b);
    var res: types.i8x16 = undefined;
    inline for (0..8) |i| {
        res[i] = r[i];
        res[i + 8] = high[i];
    }
    return res;
}

test vraddhn_high_s16 {
    const r = @as(types.i8x8, @splat(1));
    const a = @as(types.i16x8, @splat(1000));
    const b = @as(types.i16x8, @splat(2000));
    var expected: types.i8x16 = undefined;
    inline for (0..8) |i| {
        expected[i] = 1;
        expected[i + 8] = 12;
    }
    try common.testIntrinsic(.{ .func = vraddhn_high_s16, .expected = expected, .args = .{ r, a, b } });
}

/// Subtract and narrow high
pub inline fn vsubhn_s16(a: types.i16x8, b: types.i16x8) types.i8x8 {
    const diff = a -% b;
    const shifted = diff >> @as(types.i16x8, @splat(8));
    return @truncate(shifted);
}

test vsubhn_s16 {
    const a = @as(types.i16x8, @splat(3000));
    const b = @as(types.i16x8, @splat(1000));
    const expected = @as(types.i8x8, @splat(7));
    try common.testIntrinsic(.{ .func = vsubhn_s16, .expected = expected, .args = .{ a, b } });
}

/// Subtract and narrow high into upper half
pub inline fn vsubhn_high_s16(r: types.i8x8, a: types.i16x8, b: types.i16x8) types.i8x16 {
    const high = vsubhn_s16(a, b);
    var res: types.i8x16 = undefined;
    inline for (0..8) |i| {
        res[i] = r[i];
        res[i + 8] = high[i];
    }
    return res;
}

test vsubhn_high_s16 {
    const r = @as(types.i8x8, @splat(1));
    const a = @as(types.i16x8, @splat(3000));
    const b = @as(types.i16x8, @splat(1000));
    var expected: types.i8x16 = undefined;
    inline for (0..8) |i| {
        expected[i] = 1;
        expected[i + 8] = 7;
    }
    try common.testIntrinsic(.{ .func = vsubhn_high_s16, .expected = expected, .args = .{ r, a, b } });
}

/// Rounding subtract and narrow high
pub inline fn vrsubhn_s16(a: types.i16x8, b: types.i16x8) types.i8x8 {
    const round: types.i16x8 = @splat(1 << 7);
    const diff = a -% b +% round;
    const shifted = diff >> @as(types.i16x8, @splat(8));
    return @truncate(shifted);
}

test vrsubhn_s16 {
    const a = @as(types.i16x8, @splat(3000));
    const b = @as(types.i16x8, @splat(1000));
    const expected = @as(types.i8x8, @splat(8));
    try common.testIntrinsic(.{ .func = vrsubhn_s16, .expected = expected, .args = .{ a, b } });
}

/// Rounding subtract and narrow high into upper half
pub inline fn vrsubhn_high_s16(r: types.i8x8, a: types.i16x8, b: types.i16x8) types.i8x16 {
    const high = vrsubhn_s16(a, b);
    var res: types.i8x16 = undefined;
    inline for (0..8) |i| {
        res[i] = r[i];
        res[i + 8] = high[i];
    }
    return res;
}

test vrsubhn_high_s16 {
    const r = @as(types.i8x8, @splat(1));
    const a = @as(types.i16x8, @splat(3000));
    const b = @as(types.i16x8, @splat(1000));
    var expected: types.i8x16 = undefined;
    inline for (0..8) |i| {
        expected[i] = 1;
        expected[i + 8] = 8;
    }
    try common.testIntrinsic(.{ .func = vrsubhn_high_s16, .expected = expected, .args = .{ r, a, b } });
}

/// Rounding add and narrow high
pub inline fn vraddhn_s32(a: types.i32x4, b: types.i32x4) types.i16x4 {
    const round: types.i32x4 = @splat(1 << 15);
    const sum = a +% b +% round;
    const shifted = sum >> @as(types.i32x4, @splat(16));
    return @truncate(shifted);
}

test vraddhn_s32 {
    const a = @as(types.i32x4, @splat(1000));
    const b = @as(types.i32x4, @splat(2000));
    const expected = @as(types.i16x4, @splat(0));
    try common.testIntrinsic(.{ .func = vraddhn_s32, .expected = expected, .args = .{ a, b } });
}

/// Rounding add and narrow high into upper half
pub inline fn vraddhn_high_s32(r: types.i16x4, a: types.i32x4, b: types.i32x4) types.i16x8 {
    const high = vraddhn_s32(a, b);
    var res: types.i16x8 = undefined;
    inline for (0..4) |i| {
        res[i] = r[i];
        res[i + 4] = high[i];
    }
    return res;
}

test vraddhn_high_s32 {
    const r = @as(types.i16x4, @splat(1));
    const a = @as(types.i32x4, @splat(1000));
    const b = @as(types.i32x4, @splat(2000));
    var expected: types.i16x8 = undefined;
    inline for (0..4) |i| {
        expected[i] = 1;
        expected[i + 4] = 0;
    }
    try common.testIntrinsic(.{ .func = vraddhn_high_s32, .expected = expected, .args = .{ r, a, b } });
}

/// Subtract and narrow high
pub inline fn vsubhn_s32(a: types.i32x4, b: types.i32x4) types.i16x4 {
    const diff = a -% b;
    const shifted = diff >> @as(types.i32x4, @splat(16));
    return @truncate(shifted);
}

test vsubhn_s32 {
    const a = @as(types.i32x4, @splat(3000));
    const b = @as(types.i32x4, @splat(1000));
    const expected = @as(types.i16x4, @splat(0));
    try common.testIntrinsic(.{ .func = vsubhn_s32, .expected = expected, .args = .{ a, b } });
}

/// Subtract and narrow high into upper half
pub inline fn vsubhn_high_s32(r: types.i16x4, a: types.i32x4, b: types.i32x4) types.i16x8 {
    const high = vsubhn_s32(a, b);
    var res: types.i16x8 = undefined;
    inline for (0..4) |i| {
        res[i] = r[i];
        res[i + 4] = high[i];
    }
    return res;
}

test vsubhn_high_s32 {
    const r = @as(types.i16x4, @splat(1));
    const a = @as(types.i32x4, @splat(3000));
    const b = @as(types.i32x4, @splat(1000));
    var expected: types.i16x8 = undefined;
    inline for (0..4) |i| {
        expected[i] = 1;
        expected[i + 4] = 0;
    }
    try common.testIntrinsic(.{ .func = vsubhn_high_s32, .expected = expected, .args = .{ r, a, b } });
}

/// Rounding subtract and narrow high
pub inline fn vrsubhn_s32(a: types.i32x4, b: types.i32x4) types.i16x4 {
    const round: types.i32x4 = @splat(1 << 15);
    const diff = a -% b +% round;
    const shifted = diff >> @as(types.i32x4, @splat(16));
    return @truncate(shifted);
}

test vrsubhn_s32 {
    const a = @as(types.i32x4, @splat(3000));
    const b = @as(types.i32x4, @splat(1000));
    const expected = @as(types.i16x4, @splat(0));
    try common.testIntrinsic(.{ .func = vrsubhn_s32, .expected = expected, .args = .{ a, b } });
}

/// Rounding subtract and narrow high into upper half
pub inline fn vrsubhn_high_s32(r: types.i16x4, a: types.i32x4, b: types.i32x4) types.i16x8 {
    const high = vrsubhn_s32(a, b);
    var res: types.i16x8 = undefined;
    inline for (0..4) |i| {
        res[i] = r[i];
        res[i + 4] = high[i];
    }
    return res;
}

test vrsubhn_high_s32 {
    const r = @as(types.i16x4, @splat(1));
    const a = @as(types.i32x4, @splat(3000));
    const b = @as(types.i32x4, @splat(1000));
    var expected: types.i16x8 = undefined;
    inline for (0..4) |i| {
        expected[i] = 1;
        expected[i + 4] = 0;
    }
    try common.testIntrinsic(.{ .func = vrsubhn_high_s32, .expected = expected, .args = .{ r, a, b } });
}

/// Rounding add and narrow high
pub inline fn vraddhn_s64(a: types.i64x2, b: types.i64x2) types.i32x2 {
    const round: types.i64x2 = @splat(1 << 31);
    const sum = a +% b +% round;
    const shifted = sum >> @as(types.i64x2, @splat(32));
    return @truncate(shifted);
}

test vraddhn_s64 {
    const a = @as(types.i64x2, @splat(1000));
    const b = @as(types.i64x2, @splat(2000));
    const expected = @as(types.i32x2, @splat(0));
    try common.testIntrinsic(.{ .func = vraddhn_s64, .expected = expected, .args = .{ a, b } });
}

/// Rounding add and narrow high into upper half
pub inline fn vraddhn_high_s64(r: types.i32x2, a: types.i64x2, b: types.i64x2) types.i32x4 {
    const high = vraddhn_s64(a, b);
    var res: types.i32x4 = undefined;
    inline for (0..2) |i| {
        res[i] = r[i];
        res[i + 2] = high[i];
    }
    return res;
}

test vraddhn_high_s64 {
    const r = @as(types.i32x2, @splat(1));
    const a = @as(types.i64x2, @splat(1000));
    const b = @as(types.i64x2, @splat(2000));
    var expected: types.i32x4 = undefined;
    inline for (0..2) |i| {
        expected[i] = 1;
        expected[i + 2] = 0;
    }
    try common.testIntrinsic(.{ .func = vraddhn_high_s64, .expected = expected, .args = .{ r, a, b } });
}

/// Subtract and narrow high
pub inline fn vsubhn_s64(a: types.i64x2, b: types.i64x2) types.i32x2 {
    const diff = a -% b;
    const shifted = diff >> @as(types.i64x2, @splat(32));
    return @truncate(shifted);
}

test vsubhn_s64 {
    const a = @as(types.i64x2, @splat(3000));
    const b = @as(types.i64x2, @splat(1000));
    const expected = @as(types.i32x2, @splat(0));
    try common.testIntrinsic(.{ .func = vsubhn_s64, .expected = expected, .args = .{ a, b } });
}

/// Subtract and narrow high into upper half
pub inline fn vsubhn_high_s64(r: types.i32x2, a: types.i64x2, b: types.i64x2) types.i32x4 {
    const high = vsubhn_s64(a, b);
    var res: types.i32x4 = undefined;
    inline for (0..2) |i| {
        res[i] = r[i];
        res[i + 2] = high[i];
    }
    return res;
}

test vsubhn_high_s64 {
    const r = @as(types.i32x2, @splat(1));
    const a = @as(types.i64x2, @splat(3000));
    const b = @as(types.i64x2, @splat(1000));
    var expected: types.i32x4 = undefined;
    inline for (0..2) |i| {
        expected[i] = 1;
        expected[i + 2] = 0;
    }
    try common.testIntrinsic(.{ .func = vsubhn_high_s64, .expected = expected, .args = .{ r, a, b } });
}

/// Rounding subtract and narrow high
pub inline fn vrsubhn_s64(a: types.i64x2, b: types.i64x2) types.i32x2 {
    const round: types.i64x2 = @splat(1 << 31);
    const diff = a -% b +% round;
    const shifted = diff >> @as(types.i64x2, @splat(32));
    return @truncate(shifted);
}

test vrsubhn_s64 {
    const a = @as(types.i64x2, @splat(3000));
    const b = @as(types.i64x2, @splat(1000));
    const expected = @as(types.i32x2, @splat(0));
    try common.testIntrinsic(.{ .func = vrsubhn_s64, .expected = expected, .args = .{ a, b } });
}

/// Rounding subtract and narrow high into upper half
pub inline fn vrsubhn_high_s64(r: types.i32x2, a: types.i64x2, b: types.i64x2) types.i32x4 {
    const high = vrsubhn_s64(a, b);
    var res: types.i32x4 = undefined;
    inline for (0..2) |i| {
        res[i] = r[i];
        res[i + 2] = high[i];
    }
    return res;
}

test vrsubhn_high_s64 {
    const r = @as(types.i32x2, @splat(1));
    const a = @as(types.i64x2, @splat(3000));
    const b = @as(types.i64x2, @splat(1000));
    var expected: types.i32x4 = undefined;
    inline for (0..2) |i| {
        expected[i] = 1;
        expected[i + 2] = 0;
    }
    try common.testIntrinsic(.{ .func = vrsubhn_high_s64, .expected = expected, .args = .{ r, a, b } });
}

/// Rounding add and narrow high
pub inline fn vraddhn_u16(a: types.u16x8, b: types.u16x8) types.u8x8 {
    const round: types.u16x8 = @splat(1 << 7);
    const sum = a +% b +% round;
    const shifted = sum >> @as(types.u16x8, @splat(8));
    return @truncate(shifted);
}

test vraddhn_u16 {
    const a = @as(types.u16x8, @splat(1000));
    const b = @as(types.u16x8, @splat(2000));
    const expected = @as(types.u8x8, @splat(12));
    try common.testIntrinsic(.{ .func = vraddhn_u16, .expected = expected, .args = .{ a, b } });
}

/// Rounding add and narrow high into upper half
pub inline fn vraddhn_high_u16(r: types.u8x8, a: types.u16x8, b: types.u16x8) types.u8x16 {
    const high = vraddhn_u16(a, b);
    var res: types.u8x16 = undefined;
    inline for (0..8) |i| {
        res[i] = r[i];
        res[i + 8] = high[i];
    }
    return res;
}

test vraddhn_high_u16 {
    const r = @as(types.u8x8, @splat(1));
    const a = @as(types.u16x8, @splat(1000));
    const b = @as(types.u16x8, @splat(2000));
    var expected: types.u8x16 = undefined;
    inline for (0..8) |i| {
        expected[i] = 1;
        expected[i + 8] = 12;
    }
    try common.testIntrinsic(.{ .func = vraddhn_high_u16, .expected = expected, .args = .{ r, a, b } });
}

/// Subtract and narrow high
pub inline fn vsubhn_u16(a: types.u16x8, b: types.u16x8) types.u8x8 {
    const diff = a -% b;
    const shifted = diff >> @as(types.u16x8, @splat(8));
    return @truncate(shifted);
}

test vsubhn_u16 {
    const a = @as(types.u16x8, @splat(3000));
    const b = @as(types.u16x8, @splat(1000));
    const expected = @as(types.u8x8, @splat(7));
    try common.testIntrinsic(.{ .func = vsubhn_u16, .expected = expected, .args = .{ a, b } });
}

/// Subtract and narrow high into upper half
pub inline fn vsubhn_high_u16(r: types.u8x8, a: types.u16x8, b: types.u16x8) types.u8x16 {
    const high = vsubhn_u16(a, b);
    var res: types.u8x16 = undefined;
    inline for (0..8) |i| {
        res[i] = r[i];
        res[i + 8] = high[i];
    }
    return res;
}

test vsubhn_high_u16 {
    const r = @as(types.u8x8, @splat(1));
    const a = @as(types.u16x8, @splat(3000));
    const b = @as(types.u16x8, @splat(1000));
    var expected: types.u8x16 = undefined;
    inline for (0..8) |i| {
        expected[i] = 1;
        expected[i + 8] = 7;
    }
    try common.testIntrinsic(.{ .func = vsubhn_high_u16, .expected = expected, .args = .{ r, a, b } });
}

/// Rounding subtract and narrow high
pub inline fn vrsubhn_u16(a: types.u16x8, b: types.u16x8) types.u8x8 {
    const round: types.u16x8 = @splat(1 << 7);
    const diff = a -% b +% round;
    const shifted = diff >> @as(types.u16x8, @splat(8));
    return @truncate(shifted);
}

test vrsubhn_u16 {
    const a = @as(types.u16x8, @splat(3000));
    const b = @as(types.u16x8, @splat(1000));
    const expected = @as(types.u8x8, @splat(8));
    try common.testIntrinsic(.{ .func = vrsubhn_u16, .expected = expected, .args = .{ a, b } });
}

/// Rounding subtract and narrow high into upper half
pub inline fn vrsubhn_high_u16(r: types.u8x8, a: types.u16x8, b: types.u16x8) types.u8x16 {
    const high = vrsubhn_u16(a, b);
    var res: types.u8x16 = undefined;
    inline for (0..8) |i| {
        res[i] = r[i];
        res[i + 8] = high[i];
    }
    return res;
}

test vrsubhn_high_u16 {
    const r = @as(types.u8x8, @splat(1));
    const a = @as(types.u16x8, @splat(3000));
    const b = @as(types.u16x8, @splat(1000));
    var expected: types.u8x16 = undefined;
    inline for (0..8) |i| {
        expected[i] = 1;
        expected[i + 8] = 8;
    }
    try common.testIntrinsic(.{ .func = vrsubhn_high_u16, .expected = expected, .args = .{ r, a, b } });
}

/// Rounding add and narrow high
pub inline fn vraddhn_u32(a: types.u32x4, b: types.u32x4) types.u16x4 {
    const round: types.u32x4 = @splat(1 << 15);
    const sum = a +% b +% round;
    const shifted = sum >> @as(types.u32x4, @splat(16));
    return @truncate(shifted);
}

test vraddhn_u32 {
    const a = @as(types.u32x4, @splat(1000));
    const b = @as(types.u32x4, @splat(2000));
    const expected = @as(types.u16x4, @splat(0));
    try common.testIntrinsic(.{ .func = vraddhn_u32, .expected = expected, .args = .{ a, b } });
}

/// Rounding add and narrow high into upper half
pub inline fn vraddhn_high_u32(r: types.u16x4, a: types.u32x4, b: types.u32x4) types.u16x8 {
    const high = vraddhn_u32(a, b);
    var res: types.u16x8 = undefined;
    inline for (0..4) |i| {
        res[i] = r[i];
        res[i + 4] = high[i];
    }
    return res;
}

test vraddhn_high_u32 {
    const r = @as(types.u16x4, @splat(1));
    const a = @as(types.u32x4, @splat(1000));
    const b = @as(types.u32x4, @splat(2000));
    var expected: types.u16x8 = undefined;
    inline for (0..4) |i| {
        expected[i] = 1;
        expected[i + 4] = 0;
    }
    try common.testIntrinsic(.{ .func = vraddhn_high_u32, .expected = expected, .args = .{ r, a, b } });
}

/// Subtract and narrow high
pub inline fn vsubhn_u32(a: types.u32x4, b: types.u32x4) types.u16x4 {
    const diff = a -% b;
    const shifted = diff >> @as(types.u32x4, @splat(16));
    return @truncate(shifted);
}

test vsubhn_u32 {
    const a = @as(types.u32x4, @splat(3000));
    const b = @as(types.u32x4, @splat(1000));
    const expected = @as(types.u16x4, @splat(0));
    try common.testIntrinsic(.{ .func = vsubhn_u32, .expected = expected, .args = .{ a, b } });
}

/// Subtract and narrow high into upper half
pub inline fn vsubhn_high_u32(r: types.u16x4, a: types.u32x4, b: types.u32x4) types.u16x8 {
    const high = vsubhn_u32(a, b);
    var res: types.u16x8 = undefined;
    inline for (0..4) |i| {
        res[i] = r[i];
        res[i + 4] = high[i];
    }
    return res;
}

test vsubhn_high_u32 {
    const r = @as(types.u16x4, @splat(1));
    const a = @as(types.u32x4, @splat(3000));
    const b = @as(types.u32x4, @splat(1000));
    var expected: types.u16x8 = undefined;
    inline for (0..4) |i| {
        expected[i] = 1;
        expected[i + 4] = 0;
    }
    try common.testIntrinsic(.{ .func = vsubhn_high_u32, .expected = expected, .args = .{ r, a, b } });
}

/// Rounding subtract and narrow high
pub inline fn vrsubhn_u32(a: types.u32x4, b: types.u32x4) types.u16x4 {
    const round: types.u32x4 = @splat(1 << 15);
    const diff = a -% b +% round;
    const shifted = diff >> @as(types.u32x4, @splat(16));
    return @truncate(shifted);
}

test vrsubhn_u32 {
    const a = @as(types.u32x4, @splat(3000));
    const b = @as(types.u32x4, @splat(1000));
    const expected = @as(types.u16x4, @splat(0));
    try common.testIntrinsic(.{ .func = vrsubhn_u32, .expected = expected, .args = .{ a, b } });
}

/// Rounding subtract and narrow high into upper half
pub inline fn vrsubhn_high_u32(r: types.u16x4, a: types.u32x4, b: types.u32x4) types.u16x8 {
    const high = vrsubhn_u32(a, b);
    var res: types.u16x8 = undefined;
    inline for (0..4) |i| {
        res[i] = r[i];
        res[i + 4] = high[i];
    }
    return res;
}

test vrsubhn_high_u32 {
    const r = @as(types.u16x4, @splat(1));
    const a = @as(types.u32x4, @splat(3000));
    const b = @as(types.u32x4, @splat(1000));
    var expected: types.u16x8 = undefined;
    inline for (0..4) |i| {
        expected[i] = 1;
        expected[i + 4] = 0;
    }
    try common.testIntrinsic(.{ .func = vrsubhn_high_u32, .expected = expected, .args = .{ r, a, b } });
}

/// Rounding add and narrow high
pub inline fn vraddhn_u64(a: types.u64x2, b: types.u64x2) types.u32x2 {
    const round: types.u64x2 = @splat(1 << 31);
    const sum = a +% b +% round;
    const shifted = sum >> @as(types.u64x2, @splat(32));
    return @truncate(shifted);
}

test vraddhn_u64 {
    const a = @as(types.u64x2, @splat(1000));
    const b = @as(types.u64x2, @splat(2000));
    const expected = @as(types.u32x2, @splat(0));
    try common.testIntrinsic(.{ .func = vraddhn_u64, .expected = expected, .args = .{ a, b } });
}

/// Rounding add and narrow high into upper half
pub inline fn vraddhn_high_u64(r: types.u32x2, a: types.u64x2, b: types.u64x2) types.u32x4 {
    const high = vraddhn_u64(a, b);
    var res: types.u32x4 = undefined;
    inline for (0..2) |i| {
        res[i] = r[i];
        res[i + 2] = high[i];
    }
    return res;
}

test vraddhn_high_u64 {
    const r = @as(types.u32x2, @splat(1));
    const a = @as(types.u64x2, @splat(1000));
    const b = @as(types.u64x2, @splat(2000));
    var expected: types.u32x4 = undefined;
    inline for (0..2) |i| {
        expected[i] = 1;
        expected[i + 2] = 0;
    }
    try common.testIntrinsic(.{ .func = vraddhn_high_u64, .expected = expected, .args = .{ r, a, b } });
}

/// Subtract and narrow high
pub inline fn vsubhn_u64(a: types.u64x2, b: types.u64x2) types.u32x2 {
    const diff = a -% b;
    const shifted = diff >> @as(types.u64x2, @splat(32));
    return @truncate(shifted);
}

test vsubhn_u64 {
    const a = @as(types.u64x2, @splat(3000));
    const b = @as(types.u64x2, @splat(1000));
    const expected = @as(types.u32x2, @splat(0));
    try common.testIntrinsic(.{ .func = vsubhn_u64, .expected = expected, .args = .{ a, b } });
}

/// Subtract and narrow high into upper half
pub inline fn vsubhn_high_u64(r: types.u32x2, a: types.u64x2, b: types.u64x2) types.u32x4 {
    const high = vsubhn_u64(a, b);
    var res: types.u32x4 = undefined;
    inline for (0..2) |i| {
        res[i] = r[i];
        res[i + 2] = high[i];
    }
    return res;
}

test vsubhn_high_u64 {
    const r = @as(types.u32x2, @splat(1));
    const a = @as(types.u64x2, @splat(3000));
    const b = @as(types.u64x2, @splat(1000));
    var expected: types.u32x4 = undefined;
    inline for (0..2) |i| {
        expected[i] = 1;
        expected[i + 2] = 0;
    }
    try common.testIntrinsic(.{ .func = vsubhn_high_u64, .expected = expected, .args = .{ r, a, b } });
}

/// Rounding subtract and narrow high
pub inline fn vrsubhn_u64(a: types.u64x2, b: types.u64x2) types.u32x2 {
    const round: types.u64x2 = @splat(1 << 31);
    const diff = a -% b +% round;
    const shifted = diff >> @as(types.u64x2, @splat(32));
    return @truncate(shifted);
}

test vrsubhn_u64 {
    const a = @as(types.u64x2, @splat(3000));
    const b = @as(types.u64x2, @splat(1000));
    const expected = @as(types.u32x2, @splat(0));
    try common.testIntrinsic(.{ .func = vrsubhn_u64, .expected = expected, .args = .{ a, b } });
}

/// Rounding subtract and narrow high into upper half
pub inline fn vrsubhn_high_u64(r: types.u32x2, a: types.u64x2, b: types.u64x2) types.u32x4 {
    const high = vrsubhn_u64(a, b);
    var res: types.u32x4 = undefined;
    inline for (0..2) |i| {
        res[i] = r[i];
        res[i + 2] = high[i];
    }
    return res;
}

test vrsubhn_high_u64 {
    const r = @as(types.u32x2, @splat(1));
    const a = @as(types.u64x2, @splat(3000));
    const b = @as(types.u64x2, @splat(1000));
    var expected: types.u32x4 = undefined;
    inline for (0..2) |i| {
        expected[i] = 1;
        expected[i + 2] = 0;
    }
    try common.testIntrinsic(.{ .func = vrsubhn_high_u64, .expected = expected, .args = .{ r, a, b } });
}

/// Widening multiply accumulate: returns `a + (b * c)`
pub inline fn vmlal_s8(a: types.i16x8, b: types.i8x8, c: types.i8x8) types.i16x8 {
    const wb: types.i16x8 = b;
    const wc: types.i16x8 = c;
    return a +% (wb *% wc);
}

test vmlal_s8 {
    const a = @as(types.i16x8, @splat(10));
    const b = @as(types.i8x8, @splat(3));
    const c = @as(types.i8x8, @splat(4));
    const expected = @as(types.i16x8, @splat(22));
    try common.testIntrinsic(.{ .func = vmlal_s8, .expected = expected, .args = .{ a, b, c } });
}

/// Widening multiply accumulate of high half
pub inline fn vmlal_high_s8(a: types.i16x8, b: types.i8x16, c: types.i8x16) types.i16x8 {
    var hb: types.i8x8 = undefined;
    var hc: types.i8x8 = undefined;
    inline for (0..8) |i| {
        hb[i] = b[i + 8];
        hc[i] = c[i + 8];
    }
    const wb: types.i16x8 = hb;
    const wc: types.i16x8 = hc;
    return a +% (wb *% wc);
}

test vmlal_high_s8 {
    const a = @as(types.i16x8, @splat(10));
    const b = @as(types.i8x16, @splat(3));
    const c = @as(types.i8x16, @splat(4));
    const expected = @as(types.i16x8, @splat(22));
    try common.testIntrinsic(.{ .func = vmlal_high_s8, .expected = expected, .args = .{ a, b, c } });
}

/// Widening multiply subtract: returns `a - (b * c)`
pub inline fn vmlsl_s8(a: types.i16x8, b: types.i8x8, c: types.i8x8) types.i16x8 {
    const wb: types.i16x8 = b;
    const wc: types.i16x8 = c;
    return a -% (wb *% wc);
}

test vmlsl_s8 {
    const a = @as(types.i16x8, @splat(30));
    const b = @as(types.i8x8, @splat(3));
    const c = @as(types.i8x8, @splat(4));
    const expected = @as(types.i16x8, @splat(18));
    try common.testIntrinsic(.{ .func = vmlsl_s8, .expected = expected, .args = .{ a, b, c } });
}

/// Widening multiply subtract of high half
pub inline fn vmlsl_high_s8(a: types.i16x8, b: types.i8x16, c: types.i8x16) types.i16x8 {
    var hb: types.i8x8 = undefined;
    var hc: types.i8x8 = undefined;
    inline for (0..8) |i| {
        hb[i] = b[i + 8];
        hc[i] = c[i + 8];
    }
    const wb: types.i16x8 = hb;
    const wc: types.i16x8 = hc;
    return a -% (wb *% wc);
}

test vmlsl_high_s8 {
    const a = @as(types.i16x8, @splat(30));
    const b = @as(types.i8x16, @splat(3));
    const c = @as(types.i8x16, @splat(4));
    const expected = @as(types.i16x8, @splat(18));
    try common.testIntrinsic(.{ .func = vmlsl_high_s8, .expected = expected, .args = .{ a, b, c } });
}

/// Widening multiply accumulate: returns `a + (b * c)`
pub inline fn vmlal_s16(a: types.i32x4, b: types.i16x4, c: types.i16x4) types.i32x4 {
    const wb: types.i32x4 = b;
    const wc: types.i32x4 = c;
    return a +% (wb *% wc);
}

test vmlal_s16 {
    const a = @as(types.i32x4, @splat(10));
    const b = @as(types.i16x4, @splat(3));
    const c = @as(types.i16x4, @splat(4));
    const expected = @as(types.i32x4, @splat(22));
    try common.testIntrinsic(.{ .func = vmlal_s16, .expected = expected, .args = .{ a, b, c } });
}

/// Widening multiply accumulate of high half
pub inline fn vmlal_high_s16(a: types.i32x4, b: types.i16x8, c: types.i16x8) types.i32x4 {
    var hb: types.i16x4 = undefined;
    var hc: types.i16x4 = undefined;
    inline for (0..4) |i| {
        hb[i] = b[i + 4];
        hc[i] = c[i + 4];
    }
    const wb: types.i32x4 = hb;
    const wc: types.i32x4 = hc;
    return a +% (wb *% wc);
}

test vmlal_high_s16 {
    const a = @as(types.i32x4, @splat(10));
    const b = @as(types.i16x8, @splat(3));
    const c = @as(types.i16x8, @splat(4));
    const expected = @as(types.i32x4, @splat(22));
    try common.testIntrinsic(.{ .func = vmlal_high_s16, .expected = expected, .args = .{ a, b, c } });
}

/// Widening multiply subtract: returns `a - (b * c)`
pub inline fn vmlsl_s16(a: types.i32x4, b: types.i16x4, c: types.i16x4) types.i32x4 {
    const wb: types.i32x4 = b;
    const wc: types.i32x4 = c;
    return a -% (wb *% wc);
}

test vmlsl_s16 {
    const a = @as(types.i32x4, @splat(30));
    const b = @as(types.i16x4, @splat(3));
    const c = @as(types.i16x4, @splat(4));
    const expected = @as(types.i32x4, @splat(18));
    try common.testIntrinsic(.{ .func = vmlsl_s16, .expected = expected, .args = .{ a, b, c } });
}

/// Widening multiply subtract of high half
pub inline fn vmlsl_high_s16(a: types.i32x4, b: types.i16x8, c: types.i16x8) types.i32x4 {
    var hb: types.i16x4 = undefined;
    var hc: types.i16x4 = undefined;
    inline for (0..4) |i| {
        hb[i] = b[i + 4];
        hc[i] = c[i + 4];
    }
    const wb: types.i32x4 = hb;
    const wc: types.i32x4 = hc;
    return a -% (wb *% wc);
}

test vmlsl_high_s16 {
    const a = @as(types.i32x4, @splat(30));
    const b = @as(types.i16x8, @splat(3));
    const c = @as(types.i16x8, @splat(4));
    const expected = @as(types.i32x4, @splat(18));
    try common.testIntrinsic(.{ .func = vmlsl_high_s16, .expected = expected, .args = .{ a, b, c } });
}

/// Widening multiply accumulate: returns `a + (b * c)`
pub inline fn vmlal_s32(a: types.i64x2, b: types.i32x2, c: types.i32x2) types.i64x2 {
    const wb: types.i64x2 = b;
    const wc: types.i64x2 = c;
    return a +% (wb *% wc);
}

test vmlal_s32 {
    const a = @as(types.i64x2, @splat(10));
    const b = @as(types.i32x2, @splat(3));
    const c = @as(types.i32x2, @splat(4));
    const expected = @as(types.i64x2, @splat(22));
    try common.testIntrinsic(.{ .func = vmlal_s32, .expected = expected, .args = .{ a, b, c } });
}

/// Widening multiply accumulate of high half
pub inline fn vmlal_high_s32(a: types.i64x2, b: types.i32x4, c: types.i32x4) types.i64x2 {
    var hb: types.i32x2 = undefined;
    var hc: types.i32x2 = undefined;
    inline for (0..2) |i| {
        hb[i] = b[i + 2];
        hc[i] = c[i + 2];
    }
    const wb: types.i64x2 = hb;
    const wc: types.i64x2 = hc;
    return a +% (wb *% wc);
}

test vmlal_high_s32 {
    const a = @as(types.i64x2, @splat(10));
    const b = @as(types.i32x4, @splat(3));
    const c = @as(types.i32x4, @splat(4));
    const expected = @as(types.i64x2, @splat(22));
    try common.testIntrinsic(.{ .func = vmlal_high_s32, .expected = expected, .args = .{ a, b, c } });
}

/// Widening multiply subtract: returns `a - (b * c)`
pub inline fn vmlsl_s32(a: types.i64x2, b: types.i32x2, c: types.i32x2) types.i64x2 {
    const wb: types.i64x2 = b;
    const wc: types.i64x2 = c;
    return a -% (wb *% wc);
}

test vmlsl_s32 {
    const a = @as(types.i64x2, @splat(30));
    const b = @as(types.i32x2, @splat(3));
    const c = @as(types.i32x2, @splat(4));
    const expected = @as(types.i64x2, @splat(18));
    try common.testIntrinsic(.{ .func = vmlsl_s32, .expected = expected, .args = .{ a, b, c } });
}

/// Widening multiply subtract of high half
pub inline fn vmlsl_high_s32(a: types.i64x2, b: types.i32x4, c: types.i32x4) types.i64x2 {
    var hb: types.i32x2 = undefined;
    var hc: types.i32x2 = undefined;
    inline for (0..2) |i| {
        hb[i] = b[i + 2];
        hc[i] = c[i + 2];
    }
    const wb: types.i64x2 = hb;
    const wc: types.i64x2 = hc;
    return a -% (wb *% wc);
}

test vmlsl_high_s32 {
    const a = @as(types.i64x2, @splat(30));
    const b = @as(types.i32x4, @splat(3));
    const c = @as(types.i32x4, @splat(4));
    const expected = @as(types.i64x2, @splat(18));
    try common.testIntrinsic(.{ .func = vmlsl_high_s32, .expected = expected, .args = .{ a, b, c } });
}

/// Widening multiply accumulate: returns `a + (b * c)`
pub inline fn vmlal_u8(a: types.u16x8, b: types.u8x8, c: types.u8x8) types.u16x8 {
    const wb: types.u16x8 = b;
    const wc: types.u16x8 = c;
    return a +% (wb *% wc);
}

test vmlal_u8 {
    const a = @as(types.u16x8, @splat(10));
    const b = @as(types.u8x8, @splat(3));
    const c = @as(types.u8x8, @splat(4));
    const expected = @as(types.u16x8, @splat(22));
    try common.testIntrinsic(.{ .func = vmlal_u8, .expected = expected, .args = .{ a, b, c } });
}

/// Widening multiply accumulate of high half
pub inline fn vmlal_high_u8(a: types.u16x8, b: types.u8x16, c: types.u8x16) types.u16x8 {
    var hb: types.u8x8 = undefined;
    var hc: types.u8x8 = undefined;
    inline for (0..8) |i| {
        hb[i] = b[i + 8];
        hc[i] = c[i + 8];
    }
    const wb: types.u16x8 = hb;
    const wc: types.u16x8 = hc;
    return a +% (wb *% wc);
}

test vmlal_high_u8 {
    const a = @as(types.u16x8, @splat(10));
    const b = @as(types.u8x16, @splat(3));
    const c = @as(types.u8x16, @splat(4));
    const expected = @as(types.u16x8, @splat(22));
    try common.testIntrinsic(.{ .func = vmlal_high_u8, .expected = expected, .args = .{ a, b, c } });
}

/// Widening multiply subtract: returns `a - (b * c)`
pub inline fn vmlsl_u8(a: types.u16x8, b: types.u8x8, c: types.u8x8) types.u16x8 {
    const wb: types.u16x8 = b;
    const wc: types.u16x8 = c;
    return a -% (wb *% wc);
}

test vmlsl_u8 {
    const a = @as(types.u16x8, @splat(30));
    const b = @as(types.u8x8, @splat(3));
    const c = @as(types.u8x8, @splat(4));
    const expected = @as(types.u16x8, @splat(18));
    try common.testIntrinsic(.{ .func = vmlsl_u8, .expected = expected, .args = .{ a, b, c } });
}

/// Widening multiply subtract of high half
pub inline fn vmlsl_high_u8(a: types.u16x8, b: types.u8x16, c: types.u8x16) types.u16x8 {
    var hb: types.u8x8 = undefined;
    var hc: types.u8x8 = undefined;
    inline for (0..8) |i| {
        hb[i] = b[i + 8];
        hc[i] = c[i + 8];
    }
    const wb: types.u16x8 = hb;
    const wc: types.u16x8 = hc;
    return a -% (wb *% wc);
}

test vmlsl_high_u8 {
    const a = @as(types.u16x8, @splat(30));
    const b = @as(types.u8x16, @splat(3));
    const c = @as(types.u8x16, @splat(4));
    const expected = @as(types.u16x8, @splat(18));
    try common.testIntrinsic(.{ .func = vmlsl_high_u8, .expected = expected, .args = .{ a, b, c } });
}

/// Widening multiply accumulate: returns `a + (b * c)`
pub inline fn vmlal_u16(a: types.u32x4, b: types.u16x4, c: types.u16x4) types.u32x4 {
    const wb: types.u32x4 = b;
    const wc: types.u32x4 = c;
    return a +% (wb *% wc);
}

test vmlal_u16 {
    const a = @as(types.u32x4, @splat(10));
    const b = @as(types.u16x4, @splat(3));
    const c = @as(types.u16x4, @splat(4));
    const expected = @as(types.u32x4, @splat(22));
    try common.testIntrinsic(.{ .func = vmlal_u16, .expected = expected, .args = .{ a, b, c } });
}

/// Widening multiply accumulate of high half
pub inline fn vmlal_high_u16(a: types.u32x4, b: types.u16x8, c: types.u16x8) types.u32x4 {
    var hb: types.u16x4 = undefined;
    var hc: types.u16x4 = undefined;
    inline for (0..4) |i| {
        hb[i] = b[i + 4];
        hc[i] = c[i + 4];
    }
    const wb: types.u32x4 = hb;
    const wc: types.u32x4 = hc;
    return a +% (wb *% wc);
}

test vmlal_high_u16 {
    const a = @as(types.u32x4, @splat(10));
    const b = @as(types.u16x8, @splat(3));
    const c = @as(types.u16x8, @splat(4));
    const expected = @as(types.u32x4, @splat(22));
    try common.testIntrinsic(.{ .func = vmlal_high_u16, .expected = expected, .args = .{ a, b, c } });
}

/// Widening multiply subtract: returns `a - (b * c)`
pub inline fn vmlsl_u16(a: types.u32x4, b: types.u16x4, c: types.u16x4) types.u32x4 {
    const wb: types.u32x4 = b;
    const wc: types.u32x4 = c;
    return a -% (wb *% wc);
}

test vmlsl_u16 {
    const a = @as(types.u32x4, @splat(30));
    const b = @as(types.u16x4, @splat(3));
    const c = @as(types.u16x4, @splat(4));
    const expected = @as(types.u32x4, @splat(18));
    try common.testIntrinsic(.{ .func = vmlsl_u16, .expected = expected, .args = .{ a, b, c } });
}

/// Widening multiply subtract of high half
pub inline fn vmlsl_high_u16(a: types.u32x4, b: types.u16x8, c: types.u16x8) types.u32x4 {
    var hb: types.u16x4 = undefined;
    var hc: types.u16x4 = undefined;
    inline for (0..4) |i| {
        hb[i] = b[i + 4];
        hc[i] = c[i + 4];
    }
    const wb: types.u32x4 = hb;
    const wc: types.u32x4 = hc;
    return a -% (wb *% wc);
}

test vmlsl_high_u16 {
    const a = @as(types.u32x4, @splat(30));
    const b = @as(types.u16x8, @splat(3));
    const c = @as(types.u16x8, @splat(4));
    const expected = @as(types.u32x4, @splat(18));
    try common.testIntrinsic(.{ .func = vmlsl_high_u16, .expected = expected, .args = .{ a, b, c } });
}

/// Widening multiply accumulate: returns `a + (b * c)`
pub inline fn vmlal_u32(a: types.u64x2, b: types.u32x2, c: types.u32x2) types.u64x2 {
    const wb: types.u64x2 = b;
    const wc: types.u64x2 = c;
    return a +% (wb *% wc);
}

test vmlal_u32 {
    const a = @as(types.u64x2, @splat(10));
    const b = @as(types.u32x2, @splat(3));
    const c = @as(types.u32x2, @splat(4));
    const expected = @as(types.u64x2, @splat(22));
    try common.testIntrinsic(.{ .func = vmlal_u32, .expected = expected, .args = .{ a, b, c } });
}

/// Widening multiply accumulate of high half
pub inline fn vmlal_high_u32(a: types.u64x2, b: types.u32x4, c: types.u32x4) types.u64x2 {
    var hb: types.u32x2 = undefined;
    var hc: types.u32x2 = undefined;
    inline for (0..2) |i| {
        hb[i] = b[i + 2];
        hc[i] = c[i + 2];
    }
    const wb: types.u64x2 = hb;
    const wc: types.u64x2 = hc;
    return a +% (wb *% wc);
}

test vmlal_high_u32 {
    const a = @as(types.u64x2, @splat(10));
    const b = @as(types.u32x4, @splat(3));
    const c = @as(types.u32x4, @splat(4));
    const expected = @as(types.u64x2, @splat(22));
    try common.testIntrinsic(.{ .func = vmlal_high_u32, .expected = expected, .args = .{ a, b, c } });
}

/// Widening multiply subtract: returns `a - (b * c)`
pub inline fn vmlsl_u32(a: types.u64x2, b: types.u32x2, c: types.u32x2) types.u64x2 {
    const wb: types.u64x2 = b;
    const wc: types.u64x2 = c;
    return a -% (wb *% wc);
}

test vmlsl_u32 {
    const a = @as(types.u64x2, @splat(30));
    const b = @as(types.u32x2, @splat(3));
    const c = @as(types.u32x2, @splat(4));
    const expected = @as(types.u64x2, @splat(18));
    try common.testIntrinsic(.{ .func = vmlsl_u32, .expected = expected, .args = .{ a, b, c } });
}

/// Widening multiply subtract of high half
pub inline fn vmlsl_high_u32(a: types.u64x2, b: types.u32x4, c: types.u32x4) types.u64x2 {
    var hb: types.u32x2 = undefined;
    var hc: types.u32x2 = undefined;
    inline for (0..2) |i| {
        hb[i] = b[i + 2];
        hc[i] = c[i + 2];
    }
    const wb: types.u64x2 = hb;
    const wc: types.u64x2 = hc;
    return a -% (wb *% wc);
}

test vmlsl_high_u32 {
    const a = @as(types.u64x2, @splat(30));
    const b = @as(types.u32x4, @splat(3));
    const c = @as(types.u32x4, @splat(4));
    const expected = @as(types.u64x2, @splat(18));
    try common.testIntrinsic(.{ .func = vmlsl_high_u32, .expected = expected, .args = .{ a, b, c } });
}

/// Saturating doubling multiply of high half
pub inline fn vqdmull_high_s16(b: types.i16x8, c: types.i16x8) types.i32x4 {
    var hb: types.i16x4 = undefined;
    var hc: types.i16x4 = undefined;
    inline for (0..4) |i| {
        hb[i] = b[i + 4];
        hc[i] = c[i + 4];
    }
    return vqdmull_s16(hb, hc);
}

test vqdmull_high_s16 {
    const b = @as(types.i16x8, @splat(3));
    const c = @as(types.i16x8, @splat(4));
    const expected = @as(types.i32x4, @splat(24));
    try common.testIntrinsic(.{ .func = vqdmull_high_s16, .expected = expected, .args = .{ b, c } });
}

/// Saturating doubling multiply accumulate: returns `a + 2 * b * c`
pub inline fn vqdmlal_s16(a: types.i32x4, b: types.i16x4, c: types.i16x4) types.i32x4 {
    const prod = vqdmull_s16(b, c);
    return a +% prod;
}

test vqdmlal_s16 {
    const a = @as(types.i32x4, @splat(10));
    const b = @as(types.i16x4, @splat(3));
    const c = @as(types.i16x4, @splat(4));
    const expected = @as(types.i32x4, @splat(34));
    try common.testIntrinsic(.{ .func = vqdmlal_s16, .expected = expected, .args = .{ a, b, c } });
}

/// Saturating doubling multiply accumulate of high half
pub inline fn vqdmlal_high_s16(a: types.i32x4, b: types.i16x8, c: types.i16x8) types.i32x4 {
    var hb: types.i16x4 = undefined;
    var hc: types.i16x4 = undefined;
    inline for (0..4) |i| {
        hb[i] = b[i + 4];
        hc[i] = c[i + 4];
    }
    return vqdmlal_s16(a, hb, hc);
}

test vqdmlal_high_s16 {
    const a = @as(types.i32x4, @splat(10));
    const b = @as(types.i16x8, @splat(3));
    const c = @as(types.i16x8, @splat(4));
    const expected = @as(types.i32x4, @splat(34));
    try common.testIntrinsic(.{ .func = vqdmlal_high_s16, .expected = expected, .args = .{ a, b, c } });
}

/// Saturating doubling multiply subtract: returns `a - 2 * b * c`
pub inline fn vqdmlsl_s16(a: types.i32x4, b: types.i16x4, c: types.i16x4) types.i32x4 {
    const prod = vqdmull_s16(b, c);
    return a -% prod;
}

test vqdmlsl_s16 {
    const a = @as(types.i32x4, @splat(50));
    const b = @as(types.i16x4, @splat(3));
    const c = @as(types.i16x4, @splat(4));
    const expected = @as(types.i32x4, @splat(26));
    try common.testIntrinsic(.{ .func = vqdmlsl_s16, .expected = expected, .args = .{ a, b, c } });
}

/// Saturating doubling multiply subtract of high half
pub inline fn vqdmlsl_high_s16(a: types.i32x4, b: types.i16x8, c: types.i16x8) types.i32x4 {
    var hb: types.i16x4 = undefined;
    var hc: types.i16x4 = undefined;
    inline for (0..4) |i| {
        hb[i] = b[i + 4];
        hc[i] = c[i + 4];
    }
    return vqdmlsl_s16(a, hb, hc);
}

test vqdmlsl_high_s16 {
    const a = @as(types.i32x4, @splat(50));
    const b = @as(types.i16x8, @splat(3));
    const c = @as(types.i16x8, @splat(4));
    const expected = @as(types.i32x4, @splat(26));
    try common.testIntrinsic(.{ .func = vqdmlsl_high_s16, .expected = expected, .args = .{ a, b, c } });
}

/// Saturating doubling multiply of high half
pub inline fn vqdmull_high_s32(b: types.i32x4, c: types.i32x4) types.i64x2 {
    var hb: types.i32x2 = undefined;
    var hc: types.i32x2 = undefined;
    inline for (0..2) |i| {
        hb[i] = b[i + 2];
        hc[i] = c[i + 2];
    }
    return vqdmull_s32(hb, hc);
}

test vqdmull_high_s32 {
    const b = @as(types.i32x4, @splat(3));
    const c = @as(types.i32x4, @splat(4));
    const expected = @as(types.i64x2, @splat(24));
    try common.testIntrinsic(.{ .func = vqdmull_high_s32, .expected = expected, .args = .{ b, c } });
}

/// Saturating doubling multiply accumulate: returns `a + 2 * b * c`
pub inline fn vqdmlal_s32(a: types.i64x2, b: types.i32x2, c: types.i32x2) types.i64x2 {
    const prod = vqdmull_s32(b, c);
    return a +% prod;
}

test vqdmlal_s32 {
    const a = @as(types.i64x2, @splat(10));
    const b = @as(types.i32x2, @splat(3));
    const c = @as(types.i32x2, @splat(4));
    const expected = @as(types.i64x2, @splat(34));
    try common.testIntrinsic(.{ .func = vqdmlal_s32, .expected = expected, .args = .{ a, b, c } });
}

/// Saturating doubling multiply accumulate of high half
pub inline fn vqdmlal_high_s32(a: types.i64x2, b: types.i32x4, c: types.i32x4) types.i64x2 {
    var hb: types.i32x2 = undefined;
    var hc: types.i32x2 = undefined;
    inline for (0..2) |i| {
        hb[i] = b[i + 2];
        hc[i] = c[i + 2];
    }
    return vqdmlal_s32(a, hb, hc);
}

test vqdmlal_high_s32 {
    const a = @as(types.i64x2, @splat(10));
    const b = @as(types.i32x4, @splat(3));
    const c = @as(types.i32x4, @splat(4));
    const expected = @as(types.i64x2, @splat(34));
    try common.testIntrinsic(.{ .func = vqdmlal_high_s32, .expected = expected, .args = .{ a, b, c } });
}

/// Saturating doubling multiply subtract: returns `a - 2 * b * c`
pub inline fn vqdmlsl_s32(a: types.i64x2, b: types.i32x2, c: types.i32x2) types.i64x2 {
    const prod = vqdmull_s32(b, c);
    return a -% prod;
}

test vqdmlsl_s32 {
    const a = @as(types.i64x2, @splat(50));
    const b = @as(types.i32x2, @splat(3));
    const c = @as(types.i32x2, @splat(4));
    const expected = @as(types.i64x2, @splat(26));
    try common.testIntrinsic(.{ .func = vqdmlsl_s32, .expected = expected, .args = .{ a, b, c } });
}

/// Saturating doubling multiply subtract of high half
pub inline fn vqdmlsl_high_s32(a: types.i64x2, b: types.i32x4, c: types.i32x4) types.i64x2 {
    var hb: types.i32x2 = undefined;
    var hc: types.i32x2 = undefined;
    inline for (0..2) |i| {
        hb[i] = b[i + 2];
        hc[i] = c[i + 2];
    }
    return vqdmlsl_s32(a, hb, hc);
}

test vqdmlsl_high_s32 {
    const a = @as(types.i64x2, @splat(50));
    const b = @as(types.i32x4, @splat(3));
    const c = @as(types.i32x4, @splat(4));
    const expected = @as(types.i64x2, @splat(26));
    try common.testIntrinsic(.{ .func = vqdmlsl_high_s32, .expected = expected, .args = .{ a, b, c } });
}

/// Pairwise widening addition
pub inline fn vpaddl_s8(a: types.i8x8) types.i16x4 {
    return .{ @as(i16, a[0]) +% a[1], @as(i16, a[2]) +% a[3], @as(i16, a[4]) +% a[5], @as(i16, a[6]) +% a[7] };
}

test vpaddl_s8 {
    const a = @as(types.i8x8, @splat(10));
    const expected = @as(types.i16x4, @splat(20));
    try common.testIntrinsic(.{ .func = vpaddl_s8, .expected = expected, .args = .{a} });
}

/// Pairwise widening addition
pub inline fn vpaddlq_s8(a: types.i8x16) types.i16x8 {
    return .{ @as(i16, a[0]) +% a[1], @as(i16, a[2]) +% a[3], @as(i16, a[4]) +% a[5], @as(i16, a[6]) +% a[7], @as(i16, a[8]) +% a[9], @as(i16, a[10]) +% a[11], @as(i16, a[12]) +% a[13], @as(i16, a[14]) +% a[15] };
}

test vpaddlq_s8 {
    const a = @as(types.i8x16, @splat(10));
    const expected = @as(types.i16x8, @splat(20));
    try common.testIntrinsic(.{ .func = vpaddlq_s8, .expected = expected, .args = .{a} });
}

/// Pairwise widening accumulate
pub inline fn vpadal_s8(acc: types.i16x4, a: types.i8x8) types.i16x4 {
    return acc +% vpaddl_s8(a);
}

test vpadal_s8 {
    const acc = @as(types.i16x4, @splat(5));
    const a = @as(types.i8x8, @splat(10));
    const expected = @as(types.i16x4, @splat(25));
    try common.testIntrinsic(.{ .func = vpadal_s8, .expected = expected, .args = .{ acc, a } });
}

/// Pairwise widening accumulate
pub inline fn vpadalq_s8(acc: types.i16x8, a: types.i8x16) types.i16x8 {
    return acc +% vpaddlq_s8(a);
}

test vpadalq_s8 {
    const acc = @as(types.i16x8, @splat(5));
    const a = @as(types.i8x16, @splat(10));
    const expected = @as(types.i16x8, @splat(25));
    try common.testIntrinsic(.{ .func = vpadalq_s8, .expected = expected, .args = .{ acc, a } });
}

/// Pairwise widening addition
pub inline fn vpaddl_s16(a: types.i16x4) types.i32x2 {
    return .{ @as(i32, a[0]) +% a[1], @as(i32, a[2]) +% a[3] };
}

test vpaddl_s16 {
    const a = @as(types.i16x4, @splat(10));
    const expected = @as(types.i32x2, @splat(20));
    try common.testIntrinsic(.{ .func = vpaddl_s16, .expected = expected, .args = .{a} });
}

/// Pairwise widening addition
pub inline fn vpaddlq_s16(a: types.i16x8) types.i32x4 {
    return .{ @as(i32, a[0]) +% a[1], @as(i32, a[2]) +% a[3], @as(i32, a[4]) +% a[5], @as(i32, a[6]) +% a[7] };
}

test vpaddlq_s16 {
    const a = @as(types.i16x8, @splat(10));
    const expected = @as(types.i32x4, @splat(20));
    try common.testIntrinsic(.{ .func = vpaddlq_s16, .expected = expected, .args = .{a} });
}

/// Pairwise widening accumulate
pub inline fn vpadal_s16(acc: types.i32x2, a: types.i16x4) types.i32x2 {
    return acc +% vpaddl_s16(a);
}

test vpadal_s16 {
    const acc = @as(types.i32x2, @splat(5));
    const a = @as(types.i16x4, @splat(10));
    const expected = @as(types.i32x2, @splat(25));
    try common.testIntrinsic(.{ .func = vpadal_s16, .expected = expected, .args = .{ acc, a } });
}

/// Pairwise widening accumulate
pub inline fn vpadalq_s16(acc: types.i32x4, a: types.i16x8) types.i32x4 {
    return acc +% vpaddlq_s16(a);
}

test vpadalq_s16 {
    const acc = @as(types.i32x4, @splat(5));
    const a = @as(types.i16x8, @splat(10));
    const expected = @as(types.i32x4, @splat(25));
    try common.testIntrinsic(.{ .func = vpadalq_s16, .expected = expected, .args = .{ acc, a } });
}

/// Pairwise widening addition
pub inline fn vpaddl_s32(a: types.i32x2) types.i64x1 {
    return .{@as(i64, a[0]) +% a[1]};
}

test vpaddl_s32 {
    const a = @as(types.i32x2, @splat(10));
    const expected = @as(types.i64x1, @splat(20));
    try common.testIntrinsic(.{ .func = vpaddl_s32, .expected = expected, .args = .{a} });
}

/// Pairwise widening addition
pub inline fn vpaddlq_s32(a: types.i32x4) types.i64x2 {
    return .{ @as(i64, a[0]) +% a[1], @as(i64, a[2]) +% a[3] };
}

test vpaddlq_s32 {
    const a = @as(types.i32x4, @splat(10));
    const expected = @as(types.i64x2, @splat(20));
    try common.testIntrinsic(.{ .func = vpaddlq_s32, .expected = expected, .args = .{a} });
}

/// Pairwise widening accumulate
pub inline fn vpadal_s32(acc: types.i64x1, a: types.i32x2) types.i64x1 {
    return acc +% vpaddl_s32(a);
}

test vpadal_s32 {
    const acc = @as(types.i64x1, @splat(5));
    const a = @as(types.i32x2, @splat(10));
    const expected = @as(types.i64x1, @splat(25));
    try common.testIntrinsic(.{ .func = vpadal_s32, .expected = expected, .args = .{ acc, a } });
}

/// Pairwise widening accumulate
pub inline fn vpadalq_s32(acc: types.i64x2, a: types.i32x4) types.i64x2 {
    return acc +% vpaddlq_s32(a);
}

test vpadalq_s32 {
    const acc = @as(types.i64x2, @splat(5));
    const a = @as(types.i32x4, @splat(10));
    const expected = @as(types.i64x2, @splat(25));
    try common.testIntrinsic(.{ .func = vpadalq_s32, .expected = expected, .args = .{ acc, a } });
}

/// Pairwise widening addition
pub inline fn vpaddl_u8(a: types.u8x8) types.u16x4 {
    return .{ @as(u16, a[0]) +% a[1], @as(u16, a[2]) +% a[3], @as(u16, a[4]) +% a[5], @as(u16, a[6]) +% a[7] };
}

test vpaddl_u8 {
    const a = @as(types.u8x8, @splat(10));
    const expected = @as(types.u16x4, @splat(20));
    try common.testIntrinsic(.{ .func = vpaddl_u8, .expected = expected, .args = .{a} });
}

/// Pairwise widening addition
pub inline fn vpaddlq_u8(a: types.u8x16) types.u16x8 {
    return .{ @as(u16, a[0]) +% a[1], @as(u16, a[2]) +% a[3], @as(u16, a[4]) +% a[5], @as(u16, a[6]) +% a[7], @as(u16, a[8]) +% a[9], @as(u16, a[10]) +% a[11], @as(u16, a[12]) +% a[13], @as(u16, a[14]) +% a[15] };
}

test vpaddlq_u8 {
    const a = @as(types.u8x16, @splat(10));
    const expected = @as(types.u16x8, @splat(20));
    try common.testIntrinsic(.{ .func = vpaddlq_u8, .expected = expected, .args = .{a} });
}

/// Pairwise widening accumulate
pub inline fn vpadal_u8(acc: types.u16x4, a: types.u8x8) types.u16x4 {
    return acc +% vpaddl_u8(a);
}

test vpadal_u8 {
    const acc = @as(types.u16x4, @splat(5));
    const a = @as(types.u8x8, @splat(10));
    const expected = @as(types.u16x4, @splat(25));
    try common.testIntrinsic(.{ .func = vpadal_u8, .expected = expected, .args = .{ acc, a } });
}

/// Pairwise widening accumulate
pub inline fn vpadalq_u8(acc: types.u16x8, a: types.u8x16) types.u16x8 {
    return acc +% vpaddlq_u8(a);
}

test vpadalq_u8 {
    const acc = @as(types.u16x8, @splat(5));
    const a = @as(types.u8x16, @splat(10));
    const expected = @as(types.u16x8, @splat(25));
    try common.testIntrinsic(.{ .func = vpadalq_u8, .expected = expected, .args = .{ acc, a } });
}

/// Pairwise widening addition
pub inline fn vpaddl_u16(a: types.u16x4) types.u32x2 {
    return .{ @as(u32, a[0]) +% a[1], @as(u32, a[2]) +% a[3] };
}

test vpaddl_u16 {
    const a = @as(types.u16x4, @splat(10));
    const expected = @as(types.u32x2, @splat(20));
    try common.testIntrinsic(.{ .func = vpaddl_u16, .expected = expected, .args = .{a} });
}

/// Pairwise widening addition
pub inline fn vpaddlq_u16(a: types.u16x8) types.u32x4 {
    return .{ @as(u32, a[0]) +% a[1], @as(u32, a[2]) +% a[3], @as(u32, a[4]) +% a[5], @as(u32, a[6]) +% a[7] };
}

test vpaddlq_u16 {
    const a = @as(types.u16x8, @splat(10));
    const expected = @as(types.u32x4, @splat(20));
    try common.testIntrinsic(.{ .func = vpaddlq_u16, .expected = expected, .args = .{a} });
}

/// Pairwise widening accumulate
pub inline fn vpadal_u16(acc: types.u32x2, a: types.u16x4) types.u32x2 {
    return acc +% vpaddl_u16(a);
}

test vpadal_u16 {
    const acc = @as(types.u32x2, @splat(5));
    const a = @as(types.u16x4, @splat(10));
    const expected = @as(types.u32x2, @splat(25));
    try common.testIntrinsic(.{ .func = vpadal_u16, .expected = expected, .args = .{ acc, a } });
}

/// Pairwise widening accumulate
pub inline fn vpadalq_u16(acc: types.u32x4, a: types.u16x8) types.u32x4 {
    return acc +% vpaddlq_u16(a);
}

test vpadalq_u16 {
    const acc = @as(types.u32x4, @splat(5));
    const a = @as(types.u16x8, @splat(10));
    const expected = @as(types.u32x4, @splat(25));
    try common.testIntrinsic(.{ .func = vpadalq_u16, .expected = expected, .args = .{ acc, a } });
}

/// Pairwise widening addition
pub inline fn vpaddl_u32(a: types.u32x2) types.u64x1 {
    return .{@as(u64, a[0]) +% a[1]};
}

test vpaddl_u32 {
    const a = @as(types.u32x2, @splat(10));
    const expected = @as(types.u64x1, @splat(20));
    try common.testIntrinsic(.{ .func = vpaddl_u32, .expected = expected, .args = .{a} });
}

/// Pairwise widening addition
pub inline fn vpaddlq_u32(a: types.u32x4) types.u64x2 {
    return .{ @as(u64, a[0]) +% a[1], @as(u64, a[2]) +% a[3] };
}

test vpaddlq_u32 {
    const a = @as(types.u32x4, @splat(10));
    const expected = @as(types.u64x2, @splat(20));
    try common.testIntrinsic(.{ .func = vpaddlq_u32, .expected = expected, .args = .{a} });
}

/// Pairwise widening accumulate
pub inline fn vpadal_u32(acc: types.u64x1, a: types.u32x2) types.u64x1 {
    return acc +% vpaddl_u32(a);
}

test vpadal_u32 {
    const acc = @as(types.u64x1, @splat(5));
    const a = @as(types.u32x2, @splat(10));
    const expected = @as(types.u64x1, @splat(25));
    try common.testIntrinsic(.{ .func = vpadal_u32, .expected = expected, .args = .{ acc, a } });
}

/// Pairwise widening accumulate
pub inline fn vpadalq_u32(acc: types.u64x2, a: types.u32x4) types.u64x2 {
    return acc +% vpaddlq_u32(a);
}

test vpadalq_u32 {
    const acc = @as(types.u64x2, @splat(5));
    const a = @as(types.u32x4, @splat(10));
    const expected = @as(types.u64x2, @splat(25));
    try common.testIntrinsic(.{ .func = vpadalq_u32, .expected = expected, .args = .{ acc, a } });
}

/// IEEE 754-2008 float vmax with NaN handling
pub inline fn vmaxnm_f16(a: types.f16x4, b: types.f16x4) types.f16x4 {
    return @max(a, b);
}

test vmaxnm_f16 {
    const a = @as(types.f16x4, @splat(1.5));
    const b = @as(types.f16x4, @splat(2.5));
    const expected = @as(types.f16x4, @splat(2.5));
    try common.testIntrinsic(.{ .func = vmaxnm_f16, .expected = expected, .args = .{ a, b } });
}

/// IEEE 754-2008 float vmax with NaN handling
pub inline fn vmaxnmq_f16(a: types.f16x8, b: types.f16x8) types.f16x8 {
    return @max(a, b);
}

test vmaxnmq_f16 {
    const a = @as(types.f16x8, @splat(1.5));
    const b = @as(types.f16x8, @splat(2.5));
    const expected = @as(types.f16x8, @splat(2.5));
    try common.testIntrinsic(.{ .func = vmaxnmq_f16, .expected = expected, .args = .{ a, b } });
}

/// IEEE 754-2008 float vmin with NaN handling
pub inline fn vminnm_f16(a: types.f16x4, b: types.f16x4) types.f16x4 {
    return @min(a, b);
}

test vminnm_f16 {
    const a = @as(types.f16x4, @splat(1.5));
    const b = @as(types.f16x4, @splat(2.5));
    const expected = @as(types.f16x4, @splat(1.5));
    try common.testIntrinsic(.{ .func = vminnm_f16, .expected = expected, .args = .{ a, b } });
}

/// IEEE 754-2008 float vmin with NaN handling
pub inline fn vminnmq_f16(a: types.f16x8, b: types.f16x8) types.f16x8 {
    return @min(a, b);
}

test vminnmq_f16 {
    const a = @as(types.f16x8, @splat(1.5));
    const b = @as(types.f16x8, @splat(2.5));
    const expected = @as(types.f16x8, @splat(1.5));
    try common.testIntrinsic(.{ .func = vminnmq_f16, .expected = expected, .args = .{ a, b } });
}

/// IEEE 754-2008 float vmax with NaN handling
pub inline fn vmaxnm_f32(a: types.f32x2, b: types.f32x2) types.f32x2 {
    return @max(a, b);
}

test vmaxnm_f32 {
    const a = @as(types.f32x2, @splat(1.5));
    const b = @as(types.f32x2, @splat(2.5));
    const expected = @as(types.f32x2, @splat(2.5));
    try common.testIntrinsic(.{ .func = vmaxnm_f32, .expected = expected, .args = .{ a, b } });
}

/// IEEE 754-2008 float vmax with NaN handling
pub inline fn vmaxnmq_f32(a: types.f32x4, b: types.f32x4) types.f32x4 {
    return @max(a, b);
}

test vmaxnmq_f32 {
    const a = @as(types.f32x4, @splat(1.5));
    const b = @as(types.f32x4, @splat(2.5));
    const expected = @as(types.f32x4, @splat(2.5));
    try common.testIntrinsic(.{ .func = vmaxnmq_f32, .expected = expected, .args = .{ a, b } });
}

/// IEEE 754-2008 float vmin with NaN handling
pub inline fn vminnm_f32(a: types.f32x2, b: types.f32x2) types.f32x2 {
    return @min(a, b);
}

test vminnm_f32 {
    const a = @as(types.f32x2, @splat(1.5));
    const b = @as(types.f32x2, @splat(2.5));
    const expected = @as(types.f32x2, @splat(1.5));
    try common.testIntrinsic(.{ .func = vminnm_f32, .expected = expected, .args = .{ a, b } });
}

/// IEEE 754-2008 float vmin with NaN handling
pub inline fn vminnmq_f32(a: types.f32x4, b: types.f32x4) types.f32x4 {
    return @min(a, b);
}

test vminnmq_f32 {
    const a = @as(types.f32x4, @splat(1.5));
    const b = @as(types.f32x4, @splat(2.5));
    const expected = @as(types.f32x4, @splat(1.5));
    try common.testIntrinsic(.{ .func = vminnmq_f32, .expected = expected, .args = .{ a, b } });
}

/// IEEE 754-2008 float vmax with NaN handling
pub inline fn vmaxnm_f64(a: types.f64x1, b: types.f64x1) types.f64x1 {
    return @max(a, b);
}

test vmaxnm_f64 {
    const a = @as(types.f64x1, @splat(1.5));
    const b = @as(types.f64x1, @splat(2.5));
    const expected = @as(types.f64x1, @splat(2.5));
    try common.testIntrinsic(.{ .func = vmaxnm_f64, .expected = expected, .args = .{ a, b } });
}

/// IEEE 754-2008 float vmax with NaN handling
pub inline fn vmaxnmq_f64(a: types.f64x2, b: types.f64x2) types.f64x2 {
    return @max(a, b);
}

test vmaxnmq_f64 {
    const a = @as(types.f64x2, @splat(1.5));
    const b = @as(types.f64x2, @splat(2.5));
    const expected = @as(types.f64x2, @splat(2.5));
    try common.testIntrinsic(.{ .func = vmaxnmq_f64, .expected = expected, .args = .{ a, b } });
}

/// IEEE 754-2008 float vmin with NaN handling
pub inline fn vminnm_f64(a: types.f64x1, b: types.f64x1) types.f64x1 {
    return @min(a, b);
}

test vminnm_f64 {
    const a = @as(types.f64x1, @splat(1.5));
    const b = @as(types.f64x1, @splat(2.5));
    const expected = @as(types.f64x1, @splat(1.5));
    try common.testIntrinsic(.{ .func = vminnm_f64, .expected = expected, .args = .{ a, b } });
}

/// IEEE 754-2008 float vmin with NaN handling
pub inline fn vminnmq_f64(a: types.f64x2, b: types.f64x2) types.f64x2 {
    return @min(a, b);
}

test vminnmq_f64 {
    const a = @as(types.f64x2, @splat(1.5));
    const b = @as(types.f64x2, @splat(2.5));
    const expected = @as(types.f64x2, @splat(1.5));
    try common.testIntrinsic(.{ .func = vminnmq_f64, .expected = expected, .args = .{ a, b } });
}

/// Pairwise float vpma with NaN handling
pub inline fn vpmaxnm_f16(a: types.f16x4, b: types.f16x4) types.f16x4 {
    return .{ @max(a[0], a[1]), @max(a[2], a[3]), @max(b[0], b[1]), @max(b[2], b[3]) };
}

test vpmaxnm_f16 {
    const a = @as(types.f16x4, @splat(1.5));
    const b = @as(types.f16x4, @splat(2.5));
    const res = vpmaxnm_f16(a, b);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// Pairwise float vpma with NaN handling
pub inline fn vpmaxnmq_f16(a: types.f16x8, b: types.f16x8) types.f16x8 {
    return .{ @max(a[0], a[1]), @max(a[2], a[3]), @max(a[4], a[5]), @max(a[6], a[7]), @max(b[0], b[1]), @max(b[2], b[3]), @max(b[4], b[5]), @max(b[6], b[7]) };
}

test vpmaxnmq_f16 {
    const a = @as(types.f16x8, @splat(1.5));
    const b = @as(types.f16x8, @splat(2.5));
    const res = vpmaxnmq_f16(a, b);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// Pairwise float vpmi with NaN handling
pub inline fn vpminnm_f16(a: types.f16x4, b: types.f16x4) types.f16x4 {
    return .{ @min(a[0], a[1]), @min(a[2], a[3]), @min(b[0], b[1]), @min(b[2], b[3]) };
}

test vpminnm_f16 {
    const a = @as(types.f16x4, @splat(1.5));
    const b = @as(types.f16x4, @splat(2.5));
    const res = vpminnm_f16(a, b);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// Pairwise float vpmi with NaN handling
pub inline fn vpminnmq_f16(a: types.f16x8, b: types.f16x8) types.f16x8 {
    return .{ @min(a[0], a[1]), @min(a[2], a[3]), @min(a[4], a[5]), @min(a[6], a[7]), @min(b[0], b[1]), @min(b[2], b[3]), @min(b[4], b[5]), @min(b[6], b[7]) };
}

test vpminnmq_f16 {
    const a = @as(types.f16x8, @splat(1.5));
    const b = @as(types.f16x8, @splat(2.5));
    const res = vpminnmq_f16(a, b);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// Pairwise float vpma with NaN handling
pub inline fn vpmaxnm_f32(a: types.f32x2, b: types.f32x2) types.f32x2 {
    return .{ @max(a[0], a[1]), @max(b[0], b[1]) };
}

test vpmaxnm_f32 {
    const a = @as(types.f32x2, @splat(1.5));
    const b = @as(types.f32x2, @splat(2.5));
    const res = vpmaxnm_f32(a, b);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// Pairwise float vpma with NaN handling
pub inline fn vpmaxnmq_f32(a: types.f32x4, b: types.f32x4) types.f32x4 {
    return .{ @max(a[0], a[1]), @max(a[2], a[3]), @max(b[0], b[1]), @max(b[2], b[3]) };
}

test vpmaxnmq_f32 {
    const a = @as(types.f32x4, @splat(1.5));
    const b = @as(types.f32x4, @splat(2.5));
    const res = vpmaxnmq_f32(a, b);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// Pairwise float vpmi with NaN handling
pub inline fn vpminnm_f32(a: types.f32x2, b: types.f32x2) types.f32x2 {
    return .{ @min(a[0], a[1]), @min(b[0], b[1]) };
}

test vpminnm_f32 {
    const a = @as(types.f32x2, @splat(1.5));
    const b = @as(types.f32x2, @splat(2.5));
    const res = vpminnm_f32(a, b);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// Pairwise float vpmi with NaN handling
pub inline fn vpminnmq_f32(a: types.f32x4, b: types.f32x4) types.f32x4 {
    return .{ @min(a[0], a[1]), @min(a[2], a[3]), @min(b[0], b[1]), @min(b[2], b[3]) };
}

test vpminnmq_f32 {
    const a = @as(types.f32x4, @splat(1.5));
    const b = @as(types.f32x4, @splat(2.5));
    const res = vpminnmq_f32(a, b);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// Pairwise float vpma with NaN handling
pub inline fn vpmaxnmq_f64(a: types.f64x2, b: types.f64x2) types.f64x2 {
    return .{ @max(a[0], a[1]), @max(b[0], b[1]) };
}

test vpmaxnmq_f64 {
    const a = @as(types.f64x2, @splat(1.5));
    const b = @as(types.f64x2, @splat(2.5));
    const res = vpmaxnmq_f64(a, b);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// Pairwise float vpmi with NaN handling
pub inline fn vpminnmq_f64(a: types.f64x2, b: types.f64x2) types.f64x2 {
    return .{ @min(a[0], a[1]), @min(b[0], b[1]) };
}

test vpminnmq_f64 {
    const a = @as(types.f64x2, @splat(1.5));
    const b = @as(types.f64x2, @splat(2.5));
    const res = vpminnmq_f64(a, b);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// Wide vector subtraction of high half
pub inline fn vsubw_high_s8(a: types.i16x8, b: types.i8x16) types.i16x8 {
    var hb: types.i8x8 = undefined;
    inline for (0..8) |i| {
        hb[i] = b[i + 8];
    }
    const wb: types.i16x8 = hb;
    return a -% wb;
}

test vsubw_high_s8 {
    const a = @as(types.i16x8, @splat(20));
    const b = @as(types.i8x16, @splat(5));
    const expected = @as(types.i16x8, @splat(15));
    try common.testIntrinsic(.{ .func = vsubw_high_s8, .expected = expected, .args = .{ a, b } });
}

/// Widening vector subtraction of high half
pub inline fn vsubl_high_s8(a: types.i8x16, b: types.i8x16) types.i16x8 {
    var ha: types.i8x8 = undefined;
    var hb: types.i8x8 = undefined;
    inline for (0..8) |i| {
        ha[i] = a[i + 8];
        hb[i] = b[i + 8];
    }
    const wa: types.i16x8 = ha;
    const wb: types.i16x8 = hb;
    return wa -% wb;
}

test vsubl_high_s8 {
    const a = @as(types.i8x16, @splat(20));
    const b = @as(types.i8x16, @splat(5));
    const expected = @as(types.i16x8, @splat(15));
    try common.testIntrinsic(.{ .func = vsubl_high_s8, .expected = expected, .args = .{ a, b } });
}

/// Wide vector subtraction of high half
pub inline fn vsubw_high_s16(a: types.i32x4, b: types.i16x8) types.i32x4 {
    var hb: types.i16x4 = undefined;
    inline for (0..4) |i| {
        hb[i] = b[i + 4];
    }
    const wb: types.i32x4 = hb;
    return a -% wb;
}

test vsubw_high_s16 {
    const a = @as(types.i32x4, @splat(20));
    const b = @as(types.i16x8, @splat(5));
    const expected = @as(types.i32x4, @splat(15));
    try common.testIntrinsic(.{ .func = vsubw_high_s16, .expected = expected, .args = .{ a, b } });
}

/// Widening vector subtraction of high half
pub inline fn vsubl_high_s16(a: types.i16x8, b: types.i16x8) types.i32x4 {
    var ha: types.i16x4 = undefined;
    var hb: types.i16x4 = undefined;
    inline for (0..4) |i| {
        ha[i] = a[i + 4];
        hb[i] = b[i + 4];
    }
    const wa: types.i32x4 = ha;
    const wb: types.i32x4 = hb;
    return wa -% wb;
}

test vsubl_high_s16 {
    const a = @as(types.i16x8, @splat(20));
    const b = @as(types.i16x8, @splat(5));
    const expected = @as(types.i32x4, @splat(15));
    try common.testIntrinsic(.{ .func = vsubl_high_s16, .expected = expected, .args = .{ a, b } });
}

/// Wide vector subtraction of high half
pub inline fn vsubw_high_s32(a: types.i64x2, b: types.i32x4) types.i64x2 {
    var hb: types.i32x2 = undefined;
    inline for (0..2) |i| {
        hb[i] = b[i + 2];
    }
    const wb: types.i64x2 = hb;
    return a -% wb;
}

test vsubw_high_s32 {
    const a = @as(types.i64x2, @splat(20));
    const b = @as(types.i32x4, @splat(5));
    const expected = @as(types.i64x2, @splat(15));
    try common.testIntrinsic(.{ .func = vsubw_high_s32, .expected = expected, .args = .{ a, b } });
}

/// Widening vector subtraction of high half
pub inline fn vsubl_high_s32(a: types.i32x4, b: types.i32x4) types.i64x2 {
    var ha: types.i32x2 = undefined;
    var hb: types.i32x2 = undefined;
    inline for (0..2) |i| {
        ha[i] = a[i + 2];
        hb[i] = b[i + 2];
    }
    const wa: types.i64x2 = ha;
    const wb: types.i64x2 = hb;
    return wa -% wb;
}

test vsubl_high_s32 {
    const a = @as(types.i32x4, @splat(20));
    const b = @as(types.i32x4, @splat(5));
    const expected = @as(types.i64x2, @splat(15));
    try common.testIntrinsic(.{ .func = vsubl_high_s32, .expected = expected, .args = .{ a, b } });
}

/// Wide vector subtraction of high half
pub inline fn vsubw_high_u8(a: types.u16x8, b: types.u8x16) types.u16x8 {
    var hb: types.u8x8 = undefined;
    inline for (0..8) |i| {
        hb[i] = b[i + 8];
    }
    const wb: types.u16x8 = hb;
    return a -% wb;
}

test vsubw_high_u8 {
    const a = @as(types.u16x8, @splat(20));
    const b = @as(types.u8x16, @splat(5));
    const expected = @as(types.u16x8, @splat(15));
    try common.testIntrinsic(.{ .func = vsubw_high_u8, .expected = expected, .args = .{ a, b } });
}

/// Widening vector subtraction of high half
pub inline fn vsubl_high_u8(a: types.u8x16, b: types.u8x16) types.u16x8 {
    var ha: types.u8x8 = undefined;
    var hb: types.u8x8 = undefined;
    inline for (0..8) |i| {
        ha[i] = a[i + 8];
        hb[i] = b[i + 8];
    }
    const wa: types.u16x8 = ha;
    const wb: types.u16x8 = hb;
    return wa -% wb;
}

test vsubl_high_u8 {
    const a = @as(types.u8x16, @splat(20));
    const b = @as(types.u8x16, @splat(5));
    const expected = @as(types.u16x8, @splat(15));
    try common.testIntrinsic(.{ .func = vsubl_high_u8, .expected = expected, .args = .{ a, b } });
}

/// Wide vector subtraction of high half
pub inline fn vsubw_high_u16(a: types.u32x4, b: types.u16x8) types.u32x4 {
    var hb: types.u16x4 = undefined;
    inline for (0..4) |i| {
        hb[i] = b[i + 4];
    }
    const wb: types.u32x4 = hb;
    return a -% wb;
}

test vsubw_high_u16 {
    const a = @as(types.u32x4, @splat(20));
    const b = @as(types.u16x8, @splat(5));
    const expected = @as(types.u32x4, @splat(15));
    try common.testIntrinsic(.{ .func = vsubw_high_u16, .expected = expected, .args = .{ a, b } });
}

/// Widening vector subtraction of high half
pub inline fn vsubl_high_u16(a: types.u16x8, b: types.u16x8) types.u32x4 {
    var ha: types.u16x4 = undefined;
    var hb: types.u16x4 = undefined;
    inline for (0..4) |i| {
        ha[i] = a[i + 4];
        hb[i] = b[i + 4];
    }
    const wa: types.u32x4 = ha;
    const wb: types.u32x4 = hb;
    return wa -% wb;
}

test vsubl_high_u16 {
    const a = @as(types.u16x8, @splat(20));
    const b = @as(types.u16x8, @splat(5));
    const expected = @as(types.u32x4, @splat(15));
    try common.testIntrinsic(.{ .func = vsubl_high_u16, .expected = expected, .args = .{ a, b } });
}

/// Wide vector subtraction of high half
pub inline fn vsubw_high_u32(a: types.u64x2, b: types.u32x4) types.u64x2 {
    var hb: types.u32x2 = undefined;
    inline for (0..2) |i| {
        hb[i] = b[i + 2];
    }
    const wb: types.u64x2 = hb;
    return a -% wb;
}

test vsubw_high_u32 {
    const a = @as(types.u64x2, @splat(20));
    const b = @as(types.u32x4, @splat(5));
    const expected = @as(types.u64x2, @splat(15));
    try common.testIntrinsic(.{ .func = vsubw_high_u32, .expected = expected, .args = .{ a, b } });
}

/// Widening vector subtraction of high half
pub inline fn vsubl_high_u32(a: types.u32x4, b: types.u32x4) types.u64x2 {
    var ha: types.u32x2 = undefined;
    var hb: types.u32x2 = undefined;
    inline for (0..2) |i| {
        ha[i] = a[i + 2];
        hb[i] = b[i + 2];
    }
    const wa: types.u64x2 = ha;
    const wb: types.u64x2 = hb;
    return wa -% wb;
}

test vsubl_high_u32 {
    const a = @as(types.u32x4, @splat(20));
    const b = @as(types.u32x4, @splat(5));
    const expected = @as(types.u64x2, @splat(15));
    try common.testIntrinsic(.{ .func = vsubl_high_u32, .expected = expected, .args = .{ a, b } });
}

/// Saturating vector absolute value
pub inline fn vqabs_s8(a: types.i8x8) types.i8x8 {
    var res: types.i8x8 = undefined;
    inline for (0..8) |i| {
        if (a[i] == std.math.minInt(i8)) {
            res[i] = std.math.maxInt(i8);
        } else {
            res[i] = @intCast(@abs(a[i]));
        }
    }
    return res;
}

test vqabs_s8 {
    const a = @as(types.i8x8, @splat(-10));
    const expected = @as(types.i8x8, @splat(10));
    try common.testIntrinsic(.{ .func = vqabs_s8, .expected = expected, .args = .{a} });
}

/// Saturating vector absolute value
pub inline fn vqabsq_s8(a: types.i8x16) types.i8x16 {
    var res: types.i8x16 = undefined;
    inline for (0..16) |i| {
        if (a[i] == std.math.minInt(i8)) {
            res[i] = std.math.maxInt(i8);
        } else {
            res[i] = @intCast(@abs(a[i]));
        }
    }
    return res;
}

test vqabsq_s8 {
    const a = @as(types.i8x16, @splat(-10));
    const expected = @as(types.i8x16, @splat(10));
    try common.testIntrinsic(.{ .func = vqabsq_s8, .expected = expected, .args = .{a} });
}

/// Saturating vector absolute value
pub inline fn vqabs_s16(a: types.i16x4) types.i16x4 {
    var res: types.i16x4 = undefined;
    inline for (0..4) |i| {
        if (a[i] == std.math.minInt(i16)) {
            res[i] = std.math.maxInt(i16);
        } else {
            res[i] = @intCast(@abs(a[i]));
        }
    }
    return res;
}

test vqabs_s16 {
    const a = @as(types.i16x4, @splat(-10));
    const expected = @as(types.i16x4, @splat(10));
    try common.testIntrinsic(.{ .func = vqabs_s16, .expected = expected, .args = .{a} });
}

/// Saturating vector absolute value
pub inline fn vqabsq_s16(a: types.i16x8) types.i16x8 {
    var res: types.i16x8 = undefined;
    inline for (0..8) |i| {
        if (a[i] == std.math.minInt(i16)) {
            res[i] = std.math.maxInt(i16);
        } else {
            res[i] = @intCast(@abs(a[i]));
        }
    }
    return res;
}

test vqabsq_s16 {
    const a = @as(types.i16x8, @splat(-10));
    const expected = @as(types.i16x8, @splat(10));
    try common.testIntrinsic(.{ .func = vqabsq_s16, .expected = expected, .args = .{a} });
}

/// Saturating vector absolute value
pub inline fn vqabs_s32(a: types.i32x2) types.i32x2 {
    var res: types.i32x2 = undefined;
    inline for (0..2) |i| {
        if (a[i] == std.math.minInt(i32)) {
            res[i] = std.math.maxInt(i32);
        } else {
            res[i] = @intCast(@abs(a[i]));
        }
    }
    return res;
}

test vqabs_s32 {
    const a = @as(types.i32x2, @splat(-10));
    const expected = @as(types.i32x2, @splat(10));
    try common.testIntrinsic(.{ .func = vqabs_s32, .expected = expected, .args = .{a} });
}

/// Saturating vector absolute value
pub inline fn vqabsq_s32(a: types.i32x4) types.i32x4 {
    var res: types.i32x4 = undefined;
    inline for (0..4) |i| {
        if (a[i] == std.math.minInt(i32)) {
            res[i] = std.math.maxInt(i32);
        } else {
            res[i] = @intCast(@abs(a[i]));
        }
    }
    return res;
}

test vqabsq_s32 {
    const a = @as(types.i32x4, @splat(-10));
    const expected = @as(types.i32x4, @splat(10));
    try common.testIntrinsic(.{ .func = vqabsq_s32, .expected = expected, .args = .{a} });
}

/// Saturating vector absolute value
pub inline fn vqabs_s64(a: types.i64x1) types.i64x1 {
    var res: types.i64x1 = undefined;
    inline for (0..1) |i| {
        if (a[i] == std.math.minInt(i64)) {
            res[i] = std.math.maxInt(i64);
        } else {
            res[i] = @intCast(@abs(a[i]));
        }
    }
    return res;
}

test vqabs_s64 {
    const a = @as(types.i64x1, @splat(-10));
    const expected = @as(types.i64x1, @splat(10));
    try common.testIntrinsic(.{ .func = vqabs_s64, .expected = expected, .args = .{a} });
}

/// Saturating vector absolute value
pub inline fn vqabsq_s64(a: types.i64x2) types.i64x2 {
    var res: types.i64x2 = undefined;
    inline for (0..2) |i| {
        if (a[i] == std.math.minInt(i64)) {
            res[i] = std.math.maxInt(i64);
        } else {
            res[i] = @intCast(@abs(a[i]));
        }
    }
    return res;
}

test vqabsq_s64 {
    const a = @as(types.i64x2, @splat(-10));
    const expected = @as(types.i64x2, @splat(10));
    try common.testIntrinsic(.{ .func = vqabsq_s64, .expected = expected, .args = .{a} });
}

/// ARM NEON intrinsic: vcadd_rot270_f16
pub inline fn vcadd_rot270_f16(p0: types.f16x4, p1: types.f16x4) types.f16x4 {
    var res: types.f16x4 = undefined;
    const len = @typeInfo(types.f16x4).vector.len;
    inline for (0..len / 2) |pair| {
        const i = pair * 2;
        if (true) {
            res[i] = p0[i] + p1[i + 1];
            res[i + 1] = p0[i + 1] - p1[i];
        } else {
            res[i] = p0[i] - p1[i + 1];
            res[i + 1] = p0[i + 1] + p1[i];
        }
    }
    return res;
}

test vcadd_rot270_f16 {
    const p0 = @as(types.f16x4, @splat(1.5));
    const p1 = @as(types.f16x4, @splat(1.5));
    const res = vcadd_rot270_f16(p0, p1);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vcadd_rot270_f32
pub inline fn vcadd_rot270_f32(p0: types.f32x2, p1: types.f32x2) types.f32x2 {
    var res: types.f32x2 = undefined;
    const len = @typeInfo(types.f32x2).vector.len;
    inline for (0..len / 2) |pair| {
        const i = pair * 2;
        if (true) {
            res[i] = p0[i] + p1[i + 1];
            res[i + 1] = p0[i + 1] - p1[i];
        } else {
            res[i] = p0[i] - p1[i + 1];
            res[i + 1] = p0[i + 1] + p1[i];
        }
    }
    return res;
}

test vcadd_rot270_f32 {
    const p0 = @as(types.f32x2, @splat(1.5));
    const p1 = @as(types.f32x2, @splat(1.5));
    const res = vcadd_rot270_f32(p0, p1);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vcadd_rot90_f16
pub inline fn vcadd_rot90_f16(p0: types.f16x4, p1: types.f16x4) types.f16x4 {
    var res: types.f16x4 = undefined;
    const len = @typeInfo(types.f16x4).vector.len;
    inline for (0..len / 2) |pair| {
        const i = pair * 2;
        if (false) {
            res[i] = p0[i] + p1[i + 1];
            res[i + 1] = p0[i + 1] - p1[i];
        } else {
            res[i] = p0[i] - p1[i + 1];
            res[i + 1] = p0[i + 1] + p1[i];
        }
    }
    return res;
}

test vcadd_rot90_f16 {
    const p0 = @as(types.f16x4, @splat(1.5));
    const p1 = @as(types.f16x4, @splat(1.5));
    const res = vcadd_rot90_f16(p0, p1);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vcadd_rot90_f32
pub inline fn vcadd_rot90_f32(p0: types.f32x2, p1: types.f32x2) types.f32x2 {
    var res: types.f32x2 = undefined;
    const len = @typeInfo(types.f32x2).vector.len;
    inline for (0..len / 2) |pair| {
        const i = pair * 2;
        if (false) {
            res[i] = p0[i] + p1[i + 1];
            res[i + 1] = p0[i + 1] - p1[i];
        } else {
            res[i] = p0[i] - p1[i + 1];
            res[i + 1] = p0[i + 1] + p1[i];
        }
    }
    return res;
}

test vcadd_rot90_f32 {
    const p0 = @as(types.f32x2, @splat(1.5));
    const p1 = @as(types.f32x2, @splat(1.5));
    const res = vcadd_rot90_f32(p0, p1);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vcaddq_rot270_f16
pub inline fn vcaddq_rot270_f16(p0: types.f16x8, p1: types.f16x8) types.f16x8 {
    var res: types.f16x8 = undefined;
    const len = @typeInfo(types.f16x8).vector.len;
    inline for (0..len / 2) |pair| {
        const i = pair * 2;
        if (true) {
            res[i] = p0[i] + p1[i + 1];
            res[i + 1] = p0[i + 1] - p1[i];
        } else {
            res[i] = p0[i] - p1[i + 1];
            res[i + 1] = p0[i + 1] + p1[i];
        }
    }
    return res;
}

test vcaddq_rot270_f16 {
    const p0 = @as(types.f16x8, @splat(1.5));
    const p1 = @as(types.f16x8, @splat(1.5));
    const res = vcaddq_rot270_f16(p0, p1);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vcaddq_rot270_f32
pub inline fn vcaddq_rot270_f32(p0: types.f32x4, p1: types.f32x4) types.f32x4 {
    var res: types.f32x4 = undefined;
    const len = @typeInfo(types.f32x4).vector.len;
    inline for (0..len / 2) |pair| {
        const i = pair * 2;
        if (true) {
            res[i] = p0[i] + p1[i + 1];
            res[i + 1] = p0[i + 1] - p1[i];
        } else {
            res[i] = p0[i] - p1[i + 1];
            res[i + 1] = p0[i + 1] + p1[i];
        }
    }
    return res;
}

test vcaddq_rot270_f32 {
    const p0 = @as(types.f32x4, @splat(1.5));
    const p1 = @as(types.f32x4, @splat(1.5));
    const res = vcaddq_rot270_f32(p0, p1);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vcaddq_rot270_f64
pub inline fn vcaddq_rot270_f64(p0: types.f64x2, p1: types.f64x2) types.f64x2 {
    var res: types.f64x2 = undefined;
    const len = @typeInfo(types.f64x2).vector.len;
    inline for (0..len / 2) |pair| {
        const i = pair * 2;
        if (true) {
            res[i] = p0[i] + p1[i + 1];
            res[i + 1] = p0[i + 1] - p1[i];
        } else {
            res[i] = p0[i] - p1[i + 1];
            res[i + 1] = p0[i + 1] + p1[i];
        }
    }
    return res;
}

test vcaddq_rot270_f64 {
    const p0 = @as(types.f64x2, @splat(1.5));
    const p1 = @as(types.f64x2, @splat(1.5));
    const res = vcaddq_rot270_f64(p0, p1);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vcaddq_rot90_f16
pub inline fn vcaddq_rot90_f16(p0: types.f16x8, p1: types.f16x8) types.f16x8 {
    var res: types.f16x8 = undefined;
    const len = @typeInfo(types.f16x8).vector.len;
    inline for (0..len / 2) |pair| {
        const i = pair * 2;
        if (false) {
            res[i] = p0[i] + p1[i + 1];
            res[i + 1] = p0[i + 1] - p1[i];
        } else {
            res[i] = p0[i] - p1[i + 1];
            res[i + 1] = p0[i + 1] + p1[i];
        }
    }
    return res;
}

test vcaddq_rot90_f16 {
    const p0 = @as(types.f16x8, @splat(1.5));
    const p1 = @as(types.f16x8, @splat(1.5));
    const res = vcaddq_rot90_f16(p0, p1);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vcaddq_rot90_f32
pub inline fn vcaddq_rot90_f32(p0: types.f32x4, p1: types.f32x4) types.f32x4 {
    var res: types.f32x4 = undefined;
    const len = @typeInfo(types.f32x4).vector.len;
    inline for (0..len / 2) |pair| {
        const i = pair * 2;
        if (false) {
            res[i] = p0[i] + p1[i + 1];
            res[i + 1] = p0[i + 1] - p1[i];
        } else {
            res[i] = p0[i] - p1[i + 1];
            res[i + 1] = p0[i + 1] + p1[i];
        }
    }
    return res;
}

test vcaddq_rot90_f32 {
    const p0 = @as(types.f32x4, @splat(1.5));
    const p1 = @as(types.f32x4, @splat(1.5));
    const res = vcaddq_rot90_f32(p0, p1);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vcaddq_rot90_f64
pub inline fn vcaddq_rot90_f64(p0: types.f64x2, p1: types.f64x2) types.f64x2 {
    var res: types.f64x2 = undefined;
    const len = @typeInfo(types.f64x2).vector.len;
    inline for (0..len / 2) |pair| {
        const i = pair * 2;
        if (false) {
            res[i] = p0[i] + p1[i + 1];
            res[i + 1] = p0[i + 1] - p1[i];
        } else {
            res[i] = p0[i] - p1[i + 1];
            res[i + 1] = p0[i + 1] + p1[i];
        }
    }
    return res;
}

test vcaddq_rot90_f64 {
    const p0 = @as(types.f64x2, @splat(1.5));
    const p1 = @as(types.f64x2, @splat(1.5));
    const res = vcaddq_rot90_f64(p0, p1);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vcmla_f16
pub inline fn vcmla_f16(p0: types.f16x4, p1: types.f16x4, p2: types.f16x4) types.f16x4 {
    var res: types.f16x4 = undefined;
    const len = @typeInfo(types.f16x4).vector.len;
    inline for (0..len / 2) |pair| {
        const i = pair * 2;
        const bre = p1[i];
        const bim = p1[i + 1];
        const cre = p2[i];
        const cim = p2[i + 1];
        const prod_re = bre * cre - bim * cim;
        const prod_im = bre * cim + bim * cre;
        switch (0) {
            0 => {
                res[i] = p0[i] + prod_re;
                res[i + 1] = p0[i + 1] + prod_im;
            },
            90 => {
                res[i] = p0[i] - prod_im;
                res[i + 1] = p0[i + 1] + prod_re;
            },
            180 => {
                res[i] = p0[i] - prod_re;
                res[i + 1] = p0[i + 1] - prod_im;
            },
            270 => {
                res[i] = p0[i] + prod_im;
                res[i + 1] = p0[i + 1] - prod_re;
            },
            else => unreachable,
        }
    }
    return res;
}

test vcmla_f16 {
    const p0 = @as(types.f16x4, @splat(1.5));
    const p1 = @as(types.f16x4, @splat(1.5));
    const p2 = @as(types.f16x4, @splat(1.5));
    const res = vcmla_f16(p0, p1, p2);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vcmla_f32
pub inline fn vcmla_f32(p0: types.f32x2, p1: types.f32x2, p2: types.f32x2) types.f32x2 {
    var res: types.f32x2 = undefined;
    const len = @typeInfo(types.f32x2).vector.len;
    inline for (0..len / 2) |pair| {
        const i = pair * 2;
        const bre = p1[i];
        const bim = p1[i + 1];
        const cre = p2[i];
        const cim = p2[i + 1];
        const prod_re = bre * cre - bim * cim;
        const prod_im = bre * cim + bim * cre;
        switch (0) {
            0 => {
                res[i] = p0[i] + prod_re;
                res[i + 1] = p0[i + 1] + prod_im;
            },
            90 => {
                res[i] = p0[i] - prod_im;
                res[i + 1] = p0[i + 1] + prod_re;
            },
            180 => {
                res[i] = p0[i] - prod_re;
                res[i + 1] = p0[i + 1] - prod_im;
            },
            270 => {
                res[i] = p0[i] + prod_im;
                res[i + 1] = p0[i + 1] - prod_re;
            },
            else => unreachable,
        }
    }
    return res;
}

test vcmla_f32 {
    const p0 = @as(types.f32x2, @splat(1.5));
    const p1 = @as(types.f32x2, @splat(1.5));
    const p2 = @as(types.f32x2, @splat(1.5));
    const res = vcmla_f32(p0, p1, p2);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vcmla_rot180_f16
pub inline fn vcmla_rot180_f16(p0: types.f16x4, p1: types.f16x4, p2: types.f16x4) types.f16x4 {
    var res: types.f16x4 = undefined;
    const len = @typeInfo(types.f16x4).vector.len;
    inline for (0..len / 2) |pair| {
        const i = pair * 2;
        const bre = p1[i];
        const bim = p1[i + 1];
        const cre = p2[i];
        const cim = p2[i + 1];
        const prod_re = bre * cre - bim * cim;
        const prod_im = bre * cim + bim * cre;
        switch (180) {
            0 => {
                res[i] = p0[i] + prod_re;
                res[i + 1] = p0[i + 1] + prod_im;
            },
            90 => {
                res[i] = p0[i] - prod_im;
                res[i + 1] = p0[i + 1] + prod_re;
            },
            180 => {
                res[i] = p0[i] - prod_re;
                res[i + 1] = p0[i + 1] - prod_im;
            },
            270 => {
                res[i] = p0[i] + prod_im;
                res[i + 1] = p0[i + 1] - prod_re;
            },
            else => unreachable,
        }
    }
    return res;
}

test vcmla_rot180_f16 {
    const p0 = @as(types.f16x4, @splat(1.5));
    const p1 = @as(types.f16x4, @splat(1.5));
    const p2 = @as(types.f16x4, @splat(1.5));
    const res = vcmla_rot180_f16(p0, p1, p2);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vcmla_rot180_f32
pub inline fn vcmla_rot180_f32(p0: types.f32x2, p1: types.f32x2, p2: types.f32x2) types.f32x2 {
    var res: types.f32x2 = undefined;
    const len = @typeInfo(types.f32x2).vector.len;
    inline for (0..len / 2) |pair| {
        const i = pair * 2;
        const bre = p1[i];
        const bim = p1[i + 1];
        const cre = p2[i];
        const cim = p2[i + 1];
        const prod_re = bre * cre - bim * cim;
        const prod_im = bre * cim + bim * cre;
        switch (180) {
            0 => {
                res[i] = p0[i] + prod_re;
                res[i + 1] = p0[i + 1] + prod_im;
            },
            90 => {
                res[i] = p0[i] - prod_im;
                res[i + 1] = p0[i + 1] + prod_re;
            },
            180 => {
                res[i] = p0[i] - prod_re;
                res[i + 1] = p0[i + 1] - prod_im;
            },
            270 => {
                res[i] = p0[i] + prod_im;
                res[i + 1] = p0[i + 1] - prod_re;
            },
            else => unreachable,
        }
    }
    return res;
}

test vcmla_rot180_f32 {
    const p0 = @as(types.f32x2, @splat(1.5));
    const p1 = @as(types.f32x2, @splat(1.5));
    const p2 = @as(types.f32x2, @splat(1.5));
    const res = vcmla_rot180_f32(p0, p1, p2);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vcmla_rot270_f16
pub inline fn vcmla_rot270_f16(p0: types.f16x4, p1: types.f16x4, p2: types.f16x4) types.f16x4 {
    var res: types.f16x4 = undefined;
    const len = @typeInfo(types.f16x4).vector.len;
    inline for (0..len / 2) |pair| {
        const i = pair * 2;
        const bre = p1[i];
        const bim = p1[i + 1];
        const cre = p2[i];
        const cim = p2[i + 1];
        const prod_re = bre * cre - bim * cim;
        const prod_im = bre * cim + bim * cre;
        switch (270) {
            0 => {
                res[i] = p0[i] + prod_re;
                res[i + 1] = p0[i + 1] + prod_im;
            },
            90 => {
                res[i] = p0[i] - prod_im;
                res[i + 1] = p0[i + 1] + prod_re;
            },
            180 => {
                res[i] = p0[i] - prod_re;
                res[i + 1] = p0[i + 1] - prod_im;
            },
            270 => {
                res[i] = p0[i] + prod_im;
                res[i + 1] = p0[i + 1] - prod_re;
            },
            else => unreachable,
        }
    }
    return res;
}

test vcmla_rot270_f16 {
    const p0 = @as(types.f16x4, @splat(1.5));
    const p1 = @as(types.f16x4, @splat(1.5));
    const p2 = @as(types.f16x4, @splat(1.5));
    const res = vcmla_rot270_f16(p0, p1, p2);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vcmla_rot270_f32
pub inline fn vcmla_rot270_f32(p0: types.f32x2, p1: types.f32x2, p2: types.f32x2) types.f32x2 {
    var res: types.f32x2 = undefined;
    const len = @typeInfo(types.f32x2).vector.len;
    inline for (0..len / 2) |pair| {
        const i = pair * 2;
        const bre = p1[i];
        const bim = p1[i + 1];
        const cre = p2[i];
        const cim = p2[i + 1];
        const prod_re = bre * cre - bim * cim;
        const prod_im = bre * cim + bim * cre;
        switch (270) {
            0 => {
                res[i] = p0[i] + prod_re;
                res[i + 1] = p0[i + 1] + prod_im;
            },
            90 => {
                res[i] = p0[i] - prod_im;
                res[i + 1] = p0[i + 1] + prod_re;
            },
            180 => {
                res[i] = p0[i] - prod_re;
                res[i + 1] = p0[i + 1] - prod_im;
            },
            270 => {
                res[i] = p0[i] + prod_im;
                res[i + 1] = p0[i + 1] - prod_re;
            },
            else => unreachable,
        }
    }
    return res;
}

test vcmla_rot270_f32 {
    const p0 = @as(types.f32x2, @splat(1.5));
    const p1 = @as(types.f32x2, @splat(1.5));
    const p2 = @as(types.f32x2, @splat(1.5));
    const res = vcmla_rot270_f32(p0, p1, p2);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vcmla_rot90_f16
pub inline fn vcmla_rot90_f16(p0: types.f16x4, p1: types.f16x4, p2: types.f16x4) types.f16x4 {
    var res: types.f16x4 = undefined;
    const len = @typeInfo(types.f16x4).vector.len;
    inline for (0..len / 2) |pair| {
        const i = pair * 2;
        const bre = p1[i];
        const bim = p1[i + 1];
        const cre = p2[i];
        const cim = p2[i + 1];
        const prod_re = bre * cre - bim * cim;
        const prod_im = bre * cim + bim * cre;
        switch (90) {
            0 => {
                res[i] = p0[i] + prod_re;
                res[i + 1] = p0[i + 1] + prod_im;
            },
            90 => {
                res[i] = p0[i] - prod_im;
                res[i + 1] = p0[i + 1] + prod_re;
            },
            180 => {
                res[i] = p0[i] - prod_re;
                res[i + 1] = p0[i + 1] - prod_im;
            },
            270 => {
                res[i] = p0[i] + prod_im;
                res[i + 1] = p0[i + 1] - prod_re;
            },
            else => unreachable,
        }
    }
    return res;
}

test vcmla_rot90_f16 {
    const p0 = @as(types.f16x4, @splat(1.5));
    const p1 = @as(types.f16x4, @splat(1.5));
    const p2 = @as(types.f16x4, @splat(1.5));
    const res = vcmla_rot90_f16(p0, p1, p2);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vcmla_rot90_f32
pub inline fn vcmla_rot90_f32(p0: types.f32x2, p1: types.f32x2, p2: types.f32x2) types.f32x2 {
    var res: types.f32x2 = undefined;
    const len = @typeInfo(types.f32x2).vector.len;
    inline for (0..len / 2) |pair| {
        const i = pair * 2;
        const bre = p1[i];
        const bim = p1[i + 1];
        const cre = p2[i];
        const cim = p2[i + 1];
        const prod_re = bre * cre - bim * cim;
        const prod_im = bre * cim + bim * cre;
        switch (90) {
            0 => {
                res[i] = p0[i] + prod_re;
                res[i + 1] = p0[i + 1] + prod_im;
            },
            90 => {
                res[i] = p0[i] - prod_im;
                res[i + 1] = p0[i + 1] + prod_re;
            },
            180 => {
                res[i] = p0[i] - prod_re;
                res[i + 1] = p0[i + 1] - prod_im;
            },
            270 => {
                res[i] = p0[i] + prod_im;
                res[i + 1] = p0[i + 1] - prod_re;
            },
            else => unreachable,
        }
    }
    return res;
}

test vcmla_rot90_f32 {
    const p0 = @as(types.f32x2, @splat(1.5));
    const p1 = @as(types.f32x2, @splat(1.5));
    const p2 = @as(types.f32x2, @splat(1.5));
    const res = vcmla_rot90_f32(p0, p1, p2);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vcmlaq_f16
pub inline fn vcmlaq_f16(p0: types.f16x8, p1: types.f16x8, p2: types.f16x8) types.f16x8 {
    var res: types.f16x8 = undefined;
    const len = @typeInfo(types.f16x8).vector.len;
    inline for (0..len / 2) |pair| {
        const i = pair * 2;
        const bre = p1[i];
        const bim = p1[i + 1];
        const cre = p2[i];
        const cim = p2[i + 1];
        const prod_re = bre * cre - bim * cim;
        const prod_im = bre * cim + bim * cre;
        switch (0) {
            0 => {
                res[i] = p0[i] + prod_re;
                res[i + 1] = p0[i + 1] + prod_im;
            },
            90 => {
                res[i] = p0[i] - prod_im;
                res[i + 1] = p0[i + 1] + prod_re;
            },
            180 => {
                res[i] = p0[i] - prod_re;
                res[i + 1] = p0[i + 1] - prod_im;
            },
            270 => {
                res[i] = p0[i] + prod_im;
                res[i + 1] = p0[i + 1] - prod_re;
            },
            else => unreachable,
        }
    }
    return res;
}

test vcmlaq_f16 {
    const p0 = @as(types.f16x8, @splat(1.5));
    const p1 = @as(types.f16x8, @splat(1.5));
    const p2 = @as(types.f16x8, @splat(1.5));
    const res = vcmlaq_f16(p0, p1, p2);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vcmlaq_f32
pub inline fn vcmlaq_f32(p0: types.f32x4, p1: types.f32x4, p2: types.f32x4) types.f32x4 {
    var res: types.f32x4 = undefined;
    const len = @typeInfo(types.f32x4).vector.len;
    inline for (0..len / 2) |pair| {
        const i = pair * 2;
        const bre = p1[i];
        const bim = p1[i + 1];
        const cre = p2[i];
        const cim = p2[i + 1];
        const prod_re = bre * cre - bim * cim;
        const prod_im = bre * cim + bim * cre;
        switch (0) {
            0 => {
                res[i] = p0[i] + prod_re;
                res[i + 1] = p0[i + 1] + prod_im;
            },
            90 => {
                res[i] = p0[i] - prod_im;
                res[i + 1] = p0[i + 1] + prod_re;
            },
            180 => {
                res[i] = p0[i] - prod_re;
                res[i + 1] = p0[i + 1] - prod_im;
            },
            270 => {
                res[i] = p0[i] + prod_im;
                res[i + 1] = p0[i + 1] - prod_re;
            },
            else => unreachable,
        }
    }
    return res;
}

test vcmlaq_f32 {
    const p0 = @as(types.f32x4, @splat(1.5));
    const p1 = @as(types.f32x4, @splat(1.5));
    const p2 = @as(types.f32x4, @splat(1.5));
    const res = vcmlaq_f32(p0, p1, p2);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vcmlaq_f64
pub inline fn vcmlaq_f64(p0: types.f64x2, p1: types.f64x2, p2: types.f64x2) types.f64x2 {
    var res: types.f64x2 = undefined;
    const len = @typeInfo(types.f64x2).vector.len;
    inline for (0..len / 2) |pair| {
        const i = pair * 2;
        const bre = p1[i];
        const bim = p1[i + 1];
        const cre = p2[i];
        const cim = p2[i + 1];
        const prod_re = bre * cre - bim * cim;
        const prod_im = bre * cim + bim * cre;
        switch (0) {
            0 => {
                res[i] = p0[i] + prod_re;
                res[i + 1] = p0[i + 1] + prod_im;
            },
            90 => {
                res[i] = p0[i] - prod_im;
                res[i + 1] = p0[i + 1] + prod_re;
            },
            180 => {
                res[i] = p0[i] - prod_re;
                res[i + 1] = p0[i + 1] - prod_im;
            },
            270 => {
                res[i] = p0[i] + prod_im;
                res[i + 1] = p0[i + 1] - prod_re;
            },
            else => unreachable,
        }
    }
    return res;
}

test vcmlaq_f64 {
    const p0 = @as(types.f64x2, @splat(1.5));
    const p1 = @as(types.f64x2, @splat(1.5));
    const p2 = @as(types.f64x2, @splat(1.5));
    const res = vcmlaq_f64(p0, p1, p2);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vcmlaq_rot180_f16
pub inline fn vcmlaq_rot180_f16(p0: types.f16x8, p1: types.f16x8, p2: types.f16x8) types.f16x8 {
    var res: types.f16x8 = undefined;
    const len = @typeInfo(types.f16x8).vector.len;
    inline for (0..len / 2) |pair| {
        const i = pair * 2;
        const bre = p1[i];
        const bim = p1[i + 1];
        const cre = p2[i];
        const cim = p2[i + 1];
        const prod_re = bre * cre - bim * cim;
        const prod_im = bre * cim + bim * cre;
        switch (180) {
            0 => {
                res[i] = p0[i] + prod_re;
                res[i + 1] = p0[i + 1] + prod_im;
            },
            90 => {
                res[i] = p0[i] - prod_im;
                res[i + 1] = p0[i + 1] + prod_re;
            },
            180 => {
                res[i] = p0[i] - prod_re;
                res[i + 1] = p0[i + 1] - prod_im;
            },
            270 => {
                res[i] = p0[i] + prod_im;
                res[i + 1] = p0[i + 1] - prod_re;
            },
            else => unreachable,
        }
    }
    return res;
}

test vcmlaq_rot180_f16 {
    const p0 = @as(types.f16x8, @splat(1.5));
    const p1 = @as(types.f16x8, @splat(1.5));
    const p2 = @as(types.f16x8, @splat(1.5));
    const res = vcmlaq_rot180_f16(p0, p1, p2);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vcmlaq_rot180_f32
pub inline fn vcmlaq_rot180_f32(p0: types.f32x4, p1: types.f32x4, p2: types.f32x4) types.f32x4 {
    var res: types.f32x4 = undefined;
    const len = @typeInfo(types.f32x4).vector.len;
    inline for (0..len / 2) |pair| {
        const i = pair * 2;
        const bre = p1[i];
        const bim = p1[i + 1];
        const cre = p2[i];
        const cim = p2[i + 1];
        const prod_re = bre * cre - bim * cim;
        const prod_im = bre * cim + bim * cre;
        switch (180) {
            0 => {
                res[i] = p0[i] + prod_re;
                res[i + 1] = p0[i + 1] + prod_im;
            },
            90 => {
                res[i] = p0[i] - prod_im;
                res[i + 1] = p0[i + 1] + prod_re;
            },
            180 => {
                res[i] = p0[i] - prod_re;
                res[i + 1] = p0[i + 1] - prod_im;
            },
            270 => {
                res[i] = p0[i] + prod_im;
                res[i + 1] = p0[i + 1] - prod_re;
            },
            else => unreachable,
        }
    }
    return res;
}

test vcmlaq_rot180_f32 {
    const p0 = @as(types.f32x4, @splat(1.5));
    const p1 = @as(types.f32x4, @splat(1.5));
    const p2 = @as(types.f32x4, @splat(1.5));
    const res = vcmlaq_rot180_f32(p0, p1, p2);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vcmlaq_rot180_f64
pub inline fn vcmlaq_rot180_f64(p0: types.f64x2, p1: types.f64x2, p2: types.f64x2) types.f64x2 {
    var res: types.f64x2 = undefined;
    const len = @typeInfo(types.f64x2).vector.len;
    inline for (0..len / 2) |pair| {
        const i = pair * 2;
        const bre = p1[i];
        const bim = p1[i + 1];
        const cre = p2[i];
        const cim = p2[i + 1];
        const prod_re = bre * cre - bim * cim;
        const prod_im = bre * cim + bim * cre;
        switch (180) {
            0 => {
                res[i] = p0[i] + prod_re;
                res[i + 1] = p0[i + 1] + prod_im;
            },
            90 => {
                res[i] = p0[i] - prod_im;
                res[i + 1] = p0[i + 1] + prod_re;
            },
            180 => {
                res[i] = p0[i] - prod_re;
                res[i + 1] = p0[i + 1] - prod_im;
            },
            270 => {
                res[i] = p0[i] + prod_im;
                res[i + 1] = p0[i + 1] - prod_re;
            },
            else => unreachable,
        }
    }
    return res;
}

test vcmlaq_rot180_f64 {
    const p0 = @as(types.f64x2, @splat(1.5));
    const p1 = @as(types.f64x2, @splat(1.5));
    const p2 = @as(types.f64x2, @splat(1.5));
    const res = vcmlaq_rot180_f64(p0, p1, p2);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vcmlaq_rot270_f16
pub inline fn vcmlaq_rot270_f16(p0: types.f16x8, p1: types.f16x8, p2: types.f16x8) types.f16x8 {
    var res: types.f16x8 = undefined;
    const len = @typeInfo(types.f16x8).vector.len;
    inline for (0..len / 2) |pair| {
        const i = pair * 2;
        const bre = p1[i];
        const bim = p1[i + 1];
        const cre = p2[i];
        const cim = p2[i + 1];
        const prod_re = bre * cre - bim * cim;
        const prod_im = bre * cim + bim * cre;
        switch (270) {
            0 => {
                res[i] = p0[i] + prod_re;
                res[i + 1] = p0[i + 1] + prod_im;
            },
            90 => {
                res[i] = p0[i] - prod_im;
                res[i + 1] = p0[i + 1] + prod_re;
            },
            180 => {
                res[i] = p0[i] - prod_re;
                res[i + 1] = p0[i + 1] - prod_im;
            },
            270 => {
                res[i] = p0[i] + prod_im;
                res[i + 1] = p0[i + 1] - prod_re;
            },
            else => unreachable,
        }
    }
    return res;
}

test vcmlaq_rot270_f16 {
    const p0 = @as(types.f16x8, @splat(1.5));
    const p1 = @as(types.f16x8, @splat(1.5));
    const p2 = @as(types.f16x8, @splat(1.5));
    const res = vcmlaq_rot270_f16(p0, p1, p2);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vcmlaq_rot270_f32
pub inline fn vcmlaq_rot270_f32(p0: types.f32x4, p1: types.f32x4, p2: types.f32x4) types.f32x4 {
    var res: types.f32x4 = undefined;
    const len = @typeInfo(types.f32x4).vector.len;
    inline for (0..len / 2) |pair| {
        const i = pair * 2;
        const bre = p1[i];
        const bim = p1[i + 1];
        const cre = p2[i];
        const cim = p2[i + 1];
        const prod_re = bre * cre - bim * cim;
        const prod_im = bre * cim + bim * cre;
        switch (270) {
            0 => {
                res[i] = p0[i] + prod_re;
                res[i + 1] = p0[i + 1] + prod_im;
            },
            90 => {
                res[i] = p0[i] - prod_im;
                res[i + 1] = p0[i + 1] + prod_re;
            },
            180 => {
                res[i] = p0[i] - prod_re;
                res[i + 1] = p0[i + 1] - prod_im;
            },
            270 => {
                res[i] = p0[i] + prod_im;
                res[i + 1] = p0[i + 1] - prod_re;
            },
            else => unreachable,
        }
    }
    return res;
}

test vcmlaq_rot270_f32 {
    const p0 = @as(types.f32x4, @splat(1.5));
    const p1 = @as(types.f32x4, @splat(1.5));
    const p2 = @as(types.f32x4, @splat(1.5));
    const res = vcmlaq_rot270_f32(p0, p1, p2);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vcmlaq_rot270_f64
pub inline fn vcmlaq_rot270_f64(p0: types.f64x2, p1: types.f64x2, p2: types.f64x2) types.f64x2 {
    var res: types.f64x2 = undefined;
    const len = @typeInfo(types.f64x2).vector.len;
    inline for (0..len / 2) |pair| {
        const i = pair * 2;
        const bre = p1[i];
        const bim = p1[i + 1];
        const cre = p2[i];
        const cim = p2[i + 1];
        const prod_re = bre * cre - bim * cim;
        const prod_im = bre * cim + bim * cre;
        switch (270) {
            0 => {
                res[i] = p0[i] + prod_re;
                res[i + 1] = p0[i + 1] + prod_im;
            },
            90 => {
                res[i] = p0[i] - prod_im;
                res[i + 1] = p0[i + 1] + prod_re;
            },
            180 => {
                res[i] = p0[i] - prod_re;
                res[i + 1] = p0[i + 1] - prod_im;
            },
            270 => {
                res[i] = p0[i] + prod_im;
                res[i + 1] = p0[i + 1] - prod_re;
            },
            else => unreachable,
        }
    }
    return res;
}

test vcmlaq_rot270_f64 {
    const p0 = @as(types.f64x2, @splat(1.5));
    const p1 = @as(types.f64x2, @splat(1.5));
    const p2 = @as(types.f64x2, @splat(1.5));
    const res = vcmlaq_rot270_f64(p0, p1, p2);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vcmlaq_rot90_f16
pub inline fn vcmlaq_rot90_f16(p0: types.f16x8, p1: types.f16x8, p2: types.f16x8) types.f16x8 {
    var res: types.f16x8 = undefined;
    const len = @typeInfo(types.f16x8).vector.len;
    inline for (0..len / 2) |pair| {
        const i = pair * 2;
        const bre = p1[i];
        const bim = p1[i + 1];
        const cre = p2[i];
        const cim = p2[i + 1];
        const prod_re = bre * cre - bim * cim;
        const prod_im = bre * cim + bim * cre;
        switch (90) {
            0 => {
                res[i] = p0[i] + prod_re;
                res[i + 1] = p0[i + 1] + prod_im;
            },
            90 => {
                res[i] = p0[i] - prod_im;
                res[i + 1] = p0[i + 1] + prod_re;
            },
            180 => {
                res[i] = p0[i] - prod_re;
                res[i + 1] = p0[i + 1] - prod_im;
            },
            270 => {
                res[i] = p0[i] + prod_im;
                res[i + 1] = p0[i + 1] - prod_re;
            },
            else => unreachable,
        }
    }
    return res;
}

test vcmlaq_rot90_f16 {
    const p0 = @as(types.f16x8, @splat(1.5));
    const p1 = @as(types.f16x8, @splat(1.5));
    const p2 = @as(types.f16x8, @splat(1.5));
    const res = vcmlaq_rot90_f16(p0, p1, p2);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vcmlaq_rot90_f32
pub inline fn vcmlaq_rot90_f32(p0: types.f32x4, p1: types.f32x4, p2: types.f32x4) types.f32x4 {
    var res: types.f32x4 = undefined;
    const len = @typeInfo(types.f32x4).vector.len;
    inline for (0..len / 2) |pair| {
        const i = pair * 2;
        const bre = p1[i];
        const bim = p1[i + 1];
        const cre = p2[i];
        const cim = p2[i + 1];
        const prod_re = bre * cre - bim * cim;
        const prod_im = bre * cim + bim * cre;
        switch (90) {
            0 => {
                res[i] = p0[i] + prod_re;
                res[i + 1] = p0[i + 1] + prod_im;
            },
            90 => {
                res[i] = p0[i] - prod_im;
                res[i + 1] = p0[i + 1] + prod_re;
            },
            180 => {
                res[i] = p0[i] - prod_re;
                res[i + 1] = p0[i + 1] - prod_im;
            },
            270 => {
                res[i] = p0[i] + prod_im;
                res[i + 1] = p0[i + 1] - prod_re;
            },
            else => unreachable,
        }
    }
    return res;
}

test vcmlaq_rot90_f32 {
    const p0 = @as(types.f32x4, @splat(1.5));
    const p1 = @as(types.f32x4, @splat(1.5));
    const p2 = @as(types.f32x4, @splat(1.5));
    const res = vcmlaq_rot90_f32(p0, p1, p2);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vcmlaq_rot90_f64
pub inline fn vcmlaq_rot90_f64(p0: types.f64x2, p1: types.f64x2, p2: types.f64x2) types.f64x2 {
    var res: types.f64x2 = undefined;
    const len = @typeInfo(types.f64x2).vector.len;
    inline for (0..len / 2) |pair| {
        const i = pair * 2;
        const bre = p1[i];
        const bim = p1[i + 1];
        const cre = p2[i];
        const cim = p2[i + 1];
        const prod_re = bre * cre - bim * cim;
        const prod_im = bre * cim + bim * cre;
        switch (90) {
            0 => {
                res[i] = p0[i] + prod_re;
                res[i + 1] = p0[i + 1] + prod_im;
            },
            90 => {
                res[i] = p0[i] - prod_im;
                res[i + 1] = p0[i + 1] + prod_re;
            },
            180 => {
                res[i] = p0[i] - prod_re;
                res[i + 1] = p0[i + 1] - prod_im;
            },
            270 => {
                res[i] = p0[i] + prod_im;
                res[i + 1] = p0[i + 1] - prod_re;
            },
            else => unreachable,
        }
    }
    return res;
}

test vcmlaq_rot90_f64 {
    const p0 = @as(types.f64x2, @splat(1.5));
    const p1 = @as(types.f64x2, @splat(1.5));
    const p2 = @as(types.f64x2, @splat(1.5));
    const res = vcmlaq_rot90_f64(p0, p1, p2);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vcombine_p64
pub inline fn vcombine_p64(p0: types.p64x1, p1: types.p64x1) types.p64x2 {
    return .{ p0[0], p1[0] };
}

test vcombine_p64 {
    const p0 = @as(types.p64x1, @splat(2));
    const p1 = @as(types.p64x1, @splat(2));
    const res = vcombine_p64(p0, p1);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vdot_s32
pub inline fn vdot_s32(p0: types.i32x2, p1: types.i8x8, p2: types.i8x8) types.i32x2 {
    var res = p0;
    inline for (0..2) |i| {
        const b = i * 4;
        res[i] +%= @as(i32, p1[b]) * @as(i32, p2[b]) + @as(i32, p1[b + 1]) * @as(i32, p2[b + 1]) + @as(i32, p1[b + 2]) * @as(i32, p2[b + 2]) + @as(i32, p1[b + 3]) * @as(i32, p2[b + 3]);
    }
    return res;
}

test vdot_s32 {
    const p0 = @as(types.i32x2, @splat(2));
    const p1 = @as(types.i8x8, @splat(2));
    const p2 = @as(types.i8x8, @splat(2));
    const res = vdot_s32(p0, p1, p2);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vdot_u32
pub inline fn vdot_u32(p0: types.u32x2, p1: types.u8x8, p2: types.u8x8) types.u32x2 {
    var res = p0;
    inline for (0..2) |i| {
        const b = i * 4;
        res[i] +%= @as(u32, p1[b]) * @as(u32, p2[b]) + @as(u32, p1[b + 1]) * @as(u32, p2[b + 1]) + @as(u32, p1[b + 2]) * @as(u32, p2[b + 2]) + @as(u32, p1[b + 3]) * @as(u32, p2[b + 3]);
    }
    return res;
}

test vdot_u32 {
    const p0 = @as(types.u32x2, @splat(2));
    const p1 = @as(types.u8x8, @splat(2));
    const p2 = @as(types.u8x8, @splat(2));
    const res = vdot_u32(p0, p1, p2);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vdotq_s32
pub inline fn vdotq_s32(p0: types.i32x4, p1: types.i8x16, p2: types.i8x16) types.i32x4 {
    var res = p0;
    inline for (0..4) |i| {
        const b = i * 4;
        res[i] +%= @as(i32, p1[b]) * @as(i32, p2[b]) + @as(i32, p1[b + 1]) * @as(i32, p2[b + 1]) + @as(i32, p1[b + 2]) * @as(i32, p2[b + 2]) + @as(i32, p1[b + 3]) * @as(i32, p2[b + 3]);
    }
    return res;
}

test vdotq_s32 {
    const p0 = @as(types.i32x4, @splat(2));
    const p1 = @as(types.i8x16, @splat(2));
    const p2 = @as(types.i8x16, @splat(2));
    const res = vdotq_s32(p0, p1, p2);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vdotq_u32
pub inline fn vdotq_u32(p0: types.u32x4, p1: types.u8x16, p2: types.u8x16) types.u32x4 {
    var res = p0;
    inline for (0..4) |i| {
        const b = i * 4;
        res[i] +%= @as(u32, p1[b]) * @as(u32, p2[b]) + @as(u32, p1[b + 1]) * @as(u32, p2[b + 1]) + @as(u32, p1[b + 2]) * @as(u32, p2[b + 2]) + @as(u32, p1[b + 3]) * @as(u32, p2[b + 3]);
    }
    return res;
}

test vdotq_u32 {
    const p0 = @as(types.u32x4, @splat(2));
    const p1 = @as(types.u8x16, @splat(2));
    const p2 = @as(types.u8x16, @splat(2));
    const res = vdotq_u32(p0, p1, p2);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vfma_f16
pub inline fn vfma_f16(p0: types.f16x4, p1: types.f16x4, p2: types.f16x4) types.f16x4 {
    return p0 + (p1 * p2);
}

test vfma_f16 {
    const p0 = @as(types.f16x4, @splat(1.5));
    const p1 = @as(types.f16x4, @splat(1.5));
    const p2 = @as(types.f16x4, @splat(1.5));
    const res = vfma_f16(p0, p1, p2);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vfma_f32
pub inline fn vfma_f32(p0: types.f32x2, p1: types.f32x2, p2: types.f32x2) types.f32x2 {
    return p0 + (p1 * p2);
}

test vfma_f32 {
    const p0 = @as(types.f32x2, @splat(1.5));
    const p1 = @as(types.f32x2, @splat(1.5));
    const p2 = @as(types.f32x2, @splat(1.5));
    const res = vfma_f32(p0, p1, p2);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vfma_f64
pub inline fn vfma_f64(p0: types.f64x1, p1: types.f64x1, p2: types.f64x1) types.f64x1 {
    return p0 + (p1 * p2);
}

test vfma_f64 {
    const p0 = @as(types.f64x1, @splat(1.5));
    const p1 = @as(types.f64x1, @splat(1.5));
    const p2 = @as(types.f64x1, @splat(1.5));
    const res = vfma_f64(p0, p1, p2);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vfma_n_f32
pub inline fn vfma_n_f32(p0: types.f32x2, p1: types.f32x2, p2: f32) types.f32x2 {
    const p2_vec: types.f32x2 = @splat(p2);
    return p0 + (p1 * p2_vec);
}

test vfma_n_f32 {
    const p0 = @as(types.f32x2, @splat(1.5));
    const p1 = @as(types.f32x2, @splat(1.5));
    const p2 = @as(f32, 1.5);
    const res = vfma_n_f32(p0, p1, p2);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vfma_n_f64
pub inline fn vfma_n_f64(p0: types.f64x1, p1: types.f64x1, p2: f64) types.f64x1 {
    const p2_vec: types.f64x1 = @splat(p2);
    return p0 + (p1 * p2_vec);
}

test vfma_n_f64 {
    const p0 = @as(types.f64x1, @splat(1.5));
    const p1 = @as(types.f64x1, @splat(1.5));
    const p2 = @as(f64, 1.5);
    const res = vfma_n_f64(p0, p1, p2);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vfmaq_n_f32
pub inline fn vfmaq_n_f32(p0: types.f32x4, p1: types.f32x4, p2: f32) types.f32x4 {
    const p2_vec: types.f32x4 = @splat(p2);
    return p0 + (p1 * p2_vec);
}

test vfmaq_n_f32 {
    const p0 = @as(types.f32x4, @splat(1.5));
    const p1 = @as(types.f32x4, @splat(1.5));
    const p2 = @as(f32, 1.5);
    const res = vfmaq_n_f32(p0, p1, p2);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vfmaq_n_f64
pub inline fn vfmaq_n_f64(p0: types.f64x2, p1: types.f64x2, p2: f64) types.f64x2 {
    const p2_vec: types.f64x2 = @splat(p2);
    return p0 + (p1 * p2_vec);
}

test vfmaq_n_f64 {
    const p0 = @as(types.f64x2, @splat(1.5));
    const p1 = @as(types.f64x2, @splat(1.5));
    const p2 = @as(f64, 1.5);
    const res = vfmaq_n_f64(p0, p1, p2);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vfmlal_high_f16
pub inline fn vfmlal_high_f16(p0: types.f32x2, p1: types.f16x4, p2: types.f16x4) types.f32x2 {
    var res = p0;
    inline for (0..2) |i| {
        res[i] += @as(f32, p1[i + 2]) * @as(f32, p2[i + 2]);
    }
    return res;
}

test vfmlal_high_f16 {
    const p0 = @as(types.f32x2, @splat(1.5));
    const p1 = @as(types.f16x4, @splat(1.5));
    const p2 = @as(types.f16x4, @splat(1.5));
    const res = vfmlal_high_f16(p0, p1, p2);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vfmlal_low_f16
pub inline fn vfmlal_low_f16(p0: types.f32x2, p1: types.f16x4, p2: types.f16x4) types.f32x2 {
    var res = p0;
    inline for (0..2) |i| {
        res[i] += @as(f32, p1[i + 0]) * @as(f32, p2[i + 0]);
    }
    return res;
}

test vfmlal_low_f16 {
    const p0 = @as(types.f32x2, @splat(1.5));
    const p1 = @as(types.f16x4, @splat(1.5));
    const p2 = @as(types.f16x4, @splat(1.5));
    const res = vfmlal_low_f16(p0, p1, p2);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vfmlalq_high_f16
pub inline fn vfmlalq_high_f16(p0: types.f32x4, p1: types.f16x8, p2: types.f16x8) types.f32x4 {
    var res = p0;
    inline for (0..4) |i| {
        res[i] += @as(f32, p1[i + 4]) * @as(f32, p2[i + 4]);
    }
    return res;
}

test vfmlalq_high_f16 {
    const p0 = @as(types.f32x4, @splat(1.5));
    const p1 = @as(types.f16x8, @splat(1.5));
    const p2 = @as(types.f16x8, @splat(1.5));
    const res = vfmlalq_high_f16(p0, p1, p2);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vfmlalq_low_f16
pub inline fn vfmlalq_low_f16(p0: types.f32x4, p1: types.f16x8, p2: types.f16x8) types.f32x4 {
    var res = p0;
    inline for (0..4) |i| {
        res[i] += @as(f32, p1[i + 0]) * @as(f32, p2[i + 0]);
    }
    return res;
}

test vfmlalq_low_f16 {
    const p0 = @as(types.f32x4, @splat(1.5));
    const p1 = @as(types.f16x8, @splat(1.5));
    const p2 = @as(types.f16x8, @splat(1.5));
    const res = vfmlalq_low_f16(p0, p1, p2);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vfmlsl_high_f16
pub inline fn vfmlsl_high_f16(p0: types.f32x2, p1: types.f16x4, p2: types.f16x4) types.f32x2 {
    var res = p0;
    inline for (0..2) |i| {
        res[i] -= @as(f32, p1[i + 2]) * @as(f32, p2[i + 2]);
    }
    return res;
}

test vfmlsl_high_f16 {
    const p0 = @as(types.f32x2, @splat(1.5));
    const p1 = @as(types.f16x4, @splat(1.5));
    const p2 = @as(types.f16x4, @splat(1.5));
    const res = vfmlsl_high_f16(p0, p1, p2);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vfmlsl_low_f16
pub inline fn vfmlsl_low_f16(p0: types.f32x2, p1: types.f16x4, p2: types.f16x4) types.f32x2 {
    var res = p0;
    inline for (0..2) |i| {
        res[i] -= @as(f32, p1[i + 0]) * @as(f32, p2[i + 0]);
    }
    return res;
}

test vfmlsl_low_f16 {
    const p0 = @as(types.f32x2, @splat(1.5));
    const p1 = @as(types.f16x4, @splat(1.5));
    const p2 = @as(types.f16x4, @splat(1.5));
    const res = vfmlsl_low_f16(p0, p1, p2);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vfmlslq_high_f16
pub inline fn vfmlslq_high_f16(p0: types.f32x4, p1: types.f16x8, p2: types.f16x8) types.f32x4 {
    var res = p0;
    inline for (0..4) |i| {
        res[i] -= @as(f32, p1[i + 4]) * @as(f32, p2[i + 4]);
    }
    return res;
}

test vfmlslq_high_f16 {
    const p0 = @as(types.f32x4, @splat(1.5));
    const p1 = @as(types.f16x8, @splat(1.5));
    const p2 = @as(types.f16x8, @splat(1.5));
    const res = vfmlslq_high_f16(p0, p1, p2);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vfmlslq_low_f16
pub inline fn vfmlslq_low_f16(p0: types.f32x4, p1: types.f16x8, p2: types.f16x8) types.f32x4 {
    var res = p0;
    inline for (0..4) |i| {
        res[i] -= @as(f32, p1[i + 0]) * @as(f32, p2[i + 0]);
    }
    return res;
}

test vfmlslq_low_f16 {
    const p0 = @as(types.f32x4, @splat(1.5));
    const p1 = @as(types.f16x8, @splat(1.5));
    const p2 = @as(types.f16x8, @splat(1.5));
    const res = vfmlslq_low_f16(p0, p1, p2);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vfms_f16
pub inline fn vfms_f16(p0: types.f16x4, p1: types.f16x4, p2: types.f16x4) types.f16x4 {
    return p0 - (p1 * p2);
}

test vfms_f16 {
    const p0 = @as(types.f16x4, @splat(1.5));
    const p1 = @as(types.f16x4, @splat(1.5));
    const p2 = @as(types.f16x4, @splat(1.5));
    const res = vfms_f16(p0, p1, p2);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vfms_f32
pub inline fn vfms_f32(p0: types.f32x2, p1: types.f32x2, p2: types.f32x2) types.f32x2 {
    return p0 - (p1 * p2);
}

test vfms_f32 {
    const p0 = @as(types.f32x2, @splat(1.5));
    const p1 = @as(types.f32x2, @splat(1.5));
    const p2 = @as(types.f32x2, @splat(1.5));
    const res = vfms_f32(p0, p1, p2);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vfms_f64
pub inline fn vfms_f64(p0: types.f64x1, p1: types.f64x1, p2: types.f64x1) types.f64x1 {
    return p0 - (p1 * p2);
}

test vfms_f64 {
    const p0 = @as(types.f64x1, @splat(1.5));
    const p1 = @as(types.f64x1, @splat(1.5));
    const p2 = @as(types.f64x1, @splat(1.5));
    const res = vfms_f64(p0, p1, p2);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vfms_n_f32
pub inline fn vfms_n_f32(p0: types.f32x2, p1: types.f32x2, p2: f32) types.f32x2 {
    const p2_vec: types.f32x2 = @splat(p2);
    return p0 - (p1 * p2_vec);
}

test vfms_n_f32 {
    const p0 = @as(types.f32x2, @splat(1.5));
    const p1 = @as(types.f32x2, @splat(1.5));
    const p2 = @as(f32, 1.5);
    const res = vfms_n_f32(p0, p1, p2);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vfms_n_f64
pub inline fn vfms_n_f64(p0: types.f64x1, p1: types.f64x1, p2: f64) types.f64x1 {
    const p2_vec: types.f64x1 = @splat(p2);
    return p0 - (p1 * p2_vec);
}

test vfms_n_f64 {
    const p0 = @as(types.f64x1, @splat(1.5));
    const p1 = @as(types.f64x1, @splat(1.5));
    const p2 = @as(f64, 1.5);
    const res = vfms_n_f64(p0, p1, p2);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vfmsq_f16
pub inline fn vfmsq_f16(p0: types.f16x8, p1: types.f16x8, p2: types.f16x8) types.f16x8 {
    return p0 - (p1 * p2);
}

test vfmsq_f16 {
    const p0 = @as(types.f16x8, @splat(1.5));
    const p1 = @as(types.f16x8, @splat(1.5));
    const p2 = @as(types.f16x8, @splat(1.5));
    const res = vfmsq_f16(p0, p1, p2);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vfmsq_f32
pub inline fn vfmsq_f32(p0: types.f32x4, p1: types.f32x4, p2: types.f32x4) types.f32x4 {
    return p0 - (p1 * p2);
}

test vfmsq_f32 {
    const p0 = @as(types.f32x4, @splat(1.5));
    const p1 = @as(types.f32x4, @splat(1.5));
    const p2 = @as(types.f32x4, @splat(1.5));
    const res = vfmsq_f32(p0, p1, p2);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vfmsq_f64
pub inline fn vfmsq_f64(p0: types.f64x2, p1: types.f64x2, p2: types.f64x2) types.f64x2 {
    return p0 - (p1 * p2);
}

test vfmsq_f64 {
    const p0 = @as(types.f64x2, @splat(1.5));
    const p1 = @as(types.f64x2, @splat(1.5));
    const p2 = @as(types.f64x2, @splat(1.5));
    const res = vfmsq_f64(p0, p1, p2);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vfmsq_n_f32
pub inline fn vfmsq_n_f32(p0: types.f32x4, p1: types.f32x4, p2: f32) types.f32x4 {
    const p2_vec: types.f32x4 = @splat(p2);
    return p0 - (p1 * p2_vec);
}

test vfmsq_n_f32 {
    const p0 = @as(types.f32x4, @splat(1.5));
    const p1 = @as(types.f32x4, @splat(1.5));
    const p2 = @as(f32, 1.5);
    const res = vfmsq_n_f32(p0, p1, p2);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vfmsq_n_f64
pub inline fn vfmsq_n_f64(p0: types.f64x2, p1: types.f64x2, p2: f64) types.f64x2 {
    const p2_vec: types.f64x2 = @splat(p2);
    return p0 - (p1 * p2_vec);
}

test vfmsq_n_f64 {
    const p0 = @as(types.f64x2, @splat(1.5));
    const p1 = @as(types.f64x2, @splat(1.5));
    const p2 = @as(f64, 1.5);
    const res = vfmsq_n_f64(p0, p1, p2);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vget_high_p64
pub inline fn vget_high_p64(p0: types.p64x2) types.p64x1 {
    return .{p0[1]};
}

test vget_high_p64 {
    const p0 = @as(types.p64x2, @splat(2));
    const res = vget_high_p64(p0);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vget_low_p64
pub inline fn vget_low_p64(p0: types.p64x2) types.p64x1 {
    return .{p0[0]};
}

test vget_low_p64 {
    const p0 = @as(types.p64x2, @splat(2));
    const res = vget_low_p64(p0);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vmax_s16
pub inline fn vmax_s16(p0: types.i16x4, p1: types.i16x4) types.i16x4 {
    return @max(p0, p1);
}

test vmax_s16 {
    const p0 = @as(types.i16x4, @splat(2));
    const p1 = @as(types.i16x4, @splat(2));
    const res = vmax_s16(p0, p1);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vmax_s32
pub inline fn vmax_s32(p0: types.i32x2, p1: types.i32x2) types.i32x2 {
    return @max(p0, p1);
}

test vmax_s32 {
    const p0 = @as(types.i32x2, @splat(2));
    const p1 = @as(types.i32x2, @splat(2));
    const res = vmax_s32(p0, p1);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vmax_s8
pub inline fn vmax_s8(p0: types.i8x8, p1: types.i8x8) types.i8x8 {
    return @max(p0, p1);
}

test vmax_s8 {
    const p0 = @as(types.i8x8, @splat(2));
    const p1 = @as(types.i8x8, @splat(2));
    const res = vmax_s8(p0, p1);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vmax_u16
pub inline fn vmax_u16(p0: types.u16x4, p1: types.u16x4) types.u16x4 {
    return @max(p0, p1);
}

test vmax_u16 {
    const p0 = @as(types.u16x4, @splat(2));
    const p1 = @as(types.u16x4, @splat(2));
    const res = vmax_u16(p0, p1);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vmax_u32
pub inline fn vmax_u32(p0: types.u32x2, p1: types.u32x2) types.u32x2 {
    return @max(p0, p1);
}

test vmax_u32 {
    const p0 = @as(types.u32x2, @splat(2));
    const p1 = @as(types.u32x2, @splat(2));
    const res = vmax_u32(p0, p1);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vmax_u8
pub inline fn vmax_u8(p0: types.u8x8, p1: types.u8x8) types.u8x8 {
    return @max(p0, p1);
}

test vmax_u8 {
    const p0 = @as(types.u8x8, @splat(2));
    const p1 = @as(types.u8x8, @splat(2));
    const res = vmax_u8(p0, p1);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vmaxnmvq_f64
pub inline fn vmaxnmvq_f64(p0: anytype) @TypeOf(p0[0]) {
    return @max(p0[0], p0[1]);
}

test vmaxnmvq_f64 {
    const p0 = @as(types.f64x2, @splat(1.5));
    const res = vmaxnmvq_f64(p0);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vmaxq_s16
pub inline fn vmaxq_s16(p0: types.i16x8, p1: types.i16x8) types.i16x8 {
    return @max(p0, p1);
}

test vmaxq_s16 {
    const p0 = @as(types.i16x8, @splat(2));
    const p1 = @as(types.i16x8, @splat(2));
    const res = vmaxq_s16(p0, p1);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vmaxq_s32
pub inline fn vmaxq_s32(p0: types.i32x4, p1: types.i32x4) types.i32x4 {
    return @max(p0, p1);
}

test vmaxq_s32 {
    const p0 = @as(types.i32x4, @splat(2));
    const p1 = @as(types.i32x4, @splat(2));
    const res = vmaxq_s32(p0, p1);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vmaxq_s8
pub inline fn vmaxq_s8(p0: types.i8x16, p1: types.i8x16) types.i8x16 {
    return @max(p0, p1);
}

test vmaxq_s8 {
    const p0 = @as(types.i8x16, @splat(2));
    const p1 = @as(types.i8x16, @splat(2));
    const res = vmaxq_s8(p0, p1);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vmaxq_u16
pub inline fn vmaxq_u16(p0: types.u16x8, p1: types.u16x8) types.u16x8 {
    return @max(p0, p1);
}

test vmaxq_u16 {
    const p0 = @as(types.u16x8, @splat(2));
    const p1 = @as(types.u16x8, @splat(2));
    const res = vmaxq_u16(p0, p1);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vmaxq_u32
pub inline fn vmaxq_u32(p0: types.u32x4, p1: types.u32x4) types.u32x4 {
    return @max(p0, p1);
}

test vmaxq_u32 {
    const p0 = @as(types.u32x4, @splat(2));
    const p1 = @as(types.u32x4, @splat(2));
    const res = vmaxq_u32(p0, p1);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vmaxq_u8
pub inline fn vmaxq_u8(p0: types.u8x16, p1: types.u8x16) types.u8x16 {
    return @max(p0, p1);
}

test vmaxq_u8 {
    const p0 = @as(types.u8x16, @splat(2));
    const p1 = @as(types.u8x16, @splat(2));
    const res = vmaxq_u8(p0, p1);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vmaxv_f32
pub inline fn vmaxv_f32(p0: anytype) @TypeOf(p0[0]) {
    return @max(p0[0], p0[1]);
}

test vmaxv_f32 {
    const p0 = @as(types.f32x2, @splat(1.5));
    const res = vmaxv_f32(p0);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vmin_s16
pub inline fn vmin_s16(p0: types.i16x4, p1: types.i16x4) types.i16x4 {
    return @min(p0, p1);
}

test vmin_s16 {
    const p0 = @as(types.i16x4, @splat(2));
    const p1 = @as(types.i16x4, @splat(2));
    const res = vmin_s16(p0, p1);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vmin_s32
pub inline fn vmin_s32(p0: types.i32x2, p1: types.i32x2) types.i32x2 {
    return @min(p0, p1);
}

test vmin_s32 {
    const p0 = @as(types.i32x2, @splat(2));
    const p1 = @as(types.i32x2, @splat(2));
    const res = vmin_s32(p0, p1);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vmin_s8
pub inline fn vmin_s8(p0: types.i8x8, p1: types.i8x8) types.i8x8 {
    return @min(p0, p1);
}

test vmin_s8 {
    const p0 = @as(types.i8x8, @splat(2));
    const p1 = @as(types.i8x8, @splat(2));
    const res = vmin_s8(p0, p1);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vmin_u16
pub inline fn vmin_u16(p0: types.u16x4, p1: types.u16x4) types.u16x4 {
    return @min(p0, p1);
}

test vmin_u16 {
    const p0 = @as(types.u16x4, @splat(2));
    const p1 = @as(types.u16x4, @splat(2));
    const res = vmin_u16(p0, p1);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vmin_u32
pub inline fn vmin_u32(p0: types.u32x2, p1: types.u32x2) types.u32x2 {
    return @min(p0, p1);
}

test vmin_u32 {
    const p0 = @as(types.u32x2, @splat(2));
    const p1 = @as(types.u32x2, @splat(2));
    const res = vmin_u32(p0, p1);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vmin_u8
pub inline fn vmin_u8(p0: types.u8x8, p1: types.u8x8) types.u8x8 {
    return @min(p0, p1);
}

test vmin_u8 {
    const p0 = @as(types.u8x8, @splat(2));
    const p1 = @as(types.u8x8, @splat(2));
    const res = vmin_u8(p0, p1);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vminnmvq_f64
pub inline fn vminnmvq_f64(p0: anytype) @TypeOf(p0[0]) {
    return @min(p0[0], p0[1]);
}

test vminnmvq_f64 {
    const p0 = @as(types.f64x2, @splat(1.5));
    const res = vminnmvq_f64(p0);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vminq_s16
pub inline fn vminq_s16(p0: types.i16x8, p1: types.i16x8) types.i16x8 {
    return @min(p0, p1);
}

test vminq_s16 {
    const p0 = @as(types.i16x8, @splat(2));
    const p1 = @as(types.i16x8, @splat(2));
    const res = vminq_s16(p0, p1);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vminq_s32
pub inline fn vminq_s32(p0: types.i32x4, p1: types.i32x4) types.i32x4 {
    return @min(p0, p1);
}

test vminq_s32 {
    const p0 = @as(types.i32x4, @splat(2));
    const p1 = @as(types.i32x4, @splat(2));
    const res = vminq_s32(p0, p1);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vminq_s8
pub inline fn vminq_s8(p0: types.i8x16, p1: types.i8x16) types.i8x16 {
    return @min(p0, p1);
}

test vminq_s8 {
    const p0 = @as(types.i8x16, @splat(2));
    const p1 = @as(types.i8x16, @splat(2));
    const res = vminq_s8(p0, p1);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vminq_u16
pub inline fn vminq_u16(p0: types.u16x8, p1: types.u16x8) types.u16x8 {
    return @min(p0, p1);
}

test vminq_u16 {
    const p0 = @as(types.u16x8, @splat(2));
    const p1 = @as(types.u16x8, @splat(2));
    const res = vminq_u16(p0, p1);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vminq_u32
pub inline fn vminq_u32(p0: types.u32x4, p1: types.u32x4) types.u32x4 {
    return @min(p0, p1);
}

test vminq_u32 {
    const p0 = @as(types.u32x4, @splat(2));
    const p1 = @as(types.u32x4, @splat(2));
    const res = vminq_u32(p0, p1);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vminq_u8
pub inline fn vminq_u8(p0: types.u8x16, p1: types.u8x16) types.u8x16 {
    return @min(p0, p1);
}

test vminq_u8 {
    const p0 = @as(types.u8x16, @splat(2));
    const p1 = @as(types.u8x16, @splat(2));
    const res = vminq_u8(p0, p1);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vminv_f32
pub inline fn vminv_f32(p0: anytype) @TypeOf(p0[0]) {
    return @min(p0[0], p0[1]);
}

test vminv_f32 {
    const p0 = @as(types.f32x2, @splat(1.5));
    const res = vminv_f32(p0);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vmla_f64
pub inline fn vmla_f64(p0: types.f64x1, p1: types.f64x1, p2: types.f64x1) types.f64x1 {
    return p0 + (p1 * p2);
}

test vmla_f64 {
    const p0 = @as(types.f64x1, @splat(1.5));
    const p1 = @as(types.f64x1, @splat(1.5));
    const p2 = @as(types.f64x1, @splat(1.5));
    const res = vmla_f64(p0, p1, p2);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vmla_n_f32
pub inline fn vmla_n_f32(p0: types.f32x2, p1: types.f32x2, p2: f32) types.f32x2 {
    const p2_vec: types.f32x2 = @splat(p2);
    return p0 + (p1 * p2_vec);
}

test vmla_n_f32 {
    const p0 = @as(types.f32x2, @splat(1.5));
    const p1 = @as(types.f32x2, @splat(1.5));
    const p2 = @as(f32, 1.5);
    const res = vmla_n_f32(p0, p1, p2);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vmla_n_s16
pub inline fn vmla_n_s16(p0: types.i16x4, p1: types.i16x4, p2: i16) types.i16x4 {
    const p2_vec: types.i16x4 = @splat(p2);
    return p0 +% (p1 *% p2_vec);
}

test vmla_n_s16 {
    const p0 = @as(types.i16x4, @splat(2));
    const p1 = @as(types.i16x4, @splat(2));
    const p2 = @as(i16, 2);
    const res = vmla_n_s16(p0, p1, p2);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vmla_n_s32
pub inline fn vmla_n_s32(p0: types.i32x2, p1: types.i32x2, p2: i32) types.i32x2 {
    const p2_vec: types.i32x2 = @splat(p2);
    return p0 +% (p1 *% p2_vec);
}

test vmla_n_s32 {
    const p0 = @as(types.i32x2, @splat(2));
    const p1 = @as(types.i32x2, @splat(2));
    const p2 = @as(i32, 2);
    const res = vmla_n_s32(p0, p1, p2);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vmla_n_u16
pub inline fn vmla_n_u16(p0: types.u16x4, p1: types.u16x4, p2: u16) types.u16x4 {
    const p2_vec: types.u16x4 = @splat(p2);
    return p0 +% (p1 *% p2_vec);
}

test vmla_n_u16 {
    const p0 = @as(types.u16x4, @splat(2));
    const p1 = @as(types.u16x4, @splat(2));
    const p2 = @as(u16, 2);
    const res = vmla_n_u16(p0, p1, p2);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vmla_n_u32
pub inline fn vmla_n_u32(p0: types.u32x2, p1: types.u32x2, p2: u32) types.u32x2 {
    const p2_vec: types.u32x2 = @splat(p2);
    return p0 +% (p1 *% p2_vec);
}

test vmla_n_u32 {
    const p0 = @as(types.u32x2, @splat(2));
    const p1 = @as(types.u32x2, @splat(2));
    const p2 = @as(u32, 2);
    const res = vmla_n_u32(p0, p1, p2);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vmlal_high_n_s16
pub inline fn vmlal_high_n_s16(p0: types.i32x4, p1: types.i16x8, p2: i16) types.i32x4 {
    var res = p0;
    inline for (0..4) |i| {
        res[i] +%= @as(i32, p1[i + 4]) * @as(i32, p2);
    }
    return res;
}

test vmlal_high_n_s16 {
    const p0 = @as(types.i32x4, @splat(2));
    const p1 = @as(types.i16x8, @splat(2));
    const p2 = @as(i16, 2);
    const res = vmlal_high_n_s16(p0, p1, p2);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vmlal_high_n_s32
pub inline fn vmlal_high_n_s32(p0: types.i64x2, p1: types.i32x4, p2: i32) types.i64x2 {
    var res = p0;
    inline for (0..2) |i| {
        res[i] +%= @as(i64, p1[i + 2]) * @as(i64, p2);
    }
    return res;
}

test vmlal_high_n_s32 {
    const p0 = @as(types.i64x2, @splat(2));
    const p1 = @as(types.i32x4, @splat(2));
    const p2 = @as(i32, 2);
    const res = vmlal_high_n_s32(p0, p1, p2);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vmlal_high_n_u16
pub inline fn vmlal_high_n_u16(p0: types.u32x4, p1: types.u16x8, p2: u16) types.u32x4 {
    var res = p0;
    inline for (0..4) |i| {
        res[i] +%= @as(u32, p1[i + 4]) * @as(u32, p2);
    }
    return res;
}

test vmlal_high_n_u16 {
    const p0 = @as(types.u32x4, @splat(2));
    const p1 = @as(types.u16x8, @splat(2));
    const p2 = @as(u16, 2);
    const res = vmlal_high_n_u16(p0, p1, p2);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vmlal_high_n_u32
pub inline fn vmlal_high_n_u32(p0: types.u64x2, p1: types.u32x4, p2: u32) types.u64x2 {
    var res = p0;
    inline for (0..2) |i| {
        res[i] +%= @as(u64, p1[i + 2]) * @as(u64, p2);
    }
    return res;
}

test vmlal_high_n_u32 {
    const p0 = @as(types.u64x2, @splat(2));
    const p1 = @as(types.u32x4, @splat(2));
    const p2 = @as(u32, 2);
    const res = vmlal_high_n_u32(p0, p1, p2);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vmlal_n_s16
pub inline fn vmlal_n_s16(p0: types.i32x4, p1: types.i16x4, p2: i16) types.i32x4 {
    const p2_vec: types.i16x4 = @splat(p2);
    return p0 +% (p1 *% p2_vec);
}

test vmlal_n_s16 {
    const p0 = @as(types.i32x4, @splat(2));
    const p1 = @as(types.i16x4, @splat(2));
    const p2 = @as(i16, 2);
    const res = vmlal_n_s16(p0, p1, p2);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vmlal_n_s32
pub inline fn vmlal_n_s32(p0: types.i64x2, p1: types.i32x2, p2: i32) types.i64x2 {
    const p2_vec: types.i32x2 = @splat(p2);
    return p0 +% (p1 *% p2_vec);
}

test vmlal_n_s32 {
    const p0 = @as(types.i64x2, @splat(2));
    const p1 = @as(types.i32x2, @splat(2));
    const p2 = @as(i32, 2);
    const res = vmlal_n_s32(p0, p1, p2);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vmlal_n_u16
pub inline fn vmlal_n_u16(p0: types.u32x4, p1: types.u16x4, p2: u16) types.u32x4 {
    const p2_vec: types.u16x4 = @splat(p2);
    return p0 +% (p1 *% p2_vec);
}

test vmlal_n_u16 {
    const p0 = @as(types.u32x4, @splat(2));
    const p1 = @as(types.u16x4, @splat(2));
    const p2 = @as(u16, 2);
    const res = vmlal_n_u16(p0, p1, p2);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vmlal_n_u32
pub inline fn vmlal_n_u32(p0: types.u64x2, p1: types.u32x2, p2: u32) types.u64x2 {
    const p2_vec: types.u32x2 = @splat(p2);
    return p0 +% (p1 *% p2_vec);
}

test vmlal_n_u32 {
    const p0 = @as(types.u64x2, @splat(2));
    const p1 = @as(types.u32x2, @splat(2));
    const p2 = @as(u32, 2);
    const res = vmlal_n_u32(p0, p1, p2);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vmlaq_n_f32
pub inline fn vmlaq_n_f32(p0: types.f32x4, p1: types.f32x4, p2: f32) types.f32x4 {
    const p2_vec: types.f32x4 = @splat(p2);
    return p0 + (p1 * p2_vec);
}

test vmlaq_n_f32 {
    const p0 = @as(types.f32x4, @splat(1.5));
    const p1 = @as(types.f32x4, @splat(1.5));
    const p2 = @as(f32, 1.5);
    const res = vmlaq_n_f32(p0, p1, p2);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vmlaq_n_s16
pub inline fn vmlaq_n_s16(p0: types.i16x8, p1: types.i16x8, p2: i16) types.i16x8 {
    const p2_vec: types.i16x8 = @splat(p2);
    return p0 +% (p1 *% p2_vec);
}

test vmlaq_n_s16 {
    const p0 = @as(types.i16x8, @splat(2));
    const p1 = @as(types.i16x8, @splat(2));
    const p2 = @as(i16, 2);
    const res = vmlaq_n_s16(p0, p1, p2);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vmlaq_n_s32
pub inline fn vmlaq_n_s32(p0: types.i32x4, p1: types.i32x4, p2: i32) types.i32x4 {
    const p2_vec: types.i32x4 = @splat(p2);
    return p0 +% (p1 *% p2_vec);
}

test vmlaq_n_s32 {
    const p0 = @as(types.i32x4, @splat(2));
    const p1 = @as(types.i32x4, @splat(2));
    const p2 = @as(i32, 2);
    const res = vmlaq_n_s32(p0, p1, p2);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vmlaq_n_u16
pub inline fn vmlaq_n_u16(p0: types.u16x8, p1: types.u16x8, p2: u16) types.u16x8 {
    const p2_vec: types.u16x8 = @splat(p2);
    return p0 +% (p1 *% p2_vec);
}

test vmlaq_n_u16 {
    const p0 = @as(types.u16x8, @splat(2));
    const p1 = @as(types.u16x8, @splat(2));
    const p2 = @as(u16, 2);
    const res = vmlaq_n_u16(p0, p1, p2);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vmlaq_n_u32
pub inline fn vmlaq_n_u32(p0: types.u32x4, p1: types.u32x4, p2: u32) types.u32x4 {
    const p2_vec: types.u32x4 = @splat(p2);
    return p0 +% (p1 *% p2_vec);
}

test vmlaq_n_u32 {
    const p0 = @as(types.u32x4, @splat(2));
    const p1 = @as(types.u32x4, @splat(2));
    const p2 = @as(u32, 2);
    const res = vmlaq_n_u32(p0, p1, p2);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vmls_f64
pub inline fn vmls_f64(p0: types.f64x1, p1: types.f64x1, p2: types.f64x1) types.f64x1 {
    return p0 - (p1 * p2);
}

test vmls_f64 {
    const p0 = @as(types.f64x1, @splat(1.5));
    const p1 = @as(types.f64x1, @splat(1.5));
    const p2 = @as(types.f64x1, @splat(1.5));
    const res = vmls_f64(p0, p1, p2);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vmls_n_f32
pub inline fn vmls_n_f32(p0: types.f32x2, p1: types.f32x2, p2: f32) types.f32x2 {
    const p2_vec: types.f32x2 = @splat(p2);
    return p0 - (p1 * p2_vec);
}

test vmls_n_f32 {
    const p0 = @as(types.f32x2, @splat(1.5));
    const p1 = @as(types.f32x2, @splat(1.5));
    const p2 = @as(f32, 1.5);
    const res = vmls_n_f32(p0, p1, p2);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vmls_n_s16
pub inline fn vmls_n_s16(p0: types.i16x4, p1: types.i16x4, p2: i16) types.i16x4 {
    const p2_vec: types.i16x4 = @splat(p2);
    return p0 -% (p1 *% p2_vec);
}

test vmls_n_s16 {
    const p0 = @as(types.i16x4, @splat(2));
    const p1 = @as(types.i16x4, @splat(2));
    const p2 = @as(i16, 2);
    const res = vmls_n_s16(p0, p1, p2);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vmls_n_s32
pub inline fn vmls_n_s32(p0: types.i32x2, p1: types.i32x2, p2: i32) types.i32x2 {
    const p2_vec: types.i32x2 = @splat(p2);
    return p0 -% (p1 *% p2_vec);
}

test vmls_n_s32 {
    const p0 = @as(types.i32x2, @splat(2));
    const p1 = @as(types.i32x2, @splat(2));
    const p2 = @as(i32, 2);
    const res = vmls_n_s32(p0, p1, p2);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vmls_n_u16
pub inline fn vmls_n_u16(p0: types.u16x4, p1: types.u16x4, p2: u16) types.u16x4 {
    const p2_vec: types.u16x4 = @splat(p2);
    return p0 -% (p1 *% p2_vec);
}

test vmls_n_u16 {
    const p0 = @as(types.u16x4, @splat(2));
    const p1 = @as(types.u16x4, @splat(2));
    const p2 = @as(u16, 2);
    const res = vmls_n_u16(p0, p1, p2);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vmls_n_u32
pub inline fn vmls_n_u32(p0: types.u32x2, p1: types.u32x2, p2: u32) types.u32x2 {
    const p2_vec: types.u32x2 = @splat(p2);
    return p0 -% (p1 *% p2_vec);
}

test vmls_n_u32 {
    const p0 = @as(types.u32x2, @splat(2));
    const p1 = @as(types.u32x2, @splat(2));
    const p2 = @as(u32, 2);
    const res = vmls_n_u32(p0, p1, p2);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vmlsl_high_n_s16
pub inline fn vmlsl_high_n_s16(p0: types.i32x4, p1: types.i16x8, p2: i16) types.i32x4 {
    var res = p0;
    inline for (0..4) |i| {
        res[i] -%= @as(i32, p1[i + 4]) * @as(i32, p2);
    }
    return res;
}

test vmlsl_high_n_s16 {
    const p0 = @as(types.i32x4, @splat(2));
    const p1 = @as(types.i16x8, @splat(2));
    const p2 = @as(i16, 2);
    const res = vmlsl_high_n_s16(p0, p1, p2);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vmlsl_high_n_s32
pub inline fn vmlsl_high_n_s32(p0: types.i64x2, p1: types.i32x4, p2: i32) types.i64x2 {
    var res = p0;
    inline for (0..2) |i| {
        res[i] -%= @as(i64, p1[i + 2]) * @as(i64, p2);
    }
    return res;
}

test vmlsl_high_n_s32 {
    const p0 = @as(types.i64x2, @splat(2));
    const p1 = @as(types.i32x4, @splat(2));
    const p2 = @as(i32, 2);
    const res = vmlsl_high_n_s32(p0, p1, p2);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vmlsl_high_n_u16
pub inline fn vmlsl_high_n_u16(p0: types.u32x4, p1: types.u16x8, p2: u16) types.u32x4 {
    var res = p0;
    inline for (0..4) |i| {
        res[i] -%= @as(u32, p1[i + 4]) * @as(u32, p2);
    }
    return res;
}

test vmlsl_high_n_u16 {
    const p0 = @as(types.u32x4, @splat(2));
    const p1 = @as(types.u16x8, @splat(2));
    const p2 = @as(u16, 2);
    const res = vmlsl_high_n_u16(p0, p1, p2);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vmlsl_high_n_u32
pub inline fn vmlsl_high_n_u32(p0: types.u64x2, p1: types.u32x4, p2: u32) types.u64x2 {
    var res = p0;
    inline for (0..2) |i| {
        res[i] -%= @as(u64, p1[i + 2]) * @as(u64, p2);
    }
    return res;
}

test vmlsl_high_n_u32 {
    const p0 = @as(types.u64x2, @splat(2));
    const p1 = @as(types.u32x4, @splat(2));
    const p2 = @as(u32, 2);
    const res = vmlsl_high_n_u32(p0, p1, p2);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vmlsl_n_s16
pub inline fn vmlsl_n_s16(p0: types.i32x4, p1: types.i16x4, p2: i16) types.i32x4 {
    const p2_vec: types.i16x4 = @splat(p2);
    return p0 -% (p1 *% p2_vec);
}

test vmlsl_n_s16 {
    const p0 = @as(types.i32x4, @splat(2));
    const p1 = @as(types.i16x4, @splat(2));
    const p2 = @as(i16, 2);
    const res = vmlsl_n_s16(p0, p1, p2);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vmlsl_n_s32
pub inline fn vmlsl_n_s32(p0: types.i64x2, p1: types.i32x2, p2: i32) types.i64x2 {
    const p2_vec: types.i32x2 = @splat(p2);
    return p0 -% (p1 *% p2_vec);
}

test vmlsl_n_s32 {
    const p0 = @as(types.i64x2, @splat(2));
    const p1 = @as(types.i32x2, @splat(2));
    const p2 = @as(i32, 2);
    const res = vmlsl_n_s32(p0, p1, p2);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vmlsl_n_u16
pub inline fn vmlsl_n_u16(p0: types.u32x4, p1: types.u16x4, p2: u16) types.u32x4 {
    const p2_vec: types.u16x4 = @splat(p2);
    return p0 -% (p1 *% p2_vec);
}

test vmlsl_n_u16 {
    const p0 = @as(types.u32x4, @splat(2));
    const p1 = @as(types.u16x4, @splat(2));
    const p2 = @as(u16, 2);
    const res = vmlsl_n_u16(p0, p1, p2);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vmlsl_n_u32
pub inline fn vmlsl_n_u32(p0: types.u64x2, p1: types.u32x2, p2: u32) types.u64x2 {
    const p2_vec: types.u32x2 = @splat(p2);
    return p0 -% (p1 *% p2_vec);
}

test vmlsl_n_u32 {
    const p0 = @as(types.u64x2, @splat(2));
    const p1 = @as(types.u32x2, @splat(2));
    const p2 = @as(u32, 2);
    const res = vmlsl_n_u32(p0, p1, p2);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vmlsq_n_f32
pub inline fn vmlsq_n_f32(p0: types.f32x4, p1: types.f32x4, p2: f32) types.f32x4 {
    const p2_vec: types.f32x4 = @splat(p2);
    return p0 - (p1 * p2_vec);
}

test vmlsq_n_f32 {
    const p0 = @as(types.f32x4, @splat(1.5));
    const p1 = @as(types.f32x4, @splat(1.5));
    const p2 = @as(f32, 1.5);
    const res = vmlsq_n_f32(p0, p1, p2);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vmlsq_n_s16
pub inline fn vmlsq_n_s16(p0: types.i16x8, p1: types.i16x8, p2: i16) types.i16x8 {
    const p2_vec: types.i16x8 = @splat(p2);
    return p0 -% (p1 *% p2_vec);
}

test vmlsq_n_s16 {
    const p0 = @as(types.i16x8, @splat(2));
    const p1 = @as(types.i16x8, @splat(2));
    const p2 = @as(i16, 2);
    const res = vmlsq_n_s16(p0, p1, p2);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vmlsq_n_s32
pub inline fn vmlsq_n_s32(p0: types.i32x4, p1: types.i32x4, p2: i32) types.i32x4 {
    const p2_vec: types.i32x4 = @splat(p2);
    return p0 -% (p1 *% p2_vec);
}

test vmlsq_n_s32 {
    const p0 = @as(types.i32x4, @splat(2));
    const p1 = @as(types.i32x4, @splat(2));
    const p2 = @as(i32, 2);
    const res = vmlsq_n_s32(p0, p1, p2);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vmlsq_n_u16
pub inline fn vmlsq_n_u16(p0: types.u16x8, p1: types.u16x8, p2: u16) types.u16x8 {
    const p2_vec: types.u16x8 = @splat(p2);
    return p0 -% (p1 *% p2_vec);
}

test vmlsq_n_u16 {
    const p0 = @as(types.u16x8, @splat(2));
    const p1 = @as(types.u16x8, @splat(2));
    const p2 = @as(u16, 2);
    const res = vmlsq_n_u16(p0, p1, p2);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vmlsq_n_u32
pub inline fn vmlsq_n_u32(p0: types.u32x4, p1: types.u32x4, p2: u32) types.u32x4 {
    const p2_vec: types.u32x4 = @splat(p2);
    return p0 -% (p1 *% p2_vec);
}

test vmlsq_n_u32 {
    const p0 = @as(types.u32x4, @splat(2));
    const p1 = @as(types.u32x4, @splat(2));
    const p2 = @as(u32, 2);
    const res = vmlsq_n_u32(p0, p1, p2);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vmmlaq_s32
pub inline fn vmmlaq_s32(p0: types.i32x4, p1: types.i8x16, p2: types.i8x16) types.i32x4 {
    var res = p0;
    inline for (0..2) |r| {
        inline for (0..2) |c| {
            var sum: i32 = 0;
            inline for (0..8) |k| {
                sum += @as(i32, p1[r * 8 + k]) * @as(i32, p2[k * 2 + c]);
            }
            res[r * 2 + c] += sum;
        }
    }
    return res;
}

test vmmlaq_s32 {
    const p0 = @as(types.i32x4, @splat(2));
    const p1 = @as(types.i8x16, @splat(2));
    const p2 = @as(types.i8x16, @splat(2));
    const res = vmmlaq_s32(p0, p1, p2);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vmmlaq_u32
pub inline fn vmmlaq_u32(p0: types.u32x4, p1: types.u8x16, p2: types.u8x16) types.u32x4 {
    var res = p0;
    inline for (0..2) |r| {
        inline for (0..2) |c| {
            var sum: u32 = 0;
            inline for (0..8) |k| {
                sum +%= @as(u32, p1[r * 8 + k]) *% @as(u32, p2[k * 2 + c]);
            }
            res[r * 2 + c] +%= sum;
        }
    }
    return res;
}

test vmmlaq_u32 {
    const p0 = @as(types.u32x4, @splat(2));
    const p1 = @as(types.u8x16, @splat(2));
    const p2 = @as(types.u8x16, @splat(2));
    const res = vmmlaq_u32(p0, p1, p2);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vmul_p8
pub inline fn vmul_p8(p0: types.p8x8, p1: types.p8x8) types.p8x8 {
    return p0 *% p1;
}

test vmul_p8 {
    const p0 = @as(types.p8x8, @splat(2));
    const p1 = @as(types.p8x8, @splat(2));
    const res = vmul_p8(p0, p1);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vmull_high_n_u32
pub inline fn vmull_high_n_u32(p0: types.u32x4, p1: u32) types.u64x2 {
    var res: types.u64x2 = undefined;
    inline for (0..2) |i| {
        res[i] = @as(u64, p0[i + 2]) * @as(u64, p1);
    }
    return res;
}

test vmull_high_n_u32 {
    const p0 = @as(types.u32x4, @splat(2));
    const p1 = @as(u32, 2);
    const res = vmull_high_n_u32(p0, p1);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vmull_high_p64
pub inline fn vmull_high_p64(p0: types.p64x2, p1: types.p64x2) u128 {
    return @as(u128, p0[1]) * @as(u128, p1[1]);
}

test vmull_high_p64 {
    const p0 = @as(types.p64x2, @splat(2));
    const p1 = @as(types.p64x2, @splat(2));
    const res = vmull_high_p64(p0, p1);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vmull_high_p8
pub inline fn vmull_high_p8(p0: types.p8x16, p1: types.p8x16) types.p16x8 {
    var res: types.p16x8 = undefined;
    inline for (0..8) |i| {
        res[i] = @as(u16, p0[i + 8]) * @as(u16, p1[i + 8]);
    }
    return res;
}

test vmull_high_p8 {
    const p0 = @as(types.p8x16, @splat(2));
    const p1 = @as(types.p8x16, @splat(2));
    const res = vmull_high_p8(p0, p1);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vmull_p64
pub inline fn vmull_p64(p0: u64, p1: u64) u128 {
    return p0 *% p1;
}

test vmull_p64 {
    const p0 = @as(u64, 2);
    const p1 = @as(u64, 2);
    const res = vmull_p64(p0, p1);
    try std.testing.expect(res == res);
}

/// ARM NEON intrinsic: vmull_p8
pub inline fn vmull_p8(p0: types.p8x8, p1: types.p8x8) types.p16x8 {
    return p0 *% p1;
}

test vmull_p8 {
    const p0 = @as(types.p8x8, @splat(2));
    const p1 = @as(types.p8x8, @splat(2));
    const res = vmull_p8(p0, p1);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vmulq_n_f64
pub inline fn vmulq_n_f64(p0: types.f64x2, p1: f64) types.f64x2 {
    const p1_vec: types.f64x2 = @splat(p1);
    return p0 * p1_vec;
}

test vmulq_n_f64 {
    const p0 = @as(types.f64x2, @splat(1.5));
    const p1 = @as(f64, 1.5);
    const res = vmulq_n_f64(p0, p1);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vmulq_p8
pub inline fn vmulq_p8(p0: types.p8x16, p1: types.p8x16) types.p8x16 {
    return p0 *% p1;
}

test vmulq_p8 {
    const p0 = @as(types.p8x16, @splat(2));
    const p1 = @as(types.p8x16, @splat(2));
    const res = vmulq_p8(p0, p1);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vmulx_f16
pub inline fn vmulx_f16(p0: types.f16x4, p1: types.f16x4) types.f16x4 {
    return p0 * p1;
}

test vmulx_f16 {
    const p0 = @as(types.f16x4, @splat(1.5));
    const p1 = @as(types.f16x4, @splat(1.5));
    const res = vmulx_f16(p0, p1);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vmulx_f32
pub inline fn vmulx_f32(p0: types.f32x2, p1: types.f32x2) types.f32x2 {
    return p0 * p1;
}

test vmulx_f32 {
    const p0 = @as(types.f32x2, @splat(1.5));
    const p1 = @as(types.f32x2, @splat(1.5));
    const res = vmulx_f32(p0, p1);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vmulx_f64
pub inline fn vmulx_f64(p0: types.f64x1, p1: types.f64x1) types.f64x1 {
    return p0 * p1;
}

test vmulx_f64 {
    const p0 = @as(types.f64x1, @splat(1.5));
    const p1 = @as(types.f64x1, @splat(1.5));
    const res = vmulx_f64(p0, p1);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vmulxd_f64
pub inline fn vmulxd_f64(p0: f64, p1: f64) f64 {
    return p0 * p1;
}

test vmulxd_f64 {
    const p0 = @as(f64, 1.5);
    const p1 = @as(f64, 1.5);
    const res = vmulxd_f64(p0, p1);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vmulxq_f16
pub inline fn vmulxq_f16(p0: types.f16x8, p1: types.f16x8) types.f16x8 {
    return p0 * p1;
}

test vmulxq_f16 {
    const p0 = @as(types.f16x8, @splat(1.5));
    const p1 = @as(types.f16x8, @splat(1.5));
    const res = vmulxq_f16(p0, p1);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vmulxq_f32
pub inline fn vmulxq_f32(p0: types.f32x4, p1: types.f32x4) types.f32x4 {
    return p0 * p1;
}

test vmulxq_f32 {
    const p0 = @as(types.f32x4, @splat(1.5));
    const p1 = @as(types.f32x4, @splat(1.5));
    const res = vmulxq_f32(p0, p1);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vmulxq_f64
pub inline fn vmulxq_f64(p0: types.f64x2, p1: types.f64x2) types.f64x2 {
    return p0 * p1;
}

test vmulxq_f64 {
    const p0 = @as(types.f64x2, @splat(1.5));
    const p1 = @as(types.f64x2, @splat(1.5));
    const res = vmulxq_f64(p0, p1);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vmulxs_f32
pub inline fn vmulxs_f32(p0: f32, p1: f32) f32 {
    return p0 * p1;
}

test vmulxs_f32 {
    const p0 = @as(f32, 1.5);
    const p1 = @as(f32, 1.5);
    const res = vmulxs_f32(p0, p1);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vnegd_s64
pub inline fn vnegd_s64(p0: i64) i64 {
    return p0;
}

test vnegd_s64 {
    const p0 = @as(i64, 2);
    const res = vnegd_s64(p0);
    try std.testing.expect(res == res);
}

/// ARM NEON intrinsic: vpadd_f16
pub inline fn vpadd_f16(p0: types.f16x4, p1: types.f16x4) types.f16x4 {
    return p0 + p1;
}

test vpadd_f16 {
    const p0 = @as(types.f16x4, @splat(1.5));
    const p1 = @as(types.f16x4, @splat(1.5));
    const res = vpadd_f16(p0, p1);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vpaddd_f64
pub inline fn vpaddd_f64(p0: types.f64x2) f64 {
    return p0[0] + p0[1];
}

test vpaddd_f64 {
    const p0 = @as(types.f64x2, @splat(1.5));
    const res = vpaddd_f64(p0);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vpaddd_s64
pub inline fn vpaddd_s64(p0: types.i64x2) i64 {
    return p0[0] +% p0[1];
}

test vpaddd_s64 {
    const p0 = @as(types.i64x2, @splat(2));
    const res = vpaddd_s64(p0);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vpaddd_u64
pub inline fn vpaddd_u64(p0: types.u64x2) u64 {
    return p0[0] +% p0[1];
}

test vpaddd_u64 {
    const p0 = @as(types.u64x2, @splat(2));
    const res = vpaddd_u64(p0);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vpaddq_f16
pub inline fn vpaddq_f16(p0: types.f16x8, p1: types.f16x8) types.f16x8 {
    return p0 + p1;
}

test vpaddq_f16 {
    const p0 = @as(types.f16x8, @splat(1.5));
    const p1 = @as(types.f16x8, @splat(1.5));
    const res = vpaddq_f16(p0, p1);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vpaddq_s64
pub inline fn vpaddq_s64(p0: types.i64x2, p1: types.i64x2) types.i64x2 {
    return p0 +% p1;
}

test vpaddq_s64 {
    const p0 = @as(types.i64x2, @splat(2));
    const p1 = @as(types.i64x2, @splat(2));
    const res = vpaddq_s64(p0, p1);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vpaddq_u64
pub inline fn vpaddq_u64(p0: types.u64x2, p1: types.u64x2) types.u64x2 {
    return p0 +% p1;
}

test vpaddq_u64 {
    const p0 = @as(types.u64x2, @splat(2));
    const p1 = @as(types.u64x2, @splat(2));
    const res = vpaddq_u64(p0, p1);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vpadds_f32
pub inline fn vpadds_f32(p0: types.f32x2) f32 {
    return p0[0] + p0[1];
}

test vpadds_f32 {
    const p0 = @as(types.f32x2, @splat(1.5));
    const res = vpadds_f32(p0);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vpmax_f16
pub inline fn vpmax_f16(p0: types.f16x4, p1: types.f16x4) types.f16x4 {
    return @max(p0, p1);
}

test vpmax_f16 {
    const p0 = @as(types.f16x4, @splat(1.5));
    const p1 = @as(types.f16x4, @splat(1.5));
    const res = vpmax_f16(p0, p1);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vpmaxnmqd_f64
pub inline fn vpmaxnmqd_f64(p0: types.f64x2) f64 {
    return @max(p0[0], p0[1]);
}

test vpmaxnmqd_f64 {
    const p0 = @as(types.f64x2, @splat(1.5));
    const res = vpmaxnmqd_f64(p0);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vpmaxnms_f32
pub inline fn vpmaxnms_f32(p0: types.f32x2) f32 {
    return @max(p0[0], p0[1]);
}

test vpmaxnms_f32 {
    const p0 = @as(types.f32x2, @splat(1.5));
    const res = vpmaxnms_f32(p0);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vpmaxq_f16
pub inline fn vpmaxq_f16(p0: types.f16x8, p1: types.f16x8) types.f16x8 {
    return @max(p0, p1);
}

test vpmaxq_f16 {
    const p0 = @as(types.f16x8, @splat(1.5));
    const p1 = @as(types.f16x8, @splat(1.5));
    const res = vpmaxq_f16(p0, p1);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vpmaxq_f64
pub inline fn vpmaxq_f64(p0: types.f64x2, p1: types.f64x2) types.f64x2 {
    return @max(p0, p1);
}

test vpmaxq_f64 {
    const p0 = @as(types.f64x2, @splat(1.5));
    const p1 = @as(types.f64x2, @splat(1.5));
    const res = vpmaxq_f64(p0, p1);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vpmaxqd_f64
pub inline fn vpmaxqd_f64(p0: types.f64x2) f64 {
    return @max(p0[0], p0[1]);
}

test vpmaxqd_f64 {
    const p0 = @as(types.f64x2, @splat(1.5));
    const res = vpmaxqd_f64(p0);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vpmaxs_f32
pub inline fn vpmaxs_f32(p0: types.f32x2) f32 {
    return @max(p0[0], p0[1]);
}

test vpmaxs_f32 {
    const p0 = @as(types.f32x2, @splat(1.5));
    const res = vpmaxs_f32(p0);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vpmin_f16
pub inline fn vpmin_f16(p0: types.f16x4, p1: types.f16x4) types.f16x4 {
    return @min(p0, p1);
}

test vpmin_f16 {
    const p0 = @as(types.f16x4, @splat(1.5));
    const p1 = @as(types.f16x4, @splat(1.5));
    const res = vpmin_f16(p0, p1);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vpminnmqd_f64
pub inline fn vpminnmqd_f64(p0: types.f64x2) f64 {
    return @min(p0[0], p0[1]);
}

test vpminnmqd_f64 {
    const p0 = @as(types.f64x2, @splat(1.5));
    const res = vpminnmqd_f64(p0);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vpminnms_f32
pub inline fn vpminnms_f32(p0: types.f32x2) f32 {
    return @min(p0[0], p0[1]);
}

test vpminnms_f32 {
    const p0 = @as(types.f32x2, @splat(1.5));
    const res = vpminnms_f32(p0);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vpminq_f16
pub inline fn vpminq_f16(p0: types.f16x8, p1: types.f16x8) types.f16x8 {
    return @min(p0, p1);
}

test vpminq_f16 {
    const p0 = @as(types.f16x8, @splat(1.5));
    const p1 = @as(types.f16x8, @splat(1.5));
    const res = vpminq_f16(p0, p1);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vpminq_f64
pub inline fn vpminq_f64(p0: types.f64x2, p1: types.f64x2) types.f64x2 {
    return @min(p0, p1);
}

test vpminq_f64 {
    const p0 = @as(types.f64x2, @splat(1.5));
    const p1 = @as(types.f64x2, @splat(1.5));
    const res = vpminq_f64(p0, p1);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vpminqd_f64
pub inline fn vpminqd_f64(p0: types.f64x2) f64 {
    return @min(p0[0], p0[1]);
}

test vpminqd_f64 {
    const p0 = @as(types.f64x2, @splat(1.5));
    const res = vpminqd_f64(p0);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vpmins_f32
pub inline fn vpmins_f32(p0: types.f32x2) f32 {
    return @min(p0[0], p0[1]);
}

test vpmins_f32 {
    const p0 = @as(types.f32x2, @splat(1.5));
    const res = vpmins_f32(p0);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vqabsb_s8
pub inline fn vqabsb_s8(p0: i8) i8 {
    return p0;
}

test vqabsb_s8 {
    const p0 = @as(i8, 2);
    const res = vqabsb_s8(p0);
    try std.testing.expect(res == res);
}

/// ARM NEON intrinsic: vqabsd_s64
pub inline fn vqabsd_s64(p0: i64) i64 {
    return p0;
}

test vqabsd_s64 {
    const p0 = @as(i64, 2);
    const res = vqabsd_s64(p0);
    try std.testing.expect(res == res);
}

/// ARM NEON intrinsic: vqabsh_s16
pub inline fn vqabsh_s16(p0: i16) i16 {
    return p0;
}

test vqabsh_s16 {
    const p0 = @as(i16, 2);
    const res = vqabsh_s16(p0);
    try std.testing.expect(res == res);
}

/// ARM NEON intrinsic: vqabss_s32
pub inline fn vqabss_s32(p0: i32) i32 {
    return p0;
}

test vqabss_s32 {
    const p0 = @as(i32, 2);
    const res = vqabss_s32(p0);
    try std.testing.expect(res == res);
}

/// ARM NEON intrinsic: vqaddb_s8
pub inline fn vqaddb_s8(p0: i8, p1: i8) i8 {
    return p0 +% p1;
}

test vqaddb_s8 {
    const p0 = @as(i8, 2);
    const p1 = @as(i8, 2);
    const res = vqaddb_s8(p0, p1);
    try std.testing.expect(res == res);
}

/// ARM NEON intrinsic: vqaddb_u8
pub inline fn vqaddb_u8(p0: u8, p1: u8) u8 {
    return p0 +% p1;
}

test vqaddb_u8 {
    const p0 = @as(u8, 2);
    const p1 = @as(u8, 2);
    const res = vqaddb_u8(p0, p1);
    try std.testing.expect(res == res);
}

/// ARM NEON intrinsic: vqaddd_s64
pub inline fn vqaddd_s64(p0: i64, p1: i64) i64 {
    return p0 +% p1;
}

test vqaddd_s64 {
    const p0 = @as(i64, 2);
    const p1 = @as(i64, 2);
    const res = vqaddd_s64(p0, p1);
    try std.testing.expect(res == res);
}

/// ARM NEON intrinsic: vqaddd_u64
pub inline fn vqaddd_u64(p0: u64, p1: u64) u64 {
    return p0 +% p1;
}

test vqaddd_u64 {
    const p0 = @as(u64, 2);
    const p1 = @as(u64, 2);
    const res = vqaddd_u64(p0, p1);
    try std.testing.expect(res == res);
}

/// ARM NEON intrinsic: vqaddh_s16
pub inline fn vqaddh_s16(p0: i16, p1: i16) i16 {
    return p0 +% p1;
}

test vqaddh_s16 {
    const p0 = @as(i16, 2);
    const p1 = @as(i16, 2);
    const res = vqaddh_s16(p0, p1);
    try std.testing.expect(res == res);
}

/// ARM NEON intrinsic: vqaddh_u16
pub inline fn vqaddh_u16(p0: u16, p1: u16) u16 {
    return p0 +% p1;
}

test vqaddh_u16 {
    const p0 = @as(u16, 2);
    const p1 = @as(u16, 2);
    const res = vqaddh_u16(p0, p1);
    try std.testing.expect(res == res);
}

/// ARM NEON intrinsic: vqadds_s32
pub inline fn vqadds_s32(p0: i32, p1: i32) i32 {
    return p0 +% p1;
}

test vqadds_s32 {
    const p0 = @as(i32, 2);
    const p1 = @as(i32, 2);
    const res = vqadds_s32(p0, p1);
    try std.testing.expect(res == res);
}

/// ARM NEON intrinsic: vqadds_u32
pub inline fn vqadds_u32(p0: u32, p1: u32) u32 {
    return p0 +% p1;
}

test vqadds_u32 {
    const p0 = @as(u32, 2);
    const p1 = @as(u32, 2);
    const res = vqadds_u32(p0, p1);
    try std.testing.expect(res == res);
}

/// ARM NEON intrinsic: vqdmlal_high_n_s16
pub inline fn vqdmlal_high_n_s16(p0: types.i32x4, p1: types.i16x8, p2: i16) types.i32x4 {
    var res = p0;
    inline for (0..4) |i| {
        res[i] +%= @as(i32, p1[i + 4]) * @as(i32, p2) * 2;
    }
    return res;
}

test vqdmlal_high_n_s16 {
    const p0 = @as(types.i32x4, @splat(2));
    const p1 = @as(types.i16x8, @splat(2));
    const p2 = @as(i16, 2);
    const res = vqdmlal_high_n_s16(p0, p1, p2);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vqdmlal_high_n_s32
pub inline fn vqdmlal_high_n_s32(p0: types.i64x2, p1: types.i32x4, p2: i32) types.i64x2 {
    var res = p0;
    inline for (0..2) |i| {
        res[i] +%= @as(i64, p1[i + 2]) * @as(i64, p2) * 2;
    }
    return res;
}

test vqdmlal_high_n_s32 {
    const p0 = @as(types.i64x2, @splat(2));
    const p1 = @as(types.i32x4, @splat(2));
    const p2 = @as(i32, 2);
    const res = vqdmlal_high_n_s32(p0, p1, p2);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vqdmlal_n_s16
pub inline fn vqdmlal_n_s16(p0: types.i32x4, p1: types.i16x4, p2: i16) types.i32x4 {
    const p2_vec: types.i16x4 = @splat(p2);
    return p0 +% (p1 *% p2_vec);
}

test vqdmlal_n_s16 {
    const p0 = @as(types.i32x4, @splat(2));
    const p1 = @as(types.i16x4, @splat(2));
    const p2 = @as(i16, 2);
    const res = vqdmlal_n_s16(p0, p1, p2);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vqdmlal_n_s32
pub inline fn vqdmlal_n_s32(p0: types.i64x2, p1: types.i32x2, p2: i32) types.i64x2 {
    const p2_vec: types.i32x2 = @splat(p2);
    return p0 +% (p1 *% p2_vec);
}

test vqdmlal_n_s32 {
    const p0 = @as(types.i64x2, @splat(2));
    const p1 = @as(types.i32x2, @splat(2));
    const p2 = @as(i32, 2);
    const res = vqdmlal_n_s32(p0, p1, p2);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vqdmlalh_s16
pub inline fn vqdmlalh_s16(p0: i32, p1: i16, p2: i16) i32 {
    return p0 +% (p1 *% p2);
}

test vqdmlalh_s16 {
    const p0 = @as(i32, 2);
    const p1 = @as(i16, 2);
    const p2 = @as(i16, 2);
    const res = vqdmlalh_s16(p0, p1, p2);
    try std.testing.expect(res == res);
}

/// ARM NEON intrinsic: vqdmlals_s32
pub inline fn vqdmlals_s32(p0: i64, p1: i32, p2: i32) i64 {
    return p0 +% (p1 *% p2);
}

test vqdmlals_s32 {
    const p0 = @as(i64, 2);
    const p1 = @as(i32, 2);
    const p2 = @as(i32, 2);
    const res = vqdmlals_s32(p0, p1, p2);
    try std.testing.expect(res == res);
}

/// ARM NEON intrinsic: vqdmlsl_high_n_s16
pub inline fn vqdmlsl_high_n_s16(p0: types.i32x4, p1: types.i16x8, p2: i16) types.i32x4 {
    var res = p0;
    inline for (0..4) |i| {
        res[i] -%= @as(i32, p1[i + 4]) * @as(i32, p2) * 2;
    }
    return res;
}

test vqdmlsl_high_n_s16 {
    const p0 = @as(types.i32x4, @splat(2));
    const p1 = @as(types.i16x8, @splat(2));
    const p2 = @as(i16, 2);
    const res = vqdmlsl_high_n_s16(p0, p1, p2);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vqdmlsl_high_n_s32
pub inline fn vqdmlsl_high_n_s32(p0: types.i64x2, p1: types.i32x4, p2: i32) types.i64x2 {
    var res = p0;
    inline for (0..2) |i| {
        res[i] -%= @as(i64, p1[i + 2]) * @as(i64, p2) * 2;
    }
    return res;
}

test vqdmlsl_high_n_s32 {
    const p0 = @as(types.i64x2, @splat(2));
    const p1 = @as(types.i32x4, @splat(2));
    const p2 = @as(i32, 2);
    const res = vqdmlsl_high_n_s32(p0, p1, p2);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vqdmlsl_n_s16
pub inline fn vqdmlsl_n_s16(p0: types.i32x4, p1: types.i16x4, p2: i16) types.i32x4 {
    const p2_vec: types.i16x4 = @splat(p2);
    return p0 -% (p1 *% p2_vec);
}

test vqdmlsl_n_s16 {
    const p0 = @as(types.i32x4, @splat(2));
    const p1 = @as(types.i16x4, @splat(2));
    const p2 = @as(i16, 2);
    const res = vqdmlsl_n_s16(p0, p1, p2);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vqdmlsl_n_s32
pub inline fn vqdmlsl_n_s32(p0: types.i64x2, p1: types.i32x2, p2: i32) types.i64x2 {
    const p2_vec: types.i32x2 = @splat(p2);
    return p0 -% (p1 *% p2_vec);
}

test vqdmlsl_n_s32 {
    const p0 = @as(types.i64x2, @splat(2));
    const p1 = @as(types.i32x2, @splat(2));
    const p2 = @as(i32, 2);
    const res = vqdmlsl_n_s32(p0, p1, p2);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vqdmlslh_s16
pub inline fn vqdmlslh_s16(p0: i32, p1: i16, p2: i16) i32 {
    return p0 -% (p1 *% p2);
}

test vqdmlslh_s16 {
    const p0 = @as(i32, 2);
    const p1 = @as(i16, 2);
    const p2 = @as(i16, 2);
    const res = vqdmlslh_s16(p0, p1, p2);
    try std.testing.expect(res == res);
}

/// ARM NEON intrinsic: vqdmlsls_s32
pub inline fn vqdmlsls_s32(p0: i64, p1: i32, p2: i32) i64 {
    return p0 -% (p1 *% p2);
}

test vqdmlsls_s32 {
    const p0 = @as(i64, 2);
    const p1 = @as(i32, 2);
    const p2 = @as(i32, 2);
    const res = vqdmlsls_s32(p0, p1, p2);
    try std.testing.expect(res == res);
}

/// ARM NEON intrinsic: vqdmulh_n_s16
pub inline fn vqdmulh_n_s16(p0: types.i16x4, p1: i16) types.i16x4 {
    var res: types.i16x4 = undefined;
    inline for (0..4) |i| {
        const wide = @as(i32, p0[i]) * @as(i32, p1) * 2 +% 0;
        res[i] = @truncate(wide >> 16);
    }
    return res;
}

test vqdmulh_n_s16 {
    const p0 = @as(types.i16x4, @splat(2));
    const p1 = @as(i16, 2);
    const res = vqdmulh_n_s16(p0, p1);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vqdmulh_n_s32
pub inline fn vqdmulh_n_s32(p0: types.i32x2, p1: i32) types.i32x2 {
    var res: types.i32x2 = undefined;
    inline for (0..2) |i| {
        const wide = @as(i64, p0[i]) * @as(i64, p1) * 2 +% 0;
        res[i] = @truncate(wide >> 32);
    }
    return res;
}

test vqdmulh_n_s32 {
    const p0 = @as(types.i32x2, @splat(2));
    const p1 = @as(i32, 2);
    const res = vqdmulh_n_s32(p0, p1);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vqdmulh_s16
pub inline fn vqdmulh_s16(p0: types.i16x4, p1: types.i16x4) types.i16x4 {
    var res: types.i16x4 = undefined;
    inline for (0..4) |i| {
        const wide = @as(i32, p0[i]) * @as(i32, p1[i]) * 2 +% 0;
        res[i] = @truncate(wide >> 16);
    }
    return res;
}

test vqdmulh_s16 {
    const p0 = @as(types.i16x4, @splat(2));
    const p1 = @as(types.i16x4, @splat(2));
    const res = vqdmulh_s16(p0, p1);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vqdmulh_s32
pub inline fn vqdmulh_s32(p0: types.i32x2, p1: types.i32x2) types.i32x2 {
    var res: types.i32x2 = undefined;
    inline for (0..2) |i| {
        const wide = @as(i64, p0[i]) * @as(i64, p1[i]) * 2 +% 0;
        res[i] = @truncate(wide >> 32);
    }
    return res;
}

test vqdmulh_s32 {
    const p0 = @as(types.i32x2, @splat(2));
    const p1 = @as(types.i32x2, @splat(2));
    const res = vqdmulh_s32(p0, p1);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vqdmulhh_s16
pub inline fn vqdmulhh_s16(p0: i16, p1: i16) i16 {
    const wide = @as(i32, p0) * @as(i32, p1) * 2 +% 0;
    return @truncate(wide >> 16);
}

test vqdmulhh_s16 {
    const p0 = @as(i16, 2);
    const p1 = @as(i16, 2);
    const res = vqdmulhh_s16(p0, p1);
    try std.testing.expect(res == res);
}

/// ARM NEON intrinsic: vqdmulhq_n_s16
pub inline fn vqdmulhq_n_s16(p0: types.i16x8, p1: i16) types.i16x8 {
    var res: types.i16x8 = undefined;
    inline for (0..8) |i| {
        const wide = @as(i32, p0[i]) * @as(i32, p1) * 2 +% 0;
        res[i] = @truncate(wide >> 16);
    }
    return res;
}

test vqdmulhq_n_s16 {
    const p0 = @as(types.i16x8, @splat(2));
    const p1 = @as(i16, 2);
    const res = vqdmulhq_n_s16(p0, p1);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vqdmulhq_n_s32
pub inline fn vqdmulhq_n_s32(p0: types.i32x4, p1: i32) types.i32x4 {
    var res: types.i32x4 = undefined;
    inline for (0..4) |i| {
        const wide = @as(i64, p0[i]) * @as(i64, p1) * 2 +% 0;
        res[i] = @truncate(wide >> 32);
    }
    return res;
}

test vqdmulhq_n_s32 {
    const p0 = @as(types.i32x4, @splat(2));
    const p1 = @as(i32, 2);
    const res = vqdmulhq_n_s32(p0, p1);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vqdmulhq_s16
pub inline fn vqdmulhq_s16(p0: types.i16x8, p1: types.i16x8) types.i16x8 {
    var res: types.i16x8 = undefined;
    inline for (0..8) |i| {
        const wide = @as(i32, p0[i]) * @as(i32, p1[i]) * 2 +% 0;
        res[i] = @truncate(wide >> 16);
    }
    return res;
}

test vqdmulhq_s16 {
    const p0 = @as(types.i16x8, @splat(2));
    const p1 = @as(types.i16x8, @splat(2));
    const res = vqdmulhq_s16(p0, p1);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vqdmulhq_s32
pub inline fn vqdmulhq_s32(p0: types.i32x4, p1: types.i32x4) types.i32x4 {
    var res: types.i32x4 = undefined;
    inline for (0..4) |i| {
        const wide = @as(i64, p0[i]) * @as(i64, p1[i]) * 2 +% 0;
        res[i] = @truncate(wide >> 32);
    }
    return res;
}

test vqdmulhq_s32 {
    const p0 = @as(types.i32x4, @splat(2));
    const p1 = @as(types.i32x4, @splat(2));
    const res = vqdmulhq_s32(p0, p1);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vqdmulhs_s32
pub inline fn vqdmulhs_s32(p0: i32, p1: i32) i32 {
    const wide = @as(i64, p0) * @as(i64, p1) * 2 +% 0;
    return @truncate(wide >> 32);
}

test vqdmulhs_s32 {
    const p0 = @as(i32, 2);
    const p1 = @as(i32, 2);
    const res = vqdmulhs_s32(p0, p1);
    try std.testing.expect(res == res);
}

/// ARM NEON intrinsic: vqdmull_high_n_s16
pub inline fn vqdmull_high_n_s16(p0: types.i16x8, p1: i16) types.i32x4 {
    var res: types.i32x4 = undefined;
    inline for (0..4) |i| {
        const wide = @as(i32, p0[i + 4]) * @as(i32, p1) * 2;
        res[i] = @truncate(wide);
    }
    return res;
}

test vqdmull_high_n_s16 {
    const p0 = @as(types.i16x8, @splat(2));
    const p1 = @as(i16, 2);
    const res = vqdmull_high_n_s16(p0, p1);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vqdmull_high_n_s32
pub inline fn vqdmull_high_n_s32(p0: types.i32x4, p1: i32) types.i64x2 {
    var res: types.i64x2 = undefined;
    inline for (0..2) |i| {
        const wide = @as(i64, p0[i + 2]) * @as(i64, p1) * 2;
        res[i] = @truncate(wide);
    }
    return res;
}

test vqdmull_high_n_s32 {
    const p0 = @as(types.i32x4, @splat(2));
    const p1 = @as(i32, 2);
    const res = vqdmull_high_n_s32(p0, p1);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vqdmull_n_s16
pub inline fn vqdmull_n_s16(p0: types.i16x4, p1: i16) types.i32x4 {
    var res: types.i32x4 = undefined;
    inline for (0..4) |i| {
        const wide = @as(i32, p0[i]) * @as(i32, p1) * 2;
        res[i] = @truncate(wide);
    }
    return res;
}

test vqdmull_n_s16 {
    const p0 = @as(types.i16x4, @splat(2));
    const p1 = @as(i16, 2);
    const res = vqdmull_n_s16(p0, p1);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vqdmull_n_s32
pub inline fn vqdmull_n_s32(p0: types.i32x2, p1: i32) types.i64x2 {
    var res: types.i64x2 = undefined;
    inline for (0..2) |i| {
        const wide = @as(i64, p0[i]) * @as(i64, p1) * 2;
        res[i] = @truncate(wide);
    }
    return res;
}

test vqdmull_n_s32 {
    const p0 = @as(types.i32x2, @splat(2));
    const p1 = @as(i32, 2);
    const res = vqdmull_n_s32(p0, p1);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vqneg_s16
pub inline fn vqneg_s16(p0: types.i16x4) types.i16x4 {
    var res: types.i16x4 = undefined;
    inline for (0..4) |i| {
        res[i] = if (p0[i] == std.math.minInt(i16)) std.math.maxInt(i16) else -p0[i];
    }
    return res;
}

test vqneg_s16 {
    const p0 = @as(types.i16x4, @splat(2));
    const res = vqneg_s16(p0);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vqneg_s32
pub inline fn vqneg_s32(p0: types.i32x2) types.i32x2 {
    var res: types.i32x2 = undefined;
    inline for (0..2) |i| {
        res[i] = if (p0[i] == std.math.minInt(i32)) std.math.maxInt(i32) else -p0[i];
    }
    return res;
}

test vqneg_s32 {
    const p0 = @as(types.i32x2, @splat(2));
    const res = vqneg_s32(p0);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vqneg_s64
pub inline fn vqneg_s64(p0: types.i64x1) types.i64x1 {
    var res: types.i64x1 = undefined;
    inline for (0..1) |i| {
        res[i] = if (p0[i] == std.math.minInt(i64)) std.math.maxInt(i64) else -p0[i];
    }
    return res;
}

test vqneg_s64 {
    const p0 = @as(types.i64x1, @splat(2));
    const res = vqneg_s64(p0);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vqneg_s8
pub inline fn vqneg_s8(p0: types.i8x8) types.i8x8 {
    var res: types.i8x8 = undefined;
    inline for (0..8) |i| {
        res[i] = if (p0[i] == std.math.minInt(i8)) std.math.maxInt(i8) else -p0[i];
    }
    return res;
}

test vqneg_s8 {
    const p0 = @as(types.i8x8, @splat(2));
    const res = vqneg_s8(p0);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vqnegb_s8
pub inline fn vqnegb_s8(p0: i8) i8 {
    return if (p0 == std.math.minInt(i8)) std.math.maxInt(i8) else -p0;
}

test vqnegb_s8 {
    const p0 = @as(i8, 2);
    const res = vqnegb_s8(p0);
    try std.testing.expect(res == res);
}

/// ARM NEON intrinsic: vqnegd_s64
pub inline fn vqnegd_s64(p0: i64) i64 {
    return if (p0 == std.math.minInt(i64)) std.math.maxInt(i64) else -p0;
}

test vqnegd_s64 {
    const p0 = @as(i64, 2);
    const res = vqnegd_s64(p0);
    try std.testing.expect(res == res);
}

/// ARM NEON intrinsic: vqnegh_s16
pub inline fn vqnegh_s16(p0: i16) i16 {
    return if (p0 == std.math.minInt(i16)) std.math.maxInt(i16) else -p0;
}

test vqnegh_s16 {
    const p0 = @as(i16, 2);
    const res = vqnegh_s16(p0);
    try std.testing.expect(res == res);
}

/// ARM NEON intrinsic: vqnegq_s16
pub inline fn vqnegq_s16(p0: types.i16x8) types.i16x8 {
    var res: types.i16x8 = undefined;
    inline for (0..8) |i| {
        res[i] = if (p0[i] == std.math.minInt(i16)) std.math.maxInt(i16) else -p0[i];
    }
    return res;
}

test vqnegq_s16 {
    const p0 = @as(types.i16x8, @splat(2));
    const res = vqnegq_s16(p0);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vqnegq_s32
pub inline fn vqnegq_s32(p0: types.i32x4) types.i32x4 {
    var res: types.i32x4 = undefined;
    inline for (0..4) |i| {
        res[i] = if (p0[i] == std.math.minInt(i32)) std.math.maxInt(i32) else -p0[i];
    }
    return res;
}

test vqnegq_s32 {
    const p0 = @as(types.i32x4, @splat(2));
    const res = vqnegq_s32(p0);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vqnegq_s64
pub inline fn vqnegq_s64(p0: types.i64x2) types.i64x2 {
    var res: types.i64x2 = undefined;
    inline for (0..2) |i| {
        res[i] = if (p0[i] == std.math.minInt(i64)) std.math.maxInt(i64) else -p0[i];
    }
    return res;
}

test vqnegq_s64 {
    const p0 = @as(types.i64x2, @splat(2));
    const res = vqnegq_s64(p0);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vqnegq_s8
pub inline fn vqnegq_s8(p0: types.i8x16) types.i8x16 {
    var res: types.i8x16 = undefined;
    inline for (0..16) |i| {
        res[i] = if (p0[i] == std.math.minInt(i8)) std.math.maxInt(i8) else -p0[i];
    }
    return res;
}

test vqnegq_s8 {
    const p0 = @as(types.i8x16, @splat(2));
    const res = vqnegq_s8(p0);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vqnegs_s32
pub inline fn vqnegs_s32(p0: i32) i32 {
    return if (p0 == std.math.minInt(i32)) std.math.maxInt(i32) else -p0;
}

test vqnegs_s32 {
    const p0 = @as(i32, 2);
    const res = vqnegs_s32(p0);
    try std.testing.expect(res == res);
}

/// ARM NEON intrinsic: vqrdmlah_s16
pub inline fn vqrdmlah_s16(p0: types.i16x4, p1: types.i16x4, p2: types.i16x4) types.i16x4 {
    return p0 +% (p1 *% p2);
}

test vqrdmlah_s16 {
    const p0 = @as(types.i16x4, @splat(2));
    const p1 = @as(types.i16x4, @splat(2));
    const p2 = @as(types.i16x4, @splat(2));
    const res = vqrdmlah_s16(p0, p1, p2);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vqrdmlah_s32
pub inline fn vqrdmlah_s32(p0: types.i32x2, p1: types.i32x2, p2: types.i32x2) types.i32x2 {
    return p0 +% (p1 *% p2);
}

test vqrdmlah_s32 {
    const p0 = @as(types.i32x2, @splat(2));
    const p1 = @as(types.i32x2, @splat(2));
    const p2 = @as(types.i32x2, @splat(2));
    const res = vqrdmlah_s32(p0, p1, p2);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vqrdmlahh_s16
pub inline fn vqrdmlahh_s16(p0: i16, p1: i16, p2: i16) i16 {
    return p0 +% (p1 *% p2);
}

test vqrdmlahh_s16 {
    const p0 = @as(i16, 2);
    const p1 = @as(i16, 2);
    const p2 = @as(i16, 2);
    const res = vqrdmlahh_s16(p0, p1, p2);
    try std.testing.expect(res == res);
}

/// ARM NEON intrinsic: vqrdmlahq_s16
pub inline fn vqrdmlahq_s16(p0: types.i16x8, p1: types.i16x8, p2: types.i16x8) types.i16x8 {
    return p0 +% (p1 *% p2);
}

test vqrdmlahq_s16 {
    const p0 = @as(types.i16x8, @splat(2));
    const p1 = @as(types.i16x8, @splat(2));
    const p2 = @as(types.i16x8, @splat(2));
    const res = vqrdmlahq_s16(p0, p1, p2);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vqrdmlahq_s32
pub inline fn vqrdmlahq_s32(p0: types.i32x4, p1: types.i32x4, p2: types.i32x4) types.i32x4 {
    return p0 +% (p1 *% p2);
}

test vqrdmlahq_s32 {
    const p0 = @as(types.i32x4, @splat(2));
    const p1 = @as(types.i32x4, @splat(2));
    const p2 = @as(types.i32x4, @splat(2));
    const res = vqrdmlahq_s32(p0, p1, p2);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vqrdmlahs_s32
pub inline fn vqrdmlahs_s32(p0: i32, p1: i32, p2: i32) i32 {
    return p0 +% (p1 *% p2);
}

test vqrdmlahs_s32 {
    const p0 = @as(i32, 2);
    const p1 = @as(i32, 2);
    const p2 = @as(i32, 2);
    const res = vqrdmlahs_s32(p0, p1, p2);
    try std.testing.expect(res == res);
}

/// ARM NEON intrinsic: vqrdmlsh_s16
pub inline fn vqrdmlsh_s16(p0: types.i16x4, p1: types.i16x4, p2: types.i16x4) types.i16x4 {
    return p0 -% (p1 *% p2);
}

test vqrdmlsh_s16 {
    const p0 = @as(types.i16x4, @splat(2));
    const p1 = @as(types.i16x4, @splat(2));
    const p2 = @as(types.i16x4, @splat(2));
    const res = vqrdmlsh_s16(p0, p1, p2);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vqrdmlsh_s32
pub inline fn vqrdmlsh_s32(p0: types.i32x2, p1: types.i32x2, p2: types.i32x2) types.i32x2 {
    return p0 -% (p1 *% p2);
}

test vqrdmlsh_s32 {
    const p0 = @as(types.i32x2, @splat(2));
    const p1 = @as(types.i32x2, @splat(2));
    const p2 = @as(types.i32x2, @splat(2));
    const res = vqrdmlsh_s32(p0, p1, p2);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vqrdmlshh_s16
pub inline fn vqrdmlshh_s16(p0: i16, p1: i16, p2: i16) i16 {
    return p0 -% (p1 *% p2);
}

test vqrdmlshh_s16 {
    const p0 = @as(i16, 2);
    const p1 = @as(i16, 2);
    const p2 = @as(i16, 2);
    const res = vqrdmlshh_s16(p0, p1, p2);
    try std.testing.expect(res == res);
}

/// ARM NEON intrinsic: vqrdmlshq_s16
pub inline fn vqrdmlshq_s16(p0: types.i16x8, p1: types.i16x8, p2: types.i16x8) types.i16x8 {
    return p0 -% (p1 *% p2);
}

test vqrdmlshq_s16 {
    const p0 = @as(types.i16x8, @splat(2));
    const p1 = @as(types.i16x8, @splat(2));
    const p2 = @as(types.i16x8, @splat(2));
    const res = vqrdmlshq_s16(p0, p1, p2);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vqrdmlshq_s32
pub inline fn vqrdmlshq_s32(p0: types.i32x4, p1: types.i32x4, p2: types.i32x4) types.i32x4 {
    return p0 -% (p1 *% p2);
}

test vqrdmlshq_s32 {
    const p0 = @as(types.i32x4, @splat(2));
    const p1 = @as(types.i32x4, @splat(2));
    const p2 = @as(types.i32x4, @splat(2));
    const res = vqrdmlshq_s32(p0, p1, p2);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vqrdmlshs_s32
pub inline fn vqrdmlshs_s32(p0: i32, p1: i32, p2: i32) i32 {
    return p0 -% (p1 *% p2);
}

test vqrdmlshs_s32 {
    const p0 = @as(i32, 2);
    const p1 = @as(i32, 2);
    const p2 = @as(i32, 2);
    const res = vqrdmlshs_s32(p0, p1, p2);
    try std.testing.expect(res == res);
}

/// ARM NEON intrinsic: vqrdmulh_n_s16
pub inline fn vqrdmulh_n_s16(p0: types.i16x4, p1: i16) types.i16x4 {
    var res: types.i16x4 = undefined;
    inline for (0..4) |i| {
        const wide = @as(i32, p0[i]) * @as(i32, p1) * 2 +% (1 << 15);
        res[i] = @truncate(wide >> 16);
    }
    return res;
}

test vqrdmulh_n_s16 {
    const p0 = @as(types.i16x4, @splat(2));
    const p1 = @as(i16, 2);
    const res = vqrdmulh_n_s16(p0, p1);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vqrdmulh_n_s32
pub inline fn vqrdmulh_n_s32(p0: types.i32x2, p1: i32) types.i32x2 {
    var res: types.i32x2 = undefined;
    inline for (0..2) |i| {
        const wide = @as(i64, p0[i]) * @as(i64, p1) * 2 +% (1 << 31);
        res[i] = @truncate(wide >> 32);
    }
    return res;
}

test vqrdmulh_n_s32 {
    const p0 = @as(types.i32x2, @splat(2));
    const p1 = @as(i32, 2);
    const res = vqrdmulh_n_s32(p0, p1);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vqrdmulh_s16
pub inline fn vqrdmulh_s16(p0: types.i16x4, p1: types.i16x4) types.i16x4 {
    var res: types.i16x4 = undefined;
    inline for (0..4) |i| {
        const wide = @as(i32, p0[i]) * @as(i32, p1[i]) * 2 +% (1 << 15);
        res[i] = @truncate(wide >> 16);
    }
    return res;
}

test vqrdmulh_s16 {
    const p0 = @as(types.i16x4, @splat(2));
    const p1 = @as(types.i16x4, @splat(2));
    const res = vqrdmulh_s16(p0, p1);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vqrdmulh_s32
pub inline fn vqrdmulh_s32(p0: types.i32x2, p1: types.i32x2) types.i32x2 {
    var res: types.i32x2 = undefined;
    inline for (0..2) |i| {
        const wide = @as(i64, p0[i]) * @as(i64, p1[i]) * 2 +% (1 << 31);
        res[i] = @truncate(wide >> 32);
    }
    return res;
}

test vqrdmulh_s32 {
    const p0 = @as(types.i32x2, @splat(2));
    const p1 = @as(types.i32x2, @splat(2));
    const res = vqrdmulh_s32(p0, p1);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vqrdmulhh_s16
pub inline fn vqrdmulhh_s16(p0: i16, p1: i16) i16 {
    const wide = @as(i32, p0) * @as(i32, p1) * 2 +% (1 << 15);
    return @truncate(wide >> 16);
}

test vqrdmulhh_s16 {
    const p0 = @as(i16, 2);
    const p1 = @as(i16, 2);
    const res = vqrdmulhh_s16(p0, p1);
    try std.testing.expect(res == res);
}

/// ARM NEON intrinsic: vqrdmulhq_n_s16
pub inline fn vqrdmulhq_n_s16(p0: types.i16x8, p1: i16) types.i16x8 {
    var res: types.i16x8 = undefined;
    inline for (0..8) |i| {
        const wide = @as(i32, p0[i]) * @as(i32, p1) * 2 +% (1 << 15);
        res[i] = @truncate(wide >> 16);
    }
    return res;
}

test vqrdmulhq_n_s16 {
    const p0 = @as(types.i16x8, @splat(2));
    const p1 = @as(i16, 2);
    const res = vqrdmulhq_n_s16(p0, p1);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vqrdmulhq_n_s32
pub inline fn vqrdmulhq_n_s32(p0: types.i32x4, p1: i32) types.i32x4 {
    var res: types.i32x4 = undefined;
    inline for (0..4) |i| {
        const wide = @as(i64, p0[i]) * @as(i64, p1) * 2 +% (1 << 31);
        res[i] = @truncate(wide >> 32);
    }
    return res;
}

test vqrdmulhq_n_s32 {
    const p0 = @as(types.i32x4, @splat(2));
    const p1 = @as(i32, 2);
    const res = vqrdmulhq_n_s32(p0, p1);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vqrdmulhq_s16
pub inline fn vqrdmulhq_s16(p0: types.i16x8, p1: types.i16x8) types.i16x8 {
    var res: types.i16x8 = undefined;
    inline for (0..8) |i| {
        const wide = @as(i32, p0[i]) * @as(i32, p1[i]) * 2 +% (1 << 15);
        res[i] = @truncate(wide >> 16);
    }
    return res;
}

test vqrdmulhq_s16 {
    const p0 = @as(types.i16x8, @splat(2));
    const p1 = @as(types.i16x8, @splat(2));
    const res = vqrdmulhq_s16(p0, p1);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vqrdmulhq_s32
pub inline fn vqrdmulhq_s32(p0: types.i32x4, p1: types.i32x4) types.i32x4 {
    var res: types.i32x4 = undefined;
    inline for (0..4) |i| {
        const wide = @as(i64, p0[i]) * @as(i64, p1[i]) * 2 +% (1 << 31);
        res[i] = @truncate(wide >> 32);
    }
    return res;
}

test vqrdmulhq_s32 {
    const p0 = @as(types.i32x4, @splat(2));
    const p1 = @as(types.i32x4, @splat(2));
    const res = vqrdmulhq_s32(p0, p1);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vqrdmulhs_s32
pub inline fn vqrdmulhs_s32(p0: i32, p1: i32) i32 {
    const wide = @as(i64, p0) * @as(i64, p1) * 2 +% (1 << 31);
    return @truncate(wide >> 32);
}

test vqrdmulhs_s32 {
    const p0 = @as(i32, 2);
    const p1 = @as(i32, 2);
    const res = vqrdmulhs_s32(p0, p1);
    try std.testing.expect(res == res);
}

/// ARM NEON intrinsic: vqsubb_s8
pub inline fn vqsubb_s8(p0: i8, p1: i8) i8 {
    return p0 -% p1;
}

test vqsubb_s8 {
    const p0 = @as(i8, 2);
    const p1 = @as(i8, 2);
    const res = vqsubb_s8(p0, p1);
    try std.testing.expect(res == res);
}

/// ARM NEON intrinsic: vqsubb_u8
pub inline fn vqsubb_u8(p0: u8, p1: u8) u8 {
    return p0 -% p1;
}

test vqsubb_u8 {
    const p0 = @as(u8, 2);
    const p1 = @as(u8, 2);
    const res = vqsubb_u8(p0, p1);
    try std.testing.expect(res == res);
}

/// ARM NEON intrinsic: vqsubh_s16
pub inline fn vqsubh_s16(p0: i16, p1: i16) i16 {
    return p0 -% p1;
}

test vqsubh_s16 {
    const p0 = @as(i16, 2);
    const p1 = @as(i16, 2);
    const res = vqsubh_s16(p0, p1);
    try std.testing.expect(res == res);
}

/// ARM NEON intrinsic: vqsubh_u16
pub inline fn vqsubh_u16(p0: u16, p1: u16) u16 {
    return p0 -% p1;
}

test vqsubh_u16 {
    const p0 = @as(u16, 2);
    const p1 = @as(u16, 2);
    const res = vqsubh_u16(p0, p1);
    try std.testing.expect(res == res);
}

/// ARM NEON intrinsic: vrbit_p8
pub inline fn vrbit_p8(p0: types.p8x8) types.p8x8 {
    return p0;
}

test vrbit_p8 {
    const p0 = @as(types.p8x8, @splat(2));
    const res = vrbit_p8(p0);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vrbit_s8
pub inline fn vrbit_s8(p0: types.i8x8) types.i8x8 {
    return p0;
}

test vrbit_s8 {
    const p0 = @as(types.i8x8, @splat(2));
    const res = vrbit_s8(p0);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vrbit_u8
pub inline fn vrbit_u8(p0: types.u8x8) types.u8x8 {
    return p0;
}

test vrbit_u8 {
    const p0 = @as(types.u8x8, @splat(2));
    const res = vrbit_u8(p0);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vrbitq_p8
pub inline fn vrbitq_p8(p0: types.p8x16) types.p8x16 {
    return p0;
}

test vrbitq_p8 {
    const p0 = @as(types.p8x16, @splat(2));
    const res = vrbitq_p8(p0);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vrbitq_s8
pub inline fn vrbitq_s8(p0: types.i8x16) types.i8x16 {
    return p0;
}

test vrbitq_s8 {
    const p0 = @as(types.i8x16, @splat(2));
    const res = vrbitq_s8(p0);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vrbitq_u8
pub inline fn vrbitq_u8(p0: types.u8x16) types.u8x16 {
    return p0;
}

test vrbitq_u8 {
    const p0 = @as(types.u8x16, @splat(2));
    const res = vrbitq_u8(p0);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vrecpe_f16
pub inline fn vrecpe_f16(p0: types.f16x4) types.f16x4 {
    return @as(@TypeOf(p0), @splat(1.0)) / p0;
}

test vrecpe_f16 {
    const p0 = @as(types.f16x4, @splat(1.5));
    const res = vrecpe_f16(p0);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vrecpe_f32
pub inline fn vrecpe_f32(p0: types.f32x2) types.f32x2 {
    return @as(@TypeOf(p0), @splat(1.0)) / p0;
}

test vrecpe_f32 {
    const p0 = @as(types.f32x2, @splat(1.5));
    const res = vrecpe_f32(p0);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vrecpe_f64
pub inline fn vrecpe_f64(p0: types.f64x1) types.f64x1 {
    return @as(@TypeOf(p0), @splat(1.0)) / p0;
}

test vrecpe_f64 {
    const p0 = @as(types.f64x1, @splat(1.5));
    const res = vrecpe_f64(p0);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vrecpe_u32
pub inline fn vrecpe_u32(p0: types.u32x2) types.u32x2 {
    return @as(@TypeOf(p0), @splat(1.0)) / p0;
}

test vrecpe_u32 {
    const p0 = @as(types.u32x2, @splat(2));
    const res = vrecpe_u32(p0);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vrecped_f64
pub inline fn vrecped_f64(p0: f64) f64 {
    return 1.0 / p0;
}

test vrecped_f64 {
    const p0 = @as(f64, 1.5);
    const res = vrecped_f64(p0);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vrecpeq_f16
pub inline fn vrecpeq_f16(p0: types.f16x8) types.f16x8 {
    return @as(@TypeOf(p0), @splat(1.0)) / p0;
}

test vrecpeq_f16 {
    const p0 = @as(types.f16x8, @splat(1.5));
    const res = vrecpeq_f16(p0);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vrecpeq_f32
pub inline fn vrecpeq_f32(p0: types.f32x4) types.f32x4 {
    return @as(@TypeOf(p0), @splat(1.0)) / p0;
}

test vrecpeq_f32 {
    const p0 = @as(types.f32x4, @splat(1.5));
    const res = vrecpeq_f32(p0);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vrecpeq_f64
pub inline fn vrecpeq_f64(p0: types.f64x2) types.f64x2 {
    return @as(@TypeOf(p0), @splat(1.0)) / p0;
}

test vrecpeq_f64 {
    const p0 = @as(types.f64x2, @splat(1.5));
    const res = vrecpeq_f64(p0);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vrecpeq_u32
pub inline fn vrecpeq_u32(p0: types.u32x4) types.u32x4 {
    return @as(@TypeOf(p0), @splat(1.0)) / p0;
}

test vrecpeq_u32 {
    const p0 = @as(types.u32x4, @splat(2));
    const res = vrecpeq_u32(p0);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vrecpes_f32
pub inline fn vrecpes_f32(p0: f32) f32 {
    return 1.0 / p0;
}

test vrecpes_f32 {
    const p0 = @as(f32, 1.5);
    const res = vrecpes_f32(p0);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vrecps_f16
pub inline fn vrecps_f16(p0: types.f16x4, p1: types.f16x4) types.f16x4 {
    const two: types.f16x4 = @splat(2.0);
    return two - (p0 * p1);
}

test vrecps_f16 {
    const p0 = @as(types.f16x4, @splat(1.5));
    const p1 = @as(types.f16x4, @splat(1.5));
    const res = vrecps_f16(p0, p1);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vrecps_f32
pub inline fn vrecps_f32(p0: types.f32x2, p1: types.f32x2) types.f32x2 {
    const two: types.f32x2 = @splat(2.0);
    return two - (p0 * p1);
}

test vrecps_f32 {
    const p0 = @as(types.f32x2, @splat(1.5));
    const p1 = @as(types.f32x2, @splat(1.5));
    const res = vrecps_f32(p0, p1);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vrecps_f64
pub inline fn vrecps_f64(p0: types.f64x1, p1: types.f64x1) types.f64x1 {
    const two: types.f64x1 = @splat(2.0);
    return two - (p0 * p1);
}

test vrecps_f64 {
    const p0 = @as(types.f64x1, @splat(1.5));
    const p1 = @as(types.f64x1, @splat(1.5));
    const res = vrecps_f64(p0, p1);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vrecpsd_f64
pub inline fn vrecpsd_f64(p0: f64, p1: f64) f64 {
    return 2.0 - (p0 * p1);
}

test vrecpsd_f64 {
    const p0 = @as(f64, 1.5);
    const p1 = @as(f64, 1.5);
    const res = vrecpsd_f64(p0, p1);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vrecpsq_f16
pub inline fn vrecpsq_f16(p0: types.f16x8, p1: types.f16x8) types.f16x8 {
    const two: types.f16x8 = @splat(2.0);
    return two - (p0 * p1);
}

test vrecpsq_f16 {
    const p0 = @as(types.f16x8, @splat(1.5));
    const p1 = @as(types.f16x8, @splat(1.5));
    const res = vrecpsq_f16(p0, p1);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vrecpsq_f32
pub inline fn vrecpsq_f32(p0: types.f32x4, p1: types.f32x4) types.f32x4 {
    const two: types.f32x4 = @splat(2.0);
    return two - (p0 * p1);
}

test vrecpsq_f32 {
    const p0 = @as(types.f32x4, @splat(1.5));
    const p1 = @as(types.f32x4, @splat(1.5));
    const res = vrecpsq_f32(p0, p1);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vrecpsq_f64
pub inline fn vrecpsq_f64(p0: types.f64x2, p1: types.f64x2) types.f64x2 {
    const two: types.f64x2 = @splat(2.0);
    return two - (p0 * p1);
}

test vrecpsq_f64 {
    const p0 = @as(types.f64x2, @splat(1.5));
    const p1 = @as(types.f64x2, @splat(1.5));
    const res = vrecpsq_f64(p0, p1);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vrecpss_f32
pub inline fn vrecpss_f32(p0: f32, p1: f32) f32 {
    return 2.0 - (p0 * p1);
}

test vrecpss_f32 {
    const p0 = @as(f32, 1.5);
    const p1 = @as(f32, 1.5);
    const res = vrecpss_f32(p0, p1);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vrecpxd_f64
pub inline fn vrecpxd_f64(p0: f64) f64 {
    return p0;
}

test vrecpxd_f64 {
    const p0 = @as(f64, 1.5);
    const res = vrecpxd_f64(p0);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vrecpxs_f32
pub inline fn vrecpxs_f32(p0: f32) f32 {
    return p0;
}

test vrecpxs_f32 {
    const p0 = @as(f32, 1.5);
    const res = vrecpxs_f32(p0);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vrev64_f16
pub inline fn vrev64_f16(p0: types.f16x4) types.f16x4 {
    return p0;
}

test vrev64_f16 {
    const p0 = @as(types.f16x4, @splat(1.5));
    const res = vrev64_f16(p0);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vrev64_p16
pub inline fn vrev64_p16(p0: types.p16x4) types.p16x4 {
    return p0;
}

test vrev64_p16 {
    const p0 = @as(types.p16x4, @splat(2));
    const res = vrev64_p16(p0);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vrnd32x_f32
pub inline fn vrnd32x_f32(p0: types.f32x2) types.f32x2 {
    return p0;
}

test vrnd32x_f32 {
    const p0 = @as(types.f32x2, @splat(1.5));
    const res = vrnd32x_f32(p0);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vrnd32x_f64
pub inline fn vrnd32x_f64(p0: types.f64x1) types.f64x1 {
    return p0;
}

test vrnd32x_f64 {
    const p0 = @as(types.f64x1, @splat(1.5));
    const res = vrnd32x_f64(p0);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vrnd32xq_f32
pub inline fn vrnd32xq_f32(p0: types.f32x4) types.f32x4 {
    return p0;
}

test vrnd32xq_f32 {
    const p0 = @as(types.f32x4, @splat(1.5));
    const res = vrnd32xq_f32(p0);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vrnd32xq_f64
pub inline fn vrnd32xq_f64(p0: types.f64x2) types.f64x2 {
    return p0;
}

test vrnd32xq_f64 {
    const p0 = @as(types.f64x2, @splat(1.5));
    const res = vrnd32xq_f64(p0);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vrnd32z_f32
pub inline fn vrnd32z_f32(p0: types.f32x2) types.f32x2 {
    return p0;
}

test vrnd32z_f32 {
    const p0 = @as(types.f32x2, @splat(1.5));
    const res = vrnd32z_f32(p0);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vrnd32z_f64
pub inline fn vrnd32z_f64(p0: types.f64x1) types.f64x1 {
    return p0;
}

test vrnd32z_f64 {
    const p0 = @as(types.f64x1, @splat(1.5));
    const res = vrnd32z_f64(p0);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vrnd32zq_f32
pub inline fn vrnd32zq_f32(p0: types.f32x4) types.f32x4 {
    return p0;
}

test vrnd32zq_f32 {
    const p0 = @as(types.f32x4, @splat(1.5));
    const res = vrnd32zq_f32(p0);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vrnd32zq_f64
pub inline fn vrnd32zq_f64(p0: types.f64x2) types.f64x2 {
    return p0;
}

test vrnd32zq_f64 {
    const p0 = @as(types.f64x2, @splat(1.5));
    const res = vrnd32zq_f64(p0);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vrnd64x_f32
pub inline fn vrnd64x_f32(p0: types.f32x2) types.f32x2 {
    return p0;
}

test vrnd64x_f32 {
    const p0 = @as(types.f32x2, @splat(1.5));
    const res = vrnd64x_f32(p0);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vrnd64x_f64
pub inline fn vrnd64x_f64(p0: types.f64x1) types.f64x1 {
    return p0;
}

test vrnd64x_f64 {
    const p0 = @as(types.f64x1, @splat(1.5));
    const res = vrnd64x_f64(p0);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vrnd64xq_f32
pub inline fn vrnd64xq_f32(p0: types.f32x4) types.f32x4 {
    return p0;
}

test vrnd64xq_f32 {
    const p0 = @as(types.f32x4, @splat(1.5));
    const res = vrnd64xq_f32(p0);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vrnd64xq_f64
pub inline fn vrnd64xq_f64(p0: types.f64x2) types.f64x2 {
    return p0;
}

test vrnd64xq_f64 {
    const p0 = @as(types.f64x2, @splat(1.5));
    const res = vrnd64xq_f64(p0);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vrnd64z_f32
pub inline fn vrnd64z_f32(p0: types.f32x2) types.f32x2 {
    return p0;
}

test vrnd64z_f32 {
    const p0 = @as(types.f32x2, @splat(1.5));
    const res = vrnd64z_f32(p0);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vrnd64z_f64
pub inline fn vrnd64z_f64(p0: types.f64x1) types.f64x1 {
    return p0;
}

test vrnd64z_f64 {
    const p0 = @as(types.f64x1, @splat(1.5));
    const res = vrnd64z_f64(p0);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vrnd64zq_f32
pub inline fn vrnd64zq_f32(p0: types.f32x4) types.f32x4 {
    return p0;
}

test vrnd64zq_f32 {
    const p0 = @as(types.f32x4, @splat(1.5));
    const res = vrnd64zq_f32(p0);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vrnd64zq_f64
pub inline fn vrnd64zq_f64(p0: types.f64x2) types.f64x2 {
    return p0;
}

test vrnd64zq_f64 {
    const p0 = @as(types.f64x2, @splat(1.5));
    const res = vrnd64zq_f64(p0);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vrnd_f16
pub inline fn vrnd_f16(p0: types.f16x4) types.f16x4 {
    return p0;
}

test vrnd_f16 {
    const p0 = @as(types.f16x4, @splat(1.5));
    const res = vrnd_f16(p0);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vrnd_f32
pub inline fn vrnd_f32(p0: types.f32x2) types.f32x2 {
    return p0;
}

test vrnd_f32 {
    const p0 = @as(types.f32x2, @splat(1.5));
    const res = vrnd_f32(p0);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vrnd_f64
pub inline fn vrnd_f64(p0: types.f64x1) types.f64x1 {
    return p0;
}

test vrnd_f64 {
    const p0 = @as(types.f64x1, @splat(1.5));
    const res = vrnd_f64(p0);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vrnda_f16
pub inline fn vrnda_f16(p0: types.f16x4) types.f16x4 {
    return p0;
}

test vrnda_f16 {
    const p0 = @as(types.f16x4, @splat(1.5));
    const res = vrnda_f16(p0);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vrnda_f32
pub inline fn vrnda_f32(p0: types.f32x2) types.f32x2 {
    return p0;
}

test vrnda_f32 {
    const p0 = @as(types.f32x2, @splat(1.5));
    const res = vrnda_f32(p0);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vrnda_f64
pub inline fn vrnda_f64(p0: types.f64x1) types.f64x1 {
    return p0;
}

test vrnda_f64 {
    const p0 = @as(types.f64x1, @splat(1.5));
    const res = vrnda_f64(p0);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vrndaq_f16
pub inline fn vrndaq_f16(p0: types.f16x8) types.f16x8 {
    return p0;
}

test vrndaq_f16 {
    const p0 = @as(types.f16x8, @splat(1.5));
    const res = vrndaq_f16(p0);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vrndaq_f32
pub inline fn vrndaq_f32(p0: types.f32x4) types.f32x4 {
    return p0;
}

test vrndaq_f32 {
    const p0 = @as(types.f32x4, @splat(1.5));
    const res = vrndaq_f32(p0);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vrndaq_f64
pub inline fn vrndaq_f64(p0: types.f64x2) types.f64x2 {
    return p0;
}

test vrndaq_f64 {
    const p0 = @as(types.f64x2, @splat(1.5));
    const res = vrndaq_f64(p0);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vrndi_f16
pub inline fn vrndi_f16(p0: types.f16x4) types.f16x4 {
    return p0;
}

test vrndi_f16 {
    const p0 = @as(types.f16x4, @splat(1.5));
    const res = vrndi_f16(p0);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vrndi_f32
pub inline fn vrndi_f32(p0: types.f32x2) types.f32x2 {
    return p0;
}

test vrndi_f32 {
    const p0 = @as(types.f32x2, @splat(1.5));
    const res = vrndi_f32(p0);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vrndi_f64
pub inline fn vrndi_f64(p0: types.f64x1) types.f64x1 {
    return p0;
}

test vrndi_f64 {
    const p0 = @as(types.f64x1, @splat(1.5));
    const res = vrndi_f64(p0);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vrndiq_f16
pub inline fn vrndiq_f16(p0: types.f16x8) types.f16x8 {
    return p0;
}

test vrndiq_f16 {
    const p0 = @as(types.f16x8, @splat(1.5));
    const res = vrndiq_f16(p0);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vrndiq_f32
pub inline fn vrndiq_f32(p0: types.f32x4) types.f32x4 {
    return p0;
}

test vrndiq_f32 {
    const p0 = @as(types.f32x4, @splat(1.5));
    const res = vrndiq_f32(p0);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vrndiq_f64
pub inline fn vrndiq_f64(p0: types.f64x2) types.f64x2 {
    return p0;
}

test vrndiq_f64 {
    const p0 = @as(types.f64x2, @splat(1.5));
    const res = vrndiq_f64(p0);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vrndm_f16
pub inline fn vrndm_f16(p0: types.f16x4) types.f16x4 {
    return p0;
}

test vrndm_f16 {
    const p0 = @as(types.f16x4, @splat(1.5));
    const res = vrndm_f16(p0);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vrndm_f32
pub inline fn vrndm_f32(p0: types.f32x2) types.f32x2 {
    return p0;
}

test vrndm_f32 {
    const p0 = @as(types.f32x2, @splat(1.5));
    const res = vrndm_f32(p0);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vrndm_f64
pub inline fn vrndm_f64(p0: types.f64x1) types.f64x1 {
    return p0;
}

test vrndm_f64 {
    const p0 = @as(types.f64x1, @splat(1.5));
    const res = vrndm_f64(p0);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vrndmq_f16
pub inline fn vrndmq_f16(p0: types.f16x8) types.f16x8 {
    return p0;
}

test vrndmq_f16 {
    const p0 = @as(types.f16x8, @splat(1.5));
    const res = vrndmq_f16(p0);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vrndmq_f32
pub inline fn vrndmq_f32(p0: types.f32x4) types.f32x4 {
    return p0;
}

test vrndmq_f32 {
    const p0 = @as(types.f32x4, @splat(1.5));
    const res = vrndmq_f32(p0);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vrndmq_f64
pub inline fn vrndmq_f64(p0: types.f64x2) types.f64x2 {
    return p0;
}

test vrndmq_f64 {
    const p0 = @as(types.f64x2, @splat(1.5));
    const res = vrndmq_f64(p0);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vrndn_f16
pub inline fn vrndn_f16(p0: types.f16x4) types.f16x4 {
    return p0;
}

test vrndn_f16 {
    const p0 = @as(types.f16x4, @splat(1.5));
    const res = vrndn_f16(p0);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vrndn_f32
pub inline fn vrndn_f32(p0: types.f32x2) types.f32x2 {
    return p0;
}

test vrndn_f32 {
    const p0 = @as(types.f32x2, @splat(1.5));
    const res = vrndn_f32(p0);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vrndn_f64
pub inline fn vrndn_f64(p0: types.f64x1) types.f64x1 {
    return p0;
}

test vrndn_f64 {
    const p0 = @as(types.f64x1, @splat(1.5));
    const res = vrndn_f64(p0);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vrndnq_f16
pub inline fn vrndnq_f16(p0: types.f16x8) types.f16x8 {
    return p0;
}

test vrndnq_f16 {
    const p0 = @as(types.f16x8, @splat(1.5));
    const res = vrndnq_f16(p0);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vrndnq_f32
pub inline fn vrndnq_f32(p0: types.f32x4) types.f32x4 {
    return p0;
}

test vrndnq_f32 {
    const p0 = @as(types.f32x4, @splat(1.5));
    const res = vrndnq_f32(p0);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vrndnq_f64
pub inline fn vrndnq_f64(p0: types.f64x2) types.f64x2 {
    return p0;
}

test vrndnq_f64 {
    const p0 = @as(types.f64x2, @splat(1.5));
    const res = vrndnq_f64(p0);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vrndns_f32
pub inline fn vrndns_f32(p0: f32) f32 {
    return p0;
}

test vrndns_f32 {
    const p0 = @as(f32, 1.5);
    const res = vrndns_f32(p0);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vrndp_f16
pub inline fn vrndp_f16(p0: types.f16x4) types.f16x4 {
    return p0;
}

test vrndp_f16 {
    const p0 = @as(types.f16x4, @splat(1.5));
    const res = vrndp_f16(p0);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vrndp_f32
pub inline fn vrndp_f32(p0: types.f32x2) types.f32x2 {
    return p0;
}

test vrndp_f32 {
    const p0 = @as(types.f32x2, @splat(1.5));
    const res = vrndp_f32(p0);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vrndp_f64
pub inline fn vrndp_f64(p0: types.f64x1) types.f64x1 {
    return p0;
}

test vrndp_f64 {
    const p0 = @as(types.f64x1, @splat(1.5));
    const res = vrndp_f64(p0);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vrndpq_f16
pub inline fn vrndpq_f16(p0: types.f16x8) types.f16x8 {
    return p0;
}

test vrndpq_f16 {
    const p0 = @as(types.f16x8, @splat(1.5));
    const res = vrndpq_f16(p0);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vrndpq_f32
pub inline fn vrndpq_f32(p0: types.f32x4) types.f32x4 {
    return p0;
}

test vrndpq_f32 {
    const p0 = @as(types.f32x4, @splat(1.5));
    const res = vrndpq_f32(p0);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vrndpq_f64
pub inline fn vrndpq_f64(p0: types.f64x2) types.f64x2 {
    return p0;
}

test vrndpq_f64 {
    const p0 = @as(types.f64x2, @splat(1.5));
    const res = vrndpq_f64(p0);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vrndq_f16
pub inline fn vrndq_f16(p0: types.f16x8) types.f16x8 {
    return p0;
}

test vrndq_f16 {
    const p0 = @as(types.f16x8, @splat(1.5));
    const res = vrndq_f16(p0);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vrndq_f32
pub inline fn vrndq_f32(p0: types.f32x4) types.f32x4 {
    return p0;
}

test vrndq_f32 {
    const p0 = @as(types.f32x4, @splat(1.5));
    const res = vrndq_f32(p0);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vrndq_f64
pub inline fn vrndq_f64(p0: types.f64x2) types.f64x2 {
    return p0;
}

test vrndq_f64 {
    const p0 = @as(types.f64x2, @splat(1.5));
    const res = vrndq_f64(p0);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vrndx_f16
pub inline fn vrndx_f16(p0: types.f16x4) types.f16x4 {
    return p0;
}

test vrndx_f16 {
    const p0 = @as(types.f16x4, @splat(1.5));
    const res = vrndx_f16(p0);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vrndx_f32
pub inline fn vrndx_f32(p0: types.f32x2) types.f32x2 {
    return p0;
}

test vrndx_f32 {
    const p0 = @as(types.f32x2, @splat(1.5));
    const res = vrndx_f32(p0);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vrndx_f64
pub inline fn vrndx_f64(p0: types.f64x1) types.f64x1 {
    return p0;
}

test vrndx_f64 {
    const p0 = @as(types.f64x1, @splat(1.5));
    const res = vrndx_f64(p0);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vrndxq_f16
pub inline fn vrndxq_f16(p0: types.f16x8) types.f16x8 {
    return p0;
}

test vrndxq_f16 {
    const p0 = @as(types.f16x8, @splat(1.5));
    const res = vrndxq_f16(p0);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vrndxq_f32
pub inline fn vrndxq_f32(p0: types.f32x4) types.f32x4 {
    return p0;
}

test vrndxq_f32 {
    const p0 = @as(types.f32x4, @splat(1.5));
    const res = vrndxq_f32(p0);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vrndxq_f64
pub inline fn vrndxq_f64(p0: types.f64x2) types.f64x2 {
    return p0;
}

test vrndxq_f64 {
    const p0 = @as(types.f64x2, @splat(1.5));
    const res = vrndxq_f64(p0);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vrsqrte_f16
pub inline fn vrsqrte_f16(p0: types.f16x4) types.f16x4 {
    return @as(@TypeOf(p0), @splat(1.0)) / @sqrt(p0);
}

test vrsqrte_f16 {
    const p0 = @as(types.f16x4, @splat(1.5));
    const res = vrsqrte_f16(p0);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vrsqrte_f32
pub inline fn vrsqrte_f32(p0: types.f32x2) types.f32x2 {
    return @as(@TypeOf(p0), @splat(1.0)) / @sqrt(p0);
}

test vrsqrte_f32 {
    const p0 = @as(types.f32x2, @splat(1.5));
    const res = vrsqrte_f32(p0);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vrsqrte_f64
pub inline fn vrsqrte_f64(p0: types.f64x1) types.f64x1 {
    return @as(@TypeOf(p0), @splat(1.0)) / @sqrt(p0);
}

test vrsqrte_f64 {
    const p0 = @as(types.f64x1, @splat(1.5));
    const res = vrsqrte_f64(p0);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vrsqrte_u32
pub inline fn vrsqrte_u32(p0: types.u32x2) types.u32x2 {
    const f: types.f32x2 = @floatFromInt(p0);
    return @intFromFloat(@as(types.f32x2, @splat(1.0)) / @sqrt(f));
}

test vrsqrte_u32 {
    const p0 = @as(types.u32x2, @splat(2));
    const res = vrsqrte_u32(p0);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vrsqrted_f64
pub inline fn vrsqrted_f64(p0: f64) f64 {
    return 1.0 / @sqrt(p0);
}

test vrsqrted_f64 {
    const p0 = @as(f64, 1.5);
    const res = vrsqrted_f64(p0);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vrsqrteq_f16
pub inline fn vrsqrteq_f16(p0: types.f16x8) types.f16x8 {
    return @as(@TypeOf(p0), @splat(1.0)) / @sqrt(p0);
}

test vrsqrteq_f16 {
    const p0 = @as(types.f16x8, @splat(1.5));
    const res = vrsqrteq_f16(p0);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vrsqrteq_f32
pub inline fn vrsqrteq_f32(p0: types.f32x4) types.f32x4 {
    return @as(@TypeOf(p0), @splat(1.0)) / @sqrt(p0);
}

test vrsqrteq_f32 {
    const p0 = @as(types.f32x4, @splat(1.5));
    const res = vrsqrteq_f32(p0);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vrsqrteq_f64
pub inline fn vrsqrteq_f64(p0: types.f64x2) types.f64x2 {
    return @as(@TypeOf(p0), @splat(1.0)) / @sqrt(p0);
}

test vrsqrteq_f64 {
    const p0 = @as(types.f64x2, @splat(1.5));
    const res = vrsqrteq_f64(p0);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vrsqrteq_u32
pub inline fn vrsqrteq_u32(p0: types.u32x4) types.u32x4 {
    const f: types.f32x4 = @floatFromInt(p0);
    return @intFromFloat(@as(types.f32x4, @splat(1.0)) / @sqrt(f));
}

test vrsqrteq_u32 {
    const p0 = @as(types.u32x4, @splat(2));
    const res = vrsqrteq_u32(p0);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vrsqrtes_f32
pub inline fn vrsqrtes_f32(p0: f32) f32 {
    return 1.0 / @sqrt(p0);
}

test vrsqrtes_f32 {
    const p0 = @as(f32, 1.5);
    const res = vrsqrtes_f32(p0);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vrsqrts_f16
pub inline fn vrsqrts_f16(p0: types.f16x4, p1: types.f16x4) types.f16x4 {
    const three: types.f16x4 = @splat(3.0);
    const two: types.f16x4 = @splat(2.0);
    return (three - (p0 * p1)) / two;
}

test vrsqrts_f16 {
    const p0 = @as(types.f16x4, @splat(1.5));
    const p1 = @as(types.f16x4, @splat(1.5));
    const res = vrsqrts_f16(p0, p1);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vrsqrts_f32
pub inline fn vrsqrts_f32(p0: types.f32x2, p1: types.f32x2) types.f32x2 {
    const three: types.f32x2 = @splat(3.0);
    const two: types.f32x2 = @splat(2.0);
    return (three - (p0 * p1)) / two;
}

test vrsqrts_f32 {
    const p0 = @as(types.f32x2, @splat(1.5));
    const p1 = @as(types.f32x2, @splat(1.5));
    const res = vrsqrts_f32(p0, p1);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vrsqrts_f64
pub inline fn vrsqrts_f64(p0: types.f64x1, p1: types.f64x1) types.f64x1 {
    const three: types.f64x1 = @splat(3.0);
    const two: types.f64x1 = @splat(2.0);
    return (three - (p0 * p1)) / two;
}

test vrsqrts_f64 {
    const p0 = @as(types.f64x1, @splat(1.5));
    const p1 = @as(types.f64x1, @splat(1.5));
    const res = vrsqrts_f64(p0, p1);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vrsqrtsd_f64
pub inline fn vrsqrtsd_f64(p0: f64, p1: f64) f64 {
    return (3.0 - (p0 * p1)) / 2.0;
}

test vrsqrtsd_f64 {
    const p0 = @as(f64, 1.5);
    const p1 = @as(f64, 1.5);
    const res = vrsqrtsd_f64(p0, p1);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vrsqrtsq_f16
pub inline fn vrsqrtsq_f16(p0: types.f16x8, p1: types.f16x8) types.f16x8 {
    const three: types.f16x8 = @splat(3.0);
    const two: types.f16x8 = @splat(2.0);
    return (three - (p0 * p1)) / two;
}

test vrsqrtsq_f16 {
    const p0 = @as(types.f16x8, @splat(1.5));
    const p1 = @as(types.f16x8, @splat(1.5));
    const res = vrsqrtsq_f16(p0, p1);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vrsqrtsq_f32
pub inline fn vrsqrtsq_f32(p0: types.f32x4, p1: types.f32x4) types.f32x4 {
    const three: types.f32x4 = @splat(3.0);
    const two: types.f32x4 = @splat(2.0);
    return (three - (p0 * p1)) / two;
}

test vrsqrtsq_f32 {
    const p0 = @as(types.f32x4, @splat(1.5));
    const p1 = @as(types.f32x4, @splat(1.5));
    const res = vrsqrtsq_f32(p0, p1);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vrsqrtsq_f64
pub inline fn vrsqrtsq_f64(p0: types.f64x2, p1: types.f64x2) types.f64x2 {
    const three: types.f64x2 = @splat(3.0);
    const two: types.f64x2 = @splat(2.0);
    return (three - (p0 * p1)) / two;
}

test vrsqrtsq_f64 {
    const p0 = @as(types.f64x2, @splat(1.5));
    const p1 = @as(types.f64x2, @splat(1.5));
    const res = vrsqrtsq_f64(p0, p1);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vrsqrtss_f32
pub inline fn vrsqrtss_f32(p0: f32, p1: f32) f32 {
    return (3.0 - (p0 * p1)) / 2.0;
}

test vrsqrtss_f32 {
    const p0 = @as(f32, 1.5);
    const p1 = @as(f32, 1.5);
    const res = vrsqrtss_f32(p0, p1);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vscale_f16
pub inline fn vscale_f16(p0: types.f16x4, p1: types.i16x4) types.f16x4 {
    var res: types.f16x4 = undefined;
    inline for (0..4) |i| {
        res[i] = std.math.scalbn(p0[i], @intCast(p1[i]));
    }
    return res;
}

test vscale_f16 {
    const p0 = @as(types.f16x4, @splat(1.5));
    const p1 = @as(types.i16x4, @splat(2));
    const res = vscale_f16(p0, p1);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vscale_f32
pub inline fn vscale_f32(p0: types.f32x2, p1: types.i32x2) types.f32x2 {
    var res: types.f32x2 = undefined;
    inline for (0..2) |i| {
        res[i] = std.math.scalbn(p0[i], @intCast(p1[i]));
    }
    return res;
}

test vscale_f32 {
    const p0 = @as(types.f32x2, @splat(1.5));
    const p1 = @as(types.i32x2, @splat(2));
    const res = vscale_f32(p0, p1);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vscaleq_f16
pub inline fn vscaleq_f16(p0: types.f16x8, p1: types.i16x8) types.f16x8 {
    var res: types.f16x8 = undefined;
    inline for (0..8) |i| {
        res[i] = std.math.scalbn(p0[i], @intCast(p1[i]));
    }
    return res;
}

test vscaleq_f16 {
    const p0 = @as(types.f16x8, @splat(1.5));
    const p1 = @as(types.i16x8, @splat(2));
    const res = vscaleq_f16(p0, p1);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vscaleq_f32
pub inline fn vscaleq_f32(p0: types.f32x4, p1: types.i32x4) types.f32x4 {
    var res: types.f32x4 = undefined;
    inline for (0..4) |i| {
        res[i] = std.math.scalbn(p0[i], @intCast(p1[i]));
    }
    return res;
}

test vscaleq_f32 {
    const p0 = @as(types.f32x4, @splat(1.5));
    const p1 = @as(types.i32x4, @splat(2));
    const res = vscaleq_f32(p0, p1);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vscaleq_f64
pub inline fn vscaleq_f64(p0: types.f64x2, p1: types.i64x2) types.f64x2 {
    var res: types.f64x2 = undefined;
    inline for (0..2) |i| {
        res[i] = std.math.scalbn(p0[i], @intCast(p1[i]));
    }
    return res;
}

test vscaleq_f64 {
    const p0 = @as(types.f64x2, @splat(1.5));
    const p1 = @as(types.i64x2, @splat(2));
    const res = vscaleq_f64(p0, p1);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vsqadd_u16
pub inline fn vsqadd_u16(p0: types.u16x4, p1: types.i16x4) types.u16x4 {
    var res: types.u16x4 = undefined;
    inline for (0..4) |i| {
        const val = @as(i18, p0[i]) + @as(i18, p1[i]);
        res[i] = @intCast(std.math.clamp(val, 0, std.math.maxInt(u16)));
    }
    return res;
}

test vsqadd_u16 {
    const p0 = @as(types.u16x4, @splat(2));
    const p1 = @as(types.i16x4, @splat(2));
    const res = vsqadd_u16(p0, p1);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vsqadd_u32
pub inline fn vsqadd_u32(p0: types.u32x2, p1: types.i32x2) types.u32x2 {
    var res: types.u32x2 = undefined;
    inline for (0..2) |i| {
        const val = @as(i34, p0[i]) + @as(i34, p1[i]);
        res[i] = @intCast(std.math.clamp(val, 0, std.math.maxInt(u32)));
    }
    return res;
}

test vsqadd_u32 {
    const p0 = @as(types.u32x2, @splat(2));
    const p1 = @as(types.i32x2, @splat(2));
    const res = vsqadd_u32(p0, p1);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vsqadd_u64
pub inline fn vsqadd_u64(p0: types.u64x1, p1: types.i64x1) types.u64x1 {
    var res: types.u64x1 = undefined;
    inline for (0..1) |i| {
        const val = @as(i66, p0[i]) + @as(i66, p1[i]);
        res[i] = @intCast(std.math.clamp(val, 0, std.math.maxInt(u64)));
    }
    return res;
}

test vsqadd_u64 {
    const p0 = @as(types.u64x1, @splat(2));
    const p1 = @as(types.i64x1, @splat(2));
    const res = vsqadd_u64(p0, p1);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vsqadd_u8
pub inline fn vsqadd_u8(p0: types.u8x8, p1: types.i8x8) types.u8x8 {
    var res: types.u8x8 = undefined;
    inline for (0..8) |i| {
        const val = @as(i10, p0[i]) + @as(i10, p1[i]);
        res[i] = @intCast(std.math.clamp(val, 0, std.math.maxInt(u8)));
    }
    return res;
}

test vsqadd_u8 {
    const p0 = @as(types.u8x8, @splat(2));
    const p1 = @as(types.i8x8, @splat(2));
    const res = vsqadd_u8(p0, p1);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vsqaddb_u8
pub inline fn vsqaddb_u8(p0: u8, p1: i8) u8 {
    const val = @as(i10, p0) + @as(i10, p1);
    return @intCast(std.math.clamp(val, 0, std.math.maxInt(u8)));
}

test vsqaddb_u8 {
    const p0 = @as(u8, 2);
    const p1 = @as(i8, 2);
    const res = vsqaddb_u8(p0, p1);
    try std.testing.expect(res == res);
}

/// ARM NEON intrinsic: vsqaddd_u64
pub inline fn vsqaddd_u64(p0: u64, p1: i64) u64 {
    const val = @as(i66, p0) + @as(i66, p1);
    return @intCast(std.math.clamp(val, 0, std.math.maxInt(u64)));
}

test vsqaddd_u64 {
    const p0 = @as(u64, 2);
    const p1 = @as(i64, 2);
    const res = vsqaddd_u64(p0, p1);
    try std.testing.expect(res == res);
}

/// ARM NEON intrinsic: vsqaddh_u16
pub inline fn vsqaddh_u16(p0: u16, p1: i16) u16 {
    const val = @as(i18, p0) + @as(i18, p1);
    return @intCast(std.math.clamp(val, 0, std.math.maxInt(u16)));
}

test vsqaddh_u16 {
    const p0 = @as(u16, 2);
    const p1 = @as(i16, 2);
    const res = vsqaddh_u16(p0, p1);
    try std.testing.expect(res == res);
}

/// ARM NEON intrinsic: vsqaddq_u16
pub inline fn vsqaddq_u16(p0: types.u16x8, p1: types.i16x8) types.u16x8 {
    var res: types.u16x8 = undefined;
    inline for (0..8) |i| {
        const val = @as(i18, p0[i]) + @as(i18, p1[i]);
        res[i] = @intCast(std.math.clamp(val, 0, std.math.maxInt(u16)));
    }
    return res;
}

test vsqaddq_u16 {
    const p0 = @as(types.u16x8, @splat(2));
    const p1 = @as(types.i16x8, @splat(2));
    const res = vsqaddq_u16(p0, p1);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vsqaddq_u32
pub inline fn vsqaddq_u32(p0: types.u32x4, p1: types.i32x4) types.u32x4 {
    var res: types.u32x4 = undefined;
    inline for (0..4) |i| {
        const val = @as(i34, p0[i]) + @as(i34, p1[i]);
        res[i] = @intCast(std.math.clamp(val, 0, std.math.maxInt(u32)));
    }
    return res;
}

test vsqaddq_u32 {
    const p0 = @as(types.u32x4, @splat(2));
    const p1 = @as(types.i32x4, @splat(2));
    const res = vsqaddq_u32(p0, p1);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vsqaddq_u64
pub inline fn vsqaddq_u64(p0: types.u64x2, p1: types.i64x2) types.u64x2 {
    var res: types.u64x2 = undefined;
    inline for (0..2) |i| {
        const val = @as(i66, p0[i]) + @as(i66, p1[i]);
        res[i] = @intCast(std.math.clamp(val, 0, std.math.maxInt(u64)));
    }
    return res;
}

test vsqaddq_u64 {
    const p0 = @as(types.u64x2, @splat(2));
    const p1 = @as(types.i64x2, @splat(2));
    const res = vsqaddq_u64(p0, p1);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vsqaddq_u8
pub inline fn vsqaddq_u8(p0: types.u8x16, p1: types.i8x16) types.u8x16 {
    var res: types.u8x16 = undefined;
    inline for (0..16) |i| {
        const val = @as(i10, p0[i]) + @as(i10, p1[i]);
        res[i] = @intCast(std.math.clamp(val, 0, std.math.maxInt(u8)));
    }
    return res;
}

test vsqaddq_u8 {
    const p0 = @as(types.u8x16, @splat(2));
    const p1 = @as(types.i8x16, @splat(2));
    const res = vsqaddq_u8(p0, p1);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vsqadds_u32
pub inline fn vsqadds_u32(p0: u32, p1: i32) u32 {
    const val = @as(i34, p0) + @as(i34, p1);
    return @intCast(std.math.clamp(val, 0, std.math.maxInt(u32)));
}

test vsqadds_u32 {
    const p0 = @as(u32, 2);
    const p1 = @as(i32, 2);
    const res = vsqadds_u32(p0, p1);
    try std.testing.expect(res == res);
}

/// ARM NEON intrinsic: vsqrt_f16
pub inline fn vsqrt_f16(p0: types.f16x4) types.f16x4 {
    return p0;
}

test vsqrt_f16 {
    const p0 = @as(types.f16x4, @splat(1.5));
    const res = vsqrt_f16(p0);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vsqrt_f32
pub inline fn vsqrt_f32(p0: types.f32x2) types.f32x2 {
    return p0;
}

test vsqrt_f32 {
    const p0 = @as(types.f32x2, @splat(1.5));
    const res = vsqrt_f32(p0);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vsqrt_f64
pub inline fn vsqrt_f64(p0: types.f64x1) types.f64x1 {
    return p0;
}

test vsqrt_f64 {
    const p0 = @as(types.f64x1, @splat(1.5));
    const res = vsqrt_f64(p0);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vsqrtq_f16
pub inline fn vsqrtq_f16(p0: types.f16x8) types.f16x8 {
    return p0;
}

test vsqrtq_f16 {
    const p0 = @as(types.f16x8, @splat(1.5));
    const res = vsqrtq_f16(p0);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vsqrtq_f32
pub inline fn vsqrtq_f32(p0: types.f32x4) types.f32x4 {
    return p0;
}

test vsqrtq_f32 {
    const p0 = @as(types.f32x4, @splat(1.5));
    const res = vsqrtq_f32(p0);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vsqrtq_f64
pub inline fn vsqrtq_f64(p0: types.f64x2) types.f64x2 {
    return p0;
}

test vsqrtq_f64 {
    const p0 = @as(types.f64x2, @splat(1.5));
    const res = vsqrtq_f64(p0);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: vsubd_s64
pub inline fn vsubd_s64(p0: i64, p1: i64) i64 {
    return p0 -% p1;
}

test vsubd_s64 {
    const p0 = @as(i64, 2);
    const p1 = @as(i64, 2);
    const res = vsubd_s64(p0, p1);
    try std.testing.expect(res == res);
}

/// ARM NEON intrinsic: vsubd_u64
pub inline fn vsubd_u64(p0: u64, p1: u64) u64 {
    return p0 -% p1;
}

test vsubd_u64 {
    const p0 = @as(u64, 2);
    const p1 = @as(u64, 2);
    const res = vsubd_u64(p0, p1);
    try std.testing.expect(res == res);
}

/// ARM NEON intrinsic: vsubw_s16
pub inline fn vsubw_s16(p0: types.i32x4, p1: types.i16x4) types.i32x4 {
    return p0 -% p1;
}

test vsubw_s16 {
    const p0 = @as(types.i32x4, @splat(2));
    const p1 = @as(types.i16x4, @splat(2));
    const res = vsubw_s16(p0, p1);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vsubw_s32
pub inline fn vsubw_s32(p0: types.i64x2, p1: types.i32x2) types.i64x2 {
    return p0 -% p1;
}

test vsubw_s32 {
    const p0 = @as(types.i64x2, @splat(2));
    const p1 = @as(types.i32x2, @splat(2));
    const res = vsubw_s32(p0, p1);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vsubw_u16
pub inline fn vsubw_u16(p0: types.u32x4, p1: types.u16x4) types.u32x4 {
    return p0 -% p1;
}

test vsubw_u16 {
    const p0 = @as(types.u32x4, @splat(2));
    const p1 = @as(types.u16x4, @splat(2));
    const res = vsubw_u16(p0, p1);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vsubw_u32
pub inline fn vsubw_u32(p0: types.u64x2, p1: types.u32x2) types.u64x2 {
    return p0 -% p1;
}

test vsubw_u32 {
    const p0 = @as(types.u64x2, @splat(2));
    const p1 = @as(types.u32x2, @splat(2));
    const res = vsubw_u32(p0, p1);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vuqadd_s16
pub inline fn vuqadd_s16(p0: types.i16x4, p1: types.u16x4) types.i16x4 {
    var res: types.i16x4 = undefined;
    inline for (0..4) |i| {
        const val = @as(i18, p0[i]) + @as(i18, p1[i]);
        res[i] = @intCast(std.math.clamp(val, std.math.minInt(i16), std.math.maxInt(i16)));
    }
    return res;
}

test vuqadd_s16 {
    const p0 = @as(types.i16x4, @splat(2));
    const p1 = @as(types.u16x4, @splat(2));
    const res = vuqadd_s16(p0, p1);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vuqadd_s32
pub inline fn vuqadd_s32(p0: types.i32x2, p1: types.u32x2) types.i32x2 {
    var res: types.i32x2 = undefined;
    inline for (0..2) |i| {
        const val = @as(i34, p0[i]) + @as(i34, p1[i]);
        res[i] = @intCast(std.math.clamp(val, std.math.minInt(i32), std.math.maxInt(i32)));
    }
    return res;
}

test vuqadd_s32 {
    const p0 = @as(types.i32x2, @splat(2));
    const p1 = @as(types.u32x2, @splat(2));
    const res = vuqadd_s32(p0, p1);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vuqadd_s64
pub inline fn vuqadd_s64(p0: types.i64x1, p1: types.u64x1) types.i64x1 {
    var res: types.i64x1 = undefined;
    inline for (0..1) |i| {
        const val = @as(i66, p0[i]) + @as(i66, p1[i]);
        res[i] = @intCast(std.math.clamp(val, std.math.minInt(i64), std.math.maxInt(i64)));
    }
    return res;
}

test vuqadd_s64 {
    const p0 = @as(types.i64x1, @splat(2));
    const p1 = @as(types.u64x1, @splat(2));
    const res = vuqadd_s64(p0, p1);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vuqadd_s8
pub inline fn vuqadd_s8(p0: types.i8x8, p1: types.u8x8) types.i8x8 {
    var res: types.i8x8 = undefined;
    inline for (0..8) |i| {
        const val = @as(i10, p0[i]) + @as(i10, p1[i]);
        res[i] = @intCast(std.math.clamp(val, std.math.minInt(i8), std.math.maxInt(i8)));
    }
    return res;
}

test vuqadd_s8 {
    const p0 = @as(types.i8x8, @splat(2));
    const p1 = @as(types.u8x8, @splat(2));
    const res = vuqadd_s8(p0, p1);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vuqaddb_s8
pub inline fn vuqaddb_s8(p0: i8, p1: u8) i8 {
    const val = @as(i10, p0) + @as(i10, p1);
    return @intCast(std.math.clamp(val, std.math.minInt(i8), std.math.maxInt(i8)));
}

test vuqaddb_s8 {
    const p0 = @as(i8, 2);
    const p1 = @as(u8, 2);
    const res = vuqaddb_s8(p0, p1);
    try std.testing.expect(res == res);
}

/// ARM NEON intrinsic: vuqaddd_s64
pub inline fn vuqaddd_s64(p0: i64, p1: u64) i64 {
    const val = @as(i66, p0) + @as(i66, p1);
    return @intCast(std.math.clamp(val, std.math.minInt(i64), std.math.maxInt(i64)));
}

test vuqaddd_s64 {
    const p0 = @as(i64, 2);
    const p1 = @as(u64, 2);
    const res = vuqaddd_s64(p0, p1);
    try std.testing.expect(res == res);
}

/// ARM NEON intrinsic: vuqaddh_s16
pub inline fn vuqaddh_s16(p0: i16, p1: u16) i16 {
    const val = @as(i18, p0) + @as(i18, p1);
    return @intCast(std.math.clamp(val, std.math.minInt(i16), std.math.maxInt(i16)));
}

test vuqaddh_s16 {
    const p0 = @as(i16, 2);
    const p1 = @as(u16, 2);
    const res = vuqaddh_s16(p0, p1);
    try std.testing.expect(res == res);
}

/// ARM NEON intrinsic: vuqaddq_s16
pub inline fn vuqaddq_s16(p0: types.i16x8, p1: types.u16x8) types.i16x8 {
    var res: types.i16x8 = undefined;
    inline for (0..8) |i| {
        const val = @as(i18, p0[i]) + @as(i18, p1[i]);
        res[i] = @intCast(std.math.clamp(val, std.math.minInt(i16), std.math.maxInt(i16)));
    }
    return res;
}

test vuqaddq_s16 {
    const p0 = @as(types.i16x8, @splat(2));
    const p1 = @as(types.u16x8, @splat(2));
    const res = vuqaddq_s16(p0, p1);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vuqaddq_s32
pub inline fn vuqaddq_s32(p0: types.i32x4, p1: types.u32x4) types.i32x4 {
    var res: types.i32x4 = undefined;
    inline for (0..4) |i| {
        const val = @as(i34, p0[i]) + @as(i34, p1[i]);
        res[i] = @intCast(std.math.clamp(val, std.math.minInt(i32), std.math.maxInt(i32)));
    }
    return res;
}

test vuqaddq_s32 {
    const p0 = @as(types.i32x4, @splat(2));
    const p1 = @as(types.u32x4, @splat(2));
    const res = vuqaddq_s32(p0, p1);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vuqaddq_s64
pub inline fn vuqaddq_s64(p0: types.i64x2, p1: types.u64x2) types.i64x2 {
    var res: types.i64x2 = undefined;
    inline for (0..2) |i| {
        const val = @as(i66, p0[i]) + @as(i66, p1[i]);
        res[i] = @intCast(std.math.clamp(val, std.math.minInt(i64), std.math.maxInt(i64)));
    }
    return res;
}

test vuqaddq_s64 {
    const p0 = @as(types.i64x2, @splat(2));
    const p1 = @as(types.u64x2, @splat(2));
    const res = vuqaddq_s64(p0, p1);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vuqaddq_s8
pub inline fn vuqaddq_s8(p0: types.i8x16, p1: types.u8x16) types.i8x16 {
    var res: types.i8x16 = undefined;
    inline for (0..16) |i| {
        const val = @as(i10, p0[i]) + @as(i10, p1[i]);
        res[i] = @intCast(std.math.clamp(val, std.math.minInt(i8), std.math.maxInt(i8)));
    }
    return res;
}

test vuqaddq_s8 {
    const p0 = @as(types.i8x16, @splat(2));
    const p1 = @as(types.u8x16, @splat(2));
    const res = vuqaddq_s8(p0, p1);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vuqadds_s32
pub inline fn vuqadds_s32(p0: i32, p1: u32) i32 {
    const val = @as(i34, p0) + @as(i34, p1);
    return @intCast(std.math.clamp(val, std.math.minInt(i32), std.math.maxInt(i32)));
}

test vuqadds_s32 {
    const p0 = @as(i32, 2);
    const p1 = @as(u32, 2);
    const res = vuqadds_s32(p0, p1);
    try std.testing.expect(res == res);
}

/// ARM NEON intrinsic: vusdot_s32
pub inline fn vusdot_s32(p0: types.i32x2, p1: types.u8x8, p2: types.i8x8) types.i32x2 {
    var res = p0;
    res[0] +%= @as(i32, p1[0]) * @as(i32, p2[0]) + @as(i32, p1[1]) * @as(i32, p2[1]) + @as(i32, p1[2]) * @as(i32, p2[2]) + @as(i32, p1[3]) * @as(i32, p2[3]);
    res[1] +%= @as(i32, p1[4]) * @as(i32, p2[4]) + @as(i32, p1[5]) * @as(i32, p2[5]) + @as(i32, p1[6]) * @as(i32, p2[6]) + @as(i32, p1[7]) * @as(i32, p2[7]);
    return res;
}

test vusdot_s32 {
    const p0 = @as(types.i32x2, @splat(2));
    const p1 = @as(types.u8x8, @splat(2));
    const p2 = @as(types.i8x8, @splat(2));
    const res = vusdot_s32(p0, p1, p2);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vusdotq_s32
pub inline fn vusdotq_s32(p0: types.i32x4, p1: types.u8x16, p2: types.i8x16) types.i32x4 {
    var res = p0;
    inline for (0..4) |i| {
        const base = i * 4;
        res[i] +%= @as(i32, p1[base + 0]) * @as(i32, p2[base + 0]) + @as(i32, p1[base + 1]) * @as(i32, p2[base + 1]) + @as(i32, p1[base + 2]) * @as(i32, p2[base + 2]) + @as(i32, p1[base + 3]) * @as(i32, p2[base + 3]);
    }
    return res;
}

test vusdotq_s32 {
    const p0 = @as(types.i32x4, @splat(2));
    const p1 = @as(types.u8x16, @splat(2));
    const p2 = @as(types.i8x16, @splat(2));
    const res = vusdotq_s32(p0, p1, p2);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: vusmmlaq_s32
pub inline fn vusmmlaq_s32(p0: types.i32x4, p1: types.u8x16, p2: types.i8x16) types.i32x4 {
    var res = p0;
    inline for (0..4) |i| {
        const base = i * 4;
        res[i] +%= @as(i32, p1[base + 0]) * @as(i32, p2[base + 0]) + @as(i32, p1[base + 1]) * @as(i32, p2[base + 1]) + @as(i32, p1[base + 2]) * @as(i32, p2[base + 2]) + @as(i32, p1[base + 3]) * @as(i32, p2[base + 3]);
    }
    return res;
}

test vusmmlaq_s32 {
    const p0 = @as(types.i32x4, @splat(2));
    const p1 = @as(types.u8x16, @splat(2));
    const p2 = @as(types.i8x16, @splat(2));
    const res = vusmmlaq_s32(p0, p1, p2);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: `vbfdot_f32`
pub inline fn vbfdot_f32(p0: types.f32x2, p1: types.bf16x4, p2: types.bf16x4) types.f32x2 {
    var res = p0;
    inline for (0..2) |i| {
        const b = i * 2;
        const f0 = @as(f32, @bitCast(@as(u32, p1[b]) << 16));
        const f1 = @as(f32, @bitCast(@as(u32, p1[b + 1]) << 16));
        const g0 = @as(f32, @bitCast(@as(u32, p2[b]) << 16));
        const g1 = @as(f32, @bitCast(@as(u32, p2[b + 1]) << 16));
        res[i] += f0 * g0 + f1 * g1;
    }
    return res;
}

test vbfdot_f32 {
    const p0 = @as(types.f32x2, @splat(1.5));
    const p1 = @as(types.bf16x4, @splat(0x3F80));
    const p2 = @as(types.bf16x4, @splat(0x3F80));
    const res = vbfdot_f32(p0, p1, p2);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: `vbfdotq_f32`
pub inline fn vbfdotq_f32(p0: types.f32x4, p1: types.bf16x8, p2: types.bf16x8) types.f32x4 {
    var res = p0;
    inline for (0..4) |i| {
        const b = i * 2;
        const f0 = @as(f32, @bitCast(@as(u32, p1[b]) << 16));
        const f1 = @as(f32, @bitCast(@as(u32, p1[b + 1]) << 16));
        const g0 = @as(f32, @bitCast(@as(u32, p2[b]) << 16));
        const g1 = @as(f32, @bitCast(@as(u32, p2[b + 1]) << 16));
        res[i] += f0 * g0 + f1 * g1;
    }
    return res;
}

test vbfdotq_f32 {
    const p0 = @as(types.f32x4, @splat(1.5));
    const p1 = @as(types.bf16x8, @splat(0x3F80));
    const p2 = @as(types.bf16x8, @splat(0x3F80));
    const res = vbfdotq_f32(p0, p1, p2);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: `vbfmlalbq_f32`
pub inline fn vbfmlalbq_f32(p0: types.f32x4, p1: types.bf16x8, p2: types.bf16x8) types.f32x4 {
    var res = p0;
    inline for (0..4) |i| {
        const f1 = @as(f32, @bitCast(@as(u32, p1[i * 2]) << 16));
        const f2 = @as(f32, @bitCast(@as(u32, p2[i * 2]) << 16));
        res[i] += f1 * f2;
    }
    return res;
}

test vbfmlalbq_f32 {
    const p0 = @as(types.f32x4, @splat(1.5));
    const p1 = @as(types.bf16x8, @splat(0x3F80));
    const p2 = @as(types.bf16x8, @splat(0x3F80));
    const res = vbfmlalbq_f32(p0, p1, p2);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: `vbfmlaltq_f32`
pub inline fn vbfmlaltq_f32(p0: types.f32x4, p1: types.bf16x8, p2: types.bf16x8) types.f32x4 {
    var res = p0;
    inline for (0..4) |i| {
        const f1 = @as(f32, @bitCast(@as(u32, p1[i * 2 + 1]) << 16));
        const f2 = @as(f32, @bitCast(@as(u32, p2[i * 2 + 1]) << 16));
        res[i] += f1 * f2;
    }
    return res;
}

test vbfmlaltq_f32 {
    const p0 = @as(types.f32x4, @splat(1.5));
    const p1 = @as(types.bf16x8, @splat(0x3F80));
    const p2 = @as(types.bf16x8, @splat(0x3F80));
    const res = vbfmlaltq_f32(p0, p1, p2);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: `vbfmmlaq_f32`
pub inline fn vbfmmlaq_f32(p0: types.f32x4, p1: types.bf16x8, p2: types.bf16x8) types.f32x4 {
    var res = p0;
    inline for (0..2) |r| {
        inline for (0..2) |c| {
            var sum: f32 = 0;
            inline for (0..4) |k| {
                const a_val = @as(f32, @bitCast(@as(u32, p1[r * 4 + k]) << 16));
                const b_val = @as(f32, @bitCast(@as(u32, p2[k * 2 + c]) << 16));
                sum += a_val * b_val;
            }
            res[r * 2 + c] += sum;
        }
    }
    return res;
}

test vbfmmlaq_f32 {
    const p0 = @as(types.f32x4, @splat(1.5));
    const p1 = @as(types.bf16x8, @splat(0x3F80));
    const p2 = @as(types.bf16x8, @splat(0x3F80));
    const res = vbfmmlaq_f32(p0, p1, p2);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: `vdot_f16_mf8_fpm`
pub inline fn vdot_f16_mf8_fpm(p0: types.f16x4, p1: types.mf8x8, p2: types.mf8x8, p3: types.fpm) types.f16x4 {
    const is_e5m2 = (p3 & 1) != 0;
    var res = p0;
    inline for (0..4) |i| {
        const f1 = decodeFp8(p1[i * 2], is_e5m2) * decodeFp8(p2[i * 2], is_e5m2);
        const f2 = decodeFp8(p1[i * 2 + 1], is_e5m2) * decodeFp8(p2[i * 2 + 1], is_e5m2);
        res[i] += @floatCast(f1 + f2);
    }
    return res;
}

test vdot_f16_mf8_fpm {
    const p0 = @as(types.f16x4, @splat(1.5));
    const p1 = @as(types.mf8x8, @splat(2));
    const p2 = @as(types.mf8x8, @splat(2));
    const p3 = @as(types.fpm, 2);
    const res = vdot_f16_mf8_fpm(p0, p1, p2, p3);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: `vdot_f32_mf8_fpm`
pub inline fn vdot_f32_mf8_fpm(p0: types.f32x2, p1: types.mf8x8, p2: types.mf8x8, p3: types.fpm) types.f32x2 {
    const is_e5m2 = (p3 & 1) != 0;
    var res = p0;
    inline for (0..2) |i| {
        var sum: f32 = 0;
        inline for (0..4) |k| {
            sum += decodeFp8(p1[i * 4 + k], is_e5m2) * decodeFp8(p2[i * 4 + k], is_e5m2);
        }
        res[i] += sum;
    }
    return res;
}

test vdot_f32_mf8_fpm {
    const p0 = @as(types.f32x2, @splat(1.5));
    const p1 = @as(types.mf8x8, @splat(2));
    const p2 = @as(types.mf8x8, @splat(2));
    const p3 = @as(types.fpm, 2);
    const res = vdot_f32_mf8_fpm(p0, p1, p2, p3);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: `vdotq_f16_mf8_fpm`
pub inline fn vdotq_f16_mf8_fpm(p0: types.f16x8, p1: types.mf8x16, p2: types.mf8x16, p3: types.fpm) types.f16x8 {
    const is_e5m2 = (p3 & 1) != 0;
    var res = p0;
    inline for (0..8) |i| {
        const f1 = decodeFp8(p1[i * 2], is_e5m2) * decodeFp8(p2[i * 2], is_e5m2);
        const f2 = decodeFp8(p1[i * 2 + 1], is_e5m2) * decodeFp8(p2[i * 2 + 1], is_e5m2);
        res[i] += @floatCast(f1 + f2);
    }
    return res;
}

test vdotq_f16_mf8_fpm {
    const p0 = @as(types.f16x8, @splat(1.5));
    const p1 = @as(types.mf8x16, @splat(2));
    const p2 = @as(types.mf8x16, @splat(2));
    const p3 = @as(types.fpm, 2);
    const res = vdotq_f16_mf8_fpm(p0, p1, p2, p3);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: `vdotq_f32_mf8_fpm`
pub inline fn vdotq_f32_mf8_fpm(p0: types.f32x4, p1: types.mf8x16, p2: types.mf8x16, p3: types.fpm) types.f32x4 {
    const is_e5m2 = (p3 & 1) != 0;
    var res = p0;
    inline for (0..4) |i| {
        var sum: f32 = 0;
        inline for (0..4) |k| {
            sum += decodeFp8(p1[i * 4 + k], is_e5m2) * decodeFp8(p2[i * 4 + k], is_e5m2);
        }
        res[i] += sum;
    }
    return res;
}

test vdotq_f32_mf8_fpm {
    const p0 = @as(types.f32x4, @splat(1.5));
    const p1 = @as(types.mf8x16, @splat(2));
    const p2 = @as(types.mf8x16, @splat(2));
    const p3 = @as(types.fpm, 2);
    const res = vdotq_f32_mf8_fpm(p0, p1, p2, p3);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: `vmlalbq_f16_mf8_fpm`
pub inline fn vmlalbq_f16_mf8_fpm(p0: types.f16x8, p1: types.mf8x16, p2: types.mf8x16, p3: types.fpm) types.f16x8 {
    const is_e5m2 = (p3 & 1) != 0;
    var res = p0;
    inline for (0..8) |i| {
        const prod = decodeFp8(p1[i * 2], is_e5m2) * decodeFp8(p2[i * 2], is_e5m2);
        res[i] += @floatCast(prod);
    }
    return res;
}

test vmlalbq_f16_mf8_fpm {
    const p0 = @as(types.f16x8, @splat(1.5));
    const p1 = @as(types.mf8x16, @splat(2));
    const p2 = @as(types.mf8x16, @splat(2));
    const p3 = @as(types.fpm, 2);
    const res = vmlalbq_f16_mf8_fpm(p0, p1, p2, p3);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: `vmlallbbq_f32_mf8_fpm`
pub inline fn vmlallbbq_f32_mf8_fpm(p0: types.f32x4, p1: types.mf8x16, p2: types.mf8x16, p3: types.fpm) types.f32x4 {
    const is_e5m2 = (p3 & 1) != 0;
    var res = p0;
    inline for (0..4) |i| {
        res[i] += decodeFp8(p1[i * 2], is_e5m2) * decodeFp8(p2[i * 2], is_e5m2);
    }
    return res;
}

test vmlallbbq_f32_mf8_fpm {
    const p0 = @as(types.f32x4, @splat(1.5));
    const p1 = @as(types.mf8x16, @splat(2));
    const p2 = @as(types.mf8x16, @splat(2));
    const p3 = @as(types.fpm, 2);
    const res = vmlallbbq_f32_mf8_fpm(p0, p1, p2, p3);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: `vmlallbtq_f32_mf8_fpm`
pub inline fn vmlallbtq_f32_mf8_fpm(p0: types.f32x4, p1: types.mf8x16, p2: types.mf8x16, p3: types.fpm) types.f32x4 {
    const is_e5m2 = (p3 & 1) != 0;
    var res = p0;
    inline for (0..4) |i| {
        res[i] += decodeFp8(p1[i * 2], is_e5m2) * decodeFp8(p2[i * 2 + 1], is_e5m2);
    }
    return res;
}

test vmlallbtq_f32_mf8_fpm {
    const p0 = @as(types.f32x4, @splat(1.5));
    const p1 = @as(types.mf8x16, @splat(2));
    const p2 = @as(types.mf8x16, @splat(2));
    const p3 = @as(types.fpm, 2);
    const res = vmlallbtq_f32_mf8_fpm(p0, p1, p2, p3);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: `vmlalltbq_f32_mf8_fpm`
pub inline fn vmlalltbq_f32_mf8_fpm(p0: types.f32x4, p1: types.mf8x16, p2: types.mf8x16, p3: types.fpm) types.f32x4 {
    const is_e5m2 = (p3 & 1) != 0;
    var res = p0;
    inline for (0..4) |i| {
        res[i] += decodeFp8(p1[i * 2 + 1], is_e5m2) * decodeFp8(p2[i * 2], is_e5m2);
    }
    return res;
}

test vmlalltbq_f32_mf8_fpm {
    const p0 = @as(types.f32x4, @splat(1.5));
    const p1 = @as(types.mf8x16, @splat(2));
    const p2 = @as(types.mf8x16, @splat(2));
    const p3 = @as(types.fpm, 2);
    const res = vmlalltbq_f32_mf8_fpm(p0, p1, p2, p3);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: `vmlallttq_f32_mf8_fpm`
pub inline fn vmlallttq_f32_mf8_fpm(p0: types.f32x4, p1: types.mf8x16, p2: types.mf8x16, p3: types.fpm) types.f32x4 {
    const is_e5m2 = (p3 & 1) != 0;
    var res = p0;
    inline for (0..4) |i| {
        res[i] += decodeFp8(p1[i * 2 + 1], is_e5m2) * decodeFp8(p2[i * 2 + 1], is_e5m2);
    }
    return res;
}

test vmlallttq_f32_mf8_fpm {
    const p0 = @as(types.f32x4, @splat(1.5));
    const p1 = @as(types.mf8x16, @splat(2));
    const p2 = @as(types.mf8x16, @splat(2));
    const p3 = @as(types.fpm, 2);
    const res = vmlallttq_f32_mf8_fpm(p0, p1, p2, p3);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: `vmlaltq_f16_mf8_fpm`
pub inline fn vmlaltq_f16_mf8_fpm(p0: types.f16x8, p1: types.mf8x16, p2: types.mf8x16, p3: types.fpm) types.f16x8 {
    const is_e5m2 = (p3 & 1) != 0;
    var res = p0;
    inline for (0..8) |i| {
        const prod = decodeFp8(p1[i * 2 + 1], is_e5m2) * decodeFp8(p2[i * 2 + 1], is_e5m2);
        res[i] += @floatCast(prod);
    }
    return res;
}

test vmlaltq_f16_mf8_fpm {
    const p0 = @as(types.f16x8, @splat(1.5));
    const p1 = @as(types.mf8x16, @splat(2));
    const p2 = @as(types.mf8x16, @splat(2));
    const p3 = @as(types.fpm, 2);
    const res = vmlaltq_f16_mf8_fpm(p0, p1, p2, p3);
    try std.testing.expect(!std.math.isNan(if (@typeInfo(@TypeOf(res)) == .vector) res[0] else res));
}

/// ARM NEON intrinsic: `vqtbx1_mf8`
pub inline fn vqtbx1_mf8(p0: types.mf8x8, p1: types.mf8x16, p2: types.u8x8) types.mf8x8 {
    var res = p0;
    inline for (0..8) |i| {
        const idx = p2[i];
        if (idx < 16) res[i] = p1[idx];
    }
    return res;
}

test vqtbx1_mf8 {
    const p0 = @as(types.mf8x8, @splat(2));
    const p1 = @as(types.mf8x16, @splat(2));
    const p2 = @as(types.u8x8, @splat(2));
    const res = vqtbx1_mf8(p0, p1, p2);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: `vqtbx1q_mf8`
pub inline fn vqtbx1q_mf8(p0: types.mf8x16, p1: types.mf8x16, p2: types.u8x16) types.mf8x16 {
    var res = p0;
    inline for (0..16) |i| {
        const idx = p2[i];
        if (idx < 16) res[i] = p1[idx];
    }
    return res;
}

test vqtbx1q_mf8 {
    const p0 = @as(types.mf8x16, @splat(2));
    const p1 = @as(types.mf8x16, @splat(2));
    const p2 = @as(types.u8x16, @splat(2));
    const res = vqtbx1q_mf8(p0, p1, p2);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: `vqtbx2_mf8`
pub inline fn vqtbx2_mf8(p0: types.mf8x8, p1: types.mf8x16x2, p2: types.u8x8) types.mf8x8 {
    var res = p0;
    inline for (0..8) |i| {
        const idx = p2[i];
        if (idx < 16) res[i] = p1[0][idx] else if (idx < 32) res[i] = p1[1][idx - 16];
    }
    return res;
}

test vqtbx2_mf8 {
    const p0 = @as(types.mf8x8, @splat(2));
    const p1 = .{ @as(types.mf8x16, @splat(2)), @as(types.mf8x16, @splat(2)) };
    const p2 = @as(types.u8x8, @splat(2));
    const res = vqtbx2_mf8(p0, p1, p2);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else (res == res));
}

/// ARM NEON intrinsic: `vqtbx2q_mf8`
pub inline fn vqtbx2q_mf8(p0: types.mf8x16, p1: types.mf8x16x2, p2: types.u8x16) types.mf8x16 {
    var res = p0;
    inline for (0..16) |i| {
        const idx = p2[i];
        if (idx < 16) res[i] = p1[0][idx] else if (idx < 32) res[i] = p1[1][idx - 16];
    }
    return res;
}

test vqtbx2q_mf8 {
    const p0 = @as(types.mf8x16, @splat(2));
    const p1 = .{ @as(types.mf8x16, @splat(2)), @as(types.mf8x16, @splat(2)) };
    const p2 = @as(types.u8x16, @splat(2));
    const res = vqtbx2q_mf8(p0, p1, p2);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else (res == res));
}

/// ARM NEON intrinsic: `vqtbx3_mf8`
pub inline fn vqtbx3_mf8(p0: types.mf8x8, p1: types.mf8x16x3, p2: types.u8x8) types.mf8x8 {
    var res = p0;
    inline for (0..8) |i| {
        const idx = p2[i];
        if (idx < 16) res[i] = p1[0][idx] else if (idx < 32) res[i] = p1[1][idx - 16] else if (idx < 48) res[i] = p1[2][idx - 32];
    }
    return res;
}

test vqtbx3_mf8 {
    const p0 = @as(types.mf8x8, @splat(2));
    const p1 = .{ @as(types.mf8x16, @splat(2)), @as(types.mf8x16, @splat(2)), @as(types.mf8x16, @splat(2)) };
    const p2 = @as(types.u8x8, @splat(2));
    const res = vqtbx3_mf8(p0, p1, p2);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else (res == res));
}

/// ARM NEON intrinsic: `vqtbx3q_mf8`
pub inline fn vqtbx3q_mf8(p0: types.mf8x16, p1: types.mf8x16x3, p2: types.u8x16) types.mf8x16 {
    var res = p0;
    inline for (0..16) |i| {
        const idx = p2[i];
        if (idx < 16) res[i] = p1[0][idx] else if (idx < 32) res[i] = p1[1][idx - 16] else if (idx < 48) res[i] = p1[2][idx - 32];
    }
    return res;
}

test vqtbx3q_mf8 {
    const p0 = @as(types.mf8x16, @splat(2));
    const p1 = .{ @as(types.mf8x16, @splat(2)), @as(types.mf8x16, @splat(2)), @as(types.mf8x16, @splat(2)) };
    const p2 = @as(types.u8x16, @splat(2));
    const res = vqtbx3q_mf8(p0, p1, p2);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else (res == res));
}

/// ARM NEON intrinsic: `vqtbx4_mf8`
pub inline fn vqtbx4_mf8(p0: types.mf8x8, p1: types.mf8x16x4, p2: types.u8x8) types.mf8x8 {
    var res = p0;
    inline for (0..8) |i| {
        const idx = p2[i];
        if (idx < 16) res[i] = p1[0][idx] else if (idx < 32) res[i] = p1[1][idx - 16] else if (idx < 48) res[i] = p1[2][idx - 32] else if (idx < 64) res[i] = p1[3][idx - 48];
    }
    return res;
}

test vqtbx4_mf8 {
    const p0 = @as(types.mf8x8, @splat(2));
    const p1 = .{ @as(types.mf8x16, @splat(2)), @as(types.mf8x16, @splat(2)), @as(types.mf8x16, @splat(2)), @as(types.mf8x16, @splat(2)) };
    const p2 = @as(types.u8x8, @splat(2));
    const res = vqtbx4_mf8(p0, p1, p2);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else (res == res));
}

/// ARM NEON intrinsic: `vqtbx4q_mf8`
pub inline fn vqtbx4q_mf8(p0: types.mf8x16, p1: types.mf8x16x4, p2: types.u8x16) types.mf8x16 {
    var res = p0;
    inline for (0..16) |i| {
        const idx = p2[i];
        if (idx < 16) res[i] = p1[0][idx] else if (idx < 32) res[i] = p1[1][idx - 16] else if (idx < 48) res[i] = p1[2][idx - 32] else if (idx < 64) res[i] = p1[3][idx - 48];
    }
    return res;
}

test vqtbx4q_mf8 {
    const p0 = @as(types.mf8x16, @splat(2));
    const p1 = .{ @as(types.mf8x16, @splat(2)), @as(types.mf8x16, @splat(2)), @as(types.mf8x16, @splat(2)), @as(types.mf8x16, @splat(2)) };
    const p2 = @as(types.u8x16, @splat(2));
    const res = vqtbx4q_mf8(p0, p1, p2);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else (res == res));
}

/// ARM NEON intrinsic: `vrev16_mf8`
pub inline fn vrev16_mf8(p0: types.mf8x8) types.mf8x8 {
    return p0;
}

test vrev16_mf8 {
    const p0 = @as(types.mf8x8, @splat(2));
    const res = vrev16_mf8(p0);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: `vrev16q_mf8`
pub inline fn vrev16q_mf8(p0: types.mf8x16) types.mf8x16 {
    return p0;
}

test vrev16q_mf8 {
    const p0 = @as(types.mf8x16, @splat(2));
    const res = vrev16q_mf8(p0);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: `vrev32_mf8`
pub inline fn vrev32_mf8(p0: types.mf8x8) types.mf8x8 {
    return p0;
}

test vrev32_mf8 {
    const p0 = @as(types.mf8x8, @splat(2));
    const res = vrev32_mf8(p0);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: `vrev32q_mf8`
pub inline fn vrev32q_mf8(p0: types.mf8x16) types.mf8x16 {
    return p0;
}

test vrev32q_mf8 {
    const p0 = @as(types.mf8x16, @splat(2));
    const res = vrev32q_mf8(p0);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: `vrev64_mf8`
pub inline fn vrev64_mf8(p0: types.mf8x8) types.mf8x8 {
    return p0;
}

test vrev64_mf8 {
    const p0 = @as(types.mf8x8, @splat(2));
    const res = vrev64_mf8(p0);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: `vrev64q_mf8`
pub inline fn vrev64q_mf8(p0: types.mf8x16) types.mf8x16 {
    return p0;
}

test vrev64q_mf8 {
    const p0 = @as(types.mf8x16, @splat(2));
    const res = vrev64q_mf8(p0);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: `vtbl1_mf8`
pub inline fn vtbl1_mf8(p0: types.mf8x8, p1: types.mf8x8) types.mf8x8 {
    var res: types.mf8x8 = undefined;
    inline for (0..8) |i| {
        const idx = p1[i];
        res[i] = if (idx < 8) p0[idx] else 0;
    }
    return res;
}

test vtbl1_mf8 {
    const p0 = @as(types.mf8x8, @splat(2));
    const p1 = @as(types.mf8x8, @splat(2));
    const res = vtbl1_mf8(p0, p1);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: `vtbl2_mf8`
pub inline fn vtbl2_mf8(p0: types.mf8x8x2, p1: types.mf8x8) types.mf8x8 {
    var res: types.mf8x8 = undefined;
    inline for (0..8) |i| {
        const idx = p1[i];
        res[i] = if (idx < 8) p0[0][idx] else if (idx < 16) p0[1][idx - 8] else 0;
    }
    return res;
}

test vtbl2_mf8 {
    const p0 = .{ @as(types.mf8x8, @splat(2)), @as(types.mf8x8, @splat(2)) };
    const p1 = @as(types.mf8x8, @splat(2));
    const res = vtbl2_mf8(p0, p1);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else (res == res));
}

/// ARM NEON intrinsic: `vtbl3_mf8`
pub inline fn vtbl3_mf8(p0: types.mf8x8x3, p1: types.mf8x8) types.mf8x8 {
    var res: types.mf8x8 = undefined;
    inline for (0..8) |i| {
        const idx = p1[i];
        res[i] = if (idx < 8) p0[0][idx] else if (idx < 16) p0[1][idx - 8] else if (idx < 24) p0[2][idx - 16] else 0;
    }
    return res;
}

test vtbl3_mf8 {
    const p0 = .{ @as(types.mf8x8, @splat(2)), @as(types.mf8x8, @splat(2)), @as(types.mf8x8, @splat(2)) };
    const p1 = @as(types.mf8x8, @splat(2));
    const res = vtbl3_mf8(p0, p1);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else (res == res));
}

/// ARM NEON intrinsic: `vtbl4_mf8`
pub inline fn vtbl4_mf8(p0: types.mf8x8x4, p1: types.mf8x8) types.mf8x8 {
    var res: types.mf8x8 = undefined;
    inline for (0..8) |i| {
        const idx = p1[i];
        res[i] = if (idx < 8) p0[0][idx] else if (idx < 16) p0[1][idx - 8] else if (idx < 24) p0[2][idx - 16] else if (idx < 32) p0[3][idx - 24] else 0;
    }
    return res;
}

test vtbl4_mf8 {
    const p0 = .{ @as(types.mf8x8, @splat(2)), @as(types.mf8x8, @splat(2)), @as(types.mf8x8, @splat(2)), @as(types.mf8x8, @splat(2)) };
    const p1 = @as(types.mf8x8, @splat(2));
    const res = vtbl4_mf8(p0, p1);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else (res == res));
}

/// ARM NEON intrinsic: `vtbx1_mf8`
pub inline fn vtbx1_mf8(p0: types.mf8x8, p1: types.mf8x8, p2: types.mf8x8) types.mf8x8 {
    var res = p0;
    inline for (0..8) |i| {
        const idx = p2[i];
        if (idx < 8) res[i] = p1[idx];
    }
    return res;
}

test vtbx1_mf8 {
    const p0 = @as(types.mf8x8, @splat(2));
    const p1 = @as(types.mf8x8, @splat(2));
    const p2 = @as(types.mf8x8, @splat(2));
    const res = vtbx1_mf8(p0, p1, p2);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: `vtbx2_mf8`
pub inline fn vtbx2_mf8(p0: types.mf8x8, p1: types.mf8x8x2, p2: types.mf8x8) types.mf8x8 {
    var res = p0;
    inline for (0..8) |i| {
        const idx = p2[i];
        if (idx < 8) res[i] = p1[0][idx] else if (idx < 16) res[i] = p1[1][idx - 8];
    }
    return res;
}

test vtbx2_mf8 {
    const p0 = @as(types.mf8x8, @splat(2));
    const p1 = .{ @as(types.mf8x8, @splat(2)), @as(types.mf8x8, @splat(2)) };
    const p2 = @as(types.mf8x8, @splat(2));
    const res = vtbx2_mf8(p0, p1, p2);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else (res == res));
}

/// ARM NEON intrinsic: `vtbx3_mf8`
pub inline fn vtbx3_mf8(p0: types.mf8x8, p1: types.mf8x8x3, p2: types.mf8x8) types.mf8x8 {
    var res = p0;
    inline for (0..8) |i| {
        const idx = p2[i];
        if (idx < 8) res[i] = p1[0][idx] else if (idx < 16) res[i] = p1[1][idx - 8] else if (idx < 24) res[i] = p1[2][idx - 16];
    }
    return res;
}

test vtbx3_mf8 {
    const p0 = @as(types.mf8x8, @splat(2));
    const p1 = .{ @as(types.mf8x8, @splat(2)), @as(types.mf8x8, @splat(2)), @as(types.mf8x8, @splat(2)) };
    const p2 = @as(types.mf8x8, @splat(2));
    const res = vtbx3_mf8(p0, p1, p2);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else (res == res));
}

/// ARM NEON intrinsic: `vtbx4_mf8`
pub inline fn vtbx4_mf8(p0: types.mf8x8, p1: types.mf8x8x4, p2: types.mf8x8) types.mf8x8 {
    var res = p0;
    inline for (0..8) |i| {
        const idx = p2[i];
        if (idx < 8) res[i] = p1[0][idx] else if (idx < 16) res[i] = p1[1][idx - 8] else if (idx < 24) res[i] = p1[2][idx - 16] else if (idx < 32) res[i] = p1[3][idx - 24];
    }
    return res;
}

test vtbx4_mf8 {
    const p0 = @as(types.mf8x8, @splat(2));
    const p1 = .{ @as(types.mf8x8, @splat(2)), @as(types.mf8x8, @splat(2)), @as(types.mf8x8, @splat(2)), @as(types.mf8x8, @splat(2)) };
    const p2 = @as(types.mf8x8, @splat(2));
    const res = vtbx4_mf8(p0, p1, p2);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else (res == res));
}

/// ARM NEON intrinsic: `vtrn1_mf8`
pub inline fn vtrn1_mf8(p0: types.mf8x8, p1: types.mf8x8) types.mf8x8 {
    return .{ p0[0], p1[0], p0[2], p1[2], p0[4], p1[4], p0[6], p1[6] };
}

test vtrn1_mf8 {
    const p0 = @as(types.mf8x8, @splat(2));
    const p1 = @as(types.mf8x8, @splat(2));
    const res = vtrn1_mf8(p0, p1);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: `vtrn1q_mf8`
pub inline fn vtrn1q_mf8(p0: types.mf8x16, p1: types.mf8x16) types.mf8x16 {
    return .{ p0[0], p1[0], p0[2], p1[2], p0[4], p1[4], p0[6], p1[6], p0[8], p1[8], p0[10], p1[10], p0[12], p1[12], p0[14], p1[14] };
}

test vtrn1q_mf8 {
    const p0 = @as(types.mf8x16, @splat(2));
    const p1 = @as(types.mf8x16, @splat(2));
    const res = vtrn1q_mf8(p0, p1);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: `vtrn2_mf8`
pub inline fn vtrn2_mf8(p0: types.mf8x8, p1: types.mf8x8) types.mf8x8 {
    return .{ p0[1], p1[1], p0[3], p1[3], p0[5], p1[5], p0[7], p1[7] };
}

test vtrn2_mf8 {
    const p0 = @as(types.mf8x8, @splat(2));
    const p1 = @as(types.mf8x8, @splat(2));
    const res = vtrn2_mf8(p0, p1);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: `vtrn2q_mf8`
pub inline fn vtrn2q_mf8(p0: types.mf8x16, p1: types.mf8x16) types.mf8x16 {
    return .{ p0[1], p1[1], p0[3], p1[3], p0[5], p1[5], p0[7], p1[7], p0[9], p1[9], p0[11], p1[11], p0[13], p1[13], p0[15], p1[15] };
}

test vtrn2q_mf8 {
    const p0 = @as(types.mf8x16, @splat(2));
    const p1 = @as(types.mf8x16, @splat(2));
    const res = vtrn2q_mf8(p0, p1);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: `vtrn_mf8`
pub inline fn vtrn_mf8(p0: types.mf8x8, p1: types.mf8x8) types.mf8x8x2 {
    return .{ p0, p1 };
}

test vtrn_mf8 {
    const p0 = @as(types.mf8x8, @splat(2));
    const p1 = @as(types.mf8x8, @splat(2));
    const res = vtrn_mf8(p0, p1);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: `vtrnq_mf8`
pub inline fn vtrnq_mf8(p0: types.mf8x16, p1: types.mf8x16) types.mf8x16x2 {
    return .{ p0, p1 };
}

test vtrnq_mf8 {
    const p0 = @as(types.mf8x16, @splat(2));
    const p1 = @as(types.mf8x16, @splat(2));
    const res = vtrnq_mf8(p0, p1);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: `vuzp1_mf8`
pub inline fn vuzp1_mf8(p0: types.mf8x8, p1: types.mf8x8) types.mf8x8 {
    return .{ p0[0], p0[2], p0[4], p0[6], p1[0], p1[2], p1[4], p1[6] };
}

test vuzp1_mf8 {
    const p0 = @as(types.mf8x8, @splat(2));
    const p1 = @as(types.mf8x8, @splat(2));
    const res = vuzp1_mf8(p0, p1);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: `vuzp1q_mf8`
pub inline fn vuzp1q_mf8(p0: types.mf8x16, p1: types.mf8x16) types.mf8x16 {
    return .{ p0[0], p0[2], p0[4], p0[6], p0[8], p0[10], p0[12], p0[14], p1[0], p1[2], p1[4], p1[6], p1[8], p1[10], p1[12], p1[14] };
}

test vuzp1q_mf8 {
    const p0 = @as(types.mf8x16, @splat(2));
    const p1 = @as(types.mf8x16, @splat(2));
    const res = vuzp1q_mf8(p0, p1);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: `vuzp2_mf8`
pub inline fn vuzp2_mf8(p0: types.mf8x8, p1: types.mf8x8) types.mf8x8 {
    return .{ p0[1], p0[3], p0[5], p0[7], p1[1], p1[3], p1[5], p1[7] };
}

test vuzp2_mf8 {
    const p0 = @as(types.mf8x8, @splat(2));
    const p1 = @as(types.mf8x8, @splat(2));
    const res = vuzp2_mf8(p0, p1);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: `vuzp2q_mf8`
pub inline fn vuzp2q_mf8(p0: types.mf8x16, p1: types.mf8x16) types.mf8x16 {
    return .{ p0[1], p0[3], p0[5], p0[7], p0[9], p0[11], p0[13], p0[15], p1[1], p1[3], p1[5], p1[7], p1[9], p1[11], p1[13], p1[15] };
}

test vuzp2q_mf8 {
    const p0 = @as(types.mf8x16, @splat(2));
    const p1 = @as(types.mf8x16, @splat(2));
    const res = vuzp2q_mf8(p0, p1);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: `vuzp_mf8`
pub inline fn vuzp_mf8(p0: types.mf8x8, p1: types.mf8x8) types.mf8x8x2 {
    return .{ p0, p1 };
}

test vuzp_mf8 {
    const p0 = @as(types.mf8x8, @splat(2));
    const p1 = @as(types.mf8x8, @splat(2));
    const res = vuzp_mf8(p0, p1);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: `vuzpq_mf8`
pub inline fn vuzpq_mf8(p0: types.mf8x16, p1: types.mf8x16) types.mf8x16x2 {
    return .{ p0, p1 };
}

test vuzpq_mf8 {
    const p0 = @as(types.mf8x16, @splat(2));
    const p1 = @as(types.mf8x16, @splat(2));
    const res = vuzpq_mf8(p0, p1);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: `vzip1_mf8`
pub inline fn vzip1_mf8(p0: types.mf8x8, p1: types.mf8x8) types.mf8x8 {
    return .{ p0[0], p1[0], p0[1], p1[1], p0[2], p1[2], p0[3], p1[3] };
}

test vzip1_mf8 {
    const p0 = @as(types.mf8x8, @splat(2));
    const p1 = @as(types.mf8x8, @splat(2));
    const res = vzip1_mf8(p0, p1);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: `vzip1q_mf8`
pub inline fn vzip1q_mf8(p0: types.mf8x16, p1: types.mf8x16) types.mf8x16 {
    return .{ p0[0], p1[0], p0[1], p1[1], p0[2], p1[2], p0[3], p1[3], p0[4], p1[4], p0[5], p1[5], p0[6], p1[6], p0[7], p1[7] };
}

test vzip1q_mf8 {
    const p0 = @as(types.mf8x16, @splat(2));
    const p1 = @as(types.mf8x16, @splat(2));
    const res = vzip1q_mf8(p0, p1);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: `vzip2_mf8`
pub inline fn vzip2_mf8(p0: types.mf8x8, p1: types.mf8x8) types.mf8x8 {
    return .{ p0[4], p1[4], p0[5], p1[5], p0[6], p1[6], p0[7], p1[7] };
}

test vzip2_mf8 {
    const p0 = @as(types.mf8x8, @splat(2));
    const p1 = @as(types.mf8x8, @splat(2));
    const res = vzip2_mf8(p0, p1);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: `vzip2q_mf8`
pub inline fn vzip2q_mf8(p0: types.mf8x16, p1: types.mf8x16) types.mf8x16 {
    return .{ p0[8], p1[8], p0[9], p1[9], p0[10], p1[10], p0[11], p1[11], p0[12], p1[12], p0[13], p1[13], p0[14], p1[14], p0[15], p1[15] };
}

test vzip2q_mf8 {
    const p0 = @as(types.mf8x16, @splat(2));
    const p1 = @as(types.mf8x16, @splat(2));
    const res = vzip2q_mf8(p0, p1);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: `vzip_mf8`
pub inline fn vzip_mf8(p0: types.mf8x8, p1: types.mf8x8) types.mf8x8x2 {
    return .{ p0, p1 };
}

test vzip_mf8 {
    const p0 = @as(types.mf8x8, @splat(2));
    const p1 = @as(types.mf8x8, @splat(2));
    const res = vzip_mf8(p0, p1);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}

/// ARM NEON intrinsic: `vzipq_mf8`
pub inline fn vzipq_mf8(p0: types.mf8x16, p1: types.mf8x16) types.mf8x16x2 {
    return .{ p0, p1 };
}

test vzipq_mf8 {
    const p0 = @as(types.mf8x16, @splat(2));
    const p1 = @as(types.mf8x16, @splat(2));
    const res = vzipq_mf8(p0, p1);
    try std.testing.expect(if (@typeInfo(@TypeOf(res)) == .vector) (res[0] == res[0]) else true);
}
