const std = @import("std");
const expectEqual = std.testing.expectEqual;
const types = @import("../types.zig");
const common = @import("../common.zig");

/// Signed Add Long across Vector
pub inline fn vaddlv_s8(a: types.i8x8) i16 {
    return @reduce(.Add, @as(types.i16x8, a));
}

test vaddlv_s8 {
    const a: types.i8x8 = .{ 1, 1, 1, 1, 1, 1, 1, 1 };
    const expected: i16 = 8;

    try expectEqual(expected, vaddlv_s8(a));
}

/// Signed Add Long across Vector
pub inline fn vaddlv_s16(a: types.i16x4) i32 {
    return @reduce(.Add, @as(types.i32x4, a));
}

test vaddlv_s16 {
    const a: types.i16x4 = .{ 1, 1, 1, 1 };
    const expected: i32 = 4;

    try expectEqual(expected, vaddlv_s16(a));
}

/// Signed Add Long across Vector
pub inline fn vaddlv_s32(a: types.i32x2) i64 {
    return @reduce(.Add, @as(types.i64x2, a));
}

test vaddlv_s32 {
    const a: types.i32x2 = .{ 1, 1 };
    const expected: i64 = 2;

    try expectEqual(expected, vaddlv_s32(a));
}

/// Unsigned Add Long across Vector
pub inline fn vaddlv_u8(a: types.u8x8) u16 {
    return @reduce(.Add, @as(types.u16x8, a));
}

test vaddlv_u8 {
    const a: types.u8x8 = .{ 1, 1, 1, 1, 1, 1, 1, 1 };
    const expected: u16 = 8;

    try expectEqual(expected, vaddlv_u8(a));
}

/// Unsigned Add Long across Vector
pub inline fn vaddlv_u16(a: types.u16x4) u32 {
    return @reduce(.Add, @as(types.u32x4, a));
}

test vaddlv_u16 {
    const a: types.u16x4 = .{ 1, 1, 1, 1 };
    const expected: u32 = 4;

    try expectEqual(expected, vaddlv_u16(a));
}

/// Unsigned Add Long across Vector
pub inline fn vaddlv_u32(a: types.u32x2) u64 {
    return @reduce(.Add, @as(types.u64x2, a));
}

test vaddlv_u32 {
    const a: types.u32x2 = .{ 1, 1 };
    const expected: u64 = 2;

    try expectEqual(expected, vaddlv_u32(a));
}

/// Signed Add Long across Vector
pub inline fn vaddlvq_s8(a: types.i8x16) i16 {
    return @reduce(.Add, @as(common.PromoteVector(types.i8x16), a));
}

test vaddlvq_s8 {
    const a: types.i8x16 = .{ 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 };
    const expected: i16 = 16;

    try expectEqual(expected, vaddlvq_s8(a));
}

/// Signed Add Long across Vector
pub inline fn vaddlvq_s16(a: types.i16x8) i32 {
    return @reduce(.Add, @as(common.PromoteVector(types.i16x8), a));
}

test vaddlvq_s16 {
    const a: types.i16x8 = .{ 1, 1, 1, 1, 1, 1, 1, 1 };
    const expected: i32 = 8;

    try expectEqual(expected, vaddlvq_s16(a));
}

/// Signed Add Long across Vector
pub inline fn vaddlvq_s32(a: types.i32x4) i64 {
    return @reduce(.Add, @as(common.PromoteVector(types.i32x4), a));
}

test vaddlvq_s32 {
    const a: types.i32x4 = .{ 1, 1, 1, 1 };
    const expected: i64 = 4;

    try expectEqual(expected, vaddlvq_s32(a));
}

/// Unsigned Add Long across Vector
pub inline fn vaddlvq_u8(a: types.u8x16) u16 {
    return @reduce(.Add, @as(common.PromoteVector(types.u8x16), a));
}

test vaddlvq_u8 {
    const a: types.u8x16 = .{ 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 };
    const expected: u16 = 16;

    try expectEqual(expected, vaddlvq_u8(a));
}

/// Unsigned Add Long across Vector
pub inline fn vaddlvq_u16(a: types.u16x8) u32 {
    return @reduce(.Add, @as(common.PromoteVector(types.u16x8), a));
}

test vaddlvq_u16 {
    const a: types.u16x8 = .{ 1, 1, 1, 1, 1, 1, 1, 1 };
    const expected: u32 = 8;

    try expectEqual(expected, vaddlvq_u16(a));
}

