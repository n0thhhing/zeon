const neon = @import("../src/zeon.zig");
const std = @import("std");

export fn check_vshr_n_s8(arg0: neon.i8x8) neon.i8x8 {
    return neon.vshr_n_s8(arg0, 0);
}

export fn check_vshr_n_s16(arg0: *const neon.i16x4, out_ptr: *neon.i16x4) void {
    out_ptr.* = neon.vshr_n_s16(arg0.*, 0);
}

export fn check_vshr_n_s32(arg0: *const neon.i32x2, out_ptr: *neon.i32x2) void {
    out_ptr.* = neon.vshr_n_s32(arg0.*, 0);
}

export fn check_vshr_n_s64(arg0: neon.i64x1) neon.i64x1 {
    return neon.vshr_n_s64(arg0, 0);
}

export fn check_vshr_n_u8(arg0: neon.u8x8) neon.u8x8 {
    return neon.vshr_n_u8(arg0, 0);
}

export fn check_vshr_n_u16(arg0: *const neon.u16x4, out_ptr: *neon.u16x4) void {
    out_ptr.* = neon.vshr_n_u16(arg0.*, 0);
}

export fn check_vshr_n_u32(arg0: *const neon.u32x2, out_ptr: *neon.u32x2) void {
    out_ptr.* = neon.vshr_n_u32(arg0.*, 0);
}

export fn check_vshr_n_u64(arg0: neon.u64x1) neon.u64x1 {
    return neon.vshr_n_u64(arg0, 0);
}

export fn check_vshrq_n_s8(arg0: neon.i8x16) neon.i8x16 {
    return neon.vshrq_n_s8(arg0, 0);
}

export fn check_vshrq_n_s16(arg0: neon.i16x8) neon.i16x8 {
    return neon.vshrq_n_s16(arg0, 0);
}

export fn check_vshrq_n_s32(arg0: *const neon.i32x4, out_ptr: *neon.i32x4) void {
    out_ptr.* = neon.vshrq_n_s32(arg0.*, 0);
}

export fn check_vshrq_n_s64(arg0: *const neon.i64x2, out_ptr: *neon.i64x2) void {
    out_ptr.* = neon.vshrq_n_s64(arg0.*, 0);
}

export fn check_vshrq_n_u8(arg0: neon.u8x16) neon.u8x16 {
    return neon.vshrq_n_u8(arg0, 0);
}

export fn check_vshrq_n_u16(arg0: neon.u16x8) neon.u16x8 {
    return neon.vshrq_n_u16(arg0, 0);
}

export fn check_vshrq_n_u32(arg0: *const neon.u32x4, out_ptr: *neon.u32x4) void {
    out_ptr.* = neon.vshrq_n_u32(arg0.*, 0);
}

export fn check_vshrq_n_u64(arg0: *const neon.u64x2, out_ptr: *neon.u64x2) void {
    out_ptr.* = neon.vshrq_n_u64(arg0.*, 0);
}

export fn check_vshl_n_s8(arg0: neon.i8x8) neon.i8x8 {
    return neon.vshl_n_s8(arg0, 0);
}

export fn check_vshl_n_s16(arg0: *const neon.i16x4, out_ptr: *neon.i16x4) void {
    out_ptr.* = neon.vshl_n_s16(arg0.*, 0);
}

export fn check_vshl_n_s32(arg0: *const neon.i32x2, out_ptr: *neon.i32x2) void {
    out_ptr.* = neon.vshl_n_s32(arg0.*, 0);
}

export fn check_vshl_n_s64(arg0: neon.i64x1) neon.i64x1 {
    return neon.vshl_n_s64(arg0, 0);
}

export fn check_vshl_n_u8(arg0: neon.u8x8) neon.u8x8 {
    return neon.vshl_n_u8(arg0, 0);
}

export fn check_vshl_n_u16(arg0: *const neon.u16x4, out_ptr: *neon.u16x4) void {
    out_ptr.* = neon.vshl_n_u16(arg0.*, 0);
}

export fn check_vshl_n_u32(arg0: *const neon.u32x2, out_ptr: *neon.u32x2) void {
    out_ptr.* = neon.vshl_n_u32(arg0.*, 0);
}

export fn check_vshl_n_u64(arg0: neon.u64x1) neon.u64x1 {
    return neon.vshl_n_u64(arg0, 0);
}

export fn check_vshlq_n_s8(arg0: neon.i8x16) neon.i8x16 {
    return neon.vshlq_n_s8(arg0, 0);
}

export fn check_vshlq_n_s16(arg0: neon.i16x8) neon.i16x8 {
    return neon.vshlq_n_s16(arg0, 0);
}

export fn check_vshlq_n_s32(arg0: *const neon.i32x4, out_ptr: *neon.i32x4) void {
    out_ptr.* = neon.vshlq_n_s32(arg0.*, 0);
}

export fn check_vshlq_n_s64(arg0: *const neon.i64x2, out_ptr: *neon.i64x2) void {
    out_ptr.* = neon.vshlq_n_s64(arg0.*, 0);
}

export fn check_vshlq_n_u8(arg0: neon.u8x16) neon.u8x16 {
    return neon.vshlq_n_u8(arg0, 0);
}

export fn check_vshlq_n_u16(arg0: neon.u16x8) neon.u16x8 {
    return neon.vshlq_n_u16(arg0, 0);
}

export fn check_vshlq_n_u32(arg0: *const neon.u32x4, out_ptr: *neon.u32x4) void {
    out_ptr.* = neon.vshlq_n_u32(arg0.*, 0);
}

export fn check_vshlq_n_u64(arg0: *const neon.u64x2, out_ptr: *neon.u64x2) void {
    out_ptr.* = neon.vshlq_n_u64(arg0.*, 0);
}

export fn check_vsra_n_s8(arg0: neon.i8x8, arg1: neon.i8x8) neon.i8x8 {
    return neon.vsra_n_s8(arg0, arg1, 0);
}

export fn check_vsra_n_s16(arg0: *const neon.i16x4, arg1: *const neon.i16x4, out_ptr: *neon.i16x4) void {
    out_ptr.* = neon.vsra_n_s16(arg0.*, arg1.*, 0);
}

export fn check_vsra_n_s32(arg0: *const neon.i32x2, arg1: *const neon.i32x2, out_ptr: *neon.i32x2) void {
    out_ptr.* = neon.vsra_n_s32(arg0.*, arg1.*, 0);
}

export fn check_vsra_n_s64(arg0: neon.i64x1, arg1: neon.i64x1) neon.i64x1 {
    return neon.vsra_n_s64(arg0, arg1, 0);
}

export fn check_vsra_n_u8(arg0: neon.u8x8, arg1: neon.u8x8) neon.u8x8 {
    return neon.vsra_n_u8(arg0, arg1, 0);
}

export fn check_vsra_n_u16(arg0: *const neon.u16x4, arg1: *const neon.u16x4, out_ptr: *neon.u16x4) void {
    out_ptr.* = neon.vsra_n_u16(arg0.*, arg1.*, 0);
}

export fn check_vsra_n_u32(arg0: *const neon.u32x2, arg1: *const neon.u32x2, out_ptr: *neon.u32x2) void {
    out_ptr.* = neon.vsra_n_u32(arg0.*, arg1.*, 0);
}

export fn check_vsra_n_u64(arg0: neon.u64x1, arg1: neon.u64x1) neon.u64x1 {
    return neon.vsra_n_u64(arg0, arg1, 0);
}

export fn check_vsraq_n_s8(arg0: neon.i8x16, arg1: neon.i8x16) neon.i8x16 {
    return neon.vsraq_n_s8(arg0, arg1, 0);
}

export fn check_vsraq_n_s16(arg0: neon.i16x8, arg1: neon.i16x8) neon.i16x8 {
    return neon.vsraq_n_s16(arg0, arg1, 0);
}

export fn check_vsraq_n_s32(arg0: *const neon.i32x4, arg1: *const neon.i32x4, out_ptr: *neon.i32x4) void {
    out_ptr.* = neon.vsraq_n_s32(arg0.*, arg1.*, 0);
}

export fn check_vsraq_n_s64(arg0: *const neon.i64x2, arg1: *const neon.i64x2, out_ptr: *neon.i64x2) void {
    out_ptr.* = neon.vsraq_n_s64(arg0.*, arg1.*, 0);
}

export fn check_vsraq_n_u8(arg0: neon.u8x16, arg1: neon.u8x16) neon.u8x16 {
    return neon.vsraq_n_u8(arg0, arg1, 0);
}

export fn check_vsraq_n_u16(arg0: neon.u16x8, arg1: neon.u16x8) neon.u16x8 {
    return neon.vsraq_n_u16(arg0, arg1, 0);
}

export fn check_vsraq_n_u32(arg0: *const neon.u32x4, arg1: *const neon.u32x4, out_ptr: *neon.u32x4) void {
    out_ptr.* = neon.vsraq_n_u32(arg0.*, arg1.*, 0);
}

export fn check_vsraq_n_u64(arg0: *const neon.u64x2, arg1: *const neon.u64x2, out_ptr: *neon.u64x2) void {
    out_ptr.* = neon.vsraq_n_u64(arg0.*, arg1.*, 0);
}

export fn check_vshrn_n_s16(arg0: neon.i16x8) neon.i8x8 {
    return neon.vshrn_n_s16(arg0, 0);
}

export fn check_vshrn_n_s32(arg0: *const neon.i32x4, out_ptr: *neon.i16x4) void {
    out_ptr.* = neon.vshrn_n_s32(arg0.*, 0);
}

export fn check_vshrn_n_s64(arg0: *const neon.i64x2, out_ptr: *neon.i32x2) void {
    out_ptr.* = neon.vshrn_n_s64(arg0.*, 0);
}

export fn check_vshrn_n_u16(arg0: neon.u16x8) neon.u8x8 {
    return neon.vshrn_n_u16(arg0, 0);
}

export fn check_vshrn_n_u32(arg0: *const neon.u32x4, out_ptr: *neon.u16x4) void {
    out_ptr.* = neon.vshrn_n_u32(arg0.*, 0);
}

export fn check_vshrn_n_u64(arg0: *const neon.u64x2, out_ptr: *neon.u32x2) void {
    out_ptr.* = neon.vshrn_n_u64(arg0.*, 0);
}

export fn check_vshl_s8(arg0: neon.i8x8, arg1: neon.i8x8) neon.i8x8 {
    return neon.vshl_s8(arg0, arg1);
}

export fn check_vshl_u8(arg0: neon.u8x8, arg1: neon.i8x8) neon.u8x8 {
    return neon.vshl_u8(arg0, arg1);
}

export fn check_vshlq_s8(arg0: neon.i8x16, arg1: neon.i8x16) neon.i8x16 {
    return neon.vshlq_s8(arg0, arg1);
}

export fn check_vshlq_u8(arg0: neon.u8x16, arg1: neon.i8x16) neon.u8x16 {
    return neon.vshlq_u8(arg0, arg1);
}

export fn check_vadd_s8(arg0: neon.i8x8, arg1: neon.i8x8) neon.i8x8 {
    return neon.vadd_s8(arg0, arg1);
}

export fn check_vadd_s16(arg0: *const neon.i16x4, arg1: *const neon.i16x4, out_ptr: *neon.i16x4) void {
    out_ptr.* = neon.vadd_s16(arg0.*, arg1.*);
}

export fn check_vadd_s32(arg0: *const neon.i32x2, arg1: *const neon.i32x2, out_ptr: *neon.i32x2) void {
    out_ptr.* = neon.vadd_s32(arg0.*, arg1.*);
}

export fn check_vadd_s64(arg0: neon.i64x1, arg1: neon.i64x1) neon.i64x1 {
    return neon.vadd_s64(arg0, arg1);
}

export fn check_vadd_u8(arg0: neon.u8x8, arg1: neon.u8x8) neon.u8x8 {
    return neon.vadd_u8(arg0, arg1);
}

export fn check_vadd_u16(arg0: *const neon.u16x4, arg1: *const neon.u16x4, out_ptr: *neon.u16x4) void {
    out_ptr.* = neon.vadd_u16(arg0.*, arg1.*);
}

export fn check_vadd_u32(arg0: *const neon.u32x2, arg1: *const neon.u32x2, out_ptr: *neon.u32x2) void {
    out_ptr.* = neon.vadd_u32(arg0.*, arg1.*);
}

export fn check_vadd_u64(arg0: neon.u64x1, arg1: neon.u64x1) neon.u64x1 {
    return neon.vadd_u64(arg0, arg1);
}

export fn check_vadd_f16(arg0: *const neon.f16x4, arg1: *const neon.f16x4, out_ptr: *neon.f16x4) void {
    out_ptr.* = neon.vadd_f16(arg0.*, arg1.*);
}

export fn check_vadd_f32(arg0: *const neon.f32x2, arg1: *const neon.f32x2, out_ptr: *neon.f32x2) void {
    out_ptr.* = neon.vadd_f32(arg0.*, arg1.*);
}

export fn check_vadd_f64(arg0: neon.f64x1, arg1: neon.f64x1) neon.f64x1 {
    return neon.vadd_f64(arg0, arg1);
}

export fn check_vadd_p8(arg0: neon.p8x8, arg1: neon.p8x8) neon.p8x8 {
    return neon.vadd_p8(arg0, arg1);
}

export fn check_vadd_p16(arg0: *const neon.p16x4, arg1: *const neon.p16x4, out_ptr: *neon.p16x4) void {
    out_ptr.* = neon.vadd_p16(arg0.*, arg1.*);
}

export fn check_vadd_p64(arg0: neon.p64x1, arg1: neon.p64x1) neon.p64x1 {
    return neon.vadd_p64(arg0, arg1);
}

export fn check_vaddd_s64(arg0: i64, arg1: i64) i64 {
    return neon.vaddd_s64(arg0, arg1);
}

export fn check_vaddd_u64(arg0: u64, arg1: u64) u64 {
    return neon.vaddd_u64(arg0, arg1);
}

export fn check_vaddq_s8(arg0: neon.i8x16, arg1: neon.i8x16) neon.i8x16 {
    return neon.vaddq_s8(arg0, arg1);
}

export fn check_vaddq_s16(arg0: neon.i16x8, arg1: neon.i16x8) neon.i16x8 {
    return neon.vaddq_s16(arg0, arg1);
}

export fn check_vaddq_s32(arg0: *const neon.i32x4, arg1: *const neon.i32x4, out_ptr: *neon.i32x4) void {
    out_ptr.* = neon.vaddq_s32(arg0.*, arg1.*);
}

export fn check_vaddq_s64(arg0: *const neon.i64x2, arg1: *const neon.i64x2, out_ptr: *neon.i64x2) void {
    out_ptr.* = neon.vaddq_s64(arg0.*, arg1.*);
}

export fn check_vaddq_u8(arg0: neon.u8x16, arg1: neon.u8x16) neon.u8x16 {
    return neon.vaddq_u8(arg0, arg1);
}

export fn check_vaddq_u16(arg0: neon.u16x8, arg1: neon.u16x8) neon.u16x8 {
    return neon.vaddq_u16(arg0, arg1);
}

export fn check_vaddq_u32(arg0: *const neon.u32x4, arg1: *const neon.u32x4, out_ptr: *neon.u32x4) void {
    out_ptr.* = neon.vaddq_u32(arg0.*, arg1.*);
}

export fn check_vaddq_u64(arg0: *const neon.u64x2, arg1: *const neon.u64x2, out_ptr: *neon.u64x2) void {
    out_ptr.* = neon.vaddq_u64(arg0.*, arg1.*);
}

export fn check_vaddq_f16(arg0: neon.f16x8, arg1: neon.f16x8) neon.f16x8 {
    return neon.vaddq_f16(arg0, arg1);
}

export fn check_vaddq_f32(arg0: *const neon.f32x4, arg1: *const neon.f32x4, out_ptr: *neon.f32x4) void {
    out_ptr.* = neon.vaddq_f32(arg0.*, arg1.*);
}

export fn check_vaddq_f64(arg0: *const neon.f64x2, arg1: *const neon.f64x2, out_ptr: *neon.f64x2) void {
    out_ptr.* = neon.vaddq_f64(arg0.*, arg1.*);
}

export fn check_vaddq_p8(arg0: neon.p8x16, arg1: neon.p8x16) neon.p8x16 {
    return neon.vaddq_p8(arg0, arg1);
}

export fn check_vaddq_p16(arg0: neon.p16x8, arg1: neon.p16x8) neon.p16x8 {
    return neon.vaddq_p16(arg0, arg1);
}

export fn check_vaddq_p64(arg0: *const neon.p64x2, arg1: *const neon.p64x2, out_ptr: *neon.p64x2) void {
    out_ptr.* = neon.vaddq_p64(arg0.*, arg1.*);
}

export fn check_vaddq_p128(arg0: @Vector(1, p128) , b: @Vector(1, p128)) @Vector(1, p128) {
    return neon.vaddq_p128(arg0);
}

export fn check_vsub_s8(arg0: neon.i8x8, arg1: neon.i8x8) neon.i8x8 {
    return neon.vsub_s8(arg0, arg1);
}

export fn check_vsub_s16(arg0: *const neon.i16x4, arg1: *const neon.i16x4, out_ptr: *neon.i16x4) void {
    out_ptr.* = neon.vsub_s16(arg0.*, arg1.*);
}

export fn check_vsub_s32(arg0: *const neon.i32x2, arg1: *const neon.i32x2, out_ptr: *neon.i32x2) void {
    out_ptr.* = neon.vsub_s32(arg0.*, arg1.*);
}

export fn check_vsub_s64(arg0: neon.i64x1, arg1: neon.i64x1) neon.i64x1 {
    return neon.vsub_s64(arg0, arg1);
}

export fn check_vsub_u8(arg0: neon.u8x8, arg1: neon.u8x8) neon.u8x8 {
    return neon.vsub_u8(arg0, arg1);
}

export fn check_vsub_u16(arg0: *const neon.u16x4, arg1: *const neon.u16x4, out_ptr: *neon.u16x4) void {
    out_ptr.* = neon.vsub_u16(arg0.*, arg1.*);
}

export fn check_vsub_u32(arg0: *const neon.u32x2, arg1: *const neon.u32x2, out_ptr: *neon.u32x2) void {
    out_ptr.* = neon.vsub_u32(arg0.*, arg1.*);
}

export fn check_vsub_u64(arg0: neon.u64x1, arg1: neon.u64x1) neon.u64x1 {
    return neon.vsub_u64(arg0, arg1);
}

export fn check_vsub_f16(arg0: *const neon.f16x4, arg1: *const neon.f16x4, out_ptr: *neon.f16x4) void {
    out_ptr.* = neon.vsub_f16(arg0.*, arg1.*);
}

export fn check_vsub_f32(arg0: *const neon.f32x2, arg1: *const neon.f32x2, out_ptr: *neon.f32x2) void {
    out_ptr.* = neon.vsub_f32(arg0.*, arg1.*);
}

export fn check_vsub_f64(arg0: neon.f64x1, arg1: neon.f64x1) neon.f64x1 {
    return neon.vsub_f64(arg0, arg1);
}

export fn check_vsubq_s8(arg0: neon.i8x16, arg1: neon.i8x16) neon.i8x16 {
    return neon.vsubq_s8(arg0, arg1);
}

export fn check_vsubq_s16(arg0: neon.i16x8, arg1: neon.i16x8) neon.i16x8 {
    return neon.vsubq_s16(arg0, arg1);
}

export fn check_vsubq_s32(arg0: *const neon.i32x4, arg1: *const neon.i32x4, out_ptr: *neon.i32x4) void {
    out_ptr.* = neon.vsubq_s32(arg0.*, arg1.*);
}

export fn check_vsubq_s64(arg0: *const neon.i64x2, arg1: *const neon.i64x2, out_ptr: *neon.i64x2) void {
    out_ptr.* = neon.vsubq_s64(arg0.*, arg1.*);
}

export fn check_vsubq_u8(arg0: neon.u8x16, arg1: neon.u8x16) neon.u8x16 {
    return neon.vsubq_u8(arg0, arg1);
}

export fn check_vsubq_u16(arg0: neon.u16x8, arg1: neon.u16x8) neon.u16x8 {
    return neon.vsubq_u16(arg0, arg1);
}

export fn check_vsubq_u32(arg0: *const neon.u32x4, arg1: *const neon.u32x4, out_ptr: *neon.u32x4) void {
    out_ptr.* = neon.vsubq_u32(arg0.*, arg1.*);
}

export fn check_vsubq_u64(arg0: *const neon.u64x2, arg1: *const neon.u64x2, out_ptr: *neon.u64x2) void {
    out_ptr.* = neon.vsubq_u64(arg0.*, arg1.*);
}

export fn check_vsubq_f16(arg0: neon.f16x8, arg1: neon.f16x8) neon.f16x8 {
    return neon.vsubq_f16(arg0, arg1);
}

export fn check_vsubq_f32(arg0: *const neon.f32x4, arg1: *const neon.f32x4, out_ptr: *neon.f32x4) void {
    out_ptr.* = neon.vsubq_f32(arg0.*, arg1.*);
}

export fn check_vsubq_f64(arg0: *const neon.f64x2, arg1: *const neon.f64x2, out_ptr: *neon.f64x2) void {
    out_ptr.* = neon.vsubq_f64(arg0.*, arg1.*);
}

export fn check_vneg_s8(arg0: neon.i8x8) neon.i8x8 {
    return neon.vneg_s8(arg0);
}

export fn check_vneg_s16(arg0: *const neon.i16x4, out_ptr: *neon.i16x4) void {
    out_ptr.* = neon.vneg_s16(arg0.*);
}

export fn check_vneg_s32(arg0: *const neon.i32x2, out_ptr: *neon.i32x2) void {
    out_ptr.* = neon.vneg_s32(arg0.*);
}

export fn check_vneg_s64(arg0: neon.i64x1) neon.i64x1 {
    return neon.vneg_s64(arg0);
}

export fn check_vneg_f16(arg0: *const neon.f16x4, out_ptr: *neon.f16x4) void {
    out_ptr.* = neon.vneg_f16(arg0.*);
}

export fn check_vneg_f32(arg0: *const neon.f32x2, out_ptr: *neon.f32x2) void {
    out_ptr.* = neon.vneg_f32(arg0.*);
}

export fn check_vneg_f64(arg0: neon.f64x1) neon.f64x1 {
    return neon.vneg_f64(arg0);
}

export fn check_vnegq_s8(arg0: neon.i8x16) neon.i8x16 {
    return neon.vnegq_s8(arg0);
}

export fn check_vnegq_s16(arg0: neon.i16x8) neon.i16x8 {
    return neon.vnegq_s16(arg0);
}

