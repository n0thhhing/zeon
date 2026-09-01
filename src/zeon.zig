const std = @import("std");

pub const types = @import("types.zig");
pub const common = @import("common.zig");
pub const arm = @import("arch/arm.zig");
pub const aarch64 = @import("arch/aarch64.zig");

pub const is_arm = common.is_arm;
pub const is_aarch64 = common.is_aarch64;
pub const is_portable = common.is_portable;

pub const load_store = @import("intrinsics/load_store.zig");
pub const arithmetic = @import("intrinsics/arithmetic.zig");
pub const bitwise = @import("intrinsics/bitwise.zig");
pub const shift = @import("intrinsics/shift.zig");
pub const compare = @import("intrinsics/compare.zig");
pub const reduction = @import("intrinsics/reduction.zig");
pub const convert = @import("intrinsics/convert.zig");
pub const permute = @import("intrinsics/permute.zig");
pub const crypto = @import("intrinsics/crypto.zig");

// --- Scalar Types ---
pub const p8 = types.p8;
pub const p16 = types.p16;
pub const p64 = types.p64;
pub const p128 = types.p128;
pub const poly8 = types.poly8;
pub const poly16 = types.poly16;
pub const poly64 = types.poly64;
pub const poly128 = types.poly128;
pub const poly8_t = types.poly8_t;
pub const poly16_t = types.poly16_t;
pub const poly64_t = types.poly64_t;
pub const poly128_t = types.poly128_t;

// --- Vector Types ---
pub const i8x8 = types.i8x8;
pub const i8x16 = types.i8x16;
pub const i16x4 = types.i16x4;
pub const i16x8 = types.i16x8;
pub const i32x2 = types.i32x2;
pub const i32x4 = types.i32x4;
pub const i64x1 = types.i64x1;
pub const i64x2 = types.i64x2;

pub const u8x8 = types.u8x8;
pub const u8x16 = types.u8x16;
pub const u16x4 = types.u16x4;
pub const u16x8 = types.u16x8;
pub const u32x2 = types.u32x2;
pub const u32x4 = types.u32x4;
pub const u64x1 = types.u64x1;
pub const u64x2 = types.u64x2;

pub const f16x4 = types.f16x4;
pub const f16x8 = types.f16x8;
pub const f32x2 = types.f32x2;
pub const f32x4 = types.f32x4;
pub const f64x1 = types.f64x1;
pub const f64x2 = types.f64x2;

pub const p8x8 = types.p8x8;
pub const p8x16 = types.p8x16;
pub const p16x4 = types.p16x4;
pub const p16x8 = types.p16x8;
pub const p64x1 = types.p64x1;
pub const p64x2 = types.p64x2;

// --- Multi-Vector Types ---
pub const i8x8x2 = types.i8x8x2;
pub const i8x16x2 = types.i8x16x2;
pub const i16x4x2 = types.i16x4x2;
pub const i16x8x2 = types.i16x8x2;
pub const i32x2x2 = types.i32x2x2;
pub const i32x4x2 = types.i32x4x2;
pub const i64x1x2 = types.i64x1x2;
pub const i64x2x2 = types.i64x2x2;

pub const u8x8x2 = types.u8x8x2;
pub const u8x16x2 = types.u8x16x2;
pub const u16x4x2 = types.u16x4x2;
pub const u16x8x2 = types.u16x8x2;
pub const u32x2x2 = types.u32x2x2;
pub const u32x4x2 = types.u32x4x2;
pub const u64x1x2 = types.u64x1x2;
pub const u64x2x2 = types.u64x2x2;

pub const f16x4x2 = types.f16x4x2;
pub const f16x8x2 = types.f16x8x2;
pub const f32x2x2 = types.f32x2x2;
pub const f32x4x2 = types.f32x4x2;
pub const f64x1x2 = types.f64x1x2;
pub const f64x2x2 = types.f64x2x2;

pub const p8x8x2 = types.p8x8x2;
pub const p8x16x2 = types.p8x16x2;
pub const p16x4x2 = types.p16x4x2;
pub const p16x8x2 = types.p16x8x2;
pub const p64x1x2 = types.p64x1x2;
pub const p64x2x2 = types.p64x2x2;

pub const i8x8x3 = types.i8x8x3;
pub const i8x16x3 = types.i8x16x3;
pub const i16x4x3 = types.i16x4x3;
pub const i16x8x3 = types.i16x8x3;
pub const i32x2x3 = types.i32x2x3;
pub const i32x4x3 = types.i32x4x3;
pub const i64x1x3 = types.i64x1x3;
pub const i64x2x3 = types.i64x2x3;

pub const u8x8x3 = types.u8x8x3;
pub const u8x16x3 = types.u8x16x3;
pub const u16x4x3 = types.u16x4x3;
pub const u16x8x3 = types.u16x8x3;
pub const u32x2x3 = types.u32x2x3;
pub const u32x4x3 = types.u32x4x3;
pub const u64x1x3 = types.u64x1x3;
pub const u64x2x3 = types.u64x2x3;

pub const f16x4x3 = types.f16x4x3;
pub const f16x8x3 = types.f16x8x3;
pub const f32x2x3 = types.f32x2x3;
pub const f32x4x3 = types.f32x4x3;
pub const f64x1x3 = types.f64x1x3;
pub const f64x2x3 = types.f64x2x3;

pub const p8x8x3 = types.p8x8x3;
pub const p8x16x3 = types.p8x16x3;
pub const p16x4x3 = types.p16x4x3;
pub const p16x8x3 = types.p16x8x3;
pub const p64x1x3 = types.p64x1x3;
pub const p64x2x3 = types.p64x2x3;

pub const i8x8x4 = types.i8x8x4;
pub const i8x16x4 = types.i8x16x4;
pub const i16x4x4 = types.i16x4x4;
pub const i16x8x4 = types.i16x8x4;
pub const i32x2x4 = types.i32x2x4;
pub const i32x4x4 = types.i32x4x4;
pub const i64x1x4 = types.i64x1x4;
pub const i64x2x4 = types.i64x2x4;

pub const u8x8x4 = types.u8x8x4;
pub const u8x16x4 = types.u8x16x4;
pub const u16x4x4 = types.u16x4x4;
pub const u16x8x4 = types.u16x8x4;
pub const u32x2x4 = types.u32x2x4;
pub const u32x4x4 = types.u32x4x4;
pub const u64x1x4 = types.u64x1x4;
pub const u64x2x4 = types.u64x2x4;

pub const f16x4x4 = types.f16x4x4;
pub const f16x8x4 = types.f16x8x4;
pub const f32x2x4 = types.f32x2x4;
pub const f32x4x4 = types.f32x4x4;
pub const f64x1x4 = types.f64x1x4;
pub const f64x2x4 = types.f64x2x4;

pub const p8x8x4 = types.p8x8x4;
pub const p8x16x4 = types.p8x16x4;
pub const p16x4x4 = types.p16x4x4;
pub const p16x8x4 = types.p16x8x4;
pub const p64x1x4 = types.p64x1x4;
pub const p64x2x4 = types.p64x2x4;

// --- Readable Aliases ---
pub const int8x8 = types.int8x8;
pub const int8x16 = types.int8x16;
pub const int16x4 = types.int16x4;
pub const int16x8 = types.int16x8;
pub const int32x2 = types.int32x2;
pub const int32x4 = types.int32x4;
pub const int64x1 = types.int64x1;
pub const int64x2 = types.int64x2;

pub const uint8x8 = types.uint8x8;
pub const uint8x16 = types.uint8x16;
pub const uint16x4 = types.uint16x4;
pub const uint16x8 = types.uint16x8;
pub const uint32x2 = types.uint32x2;
pub const uint32x4 = types.uint32x4;
pub const uint64x1 = types.uint64x1;
pub const uint64x2 = types.uint64x2;

pub const float16x4 = types.float16x4;
pub const float16x8 = types.float16x8;
pub const float32x2 = types.float32x2;
pub const float32x4 = types.float32x4;
pub const float64x1 = types.float64x1;
pub const float64x2 = types.float64x2;

pub const poly8x8 = types.poly8x8;
pub const poly8x16 = types.poly8x16;
pub const poly16x4 = types.poly16x4;
pub const poly16x8 = types.poly16x8;
pub const poly64x1 = types.poly64x1;
pub const poly64x2 = types.poly64x2;

// --- C-style *_t Aliases ---
pub const int8x8_t = types.int8x8_t;
pub const int8x16_t = types.int8x16_t;
pub const int16x4_t = types.int16x4_t;
pub const int16x8_t = types.int16x8_t;
pub const int32x2_t = types.int32x2_t;
pub const int32x4_t = types.int32x4_t;
pub const int64x1_t = types.int64x1_t;
pub const int64x2_t = types.int64x2_t;

pub const uint8x8_t = types.uint8x8_t;
pub const uint8x16_t = types.uint8x16_t;
pub const uint16x4_t = types.uint16x4_t;
pub const uint16x8_t = types.uint16x8_t;
pub const uint32x2_t = types.uint32x2_t;
pub const uint32x4_t = types.uint32x4_t;
pub const uint64x1_t = types.uint64x1_t;
pub const uint64x2_t = types.uint64x2_t;

pub const float16x4_t = types.float16x4_t;
pub const float16x8_t = types.float16x8_t;
pub const float32x2_t = types.float32x2_t;
pub const float32x4_t = types.float32x4_t;
pub const float64x1_t = types.float64x1_t;
pub const float64x2_t = types.float64x2_t;

pub const poly8x8_t = types.poly8x8_t;
pub const poly8x16_t = types.poly8x16_t;
pub const poly16x4_t = types.poly16x4_t;
pub const poly16x8_t = types.poly16x8_t;
pub const poly64x1_t = types.poly64x1_t;
pub const poly64x2_t = types.poly64x2_t;

pub const int8x8x2_t = types.int8x8x2_t;
pub const int8x16x2_t = types.int8x16x2_t;
pub const int16x4x2_t = types.int16x4x2_t;
pub const int16x8x2_t = types.int16x8x2_t;
pub const int32x2x2_t = types.int32x2x2_t;
pub const int32x4x2_t = types.int32x4x2_t;
pub const int64x1x2_t = types.int64x1x2_t;
pub const int64x2x2_t = types.int64x2x2_t;

