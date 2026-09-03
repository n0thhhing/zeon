pub const p8 = u8;
pub const p16 = u16;
pub const p64 = u64;
pub const p128 = u128;

pub const i8x8 = @Vector(8, i8);
pub const i8x16 = @Vector(16, i8);
pub const i16x4 = @Vector(4, i16);
pub const i16x8 = @Vector(8, i16);
pub const i32x2 = @Vector(2, i32);
pub const i32x4 = @Vector(4, i32);
pub const i64x1 = @Vector(1, i64);
pub const i64x2 = @Vector(2, i64);

pub const u8x8 = @Vector(8, u8);
pub const u8x16 = @Vector(16, u8);
pub const u16x4 = @Vector(4, u16);
pub const u16x8 = @Vector(8, u16);
pub const u32x2 = @Vector(2, u32);
pub const u32x4 = @Vector(4, u32);
pub const u64x1 = @Vector(1, u64);
pub const u64x2 = @Vector(2, u64);

pub const f16x4 = @Vector(4, f16);
pub const f16x8 = @Vector(8, f16);
pub const f32x2 = @Vector(2, f32);
pub const f32x4 = @Vector(4, f32);
pub const f64x1 = @Vector(1, f64);
pub const f64x2 = @Vector(2, f64);

pub const p8x8 = @Vector(8, p8);
pub const p8x16 = @Vector(16, p8);
pub const p16x4 = @Vector(4, p16);
pub const p16x8 = @Vector(8, p16);
pub const p64x1 = @Vector(1, p64);
pub const p64x2 = @Vector(2, p64);

pub const i8x8x2 = struct { i8x8, i8x8 };
pub const i8x16x2 = struct { i8x16, i8x16 };
pub const i16x4x2 = struct { i16x4, i16x4 };
pub const i16x8x2 = struct { i16x8, i16x8 };
pub const i32x2x2 = struct { i32x2, i32x2 };
pub const i32x4x2 = struct { i32x4, i32x4 };
pub const i64x1x2 = struct { i64x1, i64x1 };
pub const i64x2x2 = struct { i64x2, i64x2 };

pub const u8x8x2 = struct { u8x8, u8x8 };
pub const u8x16x2 = struct { u8x16, u8x16 };
pub const u16x4x2 = struct { u16x4, u16x4 };
pub const u16x8x2 = struct { u16x8, u16x8 };
pub const u32x2x2 = struct { u32x2, u32x2 };
pub const u32x4x2 = struct { u32x4, u32x4 };
pub const u64x1x2 = struct { u64x1, u64x1 };
pub const u64x2x2 = struct { u64x2, u64x2 };

pub const f16x4x2 = struct { f16x4, f16x4 };
pub const f16x8x2 = struct { f16x8, f16x8 };
pub const f32x2x2 = struct { f32x2, f32x2 };
pub const f32x4x2 = struct { f32x4, f32x4 };
pub const f64x1x2 = struct { f64x1, f64x1 };
pub const f64x2x2 = struct { f64x2, f64x2 };

pub const p8x8x2 = struct { p8x8, p8x8 };
pub const p8x16x2 = struct { p8x16, p8x16 };
pub const p16x4x2 = struct { p16x4, p16x4 };
pub const p16x8x2 = struct { p16x8, p16x8 };
pub const p64x1x2 = struct { p64x1, p64x1 };
pub const p64x2x2 = struct { p64x2, p64x2 };

pub const i8x8x3 = struct { i8x8, i8x8, i8x8 };
pub const i8x16x3 = struct { i8x16, i8x16, i8x16 };
pub const i16x4x3 = struct { i16x4, i16x4, i16x4 };
pub const i16x8x3 = struct { i16x8, i16x8, i16x8 };
pub const i32x2x3 = struct { i32x2, i32x2, i32x2 };
pub const i32x4x3 = struct { i32x4, i32x4, i32x4 };
pub const i64x1x3 = struct { i64x1, i64x1, i64x1 };
pub const i64x2x3 = struct { i64x2, i64x2, i64x2 };

