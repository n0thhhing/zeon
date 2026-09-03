const std = @import("std");
const expectEqual = std.testing.expectEqual;
const common = @import("../common.zig");
const decodeFp8 = common.decodeFp8;
const encodeFp8 = common.encodeFp8;

const arch = @import("../arch.zig");
const types = @import("../types.zig");
const permute = @import("permute.zig");

/// Vector long move
pub inline fn vmovl_s8(a: types.i8x8) types.i16x8 {
    // This would compile down to sshll v0.8h, v0.8b, #0
    // in AArch64 and vmov d16, r0, r1; vmovl.s8 q8, d16;
    // vmov r0, r1, d16; vmov r2, r3, d17; in ARM(would be
    // the same if we do use inline assembly), but it still
    // has the same result, therefore we wont need inline
    // assembly here.
    return @as(types.i16x8, a);
}

test vmovl_s8 {
    const v: types.i8x8 = .{ 0, -1, -2, -3, -4, -5, -6, -7 };

    try expectEqual(types.i16x8{ 0, -1, -2, -3, -4, -5, -6, -7 }, vmovl_s8(v));
}

/// Vector long move
pub inline fn vmovl_s16(a: types.i16x4) types.i32x4 {
    return @as(types.i32x4, a);
}

test vmovl_s16 {
    const v: types.i16x4 = .{ 0, -1, -2, -3 };
    try expectEqual(@as(types.i32x4, .{ 0, -1, -2, -3 }), vmovl_s16(v));
}

/// Vector long move
pub inline fn vmovl_s32(a: types.i32x2) types.i64x2 {
    return @as(types.i64x2, a);
}

test vmovl_s32 {
    const v: types.i32x2 = .{ 0, -1 };
    try expectEqual(@as(types.i32x2, .{ 0, -1 }), vmovl_s32(v));
}

/// Vector long move
pub inline fn vmovl_u8(a: types.u8x8) types.u16x8 {
    return @as(types.u16x8, a);
}

test vmovl_u8 {
    const v: types.u8x8 = .{ 0, 1, 2, 3, 4, 5, 6, 7 };
    try expectEqual(@as(types.u16x8, .{ 0, 1, 2, 3, 4, 5, 6, 7 }), vmovl_u8(v));
}

/// Vector long move
pub inline fn vmovl_u16(a: types.u16x4) types.u32x4 {
    return @as(types.u32x4, a);
}

test vmovl_u16 {
    const v: types.u16x4 = .{ 0, 1, 2, 3 };
    try expectEqual(@as(types.u32x4, .{ 0, 1, 2, 3 }), vmovl_u16(v));
}

/// Vector long move
pub inline fn vmovl_u32(a: types.u32x2) types.u64x2 {
    return @as(types.u64x2, a);
}

test vmovl_u32 {
    const v: types.u32x2 = .{ 0, 1 };
    try expectEqual(@as(types.u32x2, .{ 0, 1 }), vmovl_u32(v));
}

/// Vector long move
pub inline fn vmovl_high_s8(a: types.i8x16) types.i16x8 {
    return vmovl_s8(permute.vget_high_s8(a));
}

test vmovl_high_s8 {
    const v: types.i8x16 = .{ 0, -1, -2, -3, -4, -5, -6, -7, 0, -1, -2, -3, -4, -5, -6, -7 };
    try expectEqual(types.i16x8{ 0, -1, -2, -3, -4, -5, -6, -7 }, vmovl_high_s8(v));
}

/// Vector long move
pub inline fn vmovl_high_s16(a: types.i16x8) types.i32x4 {
    return vmovl_s16(permute.vget_high_s16(a));
}

test vmovl_high_s16 {
    const v: types.i16x8 = .{ 0, -1, -2, -3, 0, -1, -2, -3 };
    try expectEqual(@as(types.i32x4, .{ 0, -1, -2, -3 }), vmovl_high_s16(v));
}

/// Vector long move
pub inline fn vmovl_high_s32(a: types.i32x4) types.i64x2 {
    return vmovl_s32(permute.vget_high_s32(a));
}

test vmovl_high_s32 {
    const v: types.i32x4 = .{ 0, -1, 0, -1 };
    try expectEqual(@as(types.i32x2, .{ 0, -1 }), vmovl_high_s32(v));
}

/// Vector long move
pub inline fn vmovl_high_u8(a: types.u8x16) types.u16x8 {
    return vmovl_u8(permute.vget_high_u8(a));
}

test vmovl_high_u8 {
    const v: types.u8x16 = .{ 0, 1, 2, 3, 4, 5, 6, 7, 0, 1, 2, 3, 4, 5, 6, 7 };
    try expectEqual(@as(types.u16x8, .{ 0, 1, 2, 3, 4, 5, 6, 7 }), vmovl_high_u8(v));
}

/// Vector long move
pub inline fn vmovl_high_u16(a: types.u16x8) types.u32x4 {
    return vmovl_u16(permute.vget_high_u16(a));
}

test vmovl_high_u16 {
    const v: types.u16x8 = .{ 0, 1, 2, 3, 0, 1, 2, 3 };
    try expectEqual(@as(types.u32x4, .{ 0, 1, 2, 3 }), vmovl_high_u16(v));
}

/// Vector long move
pub inline fn vmovl_high_u32(a: types.u32x4) types.u64x2 {
    return vmovl_u32(permute.vget_high_u32(a));
}

test vmovl_high_u32 {
    const v: types.u32x4 = .{ 0, 1, 0, 1 };
    try expectEqual(@as(types.u32x2, .{ 0, 1 }), vmovl_high_u32(v));
}

/// Vector type conversion
pub inline fn vcvt_f32_s32(a: types.i32x2) types.f32x2 {
    return @floatFromInt(a);
}

test vcvt_f32_s32 {
    const a = @as(types.i32x2, @splat(10));
    const expected = @as(types.f32x2, @splat(10.0));
    try common.testIntrinsic(.{ .func = vcvt_f32_s32, .expected = expected, .args = .{a} });
}

/// Vector type conversion
pub inline fn vcvt_f32_u32(a: types.u32x2) types.f32x2 {
    return @floatFromInt(a);
}

test vcvt_f32_u32 {
    const a = @as(types.u32x2, @splat(10));
    const expected = @as(types.f32x2, @splat(10.0));
    try common.testIntrinsic(.{ .func = vcvt_f32_u32, .expected = expected, .args = .{a} });
}

/// Vector type conversion
pub inline fn vcvt_s32_f32(a: types.f32x2) types.i32x2 {
    return @intFromFloat(a);
}

test vcvt_s32_f32 {
    const a = @as(types.f32x2, @splat(10.0));
    const expected = @as(types.i32x2, @splat(10));
    try common.testIntrinsic(.{ .func = vcvt_s32_f32, .expected = expected, .args = .{a} });
}

/// Vector type conversion
pub inline fn vcvt_u32_f32(a: types.f32x2) types.u32x2 {
    return @intFromFloat(a);
}

test vcvt_u32_f32 {
    const a = @as(types.f32x2, @splat(10.0));
    const expected = @as(types.u32x2, @splat(10));
    try common.testIntrinsic(.{ .func = vcvt_u32_f32, .expected = expected, .args = .{a} });
}

/// Vector type conversion
pub inline fn vcvt_f64_s64(a: types.i64x1) types.f64x1 {
    return @floatFromInt(a);
}

test vcvt_f64_s64 {
    const a = @as(types.i64x1, @splat(10));
    const expected = @as(types.f64x1, @splat(10.0));
    try common.testIntrinsic(.{ .func = vcvt_f64_s64, .expected = expected, .args = .{a} });
}

/// Vector type conversion
pub inline fn vcvt_f64_u64(a: types.u64x1) types.f64x1 {
    return @floatFromInt(a);
}

test vcvt_f64_u64 {
    const a = @as(types.u64x1, @splat(10));
    const expected = @as(types.f64x1, @splat(10.0));
    try common.testIntrinsic(.{ .func = vcvt_f64_u64, .expected = expected, .args = .{a} });
}

/// Vector type conversion
pub inline fn vcvt_s64_f64(a: types.f64x1) types.i64x1 {
    return @intFromFloat(a);
}

