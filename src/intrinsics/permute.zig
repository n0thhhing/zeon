const std = @import("std");
const builtin = @import("builtin");
const assert = std.debug.assert;
const expectEqual = std.testing.expectEqual;
const arch = @import("../arch.zig");
const endianness = builtin.target.cpu.arch.endian();
const types = @import("../types.zig");
const common = @import("../common.zig");

/// Get high elements of a int8x16_t vector
pub inline fn vget_high_s8(vec: types.i8x16) types.i8x8 {
    return @shuffle(
        i8,
        vec,
        undefined,
        types.i8x8{ 8, 9, 10, 11, 12, 13, 14, 15 },
    );
}

test vget_high_s8 {
    const v: types.i8x16 = .{ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 };
    const expected: types.i8x8 = .{ 8, 9, 10, 11, 12, 13, 14, 15 };

    try expectEqual(expected, vget_high_s8(v));
}

/// Get high elements of a int16x8_t vector
pub inline fn vget_high_s16(vec: types.i16x8) types.i16x4 {
    return @shuffle(
        i16,
        vec,
        undefined,
        types.i16x4{ 4, 5, 6, 7 },
    );
}

test vget_high_s16 {
    const v: types.i16x8 = .{ 0, 1, 2, 3, 4, 5, 6, 7 };
    const expected: types.i16x4 = .{ 4, 5, 6, 7 };

    try expectEqual(expected, vget_high_s16(v));
}

/// Get high elements of a int32x4_t vector
pub inline fn vget_high_s32(vec: types.i32x4) types.i32x2 {
    return @shuffle(
        i32,
        vec,
        undefined,
        types.i32x2{ 2, 3 },
    );
}

test vget_high_s32 {
    const v: types.i32x4 = .{ 0, 1, 2, 3 };
    const expected: types.i32x2 = .{ 2, 3 };

    try expectEqual(expected, vget_high_s32(v));
}

/// Get high elements of a int64x2_t vector
pub inline fn vget_high_s64(vec: types.i64x2) types.i64x1 {
    return @shuffle(
        i64,
        vec,
        undefined,
        types.i64x1{1},
    );
}

test vget_high_s64 {
    const v: types.i64x2 = .{ 0, 1 };
    const expected: types.i64x1 = .{1};

    try expectEqual(expected, vget_high_s64(v));
}

/// Get high elements of a float16x8_t vector
pub inline fn vget_high_f16(vec: types.f16x8) types.f16x4 {
    return @shuffle(
        f16,
        vec,
        undefined,
        types.f16x4{ 4, 5, 6, 7 },
    );
}

test vget_high_f16 {
    const v: types.f16x8 = .{ 0, 1, 2, 3, 4, 5, 6, 7 };
    const expected: types.f16x4 = .{ 4, 5, 6, 7 };

    try expectEqual(expected, vget_high_f16(v));
}

/// Get high elements of a float32x4_t vector
pub inline fn vget_high_f32(vec: types.f32x4) types.f32x2 {
    return @shuffle(
        f32,
        vec,
        undefined,
        types.f32x2{ 2, 3 },
    );
}

test vget_high_f32 {
    const v: types.f32x4 = .{ 0, 1, 2, 3 };
    const expected: types.f32x2 = .{ 2, 3 };

    try expectEqual(expected, vget_high_f32(v));
}

/// Get high elements of a float64x2_t vector
pub inline fn vget_high_f64(vec: types.f64x2) types.f64x1 {
    return @shuffle(
        f64,
        vec,
        undefined,
        types.f64x1{1},
    );
}

test vget_high_f64 {
    const v: types.f64x2 = .{ 0, 1 };
    const expected: types.f64x1 = .{1};

    try expectEqual(expected, vget_high_f64(v));
}

/// Get high elements of a uint8x16_t vector
pub inline fn vget_high_u8(vec: types.u8x16) types.u8x8 {
    return @shuffle(
        u8,
        vec,
        undefined,
        types.u8x8{ 8, 9, 10, 11, 12, 13, 14, 15 },
    );
}

test vget_high_u8 {
    const v: types.u8x16 = .{ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 };
    const expected: types.u8x8 = .{ 8, 9, 10, 11, 12, 13, 14, 15 };

    try expectEqual(expected, vget_high_u8(v));
}

/// Get high elements of a uint16x8_t vector
pub inline fn vget_high_u16(vec: types.u16x8) types.u16x4 {
    return @shuffle(
        u16,
        vec,
        undefined,
        types.u16x4{ 4, 5, 6, 7 },
    );
}

test vget_high_u16 {
    const v: types.u16x8 = .{ 0, 1, 2, 3, 4, 5, 6, 7 };
    const expected: types.u16x4 = .{ 4, 5, 6, 7 };

    try expectEqual(expected, vget_high_u16(v));
}

/// Get high elements of a uint32x4_t vector
pub inline fn vget_high_u32(vec: types.u32x4) types.u32x2 {
    return @shuffle(
        u32,
        vec,
        undefined,
        types.u32x2{ 2, 3 },
    );
}

test vget_high_u32 {
    const v: types.u32x4 = .{ 0, 1, 2, 3 };
    const expected: types.u32x2 = .{ 2, 3 };

    try expectEqual(expected, vget_high_u32(v));
}

/// Get high elements of a uint64x2_t vector
pub inline fn vget_high_u64(vec: types.u64x2) types.u64x1 {
    return @shuffle(
        u64,
        vec,
        undefined,
        types.u64x1{1},
    );
}

test vget_high_u64 {
    const v: types.u64x2 = .{ 0, 1 };
    const expected: types.u64x1 = .{1};

    try expectEqual(expected, vget_high_u64(v));
}

/// Get high elements of a poly8x16_t vector
pub inline fn vget_high_p8(vec: types.p8x16) types.p8x8 {
    return @shuffle(
        types.p8,
        vec,
        undefined,
        types.p8x8{ 8, 9, 10, 11, 12, 13, 14, 15 },
    );
}

test vget_high_p8 {
    const v: types.p8x16 = .{ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 };
    const expected: types.p8x8 = .{ 8, 9, 10, 11, 12, 13, 14, 15 };

    try expectEqual(expected, vget_high_p8(v));
}

/// Get high elements of a uint16x8_t vector
pub inline fn vget_high_p16(vec: types.p16x8) types.p16x4 {
    return @shuffle(
        types.p16,
        vec,
        undefined,
        types.p16x4{ 4, 5, 6, 7 },
    );
}

test vget_high_p16 {
    const v: types.p16x8 = .{ 0, 1, 2, 3, 4, 5, 6, 7 };
    const expected: types.p16x4 = .{ 4, 5, 6, 7 };

    try expectEqual(expected, vget_high_p16(v));
}

/// Get low elements of a int8x16_t vector
pub inline fn vget_low_s8(vec: types.i8x16) types.i8x8 {
    return @shuffle(
        i8,
        vec,
        undefined,
        types.i8x8{ 0, 1, 2, 3, 4, 5, 6, 7 },
    );
}

test vget_low_s8 {
    const vec: types.i8x16 = @splat(1);
    const expected: types.i8x8 = .{ 1, 1, 1, 1, 1, 1, 1, 1 };
    try common.testIntrinsic("vget_low_s8", vget_low_s8, expected, .{vec}, null);
}

/// Get low elements of a int16x4_t vector
pub inline fn vget_low_s16(vec: types.i16x8) types.i16x4 {
    return @shuffle(
        i16,
        vec,
        undefined,
        types.i16x4{ 0, 1, 2, 3 },
    );
}

test vget_low_s16 {
    const vec: types.i16x8 = @splat(1);
    const expected: types.i16x4 = .{ 1, 1, 1, 1 };
    try common.testIntrinsic("vget_low_s16", vget_low_s16, expected, .{vec}, null);
}

/// Get low elements of a int32x4_t vector
pub inline fn vget_low_s32(vec: types.i32x4) types.i32x2 {
    return @shuffle(
        i32,
        vec,
        undefined,
        types.i32x2{ 0, 1 },
    );
}

test vget_low_s32 {
    const vec: types.i32x4 = @splat(1);
    const expected: types.i32x2 = .{ 1, 1 };
    try common.testIntrinsic("vget_low_s32", vget_low_s32, expected, .{vec}, null);
}

/// Get low elements of a int64x2_t vector
pub inline fn vget_low_s64(vec: types.i64x2) types.i64x1 {
    return @shuffle(
        i64,
        vec,
        undefined,
        types.i64x1{0},
    );
}

test vget_low_s64 {
    const vec: types.i64x2 = @splat(1);
    const expected: types.i64x1 = .{1};
    try common.testIntrinsic("vget_low_s64", vget_low_s64, expected, .{vec}, null);
}

/// Get low elements of a uint8x16_t vector
pub inline fn vget_low_u8(vec: types.u8x16) types.u8x8 {
    return @shuffle(
        u8,
        vec,
        undefined,
        types.u8x8{ 0, 1, 2, 3, 4, 5, 6, 7 },
    );
}

test vget_low_u8 {
    const vec: types.u8x16 = @splat(1);
    const expected: types.u8x8 = .{ 1, 1, 1, 1, 1, 1, 1, 1 };
    try common.testIntrinsic("vget_low_u8", vget_low_u8, expected, .{vec}, null);
}

/// Get low elements of a uint16x8_t vector
pub inline fn vget_low_u16(vec: types.u16x8) types.u16x4 {
    return @shuffle(
        u16,
        vec,
        undefined,
        types.u16x4{ 0, 1, 2, 3 },
    );
}

test vget_low_u16 {
    const vec: types.u16x8 = @splat(1);
    const expected: types.u16x4 = .{ 1, 1, 1, 1 };
    try common.testIntrinsic("vget_low_u16", vget_low_u16, expected, .{vec}, null);
}

/// Get low elements of a uint32x4_t vector
pub inline fn vget_low_u32(vec: types.u32x4) types.u32x2 {
    return @shuffle(
        u32,
        vec,
        undefined,
        types.u32x2{ 0, 1 },
    );
}

test vget_low_u32 {
    const vec: types.u32x4 = @splat(1);
    const expected: types.u32x2 = .{ 1, 1 };
    try common.testIntrinsic("vget_low_u32", vget_low_u32, expected, .{vec}, null);
}

/// Get low elements of a uint64x2_t vector
pub inline fn vget_low_u64(vec: types.u64x2) types.u64x1 {
    return @shuffle(
        u64,
        vec,
        undefined,
        types.u64x1{0},
    );
}

test vget_low_u64 {
    const vec: types.u64x2 = @splat(1);
    const expected: types.u64x1 = .{1};
    try common.testIntrinsic("vget_low_u64", vget_low_u64, expected, .{vec}, null);
}

/// Get low elements of a poly8x16_t vector
pub inline fn vget_low_p8(vec: types.p8x16) types.p8x8 {
    return @shuffle(
        types.p8,
        vec,
        undefined,
        types.p8x8{ 0, 1, 2, 3, 4, 5, 6, 7 },
    );
}

test vget_low_p8 {
    const vec: types.p8x16 = @splat(1);
    const expected: types.p8x8 = .{ 1, 1, 1, 1, 1, 1, 1, 1 };
    try common.testIntrinsic("vget_low_p8", vget_low_p8, expected, .{vec}, null);
}

/// Get low elements of a poly16x8_t vector
pub inline fn vget_low_p16(vec: types.p16x8) types.p16x4 {
    return @shuffle(
        types.p16,
        vec,
        undefined,
        types.p16x4{ 0, 1, 2, 3 },
    );
}

test vget_low_p16 {
    const vec: types.p16x8 = @splat(1);
    const expected: types.p16x4 = .{ 1, 1, 1, 1 };
    try common.testIntrinsic("vget_low_p16", vget_low_p16, expected, .{vec}, null);
}

/// Get low elements of a float16x8_t vector
pub inline fn vget_low_f16(vec: types.f16x8) types.f16x4 {
    return @shuffle(
        f16,
        vec,
        undefined,
        types.f16x4{ 0, 1, 2, 3 },
    );
}

test vget_low_f16 {
    const vec: types.f16x8 = @splat(1.0);
    const expected: types.f16x4 = .{ 1, 1, 1, 1 };
    try common.testIntrinsic("vget_low_f16", vget_low_f16, expected, .{vec}, null);
}

/// Get low elements of a float32x4_t vector
pub inline fn vget_low_f32(vec: types.f32x4) types.f32x2 {
    return @shuffle(
        f32,
        vec,
        undefined,
        types.f32x2{ 0, 1 },
    );
}

test vget_low_f32 {
    const vec: types.f32x4 = @splat(1.0);
    const expected: types.f32x2 = .{ 1, 1 };
    try common.testIntrinsic("vget_low_f32", vget_low_f32, expected, .{vec}, null);
}

