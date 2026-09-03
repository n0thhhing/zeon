const std = @import("std");
const types = @import("../types.zig");

const common = @import("../common.zig");

/// Shift right
pub inline fn vshrq_n_s8(a: types.i8x16, n: u8) types.i8x16 {
    return @as(types.u8x16, @bitCast(a)) >> @as(types.u8x16, @splat(n));
}

test vshrq_n_s8 {
    const a: types.i8x16 = @splat(1);
    const n: u8 = 1;
    const expected: types.i8x16 = @splat(0);
    try common.testIntrinsic(.{ .func = vshrq_n_s8, .expected = expected, .args = .{ a, n } });
}

/// Shift right
pub inline fn vshrq_n_s16(a: types.i16x8, n: u16) types.i16x8 {
    return @as(types.u16x8, @bitCast(a)) >> @as(types.u16x8, @splat(n));
}

test vshrq_n_s16 {
    const a: types.i16x8 = @splat(1);
    const n: u16 = 1;
    const expected: types.i16x8 = @splat(0);
    try common.testIntrinsic(.{ .func = vshrq_n_s16, .expected = expected, .args = .{ a, n } });
}

/// Shift right
pub inline fn vshrq_n_s32(a: types.i32x4, n: u32) types.i32x4 {
    return @as(types.u32x4, @bitCast(a)) >> @as(types.u32x4, @splat(n));
}

test vshrq_n_s32 {
    const a: types.i32x4 = @splat(1);
    const n: u32 = 1;
    const expected: types.i32x4 = @splat(0);
    try common.testIntrinsic(.{ .func = vshrq_n_s32, .expected = expected, .args = .{ a, n } });
}

/// Shift right
pub inline fn vshrq_n_s64(a: types.u64x2, n: u64) types.i64x2 {
    return a >> @as(types.u64x2, @splat(n));
}

test vshrq_n_s64 {
    const a: types.u64x2 = @splat(1);
    const n: u64 = 1;
    const expected: types.i64x2 = @splat(0);
    try common.testIntrinsic(.{ .func = vshrq_n_s64, .expected = expected, .args = .{ a, n } });
}

/// Shift right
pub inline fn vshrq_n_u8(a: types.u8x16, n: u8) types.u8x16 {
    return a >> @as(types.u8x16, @splat(n));
}

test vshrq_n_u8 {
    const a: types.u8x16 = @splat(1);
    const n: u8 = 1;
    const expected: types.u8x16 = @splat(0);
    try common.testIntrinsic(.{ .func = vshrq_n_u8, .expected = expected, .args = .{ a, n } });
}

/// Shift right
pub inline fn vshrq_n_u16(a: types.u16x8, n: u16) types.u16x8 {
    return a >> @as(types.u16x8, @splat(n));
}

test vshrq_n_u16 {
    const a: types.u16x8 = @splat(1);
    const n: u16 = 1;
    const expected: types.u16x8 = @splat(0);
    try common.testIntrinsic(.{ .func = vshrq_n_u16, .expected = expected, .args = .{ a, n } });
}

/// Shift right
pub inline fn vshrq_n_u32(a: types.u32x4, n: u32) types.u32x4 {
    return a >> @as(types.u32x4, @splat(n));
}

test vshrq_n_u32 {
    const a: types.u32x4 = @splat(1);
    const n: u32 = 1;
    const expected: types.u32x4 = @splat(0);
    try common.testIntrinsic(.{ .func = vshrq_n_u32, .expected = expected, .args = .{ a, n } });
}

/// Shift right
pub inline fn vshrq_n_u64(a: types.u64x2, n: u64) types.u64x2 {
    return a >> @as(types.u64x2, @splat(n));
}

test vshrq_n_u64 {
    const a: types.u64x2 = @splat(1);
    const n: u64 = 1;
    const expected: types.u64x2 = @splat(0);
    try common.testIntrinsic(.{ .func = vshrq_n_u64, .expected = expected, .args = .{ a, n } });
}

/// Vector shift by signed vector count
pub inline fn vshl_s8(a: types.i8x8, b: types.i8x8) types.i8x8 {
    var res: types.i8x8 = undefined;
    const bits: i8 = 8;
    inline for (0..8) |i| {
        const shift = b[i];
        if (shift >= bits) {
            res[i] = 0;
        } else if (shift <= -bits) {
            res[i] = if (a[i] < 0) -1 else 0;
        } else if (shift >= 0) {
            const u: std.math.Log2Int(i8) = @intCast(shift);
            res[i] = a[i] << u;
        } else {
            const u: std.math.Log2Int(i8) = @intCast(-shift);
            res[i] = a[i] >> u;
        }
    }
    return res;
}

test vshl_s8 {
    const a = @as(types.i8x8, @splat(16));
    const b = @as(types.i8x8, @splat(1));
    const expected = @as(types.i8x8, @splat(32));
    try common.testIntrinsic(.{ .func = vshl_s8, .expected = expected, .args = .{ a, b } });
}

/// Vector shift by signed vector count
pub inline fn vshlq_s8(a: types.i8x16, b: types.i8x16) types.i8x16 {
    var res: types.i8x16 = undefined;
    const bits: i8 = 8;
    inline for (0..16) |i| {
        const shift = b[i];
        if (shift >= bits) {
            res[i] = 0;
        } else if (shift <= -bits) {
            res[i] = if (a[i] < 0) -1 else 0;
        } else if (shift >= 0) {
            const u: std.math.Log2Int(i8) = @intCast(shift);
            res[i] = a[i] << u;
        } else {
            const u: std.math.Log2Int(i8) = @intCast(-shift);
            res[i] = a[i] >> u;
        }
    }
    return res;
}

test vshlq_s8 {
    const a = @as(types.i8x16, @splat(16));
    const b = @as(types.i8x16, @splat(1));
    const expected = @as(types.i8x16, @splat(32));
    try common.testIntrinsic(.{ .func = vshlq_s8, .expected = expected, .args = .{ a, b } });
}

/// Vector shift by signed vector count
pub inline fn vshl_s16(a: types.i16x4, b: types.i16x4) types.i16x4 {
    var res: types.i16x4 = undefined;
    const bits: i16 = 16;
    inline for (0..4) |i| {
        const shift = b[i];
        if (shift >= bits) {
            res[i] = 0;
        } else if (shift <= -bits) {
            res[i] = if (a[i] < 0) -1 else 0;
        } else if (shift >= 0) {
            const u: std.math.Log2Int(i16) = @intCast(shift);
            res[i] = a[i] << u;
        } else {
            const u: std.math.Log2Int(i16) = @intCast(-shift);
            res[i] = a[i] >> u;
        }
    }
    return res;
}

test vshl_s16 {
    const a = @as(types.i16x4, @splat(16));
    const b = @as(types.i16x4, @splat(1));
    const expected = @as(types.i16x4, @splat(32));
    try common.testIntrinsic(.{ .func = vshl_s16, .expected = expected, .args = .{ a, b } });
}

/// Vector shift by signed vector count
pub inline fn vshlq_s16(a: types.i16x8, b: types.i16x8) types.i16x8 {
    var res: types.i16x8 = undefined;
    const bits: i16 = 16;
    inline for (0..8) |i| {
        const shift = b[i];
        if (shift >= bits) {
            res[i] = 0;
        } else if (shift <= -bits) {
            res[i] = if (a[i] < 0) -1 else 0;
        } else if (shift >= 0) {
            const u: std.math.Log2Int(i16) = @intCast(shift);
            res[i] = a[i] << u;
        } else {
            const u: std.math.Log2Int(i16) = @intCast(-shift);
            res[i] = a[i] >> u;
        }
    }
    return res;
}

test vshlq_s16 {
    const a = @as(types.i16x8, @splat(16));
    const b = @as(types.i16x8, @splat(1));
    const expected = @as(types.i16x8, @splat(32));
    try common.testIntrinsic(.{ .func = vshlq_s16, .expected = expected, .args = .{ a, b } });
}

/// Vector shift by signed vector count
pub inline fn vshl_s32(a: types.i32x2, b: types.i32x2) types.i32x2 {
    var res: types.i32x2 = undefined;
    const bits: i32 = 32;
    inline for (0..2) |i| {
        const shift = b[i];
        if (shift >= bits) {
            res[i] = 0;
        } else if (shift <= -bits) {
            res[i] = if (a[i] < 0) -1 else 0;
        } else if (shift >= 0) {
            const u: std.math.Log2Int(i32) = @intCast(shift);
            res[i] = a[i] << u;
        } else {
            const u: std.math.Log2Int(i32) = @intCast(-shift);
            res[i] = a[i] >> u;
        }
    }
    return res;
}

test vshl_s32 {
    const a = @as(types.i32x2, @splat(16));
    const b = @as(types.i32x2, @splat(1));
    const expected = @as(types.i32x2, @splat(32));
    try common.testIntrinsic(.{ .func = vshl_s32, .expected = expected, .args = .{ a, b } });
}

/// Vector shift by signed vector count
pub inline fn vshlq_s32(a: types.i32x4, b: types.i32x4) types.i32x4 {
    var res: types.i32x4 = undefined;
    const bits: i32 = 32;
    inline for (0..4) |i| {
        const shift = b[i];
        if (shift >= bits) {
            res[i] = 0;
        } else if (shift <= -bits) {
            res[i] = if (a[i] < 0) -1 else 0;
        } else if (shift >= 0) {
            const u: std.math.Log2Int(i32) = @intCast(shift);
            res[i] = a[i] << u;
        } else {
            const u: std.math.Log2Int(i32) = @intCast(-shift);
            res[i] = a[i] >> u;
        }
    }
    return res;
}

test vshlq_s32 {
    const a = @as(types.i32x4, @splat(16));
    const b = @as(types.i32x4, @splat(1));
    const expected = @as(types.i32x4, @splat(32));
    try common.testIntrinsic(.{ .func = vshlq_s32, .expected = expected, .args = .{ a, b } });
}

/// Vector shift by signed vector count
pub inline fn vshl_s64(a: types.i64x1, b: types.i64x1) types.i64x1 {
    var res: types.i64x1 = undefined;
    const bits: i64 = 64;
    inline for (0..1) |i| {
        const shift = b[i];
        if (shift >= bits) {
            res[i] = 0;
        } else if (shift <= -bits) {
            res[i] = if (a[i] < 0) -1 else 0;
        } else if (shift >= 0) {
            const u: std.math.Log2Int(i64) = @intCast(shift);
            res[i] = a[i] << u;
        } else {
            const u: std.math.Log2Int(i64) = @intCast(-shift);
            res[i] = a[i] >> u;
        }
    }
    return res;
}

test vshl_s64 {
    const a = @as(types.i64x1, @splat(16));
    const b = @as(types.i64x1, @splat(1));
    const expected = @as(types.i64x1, @splat(32));
    try common.testIntrinsic(.{ .func = vshl_s64, .expected = expected, .args = .{ a, b } });
}

/// Vector shift by signed vector count
pub inline fn vshlq_s64(a: types.i64x2, b: types.i64x2) types.i64x2 {
    var res: types.i64x2 = undefined;
    const bits: i64 = 64;
    inline for (0..2) |i| {
        const shift = b[i];
        if (shift >= bits) {
            res[i] = 0;
        } else if (shift <= -bits) {
            res[i] = if (a[i] < 0) -1 else 0;
        } else if (shift >= 0) {
            const u: std.math.Log2Int(i64) = @intCast(shift);
            res[i] = a[i] << u;
        } else {
            const u: std.math.Log2Int(i64) = @intCast(-shift);
            res[i] = a[i] >> u;
        }
    }
    return res;
}

