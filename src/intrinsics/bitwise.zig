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

    try common.testIntrinsic(.{ .func = vand_s8, .expected = expected, .args = .{ a, b } });
}

/// Vector bitwise and
pub inline fn vand_s16(a: types.i16x4, b: types.i16x4) types.i16x4 {
    return a & b;
}

test vand_s16 {
    const a: types.i16x4 = .{ 0x00, 0x01, 0x02, 0x03 };
    const b: types.i16x4 = .{ 0x0F, 0x0F, 0x0F, 0x0F };
    const expected: types.i16x4 = .{ 0x00, 0x01, 0x02, 0x03 };

    try common.testIntrinsic(.{ .func = vand_s16, .expected = expected, .args = .{ a, b } });
}

/// Vector bitwise and
pub inline fn vand_s32(a: types.i32x2, b: types.i32x2) types.i32x2 {
    return a & b;
}

test vand_s32 {
    const a: types.i32x2 = .{ 0x00, 0x01 };
    const b: types.i32x2 = .{ 0x0F, 0x0F };
    const expected: types.i32x2 = .{ 0x00, 0x01 };

    try common.testIntrinsic(.{ .func = vand_s32, .expected = expected, .args = .{ a, b } });
}

/// Vector bitwise and
pub inline fn vand_s64(a: types.i64x1, b: types.i64x1) types.i64x1 {
    return a & b;
}

test vand_s64 {
    const a: types.i64x1 = .{0xFF};
    const b: types.i64x1 = .{0x0F};
    const expected: types.i64x1 = .{0x0F};

    try common.testIntrinsic(.{ .func = vand_s64, .expected = expected, .args = .{ a, b } });
}

/// Vector bitwise and
pub inline fn vand_u8(a: types.u8x8, b: types.u8x8) types.u8x8 {
    return a & b;
}

test vand_u8 {
    const a: types.u8x8 = .{ 0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07 };
    const b: types.u8x8 = .{ 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F };
    const expected: types.u8x8 = .{ 0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07 };

    try common.testIntrinsic(.{ .func = vand_u8, .expected = expected, .args = .{ a, b } });
}

/// Vector bitwise and
pub inline fn vand_u16(a: types.i16x4, b: types.i16x4) types.u16x4 {
    return a & b;
}

test vand_u16 {
    const a: types.u16x4 = .{ 0x00, 0x01, 0x02, 0x03 };
    const b: types.u16x4 = .{ 0x0F, 0x0F, 0x0F, 0x0F };
    const expected: types.u16x4 = .{ 0x00, 0x01, 0x02, 0x03 };

    try common.testIntrinsic(.{ .func = vand_u16, .expected = expected, .args = .{ a, b } });
}

/// Vector bitwise and
pub inline fn vand_u32(a: types.u32x2, b: types.u32x2) types.u32x2 {
    return a & b;
}

test vand_u32 {
    const a: types.u32x2 = .{ 0x00, 0x01 };
    const b: types.u32x2 = .{ 0x0F, 0x0F };
    const expected: types.u32x2 = .{ 0x00, 0x01 };

    try common.testIntrinsic(.{ .func = vand_u32, .expected = expected, .args = .{ a, b } });
}

/// Vector bitwise and
pub inline fn vand_u64(a: types.u64x1, b: types.u64x1) types.u64x1 {
    return a & b;
}

test vand_u64 {
    const a: types.u64x1 = .{0x00};
    const b: types.u64x1 = .{0x0F};
    const expected: types.u64x1 = .{0x00};

    try common.testIntrinsic(.{ .func = vand_u64, .expected = expected, .args = .{ a, b } });
}

/// Vector bitwise and
pub inline fn vandq_s8(a: types.i8x16, b: types.i8x16) types.i8x16 {
    return a & b;
}

test vandq_s8 {
    const a: types.i8x16 = .{ 0x00, 0x01, 0x02, 0x03, 0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x00, 0x01, 0x02, 0x03 };
    const b: types.i8x16 = .{ 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F };
    const expected: types.i8x16 = .{ 0x00, 0x01, 0x02, 0x03, 0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x00, 0x01, 0x02, 0x03 };

    try common.testIntrinsic(.{ .func = vandq_s8, .expected = expected, .args = .{ a, b } });
}

/// Vector bitwise and
pub inline fn vandq_s16(a: types.i16x8, b: types.i16x8) types.i16x8 {
    return a & b;
}

test vandq_s16 {
    const a: types.i16x8 = .{ 0x00, 0x01, 0x02, 0x03, 0x00, 0x01, 0x02, 0x03 };
    const b: types.i16x8 = .{ 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F };
    const expected: types.i16x8 = .{ 0x00, 0x01, 0x02, 0x03, 0x00, 0x01, 0x02, 0x03 };

    try common.testIntrinsic(.{ .func = vandq_s16, .expected = expected, .args = .{ a, b } });
}

/// Vector bitwise and
pub inline fn vandq_s32(a: types.i32x4, b: types.i32x4) types.i32x4 {
    return a & b;
}

test vandq_s32 {
    const a: types.i32x4 = .{ 0x00, 0x01, 0x00, 0x01 };
    const b: types.i32x4 = .{ 0x0F, 0x0F, 0x0F, 0x0F };
    const expected: types.i32x4 = .{ 0x00, 0x01, 0x00, 0x01 };

    try common.testIntrinsic(.{ .func = vandq_s32, .expected = expected, .args = .{ a, b } });
}

/// Vector bitwise and
pub inline fn vandq_s64(a: types.i64x2, b: types.i64x2) types.i64x2 {
    return a & b;
}

test vandq_s64 {
    const a: types.i64x2 = .{ 0x00, 0x00 };
    const b: types.i64x2 = .{ 0x0F, 0x0F };
    const expected: types.i64x2 = .{ 0x00, 0x00 };

    try common.testIntrinsic(.{ .func = vandq_s64, .expected = expected, .args = .{ a, b } });
}

/// Vector bitwise and
pub inline fn vandq_u8(a: types.u8x16, b: types.u8x16) types.u8x16 {
    return a & b;
}

test vandq_u8 {
    const a: types.u8x16 = .{ 0x00, 0x01, 0x02, 0x03, 0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x00, 0x01, 0x02, 0x03 };
    const b: types.u8x16 = .{ 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F };
    const expected: types.u8x16 = .{ 0x00, 0x01, 0x02, 0x03, 0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x00, 0x01, 0x02, 0x03 };

    try common.testIntrinsic(.{ .func = vandq_u8, .expected = expected, .args = .{ a, b } });
}

/// Vector bitwise and
pub inline fn vandq_u16(a: types.i16x8, b: types.i16x8) types.u16x8 {
    return a & b;
}

test vandq_u16 {
    const a: types.u16x8 = .{ 0x00, 0x01, 0x02, 0x03, 0x00, 0x01, 0x02, 0x03 };
    const b: types.u16x8 = .{ 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F };
    const expected: types.u16x8 = .{ 0x00, 0x01, 0x02, 0x03, 0x00, 0x01, 0x02, 0x03 };

    try common.testIntrinsic(.{ .func = vandq_u16, .expected = expected, .args = .{ a, b } });
}

/// Vector bitwise and
pub inline fn vandq_u32(a: types.u32x4, b: types.u32x4) types.u32x4 {
    return a & b;
}

test vandq_u32 {
    const a: types.u32x4 = .{ 0x00, 0x01, 0x00, 0x01 };
    const b: types.u32x4 = .{ 0x0F, 0x0F, 0x0F, 0x0F };
    const expected: types.u32x4 = .{ 0x00, 0x01, 0x00, 0x01 };

    try common.testIntrinsic(.{ .func = vandq_u32, .expected = expected, .args = .{ a, b } });
}

/// Vector bitwise and
pub inline fn vandq_u64(a: types.u64x2, b: types.u64x2) types.u64x2 {
    return a & b;
}

test vandq_u64 {
    const a: types.u64x2 = .{ 0x00, 0x00 };
    const b: types.u64x2 = .{ 0x0F, 0x0F };
    const expected: types.u64x2 = .{ 0x00, 0x00 };

    try common.testIntrinsic(.{ .func = vandq_u64, .expected = expected, .args = .{ a, b } });
}

/// Vector bitwise bit clear
pub inline fn vbic_s8(a: types.i8x8, b: types.i8x8) types.i8x8 {
    return a & ~b;
}

test vbic_s8 {
    const a: types.i8x8 = @splat(1);
    const b: types.i8x8 = @splat(1);
    const expected: types.i8x8 = @splat(0);
    try common.testIntrinsic(.{ .func = vbic_s8, .expected = expected, .args = .{ a, b } });
}

/// Vector bitwise bit clear
pub inline fn vbic_s16(a: types.i16x4, b: types.i16x4) types.i16x4 {
    return a & ~b;
}

test vbic_s16 {
    const a: types.i16x4 = @splat(1);
    const b: types.i16x4 = @splat(1);
    const expected: types.i16x4 = @splat(0);
    try common.testIntrinsic(.{ .func = vbic_s16, .expected = expected, .args = .{ a, b } });
}

/// Vector bitwise bit clear
pub inline fn vbic_s32(a: types.i32x2, b: types.i32x2) types.i32x2 {
    return a & ~b;
}

test vbic_s32 {
    const a: types.i32x2 = @splat(1);
    const b: types.i32x2 = @splat(1);
    const expected: types.i32x2 = @splat(0);
    try common.testIntrinsic(.{ .func = vbic_s32, .expected = expected, .args = .{ a, b } });
}

