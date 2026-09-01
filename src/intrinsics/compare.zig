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

// Helper to convert boolean vector to bitmask vector (all 1s for true, 0 for false)
inline fn boolToMask(comptime Out: type, pred: anytype) Out {
    const len = common.vecLen(Out);
    const Child = std.meta.Child(Out);
    const all_ones = std.math.maxInt(Child);
    var res: Out = undefined;
    inline for (0..len) |i| {
        res[i] = if (pred[i]) all_ones else 0;
    }
    return res;
}

// --- Vector Equality (VCEQ / VCEQQ) ---
pub inline fn vceq_s8(a: i8x8, b: i8x8) u8x8 { return boolToMask(u8x8, a == b); }
pub inline fn vceq_s16(a: i16x4, b: i16x4) u16x4 { return boolToMask(u16x4, a == b); }
pub inline fn vceq_s32(a: i32x2, b: i32x2) u32x2 { return boolToMask(u32x2, a == b); }
pub inline fn vceq_u8(a: u8x8, b: u8x8) u8x8 { return boolToMask(u8x8, a == b); }
pub inline fn vceq_u16(a: u16x4, b: u16x4) u16x4 { return boolToMask(u16x4, a == b); }
pub inline fn vceq_u32(a: u32x2, b: u32x2) u32x2 { return boolToMask(u32x2, a == b); }
pub inline fn vceq_f32(a: f32x2, b: f32x2) u32x2 { return boolToMask(u32x2, a == b); }

pub inline fn vceqq_s8(a: i8x16, b: i8x16) u8x16 { return boolToMask(u8x16, a == b); }
pub inline fn vceqq_s16(a: i16x8, b: i16x8) u16x8 { return boolToMask(u16x8, a == b); }
pub inline fn vceqq_s32(a: i32x4, b: i32x4) u32x4 { return boolToMask(u32x4, a == b); }
pub inline fn vceqq_u8(a: u8x16, b: u8x16) u8x16 { return boolToMask(u8x16, a == b); }
pub inline fn vceqq_u16(a: u16x8, b: u16x8) u16x8 { return boolToMask(u16x8, a == b); }
pub inline fn vceqq_u32(a: u32x4, b: u32x4) u32x4 { return boolToMask(u32x4, a == b); }
pub inline fn vceqq_f32(a: f32x4, b: f32x4) u32x4 { return boolToMask(u32x4, a == b); }
pub inline fn vceqq_f64(a: f64x2, b: f64x2) u64x2 { return boolToMask(u64x2, a == b); }

// --- Vector Greater Than or Equal (VCGE / VCGEQ) ---
pub inline fn vcge_s8(a: i8x8, b: i8x8) u8x8 { return boolToMask(u8x8, a >= b); }
pub inline fn vcge_s16(a: i16x4, b: i16x4) u16x4 { return boolToMask(u16x4, a >= b); }
pub inline fn vcge_s32(a: i32x2, b: i32x2) u32x2 { return boolToMask(u32x2, a >= b); }
pub inline fn vcge_u8(a: u8x8, b: u8x8) u8x8 { return boolToMask(u8x8, a >= b); }
pub inline fn vcge_u16(a: u16x4, b: u16x4) u16x4 { return boolToMask(u16x4, a >= b); }
pub inline fn vcge_u32(a: u32x2, b: u32x2) u32x2 { return boolToMask(u32x2, a >= b); }
pub inline fn vcge_f32(a: f32x2, b: f32x2) u32x2 { return boolToMask(u32x2, a >= b); }

pub inline fn vcgeq_s8(a: i8x16, b: i8x16) u8x16 { return boolToMask(u8x16, a >= b); }
pub inline fn vcgeq_s16(a: i16x8, b: i16x8) u16x8 { return boolToMask(u16x8, a >= b); }
pub inline fn vcgeq_s32(a: i32x4, b: i32x4) u32x4 { return boolToMask(u32x4, a >= b); }
pub inline fn vcgeq_u8(a: u8x16, b: u8x16) u8x16 { return boolToMask(u8x16, a >= b); }
pub inline fn vcgeq_u16(a: u16x8, b: u16x8) u16x8 { return boolToMask(u16x8, a >= b); }
pub inline fn vcgeq_u32(a: u32x4, b: u32x4) u32x4 { return boolToMask(u32x4, a >= b); }
pub inline fn vcgeq_f32(a: f32x4, b: f32x4) u32x4 { return boolToMask(u32x4, a >= b); }
pub inline fn vcgeq_f64(a: f64x2, b: f64x2) u64x2 { return boolToMask(u64x2, a >= b); }