pub const uint8x8x2_t = types.uint8x8x2_t;
pub const uint8x16x2_t = types.uint8x16x2_t;
pub const uint16x4x2_t = types.uint16x4x2_t;
pub const uint16x8x2_t = types.uint16x8x2_t;
pub const uint32x2x2_t = types.uint32x2_t;
pub const uint32x4x2_t = types.uint32x4_t;
pub const uint64x1x2_t = types.uint64x1x2_t;
pub const uint64x2x2_t = types.uint64x2_t;

pub const float16x4x2_t = types.float16x4x2_t;
pub const float16x8x2_t = types.float16x8x2_t;
pub const float32x2x2_t = types.float32x2_t;
pub const float32x4x2_t = types.float32x4_t;
pub const float64x1x2_t = types.float64x1_t;
pub const float64x2x2_t = types.float64x2_t;

pub const poly8x8x2_t = types.poly8x8x2_t;
pub const poly8x16x2_t = types.poly8x16x2_t;
pub const poly16x4x2_t = types.poly16x4x2_t;
pub const poly16x8x2_t = types.poly16x8x2_t;
pub const poly64x1x2_t = types.poly64x1x2_t;
pub const poly64x2x2_t = types.poly64x2x2_t;

pub const int8x8x3_t = types.int8x8x3_t;
pub const int8x16x3_t = types.int8x16x3_t;
pub const int16x4x3_t = types.int16x4x3_t;
pub const int16x8x3_t = types.int16x8x3_t;
pub const int32x2x3_t = types.int32x2x3_t;
pub const int32x4x3_t = types.int32x4x3_t;
pub const int64x1x3_t = types.int64x1x3_t;
pub const int64x2x3_t = types.int64x2x3_t;

pub const uint8x8x3_t = types.uint8x8x3_t;
pub const uint8x16x3_t = types.uint8x16x3_t;
pub const uint16x4x3_t = types.uint16x4x3_t;
pub const uint16x8x3_t = types.uint16x8x3_t;
pub const uint32x2x3_t = types.uint32x2x3_t;
pub const uint32x4x3_t = types.uint32x4_t;
pub const uint64x1x3_t = types.uint64x1_t;
pub const uint64x2x3_t = types.uint64x2_t;

pub const float16x4x3_t = types.float16x4x3_t;
pub const float16x8x3_t = types.float16x8x3_t;
pub const float32x2x3_t = types.float32x2_t;
pub const float32x4x3_t = types.float32x4_t;
pub const float64x1x3_t = types.float64x1_t;
pub const float64x2x3_t = types.float64x2_t;

pub const poly8x8x3_t = types.poly8x8x3_t;
pub const poly8x16x3_t = types.poly8x16x3_t;
pub const poly16x4x3_t = types.poly16x4x3_t;
pub const poly16x8x3_t = types.poly16x8x3_t;
pub const poly64x1x3_t = types.poly64x1x3_t;
pub const poly64x2x3_t = types.poly64x2x3_t;

pub const int8x8x4_t = types.int8x8x4_t;
pub const int8x16x4_t = types.int8x16x4_t;
pub const int16x4x4_t = types.int16x4x4_t;
pub const int16x8x4_t = types.int16x8x4_t;
pub const int32x2x4_t = types.int32x2x4_t;
pub const int32x4x4_t = types.int32x4x4_t;
pub const int64x1x4_t = types.int64x1x4_t;
pub const int64x2x4_t = types.int64x2x4_t;

pub const uint8x8x4_t = types.uint8x8x4_t;
pub const uint8x16x4_t = types.uint8x16x4_t;
pub const uint16x4x4_t = types.uint16x4x4_t;
pub const uint16x8x4_t = types.uint16x8x4_t;
pub const uint32x2x4_t = types.uint32x2x4_t;
pub const uint32x4x4_t = types.uint32x4_t;
pub const uint64x1x4_t = types.uint64x1_t;
pub const uint64x2x4_t = types.uint64x2_t;

pub const float16x4x4_t = types.float16x4x4_t;
pub const float16x8x4_t = types.float16x8x4_t;
pub const float32x2x4_t = types.float32x2_t;
pub const float32x4x4_t = types.float32x4_t;
pub const float64x1x4_t = types.float64x1_t;
pub const float64x2x4_t = types.float64x2_t;

pub const poly8x8x4_t = types.poly8x8x4_t;
pub const poly8x16x4_t = types.poly8x16x4_t;
pub const poly16x4x4_t = types.poly16x4x4_t;
pub const poly16x8x4_t = types.poly16x8x4_t;
pub const poly64x1x4_t = types.poly64x1x4_t;
pub const poly64x2x4_t = types.poly64x2x4_t;

// --- Short v* Aliases ---
pub const v8i8 = types.v8i8;
pub const v16i8 = types.v16i8;
pub const v4i16 = types.v4i16;
pub const v8i16 = types.v8i16;
pub const v2i32 = types.v2i32;
pub const v4i32 = types.v4i32;
pub const v1i64 = types.v1i64;
pub const v2i64 = types.v2i64;

pub const v8u8 = types.v8u8;
pub const v16u8 = types.v16u8;
pub const v4u16 = types.v4u16;
pub const v8u16 = types.v8u16;
pub const v2u32 = types.v2u32;
pub const v4u32 = types.v4u32;
pub const v1u64 = types.v1u64;
pub const v2u64 = types.v2u64;

pub const v4f16 = types.v4f16;
pub const v8f16 = types.v8f16;
pub const v2f32 = types.v2f32;
pub const v4f32 = types.v4f32;
pub const v1f64 = types.v1f64;
pub const v2f64 = types.v2f64;

pub const v8p8 = types.v8p8;
pub const v16p8 = types.v16p8;
pub const v4p16 = types.v4p16;
pub const v8p16 = types.v8p16;
pub const v1p64 = types.v1p64;
pub const v2p64 = types.v2p64;

// --- Load / Store Intrinsics ---
pub const vld1_s8 = load_store.vld1_s8;
pub const vld1_s16 = load_store.vld1_s16;
pub const vld1_s32 = load_store.vld1_s32;
pub const vld1_s64 = load_store.vld1_s64;
pub const vld1_u8 = load_store.vld1_u8;
pub const vld1_u16 = load_store.vld1_u16;
pub const vld1_u32 = load_store.vld1_u32;
pub const vld1_u64 = load_store.vld1_u64;
pub const vld1_f16 = load_store.vld1_f16;
pub const vld1_f32 = load_store.vld1_f32;
pub const vld1_f64 = load_store.vld1_f64;
pub const vld1_p8 = load_store.vld1_p8;
pub const vld1_p16 = load_store.vld1_p16;
pub const vld1_p64 = load_store.vld1_p64;

pub const vld1q_s8 = load_store.vld1q_s8;
pub const vld1q_s16 = load_store.vld1q_s16;
pub const vld1q_s32 = load_store.vld1q_s32;
pub const vld1q_s64 = load_store.vld1q_s64;
pub const vld1q_u8 = load_store.vld1q_u8;
pub const vld1q_u16 = load_store.vld1q_u16;
pub const vld1q_u32 = load_store.vld1q_u32;
pub const vld1q_u64 = load_store.vld1q_u64;
pub const vld1q_f16 = load_store.vld1q_f16;
pub const vld1q_f32 = load_store.vld1q_f32;
pub const vld1q_f64 = load_store.vld1q_f64;
pub const vld1q_p8 = load_store.vld1q_p8;
pub const vld1q_p16 = load_store.vld1q_p16;
pub const vld1q_p64 = load_store.vld1q_p64;

pub const vst1_s8 = load_store.vst1_s8;
pub const vst1_s16 = load_store.vst1_s16;
pub const vst1_s32 = load_store.vst1_s32;
pub const vst1_s64 = load_store.vst1_s64;
pub const vst1_u8 = load_store.vst1_u8;
pub const vst1_u16 = load_store.vst1_u16;
pub const vst1_u32 = load_store.vst1_u32;
pub const vst1_u64 = load_store.vst1_u64;
pub const vst1_f16 = load_store.vst1_f16;
pub const vst1_f32 = load_store.vst1_f32;
pub const vst1_f64 = load_store.vst1_f64;
pub const vst1_p8 = load_store.vst1_p8;
pub const vst1_p16 = load_store.vst1_p16;
pub const vst1_p64 = load_store.vst1_p64;

pub const vst1q_s8 = load_store.vst1q_s8;
pub const vst1q_s16 = load_store.vst1q_s16;
pub const vst1q_s32 = load_store.vst1q_s32;
pub const vst1q_s64 = load_store.vst1q_s64;
pub const vst1q_u8 = load_store.vst1q_u8;
pub const vst1q_u16 = load_store.vst1q_u16;
pub const vst1q_u32 = load_store.vst1q_u32;
pub const vst1q_u64 = load_store.vst1q_u64;
pub const vst1q_f16 = load_store.vst1q_f16;
pub const vst1q_f32 = load_store.vst1q_f32;
pub const vst1q_f64 = load_store.vst1q_f64;
pub const vst1q_p8 = load_store.vst1q_p8;
pub const vst1q_p16 = load_store.vst1q_p16;
pub const vst1q_p64 = load_store.vst1q_p64;
pub const vst1q_p46 = load_store.vst1q_p46;

