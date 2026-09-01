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
const p128 = types.p128;

// --- Vector Add (Wrapping / Float) ---
pub inline fn vadd_s8(a: i8x8, b: i8x8) i8x8 { return a +% b; }
pub inline fn vadd_s16(a: i16x4, b: i16x4) i16x4 { return a +% b; }
pub inline fn vadd_s32(a: i32x2, b: i32x2) i32x2 { return a +% b; }
pub inline fn vadd_s64(a: i64x1, b: i64x1) i64x1 { return a +% b; }
pub inline fn vadd_u8(a: u8x8, b: u8x8) u8x8 { return a +% b; }
pub inline fn vadd_u16(a: u16x4, b: u16x4) u16x4 { return a +% b; }
pub inline fn vadd_u32(a: u32x2, b: u32x2) u32x2 { return a +% b; }
pub inline fn vadd_u64(a: u64x1, b: u64x1) u64x1 { return a +% b; }
pub inline fn vadd_f16(a: f16x4, b: f16x4) f16x4 { return a + b; }
pub inline fn vadd_f32(a: f32x2, b: f32x2) f32x2 { return a + b; }
pub inline fn vadd_f64(a: f64x1, b: f64x1) f64x1 { return a + b; }
pub inline fn vadd_p8(a: p8x8, b: p8x8) p8x8 { return a ^ b; }
pub inline fn vadd_p16(a: p16x4, b: p16x4) p16x4 { return a ^ b; }
pub inline fn vadd_p64(a: p64x1, b: p64x1) p64x1 { return a ^ b; }
pub inline fn vaddd_s64(a: i64, b: i64) i64 { return a +% b; }
pub inline fn vaddd_u64(a: u64, b: u64) u64 { return a +% b; }

pub inline fn vaddq_s8(a: i8x16, b: i8x16) i8x16 { return a +% b; }
pub inline fn vaddq_s16(a: i16x8, b: i16x8) i16x8 { return a +% b; }
pub inline fn vaddq_s32(a: i32x4, b: i32x4) i32x4 { return a +% b; }
pub inline fn vaddq_s64(a: i64x2, b: i64x2) i64x2 { return a +% b; }
pub inline fn vaddq_u8(a: u8x16, b: u8x16) u8x16 { return a +% b; }
pub inline fn vaddq_u16(a: u16x8, b: u16x8) u16x8 { return a +% b; }
pub inline fn vaddq_u32(a: u32x4, b: u32x4) u32x4 { return a +% b; }
pub inline fn vaddq_u64(a: u64x2, b: u64x2) u64x2 { return a +% b; }
pub inline fn vaddq_f16(a: f16x8, b: f16x8) f16x8 { return a + b; }
pub inline fn vaddq_f32(a: f32x4, b: f32x4) f32x4 { return a + b; }
pub inline fn vaddq_f64(a: f64x2, b: f64x2) f64x2 { return a + b; }
pub inline fn vaddq_p8(a: p8x16, b: p8x16) p8x16 { return a ^ b; }
pub inline fn vaddq_p16(a: p16x8, b: p16x8) p16x8 { return a ^ b; }
pub inline fn vaddq_p64(a: p64x2, b: p64x2) p64x2 { return a ^ b; }
pub inline fn vaddq_p128(a: @Vector(1, p128), b: @Vector(1, p128)) @Vector(1, p128) { return a ^ b; }

// --- Vector Sub (Wrapping / Float) ---
pub inline fn vsub_s8(a: i8x8, b: i8x8) i8x8 { return a -% b; }
pub inline fn vsub_s16(a: i16x4, b: i16x4) i16x4 { return a -% b; }
pub inline fn vsub_s32(a: i32x2, b: i32x2) i32x2 { return a -% b; }
pub inline fn vsub_s64(a: i64x1, b: i64x1) i64x1 { return a -% b; }
pub inline fn vsub_u8(a: u8x8, b: u8x8) u8x8 { return a -% b; }
pub inline fn vsub_u16(a: u16x4, b: u16x4) u16x4 { return a -% b; }
pub inline fn vsub_u32(a: u32x2, b: u32x2) u32x2 { return a -% b; }
pub inline fn vsub_u64(a: u64x1, b: u64x1) u64x1 { return a -% b; }
pub inline fn vsub_f16(a: f16x4, b: f16x4) f16x4 { return a - b; }
pub inline fn vsub_f32(a: f32x2, b: f32x2) f32x2 { return a - b; }
pub inline fn vsub_f64(a: f64x1, b: f64x1) f64x1 { return a - b; }