/// Get low elements of a float64x2_t vector
pub inline fn vget_low_f64(vec: types.f64x2) types.f64x1 {
    return @shuffle(
        f64,
        vec,
        undefined,
        types.f64x1{0},
    );
}

test vget_low_f64 {
    const vec: types.f64x2 = @splat(1.0);
    const expected: types.f64x1 = .{1};
    try common.testIntrinsic("vget_low_f64", vget_low_f64, expected, .{vec}, null);
}

/// Unsigned Move vector element to general-purpose register
pub inline fn vget_lane_p8(vec: types.p8x8, comptime lane: usize) types.p8 {
    return vec[lane];
}

test vget_lane_p8 {
    const v: types.p8x8 = .{ 0, 1, 2, 3, 4, 5, 6, 7 };
    const lane: usize = 6;
    const expected: types.p8 = 6;

    try common.testIntrinsic("vget_lane_p8", vget_lane_p8, expected, .{ v, lane }, null);
}

/// Unsigned Move vector element to general-purpose register
pub inline fn vget_lane_p16(vec: types.p16x4, comptime lane: usize) types.p16 {
    return vec[lane];
}

test vget_lane_p16 {
    const v: types.p16x4 = .{ 0, 1, 2, 3 };
    const lane: usize = 2;
    const expected: types.p16 = 2;

    try common.testIntrinsic("vget_lane_p16", vget_lane_p16, expected, .{ v, lane }, null);
}

/// Unsigned Move vector element to general-purpose register
pub inline fn vget_lane_p64(vec: types.p64x1, comptime lane: usize) types.p64 {
    return vec[lane];
}

test vget_lane_p64 {
    const v: types.p64x1 = .{std.math.maxInt(types.p64)};
    const lane: usize = 0;
    const expected: types.p64 = std.math.maxInt(types.p64);

    try common.testIntrinsic("vget_lane_p64", vget_lane_p64, expected, .{ v, lane }, null);
}

/// Signed Move vector element to general-purpose register
pub inline fn vget_lane_s8(vec: types.i8x8, comptime lane: usize) i8 {
    return vec[lane];
}

test vget_lane_s8 {
    const v: types.i8x8 = .{ 0, 1, 2, 3, 4, 5, 6, 7 };
    const lane: usize = 5;
    const expected: i8 = 5;

    try common.testIntrinsic("vget_lane_s8", vget_lane_s8, expected, .{ v, lane }, null);
}

/// Signed Move vector element to general-purpose register
pub inline fn vget_lane_s16(vec: types.i16x4, comptime lane: usize) i16 {
    return vec[lane];
}

test vget_lane_s16 {
    const v: types.i16x4 = .{ 0, 1, 2, 3 };
    const lane: usize = 2;
    const expected: i16 = 2;

    try common.testIntrinsic("vget_lane_s16", vget_lane_s16, expected, .{ v, lane }, null);
}

/// Signed Move vector element to general-purpose register
pub inline fn vget_lane_s32(vec: types.i32x2, comptime lane: usize) i32 {
    return vec[lane];
}

test vget_lane_s32 {
    const v: types.i32x2 = .{ 0, 1 };
    const lane: usize = 0;
    const expected: i32 = 0;

    try common.testIntrinsic("vget_lane_s32", vget_lane_s32, expected, .{ v, lane }, null);
}

/// Signed Move vector element to general-purpose register
pub inline fn vget_lane_s64(vec: types.i64x1, comptime lane: usize) i64 {
    return vec[lane];
}

test vget_lane_s64 {
    const v: types.i64x1 = .{std.math.maxInt(i64)};
    const lane: usize = 0;
    const expected: i64 = std.math.maxInt(i64);

    try common.testIntrinsic("vget_lane_s64", vget_lane_s64, expected, .{ v, lane }, null);
}

/// Unigned Move vector element to general-purpose register
pub inline fn vget_lane_u8(vec: types.u8x8, comptime lane: usize) u8 {
    return vec[lane];
}

test vget_lane_u8 {
    const v: types.u8x8 = .{ 0, 1, 2, 3, 4, 5, 6, 7 };
    const lane: usize = 5;
    const expected: u8 = 5;

    try common.testIntrinsic("vget_lane_u8", vget_lane_u8, expected, .{ v, lane }, null);
}

/// Unigned Move vector element to general-purpose register
pub inline fn vget_lane_u16(vec: types.u16x4, comptime lane: usize) u16 {
    return vec[lane];
}

test vget_lane_u16 {
    const v: types.u16x4 = .{ 0, 1, 2, 3 };
    const lane: usize = 2;
    const expected: u16 = 2;

    try common.testIntrinsic("vget_lane_u16", vget_lane_u16, expected, .{ v, lane }, null);
}

/// Unigned Move vector element to general-purpose register
pub inline fn vget_lane_u32(vec: types.u32x2, comptime lane: usize) u32 {
    return vec[lane];
}

test vget_lane_u32 {
    const v: types.u32x2 = .{ 0, 1 };
    const lane: usize = 0;
    const expected: u32 = 0;

    try common.testIntrinsic("vget_lane_u32", vget_lane_u32, expected, .{ v, lane }, null);
}

/// Unigned Move vector element to general-purpose register
pub inline fn vget_lane_u64(vec: types.u64x1, comptime lane: usize) u64 {
    return vec[lane];
}

test vget_lane_u64 {
    const v: types.u64x1 = .{std.math.maxInt(u64)};
    const lane: usize = 0;
    const expected: u64 = std.math.maxInt(u64);

    try common.testIntrinsic("vget_lane_u64", vget_lane_u64, expected, .{ v, lane }, null);
}

/// Duplicate vector element to vector or scalar (for floating-point)
pub inline fn vget_lane_f32(vec: types.f32x2, comptime lane: usize) f32 {
    comptime assert(lane < 2);
        return vec[lane];
}

test vget_lane_f32 {
    const v: types.f32x2 = .{ 5, 1 };
    const lane: usize = 0;
    const expected: f32 = 5;

    try common.testIntrinsic("vget_lane_f32", vget_lane_f32, expected, .{ v, lane }, null);
}

/// Floating-point Move vector element to general-purpose register
pub inline fn vget_lane_f64(vec: types.f64x1, comptime lane: usize) f64 {
    return vec[lane];
}

test vget_lane_f64 {
    const v: types.f64x1 = .{std.math.floatMax(f64)};
    const lane: usize = 0;
    const expected: f64 = std.math.floatMax(f64);

    try common.testIntrinsic("vget_lane_f64", vget_lane_f64, expected, .{ v, lane }, null);
}

/// Duplicate vector element to vector or scalar
pub inline fn vdupq_n_u8(scalar: u8) types.u8x16 {
    return @splat(scalar);
}

test vdupq_n_u8 {
    try common.testIntrinsic("vdupq_n_u8", vdupq_n_u8, types.u8x16{ 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5 }, .{5}, null);
    try common.testIntrinsic("vdupq_n_u8", vdupq_n_u8, types.u8x16{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }, .{0}, null);
    try common.testIntrinsic("vdupq_n_u8", vdupq_n_u8, types.u8x16{ std.math.maxInt(u8), std.math.maxInt(u8), std.math.maxInt(u8), std.math.maxInt(u8), std.math.maxInt(u8), std.math.maxInt(u8), std.math.maxInt(u8), std.math.maxInt(u8), std.math.maxInt(u8), std.math.maxInt(u8), std.math.maxInt(u8), std.math.maxInt(u8), std.math.maxInt(u8), std.math.maxInt(u8), std.math.maxInt(u8), std.math.maxInt(u8) }, .{std.math.maxInt(u8)}, null);
}

/// Duplicate vector element to vector or scalar
pub inline fn vdupq_n_u16(scalar: u16) types.u16x8 {
    return @splat(scalar);
}

test vdupq_n_u16 {
    try common.testIntrinsic("vdupq_n_u16", vdupq_n_u16, types.u16x8{ 5, 5, 5, 5, 5, 5, 5, 5 }, .{5}, null);
    try common.testIntrinsic("vdupq_n_u16", vdupq_n_u16, types.u16x8{ 0, 0, 0, 0, 0, 0, 0, 0 }, .{0}, null);
    try common.testIntrinsic("vdupq_n_u16", vdupq_n_u16, types.u16x8{ std.math.maxInt(u16), std.math.maxInt(u16), std.math.maxInt(u16), std.math.maxInt(u16), std.math.maxInt(u16), std.math.maxInt(u16), std.math.maxInt(u16), std.math.maxInt(u16) }, .{std.math.maxInt(u16)}, null);
}

/// Duplicate vector element to vector or scalar
pub inline fn vdupq_n_u32(scalar: u32) types.u32x4 {
    return @splat(scalar);
}

test vdupq_n_u32 {
    try common.testIntrinsic("vdupq_n_u32", vdupq_n_u32, types.u32x4{ 5, 5, 5, 5 }, .{5}, null);
    try common.testIntrinsic("vdupq_n_u32", vdupq_n_u32, types.u32x4{ 0, 0, 0, 0 }, .{0}, null);
    try common.testIntrinsic("vdupq_n_u32", vdupq_n_u32, types.u32x4{ std.math.maxInt(u32), std.math.maxInt(u32), std.math.maxInt(u32), std.math.maxInt(u32) }, .{std.math.maxInt(u32)}, null);
}

/// Duplicate vector element to vector or scalar
pub inline fn vdupq_n_u64(scalar: u64) types.u64x2 {
    return @splat(scalar);
}

test vdupq_n_u64 {
    try common.testIntrinsic("vdupq_n_u64", vdupq_n_u64, types.u64x2{ 5, 5 }, .{5}, null);
    try common.testIntrinsic("vdupq_n_u64", vdupq_n_u64, types.u64x2{ 0, 0 }, .{0}, null);
    try common.testIntrinsic("vdupq_n_u64", vdupq_n_u64, types.u64x2{ std.math.maxInt(u64), std.math.maxInt(u64) }, .{std.math.maxInt(u64)}, null);
}

/// Duplicate vector element to vector or scalar
pub inline fn vdupq_n_s8(scalar: i8) types.i8x16 {
    return @splat(scalar);
}

test vdupq_n_s8 {
    try common.testIntrinsic("vdupq_n_s8", vdupq_n_s8, types.i8x16{ 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5 }, .{5}, null);
    try common.testIntrinsic("vdupq_n_s8", vdupq_n_s8, types.i8x16{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }, .{0}, null);
    try common.testIntrinsic("vdupq_n_s8", vdupq_n_s8, types.i8x16{ std.math.maxInt(i8), std.math.maxInt(i8), std.math.maxInt(i8), std.math.maxInt(i8), std.math.maxInt(i8), std.math.maxInt(i8), std.math.maxInt(i8), std.math.maxInt(i8), std.math.maxInt(i8), std.math.maxInt(i8), std.math.maxInt(i8), std.math.maxInt(i8), std.math.maxInt(i8), std.math.maxInt(i8), std.math.maxInt(i8), std.math.maxInt(i8) }, .{std.math.maxInt(i8)}, null);
}

/// Duplicate vector element to vector or scalar
pub inline fn vdupq_n_s16(scalar: i16) types.i16x8 {
    return @splat(scalar);
}

test vdupq_n_s16 {
    try common.testIntrinsic("vdupq_n_s16", vdupq_n_s16, types.i16x8{ 5, 5, 5, 5, 5, 5, 5, 5 }, .{5}, null);
    try common.testIntrinsic("vdupq_n_s16", vdupq_n_s16, types.i16x8{ 0, 0, 0, 0, 0, 0, 0, 0 }, .{0}, null);
    try common.testIntrinsic("vdupq_n_s16", vdupq_n_s16, types.i16x8{ std.math.maxInt(i16), std.math.maxInt(i16), std.math.maxInt(i16), std.math.maxInt(i16), std.math.maxInt(i16), std.math.maxInt(i16), std.math.maxInt(i16), std.math.maxInt(i16) }, .{std.math.maxInt(i16)}, null);
}

/// Duplicate vector element to vector or scalar
pub inline fn vdupq_n_s32(scalar: i32) types.i32x4 {
    return @splat(scalar);
}

test vdupq_n_s32 {
    try common.testIntrinsic("vdupq_n_s32", vdupq_n_s32, types.i32x4{ 5, 5, 5, 5 }, .{5}, null);
    try common.testIntrinsic("vdupq_n_s32", vdupq_n_s32, types.i32x4{ 0, 0, 0, 0 }, .{0}, null);
    try common.testIntrinsic("vdupq_n_s32", vdupq_n_s32, types.i32x4{ std.math.maxInt(i32), std.math.maxInt(i32), std.math.maxInt(i32), std.math.maxInt(i32) }, .{std.math.maxInt(i32)}, null);
}

/// Duplicate vector element to vector or scalar
pub inline fn vdupq_n_s64(scalar: i64) types.i64x2 {
    return @splat(scalar);
}