export fn check_vnegq_s32(arg0: *const neon.i32x4, out_ptr: *neon.i32x4) void {
    out_ptr.* = neon.vnegq_s32(arg0.*);
}

export fn check_vnegq_s64(arg0: *const neon.i64x2, out_ptr: *neon.i64x2) void {
    out_ptr.* = neon.vnegq_s64(arg0.*);
}

export fn check_vnegq_f16(arg0: neon.f16x8) neon.f16x8 {
    return neon.vnegq_f16(arg0);
}

export fn check_vnegq_f32(arg0: *const neon.f32x4, out_ptr: *neon.f32x4) void {
    out_ptr.* = neon.vnegq_f32(arg0.*);
}

export fn check_vnegq_f64(arg0: *const neon.f64x2, out_ptr: *neon.f64x2) void {
    out_ptr.* = neon.vnegq_f64(arg0.*);
}

export fn check_vabs_s8(arg0: neon.i8x8) neon.i8x8 {
    return neon.vabs_s8(arg0);
}

export fn check_vabs_s16(arg0: *const neon.i16x4, out_ptr: *neon.i16x4) void {
    out_ptr.* = neon.vabs_s16(arg0.*);
}

export fn check_vabs_s32(arg0: *const neon.i32x2, out_ptr: *neon.i32x2) void {
    out_ptr.* = neon.vabs_s32(arg0.*);
}

export fn check_vabs_s64(arg0: neon.i64x1) neon.i64x1 {
    return neon.vabs_s64(arg0);
}

export fn check_vabs_f16(arg0: *const neon.f16x4, out_ptr: *neon.f16x4) void {
    out_ptr.* = neon.vabs_f16(arg0.*);
}

export fn check_vabs_f32(arg0: *const neon.f32x2, out_ptr: *neon.f32x2) void {
    out_ptr.* = neon.vabs_f32(arg0.*);
}

export fn check_vabs_f64(arg0: neon.f64x1) neon.f64x1 {
    return neon.vabs_f64(arg0);
}

export fn check_vabsd_s64(arg0: i64) i64 {
    return neon.vabsd_s64(arg0);
}

export fn check_vabsq_s8(arg0: neon.i8x16) neon.i8x16 {
    return neon.vabsq_s8(arg0);
}

export fn check_vabsq_s16(arg0: neon.i16x8) neon.i16x8 {
    return neon.vabsq_s16(arg0);
}

export fn check_vabsq_s32(arg0: *const neon.i32x4, out_ptr: *neon.i32x4) void {
    out_ptr.* = neon.vabsq_s32(arg0.*);
}

export fn check_vabsq_s64(arg0: *const neon.i64x2, out_ptr: *neon.i64x2) void {
    out_ptr.* = neon.vabsq_s64(arg0.*);
}

export fn check_vabsq_f16(arg0: neon.f16x8) neon.f16x8 {
    return neon.vabsq_f16(arg0);
}

export fn check_vabsq_f32(arg0: *const neon.f32x4, out_ptr: *neon.f32x4) void {
    out_ptr.* = neon.vabsq_f32(arg0.*);
}

export fn check_vabsq_f64(arg0: *const neon.f64x2, out_ptr: *neon.f64x2) void {
    out_ptr.* = neon.vabsq_f64(arg0.*);
}

export fn check_vabd_s8(arg0: neon.i8x8, arg1: neon.i8x8) neon.i8x8 {
    return neon.vabd_s8(arg0, arg1);
}

export fn check_vabd_s16(arg0: *const neon.i16x4, arg1: *const neon.i16x4, out_ptr: *neon.i16x4) void {
    out_ptr.* = neon.vabd_s16(arg0.*, arg1.*);
}

export fn check_vabd_s32(arg0: *const neon.i32x2, arg1: *const neon.i32x2, out_ptr: *neon.i32x2) void {
    out_ptr.* = neon.vabd_s32(arg0.*, arg1.*);
}

export fn check_vabd_u8(arg0: neon.u8x8, arg1: neon.u8x8) neon.u8x8 {
    return neon.vabd_u8(arg0, arg1);
}

export fn check_vabd_u16(arg0: *const neon.u16x4, arg1: *const neon.u16x4, out_ptr: *neon.u16x4) void {
    out_ptr.* = neon.vabd_u16(arg0.*, arg1.*);
}

export fn check_vabd_u32(arg0: *const neon.u32x2, arg1: *const neon.u32x2, out_ptr: *neon.u32x2) void {
    out_ptr.* = neon.vabd_u32(arg0.*, arg1.*);
}

export fn check_vabd_f16(arg0: *const neon.f16x4, arg1: *const neon.f16x4, out_ptr: *neon.f16x4) void {
    out_ptr.* = neon.vabd_f16(arg0.*, arg1.*);
}

export fn check_vabd_f32(arg0: *const neon.f32x2, arg1: *const neon.f32x2, out_ptr: *neon.f32x2) void {
    out_ptr.* = neon.vabd_f32(arg0.*, arg1.*);
}

export fn check_vabd_f64(arg0: neon.f64x1, arg1: neon.f64x1) neon.f64x1 {
    return neon.vabd_f64(arg0, arg1);
}

export fn check_vabds_f32(arg0: f32, arg1: f32) f32 {
    return neon.vabds_f32(arg0, arg1);
}

export fn check_vabdd_f64(arg0: f64, arg1: f64) f64 {
    return neon.vabdd_f64(arg0, arg1);
}

export fn check_vabdq_s8(arg0: neon.i8x16, arg1: neon.i8x16) neon.i8x16 {
    return neon.vabdq_s8(arg0, arg1);
}

export fn check_vabdq_s16(arg0: neon.i16x8, arg1: neon.i16x8) neon.i16x8 {
    return neon.vabdq_s16(arg0, arg1);
}

export fn check_vabdq_s32(arg0: *const neon.i32x4, arg1: *const neon.i32x4, out_ptr: *neon.i32x4) void {
    out_ptr.* = neon.vabdq_s32(arg0.*, arg1.*);
}

export fn check_vabdq_u8(arg0: neon.u8x16, arg1: neon.u8x16) neon.u8x16 {
    return neon.vabdq_u8(arg0, arg1);
}

export fn check_vabdq_u16(arg0: neon.u16x8, arg1: neon.u16x8) neon.u16x8 {
    return neon.vabdq_u16(arg0, arg1);
}

export fn check_vabdq_u32(arg0: *const neon.u32x4, arg1: *const neon.u32x4, out_ptr: *neon.u32x4) void {
    out_ptr.* = neon.vabdq_u32(arg0.*, arg1.*);
}

export fn check_vabdq_f16(arg0: neon.f16x8, arg1: neon.f16x8) neon.f16x8 {
    return neon.vabdq_f16(arg0, arg1);
}

export fn check_vabdq_f32(arg0: *const neon.f32x4, arg1: *const neon.f32x4, out_ptr: *neon.f32x4) void {
    out_ptr.* = neon.vabdq_f32(arg0.*, arg1.*);
}

export fn check_vabdq_f64(arg0: *const neon.f64x2, arg1: *const neon.f64x2, out_ptr: *neon.f64x2) void {
    out_ptr.* = neon.vabdq_f64(arg0.*, arg1.*);
}

export fn check_vabdl_s8(arg0: neon.i8x8, arg1: neon.i8x8) neon.i16x8 {
    return neon.vabdl_s8(arg0, arg1);
}

export fn check_vabdl_s16(arg0: *const neon.i16x4, arg1: *const neon.i16x4, out_ptr: *neon.i32x4) void {
    out_ptr.* = neon.vabdl_s16(arg0.*, arg1.*);
}

export fn check_vabdl_s32(arg0: *const neon.i32x2, arg1: *const neon.i32x2, out_ptr: *neon.i64x2) void {
    out_ptr.* = neon.vabdl_s32(arg0.*, arg1.*);
}

export fn check_vabdl_u8(arg0: neon.u8x8, arg1: neon.u8x8) neon.u16x8 {
    return neon.vabdl_u8(arg0, arg1);
}

export fn check_vabdl_u16(arg0: *const neon.u16x4, arg1: *const neon.u16x4, out_ptr: *neon.u32x4) void {
    out_ptr.* = neon.vabdl_u16(arg0.*, arg1.*);
}

export fn check_vabdl_u32(arg0: *const neon.u32x2, arg1: *const neon.u32x2, out_ptr: *neon.u64x2) void {
    out_ptr.* = neon.vabdl_u32(arg0.*, arg1.*);
}

export fn check_vaba_s8(arg0: neon.i8x8, arg1: neon.i8x8, arg2: neon.i8x8) neon.i8x8 {
    return neon.vaba_s8(arg0, arg1, arg2);
}

export fn check_vaba_s16(arg0: *const neon.i16x4, arg1: *const neon.i16x4, arg2: *const neon.i16x4, out_ptr: *neon.i16x4) void {
    out_ptr.* = neon.vaba_s16(arg0.*, arg1.*, arg2.*);
}

export fn check_vaba_s32(arg0: *const neon.i32x2, arg1: *const neon.i32x2, arg2: *const neon.i32x2, out_ptr: *neon.i32x2) void {
    out_ptr.* = neon.vaba_s32(arg0.*, arg1.*, arg2.*);
}

export fn check_vaba_u8(arg0: neon.u8x8, arg1: neon.u8x8, arg2: neon.u8x8) neon.u8x8 {
    return neon.vaba_u8(arg0, arg1, arg2);
}

export fn check_vaba_u16(arg0: *const neon.u16x4, arg1: *const neon.u16x4, arg2: *const neon.u16x4, out_ptr: *neon.u16x4) void {
    out_ptr.* = neon.vaba_u16(arg0.*, arg1.*, arg2.*);
}

export fn check_vaba_u32(arg0: *const neon.u32x2, arg1: *const neon.u32x2, arg2: *const neon.u32x2, out_ptr: *neon.u32x2) void {
    out_ptr.* = neon.vaba_u32(arg0.*, arg1.*, arg2.*);
}

export fn check_vabaq_s8(arg0: neon.i8x16, arg1: neon.i8x16, arg2: neon.i8x16) neon.i8x16 {
    return neon.vabaq_s8(arg0, arg1, arg2);
}

export fn check_vabaq_s16(arg0: neon.i16x8, arg1: neon.i16x8, arg2: neon.i16x8) neon.i16x8 {
    return neon.vabaq_s16(arg0, arg1, arg2);
}

export fn check_vabaq_s32(arg0: *const neon.i32x4, arg1: *const neon.i32x4, arg2: *const neon.i32x4, out_ptr: *neon.i32x4) void {
    out_ptr.* = neon.vabaq_s32(arg0.*, arg1.*, arg2.*);
}

export fn check_vabaq_u8(arg0: neon.u8x16, arg1: neon.u8x16, arg2: neon.u8x16) neon.u8x16 {
    return neon.vabaq_u8(arg0, arg1, arg2);
}

export fn check_vabaq_u16(arg0: neon.u16x8, arg1: neon.u16x8, arg2: neon.u16x8) neon.u16x8 {
    return neon.vabaq_u16(arg0, arg1, arg2);
}

export fn check_vabaq_u32(arg0: *const neon.u32x4, arg1: *const neon.u32x4, arg2: *const neon.u32x4, out_ptr: *neon.u32x4) void {
    out_ptr.* = neon.vabaq_u32(arg0.*, arg1.*, arg2.*);
}

export fn check_vabal_s8(arg0: neon.i16x8, arg1: neon.i8x8, arg2: neon.i8x8) neon.i16x8 {
    return neon.vabal_s8(arg0, arg1, arg2);
}

export fn check_vabal_s16(arg0: *const neon.i32x4, arg1: *const neon.i16x4, arg2: *const neon.i16x4, out_ptr: *neon.i32x4) void {
    out_ptr.* = neon.vabal_s16(arg0.*, arg1.*, arg2.*);
}

export fn check_vabal_s32(arg0: *const neon.i64x2, arg1: *const neon.i32x2, arg2: *const neon.i32x2, out_ptr: *neon.i64x2) void {
    out_ptr.* = neon.vabal_s32(arg0.*, arg1.*, arg2.*);
}

export fn check_vabal_u8(arg0: neon.u16x8, arg1: neon.u8x8, arg2: neon.u8x8) neon.u16x8 {
    return neon.vabal_u8(arg0, arg1, arg2);
}

export fn check_vabal_u16(arg0: *const neon.u32x4, arg1: *const neon.u16x4, arg2: *const neon.u16x4, out_ptr: *neon.u32x4) void {
    out_ptr.* = neon.vabal_u16(arg0.*, arg1.*, arg2.*);
}

export fn check_vabal_u32(arg0: *const neon.u64x2, arg1: *const neon.u32x2, arg2: *const neon.u32x2, out_ptr: *neon.u64x2) void {
    out_ptr.* = neon.vabal_u32(arg0.*, arg1.*, arg2.*);
}

export fn check_vaddl_s8(arg0: neon.i8x8, arg1: neon.i8x8) neon.i16x8 {
    return neon.vaddl_s8(arg0, arg1);
}

export fn check_vaddl_s16(arg0: *const neon.i16x4, arg1: *const neon.i16x4, out_ptr: *neon.i32x4) void {
    out_ptr.* = neon.vaddl_s16(arg0.*, arg1.*);
}

export fn check_vaddl_s32(arg0: *const neon.i32x2, arg1: *const neon.i32x2, out_ptr: *neon.i64x2) void {
    out_ptr.* = neon.vaddl_s32(arg0.*, arg1.*);
}

export fn check_vaddl_u8(arg0: neon.u8x8, arg1: neon.u8x8) neon.u16x8 {
    return neon.vaddl_u8(arg0, arg1);
}

export fn check_vaddl_u16(arg0: *const neon.u16x4, arg1: *const neon.u16x4, out_ptr: *neon.u32x4) void {
    out_ptr.* = neon.vaddl_u16(arg0.*, arg1.*);
}

export fn check_vaddl_u32(arg0: *const neon.u32x2, arg1: *const neon.u32x2, out_ptr: *neon.u64x2) void {
    out_ptr.* = neon.vaddl_u32(arg0.*, arg1.*);
}

export fn check_vaddw_s8(arg0: neon.i16x8, arg1: neon.i8x8) neon.i16x8 {
    return neon.vaddw_s8(arg0, arg1);
}

export fn check_vaddw_s16(arg0: *const neon.i32x4, arg1: *const neon.i16x4, out_ptr: *neon.i32x4) void {
    out_ptr.* = neon.vaddw_s16(arg0.*, arg1.*);
}

export fn check_vaddw_s32(arg0: *const neon.i64x2, arg1: *const neon.i32x2, out_ptr: *neon.i64x2) void {
    out_ptr.* = neon.vaddw_s32(arg0.*, arg1.*);
}

export fn check_vaddw_u8(arg0: neon.u16x8, arg1: neon.u8x8) neon.u16x8 {
    return neon.vaddw_u8(arg0, arg1);
}

export fn check_vaddw_u16(arg0: *const neon.u32x4, arg1: *const neon.u16x4, out_ptr: *neon.u32x4) void {
    out_ptr.* = neon.vaddw_u16(arg0.*, arg1.*);
}

export fn check_vaddw_u32(arg0: *const neon.u64x2, arg1: *const neon.u32x2, out_ptr: *neon.u64x2) void {
    out_ptr.* = neon.vaddw_u32(arg0.*, arg1.*);
}

export fn check_vaddhn_s16(arg0: neon.i16x8, arg1: neon.i16x8) neon.i8x8 {
    return neon.vaddhn_s16(arg0, arg1);
}

export fn check_vaddhn_s32(arg0: *const neon.i32x4, arg1: *const neon.i32x4, out_ptr: *neon.i16x4) void {
    out_ptr.* = neon.vaddhn_s32(arg0.*, arg1.*);
}

export fn check_vaddhn_s64(arg0: *const neon.i64x2, arg1: *const neon.i64x2, out_ptr: *neon.i32x2) void {
    out_ptr.* = neon.vaddhn_s64(arg0.*, arg1.*);
}

export fn check_vaddhn_u16(arg0: neon.u16x8, arg1: neon.u16x8) neon.u8x8 {
    return neon.vaddhn_u16(arg0, arg1);
}

export fn check_vaddhn_u32(arg0: *const neon.u32x4, arg1: *const neon.u32x4, out_ptr: *neon.u16x4) void {
    out_ptr.* = neon.vaddhn_u32(arg0.*, arg1.*);
}

export fn check_vaddhn_u64(arg0: *const neon.u64x2, arg1: *const neon.u64x2, out_ptr: *neon.u32x2) void {
    out_ptr.* = neon.vaddhn_u64(arg0.*, arg1.*);
}

export fn check_vmul_s8(arg0: neon.i8x8, arg1: neon.i8x8) neon.i8x8 {
    return neon.vmul_s8(arg0, arg1);
}

export fn check_vmul_s16(arg0: *const neon.i16x4, arg1: *const neon.i16x4, out_ptr: *neon.i16x4) void {
    out_ptr.* = neon.vmul_s16(arg0.*, arg1.*);
}

export fn check_vmul_s32(arg0: *const neon.i32x2, arg1: *const neon.i32x2, out_ptr: *neon.i32x2) void {
    out_ptr.* = neon.vmul_s32(arg0.*, arg1.*);
}

export fn check_vmul_u8(arg0: neon.u8x8, arg1: neon.u8x8) neon.u8x8 {
    return neon.vmul_u8(arg0, arg1);
}

export fn check_vmul_u16(arg0: *const neon.u16x4, arg1: *const neon.u16x4, out_ptr: *neon.u16x4) void {
    out_ptr.* = neon.vmul_u16(arg0.*, arg1.*);
}

export fn check_vmul_u32(arg0: *const neon.u32x2, arg1: *const neon.u32x2, out_ptr: *neon.u32x2) void {
    out_ptr.* = neon.vmul_u32(arg0.*, arg1.*);
}

export fn check_vmul_f16(arg0: *const neon.f16x4, arg1: *const neon.f16x4, out_ptr: *neon.f16x4) void {
    out_ptr.* = neon.vmul_f16(arg0.*, arg1.*);
}

export fn check_vmul_f32(arg0: *const neon.f32x2, arg1: *const neon.f32x2, out_ptr: *neon.f32x2) void {
    out_ptr.* = neon.vmul_f32(arg0.*, arg1.*);
}

export fn check_vmul_f64(arg0: neon.f64x1, arg1: neon.f64x1) neon.f64x1 {
    return neon.vmul_f64(arg0, arg1);
}

export fn check_vmulq_s8(arg0: neon.i8x16, arg1: neon.i8x16) neon.i8x16 {
    return neon.vmulq_s8(arg0, arg1);
}

export fn check_vmulq_s16(arg0: neon.i16x8, arg1: neon.i16x8) neon.i16x8 {
    return neon.vmulq_s16(arg0, arg1);
}

export fn check_vmulq_s32(arg0: *const neon.i32x4, arg1: *const neon.i32x4, out_ptr: *neon.i32x4) void {
    out_ptr.* = neon.vmulq_s32(arg0.*, arg1.*);
}

export fn check_vmulq_u8(arg0: neon.u8x16, arg1: neon.u8x16) neon.u8x16 {
    return neon.vmulq_u8(arg0, arg1);
}

export fn check_vmulq_u16(arg0: neon.u16x8, arg1: neon.u16x8) neon.u16x8 {
    return neon.vmulq_u16(arg0, arg1);
}

export fn check_vmulq_u32(arg0: *const neon.u32x4, arg1: *const neon.u32x4, out_ptr: *neon.u32x4) void {
    out_ptr.* = neon.vmulq_u32(arg0.*, arg1.*);
}

export fn check_vmulq_f16(arg0: neon.f16x8, arg1: neon.f16x8) neon.f16x8 {
    return neon.vmulq_f16(arg0, arg1);
}

export fn check_vmulq_f32(arg0: *const neon.f32x4, arg1: *const neon.f32x4, out_ptr: *neon.f32x4) void {
    out_ptr.* = neon.vmulq_f32(arg0.*, arg1.*);
}

export fn check_vmulq_f64(arg0: *const neon.f64x2, arg1: *const neon.f64x2, out_ptr: *neon.f64x2) void {
    out_ptr.* = neon.vmulq_f64(arg0.*, arg1.*);
}

export fn check_vmull_s8(arg0: neon.i8x8, arg1: neon.i8x8) neon.i16x8 {
    return neon.vmull_s8(arg0, arg1);
}

export fn check_vmull_s16(arg0: *const neon.i16x4, arg1: *const neon.i16x4, out_ptr: *neon.i32x4) void {
    out_ptr.* = neon.vmull_s16(arg0.*, arg1.*);
}

export fn check_vmull_s32(arg0: *const neon.i32x2, arg1: *const neon.i32x2, out_ptr: *neon.i64x2) void {
    out_ptr.* = neon.vmull_s32(arg0.*, arg1.*);
}

export fn check_vmull_u8(arg0: neon.u8x8, arg1: neon.u8x8) neon.u16x8 {
    return neon.vmull_u8(arg0, arg1);
}

export fn check_vmull_u16(arg0: *const neon.u16x4, arg1: *const neon.u16x4, out_ptr: *neon.u32x4) void {
    out_ptr.* = neon.vmull_u16(arg0.*, arg1.*);
}

export fn check_vmull_u32(arg0: *const neon.u32x2, arg1: *const neon.u32x2, out_ptr: *neon.u64x2) void {
    out_ptr.* = neon.vmull_u32(arg0.*, arg1.*);
}

export fn check_vmla_s8(arg0: neon.i8x8, arg1: neon.i8x8, arg2: neon.i8x8) neon.i8x8 {
    return neon.vmla_s8(arg0, arg1, arg2);
}

export fn check_vmla_s16(arg0: *const neon.i16x4, arg1: *const neon.i16x4, arg2: *const neon.i16x4, out_ptr: *neon.i16x4) void {
    out_ptr.* = neon.vmla_s16(arg0.*, arg1.*, arg2.*);
}

export fn check_vmla_s32(arg0: *const neon.i32x2, arg1: *const neon.i32x2, arg2: *const neon.i32x2, out_ptr: *neon.i32x2) void {
    out_ptr.* = neon.vmla_s32(arg0.*, arg1.*, arg2.*);
}

export fn check_vmla_u8(arg0: neon.u8x8, arg1: neon.u8x8, arg2: neon.u8x8) neon.u8x8 {
    return neon.vmla_u8(arg0, arg1, arg2);
}

export fn check_vmla_u16(arg0: *const neon.u16x4, arg1: *const neon.u16x4, arg2: *const neon.u16x4, out_ptr: *neon.u16x4) void {
    out_ptr.* = neon.vmla_u16(arg0.*, arg1.*, arg2.*);
}