pub const vld1_lane_u8 = load_store.vld1_lane_u8;
pub const vld1q_lane_u8 = load_store.vld1q_lane_u8;
pub const vld1_lane_s32 = load_store.vld1_lane_s32;
pub const vld1q_lane_s32 = load_store.vld1q_lane_s32;
pub const vld1_lane_f32 = load_store.vld1_lane_f32;
pub const vld1q_lane_f32 = load_store.vld1q_lane_f32;
pub const vld1_dup_u8 = load_store.vld1_dup_u8;
pub const vld1_dup_u16 = load_store.vld1_dup_u16;
pub const vld1_dup_u32 = load_store.vld1_dup_u32;
pub const vld1_dup_u64 = load_store.vld1_dup_u64;
pub const vld1_dup_s8 = load_store.vld1_dup_s8;
pub const vld1_dup_s16 = load_store.vld1_dup_s16;
pub const vld1_dup_s32 = load_store.vld1_dup_s32;
pub const vld1_dup_s64 = load_store.vld1_dup_s64;
pub const vld1_dup_f16 = load_store.vld1_dup_f16;
pub const vld1_dup_f32 = load_store.vld1_dup_f32;
pub const vld1_dup_f64 = load_store.vld1_dup_f64;
pub const vld1_dup_p8 = load_store.vld1_dup_p8;
pub const vld1_dup_p16 = load_store.vld1_dup_p16;
pub const vld1_dup_p64 = load_store.vld1_dup_p64;
pub const vld1q_dup_u8 = load_store.vld1q_dup_u8;
pub const vld1q_dup_u16 = load_store.vld1q_dup_u16;
pub const vld1q_dup_u32 = load_store.vld1q_dup_u32;
pub const vld1q_dup_u64 = load_store.vld1q_dup_u64;
pub const vld1q_dup_s8 = load_store.vld1q_dup_s8;
pub const vld1q_dup_s16 = load_store.vld1q_dup_s16;
pub const vld1q_dup_s32 = load_store.vld1q_dup_s32;
pub const vld1q_dup_s64 = load_store.vld1q_dup_s64;
pub const vld1q_dup_f16 = load_store.vld1q_dup_f16;
pub const vld1q_dup_f32 = load_store.vld1q_dup_f32;
pub const vld1q_dup_f64 = load_store.vld1q_dup_f64;
pub const vld1q_dup_p8 = load_store.vld1q_dup_p8;
pub const vld1q_dup_p16 = load_store.vld1q_dup_p16;
pub const vld1q_dup_p64 = load_store.vld1q_dup_p64;
pub const vst1_lane_u8 = load_store.vst1_lane_u8;
pub const vst1q_lane_u8 = load_store.vst1q_lane_u8;
pub const vst1_lane_s32 = load_store.vst1_lane_s32;
pub const vst1q_lane_s32 = load_store.vst1q_lane_s32;
pub const vst1_lane_f32 = load_store.vst1_lane_f32;
pub const vst1q_lane_f32 = load_store.vst1q_lane_f32;

pub const vld2_u8 = load_store.vld2_u8;
pub const vld2_s8 = load_store.vld2_s8;
pub const vld2_s16 = load_store.vld2_s16;
pub const vld2_u16 = load_store.vld2_u16;
pub const vld2_s32 = load_store.vld2_s32;
pub const vld2_u32 = load_store.vld2_u32;
pub const vld2_f32 = load_store.vld2_f32;
pub const vld2q_u8 = load_store.vld2q_u8;
pub const vld2q_s8 = load_store.vld2q_s8;
pub const vld2q_s16 = load_store.vld2q_s16;
pub const vld2q_u16 = load_store.vld2q_u16;
pub const vld2q_s32 = load_store.vld2q_s32;
pub const vld2q_u32 = load_store.vld2q_u32;
pub const vld2q_f32 = load_store.vld2q_f32;
pub const vst2_u8 = load_store.vst2_u8;
pub const vst2_s8 = load_store.vst2_s8;
pub const vst2_s16 = load_store.vst2_s16;
pub const vst2_u16 = load_store.vst2_u16;
pub const vst2_s32 = load_store.vst2_s32;
pub const vst2_u32 = load_store.vst2_u32;
pub const vst2_f32 = load_store.vst2_f32;
pub const vst2q_u8 = load_store.vst2q_u8;
pub const vst2q_s8 = load_store.vst2q_s8;
pub const vst2q_s16 = load_store.vst2q_s16;
pub const vst2q_u16 = load_store.vst2q_u16;
pub const vst2q_s32 = load_store.vst2q_s32;
pub const vst2q_u32 = load_store.vst2q_u32;
pub const vst2q_f32 = load_store.vst2q_f32;
pub const vld3q_u8 = load_store.vld3q_u8;
pub const vst3q_u8 = load_store.vst3q_u8;
pub const vld4q_u8 = load_store.vld4q_u8;
pub const vst4q_u8 = load_store.vst4q_u8;

// --- Arithmetic Intrinsics ---
pub const vadd_s8 = arithmetic.vadd_s8;
pub const vadd_s16 = arithmetic.vadd_s16;
pub const vadd_s32 = arithmetic.vadd_s32;
pub const vadd_s64 = arithmetic.vadd_s64;
pub const vadd_u8 = arithmetic.vadd_u8;
pub const vadd_u16 = arithmetic.vadd_u16;
pub const vadd_u32 = arithmetic.vadd_u32;
pub const vadd_u64 = arithmetic.vadd_u64;
pub const vadd_f16 = arithmetic.vadd_f16;
pub const vadd_f32 = arithmetic.vadd_f32;
pub const vadd_f64 = arithmetic.vadd_f64;
pub const vadd_p8 = arithmetic.vadd_p8;
pub const vadd_p16 = arithmetic.vadd_p16;
pub const vadd_p64 = arithmetic.vadd_p64;
pub const vaddd_s64 = arithmetic.vaddd_s64;
pub const vaddd_u64 = arithmetic.vaddd_u64;

pub const vaddq_s8 = arithmetic.vaddq_s8;
pub const vaddq_s16 = arithmetic.vaddq_s16;
pub const vaddq_s32 = arithmetic.vaddq_s32;
pub const vaddq_s64 = arithmetic.vaddq_s64;
pub const vaddq_u8 = arithmetic.vaddq_u8;
pub const vaddq_u16 = arithmetic.vaddq_u16;
pub const vaddq_u32 = arithmetic.vaddq_u32;
pub const vaddq_u64 = arithmetic.vaddq_u64;
pub const vaddq_f16 = arithmetic.vaddq_f16;
pub const vaddq_f32 = arithmetic.vaddq_f32;
pub const vaddq_f64 = arithmetic.vaddq_f64;
pub const vaddq_p8 = arithmetic.vaddq_p8;
pub const vaddq_p16 = arithmetic.vaddq_p16;
pub const vaddq_p64 = arithmetic.vaddq_p64;
pub const vaddq_p128 = arithmetic.vaddq_p128;

pub const vsub_s8 = arithmetic.vsub_s8;
pub const vsub_s16 = arithmetic.vsub_s16;
pub const vsub_s32 = arithmetic.vsub_s32;
pub const vsub_s64 = arithmetic.vsub_s64;
pub const vsub_u8 = arithmetic.vsub_u8;
pub const vsub_u16 = arithmetic.vsub_u16;
pub const vsub_u32 = arithmetic.vsub_u32;
pub const vsub_u64 = arithmetic.vsub_u64;
pub const vsub_f16 = arithmetic.vsub_f16;
pub const vsub_f32 = arithmetic.vsub_f32;
pub const vsub_f64 = arithmetic.vsub_f64;

pub const vsubq_s8 = arithmetic.vsubq_s8;
pub const vsubq_s16 = arithmetic.vsubq_s16;
pub const vsubq_s32 = arithmetic.vsubq_s32;
pub const vsubq_s64 = arithmetic.vsubq_s64;
pub const vsubq_u8 = arithmetic.vsubq_u8;
pub const vsubq_u16 = arithmetic.vsubq_u16;
pub const vsubq_u32 = arithmetic.vsubq_u32;
pub const vsubq_u64 = arithmetic.vsubq_u64;
pub const vsubq_f16 = arithmetic.vsubq_f16;
pub const vsubq_f32 = arithmetic.vsubq_f32;
pub const vsubq_f64 = arithmetic.vsubq_f64;

pub const vneg_s8 = arithmetic.vneg_s8;
pub const vneg_s16 = arithmetic.vneg_s16;
pub const vneg_s32 = arithmetic.vneg_s32;
pub const vneg_s64 = arithmetic.vneg_s64;
pub const vneg_f16 = arithmetic.vneg_f16;
pub const vneg_f32 = arithmetic.vneg_f32;
pub const vneg_f64 = arithmetic.vneg_f64;

pub const vnegq_s8 = arithmetic.vnegq_s8;
pub const vnegq_s16 = arithmetic.vnegq_s16;
pub const vnegq_s32 = arithmetic.vnegq_s32;
pub const vnegq_s64 = arithmetic.vnegq_s64;
pub const vnegq_f16 = arithmetic.vnegq_f16;
pub const vnegq_f32 = arithmetic.vnegq_f32;
pub const vnegq_f64 = arithmetic.vnegq_f64;

pub const vabs_s8 = arithmetic.vabs_s8;
pub const vabs_s16 = arithmetic.vabs_s16;
pub const vabs_s32 = arithmetic.vabs_s32;
pub const vabs_s64 = arithmetic.vabs_s64;
pub const vabs_f16 = arithmetic.vabs_f16;
pub const vabs_f32 = arithmetic.vabs_f32;
pub const vabs_f64 = arithmetic.vabs_f64;
pub const vabsd_s64 = arithmetic.vabsd_s64;

pub const vabsq_s8 = arithmetic.vabsq_s8;
pub const vabsq_s16 = arithmetic.vabsq_s16;
pub const vabsq_s32 = arithmetic.vabsq_s32;
pub const vabsq_s64 = arithmetic.vabsq_s64;
pub const vabsq_f16 = arithmetic.vabsq_f16;
pub const vabsq_f32 = arithmetic.vabsq_f32;
pub const vabsq_f64 = arithmetic.vabsq_f64;

pub const vabd_s8 = arithmetic.vabd_s8;
pub const vabd_s16 = arithmetic.vabd_s16;
pub const vabd_s32 = arithmetic.vabd_s32;
pub const vabd_u8 = arithmetic.vabd_u8;
pub const vabd_u16 = arithmetic.vabd_u16;
pub const vabd_u32 = arithmetic.vabd_u32;
pub const vabd_f16 = arithmetic.vabd_f16;
pub const vabd_f32 = arithmetic.vabd_f32;
pub const vabd_f64 = arithmetic.vabd_f64;
pub const vabds_f32 = arithmetic.vabds_f32;
pub const vabdd_f64 = arithmetic.vabdd_f64;

pub const vabdq_s8 = arithmetic.vabdq_s8;
pub const vabdq_s16 = arithmetic.vabdq_s16;
pub const vabdq_s32 = arithmetic.vabdq_s32;
pub const vabdq_u8 = arithmetic.vabdq_u8;
pub const vabdq_u16 = arithmetic.vabdq_u16;
pub const vabdq_u32 = arithmetic.vabdq_u32;
pub const vabdq_f16 = arithmetic.vabdq_f16;
pub const vabdq_f32 = arithmetic.vabdq_f32;
pub const vabdq_f64 = arithmetic.vabdq_f64;

