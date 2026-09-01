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

// --- Immediate Right Shift (VSHR_N / VSHRQ_N) ---
pub inline fn vshr_n_s8(a: i8x8, comptime n: usize) i8x8 {
    const shift: i8x8 = @splat(@intCast(n));
    return a >> shift;
}
pub inline fn vshr_n_s16(a: i16x4, comptime n: usize) i16x4 {
    const shift: i16x4 = @splat(@intCast(n));
    return a >> shift;
}
pub inline fn vshr_n_s32(a: i32x2, comptime n: usize) i32x2 {
    const shift: i32x2 = @splat(@intCast(n));
    return a >> shift;
}
pub inline fn vshr_n_s64(a: i64x1, comptime n: usize) i64x1 {
    const shift: i64x1 = @splat(@intCast(n));
    return a >> shift;
}

pub inline fn vshr_n_u8(a: u8x8, comptime n: usize) u8x8 {
    const shift: u8x8 = @splat(@intCast(n));
    return a >> shift;
}
pub inline fn vshr_n_u16(a: u16x4, comptime n: usize) u16x4 {
    const shift: u16x4 = @splat(@intCast(n));
    return a >> shift;
}
pub inline fn vshr_n_u32(a: u32x2, comptime n: usize) u32x2 {
    const shift: u32x2 = @splat(@intCast(n));
    return a >> shift;
}
pub inline fn vshr_n_u64(a: u64x1, comptime n: usize) u64x1 {
    const shift: u64x1 = @splat(@intCast(n));
    return a >> shift;
}

pub inline fn vshrq_n_s8(a: i8x16, comptime n: usize) i8x16 {
    const shift: i8x16 = @splat(@intCast(n));
    return a >> shift;
}
pub inline fn vshrq_n_s16(a: i16x8, comptime n: usize) i16x8 {
    const shift: i16x8 = @splat(@intCast(n));
    return a >> shift;
}
pub inline fn vshrq_n_s32(a: i32x4, comptime n: usize) i32x4 {
    const shift: i32x4 = @splat(@intCast(n));
    return a >> shift;
}
pub inline fn vshrq_n_s64(a: i64x2, comptime n: usize) i64x2 {
    const shift: i64x2 = @splat(@intCast(n));
    return a >> shift;
}

pub inline fn vshrq_n_u8(a: u8x16, comptime n: usize) u8x16 {
    const shift: u8x16 = @splat(@intCast(n));
    return a >> shift;
}
pub inline fn vshrq_n_u16(a: u16x8, comptime n: usize) u16x8 {
    const shift: u16x8 = @splat(@intCast(n));
    return a >> shift;
}
pub inline fn vshrq_n_u32(a: u32x4, comptime n: usize) u32x4 {
    const shift: u32x4 = @splat(@intCast(n));
    return a >> shift;
}
pub inline fn vshrq_n_u64(a: u64x2, comptime n: usize) u64x2 {
    const shift: u64x2 = @splat(@intCast(n));
    return a >> shift;
}

// --- Immediate Left Shift (VSHL_N / VSHLQ_N) ---
pub inline fn vshl_n_s8(a: i8x8, comptime n: usize) i8x8 {
    const shift: i8x8 = @splat(@intCast(n));
    return a << shift;
}
pub inline fn vshl_n_s16(a: i16x4, comptime n: usize) i16x4 {
    const shift: i16x4 = @splat(@intCast(n));
    return a << shift;
}
pub inline fn vshl_n_s32(a: i32x2, comptime n: usize) i32x2 {
    const shift: i32x2 = @splat(@intCast(n));
    return a << shift;
}
pub inline fn vshl_n_s64(a: i64x1, comptime n: usize) i64x1 {
    const shift: i64x1 = @splat(@intCast(n));
    return a << shift;
}

pub inline fn vshl_n_u8(a: u8x8, comptime n: usize) u8x8 {
    const shift: u8x8 = @splat(@intCast(n));
    return a << shift;
}
pub inline fn vshl_n_u16(a: u16x4, comptime n: usize) u16x4 {
    const shift: u16x4 = @splat(@intCast(n));
    return a << shift;
}
pub inline fn vshl_n_u32(a: u32x2, comptime n: usize) u32x2 {
    const shift: u32x2 = @splat(@intCast(n));
    return a << shift;
}
pub inline fn vshl_n_u64(a: u64x1, comptime n: usize) u64x1 {
    const shift: u64x1 = @splat(@intCast(n));
    return a << shift;
}

