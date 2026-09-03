const std = @import("std");
const expectEqual = std.testing.expectEqual;
const arch = @import("../arch.zig");
const types = @import("../types.zig");
const common = @import("../common.zig");

//// Vector bitwise and
pub inline fn vand_s8(a: types.i8x8, b: types.i8x8) types.i8x8 {
    return a & b;
}

test vand_s8 {
    const a: types.i8x8 = .{ 0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07 };
    const b: types.i8x8 = .{ 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F };
    const expected: types.i8x8 = .{ 0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07 };

    try common.testIntrinsic("vand_s8", vand_s8, expected, .{ a, b }, null);
}

/// Vector bitwise and
pub inline fn vand_s16(a: types.i16x4, b: types.i16x4) types.i16x4 {
    return a & b;
}

test vand_s16 {
    const a: types.i16x4 = .{ 0x00, 0x01, 0x02, 0x03 };
    const b: types.i16x4 = .{ 0x0F, 0x0F, 0x0F, 0x0F };
    const expected: types.i16x4 = .{ 0x00, 0x01, 0x02, 0x03 };

    try common.testIntrinsic("vand_s16", vand_s16, expected, .{ a, b }, null);
}

/// Vector bitwise and
pub inline fn vand_s32(a: types.i32x2, b: types.i32x2) types.i32x2 {
    return a & b;
}

test vand_s32 {
    const a: types.i32x2 = .{ 0x00, 0x01 };
    const b: types.i32x2 = .{ 0x0F, 0x0F };
    const expected: types.i32x2 = .{ 0x00, 0x01 };

    try common.testIntrinsic("vand_s32", vand_s32, expected, .{ a, b }, null);
}

/// Vector bitwise and
pub inline fn vand_s64(a: types.i64x1, b: types.i64x1) types.i64x1 {
    return a & b;
}

test vand_s64 {
    const a: types.i64x1 = .{0xFF};
    const b: types.i64x1 = .{0x0F};
    const expected: types.i64x1 = .{0x0F};

    try common.testIntrinsic("vand_s64", vand_s64, expected, .{ a, b }, null);
}

/// Vector bitwise and
pub inline fn vand_u8(a: types.u8x8, b: types.u8x8) types.u8x8 {
    return a & b;
}

test vand_u8 {
    const a: types.u8x8 = .{ 0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07 };
    const b: types.u8x8 = .{ 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F };
    const expected: types.u8x8 = .{ 0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07 };

    try common.testIntrinsic("vand_u8", vand_u8, expected, .{ a, b }, null);
}

/// Vector bitwise and
pub inline fn vand_u16(a: types.i16x4, b: types.i16x4) types.u16x4 {
    return a & b;
}

test vand_u16 {
    const a: types.u16x4 = .{ 0x00, 0x01, 0x02, 0x03 };
    const b: types.u16x4 = .{ 0x0F, 0x0F, 0x0F, 0x0F };
    const expected: types.u16x4 = .{ 0x00, 0x01, 0x02, 0x03 };

    try common.testIntrinsic("vand_u16", vand_u16, expected, .{ a, b }, null);
}

/// Vector bitwise and
pub inline fn vand_u32(a: types.u32x2, b: types.u32x2) types.u32x2 {
    return a & b;
}

test vand_u32 {
    const a: types.u32x2 = .{ 0x00, 0x01 };
    const b: types.u32x2 = .{ 0x0F, 0x0F };
    const expected: types.u32x2 = .{ 0x00, 0x01 };

    try common.testIntrinsic("vand_u32", vand_u32, expected, .{ a, b }, null);
}

/// Vector bitwise and
pub inline fn vand_u64(a: types.u64x1, b: types.u64x1) types.u64x1 {
    return a & b;
}

test vand_u64 {
    const a: types.u64x1 = .{0x00};
    const b: types.u64x1 = .{0x0F};
    const expected: types.u64x1 = .{0x00};

    try common.testIntrinsic("vand_u64", vand_u64, expected, .{ a, b }, null);
}

/// Vector bitwise and
pub inline fn vandq_s8(a: types.i8x16, b: types.i8x16) types.i8x16 {
    return a & b;
}

test vandq_s8 {
    const a: types.i8x16 = .{ 0x00, 0x01, 0x02, 0x03, 0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x00, 0x01, 0x02, 0x03 };
    const b: types.i8x16 = .{ 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F };
    const expected: types.i8x16 = .{ 0x00, 0x01, 0x02, 0x03, 0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x00, 0x01, 0x02, 0x03 };

    try common.testIntrinsic("vandq_s8", vandq_s8, expected, .{ a, b }, null);
}

/// Vector bitwise and
pub inline fn vandq_s16(a: types.i16x8, b: types.i16x8) types.i16x8 {
    return a & b;
}

test vandq_s16 {
    const a: types.i16x8 = .{ 0x00, 0x01, 0x02, 0x03, 0x00, 0x01, 0x02, 0x03 };
    const b: types.i16x8 = .{ 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F };
    const expected: types.i16x8 = .{ 0x00, 0x01, 0x02, 0x03, 0x00, 0x01, 0x02, 0x03 };

    try common.testIntrinsic("vandq_s16", vandq_s16, expected, .{ a, b }, null);
}

/// Vector bitwise and
pub inline fn vandq_s32(a: types.i32x4, b: types.i32x4) types.i32x4 {
    return a & b;
}

test vandq_s32 {
    const a: types.i32x4 = .{ 0x00, 0x01, 0x00, 0x01 };
    const b: types.i32x4 = .{ 0x0F, 0x0F, 0x0F, 0x0F };
    const expected: types.i32x4 = .{ 0x00, 0x01, 0x00, 0x01 };

    try common.testIntrinsic("vandq_s32", vandq_s32, expected, .{ a, b }, null);
}

/// Vector bitwise and
pub inline fn vandq_s64(a: types.i64x2, b: types.i64x2) types.i64x2 {
    return a & b;
}

test vandq_s64 {
    const a: types.i64x2 = .{ 0x00, 0x00 };
    const b: types.i64x2 = .{ 0x0F, 0x0F };
    const expected: types.i64x2 = .{ 0x00, 0x00 };

    try common.testIntrinsic("vandq_s64", vandq_s64, expected, .{ a, b }, null);
}

/// Vector bitwise and
pub inline fn vandq_u8(a: types.u8x16, b: types.u8x16) types.u8x16 {
    return a & b;
}

test vandq_u8 {
    const a: types.u8x16 = .{ 0x00, 0x01, 0x02, 0x03, 0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x00, 0x01, 0x02, 0x03 };
    const b: types.u8x16 = .{ 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F };
    const expected: types.u8x16 = .{ 0x00, 0x01, 0x02, 0x03, 0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x00, 0x01, 0x02, 0x03 };

    try common.testIntrinsic("vandq_u8", vandq_u8, expected, .{ a, b }, null);
}

/// Vector bitwise and
pub inline fn vandq_u16(a: types.i16x8, b: types.i16x8) types.u16x8 {
    return a & b;
}

test vandq_u16 {
    const a: types.u16x8 = .{ 0x00, 0x01, 0x02, 0x03, 0x00, 0x01, 0x02, 0x03 };
    const b: types.u16x8 = .{ 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F };
    const expected: types.u16x8 = .{ 0x00, 0x01, 0x02, 0x03, 0x00, 0x01, 0x02, 0x03 };

    try common.testIntrinsic("vandq_u16", vandq_u16, expected, .{ a, b }, null);
}