/// Vector bitwise bit clear
pub inline fn vbic_s64(a: types.i64x1, b: types.i64x1) types.i64x1 {
    return a & ~b;
}

test vbic_s64 {
    const a: types.i64x1 = @splat(1);
    const b: types.i64x1 = @splat(1);
    const expected: types.i64x1 = @splat(0);
    try common.testIntrinsic(.{ .func = vbic_s64, .expected = expected, .args = .{ a, b } });
}

/// Vector bitwise bit clear
pub inline fn vbic_u8(a: types.u8x8, b: types.u8x8) types.u8x8 {
    return a & ~b;
}

test vbic_u8 {
    const a: types.u8x8 = @splat(1);
    const b: types.u8x8 = @splat(1);
    const expected: types.u8x8 = @splat(0);
    try common.testIntrinsic(.{ .func = vbic_u8, .expected = expected, .args = .{ a, b } });
}

/// Vector bitwise bit clear
pub inline fn vbic_u16(a: types.u16x4, b: types.u16x4) types.u16x4 {
    return a & ~b;
}

test vbic_u16 {
    const a: types.u16x4 = @splat(1);
    const b: types.u16x4 = @splat(1);
    const expected: types.u16x4 = @splat(0);
    try common.testIntrinsic(.{ .func = vbic_u16, .expected = expected, .args = .{ a, b } });
}

/// Vector bitwise bit clear
pub inline fn vbic_u32(a: types.u32x2, b: types.u32x2) types.u32x2 {
    return a & ~b;
}

test vbic_u32 {
    const a: types.u32x2 = @splat(1);
    const b: types.u32x2 = @splat(1);
    const expected: types.u32x2 = @splat(0);
    try common.testIntrinsic(.{ .func = vbic_u32, .expected = expected, .args = .{ a, b } });
}

/// Vector bitwise bit clear
pub inline fn vbic_u64(a: types.u64x1, b: types.u64x1) types.u64x1 {
    return a & ~b;
}

test vbic_u64 {
    const a: types.u64x1 = @splat(1);
    const b: types.u64x1 = @splat(1);
    const expected: types.u64x1 = @splat(0);
    try common.testIntrinsic(.{ .func = vbic_u64, .expected = expected, .args = .{ a, b } });
}

/// Vector bitwise bit clear
pub inline fn vbicq_s8(a: types.i8x16, b: types.i8x16) types.i8x16 {
    return a & ~b;
}

test vbicq_s8 {
    const a: types.i8x16 = @splat(1);
    const b: types.i8x16 = @splat(1);
    const expected: types.i8x16 = @splat(0);
    try common.testIntrinsic(.{ .func = vbicq_s8, .expected = expected, .args = .{ a, b } });
}

/// Vector bitwise bit clear
pub inline fn vbicq_s16(a: types.i16x8, b: types.i16x8) types.i16x8 {
    return a & ~b;
}

test vbicq_s16 {
    const a: types.i16x8 = @splat(1);
    const b: types.i16x8 = @splat(1);
    const expected: types.i16x8 = @splat(0);
    try common.testIntrinsic(.{ .func = vbicq_s16, .expected = expected, .args = .{ a, b } });
}

/// Vector bitwise bit clear
pub inline fn vbicq_s32(a: types.i32x4, b: types.i32x4) types.i32x4 {
    return a & ~b;
}

test vbicq_s32 {
    const a: types.i32x4 = @splat(1);
    const b: types.i32x4 = @splat(1);
    const expected: types.i32x4 = @splat(0);
    try common.testIntrinsic(.{ .func = vbicq_s32, .expected = expected, .args = .{ a, b } });
}

/// Vector bitwise bit clear
pub inline fn vbicq_s64(a: types.i64x2, b: types.i64x2) types.i64x2 {
    return a & ~b;
}

test vbicq_s64 {
    const a: types.i64x2 = @splat(1);
    const b: types.i64x2 = @splat(1);
    const expected: types.i64x2 = @splat(0);
    try common.testIntrinsic(.{ .func = vbicq_s64, .expected = expected, .args = .{ a, b } });
}

/// Vector bitwise bit clear
pub inline fn vbicq_u8(a: types.u8x16, b: types.u8x16) types.u8x16 {
    return a & ~b;
}

test vbicq_u8 {
    const a: types.u8x16 = @splat(1);
    const b: types.u8x16 = @splat(1);
    const expected: types.u8x16 = @splat(0);
    try common.testIntrinsic(.{ .func = vbicq_u8, .expected = expected, .args = .{ a, b } });
}

/// Vector bitwise bit clear
pub inline fn vbicq_u16(a: types.u16x8, b: types.u16x8) types.u16x8 {
    return a & ~b;
}

test vbicq_u16 {
    const a: types.u16x8 = @splat(1);
    const b: types.u16x8 = @splat(1);
    const expected: types.u16x8 = @splat(0);
    try common.testIntrinsic(.{ .func = vbicq_u16, .expected = expected, .args = .{ a, b } });
}

/// Vector bitwise bit clear
pub inline fn vbicq_u32(a: types.u32x4, b: types.u32x4) types.u32x4 {
    return a & ~b;
}

test vbicq_u32 {
    const a: types.u32x4 = @splat(1);
    const b: types.u32x4 = @splat(1);
    const expected: types.u32x4 = @splat(0);
    try common.testIntrinsic(.{ .func = vbicq_u32, .expected = expected, .args = .{ a, b } });
}

/// Vector bitwise bit clear
pub inline fn vbicq_u64(a: types.u64x2, b: types.u64x2) types.u64x2 {
    return a & ~b;
}

test vbicq_u64 {
    const a: types.u64x2 = @splat(1);
    const b: types.u64x2 = @splat(1);
    const expected: types.u64x2 = @splat(0);
    try common.testIntrinsic(.{ .func = vbicq_u64, .expected = expected, .args = .{ a, b } });
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

    try common.testIntrinsic(.{ .func = vbsl_s8, .expected = expected, .args = .{ a, b, c } });
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
    try common.testIntrinsic(.{ .func = vbsl_s16, .expected = expected, .args = .{ a, b, c } });
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
    try common.testIntrinsic(.{ .func = vbsl_s32, .expected = expected, .args = .{ a, b, c } });
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
    try common.testIntrinsic(.{ .func = vbsl_s64, .expected = expected, .args = .{ a, b, c } });
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

    try common.testIntrinsic(.{ .func = vbsl_u8, .expected = expected, .args = .{ a, b, c } });
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
    try common.testIntrinsic(.{ .func = vbsl_u32, .expected = expected, .args = .{ a, b, c } });
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
    try common.testIntrinsic(.{ .func = vbsl_u64, .expected = expected, .args = .{ a, b, c } });
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

    try common.testIntrinsic(.{ .func = vbsl_f32, .expected = expected, .args = .{ a, b, c } });
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
    try common.testIntrinsic(.{ .func = vbsl_p8, .expected = expected, .args = .{ a, b, c } });
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
    try common.testIntrinsic(.{ .func = vbsl_p64, .expected = expected, .args = .{ a, b, c } });
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
    try common.testIntrinsic(.{ .func = vbsl_p16, .expected = expected, .args = .{ a, b, c } });
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
    try common.testIntrinsic(.{ .func = vbslq_s8, .expected = expected, .args = .{ a, b, c } });
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
    try common.testIntrinsic(.{ .func = vbslq_s16, .expected = expected, .args = .{ a, b, c } });
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
    try common.testIntrinsic(.{ .func = vbslq_s32, .expected = expected, .args = .{ a, b, c } });
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
    try common.testIntrinsic(.{ .func = vbslq_s64, .expected = expected, .args = .{ a, b, c } });
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
    try common.testIntrinsic(.{ .func = vbslq_u8, .expected = expected, .args = .{ a, b, c } });
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
    try common.testIntrinsic(.{ .func = vbslq_u16, .expected = expected, .args = .{ a, b, c } });
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
    try common.testIntrinsic(.{ .func = vbslq_u32, .expected = expected, .args = .{ a, b, c } });
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
    try common.testIntrinsic(.{ .func = vbslq_u64, .expected = expected, .args = .{ a, b, c } });
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
    try common.testIntrinsic(.{ .func = vbslq_f32, .expected = expected, .args = .{ a, b, c } });
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
    try common.testIntrinsic(.{ .func = vbslq_f64, .expected = expected, .args = .{ a, b, c } });
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
    try common.testIntrinsic(.{ .func = vbslq_p8, .expected = expected, .args = .{ a, b, c } });
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
    try common.testIntrinsic(.{ .func = vbslq_p16, .expected = expected, .args = .{ a, b, c } });
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
    try common.testIntrinsic(.{ .func = vbslq_p64, .expected = expected, .args = .{ a, b, c } });
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

    try common.testIntrinsic(.{ .func = vbcaxq_s8, .expected = expected, .args = .{ a, b, c } });
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

    try common.testIntrinsic(.{ .func = vbcaxq_s16, .expected = expected, .args = .{ a, b, c } });
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

    try common.testIntrinsic(.{ .func = vbcaxq_s32, .expected = expected, .args = .{ a, b, c } });
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

    try common.testIntrinsic(.{ .func = vbcaxq_s64, .expected = expected, .args = .{ a, b, c } });
}

/// ARM NEON intrinsic: `veor_s16`
pub inline fn veor_s16(a: types.i16x4, b: types.i16x4) types.i16x4 {
    return a ^ b;
}