pub inline fn vsubq_s8(a: i8x16, b: i8x16) i8x16 { return a -% b; }
pub inline fn vsubq_s16(a: i16x8, b: i16x8) i16x8 { return a -% b; }
pub inline fn vsubq_s32(a: i32x4, b: i32x4) i32x4 { return a -% b; }
pub inline fn vsubq_s64(a: i64x2, b: i64x2) i64x2 { return a -% b; }
pub inline fn vsubq_u8(a: u8x16, b: u8x16) u8x16 { return a -% b; }
pub inline fn vsubq_u16(a: u16x8, b: u16x8) u16x8 { return a -% b; }
pub inline fn vsubq_u32(a: u32x4, b: u32x4) u32x4 { return a -% b; }
pub inline fn vsubq_u64(a: u64x2, b: u64x2) u64x2 { return a -% b; }
pub inline fn vsubq_f16(a: f16x8, b: f16x8) f16x8 { return a - b; }
pub inline fn vsubq_f32(a: f32x4, b: f32x4) f32x4 { return a - b; }
pub inline fn vsubq_f64(a: f64x2, b: f64x2) f64x2 { return a - b; }

// --- Vector Negate ---
pub inline fn vneg_s8(a: i8x8) i8x8 { return -%a; }
pub inline fn vneg_s16(a: i16x4) i16x4 { return -%a; }
pub inline fn vneg_s32(a: i32x2) i32x2 { return -%a; }
pub inline fn vneg_s64(a: i64x1) i64x1 { return -%a; }
pub inline fn vneg_f16(a: f16x4) f16x4 { return -a; }
pub inline fn vneg_f32(a: f32x2) f32x2 { return -a; }
pub inline fn vneg_f64(a: f64x1) f64x1 { return -a; }

pub inline fn vnegq_s8(a: i8x16) i8x16 { return -%a; }
pub inline fn vnegq_s16(a: i16x8) i16x8 { return -%a; }
pub inline fn vnegq_s32(a: i32x4) i32x4 { return -%a; }
pub inline fn vnegq_s64(a: i64x2) i64x2 { return -%a; }
pub inline fn vnegq_f16(a: f16x8) f16x8 { return -a; }
pub inline fn vnegq_f32(a: f32x4) f32x4 { return -a; }
pub inline fn vnegq_f64(a: f64x2) f64x2 { return -a; }

// --- Vector Absolute Value ---
pub inline fn vabs_s8(a: i8x8) i8x8 { return @bitCast(@abs(a)); }
pub inline fn vabs_s16(a: i16x4) i16x4 { return @bitCast(@abs(a)); }
pub inline fn vabs_s32(a: i32x2) i32x2 { return @bitCast(@abs(a)); }
pub inline fn vabs_s64(a: i64x1) i64x1 { return @bitCast(@abs(a)); }
pub inline fn vabs_f16(a: f16x4) f16x4 { return @abs(a); }
pub inline fn vabs_f32(a: f32x2) f32x2 { return @abs(a); }
pub inline fn vabs_f64(a: f64x1) f64x1 { return @abs(a); }
pub inline fn vabsd_s64(a: i64) i64 { return @bitCast(@abs(a)); }

pub inline fn vabsq_s8(a: i8x16) i8x16 { return @bitCast(@abs(a)); }
pub inline fn vabsq_s16(a: i16x8) i16x8 { return @bitCast(@abs(a)); }
pub inline fn vabsq_s32(a: i32x4) i32x4 { return @bitCast(@abs(a)); }
pub inline fn vabsq_s64(a: i64x2) i64x2 { return @bitCast(@abs(a)); }
pub inline fn vabsq_f16(a: f16x8) f16x8 { return @abs(a); }
pub inline fn vabsq_f32(a: f32x4) f32x4 { return @abs(a); }
pub inline fn vabsq_f64(a: f64x2) f64x2 { return @abs(a); }

// --- Absolute Difference ---
pub inline fn vabd_s8(a: i8x8, b: i8x8) i8x8 { return common.abdGeneric(a, b); }
pub inline fn vabd_s16(a: i16x4, b: i16x4) i16x4 { return common.abdGeneric(a, b); }
pub inline fn vabd_s32(a: i32x2, b: i32x2) i32x2 { return common.abdGeneric(a, b); }
pub inline fn vabd_u8(a: u8x8, b: u8x8) u8x8 { return common.abdGeneric(a, b); }
pub inline fn vabd_u16(a: u16x4, b: u16x4) u16x4 { return common.abdGeneric(a, b); }
pub inline fn vabd_u32(a: u32x2, b: u32x2) u32x2 { return common.abdGeneric(a, b); }
pub inline fn vabd_f16(a: f16x4, b: f16x4) f16x4 { return common.abdGeneric(a, b); }
pub inline fn vabd_f32(a: f32x2, b: f32x2) f32x2 { return common.abdGeneric(a, b); }
pub inline fn vabd_f64(a: f64x1, b: f64x1) f64x1 { return common.abdGeneric(a, b); }
pub inline fn vabds_f32(a: f32, b: f32) f32 { return @abs(a - b); }
pub inline fn vabdd_f64(a: f64, b: f64) f64 { return @abs(a - b); }