test vdupq_n_s64 {
    try common.testIntrinsic("vdupq_n_s64", vdupq_n_s64, types.i64x2{ 5, 5 }, .{5}, null);
    try common.testIntrinsic("vdupq_n_s64", vdupq_n_s64, types.i64x2{ 0, 0 }, .{0}, null);
    try common.testIntrinsic("vdupq_n_s64", vdupq_n_s64, types.i64x2{ std.math.maxInt(i64), std.math.maxInt(i64) }, .{std.math.maxInt(i64)}, null);
}

/// Duplicate vector element to vector or scalar
pub inline fn vdupq_n_p8(scalar: types.p8) types.p8x16 {
    return @splat(scalar);
}

test vdupq_n_p8 {
    try common.testIntrinsic("vdupq_n_p8", vdupq_n_p8, types.p8x16{ 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5 }, .{5}, null);
    try common.testIntrinsic("vdupq_n_p8", vdupq_n_p8, types.p8x16{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }, .{0}, null);
    try common.testIntrinsic("vdupq_n_p8", vdupq_n_p8, types.p8x16{ std.math.maxInt(types.p8), std.math.maxInt(types.p8), std.math.maxInt(types.p8), std.math.maxInt(types.p8), std.math.maxInt(types.p8), std.math.maxInt(types.p8), std.math.maxInt(types.p8), std.math.maxInt(types.p8), std.math.maxInt(types.p8), std.math.maxInt(types.p8), std.math.maxInt(types.p8), std.math.maxInt(types.p8), std.math.maxInt(types.p8), std.math.maxInt(types.p8), std.math.maxInt(types.p8), std.math.maxInt(types.p8) }, .{std.math.maxInt(types.p8)}, null);
}

/// Duplicate vector element to vector or scalar
pub inline fn vdupq_n_p16(scalar: types.p16) types.p16x8 {
    return @splat(scalar);
}

/// Duplicate vector element to vector or scalar
pub inline fn vdupq_n_p64(scalar: types.p64) types.p64x2 {
    return @splat(scalar);
}

test vdupq_n_p64 {
    try common.testIntrinsic("vdupq_n_p64", vdupq_n_p64, types.p64x2{ 5, 5 }, .{5}, null);
    try common.testIntrinsic("vdupq_n_p64", vdupq_n_p64, types.p64x2{ 0, 0 }, .{0}, null);
    try common.testIntrinsic("vdupq_n_p64", vdupq_n_p64, types.p64x2{ std.math.maxInt(u64), std.math.maxInt(u64) }, .{std.math.maxInt(u64)}, null);
}

test vdupq_n_p16 {
    try common.testIntrinsic("vdupq_n_p16", vdupq_n_p16, types.p16x8{ 5, 5, 5, 5, 5, 5, 5, 5 }, .{5}, null);
    try common.testIntrinsic("vdupq_n_p16", vdupq_n_p16, types.p16x8{ 0, 0, 0, 0, 0, 0, 0, 0 }, .{0}, null);
    try common.testIntrinsic("vdupq_n_p16", vdupq_n_p16, types.p16x8{ std.math.maxInt(types.p16), std.math.maxInt(types.p16), std.math.maxInt(types.p16), std.math.maxInt(types.p16), std.math.maxInt(types.p16), std.math.maxInt(types.p16), std.math.maxInt(types.p16), std.math.maxInt(types.p16) }, .{std.math.maxInt(types.p16)}, null);
}

/// Duplicate vector element to vector or scalar
pub inline fn vdupq_n_f16(scalar: f16) types.f16x8 {
    return @splat(scalar);
}

test vdupq_n_f16 {
    try common.testIntrinsic("vdupq_n_f16", vdupq_n_f16, types.f16x8{ 5, 5, 5, 5, 5, 5, 5, 5 }, .{5}, null);
    try common.testIntrinsic("vdupq_n_f16", vdupq_n_f16, types.f16x8{ 0, 0, 0, 0, 0, 0, 0, 0 }, .{0}, null);
    try common.testIntrinsic("vdupq_n_f16", vdupq_n_f16, types.f16x8{ std.math.floatMax(f16), std.math.floatMax(f16), std.math.floatMax(f16), std.math.floatMax(f16), std.math.floatMax(f16), std.math.floatMax(f16), std.math.floatMax(f16), std.math.floatMax(f16) }, .{std.math.floatMax(f16)}, null);
}

/// Duplicate vector element to vector or scalar
pub inline fn vdupq_n_f32(scalar: f32) types.f32x4 {
    return @splat(scalar);
}

test vdupq_n_f32 {
    try common.testIntrinsic("vdupq_n_f32", vdupq_n_f32, types.f32x4{ 5, 5, 5, 5 }, .{5}, null);
    try common.testIntrinsic("vdupq_n_f32", vdupq_n_f32, types.f32x4{ 0, 0, 0, 0 }, .{0}, null);
    try common.testIntrinsic("vdupq_n_f32", vdupq_n_f32, types.f32x4{ std.math.floatMax(f32), std.math.floatMax(f32), std.math.floatMax(f32), std.math.floatMax(f32) }, .{std.math.floatMax(f32)}, null);
}

/// Duplicate vector element to vector or scalar
pub inline fn vdupq_n_f64(scalar: f64) types.f64x2 {
    return @splat(scalar);
}

test vdupq_n_f64 {
    try common.testIntrinsic("vdupq_n_f64", vdupq_n_f64, types.f64x2{ 5, 5 }, .{5}, null);
    try common.testIntrinsic("vdupq_n_f64", vdupq_n_f64, types.f64x2{ 0, 0 }, .{0}, null);
    try common.testIntrinsic("vdupq_n_f64", vdupq_n_f64, types.f64x2{ std.math.floatMax(f64), std.math.floatMax(f64) }, .{std.math.floatMax(f64)}, null);
}

/// Zip vectors
pub inline fn vzip1_s8(a: types.i8x8, b: types.i8x8) types.i8x8 {
    return @shuffle(i8, a, b, types.i8x8{ 0, ~@as(i8, 0), 1, ~@as(i8, 1), 2, ~@as(i8, 2), 3, ~@as(i8, 3) });
}

test vzip1_s8 {
    const a: types.i8x8 = .{ 0, 2, 4, 6, 8, 10, 12, 14 };
    const b: types.i8x8 = .{ 1, 3, 5, 7, 9, 11, 13, 15 };
    const expected: types.i8x8 = .{ 0, 1, 2, 3, 4, 5, 6, 7 };

    try common.testIntrinsic("vzip1_s8", vzip1_s8, expected, .{ a, b }, null);
}

/// Zip vectors
pub inline fn vzip1_s16(a: types.i16x4, b: types.i16x4) types.i16x4 {
    return @shuffle(i16, a, b, types.i16x4{ 0, ~@as(i16, 0), 1, ~@as(i16, 1) });
}

test vzip1_s16 {
    const a: types.i16x4 = .{ 0, 2, 4, 6 };
    const b: types.i16x4 = .{ 1, 3, 5, 7 };
    const expected: types.i16x4 = .{ 0, 1, 2, 3 };

    try common.testIntrinsic("vzip1_s16", vzip1_s16, expected, .{ a, b }, null);
}

/// Zip vectors
pub inline fn vzip1_s32(a: types.i32x2, b: types.i32x2) types.i32x2 {
    return @shuffle(i32, a, b, types.i32x2{ 0, ~@as(i32, 0) });
}

test vzip1_s32 {
    const a: types.i32x2 = .{ 0, 2 };
    const b: types.i32x2 = .{ 1, 3 };
    const expected: types.i32x2 = .{ 0, 1 };

    try common.testIntrinsic("vzip1_s32", vzip1_s32, expected, .{ a, b }, null);
}

/// Zip vectors
pub inline fn vzip1_u8(a: types.u8x8, b: types.u8x8) types.u8x8 {
    return @shuffle(u8, a, b, types.i8x8{ 0, ~@as(i8, 0), 1, ~@as(i8, 1), 2, ~@as(i8, 2), 3, ~@as(i8, 3) });
}

test vzip1_u8 {
    const a: types.u8x8 = .{ 0, 2, 4, 6, 8, 10, 12, 14 };
    const b: types.u8x8 = .{ 1, 3, 5, 7, 9, 11, 13, 15 };
    const expected: types.u8x8 = .{ 0, 1, 2, 3, 4, 5, 6, 7 };

    try common.testIntrinsic("vzip1_u8", vzip1_u8, expected, .{ a, b }, null);
}

/// Zip vectors
pub inline fn vzip1_u16(a: types.u16x4, b: types.u16x4) types.u16x4 {
    return @shuffle(u16, a, b, types.i16x4{ 0, ~@as(i16, 0), 1, ~@as(i16, 1) });
}

test vzip1_u16 {
    const a: types.u16x4 = .{ 0, 2, 4, 6 };
    const b: types.u16x4 = .{ 1, 3, 5, 7 };
    const expected: types.u16x4 = .{ 0, 1, 2, 3 };

    try common.testIntrinsic("vzip1_u16", vzip1_u16, expected, .{ a, b }, null);
}

/// Zip vectors
pub inline fn vzip1_u32(a: types.u32x2, b: types.u32x2) types.u32x2 {
    return @shuffle(u32, a, b, types.i32x2{ 0, ~@as(i32, 0) });
}

test vzip1_u32 {
    const a: types.u32x2 = .{ 0, 2 };
    const b: types.u32x2 = .{ 1, 3 };
    const expected: types.u32x2 = .{ 0, 1 };

    try common.testIntrinsic("vzip1_u32", vzip1_u32, expected, .{ a, b }, null);
}

/// Zip vectors
pub inline fn vzip1_f32(a: types.f32x2, b: types.f32x2) types.f32x2 {
    return @shuffle(f32, a, b, types.i32x2{ 0, ~@as(i32, 0) });
}

test vzip1_f32 {
    const a: types.f32x2 = .{ 0, 2 };
    const b: types.f32x2 = .{ 1, 3 };
    const expected: types.f32x2 = .{ 0, 1 };

    try common.testIntrinsic("vzip1_f32", vzip1_f32, expected, .{ a, b }, null);
}

/// Zip vectors
pub inline fn vzip2_s8(a: types.i8x8, b: types.i8x8) types.i8x8 {
    return @shuffle(i8, a, b, types.i8x8{ 4, ~@as(i8, 4), 5, ~@as(i8, 5), 6, ~@as(i8, 6), 7, ~@as(i8, 7) });
}

test vzip2_s8 {
    const a: types.i8x8 = .{ 0, 16, 16, 18, 16, 18, 20, 22 };
    const b: types.i8x8 = .{ 1, 17, 17, 19, 17, 19, 21, 23 };
    const expected: types.i8x8 = .{ 16, 17, 18, 19, 20, 21, 22, 23 };

    try common.testIntrinsic("vzip2_s8", vzip2_s8, expected, .{ a, b }, null);
}

/// Zip vectors
pub inline fn vzip2_s16(a: types.i16x4, b: types.i16x4) types.i16x4 {
    return @shuffle(i16, a, b, types.i16x4{ 2, ~@as(i16, 2), 3, ~@as(i16, 3) });
}

test vzip2_s16 {
    const a: types.i16x4 = .{ 0, 16, 16, 18 };
    const b: types.i16x4 = .{ 1, 17, 17, 19 };
    const expected: types.i16x4 = .{ 16, 17, 18, 19 };

    try common.testIntrinsic("vzip2_s16", vzip2_s16, expected, .{ a, b }, null);
}

/// Zip vectors
pub inline fn vzip2_s32(a: types.i32x2, b: types.i32x2) types.i32x2 {
    return @shuffle(i32, a, b, types.i32x2{ 1, ~@as(i32, 1) });
}

test vzip2_s32 {
    const a: types.i32x2 = .{ 0, 16 };
    const b: types.i32x2 = .{ 1, 17 };
    const expected: types.i32x2 = .{ 16, 17 };

    try common.testIntrinsic("vzip2_s32", vzip2_s32, expected, .{ a, b }, null);
}

/// Zip vectors
pub inline fn vzip2_u8(a: types.u8x8, b: types.u8x8) types.u8x8 {
    return @shuffle(u8, a, b, types.i8x8{ 4, ~@as(i8, 4), 5, ~@as(i8, 5), 6, ~@as(i8, 6), 7, ~@as(i8, 7) });
}

test vzip2_u8 {
    const a: types.u8x8 = .{ 0, 16, 16, 18, 16, 18, 20, 22 };
    const b: types.u8x8 = .{ 1, 17, 17, 19, 17, 19, 21, 23 };
    const expected: types.u8x8 = .{ 16, 17, 18, 19, 20, 21, 22, 23 };

    try common.testIntrinsic("vzip2_u8", vzip2_u8, expected, .{ a, b }, null);
}

/// Zip vectors
pub inline fn vzip2_u16(a: types.u16x4, b: types.u16x4) types.u16x4 {
    return @shuffle(u16, a, b, types.i16x4{ 2, ~@as(i16, 2), 3, ~@as(i16, 3) });
}

