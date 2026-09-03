const std = @import("std");
const arch = @import("../arch.zig");
const types = @import("../types.zig");
const common = @import("../common.zig");

/// Floating-point absolute compare greater than or equal
pub inline fn vcage_f32(a: types.f32x2, b: types.f32x2) types.u32x2 {
    const comparison = @abs(a) >= @abs(b);
    return @select(u32, comparison, @as(types.u32x2, @splat(0xffffffff)), @as(types.u32x2, @splat(0x00000000)));
}

test vcage_f32 {
    const a = types.f32x2{ 1.0, -2.0 };
    const b = types.f32x2{ 1.5, 2.0 };
    const expected = types.u32x2{ 0x00000000, 0xffffffff };

    try common.testIntrinsic("vcage_f32", vcage_f32, expected, .{ a, b }, null);
}

/// Floating-point absolute compare greater than or equal
pub inline fn vcage_f64(a: types.f64x1, b: types.f64x1) types.u64x1 {
    const comparison = @abs(a) >= @abs(b);
    return @select(u64, comparison, @as(types.u64x1, @splat(0xffffffffffffffff)), @as(types.u64x1, @splat(0x0000000000000000)));
}

test vcage_f64 {
    const a = types.f64x1{-2.0};
    const b = types.f64x1{2.0};
    const expected = types.u64x1{0xffffffffffffffff};

    try common.testIntrinsic("vcage_f64", vcage_f64, expected, .{ a, b }, null);
}

/// Floating-point absolute compare greater than or equal
pub inline fn vcageq_f32(a: types.f32x4, b: types.f32x4) types.u32x4 {
    const comparison = @abs(a) >= @abs(b);
    return @select(u32, comparison, @as(types.u32x4, @splat(0xffffffff)), @as(types.u32x4, @splat(0x00000000)));
}

test vcageq_f32 {
    const a = types.f32x4{ 1.0, -2.0, 3.0, -4.0 };
    const b = types.f32x4{ 1.5, 2.0, -2.5, 4.0 };
    const expected = types.u32x4{ 0x00000000, 0xffffffff, 0xffffffff, 0xffffffff };

    try common.testIntrinsic("vcageq_f32", vcageq_f32, expected, .{ a, b }, null);
}

/// Floating-point absolute compare greater than or equal
pub inline fn vcageq_f64(a: types.f64x2, b: types.f64x2) types.u64x2 {
    const comparison = @abs(a) >= @abs(b);
    return @select(u64, comparison, @as(types.u64x2, @splat(0xffffffffffffffff)), @as(types.u64x2, @splat(0x0000000000000000)));
}

test vcageq_f64 {
    const a = types.f64x2{ 1.0, -4.0 };
    const b = types.f64x2{ 1.5, 3.0 };
    const expected = types.u64x2{ 0x0000000000000000, 0xffffffffffffffff };

    try common.testIntrinsic("vcageq_f64", vcageq_f64, expected, .{ a, b }, null);
}

/// Floating-point absolute compare greater than
pub inline fn vcagt_f32(a: types.f32x2, b: types.f32x2) types.u32x2 {
    const comparison = @abs(a) > @abs(b);
    return @select(u32, comparison, @as(types.u32x2, @splat(0xffffffff)), @as(types.u32x2, @splat(0x00000000)));
}

test vcagt_f32 {
    const a = types.f32x2{ -1.2, 0.0 };
    const b = types.f32x2{ -1.1, 0.0 };
    const expected = types.u32x2{ 0xffffffff, 0x00000000 };

    try common.testIntrinsic("vcagt_f32", vcagt_f32, expected, .{ a, b }, null);
}

/// Floating-point absolute compare greater than
pub inline fn vcagt_f64(a: types.f64x1, b: types.f64x1) types.u64x1 {
    const comparison = @abs(a) > @abs(b);
    return @select(u64, comparison, @as(types.u64x1, @splat(0xffffffffffffffff)), @as(types.u64x1, @splat(0x0000000000000000)));
}

test vcagt_f64 {
    const a = types.f64x1{-1.2};
    const b = types.f64x1{-1.1};
    const expected = types.u64x1{0xffffffffffffffff};

    try common.testIntrinsic("vcagt_f64", vcagt_f64, expected, .{ a, b }, null);
}

// --- Auto-generated Compare Equal Intrinsics ---
pub inline fn vceq_s8(a: types.i8x8, b: types.i8x8) types.u8x8 {
    const comparison = a == b;
    return @select(u8, comparison, @as(types.u8x8, @splat(0xff)), @as(types.u8x8, @splat(0)));
}

test vceq_s8 {
    const a = std.mem.zeroes(types.i8x8);
    const b = std.mem.zeroes(types.i8x8);
    const expected = @as(types.u8x8, @splat(0xff));
    try common.testIntrinsic("vceq_s8", vceq_s8, expected, .{ a, b }, null);
}
pub inline fn vceqq_s8(a: types.i8x16, b: types.i8x16) types.u8x16 {
    const comparison = a == b;
    return @select(u8, comparison, @as(types.u8x16, @splat(0xff)), @as(types.u8x16, @splat(0)));
}

test vceqq_s8 {
    const a = std.mem.zeroes(types.i8x16);
    const b = std.mem.zeroes(types.i8x16);
    const expected = @as(types.u8x16, @splat(0xff));
    try common.testIntrinsic("vceqq_s8", vceqq_s8, expected, .{ a, b }, null);
}
pub inline fn vceq_s16(a: types.i16x4, b: types.i16x4) types.u16x4 {
    const comparison = a == b;
    return @select(u16, comparison, @as(types.u16x4, @splat(0xffff)), @as(types.u16x4, @splat(0)));
}

test vceq_s16 {
    const a = std.mem.zeroes(types.i16x4);
    const b = std.mem.zeroes(types.i16x4);
    const expected = @as(types.u16x4, @splat(0xffff));
    try common.testIntrinsic("vceq_s16", vceq_s16, expected, .{ a, b }, null);
}
pub inline fn vceqq_s16(a: types.i16x8, b: types.i16x8) types.u16x8 {
    const comparison = a == b;
    return @select(u16, comparison, @as(types.u16x8, @splat(0xffff)), @as(types.u16x8, @splat(0)));
}

test vceqq_s16 {
    const a = std.mem.zeroes(types.i16x8);
    const b = std.mem.zeroes(types.i16x8);
    const expected = @as(types.u16x8, @splat(0xffff));
    try common.testIntrinsic("vceqq_s16", vceqq_s16, expected, .{ a, b }, null);
}
pub inline fn vceq_s32(a: types.i32x2, b: types.i32x2) types.u32x2 {
    const comparison = a == b;
    return @select(u32, comparison, @as(types.u32x2, @splat(0xffffffff)), @as(types.u32x2, @splat(0)));
}

test vceq_s32 {
    const a = std.mem.zeroes(types.i32x2);
    const b = std.mem.zeroes(types.i32x2);
    const expected = @as(types.u32x2, @splat(0xffffffff));
    try common.testIntrinsic("vceq_s32", vceq_s32, expected, .{ a, b }, null);
}
pub inline fn vceqq_s32(a: types.i32x4, b: types.i32x4) types.u32x4 {
    const comparison = a == b;
    return @select(u32, comparison, @as(types.u32x4, @splat(0xffffffff)), @as(types.u32x4, @splat(0)));
}

test vceqq_s32 {
    const a = std.mem.zeroes(types.i32x4);
    const b = std.mem.zeroes(types.i32x4);
    const expected = @as(types.u32x4, @splat(0xffffffff));
    try common.testIntrinsic("vceqq_s32", vceqq_s32, expected, .{ a, b }, null);
}
pub inline fn vceq_s64(a: types.i64x1, b: types.i64x1) types.u64x1 {
    const comparison = a == b;
    return @select(u64, comparison, @as(types.u64x1, @splat(0xffffffffffffffff)), @as(types.u64x1, @splat(0)));
}

