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
    try common.testIntrinsic(.{ .func = vget_low_s8, .expected = expected, .args = .{vec} });
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
    try common.testIntrinsic(.{ .func = vget_low_s16, .expected = expected, .args = .{vec} });
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
    try common.testIntrinsic(.{ .func = vget_low_s32, .expected = expected, .args = .{vec} });
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
    try common.testIntrinsic(.{ .func = vget_low_s64, .expected = expected, .args = .{vec} });
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
    try common.testIntrinsic(.{ .func = vget_low_u8, .expected = expected, .args = .{vec} });
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
    try common.testIntrinsic(.{ .func = vget_low_u16, .expected = expected, .args = .{vec} });
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
    try common.testIntrinsic(.{ .func = vget_low_u32, .expected = expected, .args = .{vec} });
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
    try common.testIntrinsic(.{ .func = vget_low_u64, .expected = expected, .args = .{vec} });
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
    try common.testIntrinsic(.{ .func = vget_low_p8, .expected = expected, .args = .{vec} });
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
    try common.testIntrinsic(.{ .func = vget_low_p16, .expected = expected, .args = .{vec} });
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
    try common.testIntrinsic(.{ .func = vget_low_f16, .expected = expected, .args = .{vec} });
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
    try common.testIntrinsic(.{ .func = vget_low_f32, .expected = expected, .args = .{vec} });
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
    try common.testIntrinsic(.{ .func = vget_low_f64, .expected = expected, .args = .{vec} });
}

/// Unsigned Move vector element to general-purpose register
pub inline fn vget_lane_p8(vec: types.p8x8, comptime lane: usize) types.p8 {
    return vec[lane];
}

test vget_lane_p8 {
    const v: types.p8x8 = .{ 0, 1, 2, 3, 4, 5, 6, 7 };
    const lane: usize = 6;
    const expected: types.p8 = 6;

    try common.testIntrinsic(.{ .func = vget_lane_p8, .expected = expected, .args = .{ v, lane } });
}

/// Unsigned Move vector element to general-purpose register
pub inline fn vget_lane_p16(vec: types.p16x4, comptime lane: usize) types.p16 {
    return vec[lane];
}

test vget_lane_p16 {
    const v: types.p16x4 = .{ 0, 1, 2, 3 };
    const lane: usize = 2;
    const expected: types.p16 = 2;

    try common.testIntrinsic(.{ .func = vget_lane_p16, .expected = expected, .args = .{ v, lane } });
}

/// Unsigned Move vector element to general-purpose register
pub inline fn vget_lane_p64(vec: types.p64x1, comptime lane: usize) types.p64 {
    return vec[lane];
}

test vget_lane_p64 {
    const v: types.p64x1 = .{std.math.maxInt(types.p64)};
    const lane: usize = 0;
    const expected: types.p64 = std.math.maxInt(types.p64);

    try common.testIntrinsic(.{ .func = vget_lane_p64, .expected = expected, .args = .{ v, lane } });
}

/// Signed Move vector element to general-purpose register
pub inline fn vget_lane_s8(vec: types.i8x8, comptime lane: usize) i8 {
    return vec[lane];
}

test vget_lane_s8 {
    const v: types.i8x8 = .{ 0, 1, 2, 3, 4, 5, 6, 7 };
    const lane: usize = 5;
    const expected: i8 = 5;

    try common.testIntrinsic(.{ .func = vget_lane_s8, .expected = expected, .args = .{ v, lane } });
}

/// Signed Move vector element to general-purpose register
pub inline fn vget_lane_s16(vec: types.i16x4, comptime lane: usize) i16 {
    return vec[lane];
}

test vget_lane_s16 {
    const v: types.i16x4 = .{ 0, 1, 2, 3 };
    const lane: usize = 2;
    const expected: i16 = 2;

    try common.testIntrinsic(.{ .func = vget_lane_s16, .expected = expected, .args = .{ v, lane } });
}

/// Signed Move vector element to general-purpose register
pub inline fn vget_lane_s32(vec: types.i32x2, comptime lane: usize) i32 {
    return vec[lane];
}

test vget_lane_s32 {
    const v: types.i32x2 = .{ 0, 1 };
    const lane: usize = 0;
    const expected: i32 = 0;

    try common.testIntrinsic(.{ .func = vget_lane_s32, .expected = expected, .args = .{ v, lane } });
}

/// Signed Move vector element to general-purpose register
pub inline fn vget_lane_s64(vec: types.i64x1, comptime lane: usize) i64 {
    return vec[lane];
}

test vget_lane_s64 {
    const v: types.i64x1 = .{std.math.maxInt(i64)};
    const lane: usize = 0;
    const expected: i64 = std.math.maxInt(i64);

    try common.testIntrinsic(.{ .func = vget_lane_s64, .expected = expected, .args = .{ v, lane } });
}

/// Unigned Move vector element to general-purpose register
pub inline fn vget_lane_u8(vec: types.u8x8, comptime lane: usize) u8 {
    return vec[lane];
}

test vget_lane_u8 {
    const v: types.u8x8 = .{ 0, 1, 2, 3, 4, 5, 6, 7 };
    const lane: usize = 5;
    const expected: u8 = 5;

    try common.testIntrinsic(.{ .func = vget_lane_u8, .expected = expected, .args = .{ v, lane } });
}

/// Unigned Move vector element to general-purpose register
pub inline fn vget_lane_u16(vec: types.u16x4, comptime lane: usize) u16 {
    return vec[lane];
}

test vget_lane_u16 {
    const v: types.u16x4 = .{ 0, 1, 2, 3 };
    const lane: usize = 2;
    const expected: u16 = 2;

    try common.testIntrinsic(.{ .func = vget_lane_u16, .expected = expected, .args = .{ v, lane } });
}

/// Unigned Move vector element to general-purpose register
pub inline fn vget_lane_u32(vec: types.u32x2, comptime lane: usize) u32 {
    return vec[lane];
}

test vget_lane_u32 {
    const v: types.u32x2 = .{ 0, 1 };
    const lane: usize = 0;
    const expected: u32 = 0;

    try common.testIntrinsic(.{ .func = vget_lane_u32, .expected = expected, .args = .{ v, lane } });
}

/// Unigned Move vector element to general-purpose register
pub inline fn vget_lane_u64(vec: types.u64x1, comptime lane: usize) u64 {
    return vec[lane];
}

test vget_lane_u64 {
    const v: types.u64x1 = .{std.math.maxInt(u64)};
    const lane: usize = 0;
    const expected: u64 = std.math.maxInt(u64);

    try common.testIntrinsic(.{ .func = vget_lane_u64, .expected = expected, .args = .{ v, lane } });
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

    try common.testIntrinsic(.{ .func = vget_lane_f32, .expected = expected, .args = .{ v, lane } });
}

/// Floating-point Move vector element to general-purpose register
pub inline fn vget_lane_f64(vec: types.f64x1, comptime lane: usize) f64 {
    return vec[lane];
}

test vget_lane_f64 {
    const v: types.f64x1 = .{std.math.floatMax(f64)};
    const lane: usize = 0;
    const expected: f64 = std.math.floatMax(f64);

    try common.testIntrinsic(.{ .func = vget_lane_f64, .expected = expected, .args = .{ v, lane } });
}

/// Duplicate vector element to vector or scalar
pub inline fn vdupq_n_u8(scalar: u8) types.u8x16 {
    return @splat(scalar);
}

test vdupq_n_u8 {
    try common.testIntrinsic(.{ .func = vdupq_n_u8, .expected = types.u8x16{ 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5 }, .args = .{5} });
    try common.testIntrinsic(.{ .func = vdupq_n_u8, .expected = types.u8x16{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }, .args = .{0} });
    try common.testIntrinsic(.{ .func = vdupq_n_u8, .expected = types.u8x16{ std.math.maxInt(u8), std.math.maxInt(u8), std.math.maxInt(u8), std.math.maxInt(u8), std.math.maxInt(u8), std.math.maxInt(u8), std.math.maxInt(u8), std.math.maxInt(u8), std.math.maxInt(u8), std.math.maxInt(u8), std.math.maxInt(u8), std.math.maxInt(u8), std.math.maxInt(u8), std.math.maxInt(u8), std.math.maxInt(u8), std.math.maxInt(u8) }, .args = .{std.math.maxInt(u8)} });
}

/// Duplicate vector element to vector or scalar
pub inline fn vdupq_n_u16(scalar: u16) types.u16x8 {
    return @splat(scalar);
}

test vdupq_n_u16 {
    try common.testIntrinsic(.{ .func = vdupq_n_u16, .expected = types.u16x8{ 5, 5, 5, 5, 5, 5, 5, 5 }, .args = .{5} });
    try common.testIntrinsic(.{ .func = vdupq_n_u16, .expected = types.u16x8{ 0, 0, 0, 0, 0, 0, 0, 0 }, .args = .{0} });
    try common.testIntrinsic(.{ .func = vdupq_n_u16, .expected = types.u16x8{ std.math.maxInt(u16), std.math.maxInt(u16), std.math.maxInt(u16), std.math.maxInt(u16), std.math.maxInt(u16), std.math.maxInt(u16), std.math.maxInt(u16), std.math.maxInt(u16) }, .args = .{std.math.maxInt(u16)} });
}

/// Duplicate vector element to vector or scalar
pub inline fn vdupq_n_u32(scalar: u32) types.u32x4 {
    return @splat(scalar);
}

test vdupq_n_u32 {
    try common.testIntrinsic(.{ .func = vdupq_n_u32, .expected = types.u32x4{ 5, 5, 5, 5 }, .args = .{5} });
    try common.testIntrinsic(.{ .func = vdupq_n_u32, .expected = types.u32x4{ 0, 0, 0, 0 }, .args = .{0} });
    try common.testIntrinsic(.{ .func = vdupq_n_u32, .expected = types.u32x4{ std.math.maxInt(u32), std.math.maxInt(u32), std.math.maxInt(u32), std.math.maxInt(u32) }, .args = .{std.math.maxInt(u32)} });
}

/// Duplicate vector element to vector or scalar
pub inline fn vdupq_n_u64(scalar: u64) types.u64x2 {
    return @splat(scalar);
}

test vdupq_n_u64 {
    try common.testIntrinsic(.{ .func = vdupq_n_u64, .expected = types.u64x2{ 5, 5 }, .args = .{5} });
    try common.testIntrinsic(.{ .func = vdupq_n_u64, .expected = types.u64x2{ 0, 0 }, .args = .{0} });
    try common.testIntrinsic(.{ .func = vdupq_n_u64, .expected = types.u64x2{ std.math.maxInt(u64), std.math.maxInt(u64) }, .args = .{std.math.maxInt(u64)} });
}

/// Duplicate vector element to vector or scalar
pub inline fn vdupq_n_s8(scalar: i8) types.i8x16 {
    return @splat(scalar);
}

test vdupq_n_s8 {
    try common.testIntrinsic(.{ .func = vdupq_n_s8, .expected = types.i8x16{ 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5 }, .args = .{5} });
    try common.testIntrinsic(.{ .func = vdupq_n_s8, .expected = types.i8x16{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }, .args = .{0} });
    try common.testIntrinsic(.{ .func = vdupq_n_s8, .expected = types.i8x16{ std.math.maxInt(i8), std.math.maxInt(i8), std.math.maxInt(i8), std.math.maxInt(i8), std.math.maxInt(i8), std.math.maxInt(i8), std.math.maxInt(i8), std.math.maxInt(i8), std.math.maxInt(i8), std.math.maxInt(i8), std.math.maxInt(i8), std.math.maxInt(i8), std.math.maxInt(i8), std.math.maxInt(i8), std.math.maxInt(i8), std.math.maxInt(i8) }, .args = .{std.math.maxInt(i8)} });
}

/// Duplicate vector element to vector or scalar
pub inline fn vdupq_n_s16(scalar: i16) types.i16x8 {
    return @splat(scalar);
}

test vdupq_n_s16 {
    try common.testIntrinsic(.{ .func = vdupq_n_s16, .expected = types.i16x8{ 5, 5, 5, 5, 5, 5, 5, 5 }, .args = .{5} });
    try common.testIntrinsic(.{ .func = vdupq_n_s16, .expected = types.i16x8{ 0, 0, 0, 0, 0, 0, 0, 0 }, .args = .{0} });
    try common.testIntrinsic(.{ .func = vdupq_n_s16, .expected = types.i16x8{ std.math.maxInt(i16), std.math.maxInt(i16), std.math.maxInt(i16), std.math.maxInt(i16), std.math.maxInt(i16), std.math.maxInt(i16), std.math.maxInt(i16), std.math.maxInt(i16) }, .args = .{std.math.maxInt(i16)} });
}

/// Duplicate vector element to vector or scalar
pub inline fn vdupq_n_s32(scalar: i32) types.i32x4 {
    return @splat(scalar);
}

test vdupq_n_s32 {
    try common.testIntrinsic(.{ .func = vdupq_n_s32, .expected = types.i32x4{ 5, 5, 5, 5 }, .args = .{5} });
    try common.testIntrinsic(.{ .func = vdupq_n_s32, .expected = types.i32x4{ 0, 0, 0, 0 }, .args = .{0} });
    try common.testIntrinsic(.{ .func = vdupq_n_s32, .expected = types.i32x4{ std.math.maxInt(i32), std.math.maxInt(i32), std.math.maxInt(i32), std.math.maxInt(i32) }, .args = .{std.math.maxInt(i32)} });
}

/// Duplicate vector element to vector or scalar
pub inline fn vdupq_n_s64(scalar: i64) types.i64x2 {
    return @splat(scalar);
}

test vdupq_n_s64 {
    try common.testIntrinsic(.{ .func = vdupq_n_s64, .expected = types.i64x2{ 5, 5 }, .args = .{5} });
    try common.testIntrinsic(.{ .func = vdupq_n_s64, .expected = types.i64x2{ 0, 0 }, .args = .{0} });
    try common.testIntrinsic(.{ .func = vdupq_n_s64, .expected = types.i64x2{ std.math.maxInt(i64), std.math.maxInt(i64) }, .args = .{std.math.maxInt(i64)} });
}

/// Duplicate vector element to vector or scalar
pub inline fn vdupq_n_p8(scalar: types.p8) types.p8x16 {
    return @splat(scalar);
}

test vdupq_n_p8 {
    try common.testIntrinsic(.{ .func = vdupq_n_p8, .expected = types.p8x16{ 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5 }, .args = .{5} });
    try common.testIntrinsic(.{ .func = vdupq_n_p8, .expected = types.p8x16{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }, .args = .{0} });
    try common.testIntrinsic(.{ .func = vdupq_n_p8, .expected = types.p8x16{ std.math.maxInt(types.p8), std.math.maxInt(types.p8), std.math.maxInt(types.p8), std.math.maxInt(types.p8), std.math.maxInt(types.p8), std.math.maxInt(types.p8), std.math.maxInt(types.p8), std.math.maxInt(types.p8), std.math.maxInt(types.p8), std.math.maxInt(types.p8), std.math.maxInt(types.p8), std.math.maxInt(types.p8), std.math.maxInt(types.p8), std.math.maxInt(types.p8), std.math.maxInt(types.p8), std.math.maxInt(types.p8) }, .args = .{std.math.maxInt(types.p8)} });
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
    try common.testIntrinsic(.{ .func = vdupq_n_p64, .expected = types.p64x2{ 5, 5 }, .args = .{5} });
    try common.testIntrinsic(.{ .func = vdupq_n_p64, .expected = types.p64x2{ 0, 0 }, .args = .{0} });
    try common.testIntrinsic(.{ .func = vdupq_n_p64, .expected = types.p64x2{ std.math.maxInt(u64), std.math.maxInt(u64) }, .args = .{std.math.maxInt(u64)} });
}

test vdupq_n_p16 {
    try common.testIntrinsic(.{ .func = vdupq_n_p16, .expected = types.p16x8{ 5, 5, 5, 5, 5, 5, 5, 5 }, .args = .{5} });
    try common.testIntrinsic(.{ .func = vdupq_n_p16, .expected = types.p16x8{ 0, 0, 0, 0, 0, 0, 0, 0 }, .args = .{0} });
    try common.testIntrinsic(.{ .func = vdupq_n_p16, .expected = types.p16x8{ std.math.maxInt(types.p16), std.math.maxInt(types.p16), std.math.maxInt(types.p16), std.math.maxInt(types.p16), std.math.maxInt(types.p16), std.math.maxInt(types.p16), std.math.maxInt(types.p16), std.math.maxInt(types.p16) }, .args = .{std.math.maxInt(types.p16)} });
}

/// Duplicate vector element to vector or scalar
pub inline fn vdupq_n_f16(scalar: f16) types.f16x8 {
    return @splat(scalar);
}

test vdupq_n_f16 {
    try common.testIntrinsic(.{ .func = vdupq_n_f16, .expected = types.f16x8{ 5, 5, 5, 5, 5, 5, 5, 5 }, .args = .{5} });
    try common.testIntrinsic(.{ .func = vdupq_n_f16, .expected = types.f16x8{ 0, 0, 0, 0, 0, 0, 0, 0 }, .args = .{0} });
    try common.testIntrinsic(.{ .func = vdupq_n_f16, .expected = types.f16x8{ std.math.floatMax(f16), std.math.floatMax(f16), std.math.floatMax(f16), std.math.floatMax(f16), std.math.floatMax(f16), std.math.floatMax(f16), std.math.floatMax(f16), std.math.floatMax(f16) }, .args = .{std.math.floatMax(f16)} });
}

/// Duplicate vector element to vector or scalar
pub inline fn vdupq_n_f32(scalar: f32) types.f32x4 {
    return @splat(scalar);
}

test vdupq_n_f32 {
    try common.testIntrinsic(.{ .func = vdupq_n_f32, .expected = types.f32x4{ 5, 5, 5, 5 }, .args = .{5} });
    try common.testIntrinsic(.{ .func = vdupq_n_f32, .expected = types.f32x4{ 0, 0, 0, 0 }, .args = .{0} });
    try common.testIntrinsic(.{ .func = vdupq_n_f32, .expected = types.f32x4{ std.math.floatMax(f32), std.math.floatMax(f32), std.math.floatMax(f32), std.math.floatMax(f32) }, .args = .{std.math.floatMax(f32)} });
}

/// Duplicate vector element to vector or scalar
pub inline fn vdupq_n_f64(scalar: f64) types.f64x2 {
    return @splat(scalar);
}

test vdupq_n_f64 {
    try common.testIntrinsic(.{ .func = vdupq_n_f64, .expected = types.f64x2{ 5, 5 }, .args = .{5} });
    try common.testIntrinsic(.{ .func = vdupq_n_f64, .expected = types.f64x2{ 0, 0 }, .args = .{0} });
    try common.testIntrinsic(.{ .func = vdupq_n_f64, .expected = types.f64x2{ std.math.floatMax(f64), std.math.floatMax(f64) }, .args = .{std.math.floatMax(f64)} });
}

/// Zip vectors
pub inline fn vzip1_s8(a: types.i8x8, b: types.i8x8) types.i8x8 {
    return @shuffle(i8, a, b, types.i8x8{ 0, ~@as(i8, 0), 1, ~@as(i8, 1), 2, ~@as(i8, 2), 3, ~@as(i8, 3) });
}

test vzip1_s8 {
    const a: types.i8x8 = .{ 0, 2, 4, 6, 8, 10, 12, 14 };
    const b: types.i8x8 = .{ 1, 3, 5, 7, 9, 11, 13, 15 };
    const expected: types.i8x8 = .{ 0, 1, 2, 3, 4, 5, 6, 7 };

    try common.testIntrinsic(.{ .func = vzip1_s8, .expected = expected, .args = .{ a, b } });
}

/// Zip vectors
pub inline fn vzip1_s16(a: types.i16x4, b: types.i16x4) types.i16x4 {
    return @shuffle(i16, a, b, types.i16x4{ 0, ~@as(i16, 0), 1, ~@as(i16, 1) });
}

test vzip1_s16 {
    const a: types.i16x4 = .{ 0, 2, 4, 6 };
    const b: types.i16x4 = .{ 1, 3, 5, 7 };
    const expected: types.i16x4 = .{ 0, 1, 2, 3 };

    try common.testIntrinsic(.{ .func = vzip1_s16, .expected = expected, .args = .{ a, b } });
}

/// Zip vectors
pub inline fn vzip1_s32(a: types.i32x2, b: types.i32x2) types.i32x2 {
    return @shuffle(i32, a, b, types.i32x2{ 0, ~@as(i32, 0) });
}

test vzip1_s32 {
    const a: types.i32x2 = .{ 0, 2 };
    const b: types.i32x2 = .{ 1, 3 };
    const expected: types.i32x2 = .{ 0, 1 };

    try common.testIntrinsic(.{ .func = vzip1_s32, .expected = expected, .args = .{ a, b } });
}

/// Zip vectors
pub inline fn vzip1_u8(a: types.u8x8, b: types.u8x8) types.u8x8 {
    return @shuffle(u8, a, b, types.i8x8{ 0, ~@as(i8, 0), 1, ~@as(i8, 1), 2, ~@as(i8, 2), 3, ~@as(i8, 3) });
}

test vzip1_u8 {
    const a: types.u8x8 = .{ 0, 2, 4, 6, 8, 10, 12, 14 };
    const b: types.u8x8 = .{ 1, 3, 5, 7, 9, 11, 13, 15 };
    const expected: types.u8x8 = .{ 0, 1, 2, 3, 4, 5, 6, 7 };

    try common.testIntrinsic(.{ .func = vzip1_u8, .expected = expected, .args = .{ a, b } });
}

/// Zip vectors
pub inline fn vzip1_u16(a: types.u16x4, b: types.u16x4) types.u16x4 {
    return @shuffle(u16, a, b, types.i16x4{ 0, ~@as(i16, 0), 1, ~@as(i16, 1) });
}

test vzip1_u16 {
    const a: types.u16x4 = .{ 0, 2, 4, 6 };
    const b: types.u16x4 = .{ 1, 3, 5, 7 };
    const expected: types.u16x4 = .{ 0, 1, 2, 3 };

    try common.testIntrinsic(.{ .func = vzip1_u16, .expected = expected, .args = .{ a, b } });
}

/// Zip vectors
pub inline fn vzip1_u32(a: types.u32x2, b: types.u32x2) types.u32x2 {
    return @shuffle(u32, a, b, types.i32x2{ 0, ~@as(i32, 0) });
}

test vzip1_u32 {
    const a: types.u32x2 = .{ 0, 2 };
    const b: types.u32x2 = .{ 1, 3 };
    const expected: types.u32x2 = .{ 0, 1 };

    try common.testIntrinsic(.{ .func = vzip1_u32, .expected = expected, .args = .{ a, b } });
}

/// Zip vectors
pub inline fn vzip1_f32(a: types.f32x2, b: types.f32x2) types.f32x2 {
    return @shuffle(f32, a, b, types.i32x2{ 0, ~@as(i32, 0) });
}

test vzip1_f32 {
    const a: types.f32x2 = .{ 0, 2 };
    const b: types.f32x2 = .{ 1, 3 };
    const expected: types.f32x2 = .{ 0, 1 };

    try common.testIntrinsic(.{ .func = vzip1_f32, .expected = expected, .args = .{ a, b } });
}

/// Zip vectors
pub inline fn vzip2_s8(a: types.i8x8, b: types.i8x8) types.i8x8 {
    return @shuffle(i8, a, b, types.i8x8{ 4, ~@as(i8, 4), 5, ~@as(i8, 5), 6, ~@as(i8, 6), 7, ~@as(i8, 7) });
}

test vzip2_s8 {
    const a: types.i8x8 = .{ 0, 16, 16, 18, 16, 18, 20, 22 };
    const b: types.i8x8 = .{ 1, 17, 17, 19, 17, 19, 21, 23 };
    const expected: types.i8x8 = .{ 16, 17, 18, 19, 20, 21, 22, 23 };

    try common.testIntrinsic(.{ .func = vzip2_s8, .expected = expected, .args = .{ a, b } });
}

/// Zip vectors
pub inline fn vzip2_s16(a: types.i16x4, b: types.i16x4) types.i16x4 {
    return @shuffle(i16, a, b, types.i16x4{ 2, ~@as(i16, 2), 3, ~@as(i16, 3) });
}

test vzip2_s16 {
    const a: types.i16x4 = .{ 0, 16, 16, 18 };
    const b: types.i16x4 = .{ 1, 17, 17, 19 };
    const expected: types.i16x4 = .{ 16, 17, 18, 19 };

    try common.testIntrinsic(.{ .func = vzip2_s16, .expected = expected, .args = .{ a, b } });
}

/// Zip vectors
pub inline fn vzip2_s32(a: types.i32x2, b: types.i32x2) types.i32x2 {
    return @shuffle(i32, a, b, types.i32x2{ 1, ~@as(i32, 1) });
}

test vzip2_s32 {
    const a: types.i32x2 = .{ 0, 16 };
    const b: types.i32x2 = .{ 1, 17 };
    const expected: types.i32x2 = .{ 16, 17 };

    try common.testIntrinsic(.{ .func = vzip2_s32, .expected = expected, .args = .{ a, b } });
}

/// Zip vectors
pub inline fn vzip2_u8(a: types.u8x8, b: types.u8x8) types.u8x8 {
    return @shuffle(u8, a, b, types.i8x8{ 4, ~@as(i8, 4), 5, ~@as(i8, 5), 6, ~@as(i8, 6), 7, ~@as(i8, 7) });
}

test vzip2_u8 {
    const a: types.u8x8 = .{ 0, 16, 16, 18, 16, 18, 20, 22 };
    const b: types.u8x8 = .{ 1, 17, 17, 19, 17, 19, 21, 23 };
    const expected: types.u8x8 = .{ 16, 17, 18, 19, 20, 21, 22, 23 };

    try common.testIntrinsic(.{ .func = vzip2_u8, .expected = expected, .args = .{ a, b } });
}

/// Zip vectors
pub inline fn vzip2_u16(a: types.u16x4, b: types.u16x4) types.u16x4 {
    return @shuffle(u16, a, b, types.i16x4{ 2, ~@as(i16, 2), 3, ~@as(i16, 3) });
}

test vzip2_u16 {
    const a: types.u16x4 = .{ 0, 16, 16, 18 };
    const b: types.u16x4 = .{ 1, 17, 17, 19 };
    const expected: types.u16x4 = .{ 16, 17, 18, 19 };

    try common.testIntrinsic(.{ .func = vzip2_u16, .expected = expected, .args = .{ a, b } });
}

/// Zip vectors
pub inline fn vzip2_u32(a: types.u32x2, b: types.u32x2) types.u32x2 {
    return @shuffle(u32, a, b, types.i32x2{ 1, ~@as(i32, 1) });
}

test vzip2_u32 {
    const a: types.u32x2 = .{ 0, 16 };
    const b: types.u32x2 = .{ 1, 17 };
    const expected: types.u32x2 = .{ 16, 17 };

    try common.testIntrinsic(.{ .func = vzip2_u32, .expected = expected, .args = .{ a, b } });
}

/// Zip vectors
pub inline fn vzip2_f32(a: types.f32x2, b: types.f32x2) types.f32x2 {
    return @shuffle(f32, a, b, types.i32x2{ 1, ~@as(i32, 1) });
}

test vzip2_f32 {
    const a: types.f32x2 = .{ 0, 16 };
    const b: types.f32x2 = .{ 1, 17 };
    const expected: types.f32x2 = .{ 16, 17 };

    try common.testIntrinsic(.{ .func = vzip2_f32, .expected = expected, .args = .{ a, b } });
}

/// Zip vectors
pub inline fn vzip1q_s8(a: types.i8x16, b: types.i8x16) types.i8x16 {
    return @shuffle(i8, a, b, types.i8x16{ 0, ~@as(i8, 0), 1, ~@as(i8, 1), 2, ~@as(i8, 2), 3, ~@as(i8, 3), 4, ~@as(i8, 4), 5, ~@as(i8, 5), 6, ~@as(i8, 6), 7, ~@as(i8, 7) });
}

test vzip1q_s8 {
    const a: types.i8x16 = .{ 0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30 };
    const b: types.i8x16 = .{ 1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29, 31 };
    const expected: types.i8x16 = .{ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 };

    try common.testIntrinsic(.{ .func = vzip1q_s8, .expected = expected, .args = .{ a, b } });
}

/// Zip vectors
pub inline fn vzip1q_s16(a: types.i16x8, b: types.i16x8) types.i16x8 {
    return @shuffle(i16, a, b, types.i16x8{ 0, ~@as(i16, 0), 1, ~@as(i16, 1), 2, ~@as(i16, 2), 3, ~@as(i16, 3) });
}

test vzip1q_s16 {
    const a: types.i16x8 = .{ 0, 2, 4, 6, 8, 10, 12, 14 };
    const b: types.i16x8 = .{ 1, 3, 5, 7, 9, 11, 13, 15 };
    const expected: types.i16x8 = .{ 0, 1, 2, 3, 4, 5, 6, 7 };

    try common.testIntrinsic(.{ .func = vzip1q_s16, .expected = expected, .args = .{ a, b } });
}

/// Zip vectors
pub inline fn vzip1q_s32(a: types.i32x4, b: types.i32x4) types.i32x4 {
    return @shuffle(i32, a, b, types.i32x4{ 0, ~@as(i32, 0), 1, ~@as(i32, 1) });
}

test vzip1q_s32 {
    const a: types.i32x4 = .{ 0, 2, 4, 6 };
    const b: types.i32x4 = .{ 1, 3, 5, 7 };
    const expected: types.i32x4 = .{ 0, 1, 2, 3 };

    try common.testIntrinsic(.{ .func = vzip1q_s32, .expected = expected, .args = .{ a, b } });
}

/// Zip vectors
pub inline fn vzip1q_s64(a: types.i64x2, b: types.i64x2) types.i64x2 {
    return @shuffle(i64, a, b, types.i64x2{ 0, ~@as(i64, 0) });
}

test vzip1q_s64 {
    const a: types.i64x2 = .{ 0, 2 };
    const b: types.i64x2 = .{ 1, 3 };
    const expected: types.i64x2 = .{ 0, 1 };

    try common.testIntrinsic(.{ .func = vzip1q_s64, .expected = expected, .args = .{ a, b } });
}

/// Zip vectors
pub inline fn vzip1q_u8(a: types.u8x16, b: types.u8x16) types.u8x16 {
    return @shuffle(u8, a, b, types.i8x16{ 0, ~@as(i8, 0), 1, ~@as(i8, 1), 2, ~@as(i8, 2), 3, ~@as(i8, 3), 4, ~@as(i8, 4), 5, ~@as(i8, 5), 6, ~@as(i8, 6), 7, ~@as(i8, 7) });
}

test vzip1q_u8 {
    const a: types.u8x16 = .{ 0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30 };
    const b: types.u8x16 = .{ 1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29, 31 };
    const expected: types.u8x16 = .{ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 };

    try common.testIntrinsic(.{ .func = vzip1q_u8, .expected = expected, .args = .{ a, b } });
}

/// Zip vectors
pub inline fn vzip1q_u16(a: types.u16x8, b: types.u16x8) types.u16x8 {
    return @shuffle(u16, a, b, types.i16x8{ 0, ~@as(i16, 0), 1, ~@as(i16, 1), 2, ~@as(i16, 2), 3, ~@as(i16, 3) });
}

test vzip1q_u16 {
    const a: types.u16x8 = .{ 0, 2, 4, 6, 8, 10, 12, 14 };
    const b: types.u16x8 = .{ 1, 3, 5, 7, 9, 11, 13, 15 };
    const expected: types.u16x8 = .{ 0, 1, 2, 3, 4, 5, 6, 7 };

    try common.testIntrinsic(.{ .func = vzip1q_u16, .expected = expected, .args = .{ a, b } });
}

/// Zip vectors
pub inline fn vzip1q_u32(a: types.u32x4, b: types.u32x4) types.u32x4 {
    return @shuffle(u32, a, b, types.i32x4{ 0, ~@as(i32, 0), 1, ~@as(i32, 1) });
}

test vzip1q_u32 {
    const a: types.u32x4 = .{ 0, 2, 4, 6 };
    const b: types.u32x4 = .{ 1, 3, 5, 7 };
    const expected: types.u32x4 = .{ 0, 1, 2, 3 };

    try common.testIntrinsic(.{ .func = vzip1q_u32, .expected = expected, .args = .{ a, b } });
}

/// Zip vectors
pub inline fn vzip1q_u64(a: types.u64x2, b: types.u64x2) types.u64x2 {
    return @shuffle(u64, a, b, types.i64x2{ 0, ~@as(i64, 0) });
}

test vzip1q_u64 {
    const a: types.u64x2 = .{ 0, 2 };
    const b: types.u64x2 = .{ 1, 3 };
    const expected: types.u64x2 = .{ 0, 1 };

    try common.testIntrinsic(.{ .func = vzip1q_u64, .expected = expected, .args = .{ a, b } });
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

    try common.testIntrinsic(.{ .func = vzip1q_u8, .expected = expected, .args = .{ a, b } });
}

/// Zip vectors
pub inline fn vzip1q_p16(a: types.p16x8, b: types.p16x8) types.p16x8 {
    return @shuffle(u16, a, b, types.i16x8{ 0, ~@as(i16, 0), 1, ~@as(i16, 1), 2, ~@as(i16, 2), 3, ~@as(i16, 3) });
}

test vzip1q_p16 {
    const a: types.u16x8 = .{ 0, 2, 4, 6, 8, 10, 12, 14 };
    const b: types.u16x8 = .{ 1, 3, 5, 7, 9, 11, 13, 15 };
    const expected: types.u16x8 = .{ 0, 1, 2, 3, 4, 5, 6, 7 };

    try common.testIntrinsic(.{ .func = vzip1q_u16, .expected = expected, .args = .{ a, b } });
}

/// Zip vectors
pub inline fn vzip1q_p64(a: types.p64x2, b: types.p64x2) types.p64x2 {
    return @shuffle(u64, a, b, types.i64x2{ 0, ~@as(i64, 0) });
}

test vzip1q_p64 {
    const a: types.u64x2 = .{ 0, 2 };
    const b: types.u64x2 = .{ 1, 3 };
    const expected: types.u64x2 = .{ 0, 1 };

    try common.testIntrinsic(.{ .func = vzip1q_p64, .expected = expected, .args = .{ a, b } });
}

test vzip1q_f32 {
    const a: types.f32x4 = .{ 0, 2, 4, 6 };
    const b: types.f32x4 = .{ 1, 3, 5, 7 };
    const expected: types.f32x4 = .{ 0, 1, 2, 3 };

    try common.testIntrinsic(.{ .func = vzip1q_f32, .expected = expected, .args = .{ a, b } });
}

/// Zip vectors
pub inline fn vzip1q_f64(a: types.f64x2, b: types.f64x2) types.f64x2 {
    return @shuffle(f64, a, b, types.i64x2{ 0, ~@as(i64, 0) });
}

test vzip1q_f64 {
    const a: types.f64x2 = .{ 0, 2 };
    const b: types.f64x2 = .{ 1, 3 };
    const expected: types.f64x2 = .{ 0, 1 };

    try common.testIntrinsic(.{ .func = vzip1q_f64, .expected = expected, .args = .{ a, b } });
}

/// Zip vectors
pub inline fn vzip2q_s8(a: types.i8x16, b: types.i8x16) types.i8x16 {
    return @shuffle(i8, a, b, types.i8x16{ 8, ~@as(i8, 8), 9, ~@as(i8, 9), 10, ~@as(i8, 10), 11, ~@as(i8, 11), 12, ~@as(i8, 12), 13, ~@as(i8, 13), 14, ~@as(i8, 14), 15, ~@as(i8, 15) });
}

test vzip2q_s8 {
    const a: types.i8x16 = .{ 0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30 };
    const b: types.i8x16 = .{ 1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29, 31 };
    const expected: types.i8x16 = .{ 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31 };

    try common.testIntrinsic(.{ .func = vzip2q_s8, .expected = expected, .args = .{ a, b } });
}

/// Zip vectors
pub inline fn vzip2q_s16(a: types.i16x8, b: types.i16x8) types.i16x8 {
    return @shuffle(i16, a, b, types.i16x8{ 4, ~@as(i16, 4), 5, ~@as(i16, 5), 6, ~@as(i16, 6), 7, ~@as(i16, 7) });
}

test vzip2q_s16 {
    const a: types.i16x8 = .{ 0, 2, 4, 6, 8, 10, 12, 14 };
    const b: types.i16x8 = .{ 1, 3, 5, 7, 9, 11, 13, 15 };
    const expected: types.i16x8 = .{ 8, 9, 10, 11, 12, 13, 14, 15 };

    try common.testIntrinsic(.{ .func = vzip2q_s16, .expected = expected, .args = .{ a, b } });
}