/// Vector bitwise and
pub inline fn vandq_u32(a: types.u32x4, b: types.u32x4) types.u32x4 {
    return a & b;
}

test vandq_u32 {
    const a: types.u32x4 = .{ 0x00, 0x01, 0x00, 0x01 };
    const b: types.u32x4 = .{ 0x0F, 0x0F, 0x0F, 0x0F };
    const expected: types.u32x4 = .{ 0x00, 0x01, 0x00, 0x01 };

    try common.testIntrinsic("vandq_u32", vandq_u32, expected, .{ a, b }, null);
}

/// Vector bitwise and
pub inline fn vandq_u64(a: types.u64x2, b: types.u64x2) types.u64x2 {
    return a & b;
}

test vandq_u64 {
    const a: types.u64x2 = .{ 0x00, 0x00 };
    const b: types.u64x2 = .{ 0x0F, 0x0F };
    const expected: types.u64x2 = .{ 0x00, 0x00 };

    try common.testIntrinsic("vandq_u64", vandq_u64, expected, .{ a, b }, null);
}

/// Vector bitwise bit clear
pub inline fn vbic_s8(a: types.i8x8, b: types.i8x8) types.i8x8 {
    return a & ~b;
}

test vbic_s8 {
    const a: types.i8x8 = @splat(1);
    const b: types.i8x8 = @splat(1);
    const expected: types.i8x8 = @splat(0);
    try common.testIntrinsic("vbic_s8", vbic_s8, expected, .{ a, b }, null);
}

/// Vector bitwise bit clear
pub inline fn vbic_s16(a: types.i16x4, b: types.i16x4) types.i16x4 {
    return a & ~b;
}

test vbic_s16 {
    const a: types.i16x4 = @splat(1);
    const b: types.i16x4 = @splat(1);
    const expected: types.i16x4 = @splat(0);
    try common.testIntrinsic("vbic_s16", vbic_s16, expected, .{ a, b }, null);
}

/// Vector bitwise bit clear
pub inline fn vbic_s32(a: types.i32x2, b: types.i32x2) types.i32x2 {
    return a & ~b;
}

test vbic_s32 {
    const a: types.i32x2 = @splat(1);
    const b: types.i32x2 = @splat(1);
    const expected: types.i32x2 = @splat(0);
    try common.testIntrinsic("vbic_s32", vbic_s32, expected, .{ a, b }, null);
}

/// Vector bitwise bit clear
pub inline fn vbic_s64(a: types.i64x1, b: types.i64x1) types.i64x1 {
    return a & ~b;
}

test vbic_s64 {
    const a: types.i64x1 = @splat(1);
    const b: types.i64x1 = @splat(1);
    const expected: types.i64x1 = @splat(0);
    try common.testIntrinsic("vbic_s64", vbic_s64, expected, .{ a, b }, null);
}

/// Vector bitwise bit clear
pub inline fn vbic_u8(a: types.u8x8, b: types.u8x8) types.u8x8 {
    return a & ~b;
}

test vbic_u8 {
    const a: types.u8x8 = @splat(1);
    const b: types.u8x8 = @splat(1);
    const expected: types.u8x8 = @splat(0);
    try common.testIntrinsic("vbic_u8", vbic_u8, expected, .{ a, b }, null);
}

/// Vector bitwise bit clear
pub inline fn vbic_u16(a: types.u16x4, b: types.u16x4) types.u16x4 {
    return a & ~b;
}

test vbic_u16 {
    const a: types.u16x4 = @splat(1);
    const b: types.u16x4 = @splat(1);
    const expected: types.u16x4 = @splat(0);
    try common.testIntrinsic("vbic_u16", vbic_u16, expected, .{ a, b }, null);
}

/// Vector bitwise bit clear
pub inline fn vbic_u32(a: types.u32x2, b: types.u32x2) types.u32x2 {
    return a & ~b;
}

test vbic_u32 {
    const a: types.u32x2 = @splat(1);
    const b: types.u32x2 = @splat(1);
    const expected: types.u32x2 = @splat(0);
    try common.testIntrinsic("vbic_u32", vbic_u32, expected, .{ a, b }, null);
}

/// Vector bitwise bit clear
pub inline fn vbic_u64(a: types.u64x1, b: types.u64x1) types.u64x1 {
    return a & ~b;
}

test vbic_u64 {
    const a: types.u64x1 = @splat(1);
    const b: types.u64x1 = @splat(1);
    const expected: types.u64x1 = @splat(0);
    try common.testIntrinsic("vbic_u64", vbic_u64, expected, .{ a, b }, null);
}

/// Vector bitwise bit clear
pub inline fn vbicq_s8(a: types.i8x16, b: types.i8x16) types.i8x16 {
    return a & ~b;
}

test vbicq_s8 {
    const a: types.i8x16 = @splat(1);
    const b: types.i8x16 = @splat(1);
    const expected: types.i8x16 = @splat(0);
    try common.testIntrinsic("vbicq_s8", vbicq_s8, expected, .{ a, b }, null);
}

/// Vector bitwise bit clear
pub inline fn vbicq_s16(a: types.i16x8, b: types.i16x8) types.i16x8 {
    return a & ~b;
}

test vbicq_s16 {
    const a: types.i16x8 = @splat(1);
    const b: types.i16x8 = @splat(1);
    const expected: types.i16x8 = @splat(0);
    try common.testIntrinsic("vbicq_s16", vbicq_s16, expected, .{ a, b }, null);
}

/// Vector bitwise bit clear
pub inline fn vbicq_s32(a: types.i32x4, b: types.i32x4) types.i32x4 {
    return a & ~b;
}

test vbicq_s32 {
    const a: types.i32x4 = @splat(1);
    const b: types.i32x4 = @splat(1);
    const expected: types.i32x4 = @splat(0);
    try common.testIntrinsic("vbicq_s32", vbicq_s32, expected, .{ a, b }, null);
}

/// Vector bitwise bit clear
pub inline fn vbicq_s64(a: types.i64x2, b: types.i64x2) types.i64x2 {
    return a & ~b;
}

test vbicq_s64 {
    const a: types.i64x2 = @splat(1);
    const b: types.i64x2 = @splat(1);
    const expected: types.i64x2 = @splat(0);
    try common.testIntrinsic("vbicq_s64", vbicq_s64, expected, .{ a, b }, null);
}

/// Vector bitwise bit clear
pub inline fn vbicq_u8(a: types.u8x16, b: types.u8x16) types.u8x16 {
    return a & ~b;
}

test vbicq_u8 {
    const a: types.u8x16 = @splat(1);
    const b: types.u8x16 = @splat(1);
    const expected: types.u8x16 = @splat(0);
    try common.testIntrinsic("vbicq_u8", vbicq_u8, expected, .{ a, b }, null);
}

/// Vector bitwise bit clear
pub inline fn vbicq_u16(a: types.u16x8, b: types.u16x8) types.u16x8 {
    return a & ~b;
}

test vbicq_u16 {
    const a: types.u16x8 = @splat(1);
    const b: types.u16x8 = @splat(1);
    const expected: types.u16x8 = @splat(0);
    try common.testIntrinsic("vbicq_u16", vbicq_u16, expected, .{ a, b }, null);
}