pub const vabdl_s8 = arithmetic.vabdl_s8;
pub const vabdl_s16 = arithmetic.vabdl_s16;
pub const vabdl_s32 = arithmetic.vabdl_s32;
pub const vabdl_u8 = arithmetic.vabdl_u8;
pub const vabdl_u16 = arithmetic.vabdl_u16;
pub const vabdl_u32 = arithmetic.vabdl_u32;

pub const vaba_s8 = arithmetic.vaba_s8;
pub const vaba_s16 = arithmetic.vaba_s16;
pub const vaba_s32 = arithmetic.vaba_s32;
pub const vaba_u8 = arithmetic.vaba_u8;
pub const vaba_u16 = arithmetic.vaba_u16;
pub const vaba_u32 = arithmetic.vaba_u32;

pub const vabaq_s8 = arithmetic.vabaq_s8;
pub const vabaq_s16 = arithmetic.vabaq_s16;
pub const vabaq_s32 = arithmetic.vabaq_s32;
pub const vabaq_u8 = arithmetic.vabaq_u8;
pub const vabaq_u16 = arithmetic.vabaq_u16;
pub const vabaq_u32 = arithmetic.vabaq_u32;

pub const vabal_s8 = arithmetic.vabal_s8;
pub const vabal_s16 = arithmetic.vabal_s16;
pub const vabal_s32 = arithmetic.vabal_s32;
pub const vabal_u8 = arithmetic.vabal_u8;
pub const vabal_u16 = arithmetic.vabal_u16;
pub const vabal_u32 = arithmetic.vabal_u32;

pub const vaddl_s8 = arithmetic.vaddl_s8;
pub const vaddl_s16 = arithmetic.vaddl_s16;
pub const vaddl_s32 = arithmetic.vaddl_s32;
pub const vaddl_u8 = arithmetic.vaddl_u8;
pub const vaddl_u16 = arithmetic.vaddl_u16;
pub const vaddl_u32 = arithmetic.vaddl_u32;

pub const vaddw_s8 = arithmetic.vaddw_s8;
pub const vaddw_s16 = arithmetic.vaddw_s16;
pub const vaddw_s32 = arithmetic.vaddw_s32;
pub const vaddw_u8 = arithmetic.vaddw_u8;
pub const vaddw_u16 = arithmetic.vaddw_u16;
pub const vaddw_u32 = arithmetic.vaddw_u32;

pub const vaddhn_s16 = arithmetic.vaddhn_s16;
pub const vaddhn_s32 = arithmetic.vaddhn_s32;
pub const vaddhn_s64 = arithmetic.vaddhn_s64;
pub const vaddhn_u16 = arithmetic.vaddhn_u16;
pub const vaddhn_u32 = arithmetic.vaddhn_u32;
pub const vaddhn_u64 = arithmetic.vaddhn_u64;

pub const vmul_s8 = arithmetic.vmul_s8;
pub const vmul_s16 = arithmetic.vmul_s16;
pub const vmul_s32 = arithmetic.vmul_s32;
pub const vmul_u8 = arithmetic.vmul_u8;
pub const vmul_u16 = arithmetic.vmul_u16;
pub const vmul_u32 = arithmetic.vmul_u32;
pub const vmul_f16 = arithmetic.vmul_f16;
pub const vmul_f32 = arithmetic.vmul_f32;
pub const vmul_f64 = arithmetic.vmul_f64;

pub const vmulq_s8 = arithmetic.vmulq_s8;
pub const vmulq_s16 = arithmetic.vmulq_s16;
pub const vmulq_s32 = arithmetic.vmulq_s32;
pub const vmulq_u8 = arithmetic.vmulq_u8;
pub const vmulq_u16 = arithmetic.vmulq_u16;
pub const vmulq_u32 = arithmetic.vmulq_u32;
pub const vmulq_f16 = arithmetic.vmulq_f16;
pub const vmulq_f32 = arithmetic.vmulq_f32;
pub const vmulq_f64 = arithmetic.vmulq_f64;

pub const vmull_s8 = arithmetic.vmull_s8;
pub const vmull_s16 = arithmetic.vmull_s16;
pub const vmull_s32 = arithmetic.vmull_s32;
pub const vmull_u8 = arithmetic.vmull_u8;
pub const vmull_u16 = arithmetic.vmull_u16;
pub const vmull_u32 = arithmetic.vmull_u32;

pub const vmla_s8 = arithmetic.vmla_s8;
pub const vmla_s16 = arithmetic.vmla_s16;
pub const vmla_s32 = arithmetic.vmla_s32;
pub const vmla_u8 = arithmetic.vmla_u8;
pub const vmla_u16 = arithmetic.vmla_u16;
pub const vmla_u32 = arithmetic.vmla_u32;
pub const vmla_f16 = arithmetic.vmla_f16;
pub const vmla_f32 = arithmetic.vmla_f32;

pub const vmlaq_s8 = arithmetic.vmlaq_s8;
pub const vmlaq_s16 = arithmetic.vmlaq_s16;
pub const vmlaq_s32 = arithmetic.vmlaq_s32;
pub const vmlaq_u8 = arithmetic.vmlaq_u8;
pub const vmlaq_u16 = arithmetic.vmlaq_u16;
pub const vmlaq_u32 = arithmetic.vmlaq_u32;
pub const vmlaq_f16 = arithmetic.vmlaq_f16;
pub const vmlaq_f32 = arithmetic.vmlaq_f32;
pub const vmlaq_f64 = arithmetic.vmlaq_f64;

pub const vmls_s8 = arithmetic.vmls_s8;
pub const vmls_s16 = arithmetic.vmls_s16;
pub const vmls_s32 = arithmetic.vmls_s32;
pub const vmls_u8 = arithmetic.vmls_u8;
pub const vmls_u16 = arithmetic.vmls_u16;
pub const vmls_u32 = arithmetic.vmls_u32;
pub const vmls_f16 = arithmetic.vmls_f16;
pub const vmls_f32 = arithmetic.vmls_f32;

pub const vmlsq_s8 = arithmetic.vmlsq_s8;
pub const vmlsq_s16 = arithmetic.vmlsq_s16;
pub const vmlsq_s32 = arithmetic.vmlsq_s32;
pub const vmlsq_u8 = arithmetic.vmlsq_u8;
pub const vmlsq_u16 = arithmetic.vmlsq_u16;
pub const vmlsq_u32 = arithmetic.vmlsq_u32;
pub const vmlsq_f16 = arithmetic.vmlsq_f16;
pub const vmlsq_f32 = arithmetic.vmlsq_f32;
pub const vmlsq_f64 = arithmetic.vmlsq_f64;

pub const vfma_f16 = arithmetic.vfma_f16;
pub const vfma_f32 = arithmetic.vfma_f32;
pub const vfma_f64 = arithmetic.vfma_f64;
pub const vfmaq_f16 = arithmetic.vfmaq_f16;
pub const vfmaq_f32 = arithmetic.vfmaq_f32;
pub const vfmaq_f64 = arithmetic.vfmaq_f64;

pub const vfms_f16 = arithmetic.vfms_f16;
pub const vfms_f32 = arithmetic.vfms_f32;
pub const vfms_f64 = arithmetic.vfms_f64;
pub const vfmsq_f16 = arithmetic.vfmsq_f16;
pub const vfmsq_f32 = arithmetic.vfmsq_f32;
pub const vfmsq_f64 = arithmetic.vfmsq_f64;

pub const vfmaq_laneq_f16 = arithmetic.vfmaq_laneq_f16;
pub const vfmaq_laneq_f32 = arithmetic.vfmaq_laneq_f32;
pub const vfmaq_laneq_f64 = arithmetic.vfmaq_laneq_f64;

pub const vqadd_s8 = arithmetic.vqadd_s8;
pub const vqadd_s16 = arithmetic.vqadd_s16;
pub const vqadd_s32 = arithmetic.vqadd_s32;
pub const vqadd_s64 = arithmetic.vqadd_s64;
pub const vqadd_u8 = arithmetic.vqadd_u8;
pub const vqadd_u16 = arithmetic.vqadd_u16;
pub const vqadd_u32 = arithmetic.vqadd_u32;
pub const vqadd_u64 = arithmetic.vqadd_u64;

pub const vqaddq_s8 = arithmetic.vqaddq_s8;
pub const vqaddq_s16 = arithmetic.vqaddq_s16;
pub const vqaddq_s32 = arithmetic.vqaddq_s32;
pub const vqaddq_s64 = arithmetic.vqaddq_s64;
pub const vqaddq_u8 = arithmetic.vqaddq_u8;
pub const vqaddq_u16 = arithmetic.vqaddq_u16;
pub const vqaddq_u32 = arithmetic.vqaddq_u32;
pub const vqaddq_u64 = arithmetic.vqaddq_u64;

pub const vqsub_s8 = arithmetic.vqsub_s8;
pub const vqsub_s16 = arithmetic.vqsub_s16;
pub const vqsub_s32 = arithmetic.vqsub_s32;
pub const vqsub_s64 = arithmetic.vqsub_s64;
pub const vqsub_u8 = arithmetic.vqsub_u8;
pub const vqsub_u16 = arithmetic.vqsub_u16;
pub const vqsub_u32 = arithmetic.vqsub_u32;
pub const vqsub_u64 = arithmetic.vqsub_u64;

pub const vqsubq_s8 = arithmetic.vqsubq_s8;
pub const vqsubq_s16 = arithmetic.vqsubq_s16;
pub const vqsubq_s32 = arithmetic.vqsubq_s32;
pub const vqsubq_s64 = arithmetic.vqsubq_s64;
pub const vqsubq_u8 = arithmetic.vqsubq_u8;
pub const vqsubq_u16 = arithmetic.vqsubq_u16;
pub const vqsubq_u32 = arithmetic.vqsubq_u32;
pub const vqsubq_u64 = arithmetic.vqsubq_u64;

pub const vqsubs_s32 = arithmetic.vqsubs_s32;
pub const vqsubs_u32 = arithmetic.vqsubs_u32;
pub const vqsubd_s64 = arithmetic.vqsubd_s64;
pub const vqsubd_u64 = arithmetic.vqsubd_u64;

pub const vqdmull_s16 = arithmetic.vqdmull_s16;
pub const vqdmull_s32 = arithmetic.vqdmull_s32;
pub const vqdmullh_s16 = arithmetic.vqdmullh_s16;
pub const vqdmulls_s32 = arithmetic.vqdmulls_s32;