test veor_s16 {
    const a = @as(types.i16x4, @splat(0x55));
    const b = @as(types.i16x4, @splat(0x33));
    const expected = @as(types.i16x4, @splat(0x66));
    try common.testIntrinsic(.{ .func = veor_s16, .expected = expected, .args = .{ a, b } });
}

/// ARM NEON intrinsic: `veor_s32`
pub inline fn veor_s32(a: types.i32x2, b: types.i32x2) types.i32x2 {
    return a ^ b;
}

test veor_s32 {
    const a = @as(types.i32x2, @splat(0x55));
    const b = @as(types.i32x2, @splat(0x33));
    const expected = @as(types.i32x2, @splat(0x66));
    try common.testIntrinsic(.{ .func = veor_s32, .expected = expected, .args = .{ a, b } });
}

/// ARM NEON intrinsic: `veor_s64`
pub inline fn veor_s64(a: types.i64x1, b: types.i64x1) types.i64x1 {
    return a ^ b;
}

test veor_s64 {
    const a = @as(types.i64x1, @splat(0x55));
    const b = @as(types.i64x1, @splat(0x33));
    const expected = @as(types.i64x1, @splat(0x66));
    try common.testIntrinsic(.{ .func = veor_s64, .expected = expected, .args = .{ a, b } });
}

/// ARM NEON intrinsic: `veor_s8`
pub inline fn veor_s8(a: types.i8x8, b: types.i8x8) types.i8x8 {
    return a ^ b;
}

test veor_s8 {
    const a = @as(types.i8x8, @splat(0x55));
    const b = @as(types.i8x8, @splat(0x33));
    const expected = @as(types.i8x8, @splat(0x66));
    try common.testIntrinsic(.{ .func = veor_s8, .expected = expected, .args = .{ a, b } });
}

/// ARM NEON intrinsic: `veor_u16`
pub inline fn veor_u16(a: types.u16x4, b: types.u16x4) types.u16x4 {
    return a ^ b;
}

test veor_u16 {
    const a = @as(types.u16x4, @splat(0x55));
    const b = @as(types.u16x4, @splat(0x33));
    const expected = @as(types.u16x4, @splat(0x66));
    try common.testIntrinsic(.{ .func = veor_u16, .expected = expected, .args = .{ a, b } });
}

/// ARM NEON intrinsic: `veor_u32`
pub inline fn veor_u32(a: types.u32x2, b: types.u32x2) types.u32x2 {
    return a ^ b;
}

test veor_u32 {
    const a = @as(types.u32x2, @splat(0x55));
    const b = @as(types.u32x2, @splat(0x33));
    const expected = @as(types.u32x2, @splat(0x66));
    try common.testIntrinsic(.{ .func = veor_u32, .expected = expected, .args = .{ a, b } });
}

/// ARM NEON intrinsic: `veor_u64`
pub inline fn veor_u64(a: types.u64x1, b: types.u64x1) types.u64x1 {
    return a ^ b;
}

test veor_u64 {
    const a = @as(types.u64x1, @splat(0x55));
    const b = @as(types.u64x1, @splat(0x33));
    const expected = @as(types.u64x1, @splat(0x66));
    try common.testIntrinsic(.{ .func = veor_u64, .expected = expected, .args = .{ a, b } });
}

/// ARM NEON intrinsic: `veor_u8`
pub inline fn veor_u8(a: types.u8x8, b: types.u8x8) types.u8x8 {
    return a ^ b;
}

test veor_u8 {
    const a = @as(types.u8x8, @splat(0x55));
    const b = @as(types.u8x8, @splat(0x33));
    const expected = @as(types.u8x8, @splat(0x66));
    try common.testIntrinsic(.{ .func = veor_u8, .expected = expected, .args = .{ a, b } });
}

/// ARM NEON intrinsic: `veorq_s16`
pub inline fn veorq_s16(a: types.i16x8, b: types.i16x8) types.i16x8 {
    return a ^ b;
}

test veorq_s16 {
    const a = @as(types.i16x8, @splat(0x55));
    const b = @as(types.i16x8, @splat(0x33));
    const expected = @as(types.i16x8, @splat(0x66));
    try common.testIntrinsic(.{ .func = veorq_s16, .expected = expected, .args = .{ a, b } });
}

/// ARM NEON intrinsic: `veorq_s32`
pub inline fn veorq_s32(a: types.i32x4, b: types.i32x4) types.i32x4 {
    return a ^ b;
}

test veorq_s32 {
    const a = @as(types.i32x4, @splat(0x55));
    const b = @as(types.i32x4, @splat(0x33));
    const expected = @as(types.i32x4, @splat(0x66));
    try common.testIntrinsic(.{ .func = veorq_s32, .expected = expected, .args = .{ a, b } });
}

/// ARM NEON intrinsic: `veorq_s64`
pub inline fn veorq_s64(a: types.i64x2, b: types.i64x2) types.i64x2 {
    return a ^ b;
}

test veorq_s64 {
    const a = @as(types.i64x2, @splat(0x55));
    const b = @as(types.i64x2, @splat(0x33));
    const expected = @as(types.i64x2, @splat(0x66));
    try common.testIntrinsic(.{ .func = veorq_s64, .expected = expected, .args = .{ a, b } });
}

/// ARM NEON intrinsic: `veorq_s8`
pub inline fn veorq_s8(a: types.i8x16, b: types.i8x16) types.i8x16 {
    return a ^ b;
}

test veorq_s8 {
    const a = @as(types.i8x16, @splat(0x55));
    const b = @as(types.i8x16, @splat(0x33));
    const expected = @as(types.i8x16, @splat(0x66));
    try common.testIntrinsic(.{ .func = veorq_s8, .expected = expected, .args = .{ a, b } });
}

/// ARM NEON intrinsic: `veorq_u16`
pub inline fn veorq_u16(a: types.u16x8, b: types.u16x8) types.u16x8 {
    return a ^ b;
}

test veorq_u16 {
    const a = @as(types.u16x8, @splat(0x55));
    const b = @as(types.u16x8, @splat(0x33));
    const expected = @as(types.u16x8, @splat(0x66));
    try common.testIntrinsic(.{ .func = veorq_u16, .expected = expected, .args = .{ a, b } });
}

/// ARM NEON intrinsic: `veorq_u32`
pub inline fn veorq_u32(a: types.u32x4, b: types.u32x4) types.u32x4 {
    return a ^ b;
}

test veorq_u32 {
    const a = @as(types.u32x4, @splat(0x55));
    const b = @as(types.u32x4, @splat(0x33));
    const expected = @as(types.u32x4, @splat(0x66));
    try common.testIntrinsic(.{ .func = veorq_u32, .expected = expected, .args = .{ a, b } });
}

/// ARM NEON intrinsic: `veorq_u64`
pub inline fn veorq_u64(a: types.u64x2, b: types.u64x2) types.u64x2 {
    return a ^ b;
}

test veorq_u64 {
    const a = @as(types.u64x2, @splat(0x55));
    const b = @as(types.u64x2, @splat(0x33));
    const expected = @as(types.u64x2, @splat(0x66));
    try common.testIntrinsic(.{ .func = veorq_u64, .expected = expected, .args = .{ a, b } });
}

/// ARM NEON intrinsic: `veorq_u8`
pub inline fn veorq_u8(a: types.u8x16, b: types.u8x16) types.u8x16 {
    return a ^ b;
}

test veorq_u8 {
    const a = @as(types.u8x16, @splat(0x55));
    const b = @as(types.u8x16, @splat(0x33));
    const expected = @as(types.u8x16, @splat(0x66));
    try common.testIntrinsic(.{ .func = veorq_u8, .expected = expected, .args = .{ a, b } });
}

/// ARM NEON intrinsic: `vorn_s16`
pub inline fn vorn_s16(a: types.i16x4, b: types.i16x4) types.i16x4 {
    return a | ~b;
}

test vorn_s16 {
    const a = @as(types.i16x4, @splat(0x55));
    const b = @as(types.i16x4, @splat(0x33));
    const expected = @as(types.i16x4, @splat(-35));
    try common.testIntrinsic(.{ .func = vorn_s16, .expected = expected, .args = .{ a, b } });
}

/// ARM NEON intrinsic: `vorn_s32`
pub inline fn vorn_s32(a: types.i32x2, b: types.i32x2) types.i32x2 {
    return a | ~b;
}

test vorn_s32 {
    const a = @as(types.i32x2, @splat(0x55));
    const b = @as(types.i32x2, @splat(0x33));
    const expected = @as(types.i32x2, @splat(-35));
    try common.testIntrinsic(.{ .func = vorn_s32, .expected = expected, .args = .{ a, b } });
}

/// ARM NEON intrinsic: `vorn_s64`
pub inline fn vorn_s64(a: types.i64x1, b: types.i64x1) types.i64x1 {
    return a | ~b;
}

test vorn_s64 {
    const a = @as(types.i64x1, @splat(0x55));
    const b = @as(types.i64x1, @splat(0x33));
    const expected = @as(types.i64x1, @splat(-35));
    try common.testIntrinsic(.{ .func = vorn_s64, .expected = expected, .args = .{ a, b } });
}

/// ARM NEON intrinsic: `vorn_s8`
pub inline fn vorn_s8(a: types.i8x8, b: types.i8x8) types.i8x8 {
    return a | ~b;
}

