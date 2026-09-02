const arch = @import("../arch.zig");
const std = @import("std");
const types = @import("../types.zig");
const common = @import("../common.zig");

const i8x8 = types.i8x8;
const i8x16 = types.i8x16;
const i16x4 = types.i16x4;
const i16x8 = types.i16x8;
const i32x2 = types.i32x2;
const i32x4 = types.i32x4;
const i64x1 = types.i64x1;
const i64x2 = types.i64x2;

const u8x8 = types.u8x8;
const u8x16 = types.u8x16;
const u16x4 = types.u16x4;
const u16x8 = types.u16x8;
const u32x2 = types.u32x2;
const u32x4 = types.u32x4;
const u64x1 = types.u64x1;
const u64x2 = types.u64x2;

const f16x4 = types.f16x4;
const f16x8 = types.f16x8;
const f32x2 = types.f32x2;
const f32x4 = types.f32x4;
const f64x1 = types.f64x1;
const f64x2 = types.f64x2;

const p8x8 = types.p8x8;
const p8x16 = types.p8x16;
const p16x4 = types.p16x4;
const p16x8 = types.p16x8;
const p64x1 = types.p64x1;
const p64x2 = types.p64x2;

const p8 = types.p8;
const p16 = types.p16;
const p64 = types.p64;

// --- Get Low Half (VGET_LOW) ---
pub inline fn vget_low_s8(vec: i8x16) i8x8 { return @shuffle(i8, vec, undefined, i8x8{ 0, 1, 2, 3, 4, 5, 6, 7 }); }
pub inline fn vget_low_s16(vec: i16x8) i16x4 { return @shuffle(i16, vec, undefined, i16x4{ 0, 1, 2, 3 }); }
pub inline fn vget_low_s32(vec: i32x4) i32x2 { return @shuffle(i32, vec, undefined, i32x2{ 0, 1 }); }
pub inline fn vget_low_s64(vec: i64x2) i64x1 { return @shuffle(i64, vec, undefined, i64x1{0}); }
pub inline fn vget_low_u8(vec: u8x16) u8x8 { return @shuffle(u8, vec, undefined, u8x8{ 0, 1, 2, 3, 4, 5, 6, 7 }); }
pub inline fn vget_low_u16(vec: u16x8) u16x4 { return @shuffle(u16, vec, undefined, u16x4{ 0, 1, 2, 3 }); }
pub inline fn vget_low_u32(vec: u32x4) u32x2 { return @shuffle(u32, vec, undefined, u32x2{ 0, 1 }); }
pub inline fn vget_low_u64(vec: u64x2) u64x1 { return @shuffle(u64, vec, undefined, u64x1{0}); }
pub inline fn vget_low_f16(vec: f16x8) f16x4 { return @shuffle(f16, vec, undefined, f16x4{ 0, 1, 2, 3 }); }
pub inline fn vget_low_f32(vec: f32x4) f32x2 { return @shuffle(f32, vec, undefined, f32x2{ 0, 1 }); }
pub inline fn vget_low_f64(vec: f64x2) f64x1 { return @shuffle(f64, vec, undefined, f64x1{0}); }
pub inline fn vget_low_p8(vec: p8x16) p8x8 { return @shuffle(p8, vec, undefined, p8x8{ 0, 1, 2, 3, 4, 5, 6, 7 }); }
pub inline fn vget_low_p16(vec: p16x8) p16x4 { return @shuffle(p16, vec, undefined, p16x4{ 0, 1, 2, 3 }); }
pub inline fn vget_low_p64(vec: p64x2) p64x1 { return @shuffle(p64, vec, undefined, p64x1{0}); }

