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

// Generic helper for loading a vector from a pointer
inline fn loadVec(comptime V: type, ptr: anytype) V {
    const len = common.vecLen(V);
    const Child = std.meta.Child(V);
    const p: [*]const Child = @ptrCast(ptr);
    return p[0..len].*;
}

// Generic helper for storing a vector to a pointer
inline fn storeVec(ptr: anytype, vec: anytype) void {
    const V = @TypeOf(vec);
    const len = common.vecLen(V);
    const Child = std.meta.Child(V);
    const p: [*]Child = @ptrCast(ptr);
    p[0..len].* = vec;
}

// 64-bit vector loads
pub inline fn vld1_s8(ptr: [*]const i8) i8x8 { return loadVec(i8x8, ptr); }
pub inline fn vld1_s16(ptr: [*]const i16) i16x4 { return loadVec(i16x4, ptr); }
pub inline fn vld1_s32(ptr: [*]const i32) i32x2 { return loadVec(i32x2, ptr); }
pub inline fn vld1_s64(ptr: [*]const i64) i64x1 { return loadVec(i64x1, ptr); }
pub inline fn vld1_u8(ptr: [*]const u8) u8x8 { return loadVec(u8x8, ptr); }
pub inline fn vld1_u16(ptr: [*]const u16) u16x4 { return loadVec(u16x4, ptr); }
pub inline fn vld1_u32(ptr: [*]const u32) u32x2 { return loadVec(u32x2, ptr); }
pub inline fn vld1_u64(ptr: [*]const u64) u64x1 { return loadVec(u64x1, ptr); }
pub inline fn vld1_f16(ptr: [*]const f16) f16x4 { return loadVec(f16x4, ptr); }
pub inline fn vld1_f32(ptr: [*]const f32) f32x2 { return loadVec(f32x2, ptr); }
pub inline fn vld1_f64(ptr: [*]const f64) f64x1 { return loadVec(f64x1, ptr); }
pub inline fn vld1_p8(ptr: [*]const p8) p8x8 { return loadVec(p8x8, ptr); }
pub inline fn vld1_p16(ptr: [*]const p16) p16x4 { return loadVec(p16x4, ptr); }
pub inline fn vld1_p64(ptr: [*]const p64) p64x1 { return loadVec(p64x1, ptr); }

// 128-bit vector loads
pub inline fn vld1q_s8(ptr: [*]const i8) i8x16 { return loadVec(i8x16, ptr); }
pub inline fn vld1q_s16(ptr: [*]const i16) i16x8 { return loadVec(i16x8, ptr); }
pub inline fn vld1q_s32(ptr: [*]const i32) i32x4 { return loadVec(i32x4, ptr); }
pub inline fn vld1q_s64(ptr: [*]const i64) i64x2 { return loadVec(i64x2, ptr); }
pub inline fn vld1q_u8(ptr: [*]const u8) u8x16 { return loadVec(u8x16, ptr); }
pub inline fn vld1q_u16(ptr: [*]const u16) u16x8 { return loadVec(u16x8, ptr); }
pub inline fn vld1q_u32(ptr: [*]const u32) u32x4 { return loadVec(u32x4, ptr); }
pub inline fn vld1q_u64(ptr: [*]const u64) u64x2 { return loadVec(u64x2, ptr); }
pub inline fn vld1q_f16(ptr: [*]const f16) f16x8 { return loadVec(f16x8, ptr); }
pub inline fn vld1q_f32(ptr: [*]const f32) f32x4 { return loadVec(f32x4, ptr); }
pub inline fn vld1q_f64(ptr: [*]const f64) f64x2 { return loadVec(f64x2, ptr); }
pub inline fn vld1q_p8(ptr: [*]const p8) p8x16 { return loadVec(p8x16, ptr); }
pub inline fn vld1q_p16(ptr: [*]const p16) p16x8 { return loadVec(p16x8, ptr); }
pub inline fn vld1q_p64(ptr: [*]const p64) p64x2 { return loadVec(p64x2, ptr); }

