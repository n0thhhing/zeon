const std = @import("std");
const builtin = @import("builtin");
const arch = @import("../arch.zig");
const endianness = builtin.target.cpu.arch.endian();
const types = @import("../types.zig");
const common = @import("../common.zig");

/// Load multiple single-element structures to one, two, three, or four registers
/// TODO: The inline assembly implementation wouldnt be optimal in this
///       case, as inline assembly may hinder optimization opportunities.
///       For example, using `vld1q_u8(mem_addr + 2)` with the assembly
///       implementation would compile into two instructions: one to
///       increment the pointer and another to perform the load. However,
///       the optimal solution would involve a single instruction that
///       uses an immediate offset to load the values directly into the
///       registers, which the fallback implementation allows.
pub inline fn vld1q_u8(mem_addr: [*]const u8) types.u8x16 {
    return .{ mem_addr[0], mem_addr[1], mem_addr[2], mem_addr[3], mem_addr[4], mem_addr[5], mem_addr[6], mem_addr[7], mem_addr[8], mem_addr[9], mem_addr[10], mem_addr[11], mem_addr[12], mem_addr[13], mem_addr[14], mem_addr[15] };
        // This fixes the issue where zig throws an error
        // for out of bounds access and still compiles down
        // to the target instruction, but im not going to
        // worry about this for now...
        // @setRuntimeSafety(false);
        // var buffer: [16]u8 = undefined;
        // @memcpy(buffer[0..16], mem_addr);
        // return buffer[0..16].*;
}

test vld1q_u8 {
    const addr = ([16]u8{ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, std.math.maxInt(u8) })[0..].ptr;
    const expected: types.u8x16 = .{ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, std.math.maxInt(u8) };

    try common.testIntrinsic("vld1q_u8", vld1q_u8, expected, .{addr}, null);
}

/// Load multiple single-element structures to one, two, three, or four registers
pub inline fn vld1q_u16(mem_addr: [*]const u16) types.u16x8 {
    return .{ mem_addr[0], mem_addr[1], mem_addr[2], mem_addr[3], mem_addr[4], mem_addr[5], mem_addr[6], mem_addr[7] };
}

test vld1q_u16 {
    const addr = ([8]u16{ 0, 1, 2, 3, 4, 5, 6, std.math.maxInt(u16) })[0..].ptr;
    const expected: types.u16x8 = .{ 0, 1, 2, 3, 4, 5, 6, std.math.maxInt(u16) };

    try common.testIntrinsic("vld1q_u16", vld1q_u16, expected, .{addr}, null);
}

/// Load multiple single-element structures to one, two, three, or four registers
pub inline fn vld1q_u32(mem_addr: [*]const u32) types.u32x4 {
    return .{ mem_addr[0], mem_addr[1], mem_addr[2], mem_addr[3] };
}

test vld1q_u32 {
    const addr = ([4]u32{ 0, 1, 2, std.math.maxInt(u32) })[0..].ptr;
    const expected: types.u32x4 = .{ 0, 1, 2, std.math.maxInt(u32) };

    try common.testIntrinsic("vld1q_u32", vld1q_u32, expected, .{addr}, null);
}

/// Load multiple single-element structures to one, two, three, or four registers
pub inline fn vld1q_u64(mem_addr: [*]const u64) types.u64x2 {
    return .{ mem_addr[0], mem_addr[1] };
}

test vld1q_u64 {
    const addr = ([2]u64{ 0, std.math.maxInt(u64) })[0..].ptr;
    const expected: types.u64x2 = .{ 0, std.math.maxInt(u64) };

    try common.testIntrinsic("vld1q_u64", vld1q_u64, expected, .{addr}, null);
}

/// Load multiple single-element structures to one, two, three, or four registers
pub inline fn vld1q_s8(mem_addr: [*]const i8) types.i8x16 {
    return .{ mem_addr[0], mem_addr[1], mem_addr[2], mem_addr[3], mem_addr[4], mem_addr[5], mem_addr[6], mem_addr[7], mem_addr[8], mem_addr[9], mem_addr[10], mem_addr[11], mem_addr[12], mem_addr[13], mem_addr[14], mem_addr[15] };
}