test vshlq_s64 {
    const a = @as(types.i64x2, @splat(16));
    const b = @as(types.i64x2, @splat(1));
    const expected = @as(types.i64x2, @splat(32));
    try common.testIntrinsic(.{ .func = vshlq_s64, .expected = expected, .args = .{ a, b } });
}

/// Vector shift by signed vector count
pub inline fn vshl_u8(a: types.u8x8, b: types.i8x8) types.u8x8 {
    var res: types.u8x8 = undefined;
    const bits: i8 = 8;
    inline for (0..8) |i| {
        const shift = b[i];
        if (shift >= bits) {
            res[i] = 0;
        } else if (shift <= -bits) {
            res[i] = 0;
        } else if (shift >= 0) {
            const u: std.math.Log2Int(u8) = @intCast(shift);
            res[i] = a[i] << u;
        } else {
            const u: std.math.Log2Int(u8) = @intCast(-shift);
            res[i] = a[i] >> u;
        }
    }
    return res;
}

test vshl_u8 {
    const a = @as(types.u8x8, @splat(16));
    const b = @as(types.i8x8, @splat(1));
    const expected = @as(types.u8x8, @splat(32));
    try common.testIntrinsic(.{ .func = vshl_u8, .expected = expected, .args = .{ a, b } });
}

/// Vector shift by signed vector count
pub inline fn vshlq_u8(a: types.u8x16, b: types.i8x16) types.u8x16 {
    var res: types.u8x16 = undefined;
    const bits: i8 = 8;
    inline for (0..16) |i| {
        const shift = b[i];
        if (shift >= bits) {
            res[i] = 0;
        } else if (shift <= -bits) {
            res[i] = 0;
        } else if (shift >= 0) {
            const u: std.math.Log2Int(u8) = @intCast(shift);
            res[i] = a[i] << u;
        } else {
            const u: std.math.Log2Int(u8) = @intCast(-shift);
            res[i] = a[i] >> u;
        }
    }
    return res;
}

test vshlq_u8 {
    const a = @as(types.u8x16, @splat(16));
    const b = @as(types.i8x16, @splat(1));
    const expected = @as(types.u8x16, @splat(32));
    try common.testIntrinsic(.{ .func = vshlq_u8, .expected = expected, .args = .{ a, b } });
}

/// Vector shift by signed vector count
pub inline fn vshl_u16(a: types.u16x4, b: types.i16x4) types.u16x4 {
    var res: types.u16x4 = undefined;
    const bits: i16 = 16;
    inline for (0..4) |i| {
        const shift = b[i];
        if (shift >= bits) {
            res[i] = 0;
        } else if (shift <= -bits) {
            res[i] = 0;
        } else if (shift >= 0) {
            const u: std.math.Log2Int(u16) = @intCast(shift);
            res[i] = a[i] << u;
        } else {
            const u: std.math.Log2Int(u16) = @intCast(-shift);
            res[i] = a[i] >> u;
        }
    }
    return res;
}

test vshl_u16 {
    const a = @as(types.u16x4, @splat(16));
    const b = @as(types.i16x4, @splat(1));
    const expected = @as(types.u16x4, @splat(32));
    try common.testIntrinsic(.{ .func = vshl_u16, .expected = expected, .args = .{ a, b } });
}

/// Vector shift by signed vector count
pub inline fn vshlq_u16(a: types.u16x8, b: types.i16x8) types.u16x8 {
    var res: types.u16x8 = undefined;
    const bits: i16 = 16;
    inline for (0..8) |i| {
        const shift = b[i];
        if (shift >= bits) {
            res[i] = 0;
        } else if (shift <= -bits) {
            res[i] = 0;
        } else if (shift >= 0) {
            const u: std.math.Log2Int(u16) = @intCast(shift);
            res[i] = a[i] << u;
        } else {
            const u: std.math.Log2Int(u16) = @intCast(-shift);
            res[i] = a[i] >> u;
        }
    }
    return res;
}

test vshlq_u16 {
    const a = @as(types.u16x8, @splat(16));
    const b = @as(types.i16x8, @splat(1));
    const expected = @as(types.u16x8, @splat(32));
    try common.testIntrinsic(.{ .func = vshlq_u16, .expected = expected, .args = .{ a, b } });
}

/// Vector shift by signed vector count
pub inline fn vshl_u32(a: types.u32x2, b: types.i32x2) types.u32x2 {
    var res: types.u32x2 = undefined;
    const bits: i32 = 32;
    inline for (0..2) |i| {
        const shift = b[i];
        if (shift >= bits) {
            res[i] = 0;
        } else if (shift <= -bits) {
            res[i] = 0;
        } else if (shift >= 0) {
            const u: std.math.Log2Int(u32) = @intCast(shift);
            res[i] = a[i] << u;
        } else {
            const u: std.math.Log2Int(u32) = @intCast(-shift);
            res[i] = a[i] >> u;
        }
    }
    return res;
}

test vshl_u32 {
    const a = @as(types.u32x2, @splat(16));
    const b = @as(types.i32x2, @splat(1));
    const expected = @as(types.u32x2, @splat(32));
    try common.testIntrinsic(.{ .func = vshl_u32, .expected = expected, .args = .{ a, b } });
}

/// Vector shift by signed vector count
pub inline fn vshlq_u32(a: types.u32x4, b: types.i32x4) types.u32x4 {
    var res: types.u32x4 = undefined;
    const bits: i32 = 32;
    inline for (0..4) |i| {
        const shift = b[i];
        if (shift >= bits) {
            res[i] = 0;
        } else if (shift <= -bits) {
            res[i] = 0;
        } else if (shift >= 0) {
            const u: std.math.Log2Int(u32) = @intCast(shift);
            res[i] = a[i] << u;
        } else {
            const u: std.math.Log2Int(u32) = @intCast(-shift);
            res[i] = a[i] >> u;
        }
    }
    return res;
}

test vshlq_u32 {
    const a = @as(types.u32x4, @splat(16));
    const b = @as(types.i32x4, @splat(1));
    const expected = @as(types.u32x4, @splat(32));
    try common.testIntrinsic(.{ .func = vshlq_u32, .expected = expected, .args = .{ a, b } });
}

/// Vector shift by signed vector count
pub inline fn vshl_u64(a: types.u64x1, b: types.i64x1) types.u64x1 {
    var res: types.u64x1 = undefined;
    const bits: i64 = 64;
    inline for (0..1) |i| {
        const shift = b[i];
        if (shift >= bits) {
            res[i] = 0;
        } else if (shift <= -bits) {
            res[i] = 0;
        } else if (shift >= 0) {
            const u: std.math.Log2Int(u64) = @intCast(shift);
            res[i] = a[i] << u;
        } else {
            const u: std.math.Log2Int(u64) = @intCast(-shift);
            res[i] = a[i] >> u;
        }
    }
    return res;
}

test vshl_u64 {
    const a = @as(types.u64x1, @splat(16));
    const b = @as(types.i64x1, @splat(1));
    const expected = @as(types.u64x1, @splat(32));
    try common.testIntrinsic(.{ .func = vshl_u64, .expected = expected, .args = .{ a, b } });
}

/// Vector shift by signed vector count
pub inline fn vshlq_u64(a: types.u64x2, b: types.i64x2) types.u64x2 {
    var res: types.u64x2 = undefined;
    const bits: i64 = 64;
    inline for (0..2) |i| {
        const shift = b[i];
        if (shift >= bits) {
            res[i] = 0;
        } else if (shift <= -bits) {
            res[i] = 0;
        } else if (shift >= 0) {
            const u: std.math.Log2Int(u64) = @intCast(shift);
            res[i] = a[i] << u;
        } else {
            const u: std.math.Log2Int(u64) = @intCast(-shift);
            res[i] = a[i] >> u;
        }
    }
    return res;
}

test vshlq_u64 {
    const a = @as(types.u64x2, @splat(16));
    const b = @as(types.i64x2, @splat(1));
    const expected = @as(types.u64x2, @splat(32));
    try common.testIntrinsic(.{ .func = vshlq_u64, .expected = expected, .args = .{ a, b } });
}

/// Vector rounding shift by signed vector count
pub inline fn vrshl_s8(a: types.i8x8, b: types.i8x8) types.i8x8 {
    var res: types.i8x8 = undefined;
    const bits: i8 = 8;
    inline for (0..8) |i| {
        const shift = b[i];
        if (shift >= bits) {
            res[i] = 0;
        } else if (shift >= 0) {
            const u: std.math.Log2Int(i8) = @intCast(shift);
            res[i] = a[i] << u;
        } else if (shift <= -bits) {
            res[i] = 0;
        } else {
            const r_shift = -shift;
            const u: std.math.Log2Int(i8) = @intCast(r_shift);
            const round: i8 = @as(i8, 1) << (u - 1);
            res[i] = (a[i] +% round) >> u;
        }
    }
    return res;
}

test vrshl_s8 {
    const a = @as(types.i8x8, @splat(15));
    const b = @as(types.i8x8, @splat(-1));
    const expected = @as(types.i8x8, @splat(8));
    try common.testIntrinsic(.{ .func = vrshl_s8, .expected = expected, .args = .{ a, b } });
}

/// Vector rounding shift by signed vector count
pub inline fn vrshlq_s8(a: types.i8x16, b: types.i8x16) types.i8x16 {
    var res: types.i8x16 = undefined;
    const bits: i8 = 8;
    inline for (0..16) |i| {
        const shift = b[i];
        if (shift >= bits) {
            res[i] = 0;
        } else if (shift >= 0) {
            const u: std.math.Log2Int(i8) = @intCast(shift);
            res[i] = a[i] << u;
        } else if (shift <= -bits) {
            res[i] = 0;
        } else {
            const r_shift = -shift;
            const u: std.math.Log2Int(i8) = @intCast(r_shift);
            const round: i8 = @as(i8, 1) << (u - 1);
            res[i] = (a[i] +% round) >> u;
        }
    }
    return res;
}

test vrshlq_s8 {
    const a = @as(types.i8x16, @splat(15));
    const b = @as(types.i8x16, @splat(-1));
    const expected = @as(types.i8x16, @splat(8));
    try common.testIntrinsic(.{ .func = vrshlq_s8, .expected = expected, .args = .{ a, b } });
}

/// Vector rounding shift by signed vector count
pub inline fn vrshl_s16(a: types.i16x4, b: types.i16x4) types.i16x4 {
    var res: types.i16x4 = undefined;
    const bits: i16 = 16;
    inline for (0..4) |i| {
        const shift = b[i];
        if (shift >= bits) {
            res[i] = 0;
        } else if (shift >= 0) {
            const u: std.math.Log2Int(i16) = @intCast(shift);
            res[i] = a[i] << u;
        } else if (shift <= -bits) {
            res[i] = 0;
        } else {
            const r_shift = -shift;
            const u: std.math.Log2Int(i16) = @intCast(r_shift);
            const round: i16 = @as(i16, 1) << (u - 1);
            res[i] = (a[i] +% round) >> u;
        }
    }
    return res;
}

test vrshl_s16 {
    const a = @as(types.i16x4, @splat(15));
    const b = @as(types.i16x4, @splat(-1));
    const expected = @as(types.i16x4, @splat(8));
    try common.testIntrinsic(.{ .func = vrshl_s16, .expected = expected, .args = .{ a, b } });
}