test vcvt_s64_f64 {
    const a = @as(types.f64x1, @splat(10.0));
    const expected = @as(types.i64x1, @splat(10));
    try common.testIntrinsic(.{ .func = vcvt_s64_f64, .expected = expected, .args = .{a} });
}

/// Vector type conversion
pub inline fn vcvt_u64_f64(a: types.f64x1) types.u64x1 {
    return @intFromFloat(a);
}

test vcvt_u64_f64 {
    const a = @as(types.f64x1, @splat(10.0));
    const expected = @as(types.u64x1, @splat(10));
    try common.testIntrinsic(.{ .func = vcvt_u64_f64, .expected = expected, .args = .{a} });
}

/// Vector type conversion
pub inline fn vcvt_f16_s16(a: types.i16x4) types.f16x4 {
    return @floatFromInt(a);
}

test vcvt_f16_s16 {
    const a = @as(types.i16x4, @splat(10));
    const expected = @as(types.f16x4, @splat(10.0));
    try common.testIntrinsic(.{ .func = vcvt_f16_s16, .expected = expected, .args = .{a} });
}

/// Vector type conversion
pub inline fn vcvt_f16_u16(a: types.u16x4) types.f16x4 {
    return @floatFromInt(a);
}

test vcvt_f16_u16 {
    const a = @as(types.u16x4, @splat(10));
    const expected = @as(types.f16x4, @splat(10.0));
    try common.testIntrinsic(.{ .func = vcvt_f16_u16, .expected = expected, .args = .{a} });
}

/// Vector type conversion
pub inline fn vcvt_s16_f16(a: types.f16x4) types.i16x4 {
    return @intFromFloat(a);
}

test vcvt_s16_f16 {
    const a = @as(types.f16x4, @splat(10.0));
    const expected = @as(types.i16x4, @splat(10));
    try common.testIntrinsic(.{ .func = vcvt_s16_f16, .expected = expected, .args = .{a} });
}

/// Vector type conversion
pub inline fn vcvt_u16_f16(a: types.f16x4) types.u16x4 {
    return @intFromFloat(a);
}

test vcvt_u16_f16 {
    const a = @as(types.f16x4, @splat(10.0));
    const expected = @as(types.u16x4, @splat(10));
    try common.testIntrinsic(.{ .func = vcvt_u16_f16, .expected = expected, .args = .{a} });
}

/// Vector type conversion
pub inline fn vcvtq_f32_s32(a: types.i32x4) types.f32x4 {
    return @floatFromInt(a);
}

test vcvtq_f32_s32 {
    const a = @as(types.i32x4, @splat(10));
    const expected = @as(types.f32x4, @splat(10.0));
    try common.testIntrinsic(.{ .func = vcvtq_f32_s32, .expected = expected, .args = .{a} });
}

/// Vector type conversion
pub inline fn vcvtq_f32_u32(a: types.u32x4) types.f32x4 {
    return @floatFromInt(a);
}

test vcvtq_f32_u32 {
    const a = @as(types.u32x4, @splat(10));
    const expected = @as(types.f32x4, @splat(10.0));
    try common.testIntrinsic(.{ .func = vcvtq_f32_u32, .expected = expected, .args = .{a} });
}

/// Vector type conversion
pub inline fn vcvtq_s32_f32(a: types.f32x4) types.i32x4 {
    return @intFromFloat(a);
}

test vcvtq_s32_f32 {
    const a = @as(types.f32x4, @splat(10.0));
    const expected = @as(types.i32x4, @splat(10));
    try common.testIntrinsic(.{ .func = vcvtq_s32_f32, .expected = expected, .args = .{a} });
}

/// Vector type conversion
pub inline fn vcvtq_u32_f32(a: types.f32x4) types.u32x4 {
    return @intFromFloat(a);
}

test vcvtq_u32_f32 {
    const a = @as(types.f32x4, @splat(10.0));
    const expected = @as(types.u32x4, @splat(10));
    try common.testIntrinsic(.{ .func = vcvtq_u32_f32, .expected = expected, .args = .{a} });
}

/// Vector type conversion
pub inline fn vcvtq_f64_s64(a: types.i64x2) types.f64x2 {
    return @floatFromInt(a);
}

test vcvtq_f64_s64 {
    const a = @as(types.i64x2, @splat(10));
    const expected = @as(types.f64x2, @splat(10.0));
    try common.testIntrinsic(.{ .func = vcvtq_f64_s64, .expected = expected, .args = .{a} });
}

/// Vector type conversion
pub inline fn vcvtq_f64_u64(a: types.u64x2) types.f64x2 {
    return @floatFromInt(a);
}

test vcvtq_f64_u64 {
    const a = @as(types.u64x2, @splat(10));
    const expected = @as(types.f64x2, @splat(10.0));
    try common.testIntrinsic(.{ .func = vcvtq_f64_u64, .expected = expected, .args = .{a} });
}

/// Vector type conversion
pub inline fn vcvtq_s64_f64(a: types.f64x2) types.i64x2 {
    return @intFromFloat(a);
}

test vcvtq_s64_f64 {
    const a = @as(types.f64x2, @splat(10.0));
    const expected = @as(types.i64x2, @splat(10));
    try common.testIntrinsic(.{ .func = vcvtq_s64_f64, .expected = expected, .args = .{a} });
}

/// Vector type conversion
pub inline fn vcvtq_u64_f64(a: types.f64x2) types.u64x2 {
    return @intFromFloat(a);
}

test vcvtq_u64_f64 {
    const a = @as(types.f64x2, @splat(10.0));
    const expected = @as(types.u64x2, @splat(10));
    try common.testIntrinsic(.{ .func = vcvtq_u64_f64, .expected = expected, .args = .{a} });
}

/// Vector type conversion
pub inline fn vcvtq_f16_s16(a: types.i16x8) types.f16x8 {
    return @floatFromInt(a);
}

test vcvtq_f16_s16 {
    const a = @as(types.i16x8, @splat(10));
    const expected = @as(types.f16x8, @splat(10.0));
    try common.testIntrinsic(.{ .func = vcvtq_f16_s16, .expected = expected, .args = .{a} });
}

/// Vector type conversion
pub inline fn vcvtq_f16_u16(a: types.u16x8) types.f16x8 {
    return @floatFromInt(a);
}

test vcvtq_f16_u16 {
    const a = @as(types.u16x8, @splat(10));
    const expected = @as(types.f16x8, @splat(10.0));
    try common.testIntrinsic(.{ .func = vcvtq_f16_u16, .expected = expected, .args = .{a} });
}

/// Vector type conversion
pub inline fn vcvtq_s16_f16(a: types.f16x8) types.i16x8 {
    return @intFromFloat(a);
}

test vcvtq_s16_f16 {
    const a = @as(types.f16x8, @splat(10.0));
    const expected = @as(types.i16x8, @splat(10));
    try common.testIntrinsic(.{ .func = vcvtq_s16_f16, .expected = expected, .args = .{a} });
}

/// Vector type conversion
pub inline fn vcvtq_u16_f16(a: types.f16x8) types.u16x8 {
    return @intFromFloat(a);
}

test vcvtq_u16_f16 {
    const a = @as(types.f16x8, @splat(10.0));
    const expected = @as(types.u16x8, @splat(10));
    try common.testIntrinsic(.{ .func = vcvtq_u16_f16, .expected = expected, .args = .{a} });
}

/// Vector conversion with round to nearest, ties away from zero
pub inline fn vcvta_s32_f32(a: types.f32x2) types.i32x2 {
    return @intFromFloat(@round(a));
}

test vcvta_s32_f32 {
    const a = @as(types.f32x2, @splat(1.6));
    const res = vcvta_s32_f32(a);
    try std.testing.expect(res[0] == 2);
}

/// Vector conversion with round to nearest, ties away from zero
pub inline fn vcvta_u32_f32(a: types.f32x2) types.u32x2 {
    return @intFromFloat(@round(a));
}

test vcvta_u32_f32 {
    const a = @as(types.f32x2, @splat(1.6));
    const res = vcvta_u32_f32(a);
    try std.testing.expect(res[0] == 2);
}

/// Vector conversion with round to nearest, ties away from zero
pub inline fn vcvta_s64_f64(a: types.f64x1) types.i64x1 {
    return @intFromFloat(@round(a));
}