test vceq_s64 {
    const a = std.mem.zeroes(types.i64x1);
    const b = std.mem.zeroes(types.i64x1);
    const expected = @as(types.u64x1, @splat(0xffffffffffffffff));
    try common.testIntrinsic("vceq_s64", vceq_s64, expected, .{ a, b }, null);
}
pub inline fn vceqq_s64(a: types.i64x2, b: types.i64x2) types.u64x2 {
    const comparison = a == b;
    return @select(u64, comparison, @as(types.u64x2, @splat(0xffffffffffffffff)), @as(types.u64x2, @splat(0)));
}

test vceqq_s64 {
    const a = std.mem.zeroes(types.i64x2);
    const b = std.mem.zeroes(types.i64x2);
    const expected = @as(types.u64x2, @splat(0xffffffffffffffff));
    try common.testIntrinsic("vceqq_s64", vceqq_s64, expected, .{ a, b }, null);
}
pub inline fn vceq_u8(a: types.u8x8, b: types.u8x8) types.u8x8 {
    const comparison = a == b;
    return @select(u8, comparison, @as(types.u8x8, @splat(0xff)), @as(types.u8x8, @splat(0)));
}

test vceq_u8 {
    const a = std.mem.zeroes(types.u8x8);
    const b = std.mem.zeroes(types.u8x8);
    const expected = @as(types.u8x8, @splat(0xff));
    try common.testIntrinsic("vceq_u8", vceq_u8, expected, .{ a, b }, null);
}
pub inline fn vceqq_u8(a: types.u8x16, b: types.u8x16) types.u8x16 {
    const comparison = a == b;
    return @select(u8, comparison, @as(types.u8x16, @splat(0xff)), @as(types.u8x16, @splat(0)));
}

test vceqq_u8 {
    const a = std.mem.zeroes(types.u8x16);
    const b = std.mem.zeroes(types.u8x16);
    const expected = @as(types.u8x16, @splat(0xff));
    try common.testIntrinsic("vceqq_u8", vceqq_u8, expected, .{ a, b }, null);
}
pub inline fn vceq_u16(a: types.u16x4, b: types.u16x4) types.u16x4 {
    const comparison = a == b;
    return @select(u16, comparison, @as(types.u16x4, @splat(0xffff)), @as(types.u16x4, @splat(0)));
}

test vceq_u16 {
    const a = std.mem.zeroes(types.u16x4);
    const b = std.mem.zeroes(types.u16x4);
    const expected = @as(types.u16x4, @splat(0xffff));
    try common.testIntrinsic("vceq_u16", vceq_u16, expected, .{ a, b }, null);
}
pub inline fn vceqq_u16(a: types.u16x8, b: types.u16x8) types.u16x8 {
    const comparison = a == b;
    return @select(u16, comparison, @as(types.u16x8, @splat(0xffff)), @as(types.u16x8, @splat(0)));
}

test vceqq_u16 {
    const a = std.mem.zeroes(types.u16x8);
    const b = std.mem.zeroes(types.u16x8);
    const expected = @as(types.u16x8, @splat(0xffff));
    try common.testIntrinsic("vceqq_u16", vceqq_u16, expected, .{ a, b }, null);
}
pub inline fn vceq_u32(a: types.u32x2, b: types.u32x2) types.u32x2 {
    const comparison = a == b;
    return @select(u32, comparison, @as(types.u32x2, @splat(0xffffffff)), @as(types.u32x2, @splat(0)));
}

test vceq_u32 {
    const a = std.mem.zeroes(types.u32x2);
    const b = std.mem.zeroes(types.u32x2);
    const expected = @as(types.u32x2, @splat(0xffffffff));
    try common.testIntrinsic("vceq_u32", vceq_u32, expected, .{ a, b }, null);
}
pub inline fn vceqq_u32(a: types.u32x4, b: types.u32x4) types.u32x4 {
    const comparison = a == b;
    return @select(u32, comparison, @as(types.u32x4, @splat(0xffffffff)), @as(types.u32x4, @splat(0)));
}

test vceqq_u32 {
    const a = std.mem.zeroes(types.u32x4);
    const b = std.mem.zeroes(types.u32x4);
    const expected = @as(types.u32x4, @splat(0xffffffff));
    try common.testIntrinsic("vceqq_u32", vceqq_u32, expected, .{ a, b }, null);
}
pub inline fn vceq_u64(a: types.u64x1, b: types.u64x1) types.u64x1 {
    const comparison = a == b;
    return @select(u64, comparison, @as(types.u64x1, @splat(0xffffffffffffffff)), @as(types.u64x1, @splat(0)));
}

test vceq_u64 {
    const a = std.mem.zeroes(types.u64x1);
    const b = std.mem.zeroes(types.u64x1);
    const expected = @as(types.u64x1, @splat(0xffffffffffffffff));
    try common.testIntrinsic("vceq_u64", vceq_u64, expected, .{ a, b }, null);
}
pub inline fn vceqq_u64(a: types.u64x2, b: types.u64x2) types.u64x2 {
    const comparison = a == b;
    return @select(u64, comparison, @as(types.u64x2, @splat(0xffffffffffffffff)), @as(types.u64x2, @splat(0)));
}

test vceqq_u64 {
    const a = std.mem.zeroes(types.u64x2);
    const b = std.mem.zeroes(types.u64x2);
    const expected = @as(types.u64x2, @splat(0xffffffffffffffff));
    try common.testIntrinsic("vceqq_u64", vceqq_u64, expected, .{ a, b }, null);
}
pub inline fn vceq_f16(a: types.f16x4, b: types.f16x4) types.u16x4 {
    const comparison = a == b;
    return @select(u16, comparison, @as(types.u16x4, @splat(0xffff)), @as(types.u16x4, @splat(0)));
}

test vceq_f16 {
    const a = std.mem.zeroes(types.f16x4);
    const b = std.mem.zeroes(types.f16x4);
    const expected = @as(types.u16x4, @splat(0xffff));
    try common.testIntrinsic("vceq_f16", vceq_f16, expected, .{ a, b }, null);
}
pub inline fn vceqq_f16(a: types.f16x8, b: types.f16x8) types.u16x8 {
    const comparison = a == b;
    return @select(u16, comparison, @as(types.u16x8, @splat(0xffff)), @as(types.u16x8, @splat(0)));
}

test vceqq_f16 {
    const a = std.mem.zeroes(types.f16x8);
    const b = std.mem.zeroes(types.f16x8);
    const expected = @as(types.u16x8, @splat(0xffff));
    try common.testIntrinsic("vceqq_f16", vceqq_f16, expected, .{ a, b }, null);
}
pub inline fn vceq_f32(a: types.f32x2, b: types.f32x2) types.u32x2 {
    const comparison = a == b;
    return @select(u32, comparison, @as(types.u32x2, @splat(0xffffffff)), @as(types.u32x2, @splat(0)));
}

test vceq_f32 {
    const a = std.mem.zeroes(types.f32x2);
    const b = std.mem.zeroes(types.f32x2);
    const expected = @as(types.u32x2, @splat(0xffffffff));
    try common.testIntrinsic("vceq_f32", vceq_f32, expected, .{ a, b }, null);
}
pub inline fn vceqq_f32(a: types.f32x4, b: types.f32x4) types.u32x4 {
    const comparison = a == b;
    return @select(u32, comparison, @as(types.u32x4, @splat(0xffffffff)), @as(types.u32x4, @splat(0)));
}

test vceqq_f32 {
    const a = std.mem.zeroes(types.f32x4);
    const b = std.mem.zeroes(types.f32x4);
    const expected = @as(types.u32x4, @splat(0xffffffff));
    try common.testIntrinsic("vceqq_f32", vceqq_f32, expected, .{ a, b }, null);
}
pub inline fn vceq_f64(a: types.f64x1, b: types.f64x1) types.u64x1 {
    const comparison = a == b;
    return @select(u64, comparison, @as(types.u64x1, @splat(0xffffffffffffffff)), @as(types.u64x1, @splat(0)));
}