/// Zip vectors
pub inline fn vzip2q_s32(a: types.i32x4, b: types.i32x4) types.i32x4 {
    return @shuffle(i32, a, b, types.i32x4{ 2, ~@as(i32, 2), 3, ~@as(i32, 3) });
}

test vzip2q_s32 {
    const a: types.i32x4 = .{ 0, 2, 4, 6 };
    const b: types.i32x4 = .{ 1, 3, 5, 7 };
    const expected: types.i32x4 = .{ 4, 5, 6, 7 };

    try common.testIntrinsic(.{ .func = vzip2q_s32, .expected = expected, .args = .{ a, b } });
}

/// Zip vectors
pub inline fn vzip2q_s64(a: types.i64x2, b: types.i64x2) types.i64x2 {
    return @shuffle(i64, a, b, types.i64x2{ 1, ~@as(i64, 1) });
}

test vzip2q_s64 {
    const a: types.i64x2 = .{ 0, 2 };
    const b: types.i64x2 = .{ 1, 3 };
    const expected: types.i64x2 = .{ 2, 3 };

    try common.testIntrinsic(.{ .func = vzip2q_s64, .expected = expected, .args = .{ a, b } });
}

/// Zip vectors
pub inline fn vzip2q_u8(a: types.u8x16, b: types.u8x16) types.u8x16 {
    return @shuffle(u8, a, b, types.i8x16{ 8, ~@as(i8, 8), 9, ~@as(i8, 9), 10, ~@as(i8, 10), 11, ~@as(i8, 11), 12, ~@as(i8, 12), 13, ~@as(i8, 13), 14, ~@as(i8, 14), 15, ~@as(i8, 15) });
}

test vzip2q_u8 {
    const a: types.u8x16 = .{ 0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30 };
    const b: types.u8x16 = .{ 1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29, 31 };
    const expected: types.i8x16 = .{ 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31 };

    try common.testIntrinsic(.{ .func = vzip2q_s8, .expected = expected, .args = .{ a, b } });
}

/// Zip vectors
pub inline fn vzip2q_u16(a: types.u16x8, b: types.u16x8) types.u16x8 {
    return @shuffle(u16, a, b, types.i16x8{ 4, ~@as(i16, 4), 5, ~@as(i16, 5), 6, ~@as(i16, 6), 7, ~@as(i16, 7) });
}

test vzip2q_u16 {
    const a: types.u16x8 = .{ 0, 2, 4, 6, 8, 10, 12, 14 };
    const b: types.u16x8 = .{ 1, 3, 5, 7, 9, 11, 13, 15 };
    const expected: types.u16x8 = .{ 8, 9, 10, 11, 12, 13, 14, 15 };

    try common.testIntrinsic(.{ .func = vzip2q_u16, .expected = expected, .args = .{ a, b } });
}

/// Zip vectors
pub inline fn vzip2q_u32(a: types.u32x4, b: types.u32x4) types.u32x4 {
    return @shuffle(u32, a, b, types.i32x4{ 2, ~@as(i32, 2), 3, ~@as(i32, 3) });
}

test vzip2q_u32 {
    const a: types.u32x4 = .{ 0, 2, 4, 6 };
    const b: types.u32x4 = .{ 1, 3, 5, 7 };
    const expected: types.u32x4 = .{ 4, 5, 6, 7 };

    try common.testIntrinsic(.{ .func = vzip2q_u32, .expected = expected, .args = .{ a, b } });
}

/// Zip vectors
pub inline fn vzip2q_u64(a: types.u64x2, b: types.u64x2) types.u64x2 {
    return @shuffle(u64, a, b, types.i64x2{ 1, ~@as(i64, 1) });
}

test vzip2q_u64 {
    const a: types.u64x2 = .{ 0, 2 };
    const b: types.u64x2 = .{ 1, 3 };
    const expected: types.u64x2 = .{ 2, 3 };

    try common.testIntrinsic(.{ .func = vzip2q_u64, .expected = expected, .args = .{ a, b } });
}

/// Zip vectors
pub inline fn vzip2q_f32(a: types.f32x4, b: types.f32x4) types.f32x4 {
    return @shuffle(f32, a, b, types.i32x4{ 2, ~@as(i32, 2), 3, ~@as(i32, 3) });
}

test vzip2q_f32 {
    const a: types.f32x4 = .{ 0, 2, 4, 6 };
    const b: types.f32x4 = .{ 1, 3, 5, 7 };
    const expected: types.f32x4 = .{ 4, 5, 6, 7 };

    try common.testIntrinsic(.{ .func = vzip2q_f32, .expected = expected, .args = .{ a, b } });
}

/// Zip vectors
pub inline fn vzip2q_f64(a: types.f64x2, b: types.f64x2) types.f64x2 {
    return @shuffle(f64, a, b, types.i64x2{ 1, ~@as(i64, 1) });
}

test vzip2q_f64 {
    const a: types.f64x2 = .{ 0, 2 };
    const b: types.f64x2 = .{ 1, 3 };
    const expected: types.f64x2 = .{ 2, 3 };

    try common.testIntrinsic(.{ .func = vzip2q_f64, .expected = expected, .args = .{ a, b } });
}

/// Zip vectors
pub inline fn vzip2q_p8(a: types.p8x16, b: types.p8x16) types.p8x16 {
    return @shuffle(types.p8, a, b, types.i8x16{ 8, ~@as(i8, 8), 9, ~@as(i8, 9), 10, ~@as(i8, 10), 11, ~@as(i8, 11), 12, ~@as(i8, 12), 13, ~@as(i8, 13), 14, ~@as(i8, 14), 15, ~@as(i8, 15) });
}

test vzip2q_p8 {
    const a: types.p8x16 = .{ 0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30 };
    const b: types.p8x16 = .{ 1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29, 31 };
    const expected: types.i8x16 = .{ 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31 };

    try common.testIntrinsic(.{ .func = vzip2q_s8, .expected = expected, .args = .{ a, b } });
}

/// Zip vectors
pub inline fn vzip2q_p16(a: types.p16x8, b: types.p16x8) types.p16x8 {
    return @shuffle(types.p16, a, b, types.i16x8{ 4, ~@as(i16, 4), 5, ~@as(i16, 5), 6, ~@as(i16, 6), 7, ~@as(i16, 7) });
}

test vzip2q_p16 {
    const a: types.p16x8 = .{ 0, 2, 4, 6, 8, 10, 12, 14 };
    const b: types.p16x8 = .{ 1, 3, 5, 7, 9, 11, 13, 15 };
    const expected: types.p16x8 = .{ 8, 9, 10, 11, 12, 13, 14, 15 };

    try common.testIntrinsic(.{ .func = vzip2q_p16, .expected = expected, .args = .{ a, b } });
}

/// Zip vectors
pub inline fn vzip2q_p64(a: types.p64x2, b: types.p64x2) types.p64x2 {
    return @shuffle(types.p64, a, b, types.i64x2{ 1, ~@as(i64, 1) });
}

test vzip2q_p64 {
    const a: types.p64x2 = .{ 0, 2 };
    const b: types.p64x2 = .{ 1, 3 };
    const expected: types.p64x2 = .{ 2, 3 };

    try common.testIntrinsic(.{ .func = vzip2q_p64, .expected = expected, .args = .{ a, b } });
}

/// Zip vectors
pub inline fn vzipq_u8(a: types.u8x16, b: types.u8x16) types.u8x16x2 {
    return .{ vzip1q_u8(a, b), vzip2q_u8(a, b) };
}

test vzipq_u8 {
    const a: types.u8x16 = .{ 0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30 };
    const b: types.u8x16 = .{ 1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29, 31 };
    const expected: types.u8x16x2 = .{ .{ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 }, .{ 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31 } };

    try common.testIntrinsic(.{ .func = vzipq_u8, .expected = expected, .args = .{ a, b } });
}

/// Zip vectors
pub inline fn vzipq_u16(a: types.u16x8, b: types.u16x8) types.u16x8x2 {
    return .{ vzip1q_u16(a, b), vzip2q_u16(a, b) };
}

test vzipq_u16 {
    const a: types.u16x8 = .{ 0, 2, 4, 6, 8, 10, 12, 14 };
    const b: types.u16x8 = .{ 1, 3, 5, 7, 9, 11, 13, 15 };
    const expected: types.u16x8x2 = .{ .{ 0, 1, 2, 3, 4, 5, 6, 7 }, .{ 8, 9, 10, 11, 12, 13, 14, 15 } };

    try common.testIntrinsic(.{ .func = vzipq_u16, .expected = expected, .args = .{ a, b } });
}

/// Zip vectors
pub inline fn vzipq_u32(a: types.u32x4, b: types.u32x4) types.u32x4x2 {
    return .{ vzip1q_u32(a, b), vzip2q_u32(a, b) };
}

test vzipq_u32 {
    const a: types.u32x4 = .{ 0, 2, 4, 6 };
    const b: types.u32x4 = .{ 1, 3, 5, 7 };
    const expected: types.u32x4x2 = .{ .{ 0, 1, 2, 3 }, .{ 4, 5, 6, 7 } };

    try common.testIntrinsic(.{ .func = vzipq_u32, .expected = expected, .args = .{ a, b } });
}

/// Zip vectors
pub inline fn vzipq_u64(a: types.u64x2, b: types.u64x2) types.u64x2x2 {
    return .{ vzip1q_u64(a, b), vzip2q_u64(a, b) };
}

test vzipq_u64 {
    const a: types.u64x2 = .{ 0, 2 };
    const b: types.u64x2 = .{ 1, 3 };
    const expected: types.u64x2x2 = .{ .{ 0, 1 }, .{ 2, 3 } };

    try common.testIntrinsic(.{ .func = vzipq_u64, .expected = expected, .args = .{ a, b } });
}

/// Transpose vectors
pub inline fn vtrn1q_s8(a: types.i8x16, b: types.i8x16) types.i8x16 {
    return @shuffle(i8, a, b, types.i8x16{ 0, ~@as(i8, 0), 2, ~@as(i8, 2), 4, ~@as(i8, 4), 6, ~@as(i8, 6), 8, ~@as(i8, 8), 10, ~@as(i8, 10), 12, ~@as(i8, 12), 14, ~@as(i8, 14) });
}

test vtrn1q_s8 {
    const a: types.i8x16 = .{ 0, 2, 2, 6, 2, 10, 6, 14, 2, 18, 6, 22, 10, 26, 14, 30 };
    const b: types.i8x16 = .{ 1, 3, 3, 7, 3, 1, 7, 15, 3, 19, 7, 23, 1, 27, 15, 31 };
    const expected: types.i8x16 = .{ 0, 1, 2, 3, 2, 3, 6, 7, 2, 3, 6, 7, 10, 1, 14, 15 };

    try common.testIntrinsic(.{ .func = vtrn1q_s8, .expected = expected, .args = .{ a, b } });
}

/// Transpose vectors
pub inline fn vtrn1q_s16(a: types.i16x8, b: types.i16x8) types.i16x8 {
    return @shuffle(i16, a, b, types.i16x8{ 0, ~@as(i16, 0), 2, ~@as(i16, 2), 4, ~@as(i16, 4), 6, ~@as(i16, 6) });
}

test vtrn1q_s16 {
    const a: types.i16x8 = .{ 0, 2, 2, 6, 2, 10, 6, 14 };
    const b: types.i16x8 = .{ 1, 3, 3, 7, 3, 1, 7, 15 };
    const expected: types.i16x8 = .{ 0, 1, 2, 3, 2, 3, 6, 7 };

    try common.testIntrinsic(.{ .func = vtrn1q_s16, .expected = expected, .args = .{ a, b } });
}

/// Transpose vectors
pub inline fn vtrn1q_s32(a: types.i32x4, b: types.i32x4) types.i32x4 {
    return @shuffle(i32, a, b, types.i32x4{ 0, ~@as(i32, 0), 2, ~@as(i32, 2) });
}

test vtrn1q_s32 {
    const a: types.i32x4 = .{ 0, 2, 2, 6 };
    const b: types.i32x4 = .{ 1, 3, 3, 7 };
    const expected: types.i32x4 = .{ 0, 1, 2, 3 };

    try common.testIntrinsic(.{ .func = vtrn1q_s32, .expected = expected, .args = .{ a, b } });
}

/// Transpose vectors
pub inline fn vtrn1q_s64(a: types.i64x2, b: types.i64x2) types.i64x2 {
    return @shuffle(i64, a, b, types.i64x2{ 0, ~@as(i64, 0) });
}

test vtrn1q_s64 {
    const a: types.i64x2 = .{ 0, 2 };
    const b: types.i64x2 = .{ 1, 3 };
    const expected: types.i64x2 = .{ 0, 1 };

    try common.testIntrinsic(.{ .func = vtrn1q_s64, .expected = expected, .args = .{ a, b } });
}

/// Transpose vectors
pub inline fn vtrn1q_u8(a: types.u8x16, b: types.u8x16) types.u8x16 {
    return @shuffle(u8, a, b, types.i8x16{ 0, ~@as(i8, 0), 2, ~@as(i8, 2), 4, ~@as(i8, 4), 6, ~@as(i8, 6), 8, ~@as(i8, 8), 10, ~@as(i8, 10), 12, ~@as(i8, 12), 14, ~@as(i8, 14) });
}

test vtrn1q_u8 {
    const a: types.u8x16 = .{ 0, 2, 2, 6, 2, 10, 6, 14, 2, 18, 6, 22, 10, 26, 14, 30 };
    const b: types.u8x16 = .{ 1, 3, 3, 7, 3, 1, 7, 15, 3, 19, 7, 23, 1, 27, 15, 31 };
    const expected: types.u8x16 = .{ 0, 1, 2, 3, 2, 3, 6, 7, 2, 3, 6, 7, 10, 1, 14, 15 };

    try common.testIntrinsic(.{ .func = vtrn1q_u8, .expected = expected, .args = .{ a, b } });
}

/// Transpose vectors
pub inline fn vtrn1q_u16(a: types.u16x8, b: types.u16x8) types.u16x8 {
    return @shuffle(u16, a, b, types.i16x8{ 0, ~@as(i16, 0), 2, ~@as(i16, 2), 4, ~@as(i16, 4), 6, ~@as(i16, 6) });
}

test vtrn1q_u16 {
    const a: types.u16x8 = .{ 0, 2, 2, 6, 2, 10, 6, 14 };
    const b: types.u16x8 = .{ 1, 3, 3, 7, 3, 1, 7, 15 };
    const expected: types.u16x8 = .{ 0, 1, 2, 3, 2, 3, 6, 7 };

    try common.testIntrinsic(.{ .func = vtrn1q_u16, .expected = expected, .args = .{ a, b } });
}

/// Transpose vectors
pub inline fn vtrn1q_u32(a: types.u32x4, b: types.u32x4) types.u32x4 {
    return @shuffle(u32, a, b, types.i32x4{ 0, ~@as(i32, 0), 2, ~@as(i32, 2) });
}

test vtrn1q_u32 {
    const a: types.u32x4 = .{ 0, 2, 2, 6 };
    const b: types.u32x4 = .{ 1, 3, 3, 7 };
    const expected: types.u32x4 = .{ 0, 1, 2, 3 };

    try common.testIntrinsic(.{ .func = vtrn1q_u32, .expected = expected, .args = .{ a, b } });
}

/// Transpose vectors
pub inline fn vtrn1q_u64(a: types.u64x2, b: types.u64x2) types.u64x2 {
    return @shuffle(u64, a, b, types.i64x2{ 0, ~@as(i64, 0) });
}

test vtrn1q_u64 {
    const a: types.u64x2 = .{ 0, 2 };
    const b: types.u64x2 = .{ 1, 3 };
    const expected: types.u64x2 = .{ 0, 1 };

    try common.testIntrinsic(.{ .func = vtrn1q_u64, .expected = expected, .args = .{ a, b } });
}

/// Transpose vectors
pub inline fn vtrn1q_f32(a: types.f32x4, b: types.f32x4) types.f32x4 {
    return @shuffle(f32, a, b, types.i32x4{ 0, ~@as(i32, 0), 2, ~@as(i32, 2) });
}

test vtrn1q_f32 {
    const a: types.f32x4 = .{ 0, 2, 2, 6 };
    const b: types.f32x4 = .{ 1, 3, 3, 7 };
    const expected: types.f32x4 = .{ 0, 1, 2, 3 };

    try common.testIntrinsic(.{ .func = vtrn1q_f32, .expected = expected, .args = .{ a, b } });
}

/// Transpose vectors
pub inline fn vtrn1q_f64(a: types.f64x2, b: types.f64x2) types.f64x2 {
    return @shuffle(f64, a, b, types.i64x2{ 0, ~@as(i64, 0) });
}

test vtrn1q_f64 {
    const a: types.f64x2 = .{ 0, 2 };
    const b: types.f64x2 = .{ 1, 3 };
    const expected: types.f64x2 = .{ 0, 1 };

    try common.testIntrinsic(.{ .func = vtrn1q_f64, .expected = expected, .args = .{ a, b } });
}

/// Transpose vectors
pub inline fn vtrn2q_s8(a: types.i8x16, b: types.i8x16) types.i8x16 {
    return @shuffle(i8, a, b, types.i8x16{ 1, ~@as(i8, 1), 3, ~@as(i8, 3), 5, ~@as(i8, 5), 7, ~@as(i8, 7), 9, ~@as(i8, 9), 11, ~@as(i8, 11), 13, ~@as(i8, 13), 15, ~@as(i8, 15) });
}

test vtrn2q_s8 {
    const a: types.i8x16 = .{ 0, 2, 2, 6, 2, 10, 6, 14, 2, 18, 6, 22, 10, 26, 14, 30 };
    const b: types.i8x16 = .{ 1, 3, 3, 7, 3, 1, 7, 15, 3, 19, 7, 23, 1, 27, 15, 31 };
    const expected: types.i8x16 = .{ 2, 3, 6, 7, 10, 1, 14, 15, 18, 19, 22, 23, 26, 27, 30, 31 };

    try common.testIntrinsic(.{ .func = vtrn2q_s8, .expected = expected, .args = .{ a, b } });
}

/// Transpose vectors
pub inline fn vtrn2q_s16(a: types.i16x8, b: types.i16x8) types.i16x8 {
    return @shuffle(i16, a, b, types.i16x8{ 1, ~@as(i16, 1), 3, ~@as(i16, 3), 5, ~@as(i16, 5), 7, ~@as(i16, 7) });
}

test vtrn2q_s16 {
    const a: types.i16x8 = .{ 0, 2, 2, 6, 2, 10, 6, 14 };
    const b: types.i16x8 = .{ 1, 3, 3, 7, 3, 1, 7, 15 };
    const expected: types.i16x8 = .{ 2, 3, 6, 7, 10, 1, 14, 15 };

    try common.testIntrinsic(.{ .func = vtrn2q_s16, .expected = expected, .args = .{ a, b } });
}

/// Transpose vectors
pub inline fn vtrn2q_s32(a: types.i32x4, b: types.i32x4) types.i32x4 {
    return @shuffle(i32, a, b, types.i32x4{ 1, ~@as(i32, 1), 3, ~@as(i32, 3) });
}

test vtrn2q_s32 {
    const a: types.i32x4 = .{ 0, 2, 2, 6 };
    const b: types.i32x4 = .{ 1, 3, 3, 7 };
    const expected: types.i32x4 = .{ 2, 3, 6, 7 };

    try common.testIntrinsic(.{ .func = vtrn2q_s32, .expected = expected, .args = .{ a, b } });
}

/// Transpose vectors
pub inline fn vtrn2q_s64(a: types.i64x2, b: types.i64x2) types.i64x2 {
    return @shuffle(i64, a, b, types.i64x2{ 1, ~@as(i64, 1) });
}

test vtrn2q_s64 {
    const a: types.i64x2 = .{ 0, 2 };
    const b: types.i64x2 = .{ 1, 3 };
    const expected: types.i64x2 = .{ 2, 3 };

    try common.testIntrinsic(.{ .func = vtrn2q_s64, .expected = expected, .args = .{ a, b } });
}

/// Transpose vectors
pub inline fn vtrn2q_u8(a: types.u8x16, b: types.u8x16) types.u8x16 {
    return @shuffle(u8, a, b, types.i8x16{ 1, ~@as(i8, 1), 3, ~@as(i8, 3), 5, ~@as(i8, 5), 7, ~@as(i8, 7), 9, ~@as(i8, 9), 11, ~@as(i8, 11), 13, ~@as(i8, 13), 15, ~@as(i8, 15) });
}

test vtrn2q_u8 {
    const a: types.u8x16 = .{ 0, 2, 2, 6, 2, 10, 6, 14, 2, 18, 6, 22, 10, 26, 14, 30 };
    const b: types.u8x16 = .{ 1, 3, 3, 7, 3, 1, 7, 15, 3, 19, 7, 23, 1, 27, 15, 31 };
    const expected: types.u8x16 = .{ 2, 3, 6, 7, 10, 1, 14, 15, 18, 19, 22, 23, 26, 27, 30, 31 };

    try common.testIntrinsic(.{ .func = vtrn2q_u8, .expected = expected, .args = .{ a, b } });
}

/// Transpose vectors
pub inline fn vtrn2q_u16(a: types.u16x8, b: types.u16x8) types.u16x8 {
    return @shuffle(u16, a, b, types.i16x8{ 1, ~@as(i16, 1), 3, ~@as(i16, 3), 5, ~@as(i16, 5), 7, ~@as(i16, 7) });
}

test vtrn2q_u16 {
    const a: types.u16x8 = .{ 0, 2, 2, 6, 2, 10, 6, 14 };
    const b: types.u16x8 = .{ 1, 3, 3, 7, 3, 1, 7, 15 };
    const expected: types.u16x8 = .{ 2, 3, 6, 7, 10, 1, 14, 15 };

    try common.testIntrinsic(.{ .func = vtrn2q_u16, .expected = expected, .args = .{ a, b } });
}

/// Transpose vectors
pub inline fn vtrn2q_u32(a: types.u32x4, b: types.u32x4) types.u32x4 {
    return @shuffle(u32, a, b, types.i32x4{ 1, ~@as(i32, 1), 3, ~@as(i32, 3) });
}

test vtrn2q_u32 {
    const a: types.u32x4 = .{ 0, 2, 2, 6 };
    const b: types.u32x4 = .{ 1, 3, 3, 7 };
    const expected: types.u32x4 = .{ 2, 3, 6, 7 };

    try common.testIntrinsic(.{ .func = vtrn2q_u32, .expected = expected, .args = .{ a, b } });
}

/// Transpose vectors
pub inline fn vtrn2q_u64(a: types.u64x2, b: types.u64x2) types.u64x2 {
    return @shuffle(u64, a, b, types.i64x2{ 1, ~@as(i64, 1) });
}

test vtrn2q_u64 {
    const a: types.u64x2 = .{ 0, 2 };
    const b: types.u64x2 = .{ 1, 3 };
    const expected: types.u64x2 = .{ 2, 3 };

    try common.testIntrinsic(.{ .func = vtrn2q_u64, .expected = expected, .args = .{ a, b } });
}

/// Transpose vectors
pub inline fn vtrn2q_f32(a: types.f32x4, b: types.f32x4) types.f32x4 {
    return @shuffle(f32, a, b, types.i32x4{ 1, ~@as(i32, 1), 3, ~@as(i32, 3) });
}

test vtrn2q_f32 {
    const a: types.f32x4 = .{ 0, 2, 2, 6 };
    const b: types.f32x4 = .{ 1, 3, 3, 7 };
    const expected: types.f32x4 = .{ 2, 3, 6, 7 };

    try common.testIntrinsic(.{ .func = vtrn2q_f32, .expected = expected, .args = .{ a, b } });
}

/// Transpose vectors
pub inline fn vtrn2q_f64(a: types.f64x2, b: types.f64x2) types.f64x2 {
    return @shuffle(f64, a, b, types.i64x2{ 1, ~@as(i64, 1) });
}

test vtrn2q_f64 {
    const a: types.f64x2 = .{ 0, 2 };
    const b: types.f64x2 = .{ 1, 3 };
    const expected: types.f64x2 = .{ 2, 3 };

    try common.testIntrinsic(.{ .func = vtrn2q_f64, .expected = expected, .args = .{ a, b } });
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

    try common.testIntrinsic(.{ .func = vtrnq_s8, .expected = expected, .args = .{ a, b } });
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

    try common.testIntrinsic(.{ .func = vtrnq_s16, .expected = expected, .args = .{ a, b } });
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

    try common.testIntrinsic(.{ .func = vtrnq_s32, .expected = expected, .args = .{ a, b } });
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

    try common.testIntrinsic(.{ .func = vtrnq_u8, .expected = expected, .args = .{ a, b } });
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

    try common.testIntrinsic(.{ .func = vtrnq_u16, .expected = expected, .args = .{ a, b } });
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

    try common.testIntrinsic(.{ .func = vtrnq_u32, .expected = expected, .args = .{ a, b } });
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

    try common.testIntrinsic(.{ .func = vtrnq_f32, .expected = expected, .args = .{ a, b } });
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

    try common.testIntrinsic(.{ .func = vtrnq_p8, .expected = expected, .args = .{ a, b } });
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

    try common.testIntrinsic(.{ .func = vtrnq_p16, .expected = expected, .args = .{ a, b } });
}

/// Reversing vector elements (swap endianness)
pub inline fn vrev64q_s8(a: types.i8x16) types.i8x16 {
    return @shuffle(i8, a, undefined, types.i8x16{ 7, 6, 5, 4, 3, 2, 1, 0, 15, 14, 13, 12, 11, 10, 9, 8 });
}

test vrev64q_s8 {
    const a: types.i8x16 = .{ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 };
    const expected: types.i8x16 = .{ 7, 6, 5, 4, 3, 2, 1, 0, 15, 14, 13, 12, 11, 10, 9, 8 };

    try common.testIntrinsic(.{ .func = vrev64q_s8, .expected = expected, .args = .{a} });
}

/// Reversing vector elements (swap endianness)
pub inline fn vrev64q_s16(a: types.i16x8) types.i16x8 {
    return @shuffle(i16, a, undefined, types.i16x8{ 3, 2, 1, 0, 7, 6, 5, 4 });
}

test vrev64q_s16 {
    const a: types.i16x8 = .{ 0, 1, 2, 3, 4, 5, 6, 7 };
    const expected: types.i16x8 = .{ 3, 2, 1, 0, 7, 6, 5, 4 };

    try common.testIntrinsic(.{ .func = vrev64q_s16, .expected = expected, .args = .{a} });
}

/// Reversing vector elements (swap endianness)
pub inline fn vrev64q_s32(a: types.i32x4) types.i32x4 {
    return @shuffle(i32, a, undefined, types.i32x4{ 1, 0, 3, 2 });
}

test vrev64q_s32 {
    const a: types.i32x4 = .{ 0, 1, 2, 3 };
    const expected: types.i32x4 = .{ 1, 0, 3, 2 };

    try common.testIntrinsic(.{ .func = vrev64q_s32, .expected = expected, .args = .{a} });
}

/// Reversing vector elements (swap endianness)
pub inline fn vrev64q_u8(a: types.u8x16) types.u8x16 {
    return @shuffle(u8, a, undefined, types.u8x16{ 7, 6, 5, 4, 3, 2, 1, 0, 15, 14, 13, 12, 11, 10, 9, 8 });
}

test vrev64q_u8 {
    const a: types.u8x16 = .{ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 };
    const expected: types.u8x16 = .{ 7, 6, 5, 4, 3, 2, 1, 0, 15, 14, 13, 12, 11, 10, 9, 8 };

    try common.testIntrinsic(.{ .func = vrev64q_u8, .expected = expected, .args = .{a} });
}

/// Reversing vector elements (swap endianness)
pub inline fn vrev64q_u16(a: types.u16x8) types.u16x8 {
    return @shuffle(u16, a, undefined, types.u16x8{ 3, 2, 1, 0, 7, 6, 5, 4 });
}

test vrev64q_u16 {
    const a: types.u16x8 = .{ 0, 1, 2, 3, 4, 5, 6, 7 };
    const expected: types.u16x8 = .{ 3, 2, 1, 0, 7, 6, 5, 4 };

    try common.testIntrinsic(.{ .func = vrev64q_u16, .expected = expected, .args = .{a} });
}

/// Reversing vector elements (swap endianness)
pub inline fn vrev64q_u32(a: types.u32x4) types.u32x4 {
    return @shuffle(u32, a, undefined, types.u32x4{ 1, 0, 3, 2 });
}

test vrev64q_u32 {
    const a: types.u32x4 = .{ 0, 1, 2, 3 };
    const expected: types.u32x4 = .{ 1, 0, 3, 2 };

    try common.testIntrinsic(.{ .func = vrev64q_u32, .expected = expected, .args = .{a} });
}

/// Reversing vector elements (swap endianness)
pub inline fn vrev64q_p8(a: types.p8x16) types.p8x16 {
    return @shuffle(types.p8, a, undefined, types.p8x16{ 7, 6, 5, 4, 3, 2, 1, 0, 15, 14, 13, 12, 11, 10, 9, 8 });
}

test vrev64q_p8 {
    const a: types.p8x16 = .{ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 };
    const expected: types.p8x16 = .{ 7, 6, 5, 4, 3, 2, 1, 0, 15, 14, 13, 12, 11, 10, 9, 8 };

    try common.testIntrinsic(.{ .func = vrev64q_p8, .expected = expected, .args = .{a} });
}

/// Reversing vector elements (swap endianness)
pub inline fn vrev64q_p16(a: types.p16x8) types.p16x8 {
    return @shuffle(types.p16, a, undefined, types.p16x8{ 3, 2, 1, 0, 7, 6, 5, 4 });
}

test vrev64q_p16 {
    const a: types.p16x8 = .{ 0, 1, 2, 3, 4, 5, 6, 7 };
    const expected: types.p16x8 = .{ 3, 2, 1, 0, 7, 6, 5, 4 };

    try common.testIntrinsic(.{ .func = vrev64q_p16, .expected = expected, .args = .{a} });
}

/// Reversing vector elements (swap endianness)
pub inline fn vrev64q_f32(a: types.f32x4) types.f32x4 {
    return @shuffle(f32, a, undefined, types.f32x4{ 1, 0, 3, 2 });
}

test vrev64q_f32 {
    const a: types.f32x4 = .{ 0, 1, 2, 3 };
    const expected: types.f32x4 = .{ 1, 0, 3, 2 };

    try common.testIntrinsic(.{ .func = vrev64q_f32, .expected = expected, .args = .{a} });
}

/// Vector combine
pub inline fn vcombine_s8(a: types.i8x8, b: types.i8x8) types.i8x16 {
    return common.join(a, b);
}

test vcombine_s8 {
    const a: types.i8x8 = .{ 0, 1, 2, 3, 4, 5, 6, 7 };
    const b: types.i8x8 = .{ 8, 9, 10, 11, 12, 13, 14, 15 };
    const expected: types.i8x16 = .{ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 };

    try common.testIntrinsic(.{ .func = vcombine_s8, .expected = expected, .args = .{ a, b } });
}

/// Vector combine
pub inline fn vcombine_s16(a: types.i16x4, b: types.i16x4) types.i16x8 {
    return common.join(a, b);
}

test vcombine_s16 {
    const a: types.i16x4 = .{ 0, 1, 2, 3 };
    const b: types.i16x4 = .{ 4, 5, 6, 7 };
    const expected: types.i16x8 = .{ 0, 1, 2, 3, 4, 5, 6, 7 };

    try common.testIntrinsic(.{ .func = vcombine_s16, .expected = expected, .args = .{ a, b } });
}

/// Vector combine
pub inline fn vcombine_s32(a: types.i32x2, b: types.i32x2) types.i32x4 {
    return common.join(a, b);
}

test vcombine_s32 {
    const a: types.i32x2 = .{ 0, 1 };
    const b: types.i32x2 = .{ 2, 3 };
    const expected: types.i32x4 = .{ 0, 1, 2, 3 };

    try common.testIntrinsic(.{ .func = vcombine_s32, .expected = expected, .args = .{ a, b } });
}

/// Vector combine
pub inline fn vcombine_s64(a: types.i64x1, b: types.i64x1) types.i64x2 {
    return common.join(a, b);
}

test vcombine_s64 {
    const a: types.i64x1 = .{0};
    const b: types.i64x1 = .{1};
    const expected: types.i64x2 = .{ 0, 1 };

    try common.testIntrinsic(.{ .func = vcombine_s64, .expected = expected, .args = .{ a, b } });
}

/// Vector combine
pub inline fn vcombine_u8(a: types.u8x8, b: types.u8x8) types.u8x16 {
    return common.join(a, b);
}

test vcombine_u8 {
    const a: types.u8x8 = .{ 0, 1, 2, 3, 4, 5, 6, 7 };
    const b: types.u8x8 = .{ 8, 9, 10, 11, 12, 13, 14, 15 };
    const expected: types.u8x16 = .{ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 };

    try common.testIntrinsic(.{ .func = vcombine_u8, .expected = expected, .args = .{ a, b } });
}

/// Vector combine
pub inline fn vcombine_u16(a: types.u16x4, b: types.u16x4) types.u16x8 {
    return common.join(a, b);
}

test vcombine_u16 {
    const a: types.u16x4 = .{ 0, 1, 2, 3 };
    const b: types.u16x4 = .{ 4, 5, 6, 7 };
    const expected: types.u16x8 = .{ 0, 1, 2, 3, 4, 5, 6, 7 };

    try common.testIntrinsic(.{ .func = vcombine_u16, .expected = expected, .args = .{ a, b } });
}

/// Vector combine
pub inline fn vcombine_u32(a: types.u32x2, b: types.u32x2) types.u32x4 {
    return common.join(a, b);
}

test vcombine_u32 {
    const a: types.u32x2 = .{ 0, 1 };
    const b: types.u32x2 = .{ 2, 3 };
    const expected: types.u32x4 = .{ 0, 1, 2, 3 };

    try common.testIntrinsic(.{ .func = vcombine_u32, .expected = expected, .args = .{ a, b } });
}

/// Vector combine
pub inline fn vcombine_u64(a: types.u64x1, b: types.u64x1) types.u64x2 {
    return common.join(a, b);
}

test vcombine_u64 {
    const a: types.u64x1 = .{0};
    const b: types.u64x1 = .{1};
    const expected: types.u64x2 = .{ 0, 1 };

    try common.testIntrinsic(.{ .func = vcombine_u64, .expected = expected, .args = .{ a, b } });
}

/// Vector combine
pub inline fn vcombine_p8(a: types.p8x8, b: types.p8x8) types.p8x16 {
    return common.join(a, b);
}

test vcombine_p8 {
    const a: types.p8x8 = .{ 0, 1, 2, 3, 4, 5, 6, 7 };
    const b: types.p8x8 = .{ 8, 9, 10, 11, 12, 13, 14, 15 };
    const expected: types.p8x16 = .{ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 };

    try common.testIntrinsic(.{ .func = vcombine_p8, .expected = expected, .args = .{ a, b } });
}

/// Vector combine
pub inline fn vcombine_p16(a: types.p16x4, b: types.p16x4) types.p16x8 {
    return common.join(a, b);
}

test vcombine_p16 {
    const a: types.p16x4 = .{ 0, 1, 2, 3 };
    const b: types.p16x4 = .{ 4, 5, 6, 7 };
    const expected: types.p16x8 = .{ 0, 1, 2, 3, 4, 5, 6, 7 };

    try common.testIntrinsic(.{ .func = vcombine_p16, .expected = expected, .args = .{ a, b } });
}

/// Vector combine
pub inline fn vcombine_f16(a: types.f16x4, b: types.f16x4) types.f16x8 {
    return common.join(a, b);
}

test vcombine_f16 {
    const a: types.f16x4 = .{ 0, 1, 2, 3 };
    const b: types.f16x4 = .{ 4, 5, 6, 7 };
    const expected: types.f16x8 = .{ 0, 1, 2, 3, 4, 5, 6, 7 };

    try common.testIntrinsic(.{ .func = vcombine_f16, .expected = expected, .args = .{ a, b } });
}

/// Vector combine
pub inline fn vcombine_f32(a: types.f32x2, b: types.f32x2) types.f32x4 {
    return common.join(a, b);
}

test vcombine_f32 {
    const a: types.f32x2 = .{ 0, 1 };
    const b: types.f32x2 = .{ 2, 3 };
    const expected: types.f32x4 = .{ 0, 1, 2, 3 };

    try common.testIntrinsic(.{ .func = vcombine_f32, .expected = expected, .args = .{ a, b } });
}

/// Vector combine
pub inline fn vcombine_f64(a: types.f64x1, b: types.f64x1) types.f64x2 {
    return common.join(a, b);
}