/// Unsigned Add Long across Vector
pub inline fn vaddlvq_u32(a: types.u32x4) u64 {
    return @reduce(.Add, @as(common.PromoteVector(types.u32x4), a));
}

test vaddlvq_u32 {
    const a: types.u32x4 = .{ 1, 1, 1, 1 };
    const expected: u64 = 4;

    try expectEqual(expected, vaddlvq_u32(a));
}

/// Signed Add Long across Vector
pub inline fn vaddv_s8(a: types.i8x8) i8 {
    return @reduce(.Add, a);
}

test vaddv_s8 {
    const a: types.i8x8 = .{ 1, 1, 1, 1, 1, 1, 1, 1 };
    const expected: i8 = 8;

    try expectEqual(expected, vaddv_s8(a));
}

/// Signed Add Long across Vector
pub inline fn vaddv_s16(a: types.i16x4) i16 {
    return @reduce(.Add, a);
}

test vaddv_s16 {
    const a: types.i16x4 = .{ 1, 1, 1, 1 };
    const expected: i16 = 4;

    try expectEqual(expected, vaddv_s16(a));
}

/// Signed Add Long across Vector
pub inline fn vaddv_s32(a: types.i32x2) i32 {
    return @reduce(.Add, a);
}

test vaddv_s32 {
    const a: types.i32x2 = .{ 1, 1 };
    const expected: i32 = 2;

    try expectEqual(expected, vaddv_s32(a));
}

/// Unsigned Add Long across Vector
pub inline fn vaddv_u8(a: types.u8x8) u8 {
    return @reduce(.Add, a);
}

test vaddv_u8 {
    const a: types.u8x8 = .{ 1, 1, 1, 1, 1, 1, 1, 1 };
    const expected: u8 = 8;

    try expectEqual(expected, vaddv_u8(a));
}

/// Unsigned Add Long across Vector
pub inline fn vaddv_u16(a: types.u16x4) u16 {
    return @reduce(.Add, a);
}

test vaddv_u16 {
    const a: types.u16x4 = .{ 1, 1, 1, 1 };
    const expected: u16 = 4;

    try expectEqual(expected, vaddv_u16(a));
}

/// Unsigned Add Long across Vector
pub inline fn vaddv_u32(a: types.u32x2) u32 {
    return @reduce(.Add, a);
}

test vaddv_u32 {
    const a: types.u32x2 = .{ 1, 1 };
    const expected: u32 = 2;

    try expectEqual(expected, vaddv_u32(a));
}

/// Floating-point add across vector
pub inline fn vaddv_f32(a: types.f32x2) f32 {
    return @reduce(.Add, a);
}

test vaddv_f32 {
    const a: types.f32x2 = @splat(1.0);
    const expected: f32 = 2;
    try common.testIntrinsic(.{ .func = vaddv_f32, .expected = expected, .args = .{a} });
}

/// Signed Add Long across Vector
pub inline fn vaddvq_s8(a: types.i8x16) i8 {
    return @reduce(.Add, a);
}

test vaddvq_s8 {
    const a: types.i8x16 = .{ 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 };
    const expected: i8 = 16;

    try expectEqual(expected, vaddvq_s8(a));
}

/// Signed Add Long across Vector
pub inline fn vaddvq_s16(a: types.i16x8) i16 {
    return @reduce(.Add, a);
}

test vaddvq_s16 {
    const a: types.i16x8 = .{ 1, 1, 1, 1, 1, 1, 1, 1 };
    const expected: i16 = 8;

    try expectEqual(expected, vaddvq_s16(a));
}

/// Signed Add Long across Vector
pub inline fn vaddvq_s32(a: types.i32x4) i32 {
    return @reduce(.Add, a);
}

test vaddvq_s32 {
    const a: types.i32x4 = .{ 1, 1, 1, 1 };
    const expected: i32 = 4;

    try expectEqual(expected, vaddvq_s32(a));
}

/// Unsigned Add Long across Vector
pub inline fn vaddvq_s64(a: types.i64x2) i64 {
    return @reduce(.Add, a);
}

test vaddvq_s64 {
    const a: types.i64x2 = .{ 1, 1 };
    const expected: i64 = 2;

    try expectEqual(expected, vaddvq_s64(a));
}

/// Unsigned Add Long across Vector
pub inline fn vaddvq_u8(a: types.u8x16) u8 {
    return @reduce(.Add, a);
}

test vaddvq_u8 {
    const a: types.u8x16 = .{ 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 };
    const expected: u8 = 16;

    try expectEqual(expected, vaddvq_u8(a));
}