// --- Get High Half (VGET_HIGH) ---
pub inline fn vget_high_s8(vec: i8x16) i8x8 { return @shuffle(i8, vec, undefined, i8x8{ 8, 9, 10, 11, 12, 13, 14, 15 }); }
pub inline fn vget_high_s16(vec: i16x8) i16x4 { return @shuffle(i16, vec, undefined, i16x4{ 4, 5, 6, 7 }); }
pub inline fn vget_high_s32(vec: i32x4) i32x2 { return @shuffle(i32, vec, undefined, i32x2{ 2, 3 }); }
pub inline fn vget_high_s64(vec: i64x2) i64x1 { return @shuffle(i64, vec, undefined, i64x1{1}); }
pub inline fn vget_high_u8(vec: u8x16) u8x8 { return @shuffle(u8, vec, undefined, u8x8{ 8, 9, 10, 11, 12, 13, 14, 15 }); }
pub inline fn vget_high_u16(vec: u16x8) u16x4 { return @shuffle(u16, vec, undefined, u16x4{ 4, 5, 6, 7 }); }
pub inline fn vget_high_u32(vec: u32x4) u32x2 { return @shuffle(u32, vec, undefined, u32x2{ 2, 3 }); }
pub inline fn vget_high_u64(vec: u64x2) u64x1 { return @shuffle(u64, vec, undefined, u64x1{1}); }
pub inline fn vget_high_f16(vec: f16x8) f16x4 { return @shuffle(f16, vec, undefined, f16x4{ 4, 5, 6, 7 }); }
pub inline fn vget_high_f32(vec: f32x4) f32x2 { return @shuffle(f32, vec, undefined, f32x2{ 2, 3 }); }
pub inline fn vget_high_f64(vec: f64x2) f64x1 { return @shuffle(f64, vec, undefined, f64x1{1}); }
pub inline fn vget_high_p8(vec: p8x16) p8x8 { return @shuffle(p8, vec, undefined, p8x8{ 8, 9, 10, 11, 12, 13, 14, 15 }); }
pub inline fn vget_high_p16(vec: p16x8) p16x4 { return @shuffle(p16, vec, undefined, p16x4{ 4, 5, 6, 7 }); }
pub inline fn vget_high_p64(vec: p64x2) p64x1 { return @shuffle(p64, vec, undefined, p64x1{1}); }

// --- Combine Two 64-bit Vectors into 128-bit Vector (VCOMBINE) ---
pub inline fn vcombine_s8(a: i8x8, b: i8x8) i8x16 { return common.join(a, b); }
pub inline fn vcombine_s16(a: i16x4, b: i16x4) i16x8 { return common.join(a, b); }
pub inline fn vcombine_s32(a: i32x2, b: i32x2) i32x4 { return common.join(a, b); }
pub inline fn vcombine_s64(a: i64x1, b: i64x1) i64x2 { return common.join(a, b); }
pub inline fn vcombine_u8(a: u8x8, b: u8x8) u8x16 { return common.join(a, b); }
pub inline fn vcombine_u16(a: u16x4, b: u16x4) u16x8 { return common.join(a, b); }
pub inline fn vcombine_u32(a: u32x2, b: u32x2) u32x4 { return common.join(a, b); }
pub inline fn vcombine_u64(a: u64x1, b: u64x1) u64x2 { return common.join(a, b); }
pub inline fn vcombine_f16(a: f16x4, b: f16x4) f16x8 { return common.join(a, b); }
pub inline fn vcombine_f32(a: f32x2, b: f32x2) f32x4 { return common.join(a, b); }
pub inline fn vcombine_f64(a: f64x1, b: f64x1) f64x2 { return common.join(a, b); }
pub inline fn vcombine_p8(a: p8x8, b: p8x8) p8x16 { return common.join(a, b); }
pub inline fn vcombine_p16(a: p16x4, b: p16x4) p16x8 { return common.join(a, b); }
pub inline fn vcombine_p64(a: p64x1, b: p64x1) p64x2 { return common.join(a, b); }

// --- Get Lane / Set Lane ---
pub inline fn vget_lane_s8(vec: i8x8, comptime lane: usize) i8 { return vec[lane]; }
pub inline fn vget_lane_s16(vec: i16x4, comptime lane: usize) i16 { return vec[lane]; }
pub inline fn vget_lane_s32(vec: i32x2, comptime lane: usize) i32 { return vec[lane]; }
pub inline fn vget_lane_s64(vec: i64x1, comptime lane: usize) i64 { return vec[lane]; }
pub inline fn vget_lane_u8(vec: u8x8, comptime lane: usize) u8 { return vec[lane]; }
pub inline fn vget_lane_u16(vec: u16x4, comptime lane: usize) u16 { return vec[lane]; }
pub inline fn vget_lane_u32(vec: u32x2, comptime lane: usize) u32 { return vec[lane]; }
pub inline fn vget_lane_u64(vec: u64x1, comptime lane: usize) u64 { return vec[lane]; }
pub inline fn vget_lane_f16(vec: f16x4, comptime lane: usize) f16 { return vec[lane]; }
pub inline fn vget_lane_f32(vec: f32x2, comptime lane: usize) f32 { return vec[lane]; }
pub inline fn vget_lane_f64(vec: f64x1, comptime lane: usize) f64 { return vec[lane]; }
pub inline fn vget_lane_p8(vec: p8x8, comptime lane: usize) p8 { return vec[lane]; }
pub inline fn vget_lane_p16(vec: p16x4, comptime lane: usize) p16 { return vec[lane]; }
pub inline fn vget_lane_p64(vec: p64x1, comptime lane: usize) p64 { return vec[lane]; }