test vcombine_f64 {
    const a: types.f64x1 = .{0};
    const b: types.f64x1 = .{1};
    const expected: types.f64x2 = .{ 0, 1 };

    try common.testIntrinsic(.{ .func = vcombine_f64, .expected = expected, .args = .{ a, b } });
}

/// Duplicate vector element to vector or scalar
pub inline fn vmovq_n_u8(scalar: u8) types.u8x16 {
    return vdupq_n_u8(scalar);
}

test vmovq_n_u8 {
    const scalar: u8 = 66;
    const expected: types.u8x16 = .{ 66, 66, 66, 66, 66, 66, 66, 66, 66, 66, 66, 66, 66, 66, 66, 66 };

    try common.testIntrinsic(.{ .func = vmovq_n_u8, .expected = expected, .args = .{scalar} });
}

/// Duplicate vector element to vector or scalar
pub inline fn vmovq_n_u16(scalar: u16) types.u16x8 {
    return vdupq_n_u16(scalar);
}

test vmovq_n_u16 {
    const scalar: u16 = 2701;
    const expected: types.u16x8 = .{ 2701, 2701, 2701, 2701, 2701, 2701, 2701, 2701 };

    try common.testIntrinsic(.{ .func = vmovq_n_u16, .expected = expected, .args = .{scalar} });
}

/// Duplicate vector element to vector or scalar
pub inline fn vmovq_n_u32(scalar: u32) types.u32x4 {
    return vdupq_n_u32(scalar);
}

test vmovq_n_u32 {
    const scalar: u32 = 717371659;
    const expected: types.u32x4 = .{ 717371659, 717371659, 717371659, 717371659 };

    try common.testIntrinsic(.{ .func = vmovq_n_u32, .expected = expected, .args = .{scalar} });
}

/// Duplicate vector element to vector or scalar
pub inline fn vmovq_n_u64(scalar: u64) types.u64x2 {
    return vdupq_n_u64(scalar);
}

test vmovq_n_u64 {
    const scalar: u64 = 13609191869422731000;
    const expected: types.u64x2 = .{ 13609191869422731000, 13609191869422731000 };

    try common.testIntrinsic(.{ .func = vmovq_n_u64, .expected = expected, .args = .{scalar} });
}

/// Duplicate vector element to vector or scalar
pub inline fn vmovq_n_s8(scalar: i8) types.i8x16 {
    return vdupq_n_s8(scalar);
}

test vmovq_n_s8 {
    const scalar: i8 = 14;
    const expected: types.i8x16 = .{ 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14 };

    try common.testIntrinsic(.{ .func = vmovq_n_s8, .expected = expected, .args = .{scalar} });
}

/// Duplicate vector element to vector or scalar
pub inline fn vmovq_n_s16(scalar: i16) types.i16x8 {
    return vdupq_n_s16(scalar);
}

test vmovq_n_s16 {
    const scalar: i16 = 27570;
    const expected: types.i16x8 = .{ 27570, 27570, 27570, 27570, 27570, 27570, 27570, 27570 };

    try common.testIntrinsic(.{ .func = vmovq_n_s16, .expected = expected, .args = .{scalar} });
}

/// Duplicate vector element to vector or scalar
pub inline fn vmovq_n_s32(scalar: i32) types.i32x4 {
    return vdupq_n_s32(scalar);
}

test vmovq_n_s32 {
    const scalar: i32 = 964454829;
    const expected: types.i32x4 = .{ 964454829, 964454829, 964454829, 964454829 };

    try common.testIntrinsic(.{ .func = vmovq_n_s32, .expected = expected, .args = .{scalar} });
}

/// Duplicate vector element to vector or scalar
pub inline fn vmovq_n_s64(scalar: i64) types.i64x2 {
    return vdupq_n_s64(scalar);
}

test vmovq_n_s64 {
    const scalar: i64 = 4555543976599521300;
    const expected: types.i64x2 = .{ 4555543976599521300, 4555543976599521300 };

    try common.testIntrinsic(.{ .func = vmovq_n_s64, .expected = expected, .args = .{scalar} });
}

/// Duplicate vector element to vector or scalar
pub inline fn vmovq_n_p8(scalar: types.p8) types.p8x16 {
    return vdupq_n_p8(scalar);
}

test vmovq_n_p8 {
    const scalar: types.p8 = 187;
    const expected: types.p8x16 = .{ 187, 187, 187, 187, 187, 187, 187, 187, 187, 187, 187, 187, 187, 187, 187, 187 };

    try common.testIntrinsic(.{ .func = vmovq_n_p8, .expected = expected, .args = .{scalar} });
}

/// Duplicate vector element to vector or scalar
pub inline fn vmovq_n_p16(scalar: types.p16) types.p16x8 {
    return vdupq_n_p16(scalar);
}

test vmovq_n_p16 {
    const scalar: types.p16 = 54032;
    const expected: types.p16x8 = .{ 54032, 54032, 54032, 54032, 54032, 54032, 54032, 54032 };

    try common.testIntrinsic(.{ .func = vmovq_n_p16, .expected = expected, .args = .{scalar} });
}

/// Duplicate vector element to vector or scalar
pub inline fn vmovq_n_p64(scalar: types.p64) types.p64x2 {
    return vdupq_n_p64(scalar);
}

test vmovq_n_p64 {
    const scalar: types.p64 = 13609191869422731000;
    const expected: types.p64x2 = .{ 13609191869422731000, 13609191869422731000 };

    try common.testIntrinsic(.{ .func = vmovq_n_p64, .expected = expected, .args = .{scalar} });
}

/// Duplicate vector element to vector or scalar
pub inline fn vmovq_n_f32(scalar: f32) types.f32x4 {
    return vdupq_n_f32(scalar);
}

test vmovq_n_f32 {
    const scalar: f32 = 3.559321397026124e+37;
    const expected: types.f32x4 = .{ 3.559321397026124e+37, 3.559321397026124e+37, 3.559321397026124e+37, 3.559321397026124e+37 };

    try common.testIntrinsic(.{ .func = vmovq_n_f32, .expected = expected, .args = .{scalar} });
}

/// Duplicate vector element to vector or scalar
pub inline fn vmovq_n_f64(scalar: f64) types.f64x2 {
    return vdupq_n_f64(scalar);
}

test vmovq_n_f64 {
    const scalar: f64 = 8.935392104998695e+306;
    const expected: types.f64x2 = .{ 8.935392104998695e+306, 8.935392104998695e+306 };

    try common.testIntrinsic(.{ .func = vmovq_n_f64, .expected = expected, .args = .{scalar} });
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

        try common.testIntrinsic(.{ .func = vqtbl1q_s8, .expected = expected, .args = .{ t, idx } });
    }
    {
        const t: types.i8x16 = .{ 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127 };
        const idx: types.i8x16 = .{ 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0 };
        const expected: types.i8x16 = .{ 127, 126, 125, 124, 123, 122, 121, 120, 119, 118, 117, 116, 115, 114, 113, 112 };

        try common.testIntrinsic(.{ .func = vqtbl1q_s8, .expected = expected, .args = .{ t, idx } });
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

    try common.testIntrinsic(.{ .func = vqtbl1q_u8, .expected = expected, .args = .{ t, idx } });
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

    try common.testIntrinsic(.{ .func = vqtbl1q_p8, .expected = expected, .args = .{ t, idx } });
}
/// Scalar saturating narrowing move
pub inline fn vqmovnh_s16(a: i16) i8 {
    return @intCast(std.math.clamp(a, std.math.minInt(i8), std.math.maxInt(i8)));
}

test vqmovnh_s16 {
    const a: i16 = 42;
    const expected: i8 = 42;
    try common.testIntrinsic(.{ .func = vqmovnh_s16, .expected = expected, .args = .{a} });
}

/// Scalar saturating narrowing move
pub inline fn vqmovnh_u16(a: u16) u8 {
    return @intCast(std.math.clamp(a, 0, std.math.maxInt(u8)));
}

test vqmovnh_u16 {
    const a: u16 = 42;
    const expected: u8 = 42;
    try common.testIntrinsic(.{ .func = vqmovnh_u16, .expected = expected, .args = .{a} });
}

/// Scalar saturating narrowing move
pub inline fn vqmovns_s32(a: i32) i16 {
    return @intCast(std.math.clamp(a, std.math.minInt(i16), std.math.maxInt(i16)));
}

test vqmovns_s32 {
    const a: i32 = 42;
    const expected: i16 = 42;
    try common.testIntrinsic(.{ .func = vqmovns_s32, .expected = expected, .args = .{a} });
}

/// Scalar saturating narrowing move
pub inline fn vqmovns_u32(a: u32) u16 {
    return @intCast(std.math.clamp(a, 0, std.math.maxInt(u16)));
}

test vqmovns_u32 {
    const a: u32 = 42;
    const expected: u16 = 42;
    try common.testIntrinsic(.{ .func = vqmovns_u32, .expected = expected, .args = .{a} });
}

/// Scalar saturating narrowing move
pub inline fn vqmovnd_s64(a: i64) i32 {
    return @intCast(std.math.clamp(a, std.math.minInt(i32), std.math.maxInt(i32)));
}

test vqmovnd_s64 {
    const a: i64 = 42;
    const expected: i32 = 42;
    try common.testIntrinsic(.{ .func = vqmovnd_s64, .expected = expected, .args = .{a} });
}

/// Scalar saturating narrowing move
pub inline fn vqmovnd_u64(a: u64) u32 {
    return @intCast(std.math.clamp(a, 0, std.math.maxInt(u32)));
}

test vqmovnd_u64 {
    const a: u64 = 42;
    const expected: u32 = 42;
    try common.testIntrinsic(.{ .func = vqmovnd_u64, .expected = expected, .args = .{a} });
}

/// Scalar saturating narrowing move
pub inline fn vqmovunh_s16(a: i16) u8 {
    return @intCast(std.math.clamp(a, 0, std.math.maxInt(u8)));
}

test vqmovunh_s16 {
    const a: i16 = 42;
    const expected: u8 = 42;
    try common.testIntrinsic(.{ .func = vqmovunh_s16, .expected = expected, .args = .{a} });
}

/// Scalar saturating narrowing move
pub inline fn vqmovuns_s32(a: i32) u16 {
    return @intCast(std.math.clamp(a, 0, std.math.maxInt(u16)));
}

test vqmovuns_s32 {
    const a: i32 = 42;
    const expected: u16 = 42;
    try common.testIntrinsic(.{ .func = vqmovuns_s32, .expected = expected, .args = .{a} });
}

/// Scalar saturating narrowing move
pub inline fn vqmovund_s64(a: i64) u32 {
    return @intCast(std.math.clamp(a, 0, std.math.maxInt(u32)));
}

test vqmovund_s64 {
    const a: i64 = 42;
    const expected: u32 = 42;
    try common.testIntrinsic(.{ .func = vqmovund_s64, .expected = expected, .args = .{a} });
}

/// Table lookup (1x 64-bit vectors)
pub inline fn vtbl1_s8(t: types.i8x8, idx: types.i8x8) types.i8x8 {
    var res: types.i8x8 = undefined;
    inline for (0..8) |i| {
        const u_idx: u8 = @bitCast(idx[i]);
        res[i] = blk: {
            if (u_idx < 8) break :blk t[u_idx - 0];
            break :blk 0;
        };
    }
    return res;
}

test vtbl1_s8 {
    const t: types.i8x8 = @as(types.i8x8, @splat(0x42));
    const idx = @as(types.i8x8, @splat(0));
    const expected = @as(types.i8x8, @splat(0x42));
    try common.testIntrinsic(.{ .func = vtbl1_s8, .expected = expected, .args = .{ t, idx } });
}

/// Table lookup (1x 64-bit vectors)
pub inline fn vtbl1_u8(t: types.u8x8, idx: types.u8x8) types.u8x8 {
    var res: types.u8x8 = undefined;
    inline for (0..8) |i| {
        const u_idx: u8 = @bitCast(idx[i]);
        res[i] = blk: {
            if (u_idx < 8) break :blk t[u_idx - 0];
            break :blk 0;
        };
    }
    return res;
}

test vtbl1_u8 {
    const t: types.u8x8 = @as(types.u8x8, @splat(0x42));
    const idx = @as(types.u8x8, @splat(0));
    const expected = @as(types.u8x8, @splat(0x42));
    try common.testIntrinsic(.{ .func = vtbl1_u8, .expected = expected, .args = .{ t, idx } });
}

/// Table lookup (1x 64-bit vectors)
pub inline fn vtbl1_p8(t: types.p8x8, idx: types.p8x8) types.p8x8 {
    var res: types.p8x8 = undefined;
    inline for (0..8) |i| {
        const u_idx: u8 = @bitCast(idx[i]);
        res[i] = blk: {
            if (u_idx < 8) break :blk t[u_idx - 0];
            break :blk 0;
        };
    }
    return res;
}

test vtbl1_p8 {
    const t: types.p8x8 = @as(types.p8x8, @splat(0x42));
    const idx = @as(types.p8x8, @splat(0));
    const expected = @as(types.p8x8, @splat(0x42));
    try common.testIntrinsic(.{ .func = vtbl1_p8, .expected = expected, .args = .{ t, idx } });
}

/// Table lookup (2x 64-bit vectors)
pub inline fn vtbl2_s8(t: types.i8x8x2, idx: types.i8x8) types.i8x8 {
    var res: types.i8x8 = undefined;
    inline for (0..8) |i| {
        const u_idx: u8 = @bitCast(idx[i]);
        res[i] = blk: {
            if (u_idx < 8) break :blk t[0][u_idx - 0];
            if (u_idx < 16) break :blk t[1][u_idx - 8];
            break :blk 0;
        };
    }
    return res;
}

test vtbl2_s8 {
    const t: types.i8x8x2 = .{ @as(types.i8x8, @splat(0x42)), @as(types.i8x8, @splat(0x42)) };
    const idx = @as(types.i8x8, @splat(0));
    const expected = @as(types.i8x8, @splat(0x42));
    try common.testIntrinsic(.{ .func = vtbl2_s8, .expected = expected, .args = .{ t, idx } });
}

/// Table lookup (2x 64-bit vectors)
pub inline fn vtbl2_u8(t: types.u8x8x2, idx: types.u8x8) types.u8x8 {
    var res: types.u8x8 = undefined;
    inline for (0..8) |i| {
        const u_idx: u8 = @bitCast(idx[i]);
        res[i] = blk: {
            if (u_idx < 8) break :blk t[0][u_idx - 0];
            if (u_idx < 16) break :blk t[1][u_idx - 8];
            break :blk 0;
        };
    }
    return res;
}

test vtbl2_u8 {
    const t: types.u8x8x2 = .{ @as(types.u8x8, @splat(0x42)), @as(types.u8x8, @splat(0x42)) };
    const idx = @as(types.u8x8, @splat(0));
    const expected = @as(types.u8x8, @splat(0x42));
    try common.testIntrinsic(.{ .func = vtbl2_u8, .expected = expected, .args = .{ t, idx } });
}

/// Table lookup (2x 64-bit vectors)
pub inline fn vtbl2_p8(t: types.p8x8x2, idx: types.p8x8) types.p8x8 {
    var res: types.p8x8 = undefined;
    inline for (0..8) |i| {
        const u_idx: u8 = @bitCast(idx[i]);
        res[i] = blk: {
            if (u_idx < 8) break :blk t[0][u_idx - 0];
            if (u_idx < 16) break :blk t[1][u_idx - 8];
            break :blk 0;
        };
    }
    return res;
}

test vtbl2_p8 {
    const t: types.p8x8x2 = .{ @as(types.p8x8, @splat(0x42)), @as(types.p8x8, @splat(0x42)) };
    const idx = @as(types.p8x8, @splat(0));
    const expected = @as(types.p8x8, @splat(0x42));
    try common.testIntrinsic(.{ .func = vtbl2_p8, .expected = expected, .args = .{ t, idx } });
}

/// Table lookup (3x 64-bit vectors)
pub inline fn vtbl3_s8(t: types.i8x8x3, idx: types.i8x8) types.i8x8 {
    var res: types.i8x8 = undefined;
    inline for (0..8) |i| {
        const u_idx: u8 = @bitCast(idx[i]);
        res[i] = blk: {
            if (u_idx < 8) break :blk t[0][u_idx - 0];
            if (u_idx < 16) break :blk t[1][u_idx - 8];
            if (u_idx < 24) break :blk t[2][u_idx - 16];
            break :blk 0;
        };
    }
    return res;
}

test vtbl3_s8 {
    const t: types.i8x8x3 = .{ @as(types.i8x8, @splat(0x42)), @as(types.i8x8, @splat(0x42)), @as(types.i8x8, @splat(0x42)) };
    const idx = @as(types.i8x8, @splat(0));
    const expected = @as(types.i8x8, @splat(0x42));
    try common.testIntrinsic(.{ .func = vtbl3_s8, .expected = expected, .args = .{ t, idx } });
}

/// Table lookup (3x 64-bit vectors)
pub inline fn vtbl3_u8(t: types.u8x8x3, idx: types.u8x8) types.u8x8 {
    var res: types.u8x8 = undefined;
    inline for (0..8) |i| {
        const u_idx: u8 = @bitCast(idx[i]);
        res[i] = blk: {
            if (u_idx < 8) break :blk t[0][u_idx - 0];
            if (u_idx < 16) break :blk t[1][u_idx - 8];
            if (u_idx < 24) break :blk t[2][u_idx - 16];
            break :blk 0;
        };
    }
    return res;
}

test vtbl3_u8 {
    const t: types.u8x8x3 = .{ @as(types.u8x8, @splat(0x42)), @as(types.u8x8, @splat(0x42)), @as(types.u8x8, @splat(0x42)) };
    const idx = @as(types.u8x8, @splat(0));
    const expected = @as(types.u8x8, @splat(0x42));
    try common.testIntrinsic(.{ .func = vtbl3_u8, .expected = expected, .args = .{ t, idx } });
}

/// Table lookup (3x 64-bit vectors)
pub inline fn vtbl3_p8(t: types.p8x8x3, idx: types.p8x8) types.p8x8 {
    var res: types.p8x8 = undefined;
    inline for (0..8) |i| {
        const u_idx: u8 = @bitCast(idx[i]);
        res[i] = blk: {
            if (u_idx < 8) break :blk t[0][u_idx - 0];
            if (u_idx < 16) break :blk t[1][u_idx - 8];
            if (u_idx < 24) break :blk t[2][u_idx - 16];
            break :blk 0;
        };
    }
    return res;
}

test vtbl3_p8 {
    const t: types.p8x8x3 = .{ @as(types.p8x8, @splat(0x42)), @as(types.p8x8, @splat(0x42)), @as(types.p8x8, @splat(0x42)) };
    const idx = @as(types.p8x8, @splat(0));
    const expected = @as(types.p8x8, @splat(0x42));
    try common.testIntrinsic(.{ .func = vtbl3_p8, .expected = expected, .args = .{ t, idx } });
}

/// Table lookup (4x 64-bit vectors)
pub inline fn vtbl4_s8(t: types.i8x8x4, idx: types.i8x8) types.i8x8 {
    var res: types.i8x8 = undefined;
    inline for (0..8) |i| {
        const u_idx: u8 = @bitCast(idx[i]);
        res[i] = blk: {
            if (u_idx < 8) break :blk t[0][u_idx - 0];
            if (u_idx < 16) break :blk t[1][u_idx - 8];
            if (u_idx < 24) break :blk t[2][u_idx - 16];
            if (u_idx < 32) break :blk t[3][u_idx - 24];
            break :blk 0;
        };
    }
    return res;
}

test vtbl4_s8 {
    const t: types.i8x8x4 = .{ @as(types.i8x8, @splat(0x42)), @as(types.i8x8, @splat(0x42)), @as(types.i8x8, @splat(0x42)), @as(types.i8x8, @splat(0x42)) };
    const idx = @as(types.i8x8, @splat(0));
    const expected = @as(types.i8x8, @splat(0x42));
    try common.testIntrinsic(.{ .func = vtbl4_s8, .expected = expected, .args = .{ t, idx } });
}

/// Table lookup (4x 64-bit vectors)
pub inline fn vtbl4_u8(t: types.u8x8x4, idx: types.u8x8) types.u8x8 {
    var res: types.u8x8 = undefined;
    inline for (0..8) |i| {
        const u_idx: u8 = @bitCast(idx[i]);
        res[i] = blk: {
            if (u_idx < 8) break :blk t[0][u_idx - 0];
            if (u_idx < 16) break :blk t[1][u_idx - 8];
            if (u_idx < 24) break :blk t[2][u_idx - 16];
            if (u_idx < 32) break :blk t[3][u_idx - 24];
            break :blk 0;
        };
    }
    return res;
}

test vtbl4_u8 {
    const t: types.u8x8x4 = .{ @as(types.u8x8, @splat(0x42)), @as(types.u8x8, @splat(0x42)), @as(types.u8x8, @splat(0x42)), @as(types.u8x8, @splat(0x42)) };
    const idx = @as(types.u8x8, @splat(0));
    const expected = @as(types.u8x8, @splat(0x42));
    try common.testIntrinsic(.{ .func = vtbl4_u8, .expected = expected, .args = .{ t, idx } });
}

/// Table lookup (4x 64-bit vectors)
pub inline fn vtbl4_p8(t: types.p8x8x4, idx: types.p8x8) types.p8x8 {
    var res: types.p8x8 = undefined;
    inline for (0..8) |i| {
        const u_idx: u8 = @bitCast(idx[i]);
        res[i] = blk: {
            if (u_idx < 8) break :blk t[0][u_idx - 0];
            if (u_idx < 16) break :blk t[1][u_idx - 8];
            if (u_idx < 24) break :blk t[2][u_idx - 16];
            if (u_idx < 32) break :blk t[3][u_idx - 24];
            break :blk 0;
        };
    }
    return res;
}

test vtbl4_p8 {
    const t: types.p8x8x4 = .{ @as(types.p8x8, @splat(0x42)), @as(types.p8x8, @splat(0x42)), @as(types.p8x8, @splat(0x42)), @as(types.p8x8, @splat(0x42)) };
    const idx = @as(types.p8x8, @splat(0));
    const expected = @as(types.p8x8, @splat(0x42));
    try common.testIntrinsic(.{ .func = vtbl4_p8, .expected = expected, .args = .{ t, idx } });
}

/// Table lookup (1x 128-bit vectors, 64-bit result)
pub inline fn vqtbl1_s8(t: types.i8x16, idx: types.i8x8) types.i8x8 {
    var res: types.i8x8 = undefined;
    inline for (0..8) |i| {
        const u_idx: u8 = @bitCast(idx[i]);
        res[i] = blk: {
            if (u_idx < 16) break :blk t[u_idx - 0];
            break :blk 0;
        };
    }
    return res;
}

test vqtbl1_s8 {
    const t: types.i8x16 = @as(types.i8x16, @splat(0x42));
    const idx = @as(types.i8x8, @splat(0));
    const expected = @as(types.i8x8, @splat(0x42));
    try common.testIntrinsic(.{ .func = vqtbl1_s8, .expected = expected, .args = .{ t, idx } });
}

/// Table lookup (1x 128-bit vectors, 64-bit result)
pub inline fn vqtbl1_u8(t: types.u8x16, idx: types.u8x8) types.u8x8 {
    var res: types.u8x8 = undefined;
    inline for (0..8) |i| {
        const u_idx: u8 = @bitCast(idx[i]);
        res[i] = blk: {
            if (u_idx < 16) break :blk t[u_idx - 0];
            break :blk 0;
        };
    }
    return res;
}

test vqtbl1_u8 {
    const t: types.u8x16 = @as(types.u8x16, @splat(0x42));
    const idx = @as(types.u8x8, @splat(0));
    const expected = @as(types.u8x8, @splat(0x42));
    try common.testIntrinsic(.{ .func = vqtbl1_u8, .expected = expected, .args = .{ t, idx } });
}

/// Table lookup (1x 128-bit vectors, 64-bit result)
pub inline fn vqtbl1_p8(t: types.p8x16, idx: types.p8x8) types.p8x8 {
    var res: types.p8x8 = undefined;
    inline for (0..8) |i| {
        const u_idx: u8 = @bitCast(idx[i]);
        res[i] = blk: {
            if (u_idx < 16) break :blk t[u_idx - 0];
            break :blk 0;
        };
    }
    return res;
}

test vqtbl1_p8 {
    const t: types.p8x16 = @as(types.p8x16, @splat(0x42));
    const idx = @as(types.p8x8, @splat(0));
    const expected = @as(types.p8x8, @splat(0x42));
    try common.testIntrinsic(.{ .func = vqtbl1_p8, .expected = expected, .args = .{ t, idx } });
}

/// Table lookup (2x 128-bit vectors, 64-bit result)
pub inline fn vqtbl2_s8(t: types.i8x16x2, idx: types.i8x8) types.i8x8 {
    var res: types.i8x8 = undefined;
    inline for (0..8) |i| {
        const u_idx: u8 = @bitCast(idx[i]);
        res[i] = blk: {
            if (u_idx < 16) break :blk t[0][u_idx - 0];
            if (u_idx < 32) break :blk t[1][u_idx - 16];
            break :blk 0;
        };
    }
    return res;
}

test vqtbl2_s8 {
    const t: types.i8x16x2 = .{ @as(types.i8x16, @splat(0x42)), @as(types.i8x16, @splat(0x42)) };
    const idx = @as(types.i8x8, @splat(0));
    const expected = @as(types.i8x8, @splat(0x42));
    try common.testIntrinsic(.{ .func = vqtbl2_s8, .expected = expected, .args = .{ t, idx } });
}

/// Table lookup (2x 128-bit vectors, 64-bit result)
pub inline fn vqtbl2_u8(t: types.u8x16x2, idx: types.u8x8) types.u8x8 {
    var res: types.u8x8 = undefined;
    inline for (0..8) |i| {
        const u_idx: u8 = @bitCast(idx[i]);
        res[i] = blk: {
            if (u_idx < 16) break :blk t[0][u_idx - 0];
            if (u_idx < 32) break :blk t[1][u_idx - 16];
            break :blk 0;
        };
    }
    return res;
}

test vqtbl2_u8 {
    const t: types.u8x16x2 = .{ @as(types.u8x16, @splat(0x42)), @as(types.u8x16, @splat(0x42)) };
    const idx = @as(types.u8x8, @splat(0));
    const expected = @as(types.u8x8, @splat(0x42));
    try common.testIntrinsic(.{ .func = vqtbl2_u8, .expected = expected, .args = .{ t, idx } });
}

/// Table lookup (2x 128-bit vectors, 64-bit result)
pub inline fn vqtbl2_p8(t: types.p8x16x2, idx: types.p8x8) types.p8x8 {
    var res: types.p8x8 = undefined;
    inline for (0..8) |i| {
        const u_idx: u8 = @bitCast(idx[i]);
        res[i] = blk: {
            if (u_idx < 16) break :blk t[0][u_idx - 0];
            if (u_idx < 32) break :blk t[1][u_idx - 16];
            break :blk 0;
        };
    }
    return res;
}

test vqtbl2_p8 {
    const t: types.p8x16x2 = .{ @as(types.p8x16, @splat(0x42)), @as(types.p8x16, @splat(0x42)) };
    const idx = @as(types.p8x8, @splat(0));
    const expected = @as(types.p8x8, @splat(0x42));
    try common.testIntrinsic(.{ .func = vqtbl2_p8, .expected = expected, .args = .{ t, idx } });
}

/// Table lookup (3x 128-bit vectors, 64-bit result)
pub inline fn vqtbl3_s8(t: types.i8x16x3, idx: types.i8x8) types.i8x8 {
    var res: types.i8x8 = undefined;
    inline for (0..8) |i| {
        const u_idx: u8 = @bitCast(idx[i]);
        res[i] = blk: {
            if (u_idx < 16) break :blk t[0][u_idx - 0];
            if (u_idx < 32) break :blk t[1][u_idx - 16];
            if (u_idx < 48) break :blk t[2][u_idx - 32];
            break :blk 0;
        };
    }
    return res;
}

test vqtbl3_s8 {
    const t: types.i8x16x3 = .{ @as(types.i8x16, @splat(0x42)), @as(types.i8x16, @splat(0x42)), @as(types.i8x16, @splat(0x42)) };
    const idx = @as(types.i8x8, @splat(0));
    const expected = @as(types.i8x8, @splat(0x42));
    try common.testIntrinsic(.{ .func = vqtbl3_s8, .expected = expected, .args = .{ t, idx } });
}

/// Table lookup (3x 128-bit vectors, 64-bit result)
pub inline fn vqtbl3_u8(t: types.u8x16x3, idx: types.u8x8) types.u8x8 {
    var res: types.u8x8 = undefined;
    inline for (0..8) |i| {
        const u_idx: u8 = @bitCast(idx[i]);
        res[i] = blk: {
            if (u_idx < 16) break :blk t[0][u_idx - 0];
            if (u_idx < 32) break :blk t[1][u_idx - 16];
            if (u_idx < 48) break :blk t[2][u_idx - 32];
            break :blk 0;
        };
    }
    return res;
}

test vqtbl3_u8 {
    const t: types.u8x16x3 = .{ @as(types.u8x16, @splat(0x42)), @as(types.u8x16, @splat(0x42)), @as(types.u8x16, @splat(0x42)) };
    const idx = @as(types.u8x8, @splat(0));
    const expected = @as(types.u8x8, @splat(0x42));
    try common.testIntrinsic(.{ .func = vqtbl3_u8, .expected = expected, .args = .{ t, idx } });
}

/// Table lookup (3x 128-bit vectors, 64-bit result)
pub inline fn vqtbl3_p8(t: types.p8x16x3, idx: types.p8x8) types.p8x8 {
    var res: types.p8x8 = undefined;
    inline for (0..8) |i| {
        const u_idx: u8 = @bitCast(idx[i]);
        res[i] = blk: {
            if (u_idx < 16) break :blk t[0][u_idx - 0];
            if (u_idx < 32) break :blk t[1][u_idx - 16];
            if (u_idx < 48) break :blk t[2][u_idx - 32];
            break :blk 0;
        };
    }
    return res;
}

test vqtbl3_p8 {
    const t: types.p8x16x3 = .{ @as(types.p8x16, @splat(0x42)), @as(types.p8x16, @splat(0x42)), @as(types.p8x16, @splat(0x42)) };
    const idx = @as(types.p8x8, @splat(0));
    const expected = @as(types.p8x8, @splat(0x42));
    try common.testIntrinsic(.{ .func = vqtbl3_p8, .expected = expected, .args = .{ t, idx } });
}

/// Table lookup (4x 128-bit vectors, 64-bit result)
pub inline fn vqtbl4_s8(t: types.i8x16x4, idx: types.i8x8) types.i8x8 {
    var res: types.i8x8 = undefined;
    inline for (0..8) |i| {
        const u_idx: u8 = @bitCast(idx[i]);
        res[i] = blk: {
            if (u_idx < 16) break :blk t[0][u_idx - 0];
            if (u_idx < 32) break :blk t[1][u_idx - 16];
            if (u_idx < 48) break :blk t[2][u_idx - 32];
            if (u_idx < 64) break :blk t[3][u_idx - 48];
            break :blk 0;
        };
    }
    return res;
}

test vqtbl4_s8 {
    const t: types.i8x16x4 = .{ @as(types.i8x16, @splat(0x42)), @as(types.i8x16, @splat(0x42)), @as(types.i8x16, @splat(0x42)), @as(types.i8x16, @splat(0x42)) };
    const idx = @as(types.i8x8, @splat(0));
    const expected = @as(types.i8x8, @splat(0x42));
    try common.testIntrinsic(.{ .func = vqtbl4_s8, .expected = expected, .args = .{ t, idx } });
}

/// Table lookup (4x 128-bit vectors, 64-bit result)
pub inline fn vqtbl4_u8(t: types.u8x16x4, idx: types.u8x8) types.u8x8 {
    var res: types.u8x8 = undefined;
    inline for (0..8) |i| {
        const u_idx: u8 = @bitCast(idx[i]);
        res[i] = blk: {
            if (u_idx < 16) break :blk t[0][u_idx - 0];
            if (u_idx < 32) break :blk t[1][u_idx - 16];
            if (u_idx < 48) break :blk t[2][u_idx - 32];
            if (u_idx < 64) break :blk t[3][u_idx - 48];
            break :blk 0;
        };
    }
    return res;
}

test vqtbl4_u8 {
    const t: types.u8x16x4 = .{ @as(types.u8x16, @splat(0x42)), @as(types.u8x16, @splat(0x42)), @as(types.u8x16, @splat(0x42)), @as(types.u8x16, @splat(0x42)) };
    const idx = @as(types.u8x8, @splat(0));
    const expected = @as(types.u8x8, @splat(0x42));
    try common.testIntrinsic(.{ .func = vqtbl4_u8, .expected = expected, .args = .{ t, idx } });
}

/// Table lookup (4x 128-bit vectors, 64-bit result)
pub inline fn vqtbl4_p8(t: types.p8x16x4, idx: types.p8x8) types.p8x8 {
    var res: types.p8x8 = undefined;
    inline for (0..8) |i| {
        const u_idx: u8 = @bitCast(idx[i]);
        res[i] = blk: {
            if (u_idx < 16) break :blk t[0][u_idx - 0];
            if (u_idx < 32) break :blk t[1][u_idx - 16];
            if (u_idx < 48) break :blk t[2][u_idx - 32];
            if (u_idx < 64) break :blk t[3][u_idx - 48];
            break :blk 0;
        };
    }
    return res;
}

test vqtbl4_p8 {
    const t: types.p8x16x4 = .{ @as(types.p8x16, @splat(0x42)), @as(types.p8x16, @splat(0x42)), @as(types.p8x16, @splat(0x42)), @as(types.p8x16, @splat(0x42)) };
    const idx = @as(types.p8x8, @splat(0));
    const expected = @as(types.p8x8, @splat(0x42));
    try common.testIntrinsic(.{ .func = vqtbl4_p8, .expected = expected, .args = .{ t, idx } });
}

/// Table lookup (2x 128-bit vectors, 128-bit result)
pub inline fn vqtbl2q_s8(t: types.i8x16x2, idx: types.u8x16) types.i8x16 {
    var res: types.i8x16 = undefined;
    inline for (0..16) |i| {
        const u_idx = idx[i];
        res[i] = blk: {
            if (u_idx < 16) break :blk t[0][u_idx - 0];
            if (u_idx < 32) break :blk t[1][u_idx - 16];
            break :blk 0;
        };
    }
    return res;
}

test vqtbl2q_s8 {
    const t: types.i8x16x2 = .{ @as(types.i8x16, @splat(0x42)), @as(types.i8x16, @splat(0x42)) };
    const idx = @as(types.u8x16, @splat(0));
    const expected = @as(types.i8x16, @splat(0x42));
    try common.testIntrinsic(.{ .func = vqtbl2q_s8, .expected = expected, .args = .{ t, idx } });
}

/// Table lookup (2x 128-bit vectors, 128-bit result)
pub inline fn vqtbl2q_u8(t: types.u8x16x2, idx: types.u8x16) types.u8x16 {
    var res: types.u8x16 = undefined;
    inline for (0..16) |i| {
        const u_idx = idx[i];
        res[i] = blk: {
            if (u_idx < 16) break :blk t[0][u_idx - 0];
            if (u_idx < 32) break :blk t[1][u_idx - 16];
            break :blk 0;
        };
    }
    return res;
}

test vqtbl2q_u8 {
    const t: types.u8x16x2 = .{ @as(types.u8x16, @splat(0x42)), @as(types.u8x16, @splat(0x42)) };
    const idx = @as(types.u8x16, @splat(0));
    const expected = @as(types.u8x16, @splat(0x42));
    try common.testIntrinsic(.{ .func = vqtbl2q_u8, .expected = expected, .args = .{ t, idx } });
}

/// Table lookup (2x 128-bit vectors, 128-bit result)
pub inline fn vqtbl2q_p8(t: types.p8x16x2, idx: types.u8x16) types.p8x16 {
    var res: types.p8x16 = undefined;
    inline for (0..16) |i| {
        const u_idx = idx[i];
        res[i] = blk: {
            if (u_idx < 16) break :blk t[0][u_idx - 0];
            if (u_idx < 32) break :blk t[1][u_idx - 16];
            break :blk 0;
        };
    }
    return res;
}

test vqtbl2q_p8 {
    const t: types.p8x16x2 = .{ @as(types.p8x16, @splat(0x42)), @as(types.p8x16, @splat(0x42)) };
    const idx = @as(types.u8x16, @splat(0));
    const expected = @as(types.p8x16, @splat(0x42));
    try common.testIntrinsic(.{ .func = vqtbl2q_p8, .expected = expected, .args = .{ t, idx } });
}