/// Vector bitwise bit clear
pub inline fn vbicq_u32(a: types.u32x4, b: types.u32x4) types.u32x4 {
    return a & ~b;
}

test vbicq_u32 {
    const a: types.u32x4 = @splat(1);
    const b: types.u32x4 = @splat(1);
    const expected: types.u32x4 = @splat(0);
    try common.testIntrinsic("vbicq_u32", vbicq_u32, expected, .{ a, b }, null);
}

/// Vector bitwise bit clear
pub inline fn vbicq_u64(a: types.u64x2, b: types.u64x2) types.u64x2 {
    return a & ~b;
}

test vbicq_u64 {
    const a: types.u64x2 = @splat(1);
    const b: types.u64x2 = @splat(1);
    const expected: types.u64x2 = @splat(0);
    try common.testIntrinsic("vbicq_u64", vbicq_u64, expected, .{ a, b }, null);
}

/// Bitwise Select
pub inline fn vbsl_s8(a: types.i8x8, b: types.i8x8, c: types.i8x8) types.i8x8 {
    return c ^ ((c ^ b) & a);
}

test vbsl_s8 {
    const a: types.i8x8 = .{ -1, -1, -1, -1, 0, 0, 0, 0 };
    const b: types.i8x8 = .{ std.math.maxInt(i8), std.math.maxInt(i8), std.math.maxInt(i8), std.math.maxInt(i8), std.math.maxInt(i8), std.math.maxInt(i8), std.math.maxInt(i8), std.math.maxInt(i8) };
    const c: types.i8x8 = .{ std.math.minInt(i8), std.math.minInt(i8), std.math.minInt(i8), std.math.minInt(i8), std.math.minInt(i8), std.math.minInt(i8), std.math.minInt(i8), std.math.minInt(i8) };
    const expected: types.i8x8 = .{ std.math.maxInt(i8), std.math.maxInt(i8), std.math.maxInt(i8), std.math.maxInt(i8), std.math.minInt(i8), std.math.minInt(i8), std.math.minInt(i8), std.math.minInt(i8) };

    try common.testIntrinsic("vbsl_s8", vbsl_s8, expected, .{ a, b, c }, null);
}

/// Bitwise Select
pub inline fn vbsl_s16(a: types.i16x4, b: types.i16x4, c: types.i16x4) types.i16x4 {
    return c ^ ((c ^ b) & a);
}

test vbsl_s16 {
    const a: types.i16x4 = @splat(1);
    const b: types.i16x4 = @splat(1);
    const c: types.i16x4 = @splat(1);
    const expected: types.i16x4 = .{ 1, 1, 1, 1 };
    try common.testIntrinsic("vbsl_s16", vbsl_s16, expected, .{ a, b, c }, null);
}

/// Bitwise Select
pub inline fn vbsl_s32(a: types.i32x2, b: types.i32x2, c: types.i32x2) types.i32x2 {
    return c ^ ((c ^ b) & a);
}

test vbsl_s32 {
    const a: types.i32x2 = @splat(1);
    const b: types.i32x2 = @splat(1);
    const c: types.i32x2 = @splat(1);
    const expected: types.i32x2 = .{ 1, 1 };
    try common.testIntrinsic("vbsl_s32", vbsl_s32, expected, .{ a, b, c }, null);
}

/// Bitwise Select
pub inline fn vbsl_s64(a: types.i64x1, b: types.i64x1, c: types.i64x1) types.i64x1 {
    return c ^ ((c ^ b) & a);
}

test vbsl_s64 {
    const a: types.i64x1 = @splat(1);
    const b: types.i64x1 = @splat(1);
    const c: types.i64x1 = @splat(1);
    const expected: types.i64x1 = .{1};
    try common.testIntrinsic("vbsl_s64", vbsl_s64, expected, .{ a, b, c }, null);
}

/// Bitwise Select
pub inline fn vbsl_u8(a: types.u8x8, b: types.u8x8, c: types.u8x8) types.u8x8 {
    return c ^ ((c ^ b) & a);
}

test vbsl_u8 {
    const a: types.u8x8 = .{ std.math.maxInt(u8), 0, std.math.maxInt(u8), 2, std.math.maxInt(u8), 0, std.math.maxInt(u8), 0 };
    const b: types.u8x8 = .{ std.math.maxInt(u8), std.math.maxInt(u8), std.math.maxInt(u8), std.math.maxInt(u8), std.math.maxInt(u8), std.math.maxInt(u8), std.math.maxInt(u8), std.math.maxInt(u8) };
    const c: types.u8x8 = .{ std.math.minInt(u8), std.math.minInt(u8), std.math.minInt(u8), std.math.minInt(u8), std.math.minInt(u8), std.math.minInt(u8), std.math.minInt(u8), std.math.minInt(u8) };
    const expected: types.u8x8 = .{ std.math.maxInt(u8), 0, std.math.maxInt(u8), 2, std.math.maxInt(u8), std.math.minInt(u8), std.math.maxInt(u8), std.math.minInt(u8) };

    try common.testIntrinsic("vbsl_u8", vbsl_u8, expected, .{ a, b, c }, null);
}

/// Bitwise Select
pub inline fn vbsl_u16(a: types.u16x4, b: types.u16x4, c: types.u16x4) types.u16x4 {
    return c ^ ((c ^ b) & a);
}

test vbsl_u16 {
    const a: types.u16x4 = .{ std.math.maxInt(u16), 1, std.math.maxInt(u16), 2 };
    const b: types.u16x4 = .{ std.math.maxInt(u16), std.math.maxInt(u16), std.math.maxInt(u16), std.math.maxInt(u16) };
    const c: types.u16x4 = .{ std.math.minInt(u16), std.math.minInt(u16), std.math.minInt(u16), std.math.minInt(u16) };
    const expected: types.u16x4 = .{ std.math.maxInt(u16), 1, std.math.maxInt(u16), 2 };

    try expectEqual(expected, vbsl_u16(a, b, c));
}

/// Bitwise Select
pub inline fn vbsl_u32(a: types.u32x2, b: types.u32x2, c: types.u32x2) types.u32x2 {
    return c ^ ((c ^ b) & a);
}

test vbsl_u32 {
    const a: types.u32x2 = @splat(1);
    const b: types.u32x2 = @splat(1);
    const c: types.u32x2 = @splat(1);
    const expected: types.u32x2 = .{ 1, 1 };
    try common.testIntrinsic("vbsl_u32", vbsl_u32, expected, .{ a, b, c }, null);
}

/// Bitwise Select
pub inline fn vbsl_u64(a: types.i64x1, b: types.i64x1, c: types.i64x1) types.i64x1 {
    return c ^ ((c ^ b) & a);
}

test vbsl_u64 {
    const a: types.i64x1 = @splat(1);
    const b: types.i64x1 = @splat(1);
    const c: types.i64x1 = @splat(1);
    const expected: types.i64x1 = .{1};
    try common.testIntrinsic("vbsl_u64", vbsl_u64, expected, .{ a, b, c }, null);
}