// --- Bitwise Intrinsics ---
pub const vand_s8 = bitwise.vand_s8;
pub const vand_s16 = bitwise.vand_s16;
pub const vand_s32 = bitwise.vand_s32;
pub const vand_s64 = bitwise.vand_s64;
pub const vand_u8 = bitwise.vand_u8;
pub const vand_u16 = bitwise.vand_u16;
pub const vand_u32 = bitwise.vand_u32;
pub const vand_u64 = bitwise.vand_u64;
pub const vand_p8 = bitwise.vand_p8;
pub const vand_p16 = bitwise.vand_p16;
pub const vand_p64 = bitwise.vand_p64;

pub const vandq_s8 = bitwise.vandq_s8;
pub const vandq_s16 = bitwise.vandq_s16;
pub const vandq_s32 = bitwise.vandq_s32;
pub const vandq_s64 = bitwise.vandq_s64;
pub const vandq_u8 = bitwise.vandq_u8;
pub const vandq_u16 = bitwise.vandq_u16;
pub const vandq_u32 = bitwise.vandq_u32;
pub const vandq_u64 = bitwise.vandq_u64;
pub const vandq_p8 = bitwise.vandq_p8;
pub const vandq_p16 = bitwise.vandq_p16;
pub const vandq_p64 = bitwise.vandq_p64;

pub const vorr_s8 = bitwise.vorr_s8;
pub const vorr_s16 = bitwise.vorr_s16;
pub const vorr_s32 = bitwise.vorr_s32;
pub const vorr_s64 = bitwise.vorr_s64;
pub const vorr_u8 = bitwise.vorr_u8;
pub const vorr_u16 = bitwise.vorr_u16;
pub const vorr_u32 = bitwise.vorr_u32;
pub const vorr_u64 = bitwise.vorr_u64;

pub const vorrq_s8 = bitwise.vorrq_s8;
pub const vorrq_s16 = bitwise.vorrq_s16;
pub const vorrq_s32 = bitwise.vorrq_s32;
pub const vorrq_s64 = bitwise.vorrq_s64;
pub const vorrq_u8 = bitwise.vorrq_u8;
pub const vorrq_u16 = bitwise.vorrq_u16;
pub const vorrq_u32 = bitwise.vorrq_u32;
pub const vorrq_u64 = bitwise.vorrq_u64;

pub const veor_s8 = bitwise.veor_s8;
pub const veor_s16 = bitwise.veor_s16;
pub const veor_s32 = bitwise.veor_s32;
pub const veor_s64 = bitwise.veor_s64;
pub const veor_u8 = bitwise.veor_u8;
pub const veor_u16 = bitwise.veor_u16;
pub const veor_u32 = bitwise.veor_u32;
pub const veor_u64 = bitwise.veor_u64;

pub const veorq_s8 = bitwise.veorq_s8;
pub const veorq_s16 = bitwise.veorq_s16;
pub const veorq_s32 = bitwise.veorq_s32;
pub const veorq_s64 = bitwise.veorq_s64;
pub const veorq_u8 = bitwise.veorq_u8;
pub const veorq_u16 = bitwise.veorq_u16;
pub const veorq_u32 = bitwise.veorq_u32;
pub const veorq_u64 = bitwise.veorq_u64;

pub const vbic_s8 = bitwise.vbic_s8;
pub const vbic_s16 = bitwise.vbic_s16;
pub const vbic_s32 = bitwise.vbic_s32;
pub const vbic_s64 = bitwise.vbic_s64;
pub const vbic_u8 = bitwise.vbic_u8;
pub const vbic_u16 = bitwise.vbic_u16;
pub const vbic_u32 = bitwise.vbic_u32;
pub const vbic_u64 = bitwise.vbic_u64;

pub const vbicq_s8 = bitwise.vbicq_s8;
pub const vbicq_s16 = bitwise.vbicq_s16;
pub const vbicq_s32 = bitwise.vbicq_s32;
pub const vbicq_s64 = bitwise.vbicq_s64;
pub const vbicq_u8 = bitwise.vbicq_u8;
pub const vbicq_u16 = bitwise.vbicq_u16;
pub const vbicq_u32 = bitwise.vbicq_u32;
pub const vbicq_u64 = bitwise.vbicq_u64;

pub const vmvn_s8 = bitwise.vmvn_s8;
pub const vmvn_s16 = bitwise.vmvn_s16;
pub const vmvn_s32 = bitwise.vmvn_s32;
pub const vmvn_u8 = bitwise.vmvn_u8;
pub const vmvn_u16 = bitwise.vmvn_u16;
pub const vmvn_u32 = bitwise.vmvn_u32;

pub const vmvnq_s8 = bitwise.vmvnq_s8;
pub const vmvnq_s16 = bitwise.vmvnq_s16;
pub const vmvnq_s32 = bitwise.vmvnq_s32;
pub const vmvnq_u8 = bitwise.vmvnq_u8;
pub const vmvnq_u16 = bitwise.vmvnq_u16;
pub const vmvnq_u32 = bitwise.vmvnq_u32;

pub const vbsl_s8 = bitwise.vbsl_s8;
pub const vbsl_s16 = bitwise.vbsl_s16;
pub const vbsl_s32 = bitwise.vbsl_s32;
pub const vbsl_s64 = bitwise.vbsl_s64;
pub const vbsl_u8 = bitwise.vbsl_u8;
pub const vbsl_u16 = bitwise.vbsl_u16;
pub const vbsl_u32 = bitwise.vbsl_u32;
pub const vbsl_u64 = bitwise.vbsl_u64;
pub const vbsl_f32 = bitwise.vbsl_f32;
pub const vbsl_f64 = bitwise.vbsl_f64;
pub const vbsl_p8 = bitwise.vbsl_p8;
pub const vbsl_p16 = bitwise.vbsl_p16;
pub const vbsl_p64 = bitwise.vbsl_p64;

pub const vbslq_s8 = bitwise.vbslq_s8;
pub const vbslq_s16 = bitwise.vbslq_s16;
pub const vbslq_s32 = bitwise.vbslq_s32;
pub const vbslq_s64 = bitwise.vbslq_s64;
pub const vbslq_u8 = bitwise.vbslq_u8;
pub const vbslq_u16 = bitwise.vbslq_u16;
pub const vbslq_u32 = bitwise.vbslq_u32;
pub const vbslq_u64 = bitwise.vbslq_u64;
pub const vbslq_f32 = bitwise.vbslq_f32;
pub const vbslq_f64 = bitwise.vbslq_f64;
pub const vbslq_p8 = bitwise.vbslq_p8;
pub const vbslq_p16 = bitwise.vbslq_p16;
pub const vbslq_p64 = bitwise.vbslq_p64;

pub const vbcaxq_s8 = bitwise.vbcaxq_s8;
pub const vbcaxq_s16 = bitwise.vbcaxq_s16;
pub const vbcaxq_s32 = bitwise.vbcaxq_s32;
pub const vbcaxq_s64 = bitwise.vbcaxq_s64;
pub const vbcaxq_u8 = bitwise.vbcaxq_u8;
pub const vbcaxq_u16 = bitwise.vbcaxq_u16;
pub const vbcaxq_u32 = bitwise.vbcaxq_u32;
pub const vbcaxq_u64 = bitwise.vbcaxq_u64;

pub const vcnt_u8 = bitwise.vcnt_u8;
pub const vcnt_s8 = bitwise.vcnt_s8;
pub const vcnt_p8 = bitwise.vcnt_p8;
pub const vcntq_u8 = bitwise.vcntq_u8;
pub const vcntq_s8 = bitwise.vcntq_s8;
pub const vcntq_p8 = bitwise.vcntq_p8;

pub const vclz_u8 = bitwise.vclz_u8;
pub const vclz_u16 = bitwise.vclz_u16;
pub const vclz_u32 = bitwise.vclz_u32;
pub const vclz_s8 = bitwise.vclz_s8;
pub const vclz_s16 = bitwise.vclz_s16;
pub const vclz_s32 = bitwise.vclz_s32;
pub const vclzq_u8 = bitwise.vclzq_u8;
pub const vclzq_u16 = bitwise.vclzq_u16;
pub const vclzq_u32 = bitwise.vclzq_u32;
pub const vclzq_s8 = bitwise.vclzq_s8;
pub const vclzq_s16 = bitwise.vclzq_s16;
pub const vclzq_s32 = bitwise.vclzq_s32;

// --- Shift Intrinsics ---
pub const vshr_n_s8 = shift.vshr_n_s8;
pub const vshr_n_s16 = shift.vshr_n_s16;
pub const vshr_n_s32 = shift.vshr_n_s32;
pub const vshr_n_s64 = shift.vshr_n_s64;
pub const vshr_n_u8 = shift.vshr_n_u8;
pub const vshr_n_u16 = shift.vshr_n_u16;
pub const vshr_n_u32 = shift.vshr_n_u32;
pub const vshr_n_u64 = shift.vshr_n_u64;

pub const vshrq_n_s8 = shift.vshrq_n_s8;
pub const vshrq_n_s16 = shift.vshrq_n_s16;
pub const vshrq_n_s32 = shift.vshrq_n_s32;
pub const vshrq_n_s64 = shift.vshrq_n_s64;
pub const vshrq_n_u8 = shift.vshrq_n_u8;
pub const vshrq_n_u16 = shift.vshrq_n_u16;
pub const vshrq_n_u32 = shift.vshrq_n_u32;
pub const vshrq_n_u64 = shift.vshrq_n_u64;

pub const vshl_n_s8 = shift.vshl_n_s8;
pub const vshl_n_s16 = shift.vshl_n_s16;
pub const vshl_n_s32 = shift.vshl_n_s32;
pub const vshl_n_s64 = shift.vshl_n_s64;
pub const vshl_n_u8 = shift.vshl_n_u8;
pub const vshl_n_u16 = shift.vshl_n_u16;
pub const vshl_n_u32 = shift.vshl_n_u32;
pub const vshl_n_u64 = shift.vshl_n_u64;