test vzip2_u16 {
    const a: types.u16x4 = .{ 0, 16, 16, 18 };
    const b: types.u16x4 = .{ 1, 17, 17, 19 };
    const expected: types.u16x4 = .{ 16, 17, 18, 19 };

    try common.testIntrinsic("vzip2_u16", vzip2_u16, expected, .{ a, b }, null);
}

/// Zip vectors
pub inline fn vzip2_u32(a: types.u32x2, b: types.u32x2) types.u32x2 {
    return @shuffle(u32, a, b, types.i32x2{ 1, ~@as(i32, 1) });
}

test vzip2_u32 {
    const a: types.u32x2 = .{ 0, 16 };
    const b: types.u32x2 = .{ 1, 17 };
    const expected: types.u32x2 = .{ 16, 17 };

    try common.testIntrinsic("vzip2_u32", vzip2_u32, expected, .{ a, b }, null);
}

/// Zip vectors
pub inline fn vzip2_f32(a: types.f32x2, b: types.f32x2) types.f32x2 {
    return @shuffle(f32, a, b, types.i32x2{ 1, ~@as(i32, 1) });
}

test vzip2_f32 {
    const a: types.f32x2 = .{ 0, 16 };
    const b: types.f32x2 = .{ 1, 17 };
    const expected: types.f32x2 = .{ 16, 17 };

    try common.testIntrinsic("vzip2_f32", vzip2_f32, expected, .{ a, b }, null);
}

/// Zip vectors
pub inline fn vzip1q_s8(a: types.i8x16, b: types.i8x16) types.i8x16 {
    return @shuffle(i8, a, b, types.i8x16{ 0, ~@as(i8, 0), 1, ~@as(i8, 1), 2, ~@as(i8, 2), 3, ~@as(i8, 3), 4, ~@as(i8, 4), 5, ~@as(i8, 5), 6, ~@as(i8, 6), 7, ~@as(i8, 7) });
}

test vzip1q_s8 {
    const a: types.i8x16 = .{ 0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30 };
    const b: types.i8x16 = .{ 1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29, 31 };
    const expected: types.i8x16 = .{ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 };

    try common.testIntrinsic("vzip1q_s8", vzip1q_s8, expected, .{ a, b }, null);
}

/// Zip vectors
pub inline fn vzip1q_s16(a: types.i16x8, b: types.i16x8) types.i16x8 {
    return @shuffle(i16, a, b, types.i16x8{ 0, ~@as(i16, 0), 1, ~@as(i16, 1), 2, ~@as(i16, 2), 3, ~@as(i16, 3) });
}

test vzip1q_s16 {
    const a: types.i16x8 = .{ 0, 2, 4, 6, 8, 10, 12, 14 };
    const b: types.i16x8 = .{ 1, 3, 5, 7, 9, 11, 13, 15 };
    const expected: types.i16x8 = .{ 0, 1, 2, 3, 4, 5, 6, 7 };

    try common.testIntrinsic("vzip1q_s16", vzip1q_s16, expected, .{ a, b }, null);
}

/// Zip vectors
pub inline fn vzip1q_s32(a: types.i32x4, b: types.i32x4) types.i32x4 {
    return @shuffle(i32, a, b, types.i32x4{ 0, ~@as(i32, 0), 1, ~@as(i32, 1) });
}

test vzip1q_s32 {
    const a: types.i32x4 = .{ 0, 2, 4, 6 };
    const b: types.i32x4 = .{ 1, 3, 5, 7 };
    const expected: types.i32x4 = .{ 0, 1, 2, 3 };

    try common.testIntrinsic("vzip1q_s32", vzip1q_s32, expected, .{ a, b }, null);
}

/// Zip vectors
pub inline fn vzip1q_s64(a: types.i64x2, b: types.i64x2) types.i64x2 {
    return @shuffle(i64, a, b, types.i64x2{ 0, ~@as(i64, 0) });
}

test vzip1q_s64 {
    const a: types.i64x2 = .{ 0, 2 };
    const b: types.i64x2 = .{ 1, 3 };
    const expected: types.i64x2 = .{ 0, 1 };

    try common.testIntrinsic("vzip1q_s64", vzip1q_s64, expected, .{ a, b }, null);
}

/// Zip vectors
pub inline fn vzip1q_u8(a: types.u8x16, b: types.u8x16) types.u8x16 {
    return @shuffle(u8, a, b, types.i8x16{ 0, ~@as(i8, 0), 1, ~@as(i8, 1), 2, ~@as(i8, 2), 3, ~@as(i8, 3), 4, ~@as(i8, 4), 5, ~@as(i8, 5), 6, ~@as(i8, 6), 7, ~@as(i8, 7) });
}

test vzip1q_u8 {
    const a: types.u8x16 = .{ 0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30 };
    const b: types.u8x16 = .{ 1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29, 31 };
    const expected: types.u8x16 = .{ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 };

    try common.testIntrinsic("vzip1q_u8", vzip1q_u8, expected, .{ a, b }, null);
}

/// Zip vectors
pub inline fn vzip1q_u16(a: types.u16x8, b: types.u16x8) types.u16x8 {
    return @shuffle(u16, a, b, types.i16x8{ 0, ~@as(i16, 0), 1, ~@as(i16, 1), 2, ~@as(i16, 2), 3, ~@as(i16, 3) });
}

test vzip1q_u16 {
    const a: types.u16x8 = .{ 0, 2, 4, 6, 8, 10, 12, 14 };
    const b: types.u16x8 = .{ 1, 3, 5, 7, 9, 11, 13, 15 };
    const expected: types.u16x8 = .{ 0, 1, 2, 3, 4, 5, 6, 7 };

    try common.testIntrinsic("vzip1q_u16", vzip1q_u16, expected, .{ a, b }, null);
}

/// Zip vectors
pub inline fn vzip1q_u32(a: types.u32x4, b: types.u32x4) types.u32x4 {
    return @shuffle(u32, a, b, types.i32x4{ 0, ~@as(i32, 0), 1, ~@as(i32, 1) });
}

test vzip1q_u32 {
    const a: types.u32x4 = .{ 0, 2, 4, 6 };
    const b: types.u32x4 = .{ 1, 3, 5, 7 };
    const expected: types.u32x4 = .{ 0, 1, 2, 3 };

    try common.testIntrinsic("vzip1q_u32", vzip1q_u32, expected, .{ a, b }, null);
}

/// Zip vectors
pub inline fn vzip1q_u64(a: types.u64x2, b: types.u64x2) types.u64x2 {
    return @shuffle(u64, a, b, types.i64x2{ 0, ~@as(i64, 0) });
}

test vzip1q_u64 {
    const a: types.u64x2 = .{ 0, 2 };
    const b: types.u64x2 = .{ 1, 3 };
    const expected: types.u64x2 = .{ 0, 1 };

    try common.testIntrinsic("vzip1q_u64", vzip1q_u64, expected, .{ a, b }, null);
}

/// Zip vectors
pub inline fn vzip1q_f32(a: types.f32x4, b: types.f32x4) types.f32x4 {
    return @shuffle(f32, a, b, types.i32x4{ 0, ~@as(i32, 0), 1, ~@as(i32, 1) });
}

/// Zip vectors
pub inline fn vzip1q_p8(a: types.p8x16, b: types.p8x16) types.p8x16 {
    return @shuffle(u8, a, b, types.i8x16{ 0, ~@as(i8, 0), 1, ~@as(i8, 1), 2, ~@as(i8, 2), 3, ~@as(i8, 3), 4, ~@as(i8, 4), 5, ~@as(i8, 5), 6, ~@as(i8, 6), 7, ~@as(i8, 7) });
}

test vzip1q_p8 {
    const a: types.u8x16 = .{ 0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30 };
    const b: types.u8x16 = .{ 1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29, 31 };
    const expected: types.u8x16 = .{ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 };

    try common.testIntrinsic("vzip1q_u8", vzip1q_u8, expected, .{ a, b }, null);
}

/// Zip vectors
pub inline fn vzip1q_p16(a: types.p16x8, b: types.p16x8) types.p16x8 {
    return @shuffle(u16, a, b, types.i16x8{ 0, ~@as(i16, 0), 1, ~@as(i16, 1), 2, ~@as(i16, 2), 3, ~@as(i16, 3) });
}

test vzip1q_p16 {
    const a: types.u16x8 = .{ 0, 2, 4, 6, 8, 10, 12, 14 };
    const b: types.u16x8 = .{ 1, 3, 5, 7, 9, 11, 13, 15 };
    const expected: types.u16x8 = .{ 0, 1, 2, 3, 4, 5, 6, 7 };

    try common.testIntrinsic("vzip1q_u16", vzip1q_u16, expected, .{ a, b }, null);
}

/// Zip vectors
pub inline fn vzip1q_p64(a: types.p64x2, b: types.p64x2) types.p64x2 {
    return @shuffle(u64, a, b, types.i64x2{ 0, ~@as(i64, 0) });
}

test vzip1q_p64 {
    const a: types.u64x2 = .{ 0, 2 };
    const b: types.u64x2 = .{ 1, 3 };
    const expected: types.u64x2 = .{ 0, 1 };

    try common.testIntrinsic("vzip1q_p64", vzip1q_p64, expected, .{ a, b }, null);
}

test vzip1q_f32 {
    const a: types.f32x4 = .{ 0, 2, 4, 6 };
    const b: types.f32x4 = .{ 1, 3, 5, 7 };
    const expected: types.f32x4 = .{ 0, 1, 2, 3 };

    try common.testIntrinsic("vzip1q_f32", vzip1q_f32, expected, .{ a, b }, null);
}

/// Zip vectors
pub inline fn vzip1q_f64(a: types.f64x2, b: types.f64x2) types.f64x2 {
    return @shuffle(f64, a, b, types.i64x2{ 0, ~@as(i64, 0) });
}

test vzip1q_f64 {
    const a: types.f64x2 = .{ 0, 2 };
    const b: types.f64x2 = .{ 1, 3 };
    const expected: types.f64x2 = .{ 0, 1 };

    try common.testIntrinsic("vzip1q_f64", vzip1q_f64, expected, .{ a, b }, null);
}

/// Zip vectors
pub inline fn vzip2q_s8(a: types.i8x16, b: types.i8x16) types.i8x16 {
    return @shuffle(i8, a, b, types.i8x16{ 8, ~@as(i8, 8), 9, ~@as(i8, 9), 10, ~@as(i8, 10), 11, ~@as(i8, 11), 12, ~@as(i8, 12), 13, ~@as(i8, 13), 14, ~@as(i8, 14), 15, ~@as(i8, 15) });
}

test vzip2q_s8 {
    const a: types.i8x16 = .{ 0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30 };
    const b: types.i8x16 = .{ 1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29, 31 };
    const expected: types.i8x16 = .{ 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31 };

    try common.testIntrinsic("vzip2q_s8", vzip2q_s8, expected, .{ a, b }, null);
}

/// Zip vectors
pub inline fn vzip2q_s16(a: types.i16x8, b: types.i16x8) types.i16x8 {
    return @shuffle(i16, a, b, types.i16x8{ 4, ~@as(i16, 4), 5, ~@as(i16, 5), 6, ~@as(i16, 6), 7, ~@as(i16, 7) });
}

test vzip2q_s16 {
    const a: types.i16x8 = .{ 0, 2, 4, 6, 8, 10, 12, 14 };
    const b: types.i16x8 = .{ 1, 3, 5, 7, 9, 11, 13, 15 };
    const expected: types.i16x8 = .{ 8, 9, 10, 11, 12, 13, 14, 15 };

    try common.testIntrinsic("vzip2q_s16", vzip2q_s16, expected, .{ a, b }, null);
}

/// Zip vectors
pub inline fn vzip2q_s32(a: types.i32x4, b: types.i32x4) types.i32x4 {
    return @shuffle(i32, a, b, types.i32x4{ 2, ~@as(i32, 2), 3, ~@as(i32, 3) });
}

test vzip2q_s32 {
    const a: types.i32x4 = .{ 0, 2, 4, 6 };
    const b: types.i32x4 = .{ 1, 3, 5, 7 };
    const expected: types.i32x4 = .{ 4, 5, 6, 7 };

    try common.testIntrinsic("vzip2q_s32", vzip2q_s32, expected, .{ a, b }, null);
}

/// Zip vectors
pub inline fn vzip2q_s64(a: types.i64x2, b: types.i64x2) types.i64x2 {
    return @shuffle(i64, a, b, types.i64x2{ 1, ~@as(i64, 1) });
}

test vzip2q_s64 {
    const a: types.i64x2 = .{ 0, 2 };
    const b: types.i64x2 = .{ 1, 3 };
    const expected: types.i64x2 = .{ 2, 3 };

    try common.testIntrinsic("vzip2q_s64", vzip2q_s64, expected, .{ a, b }, null);
}