export fn check_vmla_u32(arg0: *const neon.u32x2, arg1: *const neon.u32x2, arg2: *const neon.u32x2, out_ptr: *neon.u32x2) void {
    out_ptr.* = neon.vmla_u32(arg0.*, arg1.*, arg2.*);
}

export fn check_vmla_f16(arg0: *const neon.f16x4, arg1: *const neon.f16x4, arg2: *const neon.f16x4, out_ptr: *neon.f16x4) void {
    out_ptr.* = neon.vmla_f16(arg0.*, arg1.*, arg2.*);
}

export fn check_vmla_f32(arg0: *const neon.f32x2, arg1: *const neon.f32x2, arg2: *const neon.f32x2, out_ptr: *neon.f32x2) void {
    out_ptr.* = neon.vmla_f32(arg0.*, arg1.*, arg2.*);
}

export fn check_vmlaq_s8(arg0: neon.i8x16, arg1: neon.i8x16, arg2: neon.i8x16) neon.i8x16 {
    return neon.vmlaq_s8(arg0, arg1, arg2);
}

export fn check_vmlaq_s16(arg0: neon.i16x8, arg1: neon.i16x8, arg2: neon.i16x8) neon.i16x8 {
    return neon.vmlaq_s16(arg0, arg1, arg2);
}

export fn check_vmlaq_s32(arg0: *const neon.i32x4, arg1: *const neon.i32x4, arg2: *const neon.i32x4, out_ptr: *neon.i32x4) void {
    out_ptr.* = neon.vmlaq_s32(arg0.*, arg1.*, arg2.*);
}

export fn check_vmlaq_u8(arg0: neon.u8x16, arg1: neon.u8x16, arg2: neon.u8x16) neon.u8x16 {
    return neon.vmlaq_u8(arg0, arg1, arg2);
}

export fn check_vmlaq_u16(arg0: neon.u16x8, arg1: neon.u16x8, arg2: neon.u16x8) neon.u16x8 {
    return neon.vmlaq_u16(arg0, arg1, arg2);
}

export fn check_vmlaq_u32(arg0: *const neon.u32x4, arg1: *const neon.u32x4, arg2: *const neon.u32x4, out_ptr: *neon.u32x4) void {
    out_ptr.* = neon.vmlaq_u32(arg0.*, arg1.*, arg2.*);
}

export fn check_vmlaq_f16(arg0: neon.f16x8, arg1: neon.f16x8, arg2: neon.f16x8) neon.f16x8 {
    return neon.vmlaq_f16(arg0, arg1, arg2);
}

export fn check_vmlaq_f32(arg0: *const neon.f32x4, arg1: *const neon.f32x4, arg2: *const neon.f32x4, out_ptr: *neon.f32x4) void {
    out_ptr.* = neon.vmlaq_f32(arg0.*, arg1.*, arg2.*);
}

export fn check_vmlaq_f64(arg0: *const neon.f64x2, arg1: *const neon.f64x2, arg2: *const neon.f64x2, out_ptr: *neon.f64x2) void {
    out_ptr.* = neon.vmlaq_f64(arg0.*, arg1.*, arg2.*);
}

export fn check_vmls_s8(arg0: neon.i8x8, arg1: neon.i8x8, arg2: neon.i8x8) neon.i8x8 {
    return neon.vmls_s8(arg0, arg1, arg2);
}

export fn check_vmls_s16(arg0: *const neon.i16x4, arg1: *const neon.i16x4, arg2: *const neon.i16x4, out_ptr: *neon.i16x4) void {
    out_ptr.* = neon.vmls_s16(arg0.*, arg1.*, arg2.*);
}

export fn check_vmls_s32(arg0: *const neon.i32x2, arg1: *const neon.i32x2, arg2: *const neon.i32x2, out_ptr: *neon.i32x2) void {
    out_ptr.* = neon.vmls_s32(arg0.*, arg1.*, arg2.*);
}

export fn check_vmls_u8(arg0: neon.u8x8, arg1: neon.u8x8, arg2: neon.u8x8) neon.u8x8 {
    return neon.vmls_u8(arg0, arg1, arg2);
}

export fn check_vmls_u16(arg0: *const neon.u16x4, arg1: *const neon.u16x4, arg2: *const neon.u16x4, out_ptr: *neon.u16x4) void {
    out_ptr.* = neon.vmls_u16(arg0.*, arg1.*, arg2.*);
}

export fn check_vmls_u32(arg0: *const neon.u32x2, arg1: *const neon.u32x2, arg2: *const neon.u32x2, out_ptr: *neon.u32x2) void {
    out_ptr.* = neon.vmls_u32(arg0.*, arg1.*, arg2.*);
}

export fn check_vmls_f16(arg0: *const neon.f16x4, arg1: *const neon.f16x4, arg2: *const neon.f16x4, out_ptr: *neon.f16x4) void {
    out_ptr.* = neon.vmls_f16(arg0.*, arg1.*, arg2.*);
}

export fn check_vmls_f32(arg0: *const neon.f32x2, arg1: *const neon.f32x2, arg2: *const neon.f32x2, out_ptr: *neon.f32x2) void {
    out_ptr.* = neon.vmls_f32(arg0.*, arg1.*, arg2.*);
}

export fn check_vmlsq_s8(arg0: neon.i8x16, arg1: neon.i8x16, arg2: neon.i8x16) neon.i8x16 {
    return neon.vmlsq_s8(arg0, arg1, arg2);
}

export fn check_vmlsq_s16(arg0: neon.i16x8, arg1: neon.i16x8, arg2: neon.i16x8) neon.i16x8 {
    return neon.vmlsq_s16(arg0, arg1, arg2);
}

export fn check_vmlsq_s32(arg0: *const neon.i32x4, arg1: *const neon.i32x4, arg2: *const neon.i32x4, out_ptr: *neon.i32x4) void {
    out_ptr.* = neon.vmlsq_s32(arg0.*, arg1.*, arg2.*);
}

export fn check_vmlsq_u8(arg0: neon.u8x16, arg1: neon.u8x16, arg2: neon.u8x16) neon.u8x16 {
    return neon.vmlsq_u8(arg0, arg1, arg2);
}

export fn check_vmlsq_u16(arg0: neon.u16x8, arg1: neon.u16x8, arg2: neon.u16x8) neon.u16x8 {
    return neon.vmlsq_u16(arg0, arg1, arg2);
}

export fn check_vmlsq_u32(arg0: *const neon.u32x4, arg1: *const neon.u32x4, arg2: *const neon.u32x4, out_ptr: *neon.u32x4) void {
    out_ptr.* = neon.vmlsq_u32(arg0.*, arg1.*, arg2.*);
}

export fn check_vmlsq_f16(arg0: neon.f16x8, arg1: neon.f16x8, arg2: neon.f16x8) neon.f16x8 {
    return neon.vmlsq_f16(arg0, arg1, arg2);
}

export fn check_vmlsq_f32(arg0: *const neon.f32x4, arg1: *const neon.f32x4, arg2: *const neon.f32x4, out_ptr: *neon.f32x4) void {
    out_ptr.* = neon.vmlsq_f32(arg0.*, arg1.*, arg2.*);
}

export fn check_vmlsq_f64(arg0: *const neon.f64x2, arg1: *const neon.f64x2, arg2: *const neon.f64x2, out_ptr: *neon.f64x2) void {
    out_ptr.* = neon.vmlsq_f64(arg0.*, arg1.*, arg2.*);
}

export fn check_vfma_f16(arg0: *const neon.f16x4, arg1: *const neon.f16x4, arg2: *const neon.f16x4, out_ptr: *neon.f16x4) void {
    out_ptr.* = neon.vfma_f16(arg0.*, arg1.*, arg2.*);
}

export fn check_vfma_f32(arg0: *const neon.f32x2, arg1: *const neon.f32x2, arg2: *const neon.f32x2, out_ptr: *neon.f32x2) void {
    out_ptr.* = neon.vfma_f32(arg0.*, arg1.*, arg2.*);
}

export fn check_vfma_f64(arg0: neon.f64x1, arg1: neon.f64x1, arg2: neon.f64x1) neon.f64x1 {
    return neon.vfma_f64(arg0, arg1, arg2);
}

export fn check_vfmaq_f16(arg0: neon.f16x8, arg1: neon.f16x8, arg2: neon.f16x8) neon.f16x8 {
    return neon.vfmaq_f16(arg0, arg1, arg2);
}

export fn check_vfmaq_f32(arg0: *const neon.f32x4, arg1: *const neon.f32x4, arg2: *const neon.f32x4, out_ptr: *neon.f32x4) void {
    out_ptr.* = neon.vfmaq_f32(arg0.*, arg1.*, arg2.*);
}

export fn check_vfmaq_f64(arg0: *const neon.f64x2, arg1: *const neon.f64x2, arg2: *const neon.f64x2, out_ptr: *neon.f64x2) void {
    out_ptr.* = neon.vfmaq_f64(arg0.*, arg1.*, arg2.*);
}

export fn check_vfms_f16(arg0: *const neon.f16x4, arg1: *const neon.f16x4, arg2: *const neon.f16x4, out_ptr: *neon.f16x4) void {
    out_ptr.* = neon.vfms_f16(arg0.*, arg1.*, arg2.*);
}

export fn check_vfms_f32(arg0: *const neon.f32x2, arg1: *const neon.f32x2, arg2: *const neon.f32x2, out_ptr: *neon.f32x2) void {
    out_ptr.* = neon.vfms_f32(arg0.*, arg1.*, arg2.*);
}

export fn check_vfms_f64(arg0: neon.f64x1, arg1: neon.f64x1, arg2: neon.f64x1) neon.f64x1 {
    return neon.vfms_f64(arg0, arg1, arg2);
}

export fn check_vfmsq_f16(arg0: neon.f16x8, arg1: neon.f16x8, arg2: neon.f16x8) neon.f16x8 {
    return neon.vfmsq_f16(arg0, arg1, arg2);
}

export fn check_vfmsq_f32(arg0: *const neon.f32x4, arg1: *const neon.f32x4, arg2: *const neon.f32x4, out_ptr: *neon.f32x4) void {
    out_ptr.* = neon.vfmsq_f32(arg0.*, arg1.*, arg2.*);
}

export fn check_vfmsq_f64(arg0: *const neon.f64x2, arg1: *const neon.f64x2, arg2: *const neon.f64x2, out_ptr: *neon.f64x2) void {
    out_ptr.* = neon.vfmsq_f64(arg0.*, arg1.*, arg2.*);
}

export fn check_vfmaq_laneq_f16(arg0: neon.f16x8, arg1: neon.f16x8, arg2: neon.f16x8) neon.f16x8 {
    return neon.vfmaq_laneq_f16(arg0, arg1, arg2, 0);
}

export fn check_vfmaq_laneq_f32(arg0: *const neon.f32x4, arg1: *const neon.f32x4, arg2: *const neon.f32x4, out_ptr: *neon.f32x4) void {
    out_ptr.* = neon.vfmaq_laneq_f32(arg0.*, arg1.*, arg2.*, 0);
}

export fn check_vfmaq_laneq_f64(arg0: *const neon.f64x2, arg1: *const neon.f64x2, arg2: *const neon.f64x2, out_ptr: *neon.f64x2) void {
    out_ptr.* = neon.vfmaq_laneq_f64(arg0.*, arg1.*, arg2.*, 0);
}

export fn check_vqadd_s8(arg0: neon.i8x8, arg1: neon.i8x8) neon.i8x8 {
    return neon.vqadd_s8(arg0, arg1);
}

export fn check_vqadd_s16(arg0: *const neon.i16x4, arg1: *const neon.i16x4, out_ptr: *neon.i16x4) void {
    out_ptr.* = neon.vqadd_s16(arg0.*, arg1.*);
}

export fn check_vqadd_s32(arg0: *const neon.i32x2, arg1: *const neon.i32x2, out_ptr: *neon.i32x2) void {
    out_ptr.* = neon.vqadd_s32(arg0.*, arg1.*);
}

export fn check_vqadd_s64(arg0: neon.i64x1, arg1: neon.i64x1) neon.i64x1 {
    return neon.vqadd_s64(arg0, arg1);
}

export fn check_vqadd_u8(arg0: neon.u8x8, arg1: neon.u8x8) neon.u8x8 {
    return neon.vqadd_u8(arg0, arg1);
}

export fn check_vqadd_u16(arg0: *const neon.u16x4, arg1: *const neon.u16x4, out_ptr: *neon.u16x4) void {
    out_ptr.* = neon.vqadd_u16(arg0.*, arg1.*);
}

export fn check_vqadd_u32(arg0: *const neon.u32x2, arg1: *const neon.u32x2, out_ptr: *neon.u32x2) void {
    out_ptr.* = neon.vqadd_u32(arg0.*, arg1.*);
}

export fn check_vqadd_u64(arg0: neon.u64x1, arg1: neon.u64x1) neon.u64x1 {
    return neon.vqadd_u64(arg0, arg1);
}

export fn check_vqaddq_s8(arg0: neon.i8x16, arg1: neon.i8x16) neon.i8x16 {
    return neon.vqaddq_s8(arg0, arg1);
}

export fn check_vqaddq_s16(arg0: neon.i16x8, arg1: neon.i16x8) neon.i16x8 {
    return neon.vqaddq_s16(arg0, arg1);
}

export fn check_vqaddq_s32(arg0: *const neon.i32x4, arg1: *const neon.i32x4, out_ptr: *neon.i32x4) void {
    out_ptr.* = neon.vqaddq_s32(arg0.*, arg1.*);
}

export fn check_vqaddq_s64(arg0: *const neon.i64x2, arg1: *const neon.i64x2, out_ptr: *neon.i64x2) void {
    out_ptr.* = neon.vqaddq_s64(arg0.*, arg1.*);
}

export fn check_vqaddq_u8(arg0: neon.u8x16, arg1: neon.u8x16) neon.u8x16 {
    return neon.vqaddq_u8(arg0, arg1);
}

export fn check_vqaddq_u16(arg0: neon.u16x8, arg1: neon.u16x8) neon.u16x8 {
    return neon.vqaddq_u16(arg0, arg1);
}

export fn check_vqaddq_u32(arg0: *const neon.u32x4, arg1: *const neon.u32x4, out_ptr: *neon.u32x4) void {
    out_ptr.* = neon.vqaddq_u32(arg0.*, arg1.*);
}

export fn check_vqaddq_u64(arg0: *const neon.u64x2, arg1: *const neon.u64x2, out_ptr: *neon.u64x2) void {
    out_ptr.* = neon.vqaddq_u64(arg0.*, arg1.*);
}

export fn check_vqsub_s8(arg0: neon.i8x8, arg1: neon.i8x8) neon.i8x8 {
    return neon.vqsub_s8(arg0, arg1);
}

export fn check_vqsub_s16(arg0: *const neon.i16x4, arg1: *const neon.i16x4, out_ptr: *neon.i16x4) void {
    out_ptr.* = neon.vqsub_s16(arg0.*, arg1.*);
}

export fn check_vqsub_s32(arg0: *const neon.i32x2, arg1: *const neon.i32x2, out_ptr: *neon.i32x2) void {
    out_ptr.* = neon.vqsub_s32(arg0.*, arg1.*);
}

export fn check_vqsub_s64(arg0: neon.i64x1, arg1: neon.i64x1) neon.i64x1 {
    return neon.vqsub_s64(arg0, arg1);
}

export fn check_vqsub_u8(arg0: neon.u8x8, arg1: neon.u8x8) neon.u8x8 {
    return neon.vqsub_u8(arg0, arg1);
}

export fn check_vqsub_u16(arg0: *const neon.u16x4, arg1: *const neon.u16x4, out_ptr: *neon.u16x4) void {
    out_ptr.* = neon.vqsub_u16(arg0.*, arg1.*);
}

export fn check_vqsub_u32(arg0: *const neon.u32x2, arg1: *const neon.u32x2, out_ptr: *neon.u32x2) void {
    out_ptr.* = neon.vqsub_u32(arg0.*, arg1.*);
}

export fn check_vqsub_u64(arg0: neon.u64x1, arg1: neon.u64x1) neon.u64x1 {
    return neon.vqsub_u64(arg0, arg1);
}

export fn check_vqsubq_s8(arg0: neon.i8x16, arg1: neon.i8x16) neon.i8x16 {
    return neon.vqsubq_s8(arg0, arg1);
}

export fn check_vqsubq_s16(arg0: neon.i16x8, arg1: neon.i16x8) neon.i16x8 {
    return neon.vqsubq_s16(arg0, arg1);
}

export fn check_vqsubq_s32(arg0: *const neon.i32x4, arg1: *const neon.i32x4, out_ptr: *neon.i32x4) void {
    out_ptr.* = neon.vqsubq_s32(arg0.*, arg1.*);
}

export fn check_vqsubq_s64(arg0: *const neon.i64x2, arg1: *const neon.i64x2, out_ptr: *neon.i64x2) void {
    out_ptr.* = neon.vqsubq_s64(arg0.*, arg1.*);
}

export fn check_vqsubq_u8(arg0: neon.u8x16, arg1: neon.u8x16) neon.u8x16 {
    return neon.vqsubq_u8(arg0, arg1);
}

export fn check_vqsubq_u16(arg0: neon.u16x8, arg1: neon.u16x8) neon.u16x8 {
    return neon.vqsubq_u16(arg0, arg1);
}

export fn check_vqsubq_u32(arg0: *const neon.u32x4, arg1: *const neon.u32x4, out_ptr: *neon.u32x4) void {
    out_ptr.* = neon.vqsubq_u32(arg0.*, arg1.*);
}

export fn check_vqsubq_u64(arg0: *const neon.u64x2, arg1: *const neon.u64x2, out_ptr: *neon.u64x2) void {
    out_ptr.* = neon.vqsubq_u64(arg0.*, arg1.*);
}

export fn check_vqsubs_s32(arg0: i32, arg1: i32) i32 {
    return neon.vqsubs_s32(arg0, arg1);
}

export fn check_vqsubs_u32(arg0: u32, arg1: u32) u32 {
    return neon.vqsubs_u32(arg0, arg1);
}

export fn check_vqsubd_s64(arg0: i64, arg1: i64) i64 {
    return neon.vqsubd_s64(arg0, arg1);
}

export fn check_vqsubd_u64(arg0: u64, arg1: u64) u64 {
    return neon.vqsubd_u64(arg0, arg1);
}

export fn check_vqdmull_s16(arg0: *const neon.i16x4, arg1: *const neon.i16x4, out_ptr: *neon.i32x4) void {
    out_ptr.* = neon.vqdmull_s16(arg0.*, arg1.*);
}

export fn check_vqdmull_s32(arg0: *const neon.i32x2, arg1: *const neon.i32x2, out_ptr: *neon.i64x2) void {
    out_ptr.* = neon.vqdmull_s32(arg0.*, arg1.*);
}

export fn check_vqdmullh_s16(arg0: i16, arg1: i16) i32 {
    return neon.vqdmullh_s16(arg0, arg1);
}

export fn check_vqdmulls_s32(arg0: i32, arg1: i32) i64 {
    return neon.vqdmulls_s32(arg0, arg1);
}

export fn check_vand_s8(arg0: neon.i8x8, arg1: neon.i8x8) neon.i8x8 {
    return neon.vand_s8(arg0, arg1);
}

export fn check_vand_s16(arg0: *const neon.i16x4, arg1: *const neon.i16x4, out_ptr: *neon.i16x4) void {
    out_ptr.* = neon.vand_s16(arg0.*, arg1.*);
}

export fn check_vand_s32(arg0: *const neon.i32x2, arg1: *const neon.i32x2, out_ptr: *neon.i32x2) void {
    out_ptr.* = neon.vand_s32(arg0.*, arg1.*);
}

export fn check_vand_s64(arg0: neon.i64x1, arg1: neon.i64x1) neon.i64x1 {
    return neon.vand_s64(arg0, arg1);
}

export fn check_vand_u8(arg0: neon.u8x8, arg1: neon.u8x8) neon.u8x8 {
    return neon.vand_u8(arg0, arg1);
}

export fn check_vand_u16(arg0: *const neon.u16x4, arg1: *const neon.u16x4, out_ptr: *neon.u16x4) void {
    out_ptr.* = neon.vand_u16(arg0.*, arg1.*);
}

export fn check_vand_u32(arg0: *const neon.u32x2, arg1: *const neon.u32x2, out_ptr: *neon.u32x2) void {
    out_ptr.* = neon.vand_u32(arg0.*, arg1.*);
}

export fn check_vand_u64(arg0: neon.u64x1, arg1: neon.u64x1) neon.u64x1 {
    return neon.vand_u64(arg0, arg1);
}

export fn check_vand_p8(arg0: neon.p8x8, arg1: neon.p8x8) neon.p8x8 {
    return neon.vand_p8(arg0, arg1);
}

export fn check_vand_p16(arg0: *const neon.p16x4, arg1: *const neon.p16x4, out_ptr: *neon.p16x4) void {
    out_ptr.* = neon.vand_p16(arg0.*, arg1.*);
}

export fn check_vand_p64(arg0: neon.p64x1, arg1: neon.p64x1) neon.p64x1 {
    return neon.vand_p64(arg0, arg1);
}

export fn check_vandq_s8(arg0: neon.i8x16, arg1: neon.i8x16) neon.i8x16 {
    return neon.vandq_s8(arg0, arg1);
}

export fn check_vandq_s16(arg0: neon.i16x8, arg1: neon.i16x8) neon.i16x8 {
    return neon.vandq_s16(arg0, arg1);
}

export fn check_vandq_s32(arg0: *const neon.i32x4, arg1: *const neon.i32x4, out_ptr: *neon.i32x4) void {
    out_ptr.* = neon.vandq_s32(arg0.*, arg1.*);
}

export fn check_vandq_s64(arg0: *const neon.i64x2, arg1: *const neon.i64x2, out_ptr: *neon.i64x2) void {
    out_ptr.* = neon.vandq_s64(arg0.*, arg1.*);
}

export fn check_vandq_u8(arg0: neon.u8x16, arg1: neon.u8x16) neon.u8x16 {
    return neon.vandq_u8(arg0, arg1);
}

export fn check_vandq_u16(arg0: neon.u16x8, arg1: neon.u16x8) neon.u16x8 {
    return neon.vandq_u16(arg0, arg1);
}

export fn check_vandq_u32(arg0: *const neon.u32x4, arg1: *const neon.u32x4, out_ptr: *neon.u32x4) void {
    out_ptr.* = neon.vandq_u32(arg0.*, arg1.*);
}

export fn check_vandq_u64(arg0: *const neon.u64x2, arg1: *const neon.u64x2, out_ptr: *neon.u64x2) void {
    out_ptr.* = neon.vandq_u64(arg0.*, arg1.*);
}

