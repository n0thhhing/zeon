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

const f32x2 = types.f32x2;
const f32x4 = types.f32x4;
const f64x2 = types.f64x2;

// --- Vector Add Across Lanes (VADDV / VADDVQ) ---
pub inline fn vaddv_s8(a: i8x8) i8 { return @reduce(.Add, a); }
pub inline fn vaddv_s16(a: i16x4) i16 { return @reduce(.Add, a); }
pub inline fn vaddv_s32(a: i32x2) i32 { return @reduce(.Add, a); }
pub inline fn vaddv_u8(a: u8x8) u8 { return @reduce(.Add, a); }
pub inline fn vaddv_u16(a: u16x4) u16 { return @reduce(.Add, a); }
pub inline fn vaddv_u32(a: u32x2) u32 { return @reduce(.Add, a); }
pub inline fn vaddv_f32(a: f32x2) f32 { return @reduce(.Add, a); }

pub inline fn vaddvq_s8(a: i8x16) i8 { return @reduce(.Add, a); }
pub inline fn vaddvq_s16(a: i16x8) i16 { return @reduce(.Add, a); }
pub inline fn vaddvq_s32(a: i32x4) i32 { return @reduce(.Add, a); }
pub inline fn vaddvq_s64(a: i64x2) i64 { return @reduce(.Add, a); }
pub inline fn vaddvq_u8(a: u8x16) u8 { return @reduce(.Add, a); }
pub inline fn vaddvq_u16(a: u16x8) u16 { return @reduce(.Add, a); }
pub inline fn vaddvq_u32(a: u32x4) u32 { return @reduce(.Add, a); }
pub inline fn vaddvq_u64(a: u64x2) u64 { return @reduce(.Add, a); }
pub inline fn vaddvq_f32(a: f32x4) f32 { return @reduce(.Add, a); }
pub inline fn vaddvq_f64(a: f64x2) f64 { return @reduce(.Add, a); }

// --- Vector Long Add Across Lanes (VADDLV / VADDLVQ: Widen and Sum) ---
pub inline fn vaddlv_s8(a: i8x8) i16 {
    const a16: i16x8 = a;
    return @reduce(.Add, a16);
}
pub inline fn vaddlv_s16(a: i16x4) i32 {
    const a32: i32x4 = a;
    return @reduce(.Add, a32);
}
pub inline fn vaddlv_s32(a: i32x2) i64 {
    const a64: i64x2 = a;
    return @reduce(.Add, a64);
}
pub inline fn vaddlv_u8(a: u8x8) u16 {
    const a16: u16x8 = a;
    return @reduce(.Add, a16);
}
pub inline fn vaddlv_u16(a: u16x4) u32 {
    const a32: u32x4 = a;
    return @reduce(.Add, a32);
}
pub inline fn vaddlv_u32(a: u32x2) u64 {
    const a64: u64x2 = a;
    return @reduce(.Add, a64);
}

pub inline fn vaddlvq_s8(a: i8x16) i16 {
    const a16: @Vector(16, i16) = a;
    return @reduce(.Add, a16);
}
pub inline fn vaddlvq_s16(a: i16x8) i32 {
    const a32: @Vector(8, i32) = a;
    return @reduce(.Add, a32);
}
pub inline fn vaddlvq_s32(a: i32x4) i64 {
    const a64: @Vector(4, i64) = a;
    return @reduce(.Add, a64);
}
pub inline fn vaddlvq_u8(a: u8x16) u16 {
    const a16: @Vector(16, u16) = a;
    return @reduce(.Add, a16);
}
pub inline fn vaddlvq_u16(a: u16x8) u32 {
    const a32: @Vector(8, u32) = a;
    return @reduce(.Add, a32);
}
pub inline fn vaddlvq_u32(a: u32x4) u64 {
    const a64: @Vector(4, u64) = a;
    return @reduce(.Add, a64);
}

// --- Vector Min Across Lanes (VMINV / VMINVQ) ---
pub inline fn vminv_s8(a: i8x8) i8 { return @reduce(.Min, a); }
pub inline fn vminv_s16(a: i16x4) i16 { return @reduce(.Min, a); }
pub inline fn vminv_s32(a: i32x2) i32 { return @reduce(.Min, a); }
pub inline fn vminv_u8(a: u8x8) u8 { return @reduce(.Min, a); }
pub inline fn vminv_u16(a: u16x4) u16 { return @reduce(.Min, a); }
pub inline fn vminv_u32(a: u32x2) u32 { return @reduce(.Min, a); }

pub inline fn vminvq_s8(a: i8x16) i8 { return @reduce(.Min, a); }
pub inline fn vminvq_s16(a: i16x8) i16 { return @reduce(.Min, a); }
pub inline fn vminvq_s32(a: i32x4) i32 { return @reduce(.Min, a); }
pub inline fn vminvq_u8(a: u8x16) u8 { return @reduce(.Min, a); }
pub inline fn vminvq_u16(a: u16x8) u16 { return @reduce(.Min, a); }
pub inline fn vminvq_u32(a: u32x4) u32 { return @reduce(.Min, a); }
pub inline fn vminvq_f32(a: f32x4) f32 { return @reduce(.Min, a); }
pub inline fn vminvq_f64(a: f64x2) f64 { return @reduce(.Min, a); }

// --- Vector Max Across Lanes (VMAXV / VMAXVQ) ---
pub inline fn vmaxv_s8(a: i8x8) i8 { return @reduce(.Max, a); }
pub inline fn vmaxv_s16(a: i16x4) i16 { return @reduce(.Max, a); }
pub inline fn vmaxv_s32(a: i32x2) i32 { return @reduce(.Max, a); }
pub inline fn vmaxv_u8(a: u8x8) u8 { return @reduce(.Max, a); }
pub inline fn vmaxv_u16(a: u16x4) u16 { return @reduce(.Max, a); }
pub inline fn vmaxv_u32(a: u32x2) u32 { return @reduce(.Max, a); }

pub inline fn vmaxvq_s8(a: i8x16) i8 { return @reduce(.Max, a); }
pub inline fn vmaxvq_s16(a: i16x8) i16 { return @reduce(.Max, a); }
pub inline fn vmaxvq_s32(a: i32x4) i32 { return @reduce(.Max, a); }
pub inline fn vmaxvq_u8(a: u8x16) u8 { return @reduce(.Max, a); }
pub inline fn vmaxvq_u16(a: u16x8) u16 { return @reduce(.Max, a); }
pub inline fn vmaxvq_u32(a: u32x4) u32 { return @reduce(.Max, a); }
pub inline fn vmaxvq_f32(a: f32x4) f32 { return @reduce(.Max, a); }
pub inline fn vmaxvq_f64(a: f64x2) f64 { return @reduce(.Max, a); }

pub inline fn vmaxnmv_f32(a: f32x2) f32 { return @reduce(.Max, a); }
pub inline fn vmaxnmvq_f32(a: f32x4) f32 { return @reduce(.Max, a); }
pub inline fn vminnmv_f32(a: f32x2) f32 { return @reduce(.Min, a); }
pub inline fn vminnmvq_f32(a: f32x4) f32 { return @reduce(.Min, a); }

test "reduction intrinsics" {
    const a: i32x4 = .{ 10, 20, 30, 40 };
    try std.testing.expectEqual(@as(i32, 100), vaddvq_s32(a));
    try std.testing.expectEqual(@as(i32, 10), vminvq_s32(a));
    try std.testing.expectEqual(@as(i32, 40), vmaxvq_s32(a));
}