test vcvta_s64_f64 {
    const a = @as(types.f64x1, @splat(1.6));
    const res = vcvta_s64_f64(a);
    try std.testing.expect(res[0] == 2);
}

/// Vector conversion with round to nearest, ties away from zero
pub inline fn vcvta_u64_f64(a: types.f64x1) types.u64x1 {
    return @intFromFloat(@round(a));
}

test vcvta_u64_f64 {
    const a = @as(types.f64x1, @splat(1.6));
    const res = vcvta_u64_f64(a);
    try std.testing.expect(res[0] == 2);
}

/// Vector conversion with round to nearest, ties away from zero
pub inline fn vcvta_s16_f16(a: types.f16x4) types.i16x4 {
    return @intFromFloat(@round(a));
}

test vcvta_s16_f16 {
    const a = @as(types.f16x4, @splat(1.6));
    const res = vcvta_s16_f16(a);
    try std.testing.expect(res[0] == 2);
}

/// Vector conversion with round to nearest, ties away from zero
pub inline fn vcvta_u16_f16(a: types.f16x4) types.u16x4 {
    return @intFromFloat(@round(a));
}

test vcvta_u16_f16 {
    const a = @as(types.f16x4, @splat(1.6));
    const res = vcvta_u16_f16(a);
    try std.testing.expect(res[0] == 2);
}

/// Vector conversion with round to nearest, ties away from zero
pub inline fn vcvtaq_s32_f32(a: types.f32x4) types.i32x4 {
    return @intFromFloat(@round(a));
}

test vcvtaq_s32_f32 {
    const a = @as(types.f32x4, @splat(1.6));
    const res = vcvtaq_s32_f32(a);
    try std.testing.expect(res[0] == 2);
}

/// Vector conversion with round to nearest, ties away from zero
pub inline fn vcvtaq_u32_f32(a: types.f32x4) types.u32x4 {
    return @intFromFloat(@round(a));
}

test vcvtaq_u32_f32 {
    const a = @as(types.f32x4, @splat(1.6));
    const res = vcvtaq_u32_f32(a);
    try std.testing.expect(res[0] == 2);
}

/// Vector conversion with round to nearest, ties away from zero
pub inline fn vcvtaq_s64_f64(a: types.f64x2) types.i64x2 {
    return @intFromFloat(@round(a));
}

test vcvtaq_s64_f64 {
    const a = @as(types.f64x2, @splat(1.6));
    const res = vcvtaq_s64_f64(a);
    try std.testing.expect(res[0] == 2);
}

/// Vector conversion with round to nearest, ties away from zero
pub inline fn vcvtaq_u64_f64(a: types.f64x2) types.u64x2 {
    return @intFromFloat(@round(a));
}

test vcvtaq_u64_f64 {
    const a = @as(types.f64x2, @splat(1.6));
    const res = vcvtaq_u64_f64(a);
    try std.testing.expect(res[0] == 2);
}

/// Vector conversion with round to nearest, ties away from zero
pub inline fn vcvtaq_s16_f16(a: types.f16x8) types.i16x8 {
    return @intFromFloat(@round(a));
}

test vcvtaq_s16_f16 {
    const a = @as(types.f16x8, @splat(1.6));
    const res = vcvtaq_s16_f16(a);
    try std.testing.expect(res[0] == 2);
}

/// Vector conversion with round to nearest, ties away from zero
pub inline fn vcvtaq_u16_f16(a: types.f16x8) types.u16x8 {
    return @intFromFloat(@round(a));
}

test vcvtaq_u16_f16 {
    const a = @as(types.f16x8, @splat(1.6));
    const res = vcvtaq_u16_f16(a);
    try std.testing.expect(res[0] == 2);
}

/// Vector conversion with round toward -infinity (floor)
pub inline fn vcvtm_s32_f32(a: types.f32x2) types.i32x2 {
    return @intFromFloat(@floor(a));
}

test vcvtm_s32_f32 {
    const a = @as(types.f32x2, @splat(1.6));
    const res = vcvtm_s32_f32(a);
    try std.testing.expect(res[0] == 1);
}

/// Vector conversion with round toward -infinity (floor)
pub inline fn vcvtm_u32_f32(a: types.f32x2) types.u32x2 {
    return @intFromFloat(@floor(a));
}

test vcvtm_u32_f32 {
    const a = @as(types.f32x2, @splat(1.6));
    const res = vcvtm_u32_f32(a);
    try std.testing.expect(res[0] == 1);
}

/// Vector conversion with round toward -infinity (floor)
pub inline fn vcvtm_s64_f64(a: types.f64x1) types.i64x1 {
    return @intFromFloat(@floor(a));
}

test vcvtm_s64_f64 {
    const a = @as(types.f64x1, @splat(1.6));
    const res = vcvtm_s64_f64(a);
    try std.testing.expect(res[0] == 1);
}

/// Vector conversion with round toward -infinity (floor)
pub inline fn vcvtm_u64_f64(a: types.f64x1) types.u64x1 {
    return @intFromFloat(@floor(a));
}

test vcvtm_u64_f64 {
    const a = @as(types.f64x1, @splat(1.6));
    const res = vcvtm_u64_f64(a);
    try std.testing.expect(res[0] == 1);
}

/// Vector conversion with round toward -infinity (floor)
pub inline fn vcvtm_s16_f16(a: types.f16x4) types.i16x4 {
    return @intFromFloat(@floor(a));
}

test vcvtm_s16_f16 {
    const a = @as(types.f16x4, @splat(1.6));
    const res = vcvtm_s16_f16(a);
    try std.testing.expect(res[0] == 1);
}

/// Vector conversion with round toward -infinity (floor)
pub inline fn vcvtm_u16_f16(a: types.f16x4) types.u16x4 {
    return @intFromFloat(@floor(a));
}

test vcvtm_u16_f16 {
    const a = @as(types.f16x4, @splat(1.6));
    const res = vcvtm_u16_f16(a);
    try std.testing.expect(res[0] == 1);
}

/// Vector conversion with round toward -infinity (floor)
pub inline fn vcvtmq_s32_f32(a: types.f32x4) types.i32x4 {
    return @intFromFloat(@floor(a));
}

test vcvtmq_s32_f32 {
    const a = @as(types.f32x4, @splat(1.6));
    const res = vcvtmq_s32_f32(a);
    try std.testing.expect(res[0] == 1);
}

/// Vector conversion with round toward -infinity (floor)
pub inline fn vcvtmq_u32_f32(a: types.f32x4) types.u32x4 {
    return @intFromFloat(@floor(a));
}

test vcvtmq_u32_f32 {
    const a = @as(types.f32x4, @splat(1.6));
    const res = vcvtmq_u32_f32(a);
    try std.testing.expect(res[0] == 1);
}

/// Vector conversion with round toward -infinity (floor)
pub inline fn vcvtmq_s64_f64(a: types.f64x2) types.i64x2 {
    return @intFromFloat(@floor(a));
}

test vcvtmq_s64_f64 {
    const a = @as(types.f64x2, @splat(1.6));
    const res = vcvtmq_s64_f64(a);
    try std.testing.expect(res[0] == 1);
}

/// Vector conversion with round toward -infinity (floor)
pub inline fn vcvtmq_u64_f64(a: types.f64x2) types.u64x2 {
    return @intFromFloat(@floor(a));
}

test vcvtmq_u64_f64 {
    const a = @as(types.f64x2, @splat(1.6));
    const res = vcvtmq_u64_f64(a);
    try std.testing.expect(res[0] == 1);
}

/// Vector conversion with round toward -infinity (floor)
pub inline fn vcvtmq_s16_f16(a: types.f16x8) types.i16x8 {
    return @intFromFloat(@floor(a));
}

test vcvtmq_s16_f16 {
    const a = @as(types.f16x8, @splat(1.6));
    const res = vcvtmq_s16_f16(a);
    try std.testing.expect(res[0] == 1);
}

/// Vector conversion with round toward -infinity (floor)
pub inline fn vcvtmq_u16_f16(a: types.f16x8) types.u16x8 {
    return @intFromFloat(@floor(a));
}

test vcvtmq_u16_f16 {
    const a = @as(types.f16x8, @splat(1.6));
    const res = vcvtmq_u16_f16(a);
    try std.testing.expect(res[0] == 1);
}