pub inline fn vgetq_lane_s8(vec: i8x16, comptime lane: usize) i8 { return vec[lane]; }
pub inline fn vgetq_lane_s16(vec: i16x8, comptime lane: usize) i16 { return vec[lane]; }
pub inline fn vgetq_lane_s32(vec: i32x4, comptime lane: usize) i32 { return vec[lane]; }
pub inline fn vgetq_lane_s64(vec: i64x2, comptime lane: usize) i64 { return vec[lane]; }
pub inline fn vgetq_lane_u8(vec: u8x16, comptime lane: usize) u8 { return vec[lane]; }
pub inline fn vgetq_lane_u16(vec: u16x8, comptime lane: usize) u16 { return vec[lane]; }
pub inline fn vgetq_lane_u32(vec: u32x4, comptime lane: usize) u32 { return vec[lane]; }
pub inline fn vgetq_lane_u64(vec: u64x2, comptime lane: usize) u64 { return vec[lane]; }
pub inline fn vgetq_lane_f16(vec: f16x8, comptime lane: usize) f16 { return vec[lane]; }
pub inline fn vgetq_lane_f32(vec: f32x4, comptime lane: usize) f32 { return vec[lane]; }
pub inline fn vgetq_lane_f64(vec: f64x2, comptime lane: usize) f64 { return vec[lane]; }
pub inline fn vgetq_lane_p8(vec: p8x16, comptime lane: usize) p8 { return vec[lane]; }
pub inline fn vgetq_lane_p16(vec: p16x8, comptime lane: usize) p16 { return vec[lane]; }
pub inline fn vgetq_lane_p64(vec: p64x2, comptime lane: usize) p64 { return vec[lane]; }

pub inline fn vset_lane_s8(val: i8, vec: i8x8, comptime lane: usize) i8x8 { var r = vec; r[lane] = val; return r; }
pub inline fn vset_lane_s16(val: i16, vec: i16x4, comptime lane: usize) i16x4 { var r = vec; r[lane] = val; return r; }
pub inline fn vset_lane_s32(val: i32, vec: i32x2, comptime lane: usize) i32x2 { var r = vec; r[lane] = val; return r; }
pub inline fn vset_lane_u8(val: u8, vec: u8x8, comptime lane: usize) u8x8 { var r = vec; r[lane] = val; return r; }
pub inline fn vset_lane_u16(val: u16, vec: u16x4, comptime lane: usize) u16x4 { var r = vec; r[lane] = val; return r; }
pub inline fn vset_lane_u32(val: u32, vec: u32x2, comptime lane: usize) u32x2 { var r = vec; r[lane] = val; return r; }
pub inline fn vset_lane_f32(val: f32, vec: f32x2, comptime lane: usize) f32x2 { var r = vec; r[lane] = val; return r; }

pub inline fn vsetq_lane_s8(val: i8, vec: i8x16, comptime lane: usize) i8x16 { var r = vec; r[lane] = val; return r; }
pub inline fn vsetq_lane_s16(val: i16, vec: i16x8, comptime lane: usize) i16x8 { var r = vec; r[lane] = val; return r; }
pub inline fn vsetq_lane_s32(val: i32, vec: i32x4, comptime lane: usize) i32x4 { var r = vec; r[lane] = val; return r; }
pub inline fn vsetq_lane_u8(val: u8, vec: u8x16, comptime lane: usize) u8x16 { var r = vec; r[lane] = val; return r; }
pub inline fn vsetq_lane_u16(val: u16, vec: u16x8, comptime lane: usize) u16x8 { var r = vec; r[lane] = val; return r; }
pub inline fn vsetq_lane_u32(val: u32, vec: u32x4, comptime lane: usize) u32x4 { var r = vec; r[lane] = val; return r; }
pub inline fn vsetq_lane_f32(val: f32, vec: f32x4, comptime lane: usize) f32x4 { var r = vec; r[lane] = val; return r; }