/// Bitwise Select
/// TODO: Once zig implements bitwise operations on vector
///       of floats, we can just do c ^ ((c ^ b) & a).
pub inline fn vbsl_f32(a: types.f32x2, b: types.f32x2, c: types.f32x2) types.f32x2 {
    return @bitCast(@as(types.u32x2, @bitCast(c)) ^ ((@as(types.u32x2, @bitCast(c)) ^ @as(types.u32x2, @bitCast(b))) & @as(types.u32x2, @bitCast(a))));
}

test vbsl_f32 {
    const a: types.f32x2 = .{ std.math.floatMax(f32), 0 };
    const b: types.f32x2 = .{ 5, 5 };
    const c: types.f32x2 = .{ std.math.floatMin(f32), std.math.floatMin(f32) };
    const expected: types.f32x2 = .{ 5, std.math.floatMin(f32) };

    try common.testIntrinsic("vbsl_f32", vbsl_f32, expected, .{ a, b, c }, null);
}

/// Bitwise Select
/// TODO: Once zig implements bitwise operations on vector
///       of floats, we can just do c ^ ((c ^ b) & a).
pub inline fn vbsl_f64(a: types.f64x1, b: types.f64x1, c: types.f64x1) types.f64x1 {
    return @bitCast(@as(types.u64x1, @bitCast(c)) ^ ((@as(types.u64x1, @bitCast(c)) ^ @as(types.u64x1, @bitCast(b))) & @as(types.u64x1, @bitCast(a))));
}

test vbsl_f64 {
    const a: types.f64x1 = .{std.math.floatMax(f64)};
    const b: types.f64x1 = .{5};
    const c: types.f64x1 = .{std.math.floatMin(f64)};
    const expected: types.f64x1 = .{5};

    try expectEqual(expected, vbsl_f64(a, b, c));
}

/// Bitwise Select
pub inline fn vbsl_p8(a: types.p8x8, b: types.p8x8, c: types.p8x8) types.p8x8 {
    return c ^ ((c ^ b) & a);
}

test vbsl_p8 {
    const a: types.p8x8 = @splat(1);
    const b: types.p8x8 = @splat(1);
    const c: types.p8x8 = @splat(1);
    const expected: types.p8x8 = .{ 1, 1, 1, 1, 1, 1, 1, 1 };
    try common.testIntrinsic("vbsl_p8", vbsl_p8, expected, .{ a, b, c }, null);
}

/// Bitwise Select
pub inline fn vbsl_p64(a: types.p64x1, b: types.p64x1, c: types.p64x1) types.p64x1 {
    return c ^ ((c ^ b) & a);
}

test vbsl_p64 {
    const a: types.p64x1 = @splat(1);
    const b: types.p64x1 = @splat(1);
    const c: types.p64x1 = @splat(1);
    const expected: types.p64x1 = .{1};
    try common.testIntrinsic("vbsl_p64", vbsl_p64, expected, .{ a, b, c }, null);
}

/// Bitwise Select
pub inline fn vbsl_p16(a: types.p16x4, b: types.p16x4, c: types.p16x4) types.p16x4 {
    return c ^ ((c ^ b) & a);
}

test vbsl_p16 {
    const a: types.p16x4 = @splat(1);
    const b: types.p16x4 = @splat(1);
    const c: types.p16x4 = @splat(1);
    const expected: types.p16x4 = .{ 1, 1, 1, 1 };
    try common.testIntrinsic("vbsl_p16", vbsl_p16, expected, .{ a, b, c }, null);
}

/// Bitwise Select
pub inline fn vbslq_s8(a: types.i8x16, b: types.i8x16, c: types.i8x16) types.i8x16 {
    return c ^ ((c ^ b) & a);
}

test vbslq_s8 {
    const a: types.i8x16 = @splat(1);
    const b: types.i8x16 = @splat(1);
    const c: types.i8x16 = @splat(1);
    const expected: types.i8x16 = .{ 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 };
    try common.testIntrinsic("vbslq_s8", vbslq_s8, expected, .{ a, b, c }, null);
}

/// Bitwise Select
pub inline fn vbslq_s16(a: types.i16x8, b: types.i16x8, c: types.i16x8) types.i16x8 {
    return c ^ ((c ^ b) & a);
}

test vbslq_s16 {
    const a: types.i16x8 = @splat(1);
    const b: types.i16x8 = @splat(1);
    const c: types.i16x8 = @splat(1);
    const expected: types.i16x8 = .{ 1, 1, 1, 1, 1, 1, 1, 1 };
    try common.testIntrinsic("vbslq_s16", vbslq_s16, expected, .{ a, b, c }, null);
}

/// Bitwise Select
pub inline fn vbslq_s32(a: types.i32x4, b: types.i32x4, c: types.i32x4) types.i32x4 {
    return c ^ ((c ^ b) & a);
}

test vbslq_s32 {
    const a: types.i32x4 = @splat(1);
    const b: types.i32x4 = @splat(1);
    const c: types.i32x4 = @splat(1);
    const expected: types.i32x4 = .{ 1, 1, 1, 1 };
    try common.testIntrinsic("vbslq_s32", vbslq_s32, expected, .{ a, b, c }, null);
}

/// Bitwise Select
pub inline fn vbslq_s64(a: types.i64x2, b: types.i64x2, c: types.i64x2) types.i64x2 {
    return c ^ ((c ^ b) & a);
}

test vbslq_s64 {
    const a: types.i64x2 = @splat(1);
    const b: types.i64x2 = @splat(1);
    const c: types.i64x2 = @splat(1);
    const expected: types.i64x2 = .{ 1, 1 };
    try common.testIntrinsic("vbslq_s64", vbslq_s64, expected, .{ a, b, c }, null);
}

/// Bitwise Select
pub inline fn vbslq_u8(a: types.u8x16, b: types.u8x16, c: types.u8x16) types.u8x16 {
    return c ^ ((c ^ b) & a);
}

test vbslq_u8 {
    const a: types.u8x16 = @splat(1);
    const b: types.u8x16 = @splat(1);
    const c: types.u8x16 = @splat(1);
    const expected: types.u8x16 = .{ 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 };
    try common.testIntrinsic("vbslq_u8", vbslq_u8, expected, .{ a, b, c }, null);
}

/// Bitwise Select
pub inline fn vbslq_u16(a: types.u16x8, b: types.u16x8, c: types.u16x8) types.u16x8 {
    return c ^ ((c ^ b) & a);
}

test vbslq_u16 {
    const a: types.u16x8 = @splat(1);
    const b: types.u16x8 = @splat(1);
    const c: types.u16x8 = @splat(1);
    const expected: types.u16x8 = .{ 1, 1, 1, 1, 1, 1, 1, 1 };
    try common.testIntrinsic("vbslq_u16", vbslq_u16, expected, .{ a, b, c }, null);
}

/// Bitwise Select
pub inline fn vbslq_u32(a: types.u32x4, b: types.u32x4, c: types.u32x4) types.u32x4 {
    return c ^ ((c ^ b) & a);
}

test vbslq_u32 {
    const a: types.u32x4 = @splat(1);
    const b: types.u32x4 = @splat(1);
    const c: types.u32x4 = @splat(1);
    const expected: types.u32x4 = .{ 1, 1, 1, 1 };
    try common.testIntrinsic("vbslq_u32", vbslq_u32, expected, .{ a, b, c }, null);
}