test vorn_s8 {
    const a = @as(types.i8x8, @splat(0x55));
    const b = @as(types.i8x8, @splat(0x33));
    const expected = @as(types.i8x8, @splat(-35));
    try common.testIntrinsic(.{ .func = vorn_s8, .expected = expected, .args = .{ a, b } });
}

/// ARM NEON intrinsic: `vorn_u16`
pub inline fn vorn_u16(a: types.u16x4, b: types.u16x4) types.u16x4 {
    return a | ~b;
}

test vorn_u16 {
    const a = @as(types.u16x4, @splat(0x55));
    const b = @as(types.u16x4, @splat(0x33));
    const expected = @as(types.u16x4, @splat(0xffdd));
    try common.testIntrinsic(.{ .func = vorn_u16, .expected = expected, .args = .{ a, b } });
}

/// ARM NEON intrinsic: `vorn_u32`
pub inline fn vorn_u32(a: types.u32x2, b: types.u32x2) types.u32x2 {
    return a | ~b;
}

test vorn_u32 {
    const a = @as(types.u32x2, @splat(0x55));
    const b = @as(types.u32x2, @splat(0x33));
    const expected = @as(types.u32x2, @splat(0xffffffdd));
    try common.testIntrinsic(.{ .func = vorn_u32, .expected = expected, .args = .{ a, b } });
}

/// ARM NEON intrinsic: `vorn_u64`
pub inline fn vorn_u64(a: types.u64x1, b: types.u64x1) types.u64x1 {
    return a | ~b;
}

test vorn_u64 {
    const a = @as(types.u64x1, @splat(0x55));
    const b = @as(types.u64x1, @splat(0x33));
    const expected = @as(types.u64x1, @splat(0xffffffffffffffdd));
    try common.testIntrinsic(.{ .func = vorn_u64, .expected = expected, .args = .{ a, b } });
}

/// ARM NEON intrinsic: `vorn_u8`
pub inline fn vorn_u8(a: types.u8x8, b: types.u8x8) types.u8x8 {
    return a | ~b;
}

test vorn_u8 {
    const a = @as(types.u8x8, @splat(0x55));
    const b = @as(types.u8x8, @splat(0x33));
    const expected = @as(types.u8x8, @splat(0xdd));
    try common.testIntrinsic(.{ .func = vorn_u8, .expected = expected, .args = .{ a, b } });
}

/// ARM NEON intrinsic: `vornq_s16`
pub inline fn vornq_s16(a: types.i16x8, b: types.i16x8) types.i16x8 {
    return a | ~b;
}

test vornq_s16 {
    const a = @as(types.i16x8, @splat(0x55));
    const b = @as(types.i16x8, @splat(0x33));
    const expected = @as(types.i16x8, @splat(-35));
    try common.testIntrinsic(.{ .func = vornq_s16, .expected = expected, .args = .{ a, b } });
}

/// ARM NEON intrinsic: `vornq_s32`
pub inline fn vornq_s32(a: types.i32x4, b: types.i32x4) types.i32x4 {
    return a | ~b;
}

test vornq_s32 {
    const a = @as(types.i32x4, @splat(0x55));
    const b = @as(types.i32x4, @splat(0x33));
    const expected = @as(types.i32x4, @splat(-35));
    try common.testIntrinsic(.{ .func = vornq_s32, .expected = expected, .args = .{ a, b } });
}

/// ARM NEON intrinsic: `vornq_s64`
pub inline fn vornq_s64(a: types.i64x2, b: types.i64x2) types.i64x2 {
    return a | ~b;
}

test vornq_s64 {
    const a = @as(types.i64x2, @splat(0x55));
    const b = @as(types.i64x2, @splat(0x33));
    const expected = @as(types.i64x2, @splat(-35));
    try common.testIntrinsic(.{ .func = vornq_s64, .expected = expected, .args = .{ a, b } });
}

/// ARM NEON intrinsic: `vornq_s8`
pub inline fn vornq_s8(a: types.i8x16, b: types.i8x16) types.i8x16 {
    return a | ~b;
}

test vornq_s8 {
    const a = @as(types.i8x16, @splat(0x55));
    const b = @as(types.i8x16, @splat(0x33));
    const expected = @as(types.i8x16, @splat(-35));
    try common.testIntrinsic(.{ .func = vornq_s8, .expected = expected, .args = .{ a, b } });
}

/// ARM NEON intrinsic: `vornq_u16`
pub inline fn vornq_u16(a: types.u16x8, b: types.u16x8) types.u16x8 {
    return a | ~b;
}

test vornq_u16 {
    const a = @as(types.u16x8, @splat(0x55));
    const b = @as(types.u16x8, @splat(0x33));
    const expected = @as(types.u16x8, @splat(0xffdd));
    try common.testIntrinsic(.{ .func = vornq_u16, .expected = expected, .args = .{ a, b } });
}

/// ARM NEON intrinsic: `vornq_u32`
pub inline fn vornq_u32(a: types.u32x4, b: types.u32x4) types.u32x4 {
    return a | ~b;
}

test vornq_u32 {
    const a = @as(types.u32x4, @splat(0x55));
    const b = @as(types.u32x4, @splat(0x33));
    const expected = @as(types.u32x4, @splat(0xffffffdd));
    try common.testIntrinsic(.{ .func = vornq_u32, .expected = expected, .args = .{ a, b } });
}

/// ARM NEON intrinsic: `vornq_u64`
pub inline fn vornq_u64(a: types.u64x2, b: types.u64x2) types.u64x2 {
    return a | ~b;
}

test vornq_u64 {
    const a = @as(types.u64x2, @splat(0x55));
    const b = @as(types.u64x2, @splat(0x33));
    const expected = @as(types.u64x2, @splat(0xffffffffffffffdd));
    try common.testIntrinsic(.{ .func = vornq_u64, .expected = expected, .args = .{ a, b } });
}

/// ARM NEON intrinsic: `vornq_u8`
pub inline fn vornq_u8(a: types.u8x16, b: types.u8x16) types.u8x16 {
    return a | ~b;
}

test vornq_u8 {
    const a = @as(types.u8x16, @splat(0x55));
    const b = @as(types.u8x16, @splat(0x33));
    const expected = @as(types.u8x16, @splat(0xdd));
    try common.testIntrinsic(.{ .func = vornq_u8, .expected = expected, .args = .{ a, b } });
}

/// ARM NEON intrinsic: `vorr_s16`
pub inline fn vorr_s16(a: types.i16x4, b: types.i16x4) types.i16x4 {
    return a | b;
}

test vorr_s16 {
    const a = @as(types.i16x4, @splat(0x55));
    const b = @as(types.i16x4, @splat(0x33));
    const expected = @as(types.i16x4, @splat(0x77));
    try common.testIntrinsic(.{ .func = vorr_s16, .expected = expected, .args = .{ a, b } });
}

/// ARM NEON intrinsic: `vorr_s32`
pub inline fn vorr_s32(a: types.i32x2, b: types.i32x2) types.i32x2 {
    return a | b;
}

test vorr_s32 {
    const a = @as(types.i32x2, @splat(0x55));
    const b = @as(types.i32x2, @splat(0x33));
    const expected = @as(types.i32x2, @splat(0x77));
    try common.testIntrinsic(.{ .func = vorr_s32, .expected = expected, .args = .{ a, b } });
}

/// ARM NEON intrinsic: `vorr_s64`
pub inline fn vorr_s64(a: types.i64x1, b: types.i64x1) types.i64x1 {
    return a | b;
}

test vorr_s64 {
    const a = @as(types.i64x1, @splat(0x55));
    const b = @as(types.i64x1, @splat(0x33));
    const expected = @as(types.i64x1, @splat(0x77));
    try common.testIntrinsic(.{ .func = vorr_s64, .expected = expected, .args = .{ a, b } });
}

/// ARM NEON intrinsic: `vorr_s8`
pub inline fn vorr_s8(a: types.i8x8, b: types.i8x8) types.i8x8 {
    return a | b;
}

test vorr_s8 {
    const a = @as(types.i8x8, @splat(0x55));
    const b = @as(types.i8x8, @splat(0x33));
    const expected = @as(types.i8x8, @splat(0x77));
    try common.testIntrinsic(.{ .func = vorr_s8, .expected = expected, .args = .{ a, b } });
}

/// ARM NEON intrinsic: `vorr_u16`
pub inline fn vorr_u16(a: types.u16x4, b: types.u16x4) types.u16x4 {
    return a | b;
}

test vorr_u16 {
    const a = @as(types.u16x4, @splat(0x55));
    const b = @as(types.u16x4, @splat(0x33));
    const expected = @as(types.u16x4, @splat(0x77));
    try common.testIntrinsic(.{ .func = vorr_u16, .expected = expected, .args = .{ a, b } });
}

/// ARM NEON intrinsic: `vorr_u32`
pub inline fn vorr_u32(a: types.u32x2, b: types.u32x2) types.u32x2 {
    return a | b;
}

test vorr_u32 {
    const a = @as(types.u32x2, @splat(0x55));
    const b = @as(types.u32x2, @splat(0x33));
    const expected = @as(types.u32x2, @splat(0x77));
    try common.testIntrinsic(.{ .func = vorr_u32, .expected = expected, .args = .{ a, b } });
}

/// ARM NEON intrinsic: `vorr_u64`
pub inline fn vorr_u64(a: types.u64x1, b: types.u64x1) types.u64x1 {
    return a | b;
}

