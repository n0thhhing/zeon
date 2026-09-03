const std = @import("std");
const types = @import("../types.zig");
const common = @import("../common.zig");

/// vreinterpret_f16_f32
pub inline fn vreinterpret_f16_f32(a: types.f32x2) types.f16x4 {
    return @bitCast(a);
}

test vreinterpret_f16_f32 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.f32x2 = @bitCast(bytes);
    const expected: types.f16x4 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_f16_f32, .expected = expected, .args = .{a} });
}

/// vreinterpret_f16_f64
pub inline fn vreinterpret_f16_f64(a: types.f64x1) types.f16x4 {
    return @bitCast(a);
}

test vreinterpret_f16_f64 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.f64x1 = @bitCast(bytes);
    const expected: types.f16x4 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_f16_f64, .expected = expected, .args = .{a} });
}

/// vreinterpret_f16_p16
pub inline fn vreinterpret_f16_p16(a: types.p16x4) types.f16x4 {
    return @bitCast(a);
}

test vreinterpret_f16_p16 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.p16x4 = @bitCast(bytes);
    const expected: types.f16x4 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_f16_p16, .expected = expected, .args = .{a} });
}

/// vreinterpret_f16_p64
pub inline fn vreinterpret_f16_p64(a: types.p64x1) types.f16x4 {
    return @bitCast(a);
}

test vreinterpret_f16_p64 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.p64x1 = @bitCast(bytes);
    const expected: types.f16x4 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_f16_p64, .expected = expected, .args = .{a} });
}

/// vreinterpret_f16_p8
pub inline fn vreinterpret_f16_p8(a: types.p8x8) types.f16x4 {
    return @bitCast(a);
}

test vreinterpret_f16_p8 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.p8x8 = @bitCast(bytes);
    const expected: types.f16x4 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_f16_p8, .expected = expected, .args = .{a} });
}

/// vreinterpret_f16_s16
pub inline fn vreinterpret_f16_s16(a: types.i16x4) types.f16x4 {
    return @bitCast(a);
}

test vreinterpret_f16_s16 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.i16x4 = @bitCast(bytes);
    const expected: types.f16x4 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_f16_s16, .expected = expected, .args = .{a} });
}

/// vreinterpret_f16_s32
pub inline fn vreinterpret_f16_s32(a: types.i32x2) types.f16x4 {
    return @bitCast(a);
}

test vreinterpret_f16_s32 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.i32x2 = @bitCast(bytes);
    const expected: types.f16x4 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_f16_s32, .expected = expected, .args = .{a} });
}

/// vreinterpret_f16_s64
pub inline fn vreinterpret_f16_s64(a: types.i64x1) types.f16x4 {
    return @bitCast(a);
}

test vreinterpret_f16_s64 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.i64x1 = @bitCast(bytes);
    const expected: types.f16x4 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_f16_s64, .expected = expected, .args = .{a} });
}

/// vreinterpret_f16_s8
pub inline fn vreinterpret_f16_s8(a: types.i8x8) types.f16x4 {
    return @bitCast(a);
}

test vreinterpret_f16_s8 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.i8x8 = @bitCast(bytes);
    const expected: types.f16x4 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_f16_s8, .expected = expected, .args = .{a} });
}

/// vreinterpret_f16_u16
pub inline fn vreinterpret_f16_u16(a: types.u16x4) types.f16x4 {
    return @bitCast(a);
}

test vreinterpret_f16_u16 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.u16x4 = @bitCast(bytes);
    const expected: types.f16x4 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_f16_u16, .expected = expected, .args = .{a} });
}

/// vreinterpret_f16_u32
pub inline fn vreinterpret_f16_u32(a: types.u32x2) types.f16x4 {
    return @bitCast(a);
}

test vreinterpret_f16_u32 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.u32x2 = @bitCast(bytes);
    const expected: types.f16x4 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_f16_u32, .expected = expected, .args = .{a} });
}

/// vreinterpret_f16_u64
pub inline fn vreinterpret_f16_u64(a: types.u64x1) types.f16x4 {
    return @bitCast(a);
}

test vreinterpret_f16_u64 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.u64x1 = @bitCast(bytes);
    const expected: types.f16x4 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_f16_u64, .expected = expected, .args = .{a} });
}

/// vreinterpret_f16_u8
pub inline fn vreinterpret_f16_u8(a: types.u8x8) types.f16x4 {
    return @bitCast(a);
}

test vreinterpret_f16_u8 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.u8x8 = @bitCast(bytes);
    const expected: types.f16x4 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_f16_u8, .expected = expected, .args = .{a} });
}

/// vreinterpret_f32_f16
pub inline fn vreinterpret_f32_f16(a: types.f16x4) types.f32x2 {
    return @bitCast(a);
}

test vreinterpret_f32_f16 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.f16x4 = @bitCast(bytes);
    const expected: types.f32x2 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_f32_f16, .expected = expected, .args = .{a} });
}

/// vreinterpret_f32_f64
pub inline fn vreinterpret_f32_f64(a: types.f64x1) types.f32x2 {
    return @bitCast(a);
}

test vreinterpret_f32_f64 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.f64x1 = @bitCast(bytes);
    const expected: types.f32x2 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_f32_f64, .expected = expected, .args = .{a} });
}

/// vreinterpret_f32_p16
pub inline fn vreinterpret_f32_p16(a: types.p16x4) types.f32x2 {
    return @bitCast(a);
}

test vreinterpret_f32_p16 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.p16x4 = @bitCast(bytes);
    const expected: types.f32x2 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_f32_p16, .expected = expected, .args = .{a} });
}

/// vreinterpret_f32_p64
pub inline fn vreinterpret_f32_p64(a: types.p64x1) types.f32x2 {
    return @bitCast(a);
}

test vreinterpret_f32_p64 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.p64x1 = @bitCast(bytes);
    const expected: types.f32x2 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_f32_p64, .expected = expected, .args = .{a} });
}

/// vreinterpret_f32_p8
pub inline fn vreinterpret_f32_p8(a: types.p8x8) types.f32x2 {
    return @bitCast(a);
}

test vreinterpret_f32_p8 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.p8x8 = @bitCast(bytes);
    const expected: types.f32x2 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_f32_p8, .expected = expected, .args = .{a} });
}

/// vreinterpret_f32_s16
pub inline fn vreinterpret_f32_s16(a: types.i16x4) types.f32x2 {
    return @bitCast(a);
}

test vreinterpret_f32_s16 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.i16x4 = @bitCast(bytes);
    const expected: types.f32x2 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_f32_s16, .expected = expected, .args = .{a} });
}

/// vreinterpret_f32_s32
pub inline fn vreinterpret_f32_s32(a: types.i32x2) types.f32x2 {
    return @bitCast(a);
}

test vreinterpret_f32_s32 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.i32x2 = @bitCast(bytes);
    const expected: types.f32x2 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_f32_s32, .expected = expected, .args = .{a} });
}

/// vreinterpret_f32_s64
pub inline fn vreinterpret_f32_s64(a: types.i64x1) types.f32x2 {
    return @bitCast(a);
}

test vreinterpret_f32_s64 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.i64x1 = @bitCast(bytes);
    const expected: types.f32x2 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_f32_s64, .expected = expected, .args = .{a} });
}

/// vreinterpret_f32_s8
pub inline fn vreinterpret_f32_s8(a: types.i8x8) types.f32x2 {
    return @bitCast(a);
}

test vreinterpret_f32_s8 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.i8x8 = @bitCast(bytes);
    const expected: types.f32x2 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_f32_s8, .expected = expected, .args = .{a} });
}

/// vreinterpret_f32_u16
pub inline fn vreinterpret_f32_u16(a: types.u16x4) types.f32x2 {
    return @bitCast(a);
}

test vreinterpret_f32_u16 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.u16x4 = @bitCast(bytes);
    const expected: types.f32x2 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_f32_u16, .expected = expected, .args = .{a} });
}

/// vreinterpret_f32_u32
pub inline fn vreinterpret_f32_u32(a: types.u32x2) types.f32x2 {
    return @bitCast(a);
}

test vreinterpret_f32_u32 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.u32x2 = @bitCast(bytes);
    const expected: types.f32x2 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_f32_u32, .expected = expected, .args = .{a} });
}

/// vreinterpret_f32_u64
pub inline fn vreinterpret_f32_u64(a: types.u64x1) types.f32x2 {
    return @bitCast(a);
}

test vreinterpret_f32_u64 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.u64x1 = @bitCast(bytes);
    const expected: types.f32x2 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_f32_u64, .expected = expected, .args = .{a} });
}

/// vreinterpret_f32_u8
pub inline fn vreinterpret_f32_u8(a: types.u8x8) types.f32x2 {
    return @bitCast(a);
}

test vreinterpret_f32_u8 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.u8x8 = @bitCast(bytes);
    const expected: types.f32x2 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_f32_u8, .expected = expected, .args = .{a} });
}

/// vreinterpret_f64_f16
pub inline fn vreinterpret_f64_f16(a: types.f16x4) types.f64x1 {
    return @bitCast(a);
}

test vreinterpret_f64_f16 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.f16x4 = @bitCast(bytes);
    const expected: types.f64x1 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_f64_f16, .expected = expected, .args = .{a} });
}

/// vreinterpret_f64_f32
pub inline fn vreinterpret_f64_f32(a: types.f32x2) types.f64x1 {
    return @bitCast(a);
}

test vreinterpret_f64_f32 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.f32x2 = @bitCast(bytes);
    const expected: types.f64x1 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_f64_f32, .expected = expected, .args = .{a} });
}

/// vreinterpret_f64_p16
pub inline fn vreinterpret_f64_p16(a: types.p16x4) types.f64x1 {
    return @bitCast(a);
}

test vreinterpret_f64_p16 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.p16x4 = @bitCast(bytes);
    const expected: types.f64x1 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_f64_p16, .expected = expected, .args = .{a} });
}

/// vreinterpret_f64_p64
pub inline fn vreinterpret_f64_p64(a: types.p64x1) types.f64x1 {
    return @bitCast(a);
}

test vreinterpret_f64_p64 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.p64x1 = @bitCast(bytes);
    const expected: types.f64x1 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_f64_p64, .expected = expected, .args = .{a} });
}

/// vreinterpret_f64_p8
pub inline fn vreinterpret_f64_p8(a: types.p8x8) types.f64x1 {
    return @bitCast(a);
}

test vreinterpret_f64_p8 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.p8x8 = @bitCast(bytes);
    const expected: types.f64x1 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_f64_p8, .expected = expected, .args = .{a} });
}

/// vreinterpret_f64_s16
pub inline fn vreinterpret_f64_s16(a: types.i16x4) types.f64x1 {
    return @bitCast(a);
}

test vreinterpret_f64_s16 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.i16x4 = @bitCast(bytes);
    const expected: types.f64x1 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_f64_s16, .expected = expected, .args = .{a} });
}

/// vreinterpret_f64_s32
pub inline fn vreinterpret_f64_s32(a: types.i32x2) types.f64x1 {
    return @bitCast(a);
}

test vreinterpret_f64_s32 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.i32x2 = @bitCast(bytes);
    const expected: types.f64x1 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_f64_s32, .expected = expected, .args = .{a} });
}

/// vreinterpret_f64_s64
pub inline fn vreinterpret_f64_s64(a: types.i64x1) types.f64x1 {
    return @bitCast(a);
}

test vreinterpret_f64_s64 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.i64x1 = @bitCast(bytes);
    const expected: types.f64x1 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_f64_s64, .expected = expected, .args = .{a} });
}

/// vreinterpret_f64_s8
pub inline fn vreinterpret_f64_s8(a: types.i8x8) types.f64x1 {
    return @bitCast(a);
}

test vreinterpret_f64_s8 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.i8x8 = @bitCast(bytes);
    const expected: types.f64x1 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_f64_s8, .expected = expected, .args = .{a} });
}

/// vreinterpret_f64_u16
pub inline fn vreinterpret_f64_u16(a: types.u16x4) types.f64x1 {
    return @bitCast(a);
}

test vreinterpret_f64_u16 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.u16x4 = @bitCast(bytes);
    const expected: types.f64x1 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_f64_u16, .expected = expected, .args = .{a} });
}

/// vreinterpret_f64_u32
pub inline fn vreinterpret_f64_u32(a: types.u32x2) types.f64x1 {
    return @bitCast(a);
}

test vreinterpret_f64_u32 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.u32x2 = @bitCast(bytes);
    const expected: types.f64x1 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_f64_u32, .expected = expected, .args = .{a} });
}

/// vreinterpret_f64_u64
pub inline fn vreinterpret_f64_u64(a: types.u64x1) types.f64x1 {
    return @bitCast(a);
}

test vreinterpret_f64_u64 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.u64x1 = @bitCast(bytes);
    const expected: types.f64x1 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_f64_u64, .expected = expected, .args = .{a} });
}

/// vreinterpret_f64_u8
pub inline fn vreinterpret_f64_u8(a: types.u8x8) types.f64x1 {
    return @bitCast(a);
}

test vreinterpret_f64_u8 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.u8x8 = @bitCast(bytes);
    const expected: types.f64x1 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_f64_u8, .expected = expected, .args = .{a} });
}

/// vreinterpret_p16_f16
pub inline fn vreinterpret_p16_f16(a: types.f16x4) types.p16x4 {
    return @bitCast(a);
}

test vreinterpret_p16_f16 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.f16x4 = @bitCast(bytes);
    const expected: types.p16x4 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_p16_f16, .expected = expected, .args = .{a} });
}

/// vreinterpret_p16_f32
pub inline fn vreinterpret_p16_f32(a: types.f32x2) types.p16x4 {
    return @bitCast(a);
}

test vreinterpret_p16_f32 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.f32x2 = @bitCast(bytes);
    const expected: types.p16x4 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_p16_f32, .expected = expected, .args = .{a} });
}

/// vreinterpret_p16_f64
pub inline fn vreinterpret_p16_f64(a: types.f64x1) types.p16x4 {
    return @bitCast(a);
}

test vreinterpret_p16_f64 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.f64x1 = @bitCast(bytes);
    const expected: types.p16x4 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_p16_f64, .expected = expected, .args = .{a} });
}

/// vreinterpret_p16_p64
pub inline fn vreinterpret_p16_p64(a: types.p64x1) types.p16x4 {
    return @bitCast(a);
}

test vreinterpret_p16_p64 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.p64x1 = @bitCast(bytes);
    const expected: types.p16x4 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_p16_p64, .expected = expected, .args = .{a} });
}

/// vreinterpret_p16_p8
pub inline fn vreinterpret_p16_p8(a: types.p8x8) types.p16x4 {
    return @bitCast(a);
}

test vreinterpret_p16_p8 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.p8x8 = @bitCast(bytes);
    const expected: types.p16x4 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_p16_p8, .expected = expected, .args = .{a} });
}

/// vreinterpret_p16_s16
pub inline fn vreinterpret_p16_s16(a: types.i16x4) types.p16x4 {
    return @bitCast(a);
}

test vreinterpret_p16_s16 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.i16x4 = @bitCast(bytes);
    const expected: types.p16x4 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_p16_s16, .expected = expected, .args = .{a} });
}

/// vreinterpret_p16_s32
pub inline fn vreinterpret_p16_s32(a: types.i32x2) types.p16x4 {
    return @bitCast(a);
}

test vreinterpret_p16_s32 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.i32x2 = @bitCast(bytes);
    const expected: types.p16x4 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_p16_s32, .expected = expected, .args = .{a} });
}

/// vreinterpret_p16_s64
pub inline fn vreinterpret_p16_s64(a: types.i64x1) types.p16x4 {
    return @bitCast(a);
}

test vreinterpret_p16_s64 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.i64x1 = @bitCast(bytes);
    const expected: types.p16x4 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_p16_s64, .expected = expected, .args = .{a} });
}

/// vreinterpret_p16_s8
pub inline fn vreinterpret_p16_s8(a: types.i8x8) types.p16x4 {
    return @bitCast(a);
}

test vreinterpret_p16_s8 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.i8x8 = @bitCast(bytes);
    const expected: types.p16x4 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_p16_s8, .expected = expected, .args = .{a} });
}

/// vreinterpret_p16_u16
pub inline fn vreinterpret_p16_u16(a: types.u16x4) types.p16x4 {
    return @bitCast(a);
}

test vreinterpret_p16_u16 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.u16x4 = @bitCast(bytes);
    const expected: types.p16x4 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_p16_u16, .expected = expected, .args = .{a} });
}

/// vreinterpret_p16_u32
pub inline fn vreinterpret_p16_u32(a: types.u32x2) types.p16x4 {
    return @bitCast(a);
}

test vreinterpret_p16_u32 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.u32x2 = @bitCast(bytes);
    const expected: types.p16x4 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_p16_u32, .expected = expected, .args = .{a} });
}

/// vreinterpret_p16_u64
pub inline fn vreinterpret_p16_u64(a: types.u64x1) types.p16x4 {
    return @bitCast(a);
}

test vreinterpret_p16_u64 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.u64x1 = @bitCast(bytes);
    const expected: types.p16x4 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_p16_u64, .expected = expected, .args = .{a} });
}

/// vreinterpret_p16_u8
pub inline fn vreinterpret_p16_u8(a: types.u8x8) types.p16x4 {
    return @bitCast(a);
}

test vreinterpret_p16_u8 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.u8x8 = @bitCast(bytes);
    const expected: types.p16x4 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_p16_u8, .expected = expected, .args = .{a} });
}

/// vreinterpret_p64_f16
pub inline fn vreinterpret_p64_f16(a: types.f16x4) types.p64x1 {
    return @bitCast(a);
}

test vreinterpret_p64_f16 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.f16x4 = @bitCast(bytes);
    const expected: types.p64x1 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_p64_f16, .expected = expected, .args = .{a} });
}

/// vreinterpret_p64_f32
pub inline fn vreinterpret_p64_f32(a: types.f32x2) types.p64x1 {
    return @bitCast(a);
}

test vreinterpret_p64_f32 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.f32x2 = @bitCast(bytes);
    const expected: types.p64x1 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_p64_f32, .expected = expected, .args = .{a} });
}

/// vreinterpret_p64_f64
pub inline fn vreinterpret_p64_f64(a: types.f64x1) types.p64x1 {
    return @bitCast(a);
}

test vreinterpret_p64_f64 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.f64x1 = @bitCast(bytes);
    const expected: types.p64x1 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_p64_f64, .expected = expected, .args = .{a} });
}

/// vreinterpret_p64_p16
pub inline fn vreinterpret_p64_p16(a: types.p16x4) types.p64x1 {
    return @bitCast(a);
}

test vreinterpret_p64_p16 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.p16x4 = @bitCast(bytes);
    const expected: types.p64x1 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_p64_p16, .expected = expected, .args = .{a} });
}

/// vreinterpret_p64_p8
pub inline fn vreinterpret_p64_p8(a: types.p8x8) types.p64x1 {
    return @bitCast(a);
}

test vreinterpret_p64_p8 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.p8x8 = @bitCast(bytes);
    const expected: types.p64x1 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_p64_p8, .expected = expected, .args = .{a} });
}

/// vreinterpret_p64_s16
pub inline fn vreinterpret_p64_s16(a: types.i16x4) types.p64x1 {
    return @bitCast(a);
}

test vreinterpret_p64_s16 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.i16x4 = @bitCast(bytes);
    const expected: types.p64x1 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_p64_s16, .expected = expected, .args = .{a} });
}

/// vreinterpret_p64_s32
pub inline fn vreinterpret_p64_s32(a: types.i32x2) types.p64x1 {
    return @bitCast(a);
}

test vreinterpret_p64_s32 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.i32x2 = @bitCast(bytes);
    const expected: types.p64x1 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_p64_s32, .expected = expected, .args = .{a} });
}

/// vreinterpret_p64_s64
pub inline fn vreinterpret_p64_s64(a: types.i64x1) types.p64x1 {
    return @bitCast(a);
}

test vreinterpret_p64_s64 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.i64x1 = @bitCast(bytes);
    const expected: types.p64x1 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_p64_s64, .expected = expected, .args = .{a} });
}

/// vreinterpret_p64_s8
pub inline fn vreinterpret_p64_s8(a: types.i8x8) types.p64x1 {
    return @bitCast(a);
}

test vreinterpret_p64_s8 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.i8x8 = @bitCast(bytes);
    const expected: types.p64x1 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_p64_s8, .expected = expected, .args = .{a} });
}