// --- Vector Greater Than (VCGT / VCGTQ) ---
pub inline fn vcgt_s8(a: i8x8, b: i8x8) u8x8 { return boolToMask(u8x8, a > b); }
pub inline fn vcgt_s16(a: i16x4, b: i16x4) u16x4 { return boolToMask(u16x4, a > b); }
pub inline fn vcgt_s32(a: i32x2, b: i32x2) u32x2 { return boolToMask(u32x2, a > b); }
pub inline fn vcgt_u8(a: u8x8, b: u8x8) u8x8 { return boolToMask(u8x8, a > b); }
pub inline fn vcgt_u16(a: u16x4, b: u16x4) u16x4 { return boolToMask(u16x4, a > b); }
pub inline fn vcgt_u32(a: u32x2, b: u32x2) u32x2 { return boolToMask(u32x2, a > b); }
pub inline fn vcgt_f32(a: f32x2, b: f32x2) u32x2 { return boolToMask(u32x2, a > b); }

pub inline fn vcgtq_s8(a: i8x16, b: i8x16) u8x16 { return boolToMask(u8x16, a > b); }
pub inline fn vcgtq_s16(a: i16x8, b: i16x8) u16x8 { return boolToMask(u16x8, a > b); }
pub inline fn vcgtq_s32(a: i32x4, b: i32x4) u32x4 { return boolToMask(u32x4, a > b); }
pub inline fn vcgtq_u8(a: u8x16, b: u8x16) u8x16 { return boolToMask(u8x16, a > b); }
pub inline fn vcgtq_u16(a: u16x8, b: u16x8) u16x8 { return boolToMask(u16x8, a > b); }
pub inline fn vcgtq_u32(a: u32x4, b: u32x4) u32x4 { return boolToMask(u32x4, a > b); }
pub inline fn vcgtq_f32(a: f32x4, b: f32x4) u32x4 { return boolToMask(u32x4, a > b); }
pub inline fn vcgtq_f64(a: f64x2, b: f64x2) u64x2 { return boolToMask(u64x2, a > b); }

// --- Vector Less Than or Equal (VCLE / VCLEQ) ---
pub inline fn vcle_s8(a: i8x8, b: i8x8) u8x8 { return vcge_s8(b, a); }
pub inline fn vcle_s16(a: i16x4, b: i16x4) u16x4 { return vcge_s16(b, a); }
pub inline fn vcle_s32(a: i32x2, b: i32x2) u32x2 { return vcge_s32(b, a); }
pub inline fn vcle_u8(a: u8x8, b: u8x8) u8x8 { return vcge_u8(b, a); }
pub inline fn vcle_u16(a: u16x4, b: u16x4) u16x4 { return vcge_u16(b, a); }
pub inline fn vcle_u32(a: u32x2, b: u32x2) u32x2 { return vcge_u32(b, a); }
pub inline fn vcle_f32(a: f32x2, b: f32x2) u32x2 { return vcge_f32(b, a); }

pub inline fn vcleq_s8(a: i8x16, b: i8x16) u8x16 { return vcgeq_s8(b, a); }
pub inline fn vcleq_s16(a: i16x8, b: i16x8) u16x8 { return vcgeq_s16(b, a); }
pub inline fn vcleq_s32(a: i32x4, b: i32x4) u32x4 { return vcgeq_s32(b, a); }
pub inline fn vcleq_u8(a: u8x16, b: u8x16) u8x16 { return vcgeq_u8(b, a); }
pub inline fn vcleq_u16(a: u16x8, b: u16x8) u16x8 { return vcgeq_u16(b, a); }
pub inline fn vcleq_u32(a: u32x4, b: u32x4) u32x4 { return vcgeq_u32(b, a); }
pub inline fn vcleq_f32(a: f32x4, b: f32x4) u32x4 { return vcgeq_f32(b, a); }
pub inline fn vcleq_f64(a: f64x2, b: f64x2) u64x2 { return vcgeq_f64(b, a); }