export fn check_vandq_p8(arg0: neon.p8x16, arg1: neon.p8x16) neon.p8x16 {
    return neon.vandq_p8(arg0, arg1);
}

export fn check_vandq_p16(arg0: neon.p16x8, arg1: neon.p16x8) neon.p16x8 {
    return neon.vandq_p16(arg0, arg1);
}

export fn check_vandq_p64(arg0: *const neon.p64x2, arg1: *const neon.p64x2, out_ptr: *neon.p64x2) void {
    out_ptr.* = neon.vandq_p64(arg0.*, arg1.*);
}

export fn check_vorr_s8(arg0: neon.i8x8, arg1: neon.i8x8) neon.i8x8 {
    return neon.vorr_s8(arg0, arg1);
}

export fn check_vorr_s16(arg0: *const neon.i16x4, arg1: *const neon.i16x4, out_ptr: *neon.i16x4) void {
    out_ptr.* = neon.vorr_s16(arg0.*, arg1.*);
}

export fn check_vorr_s32(arg0: *const neon.i32x2, arg1: *const neon.i32x2, out_ptr: *neon.i32x2) void {
    out_ptr.* = neon.vorr_s32(arg0.*, arg1.*);
}

export fn check_vorr_s64(arg0: neon.i64x1, arg1: neon.i64x1) neon.i64x1 {
    return neon.vorr_s64(arg0, arg1);
}

export fn check_vorr_u8(arg0: neon.u8x8, arg1: neon.u8x8) neon.u8x8 {
    return neon.vorr_u8(arg0, arg1);
}

export fn check_vorr_u16(arg0: *const neon.u16x4, arg1: *const neon.u16x4, out_ptr: *neon.u16x4) void {
    out_ptr.* = neon.vorr_u16(arg0.*, arg1.*);
}

export fn check_vorr_u32(arg0: *const neon.u32x2, arg1: *const neon.u32x2, out_ptr: *neon.u32x2) void {
    out_ptr.* = neon.vorr_u32(arg0.*, arg1.*);
}

export fn check_vorr_u64(arg0: neon.u64x1, arg1: neon.u64x1) neon.u64x1 {
    return neon.vorr_u64(arg0, arg1);
}

export fn check_vorrq_s8(arg0: neon.i8x16, arg1: neon.i8x16) neon.i8x16 {
    return neon.vorrq_s8(arg0, arg1);
}

export fn check_vorrq_s16(arg0: neon.i16x8, arg1: neon.i16x8) neon.i16x8 {
    return neon.vorrq_s16(arg0, arg1);
}

export fn check_vorrq_s32(arg0: *const neon.i32x4, arg1: *const neon.i32x4, out_ptr: *neon.i32x4) void {
    out_ptr.* = neon.vorrq_s32(arg0.*, arg1.*);
}

export fn check_vorrq_s64(arg0: *const neon.i64x2, arg1: *const neon.i64x2, out_ptr: *neon.i64x2) void {
    out_ptr.* = neon.vorrq_s64(arg0.*, arg1.*);
}

export fn check_vorrq_u8(arg0: neon.u8x16, arg1: neon.u8x16) neon.u8x16 {
    return neon.vorrq_u8(arg0, arg1);
}

export fn check_vorrq_u16(arg0: neon.u16x8, arg1: neon.u16x8) neon.u16x8 {
    return neon.vorrq_u16(arg0, arg1);
}

export fn check_vorrq_u32(arg0: *const neon.u32x4, arg1: *const neon.u32x4, out_ptr: *neon.u32x4) void {
    out_ptr.* = neon.vorrq_u32(arg0.*, arg1.*);
}

export fn check_vorrq_u64(arg0: *const neon.u64x2, arg1: *const neon.u64x2, out_ptr: *neon.u64x2) void {
    out_ptr.* = neon.vorrq_u64(arg0.*, arg1.*);
}

export fn check_veor_s8(arg0: neon.i8x8, arg1: neon.i8x8) neon.i8x8 {
    return neon.veor_s8(arg0, arg1);
}

export fn check_veor_s16(arg0: *const neon.i16x4, arg1: *const neon.i16x4, out_ptr: *neon.i16x4) void {
    out_ptr.* = neon.veor_s16(arg0.*, arg1.*);
}

export fn check_veor_s32(arg0: *const neon.i32x2, arg1: *const neon.i32x2, out_ptr: *neon.i32x2) void {
    out_ptr.* = neon.veor_s32(arg0.*, arg1.*);
}

export fn check_veor_s64(arg0: neon.i64x1, arg1: neon.i64x1) neon.i64x1 {
    return neon.veor_s64(arg0, arg1);
}

export fn check_veor_u8(arg0: neon.u8x8, arg1: neon.u8x8) neon.u8x8 {
    return neon.veor_u8(arg0, arg1);
}

export fn check_veor_u16(arg0: *const neon.u16x4, arg1: *const neon.u16x4, out_ptr: *neon.u16x4) void {
    out_ptr.* = neon.veor_u16(arg0.*, arg1.*);
}

export fn check_veor_u32(arg0: *const neon.u32x2, arg1: *const neon.u32x2, out_ptr: *neon.u32x2) void {
    out_ptr.* = neon.veor_u32(arg0.*, arg1.*);
}

export fn check_veor_u64(arg0: neon.u64x1, arg1: neon.u64x1) neon.u64x1 {
    return neon.veor_u64(arg0, arg1);
}

export fn check_veorq_s8(arg0: neon.i8x16, arg1: neon.i8x16) neon.i8x16 {
    return neon.veorq_s8(arg0, arg1);
}

export fn check_veorq_s16(arg0: neon.i16x8, arg1: neon.i16x8) neon.i16x8 {
    return neon.veorq_s16(arg0, arg1);
}

export fn check_veorq_s32(arg0: *const neon.i32x4, arg1: *const neon.i32x4, out_ptr: *neon.i32x4) void {
    out_ptr.* = neon.veorq_s32(arg0.*, arg1.*);
}

export fn check_veorq_s64(arg0: *const neon.i64x2, arg1: *const neon.i64x2, out_ptr: *neon.i64x2) void {
    out_ptr.* = neon.veorq_s64(arg0.*, arg1.*);
}

export fn check_veorq_u8(arg0: neon.u8x16, arg1: neon.u8x16) neon.u8x16 {
    return neon.veorq_u8(arg0, arg1);
}

export fn check_veorq_u16(arg0: neon.u16x8, arg1: neon.u16x8) neon.u16x8 {
    return neon.veorq_u16(arg0, arg1);
}

export fn check_veorq_u32(arg0: *const neon.u32x4, arg1: *const neon.u32x4, out_ptr: *neon.u32x4) void {
    out_ptr.* = neon.veorq_u32(arg0.*, arg1.*);
}

export fn check_veorq_u64(arg0: *const neon.u64x2, arg1: *const neon.u64x2, out_ptr: *neon.u64x2) void {
    out_ptr.* = neon.veorq_u64(arg0.*, arg1.*);
}

export fn check_vbic_s8(arg0: neon.i8x8, arg1: neon.i8x8) neon.i8x8 {
    return neon.vbic_s8(arg0, arg1);
}

export fn check_vbic_s16(arg0: *const neon.i16x4, arg1: *const neon.i16x4, out_ptr: *neon.i16x4) void {
    out_ptr.* = neon.vbic_s16(arg0.*, arg1.*);
}

export fn check_vbic_s32(arg0: *const neon.i32x2, arg1: *const neon.i32x2, out_ptr: *neon.i32x2) void {
    out_ptr.* = neon.vbic_s32(arg0.*, arg1.*);
}

export fn check_vbic_s64(arg0: neon.i64x1, arg1: neon.i64x1) neon.i64x1 {
    return neon.vbic_s64(arg0, arg1);
}

export fn check_vbic_u8(arg0: neon.u8x8, arg1: neon.u8x8) neon.u8x8 {
    return neon.vbic_u8(arg0, arg1);
}

export fn check_vbic_u16(arg0: *const neon.u16x4, arg1: *const neon.u16x4, out_ptr: *neon.u16x4) void {
    out_ptr.* = neon.vbic_u16(arg0.*, arg1.*);
}

export fn check_vbic_u32(arg0: *const neon.u32x2, arg1: *const neon.u32x2, out_ptr: *neon.u32x2) void {
    out_ptr.* = neon.vbic_u32(arg0.*, arg1.*);
}

export fn check_vbic_u64(arg0: neon.u64x1, arg1: neon.u64x1) neon.u64x1 {
    return neon.vbic_u64(arg0, arg1);
}

export fn check_vbicq_s8(arg0: neon.i8x16, arg1: neon.i8x16) neon.i8x16 {
    return neon.vbicq_s8(arg0, arg1);
}

export fn check_vbicq_s16(arg0: neon.i16x8, arg1: neon.i16x8) neon.i16x8 {
    return neon.vbicq_s16(arg0, arg1);
}

export fn check_vbicq_s32(arg0: *const neon.i32x4, arg1: *const neon.i32x4, out_ptr: *neon.i32x4) void {
    out_ptr.* = neon.vbicq_s32(arg0.*, arg1.*);
}

export fn check_vbicq_s64(arg0: *const neon.i64x2, arg1: *const neon.i64x2, out_ptr: *neon.i64x2) void {
    out_ptr.* = neon.vbicq_s64(arg0.*, arg1.*);
}

export fn check_vbicq_u8(arg0: neon.u8x16, arg1: neon.u8x16) neon.u8x16 {
    return neon.vbicq_u8(arg0, arg1);
}

export fn check_vbicq_u16(arg0: neon.u16x8, arg1: neon.u16x8) neon.u16x8 {
    return neon.vbicq_u16(arg0, arg1);
}

export fn check_vbicq_u32(arg0: *const neon.u32x4, arg1: *const neon.u32x4, out_ptr: *neon.u32x4) void {
    out_ptr.* = neon.vbicq_u32(arg0.*, arg1.*);
}

export fn check_vbicq_u64(arg0: *const neon.u64x2, arg1: *const neon.u64x2, out_ptr: *neon.u64x2) void {
    out_ptr.* = neon.vbicq_u64(arg0.*, arg1.*);
}

export fn check_vmvn_s8(arg0: neon.i8x8) neon.i8x8 {
    return neon.vmvn_s8(arg0);
}

export fn check_vmvn_s16(arg0: *const neon.i16x4, out_ptr: *neon.i16x4) void {
    out_ptr.* = neon.vmvn_s16(arg0.*);
}

export fn check_vmvn_s32(arg0: *const neon.i32x2, out_ptr: *neon.i32x2) void {
    out_ptr.* = neon.vmvn_s32(arg0.*);
}

export fn check_vmvn_u8(arg0: neon.u8x8) neon.u8x8 {
    return neon.vmvn_u8(arg0);
}

export fn check_vmvn_u16(arg0: *const neon.u16x4, out_ptr: *neon.u16x4) void {
    out_ptr.* = neon.vmvn_u16(arg0.*);
}

export fn check_vmvn_u32(arg0: *const neon.u32x2, out_ptr: *neon.u32x2) void {
    out_ptr.* = neon.vmvn_u32(arg0.*);
}

export fn check_vmvnq_s8(arg0: neon.i8x16) neon.i8x16 {
    return neon.vmvnq_s8(arg0);
}

export fn check_vmvnq_s16(arg0: neon.i16x8) neon.i16x8 {
    return neon.vmvnq_s16(arg0);
}

export fn check_vmvnq_s32(arg0: *const neon.i32x4, out_ptr: *neon.i32x4) void {
    out_ptr.* = neon.vmvnq_s32(arg0.*);
}

export fn check_vmvnq_u8(arg0: neon.u8x16) neon.u8x16 {
    return neon.vmvnq_u8(arg0);
}

export fn check_vmvnq_u16(arg0: neon.u16x8) neon.u16x8 {
    return neon.vmvnq_u16(arg0);
}

export fn check_vmvnq_u32(arg0: *const neon.u32x4, out_ptr: *neon.u32x4) void {
    out_ptr.* = neon.vmvnq_u32(arg0.*);
}

export fn check_vbsl_s8(arg0: neon.u8x8, arg1: neon.i8x8, arg2: neon.i8x8) neon.i8x8 {
    return neon.vbsl_s8(arg0, arg1, arg2);
}

export fn check_vbsl_s16(arg0: *const neon.u16x4, arg1: *const neon.i16x4, arg2: *const neon.i16x4, out_ptr: *neon.i16x4) void {
    out_ptr.* = neon.vbsl_s16(arg0.*, arg1.*, arg2.*);
}

export fn check_vbsl_s32(arg0: *const neon.u32x2, arg1: *const neon.i32x2, arg2: *const neon.i32x2, out_ptr: *neon.i32x2) void {
    out_ptr.* = neon.vbsl_s32(arg0.*, arg1.*, arg2.*);
}

export fn check_vbsl_s64(arg0: neon.u64x1, arg1: neon.i64x1, arg2: neon.i64x1) neon.i64x1 {
    return neon.vbsl_s64(arg0, arg1, arg2);
}

export fn check_vbsl_u8(arg0: neon.u8x8, arg1: neon.u8x8, arg2: neon.u8x8) neon.u8x8 {
    return neon.vbsl_u8(arg0, arg1, arg2);
}

export fn check_vbsl_u16(arg0: *const neon.u16x4, arg1: *const neon.u16x4, arg2: *const neon.u16x4, out_ptr: *neon.u16x4) void {
    out_ptr.* = neon.vbsl_u16(arg0.*, arg1.*, arg2.*);
}

export fn check_vbsl_u32(arg0: *const neon.u32x2, arg1: *const neon.u32x2, arg2: *const neon.u32x2, out_ptr: *neon.u32x2) void {
    out_ptr.* = neon.vbsl_u32(arg0.*, arg1.*, arg2.*);
}

export fn check_vbsl_u64(arg0: neon.u64x1, arg1: neon.u64x1, arg2: neon.u64x1) neon.u64x1 {
    return neon.vbsl_u64(arg0, arg1, arg2);
}

export fn check_vbsl_f32(arg0: *const neon.u32x2, arg1: *const neon.f32x2, arg2: *const neon.f32x2, out_ptr: *neon.f32x2) void {
    out_ptr.* = neon.vbsl_f32(arg0.*, arg1.*, arg2.*);
}

export fn check_vbsl_f64(arg0: neon.u64x1, arg1: neon.f64x1, arg2: neon.f64x1) neon.f64x1 {
    return neon.vbsl_f64(arg0, arg1, arg2);
}

export fn check_vbsl_p8(arg0: neon.u8x8, arg1: neon.p8x8, arg2: neon.p8x8) neon.p8x8 {
    return neon.vbsl_p8(arg0, arg1, arg2);
}

export fn check_vbsl_p16(arg0: *const neon.u16x4, arg1: *const neon.p16x4, arg2: *const neon.p16x4, out_ptr: *neon.p16x4) void {
    out_ptr.* = neon.vbsl_p16(arg0.*, arg1.*, arg2.*);
}

export fn check_vbsl_p64(arg0: neon.u64x1, arg1: neon.p64x1, arg2: neon.p64x1) neon.p64x1 {
    return neon.vbsl_p64(arg0, arg1, arg2);
}

export fn check_vbslq_s8(arg0: neon.u8x16, arg1: neon.i8x16, arg2: neon.i8x16) neon.i8x16 {
    return neon.vbslq_s8(arg0, arg1, arg2);
}

export fn check_vbslq_s16(arg0: neon.u16x8, arg1: neon.i16x8, arg2: neon.i16x8) neon.i16x8 {
    return neon.vbslq_s16(arg0, arg1, arg2);
}

export fn check_vbslq_s32(arg0: *const neon.u32x4, arg1: *const neon.i32x4, arg2: *const neon.i32x4, out_ptr: *neon.i32x4) void {
    out_ptr.* = neon.vbslq_s32(arg0.*, arg1.*, arg2.*);
}

export fn check_vbslq_s64(arg0: *const neon.u64x2, arg1: *const neon.i64x2, arg2: *const neon.i64x2, out_ptr: *neon.i64x2) void {
    out_ptr.* = neon.vbslq_s64(arg0.*, arg1.*, arg2.*);
}

export fn check_vbslq_u8(arg0: neon.u8x16, arg1: neon.u8x16, arg2: neon.u8x16) neon.u8x16 {
    return neon.vbslq_u8(arg0, arg1, arg2);
}

export fn check_vbslq_u16(arg0: neon.u16x8, arg1: neon.u16x8, arg2: neon.u16x8) neon.u16x8 {
    return neon.vbslq_u16(arg0, arg1, arg2);
}

export fn check_vbslq_u32(arg0: *const neon.u32x4, arg1: *const neon.u32x4, arg2: *const neon.u32x4, out_ptr: *neon.u32x4) void {
    out_ptr.* = neon.vbslq_u32(arg0.*, arg1.*, arg2.*);
}

export fn check_vbslq_u64(arg0: *const neon.u64x2, arg1: *const neon.u64x2, arg2: *const neon.u64x2, out_ptr: *neon.u64x2) void {
    out_ptr.* = neon.vbslq_u64(arg0.*, arg1.*, arg2.*);
}

export fn check_vbslq_f32(arg0: *const neon.u32x4, arg1: *const neon.f32x4, arg2: *const neon.f32x4, out_ptr: *neon.f32x4) void {
    out_ptr.* = neon.vbslq_f32(arg0.*, arg1.*, arg2.*);
}

export fn check_vbslq_f64(arg0: *const neon.u64x2, arg1: *const neon.f64x2, arg2: *const neon.f64x2, out_ptr: *neon.f64x2) void {
    out_ptr.* = neon.vbslq_f64(arg0.*, arg1.*, arg2.*);
}

export fn check_vbslq_p8(arg0: neon.u8x16, arg1: neon.p8x16, arg2: neon.p8x16) neon.p8x16 {
    return neon.vbslq_p8(arg0, arg1, arg2);
}

export fn check_vbslq_p16(arg0: neon.u16x8, arg1: neon.p16x8, arg2: neon.p16x8) neon.p16x8 {
    return neon.vbslq_p16(arg0, arg1, arg2);
}

export fn check_vbslq_p64(arg0: *const neon.u64x2, arg1: *const neon.p64x2, arg2: *const neon.p64x2, out_ptr: *neon.p64x2) void {
    out_ptr.* = neon.vbslq_p64(arg0.*, arg1.*, arg2.*);
}

export fn check_vbcaxq_s8(arg0: neon.i8x16, arg1: neon.i8x16, arg2: neon.i8x16) neon.i8x16 {
    return neon.vbcaxq_s8(arg0, arg1, arg2);
}

export fn check_vbcaxq_s16(arg0: neon.i16x8, arg1: neon.i16x8, arg2: neon.i16x8) neon.i16x8 {
    return neon.vbcaxq_s16(arg0, arg1, arg2);
}

export fn check_vbcaxq_s32(arg0: *const neon.i32x4, arg1: *const neon.i32x4, arg2: *const neon.i32x4, out_ptr: *neon.i32x4) void {
    out_ptr.* = neon.vbcaxq_s32(arg0.*, arg1.*, arg2.*);
}

export fn check_vbcaxq_s64(arg0: *const neon.i64x2, arg1: *const neon.i64x2, arg2: *const neon.i64x2, out_ptr: *neon.i64x2) void {
    out_ptr.* = neon.vbcaxq_s64(arg0.*, arg1.*, arg2.*);
}

export fn check_vbcaxq_u8(arg0: neon.u8x16, arg1: neon.u8x16, arg2: neon.u8x16) neon.u8x16 {
    return neon.vbcaxq_u8(arg0, arg1, arg2);
}

export fn check_vbcaxq_u16(arg0: neon.u16x8, arg1: neon.u16x8, arg2: neon.u16x8) neon.u16x8 {
    return neon.vbcaxq_u16(arg0, arg1, arg2);
}

export fn check_vbcaxq_u32(arg0: *const neon.u32x4, arg1: *const neon.u32x4, arg2: *const neon.u32x4, out_ptr: *neon.u32x4) void {
    out_ptr.* = neon.vbcaxq_u32(arg0.*, arg1.*, arg2.*);
}

export fn check_vbcaxq_u64(arg0: *const neon.u64x2, arg1: *const neon.u64x2, arg2: *const neon.u64x2, out_ptr: *neon.u64x2) void {
    out_ptr.* = neon.vbcaxq_u64(arg0.*, arg1.*, arg2.*);
}

export fn check_vcnt_u8(arg0: neon.u8x8) neon.u8x8 {
    return neon.vcnt_u8(arg0);
}

export fn check_vcnt_s8(arg0: neon.i8x8) neon.i8x8 {
    return neon.vcnt_s8(arg0);
}

export fn check_vcnt_p8(arg0: neon.p8x8) neon.p8x8 {
    return neon.vcnt_p8(arg0);
}

export fn check_vcntq_u8(arg0: neon.u8x16) neon.u8x16 {
    return neon.vcntq_u8(arg0);
}

export fn check_vcntq_s8(arg0: neon.i8x16) neon.i8x16 {
    return neon.vcntq_s8(arg0);
}

export fn check_vcntq_p8(arg0: neon.p8x16) neon.p8x16 {
    return neon.vcntq_p8(arg0);
}

export fn check_vclz_u8(arg0: neon.u8x8) neon.u8x8 {
    return neon.vclz_u8(arg0);
}

export fn check_vclz_u16(arg0: *const neon.u16x4, out_ptr: *neon.u16x4) void {
    out_ptr.* = neon.vclz_u16(arg0.*);
}

export fn check_vclz_u32(arg0: *const neon.u32x2, out_ptr: *neon.u32x2) void {
    out_ptr.* = neon.vclz_u32(arg0.*);
}

export fn check_vclz_s8(arg0: neon.i8x8) neon.i8x8 {
    return neon.vclz_s8(arg0);
}

export fn check_vclz_s16(arg0: *const neon.i16x4, out_ptr: *neon.i16x4) void {
    out_ptr.* = neon.vclz_s16(arg0.*);
}

export fn check_vclz_s32(arg0: *const neon.i32x2, out_ptr: *neon.i32x2) void {
    out_ptr.* = neon.vclz_s32(arg0.*);
}

export fn check_vclzq_u8(arg0: neon.u8x16) neon.u8x16 {
    return neon.vclzq_u8(arg0);
}

export fn check_vclzq_u16(arg0: neon.u16x8) neon.u16x8 {
    return neon.vclzq_u16(arg0);
}

export fn check_vclzq_u32(arg0: *const neon.u32x4, out_ptr: *neon.u32x4) void {
    out_ptr.* = neon.vclzq_u32(arg0.*);
}

export fn check_vclzq_s8(arg0: neon.i8x16) neon.i8x16 {
    return neon.vclzq_s8(arg0);
}

export fn check_vclzq_s16(arg0: neon.i16x8) neon.i16x8 {
    return neon.vclzq_s16(arg0);
}