/// Table lookup (3x 128-bit vectors, 128-bit result)
pub inline fn vqtbl3q_s8(t: types.i8x16x3, idx: types.u8x16) types.i8x16 {
    var res: types.i8x16 = undefined;
    inline for (0..16) |i| {
        const u_idx = idx[i];
        res[i] = blk: {
            if (u_idx < 16) break :blk t[0][u_idx - 0];
            if (u_idx < 32) break :blk t[1][u_idx - 16];
            if (u_idx < 48) break :blk t[2][u_idx - 32];
            break :blk 0;
        };
    }
    return res;
}

test vqtbl3q_s8 {
    const t: types.i8x16x3 = .{ @as(types.i8x16, @splat(0x42)), @as(types.i8x16, @splat(0x42)), @as(types.i8x16, @splat(0x42)) };
    const idx = @as(types.u8x16, @splat(0));
    const expected = @as(types.i8x16, @splat(0x42));
    try common.testIntrinsic(.{ .func = vqtbl3q_s8, .expected = expected, .args = .{ t, idx } });
}

/// Table lookup (3x 128-bit vectors, 128-bit result)
pub inline fn vqtbl3q_u8(t: types.u8x16x3, idx: types.u8x16) types.u8x16 {
    var res: types.u8x16 = undefined;
    inline for (0..16) |i| {
        const u_idx = idx[i];
        res[i] = blk: {
            if (u_idx < 16) break :blk t[0][u_idx - 0];
            if (u_idx < 32) break :blk t[1][u_idx - 16];
            if (u_idx < 48) break :blk t[2][u_idx - 32];
            break :blk 0;
        };
    }
    return res;
}

test vqtbl3q_u8 {
    const t: types.u8x16x3 = .{ @as(types.u8x16, @splat(0x42)), @as(types.u8x16, @splat(0x42)), @as(types.u8x16, @splat(0x42)) };
    const idx = @as(types.u8x16, @splat(0));
    const expected = @as(types.u8x16, @splat(0x42));
    try common.testIntrinsic(.{ .func = vqtbl3q_u8, .expected = expected, .args = .{ t, idx } });
}

/// Table lookup (3x 128-bit vectors, 128-bit result)
pub inline fn vqtbl3q_p8(t: types.p8x16x3, idx: types.u8x16) types.p8x16 {
    var res: types.p8x16 = undefined;
    inline for (0..16) |i| {
        const u_idx = idx[i];
        res[i] = blk: {
            if (u_idx < 16) break :blk t[0][u_idx - 0];
            if (u_idx < 32) break :blk t[1][u_idx - 16];
            if (u_idx < 48) break :blk t[2][u_idx - 32];
            break :blk 0;
        };
    }
    return res;
}

test vqtbl3q_p8 {
    const t: types.p8x16x3 = .{ @as(types.p8x16, @splat(0x42)), @as(types.p8x16, @splat(0x42)), @as(types.p8x16, @splat(0x42)) };
    const idx = @as(types.u8x16, @splat(0));
    const expected = @as(types.p8x16, @splat(0x42));
    try common.testIntrinsic(.{ .func = vqtbl3q_p8, .expected = expected, .args = .{ t, idx } });
}

/// Table lookup (4x 128-bit vectors, 128-bit result)
pub inline fn vqtbl4q_s8(t: types.i8x16x4, idx: types.u8x16) types.i8x16 {
    var res: types.i8x16 = undefined;
    inline for (0..16) |i| {
        const u_idx = idx[i];
        res[i] = blk: {
            if (u_idx < 16) break :blk t[0][u_idx - 0];
            if (u_idx < 32) break :blk t[1][u_idx - 16];
            if (u_idx < 48) break :blk t[2][u_idx - 32];
            if (u_idx < 64) break :blk t[3][u_idx - 48];
            break :blk 0;
        };
    }
    return res;
}

test vqtbl4q_s8 {
    const t: types.i8x16x4 = .{ @as(types.i8x16, @splat(0x42)), @as(types.i8x16, @splat(0x42)), @as(types.i8x16, @splat(0x42)), @as(types.i8x16, @splat(0x42)) };
    const idx = @as(types.u8x16, @splat(0));
    const expected = @as(types.i8x16, @splat(0x42));
    try common.testIntrinsic(.{ .func = vqtbl4q_s8, .expected = expected, .args = .{ t, idx } });
}

/// Table lookup (4x 128-bit vectors, 128-bit result)
pub inline fn vqtbl4q_u8(t: types.u8x16x4, idx: types.u8x16) types.u8x16 {
    var res: types.u8x16 = undefined;
    inline for (0..16) |i| {
        const u_idx = idx[i];
        res[i] = blk: {
            if (u_idx < 16) break :blk t[0][u_idx - 0];
            if (u_idx < 32) break :blk t[1][u_idx - 16];
            if (u_idx < 48) break :blk t[2][u_idx - 32];
            if (u_idx < 64) break :blk t[3][u_idx - 48];
            break :blk 0;
        };
    }
    return res;
}

test vqtbl4q_u8 {
    const t: types.u8x16x4 = .{ @as(types.u8x16, @splat(0x42)), @as(types.u8x16, @splat(0x42)), @as(types.u8x16, @splat(0x42)), @as(types.u8x16, @splat(0x42)) };
    const idx = @as(types.u8x16, @splat(0));
    const expected = @as(types.u8x16, @splat(0x42));
    try common.testIntrinsic(.{ .func = vqtbl4q_u8, .expected = expected, .args = .{ t, idx } });
}

/// Table lookup (4x 128-bit vectors, 128-bit result)
pub inline fn vqtbl4q_p8(t: types.p8x16x4, idx: types.u8x16) types.p8x16 {
    var res: types.p8x16 = undefined;
    inline for (0..16) |i| {
        const u_idx = idx[i];
        res[i] = blk: {
            if (u_idx < 16) break :blk t[0][u_idx - 0];
            if (u_idx < 32) break :blk t[1][u_idx - 16];
            if (u_idx < 48) break :blk t[2][u_idx - 32];
            if (u_idx < 64) break :blk t[3][u_idx - 48];
            break :blk 0;
        };
    }
    return res;
}

test vqtbl4q_p8 {
    const t: types.p8x16x4 = .{ @as(types.p8x16, @splat(0x42)), @as(types.p8x16, @splat(0x42)), @as(types.p8x16, @splat(0x42)), @as(types.p8x16, @splat(0x42)) };
    const idx = @as(types.u8x16, @splat(0));
    const expected = @as(types.p8x16, @splat(0x42));
    try common.testIntrinsic(.{ .func = vqtbl4q_p8, .expected = expected, .args = .{ t, idx } });
}

/// Table lookup and insert (1x 64-bit vectors)
pub inline fn vtbx1_s8(default_val: types.i8x8, t: types.i8x8, idx: types.i8x8) types.i8x8 {
    var res: types.i8x8 = undefined;
    inline for (0..8) |i| {
        const u_idx: u8 = @bitCast(idx[i]);
        res[i] = blk: {
            if (u_idx < 8) break :blk t[u_idx - 0];
            break :blk default_val[i];
        };
    }
    return res;
}

test vtbx1_s8 {
    const d = @as(types.i8x8, @splat(0x10));
    const t: types.i8x8 = @as(types.i8x8, @splat(0x42));
    const idx = @as(types.i8x8, @splat(0));
    const expected = @as(types.i8x8, @splat(0x42));
    try common.testIntrinsic(.{ .func = vtbx1_s8, .expected = expected, .args = .{ d, t, idx } });
}

/// Table lookup and insert (1x 64-bit vectors)
pub inline fn vtbx1_u8(default_val: types.u8x8, t: types.u8x8, idx: types.u8x8) types.u8x8 {
    var res: types.u8x8 = undefined;
    inline for (0..8) |i| {
        const u_idx: u8 = @bitCast(idx[i]);
        res[i] = blk: {
            if (u_idx < 8) break :blk t[u_idx - 0];
            break :blk default_val[i];
        };
    }
    return res;
}

test vtbx1_u8 {
    const d = @as(types.u8x8, @splat(0x10));
    const t: types.u8x8 = @as(types.u8x8, @splat(0x42));
    const idx = @as(types.u8x8, @splat(0));
    const expected = @as(types.u8x8, @splat(0x42));
    try common.testIntrinsic(.{ .func = vtbx1_u8, .expected = expected, .args = .{ d, t, idx } });
}

/// Table lookup and insert (1x 64-bit vectors)
pub inline fn vtbx1_p8(default_val: types.p8x8, t: types.p8x8, idx: types.p8x8) types.p8x8 {
    var res: types.p8x8 = undefined;
    inline for (0..8) |i| {
        const u_idx: u8 = @bitCast(idx[i]);
        res[i] = blk: {
            if (u_idx < 8) break :blk t[u_idx - 0];
            break :blk default_val[i];
        };
    }
    return res;
}

test vtbx1_p8 {
    const d = @as(types.p8x8, @splat(0x10));
    const t: types.p8x8 = @as(types.p8x8, @splat(0x42));
    const idx = @as(types.p8x8, @splat(0));
    const expected = @as(types.p8x8, @splat(0x42));
    try common.testIntrinsic(.{ .func = vtbx1_p8, .expected = expected, .args = .{ d, t, idx } });
}

/// Table lookup and insert (2x 64-bit vectors)
pub inline fn vtbx2_s8(default_val: types.i8x8, t: types.i8x8x2, idx: types.i8x8) types.i8x8 {
    var res: types.i8x8 = undefined;
    inline for (0..8) |i| {
        const u_idx: u8 = @bitCast(idx[i]);
        res[i] = blk: {
            if (u_idx < 8) break :blk t[0][u_idx - 0];
            if (u_idx < 16) break :blk t[1][u_idx - 8];
            break :blk default_val[i];
        };
    }
    return res;
}

test vtbx2_s8 {
    const d = @as(types.i8x8, @splat(0x10));
    const t: types.i8x8x2 = .{ @as(types.i8x8, @splat(0x42)), @as(types.i8x8, @splat(0x42)) };
    const idx = @as(types.i8x8, @splat(0));
    const expected = @as(types.i8x8, @splat(0x42));
    try common.testIntrinsic(.{ .func = vtbx2_s8, .expected = expected, .args = .{ d, t, idx } });
}

/// Table lookup and insert (2x 64-bit vectors)
pub inline fn vtbx2_u8(default_val: types.u8x8, t: types.u8x8x2, idx: types.u8x8) types.u8x8 {
    var res: types.u8x8 = undefined;
    inline for (0..8) |i| {
        const u_idx: u8 = @bitCast(idx[i]);
        res[i] = blk: {
            if (u_idx < 8) break :blk t[0][u_idx - 0];
            if (u_idx < 16) break :blk t[1][u_idx - 8];
            break :blk default_val[i];
        };
    }
    return res;
}

test vtbx2_u8 {
    const d = @as(types.u8x8, @splat(0x10));
    const t: types.u8x8x2 = .{ @as(types.u8x8, @splat(0x42)), @as(types.u8x8, @splat(0x42)) };
    const idx = @as(types.u8x8, @splat(0));
    const expected = @as(types.u8x8, @splat(0x42));
    try common.testIntrinsic(.{ .func = vtbx2_u8, .expected = expected, .args = .{ d, t, idx } });
}

/// Table lookup and insert (2x 64-bit vectors)
pub inline fn vtbx2_p8(default_val: types.p8x8, t: types.p8x8x2, idx: types.p8x8) types.p8x8 {
    var res: types.p8x8 = undefined;
    inline for (0..8) |i| {
        const u_idx: u8 = @bitCast(idx[i]);
        res[i] = blk: {
            if (u_idx < 8) break :blk t[0][u_idx - 0];
            if (u_idx < 16) break :blk t[1][u_idx - 8];
            break :blk default_val[i];
        };
    }
    return res;
}

test vtbx2_p8 {
    const d = @as(types.p8x8, @splat(0x10));
    const t: types.p8x8x2 = .{ @as(types.p8x8, @splat(0x42)), @as(types.p8x8, @splat(0x42)) };
    const idx = @as(types.p8x8, @splat(0));
    const expected = @as(types.p8x8, @splat(0x42));
    try common.testIntrinsic(.{ .func = vtbx2_p8, .expected = expected, .args = .{ d, t, idx } });
}

/// Table lookup and insert (3x 64-bit vectors)
pub inline fn vtbx3_s8(default_val: types.i8x8, t: types.i8x8x3, idx: types.i8x8) types.i8x8 {
    var res: types.i8x8 = undefined;
    inline for (0..8) |i| {
        const u_idx: u8 = @bitCast(idx[i]);
        res[i] = blk: {
            if (u_idx < 8) break :blk t[0][u_idx - 0];
            if (u_idx < 16) break :blk t[1][u_idx - 8];
            if (u_idx < 24) break :blk t[2][u_idx - 16];
            break :blk default_val[i];
        };
    }
    return res;
}

test vtbx3_s8 {
    const d = @as(types.i8x8, @splat(0x10));
    const t: types.i8x8x3 = .{ @as(types.i8x8, @splat(0x42)), @as(types.i8x8, @splat(0x42)), @as(types.i8x8, @splat(0x42)) };
    const idx = @as(types.i8x8, @splat(0));
    const expected = @as(types.i8x8, @splat(0x42));
    try common.testIntrinsic(.{ .func = vtbx3_s8, .expected = expected, .args = .{ d, t, idx } });
}

/// Table lookup and insert (3x 64-bit vectors)
pub inline fn vtbx3_u8(default_val: types.u8x8, t: types.u8x8x3, idx: types.u8x8) types.u8x8 {
    var res: types.u8x8 = undefined;
    inline for (0..8) |i| {
        const u_idx: u8 = @bitCast(idx[i]);
        res[i] = blk: {
            if (u_idx < 8) break :blk t[0][u_idx - 0];
            if (u_idx < 16) break :blk t[1][u_idx - 8];
            if (u_idx < 24) break :blk t[2][u_idx - 16];
            break :blk default_val[i];
        };
    }
    return res;
}

test vtbx3_u8 {
    const d = @as(types.u8x8, @splat(0x10));
    const t: types.u8x8x3 = .{ @as(types.u8x8, @splat(0x42)), @as(types.u8x8, @splat(0x42)), @as(types.u8x8, @splat(0x42)) };
    const idx = @as(types.u8x8, @splat(0));
    const expected = @as(types.u8x8, @splat(0x42));
    try common.testIntrinsic(.{ .func = vtbx3_u8, .expected = expected, .args = .{ d, t, idx } });
}

/// Table lookup and insert (3x 64-bit vectors)
pub inline fn vtbx3_p8(default_val: types.p8x8, t: types.p8x8x3, idx: types.p8x8) types.p8x8 {
    var res: types.p8x8 = undefined;
    inline for (0..8) |i| {
        const u_idx: u8 = @bitCast(idx[i]);
        res[i] = blk: {
            if (u_idx < 8) break :blk t[0][u_idx - 0];
            if (u_idx < 16) break :blk t[1][u_idx - 8];
            if (u_idx < 24) break :blk t[2][u_idx - 16];
            break :blk default_val[i];
        };
    }
    return res;
}

test vtbx3_p8 {
    const d = @as(types.p8x8, @splat(0x10));
    const t: types.p8x8x3 = .{ @as(types.p8x8, @splat(0x42)), @as(types.p8x8, @splat(0x42)), @as(types.p8x8, @splat(0x42)) };
    const idx = @as(types.p8x8, @splat(0));
    const expected = @as(types.p8x8, @splat(0x42));
    try common.testIntrinsic(.{ .func = vtbx3_p8, .expected = expected, .args = .{ d, t, idx } });
}

/// Table lookup and insert (4x 64-bit vectors)
pub inline fn vtbx4_s8(default_val: types.i8x8, t: types.i8x8x4, idx: types.i8x8) types.i8x8 {
    var res: types.i8x8 = undefined;
    inline for (0..8) |i| {
        const u_idx: u8 = @bitCast(idx[i]);
        res[i] = blk: {
            if (u_idx < 8) break :blk t[0][u_idx - 0];
            if (u_idx < 16) break :blk t[1][u_idx - 8];
            if (u_idx < 24) break :blk t[2][u_idx - 16];
            if (u_idx < 32) break :blk t[3][u_idx - 24];
            break :blk default_val[i];
        };
    }
    return res;
}

test vtbx4_s8 {
    const d = @as(types.i8x8, @splat(0x10));
    const t: types.i8x8x4 = .{ @as(types.i8x8, @splat(0x42)), @as(types.i8x8, @splat(0x42)), @as(types.i8x8, @splat(0x42)), @as(types.i8x8, @splat(0x42)) };
    const idx = @as(types.i8x8, @splat(0));
    const expected = @as(types.i8x8, @splat(0x42));
    try common.testIntrinsic(.{ .func = vtbx4_s8, .expected = expected, .args = .{ d, t, idx } });
}

/// Table lookup and insert (4x 64-bit vectors)
pub inline fn vtbx4_u8(default_val: types.u8x8, t: types.u8x8x4, idx: types.u8x8) types.u8x8 {
    var res: types.u8x8 = undefined;
    inline for (0..8) |i| {
        const u_idx: u8 = @bitCast(idx[i]);
        res[i] = blk: {
            if (u_idx < 8) break :blk t[0][u_idx - 0];
            if (u_idx < 16) break :blk t[1][u_idx - 8];
            if (u_idx < 24) break :blk t[2][u_idx - 16];
            if (u_idx < 32) break :blk t[3][u_idx - 24];
            break :blk default_val[i];
        };
    }
    return res;
}

test vtbx4_u8 {
    const d = @as(types.u8x8, @splat(0x10));
    const t: types.u8x8x4 = .{ @as(types.u8x8, @splat(0x42)), @as(types.u8x8, @splat(0x42)), @as(types.u8x8, @splat(0x42)), @as(types.u8x8, @splat(0x42)) };
    const idx = @as(types.u8x8, @splat(0));
    const expected = @as(types.u8x8, @splat(0x42));
    try common.testIntrinsic(.{ .func = vtbx4_u8, .expected = expected, .args = .{ d, t, idx } });
}

/// Table lookup and insert (4x 64-bit vectors)
pub inline fn vtbx4_p8(default_val: types.p8x8, t: types.p8x8x4, idx: types.p8x8) types.p8x8 {
    var res: types.p8x8 = undefined;
    inline for (0..8) |i| {
        const u_idx: u8 = @bitCast(idx[i]);
        res[i] = blk: {
            if (u_idx < 8) break :blk t[0][u_idx - 0];
            if (u_idx < 16) break :blk t[1][u_idx - 8];
            if (u_idx < 24) break :blk t[2][u_idx - 16];
            if (u_idx < 32) break :blk t[3][u_idx - 24];
            break :blk default_val[i];
        };
    }
    return res;
}

test vtbx4_p8 {
    const d = @as(types.p8x8, @splat(0x10));
    const t: types.p8x8x4 = .{ @as(types.p8x8, @splat(0x42)), @as(types.p8x8, @splat(0x42)), @as(types.p8x8, @splat(0x42)), @as(types.p8x8, @splat(0x42)) };
    const idx = @as(types.p8x8, @splat(0));
    const expected = @as(types.p8x8, @splat(0x42));
    try common.testIntrinsic(.{ .func = vtbx4_p8, .expected = expected, .args = .{ d, t, idx } });
}

/// Table lookup and insert (1x 128-bit vectors, 64-bit result)
pub inline fn vqtbx1_s8(default_val: types.i8x8, t: types.i8x16, idx: types.i8x8) types.i8x8 {
    var res: types.i8x8 = undefined;
    inline for (0..8) |i| {
        const u_idx: u8 = @bitCast(idx[i]);
        res[i] = blk: {
            if (u_idx < 16) break :blk t[u_idx - 0];
            break :blk default_val[i];
        };
    }
    return res;
}

test vqtbx1_s8 {
    const d = @as(types.i8x8, @splat(0x10));
    const t: types.i8x16 = @as(types.i8x16, @splat(0x42));
    const idx = @as(types.i8x8, @splat(0));
    const expected = @as(types.i8x8, @splat(0x42));
    try common.testIntrinsic(.{ .func = vqtbx1_s8, .expected = expected, .args = .{ d, t, idx } });
}

/// Table lookup and insert (1x 128-bit vectors, 64-bit result)
pub inline fn vqtbx1_u8(default_val: types.u8x8, t: types.u8x16, idx: types.u8x8) types.u8x8 {
    var res: types.u8x8 = undefined;
    inline for (0..8) |i| {
        const u_idx: u8 = @bitCast(idx[i]);
        res[i] = blk: {
            if (u_idx < 16) break :blk t[u_idx - 0];
            break :blk default_val[i];
        };
    }
    return res;
}

test vqtbx1_u8 {
    const d = @as(types.u8x8, @splat(0x10));
    const t: types.u8x16 = @as(types.u8x16, @splat(0x42));
    const idx = @as(types.u8x8, @splat(0));
    const expected = @as(types.u8x8, @splat(0x42));
    try common.testIntrinsic(.{ .func = vqtbx1_u8, .expected = expected, .args = .{ d, t, idx } });
}

/// Table lookup and insert (1x 128-bit vectors, 64-bit result)
pub inline fn vqtbx1_p8(default_val: types.p8x8, t: types.p8x16, idx: types.p8x8) types.p8x8 {
    var res: types.p8x8 = undefined;
    inline for (0..8) |i| {
        const u_idx: u8 = @bitCast(idx[i]);
        res[i] = blk: {
            if (u_idx < 16) break :blk t[u_idx - 0];
            break :blk default_val[i];
        };
    }
    return res;
}

test vqtbx1_p8 {
    const d = @as(types.p8x8, @splat(0x10));
    const t: types.p8x16 = @as(types.p8x16, @splat(0x42));
    const idx = @as(types.p8x8, @splat(0));
    const expected = @as(types.p8x8, @splat(0x42));
    try common.testIntrinsic(.{ .func = vqtbx1_p8, .expected = expected, .args = .{ d, t, idx } });
}

/// Table lookup and insert (2x 128-bit vectors, 64-bit result)
pub inline fn vqtbx2_s8(default_val: types.i8x8, t: types.i8x16x2, idx: types.i8x8) types.i8x8 {
    var res: types.i8x8 = undefined;
    inline for (0..8) |i| {
        const u_idx: u8 = @bitCast(idx[i]);
        res[i] = blk: {
            if (u_idx < 16) break :blk t[0][u_idx - 0];
            if (u_idx < 32) break :blk t[1][u_idx - 16];
            break :blk default_val[i];
        };
    }
    return res;
}

test vqtbx2_s8 {
    const d = @as(types.i8x8, @splat(0x10));
    const t: types.i8x16x2 = .{ @as(types.i8x16, @splat(0x42)), @as(types.i8x16, @splat(0x42)) };
    const idx = @as(types.i8x8, @splat(0));
    const expected = @as(types.i8x8, @splat(0x42));
    try common.testIntrinsic(.{ .func = vqtbx2_s8, .expected = expected, .args = .{ d, t, idx } });
}

/// Table lookup and insert (2x 128-bit vectors, 64-bit result)
pub inline fn vqtbx2_u8(default_val: types.u8x8, t: types.u8x16x2, idx: types.u8x8) types.u8x8 {
    var res: types.u8x8 = undefined;
    inline for (0..8) |i| {
        const u_idx: u8 = @bitCast(idx[i]);
        res[i] = blk: {
            if (u_idx < 16) break :blk t[0][u_idx - 0];
            if (u_idx < 32) break :blk t[1][u_idx - 16];
            break :blk default_val[i];
        };
    }
    return res;
}

test vqtbx2_u8 {
    const d = @as(types.u8x8, @splat(0x10));
    const t: types.u8x16x2 = .{ @as(types.u8x16, @splat(0x42)), @as(types.u8x16, @splat(0x42)) };
    const idx = @as(types.u8x8, @splat(0));
    const expected = @as(types.u8x8, @splat(0x42));
    try common.testIntrinsic(.{ .func = vqtbx2_u8, .expected = expected, .args = .{ d, t, idx } });
}

/// Table lookup and insert (2x 128-bit vectors, 64-bit result)
pub inline fn vqtbx2_p8(default_val: types.p8x8, t: types.p8x16x2, idx: types.p8x8) types.p8x8 {
    var res: types.p8x8 = undefined;
    inline for (0..8) |i| {
        const u_idx: u8 = @bitCast(idx[i]);
        res[i] = blk: {
            if (u_idx < 16) break :blk t[0][u_idx - 0];
            if (u_idx < 32) break :blk t[1][u_idx - 16];
            break :blk default_val[i];
        };
    }
    return res;
}

test vqtbx2_p8 {
    const d = @as(types.p8x8, @splat(0x10));
    const t: types.p8x16x2 = .{ @as(types.p8x16, @splat(0x42)), @as(types.p8x16, @splat(0x42)) };
    const idx = @as(types.p8x8, @splat(0));
    const expected = @as(types.p8x8, @splat(0x42));
    try common.testIntrinsic(.{ .func = vqtbx2_p8, .expected = expected, .args = .{ d, t, idx } });
}

/// Table lookup and insert (3x 128-bit vectors, 64-bit result)
pub inline fn vqtbx3_s8(default_val: types.i8x8, t: types.i8x16x3, idx: types.i8x8) types.i8x8 {
    var res: types.i8x8 = undefined;
    inline for (0..8) |i| {
        const u_idx: u8 = @bitCast(idx[i]);
        res[i] = blk: {
            if (u_idx < 16) break :blk t[0][u_idx - 0];
            if (u_idx < 32) break :blk t[1][u_idx - 16];
            if (u_idx < 48) break :blk t[2][u_idx - 32];
            break :blk default_val[i];
        };
    }
    return res;
}

test vqtbx3_s8 {
    const d = @as(types.i8x8, @splat(0x10));
    const t: types.i8x16x3 = .{ @as(types.i8x16, @splat(0x42)), @as(types.i8x16, @splat(0x42)), @as(types.i8x16, @splat(0x42)) };
    const idx = @as(types.i8x8, @splat(0));
    const expected = @as(types.i8x8, @splat(0x42));
    try common.testIntrinsic(.{ .func = vqtbx3_s8, .expected = expected, .args = .{ d, t, idx } });
}

/// Table lookup and insert (3x 128-bit vectors, 64-bit result)
pub inline fn vqtbx3_u8(default_val: types.u8x8, t: types.u8x16x3, idx: types.u8x8) types.u8x8 {
    var res: types.u8x8 = undefined;
    inline for (0..8) |i| {
        const u_idx: u8 = @bitCast(idx[i]);
        res[i] = blk: {
            if (u_idx < 16) break :blk t[0][u_idx - 0];
            if (u_idx < 32) break :blk t[1][u_idx - 16];
            if (u_idx < 48) break :blk t[2][u_idx - 32];
            break :blk default_val[i];
        };
    }
    return res;
}

test vqtbx3_u8 {
    const d = @as(types.u8x8, @splat(0x10));
    const t: types.u8x16x3 = .{ @as(types.u8x16, @splat(0x42)), @as(types.u8x16, @splat(0x42)), @as(types.u8x16, @splat(0x42)) };
    const idx = @as(types.u8x8, @splat(0));
    const expected = @as(types.u8x8, @splat(0x42));
    try common.testIntrinsic(.{ .func = vqtbx3_u8, .expected = expected, .args = .{ d, t, idx } });
}

/// Table lookup and insert (3x 128-bit vectors, 64-bit result)
pub inline fn vqtbx3_p8(default_val: types.p8x8, t: types.p8x16x3, idx: types.p8x8) types.p8x8 {
    var res: types.p8x8 = undefined;
    inline for (0..8) |i| {
        const u_idx: u8 = @bitCast(idx[i]);
        res[i] = blk: {
            if (u_idx < 16) break :blk t[0][u_idx - 0];
            if (u_idx < 32) break :blk t[1][u_idx - 16];
            if (u_idx < 48) break :blk t[2][u_idx - 32];
            break :blk default_val[i];
        };
    }
    return res;
}

test vqtbx3_p8 {
    const d = @as(types.p8x8, @splat(0x10));
    const t: types.p8x16x3 = .{ @as(types.p8x16, @splat(0x42)), @as(types.p8x16, @splat(0x42)), @as(types.p8x16, @splat(0x42)) };
    const idx = @as(types.p8x8, @splat(0));
    const expected = @as(types.p8x8, @splat(0x42));
    try common.testIntrinsic(.{ .func = vqtbx3_p8, .expected = expected, .args = .{ d, t, idx } });
}

/// Table lookup and insert (4x 128-bit vectors, 64-bit result)
pub inline fn vqtbx4_s8(default_val: types.i8x8, t: types.i8x16x4, idx: types.i8x8) types.i8x8 {
    var res: types.i8x8 = undefined;
    inline for (0..8) |i| {
        const u_idx: u8 = @bitCast(idx[i]);
        res[i] = blk: {
            if (u_idx < 16) break :blk t[0][u_idx - 0];
            if (u_idx < 32) break :blk t[1][u_idx - 16];
            if (u_idx < 48) break :blk t[2][u_idx - 32];
            if (u_idx < 64) break :blk t[3][u_idx - 48];
            break :blk default_val[i];
        };
    }
    return res;
}

test vqtbx4_s8 {
    const d = @as(types.i8x8, @splat(0x10));
    const t: types.i8x16x4 = .{ @as(types.i8x16, @splat(0x42)), @as(types.i8x16, @splat(0x42)), @as(types.i8x16, @splat(0x42)), @as(types.i8x16, @splat(0x42)) };
    const idx = @as(types.i8x8, @splat(0));
    const expected = @as(types.i8x8, @splat(0x42));
    try common.testIntrinsic(.{ .func = vqtbx4_s8, .expected = expected, .args = .{ d, t, idx } });
}

/// Table lookup and insert (4x 128-bit vectors, 64-bit result)
pub inline fn vqtbx4_u8(default_val: types.u8x8, t: types.u8x16x4, idx: types.u8x8) types.u8x8 {
    var res: types.u8x8 = undefined;
    inline for (0..8) |i| {
        const u_idx: u8 = @bitCast(idx[i]);
        res[i] = blk: {
            if (u_idx < 16) break :blk t[0][u_idx - 0];
            if (u_idx < 32) break :blk t[1][u_idx - 16];
            if (u_idx < 48) break :blk t[2][u_idx - 32];
            if (u_idx < 64) break :blk t[3][u_idx - 48];
            break :blk default_val[i];
        };
    }
    return res;
}

test vqtbx4_u8 {
    const d = @as(types.u8x8, @splat(0x10));
    const t: types.u8x16x4 = .{ @as(types.u8x16, @splat(0x42)), @as(types.u8x16, @splat(0x42)), @as(types.u8x16, @splat(0x42)), @as(types.u8x16, @splat(0x42)) };
    const idx = @as(types.u8x8, @splat(0));
    const expected = @as(types.u8x8, @splat(0x42));
    try common.testIntrinsic(.{ .func = vqtbx4_u8, .expected = expected, .args = .{ d, t, idx } });
}

/// Table lookup and insert (4x 128-bit vectors, 64-bit result)
pub inline fn vqtbx4_p8(default_val: types.p8x8, t: types.p8x16x4, idx: types.p8x8) types.p8x8 {
    var res: types.p8x8 = undefined;
    inline for (0..8) |i| {
        const u_idx: u8 = @bitCast(idx[i]);
        res[i] = blk: {
            if (u_idx < 16) break :blk t[0][u_idx - 0];
            if (u_idx < 32) break :blk t[1][u_idx - 16];
            if (u_idx < 48) break :blk t[2][u_idx - 32];
            if (u_idx < 64) break :blk t[3][u_idx - 48];
            break :blk default_val[i];
        };
    }
    return res;
}

test vqtbx4_p8 {
    const d = @as(types.p8x8, @splat(0x10));
    const t: types.p8x16x4 = .{ @as(types.p8x16, @splat(0x42)), @as(types.p8x16, @splat(0x42)), @as(types.p8x16, @splat(0x42)), @as(types.p8x16, @splat(0x42)) };
    const idx = @as(types.p8x8, @splat(0));
    const expected = @as(types.p8x8, @splat(0x42));
    try common.testIntrinsic(.{ .func = vqtbx4_p8, .expected = expected, .args = .{ d, t, idx } });
}

/// Table lookup and insert (1x 128-bit vectors, 128-bit result)
pub inline fn vqtbx1q_s8(default_val: types.i8x16, t: types.i8x16, idx: types.u8x16) types.i8x16 {
    var res: types.i8x16 = undefined;
    inline for (0..16) |i| {
        const u_idx = idx[i];
        res[i] = blk: {
            if (u_idx < 16) break :blk t[u_idx - 0];
            break :blk default_val[i];
        };
    }
    return res;
}

test vqtbx1q_s8 {
    const d = @as(types.i8x16, @splat(0x10));
    const t: types.i8x16 = @as(types.i8x16, @splat(0x42));
    const idx = @as(types.u8x16, @splat(0));
    const expected = @as(types.i8x16, @splat(0x42));
    try common.testIntrinsic(.{ .func = vqtbx1q_s8, .expected = expected, .args = .{ d, t, idx } });
}

/// Table lookup and insert (1x 128-bit vectors, 128-bit result)
pub inline fn vqtbx1q_u8(default_val: types.u8x16, t: types.u8x16, idx: types.u8x16) types.u8x16 {
    var res: types.u8x16 = undefined;
    inline for (0..16) |i| {
        const u_idx = idx[i];
        res[i] = blk: {
            if (u_idx < 16) break :blk t[u_idx - 0];
            break :blk default_val[i];
        };
    }
    return res;
}

test vqtbx1q_u8 {
    const d = @as(types.u8x16, @splat(0x10));
    const t: types.u8x16 = @as(types.u8x16, @splat(0x42));
    const idx = @as(types.u8x16, @splat(0));
    const expected = @as(types.u8x16, @splat(0x42));
    try common.testIntrinsic(.{ .func = vqtbx1q_u8, .expected = expected, .args = .{ d, t, idx } });
}

/// Table lookup and insert (1x 128-bit vectors, 128-bit result)
pub inline fn vqtbx1q_p8(default_val: types.p8x16, t: types.p8x16, idx: types.u8x16) types.p8x16 {
    var res: types.p8x16 = undefined;
    inline for (0..16) |i| {
        const u_idx = idx[i];
        res[i] = blk: {
            if (u_idx < 16) break :blk t[u_idx - 0];
            break :blk default_val[i];
        };
    }
    return res;
}

test vqtbx1q_p8 {
    const d = @as(types.p8x16, @splat(0x10));
    const t: types.p8x16 = @as(types.p8x16, @splat(0x42));
    const idx = @as(types.u8x16, @splat(0));
    const expected = @as(types.p8x16, @splat(0x42));
    try common.testIntrinsic(.{ .func = vqtbx1q_p8, .expected = expected, .args = .{ d, t, idx } });
}

/// Table lookup and insert (2x 128-bit vectors, 128-bit result)
pub inline fn vqtbx2q_s8(default_val: types.i8x16, t: types.i8x16x2, idx: types.u8x16) types.i8x16 {
    var res: types.i8x16 = undefined;
    inline for (0..16) |i| {
        const u_idx = idx[i];
        res[i] = blk: {
            if (u_idx < 16) break :blk t[0][u_idx - 0];
            if (u_idx < 32) break :blk t[1][u_idx - 16];
            break :blk default_val[i];
        };
    }
    return res;
}

test vqtbx2q_s8 {
    const d = @as(types.i8x16, @splat(0x10));
    const t: types.i8x16x2 = .{ @as(types.i8x16, @splat(0x42)), @as(types.i8x16, @splat(0x42)) };
    const idx = @as(types.u8x16, @splat(0));
    const expected = @as(types.i8x16, @splat(0x42));
    try common.testIntrinsic(.{ .func = vqtbx2q_s8, .expected = expected, .args = .{ d, t, idx } });
}

/// Table lookup and insert (2x 128-bit vectors, 128-bit result)
pub inline fn vqtbx2q_u8(default_val: types.u8x16, t: types.u8x16x2, idx: types.u8x16) types.u8x16 {
    var res: types.u8x16 = undefined;
    inline for (0..16) |i| {
        const u_idx = idx[i];
        res[i] = blk: {
            if (u_idx < 16) break :blk t[0][u_idx - 0];
            if (u_idx < 32) break :blk t[1][u_idx - 16];
            break :blk default_val[i];
        };
    }
    return res;
}

test vqtbx2q_u8 {
    const d = @as(types.u8x16, @splat(0x10));
    const t: types.u8x16x2 = .{ @as(types.u8x16, @splat(0x42)), @as(types.u8x16, @splat(0x42)) };
    const idx = @as(types.u8x16, @splat(0));
    const expected = @as(types.u8x16, @splat(0x42));
    try common.testIntrinsic(.{ .func = vqtbx2q_u8, .expected = expected, .args = .{ d, t, idx } });
}