test vorr_u64 {
    const a = @as(types.u64x1, @splat(0x55));
    const b = @as(types.u64x1, @splat(0x33));
    const expected = @as(types.u64x1, @splat(0x77));
    try common.testIntrinsic(.{ .func = vorr_u64, .expected = expected, .args = .{ a, b } });
}

/// ARM NEON intrinsic: `vorr_u8`
pub inline fn vorr_u8(a: types.u8x8, b: types.u8x8) types.u8x8 {
    return a | b;
}

test vorr_u8 {
    const a = @as(types.u8x8, @splat(0x55));
    const b = @as(types.u8x8, @splat(0x33));
    const expected = @as(types.u8x8, @splat(0x77));
    try common.testIntrinsic(.{ .func = vorr_u8, .expected = expected, .args = .{ a, b } });
}

/// ARM NEON intrinsic: `vorrq_s16`
pub inline fn vorrq_s16(a: types.i16x8, b: types.i16x8) types.i16x8 {
    return a | b;
}

test vorrq_s16 {
    const a = @as(types.i16x8, @splat(0x55));
    const b = @as(types.i16x8, @splat(0x33));
    const expected = @as(types.i16x8, @splat(0x77));
    try common.testIntrinsic(.{ .func = vorrq_s16, .expected = expected, .args = .{ a, b } });
}

/// ARM NEON intrinsic: `vorrq_s32`
pub inline fn vorrq_s32(a: types.i32x4, b: types.i32x4) types.i32x4 {
    return a | b;
}

test vorrq_s32 {
    const a = @as(types.i32x4, @splat(0x55));
    const b = @as(types.i32x4, @splat(0x33));
    const expected = @as(types.i32x4, @splat(0x77));
    try common.testIntrinsic(.{ .func = vorrq_s32, .expected = expected, .args = .{ a, b } });
}

/// ARM NEON intrinsic: `vorrq_s64`
pub inline fn vorrq_s64(a: types.i64x2, b: types.i64x2) types.i64x2 {
    return a | b;
}

test vorrq_s64 {
    const a = @as(types.i64x2, @splat(0x55));
    const b = @as(types.i64x2, @splat(0x33));
    const expected = @as(types.i64x2, @splat(0x77));
    try common.testIntrinsic(.{ .func = vorrq_s64, .expected = expected, .args = .{ a, b } });
}

/// ARM NEON intrinsic: `vorrq_s8`
pub inline fn vorrq_s8(a: types.i8x16, b: types.i8x16) types.i8x16 {
    return a | b;
}

test vorrq_s8 {
    const a = @as(types.i8x16, @splat(0x55));
    const b = @as(types.i8x16, @splat(0x33));
    const expected = @as(types.i8x16, @splat(0x77));
    try common.testIntrinsic(.{ .func = vorrq_s8, .expected = expected, .args = .{ a, b } });
}

/// ARM NEON intrinsic: `vorrq_u16`
pub inline fn vorrq_u16(a: types.u16x8, b: types.u16x8) types.u16x8 {
    return a | b;
}

test vorrq_u16 {
    const a = @as(types.u16x8, @splat(0x55));
    const b = @as(types.u16x8, @splat(0x33));
    const expected = @as(types.u16x8, @splat(0x77));
    try common.testIntrinsic(.{ .func = vorrq_u16, .expected = expected, .args = .{ a, b } });
}

/// ARM NEON intrinsic: `vorrq_u32`
pub inline fn vorrq_u32(a: types.u32x4, b: types.u32x4) types.u32x4 {
    return a | b;
}

test vorrq_u32 {
    const a = @as(types.u32x4, @splat(0x55));
    const b = @as(types.u32x4, @splat(0x33));
    const expected = @as(types.u32x4, @splat(0x77));
    try common.testIntrinsic(.{ .func = vorrq_u32, .expected = expected, .args = .{ a, b } });
}

/// ARM NEON intrinsic: `vorrq_u64`
pub inline fn vorrq_u64(a: types.u64x2, b: types.u64x2) types.u64x2 {
    return a | b;
}

test vorrq_u64 {
    const a = @as(types.u64x2, @splat(0x55));
    const b = @as(types.u64x2, @splat(0x33));
    const expected = @as(types.u64x2, @splat(0x77));
    try common.testIntrinsic(.{ .func = vorrq_u64, .expected = expected, .args = .{ a, b } });
}

/// ARM NEON intrinsic: `vorrq_u8`
pub inline fn vorrq_u8(a: types.u8x16, b: types.u8x16) types.u8x16 {
    return a | b;
}

test vorrq_u8 {
    const a = @as(types.u8x16, @splat(0x55));
    const b = @as(types.u8x16, @splat(0x33));
    const expected = @as(types.u8x16, @splat(0x77));
    try common.testIntrinsic(.{ .func = vorrq_u8, .expected = expected, .args = .{ a, b } });
}

/// ARM NEON intrinsic: `vbcaxq_u8`
pub inline fn vbcaxq_u8(a: types.u8x16, b: types.u8x16, c: types.u8x16) types.u8x16 {
    return a ^ (b & ~c);
}

test vbcaxq_u8 {
    const a = @as(types.u8x16, @splat(0x55));
    const b = @as(types.u8x16, @splat(0x33));
    const c = @as(types.u8x16, @splat(0xf));
    const expected = @as(types.u8x16, @splat(0x65));
    try common.testIntrinsic(.{ .func = vbcaxq_u8, .expected = expected, .args = .{ a, b, c } });
}
/// ARM NEON intrinsic: `vbcaxq_u16`
pub inline fn vbcaxq_u16(a: types.u16x8, b: types.u16x8, c: types.u16x8) types.u16x8 {
    return a ^ (b & ~c);
}

test vbcaxq_u16 {
    const a = @as(types.u16x8, @splat(0x55));
    const b = @as(types.u16x8, @splat(0x33));
    const c = @as(types.u16x8, @splat(0xf));
    const expected = @as(types.u16x8, @splat(0x65));
    try common.testIntrinsic(.{ .func = vbcaxq_u16, .expected = expected, .args = .{ a, b, c } });
}
/// ARM NEON intrinsic: `vbcaxq_u32`
pub inline fn vbcaxq_u32(a: types.u32x4, b: types.u32x4, c: types.u32x4) types.u32x4 {
    return a ^ (b & ~c);
}

test vbcaxq_u32 {
    const a = @as(types.u32x4, @splat(0x55));
    const b = @as(types.u32x4, @splat(0x33));
    const c = @as(types.u32x4, @splat(0xf));
    const expected = @as(types.u32x4, @splat(0x65));
    try common.testIntrinsic(.{ .func = vbcaxq_u32, .expected = expected, .args = .{ a, b, c } });
}
/// ARM NEON intrinsic: `vbcaxq_u64`
pub inline fn vbcaxq_u64(a: types.u64x2, b: types.u64x2, c: types.u64x2) types.u64x2 {
    return a ^ (b & ~c);
}

test vbcaxq_u64 {
    const a = @as(types.u64x2, @splat(0x55));
    const b = @as(types.u64x2, @splat(0x33));
    const c = @as(types.u64x2, @splat(0xf));
    const expected = @as(types.u64x2, @splat(0x65));
    try common.testIntrinsic(.{ .func = vbcaxq_u64, .expected = expected, .args = .{ a, b, c } });
}

/// Vector bitwise NOT: returns `~a`
pub inline fn vmvn_s8(a: types.i8x8) types.i8x8 {
    return ~a;
}

test vmvn_s8 {
    const a = @as(types.i8x8, @splat(0x55));
    const expected = @as(types.i8x8, @splat(@as(i8, @bitCast(@as(u8, ~@as(u8, 0x55))))));
    try common.testIntrinsic(.{ .func = vmvn_s8, .expected = expected, .args = .{a} });
}

/// Vector bitwise NOT: returns `~a`
pub inline fn vmvn_s16(a: types.i16x4) types.i16x4 {
    return ~a;
}

test vmvn_s16 {
    const a = @as(types.i16x4, @splat(0x55));
    const expected = @as(types.i16x4, @splat(@as(i16, @bitCast(@as(u16, ~@as(u16, 0x55))))));
    try common.testIntrinsic(.{ .func = vmvn_s16, .expected = expected, .args = .{a} });
}

/// Vector bitwise NOT: returns `~a`
pub inline fn vmvn_s32(a: types.i32x2) types.i32x2 {
    return ~a;
}

test vmvn_s32 {
    const a = @as(types.i32x2, @splat(0x55));
    const expected = @as(types.i32x2, @splat(@as(i32, @bitCast(@as(u32, ~@as(u32, 0x55))))));
    try common.testIntrinsic(.{ .func = vmvn_s32, .expected = expected, .args = .{a} });
}

/// Vector bitwise NOT: returns `~a`
pub inline fn vmvn_u8(a: types.u8x8) types.u8x8 {
    return ~a;
}

test vmvn_u8 {
    const a = @as(types.u8x8, @splat(0x55));
    const expected = @as(types.u8x8, @splat(@as(u8, @bitCast(@as(u8, ~@as(u8, 0x55))))));
    try common.testIntrinsic(.{ .func = vmvn_u8, .expected = expected, .args = .{a} });
}

/// Vector bitwise NOT: returns `~a`
pub inline fn vmvn_u16(a: types.u16x4) types.u16x4 {
    return ~a;
}

test vmvn_u16 {
    const a = @as(types.u16x4, @splat(0x55));
    const expected = @as(types.u16x4, @splat(@as(u16, @bitCast(@as(u16, ~@as(u16, 0x55))))));
    try common.testIntrinsic(.{ .func = vmvn_u16, .expected = expected, .args = .{a} });
}