/// Vector rounding shift by signed vector count
pub inline fn vrshlq_s16(a: types.i16x8, b: types.i16x8) types.i16x8 {
    var res: types.i16x8 = undefined;
    const bits: i16 = 16;
    inline for (0..8) |i| {
        const shift = b[i];
        if (shift >= bits) {
            res[i] = 0;
        } else if (shift >= 0) {
            const u: std.math.Log2Int(i16) = @intCast(shift);
            res[i] = a[i] << u;
        } else if (shift <= -bits) {
            res[i] = 0;
        } else {
            const r_shift = -shift;
            const u: std.math.Log2Int(i16) = @intCast(r_shift);
            const round: i16 = @as(i16, 1) << (u - 1);
            res[i] = (a[i] +% round) >> u;
        }
    }
    return res;
}

test vrshlq_s16 {
    const a = @as(types.i16x8, @splat(15));
    const b = @as(types.i16x8, @splat(-1));
    const expected = @as(types.i16x8, @splat(8));
    try common.testIntrinsic(.{ .func = vrshlq_s16, .expected = expected, .args = .{ a, b } });
}

/// Vector rounding shift by signed vector count
pub inline fn vrshl_s32(a: types.i32x2, b: types.i32x2) types.i32x2 {
    var res: types.i32x2 = undefined;
    const bits: i32 = 32;
    inline for (0..2) |i| {
        const shift = b[i];
        if (shift >= bits) {
            res[i] = 0;
        } else if (shift >= 0) {
            const u: std.math.Log2Int(i32) = @intCast(shift);
            res[i] = a[i] << u;
        } else if (shift <= -bits) {
            res[i] = 0;
        } else {
            const r_shift = -shift;
            const u: std.math.Log2Int(i32) = @intCast(r_shift);
            const round: i32 = @as(i32, 1) << (u - 1);
            res[i] = (a[i] +% round) >> u;
        }
    }
    return res;
}

test vrshl_s32 {
    const a = @as(types.i32x2, @splat(15));
    const b = @as(types.i32x2, @splat(-1));
    const expected = @as(types.i32x2, @splat(8));
    try common.testIntrinsic(.{ .func = vrshl_s32, .expected = expected, .args = .{ a, b } });
}

/// Vector rounding shift by signed vector count
pub inline fn vrshlq_s32(a: types.i32x4, b: types.i32x4) types.i32x4 {
    var res: types.i32x4 = undefined;
    const bits: i32 = 32;
    inline for (0..4) |i| {
        const shift = b[i];
        if (shift >= bits) {
            res[i] = 0;
        } else if (shift >= 0) {
            const u: std.math.Log2Int(i32) = @intCast(shift);
            res[i] = a[i] << u;
        } else if (shift <= -bits) {
            res[i] = 0;
        } else {
            const r_shift = -shift;
            const u: std.math.Log2Int(i32) = @intCast(r_shift);
            const round: i32 = @as(i32, 1) << (u - 1);
            res[i] = (a[i] +% round) >> u;
        }
    }
    return res;
}

test vrshlq_s32 {
    const a = @as(types.i32x4, @splat(15));
    const b = @as(types.i32x4, @splat(-1));
    const expected = @as(types.i32x4, @splat(8));
    try common.testIntrinsic(.{ .func = vrshlq_s32, .expected = expected, .args = .{ a, b } });
}

/// Vector rounding shift by signed vector count
pub inline fn vrshl_s64(a: types.i64x1, b: types.i64x1) types.i64x1 {
    var res: types.i64x1 = undefined;
    const bits: i64 = 64;
    inline for (0..1) |i| {
        const shift = b[i];
        if (shift >= bits) {
            res[i] = 0;
        } else if (shift >= 0) {
            const u: std.math.Log2Int(i64) = @intCast(shift);
            res[i] = a[i] << u;
        } else if (shift <= -bits) {
            res[i] = 0;
        } else {
            const r_shift = -shift;
            const u: std.math.Log2Int(i64) = @intCast(r_shift);
            const round: i64 = @as(i64, 1) << (u - 1);
            res[i] = (a[i] +% round) >> u;
        }
    }
    return res;
}

test vrshl_s64 {
    const a = @as(types.i64x1, @splat(15));
    const b = @as(types.i64x1, @splat(-1));
    const expected = @as(types.i64x1, @splat(8));
    try common.testIntrinsic(.{ .func = vrshl_s64, .expected = expected, .args = .{ a, b } });
}

/// Vector rounding shift by signed vector count
pub inline fn vrshlq_s64(a: types.i64x2, b: types.i64x2) types.i64x2 {
    var res: types.i64x2 = undefined;
    const bits: i64 = 64;
    inline for (0..2) |i| {
        const shift = b[i];
        if (shift >= bits) {
            res[i] = 0;
        } else if (shift >= 0) {
            const u: std.math.Log2Int(i64) = @intCast(shift);
            res[i] = a[i] << u;
        } else if (shift <= -bits) {
            res[i] = 0;
        } else {
            const r_shift = -shift;
            const u: std.math.Log2Int(i64) = @intCast(r_shift);
            const round: i64 = @as(i64, 1) << (u - 1);
            res[i] = (a[i] +% round) >> u;
        }
    }
    return res;
}

test vrshlq_s64 {
    const a = @as(types.i64x2, @splat(15));
    const b = @as(types.i64x2, @splat(-1));
    const expected = @as(types.i64x2, @splat(8));
    try common.testIntrinsic(.{ .func = vrshlq_s64, .expected = expected, .args = .{ a, b } });
}

/// Vector rounding shift by signed vector count
pub inline fn vrshl_u8(a: types.u8x8, b: types.i8x8) types.u8x8 {
    var res: types.u8x8 = undefined;
    const bits: i8 = 8;
    inline for (0..8) |i| {
        const shift = b[i];
        if (shift >= bits) {
            res[i] = 0;
        } else if (shift >= 0) {
            const u: std.math.Log2Int(u8) = @intCast(shift);
            res[i] = a[i] << u;
        } else if (shift <= -bits) {
            res[i] = 0;
        } else {
            const r_shift = -shift;
            const u: std.math.Log2Int(u8) = @intCast(r_shift);
            const round: u8 = @as(u8, 1) << (u - 1);
            res[i] = (a[i] +% round) >> u;
        }
    }
    return res;
}

test vrshl_u8 {
    const a = @as(types.u8x8, @splat(15));
    const b = @as(types.i8x8, @splat(-1));
    const expected = @as(types.u8x8, @splat(8));
    try common.testIntrinsic(.{ .func = vrshl_u8, .expected = expected, .args = .{ a, b } });
}

/// Vector rounding shift by signed vector count
pub inline fn vrshlq_u8(a: types.u8x16, b: types.i8x16) types.u8x16 {
    var res: types.u8x16 = undefined;
    const bits: i8 = 8;
    inline for (0..16) |i| {
        const shift = b[i];
        if (shift >= bits) {
            res[i] = 0;
        } else if (shift >= 0) {
            const u: std.math.Log2Int(u8) = @intCast(shift);
            res[i] = a[i] << u;
        } else if (shift <= -bits) {
            res[i] = 0;
        } else {
            const r_shift = -shift;
            const u: std.math.Log2Int(u8) = @intCast(r_shift);
            const round: u8 = @as(u8, 1) << (u - 1);
            res[i] = (a[i] +% round) >> u;
        }
    }
    return res;
}

test vrshlq_u8 {
    const a = @as(types.u8x16, @splat(15));
    const b = @as(types.i8x16, @splat(-1));
    const expected = @as(types.u8x16, @splat(8));
    try common.testIntrinsic(.{ .func = vrshlq_u8, .expected = expected, .args = .{ a, b } });
}

/// Vector rounding shift by signed vector count
pub inline fn vrshl_u16(a: types.u16x4, b: types.i16x4) types.u16x4 {
    var res: types.u16x4 = undefined;
    const bits: i16 = 16;
    inline for (0..4) |i| {
        const shift = b[i];
        if (shift >= bits) {
            res[i] = 0;
        } else if (shift >= 0) {
            const u: std.math.Log2Int(u16) = @intCast(shift);
            res[i] = a[i] << u;
        } else if (shift <= -bits) {
            res[i] = 0;
        } else {
            const r_shift = -shift;
            const u: std.math.Log2Int(u16) = @intCast(r_shift);
            const round: u16 = @as(u16, 1) << (u - 1);
            res[i] = (a[i] +% round) >> u;
        }
    }
    return res;
}

test vrshl_u16 {
    const a = @as(types.u16x4, @splat(15));
    const b = @as(types.i16x4, @splat(-1));
    const expected = @as(types.u16x4, @splat(8));
    try common.testIntrinsic(.{ .func = vrshl_u16, .expected = expected, .args = .{ a, b } });
}

/// Vector rounding shift by signed vector count
pub inline fn vrshlq_u16(a: types.u16x8, b: types.i16x8) types.u16x8 {
    var res: types.u16x8 = undefined;
    const bits: i16 = 16;
    inline for (0..8) |i| {
        const shift = b[i];
        if (shift >= bits) {
            res[i] = 0;
        } else if (shift >= 0) {
            const u: std.math.Log2Int(u16) = @intCast(shift);
            res[i] = a[i] << u;
        } else if (shift <= -bits) {
            res[i] = 0;
        } else {
            const r_shift = -shift;
            const u: std.math.Log2Int(u16) = @intCast(r_shift);
            const round: u16 = @as(u16, 1) << (u - 1);
            res[i] = (a[i] +% round) >> u;
        }
    }
    return res;
}

test vrshlq_u16 {
    const a = @as(types.u16x8, @splat(15));
    const b = @as(types.i16x8, @splat(-1));
    const expected = @as(types.u16x8, @splat(8));
    try common.testIntrinsic(.{ .func = vrshlq_u16, .expected = expected, .args = .{ a, b } });
}

/// Vector rounding shift by signed vector count
pub inline fn vrshl_u32(a: types.u32x2, b: types.i32x2) types.u32x2 {
    var res: types.u32x2 = undefined;
    const bits: i32 = 32;
    inline for (0..2) |i| {
        const shift = b[i];
        if (shift >= bits) {
            res[i] = 0;
        } else if (shift >= 0) {
            const u: std.math.Log2Int(u32) = @intCast(shift);
            res[i] = a[i] << u;
        } else if (shift <= -bits) {
            res[i] = 0;
        } else {
            const r_shift = -shift;
            const u: std.math.Log2Int(u32) = @intCast(r_shift);
            const round: u32 = @as(u32, 1) << (u - 1);
            res[i] = (a[i] +% round) >> u;
        }
    }
    return res;
}

test vrshl_u32 {
    const a = @as(types.u32x2, @splat(15));
    const b = @as(types.i32x2, @splat(-1));
    const expected = @as(types.u32x2, @splat(8));
    try common.testIntrinsic(.{ .func = vrshl_u32, .expected = expected, .args = .{ a, b } });
}

/// Vector rounding shift by signed vector count
pub inline fn vrshlq_u32(a: types.u32x4, b: types.i32x4) types.u32x4 {
    var res: types.u32x4 = undefined;
    const bits: i32 = 32;
    inline for (0..4) |i| {
        const shift = b[i];
        if (shift >= bits) {
            res[i] = 0;
        } else if (shift >= 0) {
            const u: std.math.Log2Int(u32) = @intCast(shift);
            res[i] = a[i] << u;
        } else if (shift <= -bits) {
            res[i] = 0;
        } else {
            const r_shift = -shift;
            const u: std.math.Log2Int(u32) = @intCast(r_shift);
            const round: u32 = @as(u32, 1) << (u - 1);
            res[i] = (a[i] +% round) >> u;
        }
    }
    return res;
}

test vrshlq_u32 {
    const a = @as(types.u32x4, @splat(15));
    const b = @as(types.i32x4, @splat(-1));
    const expected = @as(types.u32x4, @splat(8));
    try common.testIntrinsic(.{ .func = vrshlq_u32, .expected = expected, .args = .{ a, b } });
}