pub inline fn vabdq_s8(a: i8x16, b: i8x16) i8x16 { return common.abdGeneric(a, b); }
pub inline fn vabdq_s16(a: i16x8, b: i16x8) i16x8 { return common.abdGeneric(a, b); }
pub inline fn vabdq_s32(a: i32x4, b: i32x4) i32x4 { return common.abdGeneric(a, b); }
pub inline fn vabdq_u8(a: u8x16, b: u8x16) u8x16 { return common.abdGeneric(a, b); }
pub inline fn vabdq_u16(a: u16x8, b: u16x8) u16x8 { return common.abdGeneric(a, b); }
pub inline fn vabdq_u32(a: u32x4, b: u32x4) u32x4 { return common.abdGeneric(a, b); }
pub inline fn vabdq_f16(a: f16x8, b: f16x8) f16x8 { return common.abdGeneric(a, b); }
pub inline fn vabdq_f32(a: f32x4, b: f32x4) f32x4 { return common.abdGeneric(a, b); }
pub inline fn vabdq_f64(a: f64x2, b: f64x2) f64x2 { return common.abdGeneric(a, b); }

// --- Absolute Difference Long (Widen) ---
pub inline fn vabdl_s8(a: i8x8, b: i8x8) i16x8 {
    const a16: i16x8 = a;
    const b16: i16x8 = b;
    return @intCast(@abs(a16 - b16));
}
pub inline fn vabdl_s16(a: i16x4, b: i16x4) i32x4 {
    const a32: i32x4 = a;
    const b32: i32x4 = b;
    return @intCast(@abs(a32 - b32));
}
pub inline fn vabdl_s32(a: i32x2, b: i32x2) i64x2 {
    const a64: i64x2 = a;
    const b64: i64x2 = b;
    return @intCast(@abs(a64 - b64));
}
pub inline fn vabdl_u8(a: u8x8, b: u8x8) u16x8 {
    const a16: u16x8 = a;
    const b16: u16x8 = b;
    return @max(a16, b16) - @min(a16, b16);
}
pub inline fn vabdl_u16(a: u16x4, b: u16x4) u32x4 {
    const a32: u32x4 = a;
    const b32: u32x4 = b;
    return @max(a32, b32) - @min(a32, b32);
}
pub inline fn vabdl_u32(a: u32x2, b: u32x2) u64x2 {
    const a64: u64x2 = a;
    const b64: u64x2 = b;
    return @max(a64, b64) - @min(a64, b64);
}

// --- Absolute Difference and Accumulate ---
pub inline fn vaba_s8(a: i8x8, b: i8x8, c: i8x8) i8x8 { return a +% vabd_s8(b, c); }
pub inline fn vaba_s16(a: i16x4, b: i16x4, c: i16x4) i16x4 { return a +% vabd_s16(b, c); }
pub inline fn vaba_s32(a: i32x2, b: i32x2, c: i32x2) i32x2 { return a +% vabd_s32(b, c); }
pub inline fn vaba_u8(a: u8x8, b: u8x8, c: u8x8) u8x8 { return a +% vabd_u8(b, c); }
pub inline fn vaba_u16(a: u16x4, b: u16x4, c: u16x4) u16x4 { return a +% vabd_u16(b, c); }
pub inline fn vaba_u32(a: u32x2, b: u32x2, c: u32x2) u32x2 { return a +% vabd_u32(b, c); }

pub inline fn vabaq_s8(a: i8x16, b: i8x16, c: i8x16) i8x16 { return a +% vabdq_s8(b, c); }
pub inline fn vabaq_s16(a: i16x8, b: i16x8, c: i16x8) i16x8 { return a +% vabdq_s16(b, c); }
pub inline fn vabaq_s32(a: i32x4, b: i32x4, c: i32x4) i32x4 { return a +% vabdq_s32(b, c); }
pub inline fn vabaq_u8(a: u8x16, b: u8x16, c: u8x16) u8x16 { return a +% vabdq_u8(b, c); }
pub inline fn vabaq_u16(a: u16x8, b: u16x8, c: u16x8) u16x8 { return a +% vabdq_u16(b, c); }
pub inline fn vabaq_u32(a: u32x4, b: u32x4, c: u32x4) u32x4 { return a +% vabdq_u32(b, c); }