/// vreinterpret_p64_u16
pub inline fn vreinterpret_p64_u16(a: types.u16x4) types.p64x1 {
    return @bitCast(a);
}

test vreinterpret_p64_u16 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.u16x4 = @bitCast(bytes);
    const expected: types.p64x1 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_p64_u16, .expected = expected, .args = .{a} });
}

/// vreinterpret_p64_u32
pub inline fn vreinterpret_p64_u32(a: types.u32x2) types.p64x1 {
    return @bitCast(a);
}

test vreinterpret_p64_u32 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.u32x2 = @bitCast(bytes);
    const expected: types.p64x1 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_p64_u32, .expected = expected, .args = .{a} });
}

/// vreinterpret_p64_u64
pub inline fn vreinterpret_p64_u64(a: types.u64x1) types.p64x1 {
    return @bitCast(a);
}

test vreinterpret_p64_u64 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.u64x1 = @bitCast(bytes);
    const expected: types.p64x1 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_p64_u64, .expected = expected, .args = .{a} });
}

/// vreinterpret_p64_u8
pub inline fn vreinterpret_p64_u8(a: types.u8x8) types.p64x1 {
    return @bitCast(a);
}

test vreinterpret_p64_u8 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.u8x8 = @bitCast(bytes);
    const expected: types.p64x1 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_p64_u8, .expected = expected, .args = .{a} });
}

/// vreinterpret_p8_f16
pub inline fn vreinterpret_p8_f16(a: types.f16x4) types.p8x8 {
    return @bitCast(a);
}

test vreinterpret_p8_f16 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.f16x4 = @bitCast(bytes);
    const expected: types.p8x8 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_p8_f16, .expected = expected, .args = .{a} });
}

/// vreinterpret_p8_f32
pub inline fn vreinterpret_p8_f32(a: types.f32x2) types.p8x8 {
    return @bitCast(a);
}

test vreinterpret_p8_f32 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.f32x2 = @bitCast(bytes);
    const expected: types.p8x8 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_p8_f32, .expected = expected, .args = .{a} });
}

/// vreinterpret_p8_f64
pub inline fn vreinterpret_p8_f64(a: types.f64x1) types.p8x8 {
    return @bitCast(a);
}

test vreinterpret_p8_f64 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.f64x1 = @bitCast(bytes);
    const expected: types.p8x8 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_p8_f64, .expected = expected, .args = .{a} });
}

/// vreinterpret_p8_p16
pub inline fn vreinterpret_p8_p16(a: types.p16x4) types.p8x8 {
    return @bitCast(a);
}

test vreinterpret_p8_p16 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.p16x4 = @bitCast(bytes);
    const expected: types.p8x8 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_p8_p16, .expected = expected, .args = .{a} });
}

/// vreinterpret_p8_p64
pub inline fn vreinterpret_p8_p64(a: types.p64x1) types.p8x8 {
    return @bitCast(a);
}

test vreinterpret_p8_p64 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.p64x1 = @bitCast(bytes);
    const expected: types.p8x8 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_p8_p64, .expected = expected, .args = .{a} });
}

/// vreinterpret_p8_s16
pub inline fn vreinterpret_p8_s16(a: types.i16x4) types.p8x8 {
    return @bitCast(a);
}

test vreinterpret_p8_s16 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.i16x4 = @bitCast(bytes);
    const expected: types.p8x8 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_p8_s16, .expected = expected, .args = .{a} });
}

/// vreinterpret_p8_s32
pub inline fn vreinterpret_p8_s32(a: types.i32x2) types.p8x8 {
    return @bitCast(a);
}

test vreinterpret_p8_s32 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.i32x2 = @bitCast(bytes);
    const expected: types.p8x8 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_p8_s32, .expected = expected, .args = .{a} });
}

/// vreinterpret_p8_s64
pub inline fn vreinterpret_p8_s64(a: types.i64x1) types.p8x8 {
    return @bitCast(a);
}

test vreinterpret_p8_s64 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.i64x1 = @bitCast(bytes);
    const expected: types.p8x8 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_p8_s64, .expected = expected, .args = .{a} });
}

/// vreinterpret_p8_s8
pub inline fn vreinterpret_p8_s8(a: types.i8x8) types.p8x8 {
    return @bitCast(a);
}

test vreinterpret_p8_s8 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.i8x8 = @bitCast(bytes);
    const expected: types.p8x8 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_p8_s8, .expected = expected, .args = .{a} });
}

/// vreinterpret_p8_u16
pub inline fn vreinterpret_p8_u16(a: types.u16x4) types.p8x8 {
    return @bitCast(a);
}

test vreinterpret_p8_u16 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.u16x4 = @bitCast(bytes);
    const expected: types.p8x8 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_p8_u16, .expected = expected, .args = .{a} });
}

/// vreinterpret_p8_u32
pub inline fn vreinterpret_p8_u32(a: types.u32x2) types.p8x8 {
    return @bitCast(a);
}

test vreinterpret_p8_u32 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.u32x2 = @bitCast(bytes);
    const expected: types.p8x8 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_p8_u32, .expected = expected, .args = .{a} });
}

/// vreinterpret_p8_u64
pub inline fn vreinterpret_p8_u64(a: types.u64x1) types.p8x8 {
    return @bitCast(a);
}

test vreinterpret_p8_u64 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.u64x1 = @bitCast(bytes);
    const expected: types.p8x8 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_p8_u64, .expected = expected, .args = .{a} });
}

/// vreinterpret_p8_u8
pub inline fn vreinterpret_p8_u8(a: types.u8x8) types.p8x8 {
    return @bitCast(a);
}

test vreinterpret_p8_u8 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.u8x8 = @bitCast(bytes);
    const expected: types.p8x8 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_p8_u8, .expected = expected, .args = .{a} });
}

/// vreinterpret_s16_f16
pub inline fn vreinterpret_s16_f16(a: types.f16x4) types.i16x4 {
    return @bitCast(a);
}

test vreinterpret_s16_f16 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.f16x4 = @bitCast(bytes);
    const expected: types.i16x4 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_s16_f16, .expected = expected, .args = .{a} });
}

/// vreinterpret_s16_f32
pub inline fn vreinterpret_s16_f32(a: types.f32x2) types.i16x4 {
    return @bitCast(a);
}

test vreinterpret_s16_f32 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.f32x2 = @bitCast(bytes);
    const expected: types.i16x4 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_s16_f32, .expected = expected, .args = .{a} });
}

/// vreinterpret_s16_f64
pub inline fn vreinterpret_s16_f64(a: types.f64x1) types.i16x4 {
    return @bitCast(a);
}

test vreinterpret_s16_f64 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.f64x1 = @bitCast(bytes);
    const expected: types.i16x4 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_s16_f64, .expected = expected, .args = .{a} });
}

/// vreinterpret_s16_p16
pub inline fn vreinterpret_s16_p16(a: types.p16x4) types.i16x4 {
    return @bitCast(a);
}

test vreinterpret_s16_p16 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.p16x4 = @bitCast(bytes);
    const expected: types.i16x4 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_s16_p16, .expected = expected, .args = .{a} });
}

/// vreinterpret_s16_p64
pub inline fn vreinterpret_s16_p64(a: types.p64x1) types.i16x4 {
    return @bitCast(a);
}

test vreinterpret_s16_p64 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.p64x1 = @bitCast(bytes);
    const expected: types.i16x4 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_s16_p64, .expected = expected, .args = .{a} });
}

/// vreinterpret_s16_p8
pub inline fn vreinterpret_s16_p8(a: types.p8x8) types.i16x4 {
    return @bitCast(a);
}

test vreinterpret_s16_p8 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.p8x8 = @bitCast(bytes);
    const expected: types.i16x4 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_s16_p8, .expected = expected, .args = .{a} });
}

/// vreinterpret_s16_s32
pub inline fn vreinterpret_s16_s32(a: types.i32x2) types.i16x4 {
    return @bitCast(a);
}

test vreinterpret_s16_s32 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.i32x2 = @bitCast(bytes);
    const expected: types.i16x4 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_s16_s32, .expected = expected, .args = .{a} });
}

/// vreinterpret_s16_s64
pub inline fn vreinterpret_s16_s64(a: types.i64x1) types.i16x4 {
    return @bitCast(a);
}

test vreinterpret_s16_s64 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.i64x1 = @bitCast(bytes);
    const expected: types.i16x4 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_s16_s64, .expected = expected, .args = .{a} });
}

/// vreinterpret_s16_s8
pub inline fn vreinterpret_s16_s8(a: types.i8x8) types.i16x4 {
    return @bitCast(a);
}

test vreinterpret_s16_s8 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.i8x8 = @bitCast(bytes);
    const expected: types.i16x4 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_s16_s8, .expected = expected, .args = .{a} });
}

/// vreinterpret_s16_u16
pub inline fn vreinterpret_s16_u16(a: types.u16x4) types.i16x4 {
    return @bitCast(a);
}

test vreinterpret_s16_u16 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.u16x4 = @bitCast(bytes);
    const expected: types.i16x4 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_s16_u16, .expected = expected, .args = .{a} });
}

/// vreinterpret_s16_u32
pub inline fn vreinterpret_s16_u32(a: types.u32x2) types.i16x4 {
    return @bitCast(a);
}

test vreinterpret_s16_u32 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.u32x2 = @bitCast(bytes);
    const expected: types.i16x4 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_s16_u32, .expected = expected, .args = .{a} });
}

/// vreinterpret_s16_u64
pub inline fn vreinterpret_s16_u64(a: types.u64x1) types.i16x4 {
    return @bitCast(a);
}

test vreinterpret_s16_u64 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.u64x1 = @bitCast(bytes);
    const expected: types.i16x4 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_s16_u64, .expected = expected, .args = .{a} });
}

/// vreinterpret_s16_u8
pub inline fn vreinterpret_s16_u8(a: types.u8x8) types.i16x4 {
    return @bitCast(a);
}

test vreinterpret_s16_u8 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.u8x8 = @bitCast(bytes);
    const expected: types.i16x4 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_s16_u8, .expected = expected, .args = .{a} });
}

/// vreinterpret_s32_f16
pub inline fn vreinterpret_s32_f16(a: types.f16x4) types.i32x2 {
    return @bitCast(a);
}

test vreinterpret_s32_f16 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.f16x4 = @bitCast(bytes);
    const expected: types.i32x2 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_s32_f16, .expected = expected, .args = .{a} });
}

/// vreinterpret_s32_f32
pub inline fn vreinterpret_s32_f32(a: types.f32x2) types.i32x2 {
    return @bitCast(a);
}

test vreinterpret_s32_f32 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.f32x2 = @bitCast(bytes);
    const expected: types.i32x2 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_s32_f32, .expected = expected, .args = .{a} });
}

/// vreinterpret_s32_f64
pub inline fn vreinterpret_s32_f64(a: types.f64x1) types.i32x2 {
    return @bitCast(a);
}

test vreinterpret_s32_f64 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.f64x1 = @bitCast(bytes);
    const expected: types.i32x2 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_s32_f64, .expected = expected, .args = .{a} });
}

/// vreinterpret_s32_p16
pub inline fn vreinterpret_s32_p16(a: types.p16x4) types.i32x2 {
    return @bitCast(a);
}

test vreinterpret_s32_p16 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.p16x4 = @bitCast(bytes);
    const expected: types.i32x2 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_s32_p16, .expected = expected, .args = .{a} });
}

/// vreinterpret_s32_p64
pub inline fn vreinterpret_s32_p64(a: types.p64x1) types.i32x2 {
    return @bitCast(a);
}

test vreinterpret_s32_p64 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.p64x1 = @bitCast(bytes);
    const expected: types.i32x2 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_s32_p64, .expected = expected, .args = .{a} });
}

/// vreinterpret_s32_p8
pub inline fn vreinterpret_s32_p8(a: types.p8x8) types.i32x2 {
    return @bitCast(a);
}

test vreinterpret_s32_p8 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.p8x8 = @bitCast(bytes);
    const expected: types.i32x2 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_s32_p8, .expected = expected, .args = .{a} });
}

/// vreinterpret_s32_s16
pub inline fn vreinterpret_s32_s16(a: types.i16x4) types.i32x2 {
    return @bitCast(a);
}

test vreinterpret_s32_s16 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.i16x4 = @bitCast(bytes);
    const expected: types.i32x2 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_s32_s16, .expected = expected, .args = .{a} });
}

/// vreinterpret_s32_s64
pub inline fn vreinterpret_s32_s64(a: types.i64x1) types.i32x2 {
    return @bitCast(a);
}

test vreinterpret_s32_s64 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.i64x1 = @bitCast(bytes);
    const expected: types.i32x2 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_s32_s64, .expected = expected, .args = .{a} });
}

/// vreinterpret_s32_s8
pub inline fn vreinterpret_s32_s8(a: types.i8x8) types.i32x2 {
    return @bitCast(a);
}

test vreinterpret_s32_s8 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.i8x8 = @bitCast(bytes);
    const expected: types.i32x2 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_s32_s8, .expected = expected, .args = .{a} });
}

/// vreinterpret_s32_u16
pub inline fn vreinterpret_s32_u16(a: types.u16x4) types.i32x2 {
    return @bitCast(a);
}

test vreinterpret_s32_u16 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.u16x4 = @bitCast(bytes);
    const expected: types.i32x2 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_s32_u16, .expected = expected, .args = .{a} });
}

/// vreinterpret_s32_u32
pub inline fn vreinterpret_s32_u32(a: types.u32x2) types.i32x2 {
    return @bitCast(a);
}

test vreinterpret_s32_u32 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.u32x2 = @bitCast(bytes);
    const expected: types.i32x2 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_s32_u32, .expected = expected, .args = .{a} });
}

/// vreinterpret_s32_u64
pub inline fn vreinterpret_s32_u64(a: types.u64x1) types.i32x2 {
    return @bitCast(a);
}

test vreinterpret_s32_u64 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.u64x1 = @bitCast(bytes);
    const expected: types.i32x2 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_s32_u64, .expected = expected, .args = .{a} });
}

/// vreinterpret_s32_u8
pub inline fn vreinterpret_s32_u8(a: types.u8x8) types.i32x2 {
    return @bitCast(a);
}

test vreinterpret_s32_u8 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.u8x8 = @bitCast(bytes);
    const expected: types.i32x2 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_s32_u8, .expected = expected, .args = .{a} });
}

/// vreinterpret_s64_f16
pub inline fn vreinterpret_s64_f16(a: types.f16x4) types.i64x1 {
    return @bitCast(a);
}

test vreinterpret_s64_f16 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.f16x4 = @bitCast(bytes);
    const expected: types.i64x1 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_s64_f16, .expected = expected, .args = .{a} });
}

/// vreinterpret_s64_f32
pub inline fn vreinterpret_s64_f32(a: types.f32x2) types.i64x1 {
    return @bitCast(a);
}

test vreinterpret_s64_f32 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.f32x2 = @bitCast(bytes);
    const expected: types.i64x1 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_s64_f32, .expected = expected, .args = .{a} });
}

/// vreinterpret_s64_f64
pub inline fn vreinterpret_s64_f64(a: types.f64x1) types.i64x1 {
    return @bitCast(a);
}

test vreinterpret_s64_f64 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.f64x1 = @bitCast(bytes);
    const expected: types.i64x1 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_s64_f64, .expected = expected, .args = .{a} });
}

/// vreinterpret_s64_p16
pub inline fn vreinterpret_s64_p16(a: types.p16x4) types.i64x1 {
    return @bitCast(a);
}

test vreinterpret_s64_p16 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.p16x4 = @bitCast(bytes);
    const expected: types.i64x1 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_s64_p16, .expected = expected, .args = .{a} });
}

/// vreinterpret_s64_p64
pub inline fn vreinterpret_s64_p64(a: types.p64x1) types.i64x1 {
    return @bitCast(a);
}

test vreinterpret_s64_p64 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.p64x1 = @bitCast(bytes);
    const expected: types.i64x1 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_s64_p64, .expected = expected, .args = .{a} });
}

/// vreinterpret_s64_p8
pub inline fn vreinterpret_s64_p8(a: types.p8x8) types.i64x1 {
    return @bitCast(a);
}

test vreinterpret_s64_p8 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.p8x8 = @bitCast(bytes);
    const expected: types.i64x1 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_s64_p8, .expected = expected, .args = .{a} });
}

/// vreinterpret_s64_s16
pub inline fn vreinterpret_s64_s16(a: types.i16x4) types.i64x1 {
    return @bitCast(a);
}

test vreinterpret_s64_s16 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.i16x4 = @bitCast(bytes);
    const expected: types.i64x1 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_s64_s16, .expected = expected, .args = .{a} });
}

/// vreinterpret_s64_s32
pub inline fn vreinterpret_s64_s32(a: types.i32x2) types.i64x1 {
    return @bitCast(a);
}

test vreinterpret_s64_s32 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.i32x2 = @bitCast(bytes);
    const expected: types.i64x1 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_s64_s32, .expected = expected, .args = .{a} });
}

/// vreinterpret_s64_s8
pub inline fn vreinterpret_s64_s8(a: types.i8x8) types.i64x1 {
    return @bitCast(a);
}

test vreinterpret_s64_s8 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.i8x8 = @bitCast(bytes);
    const expected: types.i64x1 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_s64_s8, .expected = expected, .args = .{a} });
}

/// vreinterpret_s64_u16
pub inline fn vreinterpret_s64_u16(a: types.u16x4) types.i64x1 {
    return @bitCast(a);
}

test vreinterpret_s64_u16 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.u16x4 = @bitCast(bytes);
    const expected: types.i64x1 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_s64_u16, .expected = expected, .args = .{a} });
}

/// vreinterpret_s64_u32
pub inline fn vreinterpret_s64_u32(a: types.u32x2) types.i64x1 {
    return @bitCast(a);
}

test vreinterpret_s64_u32 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.u32x2 = @bitCast(bytes);
    const expected: types.i64x1 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_s64_u32, .expected = expected, .args = .{a} });
}

/// vreinterpret_s64_u64
pub inline fn vreinterpret_s64_u64(a: types.u64x1) types.i64x1 {
    return @bitCast(a);
}

test vreinterpret_s64_u64 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.u64x1 = @bitCast(bytes);
    const expected: types.i64x1 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_s64_u64, .expected = expected, .args = .{a} });
}

/// vreinterpret_s64_u8
pub inline fn vreinterpret_s64_u8(a: types.u8x8) types.i64x1 {
    return @bitCast(a);
}

test vreinterpret_s64_u8 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.u8x8 = @bitCast(bytes);
    const expected: types.i64x1 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_s64_u8, .expected = expected, .args = .{a} });
}

/// vreinterpret_s8_f16
pub inline fn vreinterpret_s8_f16(a: types.f16x4) types.i8x8 {
    return @bitCast(a);
}

test vreinterpret_s8_f16 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.f16x4 = @bitCast(bytes);
    const expected: types.i8x8 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_s8_f16, .expected = expected, .args = .{a} });
}

/// vreinterpret_s8_f32
pub inline fn vreinterpret_s8_f32(a: types.f32x2) types.i8x8 {
    return @bitCast(a);
}

test vreinterpret_s8_f32 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.f32x2 = @bitCast(bytes);
    const expected: types.i8x8 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_s8_f32, .expected = expected, .args = .{a} });
}

/// vreinterpret_s8_f64
pub inline fn vreinterpret_s8_f64(a: types.f64x1) types.i8x8 {
    return @bitCast(a);
}

test vreinterpret_s8_f64 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.f64x1 = @bitCast(bytes);
    const expected: types.i8x8 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_s8_f64, .expected = expected, .args = .{a} });
}

/// vreinterpret_s8_p16
pub inline fn vreinterpret_s8_p16(a: types.p16x4) types.i8x8 {
    return @bitCast(a);
}

test vreinterpret_s8_p16 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.p16x4 = @bitCast(bytes);
    const expected: types.i8x8 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_s8_p16, .expected = expected, .args = .{a} });
}

/// vreinterpret_s8_p64
pub inline fn vreinterpret_s8_p64(a: types.p64x1) types.i8x8 {
    return @bitCast(a);
}

test vreinterpret_s8_p64 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.p64x1 = @bitCast(bytes);
    const expected: types.i8x8 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_s8_p64, .expected = expected, .args = .{a} });
}

/// vreinterpret_s8_p8
pub inline fn vreinterpret_s8_p8(a: types.p8x8) types.i8x8 {
    return @bitCast(a);
}

test vreinterpret_s8_p8 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.p8x8 = @bitCast(bytes);
    const expected: types.i8x8 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_s8_p8, .expected = expected, .args = .{a} });
}