/// Vector rounding shift by signed vector count
pub inline fn vrshl_u64(a: types.u64x1, b: types.i64x1) types.u64x1 {
    var res: types.u64x1 = undefined;
    const bits: i64 = 64;
    inline for (0..1) |i| {
        const shift = b[i];
        if (shift >= bits) {
            res[i] = 0;
        } else if (shift >= 0) {
            const u: std.math.Log2Int(u64) = @intCast(shift);
            res[i] = a[i] << u;
        } else if (shift <= -bits) {
            res[i] = 0;
        } else {
            const r_shift = -shift;
            const u: std.math.Log2Int(u64) = @intCast(r_shift);
            const round: u64 = @as(u64, 1) << (u - 1);
            res[i] = (a[i] +% round) >> u;
        }
    }
    return res;
}

test vrshl_u64 {
    const a = @as(types.u64x1, @splat(15));
    const b = @as(types.i64x1, @splat(-1));
    const expected = @as(types.u64x1, @splat(8));
    try common.testIntrinsic(.{ .func = vrshl_u64, .expected = expected, .args = .{ a, b } });
}

/// Vector rounding shift by signed vector count
pub inline fn vrshlq_u64(a: types.u64x2, b: types.i64x2) types.u64x2 {
    var res: types.u64x2 = undefined;
    const bits: i64 = 64;
    inline for (0..2) |i| {
        const shift = b[i];
        if (shift >= bits) {
            res[i] = 0;
        } else if (shift >= 0) {
            const u: std.math.Log2Int(u64) = @intCast(shift);
            res[i] = a[i] << u;
        } else if (shift <= -bits) {
            res[i] = 0;
        } else {
            const r_shift = -shift;
            const u: std.math.Log2Int(u64) = @intCast(r_shift);
            const round: u64 = @as(u64, 1) << (u - 1);
            res[i] = (a[i] +% round) >> u;
        }
    }
    return res;
}

test vrshlq_u64 {
    const a = @as(types.u64x2, @splat(15));
    const b = @as(types.i64x2, @splat(-1));
    const expected = @as(types.u64x2, @splat(8));
    try common.testIntrinsic(.{ .func = vrshlq_u64, .expected = expected, .args = .{ a, b } });
}

/// Vector saturating shift by signed vector count
pub inline fn vqshl_s8(a: types.i8x8, b: types.i8x8) types.i8x8 {
    var res: types.i8x8 = undefined;
    const bits: i8 = 8;
    inline for (0..8) |i| {
        const shift = b[i];
        if (shift >= bits) {
            res[i] = if (a[i] < 0) std.math.minInt(i8) else std.math.maxInt(i8);
        } else if (shift >= 0) {
            const wide = @as(i16, a[i]) << @intCast(shift);
            res[i] = @intCast(std.math.clamp(wide, std.math.minInt(i8), std.math.maxInt(i8)));
        } else if (shift <= -bits) {
            res[i] = if (a[i] < 0) -1 else 0;
        } else {
            const u: std.math.Log2Int(i8) = @intCast(-shift);
            res[i] = a[i] >> u;
        }
    }
    return res;
}

test vqshl_s8 {
    const a = @as(types.i8x8, @splat(16));
    const b = @as(types.i8x8, @splat(1));
    const expected = @as(types.i8x8, @splat(32));
    try common.testIntrinsic(.{ .func = vqshl_s8, .expected = expected, .args = .{ a, b } });
}

/// Vector saturating shift by signed vector count
pub inline fn vqshlq_s8(a: types.i8x16, b: types.i8x16) types.i8x16 {
    var res: types.i8x16 = undefined;
    const bits: i8 = 8;
    inline for (0..16) |i| {
        const shift = b[i];
        if (shift >= bits) {
            res[i] = if (a[i] < 0) std.math.minInt(i8) else std.math.maxInt(i8);
        } else if (shift >= 0) {
            const wide = @as(i16, a[i]) << @intCast(shift);
            res[i] = @intCast(std.math.clamp(wide, std.math.minInt(i8), std.math.maxInt(i8)));
        } else if (shift <= -bits) {
            res[i] = if (a[i] < 0) -1 else 0;
        } else {
            const u: std.math.Log2Int(i8) = @intCast(-shift);
            res[i] = a[i] >> u;
        }
    }
    return res;
}

test vqshlq_s8 {
    const a = @as(types.i8x16, @splat(16));
    const b = @as(types.i8x16, @splat(1));
    const expected = @as(types.i8x16, @splat(32));
    try common.testIntrinsic(.{ .func = vqshlq_s8, .expected = expected, .args = .{ a, b } });
}

/// Vector saturating shift by signed vector count
pub inline fn vqshl_s16(a: types.i16x4, b: types.i16x4) types.i16x4 {
    var res: types.i16x4 = undefined;
    const bits: i16 = 16;
    inline for (0..4) |i| {
        const shift = b[i];
        if (shift >= bits) {
            res[i] = if (a[i] < 0) std.math.minInt(i16) else std.math.maxInt(i16);
        } else if (shift >= 0) {
            const wide = @as(i32, a[i]) << @intCast(shift);
            res[i] = @intCast(std.math.clamp(wide, std.math.minInt(i16), std.math.maxInt(i16)));
        } else if (shift <= -bits) {
            res[i] = if (a[i] < 0) -1 else 0;
        } else {
            const u: std.math.Log2Int(i16) = @intCast(-shift);
            res[i] = a[i] >> u;
        }
    }
    return res;
}

test vqshl_s16 {
    const a = @as(types.i16x4, @splat(16));
    const b = @as(types.i16x4, @splat(1));
    const expected = @as(types.i16x4, @splat(32));
    try common.testIntrinsic(.{ .func = vqshl_s16, .expected = expected, .args = .{ a, b } });
}

/// Vector saturating shift by signed vector count
pub inline fn vqshlq_s16(a: types.i16x8, b: types.i16x8) types.i16x8 {
    var res: types.i16x8 = undefined;
    const bits: i16 = 16;
    inline for (0..8) |i| {
        const shift = b[i];
        if (shift >= bits) {
            res[i] = if (a[i] < 0) std.math.minInt(i16) else std.math.maxInt(i16);
        } else if (shift >= 0) {
            const wide = @as(i32, a[i]) << @intCast(shift);
            res[i] = @intCast(std.math.clamp(wide, std.math.minInt(i16), std.math.maxInt(i16)));
        } else if (shift <= -bits) {
            res[i] = if (a[i] < 0) -1 else 0;
        } else {
            const u: std.math.Log2Int(i16) = @intCast(-shift);
            res[i] = a[i] >> u;
        }
    }
    return res;
}

test vqshlq_s16 {
    const a = @as(types.i16x8, @splat(16));
    const b = @as(types.i16x8, @splat(1));
    const expected = @as(types.i16x8, @splat(32));
    try common.testIntrinsic(.{ .func = vqshlq_s16, .expected = expected, .args = .{ a, b } });
}

/// Vector saturating shift by signed vector count
pub inline fn vqshl_s32(a: types.i32x2, b: types.i32x2) types.i32x2 {
    var res: types.i32x2 = undefined;
    const bits: i32 = 32;
    inline for (0..2) |i| {
        const shift = b[i];
        if (shift >= bits) {
            res[i] = if (a[i] < 0) std.math.minInt(i32) else std.math.maxInt(i32);
        } else if (shift >= 0) {
            const wide = @as(i64, a[i]) << @intCast(shift);
            res[i] = @intCast(std.math.clamp(wide, std.math.minInt(i32), std.math.maxInt(i32)));
        } else if (shift <= -bits) {
            res[i] = if (a[i] < 0) -1 else 0;
        } else {
            const u: std.math.Log2Int(i32) = @intCast(-shift);
            res[i] = a[i] >> u;
        }
    }
    return res;
}

test vqshl_s32 {
    const a = @as(types.i32x2, @splat(16));
    const b = @as(types.i32x2, @splat(1));
    const expected = @as(types.i32x2, @splat(32));
    try common.testIntrinsic(.{ .func = vqshl_s32, .expected = expected, .args = .{ a, b } });
}

/// Vector saturating shift by signed vector count
pub inline fn vqshlq_s32(a: types.i32x4, b: types.i32x4) types.i32x4 {
    var res: types.i32x4 = undefined;
    const bits: i32 = 32;
    inline for (0..4) |i| {
        const shift = b[i];
        if (shift >= bits) {
            res[i] = if (a[i] < 0) std.math.minInt(i32) else std.math.maxInt(i32);
        } else if (shift >= 0) {
            const wide = @as(i64, a[i]) << @intCast(shift);
            res[i] = @intCast(std.math.clamp(wide, std.math.minInt(i32), std.math.maxInt(i32)));
        } else if (shift <= -bits) {
            res[i] = if (a[i] < 0) -1 else 0;
        } else {
            const u: std.math.Log2Int(i32) = @intCast(-shift);
            res[i] = a[i] >> u;
        }
    }
    return res;
}

test vqshlq_s32 {
    const a = @as(types.i32x4, @splat(16));
    const b = @as(types.i32x4, @splat(1));
    const expected = @as(types.i32x4, @splat(32));
    try common.testIntrinsic(.{ .func = vqshlq_s32, .expected = expected, .args = .{ a, b } });
}

/// Vector saturating shift by signed vector count
pub inline fn vqshl_s64(a: types.i64x1, b: types.i64x1) types.i64x1 {
    var res: types.i64x1 = undefined;
    const bits: i64 = 64;
    inline for (0..1) |i| {
        const shift = b[i];
        if (shift >= bits) {
            res[i] = if (a[i] < 0) std.math.minInt(i64) else std.math.maxInt(i64);
        } else if (shift >= 0) {
            const wide = @as(i128, a[i]) << @intCast(shift);
            res[i] = @intCast(std.math.clamp(wide, std.math.minInt(i64), std.math.maxInt(i64)));
        } else if (shift <= -bits) {
            res[i] = if (a[i] < 0) -1 else 0;
        } else {
            const u: std.math.Log2Int(i64) = @intCast(-shift);
            res[i] = a[i] >> u;
        }
    }
    return res;
}

test vqshl_s64 {
    const a = @as(types.i64x1, @splat(16));
    const b = @as(types.i64x1, @splat(1));
    const expected = @as(types.i64x1, @splat(32));
    try common.testIntrinsic(.{ .func = vqshl_s64, .expected = expected, .args = .{ a, b } });
}

/// Vector saturating shift by signed vector count
pub inline fn vqshlq_s64(a: types.i64x2, b: types.i64x2) types.i64x2 {
    var res: types.i64x2 = undefined;
    const bits: i64 = 64;
    inline for (0..2) |i| {
        const shift = b[i];
        if (shift >= bits) {
            res[i] = if (a[i] < 0) std.math.minInt(i64) else std.math.maxInt(i64);
        } else if (shift >= 0) {
            const wide = @as(i128, a[i]) << @intCast(shift);
            res[i] = @intCast(std.math.clamp(wide, std.math.minInt(i64), std.math.maxInt(i64)));
        } else if (shift <= -bits) {
            res[i] = if (a[i] < 0) -1 else 0;
        } else {
            const u: std.math.Log2Int(i64) = @intCast(-shift);
            res[i] = a[i] >> u;
        }
    }
    return res;
}

test vqshlq_s64 {
    const a = @as(types.i64x2, @splat(16));
    const b = @as(types.i64x2, @splat(1));
    const expected = @as(types.i64x2, @splat(32));
    try common.testIntrinsic(.{ .func = vqshlq_s64, .expected = expected, .args = .{ a, b } });
}

