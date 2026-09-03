const std = @import("std");
const types = @import("../types.zig");
const common = @import("../common.zig");

/// vreinterpret_f16_f32
pub inline fn vreinterpret_f16_f32(a: types.f32x2) types.f16x4 {
    return @bitCast(a);
}

test vreinterpret_f16_f32 {
    const a = std.mem.zeroes(types.f32x2);
    const expected = std.mem.zeroes(types.f16x4);
    try common.testIntrinsic("vreinterpret_f16_f32", vreinterpret_f16_f32, expected, .{a}, null);
}

/// vreinterpret_f16_f64
pub inline fn vreinterpret_f16_f64(a: types.f64x1) types.f16x4 {
    return @bitCast(a);
}

test vreinterpret_f16_f64 {
    const a = std.mem.zeroes(types.f64x1);
    const expected = std.mem.zeroes(types.f16x4);
    try common.testIntrinsic("vreinterpret_f16_f64", vreinterpret_f16_f64, expected, .{a}, null);
}

/// vreinterpret_f16_p16
pub inline fn vreinterpret_f16_p16(a: types.p16x4) types.f16x4 {
    return @bitCast(a);
}

test vreinterpret_f16_p16 {
    const a = std.mem.zeroes(types.p16x4);
    const expected = std.mem.zeroes(types.f16x4);
    try common.testIntrinsic("vreinterpret_f16_p16", vreinterpret_f16_p16, expected, .{a}, null);
}

/// vreinterpret_f16_p64
pub inline fn vreinterpret_f16_p64(a: types.p64x1) types.f16x4 {
    return @bitCast(a);
}

test vreinterpret_f16_p64 {
    const a = std.mem.zeroes(types.p64x1);
    const expected = std.mem.zeroes(types.f16x4);
    try common.testIntrinsic("vreinterpret_f16_p64", vreinterpret_f16_p64, expected, .{a}, null);
}

/// vreinterpret_f16_p8
pub inline fn vreinterpret_f16_p8(a: types.p8x8) types.f16x4 {
    return @bitCast(a);
}

test vreinterpret_f16_p8 {
    const a = std.mem.zeroes(types.p8x8);
    const expected = std.mem.zeroes(types.f16x4);
    try common.testIntrinsic("vreinterpret_f16_p8", vreinterpret_f16_p8, expected, .{a}, null);
}

/// vreinterpret_f16_s16
pub inline fn vreinterpret_f16_s16(a: types.i16x4) types.f16x4 {
    return @bitCast(a);
}

test vreinterpret_f16_s16 {
    const a = std.mem.zeroes(types.i16x4);
    const expected = std.mem.zeroes(types.f16x4);
    try common.testIntrinsic("vreinterpret_f16_s16", vreinterpret_f16_s16, expected, .{a}, null);
}

/// vreinterpret_f16_s32
pub inline fn vreinterpret_f16_s32(a: types.i32x2) types.f16x4 {
    return @bitCast(a);
}

test vreinterpret_f16_s32 {
    const a = std.mem.zeroes(types.i32x2);
    const expected = std.mem.zeroes(types.f16x4);
    try common.testIntrinsic("vreinterpret_f16_s32", vreinterpret_f16_s32, expected, .{a}, null);
}

/// vreinterpret_f16_s64
pub inline fn vreinterpret_f16_s64(a: types.i64x1) types.f16x4 {
    return @bitCast(a);
}

test vreinterpret_f16_s64 {
    const a = std.mem.zeroes(types.i64x1);
    const expected = std.mem.zeroes(types.f16x4);
    try common.testIntrinsic("vreinterpret_f16_s64", vreinterpret_f16_s64, expected, .{a}, null);
}

/// vreinterpret_f16_s8
pub inline fn vreinterpret_f16_s8(a: types.i8x8) types.f16x4 {
    return @bitCast(a);
}

test vreinterpret_f16_s8 {
    const a = std.mem.zeroes(types.i8x8);
    const expected = std.mem.zeroes(types.f16x4);
    try common.testIntrinsic("vreinterpret_f16_s8", vreinterpret_f16_s8, expected, .{a}, null);
}

/// vreinterpret_f16_u16
pub inline fn vreinterpret_f16_u16(a: types.u16x4) types.f16x4 {
    return @bitCast(a);
}

test vreinterpret_f16_u16 {
    const a = std.mem.zeroes(types.u16x4);
    const expected = std.mem.zeroes(types.f16x4);
    try common.testIntrinsic("vreinterpret_f16_u16", vreinterpret_f16_u16, expected, .{a}, null);
}

/// vreinterpret_f16_u32
pub inline fn vreinterpret_f16_u32(a: types.u32x2) types.f16x4 {
    return @bitCast(a);
}

test vreinterpret_f16_u32 {
    const a = std.mem.zeroes(types.u32x2);
    const expected = std.mem.zeroes(types.f16x4);
    try common.testIntrinsic("vreinterpret_f16_u32", vreinterpret_f16_u32, expected, .{a}, null);
}

/// vreinterpret_f16_u64
pub inline fn vreinterpret_f16_u64(a: types.u64x1) types.f16x4 {
    return @bitCast(a);
}

test vreinterpret_f16_u64 {
    const a = std.mem.zeroes(types.u64x1);
    const expected = std.mem.zeroes(types.f16x4);
    try common.testIntrinsic("vreinterpret_f16_u64", vreinterpret_f16_u64, expected, .{a}, null);
}

/// vreinterpret_f16_u8
pub inline fn vreinterpret_f16_u8(a: types.u8x8) types.f16x4 {
    return @bitCast(a);
}

test vreinterpret_f16_u8 {
    const a = std.mem.zeroes(types.u8x8);
    const expected = std.mem.zeroes(types.f16x4);
    try common.testIntrinsic("vreinterpret_f16_u8", vreinterpret_f16_u8, expected, .{a}, null);
}

/// vreinterpret_f32_f16
pub inline fn vreinterpret_f32_f16(a: types.f16x4) types.f32x2 {
    return @bitCast(a);
}

test vreinterpret_f32_f16 {
    const a = std.mem.zeroes(types.f16x4);
    const expected = std.mem.zeroes(types.f32x2);
    try common.testIntrinsic("vreinterpret_f32_f16", vreinterpret_f32_f16, expected, .{a}, null);
}

/// vreinterpret_f32_f64
pub inline fn vreinterpret_f32_f64(a: types.f64x1) types.f32x2 {
    return @bitCast(a);
}

test vreinterpret_f32_f64 {
    const a = std.mem.zeroes(types.f64x1);
    const expected = std.mem.zeroes(types.f32x2);
    try common.testIntrinsic("vreinterpret_f32_f64", vreinterpret_f32_f64, expected, .{a}, null);
}

/// vreinterpret_f32_p16
pub inline fn vreinterpret_f32_p16(a: types.p16x4) types.f32x2 {
    return @bitCast(a);
}

test vreinterpret_f32_p16 {
    const a = std.mem.zeroes(types.p16x4);
    const expected = std.mem.zeroes(types.f32x2);
    try common.testIntrinsic("vreinterpret_f32_p16", vreinterpret_f32_p16, expected, .{a}, null);
}

/// vreinterpret_f32_p64
pub inline fn vreinterpret_f32_p64(a: types.p64x1) types.f32x2 {
    return @bitCast(a);
}

test vreinterpret_f32_p64 {
    const a = std.mem.zeroes(types.p64x1);
    const expected = std.mem.zeroes(types.f32x2);
    try common.testIntrinsic("vreinterpret_f32_p64", vreinterpret_f32_p64, expected, .{a}, null);
}

/// vreinterpret_f32_p8
pub inline fn vreinterpret_f32_p8(a: types.p8x8) types.f32x2 {
    return @bitCast(a);
}

test vreinterpret_f32_p8 {
    const a = std.mem.zeroes(types.p8x8);
    const expected = std.mem.zeroes(types.f32x2);
    try common.testIntrinsic("vreinterpret_f32_p8", vreinterpret_f32_p8, expected, .{a}, null);
}

/// vreinterpret_f32_s16
pub inline fn vreinterpret_f32_s16(a: types.i16x4) types.f32x2 {
    return @bitCast(a);
}

test vreinterpret_f32_s16 {
    const a = std.mem.zeroes(types.i16x4);
    const expected = std.mem.zeroes(types.f32x2);
    try common.testIntrinsic("vreinterpret_f32_s16", vreinterpret_f32_s16, expected, .{a}, null);
}

/// vreinterpret_f32_s32
pub inline fn vreinterpret_f32_s32(a: types.i32x2) types.f32x2 {
    return @bitCast(a);
}

test vreinterpret_f32_s32 {
    const a = std.mem.zeroes(types.i32x2);
    const expected = std.mem.zeroes(types.f32x2);
    try common.testIntrinsic("vreinterpret_f32_s32", vreinterpret_f32_s32, expected, .{a}, null);
}

/// vreinterpret_f32_s64
pub inline fn vreinterpret_f32_s64(a: types.i64x1) types.f32x2 {
    return @bitCast(a);
}

test vreinterpret_f32_s64 {
    const a = std.mem.zeroes(types.i64x1);
    const expected = std.mem.zeroes(types.f32x2);
    try common.testIntrinsic("vreinterpret_f32_s64", vreinterpret_f32_s64, expected, .{a}, null);
}

/// vreinterpret_f32_s8
pub inline fn vreinterpret_f32_s8(a: types.i8x8) types.f32x2 {
    return @bitCast(a);
}

test vreinterpret_f32_s8 {
    const a = std.mem.zeroes(types.i8x8);
    const expected = std.mem.zeroes(types.f32x2);
    try common.testIntrinsic("vreinterpret_f32_s8", vreinterpret_f32_s8, expected, .{a}, null);
}

/// vreinterpret_f32_u16
pub inline fn vreinterpret_f32_u16(a: types.u16x4) types.f32x2 {
    return @bitCast(a);
}

test vreinterpret_f32_u16 {
    const a = std.mem.zeroes(types.u16x4);
    const expected = std.mem.zeroes(types.f32x2);
    try common.testIntrinsic("vreinterpret_f32_u16", vreinterpret_f32_u16, expected, .{a}, null);
}

/// vreinterpret_f32_u32
pub inline fn vreinterpret_f32_u32(a: types.u32x2) types.f32x2 {
    return @bitCast(a);
}

test vreinterpret_f32_u32 {
    const a = std.mem.zeroes(types.u32x2);
    const expected = std.mem.zeroes(types.f32x2);
    try common.testIntrinsic("vreinterpret_f32_u32", vreinterpret_f32_u32, expected, .{a}, null);
}

/// vreinterpret_f32_u64
pub inline fn vreinterpret_f32_u64(a: types.u64x1) types.f32x2 {
    return @bitCast(a);
}

test vreinterpret_f32_u64 {
    const a = std.mem.zeroes(types.u64x1);
    const expected = std.mem.zeroes(types.f32x2);
    try common.testIntrinsic("vreinterpret_f32_u64", vreinterpret_f32_u64, expected, .{a}, null);
}

/// vreinterpret_f32_u8
pub inline fn vreinterpret_f32_u8(a: types.u8x8) types.f32x2 {
    return @bitCast(a);
}

test vreinterpret_f32_u8 {
    const a = std.mem.zeroes(types.u8x8);
    const expected = std.mem.zeroes(types.f32x2);
    try common.testIntrinsic("vreinterpret_f32_u8", vreinterpret_f32_u8, expected, .{a}, null);
}

/// vreinterpret_f64_f16
pub inline fn vreinterpret_f64_f16(a: types.f16x4) types.f64x1 {
    return @bitCast(a);
}

test vreinterpret_f64_f16 {
    const a = std.mem.zeroes(types.f16x4);
    const expected = std.mem.zeroes(types.f64x1);
    try common.testIntrinsic("vreinterpret_f64_f16", vreinterpret_f64_f16, expected, .{a}, null);
}

/// vreinterpret_f64_f32
pub inline fn vreinterpret_f64_f32(a: types.f32x2) types.f64x1 {
    return @bitCast(a);
}

test vreinterpret_f64_f32 {
    const a = std.mem.zeroes(types.f32x2);
    const expected = std.mem.zeroes(types.f64x1);
    try common.testIntrinsic("vreinterpret_f64_f32", vreinterpret_f64_f32, expected, .{a}, null);
}

/// vreinterpret_f64_p16
pub inline fn vreinterpret_f64_p16(a: types.p16x4) types.f64x1 {
    return @bitCast(a);
}

test vreinterpret_f64_p16 {
    const a = std.mem.zeroes(types.p16x4);
    const expected = std.mem.zeroes(types.f64x1);
    try common.testIntrinsic("vreinterpret_f64_p16", vreinterpret_f64_p16, expected, .{a}, null);
}

/// vreinterpret_f64_p64
pub inline fn vreinterpret_f64_p64(a: types.p64x1) types.f64x1 {
    return @bitCast(a);
}

test vreinterpret_f64_p64 {
    const a = std.mem.zeroes(types.p64x1);
    const expected = std.mem.zeroes(types.f64x1);
    try common.testIntrinsic("vreinterpret_f64_p64", vreinterpret_f64_p64, expected, .{a}, null);
}

/// vreinterpret_f64_p8
pub inline fn vreinterpret_f64_p8(a: types.p8x8) types.f64x1 {
    return @bitCast(a);
}

test vreinterpret_f64_p8 {
    const a = std.mem.zeroes(types.p8x8);
    const expected = std.mem.zeroes(types.f64x1);
    try common.testIntrinsic("vreinterpret_f64_p8", vreinterpret_f64_p8, expected, .{a}, null);
}

/// vreinterpret_f64_s16
pub inline fn vreinterpret_f64_s16(a: types.i16x4) types.f64x1 {
    return @bitCast(a);
}

test vreinterpret_f64_s16 {
    const a = std.mem.zeroes(types.i16x4);
    const expected = std.mem.zeroes(types.f64x1);
    try common.testIntrinsic("vreinterpret_f64_s16", vreinterpret_f64_s16, expected, .{a}, null);
}

/// vreinterpret_f64_s32
pub inline fn vreinterpret_f64_s32(a: types.i32x2) types.f64x1 {
    return @bitCast(a);
}

test vreinterpret_f64_s32 {
    const a = std.mem.zeroes(types.i32x2);
    const expected = std.mem.zeroes(types.f64x1);
    try common.testIntrinsic("vreinterpret_f64_s32", vreinterpret_f64_s32, expected, .{a}, null);
}

/// vreinterpret_f64_s64
pub inline fn vreinterpret_f64_s64(a: types.i64x1) types.f64x1 {
    return @bitCast(a);
}

test vreinterpret_f64_s64 {
    const a = std.mem.zeroes(types.i64x1);
    const expected = std.mem.zeroes(types.f64x1);
    try common.testIntrinsic("vreinterpret_f64_s64", vreinterpret_f64_s64, expected, .{a}, null);
}

/// vreinterpret_f64_s8
pub inline fn vreinterpret_f64_s8(a: types.i8x8) types.f64x1 {
    return @bitCast(a);
}

test vreinterpret_f64_s8 {
    const a = std.mem.zeroes(types.i8x8);
    const expected = std.mem.zeroes(types.f64x1);
    try common.testIntrinsic("vreinterpret_f64_s8", vreinterpret_f64_s8, expected, .{a}, null);
}

/// vreinterpret_f64_u16
pub inline fn vreinterpret_f64_u16(a: types.u16x4) types.f64x1 {
    return @bitCast(a);
}

test vreinterpret_f64_u16 {
    const a = std.mem.zeroes(types.u16x4);
    const expected = std.mem.zeroes(types.f64x1);
    try common.testIntrinsic("vreinterpret_f64_u16", vreinterpret_f64_u16, expected, .{a}, null);
}

/// vreinterpret_f64_u32
pub inline fn vreinterpret_f64_u32(a: types.u32x2) types.f64x1 {
    return @bitCast(a);
}

test vreinterpret_f64_u32 {
    const a = std.mem.zeroes(types.u32x2);
    const expected = std.mem.zeroes(types.f64x1);
    try common.testIntrinsic("vreinterpret_f64_u32", vreinterpret_f64_u32, expected, .{a}, null);
}

/// vreinterpret_f64_u64
pub inline fn vreinterpret_f64_u64(a: types.u64x1) types.f64x1 {
    return @bitCast(a);
}

test vreinterpret_f64_u64 {
    const a = std.mem.zeroes(types.u64x1);
    const expected = std.mem.zeroes(types.f64x1);
    try common.testIntrinsic("vreinterpret_f64_u64", vreinterpret_f64_u64, expected, .{a}, null);
}

/// vreinterpret_f64_u8
pub inline fn vreinterpret_f64_u8(a: types.u8x8) types.f64x1 {
    return @bitCast(a);
}

test vreinterpret_f64_u8 {
    const a = std.mem.zeroes(types.u8x8);
    const expected = std.mem.zeroes(types.f64x1);
    try common.testIntrinsic("vreinterpret_f64_u8", vreinterpret_f64_u8, expected, .{a}, null);
}

/// vreinterpret_p16_f16
pub inline fn vreinterpret_p16_f16(a: types.f16x4) types.p16x4 {
    return @bitCast(a);
}

test vreinterpret_p16_f16 {
    const a = std.mem.zeroes(types.f16x4);
    const expected = std.mem.zeroes(types.p16x4);
    try common.testIntrinsic("vreinterpret_p16_f16", vreinterpret_p16_f16, expected, .{a}, null);
}

/// vreinterpret_p16_f32
pub inline fn vreinterpret_p16_f32(a: types.f32x2) types.p16x4 {
    return @bitCast(a);
}

test vreinterpret_p16_f32 {
    const a = std.mem.zeroes(types.f32x2);
    const expected = std.mem.zeroes(types.p16x4);
    try common.testIntrinsic("vreinterpret_p16_f32", vreinterpret_p16_f32, expected, .{a}, null);
}

/// vreinterpret_p16_f64
pub inline fn vreinterpret_p16_f64(a: types.f64x1) types.p16x4 {
    return @bitCast(a);
}

test vreinterpret_p16_f64 {
    const a = std.mem.zeroes(types.f64x1);
    const expected = std.mem.zeroes(types.p16x4);
    try common.testIntrinsic("vreinterpret_p16_f64", vreinterpret_p16_f64, expected, .{a}, null);
}

/// vreinterpret_p16_p64
pub inline fn vreinterpret_p16_p64(a: types.p64x1) types.p16x4 {
    return @bitCast(a);
}

test vreinterpret_p16_p64 {
    const a = std.mem.zeroes(types.p64x1);
    const expected = std.mem.zeroes(types.p16x4);
    try common.testIntrinsic("vreinterpret_p16_p64", vreinterpret_p16_p64, expected, .{a}, null);
}

/// vreinterpret_p16_p8
pub inline fn vreinterpret_p16_p8(a: types.p8x8) types.p16x4 {
    return @bitCast(a);
}