/// vreinterpret_s8_s16
pub inline fn vreinterpret_s8_s16(a: types.i16x4) types.i8x8 {
    return @bitCast(a);
}

test vreinterpret_s8_s16 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.i16x4 = @bitCast(bytes);
    const expected: types.i8x8 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_s8_s16, .expected = expected, .args = .{a} });
}

/// vreinterpret_s8_s32
pub inline fn vreinterpret_s8_s32(a: types.i32x2) types.i8x8 {
    return @bitCast(a);
}

test vreinterpret_s8_s32 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.i32x2 = @bitCast(bytes);
    const expected: types.i8x8 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_s8_s32, .expected = expected, .args = .{a} });
}

/// vreinterpret_s8_s64
pub inline fn vreinterpret_s8_s64(a: types.i64x1) types.i8x8 {
    return @bitCast(a);
}

test vreinterpret_s8_s64 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.i64x1 = @bitCast(bytes);
    const expected: types.i8x8 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_s8_s64, .expected = expected, .args = .{a} });
}

/// vreinterpret_s8_u16
pub inline fn vreinterpret_s8_u16(a: types.u16x4) types.i8x8 {
    return @bitCast(a);
}

test vreinterpret_s8_u16 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.u16x4 = @bitCast(bytes);
    const expected: types.i8x8 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_s8_u16, .expected = expected, .args = .{a} });
}

/// vreinterpret_s8_u32
pub inline fn vreinterpret_s8_u32(a: types.u32x2) types.i8x8 {
    return @bitCast(a);
}

test vreinterpret_s8_u32 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.u32x2 = @bitCast(bytes);
    const expected: types.i8x8 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_s8_u32, .expected = expected, .args = .{a} });
}

/// vreinterpret_s8_u64
pub inline fn vreinterpret_s8_u64(a: types.u64x1) types.i8x8 {
    return @bitCast(a);
}

test vreinterpret_s8_u64 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.u64x1 = @bitCast(bytes);
    const expected: types.i8x8 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_s8_u64, .expected = expected, .args = .{a} });
}

/// vreinterpret_s8_u8
pub inline fn vreinterpret_s8_u8(a: types.u8x8) types.i8x8 {
    return @bitCast(a);
}

test vreinterpret_s8_u8 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.u8x8 = @bitCast(bytes);
    const expected: types.i8x8 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_s8_u8, .expected = expected, .args = .{a} });
}

/// vreinterpret_u16_f16
pub inline fn vreinterpret_u16_f16(a: types.f16x4) types.u16x4 {
    return @bitCast(a);
}

test vreinterpret_u16_f16 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.f16x4 = @bitCast(bytes);
    const expected: types.u16x4 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_u16_f16, .expected = expected, .args = .{a} });
}

/// vreinterpret_u16_f32
pub inline fn vreinterpret_u16_f32(a: types.f32x2) types.u16x4 {
    return @bitCast(a);
}

test vreinterpret_u16_f32 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.f32x2 = @bitCast(bytes);
    const expected: types.u16x4 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_u16_f32, .expected = expected, .args = .{a} });
}

/// vreinterpret_u16_f64
pub inline fn vreinterpret_u16_f64(a: types.f64x1) types.u16x4 {
    return @bitCast(a);
}

test vreinterpret_u16_f64 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.f64x1 = @bitCast(bytes);
    const expected: types.u16x4 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_u16_f64, .expected = expected, .args = .{a} });
}

/// vreinterpret_u16_p16
pub inline fn vreinterpret_u16_p16(a: types.p16x4) types.u16x4 {
    return @bitCast(a);
}

test vreinterpret_u16_p16 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.p16x4 = @bitCast(bytes);
    const expected: types.u16x4 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_u16_p16, .expected = expected, .args = .{a} });
}

/// vreinterpret_u16_p64
pub inline fn vreinterpret_u16_p64(a: types.p64x1) types.u16x4 {
    return @bitCast(a);
}

test vreinterpret_u16_p64 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.p64x1 = @bitCast(bytes);
    const expected: types.u16x4 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_u16_p64, .expected = expected, .args = .{a} });
}

/// vreinterpret_u16_p8
pub inline fn vreinterpret_u16_p8(a: types.p8x8) types.u16x4 {
    return @bitCast(a);
}

test vreinterpret_u16_p8 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.p8x8 = @bitCast(bytes);
    const expected: types.u16x4 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_u16_p8, .expected = expected, .args = .{a} });
}

/// vreinterpret_u16_s16
pub inline fn vreinterpret_u16_s16(a: types.i16x4) types.u16x4 {
    return @bitCast(a);
}

test vreinterpret_u16_s16 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.i16x4 = @bitCast(bytes);
    const expected: types.u16x4 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_u16_s16, .expected = expected, .args = .{a} });
}

/// vreinterpret_u16_s32
pub inline fn vreinterpret_u16_s32(a: types.i32x2) types.u16x4 {
    return @bitCast(a);
}

test vreinterpret_u16_s32 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.i32x2 = @bitCast(bytes);
    const expected: types.u16x4 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_u16_s32, .expected = expected, .args = .{a} });
}

/// vreinterpret_u16_s64
pub inline fn vreinterpret_u16_s64(a: types.i64x1) types.u16x4 {
    return @bitCast(a);
}

test vreinterpret_u16_s64 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.i64x1 = @bitCast(bytes);
    const expected: types.u16x4 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_u16_s64, .expected = expected, .args = .{a} });
}

/// vreinterpret_u16_s8
pub inline fn vreinterpret_u16_s8(a: types.i8x8) types.u16x4 {
    return @bitCast(a);
}

test vreinterpret_u16_s8 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.i8x8 = @bitCast(bytes);
    const expected: types.u16x4 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_u16_s8, .expected = expected, .args = .{a} });
}

/// vreinterpret_u16_u32
pub inline fn vreinterpret_u16_u32(a: types.u32x2) types.u16x4 {
    return @bitCast(a);
}

test vreinterpret_u16_u32 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.u32x2 = @bitCast(bytes);
    const expected: types.u16x4 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_u16_u32, .expected = expected, .args = .{a} });
}

/// vreinterpret_u16_u64
pub inline fn vreinterpret_u16_u64(a: types.u64x1) types.u16x4 {
    return @bitCast(a);
}

test vreinterpret_u16_u64 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.u64x1 = @bitCast(bytes);
    const expected: types.u16x4 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_u16_u64, .expected = expected, .args = .{a} });
}

/// vreinterpret_u16_u8
pub inline fn vreinterpret_u16_u8(a: types.u8x8) types.u16x4 {
    return @bitCast(a);
}

test vreinterpret_u16_u8 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.u8x8 = @bitCast(bytes);
    const expected: types.u16x4 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_u16_u8, .expected = expected, .args = .{a} });
}

/// vreinterpret_u32_f16
pub inline fn vreinterpret_u32_f16(a: types.f16x4) types.u32x2 {
    return @bitCast(a);
}

test vreinterpret_u32_f16 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.f16x4 = @bitCast(bytes);
    const expected: types.u32x2 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_u32_f16, .expected = expected, .args = .{a} });
}

/// vreinterpret_u32_f32
pub inline fn vreinterpret_u32_f32(a: types.f32x2) types.u32x2 {
    return @bitCast(a);
}

test vreinterpret_u32_f32 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.f32x2 = @bitCast(bytes);
    const expected: types.u32x2 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_u32_f32, .expected = expected, .args = .{a} });
}

/// vreinterpret_u32_f64
pub inline fn vreinterpret_u32_f64(a: types.f64x1) types.u32x2 {
    return @bitCast(a);
}

test vreinterpret_u32_f64 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.f64x1 = @bitCast(bytes);
    const expected: types.u32x2 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_u32_f64, .expected = expected, .args = .{a} });
}

/// vreinterpret_u32_p16
pub inline fn vreinterpret_u32_p16(a: types.p16x4) types.u32x2 {
    return @bitCast(a);
}

test vreinterpret_u32_p16 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.p16x4 = @bitCast(bytes);
    const expected: types.u32x2 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_u32_p16, .expected = expected, .args = .{a} });
}

/// vreinterpret_u32_p64
pub inline fn vreinterpret_u32_p64(a: types.p64x1) types.u32x2 {
    return @bitCast(a);
}

test vreinterpret_u32_p64 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.p64x1 = @bitCast(bytes);
    const expected: types.u32x2 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_u32_p64, .expected = expected, .args = .{a} });
}

/// vreinterpret_u32_p8
pub inline fn vreinterpret_u32_p8(a: types.p8x8) types.u32x2 {
    return @bitCast(a);
}

test vreinterpret_u32_p8 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.p8x8 = @bitCast(bytes);
    const expected: types.u32x2 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_u32_p8, .expected = expected, .args = .{a} });
}

/// vreinterpret_u32_s16
pub inline fn vreinterpret_u32_s16(a: types.i16x4) types.u32x2 {
    return @bitCast(a);
}

test vreinterpret_u32_s16 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.i16x4 = @bitCast(bytes);
    const expected: types.u32x2 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_u32_s16, .expected = expected, .args = .{a} });
}

/// vreinterpret_u32_s32
pub inline fn vreinterpret_u32_s32(a: types.i32x2) types.u32x2 {
    return @bitCast(a);
}

test vreinterpret_u32_s32 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.i32x2 = @bitCast(bytes);
    const expected: types.u32x2 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_u32_s32, .expected = expected, .args = .{a} });
}

/// vreinterpret_u32_s64
pub inline fn vreinterpret_u32_s64(a: types.i64x1) types.u32x2 {
    return @bitCast(a);
}

test vreinterpret_u32_s64 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.i64x1 = @bitCast(bytes);
    const expected: types.u32x2 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_u32_s64, .expected = expected, .args = .{a} });
}

/// vreinterpret_u32_s8
pub inline fn vreinterpret_u32_s8(a: types.i8x8) types.u32x2 {
    return @bitCast(a);
}

test vreinterpret_u32_s8 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.i8x8 = @bitCast(bytes);
    const expected: types.u32x2 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_u32_s8, .expected = expected, .args = .{a} });
}

/// vreinterpret_u32_u16
pub inline fn vreinterpret_u32_u16(a: types.u16x4) types.u32x2 {
    return @bitCast(a);
}

test vreinterpret_u32_u16 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.u16x4 = @bitCast(bytes);
    const expected: types.u32x2 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_u32_u16, .expected = expected, .args = .{a} });
}

/// vreinterpret_u32_u64
pub inline fn vreinterpret_u32_u64(a: types.u64x1) types.u32x2 {
    return @bitCast(a);
}

test vreinterpret_u32_u64 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.u64x1 = @bitCast(bytes);
    const expected: types.u32x2 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_u32_u64, .expected = expected, .args = .{a} });
}

/// vreinterpret_u32_u8
pub inline fn vreinterpret_u32_u8(a: types.u8x8) types.u32x2 {
    return @bitCast(a);
}

test vreinterpret_u32_u8 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.u8x8 = @bitCast(bytes);
    const expected: types.u32x2 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_u32_u8, .expected = expected, .args = .{a} });
}

/// vreinterpret_u64_f16
pub inline fn vreinterpret_u64_f16(a: types.f16x4) types.u64x1 {
    return @bitCast(a);
}

test vreinterpret_u64_f16 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.f16x4 = @bitCast(bytes);
    const expected: types.u64x1 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_u64_f16, .expected = expected, .args = .{a} });
}

/// vreinterpret_u64_f32
pub inline fn vreinterpret_u64_f32(a: types.f32x2) types.u64x1 {
    return @bitCast(a);
}

test vreinterpret_u64_f32 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.f32x2 = @bitCast(bytes);
    const expected: types.u64x1 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_u64_f32, .expected = expected, .args = .{a} });
}

/// vreinterpret_u64_f64
pub inline fn vreinterpret_u64_f64(a: types.f64x1) types.u64x1 {
    return @bitCast(a);
}

test vreinterpret_u64_f64 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.f64x1 = @bitCast(bytes);
    const expected: types.u64x1 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_u64_f64, .expected = expected, .args = .{a} });
}

/// vreinterpret_u64_p16
pub inline fn vreinterpret_u64_p16(a: types.p16x4) types.u64x1 {
    return @bitCast(a);
}

test vreinterpret_u64_p16 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.p16x4 = @bitCast(bytes);
    const expected: types.u64x1 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_u64_p16, .expected = expected, .args = .{a} });
}

/// vreinterpret_u64_p64
pub inline fn vreinterpret_u64_p64(a: types.p64x1) types.u64x1 {
    return @bitCast(a);
}

test vreinterpret_u64_p64 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.p64x1 = @bitCast(bytes);
    const expected: types.u64x1 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_u64_p64, .expected = expected, .args = .{a} });
}

/// vreinterpret_u64_p8
pub inline fn vreinterpret_u64_p8(a: types.p8x8) types.u64x1 {
    return @bitCast(a);
}

test vreinterpret_u64_p8 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.p8x8 = @bitCast(bytes);
    const expected: types.u64x1 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_u64_p8, .expected = expected, .args = .{a} });
}

/// vreinterpret_u64_s16
pub inline fn vreinterpret_u64_s16(a: types.i16x4) types.u64x1 {
    return @bitCast(a);
}

test vreinterpret_u64_s16 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.i16x4 = @bitCast(bytes);
    const expected: types.u64x1 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_u64_s16, .expected = expected, .args = .{a} });
}

/// vreinterpret_u64_s32
pub inline fn vreinterpret_u64_s32(a: types.i32x2) types.u64x1 {
    return @bitCast(a);
}

test vreinterpret_u64_s32 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.i32x2 = @bitCast(bytes);
    const expected: types.u64x1 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_u64_s32, .expected = expected, .args = .{a} });
}

/// vreinterpret_u64_s64
pub inline fn vreinterpret_u64_s64(a: types.i64x1) types.u64x1 {
    return @bitCast(a);
}

test vreinterpret_u64_s64 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.i64x1 = @bitCast(bytes);
    const expected: types.u64x1 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_u64_s64, .expected = expected, .args = .{a} });
}

/// vreinterpret_u64_s8
pub inline fn vreinterpret_u64_s8(a: types.i8x8) types.u64x1 {
    return @bitCast(a);
}

test vreinterpret_u64_s8 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.i8x8 = @bitCast(bytes);
    const expected: types.u64x1 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_u64_s8, .expected = expected, .args = .{a} });
}

/// vreinterpret_u64_u16
pub inline fn vreinterpret_u64_u16(a: types.u16x4) types.u64x1 {
    return @bitCast(a);
}

test vreinterpret_u64_u16 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.u16x4 = @bitCast(bytes);
    const expected: types.u64x1 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_u64_u16, .expected = expected, .args = .{a} });
}

/// vreinterpret_u64_u32
pub inline fn vreinterpret_u64_u32(a: types.u32x2) types.u64x1 {
    return @bitCast(a);
}

test vreinterpret_u64_u32 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.u32x2 = @bitCast(bytes);
    const expected: types.u64x1 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_u64_u32, .expected = expected, .args = .{a} });
}

/// vreinterpret_u64_u8
pub inline fn vreinterpret_u64_u8(a: types.u8x8) types.u64x1 {
    return @bitCast(a);
}

test vreinterpret_u64_u8 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.u8x8 = @bitCast(bytes);
    const expected: types.u64x1 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_u64_u8, .expected = expected, .args = .{a} });
}

/// vreinterpret_u8_f16
pub inline fn vreinterpret_u8_f16(a: types.f16x4) types.u8x8 {
    return @bitCast(a);
}

test vreinterpret_u8_f16 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.f16x4 = @bitCast(bytes);
    const expected: types.u8x8 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_u8_f16, .expected = expected, .args = .{a} });
}

/// vreinterpret_u8_f32
pub inline fn vreinterpret_u8_f32(a: types.f32x2) types.u8x8 {
    return @bitCast(a);
}

test vreinterpret_u8_f32 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.f32x2 = @bitCast(bytes);
    const expected: types.u8x8 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_u8_f32, .expected = expected, .args = .{a} });
}

/// vreinterpret_u8_f64
pub inline fn vreinterpret_u8_f64(a: types.f64x1) types.u8x8 {
    return @bitCast(a);
}

test vreinterpret_u8_f64 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.f64x1 = @bitCast(bytes);
    const expected: types.u8x8 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_u8_f64, .expected = expected, .args = .{a} });
}

/// vreinterpret_u8_p16
pub inline fn vreinterpret_u8_p16(a: types.p16x4) types.u8x8 {
    return @bitCast(a);
}

test vreinterpret_u8_p16 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.p16x4 = @bitCast(bytes);
    const expected: types.u8x8 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_u8_p16, .expected = expected, .args = .{a} });
}

/// vreinterpret_u8_p64
pub inline fn vreinterpret_u8_p64(a: types.p64x1) types.u8x8 {
    return @bitCast(a);
}

test vreinterpret_u8_p64 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.p64x1 = @bitCast(bytes);
    const expected: types.u8x8 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_u8_p64, .expected = expected, .args = .{a} });
}

/// vreinterpret_u8_p8
pub inline fn vreinterpret_u8_p8(a: types.p8x8) types.u8x8 {
    return @bitCast(a);
}

test vreinterpret_u8_p8 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.p8x8 = @bitCast(bytes);
    const expected: types.u8x8 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_u8_p8, .expected = expected, .args = .{a} });
}

/// vreinterpret_u8_s16
pub inline fn vreinterpret_u8_s16(a: types.i16x4) types.u8x8 {
    return @bitCast(a);
}

test vreinterpret_u8_s16 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.i16x4 = @bitCast(bytes);
    const expected: types.u8x8 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_u8_s16, .expected = expected, .args = .{a} });
}

/// vreinterpret_u8_s32
pub inline fn vreinterpret_u8_s32(a: types.i32x2) types.u8x8 {
    return @bitCast(a);
}

test vreinterpret_u8_s32 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.i32x2 = @bitCast(bytes);
    const expected: types.u8x8 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_u8_s32, .expected = expected, .args = .{a} });
}

/// vreinterpret_u8_s64
pub inline fn vreinterpret_u8_s64(a: types.i64x1) types.u8x8 {
    return @bitCast(a);
}

test vreinterpret_u8_s64 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.i64x1 = @bitCast(bytes);
    const expected: types.u8x8 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_u8_s64, .expected = expected, .args = .{a} });
}

/// vreinterpret_u8_s8
pub inline fn vreinterpret_u8_s8(a: types.i8x8) types.u8x8 {
    return @bitCast(a);
}

test vreinterpret_u8_s8 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.i8x8 = @bitCast(bytes);
    const expected: types.u8x8 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_u8_s8, .expected = expected, .args = .{a} });
}

/// vreinterpret_u8_u16
pub inline fn vreinterpret_u8_u16(a: types.u16x4) types.u8x8 {
    return @bitCast(a);
}

test vreinterpret_u8_u16 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.u16x4 = @bitCast(bytes);
    const expected: types.u8x8 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_u8_u16, .expected = expected, .args = .{a} });
}

/// vreinterpret_u8_u32
pub inline fn vreinterpret_u8_u32(a: types.u32x2) types.u8x8 {
    return @bitCast(a);
}

test vreinterpret_u8_u32 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.u32x2 = @bitCast(bytes);
    const expected: types.u8x8 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_u8_u32, .expected = expected, .args = .{a} });
}

/// vreinterpret_u8_u64
pub inline fn vreinterpret_u8_u64(a: types.u64x1) types.u8x8 {
    return @bitCast(a);
}