/// Vector saturating shift by signed vector count
pub inline fn vqshl_u8(a: types.u8x8, b: types.i8x8) types.u8x8 {
    var res: types.u8x8 = undefined;
    const bits: i8 = 8;
    inline for (0..8) |i| {
        const shift = b[i];
        if (shift >= bits) {
            res[i] = if (a[i] > 0) std.math.maxInt(u8) else 0;
        } else if (shift >= 0) {
            const wide = @as(u16, a[i]) << @intCast(shift);
            res[i] = @intCast(std.math.clamp(wide, std.math.minInt(u8), std.math.maxInt(u8)));
        } else if (shift <= -bits) {
            res[i] = 0;
        } else {
            const u: std.math.Log2Int(u8) = @intCast(-shift);
            res[i] = a[i] >> u;
        }
    }
    return res;
}

test vqshl_u8 {
    const a = @as(types.u8x8, @splat(16));
    const b = @as(types.i8x8, @splat(1));
    const expected = @as(types.u8x8, @splat(32));
    try common.testIntrinsic(.{ .func = vqshl_u8, .expected = expected, .args = .{ a, b } });
}

/// Vector saturating shift by signed vector count
pub inline fn vqshlq_u8(a: types.u8x16, b: types.i8x16) types.u8x16 {
    var res: types.u8x16 = undefined;
    const bits: i8 = 8;
    inline for (0..16) |i| {
        const shift = b[i];
        if (shift >= bits) {
            res[i] = if (a[i] > 0) std.math.maxInt(u8) else 0;
        } else if (shift >= 0) {
            const wide = @as(u16, a[i]) << @intCast(shift);
            res[i] = @intCast(std.math.clamp(wide, std.math.minInt(u8), std.math.maxInt(u8)));
        } else if (shift <= -bits) {
            res[i] = 0;
        } else {
            const u: std.math.Log2Int(u8) = @intCast(-shift);
            res[i] = a[i] >> u;
        }
    }
    return res;
}

test vqshlq_u8 {
    const a = @as(types.u8x16, @splat(16));
    const b = @as(types.i8x16, @splat(1));
    const expected = @as(types.u8x16, @splat(32));
    try common.testIntrinsic(.{ .func = vqshlq_u8, .expected = expected, .args = .{ a, b } });
}

/// Vector saturating shift by signed vector count
pub inline fn vqshl_u16(a: types.u16x4, b: types.i16x4) types.u16x4 {
    var res: types.u16x4 = undefined;
    const bits: i16 = 16;
    inline for (0..4) |i| {
        const shift = b[i];
        if (shift >= bits) {
            res[i] = if (a[i] > 0) std.math.maxInt(u16) else 0;
        } else if (shift >= 0) {
            const wide = @as(u32, a[i]) << @intCast(shift);
            res[i] = @intCast(std.math.clamp(wide, std.math.minInt(u16), std.math.maxInt(u16)));
        } else if (shift <= -bits) {
            res[i] = 0;
        } else {
            const u: std.math.Log2Int(u16) = @intCast(-shift);
            res[i] = a[i] >> u;
        }
    }
    return res;
}

test vqshl_u16 {
    const a = @as(types.u16x4, @splat(16));
    const b = @as(types.i16x4, @splat(1));
    const expected = @as(types.u16x4, @splat(32));
    try common.testIntrinsic(.{ .func = vqshl_u16, .expected = expected, .args = .{ a, b } });
}

/// Vector saturating shift by signed vector count
pub inline fn vqshlq_u16(a: types.u16x8, b: types.i16x8) types.u16x8 {
    var res: types.u16x8 = undefined;
    const bits: i16 = 16;
    inline for (0..8) |i| {
        const shift = b[i];
        if (shift >= bits) {
            res[i] = if (a[i] > 0) std.math.maxInt(u16) else 0;
        } else if (shift >= 0) {
            const wide = @as(u32, a[i]) << @intCast(shift);
            res[i] = @intCast(std.math.clamp(wide, std.math.minInt(u16), std.math.maxInt(u16)));
        } else if (shift <= -bits) {
            res[i] = 0;
        } else {
            const u: std.math.Log2Int(u16) = @intCast(-shift);
            res[i] = a[i] >> u;
        }
    }
    return res;
}

test vqshlq_u16 {
    const a = @as(types.u16x8, @splat(16));
    const b = @as(types.i16x8, @splat(1));
    const expected = @as(types.u16x8, @splat(32));
    try common.testIntrinsic(.{ .func = vqshlq_u16, .expected = expected, .args = .{ a, b } });
}

/// Vector saturating shift by signed vector count
pub inline fn vqshl_u32(a: types.u32x2, b: types.i32x2) types.u32x2 {
    var res: types.u32x2 = undefined;
    const bits: i32 = 32;
    inline for (0..2) |i| {
        const shift = b[i];
        if (shift >= bits) {
            res[i] = if (a[i] > 0) std.math.maxInt(u32) else 0;
        } else if (shift >= 0) {
            const wide = @as(u64, a[i]) << @intCast(shift);
            res[i] = @intCast(std.math.clamp(wide, std.math.minInt(u32), std.math.maxInt(u32)));
        } else if (shift <= -bits) {
            res[i] = 0;
        } else {
            const u: std.math.Log2Int(u32) = @intCast(-shift);
            res[i] = a[i] >> u;
        }
    }
    return res;
}

test vqshl_u32 {
    const a = @as(types.u32x2, @splat(16));
    const b = @as(types.i32x2, @splat(1));
    const expected = @as(types.u32x2, @splat(32));
    try common.testIntrinsic(.{ .func = vqshl_u32, .expected = expected, .args = .{ a, b } });
}

/// Vector saturating shift by signed vector count
pub inline fn vqshlq_u32(a: types.u32x4, b: types.i32x4) types.u32x4 {
    var res: types.u32x4 = undefined;
    const bits: i32 = 32;
    inline for (0..4) |i| {
        const shift = b[i];
        if (shift >= bits) {
            res[i] = if (a[i] > 0) std.math.maxInt(u32) else 0;
        } else if (shift >= 0) {
            const wide = @as(u64, a[i]) << @intCast(shift);
            res[i] = @intCast(std.math.clamp(wide, std.math.minInt(u32), std.math.maxInt(u32)));
        } else if (shift <= -bits) {
            res[i] = 0;
        } else {
            const u: std.math.Log2Int(u32) = @intCast(-shift);
            res[i] = a[i] >> u;
        }
    }
    return res;
}

test vqshlq_u32 {
    const a = @as(types.u32x4, @splat(16));
    const b = @as(types.i32x4, @splat(1));
    const expected = @as(types.u32x4, @splat(32));
    try common.testIntrinsic(.{ .func = vqshlq_u32, .expected = expected, .args = .{ a, b } });
}

/// Vector saturating shift by signed vector count
pub inline fn vqshl_u64(a: types.u64x1, b: types.i64x1) types.u64x1 {
    var res: types.u64x1 = undefined;
    const bits: i64 = 64;
    inline for (0..1) |i| {
        const shift = b[i];
        if (shift >= bits) {
            res[i] = if (a[i] > 0) std.math.maxInt(u64) else 0;
        } else if (shift >= 0) {
            const wide = @as(u128, a[i]) << @intCast(shift);
            res[i] = @intCast(std.math.clamp(wide, std.math.minInt(u64), std.math.maxInt(u64)));
        } else if (shift <= -bits) {
            res[i] = 0;
        } else {
            const u: std.math.Log2Int(u64) = @intCast(-shift);
            res[i] = a[i] >> u;
        }
    }
    return res;
}

test vqshl_u64 {
    const a = @as(types.u64x1, @splat(16));
    const b = @as(types.i64x1, @splat(1));
    const expected = @as(types.u64x1, @splat(32));
    try common.testIntrinsic(.{ .func = vqshl_u64, .expected = expected, .args = .{ a, b } });
}

/// Vector saturating shift by signed vector count
pub inline fn vqshlq_u64(a: types.u64x2, b: types.i64x2) types.u64x2 {
    var res: types.u64x2 = undefined;
    const bits: i64 = 64;
    inline for (0..2) |i| {
        const shift = b[i];
        if (shift >= bits) {
            res[i] = if (a[i] > 0) std.math.maxInt(u64) else 0;
        } else if (shift >= 0) {
            const wide = @as(u128, a[i]) << @intCast(shift);
            res[i] = @intCast(std.math.clamp(wide, std.math.minInt(u64), std.math.maxInt(u64)));
        } else if (shift <= -bits) {
            res[i] = 0;
        } else {
            const u: std.math.Log2Int(u64) = @intCast(-shift);
            res[i] = a[i] >> u;
        }
    }
    return res;
}

test vqshlq_u64 {
    const a = @as(types.u64x2, @splat(16));
    const b = @as(types.i64x2, @splat(1));
    const expected = @as(types.u64x2, @splat(32));
    try common.testIntrinsic(.{ .func = vqshlq_u64, .expected = expected, .args = .{ a, b } });
}

/// Vector rounding saturating shift by signed vector count
pub inline fn vqrshl_s8(a: types.i8x8, b: types.i8x8) types.i8x8 {
    var res: types.i8x8 = undefined;
    const bits: i8 = 8;
    inline for (0..8) |i| {
        const shift = b[i];
        if (shift >= bits) {
            res[i] = if (a[i] < 0) std.math.minInt(i8) else std.math.maxInt(i8);
        } else if (shift >= 0) {
            const wide = @as(i16, a[i]) << @intCast(shift);
            res[i] = @intCast(std.math.clamp(wide, std.math.minInt(i8), std.math.maxInt(i8)));
        } else if (shift <= -bits) {
            res[i] = 0;
        } else {
            const r_shift = -shift;
            const u: std.math.Log2Int(i8) = @intCast(r_shift);
            const round: i8 = @as(i8, 1) << (u - 1);
            res[i] = (a[i] +% round) >> u;
        }
    }
    return res;
}

test vqrshl_s8 {
    const a = @as(types.i8x8, @splat(15));
    const b = @as(types.i8x8, @splat(-1));
    const expected = @as(types.i8x8, @splat(8));
    try common.testIntrinsic(.{ .func = vqrshl_s8, .expected = expected, .args = .{ a, b } });
}

/// Vector rounding saturating shift by signed vector count
pub inline fn vqrshlq_s8(a: types.i8x16, b: types.i8x16) types.i8x16 {
    var res: types.i8x16 = undefined;
    const bits: i8 = 8;
    inline for (0..16) |i| {
        const shift = b[i];
        if (shift >= bits) {
            res[i] = if (a[i] < 0) std.math.minInt(i8) else std.math.maxInt(i8);
        } else if (shift >= 0) {
            const wide = @as(i16, a[i]) << @intCast(shift);
            res[i] = @intCast(std.math.clamp(wide, std.math.minInt(i8), std.math.maxInt(i8)));
        } else if (shift <= -bits) {
            res[i] = 0;
        } else {
            const r_shift = -shift;
            const u: std.math.Log2Int(i8) = @intCast(r_shift);
            const round: i8 = @as(i8, 1) << (u - 1);
            res[i] = (a[i] +% round) >> u;
        }
    }
    return res;
}

test vqrshlq_s8 {
    const a = @as(types.i8x16, @splat(15));
    const b = @as(types.i8x16, @splat(-1));
    const expected = @as(types.i8x16, @splat(8));
    try common.testIntrinsic(.{ .func = vqrshlq_s8, .expected = expected, .args = .{ a, b } });
}