test vceq_f64 {
    const a = std.mem.zeroes(types.f64x1);
    const b = std.mem.zeroes(types.f64x1);
    const expected = @as(types.u64x1, @splat(0xffffffffffffffff));
    try common.testIntrinsic("vceq_f64", vceq_f64, expected, .{ a, b }, null);
}
pub inline fn vceqq_f64(a: types.f64x2, b: types.f64x2) types.u64x2 {
    const comparison = a == b;
    return @select(u64, comparison, @as(types.u64x2, @splat(0xffffffffffffffff)), @as(types.u64x2, @splat(0)));
}

test vceqq_f64 {
    const a = std.mem.zeroes(types.f64x2);
    const b = std.mem.zeroes(types.f64x2);
    const expected = @as(types.u64x2, @splat(0xffffffffffffffff));
    try common.testIntrinsic("vceqq_f64", vceqq_f64, expected, .{ a, b }, null);
}
pub inline fn vceq_p8(a: types.p8x8, b: types.p8x8) types.u8x8 {
    const comparison = a == b;
    return @select(u8, comparison, @as(types.u8x8, @splat(0xff)), @as(types.u8x8, @splat(0)));
}

test vceq_p8 {
    const a = std.mem.zeroes(types.p8x8);
    const b = std.mem.zeroes(types.p8x8);
    const expected = @as(types.u8x8, @splat(0xff));
    try common.testIntrinsic("vceq_p8", vceq_p8, expected, .{ a, b }, null);
}
pub inline fn vceqq_p8(a: types.p8x16, b: types.p8x16) types.u8x16 {
    const comparison = a == b;
    return @select(u8, comparison, @as(types.u8x16, @splat(0xff)), @as(types.u8x16, @splat(0)));
}

test vceqq_p8 {
    const a = std.mem.zeroes(types.p8x16);
    const b = std.mem.zeroes(types.p8x16);
    const expected = @as(types.u8x16, @splat(0xff));
    try common.testIntrinsic("vceqq_p8", vceqq_p8, expected, .{ a, b }, null);
}
pub inline fn vceq_p64(a: types.p64x1, b: types.p64x1) types.u64x1 {
    const comparison = a == b;
    return @select(u64, comparison, @as(types.u64x1, @splat(0xffffffffffffffff)), @as(types.u64x1, @splat(0)));
}

test vceq_p64 {
    const a = std.mem.zeroes(types.p64x1);
    const b = std.mem.zeroes(types.p64x1);
    const expected = @as(types.u64x1, @splat(0xffffffffffffffff));
    try common.testIntrinsic("vceq_p64", vceq_p64, expected, .{ a, b }, null);
}
pub inline fn vceqq_p64(a: types.p64x2, b: types.p64x2) types.u64x2 {
    const comparison = a == b;
    return @select(u64, comparison, @as(types.u64x2, @splat(0xffffffffffffffff)), @as(types.u64x2, @splat(0)));
}

test vceqq_p64 {
    const a = std.mem.zeroes(types.p64x2);
    const b = std.mem.zeroes(types.p64x2);
    const expected = @as(types.u64x2, @splat(0xffffffffffffffff));
    try common.testIntrinsic("vceqq_p64", vceqq_p64, expected, .{ a, b }, null);
}
pub inline fn vceqz_s8(a: types.i8x8) types.u8x8 {
    const comparison = a == @as(types.i8x8, @splat(0));
    return @select(u8, comparison, @as(types.u8x8, @splat(0xff)), @as(types.u8x8, @splat(0)));
}

test vceqz_s8 {
    const a = std.mem.zeroes(types.i8x8);
    const expected = @as(types.u8x8, @splat(0xff));
    try common.testIntrinsic("vceqz_s8", vceqz_s8, expected, .{a}, null);
}
pub inline fn vceqzq_s8(a: types.i8x16) types.u8x16 {
    const comparison = a == @as(types.i8x16, @splat(0));
    return @select(u8, comparison, @as(types.u8x16, @splat(0xff)), @as(types.u8x16, @splat(0)));
}

test vceqzq_s8 {
    const a = std.mem.zeroes(types.i8x16);
    const expected = @as(types.u8x16, @splat(0xff));
    try common.testIntrinsic("vceqzq_s8", vceqzq_s8, expected, .{a}, null);
}
pub inline fn vceqz_s16(a: types.i16x4) types.u16x4 {
    const comparison = a == @as(types.i16x4, @splat(0));
    return @select(u16, comparison, @as(types.u16x4, @splat(0xffff)), @as(types.u16x4, @splat(0)));
}

test vceqz_s16 {
    const a = std.mem.zeroes(types.i16x4);
    const expected = @as(types.u16x4, @splat(0xffff));
    try common.testIntrinsic("vceqz_s16", vceqz_s16, expected, .{a}, null);
}
pub inline fn vceqzq_s16(a: types.i16x8) types.u16x8 {
    const comparison = a == @as(types.i16x8, @splat(0));
    return @select(u16, comparison, @as(types.u16x8, @splat(0xffff)), @as(types.u16x8, @splat(0)));
}

test vceqzq_s16 {
    const a = std.mem.zeroes(types.i16x8);
    const expected = @as(types.u16x8, @splat(0xffff));
    try common.testIntrinsic("vceqzq_s16", vceqzq_s16, expected, .{a}, null);
}
pub inline fn vceqz_s32(a: types.i32x2) types.u32x2 {
    const comparison = a == @as(types.i32x2, @splat(0));
    return @select(u32, comparison, @as(types.u32x2, @splat(0xffffffff)), @as(types.u32x2, @splat(0)));
}

test vceqz_s32 {
    const a = std.mem.zeroes(types.i32x2);
    const expected = @as(types.u32x2, @splat(0xffffffff));
    try common.testIntrinsic("vceqz_s32", vceqz_s32, expected, .{a}, null);
}
pub inline fn vceqzq_s32(a: types.i32x4) types.u32x4 {
    const comparison = a == @as(types.i32x4, @splat(0));
    return @select(u32, comparison, @as(types.u32x4, @splat(0xffffffff)), @as(types.u32x4, @splat(0)));
}

test vceqzq_s32 {
    const a = std.mem.zeroes(types.i32x4);
    const expected = @as(types.u32x4, @splat(0xffffffff));
    try common.testIntrinsic("vceqzq_s32", vceqzq_s32, expected, .{a}, null);
}
pub inline fn vceqz_s64(a: types.i64x1) types.u64x1 {
    const comparison = a == @as(types.i64x1, @splat(0));
    return @select(u64, comparison, @as(types.u64x1, @splat(0xffffffffffffffff)), @as(types.u64x1, @splat(0)));
}

test vceqz_s64 {
    const a = std.mem.zeroes(types.i64x1);
    const expected = @as(types.u64x1, @splat(0xffffffffffffffff));
    try common.testIntrinsic("vceqz_s64", vceqz_s64, expected, .{a}, null);
}
pub inline fn vceqzq_s64(a: types.i64x2) types.u64x2 {
    const comparison = a == @as(types.i64x2, @splat(0));
    return @select(u64, comparison, @as(types.u64x2, @splat(0xffffffffffffffff)), @as(types.u64x2, @splat(0)));
}

test vceqzq_s64 {
    const a = std.mem.zeroes(types.i64x2);
    const expected = @as(types.u64x2, @splat(0xffffffffffffffff));
    try common.testIntrinsic("vceqzq_s64", vceqzq_s64, expected, .{a}, null);
}
pub inline fn vceqz_u8(a: types.u8x8) types.u8x8 {
    const comparison = a == @as(types.u8x8, @splat(0));
    return @select(u8, comparison, @as(types.u8x8, @splat(0xff)), @as(types.u8x8, @splat(0)));
}

test vceqz_u8 {
    const a = std.mem.zeroes(types.u8x8);
    const expected = @as(types.u8x8, @splat(0xff));
    try common.testIntrinsic("vceqz_u8", vceqz_u8, expected, .{a}, null);
}
pub inline fn vceqzq_u8(a: types.u8x16) types.u8x16 {
    const comparison = a == @as(types.u8x16, @splat(0));
    return @select(u8, comparison, @as(types.u8x16, @splat(0xff)), @as(types.u8x16, @splat(0)));
}