pub inline fn vshlq_n_s8(a: i8x16, comptime n: usize) i8x16 {
    const shift: i8x16 = @splat(@intCast(n));
    return a << shift;
}
pub inline fn vshlq_n_s16(a: i16x8, comptime n: usize) i16x8 {
    const shift: i16x8 = @splat(@intCast(n));
    return a << shift;
}
pub inline fn vshlq_n_s32(a: i32x4, comptime n: usize) i32x4 {
    const shift: i32x4 = @splat(@intCast(n));
    return a << shift;
}
pub inline fn vshlq_n_s64(a: i64x2, comptime n: usize) i64x2 {
    const shift: i64x2 = @splat(@intCast(n));
    return a << shift;
}

pub inline fn vshlq_n_u8(a: u8x16, comptime n: usize) u8x16 {
    const shift: u8x16 = @splat(@intCast(n));
    return a << shift;
}
pub inline fn vshlq_n_u16(a: u16x8, comptime n: usize) u16x8 {
    const shift: u16x8 = @splat(@intCast(n));
    return a << shift;
}
pub inline fn vshlq_n_u32(a: u32x4, comptime n: usize) u32x4 {
    const shift: u32x4 = @splat(@intCast(n));
    return a << shift;
}
pub inline fn vshlq_n_u64(a: u64x2, comptime n: usize) u64x2 {
    const shift: u64x2 = @splat(@intCast(n));
    return a << shift;
}

// --- Shift Right and Accumulate (VSRA / VSRAQ) ---
pub inline fn vsra_n_s8(a: i8x8, b: i8x8, comptime n: usize) i8x8 { return a +% vshr_n_s8(b, n); }
pub inline fn vsra_n_s16(a: i16x4, b: i16x4, comptime n: usize) i16x4 { return a +% vshr_n_s16(b, n); }
pub inline fn vsra_n_s32(a: i32x2, b: i32x2, comptime n: usize) i32x2 { return a +% vshr_n_s32(b, n); }
pub inline fn vsra_n_s64(a: i64x1, b: i64x1, comptime n: usize) i64x1 { return a +% vshr_n_s64(b, n); }
pub inline fn vsra_n_u8(a: u8x8, b: u8x8, comptime n: usize) u8x8 { return a +% vshr_n_u8(b, n); }
pub inline fn vsra_n_u16(a: u16x4, b: u16x4, comptime n: usize) u16x4 { return a +% vshr_n_u16(b, n); }
pub inline fn vsra_n_u32(a: u32x2, b: u32x2, comptime n: usize) u32x2 { return a +% vshr_n_u32(b, n); }
pub inline fn vsra_n_u64(a: u64x1, b: u64x1, comptime n: usize) u64x1 { return a +% vshr_n_u64(b, n); }

pub inline fn vsraq_n_s8(a: i8x16, b: i8x16, comptime n: usize) i8x16 { return a +% vshrq_n_s8(b, n); }
pub inline fn vsraq_n_s16(a: i16x8, b: i16x8, comptime n: usize) i16x8 { return a +% vshrq_n_s16(b, n); }
pub inline fn vsraq_n_s32(a: i32x4, b: i32x4, comptime n: usize) i32x4 { return a +% vshrq_n_s32(b, n); }
pub inline fn vsraq_n_s64(a: i64x2, b: i64x2, comptime n: usize) i64x2 { return a +% vshrq_n_s64(b, n); }
pub inline fn vsraq_n_u8(a: u8x16, b: u8x16, comptime n: usize) u8x16 { return a +% vshrq_n_u8(b, n); }
pub inline fn vsraq_n_u16(a: u16x8, b: u16x8, comptime n: usize) u16x8 { return a +% vshrq_n_u16(b, n); }
pub inline fn vsraq_n_u32(a: u32x4, b: u32x4, comptime n: usize) u32x4 { return a +% vshrq_n_u32(b, n); }
pub inline fn vsraq_n_u64(a: u64x2, b: u64x2, comptime n: usize) u64x2 { return a +% vshrq_n_u64(b, n); }

