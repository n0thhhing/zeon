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

// --- Bitwise AND (VAND) ---
pub inline fn vand_s8(a: i8x8, b: i8x8) i8x8 { if (!@inComptime() and comptime arch.is_aarch64) { return asm ("and %[res].8b, %[a].8b, %[b].8b" : [res] "=w" (-> i8x8) : [a] "w" (a), [b] "w" (b)); }  return a & b; }
pub inline fn vand_s16(a: i16x4, b: i16x4) i16x4 { if (!@inComptime() and comptime arch.is_aarch64) { return asm ("and %[res].8b, %[a].8b, %[b].8b" : [res] "=w" (-> i16x4) : [a] "w" (a), [b] "w" (b)); }  return a & b; }
pub inline fn vand_s32(a: i32x2, b: i32x2) i32x2 { if (!@inComptime() and comptime arch.is_aarch64) { return asm ("and %[res].8b, %[a].8b, %[b].8b" : [res] "=w" (-> i32x2) : [a] "w" (a), [b] "w" (b)); }  return a & b; }
pub inline fn vand_s64(a: i64x1, b: i64x1) i64x1 { if (!@inComptime() and comptime arch.is_aarch64) { return asm ("and %[res].8b, %[a].8b, %[b].8b" : [res] "=w" (-> i64x1) : [a] "w" (a), [b] "w" (b)); }  return a & b; }
pub inline fn vand_u8(a: u8x8, b: u8x8) u8x8 { if (!@inComptime() and comptime arch.is_aarch64) { return asm ("and %[res].8b, %[a].8b, %[b].8b" : [res] "=w" (-> u8x8) : [a] "w" (a), [b] "w" (b)); }  return a & b; }
pub inline fn vand_u16(a: u16x4, b: u16x4) u16x4 { if (!@inComptime() and comptime arch.is_aarch64) { return asm ("and %[res].8b, %[a].8b, %[b].8b" : [res] "=w" (-> u16x4) : [a] "w" (a), [b] "w" (b)); }  return a & b; }
pub inline fn vand_u32(a: u32x2, b: u32x2) u32x2 { if (!@inComptime() and comptime arch.is_aarch64) { return asm ("and %[res].8b, %[a].8b, %[b].8b" : [res] "=w" (-> u32x2) : [a] "w" (a), [b] "w" (b)); }  return a & b; }
pub inline fn vand_u64(a: u64x1, b: u64x1) u64x1 { if (!@inComptime() and comptime arch.is_aarch64) { return asm ("and %[res].8b, %[a].8b, %[b].8b" : [res] "=w" (-> u64x1) : [a] "w" (a), [b] "w" (b)); }  return a & b; }
pub inline fn vand_p8(a: p8x8, b: p8x8) p8x8 { if (!@inComptime() and comptime arch.is_aarch64) { return asm ("and %[res].8b, %[a].8b, %[b].8b" : [res] "=w" (-> p8x8) : [a] "w" (a), [b] "w" (b)); }  return a & b; }
pub inline fn vand_p16(a: p16x4, b: p16x4) p16x4 { if (!@inComptime() and comptime arch.is_aarch64) { return asm ("and %[res].8b, %[a].8b, %[b].8b" : [res] "=w" (-> p16x4) : [a] "w" (a), [b] "w" (b)); }  return a & b; }
pub inline fn vand_p64(a: p64x1, b: p64x1) p64x1 { if (!@inComptime() and comptime arch.is_aarch64) { return asm ("and %[res].8b, %[a].8b, %[b].8b" : [res] "=w" (-> p64x1) : [a] "w" (a), [b] "w" (b)); }  return a & b; }