test vreinterpret_p16_p8 {
    const a = std.mem.zeroes(types.p8x8);
    const expected = std.mem.zeroes(types.p16x4);
    try common.testIntrinsic("vreinterpret_p16_p8", vreinterpret_p16_p8, expected, .{a}, null);
}

/// vreinterpret_p16_s16
pub inline fn vreinterpret_p16_s16(a: types.i16x4) types.p16x4 {
    return @bitCast(a);
}

test vreinterpret_p16_s16 {
    const a = std.mem.zeroes(types.i16x4);
    const expected = std.mem.zeroes(types.p16x4);
    try common.testIntrinsic("vreinterpret_p16_s16", vreinterpret_p16_s16, expected, .{a}, null);
}

/// vreinterpret_p16_s32
pub inline fn vreinterpret_p16_s32(a: types.i32x2) types.p16x4 {
    return @bitCast(a);
}

test vreinterpret_p16_s32 {
    const a = std.mem.zeroes(types.i32x2);
    const expected = std.mem.zeroes(types.p16x4);
    try common.testIntrinsic("vreinterpret_p16_s32", vreinterpret_p16_s32, expected, .{a}, null);
}

/// vreinterpret_p16_s64
pub inline fn vreinterpret_p16_s64(a: types.i64x1) types.p16x4 {
    return @bitCast(a);
}

test vreinterpret_p16_s64 {
    const a = std.mem.zeroes(types.i64x1);
    const expected = std.mem.zeroes(types.p16x4);
    try common.testIntrinsic("vreinterpret_p16_s64", vreinterpret_p16_s64, expected, .{a}, null);
}

/// vreinterpret_p16_s8
pub inline fn vreinterpret_p16_s8(a: types.i8x8) types.p16x4 {
    return @bitCast(a);
}

test vreinterpret_p16_s8 {
    const a = std.mem.zeroes(types.i8x8);
    const expected = std.mem.zeroes(types.p16x4);
    try common.testIntrinsic("vreinterpret_p16_s8", vreinterpret_p16_s8, expected, .{a}, null);
}

/// vreinterpret_p16_u16
pub inline fn vreinterpret_p16_u16(a: types.u16x4) types.p16x4 {
    return @bitCast(a);
}

test vreinterpret_p16_u16 {
    const a = std.mem.zeroes(types.u16x4);
    const expected = std.mem.zeroes(types.p16x4);
    try common.testIntrinsic("vreinterpret_p16_u16", vreinterpret_p16_u16, expected, .{a}, null);
}

/// vreinterpret_p16_u32
pub inline fn vreinterpret_p16_u32(a: types.u32x2) types.p16x4 {
    return @bitCast(a);
}

test vreinterpret_p16_u32 {
    const a = std.mem.zeroes(types.u32x2);
    const expected = std.mem.zeroes(types.p16x4);
    try common.testIntrinsic("vreinterpret_p16_u32", vreinterpret_p16_u32, expected, .{a}, null);
}

/// vreinterpret_p16_u64
pub inline fn vreinterpret_p16_u64(a: types.u64x1) types.p16x4 {
    return @bitCast(a);
}

test vreinterpret_p16_u64 {
    const a = std.mem.zeroes(types.u64x1);
    const expected = std.mem.zeroes(types.p16x4);
    try common.testIntrinsic("vreinterpret_p16_u64", vreinterpret_p16_u64, expected, .{a}, null);
}

/// vreinterpret_p16_u8
pub inline fn vreinterpret_p16_u8(a: types.u8x8) types.p16x4 {
    return @bitCast(a);
}

test vreinterpret_p16_u8 {
    const a = std.mem.zeroes(types.u8x8);
    const expected = std.mem.zeroes(types.p16x4);
    try common.testIntrinsic("vreinterpret_p16_u8", vreinterpret_p16_u8, expected, .{a}, null);
}

/// vreinterpret_p64_f16
pub inline fn vreinterpret_p64_f16(a: types.f16x4) types.p64x1 {
    return @bitCast(a);
}

test vreinterpret_p64_f16 {
    const a = std.mem.zeroes(types.f16x4);
    const expected = std.mem.zeroes(types.p64x1);
    try common.testIntrinsic("vreinterpret_p64_f16", vreinterpret_p64_f16, expected, .{a}, null);
}

/// vreinterpret_p64_f32
pub inline fn vreinterpret_p64_f32(a: types.f32x2) types.p64x1 {
    return @bitCast(a);
}

test vreinterpret_p64_f32 {
    const a = std.mem.zeroes(types.f32x2);
    const expected = std.mem.zeroes(types.p64x1);
    try common.testIntrinsic("vreinterpret_p64_f32", vreinterpret_p64_f32, expected, .{a}, null);
}

/// vreinterpret_p64_f64
pub inline fn vreinterpret_p64_f64(a: types.f64x1) types.p64x1 {
    return @bitCast(a);
}

test vreinterpret_p64_f64 {
    const a = std.mem.zeroes(types.f64x1);
    const expected = std.mem.zeroes(types.p64x1);
    try common.testIntrinsic("vreinterpret_p64_f64", vreinterpret_p64_f64, expected, .{a}, null);
}

/// vreinterpret_p64_p16
pub inline fn vreinterpret_p64_p16(a: types.p16x4) types.p64x1 {
    return @bitCast(a);
}

test vreinterpret_p64_p16 {
    const a = std.mem.zeroes(types.p16x4);
    const expected = std.mem.zeroes(types.p64x1);
    try common.testIntrinsic("vreinterpret_p64_p16", vreinterpret_p64_p16, expected, .{a}, null);
}

/// vreinterpret_p64_p8
pub inline fn vreinterpret_p64_p8(a: types.p8x8) types.p64x1 {
    return @bitCast(a);
}

test vreinterpret_p64_p8 {
    const a = std.mem.zeroes(types.p8x8);
    const expected = std.mem.zeroes(types.p64x1);
    try common.testIntrinsic("vreinterpret_p64_p8", vreinterpret_p64_p8, expected, .{a}, null);
}

/// vreinterpret_p64_s16
pub inline fn vreinterpret_p64_s16(a: types.i16x4) types.p64x1 {
    return @bitCast(a);
}

test vreinterpret_p64_s16 {
    const a = std.mem.zeroes(types.i16x4);
    const expected = std.mem.zeroes(types.p64x1);
    try common.testIntrinsic("vreinterpret_p64_s16", vreinterpret_p64_s16, expected, .{a}, null);
}

/// vreinterpret_p64_s32
pub inline fn vreinterpret_p64_s32(a: types.i32x2) types.p64x1 {
    return @bitCast(a);
}

test vreinterpret_p64_s32 {
    const a = std.mem.zeroes(types.i32x2);
    const expected = std.mem.zeroes(types.p64x1);
    try common.testIntrinsic("vreinterpret_p64_s32", vreinterpret_p64_s32, expected, .{a}, null);
}

/// vreinterpret_p64_s64
pub inline fn vreinterpret_p64_s64(a: types.i64x1) types.p64x1 {
    return @bitCast(a);
}

test vreinterpret_p64_s64 {
    const a = std.mem.zeroes(types.i64x1);
    const expected = std.mem.zeroes(types.p64x1);
    try common.testIntrinsic("vreinterpret_p64_s64", vreinterpret_p64_s64, expected, .{a}, null);
}

/// vreinterpret_p64_s8
pub inline fn vreinterpret_p64_s8(a: types.i8x8) types.p64x1 {
    return @bitCast(a);
}

test vreinterpret_p64_s8 {
    const a = std.mem.zeroes(types.i8x8);
    const expected = std.mem.zeroes(types.p64x1);
    try common.testIntrinsic("vreinterpret_p64_s8", vreinterpret_p64_s8, expected, .{a}, null);
}

/// vreinterpret_p64_u16
pub inline fn vreinterpret_p64_u16(a: types.u16x4) types.p64x1 {
    return @bitCast(a);
}

test vreinterpret_p64_u16 {
    const a = std.mem.zeroes(types.u16x4);
    const expected = std.mem.zeroes(types.p64x1);
    try common.testIntrinsic("vreinterpret_p64_u16", vreinterpret_p64_u16, expected, .{a}, null);
}

/// vreinterpret_p64_u32
pub inline fn vreinterpret_p64_u32(a: types.u32x2) types.p64x1 {
    return @bitCast(a);
}

test vreinterpret_p64_u32 {
    const a = std.mem.zeroes(types.u32x2);
    const expected = std.mem.zeroes(types.p64x1);
    try common.testIntrinsic("vreinterpret_p64_u32", vreinterpret_p64_u32, expected, .{a}, null);
}

/// vreinterpret_p64_u64
pub inline fn vreinterpret_p64_u64(a: types.u64x1) types.p64x1 {
    return @bitCast(a);
}

test vreinterpret_p64_u64 {
    const a = std.mem.zeroes(types.u64x1);
    const expected = std.mem.zeroes(types.p64x1);
    try common.testIntrinsic("vreinterpret_p64_u64", vreinterpret_p64_u64, expected, .{a}, null);
}

/// vreinterpret_p64_u8
pub inline fn vreinterpret_p64_u8(a: types.u8x8) types.p64x1 {
    return @bitCast(a);
}

test vreinterpret_p64_u8 {
    const a = std.mem.zeroes(types.u8x8);
    const expected = std.mem.zeroes(types.p64x1);
    try common.testIntrinsic("vreinterpret_p64_u8", vreinterpret_p64_u8, expected, .{a}, null);
}

/// vreinterpret_p8_f16
pub inline fn vreinterpret_p8_f16(a: types.f16x4) types.p8x8 {
    return @bitCast(a);
}

test vreinterpret_p8_f16 {
    const a = std.mem.zeroes(types.f16x4);
    const expected = std.mem.zeroes(types.p8x8);
    try common.testIntrinsic("vreinterpret_p8_f16", vreinterpret_p8_f16, expected, .{a}, null);
}

/// vreinterpret_p8_f32
pub inline fn vreinterpret_p8_f32(a: types.f32x2) types.p8x8 {
    return @bitCast(a);
}

test vreinterpret_p8_f32 {
    const a = std.mem.zeroes(types.f32x2);
    const expected = std.mem.zeroes(types.p8x8);
    try common.testIntrinsic("vreinterpret_p8_f32", vreinterpret_p8_f32, expected, .{a}, null);
}

/// vreinterpret_p8_f64
pub inline fn vreinterpret_p8_f64(a: types.f64x1) types.p8x8 {
    return @bitCast(a);
}

test vreinterpret_p8_f64 {
    const a = std.mem.zeroes(types.f64x1);
    const expected = std.mem.zeroes(types.p8x8);
    try common.testIntrinsic("vreinterpret_p8_f64", vreinterpret_p8_f64, expected, .{a}, null);
}

/// vreinterpret_p8_p16
pub inline fn vreinterpret_p8_p16(a: types.p16x4) types.p8x8 {
    return @bitCast(a);
}

test vreinterpret_p8_p16 {
    const a = std.mem.zeroes(types.p16x4);
    const expected = std.mem.zeroes(types.p8x8);
    try common.testIntrinsic("vreinterpret_p8_p16", vreinterpret_p8_p16, expected, .{a}, null);
}

/// vreinterpret_p8_p64
pub inline fn vreinterpret_p8_p64(a: types.p64x1) types.p8x8 {
    return @bitCast(a);
}

test vreinterpret_p8_p64 {
    const a = std.mem.zeroes(types.p64x1);
    const expected = std.mem.zeroes(types.p8x8);
    try common.testIntrinsic("vreinterpret_p8_p64", vreinterpret_p8_p64, expected, .{a}, null);
}

/// vreinterpret_p8_s16
pub inline fn vreinterpret_p8_s16(a: types.i16x4) types.p8x8 {
    return @bitCast(a);
}

test vreinterpret_p8_s16 {
    const a = std.mem.zeroes(types.i16x4);
    const expected = std.mem.zeroes(types.p8x8);
    try common.testIntrinsic("vreinterpret_p8_s16", vreinterpret_p8_s16, expected, .{a}, null);
}

/// vreinterpret_p8_s32
pub inline fn vreinterpret_p8_s32(a: types.i32x2) types.p8x8 {
    return @bitCast(a);
}

test vreinterpret_p8_s32 {
    const a = std.mem.zeroes(types.i32x2);
    const expected = std.mem.zeroes(types.p8x8);
    try common.testIntrinsic("vreinterpret_p8_s32", vreinterpret_p8_s32, expected, .{a}, null);
}

/// vreinterpret_p8_s64
pub inline fn vreinterpret_p8_s64(a: types.i64x1) types.p8x8 {
    return @bitCast(a);
}

test vreinterpret_p8_s64 {
    const a = std.mem.zeroes(types.i64x1);
    const expected = std.mem.zeroes(types.p8x8);
    try common.testIntrinsic("vreinterpret_p8_s64", vreinterpret_p8_s64, expected, .{a}, null);
}

/// vreinterpret_p8_s8
pub inline fn vreinterpret_p8_s8(a: types.i8x8) types.p8x8 {
    return @bitCast(a);
}

test vreinterpret_p8_s8 {
    const a = std.mem.zeroes(types.i8x8);
    const expected = std.mem.zeroes(types.p8x8);
    try common.testIntrinsic("vreinterpret_p8_s8", vreinterpret_p8_s8, expected, .{a}, null);
}

/// vreinterpret_p8_u16
pub inline fn vreinterpret_p8_u16(a: types.u16x4) types.p8x8 {
    return @bitCast(a);
}

test vreinterpret_p8_u16 {
    const a = std.mem.zeroes(types.u16x4);
    const expected = std.mem.zeroes(types.p8x8);
    try common.testIntrinsic("vreinterpret_p8_u16", vreinterpret_p8_u16, expected, .{a}, null);
}

/// vreinterpret_p8_u32
pub inline fn vreinterpret_p8_u32(a: types.u32x2) types.p8x8 {
    return @bitCast(a);
}

test vreinterpret_p8_u32 {
    const a = std.mem.zeroes(types.u32x2);
    const expected = std.mem.zeroes(types.p8x8);
    try common.testIntrinsic("vreinterpret_p8_u32", vreinterpret_p8_u32, expected, .{a}, null);
}

/// vreinterpret_p8_u64
pub inline fn vreinterpret_p8_u64(a: types.u64x1) types.p8x8 {
    return @bitCast(a);
}

test vreinterpret_p8_u64 {
    const a = std.mem.zeroes(types.u64x1);
    const expected = std.mem.zeroes(types.p8x8);
    try common.testIntrinsic("vreinterpret_p8_u64", vreinterpret_p8_u64, expected, .{a}, null);
}

/// vreinterpret_p8_u8
pub inline fn vreinterpret_p8_u8(a: types.u8x8) types.p8x8 {
    return @bitCast(a);
}

test vreinterpret_p8_u8 {
    const a = std.mem.zeroes(types.u8x8);
    const expected = std.mem.zeroes(types.p8x8);
    try common.testIntrinsic("vreinterpret_p8_u8", vreinterpret_p8_u8, expected, .{a}, null);
}

/// vreinterpret_s16_f16
pub inline fn vreinterpret_s16_f16(a: types.f16x4) types.i16x4 {
    return @bitCast(a);
}

test vreinterpret_s16_f16 {
    const a = std.mem.zeroes(types.f16x4);
    const expected = std.mem.zeroes(types.i16x4);
    try common.testIntrinsic("vreinterpret_s16_f16", vreinterpret_s16_f16, expected, .{a}, null);
}

/// vreinterpret_s16_f32
pub inline fn vreinterpret_s16_f32(a: types.f32x2) types.i16x4 {
    return @bitCast(a);
}

test vreinterpret_s16_f32 {
    const a = std.mem.zeroes(types.f32x2);
    const expected = std.mem.zeroes(types.i16x4);
    try common.testIntrinsic("vreinterpret_s16_f32", vreinterpret_s16_f32, expected, .{a}, null);
}

/// vreinterpret_s16_f64
pub inline fn vreinterpret_s16_f64(a: types.f64x1) types.i16x4 {
    return @bitCast(a);
}

test vreinterpret_s16_f64 {
    const a = std.mem.zeroes(types.f64x1);
    const expected = std.mem.zeroes(types.i16x4);
    try common.testIntrinsic("vreinterpret_s16_f64", vreinterpret_s16_f64, expected, .{a}, null);
}

/// vreinterpret_s16_p16
pub inline fn vreinterpret_s16_p16(a: types.p16x4) types.i16x4 {
    return @bitCast(a);
}

test vreinterpret_s16_p16 {
    const a = std.mem.zeroes(types.p16x4);
    const expected = std.mem.zeroes(types.i16x4);
    try common.testIntrinsic("vreinterpret_s16_p16", vreinterpret_s16_p16, expected, .{a}, null);
}

/// vreinterpret_s16_p64
pub inline fn vreinterpret_s16_p64(a: types.p64x1) types.i16x4 {
    return @bitCast(a);
}

test vreinterpret_s16_p64 {
    const a = std.mem.zeroes(types.p64x1);
    const expected = std.mem.zeroes(types.i16x4);
    try common.testIntrinsic("vreinterpret_s16_p64", vreinterpret_s16_p64, expected, .{a}, null);
}

/// vreinterpret_s16_p8
pub inline fn vreinterpret_s16_p8(a: types.p8x8) types.i16x4 {
    return @bitCast(a);
}

test vreinterpret_s16_p8 {
    const a = std.mem.zeroes(types.p8x8);
    const expected = std.mem.zeroes(types.i16x4);
    try common.testIntrinsic("vreinterpret_s16_p8", vreinterpret_s16_p8, expected, .{a}, null);
}

/// vreinterpret_s16_s32
pub inline fn vreinterpret_s16_s32(a: types.i32x2) types.i16x4 {
    return @bitCast(a);
}

test vreinterpret_s16_s32 {
    const a = std.mem.zeroes(types.i32x2);
    const expected = std.mem.zeroes(types.i16x4);
    try common.testIntrinsic("vreinterpret_s16_s32", vreinterpret_s16_s32, expected, .{a}, null);
}

/// vreinterpret_s16_s64
pub inline fn vreinterpret_s16_s64(a: types.i64x1) types.i16x4 {
    return @bitCast(a);
}

test vreinterpret_s16_s64 {
    const a = std.mem.zeroes(types.i64x1);
    const expected = std.mem.zeroes(types.i16x4);
    try common.testIntrinsic("vreinterpret_s16_s64", vreinterpret_s16_s64, expected, .{a}, null);
}

/// vreinterpret_s16_s8
pub inline fn vreinterpret_s16_s8(a: types.i8x8) types.i16x4 {
    return @bitCast(a);
}

test vreinterpret_s16_s8 {
    const a = std.mem.zeroes(types.i8x8);
    const expected = std.mem.zeroes(types.i16x4);
    try common.testIntrinsic("vreinterpret_s16_s8", vreinterpret_s16_s8, expected, .{a}, null);
}