/// Zip vectors
pub inline fn vzip2q_u8(a: types.u8x16, b: types.u8x16) types.u8x16 {
    return @shuffle(u8, a, b, types.i8x16{ 8, ~@as(i8, 8), 9, ~@as(i8, 9), 10, ~@as(i8, 10), 11, ~@as(i8, 11), 12, ~@as(i8, 12), 13, ~@as(i8, 13), 14, ~@as(i8, 14), 15, ~@as(i8, 15) });
}

test vzip2q_u8 {
    const a: types.u8x16 = .{ 0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30 };
    const b: types.u8x16 = .{ 1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29, 31 };
    const expected: types.i8x16 = .{ 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31 };

    try common.testIntrinsic("vzip2q_s8", vzip2q_s8, expected, .{ a, b }, null);
}

/// Zip vectors
pub inline fn vzip2q_u16(a: types.u16x8, b: types.u16x8) types.u16x8 {
    return @shuffle(u16, a, b, types.i16x8{ 4, ~@as(i16, 4), 5, ~@as(i16, 5), 6, ~@as(i16, 6), 7, ~@as(i16, 7) });
}

test vzip2q_u16 {
    const a: types.u16x8 = .{ 0, 2, 4, 6, 8, 10, 12, 14 };
    const b: types.u16x8 = .{ 1, 3, 5, 7, 9, 11, 13, 15 };
    const expected: types.u16x8 = .{ 8, 9, 10, 11, 12, 13, 14, 15 };

    try common.testIntrinsic("vzip2q_u16", vzip2q_u16, expected, .{ a, b }, null);
}

/// Zip vectors
pub inline fn vzip2q_u32(a: types.u32x4, b: types.u32x4) types.u32x4 {
    return @shuffle(u32, a, b, types.i32x4{ 2, ~@as(i32, 2), 3, ~@as(i32, 3) });
}

test vzip2q_u32 {
    const a: types.u32x4 = .{ 0, 2, 4, 6 };
    const b: types.u32x4 = .{ 1, 3, 5, 7 };
    const expected: types.u32x4 = .{ 4, 5, 6, 7 };

    try common.testIntrinsic("vzip2q_u32", vzip2q_u32, expected, .{ a, b }, null);
}

/// Zip vectors
pub inline fn vzip2q_u64(a: types.u64x2, b: types.u64x2) types.u64x2 {
    return @shuffle(u64, a, b, types.i64x2{ 1, ~@as(i64, 1) });
}

test vzip2q_u64 {
    const a: types.u64x2 = .{ 0, 2 };
    const b: types.u64x2 = .{ 1, 3 };
    const expected: types.u64x2 = .{ 2, 3 };

    try common.testIntrinsic("vzip1q_u64", vzip2q_u64, expected, .{ a, b }, null);
}

/// Zip vectors
pub inline fn vzip2q_f32(a: types.f32x4, b: types.f32x4) types.f32x4 {
    return @shuffle(f32, a, b, types.i32x4{ 2, ~@as(i32, 2), 3, ~@as(i32, 3) });
}

test vzip2q_f32 {
    const a: types.f32x4 = .{ 0, 2, 4, 6 };
    const b: types.f32x4 = .{ 1, 3, 5, 7 };
    const expected: types.f32x4 = .{ 4, 5, 6, 7 };

    try common.testIntrinsic("vzip2q_f32", vzip2q_f32, expected, .{ a, b }, null);
}

/// Zip vectors
pub inline fn vzip2q_f64(a: types.f64x2, b: types.f64x2) types.f64x2 {
    return @shuffle(f64, a, b, types.i64x2{ 1, ~@as(i64, 1) });
}

test vzip2q_f64 {
    const a: types.f64x2 = .{ 0, 2 };
    const b: types.f64x2 = .{ 1, 3 };
    const expected: types.f64x2 = .{ 2, 3 };

    try common.testIntrinsic("vzip1q_f64", vzip2q_f64, expected, .{ a, b }, null);
}

/// Zip vectors
pub inline fn vzip2q_p8(a: types.p8x16, b: types.p8x16) types.p8x16 {
    return @shuffle(types.p8, a, b, types.i8x16{ 8, ~@as(i8, 8), 9, ~@as(i8, 9), 10, ~@as(i8, 10), 11, ~@as(i8, 11), 12, ~@as(i8, 12), 13, ~@as(i8, 13), 14, ~@as(i8, 14), 15, ~@as(i8, 15) });
}

test vzip2q_p8 {
    const a: types.p8x16 = .{ 0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30 };
    const b: types.p8x16 = .{ 1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29, 31 };
    const expected: types.i8x16 = .{ 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31 };

    try common.testIntrinsic("vzip2q_s8", vzip2q_s8, expected, .{ a, b }, null);
}

/// Zip vectors
pub inline fn vzip2q_p16(a: types.p16x8, b: types.p16x8) types.p16x8 {
    return @shuffle(types.p16, a, b, types.i16x8{ 4, ~@as(i16, 4), 5, ~@as(i16, 5), 6, ~@as(i16, 6), 7, ~@as(i16, 7) });
}

test vzip2q_p16 {
    const a: types.p16x8 = .{ 0, 2, 4, 6, 8, 10, 12, 14 };
    const b: types.p16x8 = .{ 1, 3, 5, 7, 9, 11, 13, 15 };
    const expected: types.p16x8 = .{ 8, 9, 10, 11, 12, 13, 14, 15 };

    try common.testIntrinsic("vzip2q_p16", vzip2q_p16, expected, .{ a, b }, null);
}

/// Zip vectors
pub inline fn vzip2q_p64(a: types.p64x2, b: types.p64x2) types.p64x2 {
    return @shuffle(types.p64, a, b, types.i64x2{ 1, ~@as(i64, 1) });
}

test vzip2q_p64 {
    const a: types.p64x2 = .{ 0, 2 };
    const b: types.p64x2 = .{ 1, 3 };
    const expected: types.p64x2 = .{ 2, 3 };

    try common.testIntrinsic("vzip1q_p64", vzip2q_p64, expected, .{ a, b }, null);
}

/// Zip vectors
pub inline fn vzipq_u8(a: types.u8x16, b: types.u8x16) types.u8x16x2 {
    return .{ vzip1q_u8(a, b), vzip2q_u8(a, b) };
}

test vzipq_u8 {
    const a: types.u8x16 = .{ 0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30 };
    const b: types.u8x16 = .{ 1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29, 31 };
    const expected: types.u8x16x2 = .{ .{ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 }, .{ 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31 } };

    try common.testIntrinsic("vzipq_u8", vzipq_u8, expected, .{ a, b }, null);
}

/// Zip vectors
pub inline fn vzipq_u16(a: types.u16x8, b: types.u16x8) types.u16x8x2 {
    return .{ vzip1q_u16(a, b), vzip2q_u16(a, b) };
}

test vzipq_u16 {
    const a: types.u16x8 = .{ 0, 2, 4, 6, 8, 10, 12, 14 };
    const b: types.u16x8 = .{ 1, 3, 5, 7, 9, 11, 13, 15 };
    const expected: types.u16x8x2 = .{ .{ 0, 1, 2, 3, 4, 5, 6, 7 }, .{ 8, 9, 10, 11, 12, 13, 14, 15 } };

    try common.testIntrinsic("vzipq_u16", vzipq_u16, expected, .{ a, b }, null);
}

/// Zip vectors
pub inline fn vzipq_u32(a: types.u32x4, b: types.u32x4) types.u32x4x2 {
    return .{ vzip1q_u32(a, b), vzip2q_u32(a, b) };
}

test vzipq_u32 {
    const a: types.u32x4 = .{ 0, 2, 4, 6 };
    const b: types.u32x4 = .{ 1, 3, 5, 7 };
    const expected: types.u32x4x2 = .{ .{ 0, 1, 2, 3 }, .{ 4, 5, 6, 7 } };

    try common.testIntrinsic("vzipq_u32", vzipq_u32, expected, .{ a, b }, null);
}

/// Zip vectors
pub inline fn vzipq_u64(a: types.u64x2, b: types.u64x2) types.u64x2x2 {
    return .{ vzip1q_u64(a, b), vzip2q_u64(a, b) };
}

test vzipq_u64 {
    const a: types.u64x2 = .{ 0, 2 };
    const b: types.u64x2 = .{ 1, 3 };
    const expected: types.u64x2x2 = .{ .{ 0, 1 }, .{ 2, 3 } };

    try common.testIntrinsic("vzipq_u64", vzipq_u64, expected, .{ a, b }, null);
}

/// Transpose vectors
pub inline fn vtrn1q_s8(a: types.i8x16, b: types.i8x16) types.i8x16 {
    return @shuffle(i8, a, b, types.i8x16{ 0, ~@as(i8, 0), 2, ~@as(i8, 2), 4, ~@as(i8, 4), 6, ~@as(i8, 6), 8, ~@as(i8, 8), 10, ~@as(i8, 10), 12, ~@as(i8, 12), 14, ~@as(i8, 14) });
}

test vtrn1q_s8 {
    const a: types.i8x16 = .{ 0, 2, 2, 6, 2, 10, 6, 14, 2, 18, 6, 22, 10, 26, 14, 30 };
    const b: types.i8x16 = .{ 1, 3, 3, 7, 3, 1, 7, 15, 3, 19, 7, 23, 1, 27, 15, 31 };
    const expected: types.i8x16 = .{ 0, 1, 2, 3, 2, 3, 6, 7, 2, 3, 6, 7, 10, 1, 14, 15 };

    try common.testIntrinsic("vtrn1q_s8", vtrn1q_s8, expected, .{ a, b }, null);
}

/// Transpose vectors
pub inline fn vtrn1q_s16(a: types.i16x8, b: types.i16x8) types.i16x8 {
    return @shuffle(i16, a, b, types.i16x8{ 0, ~@as(i16, 0), 2, ~@as(i16, 2), 4, ~@as(i16, 4), 6, ~@as(i16, 6) });
}

test vtrn1q_s16 {
    const a: types.i16x8 = .{ 0, 2, 2, 6, 2, 10, 6, 14 };
    const b: types.i16x8 = .{ 1, 3, 3, 7, 3, 1, 7, 15 };
    const expected: types.i16x8 = .{ 0, 1, 2, 3, 2, 3, 6, 7 };

    try common.testIntrinsic("vtrn1q_s16", vtrn1q_s16, expected, .{ a, b }, null);
}

/// Transpose vectors
pub inline fn vtrn1q_s32(a: types.i32x4, b: types.i32x4) types.i32x4 {
    return @shuffle(i32, a, b, types.i32x4{ 0, ~@as(i32, 0), 2, ~@as(i32, 2) });
}

test vtrn1q_s32 {
    const a: types.i32x4 = .{ 0, 2, 2, 6 };
    const b: types.i32x4 = .{ 1, 3, 3, 7 };
    const expected: types.i32x4 = .{ 0, 1, 2, 3 };

    try common.testIntrinsic("vtrn1q_s32", vtrn1q_s32, expected, .{ a, b }, null);
}

/// Transpose vectors
pub inline fn vtrn1q_s64(a: types.i64x2, b: types.i64x2) types.i64x2 {
    return @shuffle(i64, a, b, types.i64x2{ 0, ~@as(i64, 0) });
}

test vtrn1q_s64 {
    const a: types.i64x2 = .{ 0, 2 };
    const b: types.i64x2 = .{ 1, 3 };
    const expected: types.i64x2 = .{ 0, 1 };

    try common.testIntrinsic("vtrn1q_s64", vtrn1q_s64, expected, .{ a, b }, null);
}

/// Transpose vectors
pub inline fn vtrn1q_u8(a: types.u8x16, b: types.u8x16) types.u8x16 {
    return @shuffle(u8, a, b, types.i8x16{ 0, ~@as(i8, 0), 2, ~@as(i8, 2), 4, ~@as(i8, 4), 6, ~@as(i8, 6), 8, ~@as(i8, 8), 10, ~@as(i8, 10), 12, ~@as(i8, 12), 14, ~@as(i8, 14) });
}

test vtrn1q_u8 {
    const a: types.u8x16 = .{ 0, 2, 2, 6, 2, 10, 6, 14, 2, 18, 6, 22, 10, 26, 14, 30 };
    const b: types.u8x16 = .{ 1, 3, 3, 7, 3, 1, 7, 15, 3, 19, 7, 23, 1, 27, 15, 31 };
    const expected: types.u8x16 = .{ 0, 1, 2, 3, 2, 3, 6, 7, 2, 3, 6, 7, 10, 1, 14, 15 };

    try common.testIntrinsic("vtrn1q_u8", vtrn1q_u8, expected, .{ a, b }, null);
}