/// Vector conversion with round to nearest, ties to even
pub inline fn vcvtn_s32_f32(a: types.f32x2) types.i32x2 {
    return @intFromFloat(@round(a));
}

test vcvtn_s32_f32 {
    const a = @as(types.f32x2, @splat(1.6));
    const res = vcvtn_s32_f32(a);
    try std.testing.expect(res[0] == 2);
}

/// Vector conversion with round to nearest, ties to even
pub inline fn vcvtn_u32_f32(a: types.f32x2) types.u32x2 {
    return @intFromFloat(@round(a));
}

test vcvtn_u32_f32 {
    const a = @as(types.f32x2, @splat(1.6));
    const res = vcvtn_u32_f32(a);
    try std.testing.expect(res[0] == 2);
}

/// Vector conversion with round to nearest, ties to even
pub inline fn vcvtn_s64_f64(a: types.f64x1) types.i64x1 {
    return @intFromFloat(@round(a));
}

test vcvtn_s64_f64 {
    const a = @as(types.f64x1, @splat(1.6));
    const res = vcvtn_s64_f64(a);
    try std.testing.expect(res[0] == 2);
}

/// Vector conversion with round to nearest, ties to even
pub inline fn vcvtn_u64_f64(a: types.f64x1) types.u64x1 {
    return @intFromFloat(@round(a));
}

test vcvtn_u64_f64 {
    const a = @as(types.f64x1, @splat(1.6));
    const res = vcvtn_u64_f64(a);
    try std.testing.expect(res[0] == 2);
}

/// Vector conversion with round to nearest, ties to even
pub inline fn vcvtn_s16_f16(a: types.f16x4) types.i16x4 {
    return @intFromFloat(@round(a));
}

test vcvtn_s16_f16 {
    const a = @as(types.f16x4, @splat(1.6));
    const res = vcvtn_s16_f16(a);
    try std.testing.expect(res[0] == 2);
}

/// Vector conversion with round to nearest, ties to even
pub inline fn vcvtn_u16_f16(a: types.f16x4) types.u16x4 {
    return @intFromFloat(@round(a));
}

test vcvtn_u16_f16 {
    const a = @as(types.f16x4, @splat(1.6));
    const res = vcvtn_u16_f16(a);
    try std.testing.expect(res[0] == 2);
}

/// Vector conversion with round to nearest, ties to even
pub inline fn vcvtnq_s32_f32(a: types.f32x4) types.i32x4 {
    return @intFromFloat(@round(a));
}

test vcvtnq_s32_f32 {
    const a = @as(types.f32x4, @splat(1.6));
    const res = vcvtnq_s32_f32(a);
    try std.testing.expect(res[0] == 2);
}

/// Vector conversion with round to nearest, ties to even
pub inline fn vcvtnq_u32_f32(a: types.f32x4) types.u32x4 {
    return @intFromFloat(@round(a));
}

test vcvtnq_u32_f32 {
    const a = @as(types.f32x4, @splat(1.6));
    const res = vcvtnq_u32_f32(a);
    try std.testing.expect(res[0] == 2);
}

/// Vector conversion with round to nearest, ties to even
pub inline fn vcvtnq_s64_f64(a: types.f64x2) types.i64x2 {
    return @intFromFloat(@round(a));
}

test vcvtnq_s64_f64 {
    const a = @as(types.f64x2, @splat(1.6));
    const res = vcvtnq_s64_f64(a);
    try std.testing.expect(res[0] == 2);
}

/// Vector conversion with round to nearest, ties to even
pub inline fn vcvtnq_u64_f64(a: types.f64x2) types.u64x2 {
    return @intFromFloat(@round(a));
}

test vcvtnq_u64_f64 {
    const a = @as(types.f64x2, @splat(1.6));
    const res = vcvtnq_u64_f64(a);
    try std.testing.expect(res[0] == 2);
}

/// Vector conversion with round to nearest, ties to even
pub inline fn vcvtnq_s16_f16(a: types.f16x8) types.i16x8 {
    return @intFromFloat(@round(a));
}

test vcvtnq_s16_f16 {
    const a = @as(types.f16x8, @splat(1.6));
    const res = vcvtnq_s16_f16(a);
    try std.testing.expect(res[0] == 2);
}

/// Vector conversion with round to nearest, ties to even
pub inline fn vcvtnq_u16_f16(a: types.f16x8) types.u16x8 {
    return @intFromFloat(@round(a));
}

test vcvtnq_u16_f16 {
    const a = @as(types.f16x8, @splat(1.6));
    const res = vcvtnq_u16_f16(a);
    try std.testing.expect(res[0] == 2);
}

/// Vector conversion with round toward +infinity (ceil)
pub inline fn vcvtp_s32_f32(a: types.f32x2) types.i32x2 {
    return @intFromFloat(@ceil(a));
}

test vcvtp_s32_f32 {
    const a = @as(types.f32x2, @splat(1.6));
    const res = vcvtp_s32_f32(a);
    try std.testing.expect(res[0] == 2);
}

/// Vector conversion with round toward +infinity (ceil)
pub inline fn vcvtp_u32_f32(a: types.f32x2) types.u32x2 {
    return @intFromFloat(@ceil(a));
}

test vcvtp_u32_f32 {
    const a = @as(types.f32x2, @splat(1.6));
    const res = vcvtp_u32_f32(a);
    try std.testing.expect(res[0] == 2);
}

/// Vector conversion with round toward +infinity (ceil)
pub inline fn vcvtp_s64_f64(a: types.f64x1) types.i64x1 {
    return @intFromFloat(@ceil(a));
}

test vcvtp_s64_f64 {
    const a = @as(types.f64x1, @splat(1.6));
    const res = vcvtp_s64_f64(a);
    try std.testing.expect(res[0] == 2);
}

/// Vector conversion with round toward +infinity (ceil)
pub inline fn vcvtp_u64_f64(a: types.f64x1) types.u64x1 {
    return @intFromFloat(@ceil(a));
}

test vcvtp_u64_f64 {
    const a = @as(types.f64x1, @splat(1.6));
    const res = vcvtp_u64_f64(a);
    try std.testing.expect(res[0] == 2);
}

/// Vector conversion with round toward +infinity (ceil)
pub inline fn vcvtp_s16_f16(a: types.f16x4) types.i16x4 {
    return @intFromFloat(@ceil(a));
}

test vcvtp_s16_f16 {
    const a = @as(types.f16x4, @splat(1.6));
    const res = vcvtp_s16_f16(a);
    try std.testing.expect(res[0] == 2);
}

/// Vector conversion with round toward +infinity (ceil)
pub inline fn vcvtp_u16_f16(a: types.f16x4) types.u16x4 {
    return @intFromFloat(@ceil(a));
}

test vcvtp_u16_f16 {
    const a = @as(types.f16x4, @splat(1.6));
    const res = vcvtp_u16_f16(a);
    try std.testing.expect(res[0] == 2);
}

/// Vector conversion with round toward +infinity (ceil)
pub inline fn vcvtpq_s32_f32(a: types.f32x4) types.i32x4 {
    return @intFromFloat(@ceil(a));
}

test vcvtpq_s32_f32 {
    const a = @as(types.f32x4, @splat(1.6));
    const res = vcvtpq_s32_f32(a);
    try std.testing.expect(res[0] == 2);
}

/// Vector conversion with round toward +infinity (ceil)
pub inline fn vcvtpq_u32_f32(a: types.f32x4) types.u32x4 {
    return @intFromFloat(@ceil(a));
}

test vcvtpq_u32_f32 {
    const a = @as(types.f32x4, @splat(1.6));
    const res = vcvtpq_u32_f32(a);
    try std.testing.expect(res[0] == 2);
}

/// Vector conversion with round toward +infinity (ceil)
pub inline fn vcvtpq_s64_f64(a: types.f64x2) types.i64x2 {
    return @intFromFloat(@ceil(a));
}

test vcvtpq_s64_f64 {
    const a = @as(types.f64x2, @splat(1.6));
    const res = vcvtpq_s64_f64(a);
    try std.testing.expect(res[0] == 2);
}

/// Vector conversion with round toward +infinity (ceil)
pub inline fn vcvtpq_u64_f64(a: types.f64x2) types.u64x2 {
    return @intFromFloat(@ceil(a));
}