// --- Duplicate / Broadcast (VDUP_N / VDUPQ_N / VMOV_N / VMOVQ_N) ---
pub inline fn vdup_n_s8(scalar: i8) i8x8 { return @splat(scalar); }
pub inline fn vdup_n_s16(scalar: i16) i16x4 { return @splat(scalar); }
pub inline fn vdup_n_s32(scalar: i32) i32x2 { return @splat(scalar); }
pub inline fn vdup_n_s64(scalar: i64) i64x1 { return @splat(scalar); }
pub inline fn vdup_n_u8(scalar: u8) u8x8 { return @splat(scalar); }
pub inline fn vdup_n_u16(scalar: u16) u16x4 { return @splat(scalar); }
pub inline fn vdup_n_u32(scalar: u32) u32x2 { return @splat(scalar); }
pub inline fn vdup_n_u64(scalar: u64) u64x1 { return @splat(scalar); }
pub inline fn vdup_n_f16(scalar: f16) f16x4 { return @splat(scalar); }
pub inline fn vdup_n_f32(scalar: f32) f32x2 { return @splat(scalar); }
pub inline fn vdup_n_f64(scalar: f64) f64x1 { return @splat(scalar); }
pub inline fn vdup_n_p8(scalar: p8) p8x8 { return @splat(scalar); }
pub inline fn vdup_n_p16(scalar: p16) p16x4 { return @splat(scalar); }
pub inline fn vdup_n_p64(scalar: p64) p64x1 { return @splat(scalar); }

pub inline fn vdupq_n_s8(scalar: i8) i8x16 { return @splat(scalar); }
pub inline fn vdupq_n_s16(scalar: i16) i16x8 { return @splat(scalar); }
pub inline fn vdupq_n_s32(scalar: i32) i32x4 { return @splat(scalar); }
pub inline fn vdupq_n_s64(scalar: i64) i64x2 { return @splat(scalar); }
pub inline fn vdupq_n_u8(scalar: u8) u8x16 { return @splat(scalar); }
pub inline fn vdupq_n_u16(scalar: u16) u16x8 { return @splat(scalar); }
pub inline fn vdupq_n_u32(scalar: u32) u32x4 { return @splat(scalar); }
pub inline fn vdupq_n_u64(scalar: u64) u64x2 { return @splat(scalar); }
pub inline fn vdupq_n_f16(scalar: f16) f16x8 { return @splat(scalar); }
pub inline fn vdupq_n_f32(scalar: f32) f32x4 { return @splat(scalar); }
pub inline fn vdupq_n_f64(scalar: f64) f64x2 { return @splat(scalar); }
pub inline fn vdupq_n_p8(scalar: p8) p8x16 { return @splat(scalar); }
pub inline fn vdupq_n_p16(scalar: p16) p16x8 { return @splat(scalar); }
pub inline fn vdupq_n_p64(scalar: p64) p64x2 { return @splat(scalar); }

pub inline fn vmov_n_s8(scalar: i8) i8x8 { return @splat(scalar); }
pub inline fn vmov_n_s16(scalar: i16) i16x4 { return @splat(scalar); }
pub inline fn vmov_n_s32(scalar: i32) i32x2 { return @splat(scalar); }
pub inline fn vmov_n_u8(scalar: u8) u8x8 { return @splat(scalar); }
pub inline fn vmov_n_u16(scalar: u16) u16x4 { return @splat(scalar); }
pub inline fn vmov_n_u32(scalar: u32) u32x2 { return @splat(scalar); }
pub inline fn vmov_n_f32(scalar: f32) f32x2 { return @splat(scalar); }

pub inline fn vmovq_n_s8(scalar: i8) i8x16 { return @splat(scalar); }
pub inline fn vmovq_n_s16(scalar: i16) i16x8 { return @splat(scalar); }
pub inline fn vmovq_n_s32(scalar: i32) i32x4 { return @splat(scalar); }
pub inline fn vmovq_n_s64(scalar: i64) i64x2 { return @splat(scalar); }
pub inline fn vmovq_n_u8(scalar: u8) u8x16 { return @splat(scalar); }
pub inline fn vmovq_n_u16(scalar: u16) u16x8 { return @splat(scalar); }
pub inline fn vmovq_n_u32(scalar: u32) u32x4 { return @splat(scalar); }
pub inline fn vmovq_n_u64(scalar: u64) u64x2 { return @splat(scalar); }
pub inline fn vmovq_n_f32(scalar: f32) f32x4 { return @splat(scalar); }
pub inline fn vmovq_n_f64(scalar: f64) f64x2 { return @splat(scalar); }
pub inline fn vmovq_n_p8(scalar: p8) p8x16 { return @splat(scalar); }
pub inline fn vmovq_n_p16(scalar: p16) p16x8 { return @splat(scalar); }
pub inline fn vmovq_n_p64(scalar: p64) p64x2 { return @splat(scalar); }