test vreinterpret_u8_u64 {
    const bytes = @as(types.u8x8, .{ 1, 2, 3, 4, 5, 6, 7, 8 });
    const a: types.u64x1 = @bitCast(bytes);
    const expected: types.u8x8 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpret_u8_u64, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_f16_f32(a: types.f32x4) types.f16x8 {
    return @bitCast(a);
}

test vreinterpretq_f16_f32 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.f32x4 = @bitCast(bytes);
    const expected: types.f16x8 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_f16_f32, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_f16_f64(a: types.f64x2) types.f16x8 {
    return @bitCast(a);
}

test vreinterpretq_f16_f64 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.f64x2 = @bitCast(bytes);
    const expected: types.f16x8 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_f16_f64, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_f16_p128(a: types.p128) types.f16x8 {
    return @bitCast(a);
}

test vreinterpretq_f16_p128 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.p128 = @bitCast(bytes);
    const expected: types.f16x8 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_f16_p128, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_f16_p16(a: types.p16x8) types.f16x8 {
    return @bitCast(a);
}

test vreinterpretq_f16_p16 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.p16x8 = @bitCast(bytes);
    const expected: types.f16x8 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_f16_p16, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_f16_p64(a: types.p64x2) types.f16x8 {
    return @bitCast(a);
}

test vreinterpretq_f16_p64 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.p64x2 = @bitCast(bytes);
    const expected: types.f16x8 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_f16_p64, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_f16_p8(a: types.p8x16) types.f16x8 {
    return @bitCast(a);
}

test vreinterpretq_f16_p8 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.p8x16 = @bitCast(bytes);
    const expected: types.f16x8 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_f16_p8, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_f16_s16(a: types.i16x8) types.f16x8 {
    return @bitCast(a);
}

test vreinterpretq_f16_s16 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.i16x8 = @bitCast(bytes);
    const expected: types.f16x8 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_f16_s16, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_f16_s32(a: types.i32x4) types.f16x8 {
    return @bitCast(a);
}

test vreinterpretq_f16_s32 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.i32x4 = @bitCast(bytes);
    const expected: types.f16x8 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_f16_s32, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_f16_s64(a: types.i64x2) types.f16x8 {
    return @bitCast(a);
}

test vreinterpretq_f16_s64 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.i64x2 = @bitCast(bytes);
    const expected: types.f16x8 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_f16_s64, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_f16_s8(a: types.i8x16) types.f16x8 {
    return @bitCast(a);
}

test vreinterpretq_f16_s8 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.i8x16 = @bitCast(bytes);
    const expected: types.f16x8 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_f16_s8, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_f16_u16(a: types.u16x8) types.f16x8 {
    return @bitCast(a);
}

test vreinterpretq_f16_u16 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.u16x8 = @bitCast(bytes);
    const expected: types.f16x8 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_f16_u16, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_f16_u32(a: types.u32x4) types.f16x8 {
    return @bitCast(a);
}

test vreinterpretq_f16_u32 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.u32x4 = @bitCast(bytes);
    const expected: types.f16x8 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_f16_u32, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_f16_u64(a: types.u64x2) types.f16x8 {
    return @bitCast(a);
}

test vreinterpretq_f16_u64 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.u64x2 = @bitCast(bytes);
    const expected: types.f16x8 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_f16_u64, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_f16_u8(a: types.u8x16) types.f16x8 {
    return @bitCast(a);
}

test vreinterpretq_f16_u8 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.u8x16 = @bitCast(bytes);
    const expected: types.f16x8 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_f16_u8, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_f32_f16(a: types.f16x8) types.f32x4 {
    return @bitCast(a);
}

test vreinterpretq_f32_f16 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.f16x8 = @bitCast(bytes);
    const expected: types.f32x4 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_f32_f16, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_f32_f64(a: types.f64x2) types.f32x4 {
    return @bitCast(a);
}

test vreinterpretq_f32_f64 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.f64x2 = @bitCast(bytes);
    const expected: types.f32x4 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_f32_f64, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_f32_p128(a: types.p128) types.f32x4 {
    return @bitCast(a);
}

test vreinterpretq_f32_p128 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.p128 = @bitCast(bytes);
    const expected: types.f32x4 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_f32_p128, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_f32_p16(a: types.p16x8) types.f32x4 {
    return @bitCast(a);
}

test vreinterpretq_f32_p16 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.p16x8 = @bitCast(bytes);
    const expected: types.f32x4 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_f32_p16, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_f32_p64(a: types.p64x2) types.f32x4 {
    return @bitCast(a);
}

test vreinterpretq_f32_p64 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.p64x2 = @bitCast(bytes);
    const expected: types.f32x4 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_f32_p64, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_f32_p8(a: types.p8x16) types.f32x4 {
    return @bitCast(a);
}

test vreinterpretq_f32_p8 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.p8x16 = @bitCast(bytes);
    const expected: types.f32x4 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_f32_p8, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_f32_s16(a: types.i16x8) types.f32x4 {
    return @bitCast(a);
}

test vreinterpretq_f32_s16 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.i16x8 = @bitCast(bytes);
    const expected: types.f32x4 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_f32_s16, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_f32_s32(a: types.i32x4) types.f32x4 {
    return @bitCast(a);
}

test vreinterpretq_f32_s32 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.i32x4 = @bitCast(bytes);
    const expected: types.f32x4 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_f32_s32, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_f32_s64(a: types.i64x2) types.f32x4 {
    return @bitCast(a);
}

test vreinterpretq_f32_s64 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.i64x2 = @bitCast(bytes);
    const expected: types.f32x4 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_f32_s64, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_f32_s8(a: types.i8x16) types.f32x4 {
    return @bitCast(a);
}

test vreinterpretq_f32_s8 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.i8x16 = @bitCast(bytes);
    const expected: types.f32x4 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_f32_s8, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_f32_u16(a: types.u16x8) types.f32x4 {
    return @bitCast(a);
}

test vreinterpretq_f32_u16 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.u16x8 = @bitCast(bytes);
    const expected: types.f32x4 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_f32_u16, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_f32_u32(a: types.u32x4) types.f32x4 {
    return @bitCast(a);
}

test vreinterpretq_f32_u32 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.u32x4 = @bitCast(bytes);
    const expected: types.f32x4 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_f32_u32, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_f32_u64(a: types.u64x2) types.f32x4 {
    return @bitCast(a);
}

test vreinterpretq_f32_u64 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.u64x2 = @bitCast(bytes);
    const expected: types.f32x4 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_f32_u64, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_f32_u8(a: types.u8x16) types.f32x4 {
    return @bitCast(a);
}

test vreinterpretq_f32_u8 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.u8x16 = @bitCast(bytes);
    const expected: types.f32x4 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_f32_u8, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_f64_f16(a: types.f16x8) types.f64x2 {
    return @bitCast(a);
}

test vreinterpretq_f64_f16 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.f16x8 = @bitCast(bytes);
    const expected: types.f64x2 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_f64_f16, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_f64_f32(a: types.f32x4) types.f64x2 {
    return @bitCast(a);
}

test vreinterpretq_f64_f32 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.f32x4 = @bitCast(bytes);
    const expected: types.f64x2 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_f64_f32, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_f64_p128(a: types.p128) types.f64x2 {
    return @bitCast(a);
}

test vreinterpretq_f64_p128 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.p128 = @bitCast(bytes);
    const expected: types.f64x2 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_f64_p128, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_f64_p16(a: types.p16x8) types.f64x2 {
    return @bitCast(a);
}

test vreinterpretq_f64_p16 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.p16x8 = @bitCast(bytes);
    const expected: types.f64x2 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_f64_p16, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_f64_p64(a: types.p64x2) types.f64x2 {
    return @bitCast(a);
}

test vreinterpretq_f64_p64 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.p64x2 = @bitCast(bytes);
    const expected: types.f64x2 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_f64_p64, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_f64_p8(a: types.p8x16) types.f64x2 {
    return @bitCast(a);
}

test vreinterpretq_f64_p8 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.p8x16 = @bitCast(bytes);
    const expected: types.f64x2 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_f64_p8, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_f64_s16(a: types.i16x8) types.f64x2 {
    return @bitCast(a);
}

test vreinterpretq_f64_s16 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.i16x8 = @bitCast(bytes);
    const expected: types.f64x2 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_f64_s16, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_f64_s32(a: types.i32x4) types.f64x2 {
    return @bitCast(a);
}

test vreinterpretq_f64_s32 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.i32x4 = @bitCast(bytes);
    const expected: types.f64x2 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_f64_s32, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_f64_s64(a: types.i64x2) types.f64x2 {
    return @bitCast(a);
}

test vreinterpretq_f64_s64 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.i64x2 = @bitCast(bytes);
    const expected: types.f64x2 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_f64_s64, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_f64_s8(a: types.i8x16) types.f64x2 {
    return @bitCast(a);
}

test vreinterpretq_f64_s8 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.i8x16 = @bitCast(bytes);
    const expected: types.f64x2 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_f64_s8, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_f64_u16(a: types.u16x8) types.f64x2 {
    return @bitCast(a);
}

test vreinterpretq_f64_u16 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.u16x8 = @bitCast(bytes);
    const expected: types.f64x2 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_f64_u16, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_f64_u32(a: types.u32x4) types.f64x2 {
    return @bitCast(a);
}

test vreinterpretq_f64_u32 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.u32x4 = @bitCast(bytes);
    const expected: types.f64x2 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_f64_u32, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_f64_u64(a: types.u64x2) types.f64x2 {
    return @bitCast(a);
}

test vreinterpretq_f64_u64 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.u64x2 = @bitCast(bytes);
    const expected: types.f64x2 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_f64_u64, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_f64_u8(a: types.u8x16) types.f64x2 {
    return @bitCast(a);
}

test vreinterpretq_f64_u8 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.u8x16 = @bitCast(bytes);
    const expected: types.f64x2 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_f64_u8, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_p128_f16(a: types.f16x8) types.p128 {
    return @bitCast(a);
}

test vreinterpretq_p128_f16 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.f16x8 = @bitCast(bytes);
    const expected: types.p128 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_p128_f16, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_p128_f32(a: types.f32x4) types.p128 {
    return @bitCast(a);
}

test vreinterpretq_p128_f32 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.f32x4 = @bitCast(bytes);
    const expected: types.p128 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_p128_f32, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_p128_f64(a: types.f64x2) types.p128 {
    return @bitCast(a);
}

test vreinterpretq_p128_f64 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.f64x2 = @bitCast(bytes);
    const expected: types.p128 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_p128_f64, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_p128_p16(a: types.p16x8) types.p128 {
    return @bitCast(a);
}

test vreinterpretq_p128_p16 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.p16x8 = @bitCast(bytes);
    const expected: types.p128 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_p128_p16, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_p128_p64(a: types.p64x2) types.p128 {
    return @bitCast(a);
}

test vreinterpretq_p128_p64 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.p64x2 = @bitCast(bytes);
    const expected: types.p128 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_p128_p64, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_p128_p8(a: types.p8x16) types.p128 {
    return @bitCast(a);
}

test vreinterpretq_p128_p8 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.p8x16 = @bitCast(bytes);
    const expected: types.p128 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_p128_p8, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_p128_s16(a: types.i16x8) types.p128 {
    return @bitCast(a);
}

test vreinterpretq_p128_s16 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.i16x8 = @bitCast(bytes);
    const expected: types.p128 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_p128_s16, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_p128_s32(a: types.i32x4) types.p128 {
    return @bitCast(a);
}

test vreinterpretq_p128_s32 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.i32x4 = @bitCast(bytes);
    const expected: types.p128 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_p128_s32, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_p128_s64(a: types.i64x2) types.p128 {
    return @bitCast(a);
}

test vreinterpretq_p128_s64 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.i64x2 = @bitCast(bytes);
    const expected: types.p128 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_p128_s64, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_p128_s8(a: types.i8x16) types.p128 {
    return @bitCast(a);
}

test vreinterpretq_p128_s8 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.i8x16 = @bitCast(bytes);
    const expected: types.p128 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_p128_s8, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_p128_u16(a: types.u16x8) types.p128 {
    return @bitCast(a);
}

test vreinterpretq_p128_u16 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.u16x8 = @bitCast(bytes);
    const expected: types.p128 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_p128_u16, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_p128_u32(a: types.u32x4) types.p128 {
    return @bitCast(a);
}

test vreinterpretq_p128_u32 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.u32x4 = @bitCast(bytes);
    const expected: types.p128 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_p128_u32, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_p128_u64(a: types.u64x2) types.p128 {
    return @bitCast(a);
}

test vreinterpretq_p128_u64 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.u64x2 = @bitCast(bytes);
    const expected: types.p128 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_p128_u64, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_p128_u8(a: types.u8x16) types.p128 {
    return @bitCast(a);
}

test vreinterpretq_p128_u8 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.u8x16 = @bitCast(bytes);
    const expected: types.p128 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_p128_u8, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_p16_f16(a: types.f16x8) types.p16x8 {
    return @bitCast(a);
}

test vreinterpretq_p16_f16 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.f16x8 = @bitCast(bytes);
    const expected: types.p16x8 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_p16_f16, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_p16_f32(a: types.f32x4) types.p16x8 {
    return @bitCast(a);
}

test vreinterpretq_p16_f32 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.f32x4 = @bitCast(bytes);
    const expected: types.p16x8 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_p16_f32, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_p16_f64(a: types.f64x2) types.p16x8 {
    return @bitCast(a);
}

test vreinterpretq_p16_f64 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.f64x2 = @bitCast(bytes);
    const expected: types.p16x8 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_p16_f64, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_p16_p128(a: types.p128) types.p16x8 {
    return @bitCast(a);
}

test vreinterpretq_p16_p128 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.p128 = @bitCast(bytes);
    const expected: types.p16x8 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_p16_p128, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_p16_p64(a: types.p64x2) types.p16x8 {
    return @bitCast(a);
}

test vreinterpretq_p16_p64 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.p64x2 = @bitCast(bytes);
    const expected: types.p16x8 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_p16_p64, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_p16_p8(a: types.p8x16) types.p16x8 {
    return @bitCast(a);
}

test vreinterpretq_p16_p8 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.p8x16 = @bitCast(bytes);
    const expected: types.p16x8 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_p16_p8, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_p16_s16(a: types.i16x8) types.p16x8 {
    return @bitCast(a);
}

test vreinterpretq_p16_s16 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.i16x8 = @bitCast(bytes);
    const expected: types.p16x8 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_p16_s16, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_p16_s32(a: types.i32x4) types.p16x8 {
    return @bitCast(a);
}

test vreinterpretq_p16_s32 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.i32x4 = @bitCast(bytes);
    const expected: types.p16x8 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_p16_s32, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_p16_s64(a: types.i64x2) types.p16x8 {
    return @bitCast(a);
}

test vreinterpretq_p16_s64 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.i64x2 = @bitCast(bytes);
    const expected: types.p16x8 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_p16_s64, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_p16_s8(a: types.i8x16) types.p16x8 {
    return @bitCast(a);
}

test vreinterpretq_p16_s8 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.i8x16 = @bitCast(bytes);
    const expected: types.p16x8 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_p16_s8, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_p16_u16(a: types.u16x8) types.p16x8 {
    return @bitCast(a);
}

test vreinterpretq_p16_u16 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.u16x8 = @bitCast(bytes);
    const expected: types.p16x8 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_p16_u16, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_p16_u32(a: types.u32x4) types.p16x8 {
    return @bitCast(a);
}

test vreinterpretq_p16_u32 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.u32x4 = @bitCast(bytes);
    const expected: types.p16x8 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_p16_u32, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_p16_u64(a: types.u64x2) types.p16x8 {
    return @bitCast(a);
}

test vreinterpretq_p16_u64 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.u64x2 = @bitCast(bytes);
    const expected: types.p16x8 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_p16_u64, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_p16_u8(a: types.u8x16) types.p16x8 {
    return @bitCast(a);
}

test vreinterpretq_p16_u8 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.u8x16 = @bitCast(bytes);
    const expected: types.p16x8 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_p16_u8, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_p64_f16(a: types.f16x8) types.p64x2 {
    return @bitCast(a);
}

test vreinterpretq_p64_f16 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.f16x8 = @bitCast(bytes);
    const expected: types.p64x2 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_p64_f16, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_p64_f32(a: types.f32x4) types.p64x2 {
    return @bitCast(a);
}

test vreinterpretq_p64_f32 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.f32x4 = @bitCast(bytes);
    const expected: types.p64x2 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_p64_f32, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_p64_f64(a: types.f64x2) types.p64x2 {
    return @bitCast(a);
}

test vreinterpretq_p64_f64 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.f64x2 = @bitCast(bytes);
    const expected: types.p64x2 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_p64_f64, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_p64_p128(a: types.p128) types.p64x2 {
    return @bitCast(a);
}

test vreinterpretq_p64_p128 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.p128 = @bitCast(bytes);
    const expected: types.p64x2 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_p64_p128, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_p64_p16(a: types.p16x8) types.p64x2 {
    return @bitCast(a);
}

test vreinterpretq_p64_p16 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.p16x8 = @bitCast(bytes);
    const expected: types.p64x2 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_p64_p16, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_p64_p8(a: types.p8x16) types.p64x2 {
    return @bitCast(a);
}

test vreinterpretq_p64_p8 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.p8x16 = @bitCast(bytes);
    const expected: types.p64x2 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_p64_p8, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_p64_s16(a: types.i16x8) types.p64x2 {
    return @bitCast(a);
}

test vreinterpretq_p64_s16 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.i16x8 = @bitCast(bytes);
    const expected: types.p64x2 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_p64_s16, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_p64_s32(a: types.i32x4) types.p64x2 {
    return @bitCast(a);
}

test vreinterpretq_p64_s32 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.i32x4 = @bitCast(bytes);
    const expected: types.p64x2 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_p64_s32, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_p64_s64(a: types.i64x2) types.p64x2 {
    return @bitCast(a);
}

test vreinterpretq_p64_s64 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.i64x2 = @bitCast(bytes);
    const expected: types.p64x2 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_p64_s64, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_p64_s8(a: types.i8x16) types.p64x2 {
    return @bitCast(a);
}

test vreinterpretq_p64_s8 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.i8x16 = @bitCast(bytes);
    const expected: types.p64x2 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_p64_s8, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_p64_u16(a: types.u16x8) types.p64x2 {
    return @bitCast(a);
}

test vreinterpretq_p64_u16 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.u16x8 = @bitCast(bytes);
    const expected: types.p64x2 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_p64_u16, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_p64_u32(a: types.u32x4) types.p64x2 {
    return @bitCast(a);
}

test vreinterpretq_p64_u32 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.u32x4 = @bitCast(bytes);
    const expected: types.p64x2 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_p64_u32, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_p64_u64(a: types.u64x2) types.p64x2 {
    return @bitCast(a);
}

test vreinterpretq_p64_u64 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.u64x2 = @bitCast(bytes);
    const expected: types.p64x2 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_p64_u64, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_p64_u8(a: types.u8x16) types.p64x2 {
    return @bitCast(a);
}

test vreinterpretq_p64_u8 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.u8x16 = @bitCast(bytes);
    const expected: types.p64x2 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_p64_u8, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_p8_f16(a: types.f16x8) types.p8x16 {
    return @bitCast(a);
}

test vreinterpretq_p8_f16 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.f16x8 = @bitCast(bytes);
    const expected: types.p8x16 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_p8_f16, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_p8_f32(a: types.f32x4) types.p8x16 {
    return @bitCast(a);
}

test vreinterpretq_p8_f32 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.f32x4 = @bitCast(bytes);
    const expected: types.p8x16 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_p8_f32, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_p8_f64(a: types.f64x2) types.p8x16 {
    return @bitCast(a);
}

test vreinterpretq_p8_f64 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.f64x2 = @bitCast(bytes);
    const expected: types.p8x16 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_p8_f64, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_p8_p128(a: types.p128) types.p8x16 {
    return @bitCast(a);
}

test vreinterpretq_p8_p128 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.p128 = @bitCast(bytes);
    const expected: types.p8x16 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_p8_p128, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_p8_p16(a: types.p16x8) types.p8x16 {
    return @bitCast(a);
}

test vreinterpretq_p8_p16 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.p16x8 = @bitCast(bytes);
    const expected: types.p8x16 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_p8_p16, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_p8_p64(a: types.p64x2) types.p8x16 {
    return @bitCast(a);
}

test vreinterpretq_p8_p64 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.p64x2 = @bitCast(bytes);
    const expected: types.p8x16 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_p8_p64, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_p8_s16(a: types.i16x8) types.p8x16 {
    return @bitCast(a);
}

test vreinterpretq_p8_s16 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.i16x8 = @bitCast(bytes);
    const expected: types.p8x16 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_p8_s16, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_p8_s32(a: types.i32x4) types.p8x16 {
    return @bitCast(a);
}

test vreinterpretq_p8_s32 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.i32x4 = @bitCast(bytes);
    const expected: types.p8x16 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_p8_s32, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_p8_s64(a: types.i64x2) types.p8x16 {
    return @bitCast(a);
}

test vreinterpretq_p8_s64 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.i64x2 = @bitCast(bytes);
    const expected: types.p8x16 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_p8_s64, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_p8_s8(a: types.i8x16) types.p8x16 {
    return @bitCast(a);
}

test vreinterpretq_p8_s8 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.i8x16 = @bitCast(bytes);
    const expected: types.p8x16 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_p8_s8, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_p8_u16(a: types.u16x8) types.p8x16 {
    return @bitCast(a);
}

test vreinterpretq_p8_u16 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.u16x8 = @bitCast(bytes);
    const expected: types.p8x16 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_p8_u16, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_p8_u32(a: types.u32x4) types.p8x16 {
    return @bitCast(a);
}

test vreinterpretq_p8_u32 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.u32x4 = @bitCast(bytes);
    const expected: types.p8x16 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_p8_u32, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_p8_u64(a: types.u64x2) types.p8x16 {
    return @bitCast(a);
}

test vreinterpretq_p8_u64 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.u64x2 = @bitCast(bytes);
    const expected: types.p8x16 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_p8_u64, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_p8_u8(a: types.u8x16) types.p8x16 {
    return @bitCast(a);
}

test vreinterpretq_p8_u8 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.u8x16 = @bitCast(bytes);
    const expected: types.p8x16 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_p8_u8, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_s16_f16(a: types.f16x8) types.i16x8 {
    return @bitCast(a);
}

test vreinterpretq_s16_f16 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.f16x8 = @bitCast(bytes);
    const expected: types.i16x8 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_s16_f16, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_s16_f32(a: types.f32x4) types.i16x8 {
    return @bitCast(a);
}

test vreinterpretq_s16_f32 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.f32x4 = @bitCast(bytes);
    const expected: types.i16x8 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_s16_f32, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_s16_f64(a: types.f64x2) types.i16x8 {
    return @bitCast(a);
}

test vreinterpretq_s16_f64 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.f64x2 = @bitCast(bytes);
    const expected: types.i16x8 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_s16_f64, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_s16_p128(a: types.p128) types.i16x8 {
    return @bitCast(a);
}

test vreinterpretq_s16_p128 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.p128 = @bitCast(bytes);
    const expected: types.i16x8 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_s16_p128, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_s16_p16(a: types.p16x8) types.i16x8 {
    return @bitCast(a);
}

test vreinterpretq_s16_p16 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.p16x8 = @bitCast(bytes);
    const expected: types.i16x8 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_s16_p16, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_s16_p64(a: types.p64x2) types.i16x8 {
    return @bitCast(a);
}

test vreinterpretq_s16_p64 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.p64x2 = @bitCast(bytes);
    const expected: types.i16x8 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_s16_p64, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_s16_p8(a: types.p8x16) types.i16x8 {
    return @bitCast(a);
}

test vreinterpretq_s16_p8 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.p8x16 = @bitCast(bytes);
    const expected: types.i16x8 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_s16_p8, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_s16_s32(a: types.i32x4) types.i16x8 {
    return @bitCast(a);
}

test vreinterpretq_s16_s32 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.i32x4 = @bitCast(bytes);
    const expected: types.i16x8 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_s16_s32, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_s16_s64(a: types.i64x2) types.i16x8 {
    return @bitCast(a);
}

test vreinterpretq_s16_s64 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.i64x2 = @bitCast(bytes);
    const expected: types.i16x8 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_s16_s64, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_s16_s8(a: types.i8x16) types.i16x8 {
    return @bitCast(a);
}

test vreinterpretq_s16_s8 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.i8x16 = @bitCast(bytes);
    const expected: types.i16x8 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_s16_s8, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_s16_u16(a: types.u16x8) types.i16x8 {
    return @bitCast(a);
}

test vreinterpretq_s16_u16 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.u16x8 = @bitCast(bytes);
    const expected: types.i16x8 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_s16_u16, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_s16_u32(a: types.u32x4) types.i16x8 {
    return @bitCast(a);
}

test vreinterpretq_s16_u32 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.u32x4 = @bitCast(bytes);
    const expected: types.i16x8 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_s16_u32, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_s16_u64(a: types.u64x2) types.i16x8 {
    return @bitCast(a);
}

test vreinterpretq_s16_u64 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.u64x2 = @bitCast(bytes);
    const expected: types.i16x8 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_s16_u64, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_s16_u8(a: types.u8x16) types.i16x8 {
    return @bitCast(a);
}

test vreinterpretq_s16_u8 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.u8x16 = @bitCast(bytes);
    const expected: types.i16x8 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_s16_u8, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_s32_f16(a: types.f16x8) types.i32x4 {
    return @bitCast(a);
}

test vreinterpretq_s32_f16 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.f16x8 = @bitCast(bytes);
    const expected: types.i32x4 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_s32_f16, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_s32_f32(a: types.f32x4) types.i32x4 {
    return @bitCast(a);
}

test vreinterpretq_s32_f32 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.f32x4 = @bitCast(bytes);
    const expected: types.i32x4 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_s32_f32, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_s32_f64(a: types.f64x2) types.i32x4 {
    return @bitCast(a);
}

test vreinterpretq_s32_f64 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.f64x2 = @bitCast(bytes);
    const expected: types.i32x4 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_s32_f64, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_s32_p128(a: types.p128) types.i32x4 {
    return @bitCast(a);
}

test vreinterpretq_s32_p128 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.p128 = @bitCast(bytes);
    const expected: types.i32x4 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_s32_p128, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_s32_p16(a: types.p16x8) types.i32x4 {
    return @bitCast(a);
}

test vreinterpretq_s32_p16 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.p16x8 = @bitCast(bytes);
    const expected: types.i32x4 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_s32_p16, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_s32_p64(a: types.p64x2) types.i32x4 {
    return @bitCast(a);
}

test vreinterpretq_s32_p64 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.p64x2 = @bitCast(bytes);
    const expected: types.i32x4 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_s32_p64, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_s32_p8(a: types.p8x16) types.i32x4 {
    return @bitCast(a);
}

test vreinterpretq_s32_p8 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.p8x16 = @bitCast(bytes);
    const expected: types.i32x4 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_s32_p8, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_s32_s16(a: types.i16x8) types.i32x4 {
    return @bitCast(a);
}

test vreinterpretq_s32_s16 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.i16x8 = @bitCast(bytes);
    const expected: types.i32x4 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_s32_s16, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_s32_s64(a: types.i64x2) types.i32x4 {
    return @bitCast(a);
}

test vreinterpretq_s32_s64 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.i64x2 = @bitCast(bytes);
    const expected: types.i32x4 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_s32_s64, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_s32_s8(a: types.i8x16) types.i32x4 {
    return @bitCast(a);
}

test vreinterpretq_s32_s8 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.i8x16 = @bitCast(bytes);
    const expected: types.i32x4 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_s32_s8, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_s32_u16(a: types.u16x8) types.i32x4 {
    return @bitCast(a);
}

test vreinterpretq_s32_u16 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.u16x8 = @bitCast(bytes);
    const expected: types.i32x4 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_s32_u16, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_s32_u32(a: types.u32x4) types.i32x4 {
    return @bitCast(a);
}

test vreinterpretq_s32_u32 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.u32x4 = @bitCast(bytes);
    const expected: types.i32x4 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_s32_u32, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_s32_u64(a: types.u64x2) types.i32x4 {
    return @bitCast(a);
}

test vreinterpretq_s32_u64 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.u64x2 = @bitCast(bytes);
    const expected: types.i32x4 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_s32_u64, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_s32_u8(a: types.u8x16) types.i32x4 {
    return @bitCast(a);
}

test vreinterpretq_s32_u8 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.u8x16 = @bitCast(bytes);
    const expected: types.i32x4 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_s32_u8, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_s64_f16(a: types.f16x8) types.i64x2 {
    return @bitCast(a);
}

test vreinterpretq_s64_f16 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.f16x8 = @bitCast(bytes);
    const expected: types.i64x2 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_s64_f16, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_s64_f32(a: types.f32x4) types.i64x2 {
    return @bitCast(a);
}

test vreinterpretq_s64_f32 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.f32x4 = @bitCast(bytes);
    const expected: types.i64x2 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_s64_f32, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_s64_f64(a: types.f64x2) types.i64x2 {
    return @bitCast(a);
}

test vreinterpretq_s64_f64 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.f64x2 = @bitCast(bytes);
    const expected: types.i64x2 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_s64_f64, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_s64_p128(a: types.p128) types.i64x2 {
    return @bitCast(a);
}

test vreinterpretq_s64_p128 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.p128 = @bitCast(bytes);
    const expected: types.i64x2 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_s64_p128, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_s64_p16(a: types.p16x8) types.i64x2 {
    return @bitCast(a);
}

test vreinterpretq_s64_p16 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.p16x8 = @bitCast(bytes);
    const expected: types.i64x2 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_s64_p16, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_s64_p64(a: types.p64x2) types.i64x2 {
    return @bitCast(a);
}

test vreinterpretq_s64_p64 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.p64x2 = @bitCast(bytes);
    const expected: types.i64x2 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_s64_p64, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_s64_p8(a: types.p8x16) types.i64x2 {
    return @bitCast(a);
}

test vreinterpretq_s64_p8 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.p8x16 = @bitCast(bytes);
    const expected: types.i64x2 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_s64_p8, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_s64_s16(a: types.i16x8) types.i64x2 {
    return @bitCast(a);
}

test vreinterpretq_s64_s16 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.i16x8 = @bitCast(bytes);
    const expected: types.i64x2 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_s64_s16, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_s64_s32(a: types.i32x4) types.i64x2 {
    return @bitCast(a);
}

test vreinterpretq_s64_s32 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.i32x4 = @bitCast(bytes);
    const expected: types.i64x2 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_s64_s32, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_s64_s8(a: types.i8x16) types.i64x2 {
    return @bitCast(a);
}

test vreinterpretq_s64_s8 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.i8x16 = @bitCast(bytes);
    const expected: types.i64x2 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_s64_s8, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_s64_u16(a: types.u16x8) types.i64x2 {
    return @bitCast(a);
}

test vreinterpretq_s64_u16 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.u16x8 = @bitCast(bytes);
    const expected: types.i64x2 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_s64_u16, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_s64_u32(a: types.u32x4) types.i64x2 {
    return @bitCast(a);
}

test vreinterpretq_s64_u32 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.u32x4 = @bitCast(bytes);
    const expected: types.i64x2 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_s64_u32, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_s64_u64(a: types.u64x2) types.i64x2 {
    return @bitCast(a);
}

test vreinterpretq_s64_u64 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.u64x2 = @bitCast(bytes);
    const expected: types.i64x2 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_s64_u64, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_s64_u8(a: types.u8x16) types.i64x2 {
    return @bitCast(a);
}

test vreinterpretq_s64_u8 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.u8x16 = @bitCast(bytes);
    const expected: types.i64x2 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_s64_u8, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_s8_f16(a: types.f16x8) types.i8x16 {
    return @bitCast(a);
}

test vreinterpretq_s8_f16 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.f16x8 = @bitCast(bytes);
    const expected: types.i8x16 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_s8_f16, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_s8_f32(a: types.f32x4) types.i8x16 {
    return @bitCast(a);
}

test vreinterpretq_s8_f32 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.f32x4 = @bitCast(bytes);
    const expected: types.i8x16 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_s8_f32, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_s8_f64(a: types.f64x2) types.i8x16 {
    return @bitCast(a);
}

test vreinterpretq_s8_f64 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.f64x2 = @bitCast(bytes);
    const expected: types.i8x16 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_s8_f64, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_s8_p128(a: types.p128) types.i8x16 {
    return @bitCast(a);
}

test vreinterpretq_s8_p128 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.p128 = @bitCast(bytes);
    const expected: types.i8x16 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_s8_p128, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_s8_p16(a: types.p16x8) types.i8x16 {
    return @bitCast(a);
}

test vreinterpretq_s8_p16 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.p16x8 = @bitCast(bytes);
    const expected: types.i8x16 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_s8_p16, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_s8_p64(a: types.p64x2) types.i8x16 {
    return @bitCast(a);
}

test vreinterpretq_s8_p64 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.p64x2 = @bitCast(bytes);
    const expected: types.i8x16 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_s8_p64, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_s8_p8(a: types.p8x16) types.i8x16 {
    return @bitCast(a);
}

test vreinterpretq_s8_p8 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.p8x16 = @bitCast(bytes);
    const expected: types.i8x16 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_s8_p8, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_s8_s16(a: types.i16x8) types.i8x16 {
    return @bitCast(a);
}

test vreinterpretq_s8_s16 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.i16x8 = @bitCast(bytes);
    const expected: types.i8x16 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_s8_s16, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_s8_s32(a: types.i32x4) types.i8x16 {
    return @bitCast(a);
}

test vreinterpretq_s8_s32 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.i32x4 = @bitCast(bytes);
    const expected: types.i8x16 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_s8_s32, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_s8_s64(a: types.i64x2) types.i8x16 {
    return @bitCast(a);
}

test vreinterpretq_s8_s64 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.i64x2 = @bitCast(bytes);
    const expected: types.i8x16 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_s8_s64, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_s8_u16(a: types.u16x8) types.i8x16 {
    return @bitCast(a);
}

test vreinterpretq_s8_u16 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.u16x8 = @bitCast(bytes);
    const expected: types.i8x16 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_s8_u16, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_s8_u32(a: types.u32x4) types.i8x16 {
    return @bitCast(a);
}

test vreinterpretq_s8_u32 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.u32x4 = @bitCast(bytes);
    const expected: types.i8x16 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_s8_u32, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_s8_u64(a: types.u64x2) types.i8x16 {
    return @bitCast(a);
}

test vreinterpretq_s8_u64 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.u64x2 = @bitCast(bytes);
    const expected: types.i8x16 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_s8_u64, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_s8_u8(a: types.u8x16) types.i8x16 {
    return @bitCast(a);
}

test vreinterpretq_s8_u8 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.u8x16 = @bitCast(bytes);
    const expected: types.i8x16 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_s8_u8, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_u16_f16(a: types.f16x8) types.u16x8 {
    return @bitCast(a);
}

test vreinterpretq_u16_f16 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.f16x8 = @bitCast(bytes);
    const expected: types.u16x8 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_u16_f16, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_u16_f32(a: types.f32x4) types.u16x8 {
    return @bitCast(a);
}

test vreinterpretq_u16_f32 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.f32x4 = @bitCast(bytes);
    const expected: types.u16x8 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_u16_f32, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_u16_f64(a: types.f64x2) types.u16x8 {
    return @bitCast(a);
}

test vreinterpretq_u16_f64 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.f64x2 = @bitCast(bytes);
    const expected: types.u16x8 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_u16_f64, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_u16_p128(a: types.p128) types.u16x8 {
    return @bitCast(a);
}

test vreinterpretq_u16_p128 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.p128 = @bitCast(bytes);
    const expected: types.u16x8 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_u16_p128, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_u16_p16(a: types.p16x8) types.u16x8 {
    return @bitCast(a);
}

test vreinterpretq_u16_p16 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.p16x8 = @bitCast(bytes);
    const expected: types.u16x8 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_u16_p16, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_u16_p64(a: types.p64x2) types.u16x8 {
    return @bitCast(a);
}

test vreinterpretq_u16_p64 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.p64x2 = @bitCast(bytes);
    const expected: types.u16x8 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_u16_p64, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_u16_p8(a: types.p8x16) types.u16x8 {
    return @bitCast(a);
}

test vreinterpretq_u16_p8 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.p8x16 = @bitCast(bytes);
    const expected: types.u16x8 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_u16_p8, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_u16_s16(a: types.i16x8) types.u16x8 {
    return @bitCast(a);
}

test vreinterpretq_u16_s16 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.i16x8 = @bitCast(bytes);
    const expected: types.u16x8 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_u16_s16, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_u16_s32(a: types.i32x4) types.u16x8 {
    return @bitCast(a);
}

test vreinterpretq_u16_s32 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.i32x4 = @bitCast(bytes);
    const expected: types.u16x8 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_u16_s32, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_u16_s64(a: types.i64x2) types.u16x8 {
    return @bitCast(a);
}

test vreinterpretq_u16_s64 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.i64x2 = @bitCast(bytes);
    const expected: types.u16x8 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_u16_s64, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_u16_s8(a: types.i8x16) types.u16x8 {
    return @bitCast(a);
}

test vreinterpretq_u16_s8 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.i8x16 = @bitCast(bytes);
    const expected: types.u16x8 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_u16_s8, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_u16_u32(a: types.u32x4) types.u16x8 {
    return @bitCast(a);
}

test vreinterpretq_u16_u32 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.u32x4 = @bitCast(bytes);
    const expected: types.u16x8 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_u16_u32, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_u16_u64(a: types.u64x2) types.u16x8 {
    return @bitCast(a);
}

test vreinterpretq_u16_u64 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.u64x2 = @bitCast(bytes);
    const expected: types.u16x8 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_u16_u64, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_u16_u8(a: types.u8x16) types.u16x8 {
    return @bitCast(a);
}

test vreinterpretq_u16_u8 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.u8x16 = @bitCast(bytes);
    const expected: types.u16x8 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_u16_u8, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_u32_f16(a: types.f16x8) types.u32x4 {
    return @bitCast(a);
}

test vreinterpretq_u32_f16 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.f16x8 = @bitCast(bytes);
    const expected: types.u32x4 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_u32_f16, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_u32_f32(a: types.f32x4) types.u32x4 {
    return @bitCast(a);
}

test vreinterpretq_u32_f32 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.f32x4 = @bitCast(bytes);
    const expected: types.u32x4 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_u32_f32, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_u32_f64(a: types.f64x2) types.u32x4 {
    return @bitCast(a);
}

test vreinterpretq_u32_f64 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.f64x2 = @bitCast(bytes);
    const expected: types.u32x4 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_u32_f64, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_u32_p128(a: types.p128) types.u32x4 {
    return @bitCast(a);
}

test vreinterpretq_u32_p128 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.p128 = @bitCast(bytes);
    const expected: types.u32x4 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_u32_p128, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_u32_p16(a: types.p16x8) types.u32x4 {
    return @bitCast(a);
}

test vreinterpretq_u32_p16 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.p16x8 = @bitCast(bytes);
    const expected: types.u32x4 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_u32_p16, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_u32_p64(a: types.p64x2) types.u32x4 {
    return @bitCast(a);
}

test vreinterpretq_u32_p64 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.p64x2 = @bitCast(bytes);
    const expected: types.u32x4 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_u32_p64, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_u32_p8(a: types.p8x16) types.u32x4 {
    return @bitCast(a);
}

test vreinterpretq_u32_p8 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.p8x16 = @bitCast(bytes);
    const expected: types.u32x4 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_u32_p8, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_u32_s16(a: types.i16x8) types.u32x4 {
    return @bitCast(a);
}

test vreinterpretq_u32_s16 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.i16x8 = @bitCast(bytes);
    const expected: types.u32x4 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_u32_s16, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_u32_s32(a: types.i32x4) types.u32x4 {
    return @bitCast(a);
}

test vreinterpretq_u32_s32 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.i32x4 = @bitCast(bytes);
    const expected: types.u32x4 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_u32_s32, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_u32_s64(a: types.i64x2) types.u32x4 {
    return @bitCast(a);
}

test vreinterpretq_u32_s64 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.i64x2 = @bitCast(bytes);
    const expected: types.u32x4 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_u32_s64, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_u32_s8(a: types.i8x16) types.u32x4 {
    return @bitCast(a);
}

test vreinterpretq_u32_s8 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.i8x16 = @bitCast(bytes);
    const expected: types.u32x4 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_u32_s8, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_u32_u16(a: types.u16x8) types.u32x4 {
    return @bitCast(a);
}

test vreinterpretq_u32_u16 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.u16x8 = @bitCast(bytes);
    const expected: types.u32x4 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_u32_u16, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_u32_u64(a: types.u64x2) types.u32x4 {
    return @bitCast(a);
}

test vreinterpretq_u32_u64 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.u64x2 = @bitCast(bytes);
    const expected: types.u32x4 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_u32_u64, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_u32_u8(a: types.u8x16) types.u32x4 {
    return @bitCast(a);
}

test vreinterpretq_u32_u8 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.u8x16 = @bitCast(bytes);
    const expected: types.u32x4 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_u32_u8, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_u64_f16(a: types.f16x8) types.u64x2 {
    return @bitCast(a);
}

test vreinterpretq_u64_f16 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.f16x8 = @bitCast(bytes);
    const expected: types.u64x2 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_u64_f16, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_u64_f32(a: types.f32x4) types.u64x2 {
    return @bitCast(a);
}

test vreinterpretq_u64_f32 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.f32x4 = @bitCast(bytes);
    const expected: types.u64x2 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_u64_f32, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_u64_f64(a: types.f64x2) types.u64x2 {
    return @bitCast(a);
}

test vreinterpretq_u64_f64 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.f64x2 = @bitCast(bytes);
    const expected: types.u64x2 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_u64_f64, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_u64_p128(a: types.p128) types.u64x2 {
    return @bitCast(a);
}

test vreinterpretq_u64_p128 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.p128 = @bitCast(bytes);
    const expected: types.u64x2 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_u64_p128, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_u64_p16(a: types.p16x8) types.u64x2 {
    return @bitCast(a);
}

test vreinterpretq_u64_p16 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.p16x8 = @bitCast(bytes);
    const expected: types.u64x2 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_u64_p16, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_u64_p64(a: types.p64x2) types.u64x2 {
    return @bitCast(a);
}

test vreinterpretq_u64_p64 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.p64x2 = @bitCast(bytes);
    const expected: types.u64x2 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_u64_p64, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_u64_p8(a: types.p8x16) types.u64x2 {
    return @bitCast(a);
}

test vreinterpretq_u64_p8 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.p8x16 = @bitCast(bytes);
    const expected: types.u64x2 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_u64_p8, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_u64_s16(a: types.i16x8) types.u64x2 {
    return @bitCast(a);
}

test vreinterpretq_u64_s16 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.i16x8 = @bitCast(bytes);
    const expected: types.u64x2 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_u64_s16, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_u64_s32(a: types.i32x4) types.u64x2 {
    return @bitCast(a);
}

test vreinterpretq_u64_s32 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.i32x4 = @bitCast(bytes);
    const expected: types.u64x2 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_u64_s32, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_u64_s64(a: types.i64x2) types.u64x2 {
    return @bitCast(a);
}

test vreinterpretq_u64_s64 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.i64x2 = @bitCast(bytes);
    const expected: types.u64x2 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_u64_s64, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_u64_s8(a: types.i8x16) types.u64x2 {
    return @bitCast(a);
}

test vreinterpretq_u64_s8 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.i8x16 = @bitCast(bytes);
    const expected: types.u64x2 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_u64_s8, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_u64_u16(a: types.u16x8) types.u64x2 {
    return @bitCast(a);
}

test vreinterpretq_u64_u16 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.u16x8 = @bitCast(bytes);
    const expected: types.u64x2 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_u64_u16, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_u64_u32(a: types.u32x4) types.u64x2 {
    return @bitCast(a);
}

test vreinterpretq_u64_u32 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.u32x4 = @bitCast(bytes);
    const expected: types.u64x2 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_u64_u32, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_u64_u8(a: types.u8x16) types.u64x2 {
    return @bitCast(a);
}

test vreinterpretq_u64_u8 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.u8x16 = @bitCast(bytes);
    const expected: types.u64x2 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_u64_u8, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_u8_f16(a: types.f16x8) types.u8x16 {
    return @bitCast(a);
}

test vreinterpretq_u8_f16 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.f16x8 = @bitCast(bytes);
    const expected: types.u8x16 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_u8_f16, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_u8_f32(a: types.f32x4) types.u8x16 {
    return @bitCast(a);
}

test vreinterpretq_u8_f32 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.f32x4 = @bitCast(bytes);
    const expected: types.u8x16 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_u8_f32, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_u8_f64(a: types.f64x2) types.u8x16 {
    return @bitCast(a);
}

test vreinterpretq_u8_f64 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.f64x2 = @bitCast(bytes);
    const expected: types.u8x16 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_u8_f64, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_u8_p128(a: types.p128) types.u8x16 {
    return @bitCast(a);
}

test vreinterpretq_u8_p128 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.p128 = @bitCast(bytes);
    const expected: types.u8x16 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_u8_p128, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_u8_p16(a: types.p16x8) types.u8x16 {
    return @bitCast(a);
}

test vreinterpretq_u8_p16 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.p16x8 = @bitCast(bytes);
    const expected: types.u8x16 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_u8_p16, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_u8_p64(a: types.p64x2) types.u8x16 {
    return @bitCast(a);
}

test vreinterpretq_u8_p64 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.p64x2 = @bitCast(bytes);
    const expected: types.u8x16 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_u8_p64, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_u8_p8(a: types.p8x16) types.u8x16 {
    return @bitCast(a);
}

test vreinterpretq_u8_p8 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.p8x16 = @bitCast(bytes);
    const expected: types.u8x16 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_u8_p8, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_u8_s16(a: types.i16x8) types.u8x16 {
    return @bitCast(a);
}

test vreinterpretq_u8_s16 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.i16x8 = @bitCast(bytes);
    const expected: types.u8x16 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_u8_s16, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_u8_s32(a: types.i32x4) types.u8x16 {
    return @bitCast(a);
}

test vreinterpretq_u8_s32 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.i32x4 = @bitCast(bytes);
    const expected: types.u8x16 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_u8_s32, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_u8_s64(a: types.i64x2) types.u8x16 {
    return @bitCast(a);
}

test vreinterpretq_u8_s64 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.i64x2 = @bitCast(bytes);
    const expected: types.u8x16 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_u8_s64, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_u8_s8(a: types.i8x16) types.u8x16 {
    return @bitCast(a);
}

test vreinterpretq_u8_s8 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.i8x16 = @bitCast(bytes);
    const expected: types.u8x16 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_u8_s8, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_u8_u16(a: types.u16x8) types.u8x16 {
    return @bitCast(a);
}

test vreinterpretq_u8_u16 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.u16x8 = @bitCast(bytes);
    const expected: types.u8x16 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_u8_u16, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_u8_u32(a: types.u32x4) types.u8x16 {
    return @bitCast(a);
}

test vreinterpretq_u8_u32 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.u32x4 = @bitCast(bytes);
    const expected: types.u8x16 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_u8_u32, .expected = expected, .args = .{a} });
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_u8_u64(a: types.u64x2) types.u8x16 {
    return @bitCast(a);
}