pub const vshlq_n_s8 = shift.vshlq_n_s8;
pub const vshlq_n_s16 = shift.vshlq_n_s16;
pub const vshlq_n_s32 = shift.vshlq_n_s32;
pub const vshlq_n_s64 = shift.vshlq_n_s64;
pub const vshlq_n_u8 = shift.vshlq_n_u8;
pub const vshlq_n_u16 = shift.vshlq_n_u16;
pub const vshlq_n_u32 = shift.vshlq_n_u32;
pub const vshlq_n_u64 = shift.vshlq_n_u64;

pub const vsra_n_s8 = shift.vsra_n_s8;
pub const vsra_n_s16 = shift.vsra_n_s16;
pub const vsra_n_s32 = shift.vsra_n_s32;
pub const vsra_n_s64 = shift.vsra_n_s64;
pub const vsra_n_u8 = shift.vsra_n_u8;
pub const vsra_n_u16 = shift.vsra_n_u16;
pub const vsra_n_u32 = shift.vsra_n_u32;
pub const vsra_n_u64 = shift.vsra_n_u64;

pub const vsraq_n_s8 = shift.vsraq_n_s8;
pub const vsraq_n_s16 = shift.vsraq_n_s16;
pub const vsraq_n_s32 = shift.vsraq_n_s32;
pub const vsraq_n_s64 = shift.vsraq_n_s64;
pub const vsraq_n_u8 = shift.vsraq_n_u8;
pub const vsraq_n_u16 = shift.vsraq_n_u16;
pub const vsraq_n_u32 = shift.vsraq_n_u32;
pub const vsraq_n_u64 = shift.vsraq_n_u64;

pub const vshrn_n_s16 = shift.vshrn_n_s16;
pub const vshrn_n_s32 = shift.vshrn_n_s32;
pub const vshrn_n_s64 = shift.vshrn_n_s64;
pub const vshrn_n_u16 = shift.vshrn_n_u16;
pub const vshrn_n_u32 = shift.vshrn_n_u32;
pub const vshrn_n_u64 = shift.vshrn_n_u64;

pub const vshl_s8 = shift.vshl_s8;
pub const vshl_u8 = shift.vshl_u8;
pub const vshlq_s8 = shift.vshlq_s8;
pub const vshlq_u8 = shift.vshlq_u8;

// --- Compare Intrinsics ---
pub const vceq_s8 = compare.vceq_s8;
pub const vceq_s16 = compare.vceq_s16;
pub const vceq_s32 = compare.vceq_s32;
pub const vceq_u8 = compare.vceq_u8;
pub const vceq_u16 = compare.vceq_u16;
pub const vceq_u32 = compare.vceq_u32;
pub const vceq_f32 = compare.vceq_f32;

pub const vceqq_s8 = compare.vceqq_s8;
pub const vceqq_s16 = compare.vceqq_s16;
pub const vceqq_s32 = compare.vceqq_s32;
pub const vceqq_u8 = compare.vceqq_u8;
pub const vceqq_u16 = compare.vceqq_u16;
pub const vceqq_u32 = compare.vceqq_u32;
pub const vceqq_f32 = compare.vceqq_f32;
pub const vceqq_f64 = compare.vceqq_f64;

pub const vcge_s8 = compare.vcge_s8;
pub const vcge_s16 = compare.vcge_s16;
pub const vcge_s32 = compare.vcge_s32;
pub const vcge_u8 = compare.vcge_u8;
pub const vcge_u16 = compare.vcge_u16;
pub const vcge_u32 = compare.vcge_u32;
pub const vcge_f32 = compare.vcge_f32;

pub const vcgeq_s8 = compare.vcgeq_s8;
pub const vcgeq_s16 = compare.vcgeq_s16;
pub const vcgeq_s32 = compare.vcgeq_s32;
pub const vcgeq_u8 = compare.vcgeq_u8;
pub const vcgeq_u16 = compare.vcgeq_u16;
pub const vcgeq_u32 = compare.vcgeq_u32;
pub const vcgeq_f32 = compare.vcgeq_f32;
pub const vcgeq_f64 = compare.vcgeq_f64;

pub const vcgt_s8 = compare.vcgt_s8;
pub const vcgt_s16 = compare.vcgt_s16;
pub const vcgt_s32 = compare.vcgt_s32;
pub const vcgt_u8 = compare.vcgt_u8;
pub const vcgt_u16 = compare.vcgt_u16;
pub const vcgt_u32 = compare.vcgt_u32;
pub const vcgt_f32 = compare.vcgt_f32;

pub const vcgtq_s8 = compare.vcgtq_s8;
pub const vcgtq_s16 = compare.vcgtq_s16;
pub const vcgtq_s32 = compare.vcgtq_s32;
pub const vcgtq_u8 = compare.vcgtq_u8;
pub const vcgtq_u16 = compare.vcgtq_u16;
pub const vcgtq_u32 = compare.vcgtq_u32;
pub const vcgtq_f32 = compare.vcgtq_f32;
pub const vcgtq_f64 = compare.vcgtq_f64;

pub const vcle_s8 = compare.vcle_s8;
pub const vcle_s16 = compare.vcle_s16;
pub const vcle_s32 = compare.vcle_s32;
pub const vcle_u8 = compare.vcle_u8;
pub const vcle_u16 = compare.vcle_u16;
pub const vcle_u32 = compare.vcle_u32;
pub const vcle_f32 = compare.vcle_f32;

pub const vcleq_s8 = compare.vcleq_s8;
pub const vcleq_s16 = compare.vcleq_s16;
pub const vcleq_s32 = compare.vcleq_s32;
pub const vcleq_u8 = compare.vcleq_u8;
pub const vcleq_u16 = compare.vcleq_u16;
pub const vcleq_u32 = compare.vcleq_u32;
pub const vcleq_f32 = compare.vcleq_f32;
pub const vcleq_f64 = compare.vcleq_f64;

pub const vclt_s8 = compare.vclt_s8;
pub const vclt_s16 = compare.vclt_s16;
pub const vclt_s32 = compare.vclt_s32;
pub const vclt_u8 = compare.vclt_u8;
pub const vclt_u16 = compare.vclt_u16;
pub const vclt_u32 = compare.vclt_u32;
pub const vclt_f32 = compare.vclt_f32;

pub const vcltq_s8 = compare.vcltq_s8;
pub const vcltq_s16 = compare.vcltq_s16;
pub const vcltq_s32 = compare.vcltq_s32;
pub const vcltq_u8 = compare.vcltq_u8;
pub const vcltq_u16 = compare.vcltq_u16;
pub const vcltq_u32 = compare.vcltq_u32;
pub const vcltq_f32 = compare.vcltq_f32;
pub const vcltq_f64 = compare.vcltq_f64;

pub const vcage_f32 = compare.vcage_f32;
pub const vcage_f64 = compare.vcage_f64;
pub const vcageq_f32 = compare.vcageq_f32;
pub const vcageq_f64 = compare.vcageq_f64;
pub const vcagt_f32 = compare.vcagt_f32;
pub const vcagt_f64 = compare.vcagt_f64;
pub const vcagtq_f32 = compare.vcagtq_f32;
pub const vcagtq_f64 = compare.vcagtq_f64;

pub const vmin_s8 = compare.vmin_s8;
pub const vmin_s16 = compare.vmin_s16;
pub const vmin_s32 = compare.vmin_s32;
pub const vmin_u8 = compare.vmin_u8;
pub const vmin_u16 = compare.vmin_u16;
pub const vmin_u32 = compare.vmin_u32;
pub const vmin_f16 = compare.vmin_f16;
pub const vmin_f32 = compare.vmin_f32;
pub const vmin_f64 = compare.vmin_f64;

pub const vminq_s8 = compare.vminq_s8;
pub const vminq_s16 = compare.vminq_s16;
pub const vminq_s32 = compare.vminq_s32;
pub const vminq_u8 = compare.vminq_u8;
pub const vminq_u16 = compare.vminq_u16;
pub const vminq_u32 = compare.vminq_u32;
pub const vminq_f16 = compare.vminq_f16;
pub const vminq_f32 = compare.vminq_f32;
pub const vminq_f64 = compare.vminq_f64;

pub const vmax_s8 = compare.vmax_s8;
pub const vmax_s16 = compare.vmax_s16;
pub const vmax_s32 = compare.vmax_s32;
pub const vmax_u8 = compare.vmax_u8;
pub const vmax_u16 = compare.vmax_u16;
pub const vmax_u32 = compare.vmax_u32;
pub const vmax_f16 = compare.vmax_f16;
pub const vmax_f32 = compare.vmax_f32;
pub const vmax_f64 = compare.vmax_f64;

pub const vmaxq_s8 = compare.vmaxq_s8;
pub const vmaxq_s16 = compare.vmaxq_s16;
pub const vmaxq_s32 = compare.vmaxq_s32;
pub const vmaxq_u8 = compare.vmaxq_u8;
pub const vmaxq_u16 = compare.vmaxq_u16;
pub const vmaxq_u32 = compare.vmaxq_u32;
pub const vmaxq_f16 = compare.vmaxq_f16;
pub const vmaxq_f32 = compare.vmaxq_f32;
pub const vmaxq_f64 = compare.vmaxq_f64;

// --- Reduction Intrinsics ---
pub const vaddv_s8 = reduction.vaddv_s8;
pub const vaddv_s16 = reduction.vaddv_s16;
pub const vaddv_s32 = reduction.vaddv_s32;
pub const vaddv_u8 = reduction.vaddv_u8;
pub const vaddv_u16 = reduction.vaddv_u16;
pub const vaddv_u32 = reduction.vaddv_u32;
pub const vaddv_f32 = reduction.vaddv_f32;

pub const vaddvq_s8 = reduction.vaddvq_s8;
pub const vaddvq_s16 = reduction.vaddvq_s16;
pub const vaddvq_s32 = reduction.vaddvq_s32;
pub const vaddvq_s64 = reduction.vaddvq_s64;
pub const vaddvq_u8 = reduction.vaddvq_u8;
pub const vaddvq_u16 = reduction.vaddvq_u16;
pub const vaddvq_u32 = reduction.vaddvq_u32;
pub const vaddvq_u64 = reduction.vaddvq_u64;
pub const vaddvq_f32 = reduction.vaddvq_f32;
pub const vaddvq_f64 = reduction.vaddvq_f64;

pub const vaddlv_s8 = reduction.vaddlv_s8;
pub const vaddlv_s16 = reduction.vaddlv_s16;
pub const vaddlv_s32 = reduction.vaddlv_s32;
pub const vaddlv_u8 = reduction.vaddlv_u8;
pub const vaddlv_u16 = reduction.vaddlv_u16;
pub const vaddlv_u32 = reduction.vaddlv_u32;