/// Bitwise Select
pub inline fn vbslq_u64(a: types.i64x2, b: types.i64x2, c: types.i64x2) types.i64x2 {
    return c ^ ((c ^ b) & a);
}

test vbslq_u64 {
    const a: types.i64x2 = @splat(1);
    const b: types.i64x2 = @splat(1);
    const c: types.i64x2 = @splat(1);
    const expected: types.i64x2 = .{ 1, 1 };
    try common.testIntrinsic("vbslq_u64", vbslq_u64, expected, .{ a, b, c }, null);
}

/// Bitwise Select
pub inline fn vbslq_f32(a: types.f32x4, b: types.f32x4, c: types.f32x4) types.f32x4 {
    const a_cast: types.u32x4 = @bitCast(a);
    const b_cast: types.u32x4 = @bitCast(b);
    const c_cast: types.u32x4 = @bitCast(c);
    return @bitCast(c_cast ^ ((c_cast ^ b_cast) & a_cast));
}

test vbslq_f32 {
    const a: types.f32x4 = @splat(1.0);
    const b: types.f32x4 = @splat(1.0);
    const c: types.f32x4 = @splat(1.0);
    const expected: types.f32x4 = .{ 1, 1, 1, 1 };
    try common.testIntrinsic("vbslq_f32", vbslq_f32, expected, .{ a, b, c }, null);
}

/// Bitwise Select
pub inline fn vbslq_f64(a: types.f64x2, b: types.f64x2, c: types.f64x2) types.f64x2 {
    const a_cast: types.u64x2 = @bitCast(a);
    const b_cast: types.u64x2 = @bitCast(b);
    const c_cast: types.u64x2 = @bitCast(c);
    return @bitCast(c_cast ^ ((c_cast ^ b_cast) & a_cast));
}

test vbslq_f64 {
    const a: types.f64x2 = @splat(1.0);
    const b: types.f64x2 = @splat(1.0);
    const c: types.f64x2 = @splat(1.0);
    const expected: types.f64x2 = .{ 1, 1 };
    try common.testIntrinsic("vbslq_f64", vbslq_f64, expected, .{ a, b, c }, null);
}

/// Bitwise Select
pub inline fn vbslq_p8(a: types.p8x16, b: types.p8x16, c: types.p8x16) types.p8x16 {
    return c ^ ((c ^ b) & a);
}

test vbslq_p8 {
    const a: types.p8x16 = @splat(1);
    const b: types.p8x16 = @splat(1);
    const c: types.p8x16 = @splat(1);
    const expected: types.p8x16 = .{ 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 };
    try common.testIntrinsic("vbslq_p8", vbslq_p8, expected, .{ a, b, c }, null);
}

/// Bitwise Select
pub inline fn vbslq_p16(a: types.p16x8, b: types.p16x8, c: types.p16x8) types.p16x8 {
    return c ^ ((c ^ b) & a);
}

test vbslq_p16 {
    const a: types.p16x8 = @splat(1);
    const b: types.p16x8 = @splat(1);
    const c: types.p16x8 = @splat(1);
    const expected: types.p16x8 = .{ 1, 1, 1, 1, 1, 1, 1, 1 };
    try common.testIntrinsic("vbslq_p16", vbslq_p16, expected, .{ a, b, c }, null);
}

/// Bitwise Select
pub inline fn vbslq_p64(a: types.p64x2, b: types.p64x2, c: types.p64x2) types.p64x2 {
    return c ^ ((c ^ b) & a);
}

test vbslq_p64 {
    const a: types.p64x2 = @splat(1);
    const b: types.p64x2 = @splat(1);
    const c: types.p64x2 = @splat(1);
    const expected: types.p64x2 = .{ 1, 1 };
    try common.testIntrinsic("vbslq_p64", vbslq_p64, expected, .{ a, b, c }, null);
}

/// Bit clear and exclusive OR
pub inline fn vbcaxq_s8(a: types.i8x16, b: types.i8x16, c: types.i8x16) types.i8x16 {
    return a ^ (b & ~c);
}

test vbcaxq_s8 {
    const a: types.i8x16 = .{ 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0 };
    const b: types.i8x16 = .{ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 };
    const c: types.i8x16 = .{ 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 };
    const expected: types.i8x16 = .{ 1, 0, 3, 2, 5, 4, 7, 6, 9, 8, 11, 10, 13, 12, 15, 14 };

    try common.testIntrinsic("vbcaxq_s8", vbcaxq_s8, expected, .{ a, b, c }, null);
}

/// Bit clear and exclusive OR
pub inline fn vbcaxq_s16(a: types.i16x8, b: types.i16x8, c: types.i16x8) types.i16x8 {
    return a ^ (b & ~c);
}

test vbcaxq_s16 {
    const a: types.i16x8 = .{ 1, 0, 1, 0, 1, 0, 1, 0 };
    const b: types.i16x8 = .{ 0, 1, 2, 3, 4, 5, 6, 7 };
    const c: types.i16x8 = .{ 1, 1, 1, 1, 1, 1, 1, 1 };
    const expected: types.i16x8 = .{ 1, 0, 3, 2, 5, 4, 7, 6 };

    try common.testIntrinsic("vbcaxq_s16", vbcaxq_s16, expected, .{ a, b, c }, null);
}

/// Bit clear and exclusive OR
pub inline fn vbcaxq_s32(a: types.i32x4, b: types.i32x4, c: types.i32x4) types.i32x4 {
    return a ^ (b & ~c);
}

test vbcaxq_s32 {
    const a: types.i32x4 = .{ 1, 0, 1, 0 };
    const b: types.i32x4 = .{ 0, 1, 2, 3 };
    const c: types.i32x4 = .{ 1, 1, 1, 1 };
    const expected: types.i32x4 = .{ 1, 0, 3, 2 };

    try common.testIntrinsic("vbcaxq_s32", vbcaxq_s32, expected, .{ a, b, c }, null);
}

/// Bit clear and exclusive OR
pub inline fn vbcaxq_s64(a: types.i64x2, b: types.i64x2, c: types.i64x2) types.i64x2 {
    return a ^ (b & ~c);
}

test vbcaxq_s64 {
    const a: types.i64x2 = .{ 1, 0 };
    const b: types.i64x2 = .{ 0, 1 };
    const c: types.i64x2 = .{ 1, 1 };
    const expected: types.i64x2 = .{ 1, 0 };

    try common.testIntrinsic("vbcaxq_s64", vbcaxq_s64, expected, .{ a, b, c }, null);
}

// --- Auto-generated Bitwise Intrinsics ---
pub inline fn veor_s16(a: types.i16x4, b: types.i16x4) types.i16x4 {
    return a ^ b;
}

test veor_s16 {
    const a = std.mem.zeroes(types.i16x4);
    const b = std.mem.zeroes(types.i16x4);
    const expected = std.mem.zeroes(types.i16x4);
    try common.testIntrinsic("veor_s16", veor_s16, expected, .{ a, b }, null);
}

pub inline fn veor_s32(a: types.i32x2, b: types.i32x2) types.i32x2 {
    return a ^ b;
}

test veor_s32 {
    const a = std.mem.zeroes(types.i32x2);
    const b = std.mem.zeroes(types.i32x2);
    const expected = std.mem.zeroes(types.i32x2);
    try common.testIntrinsic("veor_s32", veor_s32, expected, .{ a, b }, null);
}