test vceqzq_u8 {
    const a = std.mem.zeroes(types.u8x16);
    const expected = @as(types.u8x16, @splat(0xff));
    try common.testIntrinsic("vceqzq_u8", vceqzq_u8, expected, .{a}, null);
}
pub inline fn vceqz_u16(a: types.u16x4) types.u16x4 {
    const comparison = a == @as(types.u16x4, @splat(0));
    return @select(u16, comparison, @as(types.u16x4, @splat(0xffff)), @as(types.u16x4, @splat(0)));
}

test vceqz_u16 {
    const a = std.mem.zeroes(types.u16x4);
    const expected = @as(types.u16x4, @splat(0xffff));
    try common.testIntrinsic("vceqz_u16", vceqz_u16, expected, .{a}, null);
}
pub inline fn vceqzq_u16(a: types.u16x8) types.u16x8 {
    const comparison = a == @as(types.u16x8, @splat(0));
    return @select(u16, comparison, @as(types.u16x8, @splat(0xffff)), @as(types.u16x8, @splat(0)));
}

test vceqzq_u16 {
    const a = std.mem.zeroes(types.u16x8);
    const expected = @as(types.u16x8, @splat(0xffff));
    try common.testIntrinsic("vceqzq_u16", vceqzq_u16, expected, .{a}, null);
}
pub inline fn vceqz_u32(a: types.u32x2) types.u32x2 {
    const comparison = a == @as(types.u32x2, @splat(0));
    return @select(u32, comparison, @as(types.u32x2, @splat(0xffffffff)), @as(types.u32x2, @splat(0)));
}

test vceqz_u32 {
    const a = std.mem.zeroes(types.u32x2);
    const expected = @as(types.u32x2, @splat(0xffffffff));
    try common.testIntrinsic("vceqz_u32", vceqz_u32, expected, .{a}, null);
}
pub inline fn vceqzq_u32(a: types.u32x4) types.u32x4 {
    const comparison = a == @as(types.u32x4, @splat(0));
    return @select(u32, comparison, @as(types.u32x4, @splat(0xffffffff)), @as(types.u32x4, @splat(0)));
}

test vceqzq_u32 {
    const a = std.mem.zeroes(types.u32x4);
    const expected = @as(types.u32x4, @splat(0xffffffff));
    try common.testIntrinsic("vceqzq_u32", vceqzq_u32, expected, .{a}, null);
}
pub inline fn vceqz_u64(a: types.u64x1) types.u64x1 {
    const comparison = a == @as(types.u64x1, @splat(0));
    return @select(u64, comparison, @as(types.u64x1, @splat(0xffffffffffffffff)), @as(types.u64x1, @splat(0)));
}

test vceqz_u64 {
    const a = std.mem.zeroes(types.u64x1);
    const expected = @as(types.u64x1, @splat(0xffffffffffffffff));
    try common.testIntrinsic("vceqz_u64", vceqz_u64, expected, .{a}, null);
}
pub inline fn vceqzq_u64(a: types.u64x2) types.u64x2 {
    const comparison = a == @as(types.u64x2, @splat(0));
    return @select(u64, comparison, @as(types.u64x2, @splat(0xffffffffffffffff)), @as(types.u64x2, @splat(0)));
}

test vceqzq_u64 {
    const a = std.mem.zeroes(types.u64x2);
    const expected = @as(types.u64x2, @splat(0xffffffffffffffff));
    try common.testIntrinsic("vceqzq_u64", vceqzq_u64, expected, .{a}, null);
}
pub inline fn vceqz_f16(a: types.f16x4) types.u16x4 {
    const comparison = a == @as(types.f16x4, @splat(0));
    return @select(u16, comparison, @as(types.u16x4, @splat(0xffff)), @as(types.u16x4, @splat(0)));
}

test vceqz_f16 {
    const a = std.mem.zeroes(types.f16x4);
    const expected = @as(types.u16x4, @splat(0xffff));
    try common.testIntrinsic("vceqz_f16", vceqz_f16, expected, .{a}, null);
}
pub inline fn vceqzq_f16(a: types.f16x8) types.u16x8 {
    const comparison = a == @as(types.f16x8, @splat(0));
    return @select(u16, comparison, @as(types.u16x8, @splat(0xffff)), @as(types.u16x8, @splat(0)));
}

test vceqzq_f16 {
    const a = std.mem.zeroes(types.f16x8);
    const expected = @as(types.u16x8, @splat(0xffff));
    try common.testIntrinsic("vceqzq_f16", vceqzq_f16, expected, .{a}, null);
}
pub inline fn vceqz_f32(a: types.f32x2) types.u32x2 {
    const comparison = a == @as(types.f32x2, @splat(0));
    return @select(u32, comparison, @as(types.u32x2, @splat(0xffffffff)), @as(types.u32x2, @splat(0)));
}

test vceqz_f32 {
    const a = std.mem.zeroes(types.f32x2);
    const expected = @as(types.u32x2, @splat(0xffffffff));
    try common.testIntrinsic("vceqz_f32", vceqz_f32, expected, .{a}, null);
}
pub inline fn vceqzq_f32(a: types.f32x4) types.u32x4 {
    const comparison = a == @as(types.f32x4, @splat(0));
    return @select(u32, comparison, @as(types.u32x4, @splat(0xffffffff)), @as(types.u32x4, @splat(0)));
}

test vceqzq_f32 {
    const a = std.mem.zeroes(types.f32x4);
    const expected = @as(types.u32x4, @splat(0xffffffff));
    try common.testIntrinsic("vceqzq_f32", vceqzq_f32, expected, .{a}, null);
}
pub inline fn vceqz_f64(a: types.f64x1) types.u64x1 {
    const comparison = a == @as(types.f64x1, @splat(0));
    return @select(u64, comparison, @as(types.u64x1, @splat(0xffffffffffffffff)), @as(types.u64x1, @splat(0)));
}

test vceqz_f64 {
    const a = std.mem.zeroes(types.f64x1);
    const expected = @as(types.u64x1, @splat(0xffffffffffffffff));
    try common.testIntrinsic("vceqz_f64", vceqz_f64, expected, .{a}, null);
}
pub inline fn vceqzq_f64(a: types.f64x2) types.u64x2 {
    const comparison = a == @as(types.f64x2, @splat(0));
    return @select(u64, comparison, @as(types.u64x2, @splat(0xffffffffffffffff)), @as(types.u64x2, @splat(0)));
}

test vceqzq_f64 {
    const a = std.mem.zeroes(types.f64x2);
    const expected = @as(types.u64x2, @splat(0xffffffffffffffff));
    try common.testIntrinsic("vceqzq_f64", vceqzq_f64, expected, .{a}, null);
}
pub inline fn vceqz_p8(a: types.p8x8) types.u8x8 {
    const comparison = a == @as(types.p8x8, @splat(0));
    return @select(u8, comparison, @as(types.u8x8, @splat(0xff)), @as(types.u8x8, @splat(0)));
}

test vceqz_p8 {
    const a = std.mem.zeroes(types.p8x8);
    const expected = @as(types.u8x8, @splat(0xff));
    try common.testIntrinsic("vceqz_p8", vceqz_p8, expected, .{a}, null);
}
pub inline fn vceqzq_p8(a: types.p8x16) types.u8x16 {
    const comparison = a == @as(types.p8x16, @splat(0));
    return @select(u8, comparison, @as(types.u8x16, @splat(0xff)), @as(types.u8x16, @splat(0)));
}

test vceqzq_p8 {
    const a = std.mem.zeroes(types.p8x16);
    const expected = @as(types.u8x16, @splat(0xff));
    try common.testIntrinsic("vceqzq_p8", vceqzq_p8, expected, .{a}, null);
}
pub inline fn vceqz_p64(a: types.p64x1) types.u64x1 {
    const comparison = a == @as(types.p64x1, @splat(0));
    return @select(u64, comparison, @as(types.u64x1, @splat(0xffffffffffffffff)), @as(types.u64x1, @splat(0)));
}

test vceqz_p64 {
    const a = std.mem.zeroes(types.p64x1);
    const expected = @as(types.u64x1, @splat(0xffffffffffffffff));
    try common.testIntrinsic("vceqz_p64", vceqz_p64, expected, .{a}, null);
}
pub inline fn vceqzq_p64(a: types.p64x2) types.u64x2 {
    const comparison = a == @as(types.p64x2, @splat(0));
    return @select(u64, comparison, @as(types.u64x2, @splat(0xffffffffffffffff)), @as(types.u64x2, @splat(0)));
}