pub const vaddlvq_s8 = reduction.vaddlvq_s8;
pub const vaddlvq_s16 = reduction.vaddlvq_s16;
pub const vaddlvq_s32 = reduction.vaddlvq_s32;
pub const vaddlvq_u8 = reduction.vaddlvq_u8;
pub const vaddlvq_u16 = reduction.vaddlvq_u16;
pub const vaddlvq_u32 = reduction.vaddlvq_u32;

pub const vminv_s8 = reduction.vminv_s8;
pub const vminv_s16 = reduction.vminv_s16;
pub const vminv_s32 = reduction.vminv_s32;
pub const vminv_u8 = reduction.vminv_u8;
pub const vminv_u16 = reduction.vminv_u16;
pub const vminv_u32 = reduction.vminv_u32;

pub const vminvq_s8 = reduction.vminvq_s8;
pub const vminvq_s16 = reduction.vminvq_s16;
pub const vminvq_s32 = reduction.vminvq_s32;
pub const vminvq_u8 = reduction.vminvq_u8;
pub const vminvq_u16 = reduction.vminvq_u16;
pub const vminvq_u32 = reduction.vminvq_u32;
pub const vminvq_f32 = reduction.vminvq_f32;
pub const vminvq_f64 = reduction.vminvq_f64;

pub const vmaxv_s8 = reduction.vmaxv_s8;
pub const vmaxv_s16 = reduction.vmaxv_s16;
pub const vmaxv_s32 = reduction.vmaxv_s32;
pub const vmaxv_u8 = reduction.vmaxv_u8;
pub const vmaxv_u16 = reduction.vmaxv_u16;
pub const vmaxv_u32 = reduction.vmaxv_u32;

pub const vmaxvq_s8 = reduction.vmaxvq_s8;
pub const vmaxvq_s16 = reduction.vmaxvq_s16;
pub const vmaxvq_s32 = reduction.vmaxvq_s32;
pub const vmaxvq_u8 = reduction.vmaxvq_u8;
pub const vmaxvq_u16 = reduction.vmaxvq_u16;
pub const vmaxvq_u32 = reduction.vmaxvq_u32;
pub const vmaxvq_f32 = reduction.vmaxvq_f32;
pub const vmaxvq_f64 = reduction.vmaxvq_f64;

pub const vmaxnmv_f32 = reduction.vmaxnmv_f32;
pub const vmaxnmvq_f32 = reduction.vmaxnmvq_f32;
pub const vminnmv_f32 = reduction.vminnmv_f32;
pub const vminnmvq_f32 = reduction.vminnmvq_f32;

// --- Convert Intrinsics ---
pub const vmovl_s8 = convert.vmovl_s8;
pub const vmovl_s16 = convert.vmovl_s16;
pub const vmovl_s32 = convert.vmovl_s32;
pub const vmovl_u8 = convert.vmovl_u8;
pub const vmovl_u16 = convert.vmovl_u16;
pub const vmovl_u32 = convert.vmovl_u32;

pub const vmovl_high_s8 = convert.vmovl_high_s8;
pub const vmovl_high_s16 = convert.vmovl_high_s16;
pub const vmovl_high_s32 = convert.vmovl_high_s32;
pub const vmovl_high_u8 = convert.vmovl_high_u8;
pub const vmovl_high_u16 = convert.vmovl_high_u16;
pub const vmovl_high_u32 = convert.vmovl_high_u32;

pub const vmovn_s16 = convert.vmovn_s16;
pub const vmovn_s32 = convert.vmovn_s32;
pub const vmovn_s64 = convert.vmovn_s64;
pub const vmovn_u16 = convert.vmovn_u16;
pub const vmovn_u32 = convert.vmovn_u32;
pub const vmovn_u64 = convert.vmovn_u64;

pub const vcvt_f32_s32 = convert.vcvt_f32_s32;
pub const vcvt_f32_u32 = convert.vcvt_f32_u32;
pub const vcvt_s32_f32 = convert.vcvt_s32_f32;
pub const vcvt_u32_f32 = convert.vcvt_u32_f32;
pub const vcvtq_f32_s32 = convert.vcvtq_f32_s32;
pub const vcvtq_f32_u32 = convert.vcvtq_f32_u32;
pub const vcvtq_s32_f32 = convert.vcvtq_s32_f32;
pub const vcvtq_u32_f32 = convert.vcvtq_u32_f32;
pub const vcvtq_f64_s64 = convert.vcvtq_f64_s64;
pub const vcvtq_f64_u64 = convert.vcvtq_f64_u64;
pub const vcvtq_s64_f64 = convert.vcvtq_s64_f64;
pub const vcvtq_u64_f64 = convert.vcvtq_u64_f64;

pub const vreinterpret_s8_u8 = convert.vreinterpret_s8_u8;
pub const vreinterpret_u8_s8 = convert.vreinterpret_u8_s8;
pub const vreinterpret_s16_u16 = convert.vreinterpret_s16_u16;
pub const vreinterpret_u16_s16 = convert.vreinterpret_u16_s16;
pub const vreinterpret_s32_u32 = convert.vreinterpret_s32_u32;
pub const vreinterpret_u32_s32 = convert.vreinterpret_u32_s32;
pub const vreinterpret_f32_s32 = convert.vreinterpret_f32_s32;
pub const vreinterpret_s32_f32 = convert.vreinterpret_s32_f32;
pub const vreinterpret_f32_u32 = convert.vreinterpret_f32_u32;
pub const vreinterpret_u32_f32 = convert.vreinterpret_u32_f32;

pub const vreinterpretq_s8_u8 = convert.vreinterpretq_s8_u8;
pub const vreinterpretq_u8_s8 = convert.vreinterpretq_u8_s8;
pub const vreinterpretq_s16_u16 = convert.vreinterpretq_s16_u16;
pub const vreinterpretq_u16_s16 = convert.vreinterpretq_u16_s16;
pub const vreinterpretq_s32_u32 = convert.vreinterpretq_s32_u32;
pub const vreinterpretq_u32_s32 = convert.vreinterpretq_u32_s32;
pub const vreinterpretq_s64_u64 = convert.vreinterpretq_s64_u64;
pub const vreinterpretq_u64_s64 = convert.vreinterpretq_u64_s64;
pub const vreinterpretq_f32_s32 = convert.vreinterpretq_f32_s32;
pub const vreinterpretq_s32_f32 = convert.vreinterpretq_s32_f32;
pub const vreinterpretq_f32_u32 = convert.vreinterpretq_f32_u32;
pub const vreinterpretq_u32_f32 = convert.vreinterpretq_u32_f32;
pub const vreinterpretq_f64_s64 = convert.vreinterpretq_f64_s64;
pub const vreinterpretq_s64_f64 = convert.vreinterpretq_s64_f64;
pub const vreinterpretq_f64_u64 = convert.vreinterpretq_f64_u64;
pub const vreinterpretq_u64_f64 = convert.vreinterpretq_u64_f64;

// --- Permute Intrinsics ---
pub const vget_low_s8 = permute.vget_low_s8;
pub const vget_low_s16 = permute.vget_low_s16;
pub const vget_low_s32 = permute.vget_low_s32;
pub const vget_low_s64 = permute.vget_low_s64;
pub const vget_low_u8 = permute.vget_low_u8;
pub const vget_low_u16 = permute.vget_low_u16;
pub const vget_low_u32 = permute.vget_low_u32;
pub const vget_low_u64 = permute.vget_low_u64;
pub const vget_low_f16 = permute.vget_low_f16;
pub const vget_low_f32 = permute.vget_low_f32;
pub const vget_low_f64 = permute.vget_low_f64;
pub const vget_low_p8 = permute.vget_low_p8;
pub const vget_low_p16 = permute.vget_low_p16;
pub const vget_low_p64 = permute.vget_low_p64;

pub const vget_high_s8 = permute.vget_high_s8;
pub const vget_high_s16 = permute.vget_high_s16;
pub const vget_high_s32 = permute.vget_high_s32;
pub const vget_high_s64 = permute.vget_high_s64;
pub const vget_high_u8 = permute.vget_high_u8;
pub const vget_high_u16 = permute.vget_high_u16;
pub const vget_high_u32 = permute.vget_high_u32;
pub const vget_high_u64 = permute.vget_high_u64;
pub const vget_high_f16 = permute.vget_high_f16;
pub const vget_high_f32 = permute.vget_high_f32;
pub const vget_high_f64 = permute.vget_high_f64;
pub const vget_high_p8 = permute.vget_high_p8;
pub const vget_high_p16 = permute.vget_high_p16;
pub const vget_high_p64 = permute.vget_high_p64;

pub const vcombine_s8 = permute.vcombine_s8;
pub const vcombine_s16 = permute.vcombine_s16;
pub const vcombine_s32 = permute.vcombine_s32;
pub const vcombine_s64 = permute.vcombine_s64;
pub const vcombine_u8 = permute.vcombine_u8;
pub const vcombine_u16 = permute.vcombine_u16;
pub const vcombine_u32 = permute.vcombine_u32;
pub const vcombine_u64 = permute.vcombine_u64;
pub const vcombine_f16 = permute.vcombine_f16;
pub const vcombine_f32 = permute.vcombine_f32;
pub const vcombine_f64 = permute.vcombine_f64;
pub const vcombine_p8 = permute.vcombine_p8;
pub const vcombine_p16 = permute.vcombine_p16;
pub const vcombine_p64 = permute.vcombine_p64;

pub const vget_lane_s8 = permute.vget_lane_s8;
pub const vget_lane_s16 = permute.vget_lane_s16;
pub const vget_lane_s32 = permute.vget_lane_s32;
pub const vget_lane_s64 = permute.vget_lane_s64;
pub const vget_lane_u8 = permute.vget_lane_u8;
pub const vget_lane_u16 = permute.vget_lane_u16;
pub const vget_lane_u32 = permute.vget_lane_u32;
pub const vget_lane_u64 = permute.vget_lane_u64;
pub const vget_lane_f16 = permute.vget_lane_f16;
pub const vget_lane_f32 = permute.vget_lane_f32;
pub const vget_lane_f64 = permute.vget_lane_f64;
pub const vget_lane_p8 = permute.vget_lane_p8;
pub const vget_lane_p16 = permute.vget_lane_p16;
pub const vget_lane_p64 = permute.vget_lane_p64;