/// Vector rounding saturating shift by signed vector count
pub inline fn vqrshl_s16(a: types.i16x4, b: types.i16x4) types.i16x4 {
    var res: types.i16x4 = undefined;
    const bits: i16 = 16;
    inline for (0..4) |i| {
        const shift = b[i];
        if (shift >= bits) {
            res[i] = if (a[i] < 0) std.math.minInt(i16) else std.math.maxInt(i16);
        } else if (shift >= 0) {
            const wide = @as(i32, a[i]) << @intCast(shift);
            res[i] = @intCast(std.math.clamp(wide, std.math.minInt(i16), std.math.maxInt(i16)));
        } else if (shift <= -bits) {
            res[i] = 0;
        } else {
            const r_shift = -shift;
            const u: std.math.Log2Int(i16) = @intCast(r_shift);
            const round: i16 = @as(i16, 1) << (u - 1);
            res[i] = (a[i] +% round) >> u;
        }
    }
    return res;
}

test vqrshl_s16 {
    const a = @as(types.i16x4, @splat(15));
    const b = @as(types.i16x4, @splat(-1));
    const expected = @as(types.i16x4, @splat(8));
    try common.testIntrinsic(.{ .func = vqrshl_s16, .expected = expected, .args = .{ a, b } });
}

/// Vector rounding saturating shift by signed vector count
pub inline fn vqrshlq_s16(a: types.i16x8, b: types.i16x8) types.i16x8 {
    var res: types.i16x8 = undefined;
    const bits: i16 = 16;
    inline for (0..8) |i| {
        const shift = b[i];
        if (shift >= bits) {
            res[i] = if (a[i] < 0) std.math.minInt(i16) else std.math.maxInt(i16);
        } else if (shift >= 0) {
            const wide = @as(i32, a[i]) << @intCast(shift);
            res[i] = @intCast(std.math.clamp(wide, std.math.minInt(i16), std.math.maxInt(i16)));
        } else if (shift <= -bits) {
            res[i] = 0;
        } else {
            const r_shift = -shift;
            const u: std.math.Log2Int(i16) = @intCast(r_shift);
            const round: i16 = @as(i16, 1) << (u - 1);
            res[i] = (a[i] +% round) >> u;
        }
    }
    return res;
}

test vqrshlq_s16 {
    const a = @as(types.i16x8, @splat(15));
    const b = @as(types.i16x8, @splat(-1));
    const expected = @as(types.i16x8, @splat(8));
    try common.testIntrinsic(.{ .func = vqrshlq_s16, .expected = expected, .args = .{ a, b } });
}

/// Vector rounding saturating shift by signed vector count
pub inline fn vqrshl_s32(a: types.i32x2, b: types.i32x2) types.i32x2 {
    var res: types.i32x2 = undefined;
    const bits: i32 = 32;
    inline for (0..2) |i| {
        const shift = b[i];
        if (shift >= bits) {
            res[i] = if (a[i] < 0) std.math.minInt(i32) else std.math.maxInt(i32);
        } else if (shift >= 0) {
            const wide = @as(i64, a[i]) << @intCast(shift);
            res[i] = @intCast(std.math.clamp(wide, std.math.minInt(i32), std.math.maxInt(i32)));
        } else if (shift <= -bits) {
            res[i] = 0;
        } else {
            const r_shift = -shift;
            const u: std.math.Log2Int(i32) = @intCast(r_shift);
            const round: i32 = @as(i32, 1) << (u - 1);
            res[i] = (a[i] +% round) >> u;
        }
    }
    return res;
}

test vqrshl_s32 {
    const a = @as(types.i32x2, @splat(15));
    const b = @as(types.i32x2, @splat(-1));
    const expected = @as(types.i32x2, @splat(8));
    try common.testIntrinsic(.{ .func = vqrshl_s32, .expected = expected, .args = .{ a, b } });
}

/// Vector rounding saturating shift by signed vector count
pub inline fn vqrshlq_s32(a: types.i32x4, b: types.i32x4) types.i32x4 {
    var res: types.i32x4 = undefined;
    const bits: i32 = 32;
    inline for (0..4) |i| {
        const shift = b[i];
        if (shift >= bits) {
            res[i] = if (a[i] < 0) std.math.minInt(i32) else std.math.maxInt(i32);
        } else if (shift >= 0) {
            const wide = @as(i64, a[i]) << @intCast(shift);
            res[i] = @intCast(std.math.clamp(wide, std.math.minInt(i32), std.math.maxInt(i32)));
        } else if (shift <= -bits) {
            res[i] = 0;
        } else {
            const r_shift = -shift;
            const u: std.math.Log2Int(i32) = @intCast(r_shift);
            const round: i32 = @as(i32, 1) << (u - 1);
            res[i] = (a[i] +% round) >> u;
        }
    }
    return res;
}

test vqrshlq_s32 {
    const a = @as(types.i32x4, @splat(15));
    const b = @as(types.i32x4, @splat(-1));
    const expected = @as(types.i32x4, @splat(8));
    try common.testIntrinsic(.{ .func = vqrshlq_s32, .expected = expected, .args = .{ a, b } });
}

/// Vector rounding saturating shift by signed vector count
pub inline fn vqrshl_s64(a: types.i64x1, b: types.i64x1) types.i64x1 {
    var res: types.i64x1 = undefined;
    const bits: i64 = 64;
    inline for (0..1) |i| {
        const shift = b[i];
        if (shift >= bits) {
            res[i] = if (a[i] < 0) std.math.minInt(i64) else std.math.maxInt(i64);
        } else if (shift >= 0) {
            const wide = @as(i128, a[i]) << @intCast(shift);
            res[i] = @intCast(std.math.clamp(wide, std.math.minInt(i64), std.math.maxInt(i64)));
        } else if (shift <= -bits) {
            res[i] = 0;
        } else {
            const r_shift = -shift;
            const u: std.math.Log2Int(i64) = @intCast(r_shift);
            const round: i64 = @as(i64, 1) << (u - 1);
            res[i] = (a[i] +% round) >> u;
        }
    }
    return res;
}

test vqrshl_s64 {
    const a = @as(types.i64x1, @splat(15));
    const b = @as(types.i64x1, @splat(-1));
    const expected = @as(types.i64x1, @splat(8));
    try common.testIntrinsic(.{ .func = vqrshl_s64, .expected = expected, .args = .{ a, b } });
}

/// Vector rounding saturating shift by signed vector count
pub inline fn vqrshlq_s64(a: types.i64x2, b: types.i64x2) types.i64x2 {
    var res: types.i64x2 = undefined;
    const bits: i64 = 64;
    inline for (0..2) |i| {
        const shift = b[i];
        if (shift >= bits) {
            res[i] = if (a[i] < 0) std.math.minInt(i64) else std.math.maxInt(i64);
        } else if (shift >= 0) {
            const wide = @as(i128, a[i]) << @intCast(shift);
            res[i] = @intCast(std.math.clamp(wide, std.math.minInt(i64), std.math.maxInt(i64)));
        } else if (shift <= -bits) {
            res[i] = 0;
        } else {
            const r_shift = -shift;
            const u: std.math.Log2Int(i64) = @intCast(r_shift);
            const round: i64 = @as(i64, 1) << (u - 1);
            res[i] = (a[i] +% round) >> u;
        }
    }
    return res;
}

test vqrshlq_s64 {
    const a = @as(types.i64x2, @splat(15));
    const b = @as(types.i64x2, @splat(-1));
    const expected = @as(types.i64x2, @splat(8));
    try common.testIntrinsic(.{ .func = vqrshlq_s64, .expected = expected, .args = .{ a, b } });
}

/// Vector rounding saturating shift by signed vector count
pub inline fn vqrshl_u8(a: types.u8x8, b: types.i8x8) types.u8x8 {
    var res: types.u8x8 = undefined;
    const bits: i8 = 8;
    inline for (0..8) |i| {
        const shift = b[i];
        if (shift >= bits) {
            res[i] = if (a[i] > 0) std.math.maxInt(u8) else 0;
        } else if (shift >= 0) {
            const wide = @as(u16, a[i]) << @intCast(shift);
            res[i] = @intCast(std.math.clamp(wide, std.math.minInt(u8), std.math.maxInt(u8)));
        } else if (shift <= -bits) {
            res[i] = 0;
        } else {
            const r_shift = -shift;
            const u: std.math.Log2Int(u8) = @intCast(r_shift);
            const round: u8 = @as(u8, 1) << (u - 1);
            res[i] = (a[i] +% round) >> u;
        }
    }
    return res;
}

test vqrshl_u8 {
    const a = @as(types.u8x8, @splat(15));
    const b = @as(types.i8x8, @splat(-1));
    const expected = @as(types.u8x8, @splat(8));
    try common.testIntrinsic(.{ .func = vqrshl_u8, .expected = expected, .args = .{ a, b } });
}

/// Vector rounding saturating shift by signed vector count
pub inline fn vqrshlq_u8(a: types.u8x16, b: types.i8x16) types.u8x16 {
    var res: types.u8x16 = undefined;
    const bits: i8 = 8;
    inline for (0..16) |i| {
        const shift = b[i];
        if (shift >= bits) {
            res[i] = if (a[i] > 0) std.math.maxInt(u8) else 0;
        } else if (shift >= 0) {
            const wide = @as(u16, a[i]) << @intCast(shift);
            res[i] = @intCast(std.math.clamp(wide, std.math.minInt(u8), std.math.maxInt(u8)));
        } else if (shift <= -bits) {
            res[i] = 0;
        } else {
            const r_shift = -shift;
            const u: std.math.Log2Int(u8) = @intCast(r_shift);
            const round: u8 = @as(u8, 1) << (u - 1);
            res[i] = (a[i] +% round) >> u;
        }
    }
    return res;
}

test vqrshlq_u8 {
    const a = @as(types.u8x16, @splat(15));
    const b = @as(types.i8x16, @splat(-1));
    const expected = @as(types.u8x16, @splat(8));
    try common.testIntrinsic(.{ .func = vqrshlq_u8, .expected = expected, .args = .{ a, b } });
}

/// Vector rounding saturating shift by signed vector count
pub inline fn vqrshl_u16(a: types.u16x4, b: types.i16x4) types.u16x4 {
    var res: types.u16x4 = undefined;
    const bits: i16 = 16;
    inline for (0..4) |i| {
        const shift = b[i];
        if (shift >= bits) {
            res[i] = if (a[i] > 0) std.math.maxInt(u16) else 0;
        } else if (shift >= 0) {
            const wide = @as(u32, a[i]) << @intCast(shift);
            res[i] = @intCast(std.math.clamp(wide, std.math.minInt(u16), std.math.maxInt(u16)));
        } else if (shift <= -bits) {
            res[i] = 0;
        } else {
            const r_shift = -shift;
            const u: std.math.Log2Int(u16) = @intCast(r_shift);
            const round: u16 = @as(u16, 1) << (u - 1);
            res[i] = (a[i] +% round) >> u;
        }
    }
    return res;
}

test vqrshl_u16 {
    const a = @as(types.u16x4, @splat(15));
    const b = @as(types.i16x4, @splat(-1));
    const expected = @as(types.u16x4, @splat(8));
    try common.testIntrinsic(.{ .func = vqrshl_u16, .expected = expected, .args = .{ a, b } });
}