/// Unsigned Add Long across Vector
pub inline fn vaddvq_u16(a: types.u16x8) u16 {
    return @reduce(.Add, a);
}

test vaddvq_u16 {
    const a: types.u16x8 = .{ 1, 1, 1, 1, 1, 1, 1, 1 };
    const expected: u16 = 8;

    try expectEqual(expected, vaddvq_u16(a));
}

/// Unsigned Add Long across Vector
pub inline fn vaddvq_u32(a: types.u32x4) u32 {
    return @reduce(.Add, a);
}

test vaddvq_u32 {
    const a: types.u32x4 = .{ 1, 1, 1, 1 };
    const expected: u32 = 4;

    try expectEqual(expected, vaddvq_u32(a));
}

/// Unsigned Add Long across Vector
pub inline fn vaddvq_u64(a: types.u64x2) u64 {
    return @reduce(.Add, a);
}

test vaddvq_u64 {
    const a: types.u64x2 = .{ 1, 1 };
    const expected: u64 = 2;

    try expectEqual(expected, vaddvq_u64(a));
}

/// Unsigned Add Long across Vector
pub inline fn vaddvq_f32(a: types.f32x4) f32 {
    return @reduce(.Add, a);
}

test vaddvq_f32 {
    const a: types.f32x4 = @splat(1.0);
    const expected: f32 = 4;
    try common.testIntrinsic(.{ .func = vaddvq_f32, .expected = expected, .args = .{a} });
}

/// Unsigned Add Long across Vector
pub inline fn vaddvq_f64(a: types.f64x2) f64 {
    return @reduce(.Add, a);
}

test vaddvq_f64 {
    const a: types.f64x2 = @splat(1.0);
    const expected: f64 = 2;
    try common.testIntrinsic(.{ .func = vaddvq_f64, .expected = expected, .args = .{a} });
}

/// Floating-point maximum number across vector
pub inline fn vmaxnmv_f32(a: types.f32x2) f32 {
    return @reduce(.Max, a);
}

test vmaxnmv_f32 {
    const a: types.f32x2 = .{ 0.59, 0.5 };
    const expected: f32 = 0.59;

    try expectEqual(expected, vmaxnmv_f32(a));
}

/// Floating-point maximum number across vector
pub inline fn vmaxnmvq_f32(a: types.f32x4) f32 {
    return @reduce(.Max, a);
}

test vmaxnmvq_f32 {
    const a: types.f32x4 = .{ 0.59, 0.5, 2.5, 50.2 };
    const expected: f32 = 50.2;

    try expectEqual(expected, vmaxnmvq_f32(a));
}

/// Horizontal vector max
pub inline fn vmaxv_s8(a: types.i8x8) i8 {
    return @reduce(.Max, a);
}

test vmaxv_s8 {
    const a: types.i8x8 = @splat(1);
    const expected: i8 = 1;
    try common.testIntrinsic(.{ .func = vmaxv_s8, .expected = expected, .args = .{a} });
}

/// Horizontal vector max
pub inline fn vmaxv_s16(a: types.i16x4) i16 {
    return @reduce(.Max, a);
}

test vmaxv_s16 {
    const a: types.i16x4 = @splat(1);
    const expected: i16 = 1;
    try common.testIntrinsic(.{ .func = vmaxv_s16, .expected = expected, .args = .{a} });
}

/// Horizontal vector max
pub inline fn vmaxv_s32(a: types.i32x2) i32 {
    return @reduce(.Max, a);
}

test vmaxv_s32 {
    const a: types.i32x2 = @splat(1);
    const expected: i32 = 1;
    try common.testIntrinsic(.{ .func = vmaxv_s32, .expected = expected, .args = .{a} });
}

/// Horizontal vector max
pub inline fn vmaxv_u8(a: types.u8x8) u8 {
    return @reduce(.Max, a);
}

test vmaxv_u8 {
    const a: types.u8x8 = @splat(1);
    const expected: u8 = 1;
    try common.testIntrinsic(.{ .func = vmaxv_u8, .expected = expected, .args = .{a} });
}

/// Horizontal vector max
pub inline fn vmaxv_u16(a: types.u16x4) u16 {
    return @reduce(.Max, a);
}

test vmaxv_u16 {
    const a: types.u16x4 = @splat(1);
    const expected: u16 = 1;
    try common.testIntrinsic(.{ .func = vmaxv_u16, .expected = expected, .args = .{a} });
}