export fn check_vclzq_s32(arg0: *const neon.i32x4, out_ptr: *neon.i32x4) void {
    out_ptr.* = neon.vclzq_s32(arg0.*);
}

export fn check_vaeseq_u8(arg0: neon.u8x16, arg1: neon.u8x16) neon.u8x16 {
    return neon.vaeseq_u8(arg0, arg1);
}

export fn check_vaesdq_u8(arg0: neon.u8x16, arg1: neon.u8x16) neon.u8x16 {
    return neon.vaesdq_u8(arg0, arg1);
}

export fn check_vaesmcq_u8(arg0: neon.u8x16) neon.u8x16 {
    return neon.vaesmcq_u8(arg0);
}

export fn check_vaesimcq_u8(arg0: neon.u8x16) neon.u8x16 {
    return neon.vaesimcq_u8(arg0);
}

export fn check_vmull_p8(arg0: neon.p8x8, arg1: neon.p8x8) neon.p16x8 {
    return neon.vmull_p8(arg0, arg1);
}

export fn check_vmull_p64(arg0: neon.p64, arg1: neon.p64) neon.p128 {
    return neon.vmull_p64(arg0, arg1);
}

export fn check_vmovl_s8(arg0: neon.i8x8) neon.i16x8 {
    return neon.vmovl_s8(arg0);
}

export fn check_vmovl_s16(arg0: *const neon.i16x4, out_ptr: *neon.i32x4) void {
    out_ptr.* = neon.vmovl_s16(arg0.*);
}

export fn check_vmovl_s32(arg0: *const neon.i32x2, out_ptr: *neon.i64x2) void {
    out_ptr.* = neon.vmovl_s32(arg0.*);
}

export fn check_vmovl_u8(arg0: neon.u8x8) neon.u16x8 {
    return neon.vmovl_u8(arg0);
}

export fn check_vmovl_u16(arg0: *const neon.u16x4, out_ptr: *neon.u32x4) void {
    out_ptr.* = neon.vmovl_u16(arg0.*);
}

export fn check_vmovl_u32(arg0: *const neon.u32x2, out_ptr: *neon.u64x2) void {
    out_ptr.* = neon.vmovl_u32(arg0.*);
}

export fn check_vmovl_high_s8(arg0: neon.i8x16) neon.i16x8 {
    return neon.vmovl_high_s8(arg0);
}

export fn check_vmovl_high_s16(arg0: neon.i16x8, out_ptr: *neon.i32x4) void {
    out_ptr.* = neon.vmovl_high_s16(arg0);
}

export fn check_vmovl_high_s32(arg0: *const neon.i32x4, out_ptr: *neon.i64x2) void {
    out_ptr.* = neon.vmovl_high_s32(arg0.*);
}

export fn check_vmovl_high_u8(arg0: neon.u8x16) neon.u16x8 {
    return neon.vmovl_high_u8(arg0);
}

export fn check_vmovl_high_u16(arg0: neon.u16x8, out_ptr: *neon.u32x4) void {
    out_ptr.* = neon.vmovl_high_u16(arg0);
}

export fn check_vmovl_high_u32(arg0: *const neon.u32x4, out_ptr: *neon.u64x2) void {
    out_ptr.* = neon.vmovl_high_u32(arg0.*);
}

export fn check_vmovn_s16(arg0: neon.i16x8) neon.i8x8 {
    return neon.vmovn_s16(arg0);
}

export fn check_vmovn_s32(arg0: *const neon.i32x4, out_ptr: *neon.i16x4) void {
    out_ptr.* = neon.vmovn_s32(arg0.*);
}

export fn check_vmovn_s64(arg0: *const neon.i64x2, out_ptr: *neon.i32x2) void {
    out_ptr.* = neon.vmovn_s64(arg0.*);
}

export fn check_vmovn_u16(arg0: neon.u16x8) neon.u8x8 {
    return neon.vmovn_u16(arg0);
}

export fn check_vmovn_u32(arg0: *const neon.u32x4, out_ptr: *neon.u16x4) void {
    out_ptr.* = neon.vmovn_u32(arg0.*);
}

export fn check_vmovn_u64(arg0: *const neon.u64x2, out_ptr: *neon.u32x2) void {
    out_ptr.* = neon.vmovn_u64(arg0.*);
}

export fn check_vcvt_f32_s32(arg0: *const neon.i32x2, out_ptr: *neon.f32x2) void {
    out_ptr.* = neon.vcvt_f32_s32(arg0.*);
}

export fn check_vcvt_f32_u32(arg0: *const neon.u32x2, out_ptr: *neon.f32x2) void {
    out_ptr.* = neon.vcvt_f32_u32(arg0.*);
}

export fn check_vcvt_s32_f32(arg0: *const neon.f32x2, out_ptr: *neon.i32x2) void {
    out_ptr.* = neon.vcvt_s32_f32(arg0.*);
}

export fn check_vcvt_u32_f32(arg0: *const neon.f32x2, out_ptr: *neon.u32x2) void {
    out_ptr.* = neon.vcvt_u32_f32(arg0.*);
}

export fn check_vcvtq_f32_s32(arg0: *const neon.i32x4, out_ptr: *neon.f32x4) void {
    out_ptr.* = neon.vcvtq_f32_s32(arg0.*);
}

export fn check_vcvtq_f32_u32(arg0: *const neon.u32x4, out_ptr: *neon.f32x4) void {
    out_ptr.* = neon.vcvtq_f32_u32(arg0.*);
}

export fn check_vcvtq_s32_f32(arg0: *const neon.f32x4, out_ptr: *neon.i32x4) void {
    out_ptr.* = neon.vcvtq_s32_f32(arg0.*);
}

export fn check_vcvtq_u32_f32(arg0: *const neon.f32x4, out_ptr: *neon.u32x4) void {
    out_ptr.* = neon.vcvtq_u32_f32(arg0.*);
}

export fn check_vcvtq_f64_s64(arg0: *const neon.i64x2, out_ptr: *neon.f64x2) void {
    out_ptr.* = neon.vcvtq_f64_s64(arg0.*);
}

export fn check_vcvtq_f64_u64(arg0: *const neon.u64x2, out_ptr: *neon.f64x2) void {
    out_ptr.* = neon.vcvtq_f64_u64(arg0.*);
}

export fn check_vcvtq_s64_f64(arg0: *const neon.f64x2, out_ptr: *neon.i64x2) void {
    out_ptr.* = neon.vcvtq_s64_f64(arg0.*);
}

export fn check_vcvtq_u64_f64(arg0: *const neon.f64x2, out_ptr: *neon.u64x2) void {
    out_ptr.* = neon.vcvtq_u64_f64(arg0.*);
}

export fn check_vreinterpret_s8_u8(arg0: neon.u8x8) neon.i8x8 {
    return neon.vreinterpret_s8_u8(arg0);
}

export fn check_vreinterpret_u8_s8(arg0: neon.i8x8) neon.u8x8 {
    return neon.vreinterpret_u8_s8(arg0);
}

export fn check_vreinterpret_s16_u16(arg0: *const neon.u16x4, out_ptr: *neon.i16x4) void {
    out_ptr.* = neon.vreinterpret_s16_u16(arg0.*);
}

export fn check_vreinterpret_u16_s16(arg0: *const neon.i16x4, out_ptr: *neon.u16x4) void {
    out_ptr.* = neon.vreinterpret_u16_s16(arg0.*);
}

export fn check_vreinterpret_s32_u32(arg0: *const neon.u32x2, out_ptr: *neon.i32x2) void {
    out_ptr.* = neon.vreinterpret_s32_u32(arg0.*);
}

export fn check_vreinterpret_u32_s32(arg0: *const neon.i32x2, out_ptr: *neon.u32x2) void {
    out_ptr.* = neon.vreinterpret_u32_s32(arg0.*);
}

export fn check_vreinterpret_f32_s32(arg0: *const neon.i32x2, out_ptr: *neon.f32x2) void {
    out_ptr.* = neon.vreinterpret_f32_s32(arg0.*);
}

export fn check_vreinterpret_s32_f32(arg0: *const neon.f32x2, out_ptr: *neon.i32x2) void {
    out_ptr.* = neon.vreinterpret_s32_f32(arg0.*);
}

export fn check_vreinterpret_f32_u32(arg0: *const neon.u32x2, out_ptr: *neon.f32x2) void {
    out_ptr.* = neon.vreinterpret_f32_u32(arg0.*);
}

export fn check_vreinterpret_u32_f32(arg0: *const neon.f32x2, out_ptr: *neon.u32x2) void {
    out_ptr.* = neon.vreinterpret_u32_f32(arg0.*);
}

export fn check_vreinterpretq_s8_u8(arg0: neon.u8x16) neon.i8x16 {
    return neon.vreinterpretq_s8_u8(arg0);
}

export fn check_vreinterpretq_u8_s8(arg0: neon.i8x16) neon.u8x16 {
    return neon.vreinterpretq_u8_s8(arg0);
}

export fn check_vreinterpretq_s16_u16(arg0: neon.u16x8) neon.i16x8 {
    return neon.vreinterpretq_s16_u16(arg0);
}

export fn check_vreinterpretq_u16_s16(arg0: neon.i16x8) neon.u16x8 {
    return neon.vreinterpretq_u16_s16(arg0);
}

export fn check_vreinterpretq_s32_u32(arg0: *const neon.u32x4, out_ptr: *neon.i32x4) void {
    out_ptr.* = neon.vreinterpretq_s32_u32(arg0.*);
}

export fn check_vreinterpretq_u32_s32(arg0: *const neon.i32x4, out_ptr: *neon.u32x4) void {
    out_ptr.* = neon.vreinterpretq_u32_s32(arg0.*);
}

export fn check_vreinterpretq_s64_u64(arg0: *const neon.u64x2, out_ptr: *neon.i64x2) void {
    out_ptr.* = neon.vreinterpretq_s64_u64(arg0.*);
}

export fn check_vreinterpretq_u64_s64(arg0: *const neon.i64x2, out_ptr: *neon.u64x2) void {
    out_ptr.* = neon.vreinterpretq_u64_s64(arg0.*);
}

export fn check_vreinterpretq_f32_s32(arg0: *const neon.i32x4, out_ptr: *neon.f32x4) void {
    out_ptr.* = neon.vreinterpretq_f32_s32(arg0.*);
}

export fn check_vreinterpretq_s32_f32(arg0: *const neon.f32x4, out_ptr: *neon.i32x4) void {
    out_ptr.* = neon.vreinterpretq_s32_f32(arg0.*);
}

export fn check_vreinterpretq_f32_u32(arg0: *const neon.u32x4, out_ptr: *neon.f32x4) void {
    out_ptr.* = neon.vreinterpretq_f32_u32(arg0.*);
}

export fn check_vreinterpretq_u32_f32(arg0: *const neon.f32x4, out_ptr: *neon.u32x4) void {
    out_ptr.* = neon.vreinterpretq_u32_f32(arg0.*);
}

export fn check_vreinterpretq_f64_s64(arg0: *const neon.i64x2, out_ptr: *neon.f64x2) void {
    out_ptr.* = neon.vreinterpretq_f64_s64(arg0.*);
}

export fn check_vreinterpretq_s64_f64(arg0: *const neon.f64x2, out_ptr: *neon.i64x2) void {
    out_ptr.* = neon.vreinterpretq_s64_f64(arg0.*);
}

export fn check_vreinterpretq_f64_u64(arg0: *const neon.u64x2, out_ptr: *neon.f64x2) void {
    out_ptr.* = neon.vreinterpretq_f64_u64(arg0.*);
}

export fn check_vreinterpretq_u64_f64(arg0: *const neon.f64x2, out_ptr: *neon.u64x2) void {
    out_ptr.* = neon.vreinterpretq_u64_f64(arg0.*);
}

export fn check_vceq_s8(arg0: neon.i8x8, arg1: neon.i8x8) neon.u8x8 {
    return neon.vceq_s8(arg0, arg1);
}

export fn check_vceq_s16(arg0: *const neon.i16x4, arg1: *const neon.i16x4, out_ptr: *neon.u16x4) void {
    out_ptr.* = neon.vceq_s16(arg0.*, arg1.*);
}

export fn check_vceq_s32(arg0: *const neon.i32x2, arg1: *const neon.i32x2, out_ptr: *neon.u32x2) void {
    out_ptr.* = neon.vceq_s32(arg0.*, arg1.*);
}

export fn check_vceq_u8(arg0: neon.u8x8, arg1: neon.u8x8) neon.u8x8 {
    return neon.vceq_u8(arg0, arg1);
}

export fn check_vceq_u16(arg0: *const neon.u16x4, arg1: *const neon.u16x4, out_ptr: *neon.u16x4) void {
    out_ptr.* = neon.vceq_u16(arg0.*, arg1.*);
}

export fn check_vceq_u32(arg0: *const neon.u32x2, arg1: *const neon.u32x2, out_ptr: *neon.u32x2) void {
    out_ptr.* = neon.vceq_u32(arg0.*, arg1.*);
}

export fn check_vceq_f32(arg0: *const neon.f32x2, arg1: *const neon.f32x2, out_ptr: *neon.u32x2) void {
    out_ptr.* = neon.vceq_f32(arg0.*, arg1.*);
}

export fn check_vceqq_s8(arg0: neon.i8x16, arg1: neon.i8x16) neon.u8x16 {
    return neon.vceqq_s8(arg0, arg1);
}

export fn check_vceqq_s16(arg0: neon.i16x8, arg1: neon.i16x8) neon.u16x8 {
    return neon.vceqq_s16(arg0, arg1);
}

export fn check_vceqq_s32(arg0: *const neon.i32x4, arg1: *const neon.i32x4, out_ptr: *neon.u32x4) void {
    out_ptr.* = neon.vceqq_s32(arg0.*, arg1.*);
}

export fn check_vceqq_u8(arg0: neon.u8x16, arg1: neon.u8x16) neon.u8x16 {
    return neon.vceqq_u8(arg0, arg1);
}

export fn check_vceqq_u16(arg0: neon.u16x8, arg1: neon.u16x8) neon.u16x8 {
    return neon.vceqq_u16(arg0, arg1);
}

export fn check_vceqq_u32(arg0: *const neon.u32x4, arg1: *const neon.u32x4, out_ptr: *neon.u32x4) void {
    out_ptr.* = neon.vceqq_u32(arg0.*, arg1.*);
}

export fn check_vceqq_f32(arg0: *const neon.f32x4, arg1: *const neon.f32x4, out_ptr: *neon.u32x4) void {
    out_ptr.* = neon.vceqq_f32(arg0.*, arg1.*);
}

export fn check_vceqq_f64(arg0: *const neon.f64x2, arg1: *const neon.f64x2, out_ptr: *neon.u64x2) void {
    out_ptr.* = neon.vceqq_f64(arg0.*, arg1.*);
}

export fn check_vcge_s8(arg0: neon.i8x8, arg1: neon.i8x8) neon.u8x8 {
    return neon.vcge_s8(arg0, arg1);
}

export fn check_vcge_s16(arg0: *const neon.i16x4, arg1: *const neon.i16x4, out_ptr: *neon.u16x4) void {
    out_ptr.* = neon.vcge_s16(arg0.*, arg1.*);
}

export fn check_vcge_s32(arg0: *const neon.i32x2, arg1: *const neon.i32x2, out_ptr: *neon.u32x2) void {
    out_ptr.* = neon.vcge_s32(arg0.*, arg1.*);
}

export fn check_vcge_u8(arg0: neon.u8x8, arg1: neon.u8x8) neon.u8x8 {
    return neon.vcge_u8(arg0, arg1);
}

export fn check_vcge_u16(arg0: *const neon.u16x4, arg1: *const neon.u16x4, out_ptr: *neon.u16x4) void {
    out_ptr.* = neon.vcge_u16(arg0.*, arg1.*);
}

export fn check_vcge_u32(arg0: *const neon.u32x2, arg1: *const neon.u32x2, out_ptr: *neon.u32x2) void {
    out_ptr.* = neon.vcge_u32(arg0.*, arg1.*);
}

export fn check_vcge_f32(arg0: *const neon.f32x2, arg1: *const neon.f32x2, out_ptr: *neon.u32x2) void {
    out_ptr.* = neon.vcge_f32(arg0.*, arg1.*);
}

export fn check_vcgeq_s8(arg0: neon.i8x16, arg1: neon.i8x16) neon.u8x16 {
    return neon.vcgeq_s8(arg0, arg1);
}

export fn check_vcgeq_s16(arg0: neon.i16x8, arg1: neon.i16x8) neon.u16x8 {
    return neon.vcgeq_s16(arg0, arg1);
}

export fn check_vcgeq_s32(arg0: *const neon.i32x4, arg1: *const neon.i32x4, out_ptr: *neon.u32x4) void {
    out_ptr.* = neon.vcgeq_s32(arg0.*, arg1.*);
}

export fn check_vcgeq_u8(arg0: neon.u8x16, arg1: neon.u8x16) neon.u8x16 {
    return neon.vcgeq_u8(arg0, arg1);
}

export fn check_vcgeq_u16(arg0: neon.u16x8, arg1: neon.u16x8) neon.u16x8 {
    return neon.vcgeq_u16(arg0, arg1);
}

export fn check_vcgeq_u32(arg0: *const neon.u32x4, arg1: *const neon.u32x4, out_ptr: *neon.u32x4) void {
    out_ptr.* = neon.vcgeq_u32(arg0.*, arg1.*);
}

export fn check_vcgeq_f32(arg0: *const neon.f32x4, arg1: *const neon.f32x4, out_ptr: *neon.u32x4) void {
    out_ptr.* = neon.vcgeq_f32(arg0.*, arg1.*);
}

export fn check_vcgeq_f64(arg0: *const neon.f64x2, arg1: *const neon.f64x2, out_ptr: *neon.u64x2) void {
    out_ptr.* = neon.vcgeq_f64(arg0.*, arg1.*);
}

export fn check_vcgt_s8(arg0: neon.i8x8, arg1: neon.i8x8) neon.u8x8 {
    return neon.vcgt_s8(arg0, arg1);
}

export fn check_vcgt_s16(arg0: *const neon.i16x4, arg1: *const neon.i16x4, out_ptr: *neon.u16x4) void {
    out_ptr.* = neon.vcgt_s16(arg0.*, arg1.*);
}

export fn check_vcgt_s32(arg0: *const neon.i32x2, arg1: *const neon.i32x2, out_ptr: *neon.u32x2) void {
    out_ptr.* = neon.vcgt_s32(arg0.*, arg1.*);
}

export fn check_vcgt_u8(arg0: neon.u8x8, arg1: neon.u8x8) neon.u8x8 {
    return neon.vcgt_u8(arg0, arg1);
}

export fn check_vcgt_u16(arg0: *const neon.u16x4, arg1: *const neon.u16x4, out_ptr: *neon.u16x4) void {
    out_ptr.* = neon.vcgt_u16(arg0.*, arg1.*);
}

export fn check_vcgt_u32(arg0: *const neon.u32x2, arg1: *const neon.u32x2, out_ptr: *neon.u32x2) void {
    out_ptr.* = neon.vcgt_u32(arg0.*, arg1.*);
}

export fn check_vcgt_f32(arg0: *const neon.f32x2, arg1: *const neon.f32x2, out_ptr: *neon.u32x2) void {
    out_ptr.* = neon.vcgt_f32(arg0.*, arg1.*);
}

export fn check_vcgtq_s8(arg0: neon.i8x16, arg1: neon.i8x16) neon.u8x16 {
    return neon.vcgtq_s8(arg0, arg1);
}

export fn check_vcgtq_s16(arg0: neon.i16x8, arg1: neon.i16x8) neon.u16x8 {
    return neon.vcgtq_s16(arg0, arg1);
}

export fn check_vcgtq_s32(arg0: *const neon.i32x4, arg1: *const neon.i32x4, out_ptr: *neon.u32x4) void {
    out_ptr.* = neon.vcgtq_s32(arg0.*, arg1.*);
}

export fn check_vcgtq_u8(arg0: neon.u8x16, arg1: neon.u8x16) neon.u8x16 {
    return neon.vcgtq_u8(arg0, arg1);
}

export fn check_vcgtq_u16(arg0: neon.u16x8, arg1: neon.u16x8) neon.u16x8 {
    return neon.vcgtq_u16(arg0, arg1);
}

export fn check_vcgtq_u32(arg0: *const neon.u32x4, arg1: *const neon.u32x4, out_ptr: *neon.u32x4) void {
    out_ptr.* = neon.vcgtq_u32(arg0.*, arg1.*);
}

export fn check_vcgtq_f32(arg0: *const neon.f32x4, arg1: *const neon.f32x4, out_ptr: *neon.u32x4) void {
    out_ptr.* = neon.vcgtq_f32(arg0.*, arg1.*);
}

export fn check_vcgtq_f64(arg0: *const neon.f64x2, arg1: *const neon.f64x2, out_ptr: *neon.u64x2) void {
    out_ptr.* = neon.vcgtq_f64(arg0.*, arg1.*);
}

export fn check_vcle_s8(arg0: neon.i8x8, arg1: neon.i8x8) neon.u8x8 {
    return neon.vcle_s8(arg0, arg1);
}

export fn check_vcle_s16(arg0: *const neon.i16x4, arg1: *const neon.i16x4, out_ptr: *neon.u16x4) void {
    out_ptr.* = neon.vcle_s16(arg0.*, arg1.*);
}

export fn check_vcle_s32(arg0: *const neon.i32x2, arg1: *const neon.i32x2, out_ptr: *neon.u32x2) void {
    out_ptr.* = neon.vcle_s32(arg0.*, arg1.*);
}

export fn check_vcle_u8(arg0: neon.u8x8, arg1: neon.u8x8) neon.u8x8 {
    return neon.vcle_u8(arg0, arg1);
}

export fn check_vcle_u16(arg0: *const neon.u16x4, arg1: *const neon.u16x4, out_ptr: *neon.u16x4) void {
    out_ptr.* = neon.vcle_u16(arg0.*, arg1.*);
}

export fn check_vcle_u32(arg0: *const neon.u32x2, arg1: *const neon.u32x2, out_ptr: *neon.u32x2) void {
    out_ptr.* = neon.vcle_u32(arg0.*, arg1.*);
}

export fn check_vcle_f32(arg0: *const neon.f32x2, arg1: *const neon.f32x2, out_ptr: *neon.u32x2) void {
    out_ptr.* = neon.vcle_f32(arg0.*, arg1.*);
}

export fn check_vcleq_s8(arg0: neon.i8x16, arg1: neon.i8x16) neon.u8x16 {
    return neon.vcleq_s8(arg0, arg1);
}