/// Transpose vectors
pub inline fn vtrn1q_u16(a: types.u16x8, b: types.u16x8) types.u16x8 {
    return @shuffle(u16, a, b, types.i16x8{ 0, ~@as(i16, 0), 2, ~@as(i16, 2), 4, ~@as(i16, 4), 6, ~@as(i16, 6) });
}

test vtrn1q_u16 {
    const a: types.u16x8 = .{ 0, 2, 2, 6, 2, 10, 6, 14 };
    const b: types.u16x8 = .{ 1, 3, 3, 7, 3, 1, 7, 15 };
    const expected: types.u16x8 = .{ 0, 1, 2, 3, 2, 3, 6, 7 };

    try common.testIntrinsic("vtrn1q_u16", vtrn1q_u16, expected, .{ a, b }, null);
}

/// Transpose vectors
pub inline fn vtrn1q_u32(a: types.u32x4, b: types.u32x4) types.u32x4 {
    return @shuffle(u32, a, b, types.i32x4{ 0, ~@as(i32, 0), 2, ~@as(i32, 2) });
}

test vtrn1q_u32 {
    const a: types.u32x4 = .{ 0, 2, 2, 6 };
    const b: types.u32x4 = .{ 1, 3, 3, 7 };
    const expected: types.u32x4 = .{ 0, 1, 2, 3 };

    try common.testIntrinsic("vtrn1q_u32", vtrn1q_u32, expected, .{ a, b }, null);
}

/// Transpose vectors
pub inline fn vtrn1q_u64(a: types.u64x2, b: types.u64x2) types.u64x2 {
    return @shuffle(u64, a, b, types.i64x2{ 0, ~@as(i64, 0) });
}

test vtrn1q_u64 {
    const a: types.u64x2 = .{ 0, 2 };
    const b: types.u64x2 = .{ 1, 3 };
    const expected: types.u64x2 = .{ 0, 1 };

    try common.testIntrinsic("vtrn1q_u64", vtrn1q_u64, expected, .{ a, b }, null);
}

/// Transpose vectors
pub inline fn vtrn1q_f32(a: types.f32x4, b: types.f32x4) types.f32x4 {
    return @shuffle(f32, a, b, types.i32x4{ 0, ~@as(i32, 0), 2, ~@as(i32, 2) });
}

test vtrn1q_f32 {
    const a: types.f32x4 = .{ 0, 2, 2, 6 };
    const b: types.f32x4 = .{ 1, 3, 3, 7 };
    const expected: types.f32x4 = .{ 0, 1, 2, 3 };

    try common.testIntrinsic("vtrn1q_f32", vtrn1q_f32, expected, .{ a, b }, null);
}

/// Transpose vectors
pub inline fn vtrn1q_f64(a: types.f64x2, b: types.f64x2) types.f64x2 {
    return @shuffle(f64, a, b, types.i64x2{ 0, ~@as(i64, 0) });
}

test vtrn1q_f64 {
    const a: types.f64x2 = .{ 0, 2 };
    const b: types.f64x2 = .{ 1, 3 };
    const expected: types.f64x2 = .{ 0, 1 };

    try common.testIntrinsic("vtrn1q_f64", vtrn1q_f64, expected, .{ a, b }, null);
}

/// Transpose vectors
pub inline fn vtrn2q_s8(a: types.i8x16, b: types.i8x16) types.i8x16 {
    return @shuffle(i8, a, b, types.i8x16{ 1, ~@as(i8, 1), 3, ~@as(i8, 3), 5, ~@as(i8, 5), 7, ~@as(i8, 7), 9, ~@as(i8, 9), 11, ~@as(i8, 11), 13, ~@as(i8, 13), 15, ~@as(i8, 15) });
}

test vtrn2q_s8 {
    const a: types.i8x16 = .{ 0, 2, 2, 6, 2, 10, 6, 14, 2, 18, 6, 22, 10, 26, 14, 30 };
    const b: types.i8x16 = .{ 1, 3, 3, 7, 3, 1, 7, 15, 3, 19, 7, 23, 1, 27, 15, 31 };
    const expected: types.i8x16 = .{ 2, 3, 6, 7, 10, 1, 14, 15, 18, 19, 22, 23, 26, 27, 30, 31 };

    try common.testIntrinsic("vtrn2q_s8", vtrn2q_s8, expected, .{ a, b }, null);
}

/// Transpose vectors
pub inline fn vtrn2q_s16(a: types.i16x8, b: types.i16x8) types.i16x8 {
    return @shuffle(i16, a, b, types.i16x8{ 1, ~@as(i16, 1), 3, ~@as(i16, 3), 5, ~@as(i16, 5), 7, ~@as(i16, 7) });
}

test vtrn2q_s16 {
    const a: types.i16x8 = .{ 0, 2, 2, 6, 2, 10, 6, 14 };
    const b: types.i16x8 = .{ 1, 3, 3, 7, 3, 1, 7, 15 };
    const expected: types.i16x8 = .{ 2, 3, 6, 7, 10, 1, 14, 15 };

    try common.testIntrinsic("vtrn2q_s16", vtrn2q_s16, expected, .{ a, b }, null);
}

/// Transpose vectors
pub inline fn vtrn2q_s32(a: types.i32x4, b: types.i32x4) types.i32x4 {
    return @shuffle(i32, a, b, types.i32x4{ 1, ~@as(i32, 1), 3, ~@as(i32, 3) });
}

test vtrn2q_s32 {
    const a: types.i32x4 = .{ 0, 2, 2, 6 };
    const b: types.i32x4 = .{ 1, 3, 3, 7 };
    const expected: types.i32x4 = .{ 2, 3, 6, 7 };

    try common.testIntrinsic("vtrn2q_s32", vtrn2q_s32, expected, .{ a, b }, null);
}

/// Transpose vectors
pub inline fn vtrn2q_s64(a: types.i64x2, b: types.i64x2) types.i64x2 {
    return @shuffle(i64, a, b, types.i64x2{ 1, ~@as(i64, 1) });
}

test vtrn2q_s64 {
    const a: types.i64x2 = .{ 0, 2 };
    const b: types.i64x2 = .{ 1, 3 };
    const expected: types.i64x2 = .{ 2, 3 };

    try common.testIntrinsic("vtrn2q_s64", vtrn2q_s64, expected, .{ a, b }, null);
}

/// Transpose vectors
pub inline fn vtrn2q_u8(a: types.u8x16, b: types.u8x16) types.u8x16 {
    return @shuffle(u8, a, b, types.i8x16{ 1, ~@as(i8, 1), 3, ~@as(i8, 3), 5, ~@as(i8, 5), 7, ~@as(i8, 7), 9, ~@as(i8, 9), 11, ~@as(i8, 11), 13, ~@as(i8, 13), 15, ~@as(i8, 15) });
}

test vtrn2q_u8 {
    const a: types.u8x16 = .{ 0, 2, 2, 6, 2, 10, 6, 14, 2, 18, 6, 22, 10, 26, 14, 30 };
    const b: types.u8x16 = .{ 1, 3, 3, 7, 3, 1, 7, 15, 3, 19, 7, 23, 1, 27, 15, 31 };
    const expected: types.u8x16 = .{ 2, 3, 6, 7, 10, 1, 14, 15, 18, 19, 22, 23, 26, 27, 30, 31 };

    try common.testIntrinsic("vtrn2q_u8", vtrn2q_u8, expected, .{ a, b }, null);
}

/// Transpose vectors
pub inline fn vtrn2q_u16(a: types.u16x8, b: types.u16x8) types.u16x8 {
    return @shuffle(u16, a, b, types.i16x8{ 1, ~@as(i16, 1), 3, ~@as(i16, 3), 5, ~@as(i16, 5), 7, ~@as(i16, 7) });
}

test vtrn2q_u16 {
    const a: types.u16x8 = .{ 0, 2, 2, 6, 2, 10, 6, 14 };
    const b: types.u16x8 = .{ 1, 3, 3, 7, 3, 1, 7, 15 };
    const expected: types.u16x8 = .{ 2, 3, 6, 7, 10, 1, 14, 15 };

    try common.testIntrinsic("vtrn2q_u16", vtrn2q_u16, expected, .{ a, b }, null);
}

/// Transpose vectors
pub inline fn vtrn2q_u32(a: types.u32x4, b: types.u32x4) types.u32x4 {
    return @shuffle(u32, a, b, types.i32x4{ 1, ~@as(i32, 1), 3, ~@as(i32, 3) });
}

test vtrn2q_u32 {
    const a: types.u32x4 = .{ 0, 2, 2, 6 };
    const b: types.u32x4 = .{ 1, 3, 3, 7 };
    const expected: types.u32x4 = .{ 2, 3, 6, 7 };

    try common.testIntrinsic("vtrn2q_u32", vtrn2q_u32, expected, .{ a, b }, null);
}

/// Transpose vectors
pub inline fn vtrn2q_u64(a: types.u64x2, b: types.u64x2) types.u64x2 {
    return @shuffle(u64, a, b, types.i64x2{ 1, ~@as(i64, 1) });
}

test vtrn2q_u64 {
    const a: types.u64x2 = .{ 0, 2 };
    const b: types.u64x2 = .{ 1, 3 };
    const expected: types.u64x2 = .{ 2, 3 };

    try common.testIntrinsic("vtrn2q_u64", vtrn2q_u64, expected, .{ a, b }, null);
}

/// Transpose vectors
pub inline fn vtrn2q_f32(a: types.f32x4, b: types.f32x4) types.f32x4 {
    return @shuffle(f32, a, b, types.i32x4{ 1, ~@as(i32, 1), 3, ~@as(i32, 3) });
}

test vtrn2q_f32 {
    const a: types.f32x4 = .{ 0, 2, 2, 6 };
    const b: types.f32x4 = .{ 1, 3, 3, 7 };
    const expected: types.f32x4 = .{ 2, 3, 6, 7 };

    try common.testIntrinsic("vtrn2q_f32", vtrn2q_f32, expected, .{ a, b }, null);
}

/// Transpose vectors
pub inline fn vtrn2q_f64(a: types.f64x2, b: types.f64x2) types.f64x2 {
    return @shuffle(f64, a, b, types.i64x2{ 1, ~@as(i64, 1) });
}

test vtrn2q_f64 {
    const a: types.f64x2 = .{ 0, 2 };
    const b: types.f64x2 = .{ 1, 3 };
    const expected: types.f64x2 = .{ 2, 3 };

    try common.testIntrinsic("vtrn2q_f64", vtrn2q_f64, expected, .{ a, b }, null);
}

/// Transpose elements
pub inline fn vtrnq_s8(a: types.i8x16, b: types.i8x16) types.i8x16x2 {
    const a1: types.i8x16 = vtrn1q_s8(a, b);
    const b1: types.i8x16 = vtrn2q_s8(a, b);
    return .{ a1, b1 };
}

test vtrnq_s8 {
    const a: types.i8x16 = .{ 0, 2, 2, 6, 2, 10, 6, 14, 2, 18, 6, 22, 10, 26, 14, 30 };
    const b: types.i8x16 = .{ 1, 3, 3, 7, 3, 1, 7, 15, 3, 19, 7, 23, 1, 27, 15, 31 };
    const expected: types.i8x16x2 = .{ .{ 0, 1, 2, 3, 2, 3, 6, 7, 2, 3, 6, 7, 10, 1, 14, 15 }, .{ 2, 3, 6, 7, 10, 1, 14, 15, 18, 19, 22, 23, 26, 27, 30, 31 } };

    try common.testIntrinsic("vtrnq_s8", vtrnq_s8, expected, .{ a, b }, null);
}

/// Transpose elements
pub inline fn vtrnq_s16(a: types.i16x8, b: types.i16x8) types.i16x8x2 {
    const a1: types.i16x8 = vtrn1q_s16(a, b);
    const b1: types.i16x8 = vtrn2q_s16(a, b);
    return .{ a1, b1 };
}

test vtrnq_s16 {
    const a: types.i16x8 = .{ 0, 2, 2, 6, 2, 10, 6, 14 };
    const b: types.i16x8 = .{ 1, 3, 3, 7, 3, 1, 7, 15 };
    const expected: types.i16x8x2 = .{ .{ 0, 1, 2, 3, 2, 3, 6, 7 }, .{ 2, 3, 6, 7, 10, 1, 14, 15 } };

    try common.testIntrinsic("vtrnq_s16", vtrnq_s16, expected, .{ a, b }, null);
}

/// Transpose elements
pub inline fn vtrnq_s32(a: types.i32x4, b: types.i32x4) types.i32x4x2 {
    const a1: types.i32x4 = vtrn1q_s32(a, b);
    const b1: types.i32x4 = vtrn2q_s32(a, b);
    return .{ a1, b1 };
}

test vtrnq_s32 {
    const a: types.i32x4 = .{ 0, 2, 2, 6 };
    const b: types.i32x4 = .{ 1, 3, 3, 7 };
    const expected: types.i32x4x2 = .{ .{ 0, 1, 2, 3 }, .{ 2, 3, 6, 7 } };

    try common.testIntrinsic("vtrnq_s32", vtrnq_s32, expected, .{ a, b }, null);
}