// --- Vector Less Than (VCLT / VCLTQ) ---
pub inline fn vclt_s8(a: i8x8, b: i8x8) u8x8 { return vcgt_s8(b, a); }
pub inline fn vclt_s16(a: i16x4, b: i16x4) u16x4 { return vcgt_s16(b, a); }
pub inline fn vclt_s32(a: i32x2, b: i32x2) u32x2 { return vcgt_s32(b, a); }
pub inline fn vclt_u8(a: u8x8, b: u8x8) u8x8 { return vcgt_u8(b, a); }
pub inline fn vclt_u16(a: u16x4, b: u16x4) u16x4 { return vcgt_u16(b, a); }
pub inline fn vclt_u32(a: u32x2, b: u32x2) u32x2 { return vcgt_u32(b, a); }
pub inline fn vclt_f32(a: f32x2, b: f32x2) u32x2 { return vcgt_f32(b, a); }

pub inline fn vcltq_s8(a: i8x16, b: i8x16) u8x16 { return vcgtq_s8(b, a); }
pub inline fn vcltq_s16(a: i16x8, b: i16x8) u16x8 { return vcgtq_s16(b, a); }
pub inline fn vcltq_s32(a: i32x4, b: i32x4) u32x4 { return vcgtq_s32(b, a); }
pub inline fn vcltq_u8(a: u8x16, b: u8x16) u8x16 { return vcgtq_u8(b, a); }
pub inline fn vcltq_u16(a: u16x8, b: u16x8) u16x8 { return vcgtq_u16(b, a); }
pub inline fn vcltq_u32(a: u32x4, b: u32x4) u32x4 { return vcgtq_u32(b, a); }
pub inline fn vcltq_f32(a: f32x4, b: f32x4) u32x4 { return vcgtq_f32(b, a); }
pub inline fn vcltq_f64(a: f64x2, b: f64x2) u64x2 { return vcgtq_f64(b, a); }

// --- Absolute Comparison (VCAGE / VCAGT) ---
pub inline fn vcage_f32(a: f32x2, b: f32x2) u32x2 { return boolToMask(u32x2, @abs(a) >= @abs(b)); }
pub inline fn vcage_f64(a: f64x1, b: f64x1) u64x1 {
    const a_u = @as(u64x1, @bitCast(a)) & @as(u64x1, @splat(0x7FFFFFFFFFFFFFFF));
    const b_u = @as(u64x1, @bitCast(b)) & @as(u64x1, @splat(0x7FFFFFFFFFFFFFFF));
    return boolToMask(u64x1, a_u >= b_u);
}
pub inline fn vcageq_f32(a: f32x4, b: f32x4) u32x4 { return boolToMask(u32x4, @abs(a) >= @abs(b)); }
pub inline fn vcageq_f64(a: f64x2, b: f64x2) u64x2 { return boolToMask(u64x2, @abs(a) >= @abs(b)); }

pub inline fn vcagt_f32(a: f32x2, b: f32x2) u32x2 { return boolToMask(u32x2, @abs(a) > @abs(b)); }
pub inline fn vcagt_f64(a: f64x1, b: f64x1) u64x1 {
    const a_u = @as(u64x1, @bitCast(a)) & @as(u64x1, @splat(0x7FFFFFFFFFFFFFFF));
    const b_u = @as(u64x1, @bitCast(b)) & @as(u64x1, @splat(0x7FFFFFFFFFFFFFFF));
    return boolToMask(u64x1, a_u > b_u);
}
pub inline fn vcagtq_f32(a: f32x4, b: f32x4) u32x4 { return boolToMask(u32x4, @abs(a) > @abs(b)); }
pub inline fn vcagtq_f64(a: f64x2, b: f64x2) u64x2 { return boolToMask(u64x2, @abs(a) > @abs(b)); }