export fn check_vcleq_s16(arg0: neon.i16x8, arg1: neon.i16x8) neon.u16x8 {
    return neon.vcleq_s16(arg0, arg1);
}

export fn check_vcleq_s32(arg0: *const neon.i32x4, arg1: *const neon.i32x4, out_ptr: *neon.u32x4) void {
    out_ptr.* = neon.vcleq_s32(arg0.*, arg1.*);
}

export fn check_vcleq_u8(arg0: neon.u8x16, arg1: neon.u8x16) neon.u8x16 {
    return neon.vcleq_u8(arg0, arg1);
}

export fn check_vcleq_u16(arg0: neon.u16x8, arg1: neon.u16x8) neon.u16x8 {
    return neon.vcleq_u16(arg0, arg1);
}

export fn check_vcleq_u32(arg0: *const neon.u32x4, arg1: *const neon.u32x4, out_ptr: *neon.u32x4) void {
    out_ptr.* = neon.vcleq_u32(arg0.*, arg1.*);
}

export fn check_vcleq_f32(arg0: *const neon.f32x4, arg1: *const neon.f32x4, out_ptr: *neon.u32x4) void {
    out_ptr.* = neon.vcleq_f32(arg0.*, arg1.*);
}

export fn check_vcleq_f64(arg0: *const neon.f64x2, arg1: *const neon.f64x2, out_ptr: *neon.u64x2) void {
    out_ptr.* = neon.vcleq_f64(arg0.*, arg1.*);
}

export fn check_vclt_s8(arg0: neon.i8x8, arg1: neon.i8x8) neon.u8x8 {
    return neon.vclt_s8(arg0, arg1);
}

export fn check_vclt_s16(arg0: *const neon.i16x4, arg1: *const neon.i16x4, out_ptr: *neon.u16x4) void {
    out_ptr.* = neon.vclt_s16(arg0.*, arg1.*);
}

export fn check_vclt_s32(arg0: *const neon.i32x2, arg1: *const neon.i32x2, out_ptr: *neon.u32x2) void {
    out_ptr.* = neon.vclt_s32(arg0.*, arg1.*);
}

export fn check_vclt_u8(arg0: neon.u8x8, arg1: neon.u8x8) neon.u8x8 {
    return neon.vclt_u8(arg0, arg1);
}

export fn check_vclt_u16(arg0: *const neon.u16x4, arg1: *const neon.u16x4, out_ptr: *neon.u16x4) void {
    out_ptr.* = neon.vclt_u16(arg0.*, arg1.*);
}

export fn check_vclt_u32(arg0: *const neon.u32x2, arg1: *const neon.u32x2, out_ptr: *neon.u32x2) void {
    out_ptr.* = neon.vclt_u32(arg0.*, arg1.*);
}

export fn check_vclt_f32(arg0: *const neon.f32x2, arg1: *const neon.f32x2, out_ptr: *neon.u32x2) void {
    out_ptr.* = neon.vclt_f32(arg0.*, arg1.*);
}

export fn check_vcltq_s8(arg0: neon.i8x16, arg1: neon.i8x16) neon.u8x16 {
    return neon.vcltq_s8(arg0, arg1);
}

export fn check_vcltq_s16(arg0: neon.i16x8, arg1: neon.i16x8) neon.u16x8 {
    return neon.vcltq_s16(arg0, arg1);
}

export fn check_vcltq_s32(arg0: *const neon.i32x4, arg1: *const neon.i32x4, out_ptr: *neon.u32x4) void {
    out_ptr.* = neon.vcltq_s32(arg0.*, arg1.*);
}

export fn check_vcltq_u8(arg0: neon.u8x16, arg1: neon.u8x16) neon.u8x16 {
    return neon.vcltq_u8(arg0, arg1);
}

export fn check_vcltq_u16(arg0: neon.u16x8, arg1: neon.u16x8) neon.u16x8 {
    return neon.vcltq_u16(arg0, arg1);
}

export fn check_vcltq_u32(arg0: *const neon.u32x4, arg1: *const neon.u32x4, out_ptr: *neon.u32x4) void {
    out_ptr.* = neon.vcltq_u32(arg0.*, arg1.*);
}

export fn check_vcltq_f32(arg0: *const neon.f32x4, arg1: *const neon.f32x4, out_ptr: *neon.u32x4) void {
    out_ptr.* = neon.vcltq_f32(arg0.*, arg1.*);
}

export fn check_vcltq_f64(arg0: *const neon.f64x2, arg1: *const neon.f64x2, out_ptr: *neon.u64x2) void {
    out_ptr.* = neon.vcltq_f64(arg0.*, arg1.*);
}

export fn check_vcage_f32(arg0: *const neon.f32x2, arg1: *const neon.f32x2, out_ptr: *neon.u32x2) void {
    out_ptr.* = neon.vcage_f32(arg0.*, arg1.*);
}

export fn check_vcage_f64(arg0: neon.f64x1, arg1: neon.f64x1) neon.u64x1 {
    return neon.vcage_f64(arg0, arg1);
}

export fn check_vcageq_f32(arg0: *const neon.f32x4, arg1: *const neon.f32x4, out_ptr: *neon.u32x4) void {
    out_ptr.* = neon.vcageq_f32(arg0.*, arg1.*);
}

export fn check_vcageq_f64(arg0: *const neon.f64x2, arg1: *const neon.f64x2, out_ptr: *neon.u64x2) void {
    out_ptr.* = neon.vcageq_f64(arg0.*, arg1.*);
}

export fn check_vcagt_f32(arg0: *const neon.f32x2, arg1: *const neon.f32x2, out_ptr: *neon.u32x2) void {
    out_ptr.* = neon.vcagt_f32(arg0.*, arg1.*);
}

export fn check_vcagt_f64(arg0: neon.f64x1, arg1: neon.f64x1) neon.u64x1 {
    return neon.vcagt_f64(arg0, arg1);
}

export fn check_vcagtq_f32(arg0: *const neon.f32x4, arg1: *const neon.f32x4, out_ptr: *neon.u32x4) void {
    out_ptr.* = neon.vcagtq_f32(arg0.*, arg1.*);
}

export fn check_vcagtq_f64(arg0: *const neon.f64x2, arg1: *const neon.f64x2, out_ptr: *neon.u64x2) void {
    out_ptr.* = neon.vcagtq_f64(arg0.*, arg1.*);
}

export fn check_vmin_s8(arg0: neon.i8x8, arg1: neon.i8x8) neon.i8x8 {
    return neon.vmin_s8(arg0, arg1);
}

export fn check_vmin_s16(arg0: *const neon.i16x4, arg1: *const neon.i16x4, out_ptr: *neon.i16x4) void {
    out_ptr.* = neon.vmin_s16(arg0.*, arg1.*);
}

export fn check_vmin_s32(arg0: *const neon.i32x2, arg1: *const neon.i32x2, out_ptr: *neon.i32x2) void {
    out_ptr.* = neon.vmin_s32(arg0.*, arg1.*);
}

export fn check_vmin_u8(arg0: neon.u8x8, arg1: neon.u8x8) neon.u8x8 {
    return neon.vmin_u8(arg0, arg1);
}

export fn check_vmin_u16(arg0: *const neon.u16x4, arg1: *const neon.u16x4, out_ptr: *neon.u16x4) void {
    out_ptr.* = neon.vmin_u16(arg0.*, arg1.*);
}

export fn check_vmin_u32(arg0: *const neon.u32x2, arg1: *const neon.u32x2, out_ptr: *neon.u32x2) void {
    out_ptr.* = neon.vmin_u32(arg0.*, arg1.*);
}

export fn check_vmin_f16(arg0: *const neon.f16x4, arg1: *const neon.f16x4, out_ptr: *neon.f16x4) void {
    out_ptr.* = neon.vmin_f16(arg0.*, arg1.*);
}

export fn check_vmin_f32(arg0: *const neon.f32x2, arg1: *const neon.f32x2, out_ptr: *neon.f32x2) void {
    out_ptr.* = neon.vmin_f32(arg0.*, arg1.*);
}

export fn check_vmin_f64(arg0: neon.f64x1, arg1: neon.f64x1) neon.f64x1 {
    return neon.vmin_f64(arg0, arg1);
}

export fn check_vminq_s8(arg0: neon.i8x16, arg1: neon.i8x16) neon.i8x16 {
    return neon.vminq_s8(arg0, arg1);
}

export fn check_vminq_s16(arg0: neon.i16x8, arg1: neon.i16x8) neon.i16x8 {
    return neon.vminq_s16(arg0, arg1);
}

export fn check_vminq_s32(arg0: *const neon.i32x4, arg1: *const neon.i32x4, out_ptr: *neon.i32x4) void {
    out_ptr.* = neon.vminq_s32(arg0.*, arg1.*);
}

export fn check_vminq_u8(arg0: neon.u8x16, arg1: neon.u8x16) neon.u8x16 {
    return neon.vminq_u8(arg0, arg1);
}

export fn check_vminq_u16(arg0: neon.u16x8, arg1: neon.u16x8) neon.u16x8 {
    return neon.vminq_u16(arg0, arg1);
}

export fn check_vminq_u32(arg0: *const neon.u32x4, arg1: *const neon.u32x4, out_ptr: *neon.u32x4) void {
    out_ptr.* = neon.vminq_u32(arg0.*, arg1.*);
}

export fn check_vminq_f16(arg0: neon.f16x8, arg1: neon.f16x8) neon.f16x8 {
    return neon.vminq_f16(arg0, arg1);
}

export fn check_vminq_f32(arg0: *const neon.f32x4, arg1: *const neon.f32x4, out_ptr: *neon.f32x4) void {
    out_ptr.* = neon.vminq_f32(arg0.*, arg1.*);
}

export fn check_vminq_f64(arg0: *const neon.f64x2, arg1: *const neon.f64x2, out_ptr: *neon.f64x2) void {
    out_ptr.* = neon.vminq_f64(arg0.*, arg1.*);
}

export fn check_vmax_s8(arg0: neon.i8x8, arg1: neon.i8x8) neon.i8x8 {
    return neon.vmax_s8(arg0, arg1);
}

export fn check_vmax_s16(arg0: *const neon.i16x4, arg1: *const neon.i16x4, out_ptr: *neon.i16x4) void {
    out_ptr.* = neon.vmax_s16(arg0.*, arg1.*);
}

export fn check_vmax_s32(arg0: *const neon.i32x2, arg1: *const neon.i32x2, out_ptr: *neon.i32x2) void {
    out_ptr.* = neon.vmax_s32(arg0.*, arg1.*);
}

export fn check_vmax_u8(arg0: neon.u8x8, arg1: neon.u8x8) neon.u8x8 {
    return neon.vmax_u8(arg0, arg1);
}

export fn check_vmax_u16(arg0: *const neon.u16x4, arg1: *const neon.u16x4, out_ptr: *neon.u16x4) void {
    out_ptr.* = neon.vmax_u16(arg0.*, arg1.*);
}

export fn check_vmax_u32(arg0: *const neon.u32x2, arg1: *const neon.u32x2, out_ptr: *neon.u32x2) void {
    out_ptr.* = neon.vmax_u32(arg0.*, arg1.*);
}

export fn check_vmax_f16(arg0: *const neon.f16x4, arg1: *const neon.f16x4, out_ptr: *neon.f16x4) void {
    out_ptr.* = neon.vmax_f16(arg0.*, arg1.*);
}

export fn check_vmax_f32(arg0: *const neon.f32x2, arg1: *const neon.f32x2, out_ptr: *neon.f32x2) void {
    out_ptr.* = neon.vmax_f32(arg0.*, arg1.*);
}

export fn check_vmax_f64(arg0: neon.f64x1, arg1: neon.f64x1) neon.f64x1 {
    return neon.vmax_f64(arg0, arg1);
}

export fn check_vmaxq_s8(arg0: neon.i8x16, arg1: neon.i8x16) neon.i8x16 {
    return neon.vmaxq_s8(arg0, arg1);
}

export fn check_vmaxq_s16(arg0: neon.i16x8, arg1: neon.i16x8) neon.i16x8 {
    return neon.vmaxq_s16(arg0, arg1);
}

export fn check_vmaxq_s32(arg0: *const neon.i32x4, arg1: *const neon.i32x4, out_ptr: *neon.i32x4) void {
    out_ptr.* = neon.vmaxq_s32(arg0.*, arg1.*);
}

export fn check_vmaxq_u8(arg0: neon.u8x16, arg1: neon.u8x16) neon.u8x16 {
    return neon.vmaxq_u8(arg0, arg1);
}

export fn check_vmaxq_u16(arg0: neon.u16x8, arg1: neon.u16x8) neon.u16x8 {
    return neon.vmaxq_u16(arg0, arg1);
}

export fn check_vmaxq_u32(arg0: *const neon.u32x4, arg1: *const neon.u32x4, out_ptr: *neon.u32x4) void {
    out_ptr.* = neon.vmaxq_u32(arg0.*, arg1.*);
}

export fn check_vmaxq_f16(arg0: neon.f16x8, arg1: neon.f16x8) neon.f16x8 {
    return neon.vmaxq_f16(arg0, arg1);
}

export fn check_vmaxq_f32(arg0: *const neon.f32x4, arg1: *const neon.f32x4, out_ptr: *neon.f32x4) void {
    out_ptr.* = neon.vmaxq_f32(arg0.*, arg1.*);
}

export fn check_vmaxq_f64(arg0: *const neon.f64x2, arg1: *const neon.f64x2, out_ptr: *neon.f64x2) void {
    out_ptr.* = neon.vmaxq_f64(arg0.*, arg1.*);
}

export fn check_vget_low_s8(arg0: neon.i8x16) neon.i8x8 {
    return neon.vget_low_s8(arg0);
}

export fn check_vget_low_s16(arg0: neon.i16x8, out_ptr: *neon.i16x4) void {
    out_ptr.* = neon.vget_low_s16(arg0);
}

export fn check_vget_low_s32(arg0: *const neon.i32x4, out_ptr: *neon.i32x2) void {
    out_ptr.* = neon.vget_low_s32(arg0.*);
}

export fn check_vget_low_s64(arg0: *const neon.i64x2) neon.i64x1 {
    return neon.vget_low_s64(arg0.*);
}

export fn check_vget_low_u8(arg0: neon.u8x16) neon.u8x8 {
    return neon.vget_low_u8(arg0);
}

export fn check_vget_low_u16(arg0: neon.u16x8, out_ptr: *neon.u16x4) void {
    out_ptr.* = neon.vget_low_u16(arg0);
}

export fn check_vget_low_u32(arg0: *const neon.u32x4, out_ptr: *neon.u32x2) void {
    out_ptr.* = neon.vget_low_u32(arg0.*);
}

export fn check_vget_low_u64(arg0: *const neon.u64x2) neon.u64x1 {
    return neon.vget_low_u64(arg0.*);
}

export fn check_vget_low_f16(arg0: neon.f16x8, out_ptr: *neon.f16x4) void {
    out_ptr.* = neon.vget_low_f16(arg0);
}

export fn check_vget_low_f32(arg0: *const neon.f32x4, out_ptr: *neon.f32x2) void {
    out_ptr.* = neon.vget_low_f32(arg0.*);
}

export fn check_vget_low_f64(arg0: *const neon.f64x2) neon.f64x1 {
    return neon.vget_low_f64(arg0.*);
}

export fn check_vget_low_p8(arg0: neon.p8x16) neon.p8x8 {
    return neon.vget_low_p8(arg0);
}

export fn check_vget_low_p16(arg0: neon.p16x8, out_ptr: *neon.p16x4) void {
    out_ptr.* = neon.vget_low_p16(arg0);
}

export fn check_vget_low_p64(arg0: *const neon.p64x2) neon.p64x1 {
    return neon.vget_low_p64(arg0.*);
}

export fn check_vget_high_s8(arg0: neon.i8x16) neon.i8x8 {
    return neon.vget_high_s8(arg0);
}

export fn check_vget_high_s16(arg0: neon.i16x8, out_ptr: *neon.i16x4) void {
    out_ptr.* = neon.vget_high_s16(arg0);
}

export fn check_vget_high_s32(arg0: *const neon.i32x4, out_ptr: *neon.i32x2) void {
    out_ptr.* = neon.vget_high_s32(arg0.*);
}

export fn check_vget_high_s64(arg0: *const neon.i64x2) neon.i64x1 {
    return neon.vget_high_s64(arg0.*);
}

export fn check_vget_high_u8(arg0: neon.u8x16) neon.u8x8 {
    return neon.vget_high_u8(arg0);
}

export fn check_vget_high_u16(arg0: neon.u16x8, out_ptr: *neon.u16x4) void {
    out_ptr.* = neon.vget_high_u16(arg0);
}

export fn check_vget_high_u32(arg0: *const neon.u32x4, out_ptr: *neon.u32x2) void {
    out_ptr.* = neon.vget_high_u32(arg0.*);
}

export fn check_vget_high_u64(arg0: *const neon.u64x2) neon.u64x1 {
    return neon.vget_high_u64(arg0.*);
}

export fn check_vget_high_f16(arg0: neon.f16x8, out_ptr: *neon.f16x4) void {
    out_ptr.* = neon.vget_high_f16(arg0);
}

export fn check_vget_high_f32(arg0: *const neon.f32x4, out_ptr: *neon.f32x2) void {
    out_ptr.* = neon.vget_high_f32(arg0.*);
}

export fn check_vget_high_f64(arg0: *const neon.f64x2) neon.f64x1 {
    return neon.vget_high_f64(arg0.*);
}

export fn check_vget_high_p8(arg0: neon.p8x16) neon.p8x8 {
    return neon.vget_high_p8(arg0);
}

export fn check_vget_high_p16(arg0: neon.p16x8, out_ptr: *neon.p16x4) void {
    out_ptr.* = neon.vget_high_p16(arg0);
}

export fn check_vget_high_p64(arg0: *const neon.p64x2) neon.p64x1 {
    return neon.vget_high_p64(arg0.*);
}

export fn check_vcombine_s8(arg0: neon.i8x8, arg1: neon.i8x8) neon.i8x16 {
    return neon.vcombine_s8(arg0, arg1);
}

export fn check_vcombine_s16(arg0: *const neon.i16x4, arg1: *const neon.i16x4) neon.i16x8 {
    return neon.vcombine_s16(arg0.*, arg1.*);
}

export fn check_vcombine_s32(arg0: *const neon.i32x2, arg1: *const neon.i32x2, out_ptr: *neon.i32x4) void {
    out_ptr.* = neon.vcombine_s32(arg0.*, arg1.*);
}

export fn check_vcombine_s64(arg0: neon.i64x1, arg1: neon.i64x1, out_ptr: *neon.i64x2) void {
    out_ptr.* = neon.vcombine_s64(arg0, arg1);
}

export fn check_vcombine_u8(arg0: neon.u8x8, arg1: neon.u8x8) neon.u8x16 {
    return neon.vcombine_u8(arg0, arg1);
}

export fn check_vcombine_u16(arg0: *const neon.u16x4, arg1: *const neon.u16x4) neon.u16x8 {
    return neon.vcombine_u16(arg0.*, arg1.*);
}

export fn check_vcombine_u32(arg0: *const neon.u32x2, arg1: *const neon.u32x2, out_ptr: *neon.u32x4) void {
    out_ptr.* = neon.vcombine_u32(arg0.*, arg1.*);
}

export fn check_vcombine_u64(arg0: neon.u64x1, arg1: neon.u64x1, out_ptr: *neon.u64x2) void {
    out_ptr.* = neon.vcombine_u64(arg0, arg1);
}

export fn check_vcombine_f16(arg0: *const neon.f16x4, arg1: *const neon.f16x4) neon.f16x8 {
    return neon.vcombine_f16(arg0.*, arg1.*);
}

export fn check_vcombine_f32(arg0: *const neon.f32x2, arg1: *const neon.f32x2, out_ptr: *neon.f32x4) void {
    out_ptr.* = neon.vcombine_f32(arg0.*, arg1.*);
}

export fn check_vcombine_f64(arg0: neon.f64x1, arg1: neon.f64x1, out_ptr: *neon.f64x2) void {
    out_ptr.* = neon.vcombine_f64(arg0, arg1);
}

export fn check_vcombine_p8(arg0: neon.p8x8, arg1: neon.p8x8) neon.p8x16 {
    return neon.vcombine_p8(arg0, arg1);
}

export fn check_vcombine_p16(arg0: *const neon.p16x4, arg1: *const neon.p16x4) neon.p16x8 {
    return neon.vcombine_p16(arg0.*, arg1.*);
}

export fn check_vcombine_p64(arg0: neon.p64x1, arg1: neon.p64x1, out_ptr: *neon.p64x2) void {
    out_ptr.* = neon.vcombine_p64(arg0, arg1);
}

export fn check_vget_lane_s8(arg0: neon.i8x8) i8 {
    return neon.vget_lane_s8(arg0, 0);
}

export fn check_vget_lane_s16(arg0: *const neon.i16x4) i16 {
    return neon.vget_lane_s16(arg0.*, 0);
}

export fn check_vget_lane_s32(arg0: *const neon.i32x2) i32 {
    return neon.vget_lane_s32(arg0.*, 0);
}

export fn check_vget_lane_s64(arg0: neon.i64x1) i64 {
    return neon.vget_lane_s64(arg0, 0);
}

export fn check_vget_lane_u8(arg0: neon.u8x8) u8 {
    return neon.vget_lane_u8(arg0, 0);
}

export fn check_vget_lane_u16(arg0: *const neon.u16x4) u16 {
    return neon.vget_lane_u16(arg0.*, 0);
}

export fn check_vget_lane_u32(arg0: *const neon.u32x2) u32 {
    return neon.vget_lane_u32(arg0.*, 0);
}

export fn check_vget_lane_u64(arg0: neon.u64x1) u64 {
    return neon.vget_lane_u64(arg0, 0);
}

export fn check_vget_lane_f16(arg0: *const neon.f16x4) f16 {
    return neon.vget_lane_f16(arg0.*, 0);
}

export fn check_vget_lane_f32(arg0: *const neon.f32x2) f32 {
    return neon.vget_lane_f32(arg0.*, 0);
}

export fn check_vget_lane_f64(arg0: neon.f64x1) f64 {
    return neon.vget_lane_f64(arg0, 0);
}

export fn check_vget_lane_p8(arg0: neon.p8x8) neon.p8 {
    return neon.vget_lane_p8(arg0, 0);
}

export fn check_vget_lane_p16(arg0: *const neon.p16x4) neon.p16 {
    return neon.vget_lane_p16(arg0.*, 0);
}

export fn check_vget_lane_p64(arg0: neon.p64x1) neon.p64 {
    return neon.vget_lane_p64(arg0, 0);
}

export fn check_vgetq_lane_s8(arg0: neon.i8x16) i8 {
    return neon.vgetq_lane_s8(arg0, 0);
}