pub inline fn vandq_s8(a: i8x16, b: i8x16) i8x16 { if (!@inComptime() and comptime arch.is_aarch64) { return asm ("and %[res].16b, %[a].16b, %[b].16b" : [res] "=w" (-> i8x16) : [a] "w" (a), [b] "w" (b)); }  return a & b; }
pub inline fn vandq_s16(a: i16x8, b: i16x8) i16x8 { if (!@inComptime() and comptime arch.is_aarch64) { return asm ("and %[res].16b, %[a].16b, %[b].16b" : [res] "=w" (-> i16x8) : [a] "w" (a), [b] "w" (b)); }  return a & b; }
pub inline fn vandq_s32(a: i32x4, b: i32x4) i32x4 { if (!@inComptime() and comptime arch.is_aarch64) { return asm ("and %[res].16b, %[a].16b, %[b].16b" : [res] "=w" (-> i32x4) : [a] "w" (a), [b] "w" (b)); }  return a & b; }
pub inline fn vandq_s64(a: i64x2, b: i64x2) i64x2 { if (!@inComptime() and comptime arch.is_aarch64) { return asm ("and %[res].16b, %[a].16b, %[b].16b" : [res] "=w" (-> i64x2) : [a] "w" (a), [b] "w" (b)); }  return a & b; }
pub inline fn vandq_u8(a: u8x16, b: u8x16) u8x16 { if (!@inComptime() and comptime arch.is_aarch64) { return asm ("and %[res].16b, %[a].16b, %[b].16b" : [res] "=w" (-> u8x16) : [a] "w" (a), [b] "w" (b)); }  return a & b; }
pub inline fn vandq_u16(a: u16x8, b: u16x8) u16x8 { if (!@inComptime() and comptime arch.is_aarch64) { return asm ("and %[res].16b, %[a].16b, %[b].16b" : [res] "=w" (-> u16x8) : [a] "w" (a), [b] "w" (b)); }  return a & b; }
pub inline fn vandq_u32(a: u32x4, b: u32x4) u32x4 { if (!@inComptime() and comptime arch.is_aarch64) { return asm ("and %[res].16b, %[a].16b, %[b].16b" : [res] "=w" (-> u32x4) : [a] "w" (a), [b] "w" (b)); }  return a & b; }
pub inline fn vandq_u64(a: u64x2, b: u64x2) u64x2 { if (!@inComptime() and comptime arch.is_aarch64) { return asm ("and %[res].16b, %[a].16b, %[b].16b" : [res] "=w" (-> u64x2) : [a] "w" (a), [b] "w" (b)); }  return a & b; }
pub inline fn vandq_p8(a: p8x16, b: p8x16) p8x16 { if (!@inComptime() and comptime arch.is_aarch64) { return asm ("and %[res].16b, %[a].16b, %[b].16b" : [res] "=w" (-> p8x16) : [a] "w" (a), [b] "w" (b)); }  return a & b; }
pub inline fn vandq_p16(a: p16x8, b: p16x8) p16x8 { if (!@inComptime() and comptime arch.is_aarch64) { return asm ("and %[res].16b, %[a].16b, %[b].16b" : [res] "=w" (-> p16x8) : [a] "w" (a), [b] "w" (b)); }  return a & b; }
pub inline fn vandq_p64(a: p64x2, b: p64x2) p64x2 { if (!@inComptime() and comptime arch.is_aarch64) { return asm ("and %[res].16b, %[a].16b, %[b].16b" : [res] "=w" (-> p64x2) : [a] "w" (a), [b] "w" (b)); }  return a & b; }

// --- Bitwise OR (VORR) ---
pub inline fn vorr_s8(a: i8x8, b: i8x8) i8x8 { if (!@inComptime() and comptime arch.is_aarch64) { return asm ("orr %[res].8b, %[a].8b, %[b].8b" : [res] "=w" (-> i8x8) : [a] "w" (a), [b] "w" (b)); }  return a | b; }
pub inline fn vorr_s16(a: i16x4, b: i16x4) i16x4 { if (!@inComptime() and comptime arch.is_aarch64) { return asm ("orr %[res].8b, %[a].8b, %[b].8b" : [res] "=w" (-> i16x4) : [a] "w" (a), [b] "w" (b)); }  return a | b; }
pub inline fn vorr_s32(a: i32x2, b: i32x2) i32x2 { if (!@inComptime() and comptime arch.is_aarch64) { return asm ("orr %[res].8b, %[a].8b, %[b].8b" : [res] "=w" (-> i32x2) : [a] "w" (a), [b] "w" (b)); }  return a | b; }
pub inline fn vorr_s64(a: i64x1, b: i64x1) i64x1 { if (!@inComptime() and comptime arch.is_aarch64) { return asm ("orr %[res].8b, %[a].8b, %[b].8b" : [res] "=w" (-> i64x1) : [a] "w" (a), [b] "w" (b)); }  return a | b; }
pub inline fn vorr_u8(a: u8x8, b: u8x8) u8x8 { if (!@inComptime() and comptime arch.is_aarch64) { return asm ("orr %[res].8b, %[a].8b, %[b].8b" : [res] "=w" (-> u8x8) : [a] "w" (a), [b] "w" (b)); }  return a | b; }
pub inline fn vorr_u16(a: u16x4, b: u16x4) u16x4 { if (!@inComptime() and comptime arch.is_aarch64) { return asm ("orr %[res].8b, %[a].8b, %[b].8b" : [res] "=w" (-> u16x4) : [a] "w" (a), [b] "w" (b)); }  return a | b; }
pub inline fn vorr_u32(a: u32x2, b: u32x2) u32x2 { if (!@inComptime() and comptime arch.is_aarch64) { return asm ("orr %[res].8b, %[a].8b, %[b].8b" : [res] "=w" (-> u32x2) : [a] "w" (a), [b] "w" (b)); }  return a | b; }
pub inline fn vorr_u64(a: u64x1, b: u64x1) u64x1 { if (!@inComptime() and comptime arch.is_aarch64) { return asm ("orr %[res].8b, %[a].8b, %[b].8b" : [res] "=w" (-> u64x1) : [a] "w" (a), [b] "w" (b)); }  return a | b; }