/// Table lookup and insert (2x 128-bit vectors, 128-bit result)
pub inline fn vqtbx2q_p8(default_val: types.p8x16, t: types.p8x16x2, idx: types.u8x16) types.p8x16 {
    var res: types.p8x16 = undefined;
    inline for (0..16) |i| {
        const u_idx = idx[i];
        res[i] = blk: {
            if (u_idx < 16) break :blk t[0][u_idx - 0];
            if (u_idx < 32) break :blk t[1][u_idx - 16];
            break :blk default_val[i];
        };
    }
    return res;
}

test vqtbx2q_p8 {
    const d = @as(types.p8x16, @splat(0x10));
    const t: types.p8x16x2 = .{ @as(types.p8x16, @splat(0x42)), @as(types.p8x16, @splat(0x42)) };
    const idx = @as(types.u8x16, @splat(0));
    const expected = @as(types.p8x16, @splat(0x42));
    try common.testIntrinsic(.{ .func = vqtbx2q_p8, .expected = expected, .args = .{ d, t, idx } });
}

/// Table lookup and insert (3x 128-bit vectors, 128-bit result)
pub inline fn vqtbx3q_s8(default_val: types.i8x16, t: types.i8x16x3, idx: types.u8x16) types.i8x16 {
    var res: types.i8x16 = undefined;
    inline for (0..16) |i| {
        const u_idx = idx[i];
        res[i] = blk: {
            if (u_idx < 16) break :blk t[0][u_idx - 0];
            if (u_idx < 32) break :blk t[1][u_idx - 16];
            if (u_idx < 48) break :blk t[2][u_idx - 32];
            break :blk default_val[i];
        };
    }
    return res;
}

test vqtbx3q_s8 {
    const d = @as(types.i8x16, @splat(0x10));
    const t: types.i8x16x3 = .{ @as(types.i8x16, @splat(0x42)), @as(types.i8x16, @splat(0x42)), @as(types.i8x16, @splat(0x42)) };
    const idx = @as(types.u8x16, @splat(0));
    const expected = @as(types.i8x16, @splat(0x42));
    try common.testIntrinsic(.{ .func = vqtbx3q_s8, .expected = expected, .args = .{ d, t, idx } });
}

/// Table lookup and insert (3x 128-bit vectors, 128-bit result)
pub inline fn vqtbx3q_u8(default_val: types.u8x16, t: types.u8x16x3, idx: types.u8x16) types.u8x16 {
    var res: types.u8x16 = undefined;
    inline for (0..16) |i| {
        const u_idx = idx[i];
        res[i] = blk: {
            if (u_idx < 16) break :blk t[0][u_idx - 0];
            if (u_idx < 32) break :blk t[1][u_idx - 16];
            if (u_idx < 48) break :blk t[2][u_idx - 32];
            break :blk default_val[i];
        };
    }
    return res;
}

test vqtbx3q_u8 {
    const d = @as(types.u8x16, @splat(0x10));
    const t: types.u8x16x3 = .{ @as(types.u8x16, @splat(0x42)), @as(types.u8x16, @splat(0x42)), @as(types.u8x16, @splat(0x42)) };
    const idx = @as(types.u8x16, @splat(0));
    const expected = @as(types.u8x16, @splat(0x42));
    try common.testIntrinsic(.{ .func = vqtbx3q_u8, .expected = expected, .args = .{ d, t, idx } });
}

/// Table lookup and insert (3x 128-bit vectors, 128-bit result)
pub inline fn vqtbx3q_p8(default_val: types.p8x16, t: types.p8x16x3, idx: types.u8x16) types.p8x16 {
    var res: types.p8x16 = undefined;
    inline for (0..16) |i| {
        const u_idx = idx[i];
        res[i] = blk: {
            if (u_idx < 16) break :blk t[0][u_idx - 0];
            if (u_idx < 32) break :blk t[1][u_idx - 16];
            if (u_idx < 48) break :blk t[2][u_idx - 32];
            break :blk default_val[i];
        };
    }
    return res;
}

test vqtbx3q_p8 {
    const d = @as(types.p8x16, @splat(0x10));
    const t: types.p8x16x3 = .{ @as(types.p8x16, @splat(0x42)), @as(types.p8x16, @splat(0x42)), @as(types.p8x16, @splat(0x42)) };
    const idx = @as(types.u8x16, @splat(0));
    const expected = @as(types.p8x16, @splat(0x42));
    try common.testIntrinsic(.{ .func = vqtbx3q_p8, .expected = expected, .args = .{ d, t, idx } });
}

/// Table lookup and insert (4x 128-bit vectors, 128-bit result)
pub inline fn vqtbx4q_s8(default_val: types.i8x16, t: types.i8x16x4, idx: types.u8x16) types.i8x16 {
    var res: types.i8x16 = undefined;
    inline for (0..16) |i| {
        const u_idx = idx[i];
        res[i] = blk: {
            if (u_idx < 16) break :blk t[0][u_idx - 0];
            if (u_idx < 32) break :blk t[1][u_idx - 16];
            if (u_idx < 48) break :blk t[2][u_idx - 32];
            if (u_idx < 64) break :blk t[3][u_idx - 48];
            break :blk default_val[i];
        };
    }
    return res;
}

test vqtbx4q_s8 {
    const d = @as(types.i8x16, @splat(0x10));
    const t: types.i8x16x4 = .{ @as(types.i8x16, @splat(0x42)), @as(types.i8x16, @splat(0x42)), @as(types.i8x16, @splat(0x42)), @as(types.i8x16, @splat(0x42)) };
    const idx = @as(types.u8x16, @splat(0));
    const expected = @as(types.i8x16, @splat(0x42));
    try common.testIntrinsic(.{ .func = vqtbx4q_s8, .expected = expected, .args = .{ d, t, idx } });
}

/// Table lookup and insert (4x 128-bit vectors, 128-bit result)
pub inline fn vqtbx4q_u8(default_val: types.u8x16, t: types.u8x16x4, idx: types.u8x16) types.u8x16 {
    var res: types.u8x16 = undefined;
    inline for (0..16) |i| {
        const u_idx = idx[i];
        res[i] = blk: {
            if (u_idx < 16) break :blk t[0][u_idx - 0];
            if (u_idx < 32) break :blk t[1][u_idx - 16];
            if (u_idx < 48) break :blk t[2][u_idx - 32];
            if (u_idx < 64) break :blk t[3][u_idx - 48];
            break :blk default_val[i];
        };
    }
    return res;
}

test vqtbx4q_u8 {
    const d = @as(types.u8x16, @splat(0x10));
    const t: types.u8x16x4 = .{ @as(types.u8x16, @splat(0x42)), @as(types.u8x16, @splat(0x42)), @as(types.u8x16, @splat(0x42)), @as(types.u8x16, @splat(0x42)) };
    const idx = @as(types.u8x16, @splat(0));
    const expected = @as(types.u8x16, @splat(0x42));
    try common.testIntrinsic(.{ .func = vqtbx4q_u8, .expected = expected, .args = .{ d, t, idx } });
}

/// Table lookup and insert (4x 128-bit vectors, 128-bit result)
pub inline fn vqtbx4q_p8(default_val: types.p8x16, t: types.p8x16x4, idx: types.u8x16) types.p8x16 {
    var res: types.p8x16 = undefined;
    inline for (0..16) |i| {
        const u_idx = idx[i];
        res[i] = blk: {
            if (u_idx < 16) break :blk t[0][u_idx - 0];
            if (u_idx < 32) break :blk t[1][u_idx - 16];
            if (u_idx < 48) break :blk t[2][u_idx - 32];
            if (u_idx < 64) break :blk t[3][u_idx - 48];
            break :blk default_val[i];
        };
    }
    return res;
}

test vqtbx4q_p8 {
    const d = @as(types.p8x16, @splat(0x10));
    const t: types.p8x16x4 = .{ @as(types.p8x16, @splat(0x42)), @as(types.p8x16, @splat(0x42)), @as(types.p8x16, @splat(0x42)), @as(types.p8x16, @splat(0x42)) };
    const idx = @as(types.u8x16, @splat(0));
    const expected = @as(types.p8x16, @splat(0x42));
    try common.testIntrinsic(.{ .func = vqtbx4q_p8, .expected = expected, .args = .{ d, t, idx } });
}

/// Reverse 64-bit lanes
pub inline fn vrev64_p8(a: types.p8x8) types.p8x8 {
    return .{ a[7], a[6], a[5], a[4], a[3], a[2], a[1], a[0] };
}

test vrev64_p8 {
    const a = types.p8x8{ 1, 2, 3, 4, 5, 6, 7, 8 };
    const expected = types.p8x8{ 8, 7, 6, 5, 4, 3, 2, 1 };
    try common.testIntrinsic(.{ .func = vrev64_p8, .expected = expected, .args = .{a} });
}
/// Permute vector elements
pub inline fn vzip1_p8(a: types.p8x8, b: types.p8x8) types.p8x8 {
    return .{ a[0], b[0], a[1], b[1], a[2], b[2], a[3], b[3] };
}

test vzip1_p8 {
    const a = types.p8x8{ 1, 2, 3, 4, 5, 6, 7, 8 };
    const b = types.p8x8{ 101, 102, 103, 104, 105, 106, 107, 108 };
    const expected = types.p8x8{ 1, 101, 2, 102, 3, 103, 4, 104 };
    try common.testIntrinsic(.{ .func = vzip1_p8, .expected = expected, .args = .{ a, b } });
}

/// Permute vector elements
pub inline fn vzip1_p16(a: types.p16x4, b: types.p16x4) types.p16x4 {
    return .{ a[0], b[0], a[1], b[1] };
}

test vzip1_p16 {
    const a = types.p16x4{ 1, 2, 3, 4 };
    const b = types.p16x4{ 101, 102, 103, 104 };
    const expected = types.p16x4{ 1, 101, 2, 102 };
    try common.testIntrinsic(.{ .func = vzip1_p16, .expected = expected, .args = .{ a, b } });
}

/// Permute vector elements
pub inline fn vzip1_f16(a: types.f16x4, b: types.f16x4) types.f16x4 {
    return .{ a[0], b[0], a[1], b[1] };
}

test vzip1_f16 {
    const a = types.f16x4{ 1.0, 2.0, 3.0, 4.0 };
    const b = types.f16x4{ 101.0, 102.0, 103.0, 104.0 };
    const expected = types.f16x4{ 1.0, 101.0, 2.0, 102.0 };
    try common.testIntrinsic(.{ .func = vzip1_f16, .expected = expected, .args = .{ a, b } });
}

/// Permute vector elements
pub inline fn vzip1q_f16(a: types.f16x8, b: types.f16x8) types.f16x8 {
    return .{ a[0], b[0], a[1], b[1], a[2], b[2], a[3], b[3] };
}

test vzip1q_f16 {
    const a = types.f16x8{ 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0 };
    const b = types.f16x8{ 101.0, 102.0, 103.0, 104.0, 105.0, 106.0, 107.0, 108.0 };
    const expected = types.f16x8{ 1.0, 101.0, 2.0, 102.0, 3.0, 103.0, 4.0, 104.0 };
    try common.testIntrinsic(.{ .func = vzip1q_f16, .expected = expected, .args = .{ a, b } });
}

/// Permute vector elements
pub inline fn vzip2_p8(a: types.p8x8, b: types.p8x8) types.p8x8 {
    return .{ a[4], b[4], a[5], b[5], a[6], b[6], a[7], b[7] };
}

test vzip2_p8 {
    const a = types.p8x8{ 1, 2, 3, 4, 5, 6, 7, 8 };
    const b = types.p8x8{ 101, 102, 103, 104, 105, 106, 107, 108 };
    const expected = types.p8x8{ 5, 105, 6, 106, 7, 107, 8, 108 };
    try common.testIntrinsic(.{ .func = vzip2_p8, .expected = expected, .args = .{ a, b } });
}

/// Permute vector elements
pub inline fn vzip2_p16(a: types.p16x4, b: types.p16x4) types.p16x4 {
    return .{ a[2], b[2], a[3], b[3] };
}

test vzip2_p16 {
    const a = types.p16x4{ 1, 2, 3, 4 };
    const b = types.p16x4{ 101, 102, 103, 104 };
    const expected = types.p16x4{ 3, 103, 4, 104 };
    try common.testIntrinsic(.{ .func = vzip2_p16, .expected = expected, .args = .{ a, b } });
}

/// Permute vector elements
pub inline fn vzip2_f16(a: types.f16x4, b: types.f16x4) types.f16x4 {
    return .{ a[2], b[2], a[3], b[3] };
}

test vzip2_f16 {
    const a = types.f16x4{ 1.0, 2.0, 3.0, 4.0 };
    const b = types.f16x4{ 101.0, 102.0, 103.0, 104.0 };
    const expected = types.f16x4{ 3.0, 103.0, 4.0, 104.0 };
    try common.testIntrinsic(.{ .func = vzip2_f16, .expected = expected, .args = .{ a, b } });
}

/// Permute vector elements
pub inline fn vzip2q_f16(a: types.f16x8, b: types.f16x8) types.f16x8 {
    return .{ a[4], b[4], a[5], b[5], a[6], b[6], a[7], b[7] };
}

test vzip2q_f16 {
    const a = types.f16x8{ 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0 };
    const b = types.f16x8{ 101.0, 102.0, 103.0, 104.0, 105.0, 106.0, 107.0, 108.0 };
    const expected = types.f16x8{ 5.0, 105.0, 6.0, 106.0, 7.0, 107.0, 8.0, 108.0 };
    try common.testIntrinsic(.{ .func = vzip2q_f16, .expected = expected, .args = .{ a, b } });
}

/// Permute vector elements
pub inline fn vuzp1_s8(a: types.i8x8, b: types.i8x8) types.i8x8 {
    return .{ a[0], a[2], a[4], a[6], b[0], b[2], b[4], b[6] };
}

test vuzp1_s8 {
    const a = types.i8x8{ 1, 2, 3, 4, 5, 6, 7, 8 };
    const b = types.i8x8{ 101, 102, 103, 104, 105, 106, 107, 108 };
    const expected = types.i8x8{ 1, 3, 5, 7, 101, 103, 105, 107 };
    try common.testIntrinsic(.{ .func = vuzp1_s8, .expected = expected, .args = .{ a, b } });
}

/// Permute vector elements
pub inline fn vuzp1_s16(a: types.i16x4, b: types.i16x4) types.i16x4 {
    return .{ a[0], a[2], b[0], b[2] };
}

test vuzp1_s16 {
    const a = types.i16x4{ 1, 2, 3, 4 };
    const b = types.i16x4{ 101, 102, 103, 104 };
    const expected = types.i16x4{ 1, 3, 101, 103 };
    try common.testIntrinsic(.{ .func = vuzp1_s16, .expected = expected, .args = .{ a, b } });
}

/// Permute vector elements
pub inline fn vuzp1_s32(a: types.i32x2, b: types.i32x2) types.i32x2 {
    return .{ a[0], b[0] };
}

test vuzp1_s32 {
    const a = types.i32x2{ 1, 2 };
    const b = types.i32x2{ 101, 102 };
    const expected = types.i32x2{ 1, 101 };
    try common.testIntrinsic(.{ .func = vuzp1_s32, .expected = expected, .args = .{ a, b } });
}

/// Permute vector elements
pub inline fn vuzp1_u8(a: types.u8x8, b: types.u8x8) types.u8x8 {
    return .{ a[0], a[2], a[4], a[6], b[0], b[2], b[4], b[6] };
}

test vuzp1_u8 {
    const a = types.u8x8{ 1, 2, 3, 4, 5, 6, 7, 8 };
    const b = types.u8x8{ 101, 102, 103, 104, 105, 106, 107, 108 };
    const expected = types.u8x8{ 1, 3, 5, 7, 101, 103, 105, 107 };
    try common.testIntrinsic(.{ .func = vuzp1_u8, .expected = expected, .args = .{ a, b } });
}

/// Permute vector elements
pub inline fn vuzp1_u16(a: types.u16x4, b: types.u16x4) types.u16x4 {
    return .{ a[0], a[2], b[0], b[2] };
}

test vuzp1_u16 {
    const a = types.u16x4{ 1, 2, 3, 4 };
    const b = types.u16x4{ 101, 102, 103, 104 };
    const expected = types.u16x4{ 1, 3, 101, 103 };
    try common.testIntrinsic(.{ .func = vuzp1_u16, .expected = expected, .args = .{ a, b } });
}

/// Permute vector elements
pub inline fn vuzp1_u32(a: types.u32x2, b: types.u32x2) types.u32x2 {
    return .{ a[0], b[0] };
}

test vuzp1_u32 {
    const a = types.u32x2{ 1, 2 };
    const b = types.u32x2{ 101, 102 };
    const expected = types.u32x2{ 1, 101 };
    try common.testIntrinsic(.{ .func = vuzp1_u32, .expected = expected, .args = .{ a, b } });
}

/// Permute vector elements
pub inline fn vuzp1_p8(a: types.p8x8, b: types.p8x8) types.p8x8 {
    return .{ a[0], a[2], a[4], a[6], b[0], b[2], b[4], b[6] };
}

test vuzp1_p8 {
    const a = types.p8x8{ 1, 2, 3, 4, 5, 6, 7, 8 };
    const b = types.p8x8{ 101, 102, 103, 104, 105, 106, 107, 108 };
    const expected = types.p8x8{ 1, 3, 5, 7, 101, 103, 105, 107 };
    try common.testIntrinsic(.{ .func = vuzp1_p8, .expected = expected, .args = .{ a, b } });
}

/// Permute vector elements
pub inline fn vuzp1_p16(a: types.p16x4, b: types.p16x4) types.p16x4 {
    return .{ a[0], a[2], b[0], b[2] };
}

test vuzp1_p16 {
    const a = types.p16x4{ 1, 2, 3, 4 };
    const b = types.p16x4{ 101, 102, 103, 104 };
    const expected = types.p16x4{ 1, 3, 101, 103 };
    try common.testIntrinsic(.{ .func = vuzp1_p16, .expected = expected, .args = .{ a, b } });
}

/// Permute vector elements
pub inline fn vuzp1_f16(a: types.f16x4, b: types.f16x4) types.f16x4 {
    return .{ a[0], a[2], b[0], b[2] };
}

test vuzp1_f16 {
    const a = types.f16x4{ 1.0, 2.0, 3.0, 4.0 };
    const b = types.f16x4{ 101.0, 102.0, 103.0, 104.0 };
    const expected = types.f16x4{ 1.0, 3.0, 101.0, 103.0 };
    try common.testIntrinsic(.{ .func = vuzp1_f16, .expected = expected, .args = .{ a, b } });
}

/// Permute vector elements
pub inline fn vuzp1_f32(a: types.f32x2, b: types.f32x2) types.f32x2 {
    return .{ a[0], b[0] };
}

test vuzp1_f32 {
    const a = types.f32x2{ 1.0, 2.0 };
    const b = types.f32x2{ 101.0, 102.0 };
    const expected = types.f32x2{ 1.0, 101.0 };
    try common.testIntrinsic(.{ .func = vuzp1_f32, .expected = expected, .args = .{ a, b } });
}

/// Permute vector elements
pub inline fn vuzp1q_s8(a: types.i8x16, b: types.i8x16) types.i8x16 {
    return .{ a[0], a[2], a[4], a[6], a[8], a[10], a[12], a[14], b[0], b[2], b[4], b[6], b[8], b[10], b[12], b[14] };
}

test vuzp1q_s8 {
    const a = types.i8x16{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 };
    const b = types.i8x16{ 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116 };
    const expected = types.i8x16{ 1, 3, 5, 7, 9, 11, 13, 15, 101, 103, 105, 107, 109, 111, 113, 115 };
    try common.testIntrinsic(.{ .func = vuzp1q_s8, .expected = expected, .args = .{ a, b } });
}

/// Permute vector elements
pub inline fn vuzp1q_s16(a: types.i16x8, b: types.i16x8) types.i16x8 {
    return .{ a[0], a[2], a[4], a[6], b[0], b[2], b[4], b[6] };
}

test vuzp1q_s16 {
    const a = types.i16x8{ 1, 2, 3, 4, 5, 6, 7, 8 };
    const b = types.i16x8{ 101, 102, 103, 104, 105, 106, 107, 108 };
    const expected = types.i16x8{ 1, 3, 5, 7, 101, 103, 105, 107 };
    try common.testIntrinsic(.{ .func = vuzp1q_s16, .expected = expected, .args = .{ a, b } });
}

/// Permute vector elements
pub inline fn vuzp1q_s32(a: types.i32x4, b: types.i32x4) types.i32x4 {
    return .{ a[0], a[2], b[0], b[2] };
}

test vuzp1q_s32 {
    const a = types.i32x4{ 1, 2, 3, 4 };
    const b = types.i32x4{ 101, 102, 103, 104 };
    const expected = types.i32x4{ 1, 3, 101, 103 };
    try common.testIntrinsic(.{ .func = vuzp1q_s32, .expected = expected, .args = .{ a, b } });
}

/// Permute vector elements
pub inline fn vuzp1q_s64(a: types.i64x2, b: types.i64x2) types.i64x2 {
    return .{ a[0], b[0] };
}

test vuzp1q_s64 {
    const a = types.i64x2{ 1, 2 };
    const b = types.i64x2{ 101, 102 };
    const expected = types.i64x2{ 1, 101 };
    try common.testIntrinsic(.{ .func = vuzp1q_s64, .expected = expected, .args = .{ a, b } });
}

/// Permute vector elements
pub inline fn vuzp1q_u8(a: types.u8x16, b: types.u8x16) types.u8x16 {
    return .{ a[0], a[2], a[4], a[6], a[8], a[10], a[12], a[14], b[0], b[2], b[4], b[6], b[8], b[10], b[12], b[14] };
}

test vuzp1q_u8 {
    const a = types.u8x16{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 };
    const b = types.u8x16{ 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116 };
    const expected = types.u8x16{ 1, 3, 5, 7, 9, 11, 13, 15, 101, 103, 105, 107, 109, 111, 113, 115 };
    try common.testIntrinsic(.{ .func = vuzp1q_u8, .expected = expected, .args = .{ a, b } });
}

/// Permute vector elements
pub inline fn vuzp1q_u16(a: types.u16x8, b: types.u16x8) types.u16x8 {
    return .{ a[0], a[2], a[4], a[6], b[0], b[2], b[4], b[6] };
}

test vuzp1q_u16 {
    const a = types.u16x8{ 1, 2, 3, 4, 5, 6, 7, 8 };
    const b = types.u16x8{ 101, 102, 103, 104, 105, 106, 107, 108 };
    const expected = types.u16x8{ 1, 3, 5, 7, 101, 103, 105, 107 };
    try common.testIntrinsic(.{ .func = vuzp1q_u16, .expected = expected, .args = .{ a, b } });
}

/// Permute vector elements
pub inline fn vuzp1q_u32(a: types.u32x4, b: types.u32x4) types.u32x4 {
    return .{ a[0], a[2], b[0], b[2] };
}

test vuzp1q_u32 {
    const a = types.u32x4{ 1, 2, 3, 4 };
    const b = types.u32x4{ 101, 102, 103, 104 };
    const expected = types.u32x4{ 1, 3, 101, 103 };
    try common.testIntrinsic(.{ .func = vuzp1q_u32, .expected = expected, .args = .{ a, b } });
}

/// Permute vector elements
pub inline fn vuzp1q_u64(a: types.u64x2, b: types.u64x2) types.u64x2 {
    return .{ a[0], b[0] };
}

test vuzp1q_u64 {
    const a = types.u64x2{ 1, 2 };
    const b = types.u64x2{ 101, 102 };
    const expected = types.u64x2{ 1, 101 };
    try common.testIntrinsic(.{ .func = vuzp1q_u64, .expected = expected, .args = .{ a, b } });
}

/// Permute vector elements
pub inline fn vuzp1q_p8(a: types.p8x16, b: types.p8x16) types.p8x16 {
    return .{ a[0], a[2], a[4], a[6], a[8], a[10], a[12], a[14], b[0], b[2], b[4], b[6], b[8], b[10], b[12], b[14] };
}

test vuzp1q_p8 {
    const a = types.p8x16{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 };
    const b = types.p8x16{ 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116 };
    const expected = types.p8x16{ 1, 3, 5, 7, 9, 11, 13, 15, 101, 103, 105, 107, 109, 111, 113, 115 };
    try common.testIntrinsic(.{ .func = vuzp1q_p8, .expected = expected, .args = .{ a, b } });
}

/// Permute vector elements
pub inline fn vuzp1q_p16(a: types.p16x8, b: types.p16x8) types.p16x8 {
    return .{ a[0], a[2], a[4], a[6], b[0], b[2], b[4], b[6] };
}

test vuzp1q_p16 {
    const a = types.p16x8{ 1, 2, 3, 4, 5, 6, 7, 8 };
    const b = types.p16x8{ 101, 102, 103, 104, 105, 106, 107, 108 };
    const expected = types.p16x8{ 1, 3, 5, 7, 101, 103, 105, 107 };
    try common.testIntrinsic(.{ .func = vuzp1q_p16, .expected = expected, .args = .{ a, b } });
}

/// Permute vector elements
pub inline fn vuzp1q_p64(a: types.p64x2, b: types.p64x2) types.p64x2 {
    return .{ a[0], b[0] };
}

test vuzp1q_p64 {
    const a = types.p64x2{ 1, 2 };
    const b = types.p64x2{ 101, 102 };
    const expected = types.p64x2{ 1, 101 };
    try common.testIntrinsic(.{ .func = vuzp1q_p64, .expected = expected, .args = .{ a, b } });
}

/// Permute vector elements
pub inline fn vuzp1q_f16(a: types.f16x8, b: types.f16x8) types.f16x8 {
    return .{ a[0], a[2], a[4], a[6], b[0], b[2], b[4], b[6] };
}

test vuzp1q_f16 {
    const a = types.f16x8{ 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0 };
    const b = types.f16x8{ 101.0, 102.0, 103.0, 104.0, 105.0, 106.0, 107.0, 108.0 };
    const expected = types.f16x8{ 1.0, 3.0, 5.0, 7.0, 101.0, 103.0, 105.0, 107.0 };
    try common.testIntrinsic(.{ .func = vuzp1q_f16, .expected = expected, .args = .{ a, b } });
}

/// Permute vector elements
pub inline fn vuzp1q_f32(a: types.f32x4, b: types.f32x4) types.f32x4 {
    return .{ a[0], a[2], b[0], b[2] };
}

test vuzp1q_f32 {
    const a = types.f32x4{ 1.0, 2.0, 3.0, 4.0 };
    const b = types.f32x4{ 101.0, 102.0, 103.0, 104.0 };
    const expected = types.f32x4{ 1.0, 3.0, 101.0, 103.0 };
    try common.testIntrinsic(.{ .func = vuzp1q_f32, .expected = expected, .args = .{ a, b } });
}

/// Permute vector elements
pub inline fn vuzp1q_f64(a: types.f64x2, b: types.f64x2) types.f64x2 {
    return .{ a[0], b[0] };
}

test vuzp1q_f64 {
    const a = types.f64x2{ 1.0, 2.0 };
    const b = types.f64x2{ 101.0, 102.0 };
    const expected = types.f64x2{ 1.0, 101.0 };
    try common.testIntrinsic(.{ .func = vuzp1q_f64, .expected = expected, .args = .{ a, b } });
}

/// Permute vector elements
pub inline fn vuzp2_s8(a: types.i8x8, b: types.i8x8) types.i8x8 {
    return .{ a[1], a[3], a[5], a[7], b[1], b[3], b[5], b[7] };
}

test vuzp2_s8 {
    const a = types.i8x8{ 1, 2, 3, 4, 5, 6, 7, 8 };
    const b = types.i8x8{ 101, 102, 103, 104, 105, 106, 107, 108 };
    const expected = types.i8x8{ 2, 4, 6, 8, 102, 104, 106, 108 };
    try common.testIntrinsic(.{ .func = vuzp2_s8, .expected = expected, .args = .{ a, b } });
}

/// Permute vector elements
pub inline fn vuzp2_s16(a: types.i16x4, b: types.i16x4) types.i16x4 {
    return .{ a[1], a[3], b[1], b[3] };
}

test vuzp2_s16 {
    const a = types.i16x4{ 1, 2, 3, 4 };
    const b = types.i16x4{ 101, 102, 103, 104 };
    const expected = types.i16x4{ 2, 4, 102, 104 };
    try common.testIntrinsic(.{ .func = vuzp2_s16, .expected = expected, .args = .{ a, b } });
}

/// Permute vector elements
pub inline fn vuzp2_s32(a: types.i32x2, b: types.i32x2) types.i32x2 {
    return .{ a[1], b[1] };
}

test vuzp2_s32 {
    const a = types.i32x2{ 1, 2 };
    const b = types.i32x2{ 101, 102 };
    const expected = types.i32x2{ 2, 102 };
    try common.testIntrinsic(.{ .func = vuzp2_s32, .expected = expected, .args = .{ a, b } });
}

/// Permute vector elements
pub inline fn vuzp2_u8(a: types.u8x8, b: types.u8x8) types.u8x8 {
    return .{ a[1], a[3], a[5], a[7], b[1], b[3], b[5], b[7] };
}

test vuzp2_u8 {
    const a = types.u8x8{ 1, 2, 3, 4, 5, 6, 7, 8 };
    const b = types.u8x8{ 101, 102, 103, 104, 105, 106, 107, 108 };
    const expected = types.u8x8{ 2, 4, 6, 8, 102, 104, 106, 108 };
    try common.testIntrinsic(.{ .func = vuzp2_u8, .expected = expected, .args = .{ a, b } });
}

/// Permute vector elements
pub inline fn vuzp2_u16(a: types.u16x4, b: types.u16x4) types.u16x4 {
    return .{ a[1], a[3], b[1], b[3] };
}

test vuzp2_u16 {
    const a = types.u16x4{ 1, 2, 3, 4 };
    const b = types.u16x4{ 101, 102, 103, 104 };
    const expected = types.u16x4{ 2, 4, 102, 104 };
    try common.testIntrinsic(.{ .func = vuzp2_u16, .expected = expected, .args = .{ a, b } });
}

/// Permute vector elements
pub inline fn vuzp2_u32(a: types.u32x2, b: types.u32x2) types.u32x2 {
    return .{ a[1], b[1] };
}

test vuzp2_u32 {
    const a = types.u32x2{ 1, 2 };
    const b = types.u32x2{ 101, 102 };
    const expected = types.u32x2{ 2, 102 };
    try common.testIntrinsic(.{ .func = vuzp2_u32, .expected = expected, .args = .{ a, b } });
}

/// Permute vector elements
pub inline fn vuzp2_p8(a: types.p8x8, b: types.p8x8) types.p8x8 {
    return .{ a[1], a[3], a[5], a[7], b[1], b[3], b[5], b[7] };
}

test vuzp2_p8 {
    const a = types.p8x8{ 1, 2, 3, 4, 5, 6, 7, 8 };
    const b = types.p8x8{ 101, 102, 103, 104, 105, 106, 107, 108 };
    const expected = types.p8x8{ 2, 4, 6, 8, 102, 104, 106, 108 };
    try common.testIntrinsic(.{ .func = vuzp2_p8, .expected = expected, .args = .{ a, b } });
}

/// Permute vector elements
pub inline fn vuzp2_p16(a: types.p16x4, b: types.p16x4) types.p16x4 {
    return .{ a[1], a[3], b[1], b[3] };
}

test vuzp2_p16 {
    const a = types.p16x4{ 1, 2, 3, 4 };
    const b = types.p16x4{ 101, 102, 103, 104 };
    const expected = types.p16x4{ 2, 4, 102, 104 };
    try common.testIntrinsic(.{ .func = vuzp2_p16, .expected = expected, .args = .{ a, b } });
}

/// Permute vector elements
pub inline fn vuzp2_f16(a: types.f16x4, b: types.f16x4) types.f16x4 {
    return .{ a[1], a[3], b[1], b[3] };
}

test vuzp2_f16 {
    const a = types.f16x4{ 1.0, 2.0, 3.0, 4.0 };
    const b = types.f16x4{ 101.0, 102.0, 103.0, 104.0 };
    const expected = types.f16x4{ 2.0, 4.0, 102.0, 104.0 };
    try common.testIntrinsic(.{ .func = vuzp2_f16, .expected = expected, .args = .{ a, b } });
}

/// Permute vector elements
pub inline fn vuzp2_f32(a: types.f32x2, b: types.f32x2) types.f32x2 {
    return .{ a[1], b[1] };
}

test vuzp2_f32 {
    const a = types.f32x2{ 1.0, 2.0 };
    const b = types.f32x2{ 101.0, 102.0 };
    const expected = types.f32x2{ 2.0, 102.0 };
    try common.testIntrinsic(.{ .func = vuzp2_f32, .expected = expected, .args = .{ a, b } });
}

/// Permute vector elements
pub inline fn vuzp2q_s8(a: types.i8x16, b: types.i8x16) types.i8x16 {
    return .{ a[1], a[3], a[5], a[7], a[9], a[11], a[13], a[15], b[1], b[3], b[5], b[7], b[9], b[11], b[13], b[15] };
}

test vuzp2q_s8 {
    const a = types.i8x16{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 };
    const b = types.i8x16{ 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116 };
    const expected = types.i8x16{ 2, 4, 6, 8, 10, 12, 14, 16, 102, 104, 106, 108, 110, 112, 114, 116 };
    try common.testIntrinsic(.{ .func = vuzp2q_s8, .expected = expected, .args = .{ a, b } });
}

/// Permute vector elements
pub inline fn vuzp2q_s16(a: types.i16x8, b: types.i16x8) types.i16x8 {
    return .{ a[1], a[3], a[5], a[7], b[1], b[3], b[5], b[7] };
}

test vuzp2q_s16 {
    const a = types.i16x8{ 1, 2, 3, 4, 5, 6, 7, 8 };
    const b = types.i16x8{ 101, 102, 103, 104, 105, 106, 107, 108 };
    const expected = types.i16x8{ 2, 4, 6, 8, 102, 104, 106, 108 };
    try common.testIntrinsic(.{ .func = vuzp2q_s16, .expected = expected, .args = .{ a, b } });
}

/// Permute vector elements
pub inline fn vuzp2q_s32(a: types.i32x4, b: types.i32x4) types.i32x4 {
    return .{ a[1], a[3], b[1], b[3] };
}

test vuzp2q_s32 {
    const a = types.i32x4{ 1, 2, 3, 4 };
    const b = types.i32x4{ 101, 102, 103, 104 };
    const expected = types.i32x4{ 2, 4, 102, 104 };
    try common.testIntrinsic(.{ .func = vuzp2q_s32, .expected = expected, .args = .{ a, b } });
}

/// Permute vector elements
pub inline fn vuzp2q_s64(a: types.i64x2, b: types.i64x2) types.i64x2 {
    return .{ a[1], b[1] };
}

test vuzp2q_s64 {
    const a = types.i64x2{ 1, 2 };
    const b = types.i64x2{ 101, 102 };
    const expected = types.i64x2{ 2, 102 };
    try common.testIntrinsic(.{ .func = vuzp2q_s64, .expected = expected, .args = .{ a, b } });
}

/// Permute vector elements
pub inline fn vuzp2q_u8(a: types.u8x16, b: types.u8x16) types.u8x16 {
    return .{ a[1], a[3], a[5], a[7], a[9], a[11], a[13], a[15], b[1], b[3], b[5], b[7], b[9], b[11], b[13], b[15] };
}

test vuzp2q_u8 {
    const a = types.u8x16{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 };
    const b = types.u8x16{ 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116 };
    const expected = types.u8x16{ 2, 4, 6, 8, 10, 12, 14, 16, 102, 104, 106, 108, 110, 112, 114, 116 };
    try common.testIntrinsic(.{ .func = vuzp2q_u8, .expected = expected, .args = .{ a, b } });
}

/// Permute vector elements
pub inline fn vuzp2q_u16(a: types.u16x8, b: types.u16x8) types.u16x8 {
    return .{ a[1], a[3], a[5], a[7], b[1], b[3], b[5], b[7] };
}

test vuzp2q_u16 {
    const a = types.u16x8{ 1, 2, 3, 4, 5, 6, 7, 8 };
    const b = types.u16x8{ 101, 102, 103, 104, 105, 106, 107, 108 };
    const expected = types.u16x8{ 2, 4, 6, 8, 102, 104, 106, 108 };
    try common.testIntrinsic(.{ .func = vuzp2q_u16, .expected = expected, .args = .{ a, b } });
}

/// Permute vector elements
pub inline fn vuzp2q_u32(a: types.u32x4, b: types.u32x4) types.u32x4 {
    return .{ a[1], a[3], b[1], b[3] };
}