pub inline fn vabal_s8(a: i16x8, b: i8x8, c: i8x8) i16x8 { return a +% vabdl_s8(b, c); }
pub inline fn vabal_s16(a: i32x4, b: i16x4, c: i16x4) i32x4 { return a +% vabdl_s16(b, c); }
pub inline fn vabal_s32(a: i64x2, b: i32x2, c: i32x2) i64x2 { return a +% vabdl_s32(b, c); }
pub inline fn vabal_u8(a: u16x8, b: u8x8, c: u8x8) u16x8 { return a +% vabdl_u8(b, c); }
pub inline fn vabal_u16(a: u32x4, b: u16x4, c: u16x4) u32x4 { return a +% vabdl_u16(b, c); }
pub inline fn vabal_u32(a: u64x2, b: u32x2, c: u32x2) u64x2 { return a +% vabdl_u32(b, c); }

// --- Add Long (Widen) ---
pub inline fn vaddl_s8(a: i8x8, b: i8x8) i16x8 { const a_w: i16x8 = a; const b_w: i16x8 = b; return a_w +% b_w; }
pub inline fn vaddl_s16(a: i16x4, b: i16x4) i32x4 { const a_w: i32x4 = a; const b_w: i32x4 = b; return a_w +% b_w; }
pub inline fn vaddl_s32(a: i32x2, b: i32x2) i64x2 { const a_w: i64x2 = a; const b_w: i64x2 = b; return a_w +% b_w; }
pub inline fn vaddl_u8(a: u8x8, b: u8x8) u16x8 { const a_w: u16x8 = a; const b_w: u16x8 = b; return a_w +% b_w; }
pub inline fn vaddl_u16(a: u16x4, b: u16x4) u32x4 { const a_w: u32x4 = a; const b_w: u32x4 = b; return a_w +% b_w; }
pub inline fn vaddl_u32(a: u32x2, b: u32x2) u64x2 { const a_w: u64x2 = a; const b_w: u64x2 = b; return a_w +% b_w; }

// --- Add Wide ---
pub inline fn vaddw_s8(a: i16x8, b: i8x8) i16x8 { const b_w: i16x8 = b; return a +% b_w; }
pub inline fn vaddw_s16(a: i32x4, b: i16x4) i32x4 { const b_w: i32x4 = b; return a +% b_w; }
pub inline fn vaddw_s32(a: i64x2, b: i32x2) i64x2 { const b_w: i64x2 = b; return a +% b_w; }
pub inline fn vaddw_u8(a: u16x8, b: u8x8) u16x8 { const b_w: u16x8 = b; return a +% b_w; }
pub inline fn vaddw_u16(a: u32x4, b: u16x4) u32x4 { const b_w: u32x4 = b; return a +% b_w; }
pub inline fn vaddw_u32(a: u64x2, b: u32x2) u64x2 { const b_w: u64x2 = b; return a +% b_w; }

// --- Add Narrow (Truncate High Part) ---
pub inline fn vaddhn_s16(a: i16x8, b: i16x8) i8x8 {
    const sum = a +% b;
    var res: i8x8 = undefined;
    inline for (0..8) |i| res[i] = @truncate(sum[i] >> 8);
    return res;
}
pub inline fn vaddhn_s32(a: i32x4, b: i32x4) i16x4 {
    const sum = a +% b;
    var res: i16x4 = undefined;
    inline for (0..4) |i| res[i] = @truncate(sum[i] >> 16);
    return res;
}
pub inline fn vaddhn_s64(a: i64x2, b: i64x2) i32x2 {
    const sum = a +% b;
    var res: i32x2 = undefined;
    inline for (0..2) |i| res[i] = @truncate(sum[i] >> 32);
    return res;
}
pub inline fn vaddhn_u16(a: u16x8, b: u16x8) u8x8 {
    const sum = a +% b;
    var res: u8x8 = undefined;
    inline for (0..8) |i| res[i] = @truncate(sum[i] >> 8);
    return res;
}
pub inline fn vaddhn_u32(a: u32x4, b: u32x4) u16x4 {
    const sum = a +% b;
    var res: u16x4 = undefined;
    inline for (0..4) |i| res[i] = @truncate(sum[i] >> 16);
    return res;
}
pub inline fn vaddhn_u64(a: u64x2, b: u64x2) u32x2 {
    const sum = a +% b;
    var res: u32x2 = undefined;
    inline for (0..2) |i| res[i] = @truncate(sum[i] >> 32);
    return res;
}