pub inline fn vorrq_s8(a: i8x16, b: i8x16) i8x16 { if (!@inComptime() and comptime arch.is_aarch64) { return asm ("orr %[res].16b, %[a].16b, %[b].16b" : [res] "=w" (-> i8x16) : [a] "w" (a), [b] "w" (b)); }  return a | b; }
pub inline fn vorrq_s16(a: i16x8, b: i16x8) i16x8 { if (!@inComptime() and comptime arch.is_aarch64) { return asm ("orr %[res].16b, %[a].16b, %[b].16b" : [res] "=w" (-> i16x8) : [a] "w" (a), [b] "w" (b)); }  return a | b; }
pub inline fn vorrq_s32(a: i32x4, b: i32x4) i32x4 { if (!@inComptime() and comptime arch.is_aarch64) { return asm ("orr %[res].16b, %[a].16b, %[b].16b" : [res] "=w" (-> i32x4) : [a] "w" (a), [b] "w" (b)); }  return a | b; }
pub inline fn vorrq_s64(a: i64x2, b: i64x2) i64x2 { if (!@inComptime() and comptime arch.is_aarch64) { return asm ("orr %[res].16b, %[a].16b, %[b].16b" : [res] "=w" (-> i64x2) : [a] "w" (a), [b] "w" (b)); }  return a | b; }
pub inline fn vorrq_u8(a: u8x16, b: u8x16) u8x16 { if (!@inComptime() and comptime arch.is_aarch64) { return asm ("orr %[res].16b, %[a].16b, %[b].16b" : [res] "=w" (-> u8x16) : [a] "w" (a), [b] "w" (b)); }  return a | b; }
pub inline fn vorrq_u16(a: u16x8, b: u16x8) u16x8 { if (!@inComptime() and comptime arch.is_aarch64) { return asm ("orr %[res].16b, %[a].16b, %[b].16b" : [res] "=w" (-> u16x8) : [a] "w" (a), [b] "w" (b)); }  return a | b; }
pub inline fn vorrq_u32(a: u32x4, b: u32x4) u32x4 { if (!@inComptime() and comptime arch.is_aarch64) { return asm ("orr %[res].16b, %[a].16b, %[b].16b" : [res] "=w" (-> u32x4) : [a] "w" (a), [b] "w" (b)); }  return a | b; }
pub inline fn vorrq_u64(a: u64x2, b: u64x2) u64x2 { if (!@inComptime() and comptime arch.is_aarch64) { return asm ("orr %[res].16b, %[a].16b, %[b].16b" : [res] "=w" (-> u64x2) : [a] "w" (a), [b] "w" (b)); }  return a | b; }

// --- Bitwise XOR (VEOR) ---
pub inline fn veor_s8(a: i8x8, b: i8x8) i8x8 { if (!@inComptime() and comptime arch.is_aarch64) { return asm ("eor %[res].8b, %[a].8b, %[b].8b" : [res] "=w" (-> i8x8) : [a] "w" (a), [b] "w" (b)); }  return a ^ b; }
pub inline fn veor_s16(a: i16x4, b: i16x4) i16x4 { if (!@inComptime() and comptime arch.is_aarch64) { return asm ("eor %[res].8b, %[a].8b, %[b].8b" : [res] "=w" (-> i16x4) : [a] "w" (a), [b] "w" (b)); }  return a ^ b; }
pub inline fn veor_s32(a: i32x2, b: i32x2) i32x2 { if (!@inComptime() and comptime arch.is_aarch64) { return asm ("eor %[res].8b, %[a].8b, %[b].8b" : [res] "=w" (-> i32x2) : [a] "w" (a), [b] "w" (b)); }  return a ^ b; }
pub inline fn veor_s64(a: i64x1, b: i64x1) i64x1 { if (!@inComptime() and comptime arch.is_aarch64) { return asm ("eor %[res].8b, %[a].8b, %[b].8b" : [res] "=w" (-> i64x1) : [a] "w" (a), [b] "w" (b)); }  return a ^ b; }
pub inline fn veor_u8(a: u8x8, b: u8x8) u8x8 { if (!@inComptime() and comptime arch.is_aarch64) { return asm ("eor %[res].8b, %[a].8b, %[b].8b" : [res] "=w" (-> u8x8) : [a] "w" (a), [b] "w" (b)); }  return a ^ b; }
pub inline fn veor_u16(a: u16x4, b: u16x4) u16x4 { if (!@inComptime() and comptime arch.is_aarch64) { return asm ("eor %[res].8b, %[a].8b, %[b].8b" : [res] "=w" (-> u16x4) : [a] "w" (a), [b] "w" (b)); }  return a ^ b; }
pub inline fn veor_u32(a: u32x2, b: u32x2) u32x2 { if (!@inComptime() and comptime arch.is_aarch64) { return asm ("eor %[res].8b, %[a].8b, %[b].8b" : [res] "=w" (-> u32x2) : [a] "w" (a), [b] "w" (b)); }  return a ^ b; }
pub inline fn veor_u64(a: u64x1, b: u64x1) u64x1 { if (!@inComptime() and comptime arch.is_aarch64) { return asm ("eor %[res].8b, %[a].8b, %[b].8b" : [res] "=w" (-> u64x1) : [a] "w" (a), [b] "w" (b)); }  return a ^ b; }