/// Horizontal vector max
pub inline fn vmaxv_u32(a: types.u32x2) u32 {
    return @reduce(.Max, a);
}

test vmaxv_u32 {
    const a: types.u32x2 = @splat(1);
    const expected: u32 = 1;
    try common.testIntrinsic(.{ .func = vmaxv_u32, .expected = expected, .args = .{a} });
}

/// Horizontal vector max
pub inline fn vmaxvq_s8(a: types.i8x16) i8 {
    return @reduce(.Max, a);
}

test vmaxvq_s8 {
    const a: types.i8x16 = @splat(1);
    const expected: i8 = 1;
    try common.testIntrinsic(.{ .func = vmaxvq_s8, .expected = expected, .args = .{a} });
}

/// Horizontal vector max
pub inline fn vmaxvq_s16(a: types.i16x8) i16 {
    return @reduce(.Max, a);
}

test vmaxvq_s16 {
    const a: types.i16x8 = @splat(1);
    const expected: i16 = 1;
    try common.testIntrinsic(.{ .func = vmaxvq_s16, .expected = expected, .args = .{a} });
}

/// Horizontal vector max
pub inline fn vmaxvq_s32(a: types.i32x4) i32 {
    return @reduce(.Max, a);
}

test vmaxvq_s32 {
    const a: types.i32x4 = @splat(1);
    const expected: i32 = 1;
    try common.testIntrinsic(.{ .func = vmaxvq_s32, .expected = expected, .args = .{a} });
}

/// Horizontal vector max
pub inline fn vmaxvq_u8(a: types.u8x16) u8 {
    return @reduce(.Max, a);
}

test vmaxvq_u8 {
    const a: types.u8x16 = @splat(1);
    const expected: u8 = 1;
    try common.testIntrinsic(.{ .func = vmaxvq_u8, .expected = expected, .args = .{a} });
}

/// Horizontal vector max
pub inline fn vmaxvq_u16(a: types.u16x8) u16 {
    return @reduce(.Max, a);
}

test vmaxvq_u16 {
    const a: types.u16x8 = @splat(1);
    const expected: u16 = 1;
    try common.testIntrinsic(.{ .func = vmaxvq_u16, .expected = expected, .args = .{a} });
}

/// Horizontal vector max
pub inline fn vmaxvq_u32(a: types.u32x4) u32 {
    return @reduce(.Max, a);
}

test vmaxvq_u32 {
    const a: types.u32x4 = @splat(1);
    const expected: u32 = 1;
    try common.testIntrinsic(.{ .func = vmaxvq_u32, .expected = expected, .args = .{a} });
}

/// Horizontal vector max
pub inline fn vmaxvq_f32(a: types.f32x4) f32 {
    return @reduce(.Max, a);
}

test vmaxvq_f32 {
    const a: types.f32x4 = @splat(1.0);
    const expected: f32 = 1;
    try common.testIntrinsic(.{ .func = vmaxvq_f32, .expected = expected, .args = .{a} });
}

/// Horizontal vector max
pub inline fn vmaxvq_f64(a: types.f64x2) f64 {
    return @reduce(.Max, a);
}

test vmaxvq_f64 {
    const a: types.f64x2 = @splat(1.0);
    const expected: f64 = 1;
    try common.testIntrinsic(.{ .func = vmaxvq_f64, .expected = expected, .args = .{a} });
}

/// Floating-point maximum number across vector
pub inline fn vminnmv_f32(a: types.f32x2) f32 {
    return @reduce(.Min, a);
}

test vminnmv_f32 {
    const a: types.f32x2 = .{ 0.59, 0.5 };
    const expected: f32 = 0.5;

    try expectEqual(expected, vminnmv_f32(a));
}

/// Floating-point minimum number across vector
pub inline fn vminnmvq_f32(a: types.f32x4) f32 {
    return @reduce(.Min, a);
}

test vminnmvq_f32 {
    const a: types.f32x4 = .{ 0.59, 0.5, 2.5, 50.2 };
    const expected: f32 = 0.5;

    try expectEqual(expected, vminnmvq_f32(a));
}

/// Horizontal vector min
pub inline fn vminv_s8(a: types.i8x8) i8 {
    return @reduce(.Min, a);
}

test vminv_s8 {
    const a: types.i8x8 = @splat(1);
    const expected: i8 = 1;
    try common.testIntrinsic(.{ .func = vminv_s8, .expected = expected, .args = .{a} });
}

/// Horizontal vector min
pub inline fn vminv_s16(a: types.i16x4) i16 {
    return @reduce(.Min, a);
}