// --- Vector Multiply ---
pub inline fn vmul_s8(a: i8x8, b: i8x8) i8x8 { return a *% b; }
pub inline fn vmul_s16(a: i16x4, b: i16x4) i16x4 { return a *% b; }
pub inline fn vmul_s32(a: i32x2, b: i32x2) i32x2 { return a *% b; }
pub inline fn vmul_u8(a: u8x8, b: u8x8) u8x8 { return a *% b; }
pub inline fn vmul_u16(a: u16x4, b: u16x4) u16x4 { return a *% b; }
pub inline fn vmul_u32(a: u32x2, b: u32x2) u32x2 { return a *% b; }
pub inline fn vmul_f16(a: f16x4, b: f16x4) f16x4 { return a * b; }
pub inline fn vmul_f32(a: f32x2, b: f32x2) f32x2 { return a * b; }
pub inline fn vmul_f64(a: f64x1, b: f64x1) f64x1 { return a * b; }

pub inline fn vmulq_s8(a: i8x16, b: i8x16) i8x16 { return a *% b; }
pub inline fn vmulq_s16(a: i16x8, b: i16x8) i16x8 { return a *% b; }
pub inline fn vmulq_s32(a: i32x4, b: i32x4) i32x4 { return a *% b; }
pub inline fn vmulq_u8(a: u8x16, b: u8x16) u8x16 { return a *% b; }
pub inline fn vmulq_u16(a: u16x8, b: u16x8) u16x8 { return a *% b; }
pub inline fn vmulq_u32(a: u32x4, b: u32x4) u32x4 { return a *% b; }
pub inline fn vmulq_f16(a: f16x8, b: f16x8) f16x8 { return a * b; }
pub inline fn vmulq_f32(a: f32x4, b: f32x4) f32x4 { return a * b; }
pub inline fn vmulq_f64(a: f64x2, b: f64x2) f64x2 { return a * b; }

// --- Vector Multiply Long (Widen) ---
pub inline fn vmull_s8(a: i8x8, b: i8x8) i16x8 { const a_w: i16x8 = a; const b_w: i16x8 = b; return a_w *% b_w; }
pub inline fn vmull_s16(a: i16x4, b: i16x4) i32x4 { const a_w: i32x4 = a; const b_w: i32x4 = b; return a_w *% b_w; }
pub inline fn vmull_s32(a: i32x2, b: i32x2) i64x2 { const a_w: i64x2 = a; const b_w: i64x2 = b; return a_w *% b_w; }
pub inline fn vmull_u8(a: u8x8, b: u8x8) u16x8 { const a_w: u16x8 = a; const b_w: u16x8 = b; return a_w *% b_w; }
pub inline fn vmull_u16(a: u16x4, b: u16x4) u32x4 { const a_w: u32x4 = a; const b_w: u32x4 = b; return a_w *% b_w; }
pub inline fn vmull_u32(a: u32x2, b: u32x2) u64x2 { const a_w: u64x2 = a; const b_w: u64x2 = b; return a_w *% b_w; }

// --- Vector Multiply Accumulate (VMLA) & Subtract (VMLS) ---
pub inline fn vmla_s8(a: i8x8, b: i8x8, c: i8x8) i8x8 { return a +% (b *% c); }
pub inline fn vmla_s16(a: i16x4, b: i16x4, c: i16x4) i16x4 { return a +% (b *% c); }
pub inline fn vmla_s32(a: i32x2, b: i32x2, c: i32x2) i32x2 { return a +% (b *% c); }
pub inline fn vmla_u8(a: u8x8, b: u8x8, c: u8x8) u8x8 { return a +% (b *% c); }
pub inline fn vmla_u16(a: u16x4, b: u16x4, c: u16x4) u16x4 { return a +% (b *% c); }
pub inline fn vmla_u32(a: u32x2, b: u32x2, c: u32x2) u32x2 { return a +% (b *% c); }
pub inline fn vmla_f16(a: f16x4, b: f16x4, c: f16x4) f16x4 { return a + (b * c); }
pub inline fn vmla_f32(a: f32x2, b: f32x2, c: f32x2) f32x2 { return a + (b * c); }