pub inline fn veorq_s8(a: i8x16, b: i8x16) i8x16 { if (!@inComptime() and comptime arch.is_aarch64) { return asm ("eor %[res].16b, %[a].16b, %[b].16b" : [res] "=w" (-> i8x16) : [a] "w" (a), [b] "w" (b)); }  return a ^ b; }
pub inline fn veorq_s16(a: i16x8, b: i16x8) i16x8 { if (!@inComptime() and comptime arch.is_aarch64) { return asm ("eor %[res].16b, %[a].16b, %[b].16b" : [res] "=w" (-> i16x8) : [a] "w" (a), [b] "w" (b)); }  return a ^ b; }
pub inline fn veorq_s32(a: i32x4, b: i32x4) i32x4 { if (!@inComptime() and comptime arch.is_aarch64) { return asm ("eor %[res].16b, %[a].16b, %[b].16b" : [res] "=w" (-> i32x4) : [a] "w" (a), [b] "w" (b)); }  return a ^ b; }
pub inline fn veorq_s64(a: i64x2, b: i64x2) i64x2 { if (!@inComptime() and comptime arch.is_aarch64) { return asm ("eor %[res].16b, %[a].16b, %[b].16b" : [res] "=w" (-> i64x2) : [a] "w" (a), [b] "w" (b)); }  return a ^ b; }
pub inline fn veorq_u8(a: u8x16, b: u8x16) u8x16 { if (!@inComptime() and comptime arch.is_aarch64) { return asm ("eor %[res].16b, %[a].16b, %[b].16b" : [res] "=w" (-> u8x16) : [a] "w" (a), [b] "w" (b)); }  return a ^ b; }
pub inline fn veorq_u16(a: u16x8, b: u16x8) u16x8 { if (!@inComptime() and comptime arch.is_aarch64) { return asm ("eor %[res].16b, %[a].16b, %[b].16b" : [res] "=w" (-> u16x8) : [a] "w" (a), [b] "w" (b)); }  return a ^ b; }
pub inline fn veorq_u32(a: u32x4, b: u32x4) u32x4 { if (!@inComptime() and comptime arch.is_aarch64) { return asm ("eor %[res].16b, %[a].16b, %[b].16b" : [res] "=w" (-> u32x4) : [a] "w" (a), [b] "w" (b)); }  return a ^ b; }
pub inline fn veorq_u64(a: u64x2, b: u64x2) u64x2 { if (!@inComptime() and comptime arch.is_aarch64) { return asm ("eor %[res].16b, %[a].16b, %[b].16b" : [res] "=w" (-> u64x2) : [a] "w" (a), [b] "w" (b)); }  return a ^ b; }

// --- Bit Clear (VBIC: a & ~b) ---
pub inline fn vbic_s8(a: i8x8, b: i8x8) i8x8 { if (!@inComptime() and comptime arch.is_aarch64) { return asm ("bic %[res].8b, %[a].8b, %[b].8b" : [res] "=w" (-> i8x8) : [a] "w" (a), [b] "w" (b)); }  return a & ~b; }
pub inline fn vbic_s16(a: i16x4, b: i16x4) i16x4 { if (!@inComptime() and comptime arch.is_aarch64) { return asm ("bic %[res].8b, %[a].8b, %[b].8b" : [res] "=w" (-> i16x4) : [a] "w" (a), [b] "w" (b)); }  return a & ~b; }
pub inline fn vbic_s32(a: i32x2, b: i32x2) i32x2 { if (!@inComptime() and comptime arch.is_aarch64) { return asm ("bic %[res].8b, %[a].8b, %[b].8b" : [res] "=w" (-> i32x2) : [a] "w" (a), [b] "w" (b)); }  return a & ~b; }
pub inline fn vbic_s64(a: i64x1, b: i64x1) i64x1 { if (!@inComptime() and comptime arch.is_aarch64) { return asm ("bic %[res].8b, %[a].8b, %[b].8b" : [res] "=w" (-> i64x1) : [a] "w" (a), [b] "w" (b)); }  return a & ~b; }
pub inline fn vbic_u8(a: u8x8, b: u8x8) u8x8 { if (!@inComptime() and comptime arch.is_aarch64) { return asm ("bic %[res].8b, %[a].8b, %[b].8b" : [res] "=w" (-> u8x8) : [a] "w" (a), [b] "w" (b)); }  return a & ~b; }
pub inline fn vbic_u16(a: u16x4, b: u16x4) u16x4 { if (!@inComptime() and comptime arch.is_aarch64) { return asm ("bic %[res].8b, %[a].8b, %[b].8b" : [res] "=w" (-> u16x4) : [a] "w" (a), [b] "w" (b)); }  return a & ~b; }
pub inline fn vbic_u32(a: u32x2, b: u32x2) u32x2 { if (!@inComptime() and comptime arch.is_aarch64) { return asm ("bic %[res].8b, %[a].8b, %[b].8b" : [res] "=w" (-> u32x2) : [a] "w" (a), [b] "w" (b)); }  return a & ~b; }
pub inline fn vbic_u64(a: u64x1, b: u64x1) u64x1 { if (!@inComptime() and comptime arch.is_aarch64) { return asm ("bic %[res].8b, %[a].8b, %[b].8b" : [res] "=w" (-> u64x1) : [a] "w" (a), [b] "w" (b)); }  return a & ~b; }