// 64-bit vector stores
pub inline fn vst1_s8(ptr: [*]i8, vec: i8x8) void { storeVec(ptr, vec); }
pub inline fn vst1_s16(ptr: [*]i16, vec: i16x4) void { storeVec(ptr, vec); }
pub inline fn vst1_s32(ptr: [*]i32, vec: i32x2) void { storeVec(ptr, vec); }
pub inline fn vst1_s64(ptr: [*]i64, vec: i64x1) void { storeVec(ptr, vec); }
pub inline fn vst1_u8(ptr: [*]u8, vec: u8x8) void { storeVec(ptr, vec); }
pub inline fn vst1_u16(ptr: [*]u16, vec: u16x4) void { storeVec(ptr, vec); }
pub inline fn vst1_u32(ptr: [*]u32, vec: u32x2) void { storeVec(ptr, vec); }
pub inline fn vst1_u64(ptr: [*]u64, vec: u64x1) void { storeVec(ptr, vec); }
pub inline fn vst1_f16(ptr: [*]f16, vec: f16x4) void { storeVec(ptr, vec); }
pub inline fn vst1_f32(ptr: [*]f32, vec: f32x2) void { storeVec(ptr, vec); }
pub inline fn vst1_f64(ptr: [*]f64, vec: f64x1) void { storeVec(ptr, vec); }
pub inline fn vst1_p8(ptr: [*]p8, vec: p8x8) void { storeVec(ptr, vec); }
pub inline fn vst1_p16(ptr: [*]p16, vec: p16x4) void { storeVec(ptr, vec); }
pub inline fn vst1_p64(ptr: [*]p64, vec: p64x1) void { storeVec(ptr, vec); }

// 128-bit vector stores
pub inline fn vst1q_s8(ptr: [*]i8, vec: i8x16) void { storeVec(ptr, vec); }
pub inline fn vst1q_s16(ptr: [*]i16, vec: i16x8) void { storeVec(ptr, vec); }
pub inline fn vst1q_s32(ptr: [*]i32, vec: i32x4) void { storeVec(ptr, vec); }
pub inline fn vst1q_s64(ptr: [*]i64, vec: i64x2) void { storeVec(ptr, vec); }
pub inline fn vst1q_u8(ptr: [*]u8, vec: u8x16) void { storeVec(ptr, vec); }
pub inline fn vst1q_u16(ptr: [*]u16, vec: u16x8) void { storeVec(ptr, vec); }
pub inline fn vst1q_u32(ptr: [*]u32, vec: u32x4) void { storeVec(ptr, vec); }
pub inline fn vst1q_u64(ptr: [*]u64, vec: u64x2) void { storeVec(ptr, vec); }
pub inline fn vst1q_f16(ptr: [*]f16, vec: f16x8) void { storeVec(ptr, vec); }
pub inline fn vst1q_f32(ptr: [*]f32, vec: f32x4) void { storeVec(ptr, vec); }
pub inline fn vst1q_f64(ptr: [*]f64, vec: f64x2) void { storeVec(ptr, vec); }
pub inline fn vst1q_p8(ptr: [*]p8, vec: p8x16) void { storeVec(ptr, vec); }
pub inline fn vst1q_p16(ptr: [*]p16, vec: p16x8) void { storeVec(ptr, vec); }
pub inline fn vst1q_p64(ptr: [*]p64, vec: p64x2) void { storeVec(ptr, vec); }
pub inline fn vst1q_p46(ptr: [*]p64, vec: p64x2) void { storeVec(ptr, vec); }