test vld1q_s8 {
    const addr = ([16]i8{ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, std.math.maxInt(i8) })[0..].ptr;
    const expected: types.i8x16 = .{ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, std.math.maxInt(i8) };

    try common.testIntrinsic("vld1q_s8", vld1q_s8, expected, .{addr}, null);
}

/// Load multiple single-element structures to one, two, three, or four registers
pub inline fn vld1q_s16(mem_addr: [*]const i16) types.i16x8 {
    return .{ mem_addr[0], mem_addr[1], mem_addr[2], mem_addr[3], mem_addr[4], mem_addr[5], mem_addr[6], mem_addr[7] };
}

test vld1q_s16 {
    const addr = ([8]i16{ 0, 1, 2, 3, 4, 5, 6, std.math.maxInt(i16) })[0..].ptr;
    const expected: types.i16x8 = .{ 0, 1, 2, 3, 4, 5, 6, std.math.maxInt(i16) };

    try common.testIntrinsic("vld1q_s16", vld1q_s16, expected, .{addr}, null);
}

/// Load multiple single-element structures to one, two, three, or four registers
pub inline fn vld1q_s32(mem_addr: [*]const i32) types.i32x4 {
    return .{ mem_addr[0], mem_addr[1], mem_addr[2], mem_addr[3] };
}

test vld1q_s32 {
    const addr = ([4]i32{ 0, 1, 2, std.math.maxInt(i32) })[0..].ptr;
    const expected: types.i32x4 = .{ 0, 1, 2, std.math.maxInt(i32) };

    try common.testIntrinsic("vld1q_s32", vld1q_s32, expected, .{addr}, null);
}

/// Load multiple single-element structures to one, two, three, or four registers
pub inline fn vld1q_s64(mem_addr: [*]const i64) types.i64x2 {
    return .{ mem_addr[0], mem_addr[1] };
}

test vld1q_s64 {
    const addr = ([2]i64{ 0, std.math.maxInt(i64) })[0..].ptr;
    const expected: types.i64x2 = .{ 0, std.math.maxInt(i64) };

    try common.testIntrinsic("vld1q_s64", vld1q_s64, expected, .{addr}, null);
}

/// Load multiple single-element structures to one, two, three, or four registers
pub inline fn vld1q_f32(mem_addr: [*]const f32) types.f32x4 {
    return .{ mem_addr[0], mem_addr[1], mem_addr[2], mem_addr[3] };
}

test vld1q_f32 {
    const addr = ([4]f32{ 0, 1, 2, std.math.floatMax(f32) })[0..].ptr;
    const expected: types.f32x4 = .{ 0, 1, 2, std.math.floatMax(f32) };

    try common.testIntrinsic("vld1q_f32", vld1q_f32, expected, .{addr}, null);
}

/// Load multiple single-element structures to one, two, three, or four registers
pub inline fn vld1q_f64(mem_addr: [*]const f64) types.f64x2 {
    return .{ mem_addr[0], mem_addr[1] };
}

test vld1q_f64 {
    const addr = ([2]f64{ 0, std.math.floatMax(f64) })[0..].ptr;
    const expected: types.f64x2 = .{ 0, std.math.floatMax(f64) };

    try common.testIntrinsic("vld1q_f64", vld1q_f64, expected, .{addr}, null);
}

/// Store multiple single-element structures from one, two, three, or four registers
pub inline fn vst1q_u8(mem_addr: [*]u8, vec: types.u8x16) void {
    const a: [16]u8 = vec;
        mem_addr[0..16].* = a;
}

test vst1q_u8 {
    const vec: types.u8x16 = .{ 87, 7, 66, 94, 76, 60, 92, 164, 117, 14, 58, 249, 14, 224, 177, 97 };
    var result: [16]u8 = undefined;
    const expected: [16]u8 = .{ 87, 7, 66, 94, 76, 60, 92, 164, 117, 14, 58, 249, 14, 224, 177, 97 };

    try common.testIntrinsic("vst1q_u8", vst1q_u8, expected, .{ result[0..].ptr, vec }, &result);
}