pub inline fn vbicq_s8(a: i8x16, b: i8x16) i8x16 { if (!@inComptime() and comptime arch.is_aarch64) { return asm ("bic %[res].16b, %[a].16b, %[b].16b" : [res] "=w" (-> i8x16) : [a] "w" (a), [b] "w" (b)); }  return a & ~b; }
pub inline fn vbicq_s16(a: i16x8, b: i16x8) i16x8 { if (!@inComptime() and comptime arch.is_aarch64) { return asm ("bic %[res].16b, %[a].16b, %[b].16b" : [res] "=w" (-> i16x8) : [a] "w" (a), [b] "w" (b)); }  return a & ~b; }
pub inline fn vbicq_s32(a: i32x4, b: i32x4) i32x4 { if (!@inComptime() and comptime arch.is_aarch64) { return asm ("bic %[res].16b, %[a].16b, %[b].16b" : [res] "=w" (-> i32x4) : [a] "w" (a), [b] "w" (b)); }  return a & ~b; }
pub inline fn vbicq_s64(a: i64x2, b: i64x2) i64x2 { if (!@inComptime() and comptime arch.is_aarch64) { return asm ("bic %[res].16b, %[a].16b, %[b].16b" : [res] "=w" (-> i64x2) : [a] "w" (a), [b] "w" (b)); }  return a & ~b; }
pub inline fn vbicq_u8(a: u8x16, b: u8x16) u8x16 { if (!@inComptime() and comptime arch.is_aarch64) { return asm ("bic %[res].16b, %[a].16b, %[b].16b" : [res] "=w" (-> u8x16) : [a] "w" (a), [b] "w" (b)); }  return a & ~b; }
pub inline fn vbicq_u16(a: u16x8, b: u16x8) u16x8 { if (!@inComptime() and comptime arch.is_aarch64) { return asm ("bic %[res].16b, %[a].16b, %[b].16b" : [res] "=w" (-> u16x8) : [a] "w" (a), [b] "w" (b)); }  return a & ~b; }
pub inline fn vbicq_u32(a: u32x4, b: u32x4) u32x4 { if (!@inComptime() and comptime arch.is_aarch64) { return asm ("bic %[res].16b, %[a].16b, %[b].16b" : [res] "=w" (-> u32x4) : [a] "w" (a), [b] "w" (b)); }  return a & ~b; }
pub inline fn vbicq_u64(a: u64x2, b: u64x2) u64x2 { if (!@inComptime() and comptime arch.is_aarch64) { return asm ("bic %[res].16b, %[a].16b, %[b].16b" : [res] "=w" (-> u64x2) : [a] "w" (a), [b] "w" (b)); }  return a & ~b; }

// --- Bitwise NOT (VMVN) ---
pub inline fn vmvn_s8(a: i8x8) i8x8 { if (!@inComptime() and comptime arch.is_aarch64) { return asm ("mvn %[res].8b, %[a].8b" : [res] "=w" (-> i8x8) : [a] "w" (a)); }  return ~a; }
pub inline fn vmvn_s16(a: i16x4) i16x4 { if (!@inComptime() and comptime arch.is_aarch64) { return asm ("mvn %[res].8b, %[a].8b" : [res] "=w" (-> i16x4) : [a] "w" (a)); }  return ~a; }
pub inline fn vmvn_s32(a: i32x2) i32x2 { if (!@inComptime() and comptime arch.is_aarch64) { return asm ("mvn %[res].8b, %[a].8b" : [res] "=w" (-> i32x2) : [a] "w" (a)); }  return ~a; }
pub inline fn vmvn_u8(a: u8x8) u8x8 { if (!@inComptime() and comptime arch.is_aarch64) { return asm ("mvn %[res].8b, %[a].8b" : [res] "=w" (-> u8x8) : [a] "w" (a)); }  return ~a; }
pub inline fn vmvn_u16(a: u16x4) u16x4 { if (!@inComptime() and comptime arch.is_aarch64) { return asm ("mvn %[res].8b, %[a].8b" : [res] "=w" (-> u16x4) : [a] "w" (a)); }  return ~a; }
pub inline fn vmvn_u32(a: u32x2) u32x2 { if (!@inComptime() and comptime arch.is_aarch64) { return asm ("mvn %[res].8b, %[a].8b" : [res] "=w" (-> u32x2) : [a] "w" (a)); }  return ~a; }