// Lane loads and stores
pub inline fn vld1_lane_u8(ptr: [*]const u8, vec: u8x8, comptime lane: usize) u8x8 {
    var r = vec;
    r[lane] = ptr[0];
    return r;
}
pub inline fn vld1q_lane_u8(ptr: [*]const u8, vec: u8x16, comptime lane: usize) u8x16 {
    var r = vec;
    r[lane] = ptr[0];
    return r;
}
pub inline fn vld1_lane_s32(ptr: [*]const i32, vec: i32x2, comptime lane: usize) i32x2 {
    var r = vec;
    r[lane] = ptr[0];
    return r;
}
pub inline fn vld1q_lane_s32(ptr: [*]const i32, vec: i32x4, comptime lane: usize) i32x4 {
    var r = vec;
    r[lane] = ptr[0];
    return r;
}
pub inline fn vld1_lane_f32(ptr: [*]const f32, vec: f32x2, comptime lane: usize) f32x2 {
    var r = vec;
    r[lane] = ptr[0];
    return r;
}
pub inline fn vld1q_lane_f32(ptr: [*]const f32, vec: f32x4, comptime lane: usize) f32x4 {
    var r = vec;
    r[lane] = ptr[0];
    return r;
}

pub inline fn vld1_dup_u8(ptr: [*]const u8) u8x8 { return @splat(ptr[0]); }
pub inline fn vld1_dup_u16(ptr: [*]const u16) u16x4 { return @splat(ptr[0]); }
pub inline fn vld1_dup_u32(ptr: [*]const u32) u32x2 { return @splat(ptr[0]); }
pub inline fn vld1_dup_u64(ptr: [*]const u64) u64x1 { return @splat(ptr[0]); }
pub inline fn vld1_dup_s8(ptr: [*]const i8) i8x8 { return @splat(ptr[0]); }
pub inline fn vld1_dup_s16(ptr: [*]const i16) i16x4 { return @splat(ptr[0]); }
pub inline fn vld1_dup_s32(ptr: [*]const i32) i32x2 { return @splat(ptr[0]); }
pub inline fn vld1_dup_s64(ptr: [*]const i64) i64x1 { return @splat(ptr[0]); }
pub inline fn vld1_dup_f16(ptr: [*]const f16) f16x4 { return @splat(ptr[0]); }
pub inline fn vld1_dup_f32(ptr: [*]const f32) f32x2 { return @splat(ptr[0]); }
pub inline fn vld1_dup_f64(ptr: [*]const f64) f64x1 { return @splat(ptr[0]); }
pub inline fn vld1_dup_p8(ptr: [*]const p8) p8x8 { return @splat(ptr[0]); }
pub inline fn vld1_dup_p16(ptr: [*]const p16) p16x4 { return @splat(ptr[0]); }
pub inline fn vld1_dup_p64(ptr: [*]const p64) p64x1 { return @splat(ptr[0]); }

pub inline fn vld1q_dup_u8(ptr: [*]const u8) u8x16 { return @splat(ptr[0]); }
pub inline fn vld1q_dup_u16(ptr: [*]const u16) u16x8 { return @splat(ptr[0]); }
pub inline fn vld1q_dup_u32(ptr: [*]const u32) u32x4 { return @splat(ptr[0]); }
pub inline fn vld1q_dup_u64(ptr: [*]const u64) u64x2 { return @splat(ptr[0]); }
pub inline fn vld1q_dup_s8(ptr: [*]const i8) i8x16 { return @splat(ptr[0]); }
pub inline fn vld1q_dup_s16(ptr: [*]const i16) i16x8 { return @splat(ptr[0]); }
pub inline fn vld1q_dup_s32(ptr: [*]const i32) i32x4 { return @splat(ptr[0]); }
pub inline fn vld1q_dup_s64(ptr: [*]const i64) i64x2 { return @splat(ptr[0]); }
pub inline fn vld1q_dup_f16(ptr: [*]const f16) f16x8 { return @splat(ptr[0]); }
pub inline fn vld1q_dup_f32(ptr: [*]const f32) f32x4 { return @splat(ptr[0]); }
pub inline fn vld1q_dup_f64(ptr: [*]const f64) f64x2 { return @splat(ptr[0]); }
pub inline fn vld1q_dup_p8(ptr: [*]const p8) p8x16 { return @splat(ptr[0]); }
pub inline fn vld1q_dup_p16(ptr: [*]const p16) p16x8 { return @splat(ptr[0]); }
pub inline fn vld1q_dup_p64(ptr: [*]const p64) p64x2 { return @splat(ptr[0]); }