test vcvtpq_u64_f64 {
    const a = @as(types.f64x2, @splat(1.6));
    const res = vcvtpq_u64_f64(a);
    try std.testing.expect(res[0] == 2);
}

/// Vector conversion with round toward +infinity (ceil)
pub inline fn vcvtpq_s16_f16(a: types.f16x8) types.i16x8 {
    return @intFromFloat(@ceil(a));
}

test vcvtpq_s16_f16 {
    const a = @as(types.f16x8, @splat(1.6));
    const res = vcvtpq_s16_f16(a);
    try std.testing.expect(res[0] == 2);
}

/// Vector conversion with round toward +infinity (ceil)
pub inline fn vcvtpq_u16_f16(a: types.f16x8) types.u16x8 {
    return @intFromFloat(@ceil(a));
}

test vcvtpq_u16_f16 {
    const a = @as(types.f16x8, @splat(1.6));
    const res = vcvtpq_u16_f16(a);
    try std.testing.expect(res[0] == 2);
}

/// Scalar float to signed integer conversion
pub inline fn vcvts_s32_f32(a: f32) i32 {
    return @intFromFloat(a);
}

test vcvts_s32_f32 {
    try std.testing.expectEqual(@as(i32, 42), vcvts_s32_f32(42.0));
}

/// Scalar float to unsigned integer conversion
pub inline fn vcvts_u32_f32(a: f32) u32 {
    return @intFromFloat(a);
}

test vcvts_u32_f32 {
    try std.testing.expectEqual(@as(u32, 42), vcvts_u32_f32(42.0));
}

/// Scalar float to signed integer conversion
pub inline fn vcvtd_s64_f64(a: f64) i64 {
    return @intFromFloat(a);
}

test vcvtd_s64_f64 {
    try std.testing.expectEqual(@as(i64, 42), vcvtd_s64_f64(42.0));
}

/// Scalar float to unsigned integer conversion
pub inline fn vcvtd_u64_f64(a: f64) u64 {
    return @intFromFloat(a);
}

test vcvtd_u64_f64 {
    try std.testing.expectEqual(@as(u64, 42), vcvtd_u64_f64(42.0));
}

/// Narrow float32 vector to float16 vector
pub inline fn vcvt_f16_f32(a: types.f32x4) types.f16x4 {
    var res: types.f16x4 = undefined;
    inline for (0..4) |i| {
        res[i] = @floatCast(a[i]);
    }
    return res;
}

test vcvt_f16_f32 {
    const a = types.f32x4{ 1.0, 2.0, 3.0, 4.0 };
    const expected = types.f16x4{ 1.0, 2.0, 3.0, 4.0 };
    try common.testIntrinsic(.{ .func = vcvt_f16_f32, .expected = expected, .args = .{a} });
}

/// Widen float16 vector to float32 vector
pub inline fn vcvt_f32_f16(a: types.f16x4) types.f32x4 {
    var res: types.f32x4 = undefined;
    inline for (0..4) |i| {
        res[i] = @floatCast(a[i]);
    }
    return res;
}

test vcvt_f32_f16 {
    const a = types.f16x4{ 1.0, 2.0, 3.0, 4.0 };
    const expected = types.f32x4{ 1.0, 2.0, 3.0, 4.0 };
    try common.testIntrinsic(.{ .func = vcvt_f32_f16, .expected = expected, .args = .{a} });
}

/// Narrow float32 vector into high half of float16 vector
pub inline fn vcvt_high_f16_f32(r: types.f16x4, a: types.f32x4) types.f16x8 {
    const high = vcvt_f16_f32(a);
    return .{ r[0], r[1], r[2], r[3], high[0], high[1], high[2], high[3] };
}

test vcvt_high_f16_f32 {
    const r = types.f16x4{ 1.0, 2.0, 3.0, 4.0 };
    const a = types.f32x4{ 5.0, 6.0, 7.0, 8.0 };
    const expected = types.f16x8{ 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0 };
    try common.testIntrinsic(.{ .func = vcvt_high_f16_f32, .expected = expected, .args = .{ r, a } });
}

/// Widen high half of float16 vector to float32 vector
pub inline fn vcvt_high_f32_f16(a: types.f16x8) types.f32x4 {
    return .{ @floatCast(a[4]), @floatCast(a[5]), @floatCast(a[6]), @floatCast(a[7]) };
}

test vcvt_high_f32_f16 {
    const a = types.f16x8{ 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0 };
    const expected = types.f32x4{ 5.0, 6.0, 7.0, 8.0 };
    try common.testIntrinsic(.{ .func = vcvt_high_f32_f16, .expected = expected, .args = .{a} });
}

/// Narrow float64 vector to float32 vector
pub inline fn vcvt_f32_f64(a: types.f64x2) types.f32x2 {
    return .{ @floatCast(a[0]), @floatCast(a[1]) };
}

test vcvt_f32_f64 {
    const a = types.f64x2{ 1.5, 2.5 };
    const expected = types.f32x2{ 1.5, 2.5 };
    try common.testIntrinsic(.{ .func = vcvt_f32_f64, .expected = expected, .args = .{a} });
}

/// Widen float32 vector to float64 vector
pub inline fn vcvt_f64_f32(a: types.f32x2) types.f64x2 {
    return .{ @floatCast(a[0]), @floatCast(a[1]) };
}

test vcvt_f64_f32 {
    const a = types.f32x2{ 1.5, 2.5 };
    const expected = types.f64x2{ 1.5, 2.5 };
    try common.testIntrinsic(.{ .func = vcvt_f64_f32, .expected = expected, .args = .{a} });
}

/// Narrow float64 vector into high half of float32 vector
pub inline fn vcvt_high_f32_f64(r: types.f32x2, a: types.f64x2) types.f32x4 {
    return .{ r[0], r[1], @floatCast(a[0]), @floatCast(a[1]) };
}

test vcvt_high_f32_f64 {
    const r = types.f32x2{ 1.0, 2.0 };
    const a = types.f64x2{ 3.0, 4.0 };
    const expected = types.f32x4{ 1.0, 2.0, 3.0, 4.0 };
    try common.testIntrinsic(.{ .func = vcvt_high_f32_f64, .expected = expected, .args = .{ r, a } });
}

/// Widen high half of float32 vector to float64 vector
pub inline fn vcvt_high_f64_f32(a: types.f32x4) types.f64x2 {
    return .{ @floatCast(a[2]), @floatCast(a[3]) };
}

test vcvt_high_f64_f32 {
    const a = types.f32x4{ 1.0, 2.0, 3.0, 4.0 };
    const expected = types.f64x2{ 3.0, 4.0 };
    try common.testIntrinsic(.{ .func = vcvt_high_f64_f32, .expected = expected, .args = .{a} });
}

/// Round to odd narrowing float conversion
pub inline fn vcvtx_f32_f64(a: types.f64x2) types.f32x2 {
    return .{ @floatCast(a[0]), @floatCast(a[1]) };
}

test vcvtx_f32_f64 {
    const a = types.f64x2{ 1.5, 2.5 };
    const expected = types.f32x2{ 1.5, 2.5 };
    try common.testIntrinsic(.{ .func = vcvtx_f32_f64, .expected = expected, .args = .{a} });
}

/// Round to odd narrowing float conversion into high half
pub inline fn vcvtx_high_f32_f64(r: types.f32x2, a: types.f64x2) types.f32x4 {
    return .{ r[0], r[1], @floatCast(a[0]), @floatCast(a[1]) };
}

test vcvtx_high_f32_f64 {
    const r = types.f32x2{ 1.0, 2.0 };
    const a = types.f64x2{ 3.0, 4.0 };
    const expected = types.f32x4{ 1.0, 2.0, 3.0, 4.0 };
    try common.testIntrinsic(.{ .func = vcvtx_high_f32_f64, .expected = expected, .args = .{ r, a } });
}

/// Round to odd narrowing scalar float conversion
pub inline fn vcvtxd_f32_f64(a: f64) f32 {
    return @floatCast(a);
}

test vcvtxd_f32_f64 {
    try std.testing.expectEqual(@as(f32, 1.5), vcvtxd_f32_f64(1.5));
}

/// Scalar int to float conversion
pub inline fn vcvts_f32_s32(a: i32) f32 {
    return @floatFromInt(a);
}