test vreinterpretq_u8_u64 {
    const bytes = @as(types.u8x16, .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 });
    const a: types.u64x2 = @bitCast(bytes);
    const expected: types.u8x16 = @bitCast(bytes);
    try common.testIntrinsic(.{ .func = vreinterpretq_u8_u64, .expected = expected, .args = .{a} });
}

/// ARM NEON intrinsic: `vreinterpret_bf16_f16`
pub inline fn vreinterpret_bf16_f16(p0: types.f16x4) types.bf16x4 {
    return @bitCast(p0);
}

test vreinterpret_bf16_f16 {
    const p0 = @as(types.f16x4, @splat(1.5));
    const res = vreinterpret_bf16_f16(p0);
    const expected: @TypeOf(res) = @bitCast(p0);
    try std.testing.expectEqual(expected, res);
}

/// ARM NEON intrinsic: `vreinterpret_bf16_f32`
pub inline fn vreinterpret_bf16_f32(p0: types.f32x2) types.bf16x4 {
    return @bitCast(p0);
}

test vreinterpret_bf16_f32 {
    const p0 = @as(types.f32x2, @splat(1.5));
    const res = vreinterpret_bf16_f32(p0);
    const expected: @TypeOf(res) = @bitCast(p0);
    try std.testing.expectEqual(expected, res);
}