pub const u8x8x3 = struct { u8x8, u8x8, u8x8 };
pub const u8x16x3 = struct { u8x16, u8x16, u8x16 };
pub const u16x4x3 = struct { u16x4, u16x4, u16x4 };
pub const u16x8x3 = struct { u16x8, u16x8, u16x8 };
pub const u32x2x3 = struct { u32x2, u32x2, u32x2 };
pub const u32x4x3 = struct { u32x4, u32x4, u32x4 };
pub const u64x1x3 = struct { u64x1, u64x1, u64x1 };
pub const u64x2x3 = struct { u64x2, u64x2, u64x2 };

pub const f16x4x3 = struct { f16x4, f16x4, f16x4 };
pub const f16x8x3 = struct { f16x8, f16x8, f16x8 };
pub const f32x2x3 = struct { f32x2, f32x2, f32x2 };
pub const f32x4x3 = struct { f32x4, f32x4, f32x4 };
pub const f64x1x3 = struct { f64x1, f64x1, f64x1 };
pub const f64x2x3 = struct { f64x2, f64x2, f64x2 };

pub const p8x8x3 = struct { p8x8, p8x8, p8x8 };
pub const p8x16x3 = struct { p8x16, p8x16, p8x16 };
pub const p16x4x3 = struct { p16x4, p16x4, p16x4 };
pub const p16x8x3 = struct { p16x8, p16x8, p16x8 };
pub const p64x1x3 = struct { p64x1, p64x1, p64x1 };
pub const p64x2x3 = struct { p64x2, p64x2, p64x2 };

pub const i8x8x4 = struct { i8x8, i8x8, i8x8, i8x8 };
pub const i8x16x4 = struct { i8x16, i8x16, i8x16, i8x16 };
pub const i16x4x4 = struct { i16x4, i16x4, i16x4, i16x4 };
pub const i16x8x4 = struct { i16x8, i16x8, i16x8, i16x8 };
pub const i32x2x4 = struct { i32x2, i32x2, i32x2, i32x2 };
pub const i32x4x4 = struct { i32x4, i32x4, i32x4, i32x4 };
pub const i64x1x4 = struct { i64x1, i64x1, i64x1, i64x1 };
pub const i64x2x4 = struct { i64x2, i64x2, i64x2, i64x2 };

pub const u8x8x4 = struct { u8x8, u8x8, u8x8, u8x8 };
pub const u8x16x4 = struct { u8x16, u8x16, u8x16, u8x16 };
pub const u16x4x4 = struct { u16x4, u16x4, u16x4, u16x4 };
pub const u16x8x4 = struct { u16x8, u16x8, u16x8, u16x8 };
pub const u32x2x4 = struct { u32x2, u32x2, u32x2, u32x2 };
pub const u32x4x4 = struct { u32x4, u32x4, u32x4, u32x4 };
pub const u64x1x4 = struct { u64x1, u64x1, u64x1, u64x1 };
pub const u64x2x4 = struct { u64x2, u64x2, u64x2, u64x2 };

pub const f16x4x4 = struct { f16x4, f16x4, f16x4, f16x4 };
pub const f16x8x4 = struct { f16x8, f16x8, f16x8, f16x8 };
pub const f32x2x4 = struct { f32x2, f32x2, f32x2, f32x2 };
pub const f32x4x4 = struct { f32x4, f32x4, f32x4, f32x4 };
pub const f64x1x4 = struct { f64x1, f64x1, f64x1, f64x1 };
pub const f64x2x4 = struct { f64x2, f64x2, f64x2, f64x2 };

pub const p8x8x4 = struct { p8x8, p8x8, p8x8, p8x8 };
pub const p8x16x4 = struct { p8x16, p8x16, p8x16, p8x16 };
pub const p16x4x4 = struct { p16x4, p16x4, p16x4, p16x4 };
pub const p16x8x4 = struct { p16x8, p16x8, p16x8, p16x8 };
pub const p64x1x4 = struct { p64x1, p64x1, p64x1, p64x1 };
pub const p64x2x4 = struct { p64x2, p64x2, p64x2, p64x2 };