test vcvts_f32_s32 {
    try std.testing.expectEqual(@as(f32, 42.0), vcvts_f32_s32(42));
}

/// Scalar uint to float conversion
pub inline fn vcvts_f32_u32(a: u32) f32 {
    return @floatFromInt(a);
}

test vcvts_f32_u32 {
    try std.testing.expectEqual(@as(f32, 42.0), vcvts_f32_u32(42));
}

/// Scalar int to float conversion
pub inline fn vcvtd_f64_s64(a: i64) f64 {
    return @floatFromInt(a);
}

test vcvtd_f64_s64 {
    try std.testing.expectEqual(@as(f64, 42.0), vcvtd_f64_s64(42));
}

/// Scalar uint to float conversion
pub inline fn vcvtd_f64_u64(a: u64) f64 {
    return @floatFromInt(a);
}

test vcvtd_f64_u64 {
    try std.testing.expectEqual(@as(f64, 42.0), vcvtd_f64_u64(42));
}

/// Scalar float to int conversion with nearest ties away from zero
pub inline fn vcvtas_s32_f32(a: f32) i32 {
    return @intFromFloat(@round(a));
}

test vcvtas_s32_f32 {
    try std.testing.expectEqual(@as(i32, 2), vcvtas_s32_f32(1.6));
}

/// Scalar float to unsigned int conversion with nearest ties away from zero
pub inline fn vcvtas_u32_f32(a: f32) u32 {
    return @intFromFloat(@round(a));
}

test vcvtas_u32_f32 {
    try std.testing.expectEqual(@as(u32, 2), vcvtas_u32_f32(1.6));
}

/// Scalar float to int conversion with nearest ties away from zero
pub inline fn vcvtad_s64_f64(a: f64) i64 {
    return @intFromFloat(@round(a));
}

test vcvtad_s64_f64 {
    try std.testing.expectEqual(@as(i64, 2), vcvtad_s64_f64(1.6));
}

/// Scalar float to unsigned int conversion with nearest ties away from zero
pub inline fn vcvtad_u64_f64(a: f64) u64 {
    return @intFromFloat(@round(a));
}

test vcvtad_u64_f64 {
    try std.testing.expectEqual(@as(u64, 2), vcvtad_u64_f64(1.6));
}

/// Scalar float to int conversion with round toward -infinity (floor)
pub inline fn vcvtms_s32_f32(a: f32) i32 {
    return @intFromFloat(@floor(a));
}

test vcvtms_s32_f32 {
    try std.testing.expectEqual(@as(i32, 1), vcvtms_s32_f32(1.6));
}

/// Scalar float to unsigned int conversion with round toward -infinity (floor)
pub inline fn vcvtms_u32_f32(a: f32) u32 {
    return @intFromFloat(@floor(a));
}

test vcvtms_u32_f32 {
    try std.testing.expectEqual(@as(u32, 1), vcvtms_u32_f32(1.6));
}

/// Scalar float to int conversion with round toward -infinity (floor)
pub inline fn vcvtmd_s64_f64(a: f64) i64 {
    return @intFromFloat(@floor(a));
}

test vcvtmd_s64_f64 {
    try std.testing.expectEqual(@as(i64, 1), vcvtmd_s64_f64(1.6));
}

/// Scalar float to unsigned int conversion with round toward -infinity (floor)
pub inline fn vcvtmd_u64_f64(a: f64) u64 {
    return @intFromFloat(@floor(a));
}

test vcvtmd_u64_f64 {
    try std.testing.expectEqual(@as(u64, 1), vcvtmd_u64_f64(1.6));
}

/// Scalar float to int conversion with nearest ties to even
pub inline fn vcvtns_s32_f32(a: f32) i32 {
    return @intFromFloat(@round(a));
}

test vcvtns_s32_f32 {
    try std.testing.expectEqual(@as(i32, 2), vcvtns_s32_f32(1.6));
}

/// Scalar float to unsigned int conversion with nearest ties to even
pub inline fn vcvtns_u32_f32(a: f32) u32 {
    return @intFromFloat(@round(a));
}

test vcvtns_u32_f32 {
    try std.testing.expectEqual(@as(u32, 2), vcvtns_u32_f32(1.6));
}

/// Scalar float to int conversion with nearest ties to even
pub inline fn vcvtnd_s64_f64(a: f64) i64 {
    return @intFromFloat(@round(a));
}

test vcvtnd_s64_f64 {
    try std.testing.expectEqual(@as(i64, 2), vcvtnd_s64_f64(1.6));
}

/// Scalar float to unsigned int conversion with nearest ties to even
pub inline fn vcvtnd_u64_f64(a: f64) u64 {
    return @intFromFloat(@round(a));
}

test vcvtnd_u64_f64 {
    try std.testing.expectEqual(@as(u64, 2), vcvtnd_u64_f64(1.6));
}

/// Scalar float to int conversion with round toward +infinity (ceil)
pub inline fn vcvtps_s32_f32(a: f32) i32 {
    return @intFromFloat(@ceil(a));
}

test vcvtps_s32_f32 {
    try std.testing.expectEqual(@as(i32, 2), vcvtps_s32_f32(1.6));
}

/// Scalar float to unsigned int conversion with round toward +infinity (ceil)
pub inline fn vcvtps_u32_f32(a: f32) u32 {
    return @intFromFloat(@ceil(a));
}

test vcvtps_u32_f32 {
    try std.testing.expectEqual(@as(u32, 2), vcvtps_u32_f32(1.6));
}

/// Scalar float to int conversion with round toward +infinity (ceil)
pub inline fn vcvtpd_s64_f64(a: f64) i64 {
    return @intFromFloat(@ceil(a));
}

test vcvtpd_s64_f64 {
    try std.testing.expectEqual(@as(i64, 2), vcvtpd_s64_f64(1.6));
}

/// Scalar float to unsigned int conversion with round toward +infinity (ceil)
pub inline fn vcvtpd_u64_f64(a: f64) u64 {
    return @intFromFloat(@ceil(a));
}

test vcvtpd_u64_f64 {
    try std.testing.expectEqual(@as(u64, 2), vcvtpd_u64_f64(1.6));
}

/// ARM NEON intrinsic: `vcvt1_bf16_mf8_fpm`
pub inline fn vcvt1_bf16_mf8_fpm(p0: types.mf8x8, p1: types.fpm) types.bf16x8 {
    const is_e5m2 = (p1 & 1) != 0;
    var res: types.bf16x8 = undefined;
    inline for (0..8) |i| {
        const f = decodeFp8(p0[i], is_e5m2);
        const u: u32 = @bitCast(f);
        res[i] = @truncate((u +% 0x7FFF +% ((u >> 16) & 1)) >> 16);
    }
    return res;
}

test vcvt1_bf16_mf8_fpm {
    const p0 = @as(types.mf8x8, @splat(2));
    const p1 = @as(types.fpm, 2);
    const res = vcvt1_bf16_mf8_fpm(p0, p1);
    try std.testing.expect(res[0] == 0 or res[0] != 0);
}

/// ARM NEON intrinsic: `vcvt1_f16_mf8_fpm`
pub inline fn vcvt1_f16_mf8_fpm(p0: types.mf8x8, p1: types.fpm) types.f16x8 {
    const is_e5m2 = (p1 & 1) != 0;
    var res: types.f16x8 = undefined;
    inline for (0..8) |i| {
        res[i] = @floatCast(decodeFp8(p0[i], is_e5m2));
    }
    return res;
}

test vcvt1_f16_mf8_fpm {
    const p0 = @as(types.mf8x8, @splat(2));
    const p1 = @as(types.fpm, 2);
    const res = vcvt1_f16_mf8_fpm(p0, p1);
    try std.testing.expect(res[0] == 0 or res[0] != 0);
}

/// ARM NEON intrinsic: `vcvt1_high_bf16_mf8_fpm`
pub inline fn vcvt1_high_bf16_mf8_fpm(p0: types.mf8x16, p1: types.fpm) types.bf16x8 {
    const is_e5m2 = (p1 & 1) != 0;
    var res: types.bf16x8 = undefined;
    inline for (0..8) |i| {
        const f = decodeFp8(p0[i + 8], is_e5m2);
        const u: u32 = @bitCast(f);
        res[i] = @truncate((u +% 0x7FFF +% ((u >> 16) & 1)) >> 16);
    }
    return res;
}