pub inline fn vmvnq_s8(a: i8x16) i8x16 { if (!@inComptime() and comptime arch.is_aarch64) { return asm ("mvn %[res].16b, %[a].16b" : [res] "=w" (-> i8x16) : [a] "w" (a)); }  return ~a; }
pub inline fn vmvnq_s16(a: i16x8) i16x8 { if (!@inComptime() and comptime arch.is_aarch64) { return asm ("mvn %[res].16b, %[a].16b" : [res] "=w" (-> i16x8) : [a] "w" (a)); }  return ~a; }
pub inline fn vmvnq_s32(a: i32x4) i32x4 { if (!@inComptime() and comptime arch.is_aarch64) { return asm ("mvn %[res].16b, %[a].16b" : [res] "=w" (-> i32x4) : [a] "w" (a)); }  return ~a; }
pub inline fn vmvnq_u8(a: u8x16) u8x16 { if (!@inComptime() and comptime arch.is_aarch64) { return asm ("mvn %[res].16b, %[a].16b" : [res] "=w" (-> u8x16) : [a] "w" (a)); }  return ~a; }
pub inline fn vmvnq_u16(a: u16x8) u16x8 { if (!@inComptime() and comptime arch.is_aarch64) { return asm ("mvn %[res].16b, %[a].16b" : [res] "=w" (-> u16x8) : [a] "w" (a)); }  return ~a; }
pub inline fn vmvnq_u32(a: u32x4) u32x4 { if (!@inComptime() and comptime arch.is_aarch64) { return asm ("mvn %[res].16b, %[a].16b" : [res] "=w" (-> u32x4) : [a] "w" (a)); }  return ~a; }

// --- Bitwise Select (VBSL: (a & b) | (~a & c)) ---
pub inline fn vbsl_s8(a: u8x8, b: i8x8, c: i8x8) i8x8 {
    const a_i: i8x8 = @bitCast(a);
    return (a_i & b) | (~a_i & c);
}
pub inline fn vbsl_s16(a: u16x4, b: i16x4, c: i16x4) i16x4 {
    const a_i: i16x4 = @bitCast(a);
    return (a_i & b) | (~a_i & c);
}
pub inline fn vbsl_s32(a: u32x2, b: i32x2, c: i32x2) i32x2 {
    const a_i: i32x2 = @bitCast(a);
    return (a_i & b) | (~a_i & c);
}
pub inline fn vbsl_s64(a: u64x1, b: i64x1, c: i64x1) i64x1 {
    const a_i: i64x1 = @bitCast(a);
    return (a_i & b) | (~a_i & c);
}
pub inline fn vbsl_u8(a: u8x8, b: u8x8, c: u8x8) u8x8 { return (a & b) | (~a & c); }
pub inline fn vbsl_u16(a: u16x4, b: u16x4, c: u16x4) u16x4 { return (a & b) | (~a & c); }
pub inline fn vbsl_u32(a: u32x2, b: u32x2, c: u32x2) u32x2 { return (a & b) | (~a & c); }
pub inline fn vbsl_u64(a: u64x1, b: u64x1, c: u64x1) u64x1 { return (a & b) | (~a & c); }
pub inline fn vbsl_f32(a: u32x2, b: f32x2, c: f32x2) f32x2 {
    const b_u: u32x2 = @bitCast(b);
    const c_u: u32x2 = @bitCast(c);
    return @bitCast((a & b_u) | (~a & c_u));
}
pub inline fn vbsl_f64(a: u64x1, b: f64x1, c: f64x1) f64x1 {
    const b_u: u64x1 = @bitCast(b);
    const c_u: u64x1 = @bitCast(c);
    return @bitCast((a & b_u) | (~a & c_u));
}
pub inline fn vbsl_p8(a: u8x8, b: p8x8, c: p8x8) p8x8 { return (a & b) | (~a & c); }
pub inline fn vbsl_p16(a: u16x4, b: p16x4, c: p16x4) p16x4 { return (a & b) | (~a & c); }
pub inline fn vbsl_p64(a: u64x1, b: p64x1, c: p64x1) p64x1 { return (a & b) | (~a & c); }