/// Transpose elements
pub inline fn vtrnq_u8(a: types.u8x16, b: types.u8x16) types.u8x16x2 {
    const a1: types.u8x16 = vtrn1q_u8(a, b);
    const b1: types.u8x16 = vtrn2q_u8(a, b);
    return .{ a1, b1 };
}

test vtrnq_u8 {
    const a: types.u8x16 = .{ 0, 2, 2, 6, 2, 10, 6, 14, 2, 18, 6, 22, 10, 26, 14, 30 };
    const b: types.u8x16 = .{ 1, 3, 3, 7, 3, 1, 7, 15, 3, 19, 7, 23, 1, 27, 15, 31 };
    const expected: types.u8x16x2 = .{ .{ 0, 1, 2, 3, 2, 3, 6, 7, 2, 3, 6, 7, 10, 1, 14, 15 }, .{ 2, 3, 6, 7, 10, 1, 14, 15, 18, 19, 22, 23, 26, 27, 30, 31 } };

    try common.testIntrinsic("vtrnq_u8", vtrnq_u8, expected, .{ a, b }, null);
}

/// Transpose elements
pub inline fn vtrnq_u16(a: types.u16x8, b: types.u16x8) types.u16x8x2 {
    const a1: types.u16x8 = vtrn1q_u16(a, b);
    const b1: types.u16x8 = vtrn2q_u16(a, b);
    return .{ a1, b1 };
}

test vtrnq_u16 {
    const a: types.u16x8 = .{ 0, 2, 2, 6, 2, 10, 6, 14 };
    const b: types.u16x8 = .{ 1, 3, 3, 7, 3, 1, 7, 15 };
    const expected: types.u16x8x2 = .{ .{ 0, 1, 2, 3, 2, 3, 6, 7 }, .{ 2, 3, 6, 7, 10, 1, 14, 15 } };

    try common.testIntrinsic("vtrnq_u16", vtrnq_u16, expected, .{ a, b }, null);
}

/// Transpose elements
pub inline fn vtrnq_u32(a: types.u32x4, b: types.u32x4) types.u32x4x2 {
    const a1: types.u32x4 = vtrn1q_u32(a, b);
    const b1: types.u32x4 = vtrn2q_u32(a, b);
    return .{ a1, b1 };
}

test vtrnq_u32 {
    const a: types.u32x4 = .{ 0, 2, 2, 6 };
    const b: types.u32x4 = .{ 1, 3, 3, 7 };
    const expected: types.u32x4x2 = .{ .{ 0, 1, 2, 3 }, .{ 2, 3, 6, 7 } };

    try common.testIntrinsic("vtrnq_u32", vtrnq_u32, expected, .{ a, b }, null);
}

/// Transpose elements
pub inline fn vtrnq_f32(a: types.f32x4, b: types.f32x4) types.f32x4x2 {
    const a1: types.f32x4 = vtrn1q_f32(a, b);
    const b1: types.f32x4 = vtrn2q_f32(a, b);
    return .{ a1, b1 };
}

test vtrnq_f32 {
    const a: types.f32x4 = .{ 0, 2, 2, 6 };
    const b: types.f32x4 = .{ 1, 3, 3, 7 };
    const expected: types.f32x4x2 = .{ .{ 0, 1, 2, 3 }, .{ 2, 3, 6, 7 } };

    try common.testIntrinsic("vtrnq_f32", vtrnq_f32, expected, .{ a, b }, null);
}

/// Transpose elements
pub inline fn vtrnq_p8(a: types.p8x16, b: types.p8x16) types.p8x16x2 {
    const a1: types.p8x16 = vtrn1q_u8(a, b);
    const b1: types.p8x16 = vtrn2q_u8(a, b);
    return .{ a1, b1 };
}

test vtrnq_p8 {
    const a: types.p8x16 = .{ 0, 2, 2, 6, 2, 10, 6, 14, 2, 18, 6, 22, 10, 26, 14, 30 };
    const b: types.p8x16 = .{ 1, 3, 3, 7, 3, 1, 7, 15, 3, 19, 7, 23, 1, 27, 15, 31 };
    const expected: types.p8x16x2 = .{ .{ 0, 1, 2, 3, 2, 3, 6, 7, 2, 3, 6, 7, 10, 1, 14, 15 }, .{ 2, 3, 6, 7, 10, 1, 14, 15, 18, 19, 22, 23, 26, 27, 30, 31 } };

    try common.testIntrinsic("vtrnq_p8", vtrnq_p8, expected, .{ a, b }, null);
}

/// Transpose elements
pub inline fn vtrnq_p16(a: types.p16x8, b: types.p16x8) types.p16x8x2 {
    const a1: types.p16x8 = vtrn1q_u16(a, b);
    const b1: types.p16x8 = vtrn2q_u16(a, b);
    return .{ a1, b1 };
}

test vtrnq_p16 {
    const a: types.p16x8 = .{ 0, 2, 2, 6, 2, 10, 6, 14 };
    const b: types.p16x8 = .{ 1, 3, 3, 7, 3, 1, 7, 15 };
    const expected: types.p16x8x2 = .{ .{ 0, 1, 2, 3, 2, 3, 6, 7 }, .{ 2, 3, 6, 7, 10, 1, 14, 15 } };

    try common.testIntrinsic("vtrnq_p16", vtrnq_p16, expected, .{ a, b }, null);
}

/// Reversing vector elements (swap endianness)
pub inline fn vrev64q_s8(a: types.i8x16) types.i8x16 {
    return @shuffle(i8, a, undefined, types.i8x16{ 7, 6, 5, 4, 3, 2, 1, 0, 15, 14, 13, 12, 11, 10, 9, 8 });
}

test vrev64q_s8 {
    const a: types.i8x16 = .{ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 };
    const expected: types.i8x16 = .{ 7, 6, 5, 4, 3, 2, 1, 0, 15, 14, 13, 12, 11, 10, 9, 8 };

    try common.testIntrinsic("vrev64q_s8", vrev64q_s8, expected, .{a}, null);
}

/// Reversing vector elements (swap endianness)
pub inline fn vrev64q_s16(a: types.i16x8) types.i16x8 {
    return @shuffle(i16, a, undefined, types.i16x8{ 3, 2, 1, 0, 7, 6, 5, 4 });
}

test vrev64q_s16 {
    const a: types.i16x8 = .{ 0, 1, 2, 3, 4, 5, 6, 7 };
    const expected: types.i16x8 = .{ 3, 2, 1, 0, 7, 6, 5, 4 };

    try common.testIntrinsic("vrev64q_s16", vrev64q_s16, expected, .{a}, null);
}

/// Reversing vector elements (swap endianness)
pub inline fn vrev64q_s32(a: types.i32x4) types.i32x4 {
    return @shuffle(i32, a, undefined, types.i32x4{ 1, 0, 3, 2 });
}

test vrev64q_s32 {
    const a: types.i32x4 = .{ 0, 1, 2, 3 };
    const expected: types.i32x4 = .{ 1, 0, 3, 2 };

    try common.testIntrinsic("vrev64q_s32", vrev64q_s32, expected, .{a}, null);
}

/// Reversing vector elements (swap endianness)
pub inline fn vrev64q_u8(a: types.u8x16) types.u8x16 {
    return @shuffle(u8, a, undefined, types.u8x16{ 7, 6, 5, 4, 3, 2, 1, 0, 15, 14, 13, 12, 11, 10, 9, 8 });
}

test vrev64q_u8 {
    const a: types.u8x16 = .{ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 };
    const expected: types.u8x16 = .{ 7, 6, 5, 4, 3, 2, 1, 0, 15, 14, 13, 12, 11, 10, 9, 8 };

    try common.testIntrinsic("vrev64q_u8", vrev64q_u8, expected, .{a}, null);
}

/// Reversing vector elements (swap endianness)
pub inline fn vrev64q_u16(a: types.u16x8) types.u16x8 {
    return @shuffle(u16, a, undefined, types.u16x8{ 3, 2, 1, 0, 7, 6, 5, 4 });
}

test vrev64q_u16 {
    const a: types.u16x8 = .{ 0, 1, 2, 3, 4, 5, 6, 7 };
    const expected: types.u16x8 = .{ 3, 2, 1, 0, 7, 6, 5, 4 };

    try common.testIntrinsic("vrev64q_u16", vrev64q_u16, expected, .{a}, null);
}

/// Reversing vector elements (swap endianness)
pub inline fn vrev64q_u32(a: types.u32x4) types.u32x4 {
    return @shuffle(u32, a, undefined, types.u32x4{ 1, 0, 3, 2 });
}

test vrev64q_u32 {
    const a: types.u32x4 = .{ 0, 1, 2, 3 };
    const expected: types.u32x4 = .{ 1, 0, 3, 2 };

    try common.testIntrinsic("vrev64q_u32", vrev64q_u32, expected, .{a}, null);
}

/// Reversing vector elements (swap endianness)
pub inline fn vrev64q_p8(a: types.p8x16) types.p8x16 {
    return @shuffle(types.p8, a, undefined, types.p8x16{ 7, 6, 5, 4, 3, 2, 1, 0, 15, 14, 13, 12, 11, 10, 9, 8 });
}

test vrev64q_p8 {
    const a: types.p8x16 = .{ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 };
    const expected: types.p8x16 = .{ 7, 6, 5, 4, 3, 2, 1, 0, 15, 14, 13, 12, 11, 10, 9, 8 };

    try common.testIntrinsic("vrev64q_p8", vrev64q_p8, expected, .{a}, null);
}

/// Reversing vector elements (swap endianness)
pub inline fn vrev64q_p16(a: types.p16x8) types.p16x8 {
    return @shuffle(types.p16, a, undefined, types.p16x8{ 3, 2, 1, 0, 7, 6, 5, 4 });
}

test vrev64q_p16 {
    const a: types.p16x8 = .{ 0, 1, 2, 3, 4, 5, 6, 7 };
    const expected: types.p16x8 = .{ 3, 2, 1, 0, 7, 6, 5, 4 };

    try common.testIntrinsic("vrev64q_p16", vrev64q_p16, expected, .{a}, null);
}

/// Reversing vector elements (swap endianness)
pub inline fn vrev64q_f32(a: types.f32x4) types.f32x4 {
    return @shuffle(f32, a, undefined, types.f32x4{ 1, 0, 3, 2 });
}

test vrev64q_f32 {
    const a: types.f32x4 = .{ 0, 1, 2, 3 };
    const expected: types.f32x4 = .{ 1, 0, 3, 2 };

    try common.testIntrinsic("vrev64q_f32", vrev64q_f32, expected, .{a}, null);
}

/// Vector combine
pub inline fn vcombine_s8(a: types.i8x8, b: types.i8x8) types.i8x16 {
    return common.join(a, b);
}

test vcombine_s8 {
    const a: types.i8x8 = .{ 0, 1, 2, 3, 4, 5, 6, 7 };
    const b: types.i8x8 = .{ 8, 9, 10, 11, 12, 13, 14, 15 };
    const expected: types.i8x16 = .{ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 };

    try common.testIntrinsic("vcombine_s8", vcombine_s8, expected, .{ a, b }, null);
}

/// Vector combine
pub inline fn vcombine_s16(a: types.i16x4, b: types.i16x4) types.i16x8 {
    return common.join(a, b);
}

test vcombine_s16 {
    const a: types.i16x4 = .{ 0, 1, 2, 3 };
    const b: types.i16x4 = .{ 4, 5, 6, 7 };
    const expected: types.i16x8 = .{ 0, 1, 2, 3, 4, 5, 6, 7 };

    try common.testIntrinsic("vcombine_s16", vcombine_s16, expected, .{ a, b }, null);
}

/// Vector combine
pub inline fn vcombine_s32(a: types.i32x2, b: types.i32x2) types.i32x4 {
    return common.join(a, b);
}

test vcombine_s32 {
    const a: types.i32x2 = .{ 0, 1 };
    const b: types.i32x2 = .{ 2, 3 };
    const expected: types.i32x4 = .{ 0, 1, 2, 3 };

    try common.testIntrinsic("vcombine_s32", vcombine_s32, expected, .{ a, b }, null);
}

/// Vector combine
pub inline fn vcombine_s64(a: types.i64x1, b: types.i64x1) types.i64x2 {
    return common.join(a, b);
}

test vcombine_s64 {
    const a: types.i64x1 = .{0};
    const b: types.i64x1 = .{1};
    const expected: types.i64x2 = .{ 0, 1 };

    try common.testIntrinsic("vcombine_s64", vcombine_s64, expected, .{ a, b }, null);
}

/// Vector combine
pub inline fn vcombine_u8(a: types.u8x8, b: types.u8x8) types.u8x16 {
    return common.join(a, b);
}