pub const poly8 = p8;
pub const poly16 = p16;
pub const poly64 = p64;
pub const poly128 = p128;

pub const int8x8 = u8x8;
pub const int8x16 = u8x16;
pub const int16x4 = u16x4;
pub const int16x8 = u16x8;
pub const int32x2 = u32x2;
pub const int32x4 = u32x4;
pub const int64x1 = u64x1;
pub const int64x2 = u64x2;

pub const uint8x8 = u8x8;
pub const uint8x16 = u8x16;
pub const uint16x4 = u16x4;
pub const uint16x8 = u16x8;
pub const uint32x2 = u32x2;
pub const uint32x4 = u32x4;
pub const uint64x1 = u64x1;
pub const uint64x2 = u64x2;

pub const float16x4 = f16x4;
pub const float16x8 = f16x8;
pub const float32x2 = f32x2;
pub const float32x4 = f32x4;
pub const float64x1 = f64x1;
pub const float64x2 = f64x2;

pub const poly8x8 = p8x8;
pub const poly8x16 = p8x16;
pub const poly16x4 = p16x4;
pub const poly16x8 = p16x8;
pub const poly64x1 = p64x1;
pub const poly64x2 = p64x2;

pub const int8x8x2 = u8x8x2;
pub const int8x16x2 = u8x16x2;
pub const int16x4x2 = u16x4x2;
pub const int16x8x2 = u16x8x2;
pub const int32x2x2 = u32x2x2;
pub const int32x4x2 = u32x4x2;
pub const int64x1x2 = u64x1x2;
pub const int64x2x2 = u64x2x2;

pub const uint8x8x2 = u8x8x2;
pub const uint8x16x2 = u8x16x2;
pub const uint16x4x2 = u16x4x2;
pub const uint16x8x2 = u16x8x2;
pub const uint32x2x2 = u32x2x2;
pub const uint32x4x2 = u32x4x2;
pub const uint64x1x2 = u64x1x2;
pub const uint64x2x2 = u64x2x2;

pub const float16x4x2 = f16x4x2;
pub const float16x8x2 = f16x8x2;
pub const float32x2x2 = f32x2x2;
pub const float32x4x2 = f32x4x2;
pub const float64x1x2 = f64x1x2;
pub const float64x2x2 = f64x2x2;

pub const poly8x8x2 = p8x8x2;
pub const poly8x16x2 = p8x16x2;
pub const poly16x4x2 = p16x4x2;
pub const poly16x8x2 = p16x8x2;
pub const poly64x1x2 = p64x1x2;
pub const poly64x2x2 = p64x2x2;

pub const int8x8x3 = u8x8x3;
pub const int8x16x3 = u8x16x3;
pub const int16x4x3 = u16x4x3;
pub const int16x8x3 = u16x8x3;
pub const int32x2x3 = u32x2x3;
pub const int32x4x3 = u32x4x3;
pub const int64x1x3 = u64x1x3;
pub const int64x2x3 = u64x2x3;

pub const uint8x8x3 = u8x8x3;
pub const uint8x16x3 = u8x16x3;
pub const uint16x4x3 = u16x4x3;
pub const uint16x8x3 = u16x8x3;
pub const uint32x2x3 = u32x2x3;
pub const uint32x4x3 = u32x4x3;
pub const uint64x1x3 = u64x1x3;
pub const uint64x2x3 = u64x2x3;

pub const float16x4x3 = f16x4x3;
pub const float16x8x3 = f16x8x3;
pub const float32x2x3 = f32x2x3;
pub const float32x4x3 = f32x4x3;
pub const float64x1x3 = f64x1x3;
pub const float64x2x3 = f64x2x3;

pub const poly8x8x3 = p8x8x3;
pub const poly8x16x3 = p8x16x3;
pub const poly16x4x3 = p16x4x3;
pub const poly16x8x3 = p16x8x3;
pub const poly64x1x3 = p64x1x3;
pub const poly64x2x3 = p64x2x3;