/// vreinterpret_s16_u16
pub inline fn vreinterpret_s16_u16(a: types.u16x4) types.i16x4 {
    return @bitCast(a);
}

test vreinterpret_s16_u16 {
    const a = std.mem.zeroes(types.u16x4);
    const expected = std.mem.zeroes(types.i16x4);
    try common.testIntrinsic("vreinterpret_s16_u16", vreinterpret_s16_u16, expected, .{a}, null);
}

/// vreinterpret_s16_u32
pub inline fn vreinterpret_s16_u32(a: types.u32x2) types.i16x4 {
    return @bitCast(a);
}

test vreinterpret_s16_u32 {
    const a = std.mem.zeroes(types.u32x2);
    const expected = std.mem.zeroes(types.i16x4);
    try common.testIntrinsic("vreinterpret_s16_u32", vreinterpret_s16_u32, expected, .{a}, null);
}

/// vreinterpret_s16_u64
pub inline fn vreinterpret_s16_u64(a: types.u64x1) types.i16x4 {
    return @bitCast(a);
}

test vreinterpret_s16_u64 {
    const a = std.mem.zeroes(types.u64x1);
    const expected = std.mem.zeroes(types.i16x4);
    try common.testIntrinsic("vreinterpret_s16_u64", vreinterpret_s16_u64, expected, .{a}, null);
}

/// vreinterpret_s16_u8
pub inline fn vreinterpret_s16_u8(a: types.u8x8) types.i16x4 {
    return @bitCast(a);
}

test vreinterpret_s16_u8 {
    const a = std.mem.zeroes(types.u8x8);
    const expected = std.mem.zeroes(types.i16x4);
    try common.testIntrinsic("vreinterpret_s16_u8", vreinterpret_s16_u8, expected, .{a}, null);
}

/// vreinterpret_s32_f16
pub inline fn vreinterpret_s32_f16(a: types.f16x4) types.i32x2 {
    return @bitCast(a);
}

test vreinterpret_s32_f16 {
    const a = std.mem.zeroes(types.f16x4);
    const expected = std.mem.zeroes(types.i32x2);
    try common.testIntrinsic("vreinterpret_s32_f16", vreinterpret_s32_f16, expected, .{a}, null);
}

/// vreinterpret_s32_f32
pub inline fn vreinterpret_s32_f32(a: types.f32x2) types.i32x2 {
    return @bitCast(a);
}

test vreinterpret_s32_f32 {
    const a = std.mem.zeroes(types.f32x2);
    const expected = std.mem.zeroes(types.i32x2);
    try common.testIntrinsic("vreinterpret_s32_f32", vreinterpret_s32_f32, expected, .{a}, null);
}

/// vreinterpret_s32_f64
pub inline fn vreinterpret_s32_f64(a: types.f64x1) types.i32x2 {
    return @bitCast(a);
}

test vreinterpret_s32_f64 {
    const a = std.mem.zeroes(types.f64x1);
    const expected = std.mem.zeroes(types.i32x2);
    try common.testIntrinsic("vreinterpret_s32_f64", vreinterpret_s32_f64, expected, .{a}, null);
}

/// vreinterpret_s32_p16
pub inline fn vreinterpret_s32_p16(a: types.p16x4) types.i32x2 {
    return @bitCast(a);
}

test vreinterpret_s32_p16 {
    const a = std.mem.zeroes(types.p16x4);
    const expected = std.mem.zeroes(types.i32x2);
    try common.testIntrinsic("vreinterpret_s32_p16", vreinterpret_s32_p16, expected, .{a}, null);
}

/// vreinterpret_s32_p64
pub inline fn vreinterpret_s32_p64(a: types.p64x1) types.i32x2 {
    return @bitCast(a);
}

test vreinterpret_s32_p64 {
    const a = std.mem.zeroes(types.p64x1);
    const expected = std.mem.zeroes(types.i32x2);
    try common.testIntrinsic("vreinterpret_s32_p64", vreinterpret_s32_p64, expected, .{a}, null);
}

/// vreinterpret_s32_p8
pub inline fn vreinterpret_s32_p8(a: types.p8x8) types.i32x2 {
    return @bitCast(a);
}

test vreinterpret_s32_p8 {
    const a = std.mem.zeroes(types.p8x8);
    const expected = std.mem.zeroes(types.i32x2);
    try common.testIntrinsic("vreinterpret_s32_p8", vreinterpret_s32_p8, expected, .{a}, null);
}

/// vreinterpret_s32_s16
pub inline fn vreinterpret_s32_s16(a: types.i16x4) types.i32x2 {
    return @bitCast(a);
}

test vreinterpret_s32_s16 {
    const a = std.mem.zeroes(types.i16x4);
    const expected = std.mem.zeroes(types.i32x2);
    try common.testIntrinsic("vreinterpret_s32_s16", vreinterpret_s32_s16, expected, .{a}, null);
}

/// vreinterpret_s32_s64
pub inline fn vreinterpret_s32_s64(a: types.i64x1) types.i32x2 {
    return @bitCast(a);
}

test vreinterpret_s32_s64 {
    const a = std.mem.zeroes(types.i64x1);
    const expected = std.mem.zeroes(types.i32x2);
    try common.testIntrinsic("vreinterpret_s32_s64", vreinterpret_s32_s64, expected, .{a}, null);
}

/// vreinterpret_s32_s8
pub inline fn vreinterpret_s32_s8(a: types.i8x8) types.i32x2 {
    return @bitCast(a);
}

test vreinterpret_s32_s8 {
    const a = std.mem.zeroes(types.i8x8);
    const expected = std.mem.zeroes(types.i32x2);
    try common.testIntrinsic("vreinterpret_s32_s8", vreinterpret_s32_s8, expected, .{a}, null);
}

/// vreinterpret_s32_u16
pub inline fn vreinterpret_s32_u16(a: types.u16x4) types.i32x2 {
    return @bitCast(a);
}

test vreinterpret_s32_u16 {
    const a = std.mem.zeroes(types.u16x4);
    const expected = std.mem.zeroes(types.i32x2);
    try common.testIntrinsic("vreinterpret_s32_u16", vreinterpret_s32_u16, expected, .{a}, null);
}

/// vreinterpret_s32_u32
pub inline fn vreinterpret_s32_u32(a: types.u32x2) types.i32x2 {
    return @bitCast(a);
}

test vreinterpret_s32_u32 {
    const a = std.mem.zeroes(types.u32x2);
    const expected = std.mem.zeroes(types.i32x2);
    try common.testIntrinsic("vreinterpret_s32_u32", vreinterpret_s32_u32, expected, .{a}, null);
}

/// vreinterpret_s32_u64
pub inline fn vreinterpret_s32_u64(a: types.u64x1) types.i32x2 {
    return @bitCast(a);
}

test vreinterpret_s32_u64 {
    const a = std.mem.zeroes(types.u64x1);
    const expected = std.mem.zeroes(types.i32x2);
    try common.testIntrinsic("vreinterpret_s32_u64", vreinterpret_s32_u64, expected, .{a}, null);
}

/// vreinterpret_s32_u8
pub inline fn vreinterpret_s32_u8(a: types.u8x8) types.i32x2 {
    return @bitCast(a);
}

test vreinterpret_s32_u8 {
    const a = std.mem.zeroes(types.u8x8);
    const expected = std.mem.zeroes(types.i32x2);
    try common.testIntrinsic("vreinterpret_s32_u8", vreinterpret_s32_u8, expected, .{a}, null);
}

/// vreinterpret_s64_f16
pub inline fn vreinterpret_s64_f16(a: types.f16x4) types.i64x1 {
    return @bitCast(a);
}

test vreinterpret_s64_f16 {
    const a = std.mem.zeroes(types.f16x4);
    const expected = std.mem.zeroes(types.i64x1);
    try common.testIntrinsic("vreinterpret_s64_f16", vreinterpret_s64_f16, expected, .{a}, null);
}

/// vreinterpret_s64_f32
pub inline fn vreinterpret_s64_f32(a: types.f32x2) types.i64x1 {
    return @bitCast(a);
}

test vreinterpret_s64_f32 {
    const a = std.mem.zeroes(types.f32x2);
    const expected = std.mem.zeroes(types.i64x1);
    try common.testIntrinsic("vreinterpret_s64_f32", vreinterpret_s64_f32, expected, .{a}, null);
}

/// vreinterpret_s64_f64
pub inline fn vreinterpret_s64_f64(a: types.f64x1) types.i64x1 {
    return @bitCast(a);
}

test vreinterpret_s64_f64 {
    const a = std.mem.zeroes(types.f64x1);
    const expected = std.mem.zeroes(types.i64x1);
    try common.testIntrinsic("vreinterpret_s64_f64", vreinterpret_s64_f64, expected, .{a}, null);
}

/// vreinterpret_s64_p16
pub inline fn vreinterpret_s64_p16(a: types.p16x4) types.i64x1 {
    return @bitCast(a);
}

test vreinterpret_s64_p16 {
    const a = std.mem.zeroes(types.p16x4);
    const expected = std.mem.zeroes(types.i64x1);
    try common.testIntrinsic("vreinterpret_s64_p16", vreinterpret_s64_p16, expected, .{a}, null);
}

/// vreinterpret_s64_p64
pub inline fn vreinterpret_s64_p64(a: types.p64x1) types.i64x1 {
    return @bitCast(a);
}

test vreinterpret_s64_p64 {
    const a = std.mem.zeroes(types.p64x1);
    const expected = std.mem.zeroes(types.i64x1);
    try common.testIntrinsic("vreinterpret_s64_p64", vreinterpret_s64_p64, expected, .{a}, null);
}

/// vreinterpret_s64_p8
pub inline fn vreinterpret_s64_p8(a: types.p8x8) types.i64x1 {
    return @bitCast(a);
}

test vreinterpret_s64_p8 {
    const a = std.mem.zeroes(types.p8x8);
    const expected = std.mem.zeroes(types.i64x1);
    try common.testIntrinsic("vreinterpret_s64_p8", vreinterpret_s64_p8, expected, .{a}, null);
}

/// vreinterpret_s64_s16
pub inline fn vreinterpret_s64_s16(a: types.i16x4) types.i64x1 {
    return @bitCast(a);
}

test vreinterpret_s64_s16 {
    const a = std.mem.zeroes(types.i16x4);
    const expected = std.mem.zeroes(types.i64x1);
    try common.testIntrinsic("vreinterpret_s64_s16", vreinterpret_s64_s16, expected, .{a}, null);
}

/// vreinterpret_s64_s32
pub inline fn vreinterpret_s64_s32(a: types.i32x2) types.i64x1 {
    return @bitCast(a);
}

test vreinterpret_s64_s32 {
    const a = std.mem.zeroes(types.i32x2);
    const expected = std.mem.zeroes(types.i64x1);
    try common.testIntrinsic("vreinterpret_s64_s32", vreinterpret_s64_s32, expected, .{a}, null);
}

/// vreinterpret_s64_s8
pub inline fn vreinterpret_s64_s8(a: types.i8x8) types.i64x1 {
    return @bitCast(a);
}

test vreinterpret_s64_s8 {
    const a = std.mem.zeroes(types.i8x8);
    const expected = std.mem.zeroes(types.i64x1);
    try common.testIntrinsic("vreinterpret_s64_s8", vreinterpret_s64_s8, expected, .{a}, null);
}

/// vreinterpret_s64_u16
pub inline fn vreinterpret_s64_u16(a: types.u16x4) types.i64x1 {
    return @bitCast(a);
}

test vreinterpret_s64_u16 {
    const a = std.mem.zeroes(types.u16x4);
    const expected = std.mem.zeroes(types.i64x1);
    try common.testIntrinsic("vreinterpret_s64_u16", vreinterpret_s64_u16, expected, .{a}, null);
}

/// vreinterpret_s64_u32
pub inline fn vreinterpret_s64_u32(a: types.u32x2) types.i64x1 {
    return @bitCast(a);
}

test vreinterpret_s64_u32 {
    const a = std.mem.zeroes(types.u32x2);
    const expected = std.mem.zeroes(types.i64x1);
    try common.testIntrinsic("vreinterpret_s64_u32", vreinterpret_s64_u32, expected, .{a}, null);
}

/// vreinterpret_s64_u64
pub inline fn vreinterpret_s64_u64(a: types.u64x1) types.i64x1 {
    return @bitCast(a);
}

test vreinterpret_s64_u64 {
    const a = std.mem.zeroes(types.u64x1);
    const expected = std.mem.zeroes(types.i64x1);
    try common.testIntrinsic("vreinterpret_s64_u64", vreinterpret_s64_u64, expected, .{a}, null);
}

/// vreinterpret_s64_u8
pub inline fn vreinterpret_s64_u8(a: types.u8x8) types.i64x1 {
    return @bitCast(a);
}

test vreinterpret_s64_u8 {
    const a = std.mem.zeroes(types.u8x8);
    const expected = std.mem.zeroes(types.i64x1);
    try common.testIntrinsic("vreinterpret_s64_u8", vreinterpret_s64_u8, expected, .{a}, null);
}

/// vreinterpret_s8_f16
pub inline fn vreinterpret_s8_f16(a: types.f16x4) types.i8x8 {
    return @bitCast(a);
}

test vreinterpret_s8_f16 {
    const a = std.mem.zeroes(types.f16x4);
    const expected = std.mem.zeroes(types.i8x8);
    try common.testIntrinsic("vreinterpret_s8_f16", vreinterpret_s8_f16, expected, .{a}, null);
}

/// vreinterpret_s8_f32
pub inline fn vreinterpret_s8_f32(a: types.f32x2) types.i8x8 {
    return @bitCast(a);
}

test vreinterpret_s8_f32 {
    const a = std.mem.zeroes(types.f32x2);
    const expected = std.mem.zeroes(types.i8x8);
    try common.testIntrinsic("vreinterpret_s8_f32", vreinterpret_s8_f32, expected, .{a}, null);
}

/// vreinterpret_s8_f64
pub inline fn vreinterpret_s8_f64(a: types.f64x1) types.i8x8 {
    return @bitCast(a);
}

test vreinterpret_s8_f64 {
    const a = std.mem.zeroes(types.f64x1);
    const expected = std.mem.zeroes(types.i8x8);
    try common.testIntrinsic("vreinterpret_s8_f64", vreinterpret_s8_f64, expected, .{a}, null);
}

/// vreinterpret_s8_p16
pub inline fn vreinterpret_s8_p16(a: types.p16x4) types.i8x8 {
    return @bitCast(a);
}

test vreinterpret_s8_p16 {
    const a = std.mem.zeroes(types.p16x4);
    const expected = std.mem.zeroes(types.i8x8);
    try common.testIntrinsic("vreinterpret_s8_p16", vreinterpret_s8_p16, expected, .{a}, null);
}

/// vreinterpret_s8_p64
pub inline fn vreinterpret_s8_p64(a: types.p64x1) types.i8x8 {
    return @bitCast(a);
}

test vreinterpret_s8_p64 {
    const a = std.mem.zeroes(types.p64x1);
    const expected = std.mem.zeroes(types.i8x8);
    try common.testIntrinsic("vreinterpret_s8_p64", vreinterpret_s8_p64, expected, .{a}, null);
}

/// vreinterpret_s8_p8
pub inline fn vreinterpret_s8_p8(a: types.p8x8) types.i8x8 {
    return @bitCast(a);
}

test vreinterpret_s8_p8 {
    const a = std.mem.zeroes(types.p8x8);
    const expected = std.mem.zeroes(types.i8x8);
    try common.testIntrinsic("vreinterpret_s8_p8", vreinterpret_s8_p8, expected, .{a}, null);
}

/// vreinterpret_s8_s16
pub inline fn vreinterpret_s8_s16(a: types.i16x4) types.i8x8 {
    return @bitCast(a);
}

test vreinterpret_s8_s16 {
    const a = std.mem.zeroes(types.i16x4);
    const expected = std.mem.zeroes(types.i8x8);
    try common.testIntrinsic("vreinterpret_s8_s16", vreinterpret_s8_s16, expected, .{a}, null);
}

/// vreinterpret_s8_s32
pub inline fn vreinterpret_s8_s32(a: types.i32x2) types.i8x8 {
    return @bitCast(a);
}

test vreinterpret_s8_s32 {
    const a = std.mem.zeroes(types.i32x2);
    const expected = std.mem.zeroes(types.i8x8);
    try common.testIntrinsic("vreinterpret_s8_s32", vreinterpret_s8_s32, expected, .{a}, null);
}

/// vreinterpret_s8_s64
pub inline fn vreinterpret_s8_s64(a: types.i64x1) types.i8x8 {
    return @bitCast(a);
}

test vreinterpret_s8_s64 {
    const a = std.mem.zeroes(types.i64x1);
    const expected = std.mem.zeroes(types.i8x8);
    try common.testIntrinsic("vreinterpret_s8_s64", vreinterpret_s8_s64, expected, .{a}, null);
}

/// vreinterpret_s8_u16
pub inline fn vreinterpret_s8_u16(a: types.u16x4) types.i8x8 {
    return @bitCast(a);
}

test vreinterpret_s8_u16 {
    const a = std.mem.zeroes(types.u16x4);
    const expected = std.mem.zeroes(types.i8x8);
    try common.testIntrinsic("vreinterpret_s8_u16", vreinterpret_s8_u16, expected, .{a}, null);
}

/// vreinterpret_s8_u32
pub inline fn vreinterpret_s8_u32(a: types.u32x2) types.i8x8 {
    return @bitCast(a);
}

test vreinterpret_s8_u32 {
    const a = std.mem.zeroes(types.u32x2);
    const expected = std.mem.zeroes(types.i8x8);
    try common.testIntrinsic("vreinterpret_s8_u32", vreinterpret_s8_u32, expected, .{a}, null);
}

/// vreinterpret_s8_u64
pub inline fn vreinterpret_s8_u64(a: types.u64x1) types.i8x8 {
    return @bitCast(a);
}

test vreinterpret_s8_u64 {
    const a = std.mem.zeroes(types.u64x1);
    const expected = std.mem.zeroes(types.i8x8);
    try common.testIntrinsic("vreinterpret_s8_u64", vreinterpret_s8_u64, expected, .{a}, null);
}

/// vreinterpret_s8_u8
pub inline fn vreinterpret_s8_u8(a: types.u8x8) types.i8x8 {
    return @bitCast(a);
}

test vreinterpret_s8_u8 {
    const a = std.mem.zeroes(types.u8x8);
    const expected = std.mem.zeroes(types.i8x8);
    try common.testIntrinsic("vreinterpret_s8_u8", vreinterpret_s8_u8, expected, .{a}, null);
}

/// vreinterpret_u16_f16
pub inline fn vreinterpret_u16_f16(a: types.f16x4) types.u16x4 {
    return @bitCast(a);
}

test vreinterpret_u16_f16 {
    const a = std.mem.zeroes(types.f16x4);
    const expected = std.mem.zeroes(types.u16x4);
    try common.testIntrinsic("vreinterpret_u16_f16", vreinterpret_u16_f16, expected, .{a}, null);
}