/// ARM NEON intrinsic: `vreinterpret_bf16_f64`
pub inline fn vreinterpret_bf16_f64(p0: types.f64x1) types.bf16x4 {
    return @bitCast(p0);
}

test vreinterpret_bf16_f64 {
    const p0 = @as(types.f64x1, @splat(1.5));
    const res = vreinterpret_bf16_f64(p0);
    const expected: @TypeOf(res) = @bitCast(p0);
    try std.testing.expectEqual(expected, res);
}

/// ARM NEON intrinsic: `vreinterpret_bf16_p16`
pub inline fn vreinterpret_bf16_p16(p0: types.p16x4) types.bf16x4 {
    return @bitCast(p0);
}

test vreinterpret_bf16_p16 {
    const p0 = @as(types.p16x4, @splat(2));
    const res = vreinterpret_bf16_p16(p0);
    const expected: @TypeOf(res) = @bitCast(p0);
    try std.testing.expectEqual(expected, res);
}

/// ARM NEON intrinsic: `vreinterpret_bf16_p64`
pub inline fn vreinterpret_bf16_p64(p0: types.p64x1) types.bf16x4 {
    return @bitCast(p0);
}

test vreinterpret_bf16_p64 {
    const p0 = @as(types.p64x1, @splat(2));
    const res = vreinterpret_bf16_p64(p0);
    const expected: @TypeOf(res) = @bitCast(p0);
    try std.testing.expectEqual(expected, res);
}

/// ARM NEON intrinsic: `vreinterpret_bf16_p8`
pub inline fn vreinterpret_bf16_p8(p0: types.p8x8) types.bf16x4 {
    return @bitCast(p0);
}

test vreinterpret_bf16_p8 {
    const p0 = @as(types.p8x8, @splat(2));
    const res = vreinterpret_bf16_p8(p0);
    const expected: @TypeOf(res) = @bitCast(p0);
    try std.testing.expectEqual(expected, res);
}

/// ARM NEON intrinsic: `vreinterpret_bf16_s16`
pub inline fn vreinterpret_bf16_s16(p0: types.i16x4) types.bf16x4 {
    return @bitCast(p0);
}

test vreinterpret_bf16_s16 {
    const p0 = @as(types.i16x4, @splat(2));
    const res = vreinterpret_bf16_s16(p0);
    const expected: @TypeOf(res) = @bitCast(p0);
    try std.testing.expectEqual(expected, res);
}

/// ARM NEON intrinsic: `vreinterpret_bf16_s32`
pub inline fn vreinterpret_bf16_s32(p0: types.i32x2) types.bf16x4 {
    return @bitCast(p0);
}

test vreinterpret_bf16_s32 {
    const p0 = @as(types.i32x2, @splat(2));
    const res = vreinterpret_bf16_s32(p0);
    const expected: @TypeOf(res) = @bitCast(p0);
    try std.testing.expectEqual(expected, res);
}

/// ARM NEON intrinsic: `vreinterpret_bf16_s64`
pub inline fn vreinterpret_bf16_s64(p0: types.i64x1) types.bf16x4 {
    return @bitCast(p0);
}

test vreinterpret_bf16_s64 {
    const p0 = @as(types.i64x1, @splat(2));
    const res = vreinterpret_bf16_s64(p0);
    const expected: @TypeOf(res) = @bitCast(p0);
    try std.testing.expectEqual(expected, res);
}

/// ARM NEON intrinsic: `vreinterpret_bf16_s8`
pub inline fn vreinterpret_bf16_s8(p0: types.i8x8) types.bf16x4 {
    return @bitCast(p0);
}

test vreinterpret_bf16_s8 {
    const p0 = @as(types.i8x8, @splat(2));
    const res = vreinterpret_bf16_s8(p0);
    const expected: @TypeOf(res) = @bitCast(p0);
    try std.testing.expectEqual(expected, res);
}

/// ARM NEON intrinsic: `vreinterpret_bf16_u16`
pub inline fn vreinterpret_bf16_u16(p0: types.u16x4) types.bf16x4 {
    return @bitCast(p0);
}

test vreinterpret_bf16_u16 {
    const p0 = @as(types.u16x4, @splat(2));
    const res = vreinterpret_bf16_u16(p0);
    const expected: @TypeOf(res) = @bitCast(p0);
    try std.testing.expectEqual(expected, res);
}

/// ARM NEON intrinsic: `vreinterpret_bf16_u32`
pub inline fn vreinterpret_bf16_u32(p0: types.u32x2) types.bf16x4 {
    return @bitCast(p0);
}

test vreinterpret_bf16_u32 {
    const p0 = @as(types.u32x2, @splat(2));
    const res = vreinterpret_bf16_u32(p0);
    const expected: @TypeOf(res) = @bitCast(p0);
    try std.testing.expectEqual(expected, res);
}

/// ARM NEON intrinsic: `vreinterpret_bf16_u64`
pub inline fn vreinterpret_bf16_u64(p0: types.u64x1) types.bf16x4 {
    return @bitCast(p0);
}

test vreinterpret_bf16_u64 {
    const p0 = @as(types.u64x1, @splat(2));
    const res = vreinterpret_bf16_u64(p0);
    const expected: @TypeOf(res) = @bitCast(p0);
    try std.testing.expectEqual(expected, res);
}

/// ARM NEON intrinsic: `vreinterpret_bf16_u8`
pub inline fn vreinterpret_bf16_u8(p0: types.u8x8) types.bf16x4 {
    return @bitCast(p0);
}

test vreinterpret_bf16_u8 {
    const p0 = @as(types.u8x8, @splat(2));
    const res = vreinterpret_bf16_u8(p0);
    const expected: @TypeOf(res) = @bitCast(p0);
    try std.testing.expectEqual(expected, res);
}

/// ARM NEON intrinsic: `vreinterpret_f16_bf16`
pub inline fn vreinterpret_f16_bf16(p0: types.bf16x4) types.f16x4 {
    return @bitCast(p0);
}

test vreinterpret_f16_bf16 {
    const p0 = @as(types.bf16x4, @splat(0x3F80));
    const res = vreinterpret_f16_bf16(p0);
    const expected: @TypeOf(res) = @bitCast(p0);
    try std.testing.expectEqual(expected, res);
}

/// ARM NEON intrinsic: `vreinterpret_f16_mf8`
pub inline fn vreinterpret_f16_mf8(p0: types.mf8x8) types.f16x4 {
    return @bitCast(p0);
}

test vreinterpret_f16_mf8 {
    const p0 = @as(types.mf8x8, @splat(2));
    const res = vreinterpret_f16_mf8(p0);
    const expected: @TypeOf(res) = @bitCast(p0);
    try std.testing.expectEqual(expected, res);
}

/// ARM NEON intrinsic: `vreinterpret_f32_bf16`
pub inline fn vreinterpret_f32_bf16(p0: types.bf16x4) types.f32x2 {
    return @bitCast(p0);
}

test vreinterpret_f32_bf16 {
    const p0 = @as(types.bf16x4, @splat(0x3F80));
    const res = vreinterpret_f32_bf16(p0);
    const expected: @TypeOf(res) = @bitCast(p0);
    try std.testing.expectEqual(expected, res);
}

/// ARM NEON intrinsic: `vreinterpret_f32_mf8`
pub inline fn vreinterpret_f32_mf8(p0: types.mf8x8) types.f32x2 {
    return @bitCast(p0);
}

test vreinterpret_f32_mf8 {
    const p0 = @as(types.mf8x8, @splat(2));
    const res = vreinterpret_f32_mf8(p0);
    const expected: @TypeOf(res) = @bitCast(p0);
    try std.testing.expectEqual(expected, res);
}

/// ARM NEON intrinsic: `vreinterpret_f64_bf16`
pub inline fn vreinterpret_f64_bf16(p0: types.bf16x4) types.f64x1 {
    return @bitCast(p0);
}

test vreinterpret_f64_bf16 {
    const p0 = @as(types.bf16x4, @splat(0x3F80));
    const res = vreinterpret_f64_bf16(p0);
    const expected: @TypeOf(res) = @bitCast(p0);
    try std.testing.expectEqual(expected, res);
}

/// ARM NEON intrinsic: `vreinterpret_f64_mf8`
pub inline fn vreinterpret_f64_mf8(p0: types.mf8x8) types.f64x1 {
    return @bitCast(p0);
}

test vreinterpret_f64_mf8 {
    const p0 = @as(types.mf8x8, @splat(2));
    const res = vreinterpret_f64_mf8(p0);
    const expected: @TypeOf(res) = @bitCast(p0);
    try std.testing.expectEqual(expected, res);
}

/// ARM NEON intrinsic: `vreinterpret_mf8_f16`
pub inline fn vreinterpret_mf8_f16(p0: types.f16x4) types.mf8x8 {
    return @bitCast(p0);
}

test vreinterpret_mf8_f16 {
    const p0 = @as(types.f16x4, @splat(1.5));
    const res = vreinterpret_mf8_f16(p0);
    const expected: @TypeOf(res) = @bitCast(p0);
    try std.testing.expectEqual(expected, res);
}

/// ARM NEON intrinsic: `vreinterpret_mf8_f32`
pub inline fn vreinterpret_mf8_f32(p0: types.f32x2) types.mf8x8 {
    return @bitCast(p0);
}

test vreinterpret_mf8_f32 {
    const p0 = @as(types.f32x2, @splat(1.5));
    const res = vreinterpret_mf8_f32(p0);
    const expected: @TypeOf(res) = @bitCast(p0);
    try std.testing.expectEqual(expected, res);
}

/// ARM NEON intrinsic: `vreinterpret_mf8_f64`
pub inline fn vreinterpret_mf8_f64(p0: types.f64x1) types.mf8x8 {
    return @bitCast(p0);
}

test vreinterpret_mf8_f64 {
    const p0 = @as(types.f64x1, @splat(1.5));
    const res = vreinterpret_mf8_f64(p0);
    const expected: @TypeOf(res) = @bitCast(p0);
    try std.testing.expectEqual(expected, res);
}

/// ARM NEON intrinsic: `vreinterpret_mf8_p16`
pub inline fn vreinterpret_mf8_p16(p0: types.p16x4) types.mf8x8 {
    return @bitCast(p0);
}

test vreinterpret_mf8_p16 {
    const p0 = @as(types.p16x4, @splat(2));
    const res = vreinterpret_mf8_p16(p0);
    const expected: @TypeOf(res) = @bitCast(p0);
    try std.testing.expectEqual(expected, res);
}

/// ARM NEON intrinsic: `vreinterpret_mf8_p64`
pub inline fn vreinterpret_mf8_p64(p0: types.p64x1) types.mf8x8 {
    return @bitCast(p0);
}

test vreinterpret_mf8_p64 {
    const p0 = @as(types.p64x1, @splat(2));
    const res = vreinterpret_mf8_p64(p0);
    const expected: @TypeOf(res) = @bitCast(p0);
    try std.testing.expectEqual(expected, res);
}

/// ARM NEON intrinsic: `vreinterpret_mf8_p8`
pub inline fn vreinterpret_mf8_p8(p0: types.p8x8) types.mf8x8 {
    return @bitCast(p0);
}

test vreinterpret_mf8_p8 {
    const p0 = @as(types.p8x8, @splat(2));
    const res = vreinterpret_mf8_p8(p0);
    const expected: @TypeOf(res) = @bitCast(p0);
    try std.testing.expectEqual(expected, res);
}

/// ARM NEON intrinsic: `vreinterpret_mf8_s16`
pub inline fn vreinterpret_mf8_s16(p0: types.i16x4) types.mf8x8 {
    return @bitCast(p0);
}

test vreinterpret_mf8_s16 {
    const p0 = @as(types.i16x4, @splat(2));
    const res = vreinterpret_mf8_s16(p0);
    const expected: @TypeOf(res) = @bitCast(p0);
    try std.testing.expectEqual(expected, res);
}

/// ARM NEON intrinsic: `vreinterpret_mf8_s32`
pub inline fn vreinterpret_mf8_s32(p0: types.i32x2) types.mf8x8 {
    return @bitCast(p0);
}

test vreinterpret_mf8_s32 {
    const p0 = @as(types.i32x2, @splat(2));
    const res = vreinterpret_mf8_s32(p0);
    const expected: @TypeOf(res) = @bitCast(p0);
    try std.testing.expectEqual(expected, res);
}

/// ARM NEON intrinsic: `vreinterpret_mf8_s64`
pub inline fn vreinterpret_mf8_s64(p0: types.i64x1) types.mf8x8 {
    return @bitCast(p0);
}

test vreinterpret_mf8_s64 {
    const p0 = @as(types.i64x1, @splat(2));
    const res = vreinterpret_mf8_s64(p0);
    const expected: @TypeOf(res) = @bitCast(p0);
    try std.testing.expectEqual(expected, res);
}

/// ARM NEON intrinsic: `vreinterpret_mf8_s8`
pub inline fn vreinterpret_mf8_s8(p0: types.i8x8) types.mf8x8 {
    return @bitCast(p0);
}

test vreinterpret_mf8_s8 {
    const p0 = @as(types.i8x8, @splat(2));
    const res = vreinterpret_mf8_s8(p0);
    const expected: @TypeOf(res) = @bitCast(p0);
    try std.testing.expectEqual(expected, res);
}

/// ARM NEON intrinsic: `vreinterpret_mf8_u16`
pub inline fn vreinterpret_mf8_u16(p0: types.u16x4) types.mf8x8 {
    return @bitCast(p0);
}

test vreinterpret_mf8_u16 {
    const p0 = @as(types.u16x4, @splat(2));
    const res = vreinterpret_mf8_u16(p0);
    const expected: @TypeOf(res) = @bitCast(p0);
    try std.testing.expectEqual(expected, res);
}