/// Vector bitwise NOT: returns `~a`
pub inline fn vmvn_u32(a: types.u32x2) types.u32x2 {
    return ~a;
}

test vmvn_u32 {
    const a = @as(types.u32x2, @splat(0x55));
    const expected = @as(types.u32x2, @splat(@as(u32, @bitCast(@as(u32, ~@as(u32, 0x55))))));
    try common.testIntrinsic(.{ .func = vmvn_u32, .expected = expected, .args = .{a} });
}

/// Vector bitwise NOT: returns `~a`
pub inline fn vmvn_p8(a: types.p8x8) types.p8x8 {
    return ~a;
}

test vmvn_p8 {
    const a = @as(types.p8x8, @splat(0x55));
    const expected = @as(types.p8x8, @splat(@as(u8, @bitCast(@as(u8, ~@as(u8, 0x55))))));
    try common.testIntrinsic(.{ .func = vmvn_p8, .expected = expected, .args = .{a} });
}

/// Vector bitwise NOT: returns `~a`
pub inline fn vmvnq_s8(a: types.i8x16) types.i8x16 {
    return ~a;
}

test vmvnq_s8 {
    const a = @as(types.i8x16, @splat(0x55));
    const expected = @as(types.i8x16, @splat(@as(i8, @bitCast(@as(u8, ~@as(u8, 0x55))))));
    try common.testIntrinsic(.{ .func = vmvnq_s8, .expected = expected, .args = .{a} });
}

/// Vector bitwise NOT: returns `~a`
pub inline fn vmvnq_s16(a: types.i16x8) types.i16x8 {
    return ~a;
}

test vmvnq_s16 {
    const a = @as(types.i16x8, @splat(0x55));
    const expected = @as(types.i16x8, @splat(@as(i16, @bitCast(@as(u16, ~@as(u16, 0x55))))));
    try common.testIntrinsic(.{ .func = vmvnq_s16, .expected = expected, .args = .{a} });
}

/// Vector bitwise NOT: returns `~a`
pub inline fn vmvnq_s32(a: types.i32x4) types.i32x4 {
    return ~a;
}

test vmvnq_s32 {
    const a = @as(types.i32x4, @splat(0x55));
    const expected = @as(types.i32x4, @splat(@as(i32, @bitCast(@as(u32, ~@as(u32, 0x55))))));
    try common.testIntrinsic(.{ .func = vmvnq_s32, .expected = expected, .args = .{a} });
}

/// Vector bitwise NOT: returns `~a`
pub inline fn vmvnq_u8(a: types.u8x16) types.u8x16 {
    return ~a;
}

test vmvnq_u8 {
    const a = @as(types.u8x16, @splat(0x55));
    const expected = @as(types.u8x16, @splat(@as(u8, @bitCast(@as(u8, ~@as(u8, 0x55))))));
    try common.testIntrinsic(.{ .func = vmvnq_u8, .expected = expected, .args = .{a} });
}

/// Vector bitwise NOT: returns `~a`
pub inline fn vmvnq_u16(a: types.u16x8) types.u16x8 {
    return ~a;
}

test vmvnq_u16 {
    const a = @as(types.u16x8, @splat(0x55));
    const expected = @as(types.u16x8, @splat(@as(u16, @bitCast(@as(u16, ~@as(u16, 0x55))))));
    try common.testIntrinsic(.{ .func = vmvnq_u16, .expected = expected, .args = .{a} });
}

/// Vector bitwise NOT: returns `~a`
pub inline fn vmvnq_u32(a: types.u32x4) types.u32x4 {
    return ~a;
}

test vmvnq_u32 {
    const a = @as(types.u32x4, @splat(0x55));
    const expected = @as(types.u32x4, @splat(@as(u32, @bitCast(@as(u32, ~@as(u32, 0x55))))));
    try common.testIntrinsic(.{ .func = vmvnq_u32, .expected = expected, .args = .{a} });
}

/// Vector bitwise NOT: returns `~a`
pub inline fn vmvnq_p8(a: types.p8x16) types.p8x16 {
    return ~a;
}

test vmvnq_p8 {
    const a = @as(types.p8x16, @splat(0x55));
    const expected = @as(types.p8x16, @splat(@as(u8, @bitCast(@as(u8, ~@as(u8, 0x55))))));
    try common.testIntrinsic(.{ .func = vmvnq_p8, .expected = expected, .args = .{a} });
}

/// Vector count leading zeros
pub inline fn vclz_s8(a: types.i8x8) types.i8x8 {
    return @clz(a);
}

test vclz_s8 {
    const a = types.i8x8{ 1, 2, 4, 8, 16, 32, 64, 1 };
    const expected = types.i8x8{ 7, 6, 5, 4, 3, 2, 1, 7 };
    try common.testIntrinsic(.{ .func = vclz_s8, .expected = expected, .args = .{a} });
}

/// Vector count leading zeros
pub inline fn vclz_s16(a: types.i16x4) types.i16x4 {
    return @clz(a);
}

test vclz_s16 {
    const a = types.i16x4{ 1, 2, 4, 8 };
    const expected = types.i16x4{ 15, 14, 13, 12 };
    try common.testIntrinsic(.{ .func = vclz_s16, .expected = expected, .args = .{a} });
}

/// Vector count leading zeros
pub inline fn vclz_s32(a: types.i32x2) types.i32x2 {
    return @clz(a);
}

test vclz_s32 {
    const a = types.i32x2{ 1, 2 };
    const expected = types.i32x2{ 31, 30 };
    try common.testIntrinsic(.{ .func = vclz_s32, .expected = expected, .args = .{a} });
}

/// Vector count leading zeros
pub inline fn vclz_u8(a: types.u8x8) types.u8x8 {
    return @clz(a);
}

test vclz_u8 {
    const a = types.u8x8{ 1, 2, 4, 8, 16, 32, 64, 1 };
    const expected = types.u8x8{ 7, 6, 5, 4, 3, 2, 1, 7 };
    try common.testIntrinsic(.{ .func = vclz_u8, .expected = expected, .args = .{a} });
}

/// Vector count leading zeros
pub inline fn vclz_u16(a: types.u16x4) types.u16x4 {
    return @clz(a);
}

test vclz_u16 {
    const a = types.u16x4{ 1, 2, 4, 8 };
    const expected = types.u16x4{ 15, 14, 13, 12 };
    try common.testIntrinsic(.{ .func = vclz_u16, .expected = expected, .args = .{a} });
}

/// Vector count leading zeros
pub inline fn vclz_u32(a: types.u32x2) types.u32x2 {
    return @clz(a);
}

test vclz_u32 {
    const a = types.u32x2{ 1, 2 };
    const expected = types.u32x2{ 31, 30 };
    try common.testIntrinsic(.{ .func = vclz_u32, .expected = expected, .args = .{a} });
}

/// Vector count leading zeros
pub inline fn vclzq_s8(a: types.i8x16) types.i8x16 {
    return @clz(a);
}

test vclzq_s8 {
    const a = types.i8x16{ 1, 2, 4, 8, 16, 32, 64, 1, 2, 4, 8, 16, 32, 64, 1, 2 };
    const expected = types.i8x16{ 7, 6, 5, 4, 3, 2, 1, 7, 6, 5, 4, 3, 2, 1, 7, 6 };
    try common.testIntrinsic(.{ .func = vclzq_s8, .expected = expected, .args = .{a} });
}

/// Vector count leading zeros
pub inline fn vclzq_s16(a: types.i16x8) types.i16x8 {
    return @clz(a);
}

test vclzq_s16 {
    const a = types.i16x8{ 1, 2, 4, 8, 16, 32, 64, 128 };
    const expected = types.i16x8{ 15, 14, 13, 12, 11, 10, 9, 8 };
    try common.testIntrinsic(.{ .func = vclzq_s16, .expected = expected, .args = .{a} });
}

/// Vector count leading zeros
pub inline fn vclzq_s32(a: types.i32x4) types.i32x4 {
    return @clz(a);
}

test vclzq_s32 {
    const a = types.i32x4{ 1, 2, 4, 8 };
    const expected = types.i32x4{ 31, 30, 29, 28 };
    try common.testIntrinsic(.{ .func = vclzq_s32, .expected = expected, .args = .{a} });
}

/// Vector count leading zeros
pub inline fn vclzq_u8(a: types.u8x16) types.u8x16 {
    return @clz(a);
}

test vclzq_u8 {
    const a = types.u8x16{ 1, 2, 4, 8, 16, 32, 64, 1, 2, 4, 8, 16, 32, 64, 1, 2 };
    const expected = types.u8x16{ 7, 6, 5, 4, 3, 2, 1, 7, 6, 5, 4, 3, 2, 1, 7, 6 };
    try common.testIntrinsic(.{ .func = vclzq_u8, .expected = expected, .args = .{a} });
}

/// Vector count leading zeros
pub inline fn vclzq_u16(a: types.u16x8) types.u16x8 {
    return @clz(a);
}

test vclzq_u16 {
    const a = types.u16x8{ 1, 2, 4, 8, 16, 32, 64, 128 };
    const expected = types.u16x8{ 15, 14, 13, 12, 11, 10, 9, 8 };
    try common.testIntrinsic(.{ .func = vclzq_u16, .expected = expected, .args = .{a} });
}

/// Vector count leading zeros
pub inline fn vclzq_u32(a: types.u32x4) types.u32x4 {
    return @clz(a);
}