/// vreinterpret_u16_f32
pub inline fn vreinterpret_u16_f32(a: types.f32x2) types.u16x4 {
    return @bitCast(a);
}

test vreinterpret_u16_f32 {
    const a = std.mem.zeroes(types.f32x2);
    const expected = std.mem.zeroes(types.u16x4);
    try common.testIntrinsic("vreinterpret_u16_f32", vreinterpret_u16_f32, expected, .{a}, null);
}

/// vreinterpret_u16_f64
pub inline fn vreinterpret_u16_f64(a: types.f64x1) types.u16x4 {
    return @bitCast(a);
}

test vreinterpret_u16_f64 {
    const a = std.mem.zeroes(types.f64x1);
    const expected = std.mem.zeroes(types.u16x4);
    try common.testIntrinsic("vreinterpret_u16_f64", vreinterpret_u16_f64, expected, .{a}, null);
}

/// vreinterpret_u16_p16
pub inline fn vreinterpret_u16_p16(a: types.p16x4) types.u16x4 {
    return @bitCast(a);
}

test vreinterpret_u16_p16 {
    const a = std.mem.zeroes(types.p16x4);
    const expected = std.mem.zeroes(types.u16x4);
    try common.testIntrinsic("vreinterpret_u16_p16", vreinterpret_u16_p16, expected, .{a}, null);
}

/// vreinterpret_u16_p64
pub inline fn vreinterpret_u16_p64(a: types.p64x1) types.u16x4 {
    return @bitCast(a);
}

test vreinterpret_u16_p64 {
    const a = std.mem.zeroes(types.p64x1);
    const expected = std.mem.zeroes(types.u16x4);
    try common.testIntrinsic("vreinterpret_u16_p64", vreinterpret_u16_p64, expected, .{a}, null);
}

/// vreinterpret_u16_p8
pub inline fn vreinterpret_u16_p8(a: types.p8x8) types.u16x4 {
    return @bitCast(a);
}

test vreinterpret_u16_p8 {
    const a = std.mem.zeroes(types.p8x8);
    const expected = std.mem.zeroes(types.u16x4);
    try common.testIntrinsic("vreinterpret_u16_p8", vreinterpret_u16_p8, expected, .{a}, null);
}

/// vreinterpret_u16_s16
pub inline fn vreinterpret_u16_s16(a: types.i16x4) types.u16x4 {
    return @bitCast(a);
}

test vreinterpret_u16_s16 {
    const a = std.mem.zeroes(types.i16x4);
    const expected = std.mem.zeroes(types.u16x4);
    try common.testIntrinsic("vreinterpret_u16_s16", vreinterpret_u16_s16, expected, .{a}, null);
}

/// vreinterpret_u16_s32
pub inline fn vreinterpret_u16_s32(a: types.i32x2) types.u16x4 {
    return @bitCast(a);
}

test vreinterpret_u16_s32 {
    const a = std.mem.zeroes(types.i32x2);
    const expected = std.mem.zeroes(types.u16x4);
    try common.testIntrinsic("vreinterpret_u16_s32", vreinterpret_u16_s32, expected, .{a}, null);
}

/// vreinterpret_u16_s64
pub inline fn vreinterpret_u16_s64(a: types.i64x1) types.u16x4 {
    return @bitCast(a);
}

test vreinterpret_u16_s64 {
    const a = std.mem.zeroes(types.i64x1);
    const expected = std.mem.zeroes(types.u16x4);
    try common.testIntrinsic("vreinterpret_u16_s64", vreinterpret_u16_s64, expected, .{a}, null);
}

/// vreinterpret_u16_s8
pub inline fn vreinterpret_u16_s8(a: types.i8x8) types.u16x4 {
    return @bitCast(a);
}

test vreinterpret_u16_s8 {
    const a = std.mem.zeroes(types.i8x8);
    const expected = std.mem.zeroes(types.u16x4);
    try common.testIntrinsic("vreinterpret_u16_s8", vreinterpret_u16_s8, expected, .{a}, null);
}

/// vreinterpret_u16_u32
pub inline fn vreinterpret_u16_u32(a: types.u32x2) types.u16x4 {
    return @bitCast(a);
}

test vreinterpret_u16_u32 {
    const a = std.mem.zeroes(types.u32x2);
    const expected = std.mem.zeroes(types.u16x4);
    try common.testIntrinsic("vreinterpret_u16_u32", vreinterpret_u16_u32, expected, .{a}, null);
}

/// vreinterpret_u16_u64
pub inline fn vreinterpret_u16_u64(a: types.u64x1) types.u16x4 {
    return @bitCast(a);
}

test vreinterpret_u16_u64 {
    const a = std.mem.zeroes(types.u64x1);
    const expected = std.mem.zeroes(types.u16x4);
    try common.testIntrinsic("vreinterpret_u16_u64", vreinterpret_u16_u64, expected, .{a}, null);
}

/// vreinterpret_u16_u8
pub inline fn vreinterpret_u16_u8(a: types.u8x8) types.u16x4 {
    return @bitCast(a);
}

test vreinterpret_u16_u8 {
    const a = std.mem.zeroes(types.u8x8);
    const expected = std.mem.zeroes(types.u16x4);
    try common.testIntrinsic("vreinterpret_u16_u8", vreinterpret_u16_u8, expected, .{a}, null);
}

/// vreinterpret_u32_f16
pub inline fn vreinterpret_u32_f16(a: types.f16x4) types.u32x2 {
    return @bitCast(a);
}

test vreinterpret_u32_f16 {
    const a = std.mem.zeroes(types.f16x4);
    const expected = std.mem.zeroes(types.u32x2);
    try common.testIntrinsic("vreinterpret_u32_f16", vreinterpret_u32_f16, expected, .{a}, null);
}

/// vreinterpret_u32_f32
pub inline fn vreinterpret_u32_f32(a: types.f32x2) types.u32x2 {
    return @bitCast(a);
}

test vreinterpret_u32_f32 {
    const a = std.mem.zeroes(types.f32x2);
    const expected = std.mem.zeroes(types.u32x2);
    try common.testIntrinsic("vreinterpret_u32_f32", vreinterpret_u32_f32, expected, .{a}, null);
}

/// vreinterpret_u32_f64
pub inline fn vreinterpret_u32_f64(a: types.f64x1) types.u32x2 {
    return @bitCast(a);
}

test vreinterpret_u32_f64 {
    const a = std.mem.zeroes(types.f64x1);
    const expected = std.mem.zeroes(types.u32x2);
    try common.testIntrinsic("vreinterpret_u32_f64", vreinterpret_u32_f64, expected, .{a}, null);
}

/// vreinterpret_u32_p16
pub inline fn vreinterpret_u32_p16(a: types.p16x4) types.u32x2 {
    return @bitCast(a);
}

test vreinterpret_u32_p16 {
    const a = std.mem.zeroes(types.p16x4);
    const expected = std.mem.zeroes(types.u32x2);
    try common.testIntrinsic("vreinterpret_u32_p16", vreinterpret_u32_p16, expected, .{a}, null);
}

/// vreinterpret_u32_p64
pub inline fn vreinterpret_u32_p64(a: types.p64x1) types.u32x2 {
    return @bitCast(a);
}

test vreinterpret_u32_p64 {
    const a = std.mem.zeroes(types.p64x1);
    const expected = std.mem.zeroes(types.u32x2);
    try common.testIntrinsic("vreinterpret_u32_p64", vreinterpret_u32_p64, expected, .{a}, null);
}

/// vreinterpret_u32_p8
pub inline fn vreinterpret_u32_p8(a: types.p8x8) types.u32x2 {
    return @bitCast(a);
}

test vreinterpret_u32_p8 {
    const a = std.mem.zeroes(types.p8x8);
    const expected = std.mem.zeroes(types.u32x2);
    try common.testIntrinsic("vreinterpret_u32_p8", vreinterpret_u32_p8, expected, .{a}, null);
}

/// vreinterpret_u32_s16
pub inline fn vreinterpret_u32_s16(a: types.i16x4) types.u32x2 {
    return @bitCast(a);
}

test vreinterpret_u32_s16 {
    const a = std.mem.zeroes(types.i16x4);
    const expected = std.mem.zeroes(types.u32x2);
    try common.testIntrinsic("vreinterpret_u32_s16", vreinterpret_u32_s16, expected, .{a}, null);
}

/// vreinterpret_u32_s32
pub inline fn vreinterpret_u32_s32(a: types.i32x2) types.u32x2 {
    return @bitCast(a);
}

test vreinterpret_u32_s32 {
    const a = std.mem.zeroes(types.i32x2);
    const expected = std.mem.zeroes(types.u32x2);
    try common.testIntrinsic("vreinterpret_u32_s32", vreinterpret_u32_s32, expected, .{a}, null);
}

/// vreinterpret_u32_s64
pub inline fn vreinterpret_u32_s64(a: types.i64x1) types.u32x2 {
    return @bitCast(a);
}

test vreinterpret_u32_s64 {
    const a = std.mem.zeroes(types.i64x1);
    const expected = std.mem.zeroes(types.u32x2);
    try common.testIntrinsic("vreinterpret_u32_s64", vreinterpret_u32_s64, expected, .{a}, null);
}

/// vreinterpret_u32_s8
pub inline fn vreinterpret_u32_s8(a: types.i8x8) types.u32x2 {
    return @bitCast(a);
}

test vreinterpret_u32_s8 {
    const a = std.mem.zeroes(types.i8x8);
    const expected = std.mem.zeroes(types.u32x2);
    try common.testIntrinsic("vreinterpret_u32_s8", vreinterpret_u32_s8, expected, .{a}, null);
}

/// vreinterpret_u32_u16
pub inline fn vreinterpret_u32_u16(a: types.u16x4) types.u32x2 {
    return @bitCast(a);
}

test vreinterpret_u32_u16 {
    const a = std.mem.zeroes(types.u16x4);
    const expected = std.mem.zeroes(types.u32x2);
    try common.testIntrinsic("vreinterpret_u32_u16", vreinterpret_u32_u16, expected, .{a}, null);
}

/// vreinterpret_u32_u64
pub inline fn vreinterpret_u32_u64(a: types.u64x1) types.u32x2 {
    return @bitCast(a);
}

test vreinterpret_u32_u64 {
    const a = std.mem.zeroes(types.u64x1);
    const expected = std.mem.zeroes(types.u32x2);
    try common.testIntrinsic("vreinterpret_u32_u64", vreinterpret_u32_u64, expected, .{a}, null);
}

/// vreinterpret_u32_u8
pub inline fn vreinterpret_u32_u8(a: types.u8x8) types.u32x2 {
    return @bitCast(a);
}

test vreinterpret_u32_u8 {
    const a = std.mem.zeroes(types.u8x8);
    const expected = std.mem.zeroes(types.u32x2);
    try common.testIntrinsic("vreinterpret_u32_u8", vreinterpret_u32_u8, expected, .{a}, null);
}

/// vreinterpret_u64_f16
pub inline fn vreinterpret_u64_f16(a: types.f16x4) types.u64x1 {
    return @bitCast(a);
}

test vreinterpret_u64_f16 {
    const a = std.mem.zeroes(types.f16x4);
    const expected = std.mem.zeroes(types.u64x1);
    try common.testIntrinsic("vreinterpret_u64_f16", vreinterpret_u64_f16, expected, .{a}, null);
}

/// vreinterpret_u64_f32
pub inline fn vreinterpret_u64_f32(a: types.f32x2) types.u64x1 {
    return @bitCast(a);
}

test vreinterpret_u64_f32 {
    const a = std.mem.zeroes(types.f32x2);
    const expected = std.mem.zeroes(types.u64x1);
    try common.testIntrinsic("vreinterpret_u64_f32", vreinterpret_u64_f32, expected, .{a}, null);
}

/// vreinterpret_u64_f64
pub inline fn vreinterpret_u64_f64(a: types.f64x1) types.u64x1 {
    return @bitCast(a);
}

test vreinterpret_u64_f64 {
    const a = std.mem.zeroes(types.f64x1);
    const expected = std.mem.zeroes(types.u64x1);
    try common.testIntrinsic("vreinterpret_u64_f64", vreinterpret_u64_f64, expected, .{a}, null);
}

/// vreinterpret_u64_p16
pub inline fn vreinterpret_u64_p16(a: types.p16x4) types.u64x1 {
    return @bitCast(a);
}

test vreinterpret_u64_p16 {
    const a = std.mem.zeroes(types.p16x4);
    const expected = std.mem.zeroes(types.u64x1);
    try common.testIntrinsic("vreinterpret_u64_p16", vreinterpret_u64_p16, expected, .{a}, null);
}

/// vreinterpret_u64_p64
pub inline fn vreinterpret_u64_p64(a: types.p64x1) types.u64x1 {
    return @bitCast(a);
}

test vreinterpret_u64_p64 {
    const a = std.mem.zeroes(types.p64x1);
    const expected = std.mem.zeroes(types.u64x1);
    try common.testIntrinsic("vreinterpret_u64_p64", vreinterpret_u64_p64, expected, .{a}, null);
}

/// vreinterpret_u64_p8
pub inline fn vreinterpret_u64_p8(a: types.p8x8) types.u64x1 {
    return @bitCast(a);
}

test vreinterpret_u64_p8 {
    const a = std.mem.zeroes(types.p8x8);
    const expected = std.mem.zeroes(types.u64x1);
    try common.testIntrinsic("vreinterpret_u64_p8", vreinterpret_u64_p8, expected, .{a}, null);
}

/// vreinterpret_u64_s16
pub inline fn vreinterpret_u64_s16(a: types.i16x4) types.u64x1 {
    return @bitCast(a);
}

test vreinterpret_u64_s16 {
    const a = std.mem.zeroes(types.i16x4);
    const expected = std.mem.zeroes(types.u64x1);
    try common.testIntrinsic("vreinterpret_u64_s16", vreinterpret_u64_s16, expected, .{a}, null);
}

/// vreinterpret_u64_s32
pub inline fn vreinterpret_u64_s32(a: types.i32x2) types.u64x1 {
    return @bitCast(a);
}

test vreinterpret_u64_s32 {
    const a = std.mem.zeroes(types.i32x2);
    const expected = std.mem.zeroes(types.u64x1);
    try common.testIntrinsic("vreinterpret_u64_s32", vreinterpret_u64_s32, expected, .{a}, null);
}

/// vreinterpret_u64_s64
pub inline fn vreinterpret_u64_s64(a: types.i64x1) types.u64x1 {
    return @bitCast(a);
}

test vreinterpret_u64_s64 {
    const a = std.mem.zeroes(types.i64x1);
    const expected = std.mem.zeroes(types.u64x1);
    try common.testIntrinsic("vreinterpret_u64_s64", vreinterpret_u64_s64, expected, .{a}, null);
}

/// vreinterpret_u64_s8
pub inline fn vreinterpret_u64_s8(a: types.i8x8) types.u64x1 {
    return @bitCast(a);
}

test vreinterpret_u64_s8 {
    const a = std.mem.zeroes(types.i8x8);
    const expected = std.mem.zeroes(types.u64x1);
    try common.testIntrinsic("vreinterpret_u64_s8", vreinterpret_u64_s8, expected, .{a}, null);
}

/// vreinterpret_u64_u16
pub inline fn vreinterpret_u64_u16(a: types.u16x4) types.u64x1 {
    return @bitCast(a);
}

test vreinterpret_u64_u16 {
    const a = std.mem.zeroes(types.u16x4);
    const expected = std.mem.zeroes(types.u64x1);
    try common.testIntrinsic("vreinterpret_u64_u16", vreinterpret_u64_u16, expected, .{a}, null);
}

/// vreinterpret_u64_u32
pub inline fn vreinterpret_u64_u32(a: types.u32x2) types.u64x1 {
    return @bitCast(a);
}

test vreinterpret_u64_u32 {
    const a = std.mem.zeroes(types.u32x2);
    const expected = std.mem.zeroes(types.u64x1);
    try common.testIntrinsic("vreinterpret_u64_u32", vreinterpret_u64_u32, expected, .{a}, null);
}

/// vreinterpret_u64_u8
pub inline fn vreinterpret_u64_u8(a: types.u8x8) types.u64x1 {
    return @bitCast(a);
}

test vreinterpret_u64_u8 {
    const a = std.mem.zeroes(types.u8x8);
    const expected = std.mem.zeroes(types.u64x1);
    try common.testIntrinsic("vreinterpret_u64_u8", vreinterpret_u64_u8, expected, .{a}, null);
}

/// vreinterpret_u8_f16
pub inline fn vreinterpret_u8_f16(a: types.f16x4) types.u8x8 {
    return @bitCast(a);
}

test vreinterpret_u8_f16 {
    const a = std.mem.zeroes(types.f16x4);
    const expected = std.mem.zeroes(types.u8x8);
    try common.testIntrinsic("vreinterpret_u8_f16", vreinterpret_u8_f16, expected, .{a}, null);
}

/// vreinterpret_u8_f32
pub inline fn vreinterpret_u8_f32(a: types.f32x2) types.u8x8 {
    return @bitCast(a);
}

test vreinterpret_u8_f32 {
    const a = std.mem.zeroes(types.f32x2);
    const expected = std.mem.zeroes(types.u8x8);
    try common.testIntrinsic("vreinterpret_u8_f32", vreinterpret_u8_f32, expected, .{a}, null);
}

/// vreinterpret_u8_f64
pub inline fn vreinterpret_u8_f64(a: types.f64x1) types.u8x8 {
    return @bitCast(a);
}

test vreinterpret_u8_f64 {
    const a = std.mem.zeroes(types.f64x1);
    const expected = std.mem.zeroes(types.u8x8);
    try common.testIntrinsic("vreinterpret_u8_f64", vreinterpret_u8_f64, expected, .{a}, null);
}

/// vreinterpret_u8_p16
pub inline fn vreinterpret_u8_p16(a: types.p16x4) types.u8x8 {
    return @bitCast(a);
}

test vreinterpret_u8_p16 {
    const a = std.mem.zeroes(types.p16x4);
    const expected = std.mem.zeroes(types.u8x8);
    try common.testIntrinsic("vreinterpret_u8_p16", vreinterpret_u8_p16, expected, .{a}, null);
}

/// vreinterpret_u8_p64
pub inline fn vreinterpret_u8_p64(a: types.p64x1) types.u8x8 {
    return @bitCast(a);
}

test vreinterpret_u8_p64 {
    const a = std.mem.zeroes(types.p64x1);
    const expected = std.mem.zeroes(types.u8x8);
    try common.testIntrinsic("vreinterpret_u8_p64", vreinterpret_u8_p64, expected, .{a}, null);
}

/// vreinterpret_u8_p8
pub inline fn vreinterpret_u8_p8(a: types.p8x8) types.u8x8 {
    return @bitCast(a);
}