export fn check_vgetq_lane_s16(arg0: neon.i16x8) i16 {
    return neon.vgetq_lane_s16(arg0, 0);
}

export fn check_vgetq_lane_s32(arg0: *const neon.i32x4) i32 {
    return neon.vgetq_lane_s32(arg0.*, 0);
}

export fn check_vgetq_lane_s64(arg0: *const neon.i64x2) i64 {
    return neon.vgetq_lane_s64(arg0.*, 0);
}

export fn check_vgetq_lane_u8(arg0: neon.u8x16) u8 {
    return neon.vgetq_lane_u8(arg0, 0);
}

export fn check_vgetq_lane_u16(arg0: neon.u16x8) u16 {
    return neon.vgetq_lane_u16(arg0, 0);
}

export fn check_vgetq_lane_u32(arg0: *const neon.u32x4) u32 {
    return neon.vgetq_lane_u32(arg0.*, 0);
}

export fn check_vgetq_lane_u64(arg0: *const neon.u64x2) u64 {
    return neon.vgetq_lane_u64(arg0.*, 0);
}

export fn check_vgetq_lane_f16(arg0: neon.f16x8) f16 {
    return neon.vgetq_lane_f16(arg0, 0);
}

export fn check_vgetq_lane_f32(arg0: *const neon.f32x4) f32 {
    return neon.vgetq_lane_f32(arg0.*, 0);
}

export fn check_vgetq_lane_f64(arg0: *const neon.f64x2) f64 {
    return neon.vgetq_lane_f64(arg0.*, 0);
}

export fn check_vgetq_lane_p8(arg0: neon.p8x16) neon.p8 {
    return neon.vgetq_lane_p8(arg0, 0);
}

export fn check_vgetq_lane_p16(arg0: neon.p16x8) neon.p16 {
    return neon.vgetq_lane_p16(arg0, 0);
}

export fn check_vgetq_lane_p64(arg0: *const neon.p64x2) neon.p64 {
    return neon.vgetq_lane_p64(arg0.*, 0);
}

export fn check_vset_lane_s8(arg0: i8, arg1: neon.i8x8) neon.i8x8 {
    return neon.vset_lane_s8(arg0, arg1, 0);
}

export fn check_vset_lane_s16(arg0: i16, arg1: *const neon.i16x4, out_ptr: *neon.i16x4) void {
    out_ptr.* = neon.vset_lane_s16(arg0, arg1.*, 0);
}

export fn check_vset_lane_s32(arg0: i32, arg1: *const neon.i32x2, out_ptr: *neon.i32x2) void {
    out_ptr.* = neon.vset_lane_s32(arg0, arg1.*, 0);
}

export fn check_vset_lane_u8(arg0: u8, arg1: neon.u8x8) neon.u8x8 {
    return neon.vset_lane_u8(arg0, arg1, 0);
}

export fn check_vset_lane_u16(arg0: u16, arg1: *const neon.u16x4, out_ptr: *neon.u16x4) void {
    out_ptr.* = neon.vset_lane_u16(arg0, arg1.*, 0);
}

export fn check_vset_lane_u32(arg0: u32, arg1: *const neon.u32x2, out_ptr: *neon.u32x2) void {
    out_ptr.* = neon.vset_lane_u32(arg0, arg1.*, 0);
}

export fn check_vset_lane_f32(arg0: f32, arg1: *const neon.f32x2, out_ptr: *neon.f32x2) void {
    out_ptr.* = neon.vset_lane_f32(arg0, arg1.*, 0);
}

export fn check_vsetq_lane_s8(arg0: i8, arg1: neon.i8x16) neon.i8x16 {
    return neon.vsetq_lane_s8(arg0, arg1, 0);
}

export fn check_vsetq_lane_s16(arg0: i16, arg1: neon.i16x8) neon.i16x8 {
    return neon.vsetq_lane_s16(arg0, arg1, 0);
}

export fn check_vsetq_lane_s32(arg0: i32, arg1: *const neon.i32x4, out_ptr: *neon.i32x4) void {
    out_ptr.* = neon.vsetq_lane_s32(arg0, arg1.*, 0);
}

export fn check_vsetq_lane_u8(arg0: u8, arg1: neon.u8x16) neon.u8x16 {
    return neon.vsetq_lane_u8(arg0, arg1, 0);
}

export fn check_vsetq_lane_u16(arg0: u16, arg1: neon.u16x8) neon.u16x8 {
    return neon.vsetq_lane_u16(arg0, arg1, 0);
}

export fn check_vsetq_lane_u32(arg0: u32, arg1: *const neon.u32x4, out_ptr: *neon.u32x4) void {
    out_ptr.* = neon.vsetq_lane_u32(arg0, arg1.*, 0);
}

export fn check_vsetq_lane_f32(arg0: f32, arg1: *const neon.f32x4, out_ptr: *neon.f32x4) void {
    out_ptr.* = neon.vsetq_lane_f32(arg0, arg1.*, 0);
}

export fn check_vdup_n_s8(arg0: i8) neon.i8x8 {
    return neon.vdup_n_s8(arg0);
}

export fn check_vdup_n_s16(arg0: i16, out_ptr: *neon.i16x4) void {
    out_ptr.* = neon.vdup_n_s16(arg0);
}

export fn check_vdup_n_s32(arg0: i32, out_ptr: *neon.i32x2) void {
    out_ptr.* = neon.vdup_n_s32(arg0);
}

export fn check_vdup_n_s64(arg0: i64) neon.i64x1 {
    return neon.vdup_n_s64(arg0);
}

export fn check_vdup_n_u8(arg0: u8) neon.u8x8 {
    return neon.vdup_n_u8(arg0);
}

export fn check_vdup_n_u16(arg0: u16, out_ptr: *neon.u16x4) void {
    out_ptr.* = neon.vdup_n_u16(arg0);
}

export fn check_vdup_n_u32(arg0: u32, out_ptr: *neon.u32x2) void {
    out_ptr.* = neon.vdup_n_u32(arg0);
}

export fn check_vdup_n_u64(arg0: u64) neon.u64x1 {
    return neon.vdup_n_u64(arg0);
}

export fn check_vdup_n_f16(arg0: f16, out_ptr: *neon.f16x4) void {
    out_ptr.* = neon.vdup_n_f16(arg0);
}

export fn check_vdup_n_f32(arg0: f32, out_ptr: *neon.f32x2) void {
    out_ptr.* = neon.vdup_n_f32(arg0);
}

export fn check_vdup_n_f64(arg0: f64) neon.f64x1 {
    return neon.vdup_n_f64(arg0);
}

export fn check_vdup_n_p8(arg0: neon.p8) neon.p8x8 {
    return neon.vdup_n_p8(arg0);
}

export fn check_vdup_n_p16(arg0: neon.p16, out_ptr: *neon.p16x4) void {
    out_ptr.* = neon.vdup_n_p16(arg0);
}

export fn check_vdup_n_p64(arg0: neon.p64) neon.p64x1 {
    return neon.vdup_n_p64(arg0);
}

export fn check_vdupq_n_s8(arg0: i8) neon.i8x16 {
    return neon.vdupq_n_s8(arg0);
}

export fn check_vdupq_n_s16(arg0: i16) neon.i16x8 {
    return neon.vdupq_n_s16(arg0);
}

export fn check_vdupq_n_s32(arg0: i32, out_ptr: *neon.i32x4) void {
    out_ptr.* = neon.vdupq_n_s32(arg0);
}

export fn check_vdupq_n_s64(arg0: i64, out_ptr: *neon.i64x2) void {
    out_ptr.* = neon.vdupq_n_s64(arg0);
}

export fn check_vdupq_n_u8(arg0: u8) neon.u8x16 {
    return neon.vdupq_n_u8(arg0);
}

export fn check_vdupq_n_u16(arg0: u16) neon.u16x8 {
    return neon.vdupq_n_u16(arg0);
}

export fn check_vdupq_n_u32(arg0: u32, out_ptr: *neon.u32x4) void {
    out_ptr.* = neon.vdupq_n_u32(arg0);
}

export fn check_vdupq_n_u64(arg0: u64, out_ptr: *neon.u64x2) void {
    out_ptr.* = neon.vdupq_n_u64(arg0);
}

export fn check_vdupq_n_f16(arg0: f16) neon.f16x8 {
    return neon.vdupq_n_f16(arg0);
}

export fn check_vdupq_n_f32(arg0: f32, out_ptr: *neon.f32x4) void {
    out_ptr.* = neon.vdupq_n_f32(arg0);
}

export fn check_vdupq_n_f64(arg0: f64, out_ptr: *neon.f64x2) void {
    out_ptr.* = neon.vdupq_n_f64(arg0);
}

export fn check_vdupq_n_p8(arg0: neon.p8) neon.p8x16 {
    return neon.vdupq_n_p8(arg0);
}

export fn check_vdupq_n_p16(arg0: neon.p16) neon.p16x8 {
    return neon.vdupq_n_p16(arg0);
}

export fn check_vdupq_n_p64(arg0: neon.p64, out_ptr: *neon.p64x2) void {
    out_ptr.* = neon.vdupq_n_p64(arg0);
}

export fn check_vmov_n_s8(arg0: i8) neon.i8x8 {
    return neon.vmov_n_s8(arg0);
}

export fn check_vmov_n_s16(arg0: i16, out_ptr: *neon.i16x4) void {
    out_ptr.* = neon.vmov_n_s16(arg0);
}

export fn check_vmov_n_s32(arg0: i32, out_ptr: *neon.i32x2) void {
    out_ptr.* = neon.vmov_n_s32(arg0);
}

export fn check_vmov_n_u8(arg0: u8) neon.u8x8 {
    return neon.vmov_n_u8(arg0);
}

export fn check_vmov_n_u16(arg0: u16, out_ptr: *neon.u16x4) void {
    out_ptr.* = neon.vmov_n_u16(arg0);
}

export fn check_vmov_n_u32(arg0: u32, out_ptr: *neon.u32x2) void {
    out_ptr.* = neon.vmov_n_u32(arg0);
}

export fn check_vmov_n_f32(arg0: f32, out_ptr: *neon.f32x2) void {
    out_ptr.* = neon.vmov_n_f32(arg0);
}

export fn check_vmovq_n_s8(arg0: i8) neon.i8x16 {
    return neon.vmovq_n_s8(arg0);
}

export fn check_vmovq_n_s16(arg0: i16) neon.i16x8 {
    return neon.vmovq_n_s16(arg0);
}

export fn check_vmovq_n_s32(arg0: i32, out_ptr: *neon.i32x4) void {
    out_ptr.* = neon.vmovq_n_s32(arg0);
}

export fn check_vmovq_n_s64(arg0: i64, out_ptr: *neon.i64x2) void {
    out_ptr.* = neon.vmovq_n_s64(arg0);
}

export fn check_vmovq_n_u8(arg0: u8) neon.u8x16 {
    return neon.vmovq_n_u8(arg0);
}

export fn check_vmovq_n_u16(arg0: u16) neon.u16x8 {
    return neon.vmovq_n_u16(arg0);
}

export fn check_vmovq_n_u32(arg0: u32, out_ptr: *neon.u32x4) void {
    out_ptr.* = neon.vmovq_n_u32(arg0);
}

export fn check_vmovq_n_u64(arg0: u64, out_ptr: *neon.u64x2) void {
    out_ptr.* = neon.vmovq_n_u64(arg0);
}

export fn check_vmovq_n_f32(arg0: f32, out_ptr: *neon.f32x4) void {
    out_ptr.* = neon.vmovq_n_f32(arg0);
}

export fn check_vmovq_n_f64(arg0: f64, out_ptr: *neon.f64x2) void {
    out_ptr.* = neon.vmovq_n_f64(arg0);
}

export fn check_vmovq_n_p8(arg0: neon.p8) neon.p8x16 {
    return neon.vmovq_n_p8(arg0);
}

export fn check_vmovq_n_p16(arg0: neon.p16) neon.p16x8 {
    return neon.vmovq_n_p16(arg0);
}

export fn check_vmovq_n_p64(arg0: neon.p64, out_ptr: *neon.p64x2) void {
    out_ptr.* = neon.vmovq_n_p64(arg0);
}

export fn check_vzip1_u8(arg0: neon.u8x8, arg1: neon.u8x8) neon.u8x8 {
    return neon.vzip1_u8(arg0, arg1);
}

export fn check_vzip2_u8(arg0: neon.u8x8, arg1: neon.u8x8) neon.u8x8 {
    return neon.vzip2_u8(arg0, arg1);
}

export fn check_vzip1_s8(arg0: neon.i8x8, arg1: neon.i8x8) neon.i8x8 {
    return neon.vzip1_s8(arg0, arg1);
}

export fn check_vzip2_s8(arg0: neon.i8x8, arg1: neon.i8x8) neon.i8x8 {
    return neon.vzip2_s8(arg0, arg1);
}

export fn check_vzip1_u16(arg0: *const neon.u16x4, arg1: *const neon.u16x4, out_ptr: *neon.u16x4) void {
    out_ptr.* = neon.vzip1_u16(arg0.*, arg1.*);
}

export fn check_vzip2_u16(arg0: *const neon.u16x4, arg1: *const neon.u16x4, out_ptr: *neon.u16x4) void {
    out_ptr.* = neon.vzip2_u16(arg0.*, arg1.*);
}

export fn check_vzip1_s16(arg0: *const neon.i16x4, arg1: *const neon.i16x4, out_ptr: *neon.i16x4) void {
    out_ptr.* = neon.vzip1_s16(arg0.*, arg1.*);
}

export fn check_vzip2_s16(arg0: *const neon.i16x4, arg1: *const neon.i16x4, out_ptr: *neon.i16x4) void {
    out_ptr.* = neon.vzip2_s16(arg0.*, arg1.*);
}

export fn check_vzip1_u32(arg0: *const neon.u32x2, arg1: *const neon.u32x2, out_ptr: *neon.u32x2) void {
    out_ptr.* = neon.vzip1_u32(arg0.*, arg1.*);
}

export fn check_vzip2_u32(arg0: *const neon.u32x2, arg1: *const neon.u32x2, out_ptr: *neon.u32x2) void {
    out_ptr.* = neon.vzip2_u32(arg0.*, arg1.*);
}

export fn check_vzip1_s32(arg0: *const neon.i32x2, arg1: *const neon.i32x2, out_ptr: *neon.i32x2) void {
    out_ptr.* = neon.vzip1_s32(arg0.*, arg1.*);
}

export fn check_vzip2_s32(arg0: *const neon.i32x2, arg1: *const neon.i32x2, out_ptr: *neon.i32x2) void {
    out_ptr.* = neon.vzip2_s32(arg0.*, arg1.*);
}

export fn check_vzip1_f32(arg0: *const neon.f32x2, arg1: *const neon.f32x2, out_ptr: *neon.f32x2) void {
    out_ptr.* = neon.vzip1_f32(arg0.*, arg1.*);
}

export fn check_vzip2_f32(arg0: *const neon.f32x2, arg1: *const neon.f32x2, out_ptr: *neon.f32x2) void {
    out_ptr.* = neon.vzip2_f32(arg0.*, arg1.*);
}

export fn check_vzip1q_u8(arg0: neon.u8x16, arg1: neon.u8x16) neon.u8x16 {
    return neon.vzip1q_u8(arg0, arg1);
}

export fn check_vzip2q_u8(arg0: neon.u8x16, arg1: neon.u8x16) neon.u8x16 {
    return neon.vzip2q_u8(arg0, arg1);
}

export fn check_vzip1q_s8(arg0: neon.i8x16, arg1: neon.i8x16) neon.i8x16 {
    return neon.vzip1q_s8(arg0, arg1);
}

export fn check_vzip2q_s8(arg0: neon.i8x16, arg1: neon.i8x16) neon.i8x16 {
    return neon.vzip2q_s8(arg0, arg1);
}

export fn check_vzip1q_u16(arg0: neon.u16x8, arg1: neon.u16x8) neon.u16x8 {
    return neon.vzip1q_u16(arg0, arg1);
}

export fn check_vzip2q_u16(arg0: neon.u16x8, arg1: neon.u16x8) neon.u16x8 {
    return neon.vzip2q_u16(arg0, arg1);
}

export fn check_vzip1q_s16(arg0: neon.i16x8, arg1: neon.i16x8) neon.i16x8 {
    return neon.vzip1q_s16(arg0, arg1);
}

export fn check_vzip2q_s16(arg0: neon.i16x8, arg1: neon.i16x8) neon.i16x8 {
    return neon.vzip2q_s16(arg0, arg1);
}

export fn check_vzip1q_u32(arg0: *const neon.u32x4, arg1: *const neon.u32x4, out_ptr: *neon.u32x4) void {
    out_ptr.* = neon.vzip1q_u32(arg0.*, arg1.*);
}

export fn check_vzip2q_u32(arg0: *const neon.u32x4, arg1: *const neon.u32x4, out_ptr: *neon.u32x4) void {
    out_ptr.* = neon.vzip2q_u32(arg0.*, arg1.*);
}

export fn check_vzip1q_s32(arg0: *const neon.i32x4, arg1: *const neon.i32x4, out_ptr: *neon.i32x4) void {
    out_ptr.* = neon.vzip1q_s32(arg0.*, arg1.*);
}

export fn check_vzip2q_s32(arg0: *const neon.i32x4, arg1: *const neon.i32x4, out_ptr: *neon.i32x4) void {
    out_ptr.* = neon.vzip2q_s32(arg0.*, arg1.*);
}

export fn check_vzip1q_f32(arg0: *const neon.f32x4, arg1: *const neon.f32x4, out_ptr: *neon.f32x4) void {
    out_ptr.* = neon.vzip1q_f32(arg0.*, arg1.*);
}

export fn check_vzip2q_f32(arg0: *const neon.f32x4, arg1: *const neon.f32x4, out_ptr: *neon.f32x4) void {
    out_ptr.* = neon.vzip2q_f32(arg0.*, arg1.*);
}

export fn check_vzip1q_u64(arg0: *const neon.u64x2, arg1: *const neon.u64x2, out_ptr: *neon.u64x2) void {
    out_ptr.* = neon.vzip1q_u64(arg0.*, arg1.*);
}

export fn check_vzip2q_u64(arg0: *const neon.u64x2, arg1: *const neon.u64x2, out_ptr: *neon.u64x2) void {
    out_ptr.* = neon.vzip2q_u64(arg0.*, arg1.*);
}

export fn check_vzip1q_s64(arg0: *const neon.i64x2, arg1: *const neon.i64x2, out_ptr: *neon.i64x2) void {
    out_ptr.* = neon.vzip1q_s64(arg0.*, arg1.*);
}

export fn check_vzip2q_s64(arg0: *const neon.i64x2, arg1: *const neon.i64x2, out_ptr: *neon.i64x2) void {
    out_ptr.* = neon.vzip2q_s64(arg0.*, arg1.*);
}

export fn check_vzip1q_f64(arg0: *const neon.f64x2, arg1: *const neon.f64x2, out_ptr: *neon.f64x2) void {
    out_ptr.* = neon.vzip1q_f64(arg0.*, arg1.*);
}

export fn check_vzip2q_f64(arg0: *const neon.f64x2, arg1: *const neon.f64x2, out_ptr: *neon.f64x2) void {
    out_ptr.* = neon.vzip2q_f64(arg0.*, arg1.*);
}

export fn check_vzipq_u8(arg0: neon.u8x16, arg1: neon.u8x16, out_ptr: *neon.types.u8x16x2) void {
    out_ptr.* = neon.vzipq_u8(arg0, arg1);
}

export fn check_vzipq_s8(arg0: neon.i8x16, arg1: neon.i8x16, out_ptr: *neon.types.i8x16x2) void {
    out_ptr.* = neon.vzipq_s8(arg0, arg1);
}

export fn check_vzipq_u16(arg0: neon.u16x8, arg1: neon.u16x8, out_ptr: *neon.types.u16x8x2) void {
    out_ptr.* = neon.vzipq_u16(arg0, arg1);
}

export fn check_vzipq_s16(arg0: neon.i16x8, arg1: neon.i16x8, out_ptr: *neon.types.i16x8x2) void {
    out_ptr.* = neon.vzipq_s16(arg0, arg1);
}

export fn check_vzipq_u32(arg0: *const neon.u32x4, arg1: *const neon.u32x4, out_ptr: *neon.types.u32x4x2) void {
    out_ptr.* = neon.vzipq_u32(arg0.*, arg1.*);
}

export fn check_vzipq_s32(arg0: *const neon.i32x4, arg1: *const neon.i32x4, out_ptr: *neon.types.i32x4x2) void {
    out_ptr.* = neon.vzipq_s32(arg0.*, arg1.*);
}

export fn check_vzipq_u64(arg0: *const neon.u64x2, arg1: *const neon.u64x2, out_ptr: *neon.types.u64x2x2) void {
    out_ptr.* = neon.vzipq_u64(arg0.*, arg1.*);
}

export fn check_vzipq_s64(arg0: *const neon.i64x2, arg1: *const neon.i64x2, out_ptr: *neon.types.i64x2x2) void {
    out_ptr.* = neon.vzipq_s64(arg0.*, arg1.*);
}

export fn check_vtrn1q_s8(arg0: neon.i8x16, arg1: neon.i8x16) neon.i8x16 {
    return neon.vtrn1q_s8(arg0, arg1);
}

export fn check_vtrn2q_s8(arg0: neon.i8x16, arg1: neon.i8x16) neon.i8x16 {
    return neon.vtrn2q_s8(arg0, arg1);
}

export fn check_vtrn1q_u8(arg0: neon.u8x16, arg1: neon.u8x16) neon.u8x16 {
    return neon.vtrn1q_u8(arg0, arg1);
}

export fn check_vtrn2q_u8(arg0: neon.u8x16, arg1: neon.u8x16) neon.u8x16 {
    return neon.vtrn2q_u8(arg0, arg1);
}

export fn check_vtrn1q_f32(arg0: *const neon.f32x4, arg1: *const neon.f32x4, out_ptr: *neon.f32x4) void {
    out_ptr.* = neon.vtrn1q_f32(arg0.*, arg1.*);
}

export fn check_vtrn2q_f32(arg0: *const neon.f32x4, arg1: *const neon.f32x4, out_ptr: *neon.f32x4) void {
    out_ptr.* = neon.vtrn2q_f32(arg0.*, arg1.*);
}

export fn check_vtrnq_f32(arg0: *const neon.f32x4, arg1: *const neon.f32x4, out_ptr: *neon.types.f32x4x2) void {
    out_ptr.* = neon.vtrnq_f32(arg0.*, arg1.*);
}