/// Store multiple single-element structures from one, two, three, or four registers
pub inline fn vst1q_u16(mem_addr: [*]u16, vec: types.u16x8) void {
    const a: [8]u16 = vec;
        mem_addr[0..8].* = a;
}

test vst1q_u16 {
    const vec: types.u16x8 = .{ 29455, 5763, 22951, 12746, 53163, 34315, 47952, 42506 };
    var result: [8]u16 = undefined;
    const expected: [8]u16 = .{ 29455, 5763, 22951, 12746, 53163, 34315, 47952, 42506 };

    try common.testIntrinsic("vst1q_u16", vst1q_u16, expected, .{ result[0..].ptr, vec }, &result);
}

/// Store multiple single-element structures from one, two, three, or four registers
pub inline fn vst1q_u32(mem_addr: [*]u32, vec: types.u32x4) void {
    const a: [4]u32 = vec;
        mem_addr[0..4].* = a;
}

test vst1q_u32 {
    const vec: types.u32x4 = .{ 3180044669, 3392582875, 1914261745, 906567832 };
    var result: [4]u32 = undefined;
    const expected: [4]u32 = .{ 3180044669, 3392582875, 1914261745, 906567832 };

    try common.testIntrinsic("vst1q_u32", vst1q_u32, expected, .{ result[0..].ptr, vec }, &result);
}

/// Store multiple single-element structures from one, two, three, or four registers
pub inline fn vst1q_u64(mem_addr: [*]u64, vec: types.u64x2) void {
    const a: [2]u64 = vec;
        mem_addr[0..2].* = a;
}

test vst1q_u64 {
    const vec: types.u64x2 = .{ 3829217874799001600, 2533292073724029000 };
    var result: [2]u64 = undefined;
    const expected: [2]u64 = .{ 3829217874799001600, 2533292073724029000 };

    try common.testIntrinsic("vst1q_u64", vst1q_u64, expected, .{ result[0..].ptr, vec }, &result);
}

/// Store multiple single-element structures from one, two, three, or four registers
pub inline fn vst1q_s8(mem_addr: [*]i8, vec: types.i8x16) void {
    const a: [16]i8 = vec;
        mem_addr[0..16].* = a;
}

test vst1q_s8 {
    const vec: types.i8x16 = .{ 75, 36, 6, 85, 22, 75, 44, 100, 116, 47, 61, 71, 119, 72, 64, 11 };
    var result: [16]i8 = undefined;
    const expected: [16]i8 = .{ 75, 36, 6, 85, 22, 75, 44, 100, 116, 47, 61, 71, 119, 72, 64, 11 };

    try common.testIntrinsic("vst1q_s8", vst1q_s8, expected, .{ result[0..].ptr, vec }, &result);
}

/// Store multiple single-element structures from one, two, three, or four registers
pub inline fn vst1q_s16(mem_addr: [*]i16, vec: types.i16x8) void {
    const a: [8]i16 = vec;
        mem_addr[0..8].* = a;
}

test vst1q_s16 {
    const vec: types.i16x8 = .{ 6747, 3471, 19603, 32482, 30815, 18526, 26523, 13944 };
    var result: [8]i16 = undefined;
    const expected: [8]i16 = .{ 6747, 3471, 19603, 32482, 30815, 18526, 26523, 13944 };

    try common.testIntrinsic("vst1q_s16", vst1q_s16, expected, .{ result[0..].ptr, vec }, &result);
}

/// Store multiple single-element structures from one, two, three, or four registers
pub inline fn vst1q_s32(mem_addr: [*]i32, vec: types.i32x4) void {
    const a: [4]i32 = vec;
        mem_addr[0..4].* = a;
}

test vst1q_s32 {
    const vec: types.i32x4 = .{ 145830768, 1580484351, 1402177468, 1969206225 };
    var result: [4]i32 = undefined;
    const expected: [4]i32 = .{ 145830768, 1580484351, 1402177468, 1969206225 };

    try common.testIntrinsic("vst1q_s32", vst1q_s32, expected, .{ result[0..].ptr, vec }, &result);
}