test vreinterpret_u8_p8 {
    const a = std.mem.zeroes(types.p8x8);
    const expected = std.mem.zeroes(types.u8x8);
    try common.testIntrinsic("vreinterpret_u8_p8", vreinterpret_u8_p8, expected, .{a}, null);
}

/// vreinterpret_u8_s16
pub inline fn vreinterpret_u8_s16(a: types.i16x4) types.u8x8 {
    return @bitCast(a);
}

test vreinterpret_u8_s16 {
    const a = std.mem.zeroes(types.i16x4);
    const expected = std.mem.zeroes(types.u8x8);
    try common.testIntrinsic("vreinterpret_u8_s16", vreinterpret_u8_s16, expected, .{a}, null);
}

/// vreinterpret_u8_s32
pub inline fn vreinterpret_u8_s32(a: types.i32x2) types.u8x8 {
    return @bitCast(a);
}

test vreinterpret_u8_s32 {
    const a = std.mem.zeroes(types.i32x2);
    const expected = std.mem.zeroes(types.u8x8);
    try common.testIntrinsic("vreinterpret_u8_s32", vreinterpret_u8_s32, expected, .{a}, null);
}

/// vreinterpret_u8_s64
pub inline fn vreinterpret_u8_s64(a: types.i64x1) types.u8x8 {
    return @bitCast(a);
}

test vreinterpret_u8_s64 {
    const a = std.mem.zeroes(types.i64x1);
    const expected = std.mem.zeroes(types.u8x8);
    try common.testIntrinsic("vreinterpret_u8_s64", vreinterpret_u8_s64, expected, .{a}, null);
}

/// vreinterpret_u8_s8
pub inline fn vreinterpret_u8_s8(a: types.i8x8) types.u8x8 {
    return @bitCast(a);
}

test vreinterpret_u8_s8 {
    const a = std.mem.zeroes(types.i8x8);
    const expected = std.mem.zeroes(types.u8x8);
    try common.testIntrinsic("vreinterpret_u8_s8", vreinterpret_u8_s8, expected, .{a}, null);
}

/// vreinterpret_u8_u16
pub inline fn vreinterpret_u8_u16(a: types.u16x4) types.u8x8 {
    return @bitCast(a);
}

test vreinterpret_u8_u16 {
    const a = std.mem.zeroes(types.u16x4);
    const expected = std.mem.zeroes(types.u8x8);
    try common.testIntrinsic("vreinterpret_u8_u16", vreinterpret_u8_u16, expected, .{a}, null);
}

/// vreinterpret_u8_u32
pub inline fn vreinterpret_u8_u32(a: types.u32x2) types.u8x8 {
    return @bitCast(a);
}

test vreinterpret_u8_u32 {
    const a = std.mem.zeroes(types.u32x2);
    const expected = std.mem.zeroes(types.u8x8);
    try common.testIntrinsic("vreinterpret_u8_u32", vreinterpret_u8_u32, expected, .{a}, null);
}

/// vreinterpret_u8_u64
pub inline fn vreinterpret_u8_u64(a: types.u64x1) types.u8x8 {
    return @bitCast(a);
}