pub inline fn vbslq_s8(a: u8x16, b: i8x16, c: i8x16) i8x16 {
    const a_i: i8x16 = @bitCast(a);
    return (a_i & b) | (~a_i & c);
}
pub inline fn vbslq_s16(a: u16x8, b: i16x8, c: i16x8) i16x8 {
    const a_i: i16x8 = @bitCast(a);
    return (a_i & b) | (~a_i & c);
}
pub inline fn vbslq_s32(a: u32x4, b: i32x4, c: i32x4) i32x4 {
    const a_i: i32x4 = @bitCast(a);
    return (a_i & b) | (~a_i & c);
}
pub inline fn vbslq_s64(a: u64x2, b: i64x2, c: i64x2) i64x2 {
    const a_i: i64x2 = @bitCast(a);
    return (a_i & b) | (~a_i & c);
}
pub inline fn vbslq_u8(a: u8x16, b: u8x16, c: u8x16) u8x16 { return (a & b) | (~a & c); }
pub inline fn vbslq_u16(a: u16x8, b: u16x8, c: u16x8) u16x8 { return (a & b) | (~a & c); }
pub inline fn vbslq_u32(a: u32x4, b: u32x4, c: u32x4) u32x4 { return (a & b) | (~a & c); }
pub inline fn vbslq_u64(a: u64x2, b: u64x2, c: u64x2) u64x2 { return (a & b) | (~a & c); }
pub inline fn vbslq_f32(a: u32x4, b: f32x4, c: f32x4) f32x4 {
    const b_u: u32x4 = @bitCast(b);
    const c_u: u32x4 = @bitCast(c);
    return @bitCast((a & b_u) | (~a & c_u));
}
pub inline fn vbslq_f64(a: u64x2, b: f64x2, c: f64x2) f64x2 {
    const b_u: u64x2 = @bitCast(b);
    const c_u: u64x2 = @bitCast(c);
    return @bitCast((a & b_u) | (~a & c_u));
}
pub inline fn vbslq_p8(a: u8x16, b: p8x16, c: p8x16) p8x16 { return (a & b) | (~a & c); }
pub inline fn vbslq_p16(a: u16x8, b: p16x8, c: p16x8) p16x8 { return (a & b) | (~a & c); }
pub inline fn vbslq_p64(a: u64x2, b: p64x2, c: p64x2) p64x2 { return (a & b) | (~a & c); }

// --- Bit Clear and Exclusive OR (VBCAX: a ^ (b & ~c)) ---
pub inline fn vbcaxq_s8(a: i8x16, b: i8x16, c: i8x16) i8x16 { return a ^ (b & ~c); }
pub inline fn vbcaxq_s16(a: i16x8, b: i16x8, c: i16x8) i16x8 { return a ^ (b & ~c); }
pub inline fn vbcaxq_s32(a: i32x4, b: i32x4, c: i32x4) i32x4 { return a ^ (b & ~c); }
pub inline fn vbcaxq_s64(a: i64x2, b: i64x2, c: i64x2) i64x2 { return a ^ (b & ~c); }
pub inline fn vbcaxq_u8(a: u8x16, b: u8x16, c: u8x16) u8x16 { return a ^ (b & ~c); }
pub inline fn vbcaxq_u16(a: u16x8, b: u16x8, c: u16x8) u16x8 { return a ^ (b & ~c); }
pub inline fn vbcaxq_u32(a: u32x4, b: u32x4, c: u32x4) u32x4 { return a ^ (b & ~c); }
pub inline fn vbcaxq_u64(a: u64x2, b: u64x2, c: u64x2) u64x2 { return a ^ (b & ~c); }

// --- Bit Count (VCNT: PopCount) ---
pub inline fn vcnt_u8(a: u8x8) u8x8 { if (!@inComptime() and comptime arch.is_aarch64) { return asm ("cnt %[res].8b, %[a].8b" : [res] "=w" (-> u8x8) : [a] "w" (a)); }  return @popCount(a); }
pub inline fn vcnt_s8(a: i8x8) i8x8 { if (!@inComptime() and comptime arch.is_aarch64) { return asm ("cnt %[res].8b, %[a].8b" : [res] "=w" (-> i8x8) : [a] "w" (a)); }  return @as(i8x8, @intCast(@popCount(@as(u8x8, @bitCast(a))))); }
pub inline fn vcnt_p8(a: p8x8) p8x8 { if (!@inComptime() and comptime arch.is_aarch64) { return asm ("cnt %[res].8b, %[a].8b" : [res] "=w" (-> p8x8) : [a] "w" (a)); }  return @popCount(a); }
pub inline fn vcntq_u8(a: u8x16) u8x16 { if (!@inComptime() and comptime arch.is_aarch64) { return asm ("cnt %[res].16b, %[a].16b" : [res] "=w" (-> u8x16) : [a] "w" (a)); }  return @popCount(a); }
pub inline fn vcntq_s8(a: i8x16) i8x16 { if (!@inComptime() and comptime arch.is_aarch64) { return asm ("cnt %[res].16b, %[a].16b" : [res] "=w" (-> i8x16) : [a] "w" (a)); }  return @as(i8x16, @intCast(@popCount(@as(u8x16, @bitCast(a))))); }
pub inline fn vcntq_p8(a: p8x16) p8x16 { if (!@inComptime() and comptime arch.is_aarch64) { return asm ("cnt %[res].16b, %[a].16b" : [res] "=w" (-> p8x16) : [a] "w" (a)); }  return @popCount(a); }