// --- Vector Min / Max ---
pub inline fn vmin_s8(a: i8x8, b: i8x8) i8x8 { return @min(a, b); }
pub inline fn vmin_s16(a: i16x4, b: i16x4) i16x4 { return @min(a, b); }
pub inline fn vmin_s32(a: i32x2, b: i32x2) i32x2 { return @min(a, b); }
pub inline fn vmin_u8(a: u8x8, b: u8x8) u8x8 { return @min(a, b); }
pub inline fn vmin_u16(a: u16x4, b: u16x4) u16x4 { return @min(a, b); }
pub inline fn vmin_u32(a: u32x2, b: u32x2) u32x2 { return @min(a, b); }
pub inline fn vmin_f16(a: f16x4, b: f16x4) f16x4 { return @min(a, b); }
pub inline fn vmin_f32(a: f32x2, b: f32x2) f32x2 { return @min(a, b); }
pub inline fn vmin_f64(a: f64x1, b: f64x1) f64x1 { return @min(a, b); }

pub inline fn vminq_s8(a: i8x16, b: i8x16) i8x16 { return @min(a, b); }
pub inline fn vminq_s16(a: i16x8, b: i16x8) i16x8 { return @min(a, b); }
pub inline fn vminq_s32(a: i32x4, b: i32x4) i32x4 { return @min(a, b); }
pub inline fn vminq_u8(a: u8x16, b: u8x16) u8x16 { return @min(a, b); }
pub inline fn vminq_u16(a: u16x8, b: u16x8) u16x8 { return @min(a, b); }
pub inline fn vminq_u32(a: u32x4, b: u32x4) u32x4 { return @min(a, b); }
pub inline fn vminq_f16(a: f16x8, b: f16x8) f16x8 { return @min(a, b); }
pub inline fn vminq_f32(a: f32x4, b: f32x4) f32x4 { return @min(a, b); }
pub inline fn vminq_f64(a: f64x2, b: f64x2) f64x2 { return @min(a, b); }

pub inline fn vmax_s8(a: i8x8, b: i8x8) i8x8 { return @max(a, b); }
pub inline fn vmax_s16(a: i16x4, b: i16x4) i16x4 { return @max(a, b); }
pub inline fn vmax_s32(a: i32x2, b: i32x2) i32x2 { return @max(a, b); }
pub inline fn vmax_u8(a: u8x8, b: u8x8) u8x8 { return @max(a, b); }
pub inline fn vmax_u16(a: u16x4, b: u16x4) u16x4 { return @max(a, b); }
pub inline fn vmax_u32(a: u32x2, b: u32x2) u32x2 { return @max(a, b); }
pub inline fn vmax_f16(a: f16x4, b: f16x4) f16x4 { return @max(a, b); }
pub inline fn vmax_f32(a: f32x2, b: f32x2) f32x2 { return @max(a, b); }
pub inline fn vmax_f64(a: f64x1, b: f64x1) f64x1 { return @max(a, b); }

pub inline fn vmaxq_s8(a: i8x16, b: i8x16) i8x16 { return @max(a, b); }
pub inline fn vmaxq_s16(a: i16x8, b: i16x8) i16x8 { return @max(a, b); }
pub inline fn vmaxq_s32(a: i32x4, b: i32x4) i32x4 { return @max(a, b); }
pub inline fn vmaxq_u8(a: u8x16, b: u8x16) u8x16 { return @max(a, b); }
pub inline fn vmaxq_u16(a: u16x8, b: u16x8) u16x8 { return @max(a, b); }
pub inline fn vmaxq_u32(a: u32x4, b: u32x4) u32x4 { return @max(a, b); }
pub inline fn vmaxq_f16(a: f16x8, b: f16x8) f16x8 { return @max(a, b); }
pub inline fn vmaxq_f32(a: f32x4, b: f32x4) f32x4 { return @max(a, b); }
pub inline fn vmaxq_f64(a: f64x2, b: f64x2) f64x2 { return @max(a, b); }

test "compare intrinsics" {
    const a: i32x4 = .{ 1, 5, 3, 7 };
    const b: i32x4 = .{ 1, 2, 4, 7 };
    const eq = vceqq_s32(a, b);
    try std.testing.expectEqual(u32x4{ 0xFFFFFFFF, 0, 0, 0xFFFFFFFF }, eq);

    const max_v = vmaxq_s32(a, b);
    try std.testing.expectEqual(i32x4{ 1, 5, 4, 7 }, max_v);
}