test vreinterpret_u8_u64 {
    const a = std.mem.zeroes(types.u64x1);
    const expected = std.mem.zeroes(types.u8x8);
    try common.testIntrinsic("vreinterpret_u8_u64", vreinterpret_u8_u64, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_f16_f32(a: types.f32x4) types.f16x8 {
    return @bitCast(a);
}

test vreinterpretq_f16_f32 {
    const a = std.mem.zeroes(types.f32x4);
    const expected = std.mem.zeroes(types.f16x8);
    try common.testIntrinsic("vreinterpretq_f16_f32", vreinterpretq_f16_f32, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_f16_f64(a: types.f64x2) types.f16x8 {
    return @bitCast(a);
}

test vreinterpretq_f16_f64 {
    const a = std.mem.zeroes(types.f64x2);
    const expected = std.mem.zeroes(types.f16x8);
    try common.testIntrinsic("vreinterpretq_f16_f64", vreinterpretq_f16_f64, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_f16_p128(a: types.p128) types.f16x8 {
    return @bitCast(a);
}

test vreinterpretq_f16_p128 {
    const a = std.mem.zeroes(types.p128);
    const expected = std.mem.zeroes(types.f16x8);
    try common.testIntrinsic("vreinterpretq_f16_p128", vreinterpretq_f16_p128, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_f16_p16(a: types.p16x8) types.f16x8 {
    return @bitCast(a);
}

test vreinterpretq_f16_p16 {
    const a = std.mem.zeroes(types.p16x8);
    const expected = std.mem.zeroes(types.f16x8);
    try common.testIntrinsic("vreinterpretq_f16_p16", vreinterpretq_f16_p16, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_f16_p64(a: types.p64x2) types.f16x8 {
    return @bitCast(a);
}

test vreinterpretq_f16_p64 {
    const a = std.mem.zeroes(types.p64x2);
    const expected = std.mem.zeroes(types.f16x8);
    try common.testIntrinsic("vreinterpretq_f16_p64", vreinterpretq_f16_p64, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_f16_p8(a: types.p8x16) types.f16x8 {
    return @bitCast(a);
}

test vreinterpretq_f16_p8 {
    const a = std.mem.zeroes(types.p8x16);
    const expected = std.mem.zeroes(types.f16x8);
    try common.testIntrinsic("vreinterpretq_f16_p8", vreinterpretq_f16_p8, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_f16_s16(a: types.i16x8) types.f16x8 {
    return @bitCast(a);
}

test vreinterpretq_f16_s16 {
    const a = std.mem.zeroes(types.i16x8);
    const expected = std.mem.zeroes(types.f16x8);
    try common.testIntrinsic("vreinterpretq_f16_s16", vreinterpretq_f16_s16, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_f16_s32(a: types.i32x4) types.f16x8 {
    return @bitCast(a);
}

test vreinterpretq_f16_s32 {
    const a = std.mem.zeroes(types.i32x4);
    const expected = std.mem.zeroes(types.f16x8);
    try common.testIntrinsic("vreinterpretq_f16_s32", vreinterpretq_f16_s32, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_f16_s64(a: types.i64x2) types.f16x8 {
    return @bitCast(a);
}

test vreinterpretq_f16_s64 {
    const a = std.mem.zeroes(types.i64x2);
    const expected = std.mem.zeroes(types.f16x8);
    try common.testIntrinsic("vreinterpretq_f16_s64", vreinterpretq_f16_s64, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_f16_s8(a: types.i8x16) types.f16x8 {
    return @bitCast(a);
}

test vreinterpretq_f16_s8 {
    const a = std.mem.zeroes(types.i8x16);
    const expected = std.mem.zeroes(types.f16x8);
    try common.testIntrinsic("vreinterpretq_f16_s8", vreinterpretq_f16_s8, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_f16_u16(a: types.u16x8) types.f16x8 {
    return @bitCast(a);
}

test vreinterpretq_f16_u16 {
    const a = std.mem.zeroes(types.u16x8);
    const expected = std.mem.zeroes(types.f16x8);
    try common.testIntrinsic("vreinterpretq_f16_u16", vreinterpretq_f16_u16, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_f16_u32(a: types.u32x4) types.f16x8 {
    return @bitCast(a);
}

test vreinterpretq_f16_u32 {
    const a = std.mem.zeroes(types.u32x4);
    const expected = std.mem.zeroes(types.f16x8);
    try common.testIntrinsic("vreinterpretq_f16_u32", vreinterpretq_f16_u32, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_f16_u64(a: types.u64x2) types.f16x8 {
    return @bitCast(a);
}

test vreinterpretq_f16_u64 {
    const a = std.mem.zeroes(types.u64x2);
    const expected = std.mem.zeroes(types.f16x8);
    try common.testIntrinsic("vreinterpretq_f16_u64", vreinterpretq_f16_u64, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_f16_u8(a: types.u8x16) types.f16x8 {
    return @bitCast(a);
}

test vreinterpretq_f16_u8 {
    const a = std.mem.zeroes(types.u8x16);
    const expected = std.mem.zeroes(types.f16x8);
    try common.testIntrinsic("vreinterpretq_f16_u8", vreinterpretq_f16_u8, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_f32_f16(a: types.f16x8) types.f32x4 {
    return @bitCast(a);
}

test vreinterpretq_f32_f16 {
    const a = std.mem.zeroes(types.f16x8);
    const expected = std.mem.zeroes(types.f32x4);
    try common.testIntrinsic("vreinterpretq_f32_f16", vreinterpretq_f32_f16, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_f32_f64(a: types.f64x2) types.f32x4 {
    return @bitCast(a);
}

test vreinterpretq_f32_f64 {
    const a = std.mem.zeroes(types.f64x2);
    const expected = std.mem.zeroes(types.f32x4);
    try common.testIntrinsic("vreinterpretq_f32_f64", vreinterpretq_f32_f64, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_f32_p128(a: types.p128) types.f32x4 {
    return @bitCast(a);
}

test vreinterpretq_f32_p128 {
    const a = std.mem.zeroes(types.p128);
    const expected = std.mem.zeroes(types.f32x4);
    try common.testIntrinsic("vreinterpretq_f32_p128", vreinterpretq_f32_p128, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_f32_p16(a: types.p16x8) types.f32x4 {
    return @bitCast(a);
}

test vreinterpretq_f32_p16 {
    const a = std.mem.zeroes(types.p16x8);
    const expected = std.mem.zeroes(types.f32x4);
    try common.testIntrinsic("vreinterpretq_f32_p16", vreinterpretq_f32_p16, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_f32_p64(a: types.p64x2) types.f32x4 {
    return @bitCast(a);
}

test vreinterpretq_f32_p64 {
    const a = std.mem.zeroes(types.p64x2);
    const expected = std.mem.zeroes(types.f32x4);
    try common.testIntrinsic("vreinterpretq_f32_p64", vreinterpretq_f32_p64, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_f32_p8(a: types.p8x16) types.f32x4 {
    return @bitCast(a);
}

test vreinterpretq_f32_p8 {
    const a = std.mem.zeroes(types.p8x16);
    const expected = std.mem.zeroes(types.f32x4);
    try common.testIntrinsic("vreinterpretq_f32_p8", vreinterpretq_f32_p8, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_f32_s16(a: types.i16x8) types.f32x4 {
    return @bitCast(a);
}

test vreinterpretq_f32_s16 {
    const a = std.mem.zeroes(types.i16x8);
    const expected = std.mem.zeroes(types.f32x4);
    try common.testIntrinsic("vreinterpretq_f32_s16", vreinterpretq_f32_s16, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_f32_s32(a: types.i32x4) types.f32x4 {
    return @bitCast(a);
}

test vreinterpretq_f32_s32 {
    const a = std.mem.zeroes(types.i32x4);
    const expected = std.mem.zeroes(types.f32x4);
    try common.testIntrinsic("vreinterpretq_f32_s32", vreinterpretq_f32_s32, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_f32_s64(a: types.i64x2) types.f32x4 {
    return @bitCast(a);
}

test vreinterpretq_f32_s64 {
    const a = std.mem.zeroes(types.i64x2);
    const expected = std.mem.zeroes(types.f32x4);
    try common.testIntrinsic("vreinterpretq_f32_s64", vreinterpretq_f32_s64, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_f32_s8(a: types.i8x16) types.f32x4 {
    return @bitCast(a);
}

test vreinterpretq_f32_s8 {
    const a = std.mem.zeroes(types.i8x16);
    const expected = std.mem.zeroes(types.f32x4);
    try common.testIntrinsic("vreinterpretq_f32_s8", vreinterpretq_f32_s8, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_f32_u16(a: types.u16x8) types.f32x4 {
    return @bitCast(a);
}

test vreinterpretq_f32_u16 {
    const a = std.mem.zeroes(types.u16x8);
    const expected = std.mem.zeroes(types.f32x4);
    try common.testIntrinsic("vreinterpretq_f32_u16", vreinterpretq_f32_u16, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_f32_u32(a: types.u32x4) types.f32x4 {
    return @bitCast(a);
}

test vreinterpretq_f32_u32 {
    const a = std.mem.zeroes(types.u32x4);
    const expected = std.mem.zeroes(types.f32x4);
    try common.testIntrinsic("vreinterpretq_f32_u32", vreinterpretq_f32_u32, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_f32_u64(a: types.u64x2) types.f32x4 {
    return @bitCast(a);
}

test vreinterpretq_f32_u64 {
    const a = std.mem.zeroes(types.u64x2);
    const expected = std.mem.zeroes(types.f32x4);
    try common.testIntrinsic("vreinterpretq_f32_u64", vreinterpretq_f32_u64, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_f32_u8(a: types.u8x16) types.f32x4 {
    return @bitCast(a);
}

test vreinterpretq_f32_u8 {
    const a = std.mem.zeroes(types.u8x16);
    const expected = std.mem.zeroes(types.f32x4);
    try common.testIntrinsic("vreinterpretq_f32_u8", vreinterpretq_f32_u8, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_f64_f16(a: types.f16x8) types.f64x2 {
    return @bitCast(a);
}

test vreinterpretq_f64_f16 {
    const a = std.mem.zeroes(types.f16x8);
    const expected = std.mem.zeroes(types.f64x2);
    try common.testIntrinsic("vreinterpretq_f64_f16", vreinterpretq_f64_f16, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_f64_f32(a: types.f32x4) types.f64x2 {
    return @bitCast(a);
}

test vreinterpretq_f64_f32 {
    const a = std.mem.zeroes(types.f32x4);
    const expected = std.mem.zeroes(types.f64x2);
    try common.testIntrinsic("vreinterpretq_f64_f32", vreinterpretq_f64_f32, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_f64_p128(a: types.p128) types.f64x2 {
    return @bitCast(a);
}

test vreinterpretq_f64_p128 {
    const a = std.mem.zeroes(types.p128);
    const expected = std.mem.zeroes(types.f64x2);
    try common.testIntrinsic("vreinterpretq_f64_p128", vreinterpretq_f64_p128, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_f64_p16(a: types.p16x8) types.f64x2 {
    return @bitCast(a);
}

test vreinterpretq_f64_p16 {
    const a = std.mem.zeroes(types.p16x8);
    const expected = std.mem.zeroes(types.f64x2);
    try common.testIntrinsic("vreinterpretq_f64_p16", vreinterpretq_f64_p16, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_f64_p64(a: types.p64x2) types.f64x2 {
    return @bitCast(a);
}

test vreinterpretq_f64_p64 {
    const a = std.mem.zeroes(types.p64x2);
    const expected = std.mem.zeroes(types.f64x2);
    try common.testIntrinsic("vreinterpretq_f64_p64", vreinterpretq_f64_p64, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_f64_p8(a: types.p8x16) types.f64x2 {
    return @bitCast(a);
}

test vreinterpretq_f64_p8 {
    const a = std.mem.zeroes(types.p8x16);
    const expected = std.mem.zeroes(types.f64x2);
    try common.testIntrinsic("vreinterpretq_f64_p8", vreinterpretq_f64_p8, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_f64_s16(a: types.i16x8) types.f64x2 {
    return @bitCast(a);
}

test vreinterpretq_f64_s16 {
    const a = std.mem.zeroes(types.i16x8);
    const expected = std.mem.zeroes(types.f64x2);
    try common.testIntrinsic("vreinterpretq_f64_s16", vreinterpretq_f64_s16, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_f64_s32(a: types.i32x4) types.f64x2 {
    return @bitCast(a);
}

test vreinterpretq_f64_s32 {
    const a = std.mem.zeroes(types.i32x4);
    const expected = std.mem.zeroes(types.f64x2);
    try common.testIntrinsic("vreinterpretq_f64_s32", vreinterpretq_f64_s32, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_f64_s64(a: types.i64x2) types.f64x2 {
    return @bitCast(a);
}

test vreinterpretq_f64_s64 {
    const a = std.mem.zeroes(types.i64x2);
    const expected = std.mem.zeroes(types.f64x2);
    try common.testIntrinsic("vreinterpretq_f64_s64", vreinterpretq_f64_s64, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_f64_s8(a: types.i8x16) types.f64x2 {
    return @bitCast(a);
}

test vreinterpretq_f64_s8 {
    const a = std.mem.zeroes(types.i8x16);
    const expected = std.mem.zeroes(types.f64x2);
    try common.testIntrinsic("vreinterpretq_f64_s8", vreinterpretq_f64_s8, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_f64_u16(a: types.u16x8) types.f64x2 {
    return @bitCast(a);
}

test vreinterpretq_f64_u16 {
    const a = std.mem.zeroes(types.u16x8);
    const expected = std.mem.zeroes(types.f64x2);
    try common.testIntrinsic("vreinterpretq_f64_u16", vreinterpretq_f64_u16, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_f64_u32(a: types.u32x4) types.f64x2 {
    return @bitCast(a);
}

test vreinterpretq_f64_u32 {
    const a = std.mem.zeroes(types.u32x4);
    const expected = std.mem.zeroes(types.f64x2);
    try common.testIntrinsic("vreinterpretq_f64_u32", vreinterpretq_f64_u32, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_f64_u64(a: types.u64x2) types.f64x2 {
    return @bitCast(a);
}

test vreinterpretq_f64_u64 {
    const a = std.mem.zeroes(types.u64x2);
    const expected = std.mem.zeroes(types.f64x2);
    try common.testIntrinsic("vreinterpretq_f64_u64", vreinterpretq_f64_u64, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_f64_u8(a: types.u8x16) types.f64x2 {
    return @bitCast(a);
}

test vreinterpretq_f64_u8 {
    const a = std.mem.zeroes(types.u8x16);
    const expected = std.mem.zeroes(types.f64x2);
    try common.testIntrinsic("vreinterpretq_f64_u8", vreinterpretq_f64_u8, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_p128_f16(a: types.f16x8) types.p128 {
    return @bitCast(a);
}

test vreinterpretq_p128_f16 {
    const a = std.mem.zeroes(types.f16x8);
    const expected = std.mem.zeroes(types.p128);
    try common.testIntrinsic("vreinterpretq_p128_f16", vreinterpretq_p128_f16, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_p128_f32(a: types.f32x4) types.p128 {
    return @bitCast(a);
}

test vreinterpretq_p128_f32 {
    const a = std.mem.zeroes(types.f32x4);
    const expected = std.mem.zeroes(types.p128);
    try common.testIntrinsic("vreinterpretq_p128_f32", vreinterpretq_p128_f32, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_p128_f64(a: types.f64x2) types.p128 {
    return @bitCast(a);
}

test vreinterpretq_p128_f64 {
    const a = std.mem.zeroes(types.f64x2);
    const expected = std.mem.zeroes(types.p128);
    try common.testIntrinsic("vreinterpretq_p128_f64", vreinterpretq_p128_f64, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_p128_p16(a: types.p16x8) types.p128 {
    return @bitCast(a);
}

test vreinterpretq_p128_p16 {
    const a = std.mem.zeroes(types.p16x8);
    const expected = std.mem.zeroes(types.p128);
    try common.testIntrinsic("vreinterpretq_p128_p16", vreinterpretq_p128_p16, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_p128_p64(a: types.p64x2) types.p128 {
    return @bitCast(a);
}

test vreinterpretq_p128_p64 {
    const a = std.mem.zeroes(types.p64x2);
    const expected = std.mem.zeroes(types.p128);
    try common.testIntrinsic("vreinterpretq_p128_p64", vreinterpretq_p128_p64, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_p128_p8(a: types.p8x16) types.p128 {
    return @bitCast(a);
}

test vreinterpretq_p128_p8 {
    const a = std.mem.zeroes(types.p8x16);
    const expected = std.mem.zeroes(types.p128);
    try common.testIntrinsic("vreinterpretq_p128_p8", vreinterpretq_p128_p8, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_p128_s16(a: types.i16x8) types.p128 {
    return @bitCast(a);
}

test vreinterpretq_p128_s16 {
    const a = std.mem.zeroes(types.i16x8);
    const expected = std.mem.zeroes(types.p128);
    try common.testIntrinsic("vreinterpretq_p128_s16", vreinterpretq_p128_s16, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_p128_s32(a: types.i32x4) types.p128 {
    return @bitCast(a);
}

test vreinterpretq_p128_s32 {
    const a = std.mem.zeroes(types.i32x4);
    const expected = std.mem.zeroes(types.p128);
    try common.testIntrinsic("vreinterpretq_p128_s32", vreinterpretq_p128_s32, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_p128_s64(a: types.i64x2) types.p128 {
    return @bitCast(a);
}

test vreinterpretq_p128_s64 {
    const a = std.mem.zeroes(types.i64x2);
    const expected = std.mem.zeroes(types.p128);
    try common.testIntrinsic("vreinterpretq_p128_s64", vreinterpretq_p128_s64, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_p128_s8(a: types.i8x16) types.p128 {
    return @bitCast(a);
}

test vreinterpretq_p128_s8 {
    const a = std.mem.zeroes(types.i8x16);
    const expected = std.mem.zeroes(types.p128);
    try common.testIntrinsic("vreinterpretq_p128_s8", vreinterpretq_p128_s8, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_p128_u16(a: types.u16x8) types.p128 {
    return @bitCast(a);
}

test vreinterpretq_p128_u16 {
    const a = std.mem.zeroes(types.u16x8);
    const expected = std.mem.zeroes(types.p128);
    try common.testIntrinsic("vreinterpretq_p128_u16", vreinterpretq_p128_u16, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_p128_u32(a: types.u32x4) types.p128 {
    return @bitCast(a);
}

test vreinterpretq_p128_u32 {
    const a = std.mem.zeroes(types.u32x4);
    const expected = std.mem.zeroes(types.p128);
    try common.testIntrinsic("vreinterpretq_p128_u32", vreinterpretq_p128_u32, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_p128_u64(a: types.u64x2) types.p128 {
    return @bitCast(a);
}

test vreinterpretq_p128_u64 {
    const a = std.mem.zeroes(types.u64x2);
    const expected = std.mem.zeroes(types.p128);
    try common.testIntrinsic("vreinterpretq_p128_u64", vreinterpretq_p128_u64, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_p128_u8(a: types.u8x16) types.p128 {
    return @bitCast(a);
}

test vreinterpretq_p128_u8 {
    const a = std.mem.zeroes(types.u8x16);
    const expected = std.mem.zeroes(types.p128);
    try common.testIntrinsic("vreinterpretq_p128_u8", vreinterpretq_p128_u8, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_p16_f16(a: types.f16x8) types.p16x8 {
    return @bitCast(a);
}

test vreinterpretq_p16_f16 {
    const a = std.mem.zeroes(types.f16x8);
    const expected = std.mem.zeroes(types.p16x8);
    try common.testIntrinsic("vreinterpretq_p16_f16", vreinterpretq_p16_f16, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_p16_f32(a: types.f32x4) types.p16x8 {
    return @bitCast(a);
}

test vreinterpretq_p16_f32 {
    const a = std.mem.zeroes(types.f32x4);
    const expected = std.mem.zeroes(types.p16x8);
    try common.testIntrinsic("vreinterpretq_p16_f32", vreinterpretq_p16_f32, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_p16_f64(a: types.f64x2) types.p16x8 {
    return @bitCast(a);
}

test vreinterpretq_p16_f64 {
    const a = std.mem.zeroes(types.f64x2);
    const expected = std.mem.zeroes(types.p16x8);
    try common.testIntrinsic("vreinterpretq_p16_f64", vreinterpretq_p16_f64, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_p16_p128(a: types.p128) types.p16x8 {
    return @bitCast(a);
}

test vreinterpretq_p16_p128 {
    const a = std.mem.zeroes(types.p128);
    const expected = std.mem.zeroes(types.p16x8);
    try common.testIntrinsic("vreinterpretq_p16_p128", vreinterpretq_p16_p128, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_p16_p64(a: types.p64x2) types.p16x8 {
    return @bitCast(a);
}

test vreinterpretq_p16_p64 {
    const a = std.mem.zeroes(types.p64x2);
    const expected = std.mem.zeroes(types.p16x8);
    try common.testIntrinsic("vreinterpretq_p16_p64", vreinterpretq_p16_p64, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_p16_p8(a: types.p8x16) types.p16x8 {
    return @bitCast(a);
}

test vreinterpretq_p16_p8 {
    const a = std.mem.zeroes(types.p8x16);
    const expected = std.mem.zeroes(types.p16x8);
    try common.testIntrinsic("vreinterpretq_p16_p8", vreinterpretq_p16_p8, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_p16_s16(a: types.i16x8) types.p16x8 {
    return @bitCast(a);
}

test vreinterpretq_p16_s16 {
    const a = std.mem.zeroes(types.i16x8);
    const expected = std.mem.zeroes(types.p16x8);
    try common.testIntrinsic("vreinterpretq_p16_s16", vreinterpretq_p16_s16, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_p16_s32(a: types.i32x4) types.p16x8 {
    return @bitCast(a);
}

test vreinterpretq_p16_s32 {
    const a = std.mem.zeroes(types.i32x4);
    const expected = std.mem.zeroes(types.p16x8);
    try common.testIntrinsic("vreinterpretq_p16_s32", vreinterpretq_p16_s32, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_p16_s64(a: types.i64x2) types.p16x8 {
    return @bitCast(a);
}

test vreinterpretq_p16_s64 {
    const a = std.mem.zeroes(types.i64x2);
    const expected = std.mem.zeroes(types.p16x8);
    try common.testIntrinsic("vreinterpretq_p16_s64", vreinterpretq_p16_s64, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_p16_s8(a: types.i8x16) types.p16x8 {
    return @bitCast(a);
}

test vreinterpretq_p16_s8 {
    const a = std.mem.zeroes(types.i8x16);
    const expected = std.mem.zeroes(types.p16x8);
    try common.testIntrinsic("vreinterpretq_p16_s8", vreinterpretq_p16_s8, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_p16_u16(a: types.u16x8) types.p16x8 {
    return @bitCast(a);
}

test vreinterpretq_p16_u16 {
    const a = std.mem.zeroes(types.u16x8);
    const expected = std.mem.zeroes(types.p16x8);
    try common.testIntrinsic("vreinterpretq_p16_u16", vreinterpretq_p16_u16, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_p16_u32(a: types.u32x4) types.p16x8 {
    return @bitCast(a);
}

test vreinterpretq_p16_u32 {
    const a = std.mem.zeroes(types.u32x4);
    const expected = std.mem.zeroes(types.p16x8);
    try common.testIntrinsic("vreinterpretq_p16_u32", vreinterpretq_p16_u32, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_p16_u64(a: types.u64x2) types.p16x8 {
    return @bitCast(a);
}

test vreinterpretq_p16_u64 {
    const a = std.mem.zeroes(types.u64x2);
    const expected = std.mem.zeroes(types.p16x8);
    try common.testIntrinsic("vreinterpretq_p16_u64", vreinterpretq_p16_u64, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_p16_u8(a: types.u8x16) types.p16x8 {
    return @bitCast(a);
}

test vreinterpretq_p16_u8 {
    const a = std.mem.zeroes(types.u8x16);
    const expected = std.mem.zeroes(types.p16x8);
    try common.testIntrinsic("vreinterpretq_p16_u8", vreinterpretq_p16_u8, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_p64_f16(a: types.f16x8) types.p64x2 {
    return @bitCast(a);
}

test vreinterpretq_p64_f16 {
    const a = std.mem.zeroes(types.f16x8);
    const expected = std.mem.zeroes(types.p64x2);
    try common.testIntrinsic("vreinterpretq_p64_f16", vreinterpretq_p64_f16, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_p64_f32(a: types.f32x4) types.p64x2 {
    return @bitCast(a);
}

test vreinterpretq_p64_f32 {
    const a = std.mem.zeroes(types.f32x4);
    const expected = std.mem.zeroes(types.p64x2);
    try common.testIntrinsic("vreinterpretq_p64_f32", vreinterpretq_p64_f32, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_p64_f64(a: types.f64x2) types.p64x2 {
    return @bitCast(a);
}

test vreinterpretq_p64_f64 {
    const a = std.mem.zeroes(types.f64x2);
    const expected = std.mem.zeroes(types.p64x2);
    try common.testIntrinsic("vreinterpretq_p64_f64", vreinterpretq_p64_f64, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_p64_p128(a: types.p128) types.p64x2 {
    return @bitCast(a);
}

test vreinterpretq_p64_p128 {
    const a = std.mem.zeroes(types.p128);
    const expected = std.mem.zeroes(types.p64x2);
    try common.testIntrinsic("vreinterpretq_p64_p128", vreinterpretq_p64_p128, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_p64_p16(a: types.p16x8) types.p64x2 {
    return @bitCast(a);
}

test vreinterpretq_p64_p16 {
    const a = std.mem.zeroes(types.p16x8);
    const expected = std.mem.zeroes(types.p64x2);
    try common.testIntrinsic("vreinterpretq_p64_p16", vreinterpretq_p64_p16, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_p64_p8(a: types.p8x16) types.p64x2 {
    return @bitCast(a);
}

test vreinterpretq_p64_p8 {
    const a = std.mem.zeroes(types.p8x16);
    const expected = std.mem.zeroes(types.p64x2);
    try common.testIntrinsic("vreinterpretq_p64_p8", vreinterpretq_p64_p8, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_p64_s16(a: types.i16x8) types.p64x2 {
    return @bitCast(a);
}

test vreinterpretq_p64_s16 {
    const a = std.mem.zeroes(types.i16x8);
    const expected = std.mem.zeroes(types.p64x2);
    try common.testIntrinsic("vreinterpretq_p64_s16", vreinterpretq_p64_s16, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_p64_s32(a: types.i32x4) types.p64x2 {
    return @bitCast(a);
}

test vreinterpretq_p64_s32 {
    const a = std.mem.zeroes(types.i32x4);
    const expected = std.mem.zeroes(types.p64x2);
    try common.testIntrinsic("vreinterpretq_p64_s32", vreinterpretq_p64_s32, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_p64_s64(a: types.i64x2) types.p64x2 {
    return @bitCast(a);
}

test vreinterpretq_p64_s64 {
    const a = std.mem.zeroes(types.i64x2);
    const expected = std.mem.zeroes(types.p64x2);
    try common.testIntrinsic("vreinterpretq_p64_s64", vreinterpretq_p64_s64, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_p64_s8(a: types.i8x16) types.p64x2 {
    return @bitCast(a);
}

test vreinterpretq_p64_s8 {
    const a = std.mem.zeroes(types.i8x16);
    const expected = std.mem.zeroes(types.p64x2);
    try common.testIntrinsic("vreinterpretq_p64_s8", vreinterpretq_p64_s8, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_p64_u16(a: types.u16x8) types.p64x2 {
    return @bitCast(a);
}

test vreinterpretq_p64_u16 {
    const a = std.mem.zeroes(types.u16x8);
    const expected = std.mem.zeroes(types.p64x2);
    try common.testIntrinsic("vreinterpretq_p64_u16", vreinterpretq_p64_u16, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_p64_u32(a: types.u32x4) types.p64x2 {
    return @bitCast(a);
}

test vreinterpretq_p64_u32 {
    const a = std.mem.zeroes(types.u32x4);
    const expected = std.mem.zeroes(types.p64x2);
    try common.testIntrinsic("vreinterpretq_p64_u32", vreinterpretq_p64_u32, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_p64_u64(a: types.u64x2) types.p64x2 {
    return @bitCast(a);
}

test vreinterpretq_p64_u64 {
    const a = std.mem.zeroes(types.u64x2);
    const expected = std.mem.zeroes(types.p64x2);
    try common.testIntrinsic("vreinterpretq_p64_u64", vreinterpretq_p64_u64, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_p64_u8(a: types.u8x16) types.p64x2 {
    return @bitCast(a);
}

test vreinterpretq_p64_u8 {
    const a = std.mem.zeroes(types.u8x16);
    const expected = std.mem.zeroes(types.p64x2);
    try common.testIntrinsic("vreinterpretq_p64_u8", vreinterpretq_p64_u8, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_p8_f16(a: types.f16x8) types.p8x16 {
    return @bitCast(a);
}

test vreinterpretq_p8_f16 {
    const a = std.mem.zeroes(types.f16x8);
    const expected = std.mem.zeroes(types.p8x16);
    try common.testIntrinsic("vreinterpretq_p8_f16", vreinterpretq_p8_f16, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_p8_f32(a: types.f32x4) types.p8x16 {
    return @bitCast(a);
}

test vreinterpretq_p8_f32 {
    const a = std.mem.zeroes(types.f32x4);
    const expected = std.mem.zeroes(types.p8x16);
    try common.testIntrinsic("vreinterpretq_p8_f32", vreinterpretq_p8_f32, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_p8_f64(a: types.f64x2) types.p8x16 {
    return @bitCast(a);
}

test vreinterpretq_p8_f64 {
    const a = std.mem.zeroes(types.f64x2);
    const expected = std.mem.zeroes(types.p8x16);
    try common.testIntrinsic("vreinterpretq_p8_f64", vreinterpretq_p8_f64, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_p8_p128(a: types.p128) types.p8x16 {
    return @bitCast(a);
}

test vreinterpretq_p8_p128 {
    const a = std.mem.zeroes(types.p128);
    const expected = std.mem.zeroes(types.p8x16);
    try common.testIntrinsic("vreinterpretq_p8_p128", vreinterpretq_p8_p128, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_p8_p16(a: types.p16x8) types.p8x16 {
    return @bitCast(a);
}

test vreinterpretq_p8_p16 {
    const a = std.mem.zeroes(types.p16x8);
    const expected = std.mem.zeroes(types.p8x16);
    try common.testIntrinsic("vreinterpretq_p8_p16", vreinterpretq_p8_p16, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_p8_p64(a: types.p64x2) types.p8x16 {
    return @bitCast(a);
}

test vreinterpretq_p8_p64 {
    const a = std.mem.zeroes(types.p64x2);
    const expected = std.mem.zeroes(types.p8x16);
    try common.testIntrinsic("vreinterpretq_p8_p64", vreinterpretq_p8_p64, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_p8_s16(a: types.i16x8) types.p8x16 {
    return @bitCast(a);
}

test vreinterpretq_p8_s16 {
    const a = std.mem.zeroes(types.i16x8);
    const expected = std.mem.zeroes(types.p8x16);
    try common.testIntrinsic("vreinterpretq_p8_s16", vreinterpretq_p8_s16, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_p8_s32(a: types.i32x4) types.p8x16 {
    return @bitCast(a);
}

test vreinterpretq_p8_s32 {
    const a = std.mem.zeroes(types.i32x4);
    const expected = std.mem.zeroes(types.p8x16);
    try common.testIntrinsic("vreinterpretq_p8_s32", vreinterpretq_p8_s32, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_p8_s64(a: types.i64x2) types.p8x16 {
    return @bitCast(a);
}

test vreinterpretq_p8_s64 {
    const a = std.mem.zeroes(types.i64x2);
    const expected = std.mem.zeroes(types.p8x16);
    try common.testIntrinsic("vreinterpretq_p8_s64", vreinterpretq_p8_s64, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_p8_s8(a: types.i8x16) types.p8x16 {
    return @bitCast(a);
}

test vreinterpretq_p8_s8 {
    const a = std.mem.zeroes(types.i8x16);
    const expected = std.mem.zeroes(types.p8x16);
    try common.testIntrinsic("vreinterpretq_p8_s8", vreinterpretq_p8_s8, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_p8_u16(a: types.u16x8) types.p8x16 {
    return @bitCast(a);
}

test vreinterpretq_p8_u16 {
    const a = std.mem.zeroes(types.u16x8);
    const expected = std.mem.zeroes(types.p8x16);
    try common.testIntrinsic("vreinterpretq_p8_u16", vreinterpretq_p8_u16, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_p8_u32(a: types.u32x4) types.p8x16 {
    return @bitCast(a);
}

test vreinterpretq_p8_u32 {
    const a = std.mem.zeroes(types.u32x4);
    const expected = std.mem.zeroes(types.p8x16);
    try common.testIntrinsic("vreinterpretq_p8_u32", vreinterpretq_p8_u32, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_p8_u64(a: types.u64x2) types.p8x16 {
    return @bitCast(a);
}

test vreinterpretq_p8_u64 {
    const a = std.mem.zeroes(types.u64x2);
    const expected = std.mem.zeroes(types.p8x16);
    try common.testIntrinsic("vreinterpretq_p8_u64", vreinterpretq_p8_u64, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_p8_u8(a: types.u8x16) types.p8x16 {
    return @bitCast(a);
}

test vreinterpretq_p8_u8 {
    const a = std.mem.zeroes(types.u8x16);
    const expected = std.mem.zeroes(types.p8x16);
    try common.testIntrinsic("vreinterpretq_p8_u8", vreinterpretq_p8_u8, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_s16_f16(a: types.f16x8) types.i16x8 {
    return @bitCast(a);
}

test vreinterpretq_s16_f16 {
    const a = std.mem.zeroes(types.f16x8);
    const expected = std.mem.zeroes(types.i16x8);
    try common.testIntrinsic("vreinterpretq_s16_f16", vreinterpretq_s16_f16, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_s16_f32(a: types.f32x4) types.i16x8 {
    return @bitCast(a);
}

test vreinterpretq_s16_f32 {
    const a = std.mem.zeroes(types.f32x4);
    const expected = std.mem.zeroes(types.i16x8);
    try common.testIntrinsic("vreinterpretq_s16_f32", vreinterpretq_s16_f32, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_s16_f64(a: types.f64x2) types.i16x8 {
    return @bitCast(a);
}

test vreinterpretq_s16_f64 {
    const a = std.mem.zeroes(types.f64x2);
    const expected = std.mem.zeroes(types.i16x8);
    try common.testIntrinsic("vreinterpretq_s16_f64", vreinterpretq_s16_f64, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_s16_p128(a: types.p128) types.i16x8 {
    return @bitCast(a);
}

test vreinterpretq_s16_p128 {
    const a = std.mem.zeroes(types.p128);
    const expected = std.mem.zeroes(types.i16x8);
    try common.testIntrinsic("vreinterpretq_s16_p128", vreinterpretq_s16_p128, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_s16_p16(a: types.p16x8) types.i16x8 {
    return @bitCast(a);
}

test vreinterpretq_s16_p16 {
    const a = std.mem.zeroes(types.p16x8);
    const expected = std.mem.zeroes(types.i16x8);
    try common.testIntrinsic("vreinterpretq_s16_p16", vreinterpretq_s16_p16, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_s16_p64(a: types.p64x2) types.i16x8 {
    return @bitCast(a);
}

test vreinterpretq_s16_p64 {
    const a = std.mem.zeroes(types.p64x2);
    const expected = std.mem.zeroes(types.i16x8);
    try common.testIntrinsic("vreinterpretq_s16_p64", vreinterpretq_s16_p64, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_s16_p8(a: types.p8x16) types.i16x8 {
    return @bitCast(a);
}

test vreinterpretq_s16_p8 {
    const a = std.mem.zeroes(types.p8x16);
    const expected = std.mem.zeroes(types.i16x8);
    try common.testIntrinsic("vreinterpretq_s16_p8", vreinterpretq_s16_p8, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_s16_s32(a: types.i32x4) types.i16x8 {
    return @bitCast(a);
}

test vreinterpretq_s16_s32 {
    const a = std.mem.zeroes(types.i32x4);
    const expected = std.mem.zeroes(types.i16x8);
    try common.testIntrinsic("vreinterpretq_s16_s32", vreinterpretq_s16_s32, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_s16_s64(a: types.i64x2) types.i16x8 {
    return @bitCast(a);
}

test vreinterpretq_s16_s64 {
    const a = std.mem.zeroes(types.i64x2);
    const expected = std.mem.zeroes(types.i16x8);
    try common.testIntrinsic("vreinterpretq_s16_s64", vreinterpretq_s16_s64, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_s16_s8(a: types.i8x16) types.i16x8 {
    return @bitCast(a);
}

test vreinterpretq_s16_s8 {
    const a = std.mem.zeroes(types.i8x16);
    const expected = std.mem.zeroes(types.i16x8);
    try common.testIntrinsic("vreinterpretq_s16_s8", vreinterpretq_s16_s8, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_s16_u16(a: types.u16x8) types.i16x8 {
    return @bitCast(a);
}

test vreinterpretq_s16_u16 {
    const a = std.mem.zeroes(types.u16x8);
    const expected = std.mem.zeroes(types.i16x8);
    try common.testIntrinsic("vreinterpretq_s16_u16", vreinterpretq_s16_u16, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_s16_u32(a: types.u32x4) types.i16x8 {
    return @bitCast(a);
}

test vreinterpretq_s16_u32 {
    const a = std.mem.zeroes(types.u32x4);
    const expected = std.mem.zeroes(types.i16x8);
    try common.testIntrinsic("vreinterpretq_s16_u32", vreinterpretq_s16_u32, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_s16_u64(a: types.u64x2) types.i16x8 {
    return @bitCast(a);
}

test vreinterpretq_s16_u64 {
    const a = std.mem.zeroes(types.u64x2);
    const expected = std.mem.zeroes(types.i16x8);
    try common.testIntrinsic("vreinterpretq_s16_u64", vreinterpretq_s16_u64, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_s16_u8(a: types.u8x16) types.i16x8 {
    return @bitCast(a);
}

test vreinterpretq_s16_u8 {
    const a = std.mem.zeroes(types.u8x16);
    const expected = std.mem.zeroes(types.i16x8);
    try common.testIntrinsic("vreinterpretq_s16_u8", vreinterpretq_s16_u8, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_s32_f16(a: types.f16x8) types.i32x4 {
    return @bitCast(a);
}

test vreinterpretq_s32_f16 {
    const a = std.mem.zeroes(types.f16x8);
    const expected = std.mem.zeroes(types.i32x4);
    try common.testIntrinsic("vreinterpretq_s32_f16", vreinterpretq_s32_f16, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_s32_f32(a: types.f32x4) types.i32x4 {
    return @bitCast(a);
}

test vreinterpretq_s32_f32 {
    const a = std.mem.zeroes(types.f32x4);
    const expected = std.mem.zeroes(types.i32x4);
    try common.testIntrinsic("vreinterpretq_s32_f32", vreinterpretq_s32_f32, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_s32_f64(a: types.f64x2) types.i32x4 {
    return @bitCast(a);
}

test vreinterpretq_s32_f64 {
    const a = std.mem.zeroes(types.f64x2);
    const expected = std.mem.zeroes(types.i32x4);
    try common.testIntrinsic("vreinterpretq_s32_f64", vreinterpretq_s32_f64, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_s32_p128(a: types.p128) types.i32x4 {
    return @bitCast(a);
}

test vreinterpretq_s32_p128 {
    const a = std.mem.zeroes(types.p128);
    const expected = std.mem.zeroes(types.i32x4);
    try common.testIntrinsic("vreinterpretq_s32_p128", vreinterpretq_s32_p128, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_s32_p16(a: types.p16x8) types.i32x4 {
    return @bitCast(a);
}

test vreinterpretq_s32_p16 {
    const a = std.mem.zeroes(types.p16x8);
    const expected = std.mem.zeroes(types.i32x4);
    try common.testIntrinsic("vreinterpretq_s32_p16", vreinterpretq_s32_p16, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_s32_p64(a: types.p64x2) types.i32x4 {
    return @bitCast(a);
}

test vreinterpretq_s32_p64 {
    const a = std.mem.zeroes(types.p64x2);
    const expected = std.mem.zeroes(types.i32x4);
    try common.testIntrinsic("vreinterpretq_s32_p64", vreinterpretq_s32_p64, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_s32_p8(a: types.p8x16) types.i32x4 {
    return @bitCast(a);
}

test vreinterpretq_s32_p8 {
    const a = std.mem.zeroes(types.p8x16);
    const expected = std.mem.zeroes(types.i32x4);
    try common.testIntrinsic("vreinterpretq_s32_p8", vreinterpretq_s32_p8, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_s32_s16(a: types.i16x8) types.i32x4 {
    return @bitCast(a);
}

test vreinterpretq_s32_s16 {
    const a = std.mem.zeroes(types.i16x8);
    const expected = std.mem.zeroes(types.i32x4);
    try common.testIntrinsic("vreinterpretq_s32_s16", vreinterpretq_s32_s16, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_s32_s64(a: types.i64x2) types.i32x4 {
    return @bitCast(a);
}

test vreinterpretq_s32_s64 {
    const a = std.mem.zeroes(types.i64x2);
    const expected = std.mem.zeroes(types.i32x4);
    try common.testIntrinsic("vreinterpretq_s32_s64", vreinterpretq_s32_s64, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_s32_s8(a: types.i8x16) types.i32x4 {
    return @bitCast(a);
}

test vreinterpretq_s32_s8 {
    const a = std.mem.zeroes(types.i8x16);
    const expected = std.mem.zeroes(types.i32x4);
    try common.testIntrinsic("vreinterpretq_s32_s8", vreinterpretq_s32_s8, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_s32_u16(a: types.u16x8) types.i32x4 {
    return @bitCast(a);
}

test vreinterpretq_s32_u16 {
    const a = std.mem.zeroes(types.u16x8);
    const expected = std.mem.zeroes(types.i32x4);
    try common.testIntrinsic("vreinterpretq_s32_u16", vreinterpretq_s32_u16, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_s32_u32(a: types.u32x4) types.i32x4 {
    return @bitCast(a);
}

test vreinterpretq_s32_u32 {
    const a = std.mem.zeroes(types.u32x4);
    const expected = std.mem.zeroes(types.i32x4);
    try common.testIntrinsic("vreinterpretq_s32_u32", vreinterpretq_s32_u32, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_s32_u64(a: types.u64x2) types.i32x4 {
    return @bitCast(a);
}

test vreinterpretq_s32_u64 {
    const a = std.mem.zeroes(types.u64x2);
    const expected = std.mem.zeroes(types.i32x4);
    try common.testIntrinsic("vreinterpretq_s32_u64", vreinterpretq_s32_u64, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_s32_u8(a: types.u8x16) types.i32x4 {
    return @bitCast(a);
}

test vreinterpretq_s32_u8 {
    const a = std.mem.zeroes(types.u8x16);
    const expected = std.mem.zeroes(types.i32x4);
    try common.testIntrinsic("vreinterpretq_s32_u8", vreinterpretq_s32_u8, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_s64_f16(a: types.f16x8) types.i64x2 {
    return @bitCast(a);
}

test vreinterpretq_s64_f16 {
    const a = std.mem.zeroes(types.f16x8);
    const expected = std.mem.zeroes(types.i64x2);
    try common.testIntrinsic("vreinterpretq_s64_f16", vreinterpretq_s64_f16, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_s64_f32(a: types.f32x4) types.i64x2 {
    return @bitCast(a);
}

test vreinterpretq_s64_f32 {
    const a = std.mem.zeroes(types.f32x4);
    const expected = std.mem.zeroes(types.i64x2);
    try common.testIntrinsic("vreinterpretq_s64_f32", vreinterpretq_s64_f32, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_s64_f64(a: types.f64x2) types.i64x2 {
    return @bitCast(a);
}

test vreinterpretq_s64_f64 {
    const a = std.mem.zeroes(types.f64x2);
    const expected = std.mem.zeroes(types.i64x2);
    try common.testIntrinsic("vreinterpretq_s64_f64", vreinterpretq_s64_f64, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_s64_p128(a: types.p128) types.i64x2 {
    return @bitCast(a);
}

test vreinterpretq_s64_p128 {
    const a = std.mem.zeroes(types.p128);
    const expected = std.mem.zeroes(types.i64x2);
    try common.testIntrinsic("vreinterpretq_s64_p128", vreinterpretq_s64_p128, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_s64_p16(a: types.p16x8) types.i64x2 {
    return @bitCast(a);
}

test vreinterpretq_s64_p16 {
    const a = std.mem.zeroes(types.p16x8);
    const expected = std.mem.zeroes(types.i64x2);
    try common.testIntrinsic("vreinterpretq_s64_p16", vreinterpretq_s64_p16, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_s64_p64(a: types.p64x2) types.i64x2 {
    return @bitCast(a);
}

test vreinterpretq_s64_p64 {
    const a = std.mem.zeroes(types.p64x2);
    const expected = std.mem.zeroes(types.i64x2);
    try common.testIntrinsic("vreinterpretq_s64_p64", vreinterpretq_s64_p64, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_s64_p8(a: types.p8x16) types.i64x2 {
    return @bitCast(a);
}

test vreinterpretq_s64_p8 {
    const a = std.mem.zeroes(types.p8x16);
    const expected = std.mem.zeroes(types.i64x2);
    try common.testIntrinsic("vreinterpretq_s64_p8", vreinterpretq_s64_p8, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_s64_s16(a: types.i16x8) types.i64x2 {
    return @bitCast(a);
}

test vreinterpretq_s64_s16 {
    const a = std.mem.zeroes(types.i16x8);
    const expected = std.mem.zeroes(types.i64x2);
    try common.testIntrinsic("vreinterpretq_s64_s16", vreinterpretq_s64_s16, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_s64_s32(a: types.i32x4) types.i64x2 {
    return @bitCast(a);
}

test vreinterpretq_s64_s32 {
    const a = std.mem.zeroes(types.i32x4);
    const expected = std.mem.zeroes(types.i64x2);
    try common.testIntrinsic("vreinterpretq_s64_s32", vreinterpretq_s64_s32, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_s64_s8(a: types.i8x16) types.i64x2 {
    return @bitCast(a);
}

test vreinterpretq_s64_s8 {
    const a = std.mem.zeroes(types.i8x16);
    const expected = std.mem.zeroes(types.i64x2);
    try common.testIntrinsic("vreinterpretq_s64_s8", vreinterpretq_s64_s8, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_s64_u16(a: types.u16x8) types.i64x2 {
    return @bitCast(a);
}

test vreinterpretq_s64_u16 {
    const a = std.mem.zeroes(types.u16x8);
    const expected = std.mem.zeroes(types.i64x2);
    try common.testIntrinsic("vreinterpretq_s64_u16", vreinterpretq_s64_u16, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_s64_u32(a: types.u32x4) types.i64x2 {
    return @bitCast(a);
}

test vreinterpretq_s64_u32 {
    const a = std.mem.zeroes(types.u32x4);
    const expected = std.mem.zeroes(types.i64x2);
    try common.testIntrinsic("vreinterpretq_s64_u32", vreinterpretq_s64_u32, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_s64_u64(a: types.u64x2) types.i64x2 {
    return @bitCast(a);
}

test vreinterpretq_s64_u64 {
    const a = std.mem.zeroes(types.u64x2);
    const expected = std.mem.zeroes(types.i64x2);
    try common.testIntrinsic("vreinterpretq_s64_u64", vreinterpretq_s64_u64, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_s64_u8(a: types.u8x16) types.i64x2 {
    return @bitCast(a);
}

test vreinterpretq_s64_u8 {
    const a = std.mem.zeroes(types.u8x16);
    const expected = std.mem.zeroes(types.i64x2);
    try common.testIntrinsic("vreinterpretq_s64_u8", vreinterpretq_s64_u8, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_s8_f16(a: types.f16x8) types.i8x16 {
    return @bitCast(a);
}

test vreinterpretq_s8_f16 {
    const a = std.mem.zeroes(types.f16x8);
    const expected = std.mem.zeroes(types.i8x16);
    try common.testIntrinsic("vreinterpretq_s8_f16", vreinterpretq_s8_f16, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_s8_f32(a: types.f32x4) types.i8x16 {
    return @bitCast(a);
}

test vreinterpretq_s8_f32 {
    const a = std.mem.zeroes(types.f32x4);
    const expected = std.mem.zeroes(types.i8x16);
    try common.testIntrinsic("vreinterpretq_s8_f32", vreinterpretq_s8_f32, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_s8_f64(a: types.f64x2) types.i8x16 {
    return @bitCast(a);
}

test vreinterpretq_s8_f64 {
    const a = std.mem.zeroes(types.f64x2);
    const expected = std.mem.zeroes(types.i8x16);
    try common.testIntrinsic("vreinterpretq_s8_f64", vreinterpretq_s8_f64, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_s8_p128(a: types.p128) types.i8x16 {
    return @bitCast(a);
}

test vreinterpretq_s8_p128 {
    const a = std.mem.zeroes(types.p128);
    const expected = std.mem.zeroes(types.i8x16);
    try common.testIntrinsic("vreinterpretq_s8_p128", vreinterpretq_s8_p128, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_s8_p16(a: types.p16x8) types.i8x16 {
    return @bitCast(a);
}

test vreinterpretq_s8_p16 {
    const a = std.mem.zeroes(types.p16x8);
    const expected = std.mem.zeroes(types.i8x16);
    try common.testIntrinsic("vreinterpretq_s8_p16", vreinterpretq_s8_p16, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_s8_p64(a: types.p64x2) types.i8x16 {
    return @bitCast(a);
}

test vreinterpretq_s8_p64 {
    const a = std.mem.zeroes(types.p64x2);
    const expected = std.mem.zeroes(types.i8x16);
    try common.testIntrinsic("vreinterpretq_s8_p64", vreinterpretq_s8_p64, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_s8_p8(a: types.p8x16) types.i8x16 {
    return @bitCast(a);
}

test vreinterpretq_s8_p8 {
    const a = std.mem.zeroes(types.p8x16);
    const expected = std.mem.zeroes(types.i8x16);
    try common.testIntrinsic("vreinterpretq_s8_p8", vreinterpretq_s8_p8, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_s8_s16(a: types.i16x8) types.i8x16 {
    return @bitCast(a);
}

test vreinterpretq_s8_s16 {
    const a = std.mem.zeroes(types.i16x8);
    const expected = std.mem.zeroes(types.i8x16);
    try common.testIntrinsic("vreinterpretq_s8_s16", vreinterpretq_s8_s16, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_s8_s32(a: types.i32x4) types.i8x16 {
    return @bitCast(a);
}

test vreinterpretq_s8_s32 {
    const a = std.mem.zeroes(types.i32x4);
    const expected = std.mem.zeroes(types.i8x16);
    try common.testIntrinsic("vreinterpretq_s8_s32", vreinterpretq_s8_s32, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_s8_s64(a: types.i64x2) types.i8x16 {
    return @bitCast(a);
}

test vreinterpretq_s8_s64 {
    const a = std.mem.zeroes(types.i64x2);
    const expected = std.mem.zeroes(types.i8x16);
    try common.testIntrinsic("vreinterpretq_s8_s64", vreinterpretq_s8_s64, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_s8_u16(a: types.u16x8) types.i8x16 {
    return @bitCast(a);
}

test vreinterpretq_s8_u16 {
    const a = std.mem.zeroes(types.u16x8);
    const expected = std.mem.zeroes(types.i8x16);
    try common.testIntrinsic("vreinterpretq_s8_u16", vreinterpretq_s8_u16, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_s8_u32(a: types.u32x4) types.i8x16 {
    return @bitCast(a);
}

test vreinterpretq_s8_u32 {
    const a = std.mem.zeroes(types.u32x4);
    const expected = std.mem.zeroes(types.i8x16);
    try common.testIntrinsic("vreinterpretq_s8_u32", vreinterpretq_s8_u32, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_s8_u64(a: types.u64x2) types.i8x16 {
    return @bitCast(a);
}

test vreinterpretq_s8_u64 {
    const a = std.mem.zeroes(types.u64x2);
    const expected = std.mem.zeroes(types.i8x16);
    try common.testIntrinsic("vreinterpretq_s8_u64", vreinterpretq_s8_u64, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_s8_u8(a: types.u8x16) types.i8x16 {
    return @bitCast(a);
}

test vreinterpretq_s8_u8 {
    const a = std.mem.zeroes(types.u8x16);
    const expected = std.mem.zeroes(types.i8x16);
    try common.testIntrinsic("vreinterpretq_s8_u8", vreinterpretq_s8_u8, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_u16_f16(a: types.f16x8) types.u16x8 {
    return @bitCast(a);
}

test vreinterpretq_u16_f16 {
    const a = std.mem.zeroes(types.f16x8);
    const expected = std.mem.zeroes(types.u16x8);
    try common.testIntrinsic("vreinterpretq_u16_f16", vreinterpretq_u16_f16, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_u16_f32(a: types.f32x4) types.u16x8 {
    return @bitCast(a);
}

test vreinterpretq_u16_f32 {
    const a = std.mem.zeroes(types.f32x4);
    const expected = std.mem.zeroes(types.u16x8);
    try common.testIntrinsic("vreinterpretq_u16_f32", vreinterpretq_u16_f32, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_u16_f64(a: types.f64x2) types.u16x8 {
    return @bitCast(a);
}

test vreinterpretq_u16_f64 {
    const a = std.mem.zeroes(types.f64x2);
    const expected = std.mem.zeroes(types.u16x8);
    try common.testIntrinsic("vreinterpretq_u16_f64", vreinterpretq_u16_f64, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_u16_p128(a: types.p128) types.u16x8 {
    return @bitCast(a);
}

test vreinterpretq_u16_p128 {
    const a = std.mem.zeroes(types.p128);
    const expected = std.mem.zeroes(types.u16x8);
    try common.testIntrinsic("vreinterpretq_u16_p128", vreinterpretq_u16_p128, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_u16_p16(a: types.p16x8) types.u16x8 {
    return @bitCast(a);
}

test vreinterpretq_u16_p16 {
    const a = std.mem.zeroes(types.p16x8);
    const expected = std.mem.zeroes(types.u16x8);
    try common.testIntrinsic("vreinterpretq_u16_p16", vreinterpretq_u16_p16, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_u16_p64(a: types.p64x2) types.u16x8 {
    return @bitCast(a);
}

test vreinterpretq_u16_p64 {
    const a = std.mem.zeroes(types.p64x2);
    const expected = std.mem.zeroes(types.u16x8);
    try common.testIntrinsic("vreinterpretq_u16_p64", vreinterpretq_u16_p64, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_u16_p8(a: types.p8x16) types.u16x8 {
    return @bitCast(a);
}

test vreinterpretq_u16_p8 {
    const a = std.mem.zeroes(types.p8x16);
    const expected = std.mem.zeroes(types.u16x8);
    try common.testIntrinsic("vreinterpretq_u16_p8", vreinterpretq_u16_p8, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_u16_s16(a: types.i16x8) types.u16x8 {
    return @bitCast(a);
}

test vreinterpretq_u16_s16 {
    const a = std.mem.zeroes(types.i16x8);
    const expected = std.mem.zeroes(types.u16x8);
    try common.testIntrinsic("vreinterpretq_u16_s16", vreinterpretq_u16_s16, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_u16_s32(a: types.i32x4) types.u16x8 {
    return @bitCast(a);
}

test vreinterpretq_u16_s32 {
    const a = std.mem.zeroes(types.i32x4);
    const expected = std.mem.zeroes(types.u16x8);
    try common.testIntrinsic("vreinterpretq_u16_s32", vreinterpretq_u16_s32, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_u16_s64(a: types.i64x2) types.u16x8 {
    return @bitCast(a);
}

test vreinterpretq_u16_s64 {
    const a = std.mem.zeroes(types.i64x2);
    const expected = std.mem.zeroes(types.u16x8);
    try common.testIntrinsic("vreinterpretq_u16_s64", vreinterpretq_u16_s64, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_u16_s8(a: types.i8x16) types.u16x8 {
    return @bitCast(a);
}

test vreinterpretq_u16_s8 {
    const a = std.mem.zeroes(types.i8x16);
    const expected = std.mem.zeroes(types.u16x8);
    try common.testIntrinsic("vreinterpretq_u16_s8", vreinterpretq_u16_s8, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_u16_u32(a: types.u32x4) types.u16x8 {
    return @bitCast(a);
}

test vreinterpretq_u16_u32 {
    const a = std.mem.zeroes(types.u32x4);
    const expected = std.mem.zeroes(types.u16x8);
    try common.testIntrinsic("vreinterpretq_u16_u32", vreinterpretq_u16_u32, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_u16_u64(a: types.u64x2) types.u16x8 {
    return @bitCast(a);
}

test vreinterpretq_u16_u64 {
    const a = std.mem.zeroes(types.u64x2);
    const expected = std.mem.zeroes(types.u16x8);
    try common.testIntrinsic("vreinterpretq_u16_u64", vreinterpretq_u16_u64, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_u16_u8(a: types.u8x16) types.u16x8 {
    return @bitCast(a);
}

test vreinterpretq_u16_u8 {
    const a = std.mem.zeroes(types.u8x16);
    const expected = std.mem.zeroes(types.u16x8);
    try common.testIntrinsic("vreinterpretq_u16_u8", vreinterpretq_u16_u8, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_u32_f16(a: types.f16x8) types.u32x4 {
    return @bitCast(a);
}

test vreinterpretq_u32_f16 {
    const a = std.mem.zeroes(types.f16x8);
    const expected = std.mem.zeroes(types.u32x4);
    try common.testIntrinsic("vreinterpretq_u32_f16", vreinterpretq_u32_f16, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_u32_f32(a: types.f32x4) types.u32x4 {
    return @bitCast(a);
}

test vreinterpretq_u32_f32 {
    const a = std.mem.zeroes(types.f32x4);
    const expected = std.mem.zeroes(types.u32x4);
    try common.testIntrinsic("vreinterpretq_u32_f32", vreinterpretq_u32_f32, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_u32_f64(a: types.f64x2) types.u32x4 {
    return @bitCast(a);
}

test vreinterpretq_u32_f64 {
    const a = std.mem.zeroes(types.f64x2);
    const expected = std.mem.zeroes(types.u32x4);
    try common.testIntrinsic("vreinterpretq_u32_f64", vreinterpretq_u32_f64, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_u32_p128(a: types.p128) types.u32x4 {
    return @bitCast(a);
}

test vreinterpretq_u32_p128 {
    const a = std.mem.zeroes(types.p128);
    const expected = std.mem.zeroes(types.u32x4);
    try common.testIntrinsic("vreinterpretq_u32_p128", vreinterpretq_u32_p128, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_u32_p16(a: types.p16x8) types.u32x4 {
    return @bitCast(a);
}

test vreinterpretq_u32_p16 {
    const a = std.mem.zeroes(types.p16x8);
    const expected = std.mem.zeroes(types.u32x4);
    try common.testIntrinsic("vreinterpretq_u32_p16", vreinterpretq_u32_p16, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_u32_p64(a: types.p64x2) types.u32x4 {
    return @bitCast(a);
}

test vreinterpretq_u32_p64 {
    const a = std.mem.zeroes(types.p64x2);
    const expected = std.mem.zeroes(types.u32x4);
    try common.testIntrinsic("vreinterpretq_u32_p64", vreinterpretq_u32_p64, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_u32_p8(a: types.p8x16) types.u32x4 {
    return @bitCast(a);
}

test vreinterpretq_u32_p8 {
    const a = std.mem.zeroes(types.p8x16);
    const expected = std.mem.zeroes(types.u32x4);
    try common.testIntrinsic("vreinterpretq_u32_p8", vreinterpretq_u32_p8, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_u32_s16(a: types.i16x8) types.u32x4 {
    return @bitCast(a);
}

test vreinterpretq_u32_s16 {
    const a = std.mem.zeroes(types.i16x8);
    const expected = std.mem.zeroes(types.u32x4);
    try common.testIntrinsic("vreinterpretq_u32_s16", vreinterpretq_u32_s16, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_u32_s32(a: types.i32x4) types.u32x4 {
    return @bitCast(a);
}

test vreinterpretq_u32_s32 {
    const a = std.mem.zeroes(types.i32x4);
    const expected = std.mem.zeroes(types.u32x4);
    try common.testIntrinsic("vreinterpretq_u32_s32", vreinterpretq_u32_s32, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_u32_s64(a: types.i64x2) types.u32x4 {
    return @bitCast(a);
}

test vreinterpretq_u32_s64 {
    const a = std.mem.zeroes(types.i64x2);
    const expected = std.mem.zeroes(types.u32x4);
    try common.testIntrinsic("vreinterpretq_u32_s64", vreinterpretq_u32_s64, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_u32_s8(a: types.i8x16) types.u32x4 {
    return @bitCast(a);
}

test vreinterpretq_u32_s8 {
    const a = std.mem.zeroes(types.i8x16);
    const expected = std.mem.zeroes(types.u32x4);
    try common.testIntrinsic("vreinterpretq_u32_s8", vreinterpretq_u32_s8, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_u32_u16(a: types.u16x8) types.u32x4 {
    return @bitCast(a);
}

test vreinterpretq_u32_u16 {
    const a = std.mem.zeroes(types.u16x8);
    const expected = std.mem.zeroes(types.u32x4);
    try common.testIntrinsic("vreinterpretq_u32_u16", vreinterpretq_u32_u16, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_u32_u64(a: types.u64x2) types.u32x4 {
    return @bitCast(a);
}

test vreinterpretq_u32_u64 {
    const a = std.mem.zeroes(types.u64x2);
    const expected = std.mem.zeroes(types.u32x4);
    try common.testIntrinsic("vreinterpretq_u32_u64", vreinterpretq_u32_u64, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_u32_u8(a: types.u8x16) types.u32x4 {
    return @bitCast(a);
}

test vreinterpretq_u32_u8 {
    const a = std.mem.zeroes(types.u8x16);
    const expected = std.mem.zeroes(types.u32x4);
    try common.testIntrinsic("vreinterpretq_u32_u8", vreinterpretq_u32_u8, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_u64_f16(a: types.f16x8) types.u64x2 {
    return @bitCast(a);
}

test vreinterpretq_u64_f16 {
    const a = std.mem.zeroes(types.f16x8);
    const expected = std.mem.zeroes(types.u64x2);
    try common.testIntrinsic("vreinterpretq_u64_f16", vreinterpretq_u64_f16, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_u64_f32(a: types.f32x4) types.u64x2 {
    return @bitCast(a);
}

test vreinterpretq_u64_f32 {
    const a = std.mem.zeroes(types.f32x4);
    const expected = std.mem.zeroes(types.u64x2);
    try common.testIntrinsic("vreinterpretq_u64_f32", vreinterpretq_u64_f32, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_u64_f64(a: types.f64x2) types.u64x2 {
    return @bitCast(a);
}

test vreinterpretq_u64_f64 {
    const a = std.mem.zeroes(types.f64x2);
    const expected = std.mem.zeroes(types.u64x2);
    try common.testIntrinsic("vreinterpretq_u64_f64", vreinterpretq_u64_f64, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_u64_p128(a: types.p128) types.u64x2 {
    return @bitCast(a);
}

test vreinterpretq_u64_p128 {
    const a = std.mem.zeroes(types.p128);
    const expected = std.mem.zeroes(types.u64x2);
    try common.testIntrinsic("vreinterpretq_u64_p128", vreinterpretq_u64_p128, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_u64_p16(a: types.p16x8) types.u64x2 {
    return @bitCast(a);
}

test vreinterpretq_u64_p16 {
    const a = std.mem.zeroes(types.p16x8);
    const expected = std.mem.zeroes(types.u64x2);
    try common.testIntrinsic("vreinterpretq_u64_p16", vreinterpretq_u64_p16, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_u64_p64(a: types.p64x2) types.u64x2 {
    return @bitCast(a);
}

test vreinterpretq_u64_p64 {
    const a = std.mem.zeroes(types.p64x2);
    const expected = std.mem.zeroes(types.u64x2);
    try common.testIntrinsic("vreinterpretq_u64_p64", vreinterpretq_u64_p64, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_u64_p8(a: types.p8x16) types.u64x2 {
    return @bitCast(a);
}

test vreinterpretq_u64_p8 {
    const a = std.mem.zeroes(types.p8x16);
    const expected = std.mem.zeroes(types.u64x2);
    try common.testIntrinsic("vreinterpretq_u64_p8", vreinterpretq_u64_p8, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_u64_s16(a: types.i16x8) types.u64x2 {
    return @bitCast(a);
}

test vreinterpretq_u64_s16 {
    const a = std.mem.zeroes(types.i16x8);
    const expected = std.mem.zeroes(types.u64x2);
    try common.testIntrinsic("vreinterpretq_u64_s16", vreinterpretq_u64_s16, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_u64_s32(a: types.i32x4) types.u64x2 {
    return @bitCast(a);
}

test vreinterpretq_u64_s32 {
    const a = std.mem.zeroes(types.i32x4);
    const expected = std.mem.zeroes(types.u64x2);
    try common.testIntrinsic("vreinterpretq_u64_s32", vreinterpretq_u64_s32, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_u64_s64(a: types.i64x2) types.u64x2 {
    return @bitCast(a);
}

test vreinterpretq_u64_s64 {
    const a = std.mem.zeroes(types.i64x2);
    const expected = std.mem.zeroes(types.u64x2);
    try common.testIntrinsic("vreinterpretq_u64_s64", vreinterpretq_u64_s64, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_u64_s8(a: types.i8x16) types.u64x2 {
    return @bitCast(a);
}

test vreinterpretq_u64_s8 {
    const a = std.mem.zeroes(types.i8x16);
    const expected = std.mem.zeroes(types.u64x2);
    try common.testIntrinsic("vreinterpretq_u64_s8", vreinterpretq_u64_s8, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_u64_u16(a: types.u16x8) types.u64x2 {
    return @bitCast(a);
}

test vreinterpretq_u64_u16 {
    const a = std.mem.zeroes(types.u16x8);
    const expected = std.mem.zeroes(types.u64x2);
    try common.testIntrinsic("vreinterpretq_u64_u16", vreinterpretq_u64_u16, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_u64_u32(a: types.u32x4) types.u64x2 {
    return @bitCast(a);
}

test vreinterpretq_u64_u32 {
    const a = std.mem.zeroes(types.u32x4);
    const expected = std.mem.zeroes(types.u64x2);
    try common.testIntrinsic("vreinterpretq_u64_u32", vreinterpretq_u64_u32, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_u64_u8(a: types.u8x16) types.u64x2 {
    return @bitCast(a);
}

test vreinterpretq_u64_u8 {
    const a = std.mem.zeroes(types.u8x16);
    const expected = std.mem.zeroes(types.u64x2);
    try common.testIntrinsic("vreinterpretq_u64_u8", vreinterpretq_u64_u8, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_u8_f16(a: types.f16x8) types.u8x16 {
    return @bitCast(a);
}

test vreinterpretq_u8_f16 {
    const a = std.mem.zeroes(types.f16x8);
    const expected = std.mem.zeroes(types.u8x16);
    try common.testIntrinsic("vreinterpretq_u8_f16", vreinterpretq_u8_f16, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_u8_f32(a: types.f32x4) types.u8x16 {
    return @bitCast(a);
}

test vreinterpretq_u8_f32 {
    const a = std.mem.zeroes(types.f32x4);
    const expected = std.mem.zeroes(types.u8x16);
    try common.testIntrinsic("vreinterpretq_u8_f32", vreinterpretq_u8_f32, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_u8_f64(a: types.f64x2) types.u8x16 {
    return @bitCast(a);
}

test vreinterpretq_u8_f64 {
    const a = std.mem.zeroes(types.f64x2);
    const expected = std.mem.zeroes(types.u8x16);
    try common.testIntrinsic("vreinterpretq_u8_f64", vreinterpretq_u8_f64, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_u8_p128(a: types.p128) types.u8x16 {
    return @bitCast(a);
}

test vreinterpretq_u8_p128 {
    const a = std.mem.zeroes(types.p128);
    const expected = std.mem.zeroes(types.u8x16);
    try common.testIntrinsic("vreinterpretq_u8_p128", vreinterpretq_u8_p128, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_u8_p16(a: types.p16x8) types.u8x16 {
    return @bitCast(a);
}

test vreinterpretq_u8_p16 {
    const a = std.mem.zeroes(types.p16x8);
    const expected = std.mem.zeroes(types.u8x16);
    try common.testIntrinsic("vreinterpretq_u8_p16", vreinterpretq_u8_p16, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_u8_p64(a: types.p64x2) types.u8x16 {
    return @bitCast(a);
}

test vreinterpretq_u8_p64 {
    const a = std.mem.zeroes(types.p64x2);
    const expected = std.mem.zeroes(types.u8x16);
    try common.testIntrinsic("vreinterpretq_u8_p64", vreinterpretq_u8_p64, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_u8_p8(a: types.p8x16) types.u8x16 {
    return @bitCast(a);
}

test vreinterpretq_u8_p8 {
    const a = std.mem.zeroes(types.p8x16);
    const expected = std.mem.zeroes(types.u8x16);
    try common.testIntrinsic("vreinterpretq_u8_p8", vreinterpretq_u8_p8, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_u8_s16(a: types.i16x8) types.u8x16 {
    return @bitCast(a);
}

test vreinterpretq_u8_s16 {
    const a = std.mem.zeroes(types.i16x8);
    const expected = std.mem.zeroes(types.u8x16);
    try common.testIntrinsic("vreinterpretq_u8_s16", vreinterpretq_u8_s16, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_u8_s32(a: types.i32x4) types.u8x16 {
    return @bitCast(a);
}

test vreinterpretq_u8_s32 {
    const a = std.mem.zeroes(types.i32x4);
    const expected = std.mem.zeroes(types.u8x16);
    try common.testIntrinsic("vreinterpretq_u8_s32", vreinterpretq_u8_s32, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_u8_s64(a: types.i64x2) types.u8x16 {
    return @bitCast(a);
}

test vreinterpretq_u8_s64 {
    const a = std.mem.zeroes(types.i64x2);
    const expected = std.mem.zeroes(types.u8x16);
    try common.testIntrinsic("vreinterpretq_u8_s64", vreinterpretq_u8_s64, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_u8_s8(a: types.i8x16) types.u8x16 {
    return @bitCast(a);
}

test vreinterpretq_u8_s8 {
    const a = std.mem.zeroes(types.i8x16);
    const expected = std.mem.zeroes(types.u8x16);
    try common.testIntrinsic("vreinterpretq_u8_s8", vreinterpretq_u8_s8, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_u8_u16(a: types.u16x8) types.u8x16 {
    return @bitCast(a);
}

test vreinterpretq_u8_u16 {
    const a = std.mem.zeroes(types.u16x8);
    const expected = std.mem.zeroes(types.u8x16);
    try common.testIntrinsic("vreinterpretq_u8_u16", vreinterpretq_u8_u16, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_u8_u32(a: types.u32x4) types.u8x16 {
    return @bitCast(a);
}

test vreinterpretq_u8_u32 {
    const a = std.mem.zeroes(types.u32x4);
    const expected = std.mem.zeroes(types.u8x16);
    try common.testIntrinsic("vreinterpretq_u8_u32", vreinterpretq_u8_u32, expected, .{a}, null);
}

/// Reinterprets the raw bit pattern of the input vector.
pub inline fn vreinterpretq_u8_u64(a: types.u64x2) types.u8x16 {
    return @bitCast(a);
}

test vreinterpretq_u8_u64 {
    const a = std.mem.zeroes(types.u64x2);
    const expected = std.mem.zeroes(types.u8x16);
    try common.testIntrinsic("vreinterpretq_u8_u64", vreinterpretq_u8_u64, expected, .{a}, null);
}