// --- Count Leading Zeros (VCLZ) ---
pub inline fn vclz_u8(a: u8x8) u8x8 { if (!@inComptime() and comptime arch.is_aarch64) { return asm ("clz %[res].8b, %[a].8b" : [res] "=w" (-> u8x8) : [a] "w" (a)); }  return @clz(a); }
pub inline fn vclz_u16(a: u16x4) u16x4 { if (!@inComptime() and comptime arch.is_aarch64) { return asm ("clz %[res].4h, %[a].4h" : [res] "=w" (-> u16x4) : [a] "w" (a)); }  return @clz(a); }
pub inline fn vclz_u32(a: u32x2) u32x2 { if (!@inComptime() and comptime arch.is_aarch64) { return asm ("clz %[res].2s, %[a].2s" : [res] "=w" (-> u32x2) : [a] "w" (a)); }  return @clz(a); }
pub inline fn vclz_s8(a: i8x8) i8x8 {
    if (!@inComptime() and comptime arch.is_aarch64) { return asm ("clz %[res].8b, %[a].8b" : [res] "=w" (-> i8x8) : [a] "w" (a)); }

    
    
    
    var res: i8x8 = undefined;
    inline for (0..8) |i| {
        const bits: u8 = @bitCast(a[i]);
        res[i] = @intCast(@clz(bits));
    }
    return res;
}
pub inline fn vclz_s16(a: i16x4) i16x4 {
    if (!@inComptime() and comptime arch.is_aarch64) { return asm ("clz %[res].4h, %[a].4h" : [res] "=w" (-> i16x4) : [a] "w" (a)); }

    
    
    
    var res: i16x4 = undefined;
    inline for (0..4) |i| {
        const bits: u16 = @bitCast(a[i]);
        res[i] = @intCast(@clz(bits));
    }
    return res;
}
pub inline fn vclz_s32(a: i32x2) i32x2 {
    if (!@inComptime() and comptime arch.is_aarch64) { return asm ("clz %[res].2s, %[a].2s" : [res] "=w" (-> i32x2) : [a] "w" (a)); }

    
    
    
    var res: i32x2 = undefined;
    inline for (0..2) |i| {
        const bits: u32 = @bitCast(a[i]);
        res[i] = @intCast(@clz(bits));
    }
    return res;
}

pub inline fn vclzq_u8(a: u8x16) u8x16 { if (!@inComptime() and comptime arch.is_aarch64) { return asm ("clz %[res].16b, %[a].16b" : [res] "=w" (-> u8x16) : [a] "w" (a)); }  return @clz(a); }
pub inline fn vclzq_u16(a: u16x8) u16x8 { if (!@inComptime() and comptime arch.is_aarch64) { return asm ("clz %[res].8h, %[a].8h" : [res] "=w" (-> u16x8) : [a] "w" (a)); }  return @clz(a); }
pub inline fn vclzq_u32(a: u32x4) u32x4 { if (!@inComptime() and comptime arch.is_aarch64) { return asm ("clz %[res].4s, %[a].4s" : [res] "=w" (-> u32x4) : [a] "w" (a)); }  return @clz(a); }
pub inline fn vclzq_s8(a: i8x16) i8x16 {
    if (!@inComptime() and comptime arch.is_aarch64) { return asm ("clz %[res].16b, %[a].16b" : [res] "=w" (-> i8x16) : [a] "w" (a)); }

    
    
    
    var res: i8x16 = undefined;
    inline for (0..16) |i| {
        const bits: u8 = @bitCast(a[i]);
        res[i] = @intCast(@clz(bits));
    }
    return res;
}
pub inline fn vclzq_s16(a: i16x8) i16x8 {
    if (!@inComptime() and comptime arch.is_aarch64) { return asm ("clz %[res].8h, %[a].8h" : [res] "=w" (-> i16x8) : [a] "w" (a)); }

    
    
    
    var res: i16x8 = undefined;
    inline for (0..8) |i| {
        const bits: u16 = @bitCast(a[i]);
        res[i] = @intCast(@clz(bits));
    }
    return res;
}
pub inline fn vclzq_s32(a: i32x4) i32x4 {
    if (!@inComptime() and comptime arch.is_aarch64) { return asm ("clz %[res].4s, %[a].4s" : [res] "=w" (-> i32x4) : [a] "w" (a)); }

    
    
    
    var res: i32x4 = undefined;
    inline for (0..4) |i| {
        const bits: u32 = @bitCast(a[i]);
        res[i] = @intCast(@clz(bits));
    }
    return res;
}

test "bitwise intrinsics" {
    const a: u8x8 = @splat(0b10101010);
    const b: u8x8 = @splat(0b11001100);
    try std.testing.expectEqual(@as(u8x8, @splat(0b10001000)), vand_u8(a, b));
    try std.testing.expectEqual(@as(u8x8, @splat(0b11101110)), vorr_u8(a, b));
    try std.testing.expectEqual(@as(u8x8, @splat(0b01100110)), veor_u8(a, b));
    try std.testing.expectEqual(@as(u8x8, @splat(0b00100010)), vbic_u8(a, b));
}