/// ARM NEON intrinsic: `vreinterpret_mf8_u32`
pub inline fn vreinterpret_mf8_u32(p0: types.u32x2) types.mf8x8 {
    return @bitCast(p0);
}

test vreinterpret_mf8_u32 {
    const p0 = @as(types.u32x2, @splat(2));
    const res = vreinterpret_mf8_u32(p0);
    const expected: @TypeOf(res) = @bitCast(p0);
    try std.testing.expectEqual(expected, res);
}

/// ARM NEON intrinsic: `vreinterpret_mf8_u64`
pub inline fn vreinterpret_mf8_u64(p0: types.u64x1) types.mf8x8 {
    return @bitCast(p0);
}

test vreinterpret_mf8_u64 {
    const p0 = @as(types.u64x1, @splat(2));
    const res = vreinterpret_mf8_u64(p0);
    const expected: @TypeOf(res) = @bitCast(p0);
    try std.testing.expectEqual(expected, res);
}

/// ARM NEON intrinsic: `vreinterpret_mf8_u8`
pub inline fn vreinterpret_mf8_u8(p0: types.u8x8) types.mf8x8 {
    return @bitCast(p0);
}

test vreinterpret_mf8_u8 {
    const p0 = @as(types.u8x8, @splat(2));
    const res = vreinterpret_mf8_u8(p0);
    const expected: @TypeOf(res) = @bitCast(p0);
    try std.testing.expectEqual(expected, res);
}

/// ARM NEON intrinsic: `vreinterpret_p16_bf16`
pub inline fn vreinterpret_p16_bf16(p0: types.bf16x4) types.p16x4 {
    return @bitCast(p0);
}

test vreinterpret_p16_bf16 {
    const p0 = @as(types.bf16x4, @splat(0x3F80));
    const res = vreinterpret_p16_bf16(p0);
    const expected: @TypeOf(res) = @bitCast(p0);
    try std.testing.expectEqual(expected, res);
}

/// ARM NEON intrinsic: `vreinterpret_p16_mf8`
pub inline fn vreinterpret_p16_mf8(p0: types.mf8x8) types.p16x4 {
    return @bitCast(p0);
}

test vreinterpret_p16_mf8 {
    const p0 = @as(types.mf8x8, @splat(2));
    const res = vreinterpret_p16_mf8(p0);
    const expected: @TypeOf(res) = @bitCast(p0);
    try std.testing.expectEqual(expected, res);
}

/// ARM NEON intrinsic: `vreinterpret_p64_bf16`
pub inline fn vreinterpret_p64_bf16(p0: types.bf16x4) types.p64x1 {
    return @bitCast(p0);
}

test vreinterpret_p64_bf16 {
    const p0 = @as(types.bf16x4, @splat(0x3F80));
    const res = vreinterpret_p64_bf16(p0);
    const expected: @TypeOf(res) = @bitCast(p0);
    try std.testing.expectEqual(expected, res);
}

/// ARM NEON intrinsic: `vreinterpret_p64_mf8`
pub inline fn vreinterpret_p64_mf8(p0: types.mf8x8) types.p64x1 {
    return @bitCast(p0);
}

test vreinterpret_p64_mf8 {
    const p0 = @as(types.mf8x8, @splat(2));
    const res = vreinterpret_p64_mf8(p0);
    const expected: @TypeOf(res) = @bitCast(p0);
    try std.testing.expectEqual(expected, res);
}

/// ARM NEON intrinsic: `vreinterpret_p8_bf16`
pub inline fn vreinterpret_p8_bf16(p0: types.bf16x4) types.p8x8 {
    return @bitCast(p0);
}

test vreinterpret_p8_bf16 {
    const p0 = @as(types.bf16x4, @splat(0x3F80));
    const res = vreinterpret_p8_bf16(p0);
    const expected: @TypeOf(res) = @bitCast(p0);
    try std.testing.expectEqual(expected, res);
}

/// ARM NEON intrinsic: `vreinterpret_p8_mf8`
pub inline fn vreinterpret_p8_mf8(p0: types.mf8x8) types.p8x8 {
    return @bitCast(p0);
}

test vreinterpret_p8_mf8 {
    const p0 = @as(types.mf8x8, @splat(2));
    const res = vreinterpret_p8_mf8(p0);
    const expected: @TypeOf(res) = @bitCast(p0);
    try std.testing.expectEqual(expected, res);
}

/// ARM NEON intrinsic: `vreinterpret_s16_bf16`
pub inline fn vreinterpret_s16_bf16(p0: types.bf16x4) types.i16x4 {
    return @bitCast(p0);
}

test vreinterpret_s16_bf16 {
    const p0 = @as(types.bf16x4, @splat(0x3F80));
    const res = vreinterpret_s16_bf16(p0);
    const expected: @TypeOf(res) = @bitCast(p0);
    try std.testing.expectEqual(expected, res);
}

/// ARM NEON intrinsic: `vreinterpret_s16_mf8`
pub inline fn vreinterpret_s16_mf8(p0: types.mf8x8) types.i16x4 {
    return @bitCast(p0);
}

test vreinterpret_s16_mf8 {
    const p0 = @as(types.mf8x8, @splat(2));
    const res = vreinterpret_s16_mf8(p0);
    const expected: @TypeOf(res) = @bitCast(p0);
    try std.testing.expectEqual(expected, res);
}

/// ARM NEON intrinsic: `vreinterpret_s32_bf16`
pub inline fn vreinterpret_s32_bf16(p0: types.bf16x4) types.i32x2 {
    return @bitCast(p0);
}

test vreinterpret_s32_bf16 {
    const p0 = @as(types.bf16x4, @splat(0x3F80));
    const res = vreinterpret_s32_bf16(p0);
    const expected: @TypeOf(res) = @bitCast(p0);
    try std.testing.expectEqual(expected, res);
}

/// ARM NEON intrinsic: `vreinterpret_s32_mf8`
pub inline fn vreinterpret_s32_mf8(p0: types.mf8x8) types.i32x2 {
    return @bitCast(p0);
}

test vreinterpret_s32_mf8 {
    const p0 = @as(types.mf8x8, @splat(2));
    const res = vreinterpret_s32_mf8(p0);
    const expected: @TypeOf(res) = @bitCast(p0);
    try std.testing.expectEqual(expected, res);
}

/// ARM NEON intrinsic: `vreinterpret_s64_bf16`
pub inline fn vreinterpret_s64_bf16(p0: types.bf16x4) types.i64x1 {
    return @bitCast(p0);
}

test vreinterpret_s64_bf16 {
    const p0 = @as(types.bf16x4, @splat(0x3F80));
    const res = vreinterpret_s64_bf16(p0);
    const expected: @TypeOf(res) = @bitCast(p0);
    try std.testing.expectEqual(expected, res);
}

/// ARM NEON intrinsic: `vreinterpret_s64_mf8`
pub inline fn vreinterpret_s64_mf8(p0: types.mf8x8) types.i64x1 {
    return @bitCast(p0);
}

test vreinterpret_s64_mf8 {
    const p0 = @as(types.mf8x8, @splat(2));
    const res = vreinterpret_s64_mf8(p0);
    const expected: @TypeOf(res) = @bitCast(p0);
    try std.testing.expectEqual(expected, res);
}

/// ARM NEON intrinsic: `vreinterpret_s8_bf16`
pub inline fn vreinterpret_s8_bf16(p0: types.bf16x4) types.i8x8 {
    return @bitCast(p0);
}

test vreinterpret_s8_bf16 {
    const p0 = @as(types.bf16x4, @splat(0x3F80));
    const res = vreinterpret_s8_bf16(p0);
    const expected: @TypeOf(res) = @bitCast(p0);
    try std.testing.expectEqual(expected, res);
}

/// ARM NEON intrinsic: `vreinterpret_s8_mf8`
pub inline fn vreinterpret_s8_mf8(p0: types.mf8x8) types.i8x8 {
    return @bitCast(p0);
}

test vreinterpret_s8_mf8 {
    const p0 = @as(types.mf8x8, @splat(2));
    const res = vreinterpret_s8_mf8(p0);
    const expected: @TypeOf(res) = @bitCast(p0);
    try std.testing.expectEqual(expected, res);
}

/// ARM NEON intrinsic: `vreinterpret_u16_bf16`
pub inline fn vreinterpret_u16_bf16(p0: types.bf16x4) types.u16x4 {
    return @bitCast(p0);
}

test vreinterpret_u16_bf16 {
    const p0 = @as(types.bf16x4, @splat(0x3F80));
    const res = vreinterpret_u16_bf16(p0);
    const expected: @TypeOf(res) = @bitCast(p0);
    try std.testing.expectEqual(expected, res);
}

/// ARM NEON intrinsic: `vreinterpret_u16_mf8`
pub inline fn vreinterpret_u16_mf8(p0: types.mf8x8) types.u16x4 {
    return @bitCast(p0);
}

test vreinterpret_u16_mf8 {
    const p0 = @as(types.mf8x8, @splat(2));
    const res = vreinterpret_u16_mf8(p0);
    const expected: @TypeOf(res) = @bitCast(p0);
    try std.testing.expectEqual(expected, res);
}

/// ARM NEON intrinsic: `vreinterpret_u32_bf16`
pub inline fn vreinterpret_u32_bf16(p0: types.bf16x4) types.u32x2 {
    return @bitCast(p0);
}

test vreinterpret_u32_bf16 {
    const p0 = @as(types.bf16x4, @splat(0x3F80));
    const res = vreinterpret_u32_bf16(p0);
    const expected: @TypeOf(res) = @bitCast(p0);
    try std.testing.expectEqual(expected, res);
}

/// ARM NEON intrinsic: `vreinterpret_u32_mf8`
pub inline fn vreinterpret_u32_mf8(p0: types.mf8x8) types.u32x2 {
    return @bitCast(p0);
}

test vreinterpret_u32_mf8 {
    const p0 = @as(types.mf8x8, @splat(2));
    const res = vreinterpret_u32_mf8(p0);
    const expected: @TypeOf(res) = @bitCast(p0);
    try std.testing.expectEqual(expected, res);
}

/// ARM NEON intrinsic: `vreinterpret_u64_bf16`
pub inline fn vreinterpret_u64_bf16(p0: types.bf16x4) types.u64x1 {
    return @bitCast(p0);
}

test vreinterpret_u64_bf16 {
    const p0 = @as(types.bf16x4, @splat(0x3F80));
    const res = vreinterpret_u64_bf16(p0);
    const expected: @TypeOf(res) = @bitCast(p0);
    try std.testing.expectEqual(expected, res);
}

/// ARM NEON intrinsic: `vreinterpret_u64_mf8`
pub inline fn vreinterpret_u64_mf8(p0: types.mf8x8) types.u64x1 {
    return @bitCast(p0);
}

test vreinterpret_u64_mf8 {
    const p0 = @as(types.mf8x8, @splat(2));
    const res = vreinterpret_u64_mf8(p0);
    const expected: @TypeOf(res) = @bitCast(p0);
    try std.testing.expectEqual(expected, res);
}

/// ARM NEON intrinsic: `vreinterpret_u8_bf16`
pub inline fn vreinterpret_u8_bf16(p0: types.bf16x4) types.u8x8 {
    return @bitCast(p0);
}

test vreinterpret_u8_bf16 {
    const p0 = @as(types.bf16x4, @splat(0x3F80));
    const res = vreinterpret_u8_bf16(p0);
    const expected: @TypeOf(res) = @bitCast(p0);
    try std.testing.expectEqual(expected, res);
}

/// ARM NEON intrinsic: `vreinterpret_u8_mf8`
pub inline fn vreinterpret_u8_mf8(p0: types.mf8x8) types.u8x8 {
    return @bitCast(p0);
}

test vreinterpret_u8_mf8 {
    const p0 = @as(types.mf8x8, @splat(2));
    const res = vreinterpret_u8_mf8(p0);
    const expected: @TypeOf(res) = @bitCast(p0);
    try std.testing.expectEqual(expected, res);
}

/// ARM NEON intrinsic: `vreinterpretq_bf16_f16`
pub inline fn vreinterpretq_bf16_f16(p0: types.f16x8) types.bf16x8 {
    return @bitCast(p0);
}

test vreinterpretq_bf16_f16 {
    const p0 = @as(types.f16x8, @splat(1.5));
    const res = vreinterpretq_bf16_f16(p0);
    const expected: @TypeOf(res) = @bitCast(p0);
    try std.testing.expectEqual(expected, res);
}

/// ARM NEON intrinsic: `vreinterpretq_bf16_f32`
pub inline fn vreinterpretq_bf16_f32(p0: types.f32x4) types.bf16x8 {
    return @bitCast(p0);
}

test vreinterpretq_bf16_f32 {
    const p0 = @as(types.f32x4, @splat(1.5));
    const res = vreinterpretq_bf16_f32(p0);
    const expected: @TypeOf(res) = @bitCast(p0);
    try std.testing.expectEqual(expected, res);
}

/// ARM NEON intrinsic: `vreinterpretq_bf16_f64`
pub inline fn vreinterpretq_bf16_f64(p0: types.f64x2) types.bf16x8 {
    return @bitCast(p0);
}

test vreinterpretq_bf16_f64 {
    const p0 = @as(types.f64x2, @splat(1.5));
    const res = vreinterpretq_bf16_f64(p0);
    const expected: @TypeOf(res) = @bitCast(p0);
    try std.testing.expectEqual(expected, res);
}

/// ARM NEON intrinsic: `vreinterpretq_bf16_p128`
pub inline fn vreinterpretq_bf16_p128(p0: u128) types.bf16x8 {
    return @bitCast(p0);
}

test vreinterpretq_bf16_p128 {
    const p0 = @as(u128, 2);
    const expected: types.bf16x8 = @bitCast(p0);
    try common.testIntrinsic(.{ .func = vreinterpretq_bf16_p128, .expected = expected, .args = .{p0} });
}

/// ARM NEON intrinsic: `vreinterpretq_bf16_p16`
pub inline fn vreinterpretq_bf16_p16(p0: types.p16x8) types.bf16x8 {
    return @bitCast(p0);
}

test vreinterpretq_bf16_p16 {
    const p0 = @as(types.p16x8, @splat(2));
    const res = vreinterpretq_bf16_p16(p0);
    const expected: @TypeOf(res) = @bitCast(p0);
    try std.testing.expectEqual(expected, res);
}

/// ARM NEON intrinsic: `vreinterpretq_bf16_p64`
pub inline fn vreinterpretq_bf16_p64(p0: types.p64x2) types.bf16x8 {
    return @bitCast(p0);
}

test vreinterpretq_bf16_p64 {
    const p0 = @as(types.p64x2, @splat(2));
    const res = vreinterpretq_bf16_p64(p0);
    const expected: @TypeOf(res) = @bitCast(p0);
    try std.testing.expectEqual(expected, res);
}

/// ARM NEON intrinsic: `vreinterpretq_bf16_p8`
pub inline fn vreinterpretq_bf16_p8(p0: types.p8x16) types.bf16x8 {
    return @bitCast(p0);
}

test vreinterpretq_bf16_p8 {
    const p0 = @as(types.p8x16, @splat(2));
    const res = vreinterpretq_bf16_p8(p0);
    const expected: @TypeOf(res) = @bitCast(p0);
    try std.testing.expectEqual(expected, res);
}

/// ARM NEON intrinsic: `vreinterpretq_bf16_s16`
pub inline fn vreinterpretq_bf16_s16(p0: types.i16x8) types.bf16x8 {
    return @bitCast(p0);
}

test vreinterpretq_bf16_s16 {
    const p0 = @as(types.i16x8, @splat(2));
    const res = vreinterpretq_bf16_s16(p0);
    const expected: @TypeOf(res) = @bitCast(p0);
    try std.testing.expectEqual(expected, res);
}

/// ARM NEON intrinsic: `vreinterpretq_bf16_s32`
pub inline fn vreinterpretq_bf16_s32(p0: types.i32x4) types.bf16x8 {
    return @bitCast(p0);
}

test vreinterpretq_bf16_s32 {
    const p0 = @as(types.i32x4, @splat(2));
    const res = vreinterpretq_bf16_s32(p0);
    const expected: @TypeOf(res) = @bitCast(p0);
    try std.testing.expectEqual(expected, res);
}

/// ARM NEON intrinsic: `vreinterpretq_bf16_s64`
pub inline fn vreinterpretq_bf16_s64(p0: types.i64x2) types.bf16x8 {
    return @bitCast(p0);
}

test vreinterpretq_bf16_s64 {
    const p0 = @as(types.i64x2, @splat(2));
    const res = vreinterpretq_bf16_s64(p0);
    const expected: @TypeOf(res) = @bitCast(p0);
    try std.testing.expectEqual(expected, res);
}

/// ARM NEON intrinsic: `vreinterpretq_bf16_s8`
pub inline fn vreinterpretq_bf16_s8(p0: types.i8x16) types.bf16x8 {
    return @bitCast(p0);
}

test vreinterpretq_bf16_s8 {
    const p0 = @as(types.i8x16, @splat(2));
    const res = vreinterpretq_bf16_s8(p0);
    const expected: @TypeOf(res) = @bitCast(p0);
    try std.testing.expectEqual(expected, res);
}

/// ARM NEON intrinsic: `vreinterpretq_bf16_u16`
pub inline fn vreinterpretq_bf16_u16(p0: types.u16x8) types.bf16x8 {
    return @bitCast(p0);
}

test vreinterpretq_bf16_u16 {
    const p0 = @as(types.u16x8, @splat(2));
    const res = vreinterpretq_bf16_u16(p0);
    const expected: @TypeOf(res) = @bitCast(p0);
    try std.testing.expectEqual(expected, res);
}

/// ARM NEON intrinsic: `vreinterpretq_bf16_u32`
pub inline fn vreinterpretq_bf16_u32(p0: types.u32x4) types.bf16x8 {
    return @bitCast(p0);
}

test vreinterpretq_bf16_u32 {
    const p0 = @as(types.u32x4, @splat(2));
    const res = vreinterpretq_bf16_u32(p0);
    const expected: @TypeOf(res) = @bitCast(p0);
    try std.testing.expectEqual(expected, res);
}

/// ARM NEON intrinsic: `vreinterpretq_bf16_u64`
pub inline fn vreinterpretq_bf16_u64(p0: types.u64x2) types.bf16x8 {
    return @bitCast(p0);
}

test vreinterpretq_bf16_u64 {
    const p0 = @as(types.u64x2, @splat(2));
    const res = vreinterpretq_bf16_u64(p0);
    const expected: @TypeOf(res) = @bitCast(p0);
    try std.testing.expectEqual(expected, res);
}

/// ARM NEON intrinsic: `vreinterpretq_bf16_u8`
pub inline fn vreinterpretq_bf16_u8(p0: types.u8x16) types.bf16x8 {
    return @bitCast(p0);
}

test vreinterpretq_bf16_u8 {
    const p0 = @as(types.u8x16, @splat(2));
    const res = vreinterpretq_bf16_u8(p0);
    const expected: @TypeOf(res) = @bitCast(p0);
    try std.testing.expectEqual(expected, res);
}

/// ARM NEON intrinsic: `vreinterpretq_f16_bf16`
pub inline fn vreinterpretq_f16_bf16(p0: types.bf16x8) types.f16x8 {
    return @bitCast(p0);
}

test vreinterpretq_f16_bf16 {
    const p0 = @as(types.bf16x8, @splat(0x3F80));
    const res = vreinterpretq_f16_bf16(p0);
    const expected: @TypeOf(res) = @bitCast(p0);
    try std.testing.expectEqual(expected, res);
}

/// ARM NEON intrinsic: `vreinterpretq_f16_mf8`
pub inline fn vreinterpretq_f16_mf8(p0: types.mf8x16) types.f16x8 {
    return @bitCast(p0);
}

test vreinterpretq_f16_mf8 {
    const p0 = @as(types.mf8x16, @splat(2));
    const res = vreinterpretq_f16_mf8(p0);
    const expected: @TypeOf(res) = @bitCast(p0);
    try std.testing.expectEqual(expected, res);
}

/// ARM NEON intrinsic: `vreinterpretq_f32_bf16`
pub inline fn vreinterpretq_f32_bf16(p0: types.bf16x8) types.f32x4 {
    return @bitCast(p0);
}