test vceqzq_p64 {
    const a = std.mem.zeroes(types.p64x2);
    const expected = @as(types.u64x2, @splat(0xffffffffffffffff));
    try common.testIntrinsic("vceqzq_p64", vceqzq_p64, expected, .{a}, null);
}

// --- Auto-generated Absolute Compare Intrinsics ---
pub inline fn vcagt_f16(a: types.f16x4, b: types.f16x4) types.u16x4 {
    const comparison = @abs(a) > @abs(b);
    return @select(u16, comparison, @as(types.u16x4, @splat(0xffff)), @as(types.u16x4, @splat(0)));
}

test vcagt_f16 {
    const a = std.mem.zeroes(types.f16x4);
    const b = std.mem.zeroes(types.f16x4);
    const expected = std.mem.zeroes(types.u16x4);
    try common.testIntrinsic("vcagt_f16", vcagt_f16, expected, .{ a, b }, null);
}

pub inline fn vcagtq_f16(a: types.f16x8, b: types.f16x8) types.u16x8 {
    const comparison = @abs(a) > @abs(b);
    return @select(u16, comparison, @as(types.u16x8, @splat(0xffff)), @as(types.u16x8, @splat(0)));
}

test vcagtq_f16 {
    const a = std.mem.zeroes(types.f16x8);
    const b = std.mem.zeroes(types.f16x8);
    const expected = std.mem.zeroes(types.u16x8);
    try common.testIntrinsic("vcagtq_f16", vcagtq_f16, expected, .{ a, b }, null);
}
pub inline fn vcagtq_f32(a: types.f32x4, b: types.f32x4) types.u32x4 {
    const comparison = @abs(a) > @abs(b);
    return @select(u32, comparison, @as(types.u32x4, @splat(0xffffffff)), @as(types.u32x4, @splat(0)));
}

test vcagtq_f32 {
    const a = std.mem.zeroes(types.f32x4);
    const b = std.mem.zeroes(types.f32x4);
    const expected = std.mem.zeroes(types.u32x4);
    try common.testIntrinsic("vcagtq_f32", vcagtq_f32, expected, .{ a, b }, null);
}
pub inline fn vcagtq_f64(a: types.f64x2, b: types.f64x2) types.u64x2 {
    const comparison = @abs(a) > @abs(b);
    return @select(u64, comparison, @as(types.u64x2, @splat(0xffffffffffffffff)), @as(types.u64x2, @splat(0)));
}

test vcagtq_f64 {
    const a = std.mem.zeroes(types.f64x2);
    const b = std.mem.zeroes(types.f64x2);
    const expected = std.mem.zeroes(types.u64x2);
    try common.testIntrinsic("vcagtq_f64", vcagtq_f64, expected, .{ a, b }, null);
}
pub inline fn vcagts_f32(a: f32, b: f32) u32 {
    const comparison = @abs(a) > @abs(b);
    return if (comparison) 0xffffffff else 0;
}

test vcagts_f32 {
    const a: f32 = 0.0;
    const b: f32 = 0.0;
    const expected = std.mem.zeroes(u32);
    try common.testIntrinsic("vcagts_f32", vcagts_f32, expected, .{ a, b }, null);
}
pub inline fn vcagtd_f64(a: f64, b: f64) u64 {
    const comparison = @abs(a) > @abs(b);
    return if (comparison) 0xffffffffffffffff else 0;
}

test vcagtd_f64 {
    const a: f64 = 0.0;
    const b: f64 = 0.0;
    const expected = std.mem.zeroes(u64);
    try common.testIntrinsic("vcagtd_f64", vcagtd_f64, expected, .{ a, b }, null);
}
pub inline fn vcage_f16(a: types.f16x4, b: types.f16x4) types.u16x4 {
    const comparison = @abs(a) >= @abs(b);
    return @select(u16, comparison, @as(types.u16x4, @splat(0xffff)), @as(types.u16x4, @splat(0)));
}

test vcage_f16 {
    const a = std.mem.zeroes(types.f16x4);
    const b = std.mem.zeroes(types.f16x4);
    const expected = @as(types.u16x4, @splat(0xffff));
    try common.testIntrinsic("vcage_f16", vcage_f16, expected, .{ a, b }, null);
}

pub inline fn vcageq_f16(a: types.f16x8, b: types.f16x8) types.u16x8 {
    const comparison = @abs(a) >= @abs(b);
    return @select(u16, comparison, @as(types.u16x8, @splat(0xffff)), @as(types.u16x8, @splat(0)));
}

test vcageq_f16 {
    const a = std.mem.zeroes(types.f16x8);
    const b = std.mem.zeroes(types.f16x8);
    const expected = @as(types.u16x8, @splat(0xffff));
    try common.testIntrinsic("vcageq_f16", vcageq_f16, expected, .{ a, b }, null);
}

pub inline fn vcages_f32(a: f32, b: f32) u32 {
    const comparison = @abs(a) >= @abs(b);
    return if (comparison) 0xffffffff else 0;
}

test vcages_f32 {
    const a: f32 = 0.0;
    const b: f32 = 0.0;
    const expected: u32 = 0xffffffff;
    try common.testIntrinsic("vcages_f32", vcages_f32, expected, .{ a, b }, null);
}
pub inline fn vcaged_f64(a: f64, b: f64) u64 {
    const comparison = @abs(a) >= @abs(b);
    return if (comparison) 0xffffffffffffffff else 0;
}

test vcaged_f64 {
    const a: f64 = 0.0;
    const b: f64 = 0.0;
    const expected: u64 = 0xffffffffffffffff;
    try common.testIntrinsic("vcaged_f64", vcaged_f64, expected, .{ a, b }, null);
}
pub inline fn vcalt_f16(a: types.f16x4, b: types.f16x4) types.u16x4 {
    const comparison = @abs(a) < @abs(b);
    return @select(u16, comparison, @as(types.u16x4, @splat(0xffff)), @as(types.u16x4, @splat(0)));
}

test vcalt_f16 {
    const a = std.mem.zeroes(types.f16x4);
    const b = std.mem.zeroes(types.f16x4);
    const expected = std.mem.zeroes(types.u16x4);
    try common.testIntrinsic("vcalt_f16", vcalt_f16, expected, .{ a, b }, null);
}
pub inline fn vcalt_f32(a: types.f32x2, b: types.f32x2) types.u32x2 {
    const comparison = @abs(a) < @abs(b);
    return @select(u32, comparison, @as(types.u32x2, @splat(0xffffffff)), @as(types.u32x2, @splat(0)));
}

test vcalt_f32 {
    const a = std.mem.zeroes(types.f32x2);
    const b = std.mem.zeroes(types.f32x2);
    const expected = std.mem.zeroes(types.u32x2);
    try common.testIntrinsic("vcalt_f32", vcalt_f32, expected, .{ a, b }, null);
}
pub inline fn vcaltq_f16(a: types.f16x8, b: types.f16x8) types.u16x8 {
    const comparison = @abs(a) < @abs(b);
    return @select(u16, comparison, @as(types.u16x8, @splat(0xffff)), @as(types.u16x8, @splat(0)));
}

test vcaltq_f16 {
    const a = std.mem.zeroes(types.f16x8);
    const b = std.mem.zeroes(types.f16x8);
    const expected = std.mem.zeroes(types.u16x8);
    try common.testIntrinsic("vcaltq_f16", vcaltq_f16, expected, .{ a, b }, null);
}
pub inline fn vcaltq_f32(a: types.f32x4, b: types.f32x4) types.u32x4 {
    const comparison = @abs(a) < @abs(b);
    return @select(u32, comparison, @as(types.u32x4, @splat(0xffffffff)), @as(types.u32x4, @splat(0)));
}