/// Store multiple single-element structures from one, two, three, or four registers
pub inline fn vst1q_s64(mem_addr: [*]i64, vec: types.i64x2) void {
    const a: [2]i64 = vec;
        mem_addr[0..2].* = a;
}

test vst1q_s64 {
    const vec: types.i64x2 = .{ 4686198271250203000, 6004792972826735000 };
    var result: [2]i64 = undefined;
    const expected: [2]i64 = .{ 4686198271250203000, 6004792972826735000 };

    try common.testIntrinsic("vst1q_s64", vst1q_s64, expected, .{ result[0..].ptr, vec }, &result);
}

/// Store multiple single-element structures from one, two, three, or four registers
pub inline fn vst1q_p8(mem_addr: [*]types.p8, vec: types.p8x16) void {
    const a: [16]types.p8 = vec;
        mem_addr[0..16].* = a;
}

test vst1q_p8 {
    const vec: types.p8x16 = .{ 143, 78, 26, 229, 142, 239, 26, 113, 27, 52, 212, 81, 86, 171, 140, 40 };
    var result: [16]types.p8 = undefined;
    const expected: [16]types.p8 = .{ 143, 78, 26, 229, 142, 239, 26, 113, 27, 52, 212, 81, 86, 171, 140, 40 };

    try common.testIntrinsic("vst1q_p8", vst1q_p8, expected, .{ result[0..].ptr, vec }, &result);
}

/// Store multiple single-element structures from one, two, three, or four registers
pub inline fn vst1q_p16(mem_addr: [*]types.p16, vec: types.p16x8) void {
    const a: [8]types.p16 = vec;
        mem_addr[0..8].* = a;
}

test vst1q_p16 {
    const vec: types.p16x8 = .{ 63916, 47385, 18732, 19304, 846, 25686, 17032, 5781 };
    var result: [8]types.p16 = undefined;
    const expected: [8]types.p16 = .{ 63916, 47385, 18732, 19304, 846, 25686, 17032, 5781 };

    try common.testIntrinsic("vst1q_p16", vst1q_p16, expected, .{ result[0..].ptr, vec }, &result);
}

/// Store multiple single-element structures from one, two, three, or four registers
pub inline fn vst1q_p46(mem_addr: [*]types.p64, vec: types.p64x2) void {
    const a: [2]types.p64 = vec;
        mem_addr[0..2].* = a;
}

test vst1q_p46 {
    const vec: types.p64x2 = .{ 15170803338505576000, 1743042069843003400 };

    var result: [2]types.p64 = undefined;
    const expected: [2]types.p64 = .{ 15170803338505576000, 1743042069843003400 };

    try common.testIntrinsic("vst1q_p46", vst1q_p46, expected, .{ result[0..].ptr, vec }, &result);
}

/// Store multiple single-element structures from one, two, three, or four registers
pub inline fn vst1q_f32(mem_addr: [*]f32, vec: types.f32x4) void {
    const a: [4]f32 = vec;
        mem_addr[0..4].* = a;
}

test vst1q_f32 {
    const vec: types.f32x4 = .{ 1.9548056513544903e+38, 2.332183452987896e+38, 1.6590733076880947e+38, 7.974587841002587e+37 };
    var result: [4]f32 = undefined;
    const expected: [4]f32 = .{ 1.9548056513544903e+38, 2.332183452987896e+38, 1.6590733076880947e+38, 7.974587841002587e+37 };

    try common.testIntrinsic("vst1q_f32", vst1q_f32, expected, .{ result[0..].ptr, vec }, &result);
}

/// Store multiple single-element structures from one, two, three, or four registers
pub inline fn vst1q_f64(mem_addr: [*]f64, vec: types.f64x2) void {
    const a: [2]f64 = vec;
        mem_addr[0..2].* = a;
}

test vst1q_f64 {
    const vec: types.f64x2 = .{ 8.485324487224609e+307, 1.0542911763881099e+308 };
    var result: [2]f64 = undefined;
    const expected: [2]f64 = .{ 8.485324487224609e+307, 1.0542911763881099e+308 };

    try common.testIntrinsic("vst1q_f64", vst1q_f64, expected, .{ result[0..].ptr, vec }, &result);
}
