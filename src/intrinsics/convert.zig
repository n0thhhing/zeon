const std = @import("std");
const expectEqual = std.testing.expectEqual;
const common = @import("../common.zig");

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