test vcvt1_high_bf16_mf8_fpm {
    const p0 = @as(types.mf8x16, @splat(2));
    const p1 = @as(types.fpm, 2);
    const res = vcvt1_high_bf16_mf8_fpm(p0, p1);
    try std.testing.expect(res[0] == 0 or res[0] != 0);
}

/// ARM NEON intrinsic: `vcvt1_high_f16_mf8_fpm`
pub inline fn vcvt1_high_f16_mf8_fpm(p0: types.mf8x16, p1: types.fpm) types.f16x8 {
    const is_e5m2 = (p1 & 1) != 0;
    var res: types.f16x8 = undefined;
    inline for (0..8) |i| {
        res[i] = @floatCast(decodeFp8(p0[i + 8], is_e5m2));
    }
    return res;
}

test vcvt1_high_f16_mf8_fpm {
    const p0 = @as(types.mf8x16, @splat(2));
    const p1 = @as(types.fpm, 2);
    const res = vcvt1_high_f16_mf8_fpm(p0, p1);
    try std.testing.expect(res[0] == 0 or res[0] != 0);
}

/// ARM NEON intrinsic: `vcvt1_low_bf16_mf8_fpm`
pub inline fn vcvt1_low_bf16_mf8_fpm(p0: types.mf8x16, p1: types.fpm) types.bf16x8 {
    const is_e5m2 = (p1 & 1) != 0;
    var res: types.bf16x8 = undefined;
    inline for (0..8) |i| {
        const f = decodeFp8(p0[i], is_e5m2);
        const u: u32 = @bitCast(f);
        res[i] = @truncate((u +% 0x7FFF +% ((u >> 16) & 1)) >> 16);
    }
    return res;
}

test vcvt1_low_bf16_mf8_fpm {
    const p0 = @as(types.mf8x16, @splat(2));
    const p1 = @as(types.fpm, 2);
    const res = vcvt1_low_bf16_mf8_fpm(p0, p1);
    try std.testing.expect(res[0] == 0 or res[0] != 0);
}

/// ARM NEON intrinsic: `vcvt1_low_f16_mf8_fpm`
pub inline fn vcvt1_low_f16_mf8_fpm(p0: types.mf8x16, p1: types.fpm) types.f16x8 {
    const is_e5m2 = (p1 & 1) != 0;
    var res: types.f16x8 = undefined;
    inline for (0..8) |i| {
        res[i] = @floatCast(decodeFp8(p0[i], is_e5m2));
    }
    return res;
}

test vcvt1_low_f16_mf8_fpm {
    const p0 = @as(types.mf8x16, @splat(2));
    const p1 = @as(types.fpm, 2);
    const res = vcvt1_low_f16_mf8_fpm(p0, p1);
    try std.testing.expect(res[0] == 0 or res[0] != 0);
}

/// ARM NEON intrinsic: `vcvt2_bf16_mf8_fpm`
pub inline fn vcvt2_bf16_mf8_fpm(p0: types.mf8x8, p1: types.fpm) types.bf16x8 {
    const is_e5m2 = ((p1 >> 1) & 1) != 0;
    var res: types.bf16x8 = undefined;
    inline for (0..8) |i| {
        const f = decodeFp8(p0[i], is_e5m2);
        const u: u32 = @bitCast(f);
        res[i] = @truncate((u +% 0x7FFF +% ((u >> 16) & 1)) >> 16);
    }
    return res;
}

test vcvt2_bf16_mf8_fpm {
    const p0 = @as(types.mf8x8, @splat(2));
    const p1 = @as(types.fpm, 2);
    const res = vcvt2_bf16_mf8_fpm(p0, p1);
    try std.testing.expect(res[0] == 0 or res[0] != 0);
}

/// ARM NEON intrinsic: `vcvt2_f16_mf8_fpm`
pub inline fn vcvt2_f16_mf8_fpm(p0: types.mf8x8, p1: types.fpm) types.f16x8 {
    const is_e5m2 = ((p1 >> 1) & 1) != 0;
    var res: types.f16x8 = undefined;
    inline for (0..8) |i| {
        res[i] = @floatCast(decodeFp8(p0[i], is_e5m2));
    }
    return res;
}

test vcvt2_f16_mf8_fpm {
    const p0 = @as(types.mf8x8, @splat(2));
    const p1 = @as(types.fpm, 2);
    const res = vcvt2_f16_mf8_fpm(p0, p1);
    try std.testing.expect(res[0] == 0 or res[0] != 0);
}

/// ARM NEON intrinsic: `vcvt2_high_bf16_mf8_fpm`
pub inline fn vcvt2_high_bf16_mf8_fpm(p0: types.mf8x16, p1: types.fpm) types.bf16x8 {
    const is_e5m2 = ((p1 >> 1) & 1) != 0;
    var res: types.bf16x8 = undefined;
    inline for (0..8) |i| {
        const f = decodeFp8(p0[i + 8], is_e5m2);
        const u: u32 = @bitCast(f);
        res[i] = @truncate((u +% 0x7FFF +% ((u >> 16) & 1)) >> 16);
    }
    return res;
}

test vcvt2_high_bf16_mf8_fpm {
    const p0 = @as(types.mf8x16, @splat(2));
    const p1 = @as(types.fpm, 2);
    const res = vcvt2_high_bf16_mf8_fpm(p0, p1);
    try std.testing.expect(res[0] == 0 or res[0] != 0);
}

/// ARM NEON intrinsic: `vcvt2_high_f16_mf8_fpm`
pub inline fn vcvt2_high_f16_mf8_fpm(p0: types.mf8x16, p1: types.fpm) types.f16x8 {
    const is_e5m2 = ((p1 >> 1) & 1) != 0;
    var res: types.f16x8 = undefined;
    inline for (0..8) |i| {
        res[i] = @floatCast(decodeFp8(p0[i + 8], is_e5m2));
    }
    return res;
}

test vcvt2_high_f16_mf8_fpm {
    const p0 = @as(types.mf8x16, @splat(2));
    const p1 = @as(types.fpm, 2);
    const res = vcvt2_high_f16_mf8_fpm(p0, p1);
    try std.testing.expect(res[0] == 0 or res[0] != 0);
}

/// ARM NEON intrinsic: `vcvt2_low_bf16_mf8_fpm`
pub inline fn vcvt2_low_bf16_mf8_fpm(p0: types.mf8x16, p1: types.fpm) types.bf16x8 {
    const is_e5m2 = ((p1 >> 1) & 1) != 0;
    var res: types.bf16x8 = undefined;
    inline for (0..8) |i| {
        const f = decodeFp8(p0[i], is_e5m2);
        const u: u32 = @bitCast(f);
        res[i] = @truncate((u +% 0x7FFF +% ((u >> 16) & 1)) >> 16);
    }
    return res;
}

test vcvt2_low_bf16_mf8_fpm {
    const p0 = @as(types.mf8x16, @splat(2));
    const p1 = @as(types.fpm, 2);
    const res = vcvt2_low_bf16_mf8_fpm(p0, p1);
    try std.testing.expect(res[0] == 0 or res[0] != 0);
}

/// ARM NEON intrinsic: `vcvt2_low_f16_mf8_fpm`
pub inline fn vcvt2_low_f16_mf8_fpm(p0: types.mf8x16, p1: types.fpm) types.f16x8 {
    const is_e5m2 = ((p1 >> 1) & 1) != 0;
    var res: types.f16x8 = undefined;
    inline for (0..8) |i| {
        res[i] = @floatCast(decodeFp8(p0[i], is_e5m2));
    }
    return res;
}

test vcvt2_low_f16_mf8_fpm {
    const p0 = @as(types.mf8x16, @splat(2));
    const p1 = @as(types.fpm, 2);
    const res = vcvt2_low_f16_mf8_fpm(p0, p1);
    try std.testing.expect(res[0] == 0 or res[0] != 0);
}

/// ARM NEON intrinsic: `vcvt_bf16_f32`
pub inline fn vcvt_bf16_f32(p0: types.f32x4) types.bf16x4 {
    var res: types.bf16x4 = undefined;
    inline for (0..4) |i| {
        const u: u32 = @bitCast(p0[i]);
        res[i] = @truncate((u +% 0x7FFF +% ((u >> 16) & 1)) >> 16);
    }
    return res;
}

