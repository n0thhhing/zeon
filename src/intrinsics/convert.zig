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

// --- Vector Move Long (VMOVL: 64-bit vector to 128-bit vector) ---
pub inline fn vmovl_s8(a: i8x8) i16x8 { return a; }
pub inline fn vmovl_s16(a: i16x4) i32x4 { return a; }
pub inline fn vmovl_s32(a: i32x2) i64x2 { return a; }
pub inline fn vmovl_u8(a: u8x8) u16x8 { return a; }
pub inline fn vmovl_u16(a: u16x4) u32x4 { return a; }
pub inline fn vmovl_u32(a: u32x2) u64x2 { return a; }

// --- Vector Move Long High (VMOVL_HIGH: Upper half of 128-bit to 128-bit) ---
pub inline fn vmovl_high_s8(a: i8x16) i16x8 {
    const high: i8x8 = @shuffle(i8, a, undefined, i8x8{ 8, 9, 10, 11, 12, 13, 14, 15 });
    return high;
}
pub inline fn vmovl_high_s16(a: i16x8) i32x4 {
    const high: i16x4 = @shuffle(i16, a, undefined, i16x4{ 4, 5, 6, 7 });
    return high;
}
pub inline fn vmovl_high_s32(a: i32x4) i64x2 {
    const high: i32x2 = @shuffle(i32, a, undefined, i32x2{ 2, 3 });
    return high;
}
pub inline fn vmovl_high_u8(a: u8x16) u16x8 {
    const high: u8x8 = @shuffle(u8, a, undefined, u8x8{ 8, 9, 10, 11, 12, 13, 14, 15 });
    return high;
}
pub inline fn vmovl_high_u16(a: u16x8) u32x4 {
    const high: u16x4 = @shuffle(u16, a, undefined, u16x4{ 4, 5, 6, 7 });
    return high;
}
pub inline fn vmovl_high_u32(a: u32x4) u64x2 {
    const high: u32x2 = @shuffle(u32, a, undefined, u32x2{ 2, 3 });
    return high;
}

// --- Vector Move Narrow (VMOVN: 128-bit vector to 64-bit vector) ---
pub inline fn vmovn_s16(a: i16x8) i8x8 {
    var res: i8x8 = undefined;
    inline for (0..8) |i| res[i] = @truncate(a[i]);
    return res;
}
pub inline fn vmovn_s32(a: i32x4) i16x4 {
    var res: i16x4 = undefined;
    inline for (0..4) |i| res[i] = @truncate(a[i]);
    return res;
}
pub inline fn vmovn_s64(a: i64x2) i32x2 {
    var res: i32x2 = undefined;
    inline for (0..2) |i| res[i] = @truncate(a[i]);
    return res;
}
pub inline fn vmovn_u16(a: u16x8) u8x8 {
    var res: u8x8 = undefined;
    inline for (0..8) |i| res[i] = @truncate(a[i]);
    return res;
}
pub inline fn vmovn_u32(a: u32x4) u16x4 {
    var res: u16x4 = undefined;
    inline for (0..4) |i| res[i] = @truncate(a[i]);
    return res;
}
pub inline fn vmovn_u64(a: u64x2) u32x2 {
    var res: u32x2 = undefined;
    inline for (0..2) |i| res[i] = @truncate(a[i]);
    return res;
}

// --- Float / Integer Conversion ---
pub inline fn vcvt_f32_s32(a: i32x2) f32x2 { return @floatFromInt(a); }
pub inline fn vcvt_f32_u32(a: u32x2) f32x2 { return @floatFromInt(a); }
pub inline fn vcvt_s32_f32(a: f32x2) i32x2 {
    if (comptime @import("builtin").cpu.arch == .aarch64) {
        return asm ("fcvtzs %[res].2s, %[a].2s" : [res] "=w" (-> i32x2) : [a] "w" (a));
    }
    var res: i32x2 = undefined;
    inline for (0..2) |i| {
        const v = a[i];
        if (v >= @as(f32, @floatFromInt(std.math.maxInt(i32))) or v <= @as(f32, @floatFromInt(std.math.minInt(i32)))) {
            res[i] = if (v < 0.0) std.math.minInt(i32) else std.math.maxInt(i32);
        } else {
            res[i] = @intFromFloat(v);
        }
    }
    return res;
}
pub inline fn vcvt_u32_f32(a: f32x2) u32x2 {
    if (comptime @import("builtin").cpu.arch == .aarch64) {
        return asm ("fcvtzu %[res].2s, %[a].2s" : [res] "=w" (-> u32x2) : [a] "w" (a));
    }
    var res: u32x2 = undefined;
    inline for (0..2) |i| {
        const v = a[i];
        if (v < 0.0 or v > @as(f32, @floatFromInt(std.math.maxInt(u32)))) {
            res[i] = if (v < 0.0) 0 else std.math.maxInt(u32);
        } else {
            res[i] = @intFromFloat(v);
        }
    }
    return res;
}