// --- Zip / Interleave (VZIP1 / VZIP2 / VZIPQ) ---
pub inline fn vzip1_u8(a: u8x8, b: u8x8) u8x8 {
    return @shuffle(u8, a, b, [8]i32{ 0, ~@as(i32, 0), 1, ~@as(i32, 1), 2, ~@as(i32, 2), 3, ~@as(i32, 3) });
}
pub inline fn vzip2_u8(a: u8x8, b: u8x8) u8x8 {
    return @shuffle(u8, a, b, [8]i32{ 4, ~@as(i32, 4), 5, ~@as(i32, 5), 6, ~@as(i32, 6), 7, ~@as(i32, 7) });
}
pub inline fn vzip1_s8(a: i8x8, b: i8x8) i8x8 {
    return @shuffle(i8, a, b, [8]i32{ 0, ~@as(i32, 0), 1, ~@as(i32, 1), 2, ~@as(i32, 2), 3, ~@as(i32, 3) });
}
pub inline fn vzip2_s8(a: i8x8, b: i8x8) i8x8 {
    return @shuffle(i8, a, b, [8]i32{ 4, ~@as(i32, 4), 5, ~@as(i32, 5), 6, ~@as(i32, 6), 7, ~@as(i32, 7) });
}
pub inline fn vzip1_u16(a: u16x4, b: u16x4) u16x4 {
    return @shuffle(u16, a, b, [4]i32{ 0, ~@as(i32, 0), 1, ~@as(i32, 1) });
}
pub inline fn vzip2_u16(a: u16x4, b: u16x4) u16x4 {
    return @shuffle(u16, a, b, [4]i32{ 2, ~@as(i32, 2), 3, ~@as(i32, 3) });
}
pub inline fn vzip1_s16(a: i16x4, b: i16x4) i16x4 {
    return @shuffle(i16, a, b, [4]i32{ 0, ~@as(i32, 0), 1, ~@as(i32, 1) });
}
pub inline fn vzip2_s16(a: i16x4, b: i16x4) i16x4 {
    return @shuffle(i16, a, b, [4]i32{ 2, ~@as(i32, 2), 3, ~@as(i32, 3) });
}
pub inline fn vzip1_u32(a: u32x2, b: u32x2) u32x2 {
    return @shuffle(u32, a, b, [2]i32{ 0, ~@as(i32, 0) });
}
pub inline fn vzip2_u32(a: u32x2, b: u32x2) u32x2 {
    return @shuffle(u32, a, b, [2]i32{ 1, ~@as(i32, 1) });
}
pub inline fn vzip1_s32(a: i32x2, b: i32x2) i32x2 {
    return @shuffle(i32, a, b, [2]i32{ 0, ~@as(i32, 0) });
}
pub inline fn vzip2_s32(a: i32x2, b: i32x2) i32x2 {
    return @shuffle(i32, a, b, [2]i32{ 1, ~@as(i32, 1) });
}
pub inline fn vzip1_f32(a: f32x2, b: f32x2) f32x2 {
    return @shuffle(f32, a, b, [2]i32{ 0, ~@as(i32, 0) });
}
pub inline fn vzip2_f32(a: f32x2, b: f32x2) f32x2 {
    return @shuffle(f32, a, b, [2]i32{ 1, ~@as(i32, 1) });
}