pub const int8x8x4 = u8x8x4;
pub const int8x16x4 = u8x16x4;
pub const int16x4x4 = u16x4x4;
pub const int16x8x4 = u16x8x4;
pub const int32x2x4 = u32x2x4;
pub const int32x4x4 = u32x4x4;
pub const int64x1x4 = u64x1x4;
pub const int64x2x4 = u64x2x4;

pub const uint8x8x4 = u8x8x4;
pub const uint8x16x4 = u8x16x4;
pub const uint16x4x4 = u16x4x4;
pub const uint16x8x4 = u16x8x4;
pub const uint32x2x4 = u32x2x4;
pub const uint32x4x4 = u32x4x4;
pub const uint64x1x4 = u64x1x4;
pub const uint64x2x4 = u64x2x4;

pub const float16x4x4 = f16x4x4;
pub const float16x8x4 = f16x8x4;
pub const float32x2x4 = f32x2x4;
pub const float32x4x4 = f32x4x4;
pub const float64x1x4 = f64x1x4;
pub const float64x2x4 = f64x2x4;

pub const poly8x8x4 = p8x8x4;
pub const poly8x16x4 = p8x16x4;
pub const poly16x4x4 = p16x4x4;
pub const poly16x8x4 = p16x8x4;
pub const poly64x1x4 = p64x1x4;
pub const poly64x2x4 = p64x2x4;

pub const poly8_t = p8;
pub const poly16_t = p16;
pub const poly64_t = p64;
pub const poly128_t = p128;

pub const int8x8_t = u8x8;
pub const int8x16_t = u8x16;
pub const int16x4_t = u16x4;
pub const int16x8_t = u16x8;
pub const int32x2_t = u32x2;
pub const int32x4_t = u32x4;
pub const int64x1_t = u64x1;
pub const int64x2_t = u64x2;

pub const uint8x8_t = u8x8;
pub const uint8x16_t = u8x16;
pub const uint16x4_t = u16x4;
pub const uint16x8_t = u16x8;
pub const uint32x2_t = u32x2;
pub const uint32x4_t = u32x4;
pub const uint64x1_t = u64x1;
pub const uint64x2_t = u64x2;

pub const float16x4_t = f16x4;
pub const float16x8_t = f16x8;
pub const float32x2_t = f32x2;
pub const float32x4_t = f32x4;
pub const float64x1_t = f64x1;
pub const float64x2_t = f64x2;

pub const poly8x8_t = p8x8;
pub const poly8x16_t = p8x16;
pub const poly16x4_t = p16x4;
pub const poly16x8_t = p16x8;
pub const poly64x1_t = p64x1;
pub const poly64x2_t = p64x2;

pub const int8x8x2_t = u8x8x2;
pub const int8x16x2_t = u8x16x2;
pub const int16x4x2_t = u16x4x2;
pub const int16x8x2_t = u16x8x2;
pub const int32x2x2_t = u32x2x2;
pub const int32x4x2_t = u32x4x2;
pub const int64x1x2_t = u64x1x2;
pub const int64x2x2_t = u64x2x2;

pub const uint8x8x2_t = u8x8x2;
pub const uint8x16x2_t = u8x16x2;
pub const uint16x4x2_t = u16x4x2;
pub const uint16x8x2_t = u16x8x2;
pub const uint32x2x2_t = u32x2x2;
pub const uint32x4x2_t = u32x4x2;
pub const uint64x1x2_t = u64x1x2;
pub const uint64x2x2_t = u64x2x2;

pub const float16x4x2_t = f16x4x2;
pub const float16x8x2_t = f16x8x2;
pub const float32x2x2_t = f32x2x2;
pub const float32x4x2_t = f32x4x2;
pub const float64x1x2_t = f64x1x2;
pub const float64x2x2_t = f64x2x2;

pub const poly8x8x2_t = p8x8x2;
pub const poly8x16x2_t = p8x16x2;
pub const poly16x4x2_t = p16x4x2;
pub const poly16x8x2_t = p16x8x2;
pub const poly64x1x2_t = p64x1x2;
pub const poly64x2x2_t = p64x2x2;