pub inline fn vmlaq_s8(a: i8x16, b: i8x16, c: i8x16) i8x16 { return a +% (b *% c); }
pub inline fn vmlaq_s16(a: i16x8, b: i16x8, c: i16x8) i16x8 { return a +% (b *% c); }
pub inline fn vmlaq_s32(a: i32x4, b: i32x4, c: i32x4) i32x4 { return a +% (b *% c); }
pub inline fn vmlaq_u8(a: u8x16, b: u8x16, c: u8x16) u8x16 { return a +% (b *% c); }
pub inline fn vmlaq_u16(a: u16x8, b: u16x8, c: u16x8) u16x8 { return a +% (b *% c); }
pub inline fn vmlaq_u32(a: u32x4, b: u32x4, c: u32x4) u32x4 { return a +% (b *% c); }
pub inline fn vmlaq_f16(a: f16x8, b: f16x8, c: f16x8) f16x8 { return a + (b * c); }
pub inline fn vmlaq_f32(a: f32x4, b: f32x4, c: f32x4) f32x4 { return a + (b * c); }
pub inline fn vmlaq_f64(a: f64x2, b: f64x2, c: f64x2) f64x2 { return a + (b * c); }

pub inline fn vmls_s8(a: i8x8, b: i8x8, c: i8x8) i8x8 { return a -% (b *% c); }
pub inline fn vmls_s16(a: i16x4, b: i16x4, c: i16x4) i16x4 { return a -% (b *% c); }
pub inline fn vmls_s32(a: i32x2, b: i32x2, c: i32x2) i32x2 { return a -% (b *% c); }
pub inline fn vmls_u8(a: u8x8, b: u8x8, c: u8x8) u8x8 { return a -% (b *% c); }
pub inline fn vmls_u16(a: u16x4, b: u16x4, c: u16x4) u16x4 { return a -% (b *% c); }
pub inline fn vmls_u32(a: u32x2, b: u32x2, c: u32x2) u32x2 { return a -% (b *% c); }
pub inline fn vmls_f16(a: f16x4, b: f16x4, c: f16x4) f16x4 { return a - (b * c); }
pub inline fn vmls_f32(a: f32x2, b: f32x2, c: f32x2) f32x2 { return a - (b * c); }

pub inline fn vmlsq_s8(a: i8x16, b: i8x16, c: i8x16) i8x16 { return a -% (b *% c); }
pub inline fn vmlsq_s16(a: i16x8, b: i16x8, c: i16x8) i16x8 { return a -% (b *% c); }
pub inline fn vmlsq_s32(a: i32x4, b: i32x4, c: i32x4) i32x4 { return a -% (b *% c); }
pub inline fn vmlsq_u8(a: u8x16, b: u8x16, c: u8x16) u8x16 { return a -% (b *% c); }
pub inline fn vmlsq_u16(a: u16x8, b: u16x8, c: u16x8) u16x8 { return a -% (b *% c); }
pub inline fn vmlsq_u32(a: u32x4, b: u32x4, c: u32x4) u32x4 { return a -% (b *% c); }
pub inline fn vmlsq_f16(a: f16x8, b: f16x8, c: f16x8) f16x8 { return a - (b * c); }
pub inline fn vmlsq_f32(a: f32x4, b: f32x4, c: f32x4) f32x4 { return a - (b * c); }
pub inline fn vmlsq_f64(a: f64x2, b: f64x2, c: f64x2) f64x2 { return a - (b * c); }

// --- Fused Multiply-Add (FMA) & Subtract (FMS) ---
pub inline fn vfma_f16(a: f16x4, b: f16x4, c: f16x4) f16x4 { return @mulAdd(f16x4, b, c, a); }
pub inline fn vfma_f32(a: f32x2, b: f32x2, c: f32x2) f32x2 { return @mulAdd(f32x2, b, c, a); }
pub inline fn vfma_f64(a: f64x1, b: f64x1, c: f64x1) f64x1 { return @mulAdd(f64x1, b, c, a); }

pub inline fn vfmaq_f16(a: f16x8, b: f16x8, c: f16x8) f16x8 { return @mulAdd(f16x8, b, c, a); }
pub inline fn vfmaq_f32(a: f32x4, b: f32x4, c: f32x4) f32x4 { return @mulAdd(f32x4, b, c, a); }
pub inline fn vfmaq_f64(a: f64x2, b: f64x2, c: f64x2) f64x2 { return @mulAdd(f64x2, b, c, a); }

pub inline fn vfms_f16(a: f16x4, b: f16x4, c: f16x4) f16x4 { return @mulAdd(f16x4, -b, c, a); }
pub inline fn vfms_f32(a: f32x2, b: f32x2, c: f32x2) f32x2 { return @mulAdd(f32x2, -b, c, a); }
pub inline fn vfms_f64(a: f64x1, b: f64x1, c: f64x1) f64x1 { return @mulAdd(f64x1, -b, c, a); }