pub inline fn vst1_lane_u8(ptr: [*]u8, vec: u8x8, comptime lane: usize) void {
    ptr[0] = vec[lane];
}
pub inline fn vst1q_lane_u8(ptr: [*]u8, vec: u8x16, comptime lane: usize) void {
    ptr[0] = vec[lane];
}
pub inline fn vst1_lane_s32(ptr: [*]i32, vec: i32x2, comptime lane: usize) void {
    ptr[0] = vec[lane];
}
pub inline fn vst1q_lane_s32(ptr: [*]i32, vec: i32x4, comptime lane: usize) void {
    ptr[0] = vec[lane];
}
pub inline fn vst1_lane_f32(ptr: [*]f32, vec: f32x2, comptime lane: usize) void {
    ptr[0] = vec[lane];
}
pub inline fn vst1q_lane_f32(ptr: [*]f32, vec: f32x4, comptime lane: usize) void {
    ptr[0] = vec[lane];
}

// 2-vector loads and stores
pub inline fn vld2_u8(ptr: [*]const u8) types.u8x8x2 {
    var v0: u8x8 = undefined;
    var v1: u8x8 = undefined;
    inline for (0..8) |i| {
        v0[i] = ptr[i * 2];
        v1[i] = ptr[i * 2 + 1];
    }
    return .{ v0, v1 };
}
pub inline fn vld2_s8(ptr: [*]const i8) types.i8x8x2 {
    var v0: i8x8 = undefined;
    var v1: i8x8 = undefined;
    inline for (0..8) |i| {
        v0[i] = ptr[i * 2];
        v1[i] = ptr[i * 2 + 1];
    }
    return .{ v0, v1 };
}
pub inline fn vld2_s16(ptr: [*]const i16) types.i16x4x2 {
    var v0: i16x4 = undefined;
    var v1: i16x4 = undefined;
    inline for (0..4) |i| {
        v0[i] = ptr[i * 2];
        v1[i] = ptr[i * 2 + 1];
    }
    return .{ v0, v1 };
}
pub inline fn vld2_u16(ptr: [*]const u16) types.u16x4x2 {
    var v0: u16x4 = undefined;
    var v1: u16x4 = undefined;
    inline for (0..4) |i| {
        v0[i] = ptr[i * 2];
        v1[i] = ptr[i * 2 + 1];
    }
    return .{ v0, v1 };
}
pub inline fn vld2_s32(ptr: [*]const i32) types.i32x2x2 {
    var v0: i32x2 = undefined;
    var v1: i32x2 = undefined;
    inline for (0..2) |i| {
        v0[i] = ptr[i * 2];
        v1[i] = ptr[i * 2 + 1];
    }
    return .{ v0, v1 };
}
pub inline fn vld2_u32(ptr: [*]const u32) types.u32x2x2 {
    var v0: u32x2 = undefined;
    var v1: u32x2 = undefined;
    inline for (0..2) |i| {
        v0[i] = ptr[i * 2];
        v1[i] = ptr[i * 2 + 1];
    }
    return .{ v0, v1 };
}
pub inline fn vld2_f32(ptr: [*]const f32) types.f32x2x2 {
    var v0: f32x2 = undefined;
    var v1: f32x2 = undefined;
    inline for (0..2) |i| {
        v0[i] = ptr[i * 2];
        v1[i] = ptr[i * 2 + 1];
    }
    return .{ v0, v1 };
}
pub inline fn vld2q_u8(ptr: [*]const u8) types.u8x16x2 {
    var v0: u8x16 = undefined;
    var v1: u8x16 = undefined;
    inline for (0..16) |i| {
        v0[i] = ptr[i * 2];
        v1[i] = ptr[i * 2 + 1];
    }
    return .{ v0, v1 };
}
pub inline fn vld2q_s8(ptr: [*]const i8) types.i8x16x2 {
    var v0: i8x16 = undefined;
    var v1: i8x16 = undefined;
    inline for (0..16) |i| {
        v0[i] = ptr[i * 2];
        v1[i] = ptr[i * 2 + 1];
    }
    return .{ v0, v1 };
}
pub inline fn vld2q_s16(ptr: [*]const i16) types.i16x8x2 {
    var v0: i16x8 = undefined;
    var v1: i16x8 = undefined;
    inline for (0..8) |i| {
        v0[i] = ptr[i * 2];
        v1[i] = ptr[i * 2 + 1];
    }
    return .{ v0, v1 };
}
pub inline fn vld2q_u16(ptr: [*]const u16) types.u16x8x2 {
    var v0: u16x8 = undefined;
    var v1: u16x8 = undefined;
    inline for (0..8) |i| {
        v0[i] = ptr[i * 2];
        v1[i] = ptr[i * 2 + 1];
    }
    return .{ v0, v1 };
}
pub inline fn vld2q_s32(ptr: [*]const i32) types.i32x4x2 {
    var v0: i32x4 = undefined;
    var v1: i32x4 = undefined;
    inline for (0..4) |i| {
        v0[i] = ptr[i * 2];
        v1[i] = ptr[i * 2 + 1];
    }
    return .{ v0, v1 };
}
pub inline fn vld2q_u32(ptr: [*]const u32) types.u32x4x2 {
    var v0: u32x4 = undefined;
    var v1: u32x4 = undefined;
    inline for (0..4) |i| {
        v0[i] = ptr[i * 2];
        v1[i] = ptr[i * 2 + 1];
    }
    return .{ v0, v1 };
}
pub inline fn vld2q_f32(ptr: [*]const f32) types.f32x4x2 {
    var v0: f32x4 = undefined;
    var v1: f32x4 = undefined;
    inline for (0..4) |i| {
        v0[i] = ptr[i * 2];
        v1[i] = ptr[i * 2 + 1];
    }
    return .{ v0, v1 };
}