test vuzp2q_u32 {
    const a = types.u32x4{ 1, 2, 3, 4 };
    const b = types.u32x4{ 101, 102, 103, 104 };
    const expected = types.u32x4{ 2, 4, 102, 104 };
    try common.testIntrinsic(.{ .func = vuzp2q_u32, .expected = expected, .args = .{ a, b } });
}

/// Permute vector elements
pub inline fn vuzp2q_u64(a: types.u64x2, b: types.u64x2) types.u64x2 {
    return .{ a[1], b[1] };
}

test vuzp2q_u64 {
    const a = types.u64x2{ 1, 2 };
    const b = types.u64x2{ 101, 102 };
    const expected = types.u64x2{ 2, 102 };
    try common.testIntrinsic(.{ .func = vuzp2q_u64, .expected = expected, .args = .{ a, b } });
}

/// Permute vector elements
pub inline fn vuzp2q_p8(a: types.p8x16, b: types.p8x16) types.p8x16 {
    return .{ a[1], a[3], a[5], a[7], a[9], a[11], a[13], a[15], b[1], b[3], b[5], b[7], b[9], b[11], b[13], b[15] };
}

test vuzp2q_p8 {
    const a = types.p8x16{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 };
    const b = types.p8x16{ 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116 };
    const expected = types.p8x16{ 2, 4, 6, 8, 10, 12, 14, 16, 102, 104, 106, 108, 110, 112, 114, 116 };
    try common.testIntrinsic(.{ .func = vuzp2q_p8, .expected = expected, .args = .{ a, b } });
}

/// Permute vector elements
pub inline fn vuzp2q_p16(a: types.p16x8, b: types.p16x8) types.p16x8 {
    return .{ a[1], a[3], a[5], a[7], b[1], b[3], b[5], b[7] };
}

test vuzp2q_p16 {
    const a = types.p16x8{ 1, 2, 3, 4, 5, 6, 7, 8 };
    const b = types.p16x8{ 101, 102, 103, 104, 105, 106, 107, 108 };
    const expected = types.p16x8{ 2, 4, 6, 8, 102, 104, 106, 108 };
    try common.testIntrinsic(.{ .func = vuzp2q_p16, .expected = expected, .args = .{ a, b } });
}

/// Permute vector elements
pub inline fn vuzp2q_p64(a: types.p64x2, b: types.p64x2) types.p64x2 {
    return .{ a[1], b[1] };
}

test vuzp2q_p64 {
    const a = types.p64x2{ 1, 2 };
    const b = types.p64x2{ 101, 102 };
    const expected = types.p64x2{ 2, 102 };
    try common.testIntrinsic(.{ .func = vuzp2q_p64, .expected = expected, .args = .{ a, b } });
}

/// Permute vector elements
pub inline fn vuzp2q_f16(a: types.f16x8, b: types.f16x8) types.f16x8 {
    return .{ a[1], a[3], a[5], a[7], b[1], b[3], b[5], b[7] };
}

test vuzp2q_f16 {
    const a = types.f16x8{ 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0 };
    const b = types.f16x8{ 101.0, 102.0, 103.0, 104.0, 105.0, 106.0, 107.0, 108.0 };
    const expected = types.f16x8{ 2.0, 4.0, 6.0, 8.0, 102.0, 104.0, 106.0, 108.0 };
    try common.testIntrinsic(.{ .func = vuzp2q_f16, .expected = expected, .args = .{ a, b } });
}

/// Permute vector elements
pub inline fn vuzp2q_f32(a: types.f32x4, b: types.f32x4) types.f32x4 {
    return .{ a[1], a[3], b[1], b[3] };
}

test vuzp2q_f32 {
    const a = types.f32x4{ 1.0, 2.0, 3.0, 4.0 };
    const b = types.f32x4{ 101.0, 102.0, 103.0, 104.0 };
    const expected = types.f32x4{ 2.0, 4.0, 102.0, 104.0 };
    try common.testIntrinsic(.{ .func = vuzp2q_f32, .expected = expected, .args = .{ a, b } });
}

/// Permute vector elements
pub inline fn vuzp2q_f64(a: types.f64x2, b: types.f64x2) types.f64x2 {
    return .{ a[1], b[1] };
}

test vuzp2q_f64 {
    const a = types.f64x2{ 1.0, 2.0 };
    const b = types.f64x2{ 101.0, 102.0 };
    const expected = types.f64x2{ 2.0, 102.0 };
    try common.testIntrinsic(.{ .func = vuzp2q_f64, .expected = expected, .args = .{ a, b } });
}

/// Permute vector elements
pub inline fn vtrn1_s8(a: types.i8x8, b: types.i8x8) types.i8x8 {
    return .{ a[0], b[0], a[2], b[2], a[4], b[4], a[6], b[6] };
}

test vtrn1_s8 {
    const a = types.i8x8{ 1, 2, 3, 4, 5, 6, 7, 8 };
    const b = types.i8x8{ 101, 102, 103, 104, 105, 106, 107, 108 };
    const expected = types.i8x8{ 1, 101, 3, 103, 5, 105, 7, 107 };
    try common.testIntrinsic(.{ .func = vtrn1_s8, .expected = expected, .args = .{ a, b } });
}

/// Permute vector elements
pub inline fn vtrn1_s16(a: types.i16x4, b: types.i16x4) types.i16x4 {
    return .{ a[0], b[0], a[2], b[2] };
}

test vtrn1_s16 {
    const a = types.i16x4{ 1, 2, 3, 4 };
    const b = types.i16x4{ 101, 102, 103, 104 };
    const expected = types.i16x4{ 1, 101, 3, 103 };
    try common.testIntrinsic(.{ .func = vtrn1_s16, .expected = expected, .args = .{ a, b } });
}

/// Permute vector elements
pub inline fn vtrn1_s32(a: types.i32x2, b: types.i32x2) types.i32x2 {
    return .{ a[0], b[0] };
}

test vtrn1_s32 {
    const a = types.i32x2{ 1, 2 };
    const b = types.i32x2{ 101, 102 };
    const expected = types.i32x2{ 1, 101 };
    try common.testIntrinsic(.{ .func = vtrn1_s32, .expected = expected, .args = .{ a, b } });
}

/// Permute vector elements
pub inline fn vtrn1_u8(a: types.u8x8, b: types.u8x8) types.u8x8 {
    return .{ a[0], b[0], a[2], b[2], a[4], b[4], a[6], b[6] };
}

test vtrn1_u8 {
    const a = types.u8x8{ 1, 2, 3, 4, 5, 6, 7, 8 };
    const b = types.u8x8{ 101, 102, 103, 104, 105, 106, 107, 108 };
    const expected = types.u8x8{ 1, 101, 3, 103, 5, 105, 7, 107 };
    try common.testIntrinsic(.{ .func = vtrn1_u8, .expected = expected, .args = .{ a, b } });
}

/// Permute vector elements
pub inline fn vtrn1_u16(a: types.u16x4, b: types.u16x4) types.u16x4 {
    return .{ a[0], b[0], a[2], b[2] };
}

test vtrn1_u16 {
    const a = types.u16x4{ 1, 2, 3, 4 };
    const b = types.u16x4{ 101, 102, 103, 104 };
    const expected = types.u16x4{ 1, 101, 3, 103 };
    try common.testIntrinsic(.{ .func = vtrn1_u16, .expected = expected, .args = .{ a, b } });
}

/// Permute vector elements
pub inline fn vtrn1_u32(a: types.u32x2, b: types.u32x2) types.u32x2 {
    return .{ a[0], b[0] };
}

test vtrn1_u32 {
    const a = types.u32x2{ 1, 2 };
    const b = types.u32x2{ 101, 102 };
    const expected = types.u32x2{ 1, 101 };
    try common.testIntrinsic(.{ .func = vtrn1_u32, .expected = expected, .args = .{ a, b } });
}

/// Permute vector elements
pub inline fn vtrn1_p8(a: types.p8x8, b: types.p8x8) types.p8x8 {
    return .{ a[0], b[0], a[2], b[2], a[4], b[4], a[6], b[6] };
}

test vtrn1_p8 {
    const a = types.p8x8{ 1, 2, 3, 4, 5, 6, 7, 8 };
    const b = types.p8x8{ 101, 102, 103, 104, 105, 106, 107, 108 };
    const expected = types.p8x8{ 1, 101, 3, 103, 5, 105, 7, 107 };
    try common.testIntrinsic(.{ .func = vtrn1_p8, .expected = expected, .args = .{ a, b } });
}

/// Permute vector elements
pub inline fn vtrn1_p16(a: types.p16x4, b: types.p16x4) types.p16x4 {
    return .{ a[0], b[0], a[2], b[2] };
}

test vtrn1_p16 {
    const a = types.p16x4{ 1, 2, 3, 4 };
    const b = types.p16x4{ 101, 102, 103, 104 };
    const expected = types.p16x4{ 1, 101, 3, 103 };
    try common.testIntrinsic(.{ .func = vtrn1_p16, .expected = expected, .args = .{ a, b } });
}

/// Permute vector elements
pub inline fn vtrn1_f16(a: types.f16x4, b: types.f16x4) types.f16x4 {
    return .{ a[0], b[0], a[2], b[2] };
}

test vtrn1_f16 {
    const a = types.f16x4{ 1.0, 2.0, 3.0, 4.0 };
    const b = types.f16x4{ 101.0, 102.0, 103.0, 104.0 };
    const expected = types.f16x4{ 1.0, 101.0, 3.0, 103.0 };
    try common.testIntrinsic(.{ .func = vtrn1_f16, .expected = expected, .args = .{ a, b } });
}

/// Permute vector elements
pub inline fn vtrn1_f32(a: types.f32x2, b: types.f32x2) types.f32x2 {
    return .{ a[0], b[0] };
}

test vtrn1_f32 {
    const a = types.f32x2{ 1.0, 2.0 };
    const b = types.f32x2{ 101.0, 102.0 };
    const expected = types.f32x2{ 1.0, 101.0 };
    try common.testIntrinsic(.{ .func = vtrn1_f32, .expected = expected, .args = .{ a, b } });
}

/// Permute vector elements
pub inline fn vtrn1q_p8(a: types.p8x16, b: types.p8x16) types.p8x16 {
    return .{ a[0], b[0], a[2], b[2], a[4], b[4], a[6], b[6], a[8], b[8], a[10], b[10], a[12], b[12], a[14], b[14] };
}

test vtrn1q_p8 {
    const a = types.p8x16{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 };
    const b = types.p8x16{ 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116 };
    const expected = types.p8x16{ 1, 101, 3, 103, 5, 105, 7, 107, 9, 109, 11, 111, 13, 113, 15, 115 };
    try common.testIntrinsic(.{ .func = vtrn1q_p8, .expected = expected, .args = .{ a, b } });
}

/// Permute vector elements
pub inline fn vtrn1q_p16(a: types.p16x8, b: types.p16x8) types.p16x8 {
    return .{ a[0], b[0], a[2], b[2], a[4], b[4], a[6], b[6] };
}

test vtrn1q_p16 {
    const a = types.p16x8{ 1, 2, 3, 4, 5, 6, 7, 8 };
    const b = types.p16x8{ 101, 102, 103, 104, 105, 106, 107, 108 };
    const expected = types.p16x8{ 1, 101, 3, 103, 5, 105, 7, 107 };
    try common.testIntrinsic(.{ .func = vtrn1q_p16, .expected = expected, .args = .{ a, b } });
}

/// Permute vector elements
pub inline fn vtrn1q_p64(a: types.p64x2, b: types.p64x2) types.p64x2 {
    return .{ a[0], b[0] };
}

test vtrn1q_p64 {
    const a = types.p64x2{ 1, 2 };
    const b = types.p64x2{ 101, 102 };
    const expected = types.p64x2{ 1, 101 };
    try common.testIntrinsic(.{ .func = vtrn1q_p64, .expected = expected, .args = .{ a, b } });
}

/// Permute vector elements
pub inline fn vtrn1q_f16(a: types.f16x8, b: types.f16x8) types.f16x8 {
    return .{ a[0], b[0], a[2], b[2], a[4], b[4], a[6], b[6] };
}

test vtrn1q_f16 {
    const a = types.f16x8{ 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0 };
    const b = types.f16x8{ 101.0, 102.0, 103.0, 104.0, 105.0, 106.0, 107.0, 108.0 };
    const expected = types.f16x8{ 1.0, 101.0, 3.0, 103.0, 5.0, 105.0, 7.0, 107.0 };
    try common.testIntrinsic(.{ .func = vtrn1q_f16, .expected = expected, .args = .{ a, b } });
}

/// Permute vector elements
pub inline fn vtrn2_s8(a: types.i8x8, b: types.i8x8) types.i8x8 {
    return .{ a[1], b[1], a[3], b[3], a[5], b[5], a[7], b[7] };
}

test vtrn2_s8 {
    const a = types.i8x8{ 1, 2, 3, 4, 5, 6, 7, 8 };
    const b = types.i8x8{ 101, 102, 103, 104, 105, 106, 107, 108 };
    const expected = types.i8x8{ 2, 102, 4, 104, 6, 106, 8, 108 };
    try common.testIntrinsic(.{ .func = vtrn2_s8, .expected = expected, .args = .{ a, b } });
}

/// Permute vector elements
pub inline fn vtrn2_s16(a: types.i16x4, b: types.i16x4) types.i16x4 {
    return .{ a[1], b[1], a[3], b[3] };
}

test vtrn2_s16 {
    const a = types.i16x4{ 1, 2, 3, 4 };
    const b = types.i16x4{ 101, 102, 103, 104 };
    const expected = types.i16x4{ 2, 102, 4, 104 };
    try common.testIntrinsic(.{ .func = vtrn2_s16, .expected = expected, .args = .{ a, b } });
}

/// Permute vector elements
pub inline fn vtrn2_s32(a: types.i32x2, b: types.i32x2) types.i32x2 {
    return .{ a[1], b[1] };
}

test vtrn2_s32 {
    const a = types.i32x2{ 1, 2 };
    const b = types.i32x2{ 101, 102 };
    const expected = types.i32x2{ 2, 102 };
    try common.testIntrinsic(.{ .func = vtrn2_s32, .expected = expected, .args = .{ a, b } });
}

/// Permute vector elements
pub inline fn vtrn2_u8(a: types.u8x8, b: types.u8x8) types.u8x8 {
    return .{ a[1], b[1], a[3], b[3], a[5], b[5], a[7], b[7] };
}

test vtrn2_u8 {
    const a = types.u8x8{ 1, 2, 3, 4, 5, 6, 7, 8 };
    const b = types.u8x8{ 101, 102, 103, 104, 105, 106, 107, 108 };
    const expected = types.u8x8{ 2, 102, 4, 104, 6, 106, 8, 108 };
    try common.testIntrinsic(.{ .func = vtrn2_u8, .expected = expected, .args = .{ a, b } });
}

/// Permute vector elements
pub inline fn vtrn2_u16(a: types.u16x4, b: types.u16x4) types.u16x4 {
    return .{ a[1], b[1], a[3], b[3] };
}

test vtrn2_u16 {
    const a = types.u16x4{ 1, 2, 3, 4 };
    const b = types.u16x4{ 101, 102, 103, 104 };
    const expected = types.u16x4{ 2, 102, 4, 104 };
    try common.testIntrinsic(.{ .func = vtrn2_u16, .expected = expected, .args = .{ a, b } });
}

/// Permute vector elements
pub inline fn vtrn2_u32(a: types.u32x2, b: types.u32x2) types.u32x2 {
    return .{ a[1], b[1] };
}

test vtrn2_u32 {
    const a = types.u32x2{ 1, 2 };
    const b = types.u32x2{ 101, 102 };
    const expected = types.u32x2{ 2, 102 };
    try common.testIntrinsic(.{ .func = vtrn2_u32, .expected = expected, .args = .{ a, b } });
}

/// Permute vector elements
pub inline fn vtrn2_p8(a: types.p8x8, b: types.p8x8) types.p8x8 {
    return .{ a[1], b[1], a[3], b[3], a[5], b[5], a[7], b[7] };
}

test vtrn2_p8 {
    const a = types.p8x8{ 1, 2, 3, 4, 5, 6, 7, 8 };
    const b = types.p8x8{ 101, 102, 103, 104, 105, 106, 107, 108 };
    const expected = types.p8x8{ 2, 102, 4, 104, 6, 106, 8, 108 };
    try common.testIntrinsic(.{ .func = vtrn2_p8, .expected = expected, .args = .{ a, b } });
}

/// Permute vector elements
pub inline fn vtrn2_p16(a: types.p16x4, b: types.p16x4) types.p16x4 {
    return .{ a[1], b[1], a[3], b[3] };
}

test vtrn2_p16 {
    const a = types.p16x4{ 1, 2, 3, 4 };
    const b = types.p16x4{ 101, 102, 103, 104 };
    const expected = types.p16x4{ 2, 102, 4, 104 };
    try common.testIntrinsic(.{ .func = vtrn2_p16, .expected = expected, .args = .{ a, b } });
}

/// Permute vector elements
pub inline fn vtrn2_f16(a: types.f16x4, b: types.f16x4) types.f16x4 {
    return .{ a[1], b[1], a[3], b[3] };
}

test vtrn2_f16 {
    const a = types.f16x4{ 1.0, 2.0, 3.0, 4.0 };
    const b = types.f16x4{ 101.0, 102.0, 103.0, 104.0 };
    const expected = types.f16x4{ 2.0, 102.0, 4.0, 104.0 };
    try common.testIntrinsic(.{ .func = vtrn2_f16, .expected = expected, .args = .{ a, b } });
}

/// Permute vector elements
pub inline fn vtrn2_f32(a: types.f32x2, b: types.f32x2) types.f32x2 {
    return .{ a[1], b[1] };
}

test vtrn2_f32 {
    const a = types.f32x2{ 1.0, 2.0 };
    const b = types.f32x2{ 101.0, 102.0 };
    const expected = types.f32x2{ 2.0, 102.0 };
    try common.testIntrinsic(.{ .func = vtrn2_f32, .expected = expected, .args = .{ a, b } });
}

/// Permute vector elements
pub inline fn vtrn2q_p8(a: types.p8x16, b: types.p8x16) types.p8x16 {
    return .{ a[1], b[1], a[3], b[3], a[5], b[5], a[7], b[7], a[9], b[9], a[11], b[11], a[13], b[13], a[15], b[15] };
}

test vtrn2q_p8 {
    const a = types.p8x16{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 };
    const b = types.p8x16{ 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116 };
    const expected = types.p8x16{ 2, 102, 4, 104, 6, 106, 8, 108, 10, 110, 12, 112, 14, 114, 16, 116 };
    try common.testIntrinsic(.{ .func = vtrn2q_p8, .expected = expected, .args = .{ a, b } });
}

/// Permute vector elements
pub inline fn vtrn2q_p16(a: types.p16x8, b: types.p16x8) types.p16x8 {
    return .{ a[1], b[1], a[3], b[3], a[5], b[5], a[7], b[7] };
}

test vtrn2q_p16 {
    const a = types.p16x8{ 1, 2, 3, 4, 5, 6, 7, 8 };
    const b = types.p16x8{ 101, 102, 103, 104, 105, 106, 107, 108 };
    const expected = types.p16x8{ 2, 102, 4, 104, 6, 106, 8, 108 };
    try common.testIntrinsic(.{ .func = vtrn2q_p16, .expected = expected, .args = .{ a, b } });
}

/// Permute vector elements
pub inline fn vtrn2q_p64(a: types.p64x2, b: types.p64x2) types.p64x2 {
    return .{ a[1], b[1] };
}

test vtrn2q_p64 {
    const a = types.p64x2{ 1, 2 };
    const b = types.p64x2{ 101, 102 };
    const expected = types.p64x2{ 2, 102 };
    try common.testIntrinsic(.{ .func = vtrn2q_p64, .expected = expected, .args = .{ a, b } });
}

/// Permute vector elements
pub inline fn vtrn2q_f16(a: types.f16x8, b: types.f16x8) types.f16x8 {
    return .{ a[1], b[1], a[3], b[3], a[5], b[5], a[7], b[7] };
}

test vtrn2q_f16 {
    const a = types.f16x8{ 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0 };
    const b = types.f16x8{ 101.0, 102.0, 103.0, 104.0, 105.0, 106.0, 107.0, 108.0 };
    const expected = types.f16x8{ 2.0, 102.0, 4.0, 104.0, 6.0, 106.0, 8.0, 108.0 };
    try common.testIntrinsic(.{ .func = vtrn2q_f16, .expected = expected, .args = .{ a, b } });
}

/// Interleave / unzip vector elements returning a pair of vectors
pub inline fn vzip_s8(a: types.i8x8, b: types.i8x8) struct { types.i8x8, types.i8x8 } {
    return .{ vzip1_s8(a, b), vzip2_s8(a, b) };
}

test vzip_s8 {
    const a = types.i8x8{ 1, 2, 3, 4, 5, 6, 7, 8 };
    const b = types.i8x8{ 101, 102, 103, 104, 105, 106, 107, 108 };
    const res = vzip_s8(a, b);
    try std.testing.expectEqual(vzip1_s8(a, b), res[0]);
    try std.testing.expectEqual(vzip2_s8(a, b), res[1]);
}

/// Interleave / unzip vector elements returning a pair of vectors
pub inline fn vzip_s16(a: types.i16x4, b: types.i16x4) struct { types.i16x4, types.i16x4 } {
    return .{ vzip1_s16(a, b), vzip2_s16(a, b) };
}

test vzip_s16 {
    const a = types.i16x4{ 1, 2, 3, 4 };
    const b = types.i16x4{ 101, 102, 103, 104 };
    const res = vzip_s16(a, b);
    try std.testing.expectEqual(vzip1_s16(a, b), res[0]);
    try std.testing.expectEqual(vzip2_s16(a, b), res[1]);
}

/// Interleave / unzip vector elements returning a pair of vectors
pub inline fn vzip_s32(a: types.i32x2, b: types.i32x2) struct { types.i32x2, types.i32x2 } {
    return .{ vzip1_s32(a, b), vzip2_s32(a, b) };
}

test vzip_s32 {
    const a = types.i32x2{ 1, 2 };
    const b = types.i32x2{ 101, 102 };
    const res = vzip_s32(a, b);
    try std.testing.expectEqual(vzip1_s32(a, b), res[0]);
    try std.testing.expectEqual(vzip2_s32(a, b), res[1]);
}

/// Interleave / unzip vector elements returning a pair of vectors
pub inline fn vzip_u8(a: types.u8x8, b: types.u8x8) struct { types.u8x8, types.u8x8 } {
    return .{ vzip1_u8(a, b), vzip2_u8(a, b) };
}

test vzip_u8 {
    const a = types.u8x8{ 1, 2, 3, 4, 5, 6, 7, 8 };
    const b = types.u8x8{ 101, 102, 103, 104, 105, 106, 107, 108 };
    const res = vzip_u8(a, b);
    try std.testing.expectEqual(vzip1_u8(a, b), res[0]);
    try std.testing.expectEqual(vzip2_u8(a, b), res[1]);
}

/// Interleave / unzip vector elements returning a pair of vectors
pub inline fn vzip_u16(a: types.u16x4, b: types.u16x4) struct { types.u16x4, types.u16x4 } {
    return .{ vzip1_u16(a, b), vzip2_u16(a, b) };
}

test vzip_u16 {
    const a = types.u16x4{ 1, 2, 3, 4 };
    const b = types.u16x4{ 101, 102, 103, 104 };
    const res = vzip_u16(a, b);
    try std.testing.expectEqual(vzip1_u16(a, b), res[0]);
    try std.testing.expectEqual(vzip2_u16(a, b), res[1]);
}

/// Interleave / unzip vector elements returning a pair of vectors
pub inline fn vzip_u32(a: types.u32x2, b: types.u32x2) struct { types.u32x2, types.u32x2 } {
    return .{ vzip1_u32(a, b), vzip2_u32(a, b) };
}

test vzip_u32 {
    const a = types.u32x2{ 1, 2 };
    const b = types.u32x2{ 101, 102 };
    const res = vzip_u32(a, b);
    try std.testing.expectEqual(vzip1_u32(a, b), res[0]);
    try std.testing.expectEqual(vzip2_u32(a, b), res[1]);
}

/// Interleave / unzip vector elements returning a pair of vectors
pub inline fn vzip_p8(a: types.p8x8, b: types.p8x8) struct { types.p8x8, types.p8x8 } {
    return .{ vzip1_p8(a, b), vzip2_p8(a, b) };
}

test vzip_p8 {
    const a = types.p8x8{ 1, 2, 3, 4, 5, 6, 7, 8 };
    const b = types.p8x8{ 101, 102, 103, 104, 105, 106, 107, 108 };
    const res = vzip_p8(a, b);
    try std.testing.expectEqual(vzip1_p8(a, b), res[0]);
    try std.testing.expectEqual(vzip2_p8(a, b), res[1]);
}

/// Interleave / unzip vector elements returning a pair of vectors
pub inline fn vzip_p16(a: types.p16x4, b: types.p16x4) struct { types.p16x4, types.p16x4 } {
    return .{ vzip1_p16(a, b), vzip2_p16(a, b) };
}

test vzip_p16 {
    const a = types.p16x4{ 1, 2, 3, 4 };
    const b = types.p16x4{ 101, 102, 103, 104 };
    const res = vzip_p16(a, b);
    try std.testing.expectEqual(vzip1_p16(a, b), res[0]);
    try std.testing.expectEqual(vzip2_p16(a, b), res[1]);
}

/// Interleave / unzip vector elements returning a pair of vectors
pub inline fn vzip_f16(a: types.f16x4, b: types.f16x4) struct { types.f16x4, types.f16x4 } {
    return .{ vzip1_f16(a, b), vzip2_f16(a, b) };
}

test vzip_f16 {
    const a = types.f16x4{ 1.0, 2.0, 3.0, 4.0 };
    const b = types.f16x4{ 101.0, 102.0, 103.0, 104.0 };
    const res = vzip_f16(a, b);
    try std.testing.expectEqual(vzip1_f16(a, b), res[0]);
    try std.testing.expectEqual(vzip2_f16(a, b), res[1]);
}

/// Interleave / unzip vector elements returning a pair of vectors
pub inline fn vzip_f32(a: types.f32x2, b: types.f32x2) struct { types.f32x2, types.f32x2 } {
    return .{ vzip1_f32(a, b), vzip2_f32(a, b) };
}

test vzip_f32 {
    const a = types.f32x2{ 1.0, 2.0 };
    const b = types.f32x2{ 101.0, 102.0 };
    const res = vzip_f32(a, b);
    try std.testing.expectEqual(vzip1_f32(a, b), res[0]);
    try std.testing.expectEqual(vzip2_f32(a, b), res[1]);
}

/// Interleave / unzip vector elements returning a pair of vectors
pub inline fn vzipq_s8(a: types.i8x16, b: types.i8x16) struct { types.i8x16, types.i8x16 } {
    return .{ vzip1q_s8(a, b), vzip2q_s8(a, b) };
}

test vzipq_s8 {
    const a = types.i8x16{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 };
    const b = types.i8x16{ 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116 };
    const res = vzipq_s8(a, b);
    try std.testing.expectEqual(vzip1q_s8(a, b), res[0]);
    try std.testing.expectEqual(vzip2q_s8(a, b), res[1]);
}

/// Interleave / unzip vector elements returning a pair of vectors
pub inline fn vzipq_s16(a: types.i16x8, b: types.i16x8) struct { types.i16x8, types.i16x8 } {
    return .{ vzip1q_s16(a, b), vzip2q_s16(a, b) };
}

test vzipq_s16 {
    const a = types.i16x8{ 1, 2, 3, 4, 5, 6, 7, 8 };
    const b = types.i16x8{ 101, 102, 103, 104, 105, 106, 107, 108 };
    const res = vzipq_s16(a, b);
    try std.testing.expectEqual(vzip1q_s16(a, b), res[0]);
    try std.testing.expectEqual(vzip2q_s16(a, b), res[1]);
}

/// Interleave / unzip vector elements returning a pair of vectors
pub inline fn vzipq_s32(a: types.i32x4, b: types.i32x4) struct { types.i32x4, types.i32x4 } {
    return .{ vzip1q_s32(a, b), vzip2q_s32(a, b) };
}

test vzipq_s32 {
    const a = types.i32x4{ 1, 2, 3, 4 };
    const b = types.i32x4{ 101, 102, 103, 104 };
    const res = vzipq_s32(a, b);
    try std.testing.expectEqual(vzip1q_s32(a, b), res[0]);
    try std.testing.expectEqual(vzip2q_s32(a, b), res[1]);
}

/// Interleave / unzip vector elements returning a pair of vectors
pub inline fn vzipq_s64(a: types.i64x2, b: types.i64x2) struct { types.i64x2, types.i64x2 } {
    return .{ vzip1q_s64(a, b), vzip2q_s64(a, b) };
}

test vzipq_s64 {
    const a = types.i64x2{ 1, 2 };
    const b = types.i64x2{ 101, 102 };
    const res = vzipq_s64(a, b);
    try std.testing.expectEqual(vzip1q_s64(a, b), res[0]);
    try std.testing.expectEqual(vzip2q_s64(a, b), res[1]);
}

/// Interleave / unzip vector elements returning a pair of vectors
pub inline fn vzipq_p8(a: types.p8x16, b: types.p8x16) struct { types.p8x16, types.p8x16 } {
    return .{ vzip1q_p8(a, b), vzip2q_p8(a, b) };
}

test vzipq_p8 {
    const a = types.p8x16{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 };
    const b = types.p8x16{ 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116 };
    const res = vzipq_p8(a, b);
    try std.testing.expectEqual(vzip1q_p8(a, b), res[0]);
    try std.testing.expectEqual(vzip2q_p8(a, b), res[1]);
}

/// Interleave / unzip vector elements returning a pair of vectors
pub inline fn vzipq_p16(a: types.p16x8, b: types.p16x8) struct { types.p16x8, types.p16x8 } {
    return .{ vzip1q_p16(a, b), vzip2q_p16(a, b) };
}

test vzipq_p16 {
    const a = types.p16x8{ 1, 2, 3, 4, 5, 6, 7, 8 };
    const b = types.p16x8{ 101, 102, 103, 104, 105, 106, 107, 108 };
    const res = vzipq_p16(a, b);
    try std.testing.expectEqual(vzip1q_p16(a, b), res[0]);
    try std.testing.expectEqual(vzip2q_p16(a, b), res[1]);
}

/// Interleave / unzip vector elements returning a pair of vectors
pub inline fn vzipq_p64(a: types.p64x2, b: types.p64x2) struct { types.p64x2, types.p64x2 } {
    return .{ vzip1q_p64(a, b), vzip2q_p64(a, b) };
}

test vzipq_p64 {
    const a = types.p64x2{ 1, 2 };
    const b = types.p64x2{ 101, 102 };
    const res = vzipq_p64(a, b);
    try std.testing.expectEqual(vzip1q_p64(a, b), res[0]);
    try std.testing.expectEqual(vzip2q_p64(a, b), res[1]);
}

/// Interleave / unzip vector elements returning a pair of vectors
pub inline fn vzipq_f16(a: types.f16x8, b: types.f16x8) struct { types.f16x8, types.f16x8 } {
    return .{ vzip1q_f16(a, b), vzip2q_f16(a, b) };
}

test vzipq_f16 {
    const a = types.f16x8{ 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0 };
    const b = types.f16x8{ 101.0, 102.0, 103.0, 104.0, 105.0, 106.0, 107.0, 108.0 };
    const res = vzipq_f16(a, b);
    try std.testing.expectEqual(vzip1q_f16(a, b), res[0]);
    try std.testing.expectEqual(vzip2q_f16(a, b), res[1]);
}

/// Interleave / unzip vector elements returning a pair of vectors
pub inline fn vzipq_f32(a: types.f32x4, b: types.f32x4) struct { types.f32x4, types.f32x4 } {
    return .{ vzip1q_f32(a, b), vzip2q_f32(a, b) };
}

test vzipq_f32 {
    const a = types.f32x4{ 1.0, 2.0, 3.0, 4.0 };
    const b = types.f32x4{ 101.0, 102.0, 103.0, 104.0 };
    const res = vzipq_f32(a, b);
    try std.testing.expectEqual(vzip1q_f32(a, b), res[0]);
    try std.testing.expectEqual(vzip2q_f32(a, b), res[1]);
}

/// Interleave / unzip vector elements returning a pair of vectors
pub inline fn vzipq_f64(a: types.f64x2, b: types.f64x2) struct { types.f64x2, types.f64x2 } {
    return .{ vzip1q_f64(a, b), vzip2q_f64(a, b) };
}

test vzipq_f64 {
    const a = types.f64x2{ 1.0, 2.0 };
    const b = types.f64x2{ 101.0, 102.0 };
    const res = vzipq_f64(a, b);
    try std.testing.expectEqual(vzip1q_f64(a, b), res[0]);
    try std.testing.expectEqual(vzip2q_f64(a, b), res[1]);
}

/// Interleave / unzip vector elements returning a pair of vectors
pub inline fn vuzp_s8(a: types.i8x8, b: types.i8x8) struct { types.i8x8, types.i8x8 } {
    return .{ vuzp1_s8(a, b), vuzp2_s8(a, b) };
}

test vuzp_s8 {
    const a = types.i8x8{ 1, 2, 3, 4, 5, 6, 7, 8 };
    const b = types.i8x8{ 101, 102, 103, 104, 105, 106, 107, 108 };
    const res = vuzp_s8(a, b);
    try std.testing.expectEqual(vuzp1_s8(a, b), res[0]);
    try std.testing.expectEqual(vuzp2_s8(a, b), res[1]);
}

/// Interleave / unzip vector elements returning a pair of vectors
pub inline fn vuzp_s16(a: types.i16x4, b: types.i16x4) struct { types.i16x4, types.i16x4 } {
    return .{ vuzp1_s16(a, b), vuzp2_s16(a, b) };
}

test vuzp_s16 {
    const a = types.i16x4{ 1, 2, 3, 4 };
    const b = types.i16x4{ 101, 102, 103, 104 };
    const res = vuzp_s16(a, b);
    try std.testing.expectEqual(vuzp1_s16(a, b), res[0]);
    try std.testing.expectEqual(vuzp2_s16(a, b), res[1]);
}

/// Interleave / unzip vector elements returning a pair of vectors
pub inline fn vuzp_s32(a: types.i32x2, b: types.i32x2) struct { types.i32x2, types.i32x2 } {
    return .{ vuzp1_s32(a, b), vuzp2_s32(a, b) };
}

test vuzp_s32 {
    const a = types.i32x2{ 1, 2 };
    const b = types.i32x2{ 101, 102 };
    const res = vuzp_s32(a, b);
    try std.testing.expectEqual(vuzp1_s32(a, b), res[0]);
    try std.testing.expectEqual(vuzp2_s32(a, b), res[1]);
}

/// Interleave / unzip vector elements returning a pair of vectors
pub inline fn vuzp_u8(a: types.u8x8, b: types.u8x8) struct { types.u8x8, types.u8x8 } {
    return .{ vuzp1_u8(a, b), vuzp2_u8(a, b) };
}

test vuzp_u8 {
    const a = types.u8x8{ 1, 2, 3, 4, 5, 6, 7, 8 };
    const b = types.u8x8{ 101, 102, 103, 104, 105, 106, 107, 108 };
    const res = vuzp_u8(a, b);
    try std.testing.expectEqual(vuzp1_u8(a, b), res[0]);
    try std.testing.expectEqual(vuzp2_u8(a, b), res[1]);
}

/// Interleave / unzip vector elements returning a pair of vectors
pub inline fn vuzp_u16(a: types.u16x4, b: types.u16x4) struct { types.u16x4, types.u16x4 } {
    return .{ vuzp1_u16(a, b), vuzp2_u16(a, b) };
}

test vuzp_u16 {
    const a = types.u16x4{ 1, 2, 3, 4 };
    const b = types.u16x4{ 101, 102, 103, 104 };
    const res = vuzp_u16(a, b);
    try std.testing.expectEqual(vuzp1_u16(a, b), res[0]);
    try std.testing.expectEqual(vuzp2_u16(a, b), res[1]);
}

/// Interleave / unzip vector elements returning a pair of vectors
pub inline fn vuzp_u32(a: types.u32x2, b: types.u32x2) struct { types.u32x2, types.u32x2 } {
    return .{ vuzp1_u32(a, b), vuzp2_u32(a, b) };
}

test vuzp_u32 {
    const a = types.u32x2{ 1, 2 };
    const b = types.u32x2{ 101, 102 };
    const res = vuzp_u32(a, b);
    try std.testing.expectEqual(vuzp1_u32(a, b), res[0]);
    try std.testing.expectEqual(vuzp2_u32(a, b), res[1]);
}