test vclzq_u32 {
    const a = types.u32x4{ 1, 2, 4, 8 };
    const expected = types.u32x4{ 31, 30, 29, 28 };
    try common.testIntrinsic(.{ .func = vclzq_u32, .expected = expected, .args = .{a} });
}

/// Vector count leading sign bits
pub inline fn vcls_s8(a: types.i8x8) types.i8x8 {
    const ux: types.u8x8 = @bitCast(a);
    const is_neg = a < @as(types.i8x8, @splat(0));
    const m = @select(u8, is_neg, ~ux, ux);
    return @as(types.i8x8, @bitCast(@clz(m) - @as(types.u8x8, @splat(1))));
}

test vcls_s8 {
    const a = types.i8x8{ 0, -1, 64, -64, 16, -16, 1, -2 };
    const expected = types.i8x8{ 7, 7, 0, 1, 2, 3, 6, 6 };
    try common.testIntrinsic(.{ .func = vcls_s8, .expected = expected, .args = .{a} });
}

/// Vector count leading sign bits
pub inline fn vcls_s16(a: types.i16x4) types.i16x4 {
    const ux: types.u16x4 = @bitCast(a);
    const is_neg = a < @as(types.i16x4, @splat(0));
    const m = @select(u16, is_neg, ~ux, ux);
    return @as(types.i16x4, @bitCast(@clz(m) - @as(types.u16x4, @splat(1))));
}

test vcls_s16 {
    const a = types.i16x4{ 0, -1, 16384, -16384 };
    const expected = types.i16x4{ 15, 15, 0, 1 };
    try common.testIntrinsic(.{ .func = vcls_s16, .expected = expected, .args = .{a} });
}

/// Vector count leading sign bits
pub inline fn vcls_s32(a: types.i32x2) types.i32x2 {
    const ux: types.u32x2 = @bitCast(a);
    const is_neg = a < @as(types.i32x2, @splat(0));
    const m = @select(u32, is_neg, ~ux, ux);
    return @as(types.i32x2, @bitCast(@clz(m) - @as(types.u32x2, @splat(1))));
}

test vcls_s32 {
    const a = types.i32x2{ 0, -1 };
    const expected = types.i32x2{ 31, 31 };
    try common.testIntrinsic(.{ .func = vcls_s32, .expected = expected, .args = .{a} });
}

/// Vector count leading sign bits
pub inline fn vclsq_s8(a: types.i8x16) types.i8x16 {
    const ux: types.u8x16 = @bitCast(a);
    const is_neg = a < @as(types.i8x16, @splat(0));
    const m = @select(u8, is_neg, ~ux, ux);
    return @as(types.i8x16, @bitCast(@clz(m) - @as(types.u8x16, @splat(1))));
}

test vclsq_s8 {
    const a = types.i8x16{ 0, -1, 64, -64, 16, -16, 1, -2, 8, -8, 32, -32, 2, -4, 4, -8 };
    const expected = types.i8x16{ 7, 7, 0, 1, 2, 3, 6, 6, 3, 4, 1, 2, 5, 5, 4, 4 };
    try common.testIntrinsic(.{ .func = vclsq_s8, .expected = expected, .args = .{a} });
}

/// Vector count leading sign bits
pub inline fn vclsq_s16(a: types.i16x8) types.i16x8 {
    const ux: types.u16x8 = @bitCast(a);
    const is_neg = a < @as(types.i16x8, @splat(0));
    const m = @select(u16, is_neg, ~ux, ux);
    return @as(types.i16x8, @bitCast(@clz(m) - @as(types.u16x8, @splat(1))));
}

test vclsq_s16 {
    const a = types.i16x8{ 0, -1, 16384, -16384, 1000, -1000, 200, -200 };
    const expected = types.i16x8{ 15, 15, 0, 1, 5, 5, 7, 7 };
    try common.testIntrinsic(.{ .func = vclsq_s16, .expected = expected, .args = .{a} });
}

/// Vector count leading sign bits
pub inline fn vclsq_s32(a: types.i32x4) types.i32x4 {
    const ux: types.u32x4 = @bitCast(a);
    const is_neg = a < @as(types.i32x4, @splat(0));
    const m = @select(u32, is_neg, ~ux, ux);
    return @as(types.i32x4, @bitCast(@clz(m) - @as(types.u32x4, @splat(1))));
}

test vclsq_s32 {
    const a = types.i32x4{ 0, -1, 1000000, -1000000 };
    const expected = types.i32x4{ 31, 31, 11, 11 };
    try common.testIntrinsic(.{ .func = vclsq_s32, .expected = expected, .args = .{a} });
}

/// Bitwise select: returns `(c & a) | (~c & b)`
pub inline fn vbsl_f16(c: types.u16x4, a: types.f16x4, b: types.f16x4) types.f16x4 {
    const ua: types.u16x4 = @bitCast(a);
    const ub: types.u16x4 = @bitCast(b);
    const res = (c & ua) | (~c & ub);
    return @bitCast(res);
}

test vbsl_f16 {
    const c = @as(types.u16x4, @splat(0xffff));
    const a = @as(types.f16x4, @splat(2.5));
    const b = @as(types.f16x4, @splat(1.0));
    const expected = a;
    try common.testIntrinsic(.{ .func = vbsl_f16, .expected = expected, .args = .{ c, a, b } });
}

/// Bitwise select: returns `(c & a) | (~c & b)`
pub inline fn vbslq_f16(c: types.u16x8, a: types.f16x8, b: types.f16x8) types.f16x8 {
    const ua: types.u16x8 = @bitCast(a);
    const ub: types.u16x8 = @bitCast(b);
    const res = (c & ua) | (~c & ub);
    return @bitCast(res);
}

test vbslq_f16 {
    const c = @as(types.u16x8, @splat(0xffff));
    const a = @as(types.f16x8, @splat(2.5));
    const b = @as(types.f16x8, @splat(1.0));
    const expected = a;
    try common.testIntrinsic(.{ .func = vbslq_f16, .expected = expected, .args = .{ c, a, b } });
}

/// Three-way vector bitwise XOR: returns `a ^ b ^ c`
pub inline fn veor3q_s8(a: types.i8x16, b: types.i8x16, c: types.i8x16) types.i8x16 {
    return a ^ b ^ c;
}

test veor3q_s8 {
    const a = @as(types.i8x16, @splat(0x55));
    const b = @as(types.i8x16, @splat(0x33));
    const c = @as(types.i8x16, @splat(0x0F));
    const expected = @as(types.i8x16, @splat(105));
    try common.testIntrinsic(.{ .func = veor3q_s8, .expected = expected, .args = .{ a, b, c } });
}

/// Three-way vector bitwise XOR: returns `a ^ b ^ c`
pub inline fn veor3q_s16(a: types.i16x8, b: types.i16x8, c: types.i16x8) types.i16x8 {
    return a ^ b ^ c;
}

test veor3q_s16 {
    const a = @as(types.i16x8, @splat(0x55));
    const b = @as(types.i16x8, @splat(0x33));
    const c = @as(types.i16x8, @splat(0x0F));
    const expected = @as(types.i16x8, @splat(105));
    try common.testIntrinsic(.{ .func = veor3q_s16, .expected = expected, .args = .{ a, b, c } });
}

/// Three-way vector bitwise XOR: returns `a ^ b ^ c`
pub inline fn veor3q_s32(a: types.i32x4, b: types.i32x4, c: types.i32x4) types.i32x4 {
    return a ^ b ^ c;
}

test veor3q_s32 {
    const a = @as(types.i32x4, @splat(0x55));
    const b = @as(types.i32x4, @splat(0x33));
    const c = @as(types.i32x4, @splat(0x0F));
    const expected = @as(types.i32x4, @splat(105));
    try common.testIntrinsic(.{ .func = veor3q_s32, .expected = expected, .args = .{ a, b, c } });
}

/// Three-way vector bitwise XOR: returns `a ^ b ^ c`
pub inline fn veor3q_s64(a: types.i64x2, b: types.i64x2, c: types.i64x2) types.i64x2 {
    return a ^ b ^ c;
}

test veor3q_s64 {
    const a = @as(types.i64x2, @splat(0x55));
    const b = @as(types.i64x2, @splat(0x33));
    const c = @as(types.i64x2, @splat(0x0F));
    const expected = @as(types.i64x2, @splat(105));
    try common.testIntrinsic(.{ .func = veor3q_s64, .expected = expected, .args = .{ a, b, c } });
}

/// Three-way vector bitwise XOR: returns `a ^ b ^ c`
pub inline fn veor3q_u8(a: types.u8x16, b: types.u8x16, c: types.u8x16) types.u8x16 {
    return a ^ b ^ c;
}

test veor3q_u8 {
    const a = @as(types.u8x16, @splat(0x55));
    const b = @as(types.u8x16, @splat(0x33));
    const c = @as(types.u8x16, @splat(0x0F));
    const expected = @as(types.u8x16, @splat(105));
    try common.testIntrinsic(.{ .func = veor3q_u8, .expected = expected, .args = .{ a, b, c } });
}

/// Three-way vector bitwise XOR: returns `a ^ b ^ c`
pub inline fn veor3q_u16(a: types.u16x8, b: types.u16x8, c: types.u16x8) types.u16x8 {
    return a ^ b ^ c;
}