pub inline fn vst2_u8(ptr: [*]u8, val: types.u8x8x2) void {
    inline for (0..8) |i| {
        ptr[i * 2] = val[0][i];
        ptr[i * 2 + 1] = val[1][i];
    }
}
pub inline fn vst2_s8(ptr: [*]i8, val: types.i8x8x2) void {
    inline for (0..8) |i| {
        ptr[i * 2] = val[0][i];
        ptr[i * 2 + 1] = val[1][i];
    }
}
pub inline fn vst2_s16(ptr: [*]i16, val: types.i16x4x2) void {
    inline for (0..4) |i| {
        ptr[i * 2] = val[0][i];
        ptr[i * 2 + 1] = val[1][i];
    }
}
pub inline fn vst2_u16(ptr: [*]u16, val: types.u16x4x2) void {
    inline for (0..4) |i| {
        ptr[i * 2] = val[0][i];
        ptr[i * 2 + 1] = val[1][i];
    }
}
pub inline fn vst2_s32(ptr: [*]i32, val: types.i32x2x2) void {
    inline for (0..2) |i| {
        ptr[i * 2] = val[0][i];
        ptr[i * 2 + 1] = val[1][i];
    }
}
pub inline fn vst2_u32(ptr: [*]u32, val: types.u32x2x2) void {
    inline for (0..2) |i| {
        ptr[i * 2] = val[0][i];
        ptr[i * 2 + 1] = val[1][i];
    }
}
pub inline fn vst2_f32(ptr: [*]f32, val: types.f32x2x2) void {
    inline for (0..2) |i| {
        ptr[i * 2] = val[0][i];
        ptr[i * 2 + 1] = val[1][i];
    }
}
pub inline fn vst2q_u8(ptr: [*]u8, val: types.u8x16x2) void {
    inline for (0..16) |i| {
        ptr[i * 2] = val[0][i];
        ptr[i * 2 + 1] = val[1][i];
    }
}
pub inline fn vst2q_s8(ptr: [*]i8, val: types.i8x16x2) void {
    inline for (0..16) |i| {
        ptr[i * 2] = val[0][i];
        ptr[i * 2 + 1] = val[1][i];
    }
}
pub inline fn vst2q_s16(ptr: [*]i16, val: types.i16x8x2) void {
    inline for (0..8) |i| {
        ptr[i * 2] = val[0][i];
        ptr[i * 2 + 1] = val[1][i];
    }
}
pub inline fn vst2q_u16(ptr: [*]u16, val: types.u16x8x2) void {
    inline for (0..8) |i| {
        ptr[i * 2] = val[0][i];
        ptr[i * 2 + 1] = val[1][i];
    }
}
pub inline fn vst2q_s32(ptr: [*]i32, val: types.i32x4x2) void {
    inline for (0..4) |i| {
        ptr[i * 2] = val[0][i];
        ptr[i * 2 + 1] = val[1][i];
    }
}
pub inline fn vst2q_u32(ptr: [*]u32, val: types.u32x4x2) void {
    inline for (0..4) |i| {
        ptr[i * 2] = val[0][i];
        ptr[i * 2 + 1] = val[1][i];
    }
}
pub inline fn vst2q_f32(ptr: [*]f32, val: types.f32x4x2) void {
    inline for (0..4) |i| {
        ptr[i * 2] = val[0][i];
        ptr[i * 2 + 1] = val[1][i];
    }
}