pub inline fn vcvtq_f32_s32(a: i32x4) f32x4 { return @floatFromInt(a); }
pub inline fn vcvtq_f32_u32(a: u32x4) f32x4 { return @floatFromInt(a); }
pub inline fn vcvtq_s32_f32(a: f32x4) i32x4 {
    if (comptime @import("builtin").cpu.arch == .aarch64) {
        return asm ("fcvtzs %[res].4s, %[a].4s" : [res] "=w" (-> i32x4) : [a] "w" (a));
    }
    var res: i32x4 = undefined;
    inline for (0..4) |i| {
        const v = a[i];
        if (v >= @as(f32, @floatFromInt(std.math.maxInt(i32))) or v <= @as(f32, @floatFromInt(std.math.minInt(i32)))) {
            res[i] = if (v < 0.0) std.math.minInt(i32) else std.math.maxInt(i32);
        } else {
            res[i] = @intFromFloat(v);
        }
    }
    return res;
}
pub inline fn vcvtq_u32_f32(a: f32x4) u32x4 {
    if (comptime @import("builtin").cpu.arch == .aarch64) {
        return asm ("fcvtzu %[res].4s, %[a].4s" : [res] "=w" (-> u32x4) : [a] "w" (a));
    }
    var res: u32x4 = undefined;
    inline for (0..4) |i| {
        const v = a[i];
        if (v < 0.0 or v > @as(f32, @floatFromInt(std.math.maxInt(u32)))) {
            res[i] = if (v < 0.0) 0 else std.math.maxInt(u32);
        } else {
            res[i] = @intFromFloat(v);
        }
    }
    return res;
}

pub inline fn vcvtq_f64_s64(a: i64x2) f64x2 { return @floatFromInt(a); }
pub inline fn vcvtq_f64_u64(a: u64x2) f64x2 { return @floatFromInt(a); }
pub inline fn vcvtq_s64_f64(a: f64x2) i64x2 {
    if (comptime @import("builtin").cpu.arch == .aarch64) {
        return asm ("fcvtzs %[res].2d, %[a].2d" : [res] "=w" (-> i64x2) : [a] "w" (a));
    }
    var res: i64x2 = undefined;
    inline for (0..2) |i| {
        if (a[i] >= @as(f64, std.math.maxInt(i64)) or a[i] <= @as(f64, std.math.minInt(i64))) {
            res[i] = if (a[i] < 0) std.math.minInt(i64) else std.math.maxInt(i64);
        } else {
            res[i] = @intFromFloat(a[i]);
        }
    }
    return res;
}
pub inline fn vcvtq_u64_f64(a: f64x2) u64x2 {
    if (comptime @import("builtin").cpu.arch == .aarch64) {
        return asm ("fcvtzu %[res].2d, %[a].2d" : [res] "=w" (-> u64x2) : [a] "w" (a));
    }
    var res: u64x2 = undefined;
    inline for (0..2) |i| {
        if (a[i] < 0.0 or a[i] > @as(f64, @floatFromInt(std.math.maxInt(u64)))) {
            res[i] = if (a[i] < 0.0) 0 else std.math.maxInt(u64);
        } else {
            res[i] = @intFromFloat(a[i]);
        }
    }
    return res;
}

// --- Reinterpret Casts ---
pub inline fn vreinterpret_s8_u8(a: u8x8) i8x8 { return @bitCast(a); }
pub inline fn vreinterpret_u8_s8(a: i8x8) u8x8 { return @bitCast(a); }
pub inline fn vreinterpret_s16_u16(a: u16x4) i16x4 { return @bitCast(a); }
pub inline fn vreinterpret_u16_s16(a: i16x4) u16x4 { return @bitCast(a); }
pub inline fn vreinterpret_s32_u32(a: u32x2) i32x2 { return @bitCast(a); }
pub inline fn vreinterpret_u32_s32(a: i32x2) u32x2 { return @bitCast(a); }
pub inline fn vreinterpret_f32_s32(a: i32x2) f32x2 { return @bitCast(a); }
pub inline fn vreinterpret_s32_f32(a: f32x2) i32x2 { return @bitCast(a); }
pub inline fn vreinterpret_f32_u32(a: u32x2) f32x2 { return @bitCast(a); }
pub inline fn vreinterpret_u32_f32(a: f32x2) u32x2 { return @bitCast(a); }

pub inline fn vreinterpretq_s8_u8(a: u8x16) i8x16 { return @bitCast(a); }
pub inline fn vreinterpretq_u8_s8(a: i8x16) u8x16 { return @bitCast(a); }
pub inline fn vreinterpretq_s16_u16(a: u16x8) i16x8 { return @bitCast(a); }
pub inline fn vreinterpretq_u16_s16(a: i16x8) u16x8 { return @bitCast(a); }
pub inline fn vreinterpretq_s32_u32(a: u32x4) i32x4 { return @bitCast(a); }
pub inline fn vreinterpretq_u32_s32(a: i32x4) u32x4 { return @bitCast(a); }
pub inline fn vreinterpretq_s64_u64(a: u64x2) i64x2 { return @bitCast(a); }
pub inline fn vreinterpretq_u64_s64(a: i64x2) u64x2 { return @bitCast(a); }
pub inline fn vreinterpretq_f32_s32(a: i32x4) f32x4 { return @bitCast(a); }
pub inline fn vreinterpretq_s32_f32(a: f32x4) i32x4 { return @bitCast(a); }
pub inline fn vreinterpretq_f32_u32(a: u32x4) f32x4 { return @bitCast(a); }
pub inline fn vreinterpretq_u32_f32(a: f32x4) u32x4 { return @bitCast(a); }
pub inline fn vreinterpretq_f64_s64(a: i64x2) f64x2 { return @bitCast(a); }
pub inline fn vreinterpretq_s64_f64(a: f64x2) i64x2 { return @bitCast(a); }
pub inline fn vreinterpretq_f64_u64(a: u64x2) f64x2 { return @bitCast(a); }
pub inline fn vreinterpretq_u64_f64(a: f64x2) u64x2 { return @bitCast(a); }

test "convert intrinsics" {
    const a: i8x8 = .{ 1, 2, 3, 4, 5, 6, 7, 8 };
    const w = vmovl_s8(a);
    try std.testing.expectEqual(i16x8{ 1, 2, 3, 4, 5, 6, 7, 8 }, w);

    const n = vmovn_s16(w);
    try std.testing.expectEqual(a, n);
}