export fn check_vtrnq_s8(arg0: neon.i8x16, arg1: neon.i8x16, out_ptr: *neon.types.i8x16x2) void {
    out_ptr.* = neon.vtrnq_s8(arg0, arg1);
}

export fn check_vtrnq_u8(arg0: neon.u8x16, arg1: neon.u8x16, out_ptr: *neon.types.u8x16x2) void {
    out_ptr.* = neon.vtrnq_u8(arg0, arg1);
}

export fn check_vrev64q_s8(arg0: neon.i8x16) neon.i8x16 {
    return neon.vrev64q_s8(arg0);
}

export fn check_vrev64q_u8(arg0: neon.u8x16) neon.u8x16 {
    return neon.vrev64q_u8(arg0);
}

export fn check_vrev64q_s16(arg0: neon.i16x8) neon.i16x8 {
    return neon.vrev64q_s16(arg0);
}

export fn check_vrev64q_u16(arg0: neon.u16x8) neon.u16x8 {
    return neon.vrev64q_u16(arg0);
}

export fn check_vrev64q_s32(arg0: *const neon.i32x4, out_ptr: *neon.i32x4) void {
    out_ptr.* = neon.vrev64q_s32(arg0.*);
}

export fn check_vrev64q_u32(arg0: *const neon.u32x4, out_ptr: *neon.u32x4) void {
    out_ptr.* = neon.vrev64q_u32(arg0.*);
}

export fn check_vrev64q_f32(arg0: *const neon.f32x4, out_ptr: *neon.f32x4) void {
    out_ptr.* = neon.vrev64q_f32(arg0.*);
}

export fn check_vqtbl1q_u8(arg0: neon.u8x16, arg1: neon.u8x16) neon.u8x16 {
    return neon.vqtbl1q_u8(arg0, arg1);
}

export fn check_vqtbl1q_s8(arg0: neon.i8x16, arg1: neon.i8x16) neon.i8x16 {
    return neon.vqtbl1q_s8(arg0, arg1);
}

export fn check_vqtbl1q_p8(arg0: neon.p8x16, arg1: neon.p8x16) neon.p8x16 {
    return neon.vqtbl1q_p8(arg0, arg1);
}

export fn check_vld1_s8(arg0: [*]const i8) neon.i8x8 {
    return neon.vld1_s8(arg0);
}

export fn check_vld1_s16(arg0: [*]const i16, out_ptr: *neon.i16x4) void {
    out_ptr.* = neon.vld1_s16(arg0);
}

export fn check_vld1_s32(arg0: [*]const i32, out_ptr: *neon.i32x2) void {
    out_ptr.* = neon.vld1_s32(arg0);
}

export fn check_vld1_s64(arg0: [*]const i64) neon.i64x1 {
    return neon.vld1_s64(arg0);
}

export fn check_vld1_u8(arg0: [*]const u8) neon.u8x8 {
    return neon.vld1_u8(arg0);
}

export fn check_vld1_u16(arg0: [*]const u16, out_ptr: *neon.u16x4) void {
    out_ptr.* = neon.vld1_u16(arg0);
}

export fn check_vld1_u32(arg0: [*]const u32, out_ptr: *neon.u32x2) void {
    out_ptr.* = neon.vld1_u32(arg0);
}

export fn check_vld1_u64(arg0: [*]const u64) neon.u64x1 {
    return neon.vld1_u64(arg0);
}

export fn check_vld1_f16(arg0: [*]const f16, out_ptr: *neon.f16x4) void {
    out_ptr.* = neon.vld1_f16(arg0);
}

export fn check_vld1_f32(arg0: [*]const f32, out_ptr: *neon.f32x2) void {
    out_ptr.* = neon.vld1_f32(arg0);
}

export fn check_vld1_f64(arg0: [*]const f64) neon.f64x1 {
    return neon.vld1_f64(arg0);
}

export fn check_vld1_p8(arg0: [*]const p8) neon.p8x8 {
    return neon.vld1_p8(arg0);
}

export fn check_vld1_p16(arg0: [*]const p16, out_ptr: *neon.p16x4) void {
    out_ptr.* = neon.vld1_p16(arg0);
}

export fn check_vld1_p64(arg0: [*]const p64) neon.p64x1 {
    return neon.vld1_p64(arg0);
}

export fn check_vld1q_s8(arg0: [*]const i8) neon.i8x16 {
    return neon.vld1q_s8(arg0);
}

export fn check_vld1q_s16(arg0: [*]const i16) neon.i16x8 {
    return neon.vld1q_s16(arg0);
}

export fn check_vld1q_s32(arg0: [*]const i32, out_ptr: *neon.i32x4) void {
    out_ptr.* = neon.vld1q_s32(arg0);
}

export fn check_vld1q_s64(arg0: [*]const i64, out_ptr: *neon.i64x2) void {
    out_ptr.* = neon.vld1q_s64(arg0);
}

export fn check_vld1q_u8(arg0: [*]const u8) neon.u8x16 {
    return neon.vld1q_u8(arg0);
}

export fn check_vld1q_u16(arg0: [*]const u16) neon.u16x8 {
    return neon.vld1q_u16(arg0);
}

export fn check_vld1q_u32(arg0: [*]const u32, out_ptr: *neon.u32x4) void {
    out_ptr.* = neon.vld1q_u32(arg0);
}

export fn check_vld1q_u64(arg0: [*]const u64, out_ptr: *neon.u64x2) void {
    out_ptr.* = neon.vld1q_u64(arg0);
}

export fn check_vld1q_f16(arg0: [*]const f16) neon.f16x8 {
    return neon.vld1q_f16(arg0);
}

export fn check_vld1q_f32(arg0: [*]const f32, out_ptr: *neon.f32x4) void {
    out_ptr.* = neon.vld1q_f32(arg0);
}

export fn check_vld1q_f64(arg0: [*]const f64, out_ptr: *neon.f64x2) void {
    out_ptr.* = neon.vld1q_f64(arg0);
}

export fn check_vld1q_p8(arg0: [*]const p8) neon.p8x16 {
    return neon.vld1q_p8(arg0);
}

export fn check_vld1q_p16(arg0: [*]const p16) neon.p16x8 {
    return neon.vld1q_p16(arg0);
}

export fn check_vld1q_p64(arg0: [*]const p64, out_ptr: *neon.p64x2) void {
    out_ptr.* = neon.vld1q_p64(arg0);
}

export fn check_vst1_s8(arg0: [*]i8, arg1: neon.i8x8) void {
    neon.vst1_s8(arg0, arg1);
}

export fn check_vst1_s16(arg0: [*]i16, arg1: *const neon.i16x4) void {
    neon.vst1_s16(arg0, arg1.*);
}

export fn check_vst1_s32(arg0: [*]i32, arg1: *const neon.i32x2) void {
    neon.vst1_s32(arg0, arg1.*);
}

export fn check_vst1_s64(arg0: [*]i64, arg1: neon.i64x1) void {
    neon.vst1_s64(arg0, arg1);
}

export fn check_vst1_u8(arg0: [*]u8, arg1: neon.u8x8) void {
    neon.vst1_u8(arg0, arg1);
}

export fn check_vst1_u16(arg0: [*]u16, arg1: *const neon.u16x4) void {
    neon.vst1_u16(arg0, arg1.*);
}

export fn check_vst1_u32(arg0: [*]u32, arg1: *const neon.u32x2) void {
    neon.vst1_u32(arg0, arg1.*);
}

export fn check_vst1_u64(arg0: [*]u64, arg1: neon.u64x1) void {
    neon.vst1_u64(arg0, arg1);
}

export fn check_vst1_f16(arg0: [*]f16, arg1: *const neon.f16x4) void {
    neon.vst1_f16(arg0, arg1.*);
}

export fn check_vst1_f32(arg0: [*]f32, arg1: *const neon.f32x2) void {
    neon.vst1_f32(arg0, arg1.*);
}

export fn check_vst1_f64(arg0: [*]f64, arg1: neon.f64x1) void {
    neon.vst1_f64(arg0, arg1);
}

export fn check_vst1_p8(arg0: [*]p8, arg1: neon.p8x8) void {
    neon.vst1_p8(arg0, arg1);
}

export fn check_vst1_p16(arg0: [*]p16, arg1: *const neon.p16x4) void {
    neon.vst1_p16(arg0, arg1.*);
}

export fn check_vst1_p64(arg0: [*]p64, arg1: neon.p64x1) void {
    neon.vst1_p64(arg0, arg1);
}

export fn check_vst1q_s8(arg0: [*]i8, arg1: neon.i8x16) void {
    neon.vst1q_s8(arg0, arg1);
}

export fn check_vst1q_s16(arg0: [*]i16, arg1: neon.i16x8) void {
    neon.vst1q_s16(arg0, arg1);
}

export fn check_vst1q_s32(arg0: [*]i32, arg1: *const neon.i32x4) void {
    neon.vst1q_s32(arg0, arg1.*);
}

export fn check_vst1q_s64(arg0: [*]i64, arg1: *const neon.i64x2) void {
    neon.vst1q_s64(arg0, arg1.*);
}

export fn check_vst1q_u8(arg0: [*]u8, arg1: neon.u8x16) void {
    neon.vst1q_u8(arg0, arg1);
}

export fn check_vst1q_u16(arg0: [*]u16, arg1: neon.u16x8) void {
    neon.vst1q_u16(arg0, arg1);
}

export fn check_vst1q_u32(arg0: [*]u32, arg1: *const neon.u32x4) void {
    neon.vst1q_u32(arg0, arg1.*);
}

export fn check_vst1q_u64(arg0: [*]u64, arg1: *const neon.u64x2) void {
    neon.vst1q_u64(arg0, arg1.*);
}

export fn check_vst1q_f16(arg0: [*]f16, arg1: neon.f16x8) void {
    neon.vst1q_f16(arg0, arg1);
}

export fn check_vst1q_f32(arg0: [*]f32, arg1: *const neon.f32x4) void {
    neon.vst1q_f32(arg0, arg1.*);
}

export fn check_vst1q_f64(arg0: [*]f64, arg1: *const neon.f64x2) void {
    neon.vst1q_f64(arg0, arg1.*);
}

export fn check_vst1q_p8(arg0: [*]p8, arg1: neon.p8x16) void {
    neon.vst1q_p8(arg0, arg1);
}

export fn check_vst1q_p16(arg0: [*]p16, arg1: neon.p16x8) void {
    neon.vst1q_p16(arg0, arg1);
}

export fn check_vst1q_p64(arg0: [*]p64, arg1: *const neon.p64x2) void {
    neon.vst1q_p64(arg0, arg1.*);
}

export fn check_vst1q_p46(arg0: [*]p64, arg1: *const neon.p64x2) void {
    neon.vst1q_p46(arg0, arg1.*);
}

export fn check_vld1_lane_u8(arg0: [*]const u8, arg1: neon.u8x8) neon.u8x8 {
    return neon.vld1_lane_u8(arg0, arg1, 0);
}

export fn check_vld1q_lane_u8(arg0: [*]const u8, arg1: neon.u8x16) neon.u8x16 {
    return neon.vld1q_lane_u8(arg0, arg1, 0);
}

export fn check_vld1_lane_s32(arg0: [*]const i32, arg1: *const neon.i32x2, out_ptr: *neon.i32x2) void {
    out_ptr.* = neon.vld1_lane_s32(arg0, arg1.*, 0);
}

export fn check_vld1q_lane_s32(arg0: [*]const i32, arg1: *const neon.i32x4, out_ptr: *neon.i32x4) void {
    out_ptr.* = neon.vld1q_lane_s32(arg0, arg1.*, 0);
}

export fn check_vld1_lane_f32(arg0: [*]const f32, arg1: *const neon.f32x2, out_ptr: *neon.f32x2) void {
    out_ptr.* = neon.vld1_lane_f32(arg0, arg1.*, 0);
}

export fn check_vld1q_lane_f32(arg0: [*]const f32, arg1: *const neon.f32x4, out_ptr: *neon.f32x4) void {
    out_ptr.* = neon.vld1q_lane_f32(arg0, arg1.*, 0);
}

export fn check_vst1_lane_u8(arg0: [*]u8, arg1: neon.u8x8) void {
    neon.vst1_lane_u8(arg0, arg1, 0);
}

export fn check_vst1q_lane_u8(arg0: [*]u8, arg1: neon.u8x16) void {
    neon.vst1q_lane_u8(arg0, arg1, 0);
}

export fn check_vst1_lane_s32(arg0: [*]i32, arg1: *const neon.i32x2) void {
    neon.vst1_lane_s32(arg0, arg1.*, 0);
}

export fn check_vst1q_lane_s32(arg0: [*]i32, arg1: *const neon.i32x4) void {
    neon.vst1q_lane_s32(arg0, arg1.*, 0);
}

export fn check_vst1_lane_f32(arg0: [*]f32, arg1: *const neon.f32x2) void {
    neon.vst1_lane_f32(arg0, arg1.*, 0);
}

export fn check_vst1q_lane_f32(arg0: [*]f32, arg1: *const neon.f32x4) void {
    neon.vst1q_lane_f32(arg0, arg1.*, 0);
}

export fn check_vld2_u8(arg0: [*]const u8, out_ptr: *neon.types.u8x8x2) void {
    out_ptr.* = neon.vld2_u8(arg0);
}

export fn check_vld2q_u8(arg0: [*]const u8, out_ptr: *neon.types.u8x16x2) void {
    out_ptr.* = neon.vld2q_u8(arg0);
}

export fn check_vld2q_f32(arg0: [*]const f32, out_ptr: *neon.types.f32x4x2) void {
    out_ptr.* = neon.vld2q_f32(arg0);
}

export fn check_vst2_u8(arg0: [*]u8, arg1: *const neon.types.u8x8x2) void {
    neon.vst2_u8(arg0, arg1.*);
}

export fn check_vst2q_u8(arg0: [*]u8, arg1: *const neon.types.u8x16x2) void {
    neon.vst2q_u8(arg0, arg1.*);
}

export fn check_vst2q_f32(arg0: [*]f32, arg1: *const neon.types.f32x4x2) void {
    neon.vst2q_f32(arg0, arg1.*);
}

export fn check_vld3q_u8(arg0: [*]const u8, out_ptr: *neon.types.u8x16x3) void {
    out_ptr.* = neon.vld3q_u8(arg0);
}

export fn check_vst3q_u8(arg0: [*]u8, arg1: *const neon.types.u8x16x3) void {
    neon.vst3q_u8(arg0, arg1.*);
}

export fn check_vld4q_u8(arg0: [*]const u8, out_ptr: *neon.types.u8x16x4) void {
    out_ptr.* = neon.vld4q_u8(arg0);
}

export fn check_vst4q_u8(arg0: [*]u8, arg1: *const neon.types.u8x16x4) void {
    neon.vst4q_u8(arg0, arg1.*);
}

export fn check_vaddv_s8(arg0: neon.i8x8) i8 {
    return neon.vaddv_s8(arg0);
}

export fn check_vaddv_s16(arg0: *const neon.i16x4) i16 {
    return neon.vaddv_s16(arg0.*);
}

export fn check_vaddv_s32(arg0: *const neon.i32x2) i32 {
    return neon.vaddv_s32(arg0.*);
}

export fn check_vaddv_u8(arg0: neon.u8x8) u8 {
    return neon.vaddv_u8(arg0);
}

export fn check_vaddv_u16(arg0: *const neon.u16x4) u16 {
    return neon.vaddv_u16(arg0.*);
}

export fn check_vaddv_u32(arg0: *const neon.u32x2) u32 {
    return neon.vaddv_u32(arg0.*);
}

export fn check_vaddv_f32(arg0: *const neon.f32x2) f32 {
    return neon.vaddv_f32(arg0.*);
}

export fn check_vaddvq_s8(arg0: neon.i8x16) i8 {
    return neon.vaddvq_s8(arg0);
}

export fn check_vaddvq_s16(arg0: neon.i16x8) i16 {
    return neon.vaddvq_s16(arg0);
}

export fn check_vaddvq_s32(arg0: *const neon.i32x4) i32 {
    return neon.vaddvq_s32(arg0.*);
}

export fn check_vaddvq_s64(arg0: *const neon.i64x2) i64 {
    return neon.vaddvq_s64(arg0.*);
}

export fn check_vaddvq_u8(arg0: neon.u8x16) u8 {
    return neon.vaddvq_u8(arg0);
}

export fn check_vaddvq_u16(arg0: neon.u16x8) u16 {
    return neon.vaddvq_u16(arg0);
}

export fn check_vaddvq_u32(arg0: *const neon.u32x4) u32 {
    return neon.vaddvq_u32(arg0.*);
}

export fn check_vaddvq_u64(arg0: *const neon.u64x2) u64 {
    return neon.vaddvq_u64(arg0.*);
}

export fn check_vaddvq_f32(arg0: *const neon.f32x4) f32 {
    return neon.vaddvq_f32(arg0.*);
}

export fn check_vaddvq_f64(arg0: *const neon.f64x2) f64 {
    return neon.vaddvq_f64(arg0.*);
}

export fn check_vaddlv_s8(arg0: neon.i8x8) i16 {
    return neon.vaddlv_s8(arg0);
}

export fn check_vaddlv_s16(arg0: *const neon.i16x4) i32 {
    return neon.vaddlv_s16(arg0.*);
}

export fn check_vaddlv_s32(arg0: *const neon.i32x2) i64 {
    return neon.vaddlv_s32(arg0.*);
}

export fn check_vaddlv_u8(arg0: neon.u8x8) u16 {
    return neon.vaddlv_u8(arg0);
}

export fn check_vaddlv_u16(arg0: *const neon.u16x4) u32 {
    return neon.vaddlv_u16(arg0.*);
}

export fn check_vaddlv_u32(arg0: *const neon.u32x2) u64 {
    return neon.vaddlv_u32(arg0.*);
}

export fn check_vaddlvq_s8(arg0: neon.i8x16) i16 {
    return neon.vaddlvq_s8(arg0);
}

export fn check_vaddlvq_s16(arg0: neon.i16x8) i32 {
    return neon.vaddlvq_s16(arg0);
}

export fn check_vaddlvq_s32(arg0: *const neon.i32x4) i64 {
    return neon.vaddlvq_s32(arg0.*);
}

export fn check_vaddlvq_u8(arg0: neon.u8x16) u16 {
    return neon.vaddlvq_u8(arg0);
}

export fn check_vaddlvq_u16(arg0: neon.u16x8) u32 {
    return neon.vaddlvq_u16(arg0);
}

export fn check_vaddlvq_u32(arg0: *const neon.u32x4) u64 {
    return neon.vaddlvq_u32(arg0.*);
}

export fn check_vminv_s8(arg0: neon.i8x8) i8 {
    return neon.vminv_s8(arg0);
}

export fn check_vminv_s16(arg0: *const neon.i16x4) i16 {
    return neon.vminv_s16(arg0.*);
}

export fn check_vminv_s32(arg0: *const neon.i32x2) i32 {
    return neon.vminv_s32(arg0.*);
}

export fn check_vminv_u8(arg0: neon.u8x8) u8 {
    return neon.vminv_u8(arg0);
}

export fn check_vminv_u16(arg0: *const neon.u16x4) u16 {
    return neon.vminv_u16(arg0.*);
}

export fn check_vminv_u32(arg0: *const neon.u32x2) u32 {
    return neon.vminv_u32(arg0.*);
}

export fn check_vminvq_s8(arg0: neon.i8x16) i8 {
    return neon.vminvq_s8(arg0);
}

export fn check_vminvq_s16(arg0: neon.i16x8) i16 {
    return neon.vminvq_s16(arg0);
}

export fn check_vminvq_s32(arg0: *const neon.i32x4) i32 {
    return neon.vminvq_s32(arg0.*);
}

export fn check_vminvq_u8(arg0: neon.u8x16) u8 {
    return neon.vminvq_u8(arg0);
}

export fn check_vminvq_u16(arg0: neon.u16x8) u16 {
    return neon.vminvq_u16(arg0);
}

export fn check_vminvq_u32(arg0: *const neon.u32x4) u32 {
    return neon.vminvq_u32(arg0.*);
}

export fn check_vminvq_f32(arg0: *const neon.f32x4) f32 {
    return neon.vminvq_f32(arg0.*);
}

export fn check_vminvq_f64(arg0: *const neon.f64x2) f64 {
    return neon.vminvq_f64(arg0.*);
}

export fn check_vmaxv_s8(arg0: neon.i8x8) i8 {
    return neon.vmaxv_s8(arg0);
}

export fn check_vmaxv_s16(arg0: *const neon.i16x4) i16 {
    return neon.vmaxv_s16(arg0.*);
}

export fn check_vmaxv_s32(arg0: *const neon.i32x2) i32 {
    return neon.vmaxv_s32(arg0.*);
}

export fn check_vmaxv_u8(arg0: neon.u8x8) u8 {
    return neon.vmaxv_u8(arg0);
}

export fn check_vmaxv_u16(arg0: *const neon.u16x4) u16 {
    return neon.vmaxv_u16(arg0.*);
}

export fn check_vmaxv_u32(arg0: *const neon.u32x2) u32 {
    return neon.vmaxv_u32(arg0.*);
}

export fn check_vmaxvq_s8(arg0: neon.i8x16) i8 {
    return neon.vmaxvq_s8(arg0);
}

export fn check_vmaxvq_s16(arg0: neon.i16x8) i16 {
    return neon.vmaxvq_s16(arg0);
}

export fn check_vmaxvq_s32(arg0: *const neon.i32x4) i32 {
    return neon.vmaxvq_s32(arg0.*);
}

export fn check_vmaxvq_u8(arg0: neon.u8x16) u8 {
    return neon.vmaxvq_u8(arg0);
}

export fn check_vmaxvq_u16(arg0: neon.u16x8) u16 {
    return neon.vmaxvq_u16(arg0);
}

export fn check_vmaxvq_u32(arg0: *const neon.u32x4) u32 {
    return neon.vmaxvq_u32(arg0.*);
}

export fn check_vmaxvq_f32(arg0: *const neon.f32x4) f32 {
    return neon.vmaxvq_f32(arg0.*);
}

export fn check_vmaxvq_f64(arg0: *const neon.f64x2) f64 {
    return neon.vmaxvq_f64(arg0.*);
}

export fn check_vmaxnmv_f32(arg0: *const neon.f32x2) f32 {
    return neon.vmaxnmv_f32(arg0.*);
}

export fn check_vmaxnmvq_f32(arg0: *const neon.f32x4) f32 {
    return neon.vmaxnmvq_f32(arg0.*);
}

export fn check_vminnmv_f32(arg0: *const neon.f32x2) f32 {
    return neon.vminnmv_f32(arg0.*);
}

export fn check_vminnmvq_f32(arg0: *const neon.f32x4) f32 {
    return neon.vminnmvq_f32(arg0.*);
}