/// Interleave / unzip vector elements returning a pair of vectors
pub inline fn vuzp_p8(a: types.p8x8, b: types.p8x8) struct { types.p8x8, types.p8x8 } {
    return .{ vuzp1_p8(a, b), vuzp2_p8(a, b) };
}

test vuzp_p8 {
    const a = types.p8x8{ 1, 2, 3, 4, 5, 6, 7, 8 };
    const b = types.p8x8{ 101, 102, 103, 104, 105, 106, 107, 108 };
    const res = vuzp_p8(a, b);
    try std.testing.expectEqual(vuzp1_p8(a, b), res[0]);
    try std.testing.expectEqual(vuzp2_p8(a, b), res[1]);
}

/// Interleave / unzip vector elements returning a pair of vectors
pub inline fn vuzp_p16(a: types.p16x4, b: types.p16x4) struct { types.p16x4, types.p16x4 } {
    return .{ vuzp1_p16(a, b), vuzp2_p16(a, b) };
}

test vuzp_p16 {
    const a = types.p16x4{ 1, 2, 3, 4 };
    const b = types.p16x4{ 101, 102, 103, 104 };
    const res = vuzp_p16(a, b);
    try std.testing.expectEqual(vuzp1_p16(a, b), res[0]);
    try std.testing.expectEqual(vuzp2_p16(a, b), res[1]);
}

/// Interleave / unzip vector elements returning a pair of vectors
pub inline fn vuzp_f16(a: types.f16x4, b: types.f16x4) struct { types.f16x4, types.f16x4 } {
    return .{ vuzp1_f16(a, b), vuzp2_f16(a, b) };
}

test vuzp_f16 {
    const a = types.f16x4{ 1.0, 2.0, 3.0, 4.0 };
    const b = types.f16x4{ 101.0, 102.0, 103.0, 104.0 };
    const res = vuzp_f16(a, b);
    try std.testing.expectEqual(vuzp1_f16(a, b), res[0]);
    try std.testing.expectEqual(vuzp2_f16(a, b), res[1]);
}

/// Interleave / unzip vector elements returning a pair of vectors
pub inline fn vuzp_f32(a: types.f32x2, b: types.f32x2) struct { types.f32x2, types.f32x2 } {
    return .{ vuzp1_f32(a, b), vuzp2_f32(a, b) };
}

test vuzp_f32 {
    const a = types.f32x2{ 1.0, 2.0 };
    const b = types.f32x2{ 101.0, 102.0 };
    const res = vuzp_f32(a, b);
    try std.testing.expectEqual(vuzp1_f32(a, b), res[0]);
    try std.testing.expectEqual(vuzp2_f32(a, b), res[1]);
}

/// Interleave / unzip vector elements returning a pair of vectors
pub inline fn vuzpq_s8(a: types.i8x16, b: types.i8x16) struct { types.i8x16, types.i8x16 } {
    return .{ vuzp1q_s8(a, b), vuzp2q_s8(a, b) };
}

test vuzpq_s8 {
    const a = types.i8x16{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 };
    const b = types.i8x16{ 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116 };
    const res = vuzpq_s8(a, b);
    try std.testing.expectEqual(vuzp1q_s8(a, b), res[0]);
    try std.testing.expectEqual(vuzp2q_s8(a, b), res[1]);
}

/// Interleave / unzip vector elements returning a pair of vectors
pub inline fn vuzpq_s16(a: types.i16x8, b: types.i16x8) struct { types.i16x8, types.i16x8 } {
    return .{ vuzp1q_s16(a, b), vuzp2q_s16(a, b) };
}

test vuzpq_s16 {
    const a = types.i16x8{ 1, 2, 3, 4, 5, 6, 7, 8 };
    const b = types.i16x8{ 101, 102, 103, 104, 105, 106, 107, 108 };
    const res = vuzpq_s16(a, b);
    try std.testing.expectEqual(vuzp1q_s16(a, b), res[0]);
    try std.testing.expectEqual(vuzp2q_s16(a, b), res[1]);
}

/// Interleave / unzip vector elements returning a pair of vectors
pub inline fn vuzpq_s32(a: types.i32x4, b: types.i32x4) struct { types.i32x4, types.i32x4 } {
    return .{ vuzp1q_s32(a, b), vuzp2q_s32(a, b) };
}

test vuzpq_s32 {
    const a = types.i32x4{ 1, 2, 3, 4 };
    const b = types.i32x4{ 101, 102, 103, 104 };
    const res = vuzpq_s32(a, b);
    try std.testing.expectEqual(vuzp1q_s32(a, b), res[0]);
    try std.testing.expectEqual(vuzp2q_s32(a, b), res[1]);
}

/// Interleave / unzip vector elements returning a pair of vectors
pub inline fn vuzpq_s64(a: types.i64x2, b: types.i64x2) struct { types.i64x2, types.i64x2 } {
    return .{ vuzp1q_s64(a, b), vuzp2q_s64(a, b) };
}

test vuzpq_s64 {
    const a = types.i64x2{ 1, 2 };
    const b = types.i64x2{ 101, 102 };
    const res = vuzpq_s64(a, b);
    try std.testing.expectEqual(vuzp1q_s64(a, b), res[0]);
    try std.testing.expectEqual(vuzp2q_s64(a, b), res[1]);
}

/// Interleave / unzip vector elements returning a pair of vectors
pub inline fn vuzpq_u8(a: types.u8x16, b: types.u8x16) struct { types.u8x16, types.u8x16 } {
    return .{ vuzp1q_u8(a, b), vuzp2q_u8(a, b) };
}

test vuzpq_u8 {
    const a = types.u8x16{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 };
    const b = types.u8x16{ 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116 };
    const res = vuzpq_u8(a, b);
    try std.testing.expectEqual(vuzp1q_u8(a, b), res[0]);
    try std.testing.expectEqual(vuzp2q_u8(a, b), res[1]);
}

/// Interleave / unzip vector elements returning a pair of vectors
pub inline fn vuzpq_u16(a: types.u16x8, b: types.u16x8) struct { types.u16x8, types.u16x8 } {
    return .{ vuzp1q_u16(a, b), vuzp2q_u16(a, b) };
}

test vuzpq_u16 {
    const a = types.u16x8{ 1, 2, 3, 4, 5, 6, 7, 8 };
    const b = types.u16x8{ 101, 102, 103, 104, 105, 106, 107, 108 };
    const res = vuzpq_u16(a, b);
    try std.testing.expectEqual(vuzp1q_u16(a, b), res[0]);
    try std.testing.expectEqual(vuzp2q_u16(a, b), res[1]);
}

/// Interleave / unzip vector elements returning a pair of vectors
pub inline fn vuzpq_u32(a: types.u32x4, b: types.u32x4) struct { types.u32x4, types.u32x4 } {
    return .{ vuzp1q_u32(a, b), vuzp2q_u32(a, b) };
}

test vuzpq_u32 {
    const a = types.u32x4{ 1, 2, 3, 4 };
    const b = types.u32x4{ 101, 102, 103, 104 };
    const res = vuzpq_u32(a, b);
    try std.testing.expectEqual(vuzp1q_u32(a, b), res[0]);
    try std.testing.expectEqual(vuzp2q_u32(a, b), res[1]);
}

/// Interleave / unzip vector elements returning a pair of vectors
pub inline fn vuzpq_u64(a: types.u64x2, b: types.u64x2) struct { types.u64x2, types.u64x2 } {
    return .{ vuzp1q_u64(a, b), vuzp2q_u64(a, b) };
}

test vuzpq_u64 {
    const a = types.u64x2{ 1, 2 };
    const b = types.u64x2{ 101, 102 };
    const res = vuzpq_u64(a, b);
    try std.testing.expectEqual(vuzp1q_u64(a, b), res[0]);
    try std.testing.expectEqual(vuzp2q_u64(a, b), res[1]);
}

/// Interleave / unzip vector elements returning a pair of vectors
pub inline fn vuzpq_p8(a: types.p8x16, b: types.p8x16) struct { types.p8x16, types.p8x16 } {
    return .{ vuzp1q_p8(a, b), vuzp2q_p8(a, b) };
}

test vuzpq_p8 {
    const a = types.p8x16{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 };
    const b = types.p8x16{ 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116 };
    const res = vuzpq_p8(a, b);
    try std.testing.expectEqual(vuzp1q_p8(a, b), res[0]);
    try std.testing.expectEqual(vuzp2q_p8(a, b), res[1]);
}

/// Interleave / unzip vector elements returning a pair of vectors
pub inline fn vuzpq_p16(a: types.p16x8, b: types.p16x8) struct { types.p16x8, types.p16x8 } {
    return .{ vuzp1q_p16(a, b), vuzp2q_p16(a, b) };
}

test vuzpq_p16 {
    const a = types.p16x8{ 1, 2, 3, 4, 5, 6, 7, 8 };
    const b = types.p16x8{ 101, 102, 103, 104, 105, 106, 107, 108 };
    const res = vuzpq_p16(a, b);
    try std.testing.expectEqual(vuzp1q_p16(a, b), res[0]);
    try std.testing.expectEqual(vuzp2q_p16(a, b), res[1]);
}

/// Interleave / unzip vector elements returning a pair of vectors
pub inline fn vuzpq_p64(a: types.p64x2, b: types.p64x2) struct { types.p64x2, types.p64x2 } {
    return .{ vuzp1q_p64(a, b), vuzp2q_p64(a, b) };
}

test vuzpq_p64 {
    const a = types.p64x2{ 1, 2 };
    const b = types.p64x2{ 101, 102 };
    const res = vuzpq_p64(a, b);
    try std.testing.expectEqual(vuzp1q_p64(a, b), res[0]);
    try std.testing.expectEqual(vuzp2q_p64(a, b), res[1]);
}

/// Interleave / unzip vector elements returning a pair of vectors
pub inline fn vuzpq_f16(a: types.f16x8, b: types.f16x8) struct { types.f16x8, types.f16x8 } {
    return .{ vuzp1q_f16(a, b), vuzp2q_f16(a, b) };
}

test vuzpq_f16 {
    const a = types.f16x8{ 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0 };
    const b = types.f16x8{ 101.0, 102.0, 103.0, 104.0, 105.0, 106.0, 107.0, 108.0 };
    const res = vuzpq_f16(a, b);
    try std.testing.expectEqual(vuzp1q_f16(a, b), res[0]);
    try std.testing.expectEqual(vuzp2q_f16(a, b), res[1]);
}

/// Interleave / unzip vector elements returning a pair of vectors
pub inline fn vuzpq_f32(a: types.f32x4, b: types.f32x4) struct { types.f32x4, types.f32x4 } {
    return .{ vuzp1q_f32(a, b), vuzp2q_f32(a, b) };
}

test vuzpq_f32 {
    const a = types.f32x4{ 1.0, 2.0, 3.0, 4.0 };
    const b = types.f32x4{ 101.0, 102.0, 103.0, 104.0 };
    const res = vuzpq_f32(a, b);
    try std.testing.expectEqual(vuzp1q_f32(a, b), res[0]);
    try std.testing.expectEqual(vuzp2q_f32(a, b), res[1]);
}

/// Interleave / unzip vector elements returning a pair of vectors
pub inline fn vuzpq_f64(a: types.f64x2, b: types.f64x2) struct { types.f64x2, types.f64x2 } {
    return .{ vuzp1q_f64(a, b), vuzp2q_f64(a, b) };
}

test vuzpq_f64 {
    const a = types.f64x2{ 1.0, 2.0 };
    const b = types.f64x2{ 101.0, 102.0 };
    const res = vuzpq_f64(a, b);
    try std.testing.expectEqual(vuzp1q_f64(a, b), res[0]);
    try std.testing.expectEqual(vuzp2q_f64(a, b), res[1]);
}

/// Interleave / unzip vector elements returning a pair of vectors
pub inline fn vtrn_s8(a: types.i8x8, b: types.i8x8) struct { types.i8x8, types.i8x8 } {
    return .{ vtrn1_s8(a, b), vtrn2_s8(a, b) };
}

test vtrn_s8 {
    const a = types.i8x8{ 1, 2, 3, 4, 5, 6, 7, 8 };
    const b = types.i8x8{ 101, 102, 103, 104, 105, 106, 107, 108 };
    const res = vtrn_s8(a, b);
    try std.testing.expectEqual(vtrn1_s8(a, b), res[0]);
    try std.testing.expectEqual(vtrn2_s8(a, b), res[1]);
}

/// Interleave / unzip vector elements returning a pair of vectors
pub inline fn vtrn_s16(a: types.i16x4, b: types.i16x4) struct { types.i16x4, types.i16x4 } {
    return .{ vtrn1_s16(a, b), vtrn2_s16(a, b) };
}

test vtrn_s16 {
    const a = types.i16x4{ 1, 2, 3, 4 };
    const b = types.i16x4{ 101, 102, 103, 104 };
    const res = vtrn_s16(a, b);
    try std.testing.expectEqual(vtrn1_s16(a, b), res[0]);
    try std.testing.expectEqual(vtrn2_s16(a, b), res[1]);
}

/// Interleave / unzip vector elements returning a pair of vectors
pub inline fn vtrn_s32(a: types.i32x2, b: types.i32x2) struct { types.i32x2, types.i32x2 } {
    return .{ vtrn1_s32(a, b), vtrn2_s32(a, b) };
}

test vtrn_s32 {
    const a = types.i32x2{ 1, 2 };
    const b = types.i32x2{ 101, 102 };
    const res = vtrn_s32(a, b);
    try std.testing.expectEqual(vtrn1_s32(a, b), res[0]);
    try std.testing.expectEqual(vtrn2_s32(a, b), res[1]);
}

/// Interleave / unzip vector elements returning a pair of vectors
pub inline fn vtrn_u8(a: types.u8x8, b: types.u8x8) struct { types.u8x8, types.u8x8 } {
    return .{ vtrn1_u8(a, b), vtrn2_u8(a, b) };
}

test vtrn_u8 {
    const a = types.u8x8{ 1, 2, 3, 4, 5, 6, 7, 8 };
    const b = types.u8x8{ 101, 102, 103, 104, 105, 106, 107, 108 };
    const res = vtrn_u8(a, b);
    try std.testing.expectEqual(vtrn1_u8(a, b), res[0]);
    try std.testing.expectEqual(vtrn2_u8(a, b), res[1]);
}

/// Interleave / unzip vector elements returning a pair of vectors
pub inline fn vtrn_u16(a: types.u16x4, b: types.u16x4) struct { types.u16x4, types.u16x4 } {
    return .{ vtrn1_u16(a, b), vtrn2_u16(a, b) };
}

test vtrn_u16 {
    const a = types.u16x4{ 1, 2, 3, 4 };
    const b = types.u16x4{ 101, 102, 103, 104 };
    const res = vtrn_u16(a, b);
    try std.testing.expectEqual(vtrn1_u16(a, b), res[0]);
    try std.testing.expectEqual(vtrn2_u16(a, b), res[1]);
}

/// Interleave / unzip vector elements returning a pair of vectors
pub inline fn vtrn_u32(a: types.u32x2, b: types.u32x2) struct { types.u32x2, types.u32x2 } {
    return .{ vtrn1_u32(a, b), vtrn2_u32(a, b) };
}

test vtrn_u32 {
    const a = types.u32x2{ 1, 2 };
    const b = types.u32x2{ 101, 102 };
    const res = vtrn_u32(a, b);
    try std.testing.expectEqual(vtrn1_u32(a, b), res[0]);
    try std.testing.expectEqual(vtrn2_u32(a, b), res[1]);
}

/// Interleave / unzip vector elements returning a pair of vectors
pub inline fn vtrn_p8(a: types.p8x8, b: types.p8x8) struct { types.p8x8, types.p8x8 } {
    return .{ vtrn1_p8(a, b), vtrn2_p8(a, b) };
}

test vtrn_p8 {
    const a = types.p8x8{ 1, 2, 3, 4, 5, 6, 7, 8 };
    const b = types.p8x8{ 101, 102, 103, 104, 105, 106, 107, 108 };
    const res = vtrn_p8(a, b);
    try std.testing.expectEqual(vtrn1_p8(a, b), res[0]);
    try std.testing.expectEqual(vtrn2_p8(a, b), res[1]);
}

/// Interleave / unzip vector elements returning a pair of vectors
pub inline fn vtrn_p16(a: types.p16x4, b: types.p16x4) struct { types.p16x4, types.p16x4 } {
    return .{ vtrn1_p16(a, b), vtrn2_p16(a, b) };
}

test vtrn_p16 {
    const a = types.p16x4{ 1, 2, 3, 4 };
    const b = types.p16x4{ 101, 102, 103, 104 };
    const res = vtrn_p16(a, b);
    try std.testing.expectEqual(vtrn1_p16(a, b), res[0]);
    try std.testing.expectEqual(vtrn2_p16(a, b), res[1]);
}

/// Interleave / unzip vector elements returning a pair of vectors
pub inline fn vtrn_f16(a: types.f16x4, b: types.f16x4) struct { types.f16x4, types.f16x4 } {
    return .{ vtrn1_f16(a, b), vtrn2_f16(a, b) };
}

test vtrn_f16 {
    const a = types.f16x4{ 1.0, 2.0, 3.0, 4.0 };
    const b = types.f16x4{ 101.0, 102.0, 103.0, 104.0 };
    const res = vtrn_f16(a, b);
    try std.testing.expectEqual(vtrn1_f16(a, b), res[0]);
    try std.testing.expectEqual(vtrn2_f16(a, b), res[1]);
}

/// Interleave / unzip vector elements returning a pair of vectors
pub inline fn vtrn_f32(a: types.f32x2, b: types.f32x2) struct { types.f32x2, types.f32x2 } {
    return .{ vtrn1_f32(a, b), vtrn2_f32(a, b) };
}

test vtrn_f32 {
    const a = types.f32x2{ 1.0, 2.0 };
    const b = types.f32x2{ 101.0, 102.0 };
    const res = vtrn_f32(a, b);
    try std.testing.expectEqual(vtrn1_f32(a, b), res[0]);
    try std.testing.expectEqual(vtrn2_f32(a, b), res[1]);
}

/// Interleave / unzip vector elements returning a pair of vectors
pub inline fn vtrnq_s64(a: types.i64x2, b: types.i64x2) struct { types.i64x2, types.i64x2 } {
    return .{ vtrn1q_s64(a, b), vtrn2q_s64(a, b) };
}

test vtrnq_s64 {
    const a = types.i64x2{ 1, 2 };
    const b = types.i64x2{ 101, 102 };
    const res = vtrnq_s64(a, b);
    try std.testing.expectEqual(vtrn1q_s64(a, b), res[0]);
    try std.testing.expectEqual(vtrn2q_s64(a, b), res[1]);
}

/// Interleave / unzip vector elements returning a pair of vectors
pub inline fn vtrnq_u64(a: types.u64x2, b: types.u64x2) struct { types.u64x2, types.u64x2 } {
    return .{ vtrn1q_u64(a, b), vtrn2q_u64(a, b) };
}

test vtrnq_u64 {
    const a = types.u64x2{ 1, 2 };
    const b = types.u64x2{ 101, 102 };
    const res = vtrnq_u64(a, b);
    try std.testing.expectEqual(vtrn1q_u64(a, b), res[0]);
    try std.testing.expectEqual(vtrn2q_u64(a, b), res[1]);
}

/// Interleave / unzip vector elements returning a pair of vectors
pub inline fn vtrnq_p64(a: types.p64x2, b: types.p64x2) struct { types.p64x2, types.p64x2 } {
    return .{ vtrn1q_p64(a, b), vtrn2q_p64(a, b) };
}

test vtrnq_p64 {
    const a = types.p64x2{ 1, 2 };
    const b = types.p64x2{ 101, 102 };
    const res = vtrnq_p64(a, b);
    try std.testing.expectEqual(vtrn1q_p64(a, b), res[0]);
    try std.testing.expectEqual(vtrn2q_p64(a, b), res[1]);
}

/// Interleave / unzip vector elements returning a pair of vectors
pub inline fn vtrnq_f16(a: types.f16x8, b: types.f16x8) struct { types.f16x8, types.f16x8 } {
    return .{ vtrn1q_f16(a, b), vtrn2q_f16(a, b) };
}

test vtrnq_f16 {
    const a = types.f16x8{ 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0 };
    const b = types.f16x8{ 101.0, 102.0, 103.0, 104.0, 105.0, 106.0, 107.0, 108.0 };
    const res = vtrnq_f16(a, b);
    try std.testing.expectEqual(vtrn1q_f16(a, b), res[0]);
    try std.testing.expectEqual(vtrn2q_f16(a, b), res[1]);
}

/// Interleave / unzip vector elements returning a pair of vectors
pub inline fn vtrnq_f64(a: types.f64x2, b: types.f64x2) struct { types.f64x2, types.f64x2 } {
    return .{ vtrn1q_f64(a, b), vtrn2q_f64(a, b) };
}

test vtrnq_f64 {
    const a = types.f64x2{ 1.0, 2.0 };
    const b = types.f64x2{ 101.0, 102.0 };
    const res = vtrnq_f64(a, b);
    try std.testing.expectEqual(vtrn1q_f64(a, b), res[0]);
    try std.testing.expectEqual(vtrn2q_f64(a, b), res[1]);
}

/// Saturating vector narrowing
pub inline fn vqmovn_s16(a: types.i16x8) types.i8x8 {
    var res: types.i8x8 = undefined;
    inline for (0..8) |i| {
        res[i] = @intCast(std.math.clamp(a[i], std.math.minInt(i8), std.math.maxInt(i8)));
    }
    return res;
}

test vqmovn_s16 {
    const a = types.i16x8{ -30000, -129, -50, 0, 42, 127, 128, 30000 };
    const expected = types.i8x8{ -128, -128, -50, 0, 42, 127, 127, 127 };
    try common.testIntrinsic(.{ .func = vqmovn_s16, .expected = expected, .args = .{a} });
}

/// Saturating vector narrowing into upper half
pub inline fn vqmovn_high_s16(r: types.i8x8, a: types.i16x8) types.i8x16 {
    const high = vqmovn_s16(a);
    var res: types.i8x16 = undefined;
    inline for (0..8) |i| {
        res[i] = r[i];
        res[i + 8] = high[i];
    }
    return res;
}

test vqmovn_high_s16 {
    const r = @as(types.i8x8, @splat(1));
    const a = @as(types.i16x8, @splat(2));
    var expected: types.i8x16 = undefined;
    inline for (0..8) |i| {
        expected[i] = 1;
        expected[i + 8] = 2;
    }
    try common.testIntrinsic(.{ .func = vqmovn_high_s16, .expected = expected, .args = .{ r, a } });
}

/// Saturating vector narrowing
pub inline fn vqmovn_s32(a: types.i32x4) types.i16x4 {
    var res: types.i16x4 = undefined;
    inline for (0..4) |i| {
        res[i] = @intCast(std.math.clamp(a[i], std.math.minInt(i16), std.math.maxInt(i16)));
    }
    return res;
}

test vqmovn_s32 {
    const a = types.i32x4{ -30000, -129, -50, 0 };
    const expected = types.i16x4{ -30000, -129, -50, 0 };
    try common.testIntrinsic(.{ .func = vqmovn_s32, .expected = expected, .args = .{a} });
}

/// Saturating vector narrowing into upper half
pub inline fn vqmovn_high_s32(r: types.i16x4, a: types.i32x4) types.i16x8 {
    const high = vqmovn_s32(a);
    var res: types.i16x8 = undefined;
    inline for (0..4) |i| {
        res[i] = r[i];
        res[i + 4] = high[i];
    }
    return res;
}

test vqmovn_high_s32 {
    const r = @as(types.i16x4, @splat(1));
    const a = @as(types.i32x4, @splat(2));
    var expected: types.i16x8 = undefined;
    inline for (0..4) |i| {
        expected[i] = 1;
        expected[i + 4] = 2;
    }
    try common.testIntrinsic(.{ .func = vqmovn_high_s32, .expected = expected, .args = .{ r, a } });
}

/// Saturating vector narrowing
pub inline fn vqmovn_s64(a: types.i64x2) types.i32x2 {
    var res: types.i32x2 = undefined;
    inline for (0..2) |i| {
        res[i] = @intCast(std.math.clamp(a[i], std.math.minInt(i32), std.math.maxInt(i32)));
    }
    return res;
}

test vqmovn_s64 {
    const a = types.i64x2{ -30000, -129 };
    const expected = types.i32x2{ -30000, -129 };
    try common.testIntrinsic(.{ .func = vqmovn_s64, .expected = expected, .args = .{a} });
}

/// Saturating vector narrowing into upper half
pub inline fn vqmovn_high_s64(r: types.i32x2, a: types.i64x2) types.i32x4 {
    const high = vqmovn_s64(a);
    var res: types.i32x4 = undefined;
    inline for (0..2) |i| {
        res[i] = r[i];
        res[i + 2] = high[i];
    }
    return res;
}

test vqmovn_high_s64 {
    const r = @as(types.i32x2, @splat(1));
    const a = @as(types.i64x2, @splat(2));
    var expected: types.i32x4 = undefined;
    inline for (0..2) |i| {
        expected[i] = 1;
        expected[i + 2] = 2;
    }
    try common.testIntrinsic(.{ .func = vqmovn_high_s64, .expected = expected, .args = .{ r, a } });
}

/// Saturating vector narrowing
pub inline fn vqmovn_u16(a: types.u16x8) types.u8x8 {
    var res: types.u8x8 = undefined;
    inline for (0..8) |i| {
        res[i] = @intCast(std.math.clamp(a[i], std.math.minInt(u8), std.math.maxInt(u8)));
    }
    return res;
}

test vqmovn_u16 {
    const a = types.u16x8{ 0, 50, 127, 255, 256, 1000, 40000, 65535 };
    const expected = types.u8x8{ 0, 50, 127, 255, 255, 255, 255, 255 };
    try common.testIntrinsic(.{ .func = vqmovn_u16, .expected = expected, .args = .{a} });
}

/// Saturating vector narrowing into upper half
pub inline fn vqmovn_high_u16(r: types.u8x8, a: types.u16x8) types.u8x16 {
    const high = vqmovn_u16(a);
    var res: types.u8x16 = undefined;
    inline for (0..8) |i| {
        res[i] = r[i];
        res[i + 8] = high[i];
    }
    return res;
}

test vqmovn_high_u16 {
    const r = @as(types.u8x8, @splat(1));
    const a = @as(types.u16x8, @splat(2));
    var expected: types.u8x16 = undefined;
    inline for (0..8) |i| {
        expected[i] = 1;
        expected[i + 8] = 2;
    }
    try common.testIntrinsic(.{ .func = vqmovn_high_u16, .expected = expected, .args = .{ r, a } });
}

/// Saturating vector narrowing
pub inline fn vqmovn_u32(a: types.u32x4) types.u16x4 {
    var res: types.u16x4 = undefined;
    inline for (0..4) |i| {
        res[i] = @intCast(std.math.clamp(a[i], std.math.minInt(u16), std.math.maxInt(u16)));
    }
    return res;
}

test vqmovn_u32 {
    const a = types.u32x4{ 0, 50, 127, 255 };
    const expected = types.u16x4{ 0, 50, 127, 255 };
    try common.testIntrinsic(.{ .func = vqmovn_u32, .expected = expected, .args = .{a} });
}

/// Saturating vector narrowing into upper half
pub inline fn vqmovn_high_u32(r: types.u16x4, a: types.u32x4) types.u16x8 {
    const high = vqmovn_u32(a);
    var res: types.u16x8 = undefined;
    inline for (0..4) |i| {
        res[i] = r[i];
        res[i + 4] = high[i];
    }
    return res;
}

test vqmovn_high_u32 {
    const r = @as(types.u16x4, @splat(1));
    const a = @as(types.u32x4, @splat(2));
    var expected: types.u16x8 = undefined;
    inline for (0..4) |i| {
        expected[i] = 1;
        expected[i + 4] = 2;
    }
    try common.testIntrinsic(.{ .func = vqmovn_high_u32, .expected = expected, .args = .{ r, a } });
}

/// Saturating vector narrowing
pub inline fn vqmovn_u64(a: types.u64x2) types.u32x2 {
    var res: types.u32x2 = undefined;
    inline for (0..2) |i| {
        res[i] = @intCast(std.math.clamp(a[i], std.math.minInt(u32), std.math.maxInt(u32)));
    }
    return res;
}

test vqmovn_u64 {
    const a = types.u64x2{ 0, 50 };
    const expected = types.u32x2{ 0, 50 };
    try common.testIntrinsic(.{ .func = vqmovn_u64, .expected = expected, .args = .{a} });
}

/// Saturating vector narrowing into upper half
pub inline fn vqmovn_high_u64(r: types.u32x2, a: types.u64x2) types.u32x4 {
    const high = vqmovn_u64(a);
    var res: types.u32x4 = undefined;
    inline for (0..2) |i| {
        res[i] = r[i];
        res[i + 2] = high[i];
    }
    return res;
}

test vqmovn_high_u64 {
    const r = @as(types.u32x2, @splat(1));
    const a = @as(types.u64x2, @splat(2));
    var expected: types.u32x4 = undefined;
    inline for (0..2) |i| {
        expected[i] = 1;
        expected[i + 2] = 2;
    }
    try common.testIntrinsic(.{ .func = vqmovn_high_u64, .expected = expected, .args = .{ r, a } });
}

/// Signed to unsigned saturating vector narrowing
pub inline fn vqmovun_s16(a: types.i16x8) types.u8x8 {
    var res: types.u8x8 = undefined;
    inline for (0..8) |i| {
        res[i] = @intCast(std.math.clamp(a[i], 0, std.math.maxInt(u8)));
    }
    return res;
}

test vqmovun_s16 {
    const a = types.i16x8{ -30000, -129, -50, 0, 42, 127, 255, 30000 };
    const expected = types.u8x8{ 0, 0, 0, 0, 42, 127, 255, 255 };
    try common.testIntrinsic(.{ .func = vqmovun_s16, .expected = expected, .args = .{a} });
}

/// Signed to unsigned saturating vector narrowing into upper half
pub inline fn vqmovun_high_s16(r: types.u8x8, a: types.i16x8) types.u8x16 {
    const high = vqmovun_s16(a);
    var res: types.u8x16 = undefined;
    inline for (0..8) |i| {
        res[i] = r[i];
        res[i + 8] = high[i];
    }
    return res;
}

test vqmovun_high_s16 {
    const r = @as(types.u8x8, @splat(1));
    const a = @as(types.i16x8, @splat(2));
    const res = vqmovun_high_s16(r, a);
    try std.testing.expect(res[0] != 0);
}

/// Signed to unsigned saturating vector narrowing
pub inline fn vqmovun_s32(a: types.i32x4) types.u16x4 {
    var res: types.u16x4 = undefined;
    inline for (0..4) |i| {
        res[i] = @intCast(std.math.clamp(a[i], 0, std.math.maxInt(u16)));
    }
    return res;
}

test vqmovun_s32 {
    const a = types.i32x4{ -30000, -129, -50, 0 };
    const expected = types.u16x4{ 0, 0, 0, 0 };
    try common.testIntrinsic(.{ .func = vqmovun_s32, .expected = expected, .args = .{a} });
}

/// Signed to unsigned saturating vector narrowing into upper half
pub inline fn vqmovun_high_s32(r: types.u16x4, a: types.i32x4) types.u16x8 {
    const high = vqmovun_s32(a);
    var res: types.u16x8 = undefined;
    inline for (0..4) |i| {
        res[i] = r[i];
        res[i + 4] = high[i];
    }
    return res;
}

test vqmovun_high_s32 {
    const r = @as(types.u16x4, @splat(1));
    const a = @as(types.i32x4, @splat(2));
    const res = vqmovun_high_s32(r, a);
    try std.testing.expect(res[0] != 0);
}

/// Signed to unsigned saturating vector narrowing
pub inline fn vqmovun_s64(a: types.i64x2) types.u32x2 {
    var res: types.u32x2 = undefined;
    inline for (0..2) |i| {
        res[i] = @intCast(std.math.clamp(a[i], 0, std.math.maxInt(u32)));
    }
    return res;
}

test vqmovun_s64 {
    const a = types.i64x2{ -30000, -129 };
    const expected = types.u32x2{ 0, 0 };
    try common.testIntrinsic(.{ .func = vqmovun_s64, .expected = expected, .args = .{a} });
}

/// Signed to unsigned saturating vector narrowing into upper half
pub inline fn vqmovun_high_s64(r: types.u32x2, a: types.i64x2) types.u32x4 {
    const high = vqmovun_s64(a);
    var res: types.u32x4 = undefined;
    inline for (0..2) |i| {
        res[i] = r[i];
        res[i + 2] = high[i];
    }
    return res;
}

test vqmovun_high_s64 {
    const r = @as(types.u32x2, @splat(1));
    const a = @as(types.i64x2, @splat(2));
    const res = vqmovun_high_s64(r, a);
    try std.testing.expect(res[0] != 0);
}

/// Vector narrowing move into upper half
pub inline fn vmovn_high_s16(r: types.i8x8, a: types.i16x8) types.i8x16 {
    const high: types.i8x8 = @truncate(a);
    var res: types.i8x16 = undefined;
    inline for (0..8) |i| {
        res[i] = r[i];
        res[i + 8] = high[i];
    }
    return res;
}

test vmovn_high_s16 {
    const r = @as(types.i8x8, @splat(1));
    const a = @as(types.i16x8, @splat(2));
    const res = vmovn_high_s16(r, a);
    try std.testing.expect(res[0] != 0);
}

/// Vector narrowing move into upper half
pub inline fn vmovn_high_s32(r: types.i16x4, a: types.i32x4) types.i16x8 {
    const high: types.i16x4 = @truncate(a);
    var res: types.i16x8 = undefined;
    inline for (0..4) |i| {
        res[i] = r[i];
        res[i + 4] = high[i];
    }
    return res;
}

test vmovn_high_s32 {
    const r = @as(types.i16x4, @splat(1));
    const a = @as(types.i32x4, @splat(2));
    const res = vmovn_high_s32(r, a);
    try std.testing.expect(res[0] != 0);
}

/// Vector narrowing move into upper half
pub inline fn vmovn_high_s64(r: types.i32x2, a: types.i64x2) types.i32x4 {
    const high: types.i32x2 = @truncate(a);
    var res: types.i32x4 = undefined;
    inline for (0..2) |i| {
        res[i] = r[i];
        res[i + 2] = high[i];
    }
    return res;
}

test vmovn_high_s64 {
    const r = @as(types.i32x2, @splat(1));
    const a = @as(types.i64x2, @splat(2));
    const res = vmovn_high_s64(r, a);
    try std.testing.expect(res[0] != 0);
}

/// Vector narrowing move into upper half
pub inline fn vmovn_high_u16(r: types.u8x8, a: types.u16x8) types.u8x16 {
    const high: types.u8x8 = @truncate(a);
    var res: types.u8x16 = undefined;
    inline for (0..8) |i| {
        res[i] = r[i];
        res[i + 8] = high[i];
    }
    return res;
}

test vmovn_high_u16 {
    const r = @as(types.u8x8, @splat(1));
    const a = @as(types.u16x8, @splat(2));
    const res = vmovn_high_u16(r, a);
    try std.testing.expect(res[0] != 0);
}

/// Vector narrowing move into upper half
pub inline fn vmovn_high_u32(r: types.u16x4, a: types.u32x4) types.u16x8 {
    const high: types.u16x4 = @truncate(a);
    var res: types.u16x8 = undefined;
    inline for (0..4) |i| {
        res[i] = r[i];
        res[i + 4] = high[i];
    }
    return res;
}

test vmovn_high_u32 {
    const r = @as(types.u16x4, @splat(1));
    const a = @as(types.u32x4, @splat(2));
    const res = vmovn_high_u32(r, a);
    try std.testing.expect(res[0] != 0);
}

/// Vector narrowing move into upper half
pub inline fn vmovn_high_u64(r: types.u32x2, a: types.u64x2) types.u32x4 {
    const high: types.u32x2 = @truncate(a);
    var res: types.u32x4 = undefined;
    inline for (0..2) |i| {
        res[i] = r[i];
        res[i + 2] = high[i];
    }
    return res;
}

test vmovn_high_u64 {
    const r = @as(types.u32x2, @splat(1));
    const a = @as(types.u64x2, @splat(2));
    const res = vmovn_high_u64(r, a);
    try std.testing.expect(res[0] != 0);
}

/// ARM NEON intrinsic: vrev64q_f16
pub inline fn vrev64q_f16(p0: types.f16x8) types.f16x8 {
    return .{ p0[3], p0[2], p0[1], p0[0], p0[7], p0[6], p0[5], p0[4] };
}

test vrev64q_f16 {
    const p0 = @as(types.f16x8, @splat(1.5));
    const res = vrev64q_f16(p0);
    try std.testing.expect(res[0] != 0);
}