pub inline fn vzip1q_u8(a: u8x16, b: u8x16) u8x16 {
    return @shuffle(u8, a, b, [16]i32{ 0, ~@as(i32, 0), 1, ~@as(i32, 1), 2, ~@as(i32, 2), 3, ~@as(i32, 3), 4, ~@as(i32, 4), 5, ~@as(i32, 5), 6, ~@as(i32, 6), 7, ~@as(i32, 7) });
}
pub inline fn vzip2q_u8(a: u8x16, b: u8x16) u8x16 {
    return @shuffle(u8, a, b, [16]i32{ 8, ~@as(i32, 8), 9, ~@as(i32, 9), 10, ~@as(i32, 10), 11, ~@as(i32, 11), 12, ~@as(i32, 12), 13, ~@as(i32, 13), 14, ~@as(i32, 14), 15, ~@as(i32, 15) });
}
pub inline fn vzip1q_s8(a: i8x16, b: i8x16) i8x16 {
    return @shuffle(i8, a, b, [16]i32{ 0, ~@as(i32, 0), 1, ~@as(i32, 1), 2, ~@as(i32, 2), 3, ~@as(i32, 3), 4, ~@as(i32, 4), 5, ~@as(i32, 5), 6, ~@as(i32, 6), 7, ~@as(i32, 7) });
}
pub inline fn vzip2q_s8(a: i8x16, b: i8x16) i8x16 {
    return @shuffle(i8, a, b, [16]i32{ 8, ~@as(i32, 8), 9, ~@as(i32, 9), 10, ~@as(i32, 10), 11, ~@as(i32, 11), 12, ~@as(i32, 12), 13, ~@as(i32, 13), 14, ~@as(i32, 14), 15, ~@as(i32, 15) });
}
pub inline fn vzip1q_u16(a: u16x8, b: u16x8) u16x8 {
    return @shuffle(u16, a, b, [8]i32{ 0, ~@as(i32, 0), 1, ~@as(i32, 1), 2, ~@as(i32, 2), 3, ~@as(i32, 3) });
}
pub inline fn vzip2q_u16(a: u16x8, b: u16x8) u16x8 {
    return @shuffle(u16, a, b, [8]i32{ 4, ~@as(i32, 4), 5, ~@as(i32, 5), 6, ~@as(i32, 6), 7, ~@as(i32, 7) });
}
pub inline fn vzip1q_s16(a: i16x8, b: i16x8) i16x8 {
    return @shuffle(i16, a, b, [8]i32{ 0, ~@as(i32, 0), 1, ~@as(i32, 1), 2, ~@as(i32, 2), 3, ~@as(i32, 3) });
}
pub inline fn vzip2q_s16(a: i16x8, b: i16x8) i16x8 {
    return @shuffle(i16, a, b, [8]i32{ 4, ~@as(i32, 4), 5, ~@as(i32, 5), 6, ~@as(i32, 6), 7, ~@as(i32, 7) });
}
pub inline fn vzip1q_u32(a: u32x4, b: u32x4) u32x4 {
    return @shuffle(u32, a, b, [4]i32{ 0, ~@as(i32, 0), 1, ~@as(i32, 1) });
}
pub inline fn vzip2q_u32(a: u32x4, b: u32x4) u32x4 {
    return @shuffle(u32, a, b, [4]i32{ 2, ~@as(i32, 2), 3, ~@as(i32, 3) });
}
pub inline fn vzip1q_s32(a: i32x4, b: i32x4) i32x4 {
    return @shuffle(i32, a, b, [4]i32{ 0, ~@as(i32, 0), 1, ~@as(i32, 1) });
}
pub inline fn vzip2q_s32(a: i32x4, b: i32x4) i32x4 {
    return @shuffle(i32, a, b, [4]i32{ 2, ~@as(i32, 2), 3, ~@as(i32, 3) });
}
pub inline fn vzip1q_f32(a: f32x4, b: f32x4) f32x4 {
    return @shuffle(f32, a, b, [4]i32{ 0, ~@as(i32, 0), 1, ~@as(i32, 1) });
}
pub inline fn vzip2q_f32(a: f32x4, b: f32x4) f32x4 {
    return @shuffle(f32, a, b, [4]i32{ 2, ~@as(i32, 2), 3, ~@as(i32, 3) });
}
pub inline fn vzip1q_u64(a: u64x2, b: u64x2) u64x2 {
    return @shuffle(u64, a, b, [2]i32{ 0, ~@as(i32, 0) });
}
pub inline fn vzip2q_u64(a: u64x2, b: u64x2) u64x2 {
    return @shuffle(u64, a, b, [2]i32{ 1, ~@as(i32, 1) });
}
pub inline fn vzip1q_s64(a: i64x2, b: i64x2) i64x2 {
    return @shuffle(i64, a, b, [2]i32{ 0, ~@as(i32, 0) });
}
pub inline fn vzip2q_s64(a: i64x2, b: i64x2) i64x2 {
    return @shuffle(i64, a, b, [2]i32{ 1, ~@as(i32, 1) });
}
pub inline fn vzip1q_f64(a: f64x2, b: f64x2) f64x2 {
    return @shuffle(f64, a, b, [2]i32{ 0, ~@as(i32, 0) });
}
pub inline fn vzip2q_f64(a: f64x2, b: f64x2) f64x2 {
    return @shuffle(f64, a, b, [2]i32{ 1, ~@as(i32, 1) });
}