pub inline fn veor_s64(a: types.i64x1, b: types.i64x1) types.i64x1 {
    return a ^ b;
}

test veor_s64 {
    const a = std.mem.zeroes(types.i64x1);
    const b = std.mem.zeroes(types.i64x1);
    const expected = std.mem.zeroes(types.i64x1);
    try common.testIntrinsic("veor_s64", veor_s64, expected, .{ a, b }, null);
}

pub inline fn veor_s8(a: types.i8x8, b: types.i8x8) types.i8x8 {
    return a ^ b;
}

test veor_s8 {
    const a = std.mem.zeroes(types.i8x8);
    const b = std.mem.zeroes(types.i8x8);
    const expected = std.mem.zeroes(types.i8x8);
    try common.testIntrinsic("veor_s8", veor_s8, expected, .{ a, b }, null);
}

pub inline fn veor_u16(a: types.u16x4, b: types.u16x4) types.u16x4 {
    return a ^ b;
}

test veor_u16 {
    const a = std.mem.zeroes(types.u16x4);
    const b = std.mem.zeroes(types.u16x4);
    const expected = std.mem.zeroes(types.u16x4);
    try common.testIntrinsic("veor_u16", veor_u16, expected, .{ a, b }, null);
}

pub inline fn veor_u32(a: types.u32x2, b: types.u32x2) types.u32x2 {
    return a ^ b;
}

test veor_u32 {
    const a = std.mem.zeroes(types.u32x2);
    const b = std.mem.zeroes(types.u32x2);
    const expected = std.mem.zeroes(types.u32x2);
    try common.testIntrinsic("veor_u32", veor_u32, expected, .{ a, b }, null);
}

pub inline fn veor_u64(a: types.u64x1, b: types.u64x1) types.u64x1 {
    return a ^ b;
}

test veor_u64 {
    const a = std.mem.zeroes(types.u64x1);
    const b = std.mem.zeroes(types.u64x1);
    const expected = std.mem.zeroes(types.u64x1);
    try common.testIntrinsic("veor_u64", veor_u64, expected, .{ a, b }, null);
}

pub inline fn veor_u8(a: types.u8x8, b: types.u8x8) types.u8x8 {
    return a ^ b;
}

test veor_u8 {
    const a = std.mem.zeroes(types.u8x8);
    const b = std.mem.zeroes(types.u8x8);
    const expected = std.mem.zeroes(types.u8x8);
    try common.testIntrinsic("veor_u8", veor_u8, expected, .{ a, b }, null);
}

pub inline fn veorq_s16(a: types.i16x8, b: types.i16x8) types.i16x8 {
    return a ^ b;
}

test veorq_s16 {
    const a = std.mem.zeroes(types.i16x8);
    const b = std.mem.zeroes(types.i16x8);
    const expected = std.mem.zeroes(types.i16x8);
    try common.testIntrinsic("veorq_s16", veorq_s16, expected, .{ a, b }, null);
}

pub inline fn veorq_s32(a: types.i32x4, b: types.i32x4) types.i32x4 {
    return a ^ b;
}

test veorq_s32 {
    const a = std.mem.zeroes(types.i32x4);
    const b = std.mem.zeroes(types.i32x4);
    const expected = std.mem.zeroes(types.i32x4);
    try common.testIntrinsic("veorq_s32", veorq_s32, expected, .{ a, b }, null);
}

pub inline fn veorq_s64(a: types.i64x2, b: types.i64x2) types.i64x2 {
    return a ^ b;
}

test veorq_s64 {
    const a = std.mem.zeroes(types.i64x2);
    const b = std.mem.zeroes(types.i64x2);
    const expected = std.mem.zeroes(types.i64x2);
    try common.testIntrinsic("veorq_s64", veorq_s64, expected, .{ a, b }, null);
}

pub inline fn veorq_s8(a: types.i8x16, b: types.i8x16) types.i8x16 {
    return a ^ b;
}

test veorq_s8 {
    const a = std.mem.zeroes(types.i8x16);
    const b = std.mem.zeroes(types.i8x16);
    const expected = std.mem.zeroes(types.i8x16);
    try common.testIntrinsic("veorq_s8", veorq_s8, expected, .{ a, b }, null);
}

pub inline fn veorq_u16(a: types.u16x8, b: types.u16x8) types.u16x8 {
    return a ^ b;
}

test veorq_u16 {
    const a = std.mem.zeroes(types.u16x8);
    const b = std.mem.zeroes(types.u16x8);
    const expected = std.mem.zeroes(types.u16x8);
    try common.testIntrinsic("veorq_u16", veorq_u16, expected, .{ a, b }, null);
}

pub inline fn veorq_u32(a: types.u32x4, b: types.u32x4) types.u32x4 {
    return a ^ b;
}

test veorq_u32 {
    const a = std.mem.zeroes(types.u32x4);
    const b = std.mem.zeroes(types.u32x4);
    const expected = std.mem.zeroes(types.u32x4);
    try common.testIntrinsic("veorq_u32", veorq_u32, expected, .{ a, b }, null);
}

pub inline fn veorq_u64(a: types.u64x2, b: types.u64x2) types.u64x2 {
    return a ^ b;
}

test veorq_u64 {
    const a = std.mem.zeroes(types.u64x2);
    const b = std.mem.zeroes(types.u64x2);
    const expected = std.mem.zeroes(types.u64x2);
    try common.testIntrinsic("veorq_u64", veorq_u64, expected, .{ a, b }, null);
}

pub inline fn veorq_u8(a: types.u8x16, b: types.u8x16) types.u8x16 {
    return a ^ b;
}

test veorq_u8 {
    const a = std.mem.zeroes(types.u8x16);
    const b = std.mem.zeroes(types.u8x16);
    const expected = std.mem.zeroes(types.u8x16);
    try common.testIntrinsic("veorq_u8", veorq_u8, expected, .{ a, b }, null);
}

pub inline fn vorn_s16(a: types.i16x4, b: types.i16x4) types.i16x4 {
    return a | ~b;
}

test vorn_s16 {
    const a = std.mem.zeroes(types.i16x4);
    const b = std.mem.zeroes(types.i16x4);
    const expected: types.i16x4 = @splat(-1);
    try common.testIntrinsic("vorn_s16", vorn_s16, expected, .{ a, b }, null);
}

pub inline fn vorn_s32(a: types.i32x2, b: types.i32x2) types.i32x2 {
    return a | ~b;
}

test vorn_s32 {
    const a = std.mem.zeroes(types.i32x2);
    const b = std.mem.zeroes(types.i32x2);
    const expected: types.i32x2 = @splat(-1);
    try common.testIntrinsic("vorn_s32", vorn_s32, expected, .{ a, b }, null);
}

pub inline fn vorn_s64(a: types.i64x1, b: types.i64x1) types.i64x1 {
    return a | ~b;
}

test vorn_s64 {
    const a = std.mem.zeroes(types.i64x1);
    const b = std.mem.zeroes(types.i64x1);
    const expected: types.i64x1 = @splat(-1);
    try common.testIntrinsic("vorn_s64", vorn_s64, expected, .{ a, b }, null);
}

pub inline fn vorn_s8(a: types.i8x8, b: types.i8x8) types.i8x8 {
    return a | ~b;
}