pub inline fn vfmsq_f16(a: f16x8, b: f16x8, c: f16x8) f16x8 { return @mulAdd(f16x8, -b, c, a); }
pub inline fn vfmsq_f32(a: f32x4, b: f32x4, c: f32x4) f32x4 { return @mulAdd(f32x4, -b, c, a); }
pub inline fn vfmsq_f64(a: f64x2, b: f64x2, c: f64x2) f64x2 { return @mulAdd(f64x2, -b, c, a); }

// --- FMA with Lane ---
pub inline fn vfmaq_laneq_f16(a: f16x8, b: f16x8, c: f16x8, comptime lane: usize) f16x8 {
    const lane_vec: f16x8 = @splat(c[lane]);
    return @mulAdd(f16x8, b, lane_vec, a);
}
pub inline fn vfmaq_laneq_f32(a: f32x4, b: f32x4, c: f32x4, comptime lane: usize) f32x4 {
    const lane_vec: f32x4 = @splat(c[lane]);
    return @mulAdd(f32x4, b, lane_vec, a);
}
pub inline fn vfmaq_laneq_f64(a: f64x2, b: f64x2, c: f64x2, comptime lane: usize) f64x2 {
    const lane_vec: f64x2 = @splat(c[lane]);
    return @mulAdd(f64x2, b, lane_vec, a);
}

// --- Saturating Add & Sub (VQADD / VQSUB) ---
pub inline fn vqadd_s8(a: i8x8, b: i8x8) i8x8 { return a +| b; }
pub inline fn vqadd_s16(a: i16x4, b: i16x4) i16x4 { return a +| b; }
pub inline fn vqadd_s32(a: i32x2, b: i32x2) i32x2 { return a +| b; }
pub inline fn vqadd_s64(a: i64x1, b: i64x1) i64x1 { return a +| b; }
pub inline fn vqadd_u8(a: u8x8, b: u8x8) u8x8 { return a +| b; }
pub inline fn vqadd_u16(a: u16x4, b: u16x4) u16x4 { return a +| b; }
pub inline fn vqadd_u32(a: u32x2, b: u32x2) u32x2 { return a +| b; }
pub inline fn vqadd_u64(a: u64x1, b: u64x1) u64x1 { return a +| b; }

pub inline fn vqaddq_s8(a: i8x16, b: i8x16) i8x16 { return a +| b; }
pub inline fn vqaddq_s16(a: i16x8, b: i16x8) i16x8 { return a +| b; }
pub inline fn vqaddq_s32(a: i32x4, b: i32x4) i32x4 { return a +| b; }
pub inline fn vqaddq_s64(a: i64x2, b: i64x2) i64x2 { return a +| b; }
pub inline fn vqaddq_u8(a: u8x16, b: u8x16) u8x16 { return a +| b; }
pub inline fn vqaddq_u16(a: u16x8, b: u16x8) u16x8 { return a +| b; }
pub inline fn vqaddq_u32(a: u32x4, b: u32x4) u32x4 { return a +| b; }
pub inline fn vqaddq_u64(a: u64x2, b: u64x2) u64x2 { return a +| b; }

pub inline fn vqsub_s8(a: i8x8, b: i8x8) i8x8 { return a -| b; }
pub inline fn vqsub_s16(a: i16x4, b: i16x4) i16x4 { return a -| b; }
pub inline fn vqsub_s32(a: i32x2, b: i32x2) i32x2 { return a -| b; }
pub inline fn vqsub_s64(a: i64x1, b: i64x1) i64x1 { return a -| b; }
pub inline fn vqsub_u8(a: u8x8, b: u8x8) u8x8 { return a -| b; }
pub inline fn vqsub_u16(a: u16x4, b: u16x4) u16x4 { return a -| b; }
pub inline fn vqsub_u32(a: u32x2, b: u32x2) u32x2 { return a -| b; }
pub inline fn vqsub_u64(a: u64x1, b: u64x1) u64x1 { return a -| b; }

pub inline fn vqsubq_s8(a: i8x16, b: i8x16) i8x16 { return a -| b; }
pub inline fn vqsubq_s16(a: i16x8, b: i16x8) i16x8 { return a -| b; }
pub inline fn vqsubq_s32(a: i32x4, b: i32x4) i32x4 { return a -| b; }
pub inline fn vqsubq_s64(a: i64x2, b: i64x2) i64x2 { return a -| b; }
pub inline fn vqsubq_u8(a: u8x16, b: u8x16) u8x16 { return a -| b; }
pub inline fn vqsubq_u16(a: u16x8, b: u16x8) u16x8 { return a -| b; }
pub inline fn vqsubq_u32(a: u32x4, b: u32x4) u32x4 { return a -| b; }
pub inline fn vqsubq_u64(a: u64x2, b: u64x2) u64x2 { return a -| b; }