/// Duplicate scalar into all vector lanes
pub inline fn vdup_n_s8(a: i8) types.i8x8 {
    return @splat(a);
}

test vdup_n_s8 {
    const a: i8 = 42;
    const expected = @as(types.i8x8, @splat(42));
    try common.testIntrinsic(.{ .func = vdup_n_s8, .expected = expected, .args = .{a} });
}

/// Move scalar into all vector lanes (alias for vdup_n)
pub inline fn vmov_n_s8(a: i8) types.i8x8 {
    return @splat(a);
}

test vmov_n_s8 {
    const a: i8 = 42;
    const expected = @as(types.i8x8, @splat(42));
    try common.testIntrinsic(.{ .func = vmov_n_s8, .expected = expected, .args = .{a} });
}

/// Duplicate scalar into all vector lanes
pub inline fn vdup_n_s16(a: i16) types.i16x4 {
    return @splat(a);
}

test vdup_n_s16 {
    const a: i16 = 42;
    const expected = @as(types.i16x4, @splat(42));
    try common.testIntrinsic(.{ .func = vdup_n_s16, .expected = expected, .args = .{a} });
}

/// Move scalar into all vector lanes (alias for vdup_n)
pub inline fn vmov_n_s16(a: i16) types.i16x4 {
    return @splat(a);
}

test vmov_n_s16 {
    const a: i16 = 42;
    const expected = @as(types.i16x4, @splat(42));
    try common.testIntrinsic(.{ .func = vmov_n_s16, .expected = expected, .args = .{a} });
}

/// Duplicate scalar into all vector lanes
pub inline fn vdup_n_s32(a: i32) types.i32x2 {
    return @splat(a);
}

test vdup_n_s32 {
    const a: i32 = 42;
    const expected = @as(types.i32x2, @splat(42));
    try common.testIntrinsic(.{ .func = vdup_n_s32, .expected = expected, .args = .{a} });
}

/// Move scalar into all vector lanes (alias for vdup_n)
pub inline fn vmov_n_s32(a: i32) types.i32x2 {
    return @splat(a);
}

test vmov_n_s32 {
    const a: i32 = 42;
    const expected = @as(types.i32x2, @splat(42));
    try common.testIntrinsic(.{ .func = vmov_n_s32, .expected = expected, .args = .{a} });
}

/// Duplicate scalar into all vector lanes
pub inline fn vdup_n_s64(a: i64) types.i64x1 {
    return @splat(a);
}

test vdup_n_s64 {
    const a: i64 = 42;
    const expected = @as(types.i64x1, @splat(42));
    try common.testIntrinsic(.{ .func = vdup_n_s64, .expected = expected, .args = .{a} });
}

/// Move scalar into all vector lanes (alias for vdup_n)
pub inline fn vmov_n_s64(a: i64) types.i64x1 {
    return @splat(a);
}

test vmov_n_s64 {
    const a: i64 = 42;
    const expected = @as(types.i64x1, @splat(42));
    try common.testIntrinsic(.{ .func = vmov_n_s64, .expected = expected, .args = .{a} });
}

/// Duplicate scalar into all vector lanes
pub inline fn vdup_n_u8(a: u8) types.u8x8 {
    return @splat(a);
}

test vdup_n_u8 {
    const a: u8 = 42;
    const expected = @as(types.u8x8, @splat(42));
    try common.testIntrinsic(.{ .func = vdup_n_u8, .expected = expected, .args = .{a} });
}

/// Move scalar into all vector lanes (alias for vdup_n)
pub inline fn vmov_n_u8(a: u8) types.u8x8 {
    return @splat(a);
}

test vmov_n_u8 {
    const a: u8 = 42;
    const expected = @as(types.u8x8, @splat(42));
    try common.testIntrinsic(.{ .func = vmov_n_u8, .expected = expected, .args = .{a} });
}

/// Duplicate scalar into all vector lanes
pub inline fn vdup_n_u16(a: u16) types.u16x4 {
    return @splat(a);
}

test vdup_n_u16 {
    const a: u16 = 42;
    const expected = @as(types.u16x4, @splat(42));
    try common.testIntrinsic(.{ .func = vdup_n_u16, .expected = expected, .args = .{a} });
}

/// Move scalar into all vector lanes (alias for vdup_n)
pub inline fn vmov_n_u16(a: u16) types.u16x4 {
    return @splat(a);
}

test vmov_n_u16 {
    const a: u16 = 42;
    const expected = @as(types.u16x4, @splat(42));
    try common.testIntrinsic(.{ .func = vmov_n_u16, .expected = expected, .args = .{a} });
}

/// Duplicate scalar into all vector lanes
pub inline fn vdup_n_u32(a: u32) types.u32x2 {
    return @splat(a);
}

test vdup_n_u32 {
    const a: u32 = 42;
    const expected = @as(types.u32x2, @splat(42));
    try common.testIntrinsic(.{ .func = vdup_n_u32, .expected = expected, .args = .{a} });
}

/// Move scalar into all vector lanes (alias for vdup_n)
pub inline fn vmov_n_u32(a: u32) types.u32x2 {
    return @splat(a);
}

test vmov_n_u32 {
    const a: u32 = 42;
    const expected = @as(types.u32x2, @splat(42));
    try common.testIntrinsic(.{ .func = vmov_n_u32, .expected = expected, .args = .{a} });
}

/// Duplicate scalar into all vector lanes
pub inline fn vdup_n_u64(a: u64) types.u64x1 {
    return @splat(a);
}

test vdup_n_u64 {
    const a: u64 = 42;
    const expected = @as(types.u64x1, @splat(42));
    try common.testIntrinsic(.{ .func = vdup_n_u64, .expected = expected, .args = .{a} });
}

/// Move scalar into all vector lanes (alias for vdup_n)
pub inline fn vmov_n_u64(a: u64) types.u64x1 {
    return @splat(a);
}

test vmov_n_u64 {
    const a: u64 = 42;
    const expected = @as(types.u64x1, @splat(42));
    try common.testIntrinsic(.{ .func = vmov_n_u64, .expected = expected, .args = .{a} });
}

/// Duplicate scalar into all vector lanes
pub inline fn vdup_n_p8(a: u8) types.p8x8 {
    return @splat(a);
}

test vdup_n_p8 {
    const a: u8 = 42;
    const expected = @as(types.p8x8, @splat(42));
    try common.testIntrinsic(.{ .func = vdup_n_p8, .expected = expected, .args = .{a} });
}

/// Move scalar into all vector lanes (alias for vdup_n)
pub inline fn vmov_n_p8(a: u8) types.p8x8 {
    return @splat(a);
}

test vmov_n_p8 {
    const a: u8 = 42;
    const expected = @as(types.p8x8, @splat(42));
    try common.testIntrinsic(.{ .func = vmov_n_p8, .expected = expected, .args = .{a} });
}

/// Duplicate scalar into all vector lanes
pub inline fn vdup_n_p16(a: u16) types.p16x4 {
    return @splat(a);
}

test vdup_n_p16 {
    const a: u16 = 42;
    const expected = @as(types.p16x4, @splat(42));
    try common.testIntrinsic(.{ .func = vdup_n_p16, .expected = expected, .args = .{a} });
}

/// Move scalar into all vector lanes (alias for vdup_n)
pub inline fn vmov_n_p16(a: u16) types.p16x4 {
    return @splat(a);
}

test vmov_n_p16 {
    const a: u16 = 42;
    const expected = @as(types.p16x4, @splat(42));
    try common.testIntrinsic(.{ .func = vmov_n_p16, .expected = expected, .args = .{a} });
}

/// Duplicate scalar into all vector lanes
pub inline fn vdup_n_p64(a: u64) types.p64x1 {
    return @splat(a);
}

test vdup_n_p64 {
    const a: u64 = 42;
    const expected = @as(types.p64x1, @splat(42));
    try common.testIntrinsic(.{ .func = vdup_n_p64, .expected = expected, .args = .{a} });
}

/// Move scalar into all vector lanes (alias for vdup_n)
pub inline fn vmov_n_p64(a: u64) types.p64x1 {
    return @splat(a);
}

test vmov_n_p64 {
    const a: u64 = 42;
    const expected = @as(types.p64x1, @splat(42));
    try common.testIntrinsic(.{ .func = vmov_n_p64, .expected = expected, .args = .{a} });
}

/// Duplicate scalar into all vector lanes
pub inline fn vdup_n_f32(a: f32) types.f32x2 {
    return @splat(a);
}

test vdup_n_f32 {
    const a: f32 = 1.5;
    const expected = @as(types.f32x2, @splat(1.5));
    try common.testIntrinsic(.{ .func = vdup_n_f32, .expected = expected, .args = .{a} });
}

/// Move scalar into all vector lanes (alias for vdup_n)
pub inline fn vmov_n_f32(a: f32) types.f32x2 {
    return @splat(a);
}

test vmov_n_f32 {
    const a: f32 = 1.5;
    const expected = @as(types.f32x2, @splat(1.5));
    try common.testIntrinsic(.{ .func = vmov_n_f32, .expected = expected, .args = .{a} });
}

/// Duplicate scalar into all vector lanes
pub inline fn vdup_n_f64(a: f64) types.f64x1 {
    return @splat(a);
}

test vdup_n_f64 {
    const a: f64 = 1.5;
    const expected = @as(types.f64x1, @splat(1.5));
    try common.testIntrinsic(.{ .func = vdup_n_f64, .expected = expected, .args = .{a} });
}

/// Move scalar into all vector lanes (alias for vdup_n)
pub inline fn vmov_n_f64(a: f64) types.f64x1 {
    return @splat(a);
}

test vmov_n_f64 {
    const a: f64 = 1.5;
    const expected = @as(types.f64x1, @splat(1.5));
    try common.testIntrinsic(.{ .func = vmov_n_f64, .expected = expected, .args = .{a} });
}

/// Narrowing move (truncate high bits)
pub inline fn vmovn_s16(a: types.i16x8) types.i8x8 {
    return @truncate(a);
}

test vmovn_s16 {
    const a = @as(types.i16x8, @splat(10));
    const expected = @as(types.i8x8, @splat(10));
    try common.testIntrinsic(.{ .func = vmovn_s16, .expected = expected, .args = .{a} });
}

/// Narrowing move (truncate high bits)
pub inline fn vmovn_s32(a: types.i32x4) types.i16x4 {
    return @truncate(a);
}

test vmovn_s32 {
    const a = @as(types.i32x4, @splat(10));
    const expected = @as(types.i16x4, @splat(10));
    try common.testIntrinsic(.{ .func = vmovn_s32, .expected = expected, .args = .{a} });
}

/// Narrowing move (truncate high bits)
pub inline fn vmovn_s64(a: types.i64x2) types.i32x2 {
    return @truncate(a);
}

test vmovn_s64 {
    const a = @as(types.i64x2, @splat(10));
    const expected = @as(types.i32x2, @splat(10));
    try common.testIntrinsic(.{ .func = vmovn_s64, .expected = expected, .args = .{a} });
}

/// Narrowing move (truncate high bits)
pub inline fn vmovn_u16(a: types.u16x8) types.u8x8 {
    return @truncate(a);
}

test vmovn_u16 {
    const a = @as(types.u16x8, @splat(10));
    const expected = @as(types.u8x8, @splat(10));
    try common.testIntrinsic(.{ .func = vmovn_u16, .expected = expected, .args = .{a} });
}

/// Narrowing move (truncate high bits)
pub inline fn vmovn_u32(a: types.u32x4) types.u16x4 {
    return @truncate(a);
}

test vmovn_u32 {
    const a = @as(types.u32x4, @splat(10));
    const expected = @as(types.u16x4, @splat(10));
    try common.testIntrinsic(.{ .func = vmovn_u32, .expected = expected, .args = .{a} });
}

/// Narrowing move (truncate high bits)
pub inline fn vmovn_u64(a: types.u64x2) types.u32x2 {
    return @truncate(a);
}

test vmovn_u64 {
    const a = @as(types.u64x2, @splat(10));
    const expected = @as(types.u32x2, @splat(10));
    try common.testIntrinsic(.{ .func = vmovn_u64, .expected = expected, .args = .{a} });
}

/// Reverse elements in 16-bit halfwords
pub inline fn vrev16_s8(a: types.i8x8) types.i8x8 {
    return .{ a[1], a[0], a[3], a[2], a[5], a[4], a[7], a[6] };
}

test vrev16_s8 {
    const a = types.i8x8{ 1, 2, 3, 4, 5, 6, 7, 8 };
    const expected = types.i8x8{ 2, 1, 4, 3, 6, 5, 8, 7 };
    try common.testIntrinsic(.{ .func = vrev16_s8, .expected = expected, .args = .{a} });
}

/// Reverse elements in 16-bit halfwords
pub inline fn vrev16q_s8(a: types.i8x16) types.i8x16 {
    return .{ a[1], a[0], a[3], a[2], a[5], a[4], a[7], a[6], a[9], a[8], a[11], a[10], a[13], a[12], a[15], a[14] };
}

test vrev16q_s8 {
    const a = types.i8x16{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 };
    const expected = types.i8x16{ 2, 1, 4, 3, 6, 5, 8, 7, 10, 9, 12, 11, 14, 13, 16, 15 };
    try common.testIntrinsic(.{ .func = vrev16q_s8, .expected = expected, .args = .{a} });
}

/// Reverse elements in 16-bit halfwords
pub inline fn vrev16_u8(a: types.u8x8) types.u8x8 {
    return .{ a[1], a[0], a[3], a[2], a[5], a[4], a[7], a[6] };
}

test vrev16_u8 {
    const a = types.u8x8{ 1, 2, 3, 4, 5, 6, 7, 8 };
    const expected = types.u8x8{ 2, 1, 4, 3, 6, 5, 8, 7 };
    try common.testIntrinsic(.{ .func = vrev16_u8, .expected = expected, .args = .{a} });
}

/// Reverse elements in 16-bit halfwords
pub inline fn vrev16q_u8(a: types.u8x16) types.u8x16 {
    return .{ a[1], a[0], a[3], a[2], a[5], a[4], a[7], a[6], a[9], a[8], a[11], a[10], a[13], a[12], a[15], a[14] };
}

test vrev16q_u8 {
    const a = types.u8x16{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 };
    const expected = types.u8x16{ 2, 1, 4, 3, 6, 5, 8, 7, 10, 9, 12, 11, 14, 13, 16, 15 };
    try common.testIntrinsic(.{ .func = vrev16q_u8, .expected = expected, .args = .{a} });
}

/// Reverse elements in 16-bit halfwords
pub inline fn vrev16_p8(a: types.p8x8) types.p8x8 {
    return .{ a[1], a[0], a[3], a[2], a[5], a[4], a[7], a[6] };
}

test vrev16_p8 {
    const a = types.p8x8{ 1, 2, 3, 4, 5, 6, 7, 8 };
    const expected = types.p8x8{ 2, 1, 4, 3, 6, 5, 8, 7 };
    try common.testIntrinsic(.{ .func = vrev16_p8, .expected = expected, .args = .{a} });
}

/// Reverse elements in 16-bit halfwords
pub inline fn vrev16q_p8(a: types.p8x16) types.p8x16 {
    return .{ a[1], a[0], a[3], a[2], a[5], a[4], a[7], a[6], a[9], a[8], a[11], a[10], a[13], a[12], a[15], a[14] };
}

test vrev16q_p8 {
    const a = types.p8x16{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 };
    const expected = types.p8x16{ 2, 1, 4, 3, 6, 5, 8, 7, 10, 9, 12, 11, 14, 13, 16, 15 };
    try common.testIntrinsic(.{ .func = vrev16q_p8, .expected = expected, .args = .{a} });
}

/// Reverse elements in 32-bit words
pub inline fn vrev32_s8(a: types.i8x8) types.i8x8 {
    return .{ a[3], a[2], a[1], a[0], a[7], a[6], a[5], a[4] };
}

test vrev32_s8 {
    const a = types.i8x8{ 1, 2, 3, 4, 5, 6, 7, 8 };
    const expected = types.i8x8{ 4, 3, 2, 1, 8, 7, 6, 5 };
    try common.testIntrinsic(.{ .func = vrev32_s8, .expected = expected, .args = .{a} });
}

/// Reverse elements in 32-bit words
pub inline fn vrev32q_s8(a: types.i8x16) types.i8x16 {
    return .{ a[3], a[2], a[1], a[0], a[7], a[6], a[5], a[4], a[11], a[10], a[9], a[8], a[15], a[14], a[13], a[12] };
}

test vrev32q_s8 {
    const a = types.i8x16{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 };
    const expected = types.i8x16{ 4, 3, 2, 1, 8, 7, 6, 5, 12, 11, 10, 9, 16, 15, 14, 13 };
    try common.testIntrinsic(.{ .func = vrev32q_s8, .expected = expected, .args = .{a} });
}

/// Reverse elements in 32-bit words
pub inline fn vrev32_u8(a: types.u8x8) types.u8x8 {
    return .{ a[3], a[2], a[1], a[0], a[7], a[6], a[5], a[4] };
}

test vrev32_u8 {
    const a = types.u8x8{ 1, 2, 3, 4, 5, 6, 7, 8 };
    const expected = types.u8x8{ 4, 3, 2, 1, 8, 7, 6, 5 };
    try common.testIntrinsic(.{ .func = vrev32_u8, .expected = expected, .args = .{a} });
}

/// Reverse elements in 32-bit words
pub inline fn vrev32q_u8(a: types.u8x16) types.u8x16 {
    return .{ a[3], a[2], a[1], a[0], a[7], a[6], a[5], a[4], a[11], a[10], a[9], a[8], a[15], a[14], a[13], a[12] };
}

test vrev32q_u8 {
    const a = types.u8x16{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 };
    const expected = types.u8x16{ 4, 3, 2, 1, 8, 7, 6, 5, 12, 11, 10, 9, 16, 15, 14, 13 };
    try common.testIntrinsic(.{ .func = vrev32q_u8, .expected = expected, .args = .{a} });
}

/// Reverse elements in 32-bit words
pub inline fn vrev32_p8(a: types.p8x8) types.p8x8 {
    return .{ a[3], a[2], a[1], a[0], a[7], a[6], a[5], a[4] };
}

test vrev32_p8 {
    const a = types.p8x8{ 1, 2, 3, 4, 5, 6, 7, 8 };
    const expected = types.p8x8{ 4, 3, 2, 1, 8, 7, 6, 5 };
    try common.testIntrinsic(.{ .func = vrev32_p8, .expected = expected, .args = .{a} });
}

/// Reverse elements in 32-bit words
pub inline fn vrev32q_p8(a: types.p8x16) types.p8x16 {
    return .{ a[3], a[2], a[1], a[0], a[7], a[6], a[5], a[4], a[11], a[10], a[9], a[8], a[15], a[14], a[13], a[12] };
}

test vrev32q_p8 {
    const a = types.p8x16{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 };
    const expected = types.p8x16{ 4, 3, 2, 1, 8, 7, 6, 5, 12, 11, 10, 9, 16, 15, 14, 13 };
    try common.testIntrinsic(.{ .func = vrev32q_p8, .expected = expected, .args = .{a} });
}

/// Reverse elements in 32-bit words
pub inline fn vrev32_s16(a: types.i16x4) types.i16x4 {
    return .{ a[1], a[0], a[3], a[2] };
}

test vrev32_s16 {
    const a = types.i16x4{ 1, 2, 3, 4 };
    const expected = types.i16x4{ 2, 1, 4, 3 };
    try common.testIntrinsic(.{ .func = vrev32_s16, .expected = expected, .args = .{a} });
}

/// Reverse elements in 32-bit words
pub inline fn vrev32q_s16(a: types.i16x8) types.i16x8 {
    return .{ a[1], a[0], a[3], a[2], a[5], a[4], a[7], a[6] };
}

test vrev32q_s16 {
    const a = types.i16x8{ 1, 2, 3, 4, 5, 6, 7, 8 };
    const expected = types.i16x8{ 2, 1, 4, 3, 6, 5, 8, 7 };
    try common.testIntrinsic(.{ .func = vrev32q_s16, .expected = expected, .args = .{a} });
}

/// Reverse elements in 32-bit words
pub inline fn vrev32_u16(a: types.u16x4) types.u16x4 {
    return .{ a[1], a[0], a[3], a[2] };
}

test vrev32_u16 {
    const a = types.u16x4{ 1, 2, 3, 4 };
    const expected = types.u16x4{ 2, 1, 4, 3 };
    try common.testIntrinsic(.{ .func = vrev32_u16, .expected = expected, .args = .{a} });
}

/// Reverse elements in 32-bit words
pub inline fn vrev32q_u16(a: types.u16x8) types.u16x8 {
    return .{ a[1], a[0], a[3], a[2], a[5], a[4], a[7], a[6] };
}

test vrev32q_u16 {
    const a = types.u16x8{ 1, 2, 3, 4, 5, 6, 7, 8 };
    const expected = types.u16x8{ 2, 1, 4, 3, 6, 5, 8, 7 };
    try common.testIntrinsic(.{ .func = vrev32q_u16, .expected = expected, .args = .{a} });
}

/// Reverse elements in 32-bit words
pub inline fn vrev32_p16(a: types.p16x4) types.p16x4 {
    return .{ a[1], a[0], a[3], a[2] };
}

test vrev32_p16 {
    const a = types.p16x4{ 1, 2, 3, 4 };
    const expected = types.p16x4{ 2, 1, 4, 3 };
    try common.testIntrinsic(.{ .func = vrev32_p16, .expected = expected, .args = .{a} });
}

/// Reverse elements in 32-bit words
pub inline fn vrev32q_p16(a: types.p16x8) types.p16x8 {
    return .{ a[1], a[0], a[3], a[2], a[5], a[4], a[7], a[6] };
}

test vrev32q_p16 {
    const a = types.p16x8{ 1, 2, 3, 4, 5, 6, 7, 8 };
    const expected = types.p16x8{ 2, 1, 4, 3, 6, 5, 8, 7 };
    try common.testIntrinsic(.{ .func = vrev32q_p16, .expected = expected, .args = .{a} });
}

/// Reverse elements in 64-bit doublewords
pub inline fn vrev64_s8(a: types.i8x8) types.i8x8 {
    return .{ a[7], a[6], a[5], a[4], a[3], a[2], a[1], a[0] };
}

test vrev64_s8 {
    const a = types.i8x8{ 1, 2, 3, 4, 5, 6, 7, 8 };
    const expected = types.i8x8{ 8, 7, 6, 5, 4, 3, 2, 1 };
    try common.testIntrinsic(.{ .func = vrev64_s8, .expected = expected, .args = .{a} });
}

/// Reverse elements in 64-bit doublewords
pub inline fn vrev64_u8(a: types.u8x8) types.u8x8 {
    return .{ a[7], a[6], a[5], a[4], a[3], a[2], a[1], a[0] };
}

test vrev64_u8 {
    const a = types.u8x8{ 1, 2, 3, 4, 5, 6, 7, 8 };
    const expected = types.u8x8{ 8, 7, 6, 5, 4, 3, 2, 1 };
    try common.testIntrinsic(.{ .func = vrev64_u8, .expected = expected, .args = .{a} });
}

/// Reverse elements in 64-bit doublewords
pub inline fn vrev64_s16(a: types.i16x4) types.i16x4 {
    return .{ a[3], a[2], a[1], a[0] };
}

test vrev64_s16 {
    const a = types.i16x4{ 1, 2, 3, 4 };
    const expected = types.i16x4{ 4, 3, 2, 1 };
    try common.testIntrinsic(.{ .func = vrev64_s16, .expected = expected, .args = .{a} });
}

/// Reverse elements in 64-bit doublewords
pub inline fn vrev64_u16(a: types.u16x4) types.u16x4 {
    return .{ a[3], a[2], a[1], a[0] };
}

test vrev64_u16 {
    const a = types.u16x4{ 1, 2, 3, 4 };
    const expected = types.u16x4{ 4, 3, 2, 1 };
    try common.testIntrinsic(.{ .func = vrev64_u16, .expected = expected, .args = .{a} });
}

/// Reverse elements in 64-bit doublewords
pub inline fn vrev64_s32(a: types.i32x2) types.i32x2 {
    return .{ a[1], a[0] };
}

test vrev64_s32 {
    const a = types.i32x2{ 1, 2 };
    const expected = types.i32x2{ 2, 1 };
    try common.testIntrinsic(.{ .func = vrev64_s32, .expected = expected, .args = .{a} });
}

/// Reverse elements in 64-bit doublewords
pub inline fn vrev64_u32(a: types.u32x2) types.u32x2 {
    return .{ a[1], a[0] };
}

test vrev64_u32 {
    const a = types.u32x2{ 1, 2 };
    const expected = types.u32x2{ 2, 1 };
    try common.testIntrinsic(.{ .func = vrev64_u32, .expected = expected, .args = .{a} });
}

/// Reverse elements in 64-bit doublewords
pub inline fn vrev64_f32(a: types.f32x2) types.f32x2 {
    return .{ a[1], a[0] };
}

test vrev64_f32 {
    const a = types.f32x2{ 1.0, 2.0 };
    const expected = types.f32x2{ 2.0, 1.0 };
    try common.testIntrinsic(.{ .func = vrev64_f32, .expected = expected, .args = .{a} });
}

/// ARM NEON intrinsic: `vcombine_bf16`
pub inline fn vcombine_bf16(p0: types.bf16x4, p1: types.bf16x4) types.bf16x8 {
    return .{ p0[0], p0[1], p0[2], p0[3], p1[0], p1[1], p1[2], p1[3] };
}

test vcombine_bf16 {
    const p0 = @as(types.bf16x4, @splat(0x3F80));
    const p1 = @as(types.bf16x4, @splat(0x3F80));
    const res = vcombine_bf16(p0, p1);
    try std.testing.expect(res[0] != 0);
}

/// ARM NEON intrinsic: `vcombine_mf8`
pub inline fn vcombine_mf8(p0: types.mf8x8, p1: types.mf8x8) types.mf8x16 {
    return .{ p0[0], p0[1], p0[2], p0[3], p0[4], p0[5], p0[6], p0[7], p1[0], p1[1], p1[2], p1[3], p1[4], p1[5], p1[6], p1[7] };
}

test vcombine_mf8 {
    const p0 = @as(types.mf8x8, @splat(2));
    const p1 = @as(types.mf8x8, @splat(2));
    const res = vcombine_mf8(p0, p1);
    try std.testing.expect(res[0] != 0);
}

/// ARM NEON intrinsic: `vdup_n_bf16`
pub inline fn vdup_n_bf16(p0: types.bf16) types.bf16x4 {
    return @splat(p0);
}

test vdup_n_bf16 {
    const p0 = @as(types.bf16, 0x3F80);
    const res = vdup_n_bf16(p0);
    try std.testing.expect(res[0] != 0);
}

/// ARM NEON intrinsic: `vdup_n_mf8`
pub inline fn vdup_n_mf8(p0: types.mf8) types.mf8x8 {
    return @splat(p0);
}

test vdup_n_mf8 {
    const p0 = @as(types.mf8, 2);
    const res = vdup_n_mf8(p0);
    try std.testing.expect(res[0] != 0);
}

/// ARM NEON intrinsic: `vdupq_n_bf16`
pub inline fn vdupq_n_bf16(p0: types.bf16) types.bf16x8 {
    return @splat(p0);
}

test vdupq_n_bf16 {
    const p0 = @as(types.bf16, 0x3F80);
    const res = vdupq_n_bf16(p0);
    try std.testing.expect(res[0] != 0);
}

/// ARM NEON intrinsic: `vdupq_n_mf8`
pub inline fn vdupq_n_mf8(p0: types.mf8) types.mf8x16 {
    return @splat(p0);
}

test vdupq_n_mf8 {
    const p0 = @as(types.mf8, 2);
    const res = vdupq_n_mf8(p0);
    try std.testing.expect(res[0] != 0);
}

/// ARM NEON intrinsic: `vget_high_bf16`
pub inline fn vget_high_bf16(p0: types.bf16x8) types.bf16x4 {
    return .{ p0[4], p0[5], p0[6], p0[7] };
}

test vget_high_bf16 {
    const p0 = @as(types.bf16x8, @splat(0x3F80));
    const res = vget_high_bf16(p0);
    try std.testing.expect(res[0] != 0);
}

/// ARM NEON intrinsic: `vget_high_mf8`
pub inline fn vget_high_mf8(p0: types.mf8x16) types.mf8x8 {
    return .{ p0[8], p0[9], p0[10], p0[11], p0[12], p0[13], p0[14], p0[15] };
}

test vget_high_mf8 {
    const p0 = @as(types.mf8x16, @splat(2));
    const res = vget_high_mf8(p0);
    try std.testing.expect(res[0] != 0);
}

/// ARM NEON intrinsic: `vget_low_bf16`
pub inline fn vget_low_bf16(p0: types.bf16x8) types.bf16x4 {
    return .{ p0[0], p0[1], p0[2], p0[3] };
}

test vget_low_bf16 {
    const p0 = @as(types.bf16x8, @splat(0x3F80));
    const res = vget_low_bf16(p0);
    try std.testing.expect(res[0] != 0);
}

/// ARM NEON intrinsic: `vget_low_mf8`
pub inline fn vget_low_mf8(p0: types.mf8x16) types.mf8x8 {
    return .{ p0[0], p0[1], p0[2], p0[3], p0[4], p0[5], p0[6], p0[7] };
}

test vget_low_mf8 {
    const p0 = @as(types.mf8x16, @splat(2));
    const res = vget_low_mf8(p0);
    try std.testing.expect(res[0] != 0);
}

/// ARM NEON intrinsic: `vmov_n_mf8`
pub inline fn vmov_n_mf8(p0: types.mf8) types.mf8x8 {
    return @splat(p0);
}

test vmov_n_mf8 {
    const p0 = @as(types.mf8, 2);
    const res = vmov_n_mf8(p0);
    try std.testing.expect(res[0] != 0);
}

/// ARM NEON intrinsic: `vmovq_n_mf8`
pub inline fn vmovq_n_mf8(p0: types.mf8) types.mf8x16 {
    return @splat(p0);
}

test vmovq_n_mf8 {
    const p0 = @as(types.mf8, 2);
    const res = vmovq_n_mf8(p0);
    try std.testing.expect(res[0] != 0);
}

/// ARM NEON intrinsic: `vqtbl1_mf8`
pub inline fn vqtbl1_mf8(p0: types.mf8x16, p1: types.u8x8) types.mf8x8 {
    var res: types.mf8x8 = undefined;
    inline for (0..@typeInfo(types.mf8x8).vector.len) |i| {
        const idx = p1[i];
        res[i] = if (idx < 16) p0[idx] else 0;
    }
    return res;
}

test vqtbl1_mf8 {
    const p0 = @as(types.mf8x16, @splat(2));
    const p1 = @as(types.u8x8, @splat(2));
    const res = vqtbl1_mf8(p0, p1);
    try std.testing.expect(res[0] == 2 or res[0] == 0);
}

/// ARM NEON intrinsic: `vqtbl1q_mf8`
pub inline fn vqtbl1q_mf8(p0: types.mf8x16, p1: types.u8x16) types.mf8x16 {
    var res: types.mf8x16 = undefined;
    inline for (0..@typeInfo(types.mf8x16).vector.len) |i| {
        const idx = p1[i];
        res[i] = if (idx < 16) p0[idx] else 0;
    }
    return res;
}

test vqtbl1q_mf8 {
    const p0 = @as(types.mf8x16, @splat(2));
    const p1 = @as(types.u8x16, @splat(2));
    const res = vqtbl1q_mf8(p0, p1);
    try std.testing.expect(res[0] == 2 or res[0] == 0);
}

/// ARM NEON intrinsic: `vqtbl2_mf8`
pub inline fn vqtbl2_mf8(p0: types.mf8x16x2, p1: types.u8x8) types.mf8x8 {
    var res: types.mf8x8 = undefined;
    inline for (0..8) |i| {
        const idx = p1[i];
        res[i] = if (idx < 16) p0[0][idx] else if (idx < 32) p0[1][idx - 16] else 0;
    }
    return res;
}

test vqtbl2_mf8 {
    const p0 = .{ @as(types.mf8x16, @splat(2)), @as(types.mf8x16, @splat(2)) };
    const p1 = @as(types.u8x8, @splat(2));
    const res = vqtbl2_mf8(p0, p1);
    try std.testing.expect(res[0] == 2 or res[0] == 0);
}

/// ARM NEON intrinsic: `vqtbl2q_mf8`
pub inline fn vqtbl2q_mf8(p0: types.mf8x16x2, p1: types.u8x16) types.mf8x16 {
    var res: types.mf8x16 = undefined;
    inline for (0..16) |i| {
        const idx = p1[i];
        res[i] = if (idx < 16) p0[0][idx] else if (idx < 32) p0[1][idx - 16] else 0;
    }
    return res;
}

test vqtbl2q_mf8 {
    const p0 = .{ @as(types.mf8x16, @splat(2)), @as(types.mf8x16, @splat(2)) };
    const p1 = @as(types.u8x16, @splat(2));
    const res = vqtbl2q_mf8(p0, p1);
    try std.testing.expect(res[0] == 2 or res[0] == 0);
}

/// ARM NEON intrinsic: `vqtbl3_mf8`
pub inline fn vqtbl3_mf8(p0: types.mf8x16x3, p1: types.u8x8) types.mf8x8 {
    var res: types.mf8x8 = undefined;
    inline for (0..8) |i| {
        const idx = p1[i];
        res[i] = if (idx < 16) p0[0][idx] else if (idx < 32) p0[1][idx - 16] else if (idx < 48) p0[2][idx - 32] else 0;
    }
    return res;
}

test vqtbl3_mf8 {
    const p0 = .{ @as(types.mf8x16, @splat(2)), @as(types.mf8x16, @splat(2)), @as(types.mf8x16, @splat(2)) };
    const p1 = @as(types.u8x8, @splat(2));
    const res = vqtbl3_mf8(p0, p1);
    try std.testing.expect(res[0] == 2 or res[0] == 0);
}

/// ARM NEON intrinsic: `vqtbl3q_mf8`
pub inline fn vqtbl3q_mf8(p0: types.mf8x16x3, p1: types.u8x16) types.mf8x16 {
    var res: types.mf8x16 = undefined;
    inline for (0..16) |i| {
        const idx = p1[i];
        res[i] = if (idx < 16) p0[0][idx] else if (idx < 32) p0[1][idx - 16] else if (idx < 48) p0[2][idx - 32] else 0;
    }
    return res;
}

test vqtbl3q_mf8 {
    const p0 = .{ @as(types.mf8x16, @splat(2)), @as(types.mf8x16, @splat(2)), @as(types.mf8x16, @splat(2)) };
    const p1 = @as(types.u8x16, @splat(2));
    const res = vqtbl3q_mf8(p0, p1);
    try std.testing.expect(res[0] == 2 or res[0] == 0);
}

/// ARM NEON intrinsic: `vqtbl4_mf8`
pub inline fn vqtbl4_mf8(p0: types.mf8x16x4, p1: types.u8x8) types.mf8x8 {
    var res: types.mf8x8 = undefined;
    inline for (0..8) |i| {
        const idx = p1[i];
        res[i] = if (idx < 16) p0[0][idx] else if (idx < 32) p0[1][idx - 16] else if (idx < 48) p0[2][idx - 32] else if (idx < 64) p0[3][idx - 48] else 0;
    }
    return res;
}

test vqtbl4_mf8 {
    const p0 = .{ @as(types.mf8x16, @splat(2)), @as(types.mf8x16, @splat(2)), @as(types.mf8x16, @splat(2)), @as(types.mf8x16, @splat(2)) };
    const p1 = @as(types.u8x8, @splat(2));
    const res = vqtbl4_mf8(p0, p1);
    try std.testing.expect(res[0] == 2 or res[0] == 0);
}

/// ARM NEON intrinsic: `vqtbl4q_mf8`
pub inline fn vqtbl4q_mf8(p0: types.mf8x16x4, p1: types.u8x16) types.mf8x16 {
    var res: types.mf8x16 = undefined;
    inline for (0..16) |i| {
        const idx = p1[i];
        res[i] = if (idx < 16) p0[0][idx] else if (idx < 32) p0[1][idx - 16] else if (idx < 48) p0[2][idx - 32] else if (idx < 64) p0[3][idx - 48] else 0;
    }
    return res;
}

test vqtbl4q_mf8 {
    const p0 = .{ @as(types.mf8x16, @splat(2)), @as(types.mf8x16, @splat(2)), @as(types.mf8x16, @splat(2)), @as(types.mf8x16, @splat(2)) };
    const p1 = @as(types.u8x16, @splat(2));
    const res = vqtbl4q_mf8(p0, p1);
    try std.testing.expect(res[0] == 2 or res[0] == 0);
}