test vorn_s8 {
    const a = std.mem.zeroes(types.i8x8);
    const b = std.mem.zeroes(types.i8x8);
    const expected: types.i8x8 = @splat(-1);
    try common.testIntrinsic("vorn_s8", vorn_s8, expected, .{ a, b }, null);
}

pub inline fn vorn_u16(a: types.u16x4, b: types.u16x4) types.u16x4 {
    return a | ~b;
}

test vorn_u16 {
    const a = std.mem.zeroes(types.u16x4);
    const b = std.mem.zeroes(types.u16x4);
    const expected: types.u16x4 = @splat(std.math.maxInt(u16));
    try common.testIntrinsic("vorn_u16", vorn_u16, expected, .{ a, b }, null);
}

pub inline fn vorn_u32(a: types.u32x2, b: types.u32x2) types.u32x2 {
    return a | ~b;
}

test vorn_u32 {
    const a = std.mem.zeroes(types.u32x2);
    const b = std.mem.zeroes(types.u32x2);
    const expected: types.u32x2 = @splat(std.math.maxInt(u32));
    try common.testIntrinsic("vorn_u32", vorn_u32, expected, .{ a, b }, null);
}

pub inline fn vorn_u64(a: types.u64x1, b: types.u64x1) types.u64x1 {
    return a | ~b;
}

test vorn_u64 {
    const a = std.mem.zeroes(types.u64x1);
    const b = std.mem.zeroes(types.u64x1);
    const expected: types.u64x1 = @splat(std.math.maxInt(u64));
    try common.testIntrinsic("vorn_u64", vorn_u64, expected, .{ a, b }, null);
}

pub inline fn vorn_u8(a: types.u8x8, b: types.u8x8) types.u8x8 {
    return a | ~b;
}

test vorn_u8 {
    const a = std.mem.zeroes(types.u8x8);
    const b = std.mem.zeroes(types.u8x8);
    const expected: types.u8x8 = @splat(std.math.maxInt(u8));
    try common.testIntrinsic("vorn_u8", vorn_u8, expected, .{ a, b }, null);
}

pub inline fn vornq_s16(a: types.i16x8, b: types.i16x8) types.i16x8 {
    return a | ~b;
}

test vornq_s16 {
    const a = std.mem.zeroes(types.i16x8);
    const b = std.mem.zeroes(types.i16x8);
    const expected: types.i16x8 = @splat(-1);
    try common.testIntrinsic("vornq_s16", vornq_s16, expected, .{ a, b }, null);
}

pub inline fn vornq_s32(a: types.i32x4, b: types.i32x4) types.i32x4 {
    return a | ~b;
}

test vornq_s32 {
    const a = std.mem.zeroes(types.i32x4);
    const b = std.mem.zeroes(types.i32x4);
    const expected: types.i32x4 = @splat(-1);
    try common.testIntrinsic("vornq_s32", vornq_s32, expected, .{ a, b }, null);
}

pub inline fn vornq_s64(a: types.i64x2, b: types.i64x2) types.i64x2 {
    return a | ~b;
}

test vornq_s64 {
    const a = std.mem.zeroes(types.i64x2);
    const b = std.mem.zeroes(types.i64x2);
    const expected: types.i64x2 = @splat(-1);
    try common.testIntrinsic("vornq_s64", vornq_s64, expected, .{ a, b }, null);
}

pub inline fn vornq_s8(a: types.i8x16, b: types.i8x16) types.i8x16 {
    return a | ~b;
}

test vornq_s8 {
    const a = std.mem.zeroes(types.i8x16);
    const b = std.mem.zeroes(types.i8x16);
    const expected: types.i8x16 = @splat(-1);
    try common.testIntrinsic("vornq_s8", vornq_s8, expected, .{ a, b }, null);
}

pub inline fn vornq_u16(a: types.u16x8, b: types.u16x8) types.u16x8 {
    return a | ~b;
}

test vornq_u16 {
    const a = std.mem.zeroes(types.u16x8);
    const b = std.mem.zeroes(types.u16x8);
    const expected: types.u16x8 = @splat(std.math.maxInt(u16));
    try common.testIntrinsic("vornq_u16", vornq_u16, expected, .{ a, b }, null);
}

pub inline fn vornq_u32(a: types.u32x4, b: types.u32x4) types.u32x4 {
    return a | ~b;
}

test vornq_u32 {
    const a = std.mem.zeroes(types.u32x4);
    const b = std.mem.zeroes(types.u32x4);
    const expected: types.u32x4 = @splat(std.math.maxInt(u32));
    try common.testIntrinsic("vornq_u32", vornq_u32, expected, .{ a, b }, null);
}

pub inline fn vornq_u64(a: types.u64x2, b: types.u64x2) types.u64x2 {
    return a | ~b;
}

test vornq_u64 {
    const a = std.mem.zeroes(types.u64x2);
    const b = std.mem.zeroes(types.u64x2);
    const expected: types.u64x2 = @splat(std.math.maxInt(u64));
    try common.testIntrinsic("vornq_u64", vornq_u64, expected, .{ a, b }, null);
}

pub inline fn vornq_u8(a: types.u8x16, b: types.u8x16) types.u8x16 {
    return a | ~b;
}

test vornq_u8 {
    const a = std.mem.zeroes(types.u8x16);
    const b = std.mem.zeroes(types.u8x16);
    const expected: types.u8x16 = @splat(std.math.maxInt(u8));
    try common.testIntrinsic("vornq_u8", vornq_u8, expected, .{ a, b }, null);
}

pub inline fn vorr_s16(a: types.i16x4, b: types.i16x4) types.i16x4 {
    return a | b;
}

test vorr_s16 {
    const a = std.mem.zeroes(types.i16x4);
    const b = std.mem.zeroes(types.i16x4);
    const expected = std.mem.zeroes(types.i16x4);
    try common.testIntrinsic("vorr_s16", vorr_s16, expected, .{ a, b }, null);
}

pub inline fn vorr_s32(a: types.i32x2, b: types.i32x2) types.i32x2 {
    return a | b;
}

test vorr_s32 {
    const a = std.mem.zeroes(types.i32x2);
    const b = std.mem.zeroes(types.i32x2);
    const expected = std.mem.zeroes(types.i32x2);
    try common.testIntrinsic("vorr_s32", vorr_s32, expected, .{ a, b }, null);
}

pub inline fn vorr_s64(a: types.i64x1, b: types.i64x1) types.i64x1 {
    return a | b;
}

test vorr_s64 {
    const a = std.mem.zeroes(types.i64x1);
    const b = std.mem.zeroes(types.i64x1);
    const expected = std.mem.zeroes(types.i64x1);
    try common.testIntrinsic("vorr_s64", vorr_s64, expected, .{ a, b }, null);
}

pub inline fn vorr_s8(a: types.i8x8, b: types.i8x8) types.i8x8 {
    return a | b;
}

test vorr_s8 {
    const a = std.mem.zeroes(types.i8x8);
    const b = std.mem.zeroes(types.i8x8);
    const expected = std.mem.zeroes(types.i8x8);
    try common.testIntrinsic("vorr_s8", vorr_s8, expected, .{ a, b }, null);
}

pub inline fn vorr_u16(a: types.u16x4, b: types.u16x4) types.u16x4 {
    return a | b;
}