// --- Narrowing Shift Right (VSHRN_N) ---
pub inline fn vshrn_n_s16(a: i16x8, comptime n: usize) i8x8 {
    const shifted = vshrq_n_s16(a, n);
    var res: i8x8 = undefined;
    inline for (0..8) |i| res[i] = @truncate(shifted[i]);
    return res;
}
pub inline fn vshrn_n_s32(a: i32x4, comptime n: usize) i16x4 {
    const shifted = vshrq_n_s32(a, n);
    var res: i16x4 = undefined;
    inline for (0..4) |i| res[i] = @truncate(shifted[i]);
    return res;
}
pub inline fn vshrn_n_s64(a: i64x2, comptime n: usize) i32x2 {
    const shifted = vshrq_n_s64(a, n);
    var res: i32x2 = undefined;
    inline for (0..2) |i| res[i] = @truncate(shifted[i]);
    return res;
}
pub inline fn vshrn_n_u16(a: u16x8, comptime n: usize) u8x8 {
    const shifted = vshrq_n_u16(a, n);
    var res: u8x8 = undefined;
    inline for (0..8) |i| res[i] = @truncate(shifted[i]);
    return res;
}
pub inline fn vshrn_n_u32(a: u32x4, comptime n: usize) u16x4 {
    const shifted = vshrq_n_u32(a, n);
    var res: u16x4 = undefined;
    inline for (0..4) |i| res[i] = @truncate(shifted[i]);
    return res;
}
pub inline fn vshrn_n_u64(a: u64x2, comptime n: usize) u32x2 {
    const shifted = vshrq_n_u64(a, n);
    var res: u32x2 = undefined;
    inline for (0..2) |i| res[i] = @truncate(shifted[i]);
    return res;
}

// --- Vector Shift by Vector (VSHL / VSHLQ) ---
// AArch64: single sshl/ushl instruction (shift left if b[i]>=0, right if b[i]<0)
// Portable: branchless @select between left and right shifts
inline fn vshlPortable(comptime V: type, a: V, b: anytype) V {
    const len = @typeInfo(V).vector.len;
    const Elem = std.meta.Child(V);
    const UElem = std.meta.Int(.unsigned, @bitSizeOf(Elem));
    const ShiftInt = std.math.Log2Int(UElem);
    const UVec = @Vector(len, UElem);
    const ShiftVec = @Vector(len, ShiftInt);
    const zero: @TypeOf(b) = @splat(0);
    const b_pos_mask = b >= zero;
    const b_u: UVec = @bitCast(b);
    const b_neg_u: UVec = @bitCast(-%b);
    const mask_val: UElem = @intCast(std.math.maxInt(ShiftInt));
    const b_pos_shift: ShiftVec = @truncate(b_u & @as(UVec, @splat(mask_val)));
    const b_neg_shift: ShiftVec = @truncate(b_neg_u & @as(UVec, @splat(mask_val)));
    // For unsigned vectors, shift ops are well-defined; for signed we cast
    const a_u: UVec = @bitCast(a);
    const left: UVec = a_u << b_pos_shift;
    const right: UVec = a_u >> b_neg_shift;
    return @bitCast(@select(UElem, b_pos_mask, left, right));
}
pub inline fn vshl_s8(a: i8x8, b: i8x8) i8x8 {
    if (comptime @import("builtin").cpu.arch == .aarch64)
        return asm ("sshl %[res].8b, %[a].8b, %[b].8b" : [res] "=w" (-> i8x8) : [a] "w" (a), [b] "w" (b));
    return vshlPortable(i8x8, a, b);
}
pub inline fn vshl_u8(a: u8x8, b: i8x8) u8x8 {
    if (comptime @import("builtin").cpu.arch == .aarch64)
        return asm ("ushl %[res].8b, %[a].8b, %[b].8b" : [res] "=w" (-> u8x8) : [a] "w" (a), [b] "w" (b));
    return vshlPortable(u8x8, a, b);
}
pub inline fn vshlq_s8(a: i8x16, b: i8x16) i8x16 {
    if (comptime @import("builtin").cpu.arch == .aarch64)
        return asm ("sshl %[res].16b, %[a].16b, %[b].16b" : [res] "=w" (-> i8x16) : [a] "w" (a), [b] "w" (b));
    return vshlPortable(i8x16, a, b);
}
pub inline fn vshlq_u8(a: u8x16, b: i8x16) u8x16 {
    if (comptime @import("builtin").cpu.arch == .aarch64)
        return asm ("ushl %[res].16b, %[a].16b, %[b].16b" : [res] "=w" (-> u8x16) : [a] "w" (a), [b] "w" (b));
    return vshlPortable(u8x16, a, b);
}

test "shift intrinsics" {
    const a: u8x16 = @splat(0xF0);
    const shifted = vshrq_n_u8(a, 4);
    try std.testing.expectEqual(@as(u8x16, @splat(0x0F)), shifted);

    const left = vshlq_n_u8(shifted, 4);
    try std.testing.expectEqual(a, left);
}