/// Vector rounding saturating shift by signed vector count
pub inline fn vqrshlq_u16(a: types.u16x8, b: types.i16x8) types.u16x8 {
    var res: types.u16x8 = undefined;
    const bits: i16 = 16;
    inline for (0..8) |i| {
        const shift = b[i];
        if (shift >= bits) {
            res[i] = if (a[i] > 0) std.math.maxInt(u16) else 0;
        } else if (shift >= 0) {
            const wide = @as(u32, a[i]) << @intCast(shift);
            res[i] = @intCast(std.math.clamp(wide, std.math.minInt(u16), std.math.maxInt(u16)));
        } else if (shift <= -bits) {
            res[i] = 0;
        } else {
            const r_shift = -shift;
            const u: std.math.Log2Int(u16) = @intCast(r_shift);
            const round: u16 = @as(u16, 1) << (u - 1);
            res[i] = (a[i] +% round) >> u;
        }
    }
    return res;
}

test vqrshlq_u16 {
    const a = @as(types.u16x8, @splat(15));
    const b = @as(types.i16x8, @splat(-1));
    const expected = @as(types.u16x8, @splat(8));
    try common.testIntrinsic(.{ .func = vqrshlq_u16, .expected = expected, .args = .{ a, b } });
}

/// Vector rounding saturating shift by signed vector count
pub inline fn vqrshl_u32(a: types.u32x2, b: types.i32x2) types.u32x2 {
    var res: types.u32x2 = undefined;
    const bits: i32 = 32;
    inline for (0..2) |i| {
        const shift = b[i];
        if (shift >= bits) {
            res[i] = if (a[i] > 0) std.math.maxInt(u32) else 0;
        } else if (shift >= 0) {
            const wide = @as(u64, a[i]) << @intCast(shift);
            res[i] = @intCast(std.math.clamp(wide, std.math.minInt(u32), std.math.maxInt(u32)));
        } else if (shift <= -bits) {
            res[i] = 0;
        } else {
            const r_shift = -shift;
            const u: std.math.Log2Int(u32) = @intCast(r_shift);
            const round: u32 = @as(u32, 1) << (u - 1);
            res[i] = (a[i] +% round) >> u;
        }
    }
    return res;
}

test vqrshl_u32 {
    const a = @as(types.u32x2, @splat(15));
    const b = @as(types.i32x2, @splat(-1));
    const expected = @as(types.u32x2, @splat(8));
    try common.testIntrinsic(.{ .func = vqrshl_u32, .expected = expected, .args = .{ a, b } });
}

/// Vector rounding saturating shift by signed vector count
pub inline fn vqrshlq_u32(a: types.u32x4, b: types.i32x4) types.u32x4 {
    var res: types.u32x4 = undefined;
    const bits: i32 = 32;
    inline for (0..4) |i| {
        const shift = b[i];
        if (shift >= bits) {
            res[i] = if (a[i] > 0) std.math.maxInt(u32) else 0;
        } else if (shift >= 0) {
            const wide = @as(u64, a[i]) << @intCast(shift);
            res[i] = @intCast(std.math.clamp(wide, std.math.minInt(u32), std.math.maxInt(u32)));
        } else if (shift <= -bits) {
            res[i] = 0;
        } else {
            const r_shift = -shift;
            const u: std.math.Log2Int(u32) = @intCast(r_shift);
            const round: u32 = @as(u32, 1) << (u - 1);
            res[i] = (a[i] +% round) >> u;
        }
    }
    return res;
}

test vqrshlq_u32 {
    const a = @as(types.u32x4, @splat(15));
    const b = @as(types.i32x4, @splat(-1));
    const expected = @as(types.u32x4, @splat(8));
    try common.testIntrinsic(.{ .func = vqrshlq_u32, .expected = expected, .args = .{ a, b } });
}

/// Vector rounding saturating shift by signed vector count
pub inline fn vqrshl_u64(a: types.u64x1, b: types.i64x1) types.u64x1 {
    var res: types.u64x1 = undefined;
    const bits: i64 = 64;
    inline for (0..1) |i| {
        const shift = b[i];
        if (shift >= bits) {
            res[i] = if (a[i] > 0) std.math.maxInt(u64) else 0;
        } else if (shift >= 0) {
            const wide = @as(u128, a[i]) << @intCast(shift);
            res[i] = @intCast(std.math.clamp(wide, std.math.minInt(u64), std.math.maxInt(u64)));
        } else if (shift <= -bits) {
            res[i] = 0;
        } else {
            const r_shift = -shift;
            const u: std.math.Log2Int(u64) = @intCast(r_shift);
            const round: u64 = @as(u64, 1) << (u - 1);
            res[i] = (a[i] +% round) >> u;
        }
    }
    return res;
}

test vqrshl_u64 {
    const a = @as(types.u64x1, @splat(15));
    const b = @as(types.i64x1, @splat(-1));
    const expected = @as(types.u64x1, @splat(8));
    try common.testIntrinsic(.{ .func = vqrshl_u64, .expected = expected, .args = .{ a, b } });
}

/// Vector rounding saturating shift by signed vector count
pub inline fn vqrshlq_u64(a: types.u64x2, b: types.i64x2) types.u64x2 {
    var res: types.u64x2 = undefined;
    const bits: i64 = 64;
    inline for (0..2) |i| {
        const shift = b[i];
        if (shift >= bits) {
            res[i] = if (a[i] > 0) std.math.maxInt(u64) else 0;
        } else if (shift >= 0) {
            const wide = @as(u128, a[i]) << @intCast(shift);
            res[i] = @intCast(std.math.clamp(wide, std.math.minInt(u64), std.math.maxInt(u64)));
        } else if (shift <= -bits) {
            res[i] = 0;
        } else {
            const r_shift = -shift;
            const u: std.math.Log2Int(u64) = @intCast(r_shift);
            const round: u64 = @as(u64, 1) << (u - 1);
            res[i] = (a[i] +% round) >> u;
        }
    }
    return res;
}

test vqrshlq_u64 {
    const a = @as(types.u64x2, @splat(15));
    const b = @as(types.i64x2, @splat(-1));
    const expected = @as(types.u64x2, @splat(8));
    try common.testIntrinsic(.{ .func = vqrshlq_u64, .expected = expected, .args = .{ a, b } });
}

/// Scalar shift by signed count
pub inline fn vshld_s64(a: i64, b: i64) i64 {
    if (b >= 64) return 0;
    if (b <= -64) return if (a < 0) -1 else 0;
    if (b >= 0) {
        const u: std.math.Log2Int(i64) = @intCast(b);
        return a << u;
    } else {
        const u: std.math.Log2Int(i64) = @intCast(-b);
        return a >> u;
    }
}

test vshld_s64 {
    const a: i64 = 16;
    const b: i64 = 1;
    const expected: i64 = 32;
    try common.testIntrinsic(.{ .func = vshld_s64, .expected = expected, .args = .{ a, b } });
}

/// Scalar shift by signed count
pub inline fn vshld_u64(a: u64, b: i64) u64 {
    if (b >= 64) return 0;
    if (b <= -64) return 0;
    if (b >= 0) {
        const u: std.math.Log2Int(u64) = @intCast(b);
        return a << u;
    } else {
        const u: std.math.Log2Int(u64) = @intCast(-b);
        return a >> u;
    }
}

test vshld_u64 {
    const a: u64 = 16;
    const b: i64 = 1;
    const expected: u64 = 32;
    try common.testIntrinsic(.{ .func = vshld_u64, .expected = expected, .args = .{ a, b } });
}

/// Scalar rounding shift by signed count
pub inline fn vrshld_s64(a: i64, b: i64) i64 {
    if (b >= 64) return 0;
    if (b >= 0) {
        const u: std.math.Log2Int(i64) = @intCast(b);
        return a << u;
    } else if (b <= -64) {
        return 0;
    } else {
        const r_shift = -b;
        const u: std.math.Log2Int(i64) = @intCast(r_shift);
        const round: i64 = @as(i64, 1) << (u - 1);
        return (a +% round) >> u;
    }
}

test vrshld_s64 {
    const a: i64 = 15;
    const b: i64 = -1;
    const expected: i64 = 8;
    try common.testIntrinsic(.{ .func = vrshld_s64, .expected = expected, .args = .{ a, b } });
}

/// Scalar rounding shift by signed count
pub inline fn vrshld_u64(a: u64, b: i64) u64 {
    if (b >= 64) return 0;
    if (b >= 0) {
        const u: std.math.Log2Int(u64) = @intCast(b);
        return a << u;
    } else if (b <= -64) {
        return 0;
    } else {
        const r_shift = -b;
        const u: std.math.Log2Int(u64) = @intCast(r_shift);
        const round: u64 = @as(u64, 1) << (u - 1);
        return (a +% round) >> u;
    }
}

test vrshld_u64 {
    const a: u64 = 15;
    const b: i64 = -1;
    const expected: u64 = 8;
    try common.testIntrinsic(.{ .func = vrshld_u64, .expected = expected, .args = .{ a, b } });
}

/// Scalar saturating shift by signed count
pub inline fn vqshlb_s8(a: i8, b: i8) i8 {
    const b_bits: i8 = 8;
    if (b >= b_bits) {
        return if (a < 0) std.math.minInt(i8) else std.math.maxInt(i8);
    } else if (b >= 0) {
        const wide = @as(i16, a) << @intCast(b);
        return @intCast(std.math.clamp(wide, std.math.minInt(i8), std.math.maxInt(i8)));
    } else if (b <= -b_bits) {
        return if (a < 0) -1 else 0;
    } else {
        const u: std.math.Log2Int(i8) = @intCast(-b);
        return a >> u;
    }
}

test vqshlb_s8 {
    const a: i8 = 16;
    const b: i8 = 1;
    const expected: i8 = 32;
    try common.testIntrinsic(.{ .func = vqshlb_s8, .expected = expected, .args = .{ a, b } });
}

/// Scalar saturating shift by signed count
pub inline fn vqshlb_u8(a: u8, b: i8) u8 {
    const b_bits: i8 = 8;
    if (b >= b_bits) {
        return if (a > 0) std.math.maxInt(u8) else 0;
    } else if (b >= 0) {
        const wide = @as(u16, a) << @intCast(b);
        return @intCast(std.math.clamp(wide, std.math.minInt(u8), std.math.maxInt(u8)));
    } else if (b <= -b_bits) {
        return 0;
    } else {
        const u: std.math.Log2Int(u8) = @intCast(-b);
        return a >> u;
    }
}

test vqshlb_u8 {
    const a: u8 = 16;
    const b: i8 = 1;
    const expected: u8 = 32;
    try common.testIntrinsic(.{ .func = vqshlb_u8, .expected = expected, .args = .{ a, b } });
}

/// Scalar saturating shift by signed count
pub inline fn vqshlh_s16(a: i16, b: i16) i16 {
    const b_bits: i16 = 16;
    if (b >= b_bits) {
        return if (a < 0) std.math.minInt(i16) else std.math.maxInt(i16);
    } else if (b >= 0) {
        const wide = @as(i32, a) << @intCast(b);
        return @intCast(std.math.clamp(wide, std.math.minInt(i16), std.math.maxInt(i16)));
    } else if (b <= -b_bits) {
        return if (a < 0) -1 else 0;
    } else {
        const u: std.math.Log2Int(i16) = @intCast(-b);
        return a >> u;
    }
}

test vqshlh_s16 {
    const a: i16 = 16;
    const b: i16 = 1;
    const expected: i16 = 32;
    try common.testIntrinsic(.{ .func = vqshlh_s16, .expected = expected, .args = .{ a, b } });
}

/// Scalar saturating shift by signed count
pub inline fn vqshlh_u16(a: u16, b: i16) u16 {
    const b_bits: i16 = 16;
    if (b >= b_bits) {
        return if (a > 0) std.math.maxInt(u16) else 0;
    } else if (b >= 0) {
        const wide = @as(u32, a) << @intCast(b);
        return @intCast(std.math.clamp(wide, std.math.minInt(u16), std.math.maxInt(u16)));
    } else if (b <= -b_bits) {
        return 0;
    } else {
        const u: std.math.Log2Int(u16) = @intCast(-b);
        return a >> u;
    }
}