test vcaltq_f32 {
    const a = std.mem.zeroes(types.f32x4);
    const b = std.mem.zeroes(types.f32x4);
    const expected = std.mem.zeroes(types.u32x4);
    try common.testIntrinsic("vcaltq_f32", vcaltq_f32, expected, .{ a, b }, null);
}
pub inline fn vcaltq_f64(a: types.f64x2, b: types.f64x2) types.u64x2 {
    const comparison = @abs(a) < @abs(b);
    return @select(u64, comparison, @as(types.u64x2, @splat(0xffffffffffffffff)), @as(types.u64x2, @splat(0)));
}

test vcaltq_f64 {
    const a = std.mem.zeroes(types.f64x2);
    const b = std.mem.zeroes(types.f64x2);
    const expected = std.mem.zeroes(types.u64x2);
    try common.testIntrinsic("vcaltq_f64", vcaltq_f64, expected, .{ a, b }, null);
}
pub inline fn vcalts_f32(a: f32, b: f32) u32 {
    const comparison = @abs(a) < @abs(b);
    return if (comparison) 0xffffffff else 0;
}

test vcalts_f32 {
    const a: f32 = 0.0;
    const b: f32 = 0.0;
    const expected = std.mem.zeroes(u32);
    try common.testIntrinsic("vcalts_f32", vcalts_f32, expected, .{ a, b }, null);
}
pub inline fn vcaltd_f64(a: f64, b: f64) u64 {
    const comparison = @abs(a) < @abs(b);
    return if (comparison) 0xffffffffffffffff else 0;
}

test vcaltd_f64 {
    const a: f64 = 0.0;
    const b: f64 = 0.0;
    const expected = std.mem.zeroes(u64);
    try common.testIntrinsic("vcaltd_f64", vcaltd_f64, expected, .{ a, b }, null);
}
pub inline fn vcale_f16(a: types.f16x4, b: types.f16x4) types.u16x4 {
    const comparison = @abs(a) <= @abs(b);
    return @select(u16, comparison, @as(types.u16x4, @splat(0xffff)), @as(types.u16x4, @splat(0)));
}

test vcale_f16 {
    const a = std.mem.zeroes(types.f16x4);
    const b = std.mem.zeroes(types.f16x4);
    const expected = @as(types.u16x4, @splat(0xffff));
    try common.testIntrinsic("vcale_f16", vcale_f16, expected, .{ a, b }, null);
}
pub inline fn vcale_f32(a: types.f32x2, b: types.f32x2) types.u32x2 {
    const comparison = @abs(a) <= @abs(b);
    return @select(u32, comparison, @as(types.u32x2, @splat(0xffffffff)), @as(types.u32x2, @splat(0)));
}

test vcale_f32 {
    const a = std.mem.zeroes(types.f32x2);
    const b = std.mem.zeroes(types.f32x2);
    const expected = @as(types.u32x2, @splat(0xffffffff));
    try common.testIntrinsic("vcale_f32", vcale_f32, expected, .{ a, b }, null);
}
pub inline fn vcaleq_f16(a: types.f16x8, b: types.f16x8) types.u16x8 {
    const comparison = @abs(a) <= @abs(b);
    return @select(u16, comparison, @as(types.u16x8, @splat(0xffff)), @as(types.u16x8, @splat(0)));
}

test vcaleq_f16 {
    const a = std.mem.zeroes(types.f16x8);
    const b = std.mem.zeroes(types.f16x8);
    const expected = @as(types.u16x8, @splat(0xffff));
    try common.testIntrinsic("vcaleq_f16", vcaleq_f16, expected, .{ a, b }, null);
}
pub inline fn vcaleq_f32(a: types.f32x4, b: types.f32x4) types.u32x4 {
    const comparison = @abs(a) <= @abs(b);
    return @select(u32, comparison, @as(types.u32x4, @splat(0xffffffff)), @as(types.u32x4, @splat(0)));
}

test vcaleq_f32 {
    const a = std.mem.zeroes(types.f32x4);
    const b = std.mem.zeroes(types.f32x4);
    const expected = @as(types.u32x4, @splat(0xffffffff));
    try common.testIntrinsic("vcaleq_f32", vcaleq_f32, expected, .{ a, b }, null);
}
pub inline fn vcaleq_f64(a: types.f64x2, b: types.f64x2) types.u64x2 {
    const comparison = @abs(a) <= @abs(b);
    return @select(u64, comparison, @as(types.u64x2, @splat(0xffffffffffffffff)), @as(types.u64x2, @splat(0)));
}

test vcaleq_f64 {
    const a = std.mem.zeroes(types.f64x2);
    const b = std.mem.zeroes(types.f64x2);
    const expected = @as(types.u64x2, @splat(0xffffffffffffffff));
    try common.testIntrinsic("vcaleq_f64", vcaleq_f64, expected, .{ a, b }, null);
}
pub inline fn vcales_f32(a: f32, b: f32) u32 {
    const comparison = @abs(a) <= @abs(b);
    return if (comparison) 0xffffffff else 0;
}

test vcales_f32 {
    const a: f32 = 0.0;
    const b: f32 = 0.0;
    const expected: u32 = 0xffffffff;
    try common.testIntrinsic("vcales_f32", vcales_f32, expected, .{ a, b }, null);
}
pub inline fn vcaled_f64(a: f64, b: f64) u64 {
    const comparison = @abs(a) <= @abs(b);
    return if (comparison) 0xffffffffffffffff else 0;
}

test vcaled_f64 {
    const a: f64 = 0.0;
    const b: f64 = 0.0;
    const expected: u64 = 0xffffffffffffffff;
    try common.testIntrinsic("vcaled_f64", vcaled_f64, expected, .{ a, b }, null);
}

/// Compare greater than or equal
pub inline fn vcgeq_s8(a: types.i8x8, b: types.i8x8) types.u8x8 {
    const comparison = a >= b;
    return @select(u8, comparison, @as(types.u8x8, @splat(0xff)), @as(types.u8x8, @splat(0)));
}

test vcgeq_s8 {
    const a = std.mem.zeroes(types.i8x8);
    const b = std.mem.zeroes(types.i8x8);
    const expected = @as(types.u8x8, @splat(0xff));
    try common.testIntrinsic("vcgeq_s8", vcgeq_s8, expected, .{ a, b }, null);
}

/// Compare greater than or equal
pub inline fn vcgeqq_s8(a: types.i8x16, b: types.i8x16) types.u8x16 {
    const comparison = a >= b;
    return @select(u8, comparison, @as(types.u8x16, @splat(0xff)), @as(types.u8x16, @splat(0)));
}

test vcgeqq_s8 {
    const a = std.mem.zeroes(types.i8x16);
    const b = std.mem.zeroes(types.i8x16);
    const expected = @as(types.u8x16, @splat(0xff));
    try common.testIntrinsic("vcgeqq_s8", vcgeqq_s8, expected, .{ a, b }, null);
}

/// Compare greater than or equal
pub inline fn vcgeq_s16(a: types.i16x4, b: types.i16x4) types.u16x4 {
    const comparison = a >= b;
    return @select(u16, comparison, @as(types.u16x4, @splat(0xffff)), @as(types.u16x4, @splat(0)));
}

test vcgeq_s16 {
    const a = std.mem.zeroes(types.i16x4);
    const b = std.mem.zeroes(types.i16x4);
    const expected = @as(types.u16x4, @splat(0xffff));
    try common.testIntrinsic("vcgeq_s16", vcgeq_s16, expected, .{ a, b }, null);
}

/// Compare greater than or equal
pub inline fn vcgeqq_s16(a: types.i16x8, b: types.i16x8) types.u16x8 {
    const comparison = a >= b;
    return @select(u16, comparison, @as(types.u16x8, @splat(0xffff)), @as(types.u16x8, @splat(0)));
}

test vcgeqq_s16 {
    const a = std.mem.zeroes(types.i16x8);
    const b = std.mem.zeroes(types.i16x8);
    const expected = @as(types.u16x8, @splat(0xffff));
    try common.testIntrinsic("vcgeqq_s16", vcgeqq_s16, expected, .{ a, b }, null);
}