pub const int8x8x3_t = u8x8x3;
pub const int8x16x3_t = u8x16x3;
pub const int16x4x3_t = u16x4x3;
pub const int16x8x3_t = u16x8x3;
pub const int32x2x3_t = u32x2x3;
pub const int32x4x3_t = u32x4x3;
pub const int64x1x3_t = u64x1x3;
pub const int64x2x3_t = u64x2x3;

pub const uint8x8x3_t = u8x8x3;
pub const uint8x16x3_t = u8x16x3;
pub const uint16x4x3_t = u16x4x3;
pub const uint16x8x3_t = u16x8x3;
pub const uint32x2x3_t = u32x2x3;
pub const uint32x4x3_t = u32x4x3;
pub const uint64x1x3_t = u64x1x3;
pub const uint64x2x3_t = u64x2x3;

pub const float16x4x3_t = f16x4x3;
pub const float16x8x3_t = f16x8x3;
pub const float32x2x3_t = f32x2x3;
pub const float32x4x3_t = f32x4x3;
pub const float64x1x3_t = f64x1x3;
pub const float64x2x3_t = f64x2x3;

pub const poly8x8x3_t = p8x8x3;
pub const poly8x16x3_t = p8x16x3;
pub const poly16x4x3_t = p16x4x3;
pub const poly16x8x3_t = p16x8x3;
pub const poly64x1x3_t = p64x1x3;
pub const poly64x2x3_t = p64x2x3;

pub const int8x8x4_t = u8x8x4;
pub const int8x16x4_t = u8x16x4;
pub const int16x4x4_t = u16x4x4;
pub const int16x8x4_t = u16x8x4;
pub const int32x2x4_t = u32x2x4;
pub const int32x4x4_t = u32x4x4;
pub const int64x1x4_t = u64x1x4;
pub const int64x2x4_t = u64x2x4;

pub const uint8x8x4_t = u8x8x4;
pub const uint8x16x4_t = u8x16x4;
pub const uint16x4x4_t = u16x4x4;
pub const uint16x8x4_t = u16x8x4;
pub const uint32x2x4_t = u32x2x4;
pub const uint32x4x4_t = u32x4x4;
pub const uint64x1x4_t = u64x1x4;
pub const uint64x2x4_t = u64x2x4;

pub const float16x4x4_t = f16x4x4;
pub const float16x8x4_t = f16x8x4;
pub const float32x2x4_t = f32x2x4;
pub const float32x4x4_t = f32x4x4;
pub const float64x1x4_t = f64x1x4;
pub const float64x2x4_t = f64x2x4;

pub const poly8x8x4_t = p8x8x4;
pub const poly8x16x4_t = p8x16x4;
pub const poly16x4x4_t = p16x4x4;
pub const poly16x8x4_t = p16x8x4;
pub const poly64x1x4_t = p64x1x4;
pub const poly64x2x4_t = p64x2x4;

pub const v8i8 = u8x8;
pub const v16i8 = u8x16;
pub const v4i16 = u16x4;
pub const v8i16 = u16x8;
pub const v2i32 = u32x2;
pub const v4i32 = u32x4;
pub const v1i64 = u64x1;
pub const v2i64 = u64x2;

pub const v8u8 = u8x8;
pub const v16u8 = u8x16;
pub const v4u16 = u16x4;
pub const v8u16 = u16x8;
pub const v2u32 = u32x2;
pub const v4u32 = u32x4;
pub const v1u64 = u64x1;
pub const v2u64 = u64x2;

pub const v4f16 = f16x4;
pub const v8f16 = f16x8;
pub const v2f32 = f32x2;
pub const v4f32 = f32x4;
pub const v1f64 = f64x1;
pub const v2f64 = f64x2;

pub const v8p8 = p8x8;
pub const v16p8 = p8x16;
pub const v4p16 = p16x4;
pub const v8p16 = p16x8;
pub const v1p64 = p64x1;
pub const v2p64 = p64x2;