// 3-vector loads and stores
pub inline fn vld3q_u8(ptr: [*]const u8) types.u8x16x3 {
    var v0: u8x16 = undefined;
    var v1: u8x16 = undefined;
    var v2: u8x16 = undefined;
    inline for (0..16) |i| {
        v0[i] = ptr[i * 3];
        v1[i] = ptr[i * 3 + 1];
        v2[i] = ptr[i * 3 + 2];
    }
    return .{ v0, v1, v2 };
}

pub inline fn vst3q_u8(ptr: [*]u8, val: types.u8x16x3) void {
    inline for (0..16) |i| {
        ptr[i * 3] = val[0][i];
        ptr[i * 3 + 1] = val[1][i];
        ptr[i * 3 + 2] = val[2][i];
    }
}

// 4-vector loads and stores
pub inline fn vld4q_u8(ptr: [*]const u8) types.u8x16x4 {
    var v0: u8x16 = undefined;
    var v1: u8x16 = undefined;
    var v2: u8x16 = undefined;
    var v3: u8x16 = undefined;
    inline for (0..16) |i| {
        v0[i] = ptr[i * 4];
        v1[i] = ptr[i * 4 + 1];
        v2[i] = ptr[i * 4 + 2];
        v3[i] = ptr[i * 4 + 3];
    }
    return .{ v0, v1, v2, v3 };
}

pub inline fn vst4q_u8(ptr: [*]u8, val: types.u8x16x4) void {
    inline for (0..16) |i| {
        ptr[i * 4] = val[0][i];
        ptr[i * 4 + 1] = val[1][i];
        ptr[i * 4 + 2] = val[2][i];
        ptr[i * 4 + 3] = val[3][i];
    }
}

test "load store intrinsics" {
    const data = [_]u8{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32 };
    var out: [16]u8 = undefined;

    const vec = vld1q_u8(&data);
    vst1q_u8(&out, vec);
    try std.testing.expectEqualSlices(u8, data[0..16], &out);

    const dup = vld1q_dup_u8(data[0..].ptr);
    try std.testing.expectEqual(@as(u8x16, @splat(data[0])), dup);

    const interleaved = vld2q_u8(&data);
    try std.testing.expectEqual(@as(u8, 1), interleaved[0][0]);
    try std.testing.expectEqual(@as(u8, 3), interleaved[0][1]);
    try std.testing.expectEqual(@as(u8, 15), interleaved[0][7]);
    try std.testing.expectEqual(@as(u8, 2), interleaved[1][0]);
    try std.testing.expectEqual(@as(u8, 4), interleaved[1][1]);
    try std.testing.expectEqual(@as(u8, 16), interleaved[1][7]);
}
