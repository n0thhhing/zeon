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
    try common.testIntrinsic("vshrq_n_s8", vshrq_n_s8, expected, .{ a, n }, null);
}

/// Shift right
pub inline fn vshrq_n_s16(a: types.i16x8, n: u16) types.i16x8 {
    return @as(types.u16x8, @bitCast(a)) >> @as(types.u16x8, @splat(n));
}

test vshrq_n_s16 {
    const a: types.i16x8 = @splat(1);
    const n: u16 = 1;
    const expected: types.i16x8 = @splat(0);
    try common.testIntrinsic("vshrq_n_s16", vshrq_n_s16, expected, .{ a, n }, null);
}

/// Shift right
pub inline fn vshrq_n_s32(a: types.i32x4, n: u32) types.i32x4 {
    return @as(types.u32x4, @bitCast(a)) >> @as(types.u32x4, @splat(n));
}

test vshrq_n_s32 {
    const a: types.i32x4 = @splat(1);
    const n: u32 = 1;
    const expected: types.i32x4 = @splat(0);
    try common.testIntrinsic("vshrq_n_s32", vshrq_n_s32, expected, .{ a, n }, null);
}

/// Shift right
pub inline fn vshrq_n_s64(a: types.u64x2, n: u64) types.i64x2 {
    return a >> @as(types.u64x2, @splat(n));
}

test vshrq_n_s64 {
    const a: types.u64x2 = @splat(1);
    const n: u64 = 1;
    const expected: types.i64x2 = @splat(0);
    try common.testIntrinsic("vshrq_n_s64", vshrq_n_s64, expected, .{ a, n }, null);
}

/// Shift right
pub inline fn vshrq_n_u8(a: types.u8x16, n: u8) types.u8x16 {
    return a >> @as(types.u8x16, @splat(n));
}

test vshrq_n_u8 {
    const a: types.u8x16 = @splat(1);
    const n: u8 = 1;
    const expected: types.u8x16 = @splat(0);
    try common.testIntrinsic("vshrq_n_u8", vshrq_n_u8, expected, .{ a, n }, null);
}

/// Shift right
pub inline fn vshrq_n_u16(a: types.u16x8, n: u16) types.u16x8 {
    return a >> @as(types.u16x8, @splat(n));
}

test vshrq_n_u16 {
    const a: types.u16x8 = @splat(1);
    const n: u16 = 1;
    const expected: types.u16x8 = @splat(0);
    try common.testIntrinsic("vshrq_n_u16", vshrq_n_u16, expected, .{ a, n }, null);
}

/// Shift right
pub inline fn vshrq_n_u32(a: types.u32x4, n: u32) types.u32x4 {
    return a >> @as(types.u32x4, @splat(n));
}

test vshrq_n_u32 {
    const a: types.u32x4 = @splat(1);
    const n: u32 = 1;
    const expected: types.u32x4 = @splat(0);
    try common.testIntrinsic("vshrq_n_u32", vshrq_n_u32, expected, .{ a, n }, null);
}

/// Shift right
pub inline fn vshrq_n_u64(a: types.u64x2, n: u64) types.u64x2 {
    return a >> @as(types.u64x2, @splat(n));
}

test vshrq_n_u64 {
    const a: types.u64x2 = @splat(1);
    const n: u64 = 1;
    const expected: types.u64x2 = @splat(0);
    try common.testIntrinsic("vshrq_n_u64", vshrq_n_u64, expected, .{ a, n }, null);
}