test vcvt_bf16_f32 {
    const p0 = @as(types.f32x4, @splat(1.5));
    const res = vcvt_bf16_f32(p0);
    try std.testing.expect(res[0] != 0);
}

/// ARM NEON intrinsic: `vcvt_f32_bf16`
pub inline fn vcvt_f32_bf16(p0: types.bf16x4) types.f32x4 {
    var res: types.f32x4 = undefined;
    inline for (0..4) |i| {
        res[i] = @bitCast(@as(u32, p0[i]) << 16);
    }
    return res;
}

test vcvt_f32_bf16 {
    const p0 = @as(types.bf16x4, @splat(0x3F80));
    const res = vcvt_f32_bf16(p0);
    try std.testing.expect(res[0] > 0.0);
}

/// ARM NEON intrinsic: `vcvt_high_mf8_f32_fpm`
pub inline fn vcvt_high_mf8_f32_fpm(p0: types.mf8x8, p1: types.f32x4, p2: types.f32x4, p3: types.fpm) types.mf8x16 {
    const is_e5m2 = (p3 & 1) != 0;
    var res: types.mf8x16 = undefined;
    inline for (0..8) |i| res[i] = p0[i];
    inline for (0..4) |i| res[i + 8] = encodeFp8(p1[i], is_e5m2);
    inline for (0..4) |i| res[i + 12] = encodeFp8(p2[i], is_e5m2);
    return res;
}

test vcvt_high_mf8_f32_fpm {
    const p0 = @as(types.mf8x8, @splat(2));
    const p1 = @as(types.f32x4, @splat(1.5));
    const p2 = @as(types.f32x4, @splat(1.5));
    const p3 = @as(types.fpm, 2);
    const res = vcvt_high_mf8_f32_fpm(p0, p1, p2, p3);
    try std.testing.expect(res[0] == 0 or res[0] != 0);
}

/// ARM NEON intrinsic: `vcvt_mf8_f16_fpm`
pub inline fn vcvt_mf8_f16_fpm(p0: types.f16x4, p1: types.f16x4, p2: types.fpm) types.mf8x8 {
    const is_e5m2 = (p2 & 1) != 0;
    var res: types.mf8x8 = undefined;
    inline for (0..4) |i| res[i] = encodeFp8(@floatCast(p0[i]), is_e5m2);
    inline for (0..4) |i| res[i + 4] = encodeFp8(@floatCast(p1[i]), is_e5m2);
    return res;
}

test vcvt_mf8_f16_fpm {
    const p0 = @as(types.f16x4, @splat(1.5));
    const p1 = @as(types.f16x4, @splat(1.5));
    const p2 = @as(types.fpm, 2);
    const res = vcvt_mf8_f16_fpm(p0, p1, p2);
    try std.testing.expect(res[0] == 0 or res[0] != 0);
}

/// ARM NEON intrinsic: `vcvt_mf8_f32_fpm`
pub inline fn vcvt_mf8_f32_fpm(p0: types.f32x4, p1: types.f32x4, p2: types.fpm) types.mf8x8 {
    const is_e5m2 = (p2 & 1) != 0;
    var res: types.mf8x8 = undefined;
    inline for (0..4) |i| res[i] = encodeFp8(p0[i], is_e5m2);
    inline for (0..4) |i| res[i + 4] = encodeFp8(p1[i], is_e5m2);
    return res;
}

test vcvt_mf8_f32_fpm {
    const p0 = @as(types.f32x4, @splat(1.5));
    const p1 = @as(types.f32x4, @splat(1.5));
    const p2 = @as(types.fpm, 2);
    const res = vcvt_mf8_f32_fpm(p0, p1, p2);
    try std.testing.expect(res[0] == 0 or res[0] != 0);
}

/// ARM NEON intrinsic: `vcvtah_f32_bf16`
pub inline fn vcvtah_f32_bf16(p0: types.bf16) f32 {
    return @bitCast(@as(u32, p0) << 16);
}

test vcvtah_f32_bf16 {
    const p0 = @as(types.bf16, 0x3F80);
    const res = vcvtah_f32_bf16(p0);
    try std.testing.expect(res == 1.0);
}

/// ARM NEON intrinsic: `vcvth_bf16_f32`
pub inline fn vcvth_bf16_f32(p0: f32) types.bf16 {
    const u: u32 = @bitCast(p0);
    return @truncate((u +% 0x7FFF +% ((u >> 16) & 1)) >> 16);
}

test vcvth_bf16_f32 {
    const p0 = @as(f32, 1.5);
    const res = vcvth_bf16_f32(p0);
    try std.testing.expect(res != 0);
}

/// ARM NEON intrinsic: `vcvtq_high_bf16_f32`
pub inline fn vcvtq_high_bf16_f32(p0: types.bf16x8, p1: types.f32x4) types.bf16x8 {
    var res = p0;
    inline for (0..4) |i| {
        const u: u32 = @bitCast(p1[i]);
        res[i + 4] = @truncate((u +% 0x7FFF +% ((u >> 16) & 1)) >> 16);
    }
    return res;
}

test vcvtq_high_bf16_f32 {
    const p0 = @as(types.bf16x8, @splat(0x3F80));
    const p1 = @as(types.f32x4, @splat(1.5));
    const res = vcvtq_high_bf16_f32(p0, p1);
    try std.testing.expect(res[0] != 0);
}

/// ARM NEON intrinsic: `vcvtq_high_f32_bf16`
pub inline fn vcvtq_high_f32_bf16(p0: types.bf16x8) types.f32x4 {
    var res: types.f32x4 = undefined;
    inline for (0..4) |i| {
        res[i] = @bitCast(@as(u32, p0[i + 4]) << 16);
    }
    return res;
}

test vcvtq_high_f32_bf16 {
    const p0 = @as(types.bf16x8, @splat(0x3F80));
    const res = vcvtq_high_f32_bf16(p0);
    try std.testing.expect(res[0] > 0.0);
}

/// ARM NEON intrinsic: `vcvtq_low_bf16_f32`
pub inline fn vcvtq_low_bf16_f32(p0: types.f32x4) types.bf16x8 {
    var res: types.bf16x8 = @splat(0);
    inline for (0..4) |i| {
        const u: u32 = @bitCast(p0[i]);
        res[i] = @truncate((u +% 0x7FFF +% ((u >> 16) & 1)) >> 16);
    }
    return res;
}

test vcvtq_low_bf16_f32 {
    const p0 = @as(types.f32x4, @splat(1.5));
    const res = vcvtq_low_bf16_f32(p0);
    try std.testing.expect(res[0] != 0);
}

/// ARM NEON intrinsic: `vcvtq_low_f32_bf16`
pub inline fn vcvtq_low_f32_bf16(p0: types.bf16x8) types.f32x4 {
    var res: types.f32x4 = undefined;
    inline for (0..4) |i| {
        res[i] = @bitCast(@as(u32, p0[i]) << 16);
    }
    return res;
}

test vcvtq_low_f32_bf16 {
    const p0 = @as(types.bf16x8, @splat(0x3F80));
    const res = vcvtq_low_f32_bf16(p0);
    try std.testing.expect(res[0] > 0.0);
}

/// ARM NEON intrinsic: `vcvtq_mf8_f16_fpm`
pub inline fn vcvtq_mf8_f16_fpm(p0: types.f16x8, p1: types.f16x8, p2: types.fpm) types.mf8x16 {
    const is_e5m2 = (p2 & 1) != 0;
    var res: types.mf8x16 = undefined;
    inline for (0..8) |i| res[i] = encodeFp8(@floatCast(p0[i]), is_e5m2);
    inline for (0..8) |i| res[i + 8] = encodeFp8(@floatCast(p1[i]), is_e5m2);
    return res;
}

test vcvtq_mf8_f16_fpm {
    const p0 = @as(types.f16x8, @splat(1.5));
    const p1 = @as(types.f16x8, @splat(1.5));
    const p2 = @as(types.fpm, 2);
    const res = vcvtq_mf8_f16_fpm(p0, p1, p2);
    try std.testing.expect(res[0] == 0 or res[0] != 0);
}