pub inline fn vqsubs_s32(a: i32, b: i32) i32 {
    const diff: i64 = @as(i64, a) - @as(i64, b);
    return @intCast(std.math.clamp(diff, std.math.minInt(i32), std.math.maxInt(i32)));
}
pub inline fn vqsubs_u32(a: u32, b: u32) u32 {
    if (a < b) return 0;
    return a - b;
}
pub inline fn vqsubd_s64(a: i64, b: i64) i64 {
    const diff: i128 = @as(i128, a) - @as(i128, b);
    return @intCast(std.math.clamp(diff, std.math.minInt(i64), std.math.maxInt(i64)));
}
pub inline fn vqsubd_u64(a: u64, b: u64) u64 {
    if (a < b) return 0;
    return a - b;
}

// --- Saturating Doubling Multiply ---
pub inline fn vqdmull_s16(a: i16x4, b: i16x4) i32x4 {
    if (comptime @import("builtin").cpu.arch == .aarch64)
        return asm ("sqdmull %[res].4s, %[a].4h, %[b].4h" : [res] "=w" (-> i32x4) : [a] "w" (a), [b] "w" (b));
    var res: i32x4 = undefined;
    inline for (0..4) |i| {
        const prod: i64 = @as(i64, a[i]) * @as(i64, b[i]) * 2;
        res[i] = @intCast(std.math.clamp(prod, std.math.minInt(i32), std.math.maxInt(i32)));
    }
    return res;
}
pub inline fn vqdmull_s32(a: i32x2, b: i32x2) i64x2 {
    if (comptime @import("builtin").cpu.arch == .aarch64)
        return asm ("sqdmull %[res].2d, %[a].2s, %[b].2s" : [res] "=w" (-> i64x2) : [a] "w" (a), [b] "w" (b));
    var res: i64x2 = undefined;
    inline for (0..2) |i| {
        const prod: i128 = @as(i128, a[i]) * @as(i128, b[i]) * 2;
        res[i] = @intCast(std.math.clamp(prod, std.math.minInt(i64), std.math.maxInt(i64)));
    }
    return res;
}
pub inline fn vqdmullh_s16(a: i16, b: i16) i32 {
    if (comptime @import("builtin").cpu.arch == .aarch64) {
        const va: @Vector(4, i16) = .{a, 0, 0, 0};
        const vb: @Vector(4, i16) = .{b, 0, 0, 0};
        const vres = asm ("sqdmull %[res].4s, %[a].4h, %[b].4h" : [res] "=w" (-> i32x4) : [a] "w" (va), [b] "w" (vb));
        return vres[0];
    }
    const prod: i64 = @as(i64, a) * @as(i64, b) * 2;
    return @intCast(std.math.clamp(prod, std.math.minInt(i32), std.math.maxInt(i32)));
}
pub inline fn vqdmulls_s32(a: i32, b: i32) i64 {
    if (comptime @import("builtin").cpu.arch == .aarch64) {
        const va: @Vector(2, i32) = .{a, 0};
        const vb: @Vector(2, i32) = .{b, 0};
        const vres = asm ("sqdmull %[res].2d, %[a].2s, %[b].2s" : [res] "=w" (-> i64x2) : [a] "w" (va), [b] "w" (vb));
        return vres[0];
    }
    const prod: i128 = @as(i128, a) * @as(i128, b) * 2;
    return @intCast(std.math.clamp(prod, std.math.minInt(i64), std.math.maxInt(i64)));
}

test "arithmetic intrinsics" {
    const a: i32x4 = .{ 1, 2, 3, 4 };
    const b: i32x4 = .{ 5, 6, 7, 8 };
    const sum = vaddq_s32(a, b);
    try std.testing.expectEqual(i32x4{ 6, 8, 10, 12 }, sum);

    const f1: f32x4 = .{ 1.0, 2.0, 3.0, 4.0 };
    const f2: f32x4 = .{ 2.0, 3.0, 4.0, 5.0 };
    const f3: f32x4 = .{ 0.5, 0.5, 0.5, 0.5 };
    const fma = vfmaq_f32(f3, f1, f2);
    try std.testing.expectEqual(f32x4{ 2.5, 6.5, 12.5, 20.5 }, fma);
}