test vcombine_u8 {
    const a: types.u8x8 = .{ 0, 1, 2, 3, 4, 5, 6, 7 };
    const b: types.u8x8 = .{ 8, 9, 10, 11, 12, 13, 14, 15 };
    const expected: types.u8x16 = .{ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 };

    try common.testIntrinsic("vcombine_u8", vcombine_u8, expected, .{ a, b }, null);
}

/// Vector combine
pub inline fn vcombine_u16(a: types.u16x4, b: types.u16x4) types.u16x8 {
    return common.join(a, b);
}

test vcombine_u16 {
    const a: types.u16x4 = .{ 0, 1, 2, 3 };
    const b: types.u16x4 = .{ 4, 5, 6, 7 };
    const expected: types.u16x8 = .{ 0, 1, 2, 3, 4, 5, 6, 7 };

    try common.testIntrinsic("vcombine_u16", vcombine_u16, expected, .{ a, b }, null);
}

/// Vector combine
pub inline fn vcombine_u32(a: types.u32x2, b: types.u32x2) types.u32x4 {
    return common.join(a, b);
}

test vcombine_u32 {
    const a: types.u32x2 = .{ 0, 1 };
    const b: types.u32x2 = .{ 2, 3 };
    const expected: types.u32x4 = .{ 0, 1, 2, 3 };

    try common.testIntrinsic("vcombine_u32", vcombine_u32, expected, .{ a, b }, null);
}

/// Vector combine
pub inline fn vcombine_u64(a: types.u64x1, b: types.u64x1) types.u64x2 {
    return common.join(a, b);
}

test vcombine_u64 {
    const a: types.u64x1 = .{0};
    const b: types.u64x1 = .{1};
    const expected: types.u64x2 = .{ 0, 1 };

    try common.testIntrinsic("vcombine_u64", vcombine_u64, expected, .{ a, b }, null);
}

/// Vector combine
pub inline fn vcombine_p8(a: types.p8x8, b: types.p8x8) types.p8x16 {
    return common.join(a, b);
}

test vcombine_p8 {
    const a: types.p8x8 = .{ 0, 1, 2, 3, 4, 5, 6, 7 };
    const b: types.p8x8 = .{ 8, 9, 10, 11, 12, 13, 14, 15 };
    const expected: types.p8x16 = .{ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 };

    try common.testIntrinsic("vcombine_p8", vcombine_p8, expected, .{ a, b }, null);
}

/// Vector combine
pub inline fn vcombine_p16(a: types.p16x4, b: types.p16x4) types.p16x8 {
    return common.join(a, b);
}

test vcombine_p16 {
    const a: types.p16x4 = .{ 0, 1, 2, 3 };
    const b: types.p16x4 = .{ 4, 5, 6, 7 };
    const expected: types.p16x8 = .{ 0, 1, 2, 3, 4, 5, 6, 7 };

    try common.testIntrinsic("vcombine_p16", vcombine_p16, expected, .{ a, b }, null);
}

/// Vector combine
pub inline fn vcombine_f16(a: types.f16x4, b: types.f16x4) types.f16x8 {
    return common.join(a, b);
}

test vcombine_f16 {
    const a: types.f16x4 = .{ 0, 1, 2, 3 };
    const b: types.f16x4 = .{ 4, 5, 6, 7 };
    const expected: types.f16x8 = .{ 0, 1, 2, 3, 4, 5, 6, 7 };

    try common.testIntrinsic("vcombine_f16", vcombine_f16, expected, .{ a, b }, null);
}

/// Vector combine
pub inline fn vcombine_f32(a: types.f32x2, b: types.f32x2) types.f32x4 {
    return common.join(a, b);
}

test vcombine_f32 {
    const a: types.f32x2 = .{ 0, 1 };
    const b: types.f32x2 = .{ 2, 3 };
    const expected: types.f32x4 = .{ 0, 1, 2, 3 };

    try common.testIntrinsic("vcombine_f32", vcombine_f32, expected, .{ a, b }, null);
}

/// Vector combine
pub inline fn vcombine_f64(a: types.f64x1, b: types.f64x1) types.f64x2 {
    return common.join(a, b);
}

test vcombine_f64 {
    const a: types.f64x1 = .{0};
    const b: types.f64x1 = .{1};
    const expected: types.f64x2 = .{ 0, 1 };

    try common.testIntrinsic("vcombine_f64", vcombine_f64, expected, .{ a, b }, null);
}

/// Duplicate vector element to vector or scalar
pub inline fn vmovq_n_u8(scalar: u8) types.u8x16 {
    return vdupq_n_u8(scalar);
}

test vmovq_n_u8 {
    const scalar: u8 = 66;
    const expected: types.u8x16 = .{ 66, 66, 66, 66, 66, 66, 66, 66, 66, 66, 66, 66, 66, 66, 66, 66 };

    try common.testIntrinsic("vmovq_n_u8", vmovq_n_u8, expected, .{scalar}, null);
}

/// Duplicate vector element to vector or scalar
pub inline fn vmovq_n_u16(scalar: u16) types.u16x8 {
    return vdupq_n_u16(scalar);
}

test vmovq_n_u16 {
    const scalar: u16 = 2701;
    const expected: types.u16x8 = .{ 2701, 2701, 2701, 2701, 2701, 2701, 2701, 2701 };

    try common.testIntrinsic("vmovq_n_u16", vmovq_n_u16, expected, .{scalar}, null);
}

/// Duplicate vector element to vector or scalar
pub inline fn vmovq_n_u32(scalar: u32) types.u32x4 {
    return vdupq_n_u32(scalar);
}

test vmovq_n_u32 {
    const scalar: u32 = 717371659;
    const expected: types.u32x4 = .{ 717371659, 717371659, 717371659, 717371659 };

    try common.testIntrinsic("vmovq_n_u32", vmovq_n_u32, expected, .{scalar}, null);
}

/// Duplicate vector element to vector or scalar
pub inline fn vmovq_n_u64(scalar: u64) types.u64x2 {
    return vdupq_n_u64(scalar);
}

test vmovq_n_u64 {
    const scalar: u64 = 13609191869422731000;
    const expected: types.u64x2 = .{ 13609191869422731000, 13609191869422731000 };

    try common.testIntrinsic("vmovq_n_u64", vmovq_n_u64, expected, .{scalar}, null);
}

/// Duplicate vector element to vector or scalar
pub inline fn vmovq_n_s8(scalar: i8) types.i8x16 {
    return vdupq_n_s8(scalar);
}

test vmovq_n_s8 {
    const scalar: i8 = 14;
    const expected: types.i8x16 = .{ 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14 };

    try common.testIntrinsic("vmovq_n_s8", vmovq_n_s8, expected, .{scalar}, null);
}

/// Duplicate vector element to vector or scalar
pub inline fn vmovq_n_s16(scalar: i16) types.i16x8 {
    return vdupq_n_s16(scalar);
}

test vmovq_n_s16 {
    const scalar: i16 = 27570;
    const expected: types.i16x8 = .{ 27570, 27570, 27570, 27570, 27570, 27570, 27570, 27570 };

    try common.testIntrinsic("vmovq_n_s16", vmovq_n_s16, expected, .{scalar}, null);
}

/// Duplicate vector element to vector or scalar
pub inline fn vmovq_n_s32(scalar: i32) types.i32x4 {
    return vdupq_n_s32(scalar);
}

test vmovq_n_s32 {
    const scalar: i32 = 964454829;
    const expected: types.i32x4 = .{ 964454829, 964454829, 964454829, 964454829 };

    try common.testIntrinsic("vmovq_n_s32", vmovq_n_s32, expected, .{scalar}, null);
}

/// Duplicate vector element to vector or scalar
pub inline fn vmovq_n_s64(scalar: i64) types.i64x2 {
    return vdupq_n_s64(scalar);
}

test vmovq_n_s64 {
    const scalar: i64 = 4555543976599521300;
    const expected: types.i64x2 = .{ 4555543976599521300, 4555543976599521300 };

    try common.testIntrinsic("vmovq_n_s64", vmovq_n_s64, expected, .{scalar}, null);
}

/// Duplicate vector element to vector or scalar
pub inline fn vmovq_n_p8(scalar: types.p8) types.p8x16 {
    return vdupq_n_p8(scalar);
}

test vmovq_n_p8 {
    const scalar: types.p8 = 187;
    const expected: types.p8x16 = .{ 187, 187, 187, 187, 187, 187, 187, 187, 187, 187, 187, 187, 187, 187, 187, 187 };

    try common.testIntrinsic("vmovq_n_p8", vmovq_n_p8, expected, .{scalar}, null);
}

/// Duplicate vector element to vector or scalar
pub inline fn vmovq_n_p16(scalar: types.p16) types.p16x8 {
    return vdupq_n_p16(scalar);
}

test vmovq_n_p16 {
    const scalar: types.p16 = 54032;
    const expected: types.p16x8 = .{ 54032, 54032, 54032, 54032, 54032, 54032, 54032, 54032 };

    try common.testIntrinsic("vmovq_n_p16", vmovq_n_p16, expected, .{scalar}, null);
}

/// Duplicate vector element to vector or scalar
pub inline fn vmovq_n_p64(scalar: types.p64) types.p64x2 {
    return vdupq_n_p64(scalar);
}

test vmovq_n_p64 {
    const scalar: types.p64 = 13609191869422731000;
    const expected: types.p64x2 = .{ 13609191869422731000, 13609191869422731000 };

    try common.testIntrinsic("vmovq_n_p64", vmovq_n_p64, expected, .{scalar}, null);
}

/// Duplicate vector element to vector or scalar
pub inline fn vmovq_n_f32(scalar: f32) types.f32x4 {
    return vdupq_n_f32(scalar);
}

test vmovq_n_f32 {
    const scalar: f32 = 3.559321397026124e+37;
    const expected: types.f32x4 = .{ 3.559321397026124e+37, 3.559321397026124e+37, 3.559321397026124e+37, 3.559321397026124e+37 };

    try common.testIntrinsic("vmovq_n_f32", vmovq_n_f32, expected, .{scalar}, null);
}

/// Duplicate vector element to vector or scalar
pub inline fn vmovq_n_f64(scalar: f64) types.f64x2 {
    return vdupq_n_f64(scalar);
}

test vmovq_n_f64 {
    const scalar: f64 = 8.935392104998695e+306;
    const expected: types.f64x2 = .{ 8.935392104998695e+306, 8.935392104998695e+306 };

    try common.testIntrinsic("vmovq_n_f64", vmovq_n_f64, expected, .{scalar}, null);
}

/// Table look-up
pub inline fn vqtbl1q_s8(t: types.i8x16, idx: types.i8x16) types.i8x16 {
    // @shuffle would be nice here, but mask
        // needs to be comptime known. Fortunately
        // Zig optimizes this down to its required
        // instruction despite the loop.
        var result: types.i8x16 = undefined;
        inline for (0..16) |i| {
            result[i] = t[idx[i]];
        }

        return result;
}

test vqtbl1q_s8 {
    {
        const t: types.i8x16 = .{ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 };
        const idx: types.i8x16 = .{ 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0 };
        const expected: types.i8x16 = .{ 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0 };

        try common.testIntrinsic("vqtbl1q_s8", vqtbl1q_s8, expected, .{ t, idx }, null);
    }
    {
        const t: types.i8x16 = .{ 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127 };
        const idx: types.i8x16 = .{ 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0 };
        const expected: types.i8x16 = .{ 127, 126, 125, 124, 123, 122, 121, 120, 119, 118, 117, 116, 115, 114, 113, 112 };

        try common.testIntrinsic("vqtbl1q_s8", vqtbl1q_s8, expected, .{ t, idx }, null);
    }
}

/// Table look-up
pub inline fn vqtbl1q_u8(t: types.u8x16, idx: types.u8x16) types.u8x16 {
    var result: types.u8x16 = undefined;
        inline for (0..16) |i| {
            result[i] = t[idx[i]];
        }

        return result;
}

test vqtbl1q_u8 {
    const t: types.u8x16 = .{ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 };
    const idx: types.u8x16 = .{ 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0 };
    const expected: types.u8x16 = .{ 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0 };

    try common.testIntrinsic("vqtbl1q_u8", vqtbl1q_u8, expected, .{ t, idx }, null);
}

/// Table look-up
pub inline fn vqtbl1q_p8(t: types.p8x16, idx: types.p8x16) types.p8x16 {
    var result: types.p8x16 = undefined;
        inline for (0..16) |i| {
            result[i] = t[idx[i]];
        }

        return result;
}

test vqtbl1q_p8 {
    const t: types.p8x16 = .{ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 };
    const idx: types.p8x16 = .{ 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0 };
    const expected: types.p8x16 = .{ 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0 };

    try common.testIntrinsic("vqtbl1q_p8", vqtbl1q_p8, expected, .{ t, idx }, null);
}