pub inline fn vzipq_u8(a: u8x16, b: u8x16) types.u8x16x2 { return .{ vzip1q_u8(a, b), vzip2q_u8(a, b) }; }
pub inline fn vzipq_s8(a: i8x16, b: i8x16) types.i8x16x2 { return .{ vzip1q_s8(a, b), vzip2q_s8(a, b) }; }
pub inline fn vzipq_u16(a: u16x8, b: u16x8) types.u16x8x2 { return .{ vzip1q_u16(a, b), vzip2q_u16(a, b) }; }
pub inline fn vzipq_s16(a: i16x8, b: i16x8) types.i16x8x2 { return .{ vzip1q_s16(a, b), vzip2q_s16(a, b) }; }
pub inline fn vzipq_u32(a: u32x4, b: u32x4) types.u32x4x2 { return .{ vzip1q_u32(a, b), vzip2q_u32(a, b) }; }
pub inline fn vzipq_s32(a: i32x4, b: i32x4) types.i32x4x2 { return .{ vzip1q_s32(a, b), vzip2q_s32(a, b) }; }
pub inline fn vzipq_u64(a: u64x2, b: u64x2) types.u64x2x2 { return .{ vzip1q_u64(a, b), vzip2q_u64(a, b) }; }
pub inline fn vzipq_s64(a: i64x2, b: i64x2) types.i64x2x2 { return .{ vzip1q_s64(a, b), vzip2q_s64(a, b) }; }

// --- Transpose (VTRN1 / VTRN2 / VTRNQ) ---
pub inline fn vtrn1q_s8(a: i8x16, b: i8x16) i8x16 {
    return @shuffle(i8, a, b, [16]i32{ 0, ~@as(i32, 0), 2, ~@as(i32, 2), 4, ~@as(i32, 4), 6, ~@as(i32, 6), 8, ~@as(i32, 8), 10, ~@as(i32, 10), 12, ~@as(i32, 12), 14, ~@as(i32, 14) });
}
pub inline fn vtrn2q_s8(a: i8x16, b: i8x16) i8x16 {
    return @shuffle(i8, a, b, [16]i32{ 1, ~@as(i32, 1), 3, ~@as(i32, 3), 5, ~@as(i32, 5), 7, ~@as(i32, 7), 9, ~@as(i32, 9), 11, ~@as(i32, 11), 13, ~@as(i32, 13), 15, ~@as(i32, 15) });
}
pub inline fn vtrn1q_u8(a: u8x16, b: u8x16) u8x16 {
    return @shuffle(u8, a, b, [16]i32{ 0, ~@as(i32, 0), 2, ~@as(i32, 2), 4, ~@as(i32, 4), 6, ~@as(i32, 6), 8, ~@as(i32, 8), 10, ~@as(i32, 10), 12, ~@as(i32, 12), 14, ~@as(i32, 14) });
}
pub inline fn vtrn2q_u8(a: u8x16, b: u8x16) u8x16 {
    return @shuffle(u8, a, b, [16]i32{ 1, ~@as(i32, 1), 3, ~@as(i32, 3), 5, ~@as(i32, 5), 7, ~@as(i32, 7), 9, ~@as(i32, 9), 11, ~@as(i32, 11), 13, ~@as(i32, 13), 15, ~@as(i32, 15) });
}
pub inline fn vtrn1q_f32(a: f32x4, b: f32x4) f32x4 {
    return @shuffle(f32, a, b, [4]i32{ 0, ~@as(i32, 0), 2, ~@as(i32, 2) });
}
pub inline fn vtrn2q_f32(a: f32x4, b: f32x4) f32x4 {
    return @shuffle(f32, a, b, [4]i32{ 1, ~@as(i32, 1), 3, ~@as(i32, 3) });
}
pub inline fn vtrnq_f32(a: f32x4, b: f32x4) types.f32x4x2 {
    return .{ vtrn1q_f32(a, b), vtrn2q_f32(a, b) };
}
pub inline fn vtrnq_s8(a: i8x16, b: i8x16) types.i8x16x2 {
    return .{ vtrn1q_s8(a, b), vtrn2q_s8(a, b) };
}
pub inline fn vtrnq_u8(a: u8x16, b: u8x16) types.u8x16x2 {
    return .{ vtrn1q_u8(a, b), vtrn2q_u8(a, b) };
}