test vorr_u16 {
    const a = std.mem.zeroes(types.u16x4);
    const b = std.mem.zeroes(types.u16x4);
    const expected = std.mem.zeroes(types.u16x4);
    try common.testIntrinsic("vorr_u16", vorr_u16, expected, .{ a, b }, null);
}

pub inline fn vorr_u32(a: types.u32x2, b: types.u32x2) types.u32x2 {
    return a | b;
}

test vorr_u32 {
    const a = std.mem.zeroes(types.u32x2);
    const b = std.mem.zeroes(types.u32x2);
    const expected = std.mem.zeroes(types.u32x2);
    try common.testIntrinsic("vorr_u32", vorr_u32, expected, .{ a, b }, null);
}

pub inline fn vorr_u64(a: types.u64x1, b: types.u64x1) types.u64x1 {
    return a | b;
}

test vorr_u64 {
    const a = std.mem.zeroes(types.u64x1);
    const b = std.mem.zeroes(types.u64x1);
    const expected = std.mem.zeroes(types.u64x1);
    try common.testIntrinsic("vorr_u64", vorr_u64, expected, .{ a, b }, null);
}

pub inline fn vorr_u8(a: types.u8x8, b: types.u8x8) types.u8x8 {
    return a | b;
}

test vorr_u8 {
    const a = std.mem.zeroes(types.u8x8);
    const b = std.mem.zeroes(types.u8x8);
    const expected = std.mem.zeroes(types.u8x8);
    try common.testIntrinsic("vorr_u8", vorr_u8, expected, .{ a, b }, null);
}

pub inline fn vorrq_s16(a: types.i16x8, b: types.i16x8) types.i16x8 {
    return a | b;
}

test vorrq_s16 {
    const a = std.mem.zeroes(types.i16x8);
    const b = std.mem.zeroes(types.i16x8);
    const expected = std.mem.zeroes(types.i16x8);
    try common.testIntrinsic("vorrq_s16", vorrq_s16, expected, .{ a, b }, null);
}

pub inline fn vorrq_s32(a: types.i32x4, b: types.i32x4) types.i32x4 {
    return a | b;
}

test vorrq_s32 {
    const a = std.mem.zeroes(types.i32x4);
    const b = std.mem.zeroes(types.i32x4);
    const expected = std.mem.zeroes(types.i32x4);
    try common.testIntrinsic("vorrq_s32", vorrq_s32, expected, .{ a, b }, null);
}

pub inline fn vorrq_s64(a: types.i64x2, b: types.i64x2) types.i64x2 {
    return a | b;
}

test vorrq_s64 {
    const a = std.mem.zeroes(types.i64x2);
    const b = std.mem.zeroes(types.i64x2);
    const expected = std.mem.zeroes(types.i64x2);
    try common.testIntrinsic("vorrq_s64", vorrq_s64, expected, .{ a, b }, null);
}

pub inline fn vorrq_s8(a: types.i8x16, b: types.i8x16) types.i8x16 {
    return a | b;
}

test vorrq_s8 {
    const a = std.mem.zeroes(types.i8x16);
    const b = std.mem.zeroes(types.i8x16);
    const expected = std.mem.zeroes(types.i8x16);
    try common.testIntrinsic("vorrq_s8", vorrq_s8, expected, .{ a, b }, null);
}

pub inline fn vorrq_u16(a: types.u16x8, b: types.u16x8) types.u16x8 {
    return a | b;
}

test vorrq_u16 {
    const a = std.mem.zeroes(types.u16x8);
    const b = std.mem.zeroes(types.u16x8);
    const expected = std.mem.zeroes(types.u16x8);
    try common.testIntrinsic("vorrq_u16", vorrq_u16, expected, .{ a, b }, null);
}

pub inline fn vorrq_u32(a: types.u32x4, b: types.u32x4) types.u32x4 {
    return a | b;
}

test vorrq_u32 {
    const a = std.mem.zeroes(types.u32x4);
    const b = std.mem.zeroes(types.u32x4);
    const expected = std.mem.zeroes(types.u32x4);
    try common.testIntrinsic("vorrq_u32", vorrq_u32, expected, .{ a, b }, null);
}

pub inline fn vorrq_u64(a: types.u64x2, b: types.u64x2) types.u64x2 {
    return a | b;
}

test vorrq_u64 {
    const a = std.mem.zeroes(types.u64x2);
    const b = std.mem.zeroes(types.u64x2);
    const expected = std.mem.zeroes(types.u64x2);
    try common.testIntrinsic("vorrq_u64", vorrq_u64, expected, .{ a, b }, null);
}

pub inline fn vorrq_u8(a: types.u8x16, b: types.u8x16) types.u8x16 {
    return a | b;
}

test vorrq_u8 {
    const a = std.mem.zeroes(types.u8x16);
    const b = std.mem.zeroes(types.u8x16);
    const expected = std.mem.zeroes(types.u8x16);
    try common.testIntrinsic("vorrq_u8", vorrq_u8, expected, .{ a, b }, null);
}

// --- Auto-generated Bitwise Intrinsics ---
pub inline fn vbcaxq_u8(a: types.u8x16, b: types.u8x16, c: types.u8x16) types.u8x16 {
    return a ^ (b & ~c);
}

test vbcaxq_u8 {
    const a = std.mem.zeroes(types.u8x16);
    const b = std.mem.zeroes(types.u8x16);
    const c = std.mem.zeroes(types.u8x16);
    const expected = std.mem.zeroes(types.u8x16);
    try common.testIntrinsic("vbcaxq_u8", vbcaxq_u8, expected, .{ a, b, c }, null);
}
pub inline fn vbcaxq_u16(a: types.u16x8, b: types.u16x8, c: types.u16x8) types.u16x8 {
    return a ^ (b & ~c);
}

test vbcaxq_u16 {
    const a = std.mem.zeroes(types.u16x8);
    const b = std.mem.zeroes(types.u16x8);
    const c = std.mem.zeroes(types.u16x8);
    const expected = std.mem.zeroes(types.u16x8);
    try common.testIntrinsic("vbcaxq_u16", vbcaxq_u16, expected, .{ a, b, c }, null);
}
pub inline fn vbcaxq_u32(a: types.u32x4, b: types.u32x4, c: types.u32x4) types.u32x4 {
    return a ^ (b & ~c);
}

test vbcaxq_u32 {
    const a = std.mem.zeroes(types.u32x4);
    const b = std.mem.zeroes(types.u32x4);
    const c = std.mem.zeroes(types.u32x4);
    const expected = std.mem.zeroes(types.u32x4);
    try common.testIntrinsic("vbcaxq_u32", vbcaxq_u32, expected, .{ a, b, c }, null);
}
pub inline fn vbcaxq_u64(a: types.u64x2, b: types.u64x2, c: types.u64x2) types.u64x2 {
    return a ^ (b & ~c);
}

test vbcaxq_u64 {
    const a = std.mem.zeroes(types.u64x2);
    const b = std.mem.zeroes(types.u64x2);
    const c = std.mem.zeroes(types.u64x2);
    const expected = std.mem.zeroes(types.u64x2);
    try common.testIntrinsic("vbcaxq_u64", vbcaxq_u64, expected, .{ a, b, c }, null);
}