pub const vgetq_lane_s8 = permute.vgetq_lane_s8;
pub const vgetq_lane_s16 = permute.vgetq_lane_s16;
pub const vgetq_lane_s32 = permute.vgetq_lane_s32;
pub const vgetq_lane_s64 = permute.vgetq_lane_s64;
pub const vgetq_lane_u8 = permute.vgetq_lane_u8;
pub const vgetq_lane_u16 = permute.vgetq_lane_u16;
pub const vgetq_lane_u32 = permute.vgetq_lane_u32;
pub const vgetq_lane_u64 = permute.vgetq_lane_u64;
pub const vgetq_lane_f16 = permute.vgetq_lane_f16;
pub const vgetq_lane_f32 = permute.vgetq_lane_f32;
pub const vgetq_lane_f64 = permute.vgetq_lane_f64;
pub const vgetq_lane_p8 = permute.vgetq_lane_p8;
pub const vgetq_lane_p16 = permute.vgetq_lane_p16;
pub const vgetq_lane_p64 = permute.vgetq_lane_p64;

pub const vset_lane_s8 = permute.vset_lane_s8;
pub const vset_lane_s16 = permute.vset_lane_s16;
pub const vset_lane_s32 = permute.vset_lane_s32;
pub const vset_lane_u8 = permute.vset_lane_u8;
pub const vset_lane_u16 = permute.vset_lane_u16;
pub const vset_lane_u32 = permute.vset_lane_u32;
pub const vset_lane_f32 = permute.vset_lane_f32;

pub const vsetq_lane_s8 = permute.vsetq_lane_s8;
pub const vsetq_lane_s16 = permute.vsetq_lane_s16;
pub const vsetq_lane_s32 = permute.vsetq_lane_s32;
pub const vsetq_lane_u8 = permute.vsetq_lane_u8;
pub const vsetq_lane_u16 = permute.vsetq_lane_u16;
pub const vsetq_lane_u32 = permute.vsetq_lane_u32;
pub const vsetq_lane_f32 = permute.vsetq_lane_f32;

pub const vdup_n_s8 = permute.vdup_n_s8;
pub const vdup_n_s16 = permute.vdup_n_s16;
pub const vdup_n_s32 = permute.vdup_n_s32;
pub const vdup_n_s64 = permute.vdup_n_s64;
pub const vdup_n_u8 = permute.vdup_n_u8;
pub const vdup_n_u16 = permute.vdup_n_u16;
pub const vdup_n_u32 = permute.vdup_n_u32;
pub const vdup_n_u64 = permute.vdup_n_u64;
pub const vdup_n_f16 = permute.vdup_n_f16;
pub const vdup_n_f32 = permute.vdup_n_f32;
pub const vdup_n_f64 = permute.vdup_n_f64;
pub const vdup_n_p8 = permute.vdup_n_p8;
pub const vdup_n_p16 = permute.vdup_n_p16;
pub const vdup_n_p64 = permute.vdup_n_p64;

pub const vdupq_n_s8 = permute.vdupq_n_s8;
pub const vdupq_n_s16 = permute.vdupq_n_s16;
pub const vdupq_n_s32 = permute.vdupq_n_s32;
pub const vdupq_n_s64 = permute.vdupq_n_s64;
pub const vdupq_n_u8 = permute.vdupq_n_u8;
pub const vdupq_n_u16 = permute.vdupq_n_u16;
pub const vdupq_n_u32 = permute.vdupq_n_u32;
pub const vdupq_n_u64 = permute.vdupq_n_u64;
pub const vdupq_n_f16 = permute.vdupq_n_f16;
pub const vdupq_n_f32 = permute.vdupq_n_f32;
pub const vdupq_n_f64 = permute.vdupq_n_f64;
pub const vdupq_n_p8 = permute.vdupq_n_p8;
pub const vdupq_n_p16 = permute.vdupq_n_p16;
pub const vdupq_n_p64 = permute.vdupq_n_p64;

pub const vmov_n_s8 = permute.vmov_n_s8;
pub const vmov_n_s16 = permute.vmov_n_s16;
pub const vmov_n_s32 = permute.vmov_n_s32;
pub const vmov_n_u8 = permute.vmov_n_u8;
pub const vmov_n_u16 = permute.vmov_n_u16;
pub const vmov_n_u32 = permute.vmov_n_u32;
pub const vmov_n_f32 = permute.vmov_n_f32;

pub const vmovq_n_s8 = permute.vmovq_n_s8;
pub const vmovq_n_s16 = permute.vmovq_n_s16;
pub const vmovq_n_s32 = permute.vmovq_n_s32;
pub const vmovq_n_s64 = permute.vmovq_n_s64;
pub const vmovq_n_u8 = permute.vmovq_n_u8;
pub const vmovq_n_u16 = permute.vmovq_n_u16;
pub const vmovq_n_u32 = permute.vmovq_n_u32;
pub const vmovq_n_u64 = permute.vmovq_n_u64;
pub const vmovq_n_f32 = permute.vmovq_n_f32;
pub const vmovq_n_f64 = permute.vmovq_n_f64;
pub const vmovq_n_p8 = permute.vmovq_n_p8;
pub const vmovq_n_p16 = permute.vmovq_n_p16;
pub const vmovq_n_p64 = permute.vmovq_n_p64;

pub const vzip1_u8 = permute.vzip1_u8;
pub const vzip2_u8 = permute.vzip2_u8;
pub const vzip1_s8 = permute.vzip1_s8;
pub const vzip2_s8 = permute.vzip2_s8;
pub const vzip1_u16 = permute.vzip1_u16;
pub const vzip2_u16 = permute.vzip2_u16;
pub const vzip1_s16 = permute.vzip1_s16;
pub const vzip2_s16 = permute.vzip2_s16;
pub const vzip1_u32 = permute.vzip1_u32;
pub const vzip2_u32 = permute.vzip2_u32;
pub const vzip1_s32 = permute.vzip1_s32;
pub const vzip2_s32 = permute.vzip2_s32;
pub const vzip1_f32 = permute.vzip1_f32;
pub const vzip2_f32 = permute.vzip2_f32;

pub const vzip1q_u8 = permute.vzip1q_u8;
pub const vzip2q_u8 = permute.vzip2q_u8;
pub const vzip1q_s8 = permute.vzip1q_s8;
pub const vzip2q_s8 = permute.vzip2q_s8;
pub const vzip1q_u16 = permute.vzip1q_u16;
pub const vzip2q_u16 = permute.vzip2q_u16;
pub const vzip1q_s16 = permute.vzip1q_s16;
pub const vzip2q_s16 = permute.vzip2q_s16;
pub const vzip1q_u32 = permute.vzip1q_u32;
pub const vzip2q_u32 = permute.vzip2q_u32;
pub const vzip1q_s32 = permute.vzip1q_s32;
pub const vzip2q_s32 = permute.vzip2q_s32;
pub const vzip1q_f32 = permute.vzip1q_f32;
pub const vzip2q_f32 = permute.vzip2q_f32;
pub const vzip1q_u64 = permute.vzip1q_u64;
pub const vzip2q_u64 = permute.vzip2q_u64;
pub const vzip1q_s64 = permute.vzip1q_s64;
pub const vzip2q_s64 = permute.vzip2q_s64;
pub const vzip1q_f64 = permute.vzip1q_f64;
pub const vzip2q_f64 = permute.vzip2q_f64;

pub const vzipq_u8 = permute.vzipq_u8;
pub const vzipq_s8 = permute.vzipq_s8;
pub const vzipq_u16 = permute.vzipq_u16;
pub const vzipq_s16 = permute.vzipq_s16;
pub const vzipq_u32 = permute.vzipq_u32;
pub const vzipq_s32 = permute.vzipq_s32;
pub const vzipq_u64 = permute.vzipq_u64;
pub const vzipq_s64 = permute.vzipq_s64;

pub const vtrn1q_s8 = permute.vtrn1q_s8;
pub const vtrn2q_s8 = permute.vtrn2q_s8;
pub const vtrn1q_u8 = permute.vtrn1q_u8;
pub const vtrn2q_u8 = permute.vtrn2q_u8;
pub const vtrn1q_f32 = permute.vtrn1q_f32;
pub const vtrn2q_f32 = permute.vtrn2q_f32;
pub const vtrnq_f32 = permute.vtrnq_f32;
pub const vtrnq_s8 = permute.vtrnq_s8;
pub const vtrnq_u8 = permute.vtrnq_u8;

pub const vrev64q_s8 = permute.vrev64q_s8;
pub const vrev64q_u8 = permute.vrev64q_u8;
pub const vrev64q_s16 = permute.vrev64q_s16;
pub const vrev64q_u16 = permute.vrev64q_u16;
pub const vrev64q_s32 = permute.vrev64q_s32;
pub const vrev64q_u32 = permute.vrev64q_u32;
pub const vrev64q_f32 = permute.vrev64q_f32;

pub const vqtbl1q_u8 = permute.vqtbl1q_u8;
pub const vqtbl1q_s8 = permute.vqtbl1q_s8;
pub const vqtbl1q_p8 = permute.vqtbl1q_p8;

// --- Crypto Intrinsics ---
pub const vaeseq_u8 = crypto.vaeseq_u8;
pub const vaesdq_u8 = crypto.vaesdq_u8;
pub const vaesmcq_u8 = crypto.vaesmcq_u8;
pub const vaesimcq_u8 = crypto.vaesimcq_u8;
pub const vmull_p8 = crypto.vmull_p8;
pub const vmull_p64 = crypto.vmull_p64;

test {
    _ = @import("types.zig");
    _ = @import("common.zig");
    _ = @import("arch/arm.zig");
    _ = @import("arch/aarch64.zig");
    _ = @import("intrinsics/load_store.zig");
    _ = @import("intrinsics/arithmetic.zig");
    _ = @import("intrinsics/bitwise.zig");
    _ = @import("intrinsics/shift.zig");
    _ = @import("intrinsics/compare.zig");
    _ = @import("intrinsics/reduction.zig");
    _ = @import("intrinsics/convert.zig");
    _ = @import("intrinsics/permute.zig");
    _ = @import("intrinsics/crypto.zig");
}