/// Compare greater than or equal
pub inline fn vcgeq_s32(a: types.i32x2, b: types.i32x2) types.u32x2 {
    const comparison = a >= b;
    return @select(u32, comparison, @as(types.u32x2, @splat(0xffffffff)), @as(types.u32x2, @splat(0)));
}

test vcgeq_s32 {
    const a = std.mem.zeroes(types.i32x2);
    const b = std.mem.zeroes(types.i32x2);
    const expected = @as(types.u32x2, @splat(0xffffffff));
    try common.testIntrinsic("vcgeq_s32", vcgeq_s32, expected, .{ a, b }, null);
}

/// Compare greater than or equal
pub inline fn vcgeqq_s32(a: types.i32x4, b: types.i32x4) types.u32x4 {
    const comparison = a >= b;
    return @select(u32, comparison, @as(types.u32x4, @splat(0xffffffff)), @as(types.u32x4, @splat(0)));
}

test vcgeqq_s32 {
    const a = std.mem.zeroes(types.i32x4);
    const b = std.mem.zeroes(types.i32x4);
    const expected = @as(types.u32x4, @splat(0xffffffff));
    try common.testIntrinsic("vcgeqq_s32", vcgeqq_s32, expected, .{ a, b }, null);
}

/// Compare greater than or equal
pub inline fn vcgeq_s64(a: types.i64x1, b: types.i64x1) types.u64x1 {
    const comparison = a >= b;
    return @select(u64, comparison, @as(types.u64x1, @splat(0xffffffffffffffff)), @as(types.u64x1, @splat(0)));
}

test vcgeq_s64 {
    const a = std.mem.zeroes(types.i64x1);
    const b = std.mem.zeroes(types.i64x1);
    const expected = @as(types.u64x1, @splat(0xffffffffffffffff));
    try common.testIntrinsic("vcgeq_s64", vcgeq_s64, expected, .{ a, b }, null);
}

/// Compare greater than or equal
pub inline fn vcgeqq_s64(a: types.i64x2, b: types.i64x2) types.u64x2 {
    const comparison = a >= b;
    return @select(u64, comparison, @as(types.u64x2, @splat(0xffffffffffffffff)), @as(types.u64x2, @splat(0)));
}

test vcgeqq_s64 {
    const a = std.mem.zeroes(types.i64x2);
    const b = std.mem.zeroes(types.i64x2);
    const expected = @as(types.u64x2, @splat(0xffffffffffffffff));
    try common.testIntrinsic("vcgeqq_s64", vcgeqq_s64, expected, .{ a, b }, null);
}

/// Compare greater than or equal
pub inline fn vcgeq_u8(a: types.u8x8, b: types.u8x8) types.u8x8 {
    const comparison = a >= b;
    return @select(u8, comparison, @as(types.u8x8, @splat(0xff)), @as(types.u8x8, @splat(0)));
}

test vcgeq_u8 {
    const a = std.mem.zeroes(types.u8x8);
    const b = std.mem.zeroes(types.u8x8);
    const expected = @as(types.u8x8, @splat(0xff));
    try common.testIntrinsic("vcgeq_u8", vcgeq_u8, expected, .{ a, b }, null);
}

/// Compare greater than or equal
pub inline fn vcgeqq_u8(a: types.u8x16, b: types.u8x16) types.u8x16 {
    const comparison = a >= b;
    return @select(u8, comparison, @as(types.u8x16, @splat(0xff)), @as(types.u8x16, @splat(0)));
}

test vcgeqq_u8 {
    const a = std.mem.zeroes(types.u8x16);
    const b = std.mem.zeroes(types.u8x16);
    const expected = @as(types.u8x16, @splat(0xff));
    try common.testIntrinsic("vcgeqq_u8", vcgeqq_u8, expected, .{ a, b }, null);
}

/// Compare greater than or equal
pub inline fn vcgeq_u16(a: types.u16x4, b: types.u16x4) types.u16x4 {
    const comparison = a >= b;
    return @select(u16, comparison, @as(types.u16x4, @splat(0xffff)), @as(types.u16x4, @splat(0)));
}

test vcgeq_u16 {
    const a = std.mem.zeroes(types.u16x4);
    const b = std.mem.zeroes(types.u16x4);
    const expected = @as(types.u16x4, @splat(0xffff));
    try common.testIntrinsic("vcgeq_u16", vcgeq_u16, expected, .{ a, b }, null);
}

/// Compare greater than or equal
pub inline fn vcgeqq_u16(a: types.u16x8, b: types.u16x8) types.u16x8 {
    const comparison = a >= b;
    return @select(u16, comparison, @as(types.u16x8, @splat(0xffff)), @as(types.u16x8, @splat(0)));
}

test vcgeqq_u16 {
    const a = std.mem.zeroes(types.u16x8);
    const b = std.mem.zeroes(types.u16x8);
    const expected = @as(types.u16x8, @splat(0xffff));
    try common.testIntrinsic("vcgeqq_u16", vcgeqq_u16, expected, .{ a, b }, null);
}

/// Compare greater than or equal
pub inline fn vcgeq_u32(a: types.u32x2, b: types.u32x2) types.u32x2 {
    const comparison = a >= b;
    return @select(u32, comparison, @as(types.u32x2, @splat(0xffffffff)), @as(types.u32x2, @splat(0)));
}

test vcgeq_u32 {
    const a = std.mem.zeroes(types.u32x2);
    const b = std.mem.zeroes(types.u32x2);
    const expected = @as(types.u32x2, @splat(0xffffffff));
    try common.testIntrinsic("vcgeq_u32", vcgeq_u32, expected, .{ a, b }, null);
}

/// Compare greater than or equal
pub inline fn vcgeqq_u32(a: types.u32x4, b: types.u32x4) types.u32x4 {
    const comparison = a >= b;
    return @select(u32, comparison, @as(types.u32x4, @splat(0xffffffff)), @as(types.u32x4, @splat(0)));
}

test vcgeqq_u32 {
    const a = std.mem.zeroes(types.u32x4);
    const b = std.mem.zeroes(types.u32x4);
    const expected = @as(types.u32x4, @splat(0xffffffff));
    try common.testIntrinsic("vcgeqq_u32", vcgeqq_u32, expected, .{ a, b }, null);
}

/// Compare greater than or equal
pub inline fn vcgeq_u64(a: types.u64x1, b: types.u64x1) types.u64x1 {
    const comparison = a >= b;
    return @select(u64, comparison, @as(types.u64x1, @splat(0xffffffffffffffff)), @as(types.u64x1, @splat(0)));
}

test vcgeq_u64 {
    const a = std.mem.zeroes(types.u64x1);
    const b = std.mem.zeroes(types.u64x1);
    const expected = @as(types.u64x1, @splat(0xffffffffffffffff));
    try common.testIntrinsic("vcgeq_u64", vcgeq_u64, expected, .{ a, b }, null);
}

/// Compare greater than or equal
pub inline fn vcgeqq_u64(a: types.u64x2, b: types.u64x2) types.u64x2 {
    const comparison = a >= b;
    return @select(u64, comparison, @as(types.u64x2, @splat(0xffffffffffffffff)), @as(types.u64x2, @splat(0)));
}

test vcgeqq_u64 {
    const a = std.mem.zeroes(types.u64x2);
    const b = std.mem.zeroes(types.u64x2);
    const expected = @as(types.u64x2, @splat(0xffffffffffffffff));
    try common.testIntrinsic("vcgeqq_u64", vcgeqq_u64, expected, .{ a, b }, null);
}

/// Compare greater than or equal
pub inline fn vcgeq_f16(a: types.f16x4, b: types.f16x4) types.u16x4 {
    const comparison = a >= b;
    return @select(u16, comparison, @as(types.u16x4, @splat(0xffff)), @as(types.u16x4, @splat(0)));
}

test vcgeq_f16 {
    const a = std.mem.zeroes(types.f16x4);
    const b = std.mem.zeroes(types.f16x4);
    const expected = @as(types.u16x4, @splat(0xffff));
    try common.testIntrinsic("vcgeq_f16", vcgeq_f16, expected, .{ a, b }, null);
}