test vminv_s16 {
    const a: types.i16x4 = @splat(1);
    const expected: i16 = 1;
    try common.testIntrinsic(.{ .func = vminv_s16, .expected = expected, .args = .{a} });
}

/// Horizontal vector min
pub inline fn vminv_s32(a: types.i32x2) i32 {
    return @reduce(.Min, a);
}

test vminv_s32 {
    const a: types.i32x2 = @splat(1);
    const expected: i32 = 1;
    try common.testIntrinsic(.{ .func = vminv_s32, .expected = expected, .args = .{a} });
}

/// Horizontal vector min
pub inline fn vminv_u8(a: types.u8x8) u8 {
    return @reduce(.Min, a);
}

test vminv_u8 {
    const a: types.u8x8 = @splat(1);
    const expected: u8 = 1;
    try common.testIntrinsic(.{ .func = vminv_u8, .expected = expected, .args = .{a} });
}

/// Horizontal vector min
pub inline fn vminv_u16(a: types.u16x4) u16 {
    return @reduce(.Min, a);
}

test vminv_u16 {
    const a: types.u16x4 = @splat(1);
    const expected: u16 = 1;
    try common.testIntrinsic(.{ .func = vminv_u16, .expected = expected, .args = .{a} });
}

/// Horizontal vector min
pub inline fn vminv_u32(a: types.u32x2) u32 {
    return @reduce(.Min, a);
}

test vminv_u32 {
    const a: types.u32x2 = @splat(1);
    const expected: u32 = 1;
    try common.testIntrinsic(.{ .func = vminv_u32, .expected = expected, .args = .{a} });
}

/// Horizontal vector min
pub inline fn vminvq_s8(a: types.i8x16) i8 {
    return @reduce(.Min, a);
}

test vminvq_s8 {
    const a: types.i8x16 = @splat(1);
    const expected: i8 = 1;
    try common.testIntrinsic(.{ .func = vminvq_s8, .expected = expected, .args = .{a} });
}

/// Horizontal vector min
pub inline fn vminvq_s16(a: types.i16x8) i16 {
    return @reduce(.Min, a);
}

test vminvq_s16 {
    const a: types.i16x8 = @splat(1);
    const expected: i16 = 1;
    try common.testIntrinsic(.{ .func = vminvq_s16, .expected = expected, .args = .{a} });
}

/// Horizontal vector min
pub inline fn vminvq_s32(a: types.i32x4) i32 {
    return @reduce(.Min, a);
}

test vminvq_s32 {
    const a: types.i32x4 = @splat(1);
    const expected: i32 = 1;
    try common.testIntrinsic(.{ .func = vminvq_s32, .expected = expected, .args = .{a} });
}

/// Horizontal vector min
pub inline fn vminvq_u8(a: types.u8x16) u8 {
    return @reduce(.Min, a);
}

test vminvq_u8 {
    const a: types.u8x16 = @splat(1);
    const expected: u8 = 1;
    try common.testIntrinsic(.{ .func = vminvq_u8, .expected = expected, .args = .{a} });
}

/// Horizontal vector min
pub inline fn vminvq_u16(a: types.u16x8) u16 {
    return @reduce(.Min, a);
}

test vminvq_u16 {
    const a: types.u16x8 = @splat(1);
    const expected: u16 = 1;
    try common.testIntrinsic(.{ .func = vminvq_u16, .expected = expected, .args = .{a} });
}

/// Horizontal vector min
pub inline fn vminvq_u32(a: types.u32x4) u32 {
    return @reduce(.Min, a);
}

test vminvq_u32 {
    const a: types.u32x4 = @splat(1);
    const expected: u32 = 1;
    try common.testIntrinsic(.{ .func = vminvq_u32, .expected = expected, .args = .{a} });
}

/// Horizontal vector min
pub inline fn vminvq_f32(a: types.f32x4) f32 {
    return @reduce(.Min, a);
}

test vminvq_f32 {
    const a: types.f32x4 = @splat(1.0);
    const expected: f32 = 1;
    try common.testIntrinsic(.{ .func = vminvq_f32, .expected = expected, .args = .{a} });
}

/// Horizontal vector min
pub inline fn vminvq_f64(a: types.f64x2) f64 {
    return @reduce(.Min, a);
}

test vminvq_f64 {
    const a: types.f64x2 = @splat(1.0);
    const expected: f64 = 1;
    try common.testIntrinsic(.{ .func = vminvq_f64, .expected = expected, .args = .{a} });
}