test veor3q_u16 {
    const a = @as(types.u16x8, @splat(0x55));
    const b = @as(types.u16x8, @splat(0x33));
    const c = @as(types.u16x8, @splat(0x0F));
    const expected = @as(types.u16x8, @splat(105));
    try common.testIntrinsic(.{ .func = veor3q_u16, .expected = expected, .args = .{ a, b, c } });
}

/// Three-way vector bitwise XOR: returns `a ^ b ^ c`
pub inline fn veor3q_u32(a: types.u32x4, b: types.u32x4, c: types.u32x4) types.u32x4 {
    return a ^ b ^ c;
}

test veor3q_u32 {
    const a = @as(types.u32x4, @splat(0x55));
    const b = @as(types.u32x4, @splat(0x33));
    const c = @as(types.u32x4, @splat(0x0F));
    const expected = @as(types.u32x4, @splat(105));
    try common.testIntrinsic(.{ .func = veor3q_u32, .expected = expected, .args = .{ a, b, c } });
}

/// Three-way vector bitwise XOR: returns `a ^ b ^ c`
pub inline fn veor3q_u64(a: types.u64x2, b: types.u64x2, c: types.u64x2) types.u64x2 {
    return a ^ b ^ c;
}

test veor3q_u64 {
    const a = @as(types.u64x2, @splat(0x55));
    const b = @as(types.u64x2, @splat(0x33));
    const c = @as(types.u64x2, @splat(0x0F));
    const expected = @as(types.u64x2, @splat(105));
    try common.testIntrinsic(.{ .func = veor3q_u64, .expected = expected, .args = .{ a, b, c } });
}

/// Vector population count (count number of set bits per element)
pub inline fn vcnt_s8(a: types.i8x8) types.i8x8 {
    return @popCount(a);
}

test vcnt_s8 {
    const a = types.i8x8{ 0x01, 0x03, 0x07, 0x0f, 0x1f, 0x3f, 0x7f, 0x55 };
    const expected = types.i8x8{ 1, 2, 3, 4, 5, 6, 7, 4 };
    try common.testIntrinsic(.{ .func = vcnt_s8, .expected = expected, .args = .{a} });
}

/// Vector population count (count number of set bits per element)
pub inline fn vcnt_u8(a: types.u8x8) types.u8x8 {
    return @popCount(a);
}

test vcnt_u8 {
    const a = types.u8x8{ 0x01, 0x03, 0x07, 0x0f, 0x1f, 0x3f, 0x7f, 0x55 };
    const expected = types.u8x8{ 1, 2, 3, 4, 5, 6, 7, 4 };
    try common.testIntrinsic(.{ .func = vcnt_u8, .expected = expected, .args = .{a} });
}

/// Vector population count (count number of set bits per element)
pub inline fn vcnt_p8(a: types.p8x8) types.p8x8 {
    return @popCount(a);
}

test vcnt_p8 {
    const a = types.p8x8{ 0x01, 0x03, 0x07, 0x0f, 0x1f, 0x3f, 0x7f, 0x55 };
    const expected = types.p8x8{ 1, 2, 3, 4, 5, 6, 7, 4 };
    try common.testIntrinsic(.{ .func = vcnt_p8, .expected = expected, .args = .{a} });
}

/// Vector population count (count number of set bits per element)
pub inline fn vcntq_s8(a: types.i8x16) types.i8x16 {
    return @popCount(a);
}

test vcntq_s8 {
    const a = types.i8x16{ 0x01, 0x03, 0x07, 0x0f, 0x1f, 0x3f, 0x7f, 0x55, 0x01, 0x03, 0x07, 0x0f, 0x1f, 0x3f, 0x7f, 0x55 };
    const expected = types.i8x16{ 1, 2, 3, 4, 5, 6, 7, 4, 1, 2, 3, 4, 5, 6, 7, 4 };
    try common.testIntrinsic(.{ .func = vcntq_s8, .expected = expected, .args = .{a} });
}

/// Vector population count (count number of set bits per element)
pub inline fn vcntq_u8(a: types.u8x16) types.u8x16 {
    return @popCount(a);
}

test vcntq_u8 {
    const a = types.u8x16{ 0x01, 0x03, 0x07, 0x0f, 0x1f, 0x3f, 0x7f, 0x55, 0x01, 0x03, 0x07, 0x0f, 0x1f, 0x3f, 0x7f, 0x55 };
    const expected = types.u8x16{ 1, 2, 3, 4, 5, 6, 7, 4, 1, 2, 3, 4, 5, 6, 7, 4 };
    try common.testIntrinsic(.{ .func = vcntq_u8, .expected = expected, .args = .{a} });
}

/// Vector population count (count number of set bits per element)
pub inline fn vcntq_p8(a: types.p8x16) types.p8x16 {
    return @popCount(a);
}

test vcntq_p8 {
    const a = types.p8x16{ 0x01, 0x03, 0x07, 0x0f, 0x1f, 0x3f, 0x7f, 0x55, 0x01, 0x03, 0x07, 0x0f, 0x1f, 0x3f, 0x7f, 0x55 };
    const expected = types.p8x16{ 1, 2, 3, 4, 5, 6, 7, 4, 1, 2, 3, 4, 5, 6, 7, 4 };
    try common.testIntrinsic(.{ .func = vcntq_p8, .expected = expected, .args = .{a} });
}

/// Vector count leading sign bits
pub inline fn vcls_u8(a: types.u8x8) types.u8x8 {
    return @bitCast(vcls_s8(@bitCast(a)));
}

test vcls_u8 {
    const a = @as(types.u8x8, @splat(0x40));
    const expected = @as(types.u8x8, @splat(0));
    try common.testIntrinsic(.{ .func = vcls_u8, .expected = expected, .args = .{a} });
}

/// Vector count leading sign bits
pub inline fn vcls_u16(a: types.u16x4) types.u16x4 {
    return @bitCast(vcls_s16(@bitCast(a)));
}

test vcls_u16 {
    const a = @as(types.u16x4, @splat(0x40));
    const expected = @as(types.u16x4, @splat(8));
    try common.testIntrinsic(.{ .func = vcls_u16, .expected = expected, .args = .{a} });
}

/// Vector count leading sign bits
pub inline fn vcls_u32(a: types.u32x2) types.u32x2 {
    return @bitCast(vcls_s32(@bitCast(a)));
}

test vcls_u32 {
    const a = @as(types.u32x2, @splat(0x40));
    const expected = @as(types.u32x2, @splat(24));
    try common.testIntrinsic(.{ .func = vcls_u32, .expected = expected, .args = .{a} });
}

/// Vector count leading sign bits
pub inline fn vclsq_u8(a: types.u8x16) types.u8x16 {
    return @bitCast(vclsq_s8(@bitCast(a)));
}

test vclsq_u8 {
    const a = @as(types.u8x16, @splat(0x40));
    const expected = @as(types.u8x16, @splat(0));
    try common.testIntrinsic(.{ .func = vclsq_u8, .expected = expected, .args = .{a} });
}

/// Vector count leading sign bits
pub inline fn vclsq_u16(a: types.u16x8) types.u16x8 {
    return @bitCast(vclsq_s16(@bitCast(a)));
}

test vclsq_u16 {
    const a = @as(types.u16x8, @splat(0x40));
    const expected = @as(types.u16x8, @splat(8));
    try common.testIntrinsic(.{ .func = vclsq_u16, .expected = expected, .args = .{a} });
}

/// Vector count leading sign bits
pub inline fn vclsq_u32(a: types.u32x4) types.u32x4 {
    return @bitCast(vclsq_s32(@bitCast(a)));
}

test vclsq_u32 {
    const a = @as(types.u32x4, @splat(0x40));
    const expected = @as(types.u32x4, @splat(24));
    try common.testIntrinsic(.{ .func = vclsq_u32, .expected = expected, .args = .{a} });
}

/// ARM NEON intrinsic: `vbsl_mf8`
pub inline fn vbsl_mf8(p0: types.u8x8, p1: types.mf8x8, p2: types.mf8x8) types.mf8x8 {
    return (p0 & p1) | (~p0 & p2);
}

test vbsl_mf8 {
    const a = types.u8x8{ 0xFF, 0, 0xFF, 0, 0xFF, 0, 0xFF, 0 };
    const b = types.mf8x8{ 1, 2, 3, 4, 5, 6, 7, 8 };
    const c = types.mf8x8{ 10, 20, 30, 40, 50, 60, 70, 80 };
    const expected = types.mf8x8{ 1, 20, 3, 40, 5, 60, 7, 80 };
    try common.testIntrinsic(.{ .func = vbsl_mf8, .expected = expected, .args = .{ a, b, c } });
}

/// ARM NEON intrinsic: `vbslq_mf8`
pub inline fn vbslq_mf8(p0: types.u8x16, p1: types.mf8x16, p2: types.mf8x16) types.mf8x16 {
    return (p0 & p1) | (~p0 & p2);
}

test vbslq_mf8 {
    const a = types.u8x16{ 0xFF, 0, 0xFF, 0, 0xFF, 0, 0xFF, 0, 0xFF, 0, 0xFF, 0, 0xFF, 0, 0xFF, 0 };
    const b = types.mf8x16{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 };
    const c = types.mf8x16{ 10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110, 120, 130, 140, 150, 160 };
    const expected = types.mf8x16{ 1, 20, 3, 40, 5, 60, 7, 80, 9, 100, 11, 120, 13, 140, 15, 160 };
    try common.testIntrinsic(.{ .func = vbslq_mf8, .expected = expected, .args = .{ a, b, c } });
}