test vqshlh_u16 {
    const a: u16 = 16;
    const b: i16 = 1;
    const expected: u16 = 32;
    try common.testIntrinsic(.{ .func = vqshlh_u16, .expected = expected, .args = .{ a, b } });
}

/// Scalar saturating shift by signed count
pub inline fn vqshls_s32(a: i32, b: i32) i32 {
    const b_bits: i32 = 32;
    if (b >= b_bits) {
        return if (a < 0) std.math.minInt(i32) else std.math.maxInt(i32);
    } else if (b >= 0) {
        const wide = @as(i64, a) << @intCast(b);
        return @intCast(std.math.clamp(wide, std.math.minInt(i32), std.math.maxInt(i32)));
    } else if (b <= -b_bits) {
        return if (a < 0) -1 else 0;
    } else {
        const u: std.math.Log2Int(i32) = @intCast(-b);
        return a >> u;
    }
}

test vqshls_s32 {
    const a: i32 = 16;
    const b: i32 = 1;
    const expected: i32 = 32;
    try common.testIntrinsic(.{ .func = vqshls_s32, .expected = expected, .args = .{ a, b } });
}

/// Scalar saturating shift by signed count
pub inline fn vqshls_u32(a: u32, b: i32) u32 {
    const b_bits: i32 = 32;
    if (b >= b_bits) {
        return if (a > 0) std.math.maxInt(u32) else 0;
    } else if (b >= 0) {
        const wide = @as(u64, a) << @intCast(b);
        return @intCast(std.math.clamp(wide, std.math.minInt(u32), std.math.maxInt(u32)));
    } else if (b <= -b_bits) {
        return 0;
    } else {
        const u: std.math.Log2Int(u32) = @intCast(-b);
        return a >> u;
    }
}

test vqshls_u32 {
    const a: u32 = 16;
    const b: i32 = 1;
    const expected: u32 = 32;
    try common.testIntrinsic(.{ .func = vqshls_u32, .expected = expected, .args = .{ a, b } });
}

/// Scalar saturating shift by signed count
pub inline fn vqshld_s64(a: i64, b: i64) i64 {
    const b_bits: i64 = 64;
    if (b >= b_bits) {
        return if (a < 0) std.math.minInt(i64) else std.math.maxInt(i64);
    } else if (b >= 0) {
        const wide = @as(i128, a) << @intCast(b);
        return @intCast(std.math.clamp(wide, std.math.minInt(i64), std.math.maxInt(i64)));
    } else if (b <= -b_bits) {
        return if (a < 0) -1 else 0;
    } else {
        const u: std.math.Log2Int(i64) = @intCast(-b);
        return a >> u;
    }
}

test vqshld_s64 {
    const a: i64 = 16;
    const b: i64 = 1;
    const expected: i64 = 32;
    try common.testIntrinsic(.{ .func = vqshld_s64, .expected = expected, .args = .{ a, b } });
}

/// Scalar saturating shift by signed count
pub inline fn vqshld_u64(a: u64, b: i64) u64 {
    const b_bits: i64 = 64;
    if (b >= b_bits) {
        return if (a > 0) std.math.maxInt(u64) else 0;
    } else if (b >= 0) {
        const wide = @as(u128, a) << @intCast(b);
        return @intCast(std.math.clamp(wide, std.math.minInt(u64), std.math.maxInt(u64)));
    } else if (b <= -b_bits) {
        return 0;
    } else {
        const u: std.math.Log2Int(u64) = @intCast(-b);
        return a >> u;
    }
}

test vqshld_u64 {
    const a: u64 = 16;
    const b: i64 = 1;
    const expected: u64 = 32;
    try common.testIntrinsic(.{ .func = vqshld_u64, .expected = expected, .args = .{ a, b } });
}

/// Scalar rounding saturating shift by signed count
pub inline fn vqrshlb_s8(a: i8, b: i8) i8 {
    const b_bits: i8 = 8;
    if (b >= b_bits) {
        return if (a < 0) std.math.minInt(i8) else std.math.maxInt(i8);
    } else if (b >= 0) {
        const wide = @as(i16, a) << @intCast(b);
        return @intCast(std.math.clamp(wide, std.math.minInt(i8), std.math.maxInt(i8)));
    } else if (b <= -b_bits) {
        return 0;
    } else {
        const r_shift = -b;
        const u: std.math.Log2Int(i8) = @intCast(r_shift);
        const round: i8 = @as(i8, 1) << (u - 1);
        return (a +% round) >> u;
    }
}

test vqrshlb_s8 {
    const a: i8 = 15;
    const b: i8 = -1;
    const expected: i8 = 8;
    try common.testIntrinsic(.{ .func = vqrshlb_s8, .expected = expected, .args = .{ a, b } });
}

/// Scalar rounding saturating shift by signed count
pub inline fn vqrshlb_u8(a: u8, b: i8) u8 {
    const b_bits: i8 = 8;
    if (b >= b_bits) {
        return if (a > 0) std.math.maxInt(u8) else 0;
    } else if (b >= 0) {
        const wide = @as(u16, a) << @intCast(b);
        return @intCast(std.math.clamp(wide, std.math.minInt(u8), std.math.maxInt(u8)));
    } else if (b <= -b_bits) {
        return 0;
    } else {
        const r_shift = -b;
        const u: std.math.Log2Int(u8) = @intCast(r_shift);
        const round: u8 = @as(u8, 1) << (u - 1);
        return (a +% round) >> u;
    }
}

test vqrshlb_u8 {
    const a: u8 = 15;
    const b: i8 = -1;
    const expected: u8 = 8;
    try common.testIntrinsic(.{ .func = vqrshlb_u8, .expected = expected, .args = .{ a, b } });
}

/// Scalar rounding saturating shift by signed count
pub inline fn vqrshlh_s16(a: i16, b: i16) i16 {
    const b_bits: i16 = 16;
    if (b >= b_bits) {
        return if (a < 0) std.math.minInt(i16) else std.math.maxInt(i16);
    } else if (b >= 0) {
        const wide = @as(i32, a) << @intCast(b);
        return @intCast(std.math.clamp(wide, std.math.minInt(i16), std.math.maxInt(i16)));
    } else if (b <= -b_bits) {
        return 0;
    } else {
        const r_shift = -b;
        const u: std.math.Log2Int(i16) = @intCast(r_shift);
        const round: i16 = @as(i16, 1) << (u - 1);
        return (a +% round) >> u;
    }
}

test vqrshlh_s16 {
    const a: i16 = 15;
    const b: i16 = -1;
    const expected: i16 = 8;
    try common.testIntrinsic(.{ .func = vqrshlh_s16, .expected = expected, .args = .{ a, b } });
}

/// Scalar rounding saturating shift by signed count
pub inline fn vqrshlh_u16(a: u16, b: i16) u16 {
    const b_bits: i16 = 16;
    if (b >= b_bits) {
        return if (a > 0) std.math.maxInt(u16) else 0;
    } else if (b >= 0) {
        const wide = @as(u32, a) << @intCast(b);
        return @intCast(std.math.clamp(wide, std.math.minInt(u16), std.math.maxInt(u16)));
    } else if (b <= -b_bits) {
        return 0;
    } else {
        const r_shift = -b;
        const u: std.math.Log2Int(u16) = @intCast(r_shift);
        const round: u16 = @as(u16, 1) << (u - 1);
        return (a +% round) >> u;
    }
}

test vqrshlh_u16 {
    const a: u16 = 15;
    const b: i16 = -1;
    const expected: u16 = 8;
    try common.testIntrinsic(.{ .func = vqrshlh_u16, .expected = expected, .args = .{ a, b } });
}

/// Scalar rounding saturating shift by signed count
pub inline fn vqrshls_s32(a: i32, b: i32) i32 {
    const b_bits: i32 = 32;
    if (b >= b_bits) {
        return if (a < 0) std.math.minInt(i32) else std.math.maxInt(i32);
    } else if (b >= 0) {
        const wide = @as(i64, a) << @intCast(b);
        return @intCast(std.math.clamp(wide, std.math.minInt(i32), std.math.maxInt(i32)));
    } else if (b <= -b_bits) {
        return 0;
    } else {
        const r_shift = -b;
        const u: std.math.Log2Int(i32) = @intCast(r_shift);
        const round: i32 = @as(i32, 1) << (u - 1);
        return (a +% round) >> u;
    }
}

test vqrshls_s32 {
    const a: i32 = 15;
    const b: i32 = -1;
    const expected: i32 = 8;
    try common.testIntrinsic(.{ .func = vqrshls_s32, .expected = expected, .args = .{ a, b } });
}

/// Scalar rounding saturating shift by signed count
pub inline fn vqrshls_u32(a: u32, b: i32) u32 {
    const b_bits: i32 = 32;
    if (b >= b_bits) {
        return if (a > 0) std.math.maxInt(u32) else 0;
    } else if (b >= 0) {
        const wide = @as(u64, a) << @intCast(b);
        return @intCast(std.math.clamp(wide, std.math.minInt(u32), std.math.maxInt(u32)));
    } else if (b <= -b_bits) {
        return 0;
    } else {
        const r_shift = -b;
        const u: std.math.Log2Int(u32) = @intCast(r_shift);
        const round: u32 = @as(u32, 1) << (u - 1);
        return (a +% round) >> u;
    }
}

test vqrshls_u32 {
    const a: u32 = 15;
    const b: i32 = -1;
    const expected: u32 = 8;
    try common.testIntrinsic(.{ .func = vqrshls_u32, .expected = expected, .args = .{ a, b } });
}

/// Scalar rounding saturating shift by signed count
pub inline fn vqrshld_s64(a: i64, b: i64) i64 {
    const b_bits: i64 = 64;
    if (b >= b_bits) {
        return if (a < 0) std.math.minInt(i64) else std.math.maxInt(i64);
    } else if (b >= 0) {
        const wide = @as(i128, a) << @intCast(b);
        return @intCast(std.math.clamp(wide, std.math.minInt(i64), std.math.maxInt(i64)));
    } else if (b <= -b_bits) {
        return 0;
    } else {
        const r_shift = -b;
        const u: std.math.Log2Int(i64) = @intCast(r_shift);
        const round: i64 = @as(i64, 1) << (u - 1);
        return (a +% round) >> u;
    }
}

test vqrshld_s64 {
    const a: i64 = 15;
    const b: i64 = -1;
    const expected: i64 = 8;
    try common.testIntrinsic(.{ .func = vqrshld_s64, .expected = expected, .args = .{ a, b } });
}

/// Scalar rounding saturating shift by signed count
pub inline fn vqrshld_u64(a: u64, b: i64) u64 {
    const b_bits: i64 = 64;
    if (b >= b_bits) {
        return if (a > 0) std.math.maxInt(u64) else 0;
    } else if (b >= 0) {
        const wide = @as(u128, a) << @intCast(b);
        return @intCast(std.math.clamp(wide, std.math.minInt(u64), std.math.maxInt(u64)));
    } else if (b <= -b_bits) {
        return 0;
    } else {
        const r_shift = -b;
        const u: std.math.Log2Int(u64) = @intCast(r_shift);
        const round: u64 = @as(u64, 1) << (u - 1);
        return (a +% round) >> u;
    }
}

test vqrshld_u64 {
    const a: u64 = 15;
    const b: i64 = -1;
    const expected: u64 = 8;
    try common.testIntrinsic(.{ .func = vqrshld_u64, .expected = expected, .args = .{ a, b } });
}