// --- Reverse 64-bit Lanes (VREV64 / VREV64Q) ---
pub inline fn vrev64q_s8(a: i8x16) i8x16 {
    return @shuffle(i8, a, undefined, i8x16{ 7, 6, 5, 4, 3, 2, 1, 0, 15, 14, 13, 12, 11, 10, 9, 8 });
}
pub inline fn vrev64q_u8(a: u8x16) u8x16 {
    return @shuffle(u8, a, undefined, u8x16{ 7, 6, 5, 4, 3, 2, 1, 0, 15, 14, 13, 12, 11, 10, 9, 8 });
}
pub inline fn vrev64q_s16(a: i16x8) i16x8 {
    return @shuffle(i16, a, undefined, i16x8{ 3, 2, 1, 0, 7, 6, 5, 4 });
}
pub inline fn vrev64q_u16(a: u16x8) u16x8 {
    return @shuffle(u16, a, undefined, u16x8{ 3, 2, 1, 0, 7, 6, 5, 4 });
}
pub inline fn vrev64q_s32(a: i32x4) i32x4 {
    return @shuffle(i32, a, undefined, i32x4{ 1, 0, 3, 2 });
}
pub inline fn vrev64q_u32(a: u32x4) u32x4 {
    return @shuffle(u32, a, undefined, u32x4{ 1, 0, 3, 2 });
}
pub inline fn vrev64q_f32(a: f32x4) f32x4 {
    return @shuffle(f32, a, undefined, f32x4{ 1, 0, 3, 2 });
}

// --- Table Lookup (VTBL / VQTBL) ---
pub inline fn vqtbl1q_u8(t: u8x16, idx: u8x16) u8x16 {
    var res: u8x16 = undefined;
    const t_arr: [16]u8 = @bitCast(t);
    const t_ptr: [*]const u8 = &t_arr;
    inline for (0..16) |i| {
        const index = idx[i];
        res[i] = if (index < 16) t_ptr[index] else 0;
    }
    return res;
}
pub inline fn vqtbl1q_s8(t: i8x16, idx: i8x16) i8x16 {
    const t_u: u8x16 = @bitCast(t);
    const idx_u: u8x16 = @bitCast(idx);
    var res: u8x16 = undefined;
    const t_arr: [16]u8 = @bitCast(t_u);
    const t_ptr: [*]const u8 = &t_arr;
    inline for (0..16) |i| {
        const index = idx_u[i];
        res[i] = if (index < 16) t_ptr[index] else 0;
    }
    return @bitCast(res);
}
pub inline fn vqtbl1q_p8(t: p8x16, idx: p8x16) p8x16 {
    const t_u: u8x16 = @bitCast(t);
    const idx_u: u8x16 = @bitCast(idx);
    var res: u8x16 = undefined;
    const t_arr: [16]u8 = @bitCast(t_u);
    const t_ptr: [*]const u8 = &t_arr;
    inline for (0..16) |i| {
        const index = idx_u[i];
        res[i] = if (index < 16) t_ptr[index] else 0;
    }
    return @bitCast(res);
}

test "permute intrinsics" {
    const a: i32x4 = .{ 1, 2, 3, 4 };
    const low = vget_low_s32(a);
    const high = vget_high_s32(a);
    try std.testing.expectEqual(i32x2{ 1, 2 }, low);
    try std.testing.expectEqual(i32x2{ 3, 4 }, high);

    const comb = vcombine_s32(low, high);
    try std.testing.expectEqual(a, comb);

    const table: u8x16 = .{ '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f' };
    const idx: u8x16 = .{ 0, 15, 10, 20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
    const looked_up = vqtbl1q_u8(table, idx);
    try std.testing.expectEqual(@as(u8, '0'), looked_up[0]);
    try std.testing.expectEqual(@as(u8, 'f'), looked_up[1]);
    try std.testing.expectEqual(@as(u8, 'a'), looked_up[2]);
    try std.testing.expectEqual(@as(u8, 0), looked_up[3]);
}