/// Compare greater than or equal
pub inline fn vcgeqq_f16(a: types.f16x8, b: types.f16x8) types.u16x8 {
    const comparison = a >= b;
    return @select(u16, comparison, @as(types.u16x8, @splat(0xffff)), @as(types.u16x8, @splat(0)));
}

test vcgeqq_f16 {
    const a = std.mem.zeroes(types.f16x8);
    const b = std.mem.zeroes(types.f16x8);
    const expected = @as(types.u16x8, @splat(0xffff));
    try common.testIntrinsic("vcgeqq_f16", vcgeqq_f16, expected, .{ a, b }, null);
}

/// Compare greater than or equal
pub inline fn vcgeq_f32(a: types.f32x2, b: types.f32x2) types.u32x2 {
    const comparison = a >= b;
    return @select(u32, comparison, @as(types.u32x2, @splat(0xffffffff)), @as(types.u32x2, @splat(0)));
}

test vcgeq_f32 {
    const a = std.mem.zeroes(types.f32x2);
    const b = std.mem.zeroes(types.f32x2);
    const expected = @as(types.u32x2, @splat(0xffffffff));
    try common.testIntrinsic("vcgeq_f32", vcgeq_f32, expected, .{ a, b }, null);
}

/// Compare greater than or equal
pub inline fn vcgeqq_f32(a: types.f32x4, b: types.f32x4) types.u32x4 {
    const comparison = a >= b;
    return @select(u32, comparison, @as(types.u32x4, @splat(0xffffffff)), @as(types.u32x4, @splat(0)));
}

test vcgeqq_f32 {
    const a = std.mem.zeroes(types.f32x4);
    const b = std.mem.zeroes(types.f32x4);
    const expected = @as(types.u32x4, @splat(0xffffffff));
    try common.testIntrinsic("vcgeqq_f32", vcgeqq_f32, expected, .{ a, b }, null);
}

/// Compare greater than or equal
pub inline fn vcgeq_f64(a: types.f64x1, b: types.f64x1) types.u64x1 {
    const comparison = a >= b;
    return @select(u64, comparison, @as(types.u64x1, @splat(0xffffffffffffffff)), @as(types.u64x1, @splat(0)));
}

test vcgeq_f64 {
    const a = std.mem.zeroes(types.f64x1);
    const b = std.mem.zeroes(types.f64x1);
    const expected = @as(types.u64x1, @splat(0xffffffffffffffff));
    try common.testIntrinsic("vcgeq_f64", vcgeq_f64, expected, .{ a, b }, null);
}

/// Compare greater than or equal
pub inline fn vcgeqq_f64(a: types.f64x2, b: types.f64x2) types.u64x2 {
    const comparison = a >= b;
    return @select(u64, comparison, @as(types.u64x2, @splat(0xffffffffffffffff)), @as(types.u64x2, @splat(0)));
}

test vcgeqq_f64 {
    const a = std.mem.zeroes(types.f64x2);
    const b = std.mem.zeroes(types.f64x2);
    const expected = @as(types.u64x2, @splat(0xffffffffffffffff));
    try common.testIntrinsic("vcgeqq_f64", vcgeqq_f64, expected, .{ a, b }, null);
}

/// Compare greater than (f32x2)
pub inline fn vcgt_f32(a: types.f32x2, b: types.f32x2) types.u32x2 {
    const comparison = a > b;
    return @select(u32, comparison, @as(types.u32x2, @splat(0xffffffff)), @as(types.u32x2, @splat(0)));
}

test vcgt_f32 {
    const a = types.f32x2{ 2.0, -1.0 };
    const b = types.f32x2{ 1.0, 0.0 };
    const expected = types.u32x2{ 0xffffffff, 0 };
    try common.testIntrinsic("vcgt_f32", vcgt_f32, expected, .{ a, b }, null);
}

/// Compare greater than (f32x4)
pub inline fn vcgtq_f32(a: types.f32x4, b: types.f32x4) types.u32x4 {
    const comparison = a > b;
    return @select(u32, comparison, @as(types.u32x4, @splat(0xffffffff)), @as(types.u32x4, @splat(0)));
}

test vcgtq_f32 {
    const a = types.f32x4{ 2.0, -1.0, 0.0, 5.0 };
    const b = types.f32x4{ 1.0, 0.0, 0.0, 4.0 };
    const expected = types.u32x4{ 0xffffffff, 0, 0, 0xffffffff };
    try common.testIntrinsic("vcgtq_f32", vcgtq_f32, expected, .{ a, b }, null);
}

/// Compare greater than (f64x1)
pub inline fn vcgt_f64(a: types.f64x1, b: types.f64x1) types.u64x1 {
    const comparison = a > b;
    return @select(u64, comparison, @as(types.u64x1, @splat(0xffffffffffffffff)), @as(types.u64x1, @splat(0)));
}

test vcgt_f64 {
    const a = types.f64x1{2.0};
    const b = types.f64x1{1.0};
    const expected = types.u64x1{0xffffffffffffffff};
    try common.testIntrinsic("vcgt_f64", vcgt_f64, expected, .{ a, b }, null);
}

/// Compare greater than (f64x2)
pub inline fn vcgtq_f64(a: types.f64x2, b: types.f64x2) types.u64x2 {
    const comparison = a > b;
    return @select(u64, comparison, @as(types.u64x2, @splat(0xffffffffffffffff)), @as(types.u64x2, @splat(0)));
}

test vcgtq_f64 {
    const a = types.f64x2{ 2.0, -1.0 };
    const b = types.f64x2{ 1.0, 0.0 };
    const expected = types.u64x2{ 0xffffffffffffffff, 0 };
    try common.testIntrinsic("vcgtq_f64", vcgtq_f64, expected, .{ a, b }, null);
}

/// Compare greater than (s32x2)
pub inline fn vcgt_s32(a: types.i32x2, b: types.i32x2) types.u32x2 {
    const comparison = a > b;
    return @select(u32, comparison, @as(types.u32x2, @splat(0xffffffff)), @as(types.u32x2, @splat(0)));
}

test vcgt_s32 {
    const a = types.i32x2{ 2, -1 };
    const b = types.i32x2{ 1, 0 };
    const expected = types.u32x2{ 0xffffffff, 0 };
    try common.testIntrinsic("vcgt_s32", vcgt_s32, expected, .{ a, b }, null);
}

/// Compare greater than (s32x4)
pub inline fn vcgtq_s32(a: types.i32x4, b: types.i32x4) types.u32x4 {
    const comparison = a > b;
    return @select(u32, comparison, @as(types.u32x4, @splat(0xffffffff)), @as(types.u32x4, @splat(0)));
}

test vcgtq_s32 {
    const a = types.i32x4{ 2, -1, 0, 5 };
    const b = types.i32x4{ 1, 0, 0, 4 };
    const expected = types.u32x4{ 0xffffffff, 0, 0, 0xffffffff };
    try common.testIntrinsic("vcgtq_s32", vcgtq_s32, expected, .{ a, b }, null);
}

/// Compare greater than (u32x2)
pub inline fn vcgt_u32(a: types.u32x2, b: types.u32x2) types.u32x2 {
    const comparison = a > b;
    return @select(u32, comparison, @as(types.u32x2, @splat(0xffffffff)), @as(types.u32x2, @splat(0)));
}

test vcgt_u32 {
    const a = types.u32x2{ 2, 0 };
    const b = types.u32x2{ 1, 0 };
    const expected = types.u32x2{ 0xffffffff, 0 };
    try common.testIntrinsic("vcgt_u32", vcgt_u32, expected, .{ a, b }, null);
}

/// Compare greater than (u32x4)
pub inline fn vcgtq_u32(a: types.u32x4, b: types.u32x4) types.u32x4 {
    const comparison = a > b;
    return @select(u32, comparison, @as(types.u32x4, @splat(0xffffffff)), @as(types.u32x4, @splat(0)));
}

test vcgtq_u32 {
    const a = types.u32x4{ 2, 0, 0, 5 };
    const b = types.u32x4{ 1, 0, 0, 4 };
    const expected = types.u32x4{ 0xffffffff, 0, 0, 0xffffffff };
    try common.testIntrinsic("vcgtq_u32", vcgtq_u32, expected, .{ a, b }, null);
}