test vreinterpretq_f32_bf16 {
    const p0 = @as(types.bf16x8, @splat(0x3F80));
    const res = vreinterpretq_f32_bf16(p0);
    const expected: @TypeOf(res) = @bitCast(p0);
    try std.testing.expectEqual(expected, res);
}

/// ARM NEON intrinsic: `vreinterpretq_f32_mf8`
pub inline fn vreinterpretq_f32_mf8(p0: types.mf8x16) types.f32x4 {
    return @bitCast(p0);
}

test vreinterpretq_f32_mf8 {
    const p0 = @as(types.mf8x16, @splat(2));
    const res = vreinterpretq_f32_mf8(p0);
    const expected: @TypeOf(res) = @bitCast(p0);
    try std.testing.expectEqual(expected, res);
}

/// ARM NEON intrinsic: `vreinterpretq_f64_bf16`
pub inline fn vreinterpretq_f64_bf16(p0: types.bf16x8) types.f64x2 {
    return @bitCast(p0);
}

test vreinterpretq_f64_bf16 {
    const p0 = @as(types.bf16x8, @splat(0x3F80));
    const res = vreinterpretq_f64_bf16(p0);
    const expected: @TypeOf(res) = @bitCast(p0);
    try std.testing.expectEqual(expected, res);
}

/// ARM NEON intrinsic: `vreinterpretq_f64_mf8`
pub inline fn vreinterpretq_f64_mf8(p0: types.mf8x16) types.f64x2 {
    return @bitCast(p0);
}

test vreinterpretq_f64_mf8 {
    const p0 = @as(types.mf8x16, @splat(2));
    const res = vreinterpretq_f64_mf8(p0);
    const expected: @TypeOf(res) = @bitCast(p0);
    try std.testing.expectEqual(expected, res);
}

/// ARM NEON intrinsic: `vreinterpretq_mf8_f16`
pub inline fn vreinterpretq_mf8_f16(p0: types.f16x8) types.mf8x16 {
    return @bitCast(p0);
}

test vreinterpretq_mf8_f16 {
    const p0 = @as(types.f16x8, @splat(1.5));
    const res = vreinterpretq_mf8_f16(p0);
    const expected: @TypeOf(res) = @bitCast(p0);
    try std.testing.expectEqual(expected, res);
}

/// ARM NEON intrinsic: `vreinterpretq_mf8_f32`
pub inline fn vreinterpretq_mf8_f32(p0: types.f32x4) types.mf8x16 {
    return @bitCast(p0);
}

test vreinterpretq_mf8_f32 {
    const p0 = @as(types.f32x4, @splat(1.5));
    const res = vreinterpretq_mf8_f32(p0);
    const expected: @TypeOf(res) = @bitCast(p0);
    try std.testing.expectEqual(expected, res);
}

/// ARM NEON intrinsic: `vreinterpretq_mf8_f64`
pub inline fn vreinterpretq_mf8_f64(p0: types.f64x2) types.mf8x16 {
    return @bitCast(p0);
}

test vreinterpretq_mf8_f64 {
    const p0 = @as(types.f64x2, @splat(1.5));
    const res = vreinterpretq_mf8_f64(p0);
    const expected: @TypeOf(res) = @bitCast(p0);
    try std.testing.expectEqual(expected, res);
}

/// ARM NEON intrinsic: `vreinterpretq_mf8_p128`
pub inline fn vreinterpretq_mf8_p128(p0: u128) types.mf8x16 {
    return @bitCast(p0);
}

test vreinterpretq_mf8_p128 {
    const p0 = @as(u128, 2);
    const expected: types.mf8x16 = @bitCast(p0);
    try common.testIntrinsic(.{ .func = vreinterpretq_mf8_p128, .expected = expected, .args = .{p0} });
}

/// ARM NEON intrinsic: `vreinterpretq_mf8_p16`
pub inline fn vreinterpretq_mf8_p16(p0: types.p16x8) types.mf8x16 {
    return @bitCast(p0);
}

test vreinterpretq_mf8_p16 {
    const p0 = @as(types.p16x8, @splat(2));
    const res = vreinterpretq_mf8_p16(p0);
    const expected: @TypeOf(res) = @bitCast(p0);
    try std.testing.expectEqual(expected, res);
}

/// ARM NEON intrinsic: `vreinterpretq_mf8_p64`
pub inline fn vreinterpretq_mf8_p64(p0: types.p64x2) types.mf8x16 {
    return @bitCast(p0);
}

test vreinterpretq_mf8_p64 {
    const p0 = @as(types.p64x2, @splat(2));
    const res = vreinterpretq_mf8_p64(p0);
    const expected: @TypeOf(res) = @bitCast(p0);
    try std.testing.expectEqual(expected, res);
}

/// ARM NEON intrinsic: `vreinterpretq_mf8_p8`
pub inline fn vreinterpretq_mf8_p8(p0: types.p8x16) types.mf8x16 {
    return @bitCast(p0);
}

test vreinterpretq_mf8_p8 {
    const p0 = @as(types.p8x16, @splat(2));
    const res = vreinterpretq_mf8_p8(p0);
    const expected: @TypeOf(res) = @bitCast(p0);
    try std.testing.expectEqual(expected, res);
}

/// ARM NEON intrinsic: `vreinterpretq_mf8_s16`
pub inline fn vreinterpretq_mf8_s16(p0: types.i16x8) types.mf8x16 {
    return @bitCast(p0);
}

test vreinterpretq_mf8_s16 {
    const p0 = @as(types.i16x8, @splat(2));
    const res = vreinterpretq_mf8_s16(p0);
    const expected: @TypeOf(res) = @bitCast(p0);
    try std.testing.expectEqual(expected, res);
}

/// ARM NEON intrinsic: `vreinterpretq_mf8_s32`
pub inline fn vreinterpretq_mf8_s32(p0: types.i32x4) types.mf8x16 {
    return @bitCast(p0);
}

test vreinterpretq_mf8_s32 {
    const p0 = @as(types.i32x4, @splat(2));
    const res = vreinterpretq_mf8_s32(p0);
    const expected: @TypeOf(res) = @bitCast(p0);
    try std.testing.expectEqual(expected, res);
}

/// ARM NEON intrinsic: `vreinterpretq_mf8_s64`
pub inline fn vreinterpretq_mf8_s64(p0: types.i64x2) types.mf8x16 {
    return @bitCast(p0);
}

test vreinterpretq_mf8_s64 {
    const p0 = @as(types.i64x2, @splat(2));
    const res = vreinterpretq_mf8_s64(p0);
    const expected: @TypeOf(res) = @bitCast(p0);
    try std.testing.expectEqual(expected, res);
}

/// ARM NEON intrinsic: `vreinterpretq_mf8_s8`
pub inline fn vreinterpretq_mf8_s8(p0: types.i8x16) types.mf8x16 {
    return @bitCast(p0);
}

test vreinterpretq_mf8_s8 {
    const p0 = @as(types.i8x16, @splat(2));
    const res = vreinterpretq_mf8_s8(p0);
    const expected: @TypeOf(res) = @bitCast(p0);
    try std.testing.expectEqual(expected, res);
}

/// ARM NEON intrinsic: `vreinterpretq_mf8_u16`
pub inline fn vreinterpretq_mf8_u16(p0: types.u16x8) types.mf8x16 {
    return @bitCast(p0);
}

test vreinterpretq_mf8_u16 {
    const p0 = @as(types.u16x8, @splat(2));
    const res = vreinterpretq_mf8_u16(p0);
    const expected: @TypeOf(res) = @bitCast(p0);
    try std.testing.expectEqual(expected, res);
}

/// ARM NEON intrinsic: `vreinterpretq_mf8_u32`
pub inline fn vreinterpretq_mf8_u32(p0: types.u32x4) types.mf8x16 {
    return @bitCast(p0);
}

test vreinterpretq_mf8_u32 {
    const p0 = @as(types.u32x4, @splat(2));
    const res = vreinterpretq_mf8_u32(p0);
    const expected: @TypeOf(res) = @bitCast(p0);
    try std.testing.expectEqual(expected, res);
}

/// ARM NEON intrinsic: `vreinterpretq_mf8_u64`
pub inline fn vreinterpretq_mf8_u64(p0: types.u64x2) types.mf8x16 {
    return @bitCast(p0);
}

test vreinterpretq_mf8_u64 {
    const p0 = @as(types.u64x2, @splat(2));
    const res = vreinterpretq_mf8_u64(p0);
    const expected: @TypeOf(res) = @bitCast(p0);
    try std.testing.expectEqual(expected, res);
}

/// ARM NEON intrinsic: `vreinterpretq_mf8_u8`
pub inline fn vreinterpretq_mf8_u8(p0: types.u8x16) types.mf8x16 {
    return @bitCast(p0);
}

test vreinterpretq_mf8_u8 {
    const p0 = @as(types.u8x16, @splat(2));
    const res = vreinterpretq_mf8_u8(p0);
    const expected: @TypeOf(res) = @bitCast(p0);
    try std.testing.expectEqual(expected, res);
}

/// ARM NEON intrinsic: `vreinterpretq_p128_bf16`
pub inline fn vreinterpretq_p128_bf16(p0: types.bf16x8) u128 {
    return @bitCast(p0);
}

test vreinterpretq_p128_bf16 {
    const p0 = @as(types.bf16x8, @splat(0x3F80));
    const res = vreinterpretq_p128_bf16(p0);
    const expected: @TypeOf(res) = @bitCast(p0);
    try std.testing.expectEqual(expected, res);
}

/// ARM NEON intrinsic: `vreinterpretq_p128_mf8`
pub inline fn vreinterpretq_p128_mf8(p0: types.mf8x16) u128 {
    return @bitCast(p0);
}

test vreinterpretq_p128_mf8 {
    const p0 = @as(types.mf8x16, @splat(2));
    const res = vreinterpretq_p128_mf8(p0);
    const expected: @TypeOf(res) = @bitCast(p0);
    try std.testing.expectEqual(expected, res);
}

/// ARM NEON intrinsic: `vreinterpretq_p16_bf16`
pub inline fn vreinterpretq_p16_bf16(p0: types.bf16x8) types.p16x8 {
    return @bitCast(p0);
}

test vreinterpretq_p16_bf16 {
    const p0 = @as(types.bf16x8, @splat(0x3F80));
    const res = vreinterpretq_p16_bf16(p0);
    const expected: @TypeOf(res) = @bitCast(p0);
    try std.testing.expectEqual(expected, res);
}

/// ARM NEON intrinsic: `vreinterpretq_p16_mf8`
pub inline fn vreinterpretq_p16_mf8(p0: types.mf8x16) types.p16x8 {
    return @bitCast(p0);
}

test vreinterpretq_p16_mf8 {
    const p0 = @as(types.mf8x16, @splat(2));
    const res = vreinterpretq_p16_mf8(p0);
    const expected: @TypeOf(res) = @bitCast(p0);
    try std.testing.expectEqual(expected, res);
}

/// ARM NEON intrinsic: `vreinterpretq_p64_bf16`
pub inline fn vreinterpretq_p64_bf16(p0: types.bf16x8) types.p64x2 {
    return @bitCast(p0);
}

test vreinterpretq_p64_bf16 {
    const p0 = @as(types.bf16x8, @splat(0x3F80));
    const res = vreinterpretq_p64_bf16(p0);
    const expected: @TypeOf(res) = @bitCast(p0);
    try std.testing.expectEqual(expected, res);
}

/// ARM NEON intrinsic: `vreinterpretq_p64_mf8`
pub inline fn vreinterpretq_p64_mf8(p0: types.mf8x16) types.p64x2 {
    return @bitCast(p0);
}

test vreinterpretq_p64_mf8 {
    const p0 = @as(types.mf8x16, @splat(2));
    const res = vreinterpretq_p64_mf8(p0);
    const expected: @TypeOf(res) = @bitCast(p0);
    try std.testing.expectEqual(expected, res);
}

/// ARM NEON intrinsic: `vreinterpretq_p8_bf16`
pub inline fn vreinterpretq_p8_bf16(p0: types.bf16x8) types.p8x16 {
    return @bitCast(p0);
}

test vreinterpretq_p8_bf16 {
    const p0 = @as(types.bf16x8, @splat(0x3F80));
    const res = vreinterpretq_p8_bf16(p0);
    const expected: @TypeOf(res) = @bitCast(p0);
    try std.testing.expectEqual(expected, res);
}

/// ARM NEON intrinsic: `vreinterpretq_p8_mf8`
pub inline fn vreinterpretq_p8_mf8(p0: types.mf8x16) types.p8x16 {
    return @bitCast(p0);
}

test vreinterpretq_p8_mf8 {
    const p0 = @as(types.mf8x16, @splat(2));
    const res = vreinterpretq_p8_mf8(p0);
    const expected: @TypeOf(res) = @bitCast(p0);
    try std.testing.expectEqual(expected, res);
}

/// ARM NEON intrinsic: `vreinterpretq_s16_bf16`
pub inline fn vreinterpretq_s16_bf16(p0: types.bf16x8) types.i16x8 {
    return @bitCast(p0);
}

test vreinterpretq_s16_bf16 {
    const p0 = @as(types.bf16x8, @splat(0x3F80));
    const res = vreinterpretq_s16_bf16(p0);
    const expected: @TypeOf(res) = @bitCast(p0);
    try std.testing.expectEqual(expected, res);
}

/// ARM NEON intrinsic: `vreinterpretq_s16_mf8`
pub inline fn vreinterpretq_s16_mf8(p0: types.mf8x16) types.i16x8 {
    return @bitCast(p0);
}

test vreinterpretq_s16_mf8 {
    const p0 = @as(types.mf8x16, @splat(2));
    const res = vreinterpretq_s16_mf8(p0);
    const expected: @TypeOf(res) = @bitCast(p0);
    try std.testing.expectEqual(expected, res);
}

/// ARM NEON intrinsic: `vreinterpretq_s32_bf16`
pub inline fn vreinterpretq_s32_bf16(p0: types.bf16x8) types.i32x4 {
    return @bitCast(p0);
}

test vreinterpretq_s32_bf16 {
    const p0 = @as(types.bf16x8, @splat(0x3F80));
    const res = vreinterpretq_s32_bf16(p0);
    const expected: @TypeOf(res) = @bitCast(p0);
    try std.testing.expectEqual(expected, res);
}

/// ARM NEON intrinsic: `vreinterpretq_s32_mf8`
pub inline fn vreinterpretq_s32_mf8(p0: types.mf8x16) types.i32x4 {
    return @bitCast(p0);
}

test vreinterpretq_s32_mf8 {
    const p0 = @as(types.mf8x16, @splat(2));
    const res = vreinterpretq_s32_mf8(p0);
    const expected: @TypeOf(res) = @bitCast(p0);
    try std.testing.expectEqual(expected, res);
}

/// ARM NEON intrinsic: `vreinterpretq_s64_bf16`
pub inline fn vreinterpretq_s64_bf16(p0: types.bf16x8) types.i64x2 {
    return @bitCast(p0);
}

test vreinterpretq_s64_bf16 {
    const p0 = @as(types.bf16x8, @splat(0x3F80));
    const res = vreinterpretq_s64_bf16(p0);
    const expected: @TypeOf(res) = @bitCast(p0);
    try std.testing.expectEqual(expected, res);
}

/// ARM NEON intrinsic: `vreinterpretq_s64_mf8`
pub inline fn vreinterpretq_s64_mf8(p0: types.mf8x16) types.i64x2 {
    return @bitCast(p0);
}

test vreinterpretq_s64_mf8 {
    const p0 = @as(types.mf8x16, @splat(2));
    const res = vreinterpretq_s64_mf8(p0);
    const expected: @TypeOf(res) = @bitCast(p0);
    try std.testing.expectEqual(expected, res);
}

/// ARM NEON intrinsic: `vreinterpretq_s8_bf16`
pub inline fn vreinterpretq_s8_bf16(p0: types.bf16x8) types.i8x16 {
    return @bitCast(p0);
}

test vreinterpretq_s8_bf16 {
    const p0 = @as(types.bf16x8, @splat(0x3F80));
    const res = vreinterpretq_s8_bf16(p0);
    const expected: @TypeOf(res) = @bitCast(p0);
    try std.testing.expectEqual(expected, res);
}

/// ARM NEON intrinsic: `vreinterpretq_s8_mf8`
pub inline fn vreinterpretq_s8_mf8(p0: types.mf8x16) types.i8x16 {
    return @bitCast(p0);
}

test vreinterpretq_s8_mf8 {
    const p0 = @as(types.mf8x16, @splat(2));
    const res = vreinterpretq_s8_mf8(p0);
    const expected: @TypeOf(res) = @bitCast(p0);
    try std.testing.expectEqual(expected, res);
}

/// ARM NEON intrinsic: `vreinterpretq_u16_bf16`
pub inline fn vreinterpretq_u16_bf16(p0: types.bf16x8) types.u16x8 {
    return @bitCast(p0);
}

test vreinterpretq_u16_bf16 {
    const p0 = @as(types.bf16x8, @splat(0x3F80));
    const res = vreinterpretq_u16_bf16(p0);
    const expected: @TypeOf(res) = @bitCast(p0);
    try std.testing.expectEqual(expected, res);
}

/// ARM NEON intrinsic: `vreinterpretq_u16_mf8`
pub inline fn vreinterpretq_u16_mf8(p0: types.mf8x16) types.u16x8 {
    return @bitCast(p0);
}

test vreinterpretq_u16_mf8 {
    const p0 = @as(types.mf8x16, @splat(2));
    const res = vreinterpretq_u16_mf8(p0);
    const expected: @TypeOf(res) = @bitCast(p0);
    try std.testing.expectEqual(expected, res);
}

/// ARM NEON intrinsic: `vreinterpretq_u32_bf16`
pub inline fn vreinterpretq_u32_bf16(p0: types.bf16x8) types.u32x4 {
    return @bitCast(p0);
}

test vreinterpretq_u32_bf16 {
    const p0 = @as(types.bf16x8, @splat(0x3F80));
    const res = vreinterpretq_u32_bf16(p0);
    const expected: @TypeOf(res) = @bitCast(p0);
    try std.testing.expectEqual(expected, res);
}

/// ARM NEON intrinsic: `vreinterpretq_u32_mf8`
pub inline fn vreinterpretq_u32_mf8(p0: types.mf8x16) types.u32x4 {
    return @bitCast(p0);
}

test vreinterpretq_u32_mf8 {
    const p0 = @as(types.mf8x16, @splat(2));
    const res = vreinterpretq_u32_mf8(p0);
    const expected: @TypeOf(res) = @bitCast(p0);
    try std.testing.expectEqual(expected, res);
}

/// ARM NEON intrinsic: `vreinterpretq_u64_bf16`
pub inline fn vreinterpretq_u64_bf16(p0: types.bf16x8) types.u64x2 {
    return @bitCast(p0);
}

test vreinterpretq_u64_bf16 {
    const p0 = @as(types.bf16x8, @splat(0x3F80));
    const res = vreinterpretq_u64_bf16(p0);
    const expected: @TypeOf(res) = @bitCast(p0);
    try std.testing.expectEqual(expected, res);
}

/// ARM NEON intrinsic: `vreinterpretq_u64_mf8`
pub inline fn vreinterpretq_u64_mf8(p0: types.mf8x16) types.u64x2 {
    return @bitCast(p0);
}

test vreinterpretq_u64_mf8 {
    const p0 = @as(types.mf8x16, @splat(2));
    const res = vreinterpretq_u64_mf8(p0);
    const expected: @TypeOf(res) = @bitCast(p0);
    try std.testing.expectEqual(expected, res);
}

/// ARM NEON intrinsic: `vreinterpretq_u8_bf16`
pub inline fn vreinterpretq_u8_bf16(p0: types.bf16x8) types.u8x16 {
    return @bitCast(p0);
}

test vreinterpretq_u8_bf16 {
    const p0 = @as(types.bf16x8, @splat(0x3F80));
    const res = vreinterpretq_u8_bf16(p0);
    const expected: @TypeOf(res) = @bitCast(p0);
    try std.testing.expectEqual(expected, res);
}

/// ARM NEON intrinsic: `vreinterpretq_u8_mf8`
pub inline fn vreinterpretq_u8_mf8(p0: types.mf8x16) types.u8x16 {
    return @bitCast(p0);
}

test vreinterpretq_u8_mf8 {
    const p0 = @as(types.mf8x16, @splat(2));
    const res = vreinterpretq_u8_mf8(p0);
    const expected: @TypeOf(res) = @bitCast(p0);
    try std.testing.expectEqual(expected, res);
}
