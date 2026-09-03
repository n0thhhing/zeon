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
    const a = types.f32x2{ -1.5, 2.0 };
    const b = types.f32x2{ 1.0, 1.5 };
    const expected = types.u32x2{ 0xffffffff, 0xffffffff };
    try common.testIntrinsic(.{ .func = vcage_f32, .expected = expected, .args = .{ a, b } });
}

/// Floating-point absolute compare greater than or equal
pub inline fn vcage_f64(a: types.f64x1, b: types.f64x1) types.u64x1 {
    const comparison = @abs(a) >= @abs(b);
    return @select(u64, comparison, @as(types.u64x1, @splat(0xffffffffffffffff)), @as(types.u64x1, @splat(0x0000000000000000)));
}

test vcage_f64 {
    const a = types.f64x1{-1.5};
    const b = types.f64x1{1.0};
    const expected = types.u64x1{0xffffffffffffffff};
    try common.testIntrinsic(.{ .func = vcage_f64, .expected = expected, .args = .{ a, b } });
}

/// Floating-point absolute compare greater than or equal
pub inline fn vcageq_f32(a: types.f32x4, b: types.f32x4) types.u32x4 {
    const comparison = @abs(a) >= @abs(b);
    return @select(u32, comparison, @as(types.u32x4, @splat(0xffffffff)), @as(types.u32x4, @splat(0x00000000)));
}

test vcageq_f32 {
    const a = types.f32x4{ -1.5, 2.0, 0.0, 5.5 };
    const b = types.f32x4{ 1.0, 1.5, 0.0, 10.0 };
    const expected = types.u32x4{ 0xffffffff, 0xffffffff, 0xffffffff, 0 };
    try common.testIntrinsic(.{ .func = vcageq_f32, .expected = expected, .args = .{ a, b } });
}

/// Floating-point absolute compare greater than or equal
pub inline fn vcageq_f64(a: types.f64x2, b: types.f64x2) types.u64x2 {
    const comparison = @abs(a) >= @abs(b);
    return @select(u64, comparison, @as(types.u64x2, @splat(0xffffffffffffffff)), @as(types.u64x2, @splat(0x0000000000000000)));
}

test vcageq_f64 {
    const a = types.f64x2{ -1.5, 2.0 };
    const b = types.f64x2{ 1.0, 1.5 };
    const expected = types.u64x2{ 0xffffffffffffffff, 0xffffffffffffffff };
    try common.testIntrinsic(.{ .func = vcageq_f64, .expected = expected, .args = .{ a, b } });
}

/// Floating-point absolute compare greater than
pub inline fn vcagt_f32(a: types.f32x2, b: types.f32x2) types.u32x2 {
    const comparison = @abs(a) > @abs(b);
    return @select(u32, comparison, @as(types.u32x2, @splat(0xffffffff)), @as(types.u32x2, @splat(0x00000000)));
}

test vcagt_f32 {
    const a = types.f32x2{ -1.5, 2.0 };
    const b = types.f32x2{ 1.0, 1.5 };
    const expected = types.u32x2{ 0xffffffff, 0xffffffff };
    try common.testIntrinsic(.{ .func = vcagt_f32, .expected = expected, .args = .{ a, b } });
}

/// Floating-point absolute compare greater than
pub inline fn vcagt_f64(a: types.f64x1, b: types.f64x1) types.u64x1 {
    const comparison = @abs(a) > @abs(b);
    return @select(u64, comparison, @as(types.u64x1, @splat(0xffffffffffffffff)), @as(types.u64x1, @splat(0x0000000000000000)));
}

test vcagt_f64 {
    const a = types.f64x1{-1.5};
    const b = types.f64x1{1.0};
    const expected = types.u64x1{0xffffffffffffffff};
    try common.testIntrinsic(.{ .func = vcagt_f64, .expected = expected, .args = .{ a, b } });
}

/// ARM NEON intrinsic: `vceq_s8`
pub inline fn vceq_s8(a: types.i8x8, b: types.i8x8) types.u8x8 {
    const comparison = a == b;
    return @select(u8, comparison, @as(types.u8x8, @splat(0xff)), @as(types.u8x8, @splat(0)));
}

test vceq_s8 {
    const a = types.i8x8{ -10, 20, 0, 50, -100, 42, 40, -1 };
    const b = types.i8x8{ 10, 15, 0, 100, -100, 0, 39, 0 };
    const expected = types.u8x8{ 0, 0, 0xff, 0, 0xff, 0, 0, 0 };
    try common.testIntrinsic(.{ .func = vceq_s8, .expected = expected, .args = .{ a, b } });
}
/// ARM NEON intrinsic: `vceqq_s8`
pub inline fn vceqq_s8(a: types.i8x16, b: types.i8x16) types.u8x16 {
    const comparison = a == b;
    return @select(u8, comparison, @as(types.u8x16, @splat(0xff)), @as(types.u8x16, @splat(0)));
}

test vceqq_s8 {
    const a = types.i8x16{ -10, 20, 0, 50, -100, 42, 40, -1, -10, -10, -10, -10, -10, -10, -10, -10 };
    const b = types.i8x16{ 10, 15, 0, 100, -100, 0, 39, 0, 10, 10, 10, 10, 10, 10, 10, 10 };
    const expected = types.u8x16{ 0, 0, 0xff, 0, 0xff, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
    try common.testIntrinsic(.{ .func = vceqq_s8, .expected = expected, .args = .{ a, b } });
}
/// ARM NEON intrinsic: `vceq_s16`
pub inline fn vceq_s16(a: types.i16x4, b: types.i16x4) types.u16x4 {
    const comparison = a == b;
    return @select(u16, comparison, @as(types.u16x4, @splat(0xffff)), @as(types.u16x4, @splat(0)));
}

test vceq_s16 {
    const a = types.i16x4{ -10, 20, 0, 50 };
    const b = types.i16x4{ 10, 15, 0, 100 };
    const expected = types.u16x4{ 0, 0, 0xffff, 0 };
    try common.testIntrinsic(.{ .func = vceq_s16, .expected = expected, .args = .{ a, b } });
}
/// ARM NEON intrinsic: `vceqq_s16`
pub inline fn vceqq_s16(a: types.i16x8, b: types.i16x8) types.u16x8 {
    const comparison = a == b;
    return @select(u16, comparison, @as(types.u16x8, @splat(0xffff)), @as(types.u16x8, @splat(0)));
}

test vceqq_s16 {
    const a = types.i16x8{ -10, 20, 0, 50, -100, 42, 40, -1 };
    const b = types.i16x8{ 10, 15, 0, 100, -100, 0, 39, 0 };
    const expected = types.u16x8{ 0, 0, 0xffff, 0, 0xffff, 0, 0, 0 };
    try common.testIntrinsic(.{ .func = vceqq_s16, .expected = expected, .args = .{ a, b } });
}
/// ARM NEON intrinsic: `vceq_s32`
pub inline fn vceq_s32(a: types.i32x2, b: types.i32x2) types.u32x2 {
    const comparison = a == b;
    return @select(u32, comparison, @as(types.u32x2, @splat(0xffffffff)), @as(types.u32x2, @splat(0)));
}

test vceq_s32 {
    const a = types.i32x2{ -10, 20 };
    const b = types.i32x2{ 10, 15 };
    const expected = types.u32x2{ 0, 0 };
    try common.testIntrinsic(.{ .func = vceq_s32, .expected = expected, .args = .{ a, b } });
}
/// ARM NEON intrinsic: `vceqq_s32`
pub inline fn vceqq_s32(a: types.i32x4, b: types.i32x4) types.u32x4 {
    const comparison = a == b;
    return @select(u32, comparison, @as(types.u32x4, @splat(0xffffffff)), @as(types.u32x4, @splat(0)));
}

test vceqq_s32 {
    const a = types.i32x4{ -10, 20, 0, 50 };
    const b = types.i32x4{ 10, 15, 0, 100 };
    const expected = types.u32x4{ 0, 0, 0xffffffff, 0 };
    try common.testIntrinsic(.{ .func = vceqq_s32, .expected = expected, .args = .{ a, b } });
}
/// ARM NEON intrinsic: `vceq_s64`
pub inline fn vceq_s64(a: types.i64x1, b: types.i64x1) types.u64x1 {
    const comparison = a == b;
    return @select(u64, comparison, @as(types.u64x1, @splat(0xffffffffffffffff)), @as(types.u64x1, @splat(0)));
}

test vceq_s64 {
    const a = types.i64x1{-10};
    const b = types.i64x1{10};
    const expected = types.u64x1{0};
    try common.testIntrinsic(.{ .func = vceq_s64, .expected = expected, .args = .{ a, b } });
}
/// ARM NEON intrinsic: `vceqq_s64`
pub inline fn vceqq_s64(a: types.i64x2, b: types.i64x2) types.u64x2 {
    const comparison = a == b;
    return @select(u64, comparison, @as(types.u64x2, @splat(0xffffffffffffffff)), @as(types.u64x2, @splat(0)));
}

test vceqq_s64 {
    const a = types.i64x2{ -10, 20 };
    const b = types.i64x2{ 10, 15 };
    const expected = types.u64x2{ 0, 0 };
    try common.testIntrinsic(.{ .func = vceqq_s64, .expected = expected, .args = .{ a, b } });
}
/// ARM NEON intrinsic: `vceq_u8`
pub inline fn vceq_u8(a: types.u8x8, b: types.u8x8) types.u8x8 {
    const comparison = a == b;
    return @select(u8, comparison, @as(types.u8x8, @splat(0xff)), @as(types.u8x8, @splat(0)));
}

test vceq_u8 {
    const a = types.u8x8{ 10, 50, 0, 100, 200, 1, 40, 100 };
    const b = types.u8x8{ 20, 40, 0, 100, 50, 2, 41, 50 };
    const expected = types.u8x8{ 0, 0, 0xff, 0xff, 0, 0, 0, 0 };
    try common.testIntrinsic(.{ .func = vceq_u8, .expected = expected, .args = .{ a, b } });
}
/// ARM NEON intrinsic: `vceqq_u8`
pub inline fn vceqq_u8(a: types.u8x16, b: types.u8x16) types.u8x16 {
    const comparison = a == b;
    return @select(u8, comparison, @as(types.u8x16, @splat(0xff)), @as(types.u8x16, @splat(0)));
}

test vceqq_u8 {
    const a = types.u8x16{ 10, 50, 0, 100, 200, 1, 40, 100, 10, 10, 10, 10, 10, 10, 10, 10 };
    const b = types.u8x16{ 20, 40, 0, 100, 50, 2, 41, 50, 20, 20, 20, 20, 20, 20, 20, 20 };
    const expected = types.u8x16{ 0, 0, 0xff, 0xff, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
    try common.testIntrinsic(.{ .func = vceqq_u8, .expected = expected, .args = .{ a, b } });
}
/// ARM NEON intrinsic: `vceq_u16`
pub inline fn vceq_u16(a: types.u16x4, b: types.u16x4) types.u16x4 {
    const comparison = a == b;
    return @select(u16, comparison, @as(types.u16x4, @splat(0xffff)), @as(types.u16x4, @splat(0)));
}

test vceq_u16 {
    const a = types.u16x4{ 10, 50, 0, 100 };
    const b = types.u16x4{ 20, 40, 0, 100 };
    const expected = types.u16x4{ 0, 0, 0xffff, 0xffff };
    try common.testIntrinsic(.{ .func = vceq_u16, .expected = expected, .args = .{ a, b } });
}
/// ARM NEON intrinsic: `vceqq_u16`
pub inline fn vceqq_u16(a: types.u16x8, b: types.u16x8) types.u16x8 {
    const comparison = a == b;
    return @select(u16, comparison, @as(types.u16x8, @splat(0xffff)), @as(types.u16x8, @splat(0)));
}

test vceqq_u16 {
    const a = types.u16x8{ 10, 50, 0, 100, 200, 1, 40, 100 };
    const b = types.u16x8{ 20, 40, 0, 100, 50, 2, 41, 50 };
    const expected = types.u16x8{ 0, 0, 0xffff, 0xffff, 0, 0, 0, 0 };
    try common.testIntrinsic(.{ .func = vceqq_u16, .expected = expected, .args = .{ a, b } });
}
/// ARM NEON intrinsic: `vceq_u32`
pub inline fn vceq_u32(a: types.u32x2, b: types.u32x2) types.u32x2 {
    const comparison = a == b;
    return @select(u32, comparison, @as(types.u32x2, @splat(0xffffffff)), @as(types.u32x2, @splat(0)));
}

test vceq_u32 {
    const a = types.u32x2{ 10, 50 };
    const b = types.u32x2{ 20, 40 };
    const expected = types.u32x2{ 0, 0 };
    try common.testIntrinsic(.{ .func = vceq_u32, .expected = expected, .args = .{ a, b } });
}
/// ARM NEON intrinsic: `vceqq_u32`
pub inline fn vceqq_u32(a: types.u32x4, b: types.u32x4) types.u32x4 {
    const comparison = a == b;
    return @select(u32, comparison, @as(types.u32x4, @splat(0xffffffff)), @as(types.u32x4, @splat(0)));
}

test vceqq_u32 {
    const a = types.u32x4{ 10, 50, 0, 100 };
    const b = types.u32x4{ 20, 40, 0, 100 };
    const expected = types.u32x4{ 0, 0, 0xffffffff, 0xffffffff };
    try common.testIntrinsic(.{ .func = vceqq_u32, .expected = expected, .args = .{ a, b } });
}
/// ARM NEON intrinsic: `vceq_u64`
pub inline fn vceq_u64(a: types.u64x1, b: types.u64x1) types.u64x1 {
    const comparison = a == b;
    return @select(u64, comparison, @as(types.u64x1, @splat(0xffffffffffffffff)), @as(types.u64x1, @splat(0)));
}

test vceq_u64 {
    const a = types.u64x1{10};
    const b = types.u64x1{20};
    const expected = types.u64x1{0};
    try common.testIntrinsic(.{ .func = vceq_u64, .expected = expected, .args = .{ a, b } });
}
/// ARM NEON intrinsic: `vceqq_u64`
pub inline fn vceqq_u64(a: types.u64x2, b: types.u64x2) types.u64x2 {
    const comparison = a == b;
    return @select(u64, comparison, @as(types.u64x2, @splat(0xffffffffffffffff)), @as(types.u64x2, @splat(0)));
}

test vceqq_u64 {
    const a = types.u64x2{ 10, 50 };
    const b = types.u64x2{ 20, 40 };
    const expected = types.u64x2{ 0, 0 };
    try common.testIntrinsic(.{ .func = vceqq_u64, .expected = expected, .args = .{ a, b } });
}
/// ARM NEON intrinsic: `vceq_f16`
pub inline fn vceq_f16(a: types.f16x4, b: types.f16x4) types.u16x4 {
    const comparison = a == b;
    return @select(u16, comparison, @as(types.u16x4, @splat(0xffff)), @as(types.u16x4, @splat(0)));
}

test vceq_f16 {
    const a = types.f16x4{ -1.5, 2.0, 0.0, 5.5 };
    const b = types.f16x4{ 1.0, 1.5, 0.0, 10.0 };
    const expected = types.u16x4{ 0, 0, 0xffff, 0 };
    try common.testIntrinsic(.{ .func = vceq_f16, .expected = expected, .args = .{ a, b } });
}
/// ARM NEON intrinsic: `vceqq_f16`
pub inline fn vceqq_f16(a: types.f16x8, b: types.f16x8) types.u16x8 {
    const comparison = a == b;
    return @select(u16, comparison, @as(types.u16x8, @splat(0xffff)), @as(types.u16x8, @splat(0)));
}

test vceqq_f16 {
    const a = types.f16x8{ -1.5, 2.0, 0.0, 5.5, 3.0, -10.0, 1.0, 0.0 };
    const b = types.f16x8{ 1.0, 1.5, 0.0, 10.0, -3.0, -10.0, 2.0, 0.0 };
    const expected = types.u16x8{ 0, 0, 0xffff, 0, 0, 0xffff, 0, 0xffff };
    try common.testIntrinsic(.{ .func = vceqq_f16, .expected = expected, .args = .{ a, b } });
}
/// ARM NEON intrinsic: `vceq_f32`
pub inline fn vceq_f32(a: types.f32x2, b: types.f32x2) types.u32x2 {
    const comparison = a == b;
    return @select(u32, comparison, @as(types.u32x2, @splat(0xffffffff)), @as(types.u32x2, @splat(0)));
}

test vceq_f32 {
    const a = types.f32x2{ -1.5, 2.0 };
    const b = types.f32x2{ 1.0, 1.5 };
    const expected = types.u32x2{ 0, 0 };
    try common.testIntrinsic(.{ .func = vceq_f32, .expected = expected, .args = .{ a, b } });
}
/// ARM NEON intrinsic: `vceqq_f32`
pub inline fn vceqq_f32(a: types.f32x4, b: types.f32x4) types.u32x4 {
    const comparison = a == b;
    return @select(u32, comparison, @as(types.u32x4, @splat(0xffffffff)), @as(types.u32x4, @splat(0)));
}

test vceqq_f32 {
    const a = types.f32x4{ -1.5, 2.0, 0.0, 5.5 };
    const b = types.f32x4{ 1.0, 1.5, 0.0, 10.0 };
    const expected = types.u32x4{ 0, 0, 0xffffffff, 0 };
    try common.testIntrinsic(.{ .func = vceqq_f32, .expected = expected, .args = .{ a, b } });
}
/// ARM NEON intrinsic: `vceq_f64`
pub inline fn vceq_f64(a: types.f64x1, b: types.f64x1) types.u64x1 {
    const comparison = a == b;
    return @select(u64, comparison, @as(types.u64x1, @splat(0xffffffffffffffff)), @as(types.u64x1, @splat(0)));
}

test vceq_f64 {
    const a = types.f64x1{-1.5};
    const b = types.f64x1{1.0};
    const expected = types.u64x1{0};
    try common.testIntrinsic(.{ .func = vceq_f64, .expected = expected, .args = .{ a, b } });
}
/// ARM NEON intrinsic: `vceqq_f64`
pub inline fn vceqq_f64(a: types.f64x2, b: types.f64x2) types.u64x2 {
    const comparison = a == b;
    return @select(u64, comparison, @as(types.u64x2, @splat(0xffffffffffffffff)), @as(types.u64x2, @splat(0)));
}

test vceqq_f64 {
    const a = types.f64x2{ -1.5, 2.0 };
    const b = types.f64x2{ 1.0, 1.5 };
    const expected = types.u64x2{ 0, 0 };
    try common.testIntrinsic(.{ .func = vceqq_f64, .expected = expected, .args = .{ a, b } });
}
/// ARM NEON intrinsic: `vceq_p8`
pub inline fn vceq_p8(a: types.p8x8, b: types.p8x8) types.u8x8 {
    const comparison = a == b;
    return @select(u8, comparison, @as(types.u8x8, @splat(0xff)), @as(types.u8x8, @splat(0)));
}

test vceq_p8 {
    const a = types.p8x8{ 10, 50, 0, 100, 200, 1, 40, 100 };
    const b = types.p8x8{ 20, 40, 0, 100, 50, 2, 41, 50 };
    const expected = types.u8x8{ 0, 0, 0xff, 0xff, 0, 0, 0, 0 };
    try common.testIntrinsic(.{ .func = vceq_p8, .expected = expected, .args = .{ a, b } });
}
/// ARM NEON intrinsic: `vceqq_p8`
pub inline fn vceqq_p8(a: types.p8x16, b: types.p8x16) types.u8x16 {
    const comparison = a == b;
    return @select(u8, comparison, @as(types.u8x16, @splat(0xff)), @as(types.u8x16, @splat(0)));
}

test vceqq_p8 {
    const a = types.p8x16{ 10, 50, 0, 100, 200, 1, 40, 100, 10, 10, 10, 10, 10, 10, 10, 10 };
    const b = types.p8x16{ 20, 40, 0, 100, 50, 2, 41, 50, 20, 20, 20, 20, 20, 20, 20, 20 };
    const expected = types.u8x16{ 0, 0, 0xff, 0xff, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
    try common.testIntrinsic(.{ .func = vceqq_p8, .expected = expected, .args = .{ a, b } });
}
/// ARM NEON intrinsic: `vceq_p64`
pub inline fn vceq_p64(a: types.p64x1, b: types.p64x1) types.u64x1 {
    const comparison = a == b;
    return @select(u64, comparison, @as(types.u64x1, @splat(0xffffffffffffffff)), @as(types.u64x1, @splat(0)));
}

test vceq_p64 {
    const a = types.p64x1{10};
    const b = types.p64x1{20};
    const expected = types.u64x1{0};
    try common.testIntrinsic(.{ .func = vceq_p64, .expected = expected, .args = .{ a, b } });
}
/// ARM NEON intrinsic: `vceqq_p64`
pub inline fn vceqq_p64(a: types.p64x2, b: types.p64x2) types.u64x2 {
    const comparison = a == b;
    return @select(u64, comparison, @as(types.u64x2, @splat(0xffffffffffffffff)), @as(types.u64x2, @splat(0)));
}

test vceqq_p64 {
    const a = types.p64x2{ 10, 50 };
    const b = types.p64x2{ 20, 40 };
    const expected = types.u64x2{ 0, 0 };
    try common.testIntrinsic(.{ .func = vceqq_p64, .expected = expected, .args = .{ a, b } });
}
/// ARM NEON intrinsic: `vceqz_s8`
pub inline fn vceqz_s8(a: types.i8x8) types.u8x8 {
    const comparison = a == @as(types.i8x8, @splat(0));
    return @select(u8, comparison, @as(types.u8x8, @splat(0xff)), @as(types.u8x8, @splat(0)));
}

test vceqz_s8 {
    const a = types.i8x8{ 0, 10, -5, 0, 42, 0, 1, -1 };
    const expected = types.u8x8{ 0xff, 0, 0, 0xff, 0, 0xff, 0, 0 };
    try common.testIntrinsic(.{ .func = vceqz_s8, .expected = expected, .args = .{a} });
}
/// ARM NEON intrinsic: `vceqzq_s8`
pub inline fn vceqzq_s8(a: types.i8x16) types.u8x16 {
    const comparison = a == @as(types.i8x16, @splat(0));
    return @select(u8, comparison, @as(types.u8x16, @splat(0xff)), @as(types.u8x16, @splat(0)));
}

test vceqzq_s8 {
    const a = types.i8x16{ 0, 10, -5, 0, 42, 0, 1, -1, 0, 0, 0, 0, 0, 0, 0, 0 };
    const expected = types.u8x16{ 0xff, 0, 0, 0xff, 0, 0xff, 0, 0, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff };
    try common.testIntrinsic(.{ .func = vceqzq_s8, .expected = expected, .args = .{a} });
}
/// ARM NEON intrinsic: `vceqz_s16`
pub inline fn vceqz_s16(a: types.i16x4) types.u16x4 {
    const comparison = a == @as(types.i16x4, @splat(0));
    return @select(u16, comparison, @as(types.u16x4, @splat(0xffff)), @as(types.u16x4, @splat(0)));
}

test vceqz_s16 {
    const a = types.i16x4{ 0, 10, -5, 0 };
    const expected = types.u16x4{ 0xffff, 0, 0, 0xffff };
    try common.testIntrinsic(.{ .func = vceqz_s16, .expected = expected, .args = .{a} });
}
/// ARM NEON intrinsic: `vceqzq_s16`
pub inline fn vceqzq_s16(a: types.i16x8) types.u16x8 {
    const comparison = a == @as(types.i16x8, @splat(0));
    return @select(u16, comparison, @as(types.u16x8, @splat(0xffff)), @as(types.u16x8, @splat(0)));
}

test vceqzq_s16 {
    const a = types.i16x8{ 0, 10, -5, 0, 42, 0, 1, -1 };
    const expected = types.u16x8{ 0xffff, 0, 0, 0xffff, 0, 0xffff, 0, 0 };
    try common.testIntrinsic(.{ .func = vceqzq_s16, .expected = expected, .args = .{a} });
}
/// ARM NEON intrinsic: `vceqz_s32`
pub inline fn vceqz_s32(a: types.i32x2) types.u32x2 {
    const comparison = a == @as(types.i32x2, @splat(0));
    return @select(u32, comparison, @as(types.u32x2, @splat(0xffffffff)), @as(types.u32x2, @splat(0)));
}

test vceqz_s32 {
    const a = types.i32x2{ 0, 10 };
    const expected = types.u32x2{ 0xffffffff, 0 };
    try common.testIntrinsic(.{ .func = vceqz_s32, .expected = expected, .args = .{a} });
}
/// ARM NEON intrinsic: `vceqzq_s32`
pub inline fn vceqzq_s32(a: types.i32x4) types.u32x4 {
    const comparison = a == @as(types.i32x4, @splat(0));
    return @select(u32, comparison, @as(types.u32x4, @splat(0xffffffff)), @as(types.u32x4, @splat(0)));
}

test vceqzq_s32 {
    const a = types.i32x4{ 0, 10, -5, 0 };
    const expected = types.u32x4{ 0xffffffff, 0, 0, 0xffffffff };
    try common.testIntrinsic(.{ .func = vceqzq_s32, .expected = expected, .args = .{a} });
}
/// ARM NEON intrinsic: `vceqz_s64`
pub inline fn vceqz_s64(a: types.i64x1) types.u64x1 {
    const comparison = a == @as(types.i64x1, @splat(0));
    return @select(u64, comparison, @as(types.u64x1, @splat(0xffffffffffffffff)), @as(types.u64x1, @splat(0)));
}

test vceqz_s64 {
    const a = types.i64x1{0};
    const expected = types.u64x1{0xffffffffffffffff};
    try common.testIntrinsic(.{ .func = vceqz_s64, .expected = expected, .args = .{a} });
}
/// ARM NEON intrinsic: `vceqzq_s64`
pub inline fn vceqzq_s64(a: types.i64x2) types.u64x2 {
    const comparison = a == @as(types.i64x2, @splat(0));
    return @select(u64, comparison, @as(types.u64x2, @splat(0xffffffffffffffff)), @as(types.u64x2, @splat(0)));
}

test vceqzq_s64 {
    const a = types.i64x2{ 0, 10 };
    const expected = types.u64x2{ 0xffffffffffffffff, 0 };
    try common.testIntrinsic(.{ .func = vceqzq_s64, .expected = expected, .args = .{a} });
}
/// ARM NEON intrinsic: `vceqz_u8`
pub inline fn vceqz_u8(a: types.u8x8) types.u8x8 {
    const comparison = a == @as(types.u8x8, @splat(0));
    return @select(u8, comparison, @as(types.u8x8, @splat(0xff)), @as(types.u8x8, @splat(0)));
}

test vceqz_u8 {
    const a = types.u8x8{ 0, 10, 5, 0, 42, 0, 1, 200 };
    const expected = types.u8x8{ 0xff, 0, 0, 0xff, 0, 0xff, 0, 0 };
    try common.testIntrinsic(.{ .func = vceqz_u8, .expected = expected, .args = .{a} });
}
/// ARM NEON intrinsic: `vceqzq_u8`
pub inline fn vceqzq_u8(a: types.u8x16) types.u8x16 {
    const comparison = a == @as(types.u8x16, @splat(0));
    return @select(u8, comparison, @as(types.u8x16, @splat(0xff)), @as(types.u8x16, @splat(0)));
}

test vceqzq_u8 {
    const a = types.u8x16{ 0, 10, 5, 0, 42, 0, 1, 200, 0, 0, 0, 0, 0, 0, 0, 0 };
    const expected = types.u8x16{ 0xff, 0, 0, 0xff, 0, 0xff, 0, 0, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff };
    try common.testIntrinsic(.{ .func = vceqzq_u8, .expected = expected, .args = .{a} });
}
/// ARM NEON intrinsic: `vceqz_u16`
pub inline fn vceqz_u16(a: types.u16x4) types.u16x4 {
    const comparison = a == @as(types.u16x4, @splat(0));
    return @select(u16, comparison, @as(types.u16x4, @splat(0xffff)), @as(types.u16x4, @splat(0)));
}

test vceqz_u16 {
    const a = types.u16x4{ 0, 10, 5, 0 };
    const expected = types.u16x4{ 0xffff, 0, 0, 0xffff };
    try common.testIntrinsic(.{ .func = vceqz_u16, .expected = expected, .args = .{a} });
}
/// ARM NEON intrinsic: `vceqzq_u16`
pub inline fn vceqzq_u16(a: types.u16x8) types.u16x8 {
    const comparison = a == @as(types.u16x8, @splat(0));
    return @select(u16, comparison, @as(types.u16x8, @splat(0xffff)), @as(types.u16x8, @splat(0)));
}

test vceqzq_u16 {
    const a = types.u16x8{ 0, 10, 5, 0, 42, 0, 1, 200 };
    const expected = types.u16x8{ 0xffff, 0, 0, 0xffff, 0, 0xffff, 0, 0 };
    try common.testIntrinsic(.{ .func = vceqzq_u16, .expected = expected, .args = .{a} });
}
/// ARM NEON intrinsic: `vceqz_u32`
pub inline fn vceqz_u32(a: types.u32x2) types.u32x2 {
    const comparison = a == @as(types.u32x2, @splat(0));
    return @select(u32, comparison, @as(types.u32x2, @splat(0xffffffff)), @as(types.u32x2, @splat(0)));
}

test vceqz_u32 {
    const a = types.u32x2{ 0, 10 };
    const expected = types.u32x2{ 0xffffffff, 0 };
    try common.testIntrinsic(.{ .func = vceqz_u32, .expected = expected, .args = .{a} });
}
/// ARM NEON intrinsic: `vceqzq_u32`
pub inline fn vceqzq_u32(a: types.u32x4) types.u32x4 {
    const comparison = a == @as(types.u32x4, @splat(0));
    return @select(u32, comparison, @as(types.u32x4, @splat(0xffffffff)), @as(types.u32x4, @splat(0)));
}

test vceqzq_u32 {
    const a = types.u32x4{ 0, 10, 5, 0 };
    const expected = types.u32x4{ 0xffffffff, 0, 0, 0xffffffff };
    try common.testIntrinsic(.{ .func = vceqzq_u32, .expected = expected, .args = .{a} });
}
/// ARM NEON intrinsic: `vceqz_u64`
pub inline fn vceqz_u64(a: types.u64x1) types.u64x1 {
    const comparison = a == @as(types.u64x1, @splat(0));
    return @select(u64, comparison, @as(types.u64x1, @splat(0xffffffffffffffff)), @as(types.u64x1, @splat(0)));
}

test vceqz_u64 {
    const a = types.u64x1{0};
    const expected = types.u64x1{0xffffffffffffffff};
    try common.testIntrinsic(.{ .func = vceqz_u64, .expected = expected, .args = .{a} });
}
/// ARM NEON intrinsic: `vceqzq_u64`
pub inline fn vceqzq_u64(a: types.u64x2) types.u64x2 {
    const comparison = a == @as(types.u64x2, @splat(0));
    return @select(u64, comparison, @as(types.u64x2, @splat(0xffffffffffffffff)), @as(types.u64x2, @splat(0)));
}

test vceqzq_u64 {
    const a = types.u64x2{ 0, 10 };
    const expected = types.u64x2{ 0xffffffffffffffff, 0 };
    try common.testIntrinsic(.{ .func = vceqzq_u64, .expected = expected, .args = .{a} });
}
/// ARM NEON intrinsic: `vceqz_f16`
pub inline fn vceqz_f16(a: types.f16x4) types.u16x4 {
    const comparison = a == @as(types.f16x4, @splat(0));
    return @select(u16, comparison, @as(types.u16x4, @splat(0xffff)), @as(types.u16x4, @splat(0)));
}

test vceqz_f16 {
    const a = types.f16x4{ 0.0, 1.5, -2.5, 0.0 };
    const expected = types.u16x4{ 0xffff, 0, 0, 0xffff };
    try common.testIntrinsic(.{ .func = vceqz_f16, .expected = expected, .args = .{a} });
}
/// ARM NEON intrinsic: `vceqzq_f16`
pub inline fn vceqzq_f16(a: types.f16x8) types.u16x8 {
    const comparison = a == @as(types.f16x8, @splat(0));
    return @select(u16, comparison, @as(types.u16x8, @splat(0xffff)), @as(types.u16x8, @splat(0)));
}

test vceqzq_f16 {
    const a = types.f16x8{ 0.0, 1.5, -2.5, 0.0, 10.0, 0.0, -0.5, 3.25 };
    const expected = types.u16x8{ 0xffff, 0, 0, 0xffff, 0, 0xffff, 0, 0 };
    try common.testIntrinsic(.{ .func = vceqzq_f16, .expected = expected, .args = .{a} });
}
/// ARM NEON intrinsic: `vceqz_f32`
pub inline fn vceqz_f32(a: types.f32x2) types.u32x2 {
    const comparison = a == @as(types.f32x2, @splat(0));
    return @select(u32, comparison, @as(types.u32x2, @splat(0xffffffff)), @as(types.u32x2, @splat(0)));
}

test vceqz_f32 {
    const a = types.f32x2{ 0.0, 1.5 };
    const expected = types.u32x2{ 0xffffffff, 0 };
    try common.testIntrinsic(.{ .func = vceqz_f32, .expected = expected, .args = .{a} });
}
/// ARM NEON intrinsic: `vceqzq_f32`
pub inline fn vceqzq_f32(a: types.f32x4) types.u32x4 {
    const comparison = a == @as(types.f32x4, @splat(0));
    return @select(u32, comparison, @as(types.u32x4, @splat(0xffffffff)), @as(types.u32x4, @splat(0)));
}

test vceqzq_f32 {
    const a = types.f32x4{ 0.0, 1.5, -2.5, 0.0 };
    const expected = types.u32x4{ 0xffffffff, 0, 0, 0xffffffff };
    try common.testIntrinsic(.{ .func = vceqzq_f32, .expected = expected, .args = .{a} });
}
/// ARM NEON intrinsic: `vceqz_f64`
pub inline fn vceqz_f64(a: types.f64x1) types.u64x1 {
    const comparison = a == @as(types.f64x1, @splat(0));
    return @select(u64, comparison, @as(types.u64x1, @splat(0xffffffffffffffff)), @as(types.u64x1, @splat(0)));
}

test vceqz_f64 {
    const a = types.f64x1{0.0};
    const expected = types.u64x1{0xffffffffffffffff};
    try common.testIntrinsic(.{ .func = vceqz_f64, .expected = expected, .args = .{a} });
}
/// ARM NEON intrinsic: `vceqzq_f64`
pub inline fn vceqzq_f64(a: types.f64x2) types.u64x2 {
    const comparison = a == @as(types.f64x2, @splat(0));
    return @select(u64, comparison, @as(types.u64x2, @splat(0xffffffffffffffff)), @as(types.u64x2, @splat(0)));
}

test vceqzq_f64 {
    const a = types.f64x2{ 0.0, 1.5 };
    const expected = types.u64x2{ 0xffffffffffffffff, 0 };
    try common.testIntrinsic(.{ .func = vceqzq_f64, .expected = expected, .args = .{a} });
}
/// ARM NEON intrinsic: `vceqz_p8`
pub inline fn vceqz_p8(a: types.p8x8) types.u8x8 {
    const comparison = a == @as(types.p8x8, @splat(0));
    return @select(u8, comparison, @as(types.u8x8, @splat(0xff)), @as(types.u8x8, @splat(0)));
}

test vceqz_p8 {
    const a = types.p8x8{ 0, 10, 5, 0, 42, 0, 1, 200 };
    const expected = types.u8x8{ 0xff, 0, 0, 0xff, 0, 0xff, 0, 0 };
    try common.testIntrinsic(.{ .func = vceqz_p8, .expected = expected, .args = .{a} });
}
/// ARM NEON intrinsic: `vceqzq_p8`
pub inline fn vceqzq_p8(a: types.p8x16) types.u8x16 {
    const comparison = a == @as(types.p8x16, @splat(0));
    return @select(u8, comparison, @as(types.u8x16, @splat(0xff)), @as(types.u8x16, @splat(0)));
}

test vceqzq_p8 {
    const a = types.p8x16{ 0, 10, 5, 0, 42, 0, 1, 200, 0, 0, 0, 0, 0, 0, 0, 0 };
    const expected = types.u8x16{ 0xff, 0, 0, 0xff, 0, 0xff, 0, 0, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff };
    try common.testIntrinsic(.{ .func = vceqzq_p8, .expected = expected, .args = .{a} });
}
/// ARM NEON intrinsic: `vceqz_p64`
pub inline fn vceqz_p64(a: types.p64x1) types.u64x1 {
    const comparison = a == @as(types.p64x1, @splat(0));
    return @select(u64, comparison, @as(types.u64x1, @splat(0xffffffffffffffff)), @as(types.u64x1, @splat(0)));
}

test vceqz_p64 {
    const a = types.p64x1{0};
    const expected = types.u64x1{0xffffffffffffffff};
    try common.testIntrinsic(.{ .func = vceqz_p64, .expected = expected, .args = .{a} });
}
/// ARM NEON intrinsic: `vceqzq_p64`
pub inline fn vceqzq_p64(a: types.p64x2) types.u64x2 {
    const comparison = a == @as(types.p64x2, @splat(0));
    return @select(u64, comparison, @as(types.u64x2, @splat(0xffffffffffffffff)), @as(types.u64x2, @splat(0)));
}

test vceqzq_p64 {
    const a = types.p64x2{ 0, 10 };
    const expected = types.u64x2{ 0xffffffffffffffff, 0 };
    try common.testIntrinsic(.{ .func = vceqzq_p64, .expected = expected, .args = .{a} });
}

/// ARM NEON intrinsic: `vcagt_f16`
pub inline fn vcagt_f16(a: types.f16x4, b: types.f16x4) types.u16x4 {
    const comparison = @abs(a) > @abs(b);
    return @select(u16, comparison, @as(types.u16x4, @splat(0xffff)), @as(types.u16x4, @splat(0)));
}

test vcagt_f16 {
    const a = types.f16x4{ -1.5, 2.0, 0.0, 5.5 };
    const b = types.f16x4{ 1.0, 1.5, 0.0, 10.0 };
    const expected = types.u16x4{ 0xffff, 0xffff, 0, 0 };
    try common.testIntrinsic(.{ .func = vcagt_f16, .expected = expected, .args = .{ a, b } });
}

/// ARM NEON intrinsic: `vcagtq_f16`
pub inline fn vcagtq_f16(a: types.f16x8, b: types.f16x8) types.u16x8 {
    const comparison = @abs(a) > @abs(b);
    return @select(u16, comparison, @as(types.u16x8, @splat(0xffff)), @as(types.u16x8, @splat(0)));
}

test vcagtq_f16 {
    const a = types.f16x8{ -1.5, 2.0, 0.0, 5.5, 3.0, -10.0, 1.0, 0.0 };
    const b = types.f16x8{ 1.0, 1.5, 0.0, 10.0, -3.0, -10.0, 2.0, 0.0 };
    const expected = types.u16x8{ 0xffff, 0xffff, 0, 0, 0, 0, 0, 0 };
    try common.testIntrinsic(.{ .func = vcagtq_f16, .expected = expected, .args = .{ a, b } });
}
/// ARM NEON intrinsic: `vcagtq_f32`
pub inline fn vcagtq_f32(a: types.f32x4, b: types.f32x4) types.u32x4 {
    const comparison = @abs(a) > @abs(b);
    return @select(u32, comparison, @as(types.u32x4, @splat(0xffffffff)), @as(types.u32x4, @splat(0)));
}

test vcagtq_f32 {
    const a = types.f32x4{ -1.5, 2.0, 0.0, 5.5 };
    const b = types.f32x4{ 1.0, 1.5, 0.0, 10.0 };
    const expected = types.u32x4{ 0xffffffff, 0xffffffff, 0, 0 };
    try common.testIntrinsic(.{ .func = vcagtq_f32, .expected = expected, .args = .{ a, b } });
}
/// ARM NEON intrinsic: `vcagtq_f64`
pub inline fn vcagtq_f64(a: types.f64x2, b: types.f64x2) types.u64x2 {
    const comparison = @abs(a) > @abs(b);
    return @select(u64, comparison, @as(types.u64x2, @splat(0xffffffffffffffff)), @as(types.u64x2, @splat(0)));
}

test vcagtq_f64 {
    const a = types.f64x2{ -1.5, 2.0 };
    const b = types.f64x2{ 1.0, 1.5 };
    const expected = types.u64x2{ 0xffffffffffffffff, 0xffffffffffffffff };
    try common.testIntrinsic(.{ .func = vcagtq_f64, .expected = expected, .args = .{ a, b } });
}
/// ARM NEON intrinsic: `vcagts_f32`
pub inline fn vcagts_f32(a: f32, b: f32) u32 {
    const comparison = @abs(a) > @abs(b);
    return if (comparison) 0xffffffff else 0;
}

test vcagts_f32 {
    const a: f32 = -3.5;
    const b: f32 = 2.0;
    const expected: u32 = 0xffffffff;
    try common.testIntrinsic(.{ .func = vcagts_f32, .expected = expected, .args = .{ a, b } });
}
/// ARM NEON intrinsic: `vcagtd_f64`
pub inline fn vcagtd_f64(a: f64, b: f64) u64 {
    const comparison = @abs(a) > @abs(b);
    return if (comparison) 0xffffffffffffffff else 0;
}

test vcagtd_f64 {
    const a: f64 = 1.5;
    const b: f64 = -3.0;
    const expected: u64 = 0x0;
    try common.testIntrinsic(.{ .func = vcagtd_f64, .expected = expected, .args = .{ a, b } });
}
/// ARM NEON intrinsic: `vcage_f16`
pub inline fn vcage_f16(a: types.f16x4, b: types.f16x4) types.u16x4 {
    const comparison = @abs(a) >= @abs(b);
    return @select(u16, comparison, @as(types.u16x4, @splat(0xffff)), @as(types.u16x4, @splat(0)));
}

test vcage_f16 {
    const a = types.f16x4{ -1.5, 2.0, 0.0, 5.5 };
    const b = types.f16x4{ 1.0, 1.5, 0.0, 10.0 };
    const expected = types.u16x4{ 0xffff, 0xffff, 0xffff, 0 };
    try common.testIntrinsic(.{ .func = vcage_f16, .expected = expected, .args = .{ a, b } });
}

/// ARM NEON intrinsic: `vcageq_f16`
pub inline fn vcageq_f16(a: types.f16x8, b: types.f16x8) types.u16x8 {
    const comparison = @abs(a) >= @abs(b);
    return @select(u16, comparison, @as(types.u16x8, @splat(0xffff)), @as(types.u16x8, @splat(0)));
}

test vcageq_f16 {
    const a = types.f16x8{ -1.5, 2.0, 0.0, 5.5, 3.0, -10.0, 1.0, 0.0 };
    const b = types.f16x8{ 1.0, 1.5, 0.0, 10.0, -3.0, -10.0, 2.0, 0.0 };
    const expected = types.u16x8{ 0xffff, 0xffff, 0xffff, 0, 0xffff, 0xffff, 0, 0xffff };
    try common.testIntrinsic(.{ .func = vcageq_f16, .expected = expected, .args = .{ a, b } });
}

/// ARM NEON intrinsic: `vcages_f32`
pub inline fn vcages_f32(a: f32, b: f32) u32 {
    const comparison = @abs(a) >= @abs(b);
    return if (comparison) 0xffffffff else 0;
}

test vcages_f32 {
    const a: f32 = 0.0;
    const b: f32 = 0.0;
    const expected: u32 = 0xffffffff;
    try common.testIntrinsic(.{ .func = vcages_f32, .expected = expected, .args = .{ a, b } });
}
/// ARM NEON intrinsic: `vcaged_f64`
pub inline fn vcaged_f64(a: f64, b: f64) u64 {
    const comparison = @abs(a) >= @abs(b);
    return if (comparison) 0xffffffffffffffff else 0;
}

test vcaged_f64 {
    const a: f64 = 0.0;
    const b: f64 = 0.0;
    const expected: u64 = 0xffffffffffffffff;
    try common.testIntrinsic(.{ .func = vcaged_f64, .expected = expected, .args = .{ a, b } });
}
/// ARM NEON intrinsic: `vcalt_f16`
pub inline fn vcalt_f16(a: types.f16x4, b: types.f16x4) types.u16x4 {
    const comparison = @abs(a) < @abs(b);
    return @select(u16, comparison, @as(types.u16x4, @splat(0xffff)), @as(types.u16x4, @splat(0)));
}

test vcalt_f16 {
    const a = types.f16x4{ -1.5, 2.0, 0.0, 5.5 };
    const b = types.f16x4{ 1.0, 1.5, 0.0, 10.0 };
    const expected = types.u16x4{ 0, 0, 0, 0xffff };
    try common.testIntrinsic(.{ .func = vcalt_f16, .expected = expected, .args = .{ a, b } });
}
/// ARM NEON intrinsic: `vcalt_f32`
pub inline fn vcalt_f32(a: types.f32x2, b: types.f32x2) types.u32x2 {
    const comparison = @abs(a) < @abs(b);
    return @select(u32, comparison, @as(types.u32x2, @splat(0xffffffff)), @as(types.u32x2, @splat(0)));
}

test vcalt_f32 {
    const a = types.f32x2{ -1.5, 2.0 };
    const b = types.f32x2{ 1.0, 1.5 };
    const expected = types.u32x2{ 0, 0 };
    try common.testIntrinsic(.{ .func = vcalt_f32, .expected = expected, .args = .{ a, b } });
}
/// ARM NEON intrinsic: `vcaltq_f16`
pub inline fn vcaltq_f16(a: types.f16x8, b: types.f16x8) types.u16x8 {
    const comparison = @abs(a) < @abs(b);
    return @select(u16, comparison, @as(types.u16x8, @splat(0xffff)), @as(types.u16x8, @splat(0)));
}

test vcaltq_f16 {
    const a = types.f16x8{ -1.5, 2.0, 0.0, 5.5, 3.0, -10.0, 1.0, 0.0 };
    const b = types.f16x8{ 1.0, 1.5, 0.0, 10.0, -3.0, -10.0, 2.0, 0.0 };
    const expected = types.u16x8{ 0, 0, 0, 0xffff, 0, 0, 0xffff, 0 };
    try common.testIntrinsic(.{ .func = vcaltq_f16, .expected = expected, .args = .{ a, b } });
}
/// ARM NEON intrinsic: `vcaltq_f32`
pub inline fn vcaltq_f32(a: types.f32x4, b: types.f32x4) types.u32x4 {
    const comparison = @abs(a) < @abs(b);
    return @select(u32, comparison, @as(types.u32x4, @splat(0xffffffff)), @as(types.u32x4, @splat(0)));
}

test vcaltq_f32 {
    const a = types.f32x4{ -1.5, 2.0, 0.0, 5.5 };
    const b = types.f32x4{ 1.0, 1.5, 0.0, 10.0 };
    const expected = types.u32x4{ 0, 0, 0, 0xffffffff };
    try common.testIntrinsic(.{ .func = vcaltq_f32, .expected = expected, .args = .{ a, b } });
}
/// ARM NEON intrinsic: `vcaltq_f64`
pub inline fn vcaltq_f64(a: types.f64x2, b: types.f64x2) types.u64x2 {
    const comparison = @abs(a) < @abs(b);
    return @select(u64, comparison, @as(types.u64x2, @splat(0xffffffffffffffff)), @as(types.u64x2, @splat(0)));
}

test vcaltq_f64 {
    const a = types.f64x2{ -1.5, 2.0 };
    const b = types.f64x2{ 1.0, 1.5 };
    const expected = types.u64x2{ 0, 0 };
    try common.testIntrinsic(.{ .func = vcaltq_f64, .expected = expected, .args = .{ a, b } });
}
/// ARM NEON intrinsic: `vcalts_f32`
pub inline fn vcalts_f32(a: f32, b: f32) u32 {
    const comparison = @abs(a) < @abs(b);
    return if (comparison) 0xffffffff else 0;
}

test vcalts_f32 {
    const a: f32 = -1.5;
    const b: f32 = 2.0;
    const expected: u32 = 0xffffffff;
    try common.testIntrinsic(.{ .func = vcalts_f32, .expected = expected, .args = .{ a, b } });
}
/// ARM NEON intrinsic: `vcaltd_f64`
pub inline fn vcaltd_f64(a: f64, b: f64) u64 {
    const comparison = @abs(a) < @abs(b);
    return if (comparison) 0xffffffffffffffff else 0;
}

test vcaltd_f64 {
    const a: f64 = -4.0;
    const b: f64 = 2.5;
    const expected: u64 = 0x0;
    try common.testIntrinsic(.{ .func = vcaltd_f64, .expected = expected, .args = .{ a, b } });
}
/// ARM NEON intrinsic: `vcale_f16`
pub inline fn vcale_f16(a: types.f16x4, b: types.f16x4) types.u16x4 {
    const comparison = @abs(a) <= @abs(b);
    return @select(u16, comparison, @as(types.u16x4, @splat(0xffff)), @as(types.u16x4, @splat(0)));
}

test vcale_f16 {
    const a = types.f16x4{ -1.5, 2.0, 0.0, 5.5 };
    const b = types.f16x4{ 1.0, 1.5, 0.0, 10.0 };
    const expected = types.u16x4{ 0, 0, 0xffff, 0xffff };
    try common.testIntrinsic(.{ .func = vcale_f16, .expected = expected, .args = .{ a, b } });
}
/// ARM NEON intrinsic: `vcale_f32`
pub inline fn vcale_f32(a: types.f32x2, b: types.f32x2) types.u32x2 {
    const comparison = @abs(a) <= @abs(b);
    return @select(u32, comparison, @as(types.u32x2, @splat(0xffffffff)), @as(types.u32x2, @splat(0)));
}

test vcale_f32 {
    const a = types.f32x2{ -1.5, 2.0 };
    const b = types.f32x2{ 1.0, 1.5 };
    const expected = types.u32x2{ 0, 0 };
    try common.testIntrinsic(.{ .func = vcale_f32, .expected = expected, .args = .{ a, b } });
}
/// ARM NEON intrinsic: `vcaleq_f16`
pub inline fn vcaleq_f16(a: types.f16x8, b: types.f16x8) types.u16x8 {
    const comparison = @abs(a) <= @abs(b);
    return @select(u16, comparison, @as(types.u16x8, @splat(0xffff)), @as(types.u16x8, @splat(0)));
}

test vcaleq_f16 {
    const a = types.f16x8{ -1.5, 2.0, 0.0, 5.5, 3.0, -10.0, 1.0, 0.0 };
    const b = types.f16x8{ 1.0, 1.5, 0.0, 10.0, -3.0, -10.0, 2.0, 0.0 };
    const expected = types.u16x8{ 0, 0, 0xffff, 0xffff, 0xffff, 0xffff, 0xffff, 0xffff };
    try common.testIntrinsic(.{ .func = vcaleq_f16, .expected = expected, .args = .{ a, b } });
}
/// ARM NEON intrinsic: `vcaleq_f32`
pub inline fn vcaleq_f32(a: types.f32x4, b: types.f32x4) types.u32x4 {
    const comparison = @abs(a) <= @abs(b);
    return @select(u32, comparison, @as(types.u32x4, @splat(0xffffffff)), @as(types.u32x4, @splat(0)));
}

test vcaleq_f32 {
    const a = types.f32x4{ -1.5, 2.0, 0.0, 5.5 };
    const b = types.f32x4{ 1.0, 1.5, 0.0, 10.0 };
    const expected = types.u32x4{ 0, 0, 0xffffffff, 0xffffffff };
    try common.testIntrinsic(.{ .func = vcaleq_f32, .expected = expected, .args = .{ a, b } });
}
/// ARM NEON intrinsic: `vcaleq_f64`
pub inline fn vcaleq_f64(a: types.f64x2, b: types.f64x2) types.u64x2 {
    const comparison = @abs(a) <= @abs(b);
    return @select(u64, comparison, @as(types.u64x2, @splat(0xffffffffffffffff)), @as(types.u64x2, @splat(0)));
}

test vcaleq_f64 {
    const a = types.f64x2{ -1.5, 2.0 };
    const b = types.f64x2{ 1.0, 1.5 };
    const expected = types.u64x2{ 0, 0 };
    try common.testIntrinsic(.{ .func = vcaleq_f64, .expected = expected, .args = .{ a, b } });
}
/// ARM NEON intrinsic: `vcales_f32`
pub inline fn vcales_f32(a: f32, b: f32) u32 {
    const comparison = @abs(a) <= @abs(b);
    return if (comparison) 0xffffffff else 0;
}

test vcales_f32 {
    const a: f32 = 0.0;
    const b: f32 = 0.0;
    const expected: u32 = 0xffffffff;
    try common.testIntrinsic(.{ .func = vcales_f32, .expected = expected, .args = .{ a, b } });
}
/// ARM NEON intrinsic: `vcaled_f64`
pub inline fn vcaled_f64(a: f64, b: f64) u64 {
    const comparison = @abs(a) <= @abs(b);
    return if (comparison) 0xffffffffffffffff else 0;
}

test vcaled_f64 {
    const a: f64 = 0.0;
    const b: f64 = 0.0;
    const expected: u64 = 0xffffffffffffffff;
    try common.testIntrinsic(.{ .func = vcaled_f64, .expected = expected, .args = .{ a, b } });
}

/// Compare greater than or equal
pub inline fn vcgeq_s8(a: types.i8x8, b: types.i8x8) types.u8x8 {
    const comparison = a >= b;
    return @select(u8, comparison, @as(types.u8x8, @splat(0xff)), @as(types.u8x8, @splat(0)));
}

test vcgeq_s8 {
    const a = types.i8x8{ -10, 20, 0, 50, -100, 42, 40, -1 };
    const b = types.i8x8{ 10, 15, 0, 100, -100, 0, 39, 0 };
    const expected = types.u8x8{ 0, 0xff, 0xff, 0, 0xff, 0xff, 0xff, 0 };
    try common.testIntrinsic(.{ .func = vcgeq_s8, .expected = expected, .args = .{ a, b } });
}

/// Compare greater than or equal
pub inline fn vcgeqq_s8(a: types.i8x16, b: types.i8x16) types.u8x16 {
    const comparison = a >= b;
    return @select(u8, comparison, @as(types.u8x16, @splat(0xff)), @as(types.u8x16, @splat(0)));
}

test vcgeqq_s8 {
    const a = types.i8x16{ -10, 20, 0, 50, -100, 42, 40, -1, -10, -10, -10, -10, -10, -10, -10, -10 };
    const b = types.i8x16{ 10, 15, 0, 100, -100, 0, 39, 0, 10, 10, 10, 10, 10, 10, 10, 10 };
    const expected = types.u8x16{ 0, 0xff, 0xff, 0, 0xff, 0xff, 0xff, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
    try common.testIntrinsic(.{ .func = vcgeqq_s8, .expected = expected, .args = .{ a, b } });
}

/// Compare greater than or equal
pub inline fn vcgeq_s16(a: types.i16x4, b: types.i16x4) types.u16x4 {
    const comparison = a >= b;
    return @select(u16, comparison, @as(types.u16x4, @splat(0xffff)), @as(types.u16x4, @splat(0)));
}

test vcgeq_s16 {
    const a = types.i16x4{ -10, 20, 0, 50 };
    const b = types.i16x4{ 10, 15, 0, 100 };
    const expected = types.u16x4{ 0, 0xffff, 0xffff, 0 };
    try common.testIntrinsic(.{ .func = vcgeq_s16, .expected = expected, .args = .{ a, b } });
}

/// Compare greater than or equal
pub inline fn vcgeqq_s16(a: types.i16x8, b: types.i16x8) types.u16x8 {
    const comparison = a >= b;
    return @select(u16, comparison, @as(types.u16x8, @splat(0xffff)), @as(types.u16x8, @splat(0)));
}

test vcgeqq_s16 {
    const a = types.i16x8{ -10, 20, 0, 50, -100, 42, 40, -1 };
    const b = types.i16x8{ 10, 15, 0, 100, -100, 0, 39, 0 };
    const expected = types.u16x8{ 0, 0xffff, 0xffff, 0, 0xffff, 0xffff, 0xffff, 0 };
    try common.testIntrinsic(.{ .func = vcgeqq_s16, .expected = expected, .args = .{ a, b } });
}

/// Compare greater than or equal
pub inline fn vcgeq_s32(a: types.i32x2, b: types.i32x2) types.u32x2 {
    const comparison = a >= b;
    return @select(u32, comparison, @as(types.u32x2, @splat(0xffffffff)), @as(types.u32x2, @splat(0)));
}

test vcgeq_s32 {
    const a = types.i32x2{ -10, 20 };
    const b = types.i32x2{ 10, 15 };
    const expected = types.u32x2{ 0, 0xffffffff };
    try common.testIntrinsic(.{ .func = vcgeq_s32, .expected = expected, .args = .{ a, b } });
}

/// Compare greater than or equal
pub inline fn vcgeqq_s32(a: types.i32x4, b: types.i32x4) types.u32x4 {
    const comparison = a >= b;
    return @select(u32, comparison, @as(types.u32x4, @splat(0xffffffff)), @as(types.u32x4, @splat(0)));
}

test vcgeqq_s32 {
    const a = types.i32x4{ -10, 20, 0, 50 };
    const b = types.i32x4{ 10, 15, 0, 100 };
    const expected = types.u32x4{ 0, 0xffffffff, 0xffffffff, 0 };
    try common.testIntrinsic(.{ .func = vcgeqq_s32, .expected = expected, .args = .{ a, b } });
}

/// Compare greater than or equal
pub inline fn vcgeq_s64(a: types.i64x1, b: types.i64x1) types.u64x1 {
    const comparison = a >= b;
    return @select(u64, comparison, @as(types.u64x1, @splat(0xffffffffffffffff)), @as(types.u64x1, @splat(0)));
}

test vcgeq_s64 {
    const a = types.i64x1{-10};
    const b = types.i64x1{10};
    const expected = types.u64x1{0};
    try common.testIntrinsic(.{ .func = vcgeq_s64, .expected = expected, .args = .{ a, b } });
}

/// Compare greater than or equal
pub inline fn vcgeqq_s64(a: types.i64x2, b: types.i64x2) types.u64x2 {
    const comparison = a >= b;
    return @select(u64, comparison, @as(types.u64x2, @splat(0xffffffffffffffff)), @as(types.u64x2, @splat(0)));
}

test vcgeqq_s64 {
    const a = types.i64x2{ -10, 20 };
    const b = types.i64x2{ 10, 15 };
    const expected = types.u64x2{ 0, 0xffffffffffffffff };
    try common.testIntrinsic(.{ .func = vcgeqq_s64, .expected = expected, .args = .{ a, b } });
}

/// Compare greater than or equal
pub inline fn vcgeq_u8(a: types.u8x8, b: types.u8x8) types.u8x8 {
    const comparison = a >= b;
    return @select(u8, comparison, @as(types.u8x8, @splat(0xff)), @as(types.u8x8, @splat(0)));
}

test vcgeq_u8 {
    const a = types.u8x8{ 10, 50, 0, 100, 200, 1, 40, 100 };
    const b = types.u8x8{ 20, 40, 0, 100, 50, 2, 41, 50 };
    const expected = types.u8x8{ 0, 0xff, 0xff, 0xff, 0xff, 0, 0, 0xff };
    try common.testIntrinsic(.{ .func = vcgeq_u8, .expected = expected, .args = .{ a, b } });
}

/// Compare greater than or equal
pub inline fn vcgeqq_u8(a: types.u8x16, b: types.u8x16) types.u8x16 {
    const comparison = a >= b;
    return @select(u8, comparison, @as(types.u8x16, @splat(0xff)), @as(types.u8x16, @splat(0)));
}

test vcgeqq_u8 {
    const a = types.u8x16{ 10, 50, 0, 100, 200, 1, 40, 100, 10, 10, 10, 10, 10, 10, 10, 10 };
    const b = types.u8x16{ 20, 40, 0, 100, 50, 2, 41, 50, 20, 20, 20, 20, 20, 20, 20, 20 };
    const expected = types.u8x16{ 0, 0xff, 0xff, 0xff, 0xff, 0, 0, 0xff, 0, 0, 0, 0, 0, 0, 0, 0 };
    try common.testIntrinsic(.{ .func = vcgeqq_u8, .expected = expected, .args = .{ a, b } });
}

/// Compare greater than or equal
pub inline fn vcgeq_u16(a: types.u16x4, b: types.u16x4) types.u16x4 {
    const comparison = a >= b;
    return @select(u16, comparison, @as(types.u16x4, @splat(0xffff)), @as(types.u16x4, @splat(0)));
}

test vcgeq_u16 {
    const a = types.u16x4{ 10, 50, 0, 100 };
    const b = types.u16x4{ 20, 40, 0, 100 };
    const expected = types.u16x4{ 0, 0xffff, 0xffff, 0xffff };
    try common.testIntrinsic(.{ .func = vcgeq_u16, .expected = expected, .args = .{ a, b } });
}

/// Compare greater than or equal
pub inline fn vcgeqq_u16(a: types.u16x8, b: types.u16x8) types.u16x8 {
    const comparison = a >= b;
    return @select(u16, comparison, @as(types.u16x8, @splat(0xffff)), @as(types.u16x8, @splat(0)));
}

test vcgeqq_u16 {
    const a = types.u16x8{ 10, 50, 0, 100, 200, 1, 40, 100 };
    const b = types.u16x8{ 20, 40, 0, 100, 50, 2, 41, 50 };
    const expected = types.u16x8{ 0, 0xffff, 0xffff, 0xffff, 0xffff, 0, 0, 0xffff };
    try common.testIntrinsic(.{ .func = vcgeqq_u16, .expected = expected, .args = .{ a, b } });
}

/// Compare greater than or equal
pub inline fn vcgeq_u32(a: types.u32x2, b: types.u32x2) types.u32x2 {
    const comparison = a >= b;
    return @select(u32, comparison, @as(types.u32x2, @splat(0xffffffff)), @as(types.u32x2, @splat(0)));
}

test vcgeq_u32 {
    const a = types.u32x2{ 10, 50 };
    const b = types.u32x2{ 20, 40 };
    const expected = types.u32x2{ 0, 0xffffffff };
    try common.testIntrinsic(.{ .func = vcgeq_u32, .expected = expected, .args = .{ a, b } });
}

/// Compare greater than or equal
pub inline fn vcgeqq_u32(a: types.u32x4, b: types.u32x4) types.u32x4 {
    const comparison = a >= b;
    return @select(u32, comparison, @as(types.u32x4, @splat(0xffffffff)), @as(types.u32x4, @splat(0)));
}

test vcgeqq_u32 {
    const a = types.u32x4{ 10, 50, 0, 100 };
    const b = types.u32x4{ 20, 40, 0, 100 };
    const expected = types.u32x4{ 0, 0xffffffff, 0xffffffff, 0xffffffff };
    try common.testIntrinsic(.{ .func = vcgeqq_u32, .expected = expected, .args = .{ a, b } });
}

/// Compare greater than or equal
pub inline fn vcgeq_u64(a: types.u64x1, b: types.u64x1) types.u64x1 {
    const comparison = a >= b;
    return @select(u64, comparison, @as(types.u64x1, @splat(0xffffffffffffffff)), @as(types.u64x1, @splat(0)));
}

test vcgeq_u64 {
    const a = types.u64x1{10};
    const b = types.u64x1{20};
    const expected = types.u64x1{0};
    try common.testIntrinsic(.{ .func = vcgeq_u64, .expected = expected, .args = .{ a, b } });
}

/// Compare greater than or equal
pub inline fn vcgeqq_u64(a: types.u64x2, b: types.u64x2) types.u64x2 {
    const comparison = a >= b;
    return @select(u64, comparison, @as(types.u64x2, @splat(0xffffffffffffffff)), @as(types.u64x2, @splat(0)));
}

test vcgeqq_u64 {
    const a = types.u64x2{ 10, 50 };
    const b = types.u64x2{ 20, 40 };
    const expected = types.u64x2{ 0, 0xffffffffffffffff };
    try common.testIntrinsic(.{ .func = vcgeqq_u64, .expected = expected, .args = .{ a, b } });
}

/// Compare greater than or equal
pub inline fn vcgeq_f16(a: types.f16x4, b: types.f16x4) types.u16x4 {
    const comparison = a >= b;
    return @select(u16, comparison, @as(types.u16x4, @splat(0xffff)), @as(types.u16x4, @splat(0)));
}

test vcgeq_f16 {
    const a = types.f16x4{ -1.5, 2.0, 0.0, 5.5 };
    const b = types.f16x4{ 1.0, 1.5, 0.0, 10.0 };
    const expected = types.u16x4{ 0, 0xffff, 0xffff, 0 };
    try common.testIntrinsic(.{ .func = vcgeq_f16, .expected = expected, .args = .{ a, b } });
}

/// Compare greater than or equal
pub inline fn vcgeqq_f16(a: types.f16x8, b: types.f16x8) types.u16x8 {
    const comparison = a >= b;
    return @select(u16, comparison, @as(types.u16x8, @splat(0xffff)), @as(types.u16x8, @splat(0)));
}

test vcgeqq_f16 {
    const a = types.f16x8{ -1.5, 2.0, 0.0, 5.5, 3.0, -10.0, 1.0, 0.0 };
    const b = types.f16x8{ 1.0, 1.5, 0.0, 10.0, -3.0, -10.0, 2.0, 0.0 };
    const expected = types.u16x8{ 0, 0xffff, 0xffff, 0, 0xffff, 0xffff, 0, 0xffff };
    try common.testIntrinsic(.{ .func = vcgeqq_f16, .expected = expected, .args = .{ a, b } });
}

/// Compare greater than or equal
pub inline fn vcgeq_f32(a: types.f32x2, b: types.f32x2) types.u32x2 {
    const comparison = a >= b;
    return @select(u32, comparison, @as(types.u32x2, @splat(0xffffffff)), @as(types.u32x2, @splat(0)));
}

test vcgeq_f32 {
    const a = types.f32x2{ -1.5, 2.0 };
    const b = types.f32x2{ 1.0, 1.5 };
    const expected = types.u32x2{ 0, 0xffffffff };
    try common.testIntrinsic(.{ .func = vcgeq_f32, .expected = expected, .args = .{ a, b } });
}

/// Compare greater than or equal
pub inline fn vcgeqq_f32(a: types.f32x4, b: types.f32x4) types.u32x4 {
    const comparison = a >= b;
    return @select(u32, comparison, @as(types.u32x4, @splat(0xffffffff)), @as(types.u32x4, @splat(0)));
}

test vcgeqq_f32 {
    const a = types.f32x4{ -1.5, 2.0, 0.0, 5.5 };
    const b = types.f32x4{ 1.0, 1.5, 0.0, 10.0 };
    const expected = types.u32x4{ 0, 0xffffffff, 0xffffffff, 0 };
    try common.testIntrinsic(.{ .func = vcgeqq_f32, .expected = expected, .args = .{ a, b } });
}

/// Compare greater than or equal
pub inline fn vcgeq_f64(a: types.f64x1, b: types.f64x1) types.u64x1 {
    const comparison = a >= b;
    return @select(u64, comparison, @as(types.u64x1, @splat(0xffffffffffffffff)), @as(types.u64x1, @splat(0)));
}

test vcgeq_f64 {
    const a = types.f64x1{-1.5};
    const b = types.f64x1{1.0};
    const expected = types.u64x1{0};
    try common.testIntrinsic(.{ .func = vcgeq_f64, .expected = expected, .args = .{ a, b } });
}

/// Compare greater than or equal
pub inline fn vcgeqq_f64(a: types.f64x2, b: types.f64x2) types.u64x2 {
    const comparison = a >= b;
    return @select(u64, comparison, @as(types.u64x2, @splat(0xffffffffffffffff)), @as(types.u64x2, @splat(0)));
}

test vcgeqq_f64 {
    const a = types.f64x2{ -1.5, 2.0 };
    const b = types.f64x2{ 1.0, 1.5 };
    const expected = types.u64x2{ 0, 0xffffffffffffffff };
    try common.testIntrinsic(.{ .func = vcgeqq_f64, .expected = expected, .args = .{ a, b } });
}

/// Compare greater than (f32x2)
pub inline fn vcgt_f32(a: types.f32x2, b: types.f32x2) types.u32x2 {
    const comparison = a > b;
    return @select(u32, comparison, @as(types.u32x2, @splat(0xffffffff)), @as(types.u32x2, @splat(0)));
}

test vcgt_f32 {
    const a = types.f32x2{ -1.5, 2.0 };
    const b = types.f32x2{ 1.0, 1.5 };
    const expected = types.u32x2{ 0, 0xffffffff };
    try common.testIntrinsic(.{ .func = vcgt_f32, .expected = expected, .args = .{ a, b } });
}

/// Compare greater than (f32x4)
pub inline fn vcgtq_f32(a: types.f32x4, b: types.f32x4) types.u32x4 {
    const comparison = a > b;
    return @select(u32, comparison, @as(types.u32x4, @splat(0xffffffff)), @as(types.u32x4, @splat(0)));
}

test vcgtq_f32 {
    const a = types.f32x4{ -1.5, 2.0, 0.0, 5.5 };
    const b = types.f32x4{ 1.0, 1.5, 0.0, 10.0 };
    const expected = types.u32x4{ 0, 0xffffffff, 0, 0 };
    try common.testIntrinsic(.{ .func = vcgtq_f32, .expected = expected, .args = .{ a, b } });
}

/// Compare greater than (f64x1)
pub inline fn vcgt_f64(a: types.f64x1, b: types.f64x1) types.u64x1 {
    const comparison = a > b;
    return @select(u64, comparison, @as(types.u64x1, @splat(0xffffffffffffffff)), @as(types.u64x1, @splat(0)));
}

test vcgt_f64 {
    const a = types.f64x1{-1.5};
    const b = types.f64x1{1.0};
    const expected = types.u64x1{0};
    try common.testIntrinsic(.{ .func = vcgt_f64, .expected = expected, .args = .{ a, b } });
}

/// Compare greater than (f64x2)
pub inline fn vcgtq_f64(a: types.f64x2, b: types.f64x2) types.u64x2 {
    const comparison = a > b;
    return @select(u64, comparison, @as(types.u64x2, @splat(0xffffffffffffffff)), @as(types.u64x2, @splat(0)));
}

test vcgtq_f64 {
    const a = types.f64x2{ -1.5, 2.0 };
    const b = types.f64x2{ 1.0, 1.5 };
    const expected = types.u64x2{ 0, 0xffffffffffffffff };
    try common.testIntrinsic(.{ .func = vcgtq_f64, .expected = expected, .args = .{ a, b } });
}

/// Compare greater than (s32x2)
pub inline fn vcgt_s32(a: types.i32x2, b: types.i32x2) types.u32x2 {
    const comparison = a > b;
    return @select(u32, comparison, @as(types.u32x2, @splat(0xffffffff)), @as(types.u32x2, @splat(0)));
}

test vcgt_s32 {
    const a = types.i32x2{ -10, 20 };
    const b = types.i32x2{ 10, 15 };
    const expected = types.u32x2{ 0, 0xffffffff };
    try common.testIntrinsic(.{ .func = vcgt_s32, .expected = expected, .args = .{ a, b } });
}

/// Compare greater than (s32x4)
pub inline fn vcgtq_s32(a: types.i32x4, b: types.i32x4) types.u32x4 {
    const comparison = a > b;
    return @select(u32, comparison, @as(types.u32x4, @splat(0xffffffff)), @as(types.u32x4, @splat(0)));
}

test vcgtq_s32 {
    const a = types.i32x4{ -10, 20, 0, 50 };
    const b = types.i32x4{ 10, 15, 0, 100 };
    const expected = types.u32x4{ 0, 0xffffffff, 0, 0 };
    try common.testIntrinsic(.{ .func = vcgtq_s32, .expected = expected, .args = .{ a, b } });
}

/// Compare greater than (u32x2)
pub inline fn vcgt_u32(a: types.u32x2, b: types.u32x2) types.u32x2 {
    const comparison = a > b;
    return @select(u32, comparison, @as(types.u32x2, @splat(0xffffffff)), @as(types.u32x2, @splat(0)));
}

test vcgt_u32 {
    const a = types.u32x2{ 10, 50 };
    const b = types.u32x2{ 20, 40 };
    const expected = types.u32x2{ 0, 0xffffffff };
    try common.testIntrinsic(.{ .func = vcgt_u32, .expected = expected, .args = .{ a, b } });
}

/// Compare greater than (u32x4)
pub inline fn vcgtq_u32(a: types.u32x4, b: types.u32x4) types.u32x4 {
    const comparison = a > b;
    return @select(u32, comparison, @as(types.u32x4, @splat(0xffffffff)), @as(types.u32x4, @splat(0)));
}

test vcgtq_u32 {
    const a = types.u32x4{ 10, 50, 0, 100 };
    const b = types.u32x4{ 20, 40, 0, 100 };
    const expected = types.u32x4{ 0, 0xffffffff, 0, 0 };
    try common.testIntrinsic(.{ .func = vcgtq_u32, .expected = expected, .args = .{ a, b } });
}

/// Vector compare greater than or equal: returns `a >= b` mask
pub inline fn vcge_s8(a: types.i8x8, b: types.i8x8) types.u8x8 {
    const comparison = a >= b;
    return @select(u8, comparison, @as(types.u8x8, @splat(0xff)), @as(types.u8x8, @splat(0)));
}

test vcge_s8 {
    const a = types.i8x8{ -10, 20, 0, 50, -100, 42, 40, -1 };
    const b = types.i8x8{ 10, 15, 0, 100, -100, 0, 39, 0 };
    const expected = types.u8x8{ 0, 0xff, 0xff, 0, 0xff, 0xff, 0xff, 0 };
    try common.testIntrinsic(.{ .func = vcge_s8, .expected = expected, .args = .{ a, b } });
}

/// Vector compare greater than or equal: returns `a >= b` mask
pub inline fn vcge_s16(a: types.i16x4, b: types.i16x4) types.u16x4 {
    const comparison = a >= b;
    return @select(u16, comparison, @as(types.u16x4, @splat(0xffff)), @as(types.u16x4, @splat(0)));
}

test vcge_s16 {
    const a = types.i16x4{ -10, 20, 0, 50 };
    const b = types.i16x4{ 10, 15, 0, 100 };
    const expected = types.u16x4{ 0, 0xffff, 0xffff, 0 };
    try common.testIntrinsic(.{ .func = vcge_s16, .expected = expected, .args = .{ a, b } });
}

/// Vector compare greater than or equal: returns `a >= b` mask
pub inline fn vcge_s32(a: types.i32x2, b: types.i32x2) types.u32x2 {
    const comparison = a >= b;
    return @select(u32, comparison, @as(types.u32x2, @splat(0xffffffff)), @as(types.u32x2, @splat(0)));
}

test vcge_s32 {
    const a = types.i32x2{ -10, 20 };
    const b = types.i32x2{ 10, 15 };
    const expected = types.u32x2{ 0, 0xffffffff };
    try common.testIntrinsic(.{ .func = vcge_s32, .expected = expected, .args = .{ a, b } });
}

/// Vector compare greater than or equal: returns `a >= b` mask
pub inline fn vcge_s64(a: types.i64x1, b: types.i64x1) types.u64x1 {
    const comparison = a >= b;
    return @select(u64, comparison, @as(types.u64x1, @splat(0xffffffffffffffff)), @as(types.u64x1, @splat(0)));
}

test vcge_s64 {
    const a = types.i64x1{-10};
    const b = types.i64x1{10};
    const expected = types.u64x1{0};
    try common.testIntrinsic(.{ .func = vcge_s64, .expected = expected, .args = .{ a, b } });
}

/// Vector compare greater than or equal: returns `a >= b` mask
pub inline fn vcge_u8(a: types.u8x8, b: types.u8x8) types.u8x8 {
    const comparison = a >= b;
    return @select(u8, comparison, @as(types.u8x8, @splat(0xff)), @as(types.u8x8, @splat(0)));
}

test vcge_u8 {
    const a = types.u8x8{ 10, 50, 0, 100, 200, 1, 40, 100 };
    const b = types.u8x8{ 20, 40, 0, 100, 50, 2, 41, 50 };
    const expected = types.u8x8{ 0, 0xff, 0xff, 0xff, 0xff, 0, 0, 0xff };
    try common.testIntrinsic(.{ .func = vcge_u8, .expected = expected, .args = .{ a, b } });
}

/// Vector compare greater than or equal: returns `a >= b` mask
pub inline fn vcge_u16(a: types.u16x4, b: types.u16x4) types.u16x4 {
    const comparison = a >= b;
    return @select(u16, comparison, @as(types.u16x4, @splat(0xffff)), @as(types.u16x4, @splat(0)));
}

test vcge_u16 {
    const a = types.u16x4{ 10, 50, 0, 100 };
    const b = types.u16x4{ 20, 40, 0, 100 };
    const expected = types.u16x4{ 0, 0xffff, 0xffff, 0xffff };
    try common.testIntrinsic(.{ .func = vcge_u16, .expected = expected, .args = .{ a, b } });
}

/// Vector compare greater than or equal: returns `a >= b` mask
pub inline fn vcge_u32(a: types.u32x2, b: types.u32x2) types.u32x2 {
    const comparison = a >= b;
    return @select(u32, comparison, @as(types.u32x2, @splat(0xffffffff)), @as(types.u32x2, @splat(0)));
}

test vcge_u32 {
    const a = types.u32x2{ 10, 50 };
    const b = types.u32x2{ 20, 40 };
    const expected = types.u32x2{ 0, 0xffffffff };
    try common.testIntrinsic(.{ .func = vcge_u32, .expected = expected, .args = .{ a, b } });
}

/// Vector compare greater than or equal: returns `a >= b` mask
pub inline fn vcge_u64(a: types.u64x1, b: types.u64x1) types.u64x1 {
    const comparison = a >= b;
    return @select(u64, comparison, @as(types.u64x1, @splat(0xffffffffffffffff)), @as(types.u64x1, @splat(0)));
}

test vcge_u64 {
    const a = types.u64x1{10};
    const b = types.u64x1{20};
    const expected = types.u64x1{0};
    try common.testIntrinsic(.{ .func = vcge_u64, .expected = expected, .args = .{ a, b } });
}

/// Vector compare greater than or equal: returns `a >= b` mask
pub inline fn vcge_f32(a: types.f32x2, b: types.f32x2) types.u32x2 {
    const comparison = a >= b;
    return @select(u32, comparison, @as(types.u32x2, @splat(0xffffffff)), @as(types.u32x2, @splat(0)));
}

test vcge_f32 {
    const a = types.f32x2{ -1.5, 2.0 };
    const b = types.f32x2{ 1.0, 1.5 };
    const expected = types.u32x2{ 0, 0xffffffff };
    try common.testIntrinsic(.{ .func = vcge_f32, .expected = expected, .args = .{ a, b } });
}

/// Vector compare greater than or equal: returns `a >= b` mask
pub inline fn vcge_f64(a: types.f64x1, b: types.f64x1) types.u64x1 {
    const comparison = a >= b;
    return @select(u64, comparison, @as(types.u64x1, @splat(0xffffffffffffffff)), @as(types.u64x1, @splat(0)));
}

test vcge_f64 {
    const a = types.f64x1{-1.5};
    const b = types.f64x1{1.0};
    const expected = types.u64x1{0};
    try common.testIntrinsic(.{ .func = vcge_f64, .expected = expected, .args = .{ a, b } });
}

/// Vector compare greater than: returns `a > b` mask
pub inline fn vcgt_s8(a: types.i8x8, b: types.i8x8) types.u8x8 {
    const comparison = a > b;
    return @select(u8, comparison, @as(types.u8x8, @splat(0xff)), @as(types.u8x8, @splat(0)));
}

test vcgt_s8 {
    const a = types.i8x8{ -10, 20, 0, 50, -100, 42, 40, -1 };
    const b = types.i8x8{ 10, 15, 0, 100, -100, 0, 39, 0 };
    const expected = types.u8x8{ 0, 0xff, 0, 0, 0, 0xff, 0xff, 0 };
    try common.testIntrinsic(.{ .func = vcgt_s8, .expected = expected, .args = .{ a, b } });
}

/// Vector compare greater than: returns `a > b` mask
pub inline fn vcgtq_s8(a: types.i8x16, b: types.i8x16) types.u8x16 {
    const comparison = a > b;
    return @select(u8, comparison, @as(types.u8x16, @splat(0xff)), @as(types.u8x16, @splat(0)));
}

test vcgtq_s8 {
    const a = types.i8x16{ -10, 20, 0, 50, -100, 42, 40, -1, -10, -10, -10, -10, -10, -10, -10, -10 };
    const b = types.i8x16{ 10, 15, 0, 100, -100, 0, 39, 0, 10, 10, 10, 10, 10, 10, 10, 10 };
    const expected = types.u8x16{ 0, 0xff, 0, 0, 0, 0xff, 0xff, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
    try common.testIntrinsic(.{ .func = vcgtq_s8, .expected = expected, .args = .{ a, b } });
}

/// Vector compare greater than: returns `a > b` mask
pub inline fn vcgt_s16(a: types.i16x4, b: types.i16x4) types.u16x4 {
    const comparison = a > b;
    return @select(u16, comparison, @as(types.u16x4, @splat(0xffff)), @as(types.u16x4, @splat(0)));
}

test vcgt_s16 {
    const a = types.i16x4{ -10, 20, 0, 50 };
    const b = types.i16x4{ 10, 15, 0, 100 };
    const expected = types.u16x4{ 0, 0xffff, 0, 0 };
    try common.testIntrinsic(.{ .func = vcgt_s16, .expected = expected, .args = .{ a, b } });
}

/// Vector compare greater than: returns `a > b` mask
pub inline fn vcgtq_s16(a: types.i16x8, b: types.i16x8) types.u16x8 {
    const comparison = a > b;
    return @select(u16, comparison, @as(types.u16x8, @splat(0xffff)), @as(types.u16x8, @splat(0)));
}

test vcgtq_s16 {
    const a = types.i16x8{ -10, 20, 0, 50, -100, 42, 40, -1 };
    const b = types.i16x8{ 10, 15, 0, 100, -100, 0, 39, 0 };
    const expected = types.u16x8{ 0, 0xffff, 0, 0, 0, 0xffff, 0xffff, 0 };
    try common.testIntrinsic(.{ .func = vcgtq_s16, .expected = expected, .args = .{ a, b } });
}

/// Vector compare greater than: returns `a > b` mask
pub inline fn vcgt_s64(a: types.i64x1, b: types.i64x1) types.u64x1 {
    const comparison = a > b;
    return @select(u64, comparison, @as(types.u64x1, @splat(0xffffffffffffffff)), @as(types.u64x1, @splat(0)));
}

test vcgt_s64 {
    const a = types.i64x1{-10};
    const b = types.i64x1{10};
    const expected = types.u64x1{0};
    try common.testIntrinsic(.{ .func = vcgt_s64, .expected = expected, .args = .{ a, b } });
}

/// Vector compare greater than: returns `a > b` mask
pub inline fn vcgtq_s64(a: types.i64x2, b: types.i64x2) types.u64x2 {
    const comparison = a > b;
    return @select(u64, comparison, @as(types.u64x2, @splat(0xffffffffffffffff)), @as(types.u64x2, @splat(0)));
}

test vcgtq_s64 {
    const a = types.i64x2{ -10, 20 };
    const b = types.i64x2{ 10, 15 };
    const expected = types.u64x2{ 0, 0xffffffffffffffff };
    try common.testIntrinsic(.{ .func = vcgtq_s64, .expected = expected, .args = .{ a, b } });
}

/// Vector compare greater than: returns `a > b` mask
pub inline fn vcgt_u8(a: types.u8x8, b: types.u8x8) types.u8x8 {
    const comparison = a > b;
    return @select(u8, comparison, @as(types.u8x8, @splat(0xff)), @as(types.u8x8, @splat(0)));
}

test vcgt_u8 {
    const a = types.u8x8{ 10, 50, 0, 100, 200, 1, 40, 100 };
    const b = types.u8x8{ 20, 40, 0, 100, 50, 2, 41, 50 };
    const expected = types.u8x8{ 0, 0xff, 0, 0, 0xff, 0, 0, 0xff };
    try common.testIntrinsic(.{ .func = vcgt_u8, .expected = expected, .args = .{ a, b } });
}

/// Vector compare greater than: returns `a > b` mask
pub inline fn vcgtq_u8(a: types.u8x16, b: types.u8x16) types.u8x16 {
    const comparison = a > b;
    return @select(u8, comparison, @as(types.u8x16, @splat(0xff)), @as(types.u8x16, @splat(0)));
}

test vcgtq_u8 {
    const a = types.u8x16{ 10, 50, 0, 100, 200, 1, 40, 100, 10, 10, 10, 10, 10, 10, 10, 10 };
    const b = types.u8x16{ 20, 40, 0, 100, 50, 2, 41, 50, 20, 20, 20, 20, 20, 20, 20, 20 };
    const expected = types.u8x16{ 0, 0xff, 0, 0, 0xff, 0, 0, 0xff, 0, 0, 0, 0, 0, 0, 0, 0 };
    try common.testIntrinsic(.{ .func = vcgtq_u8, .expected = expected, .args = .{ a, b } });
}

/// Vector compare greater than: returns `a > b` mask
pub inline fn vcgt_u16(a: types.u16x4, b: types.u16x4) types.u16x4 {
    const comparison = a > b;
    return @select(u16, comparison, @as(types.u16x4, @splat(0xffff)), @as(types.u16x4, @splat(0)));
}

test vcgt_u16 {
    const a = types.u16x4{ 10, 50, 0, 100 };
    const b = types.u16x4{ 20, 40, 0, 100 };
    const expected = types.u16x4{ 0, 0xffff, 0, 0 };
    try common.testIntrinsic(.{ .func = vcgt_u16, .expected = expected, .args = .{ a, b } });
}

/// Vector compare greater than: returns `a > b` mask
pub inline fn vcgtq_u16(a: types.u16x8, b: types.u16x8) types.u16x8 {
    const comparison = a > b;
    return @select(u16, comparison, @as(types.u16x8, @splat(0xffff)), @as(types.u16x8, @splat(0)));
}

test vcgtq_u16 {
    const a = types.u16x8{ 10, 50, 0, 100, 200, 1, 40, 100 };
    const b = types.u16x8{ 20, 40, 0, 100, 50, 2, 41, 50 };
    const expected = types.u16x8{ 0, 0xffff, 0, 0, 0xffff, 0, 0, 0xffff };
    try common.testIntrinsic(.{ .func = vcgtq_u16, .expected = expected, .args = .{ a, b } });
}

/// Vector compare greater than: returns `a > b` mask
pub inline fn vcgt_u64(a: types.u64x1, b: types.u64x1) types.u64x1 {
    const comparison = a > b;
    return @select(u64, comparison, @as(types.u64x1, @splat(0xffffffffffffffff)), @as(types.u64x1, @splat(0)));
}

test vcgt_u64 {
    const a = types.u64x1{10};
    const b = types.u64x1{20};
    const expected = types.u64x1{0};
    try common.testIntrinsic(.{ .func = vcgt_u64, .expected = expected, .args = .{ a, b } });
}

/// Vector compare greater than: returns `a > b` mask
pub inline fn vcgtq_u64(a: types.u64x2, b: types.u64x2) types.u64x2 {
    const comparison = a > b;
    return @select(u64, comparison, @as(types.u64x2, @splat(0xffffffffffffffff)), @as(types.u64x2, @splat(0)));
}

test vcgtq_u64 {
    const a = types.u64x2{ 10, 50 };
    const b = types.u64x2{ 20, 40 };
    const expected = types.u64x2{ 0, 0xffffffffffffffff };
    try common.testIntrinsic(.{ .func = vcgtq_u64, .expected = expected, .args = .{ a, b } });
}

/// Vector compare less than or equal: returns `a <= b` mask
pub inline fn vcle_s8(a: types.i8x8, b: types.i8x8) types.u8x8 {
    const comparison = a <= b;
    return @select(u8, comparison, @as(types.u8x8, @splat(0xff)), @as(types.u8x8, @splat(0)));
}

test vcle_s8 {
    const a = types.i8x8{ -10, 20, 0, 50, -100, 42, 40, -1 };
    const b = types.i8x8{ 10, 15, 0, 100, -100, 0, 39, 0 };
    const expected = types.u8x8{ 0xff, 0, 0xff, 0xff, 0xff, 0, 0, 0xff };
    try common.testIntrinsic(.{ .func = vcle_s8, .expected = expected, .args = .{ a, b } });
}

/// Vector compare less than or equal: returns `a <= b` mask
pub inline fn vcleq_s8(a: types.i8x16, b: types.i8x16) types.u8x16 {
    const comparison = a <= b;
    return @select(u8, comparison, @as(types.u8x16, @splat(0xff)), @as(types.u8x16, @splat(0)));
}

test vcleq_s8 {
    const a = types.i8x16{ -10, 20, 0, 50, -100, 42, 40, -1, -10, -10, -10, -10, -10, -10, -10, -10 };
    const b = types.i8x16{ 10, 15, 0, 100, -100, 0, 39, 0, 10, 10, 10, 10, 10, 10, 10, 10 };
    const expected = types.u8x16{ 0xff, 0, 0xff, 0xff, 0xff, 0, 0, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff };
    try common.testIntrinsic(.{ .func = vcleq_s8, .expected = expected, .args = .{ a, b } });
}

/// Vector compare less than or equal: returns `a <= b` mask
pub inline fn vcle_s16(a: types.i16x4, b: types.i16x4) types.u16x4 {
    const comparison = a <= b;
    return @select(u16, comparison, @as(types.u16x4, @splat(0xffff)), @as(types.u16x4, @splat(0)));
}

test vcle_s16 {
    const a = types.i16x4{ -10, 20, 0, 50 };
    const b = types.i16x4{ 10, 15, 0, 100 };
    const expected = types.u16x4{ 0xffff, 0, 0xffff, 0xffff };
    try common.testIntrinsic(.{ .func = vcle_s16, .expected = expected, .args = .{ a, b } });
}

/// Vector compare less than or equal: returns `a <= b` mask
pub inline fn vcleq_s16(a: types.i16x8, b: types.i16x8) types.u16x8 {
    const comparison = a <= b;
    return @select(u16, comparison, @as(types.u16x8, @splat(0xffff)), @as(types.u16x8, @splat(0)));
}

test vcleq_s16 {
    const a = types.i16x8{ -10, 20, 0, 50, -100, 42, 40, -1 };
    const b = types.i16x8{ 10, 15, 0, 100, -100, 0, 39, 0 };
    const expected = types.u16x8{ 0xffff, 0, 0xffff, 0xffff, 0xffff, 0, 0, 0xffff };
    try common.testIntrinsic(.{ .func = vcleq_s16, .expected = expected, .args = .{ a, b } });
}

/// Vector compare less than or equal: returns `a <= b` mask
pub inline fn vcle_s32(a: types.i32x2, b: types.i32x2) types.u32x2 {
    const comparison = a <= b;
    return @select(u32, comparison, @as(types.u32x2, @splat(0xffffffff)), @as(types.u32x2, @splat(0)));
}

test vcle_s32 {
    const a = types.i32x2{ -10, 20 };
    const b = types.i32x2{ 10, 15 };
    const expected = types.u32x2{ 0xffffffff, 0 };
    try common.testIntrinsic(.{ .func = vcle_s32, .expected = expected, .args = .{ a, b } });
}

/// Vector compare less than or equal: returns `a <= b` mask
pub inline fn vcleq_s32(a: types.i32x4, b: types.i32x4) types.u32x4 {
    const comparison = a <= b;
    return @select(u32, comparison, @as(types.u32x4, @splat(0xffffffff)), @as(types.u32x4, @splat(0)));
}

test vcleq_s32 {
    const a = types.i32x4{ -10, 20, 0, 50 };
    const b = types.i32x4{ 10, 15, 0, 100 };
    const expected = types.u32x4{ 0xffffffff, 0, 0xffffffff, 0xffffffff };
    try common.testIntrinsic(.{ .func = vcleq_s32, .expected = expected, .args = .{ a, b } });
}

/// Vector compare less than or equal: returns `a <= b` mask
pub inline fn vcle_s64(a: types.i64x1, b: types.i64x1) types.u64x1 {
    const comparison = a <= b;
    return @select(u64, comparison, @as(types.u64x1, @splat(0xffffffffffffffff)), @as(types.u64x1, @splat(0)));
}

test vcle_s64 {
    const a = types.i64x1{-10};
    const b = types.i64x1{10};
    const expected = types.u64x1{0xffffffffffffffff};
    try common.testIntrinsic(.{ .func = vcle_s64, .expected = expected, .args = .{ a, b } });
}

/// Vector compare less than or equal: returns `a <= b` mask
pub inline fn vcleq_s64(a: types.i64x2, b: types.i64x2) types.u64x2 {
    const comparison = a <= b;
    return @select(u64, comparison, @as(types.u64x2, @splat(0xffffffffffffffff)), @as(types.u64x2, @splat(0)));
}

test vcleq_s64 {
    const a = types.i64x2{ -10, 20 };
    const b = types.i64x2{ 10, 15 };
    const expected = types.u64x2{ 0xffffffffffffffff, 0 };
    try common.testIntrinsic(.{ .func = vcleq_s64, .expected = expected, .args = .{ a, b } });
}

/// Vector compare less than or equal: returns `a <= b` mask
pub inline fn vcle_u8(a: types.u8x8, b: types.u8x8) types.u8x8 {
    const comparison = a <= b;
    return @select(u8, comparison, @as(types.u8x8, @splat(0xff)), @as(types.u8x8, @splat(0)));
}

test vcle_u8 {
    const a = types.u8x8{ 10, 50, 0, 100, 200, 1, 40, 100 };
    const b = types.u8x8{ 20, 40, 0, 100, 50, 2, 41, 50 };
    const expected = types.u8x8{ 0xff, 0, 0xff, 0xff, 0, 0xff, 0xff, 0 };
    try common.testIntrinsic(.{ .func = vcle_u8, .expected = expected, .args = .{ a, b } });
}

/// Vector compare less than or equal: returns `a <= b` mask
pub inline fn vcleq_u8(a: types.u8x16, b: types.u8x16) types.u8x16 {
    const comparison = a <= b;
    return @select(u8, comparison, @as(types.u8x16, @splat(0xff)), @as(types.u8x16, @splat(0)));
}

test vcleq_u8 {
    const a = types.u8x16{ 10, 50, 0, 100, 200, 1, 40, 100, 10, 10, 10, 10, 10, 10, 10, 10 };
    const b = types.u8x16{ 20, 40, 0, 100, 50, 2, 41, 50, 20, 20, 20, 20, 20, 20, 20, 20 };
    const expected = types.u8x16{ 0xff, 0, 0xff, 0xff, 0, 0xff, 0xff, 0, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff };
    try common.testIntrinsic(.{ .func = vcleq_u8, .expected = expected, .args = .{ a, b } });
}

/// Vector compare less than or equal: returns `a <= b` mask
pub inline fn vcle_u16(a: types.u16x4, b: types.u16x4) types.u16x4 {
    const comparison = a <= b;
    return @select(u16, comparison, @as(types.u16x4, @splat(0xffff)), @as(types.u16x4, @splat(0)));
}

test vcle_u16 {
    const a = types.u16x4{ 10, 50, 0, 100 };
    const b = types.u16x4{ 20, 40, 0, 100 };
    const expected = types.u16x4{ 0xffff, 0, 0xffff, 0xffff };
    try common.testIntrinsic(.{ .func = vcle_u16, .expected = expected, .args = .{ a, b } });
}

/// Vector compare less than or equal: returns `a <= b` mask
pub inline fn vcleq_u16(a: types.u16x8, b: types.u16x8) types.u16x8 {
    const comparison = a <= b;
    return @select(u16, comparison, @as(types.u16x8, @splat(0xffff)), @as(types.u16x8, @splat(0)));
}

test vcleq_u16 {
    const a = types.u16x8{ 10, 50, 0, 100, 200, 1, 40, 100 };
    const b = types.u16x8{ 20, 40, 0, 100, 50, 2, 41, 50 };
    const expected = types.u16x8{ 0xffff, 0, 0xffff, 0xffff, 0, 0xffff, 0xffff, 0 };
    try common.testIntrinsic(.{ .func = vcleq_u16, .expected = expected, .args = .{ a, b } });
}

/// Vector compare less than or equal: returns `a <= b` mask
pub inline fn vcle_u32(a: types.u32x2, b: types.u32x2) types.u32x2 {
    const comparison = a <= b;
    return @select(u32, comparison, @as(types.u32x2, @splat(0xffffffff)), @as(types.u32x2, @splat(0)));
}

test vcle_u32 {
    const a = types.u32x2{ 10, 50 };
    const b = types.u32x2{ 20, 40 };
    const expected = types.u32x2{ 0xffffffff, 0 };
    try common.testIntrinsic(.{ .func = vcle_u32, .expected = expected, .args = .{ a, b } });
}

/// Vector compare less than or equal: returns `a <= b` mask
pub inline fn vcleq_u32(a: types.u32x4, b: types.u32x4) types.u32x4 {
    const comparison = a <= b;
    return @select(u32, comparison, @as(types.u32x4, @splat(0xffffffff)), @as(types.u32x4, @splat(0)));
}

test vcleq_u32 {
    const a = types.u32x4{ 10, 50, 0, 100 };
    const b = types.u32x4{ 20, 40, 0, 100 };
    const expected = types.u32x4{ 0xffffffff, 0, 0xffffffff, 0xffffffff };
    try common.testIntrinsic(.{ .func = vcleq_u32, .expected = expected, .args = .{ a, b } });
}

/// Vector compare less than or equal: returns `a <= b` mask
pub inline fn vcle_u64(a: types.u64x1, b: types.u64x1) types.u64x1 {
    const comparison = a <= b;
    return @select(u64, comparison, @as(types.u64x1, @splat(0xffffffffffffffff)), @as(types.u64x1, @splat(0)));
}

test vcle_u64 {
    const a = types.u64x1{10};
    const b = types.u64x1{20};
    const expected = types.u64x1{0xffffffffffffffff};
    try common.testIntrinsic(.{ .func = vcle_u64, .expected = expected, .args = .{ a, b } });
}

/// Vector compare less than or equal: returns `a <= b` mask
pub inline fn vcleq_u64(a: types.u64x2, b: types.u64x2) types.u64x2 {
    const comparison = a <= b;
    return @select(u64, comparison, @as(types.u64x2, @splat(0xffffffffffffffff)), @as(types.u64x2, @splat(0)));
}

test vcleq_u64 {
    const a = types.u64x2{ 10, 50 };
    const b = types.u64x2{ 20, 40 };
    const expected = types.u64x2{ 0xffffffffffffffff, 0 };
    try common.testIntrinsic(.{ .func = vcleq_u64, .expected = expected, .args = .{ a, b } });
}

/// Vector compare less than or equal: returns `a <= b` mask
pub inline fn vcle_f32(a: types.f32x2, b: types.f32x2) types.u32x2 {
    const comparison = a <= b;
    return @select(u32, comparison, @as(types.u32x2, @splat(0xffffffff)), @as(types.u32x2, @splat(0)));
}

test vcle_f32 {
    const a = types.f32x2{ -1.5, 2.0 };
    const b = types.f32x2{ 1.0, 1.5 };
    const expected = types.u32x2{ 0xffffffff, 0 };
    try common.testIntrinsic(.{ .func = vcle_f32, .expected = expected, .args = .{ a, b } });
}

/// Vector compare less than or equal: returns `a <= b` mask
pub inline fn vcleq_f32(a: types.f32x4, b: types.f32x4) types.u32x4 {
    const comparison = a <= b;
    return @select(u32, comparison, @as(types.u32x4, @splat(0xffffffff)), @as(types.u32x4, @splat(0)));
}

test vcleq_f32 {
    const a = types.f32x4{ -1.5, 2.0, 0.0, 5.5 };
    const b = types.f32x4{ 1.0, 1.5, 0.0, 10.0 };
    const expected = types.u32x4{ 0xffffffff, 0, 0xffffffff, 0xffffffff };
    try common.testIntrinsic(.{ .func = vcleq_f32, .expected = expected, .args = .{ a, b } });
}

/// Vector compare less than or equal: returns `a <= b` mask
pub inline fn vcle_f64(a: types.f64x1, b: types.f64x1) types.u64x1 {
    const comparison = a <= b;
    return @select(u64, comparison, @as(types.u64x1, @splat(0xffffffffffffffff)), @as(types.u64x1, @splat(0)));
}

test vcle_f64 {
    const a = types.f64x1{-1.5};
    const b = types.f64x1{1.0};
    const expected = types.u64x1{0xffffffffffffffff};
    try common.testIntrinsic(.{ .func = vcle_f64, .expected = expected, .args = .{ a, b } });
}

/// Vector compare less than or equal: returns `a <= b` mask
pub inline fn vcleq_f64(a: types.f64x2, b: types.f64x2) types.u64x2 {
    const comparison = a <= b;
    return @select(u64, comparison, @as(types.u64x2, @splat(0xffffffffffffffff)), @as(types.u64x2, @splat(0)));
}

test vcleq_f64 {
    const a = types.f64x2{ -1.5, 2.0 };
    const b = types.f64x2{ 1.0, 1.5 };
    const expected = types.u64x2{ 0xffffffffffffffff, 0 };
    try common.testIntrinsic(.{ .func = vcleq_f64, .expected = expected, .args = .{ a, b } });
}

/// Vector compare less than: returns `a < b` mask
pub inline fn vclt_s8(a: types.i8x8, b: types.i8x8) types.u8x8 {
    const comparison = a < b;
    return @select(u8, comparison, @as(types.u8x8, @splat(0xff)), @as(types.u8x8, @splat(0)));
}

test vclt_s8 {
    const a = types.i8x8{ -10, 20, 0, 50, -100, 42, 40, -1 };
    const b = types.i8x8{ 10, 15, 0, 100, -100, 0, 39, 0 };
    const expected = types.u8x8{ 0xff, 0, 0, 0xff, 0, 0, 0, 0xff };
    try common.testIntrinsic(.{ .func = vclt_s8, .expected = expected, .args = .{ a, b } });
}

/// Vector compare less than: returns `a < b` mask
pub inline fn vcltq_s8(a: types.i8x16, b: types.i8x16) types.u8x16 {
    const comparison = a < b;
    return @select(u8, comparison, @as(types.u8x16, @splat(0xff)), @as(types.u8x16, @splat(0)));
}

test vcltq_s8 {
    const a = types.i8x16{ -10, 20, 0, 50, -100, 42, 40, -1, -10, -10, -10, -10, -10, -10, -10, -10 };
    const b = types.i8x16{ 10, 15, 0, 100, -100, 0, 39, 0, 10, 10, 10, 10, 10, 10, 10, 10 };
    const expected = types.u8x16{ 0xff, 0, 0, 0xff, 0, 0, 0, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff };
    try common.testIntrinsic(.{ .func = vcltq_s8, .expected = expected, .args = .{ a, b } });
}

/// Vector compare less than: returns `a < b` mask
pub inline fn vclt_s16(a: types.i16x4, b: types.i16x4) types.u16x4 {
    const comparison = a < b;
    return @select(u16, comparison, @as(types.u16x4, @splat(0xffff)), @as(types.u16x4, @splat(0)));
}

test vclt_s16 {
    const a = types.i16x4{ -10, 20, 0, 50 };
    const b = types.i16x4{ 10, 15, 0, 100 };
    const expected = types.u16x4{ 0xffff, 0, 0, 0xffff };
    try common.testIntrinsic(.{ .func = vclt_s16, .expected = expected, .args = .{ a, b } });
}

/// Vector compare less than: returns `a < b` mask
pub inline fn vcltq_s16(a: types.i16x8, b: types.i16x8) types.u16x8 {
    const comparison = a < b;
    return @select(u16, comparison, @as(types.u16x8, @splat(0xffff)), @as(types.u16x8, @splat(0)));
}

test vcltq_s16 {
    const a = types.i16x8{ -10, 20, 0, 50, -100, 42, 40, -1 };
    const b = types.i16x8{ 10, 15, 0, 100, -100, 0, 39, 0 };
    const expected = types.u16x8{ 0xffff, 0, 0, 0xffff, 0, 0, 0, 0xffff };
    try common.testIntrinsic(.{ .func = vcltq_s16, .expected = expected, .args = .{ a, b } });
}

/// Vector compare less than: returns `a < b` mask
pub inline fn vclt_s32(a: types.i32x2, b: types.i32x2) types.u32x2 {
    const comparison = a < b;
    return @select(u32, comparison, @as(types.u32x2, @splat(0xffffffff)), @as(types.u32x2, @splat(0)));
}

test vclt_s32 {
    const a = types.i32x2{ -10, 20 };
    const b = types.i32x2{ 10, 15 };
    const expected = types.u32x2{ 0xffffffff, 0 };
    try common.testIntrinsic(.{ .func = vclt_s32, .expected = expected, .args = .{ a, b } });
}

/// Vector compare less than: returns `a < b` mask
pub inline fn vcltq_s32(a: types.i32x4, b: types.i32x4) types.u32x4 {
    const comparison = a < b;
    return @select(u32, comparison, @as(types.u32x4, @splat(0xffffffff)), @as(types.u32x4, @splat(0)));
}

test vcltq_s32 {
    const a = types.i32x4{ -10, 20, 0, 50 };
    const b = types.i32x4{ 10, 15, 0, 100 };
    const expected = types.u32x4{ 0xffffffff, 0, 0, 0xffffffff };
    try common.testIntrinsic(.{ .func = vcltq_s32, .expected = expected, .args = .{ a, b } });
}

/// Vector compare less than: returns `a < b` mask
pub inline fn vclt_s64(a: types.i64x1, b: types.i64x1) types.u64x1 {
    const comparison = a < b;
    return @select(u64, comparison, @as(types.u64x1, @splat(0xffffffffffffffff)), @as(types.u64x1, @splat(0)));
}

test vclt_s64 {
    const a = types.i64x1{-10};
    const b = types.i64x1{10};
    const expected = types.u64x1{0xffffffffffffffff};
    try common.testIntrinsic(.{ .func = vclt_s64, .expected = expected, .args = .{ a, b } });
}

/// Vector compare less than: returns `a < b` mask
pub inline fn vcltq_s64(a: types.i64x2, b: types.i64x2) types.u64x2 {
    const comparison = a < b;
    return @select(u64, comparison, @as(types.u64x2, @splat(0xffffffffffffffff)), @as(types.u64x2, @splat(0)));
}

test vcltq_s64 {
    const a = types.i64x2{ -10, 20 };
    const b = types.i64x2{ 10, 15 };
    const expected = types.u64x2{ 0xffffffffffffffff, 0 };
    try common.testIntrinsic(.{ .func = vcltq_s64, .expected = expected, .args = .{ a, b } });
}

/// Vector compare less than: returns `a < b` mask
pub inline fn vclt_u8(a: types.u8x8, b: types.u8x8) types.u8x8 {
    const comparison = a < b;
    return @select(u8, comparison, @as(types.u8x8, @splat(0xff)), @as(types.u8x8, @splat(0)));
}

test vclt_u8 {
    const a = types.u8x8{ 10, 50, 0, 100, 200, 1, 40, 100 };
    const b = types.u8x8{ 20, 40, 0, 100, 50, 2, 41, 50 };
    const expected = types.u8x8{ 0xff, 0, 0, 0, 0, 0xff, 0xff, 0 };
    try common.testIntrinsic(.{ .func = vclt_u8, .expected = expected, .args = .{ a, b } });
}

/// Vector compare less than: returns `a < b` mask
pub inline fn vcltq_u8(a: types.u8x16, b: types.u8x16) types.u8x16 {
    const comparison = a < b;
    return @select(u8, comparison, @as(types.u8x16, @splat(0xff)), @as(types.u8x16, @splat(0)));
}

test vcltq_u8 {
    const a = types.u8x16{ 10, 50, 0, 100, 200, 1, 40, 100, 10, 10, 10, 10, 10, 10, 10, 10 };
    const b = types.u8x16{ 20, 40, 0, 100, 50, 2, 41, 50, 20, 20, 20, 20, 20, 20, 20, 20 };
    const expected = types.u8x16{ 0xff, 0, 0, 0, 0, 0xff, 0xff, 0, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff };
    try common.testIntrinsic(.{ .func = vcltq_u8, .expected = expected, .args = .{ a, b } });
}

/// Vector compare less than: returns `a < b` mask
pub inline fn vclt_u16(a: types.u16x4, b: types.u16x4) types.u16x4 {
    const comparison = a < b;
    return @select(u16, comparison, @as(types.u16x4, @splat(0xffff)), @as(types.u16x4, @splat(0)));
}

test vclt_u16 {
    const a = types.u16x4{ 10, 50, 0, 100 };
    const b = types.u16x4{ 20, 40, 0, 100 };
    const expected = types.u16x4{ 0xffff, 0, 0, 0 };
    try common.testIntrinsic(.{ .func = vclt_u16, .expected = expected, .args = .{ a, b } });
}

/// Vector compare less than: returns `a < b` mask
pub inline fn vcltq_u16(a: types.u16x8, b: types.u16x8) types.u16x8 {
    const comparison = a < b;
    return @select(u16, comparison, @as(types.u16x8, @splat(0xffff)), @as(types.u16x8, @splat(0)));
}

test vcltq_u16 {
    const a = types.u16x8{ 10, 50, 0, 100, 200, 1, 40, 100 };
    const b = types.u16x8{ 20, 40, 0, 100, 50, 2, 41, 50 };
    const expected = types.u16x8{ 0xffff, 0, 0, 0, 0, 0xffff, 0xffff, 0 };
    try common.testIntrinsic(.{ .func = vcltq_u16, .expected = expected, .args = .{ a, b } });
}

/// Vector compare less than: returns `a < b` mask
pub inline fn vclt_u32(a: types.u32x2, b: types.u32x2) types.u32x2 {
    const comparison = a < b;
    return @select(u32, comparison, @as(types.u32x2, @splat(0xffffffff)), @as(types.u32x2, @splat(0)));
}

test vclt_u32 {
    const a = types.u32x2{ 10, 50 };
    const b = types.u32x2{ 20, 40 };
    const expected = types.u32x2{ 0xffffffff, 0 };
    try common.testIntrinsic(.{ .func = vclt_u32, .expected = expected, .args = .{ a, b } });
}

/// Vector compare less than: returns `a < b` mask
pub inline fn vcltq_u32(a: types.u32x4, b: types.u32x4) types.u32x4 {
    const comparison = a < b;
    return @select(u32, comparison, @as(types.u32x4, @splat(0xffffffff)), @as(types.u32x4, @splat(0)));
}

test vcltq_u32 {
    const a = types.u32x4{ 10, 50, 0, 100 };
    const b = types.u32x4{ 20, 40, 0, 100 };
    const expected = types.u32x4{ 0xffffffff, 0, 0, 0 };
    try common.testIntrinsic(.{ .func = vcltq_u32, .expected = expected, .args = .{ a, b } });
}

/// Vector compare less than: returns `a < b` mask
pub inline fn vclt_u64(a: types.u64x1, b: types.u64x1) types.u64x1 {
    const comparison = a < b;
    return @select(u64, comparison, @as(types.u64x1, @splat(0xffffffffffffffff)), @as(types.u64x1, @splat(0)));
}

test vclt_u64 {
    const a = types.u64x1{10};
    const b = types.u64x1{20};
    const expected = types.u64x1{0xffffffffffffffff};
    try common.testIntrinsic(.{ .func = vclt_u64, .expected = expected, .args = .{ a, b } });
}

/// Vector compare less than: returns `a < b` mask
pub inline fn vcltq_u64(a: types.u64x2, b: types.u64x2) types.u64x2 {
    const comparison = a < b;
    return @select(u64, comparison, @as(types.u64x2, @splat(0xffffffffffffffff)), @as(types.u64x2, @splat(0)));
}

test vcltq_u64 {
    const a = types.u64x2{ 10, 50 };
    const b = types.u64x2{ 20, 40 };
    const expected = types.u64x2{ 0xffffffffffffffff, 0 };
    try common.testIntrinsic(.{ .func = vcltq_u64, .expected = expected, .args = .{ a, b } });
}

/// Vector compare less than: returns `a < b` mask
pub inline fn vclt_f32(a: types.f32x2, b: types.f32x2) types.u32x2 {
    const comparison = a < b;
    return @select(u32, comparison, @as(types.u32x2, @splat(0xffffffff)), @as(types.u32x2, @splat(0)));
}

test vclt_f32 {
    const a = types.f32x2{ -1.5, 2.0 };
    const b = types.f32x2{ 1.0, 1.5 };
    const expected = types.u32x2{ 0xffffffff, 0 };
    try common.testIntrinsic(.{ .func = vclt_f32, .expected = expected, .args = .{ a, b } });
}

/// Vector compare less than: returns `a < b` mask
pub inline fn vcltq_f32(a: types.f32x4, b: types.f32x4) types.u32x4 {
    const comparison = a < b;
    return @select(u32, comparison, @as(types.u32x4, @splat(0xffffffff)), @as(types.u32x4, @splat(0)));
}

test vcltq_f32 {
    const a = types.f32x4{ -1.5, 2.0, 0.0, 5.5 };
    const b = types.f32x4{ 1.0, 1.5, 0.0, 10.0 };
    const expected = types.u32x4{ 0xffffffff, 0, 0, 0xffffffff };
    try common.testIntrinsic(.{ .func = vcltq_f32, .expected = expected, .args = .{ a, b } });
}

/// Vector compare less than: returns `a < b` mask
pub inline fn vclt_f64(a: types.f64x1, b: types.f64x1) types.u64x1 {
    const comparison = a < b;
    return @select(u64, comparison, @as(types.u64x1, @splat(0xffffffffffffffff)), @as(types.u64x1, @splat(0)));
}

test vclt_f64 {
    const a = types.f64x1{-1.5};
    const b = types.f64x1{1.0};
    const expected = types.u64x1{0xffffffffffffffff};
    try common.testIntrinsic(.{ .func = vclt_f64, .expected = expected, .args = .{ a, b } });
}

/// Vector compare less than: returns `a < b` mask
pub inline fn vcltq_f64(a: types.f64x2, b: types.f64x2) types.u64x2 {
    const comparison = a < b;
    return @select(u64, comparison, @as(types.u64x2, @splat(0xffffffffffffffff)), @as(types.u64x2, @splat(0)));
}

test vcltq_f64 {
    const a = types.f64x2{ -1.5, 2.0 };
    const b = types.f64x2{ 1.0, 1.5 };
    const expected = types.u64x2{ 0xffffffffffffffff, 0 };
    try common.testIntrinsic(.{ .func = vcltq_f64, .expected = expected, .args = .{ a, b } });
}

/// Vector bit test: returns `(a & b) != 0` mask
pub inline fn vtst_s8(a: types.i8x8, b: types.i8x8) types.u8x8 {
    const cond = (@as(types.u8x8, @bitCast(a)) & @as(types.u8x8, @bitCast(b))) != @as(types.u8x8, @splat(0));
    return @select(u8, cond, @as(types.u8x8, @splat(0xff)), @as(types.u8x8, @splat(0)));
}

test vtst_s8 {
    const a = types.i8x8{ 10, 5, 8, 1, 0, 15, 2, 4 };
    const b = types.i8x8{ 8, 2, 7, 1, 15, 0, 2, 8 };
    const expected = types.u8x8{ 0xff, 0, 0, 0xff, 0, 0, 0xff, 0 };
    try common.testIntrinsic(.{ .func = vtst_s8, .expected = expected, .args = .{ a, b } });
}

/// Vector bit test: returns `(a & b) != 0` mask
pub inline fn vtst_s16(a: types.i16x4, b: types.i16x4) types.u16x4 {
    const cond = (@as(types.u16x4, @bitCast(a)) & @as(types.u16x4, @bitCast(b))) != @as(types.u16x4, @splat(0));
    return @select(u16, cond, @as(types.u16x4, @splat(0xffff)), @as(types.u16x4, @splat(0)));
}

test vtst_s16 {
    const a = types.i16x4{ 10, 5, 8, 1 };
    const b = types.i16x4{ 8, 2, 7, 1 };
    const expected = types.u16x4{ 0xffff, 0, 0, 0xffff };
    try common.testIntrinsic(.{ .func = vtst_s16, .expected = expected, .args = .{ a, b } });
}

/// Vector bit test: returns `(a & b) != 0` mask
pub inline fn vtst_s32(a: types.i32x2, b: types.i32x2) types.u32x2 {
    const cond = (@as(types.u32x2, @bitCast(a)) & @as(types.u32x2, @bitCast(b))) != @as(types.u32x2, @splat(0));
    return @select(u32, cond, @as(types.u32x2, @splat(0xffffffff)), @as(types.u32x2, @splat(0)));
}

test vtst_s32 {
    const a = types.i32x2{ 10, 5 };
    const b = types.i32x2{ 8, 2 };
    const expected = types.u32x2{ 0xffffffff, 0 };
    try common.testIntrinsic(.{ .func = vtst_s32, .expected = expected, .args = .{ a, b } });
}

/// Vector bit test: returns `(a & b) != 0` mask
pub inline fn vtst_s64(a: types.i64x1, b: types.i64x1) types.u64x1 {
    const cond = (@as(types.u64x1, @bitCast(a)) & @as(types.u64x1, @bitCast(b))) != @as(types.u64x1, @splat(0));
    return @select(u64, cond, @as(types.u64x1, @splat(0xffffffffffffffff)), @as(types.u64x1, @splat(0)));
}

test vtst_s64 {
    const a = types.i64x1{10};
    const b = types.i64x1{8};
    const expected = types.u64x1{0xffffffffffffffff};
    try common.testIntrinsic(.{ .func = vtst_s64, .expected = expected, .args = .{ a, b } });
}

/// Vector bit test: returns `(a & b) != 0` mask
pub inline fn vtst_u8(a: types.u8x8, b: types.u8x8) types.u8x8 {
    const cond = (a & b) != @as(types.u8x8, @splat(0));
    return @select(u8, cond, @as(types.u8x8, @splat(0xff)), @as(types.u8x8, @splat(0)));
}

test vtst_u8 {
    const a = types.u8x8{ 10, 5, 8, 1, 0, 15, 2, 4 };
    const b = types.u8x8{ 8, 2, 7, 1, 15, 0, 2, 8 };
    const expected = types.u8x8{ 0xff, 0, 0, 0xff, 0, 0, 0xff, 0 };
    try common.testIntrinsic(.{ .func = vtst_u8, .expected = expected, .args = .{ a, b } });
}

/// Vector bit test: returns `(a & b) != 0` mask
pub inline fn vtst_u16(a: types.u16x4, b: types.u16x4) types.u16x4 {
    const cond = (a & b) != @as(types.u16x4, @splat(0));
    return @select(u16, cond, @as(types.u16x4, @splat(0xffff)), @as(types.u16x4, @splat(0)));
}

test vtst_u16 {
    const a = types.u16x4{ 10, 5, 8, 1 };
    const b = types.u16x4{ 8, 2, 7, 1 };
    const expected = types.u16x4{ 0xffff, 0, 0, 0xffff };
    try common.testIntrinsic(.{ .func = vtst_u16, .expected = expected, .args = .{ a, b } });
}

/// Vector bit test: returns `(a & b) != 0` mask
pub inline fn vtst_u32(a: types.u32x2, b: types.u32x2) types.u32x2 {
    const cond = (a & b) != @as(types.u32x2, @splat(0));
    return @select(u32, cond, @as(types.u32x2, @splat(0xffffffff)), @as(types.u32x2, @splat(0)));
}

test vtst_u32 {
    const a = types.u32x2{ 10, 5 };
    const b = types.u32x2{ 8, 2 };
    const expected = types.u32x2{ 0xffffffff, 0 };
    try common.testIntrinsic(.{ .func = vtst_u32, .expected = expected, .args = .{ a, b } });
}

/// Vector bit test: returns `(a & b) != 0` mask
pub inline fn vtst_u64(a: types.u64x1, b: types.u64x1) types.u64x1 {
    const cond = (a & b) != @as(types.u64x1, @splat(0));
    return @select(u64, cond, @as(types.u64x1, @splat(0xffffffffffffffff)), @as(types.u64x1, @splat(0)));
}

test vtst_u64 {
    const a = types.u64x1{10};
    const b = types.u64x1{8};
    const expected = types.u64x1{0xffffffffffffffff};
    try common.testIntrinsic(.{ .func = vtst_u64, .expected = expected, .args = .{ a, b } });
}

/// Vector bit test: returns `(a & b) != 0` mask
pub inline fn vtst_p8(a: types.p8x8, b: types.p8x8) types.u8x8 {
    const cond = (@as(types.u8x8, @bitCast(a)) & @as(types.u8x8, @bitCast(b))) != @as(types.u8x8, @splat(0));
    return @select(u8, cond, @as(types.u8x8, @splat(0xff)), @as(types.u8x8, @splat(0)));
}

test vtst_p8 {
    const a = types.p8x8{ 10, 5, 8, 1, 0, 15, 2, 4 };
    const b = types.p8x8{ 8, 2, 7, 1, 15, 0, 2, 8 };
    const expected = types.u8x8{ 0xff, 0, 0, 0xff, 0, 0, 0xff, 0 };
    try common.testIntrinsic(.{ .func = vtst_p8, .expected = expected, .args = .{ a, b } });
}

/// Vector bit test: returns `(a & b) != 0` mask
pub inline fn vtst_p16(a: types.p16x4, b: types.p16x4) types.u16x4 {
    const cond = (@as(types.u16x4, @bitCast(a)) & @as(types.u16x4, @bitCast(b))) != @as(types.u16x4, @splat(0));
    return @select(u16, cond, @as(types.u16x4, @splat(0xffff)), @as(types.u16x4, @splat(0)));
}

test vtst_p16 {
    const a = types.p16x4{ 10, 5, 8, 1 };
    const b = types.p16x4{ 8, 2, 7, 1 };
    const expected = types.u16x4{ 0xffff, 0, 0, 0xffff };
    try common.testIntrinsic(.{ .func = vtst_p16, .expected = expected, .args = .{ a, b } });
}

/// Vector bit test: returns `(a & b) != 0` mask
pub inline fn vtst_p64(a: types.p64x1, b: types.p64x1) types.u64x1 {
    const cond = (@as(types.u64x1, @bitCast(a)) & @as(types.u64x1, @bitCast(b))) != @as(types.u64x1, @splat(0));
    return @select(u64, cond, @as(types.u64x1, @splat(0xffffffffffffffff)), @as(types.u64x1, @splat(0)));
}

test vtst_p64 {
    const a = types.p64x1{10};
    const b = types.p64x1{8};
    const expected = types.u64x1{0xffffffffffffffff};
    try common.testIntrinsic(.{ .func = vtst_p64, .expected = expected, .args = .{ a, b } });
}

/// Vector bit test: returns `(a & b) != 0` mask
pub inline fn vtstq_s8(a: types.i8x16, b: types.i8x16) types.u8x16 {
    const cond = (@as(types.u8x16, @bitCast(a)) & @as(types.u8x16, @bitCast(b))) != @as(types.u8x16, @splat(0));
    return @select(u8, cond, @as(types.u8x16, @splat(0xff)), @as(types.u8x16, @splat(0)));
}

test vtstq_s8 {
    const a = types.i8x16{ 10, 5, 8, 1, 0, 15, 2, 4, 10, 10, 10, 10, 10, 10, 10, 10 };
    const b = types.i8x16{ 8, 2, 7, 1, 15, 0, 2, 8, 8, 8, 8, 8, 8, 8, 8, 8 };
    const expected = types.u8x16{ 0xff, 0, 0, 0xff, 0, 0, 0xff, 0, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff };
    try common.testIntrinsic(.{ .func = vtstq_s8, .expected = expected, .args = .{ a, b } });
}

/// Vector bit test: returns `(a & b) != 0` mask
pub inline fn vtstq_s16(a: types.i16x8, b: types.i16x8) types.u16x8 {
    const cond = (@as(types.u16x8, @bitCast(a)) & @as(types.u16x8, @bitCast(b))) != @as(types.u16x8, @splat(0));
    return @select(u16, cond, @as(types.u16x8, @splat(0xffff)), @as(types.u16x8, @splat(0)));
}

test vtstq_s16 {
    const a = types.i16x8{ 10, 5, 8, 1, 0, 15, 2, 4 };
    const b = types.i16x8{ 8, 2, 7, 1, 15, 0, 2, 8 };
    const expected = types.u16x8{ 0xffff, 0, 0, 0xffff, 0, 0, 0xffff, 0 };
    try common.testIntrinsic(.{ .func = vtstq_s16, .expected = expected, .args = .{ a, b } });
}

/// Vector bit test: returns `(a & b) != 0` mask
pub inline fn vtstq_s32(a: types.i32x4, b: types.i32x4) types.u32x4 {
    const cond = (@as(types.u32x4, @bitCast(a)) & @as(types.u32x4, @bitCast(b))) != @as(types.u32x4, @splat(0));
    return @select(u32, cond, @as(types.u32x4, @splat(0xffffffff)), @as(types.u32x4, @splat(0)));
}

test vtstq_s32 {
    const a = types.i32x4{ 10, 5, 8, 1 };
    const b = types.i32x4{ 8, 2, 7, 1 };
    const expected = types.u32x4{ 0xffffffff, 0, 0, 0xffffffff };
    try common.testIntrinsic(.{ .func = vtstq_s32, .expected = expected, .args = .{ a, b } });
}

/// Vector bit test: returns `(a & b) != 0` mask
pub inline fn vtstq_s64(a: types.i64x2, b: types.i64x2) types.u64x2 {
    const cond = (@as(types.u64x2, @bitCast(a)) & @as(types.u64x2, @bitCast(b))) != @as(types.u64x2, @splat(0));
    return @select(u64, cond, @as(types.u64x2, @splat(0xffffffffffffffff)), @as(types.u64x2, @splat(0)));
}

test vtstq_s64 {
    const a = types.i64x2{ 10, 5 };
    const b = types.i64x2{ 8, 2 };
    const expected = types.u64x2{ 0xffffffffffffffff, 0 };
    try common.testIntrinsic(.{ .func = vtstq_s64, .expected = expected, .args = .{ a, b } });
}

/// Vector bit test: returns `(a & b) != 0` mask
pub inline fn vtstq_u8(a: types.u8x16, b: types.u8x16) types.u8x16 {
    const cond = (a & b) != @as(types.u8x16, @splat(0));
    return @select(u8, cond, @as(types.u8x16, @splat(0xff)), @as(types.u8x16, @splat(0)));
}

test vtstq_u8 {
    const a = types.u8x16{ 10, 5, 8, 1, 0, 15, 2, 4, 10, 10, 10, 10, 10, 10, 10, 10 };
    const b = types.u8x16{ 8, 2, 7, 1, 15, 0, 2, 8, 8, 8, 8, 8, 8, 8, 8, 8 };
    const expected = types.u8x16{ 0xff, 0, 0, 0xff, 0, 0, 0xff, 0, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff };
    try common.testIntrinsic(.{ .func = vtstq_u8, .expected = expected, .args = .{ a, b } });
}

/// Vector bit test: returns `(a & b) != 0` mask
pub inline fn vtstq_u16(a: types.u16x8, b: types.u16x8) types.u16x8 {
    const cond = (a & b) != @as(types.u16x8, @splat(0));
    return @select(u16, cond, @as(types.u16x8, @splat(0xffff)), @as(types.u16x8, @splat(0)));
}

test vtstq_u16 {
    const a = types.u16x8{ 10, 5, 8, 1, 0, 15, 2, 4 };
    const b = types.u16x8{ 8, 2, 7, 1, 15, 0, 2, 8 };
    const expected = types.u16x8{ 0xffff, 0, 0, 0xffff, 0, 0, 0xffff, 0 };
    try common.testIntrinsic(.{ .func = vtstq_u16, .expected = expected, .args = .{ a, b } });
}

/// Vector bit test: returns `(a & b) != 0` mask
pub inline fn vtstq_u32(a: types.u32x4, b: types.u32x4) types.u32x4 {
    const cond = (a & b) != @as(types.u32x4, @splat(0));
    return @select(u32, cond, @as(types.u32x4, @splat(0xffffffff)), @as(types.u32x4, @splat(0)));
}

test vtstq_u32 {
    const a = types.u32x4{ 10, 5, 8, 1 };
    const b = types.u32x4{ 8, 2, 7, 1 };
    const expected = types.u32x4{ 0xffffffff, 0, 0, 0xffffffff };
    try common.testIntrinsic(.{ .func = vtstq_u32, .expected = expected, .args = .{ a, b } });
}

/// Vector bit test: returns `(a & b) != 0` mask
pub inline fn vtstq_u64(a: types.u64x2, b: types.u64x2) types.u64x2 {
    const cond = (a & b) != @as(types.u64x2, @splat(0));
    return @select(u64, cond, @as(types.u64x2, @splat(0xffffffffffffffff)), @as(types.u64x2, @splat(0)));
}

test vtstq_u64 {
    const a = types.u64x2{ 10, 5 };
    const b = types.u64x2{ 8, 2 };
    const expected = types.u64x2{ 0xffffffffffffffff, 0 };
    try common.testIntrinsic(.{ .func = vtstq_u64, .expected = expected, .args = .{ a, b } });
}

/// Vector bit test: returns `(a & b) != 0` mask
pub inline fn vtstq_p8(a: types.p8x16, b: types.p8x16) types.u8x16 {
    const cond = (@as(types.u8x16, @bitCast(a)) & @as(types.u8x16, @bitCast(b))) != @as(types.u8x16, @splat(0));
    return @select(u8, cond, @as(types.u8x16, @splat(0xff)), @as(types.u8x16, @splat(0)));
}

test vtstq_p8 {
    const a = types.p8x16{ 10, 5, 8, 1, 0, 15, 2, 4, 10, 10, 10, 10, 10, 10, 10, 10 };
    const b = types.p8x16{ 8, 2, 7, 1, 15, 0, 2, 8, 8, 8, 8, 8, 8, 8, 8, 8 };
    const expected = types.u8x16{ 0xff, 0, 0, 0xff, 0, 0, 0xff, 0, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff };
    try common.testIntrinsic(.{ .func = vtstq_p8, .expected = expected, .args = .{ a, b } });
}

/// Vector bit test: returns `(a & b) != 0` mask
pub inline fn vtstq_p16(a: types.p16x8, b: types.p16x8) types.u16x8 {
    const cond = (@as(types.u16x8, @bitCast(a)) & @as(types.u16x8, @bitCast(b))) != @as(types.u16x8, @splat(0));
    return @select(u16, cond, @as(types.u16x8, @splat(0xffff)), @as(types.u16x8, @splat(0)));
}

test vtstq_p16 {
    const a = types.p16x8{ 10, 5, 8, 1, 0, 15, 2, 4 };
    const b = types.p16x8{ 8, 2, 7, 1, 15, 0, 2, 8 };
    const expected = types.u16x8{ 0xffff, 0, 0, 0xffff, 0, 0, 0xffff, 0 };
    try common.testIntrinsic(.{ .func = vtstq_p16, .expected = expected, .args = .{ a, b } });
}

/// Vector bit test: returns `(a & b) != 0` mask
pub inline fn vtstq_p64(a: types.p64x2, b: types.p64x2) types.u64x2 {
    const cond = (@as(types.u64x2, @bitCast(a)) & @as(types.u64x2, @bitCast(b))) != @as(types.u64x2, @splat(0));
    return @select(u64, cond, @as(types.u64x2, @splat(0xffffffffffffffff)), @as(types.u64x2, @splat(0)));
}

test vtstq_p64 {
    const a = types.p64x2{ 10, 5 };
    const b = types.p64x2{ 8, 2 };
    const expected = types.u64x2{ 0xffffffffffffffff, 0 };
    try common.testIntrinsic(.{ .func = vtstq_p64, .expected = expected, .args = .{ a, b } });
}

/// Vector compare greater than zero: returns `a > 0` mask
pub inline fn vcgtz_s8(a: types.i8x8) types.u8x8 {
    const cond = a > @as(types.i8x8, @splat(0));
    return @select(u8, cond, @as(types.u8x8, @splat(0xff)), @as(types.u8x8, @splat(0)));
}

test vcgtz_s8 {
    const a = types.i8x8{ 10, -5, 0, 42, -100, 1, -1, 50 };
    const expected = types.u8x8{ 0xff, 0, 0, 0xff, 0, 0xff, 0, 0xff };
    try common.testIntrinsic(.{ .func = vcgtz_s8, .expected = expected, .args = .{a} });
}

/// Vector compare greater than zero: returns `a > 0` mask
pub inline fn vcgtz_s16(a: types.i16x4) types.u16x4 {
    const cond = a > @as(types.i16x4, @splat(0));
    return @select(u16, cond, @as(types.u16x4, @splat(0xffff)), @as(types.u16x4, @splat(0)));
}

test vcgtz_s16 {
    const a = types.i16x4{ 10, -5, 0, 42 };
    const expected = types.u16x4{ 0xffff, 0, 0, 0xffff };
    try common.testIntrinsic(.{ .func = vcgtz_s16, .expected = expected, .args = .{a} });
}

/// Vector compare greater than zero: returns `a > 0` mask
pub inline fn vcgtz_s32(a: types.i32x2) types.u32x2 {
    const cond = a > @as(types.i32x2, @splat(0));
    return @select(u32, cond, @as(types.u32x2, @splat(0xffffffff)), @as(types.u32x2, @splat(0)));
}

test vcgtz_s32 {
    const a = types.i32x2{ 10, -5 };
    const expected = types.u32x2{ 0xffffffff, 0 };
    try common.testIntrinsic(.{ .func = vcgtz_s32, .expected = expected, .args = .{a} });
}

/// Vector compare greater than zero: returns `a > 0` mask
pub inline fn vcgtz_s64(a: types.i64x1) types.u64x1 {
    const cond = a > @as(types.i64x1, @splat(0));
    return @select(u64, cond, @as(types.u64x1, @splat(0xffffffffffffffff)), @as(types.u64x1, @splat(0)));
}

test vcgtz_s64 {
    const a = types.i64x1{10};
    const expected = types.u64x1{0xffffffffffffffff};
    try common.testIntrinsic(.{ .func = vcgtz_s64, .expected = expected, .args = .{a} });
}

/// Vector compare greater than zero: returns `a > 0` mask
pub inline fn vcgtz_f32(a: types.f32x2) types.u32x2 {
    const cond = a > @as(types.f32x2, @splat(0.0));
    return @select(u32, cond, @as(types.u32x2, @splat(0xffffffff)), @as(types.u32x2, @splat(0)));
}

test vcgtz_f32 {
    const a = types.f32x2{ 1.5, -2.5 };
    const expected = types.u32x2{ 0xffffffff, 0 };
    try common.testIntrinsic(.{ .func = vcgtz_f32, .expected = expected, .args = .{a} });
}

/// Vector compare greater than zero: returns `a > 0` mask
pub inline fn vcgtz_f64(a: types.f64x1) types.u64x1 {
    const cond = a > @as(types.f64x1, @splat(0.0));
    return @select(u64, cond, @as(types.u64x1, @splat(0xffffffffffffffff)), @as(types.u64x1, @splat(0)));
}

test vcgtz_f64 {
    const a = types.f64x1{1.5};
    const expected = types.u64x1{0xffffffffffffffff};
    try common.testIntrinsic(.{ .func = vcgtz_f64, .expected = expected, .args = .{a} });
}

/// Vector compare greater than zero: returns `a > 0` mask
pub inline fn vcgtzq_s8(a: types.i8x16) types.u8x16 {
    const cond = a > @as(types.i8x16, @splat(0));
    return @select(u8, cond, @as(types.u8x16, @splat(0xff)), @as(types.u8x16, @splat(0)));
}

test vcgtzq_s8 {
    const a = types.i8x16{ 10, -5, 0, 42, -100, 1, -1, 50, 10, 10, 10, 10, 10, 10, 10, 10 };
    const expected = types.u8x16{ 0xff, 0, 0, 0xff, 0, 0xff, 0, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff };
    try common.testIntrinsic(.{ .func = vcgtzq_s8, .expected = expected, .args = .{a} });
}

/// Vector compare greater than zero: returns `a > 0` mask
pub inline fn vcgtzq_s16(a: types.i16x8) types.u16x8 {
    const cond = a > @as(types.i16x8, @splat(0));
    return @select(u16, cond, @as(types.u16x8, @splat(0xffff)), @as(types.u16x8, @splat(0)));
}

test vcgtzq_s16 {
    const a = types.i16x8{ 10, -5, 0, 42, -100, 1, -1, 50 };
    const expected = types.u16x8{ 0xffff, 0, 0, 0xffff, 0, 0xffff, 0, 0xffff };
    try common.testIntrinsic(.{ .func = vcgtzq_s16, .expected = expected, .args = .{a} });
}

/// Vector compare greater than zero: returns `a > 0` mask
pub inline fn vcgtzq_s32(a: types.i32x4) types.u32x4 {
    const cond = a > @as(types.i32x4, @splat(0));
    return @select(u32, cond, @as(types.u32x4, @splat(0xffffffff)), @as(types.u32x4, @splat(0)));
}

test vcgtzq_s32 {
    const a = types.i32x4{ 10, -5, 0, 42 };
    const expected = types.u32x4{ 0xffffffff, 0, 0, 0xffffffff };
    try common.testIntrinsic(.{ .func = vcgtzq_s32, .expected = expected, .args = .{a} });
}

/// Vector compare greater than zero: returns `a > 0` mask
pub inline fn vcgtzq_s64(a: types.i64x2) types.u64x2 {
    const cond = a > @as(types.i64x2, @splat(0));
    return @select(u64, cond, @as(types.u64x2, @splat(0xffffffffffffffff)), @as(types.u64x2, @splat(0)));
}

test vcgtzq_s64 {
    const a = types.i64x2{ 10, -5 };
    const expected = types.u64x2{ 0xffffffffffffffff, 0 };
    try common.testIntrinsic(.{ .func = vcgtzq_s64, .expected = expected, .args = .{a} });
}

/// Vector compare greater than zero: returns `a > 0` mask
pub inline fn vcgtzq_f32(a: types.f32x4) types.u32x4 {
    const cond = a > @as(types.f32x4, @splat(0.0));
    return @select(u32, cond, @as(types.u32x4, @splat(0xffffffff)), @as(types.u32x4, @splat(0)));
}

test vcgtzq_f32 {
    const a = types.f32x4{ 1.5, -2.5, 0.0, 10.0 };
    const expected = types.u32x4{ 0xffffffff, 0, 0, 0xffffffff };
    try common.testIntrinsic(.{ .func = vcgtzq_f32, .expected = expected, .args = .{a} });
}

/// Vector compare greater than zero: returns `a > 0` mask
pub inline fn vcgtzq_f64(a: types.f64x2) types.u64x2 {
    const cond = a > @as(types.f64x2, @splat(0.0));
    return @select(u64, cond, @as(types.u64x2, @splat(0xffffffffffffffff)), @as(types.u64x2, @splat(0)));
}

test vcgtzq_f64 {
    const a = types.f64x2{ 1.5, -2.5 };
    const expected = types.u64x2{ 0xffffffffffffffff, 0 };
    try common.testIntrinsic(.{ .func = vcgtzq_f64, .expected = expected, .args = .{a} });
}

/// Vector compare greater than or equal to zero: returns `a >= 0` mask
pub inline fn vcgez_s8(a: types.i8x8) types.u8x8 {
    const cond = a >= @as(types.i8x8, @splat(0));
    return @select(u8, cond, @as(types.u8x8, @splat(0xff)), @as(types.u8x8, @splat(0)));
}

test vcgez_s8 {
    const a = types.i8x8{ 10, -5, 0, 42, -100, 1, -1, 50 };
    const expected = types.u8x8{ 0xff, 0, 0xff, 0xff, 0, 0xff, 0, 0xff };
    try common.testIntrinsic(.{ .func = vcgez_s8, .expected = expected, .args = .{a} });
}

/// Vector compare greater than or equal to zero: returns `a >= 0` mask
pub inline fn vcgez_s16(a: types.i16x4) types.u16x4 {
    const cond = a >= @as(types.i16x4, @splat(0));
    return @select(u16, cond, @as(types.u16x4, @splat(0xffff)), @as(types.u16x4, @splat(0)));
}

test vcgez_s16 {
    const a = types.i16x4{ 10, -5, 0, 42 };
    const expected = types.u16x4{ 0xffff, 0, 0xffff, 0xffff };
    try common.testIntrinsic(.{ .func = vcgez_s16, .expected = expected, .args = .{a} });
}

/// Vector compare greater than or equal to zero: returns `a >= 0` mask
pub inline fn vcgez_s32(a: types.i32x2) types.u32x2 {
    const cond = a >= @as(types.i32x2, @splat(0));
    return @select(u32, cond, @as(types.u32x2, @splat(0xffffffff)), @as(types.u32x2, @splat(0)));
}

test vcgez_s32 {
    const a = types.i32x2{ 10, -5 };
    const expected = types.u32x2{ 0xffffffff, 0 };
    try common.testIntrinsic(.{ .func = vcgez_s32, .expected = expected, .args = .{a} });
}

/// Vector compare greater than or equal to zero: returns `a >= 0` mask
pub inline fn vcgez_s64(a: types.i64x1) types.u64x1 {
    const cond = a >= @as(types.i64x1, @splat(0));
    return @select(u64, cond, @as(types.u64x1, @splat(0xffffffffffffffff)), @as(types.u64x1, @splat(0)));
}

test vcgez_s64 {
    const a = types.i64x1{10};
    const expected = types.u64x1{0xffffffffffffffff};
    try common.testIntrinsic(.{ .func = vcgez_s64, .expected = expected, .args = .{a} });
}

/// Vector compare greater than or equal to zero: returns `a >= 0` mask
pub inline fn vcgez_f32(a: types.f32x2) types.u32x2 {
    const cond = a >= @as(types.f32x2, @splat(0.0));
    return @select(u32, cond, @as(types.u32x2, @splat(0xffffffff)), @as(types.u32x2, @splat(0)));
}

test vcgez_f32 {
    const a = types.f32x2{ 1.5, -2.5 };
    const expected = types.u32x2{ 0xffffffff, 0 };
    try common.testIntrinsic(.{ .func = vcgez_f32, .expected = expected, .args = .{a} });
}

/// Vector compare greater than or equal to zero: returns `a >= 0` mask
pub inline fn vcgez_f64(a: types.f64x1) types.u64x1 {
    const cond = a >= @as(types.f64x1, @splat(0.0));
    return @select(u64, cond, @as(types.u64x1, @splat(0xffffffffffffffff)), @as(types.u64x1, @splat(0)));
}

test vcgez_f64 {
    const a = types.f64x1{1.5};
    const expected = types.u64x1{0xffffffffffffffff};
    try common.testIntrinsic(.{ .func = vcgez_f64, .expected = expected, .args = .{a} });
}

/// Vector compare greater than or equal to zero: returns `a >= 0` mask
pub inline fn vcgezq_s8(a: types.i8x16) types.u8x16 {
    const cond = a >= @as(types.i8x16, @splat(0));
    return @select(u8, cond, @as(types.u8x16, @splat(0xff)), @as(types.u8x16, @splat(0)));
}

test vcgezq_s8 {
    const a = types.i8x16{ 10, -5, 0, 42, -100, 1, -1, 50, 10, 10, 10, 10, 10, 10, 10, 10 };
    const expected = types.u8x16{ 0xff, 0, 0xff, 0xff, 0, 0xff, 0, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff };
    try common.testIntrinsic(.{ .func = vcgezq_s8, .expected = expected, .args = .{a} });
}

/// Vector compare greater than or equal to zero: returns `a >= 0` mask
pub inline fn vcgezq_s16(a: types.i16x8) types.u16x8 {
    const cond = a >= @as(types.i16x8, @splat(0));
    return @select(u16, cond, @as(types.u16x8, @splat(0xffff)), @as(types.u16x8, @splat(0)));
}

test vcgezq_s16 {
    const a = types.i16x8{ 10, -5, 0, 42, -100, 1, -1, 50 };
    const expected = types.u16x8{ 0xffff, 0, 0xffff, 0xffff, 0, 0xffff, 0, 0xffff };
    try common.testIntrinsic(.{ .func = vcgezq_s16, .expected = expected, .args = .{a} });
}

/// Vector compare greater than or equal to zero: returns `a >= 0` mask
pub inline fn vcgezq_s32(a: types.i32x4) types.u32x4 {
    const cond = a >= @as(types.i32x4, @splat(0));
    return @select(u32, cond, @as(types.u32x4, @splat(0xffffffff)), @as(types.u32x4, @splat(0)));
}

test vcgezq_s32 {
    const a = types.i32x4{ 10, -5, 0, 42 };
    const expected = types.u32x4{ 0xffffffff, 0, 0xffffffff, 0xffffffff };
    try common.testIntrinsic(.{ .func = vcgezq_s32, .expected = expected, .args = .{a} });
}

/// Vector compare greater than or equal to zero: returns `a >= 0` mask
pub inline fn vcgezq_s64(a: types.i64x2) types.u64x2 {
    const cond = a >= @as(types.i64x2, @splat(0));
    return @select(u64, cond, @as(types.u64x2, @splat(0xffffffffffffffff)), @as(types.u64x2, @splat(0)));
}

test vcgezq_s64 {
    const a = types.i64x2{ 10, -5 };
    const expected = types.u64x2{ 0xffffffffffffffff, 0 };
    try common.testIntrinsic(.{ .func = vcgezq_s64, .expected = expected, .args = .{a} });
}

/// Vector compare greater than or equal to zero: returns `a >= 0` mask
pub inline fn vcgezq_f32(a: types.f32x4) types.u32x4 {
    const cond = a >= @as(types.f32x4, @splat(0.0));
    return @select(u32, cond, @as(types.u32x4, @splat(0xffffffff)), @as(types.u32x4, @splat(0)));
}

test vcgezq_f32 {
    const a = types.f32x4{ 1.5, -2.5, 0.0, 10.0 };
    const expected = types.u32x4{ 0xffffffff, 0, 0xffffffff, 0xffffffff };
    try common.testIntrinsic(.{ .func = vcgezq_f32, .expected = expected, .args = .{a} });
}

/// Vector compare greater than or equal to zero: returns `a >= 0` mask
pub inline fn vcgezq_f64(a: types.f64x2) types.u64x2 {
    const cond = a >= @as(types.f64x2, @splat(0.0));
    return @select(u64, cond, @as(types.u64x2, @splat(0xffffffffffffffff)), @as(types.u64x2, @splat(0)));
}

test vcgezq_f64 {
    const a = types.f64x2{ 1.5, -2.5 };
    const expected = types.u64x2{ 0xffffffffffffffff, 0 };
    try common.testIntrinsic(.{ .func = vcgezq_f64, .expected = expected, .args = .{a} });
}

/// Vector compare less than or equal to zero: returns `a <= 0` mask
pub inline fn vclez_s8(a: types.i8x8) types.u8x8 {
    const cond = a <= @as(types.i8x8, @splat(0));
    return @select(u8, cond, @as(types.u8x8, @splat(0xff)), @as(types.u8x8, @splat(0)));
}

test vclez_s8 {
    const a = types.i8x8{ 10, -5, 0, 42, -100, 1, -1, 50 };
    const expected = types.u8x8{ 0, 0xff, 0xff, 0, 0xff, 0, 0xff, 0 };
    try common.testIntrinsic(.{ .func = vclez_s8, .expected = expected, .args = .{a} });
}

/// Vector compare less than or equal to zero: returns `a <= 0` mask
pub inline fn vclez_s16(a: types.i16x4) types.u16x4 {
    const cond = a <= @as(types.i16x4, @splat(0));
    return @select(u16, cond, @as(types.u16x4, @splat(0xffff)), @as(types.u16x4, @splat(0)));
}

test vclez_s16 {
    const a = types.i16x4{ 10, -5, 0, 42 };
    const expected = types.u16x4{ 0, 0xffff, 0xffff, 0 };
    try common.testIntrinsic(.{ .func = vclez_s16, .expected = expected, .args = .{a} });
}

/// Vector compare less than or equal to zero: returns `a <= 0` mask
pub inline fn vclez_s32(a: types.i32x2) types.u32x2 {
    const cond = a <= @as(types.i32x2, @splat(0));
    return @select(u32, cond, @as(types.u32x2, @splat(0xffffffff)), @as(types.u32x2, @splat(0)));
}

test vclez_s32 {
    const a = types.i32x2{ 10, -5 };
    const expected = types.u32x2{ 0, 0xffffffff };
    try common.testIntrinsic(.{ .func = vclez_s32, .expected = expected, .args = .{a} });
}

/// Vector compare less than or equal to zero: returns `a <= 0` mask
pub inline fn vclez_s64(a: types.i64x1) types.u64x1 {
    const cond = a <= @as(types.i64x1, @splat(0));
    return @select(u64, cond, @as(types.u64x1, @splat(0xffffffffffffffff)), @as(types.u64x1, @splat(0)));
}

test vclez_s64 {
    const a = types.i64x1{10};
    const expected = types.u64x1{0};
    try common.testIntrinsic(.{ .func = vclez_s64, .expected = expected, .args = .{a} });
}

/// Vector compare less than or equal to zero: returns `a <= 0` mask
pub inline fn vclez_f32(a: types.f32x2) types.u32x2 {
    const cond = a <= @as(types.f32x2, @splat(0.0));
    return @select(u32, cond, @as(types.u32x2, @splat(0xffffffff)), @as(types.u32x2, @splat(0)));
}

test vclez_f32 {
    const a = types.f32x2{ 1.5, -2.5 };
    const expected = types.u32x2{ 0, 0xffffffff };
    try common.testIntrinsic(.{ .func = vclez_f32, .expected = expected, .args = .{a} });
}

/// Vector compare less than or equal to zero: returns `a <= 0` mask
pub inline fn vclez_f64(a: types.f64x1) types.u64x1 {
    const cond = a <= @as(types.f64x1, @splat(0.0));
    return @select(u64, cond, @as(types.u64x1, @splat(0xffffffffffffffff)), @as(types.u64x1, @splat(0)));
}

test vclez_f64 {
    const a = types.f64x1{1.5};
    const expected = types.u64x1{0};
    try common.testIntrinsic(.{ .func = vclez_f64, .expected = expected, .args = .{a} });
}

/// Vector compare less than or equal to zero: returns `a <= 0` mask
pub inline fn vclezq_s8(a: types.i8x16) types.u8x16 {
    const cond = a <= @as(types.i8x16, @splat(0));
    return @select(u8, cond, @as(types.u8x16, @splat(0xff)), @as(types.u8x16, @splat(0)));
}

test vclezq_s8 {
    const a = types.i8x16{ 10, -5, 0, 42, -100, 1, -1, 50, 10, 10, 10, 10, 10, 10, 10, 10 };
    const expected = types.u8x16{ 0, 0xff, 0xff, 0, 0xff, 0, 0xff, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
    try common.testIntrinsic(.{ .func = vclezq_s8, .expected = expected, .args = .{a} });
}

/// Vector compare less than or equal to zero: returns `a <= 0` mask
pub inline fn vclezq_s16(a: types.i16x8) types.u16x8 {
    const cond = a <= @as(types.i16x8, @splat(0));
    return @select(u16, cond, @as(types.u16x8, @splat(0xffff)), @as(types.u16x8, @splat(0)));
}

test vclezq_s16 {
    const a = types.i16x8{ 10, -5, 0, 42, -100, 1, -1, 50 };
    const expected = types.u16x8{ 0, 0xffff, 0xffff, 0, 0xffff, 0, 0xffff, 0 };
    try common.testIntrinsic(.{ .func = vclezq_s16, .expected = expected, .args = .{a} });
}

/// Vector compare less than or equal to zero: returns `a <= 0` mask
pub inline fn vclezq_s32(a: types.i32x4) types.u32x4 {
    const cond = a <= @as(types.i32x4, @splat(0));
    return @select(u32, cond, @as(types.u32x4, @splat(0xffffffff)), @as(types.u32x4, @splat(0)));
}

test vclezq_s32 {
    const a = types.i32x4{ 10, -5, 0, 42 };
    const expected = types.u32x4{ 0, 0xffffffff, 0xffffffff, 0 };
    try common.testIntrinsic(.{ .func = vclezq_s32, .expected = expected, .args = .{a} });
}

/// Vector compare less than or equal to zero: returns `a <= 0` mask
pub inline fn vclezq_s64(a: types.i64x2) types.u64x2 {
    const cond = a <= @as(types.i64x2, @splat(0));
    return @select(u64, cond, @as(types.u64x2, @splat(0xffffffffffffffff)), @as(types.u64x2, @splat(0)));
}

test vclezq_s64 {
    const a = types.i64x2{ 10, -5 };
    const expected = types.u64x2{ 0, 0xffffffffffffffff };
    try common.testIntrinsic(.{ .func = vclezq_s64, .expected = expected, .args = .{a} });
}

/// Vector compare less than or equal to zero: returns `a <= 0` mask
pub inline fn vclezq_f32(a: types.f32x4) types.u32x4 {
    const cond = a <= @as(types.f32x4, @splat(0.0));
    return @select(u32, cond, @as(types.u32x4, @splat(0xffffffff)), @as(types.u32x4, @splat(0)));
}

test vclezq_f32 {
    const a = types.f32x4{ 1.5, -2.5, 0.0, 10.0 };
    const expected = types.u32x4{ 0, 0xffffffff, 0xffffffff, 0 };
    try common.testIntrinsic(.{ .func = vclezq_f32, .expected = expected, .args = .{a} });
}

/// Vector compare less than or equal to zero: returns `a <= 0` mask
pub inline fn vclezq_f64(a: types.f64x2) types.u64x2 {
    const cond = a <= @as(types.f64x2, @splat(0.0));
    return @select(u64, cond, @as(types.u64x2, @splat(0xffffffffffffffff)), @as(types.u64x2, @splat(0)));
}

test vclezq_f64 {
    const a = types.f64x2{ 1.5, -2.5 };
    const expected = types.u64x2{ 0, 0xffffffffffffffff };
    try common.testIntrinsic(.{ .func = vclezq_f64, .expected = expected, .args = .{a} });
}

/// Vector compare less than zero: returns `a < 0` mask
pub inline fn vcltz_s8(a: types.i8x8) types.u8x8 {
    const cond = a < @as(types.i8x8, @splat(0));
    return @select(u8, cond, @as(types.u8x8, @splat(0xff)), @as(types.u8x8, @splat(0)));
}

test vcltz_s8 {
    const a = types.i8x8{ 10, -5, 0, 42, -100, 1, -1, 50 };
    const expected = types.u8x8{ 0, 0xff, 0, 0, 0xff, 0, 0xff, 0 };
    try common.testIntrinsic(.{ .func = vcltz_s8, .expected = expected, .args = .{a} });
}

/// Vector compare less than zero: returns `a < 0` mask
pub inline fn vcltz_s16(a: types.i16x4) types.u16x4 {
    const cond = a < @as(types.i16x4, @splat(0));
    return @select(u16, cond, @as(types.u16x4, @splat(0xffff)), @as(types.u16x4, @splat(0)));
}

test vcltz_s16 {
    const a = types.i16x4{ 10, -5, 0, 42 };
    const expected = types.u16x4{ 0, 0xffff, 0, 0 };
    try common.testIntrinsic(.{ .func = vcltz_s16, .expected = expected, .args = .{a} });
}

/// Vector compare less than zero: returns `a < 0` mask
pub inline fn vcltz_s32(a: types.i32x2) types.u32x2 {
    const cond = a < @as(types.i32x2, @splat(0));
    return @select(u32, cond, @as(types.u32x2, @splat(0xffffffff)), @as(types.u32x2, @splat(0)));
}

test vcltz_s32 {
    const a = types.i32x2{ 10, -5 };
    const expected = types.u32x2{ 0, 0xffffffff };
    try common.testIntrinsic(.{ .func = vcltz_s32, .expected = expected, .args = .{a} });
}

/// Vector compare less than zero: returns `a < 0` mask
pub inline fn vcltz_s64(a: types.i64x1) types.u64x1 {
    const cond = a < @as(types.i64x1, @splat(0));
    return @select(u64, cond, @as(types.u64x1, @splat(0xffffffffffffffff)), @as(types.u64x1, @splat(0)));
}

test vcltz_s64 {
    const a = types.i64x1{10};
    const expected = types.u64x1{0};
    try common.testIntrinsic(.{ .func = vcltz_s64, .expected = expected, .args = .{a} });
}

/// Vector compare less than zero: returns `a < 0` mask
pub inline fn vcltz_f32(a: types.f32x2) types.u32x2 {
    const cond = a < @as(types.f32x2, @splat(0.0));
    return @select(u32, cond, @as(types.u32x2, @splat(0xffffffff)), @as(types.u32x2, @splat(0)));
}

test vcltz_f32 {
    const a = types.f32x2{ 1.5, -2.5 };
    const expected = types.u32x2{ 0, 0xffffffff };
    try common.testIntrinsic(.{ .func = vcltz_f32, .expected = expected, .args = .{a} });
}

/// Vector compare less than zero: returns `a < 0` mask
pub inline fn vcltz_f64(a: types.f64x1) types.u64x1 {
    const cond = a < @as(types.f64x1, @splat(0.0));
    return @select(u64, cond, @as(types.u64x1, @splat(0xffffffffffffffff)), @as(types.u64x1, @splat(0)));
}

test vcltz_f64 {
    const a = types.f64x1{1.5};
    const expected = types.u64x1{0};
    try common.testIntrinsic(.{ .func = vcltz_f64, .expected = expected, .args = .{a} });
}

/// Vector compare less than zero: returns `a < 0` mask
pub inline fn vcltzq_s8(a: types.i8x16) types.u8x16 {
    const cond = a < @as(types.i8x16, @splat(0));
    return @select(u8, cond, @as(types.u8x16, @splat(0xff)), @as(types.u8x16, @splat(0)));
}

test vcltzq_s8 {
    const a = types.i8x16{ 10, -5, 0, 42, -100, 1, -1, 50, 10, 10, 10, 10, 10, 10, 10, 10 };
    const expected = types.u8x16{ 0, 0xff, 0, 0, 0xff, 0, 0xff, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
    try common.testIntrinsic(.{ .func = vcltzq_s8, .expected = expected, .args = .{a} });
}

/// Vector compare less than zero: returns `a < 0` mask
pub inline fn vcltzq_s16(a: types.i16x8) types.u16x8 {
    const cond = a < @as(types.i16x8, @splat(0));
    return @select(u16, cond, @as(types.u16x8, @splat(0xffff)), @as(types.u16x8, @splat(0)));
}

test vcltzq_s16 {
    const a = types.i16x8{ 10, -5, 0, 42, -100, 1, -1, 50 };
    const expected = types.u16x8{ 0, 0xffff, 0, 0, 0xffff, 0, 0xffff, 0 };
    try common.testIntrinsic(.{ .func = vcltzq_s16, .expected = expected, .args = .{a} });
}

/// Vector compare less than zero: returns `a < 0` mask
pub inline fn vcltzq_s32(a: types.i32x4) types.u32x4 {
    const cond = a < @as(types.i32x4, @splat(0));
    return @select(u32, cond, @as(types.u32x4, @splat(0xffffffff)), @as(types.u32x4, @splat(0)));
}

test vcltzq_s32 {
    const a = types.i32x4{ 10, -5, 0, 42 };
    const expected = types.u32x4{ 0, 0xffffffff, 0, 0 };
    try common.testIntrinsic(.{ .func = vcltzq_s32, .expected = expected, .args = .{a} });
}

/// Vector compare less than zero: returns `a < 0` mask
pub inline fn vcltzq_s64(a: types.i64x2) types.u64x2 {
    const cond = a < @as(types.i64x2, @splat(0));
    return @select(u64, cond, @as(types.u64x2, @splat(0xffffffffffffffff)), @as(types.u64x2, @splat(0)));
}

test vcltzq_s64 {
    const a = types.i64x2{ 10, -5 };
    const expected = types.u64x2{ 0, 0xffffffffffffffff };
    try common.testIntrinsic(.{ .func = vcltzq_s64, .expected = expected, .args = .{a} });
}

/// Vector compare less than zero: returns `a < 0` mask
pub inline fn vcltzq_f32(a: types.f32x4) types.u32x4 {
    const cond = a < @as(types.f32x4, @splat(0.0));
    return @select(u32, cond, @as(types.u32x4, @splat(0xffffffff)), @as(types.u32x4, @splat(0)));
}

test vcltzq_f32 {
    const a = types.f32x4{ 1.5, -2.5, 0.0, 10.0 };
    const expected = types.u32x4{ 0, 0xffffffff, 0, 0 };
    try common.testIntrinsic(.{ .func = vcltzq_f32, .expected = expected, .args = .{a} });
}

/// Vector compare less than zero: returns `a < 0` mask
pub inline fn vcltzq_f64(a: types.f64x2) types.u64x2 {
    const cond = a < @as(types.f64x2, @splat(0.0));
    return @select(u64, cond, @as(types.u64x2, @splat(0xffffffffffffffff)), @as(types.u64x2, @splat(0)));
}

test vcltzq_f64 {
    const a = types.f64x2{ 1.5, -2.5 };
    const expected = types.u64x2{ 0, 0xffffffffffffffff };
    try common.testIntrinsic(.{ .func = vcltzq_f64, .expected = expected, .args = .{a} });
}

/// Scalar compare ==
pub inline fn vceqd_s64(a: i64, b: i64) u64 {
    return if (a == b) 0xffffffffffffffff else 0;
}

test vceqd_s64 {
    const a: i64 = 10;
    const b: i64 = 20;
    const expected: u64 = if (a == b) 0xffffffffffffffff else 0;
    try common.testIntrinsic(.{ .func = vceqd_s64, .expected = expected, .args = .{ a, b } });
}

/// Scalar compare ==
pub inline fn vceqd_u64(a: u64, b: u64) u64 {
    return if (a == b) 0xffffffffffffffff else 0;
}

test vceqd_u64 {
    const a: u64 = 10;
    const b: u64 = 20;
    const expected: u64 = if (a == b) 0xffffffffffffffff else 0;
    try common.testIntrinsic(.{ .func = vceqd_u64, .expected = expected, .args = .{ a, b } });
}

/// Scalar compare ==
pub inline fn vceqd_f64(a: f64, b: f64) u64 {
    return if (a == b) 0xffffffffffffffff else 0;
}

test vceqd_f64 {
    const a: f64 = 10;
    const b: f64 = 20;
    const expected: u64 = if (a == b) 0xffffffffffffffff else 0;
    try common.testIntrinsic(.{ .func = vceqd_f64, .expected = expected, .args = .{ a, b } });
}

/// Scalar compare ==
pub inline fn vceqs_f32(a: f32, b: f32) u32 {
    return if (a == b) 0xffffffff else 0;
}

test vceqs_f32 {
    const a: f32 = 10;
    const b: f32 = 20;
    const expected: u32 = if (a == b) 0xffffffff else 0;
    try common.testIntrinsic(.{ .func = vceqs_f32, .expected = expected, .args = .{ a, b } });
}

/// Scalar compare >=
pub inline fn vcged_s64(a: i64, b: i64) u64 {
    return if (a >= b) 0xffffffffffffffff else 0;
}

test vcged_s64 {
    const a: i64 = 10;
    const b: i64 = 20;
    const expected: u64 = if (a >= b) 0xffffffffffffffff else 0;
    try common.testIntrinsic(.{ .func = vcged_s64, .expected = expected, .args = .{ a, b } });
}

/// Scalar compare >=
pub inline fn vcged_u64(a: u64, b: u64) u64 {
    return if (a >= b) 0xffffffffffffffff else 0;
}

test vcged_u64 {
    const a: u64 = 10;
    const b: u64 = 20;
    const expected: u64 = if (a >= b) 0xffffffffffffffff else 0;
    try common.testIntrinsic(.{ .func = vcged_u64, .expected = expected, .args = .{ a, b } });
}

/// Scalar compare >=
pub inline fn vcged_f64(a: f64, b: f64) u64 {
    return if (a >= b) 0xffffffffffffffff else 0;
}

test vcged_f64 {
    const a: f64 = 10;
    const b: f64 = 20;
    const expected: u64 = if (a >= b) 0xffffffffffffffff else 0;
    try common.testIntrinsic(.{ .func = vcged_f64, .expected = expected, .args = .{ a, b } });
}

/// Scalar compare >=
pub inline fn vcges_f32(a: f32, b: f32) u32 {
    return if (a >= b) 0xffffffff else 0;
}

test vcges_f32 {
    const a: f32 = 10;
    const b: f32 = 20;
    const expected: u32 = if (a >= b) 0xffffffff else 0;
    try common.testIntrinsic(.{ .func = vcges_f32, .expected = expected, .args = .{ a, b } });
}

/// Scalar compare >
pub inline fn vcgtd_s64(a: i64, b: i64) u64 {
    return if (a > b) 0xffffffffffffffff else 0;
}

test vcgtd_s64 {
    const a: i64 = 10;
    const b: i64 = 20;
    const expected: u64 = if (a > b) 0xffffffffffffffff else 0;
    try common.testIntrinsic(.{ .func = vcgtd_s64, .expected = expected, .args = .{ a, b } });
}

/// Scalar compare >
pub inline fn vcgtd_u64(a: u64, b: u64) u64 {
    return if (a > b) 0xffffffffffffffff else 0;
}

test vcgtd_u64 {
    const a: u64 = 10;
    const b: u64 = 20;
    const expected: u64 = if (a > b) 0xffffffffffffffff else 0;
    try common.testIntrinsic(.{ .func = vcgtd_u64, .expected = expected, .args = .{ a, b } });
}

/// Scalar compare >
pub inline fn vcgtd_f64(a: f64, b: f64) u64 {
    return if (a > b) 0xffffffffffffffff else 0;
}

test vcgtd_f64 {
    const a: f64 = 10;
    const b: f64 = 20;
    const expected: u64 = if (a > b) 0xffffffffffffffff else 0;
    try common.testIntrinsic(.{ .func = vcgtd_f64, .expected = expected, .args = .{ a, b } });
}

/// Scalar compare >
pub inline fn vcgts_f32(a: f32, b: f32) u32 {
    return if (a > b) 0xffffffff else 0;
}

test vcgts_f32 {
    const a: f32 = 10;
    const b: f32 = 20;
    const expected: u32 = if (a > b) 0xffffffff else 0;
    try common.testIntrinsic(.{ .func = vcgts_f32, .expected = expected, .args = .{ a, b } });
}

/// Scalar compare <=
pub inline fn vcled_s64(a: i64, b: i64) u64 {
    return if (a <= b) 0xffffffffffffffff else 0;
}

test vcled_s64 {
    const a: i64 = 10;
    const b: i64 = 20;
    const expected: u64 = if (a <= b) 0xffffffffffffffff else 0;
    try common.testIntrinsic(.{ .func = vcled_s64, .expected = expected, .args = .{ a, b } });
}

/// Scalar compare <=
pub inline fn vcled_u64(a: u64, b: u64) u64 {
    return if (a <= b) 0xffffffffffffffff else 0;
}

test vcled_u64 {
    const a: u64 = 10;
    const b: u64 = 20;
    const expected: u64 = if (a <= b) 0xffffffffffffffff else 0;
    try common.testIntrinsic(.{ .func = vcled_u64, .expected = expected, .args = .{ a, b } });
}

/// Scalar compare <=
pub inline fn vcled_f64(a: f64, b: f64) u64 {
    return if (a <= b) 0xffffffffffffffff else 0;
}

test vcled_f64 {
    const a: f64 = 10;
    const b: f64 = 20;
    const expected: u64 = if (a <= b) 0xffffffffffffffff else 0;
    try common.testIntrinsic(.{ .func = vcled_f64, .expected = expected, .args = .{ a, b } });
}

/// Scalar compare <=
pub inline fn vcles_f32(a: f32, b: f32) u32 {
    return if (a <= b) 0xffffffff else 0;
}

test vcles_f32 {
    const a: f32 = 10;
    const b: f32 = 20;
    const expected: u32 = if (a <= b) 0xffffffff else 0;
    try common.testIntrinsic(.{ .func = vcles_f32, .expected = expected, .args = .{ a, b } });
}

/// Scalar compare <
pub inline fn vcltd_s64(a: i64, b: i64) u64 {
    return if (a < b) 0xffffffffffffffff else 0;
}

test vcltd_s64 {
    const a: i64 = 10;
    const b: i64 = 20;
    const expected: u64 = if (a < b) 0xffffffffffffffff else 0;
    try common.testIntrinsic(.{ .func = vcltd_s64, .expected = expected, .args = .{ a, b } });
}

/// Scalar compare <
pub inline fn vcltd_u64(a: u64, b: u64) u64 {
    return if (a < b) 0xffffffffffffffff else 0;
}

test vcltd_u64 {
    const a: u64 = 10;
    const b: u64 = 20;
    const expected: u64 = if (a < b) 0xffffffffffffffff else 0;
    try common.testIntrinsic(.{ .func = vcltd_u64, .expected = expected, .args = .{ a, b } });
}

/// Scalar compare <
pub inline fn vcltd_f64(a: f64, b: f64) u64 {
    return if (a < b) 0xffffffffffffffff else 0;
}

test vcltd_f64 {
    const a: f64 = 10;
    const b: f64 = 20;
    const expected: u64 = if (a < b) 0xffffffffffffffff else 0;
    try common.testIntrinsic(.{ .func = vcltd_f64, .expected = expected, .args = .{ a, b } });
}

/// Scalar compare <
pub inline fn vclts_f32(a: f32, b: f32) u32 {
    return if (a < b) 0xffffffff else 0;
}

test vclts_f32 {
    const a: f32 = 10;
    const b: f32 = 20;
    const expected: u32 = if (a < b) 0xffffffff else 0;
    try common.testIntrinsic(.{ .func = vclts_f32, .expected = expected, .args = .{ a, b } });
}

/// Scalar compare against zero ==
pub inline fn vceqzd_s64(a: i64) u64 {
    return if (a == 0) 0xffffffffffffffff else 0;
}

test vceqzd_s64 {
    const a: i64 = 10;
    const expected: u64 = if (a == 0) 0xffffffffffffffff else 0;
    try common.testIntrinsic(.{ .func = vceqzd_s64, .expected = expected, .args = .{a} });
}

/// Scalar compare against zero ==
pub inline fn vceqzd_u64(a: u64) u64 {
    return if (a == 0) 0xffffffffffffffff else 0;
}

test vceqzd_u64 {
    const a: u64 = 10;
    const expected: u64 = if (a == 0) 0xffffffffffffffff else 0;
    try common.testIntrinsic(.{ .func = vceqzd_u64, .expected = expected, .args = .{a} });
}

/// Scalar compare against zero ==
pub inline fn vceqzd_f64(a: f64) u64 {
    return if (a == 0.0) 0xffffffffffffffff else 0;
}

test vceqzd_f64 {
    const a: f64 = 10;
    const expected: u64 = if (a == 0.0) 0xffffffffffffffff else 0;
    try common.testIntrinsic(.{ .func = vceqzd_f64, .expected = expected, .args = .{a} });
}

/// Scalar compare against zero ==
pub inline fn vceqzs_f32(a: f32) u32 {
    return if (a == 0.0) 0xffffffff else 0;
}

test vceqzs_f32 {
    const a: f32 = 10;
    const expected: u32 = if (a == 0.0) 0xffffffff else 0;
    try common.testIntrinsic(.{ .func = vceqzs_f32, .expected = expected, .args = .{a} });
}

/// Scalar compare against zero >=
pub inline fn vcgezd_s64(a: i64) u64 {
    return if (a >= 0) 0xffffffffffffffff else 0;
}

test vcgezd_s64 {
    const a: i64 = 10;
    const expected: u64 = if (a >= 0) 0xffffffffffffffff else 0;
    try common.testIntrinsic(.{ .func = vcgezd_s64, .expected = expected, .args = .{a} });
}

/// Scalar compare against zero >=
pub inline fn vcgezd_f64(a: f64) u64 {
    return if (a >= 0.0) 0xffffffffffffffff else 0;
}

test vcgezd_f64 {
    const a: f64 = 10;
    const expected: u64 = if (a >= 0.0) 0xffffffffffffffff else 0;
    try common.testIntrinsic(.{ .func = vcgezd_f64, .expected = expected, .args = .{a} });
}

/// Scalar compare against zero >=
pub inline fn vcgezs_f32(a: f32) u32 {
    return if (a >= 0.0) 0xffffffff else 0;
}

test vcgezs_f32 {
    const a: f32 = 10;
    const expected: u32 = if (a >= 0.0) 0xffffffff else 0;
    try common.testIntrinsic(.{ .func = vcgezs_f32, .expected = expected, .args = .{a} });
}

/// Scalar compare against zero >
pub inline fn vcgtzd_s64(a: i64) u64 {
    return if (a > 0) 0xffffffffffffffff else 0;
}

test vcgtzd_s64 {
    const a: i64 = 10;
    const expected: u64 = if (a > 0) 0xffffffffffffffff else 0;
    try common.testIntrinsic(.{ .func = vcgtzd_s64, .expected = expected, .args = .{a} });
}

/// Scalar compare against zero >
pub inline fn vcgtzd_f64(a: f64) u64 {
    return if (a > 0.0) 0xffffffffffffffff else 0;
}

test vcgtzd_f64 {
    const a: f64 = 10;
    const expected: u64 = if (a > 0.0) 0xffffffffffffffff else 0;
    try common.testIntrinsic(.{ .func = vcgtzd_f64, .expected = expected, .args = .{a} });
}

/// Scalar compare against zero >
pub inline fn vcgtzs_f32(a: f32) u32 {
    return if (a > 0.0) 0xffffffff else 0;
}

test vcgtzs_f32 {
    const a: f32 = 10;
    const expected: u32 = if (a > 0.0) 0xffffffff else 0;
    try common.testIntrinsic(.{ .func = vcgtzs_f32, .expected = expected, .args = .{a} });
}

/// Scalar compare against zero <=
pub inline fn vclezd_s64(a: i64) u64 {
    return if (a <= 0) 0xffffffffffffffff else 0;
}

test vclezd_s64 {
    const a: i64 = 10;
    const expected: u64 = if (a <= 0) 0xffffffffffffffff else 0;
    try common.testIntrinsic(.{ .func = vclezd_s64, .expected = expected, .args = .{a} });
}

/// Scalar compare against zero <=
pub inline fn vclezd_f64(a: f64) u64 {
    return if (a <= 0.0) 0xffffffffffffffff else 0;
}

test vclezd_f64 {
    const a: f64 = 10;
    const expected: u64 = if (a <= 0.0) 0xffffffffffffffff else 0;
    try common.testIntrinsic(.{ .func = vclezd_f64, .expected = expected, .args = .{a} });
}

/// Scalar compare against zero <=
pub inline fn vclezs_f32(a: f32) u32 {
    return if (a <= 0.0) 0xffffffff else 0;
}

test vclezs_f32 {
    const a: f32 = 10;
    const expected: u32 = if (a <= 0.0) 0xffffffff else 0;
    try common.testIntrinsic(.{ .func = vclezs_f32, .expected = expected, .args = .{a} });
}

/// Scalar compare against zero <
pub inline fn vcltzd_s64(a: i64) u64 {
    return if (a < 0) 0xffffffffffffffff else 0;
}

test vcltzd_s64 {
    const a: i64 = 10;
    const expected: u64 = if (a < 0) 0xffffffffffffffff else 0;
    try common.testIntrinsic(.{ .func = vcltzd_s64, .expected = expected, .args = .{a} });
}

/// Scalar compare against zero <
pub inline fn vcltzd_f64(a: f64) u64 {
    return if (a < 0.0) 0xffffffffffffffff else 0;
}

test vcltzd_f64 {
    const a: f64 = 10;
    const expected: u64 = if (a < 0.0) 0xffffffffffffffff else 0;
    try common.testIntrinsic(.{ .func = vcltzd_f64, .expected = expected, .args = .{a} });
}

/// Scalar compare against zero <
pub inline fn vcltzs_f32(a: f32) u32 {
    return if (a < 0.0) 0xffffffff else 0;
}

test vcltzs_f32 {
    const a: f32 = 10;
    const expected: u32 = if (a < 0.0) 0xffffffff else 0;
    try common.testIntrinsic(.{ .func = vcltzs_f32, .expected = expected, .args = .{a} });
}

/// Vector compare greater than or equal
pub inline fn vcge_f16(a: types.f16x4, b: types.f16x4) types.u16x4 {
    const comparison = a >= b;
    return @select(u16, comparison, @as(types.u16x4, @splat(0xffff)), @as(types.u16x4, @splat(0)));
}

test vcge_f16 {
    const a = types.f16x4{ 1.0, 2.0, 0.0, -1.0 };
    const b = types.f16x4{ 2.0, 1.0, 0.0, 0.0 };
    const expected = types.u16x4{ 0, 0xffff, 0xffff, 0 };
    try common.testIntrinsic(.{ .func = vcge_f16, .expected = expected, .args = .{ a, b } });
}

/// Vector compare greater than
pub inline fn vcgt_f16(a: types.f16x4, b: types.f16x4) types.u16x4 {
    const comparison = a > b;
    return @select(u16, comparison, @as(types.u16x4, @splat(0xffff)), @as(types.u16x4, @splat(0)));
}

test vcgt_f16 {
    const a = types.f16x4{ 1.0, 2.0, 0.0, -1.0 };
    const b = types.f16x4{ 2.0, 1.0, 0.0, 0.0 };
    const expected = types.u16x4{ 0, 0xffff, 0, 0 };
    try common.testIntrinsic(.{ .func = vcgt_f16, .expected = expected, .args = .{ a, b } });
}

/// Vector compare less than or equal
pub inline fn vcle_f16(a: types.f16x4, b: types.f16x4) types.u16x4 {
    const comparison = a <= b;
    return @select(u16, comparison, @as(types.u16x4, @splat(0xffff)), @as(types.u16x4, @splat(0)));
}

test vcle_f16 {
    const a = types.f16x4{ 1.0, 2.0, 0.0, -1.0 };
    const b = types.f16x4{ 2.0, 1.0, 0.0, 0.0 };
    const expected = types.u16x4{ 0xffff, 0, 0xffff, 0xffff };
    try common.testIntrinsic(.{ .func = vcle_f16, .expected = expected, .args = .{ a, b } });
}

/// Vector compare less than
pub inline fn vclt_f16(a: types.f16x4, b: types.f16x4) types.u16x4 {
    const comparison = a < b;
    return @select(u16, comparison, @as(types.u16x4, @splat(0xffff)), @as(types.u16x4, @splat(0)));
}

test vclt_f16 {
    const a = types.f16x4{ 1.0, 2.0, 0.0, -1.0 };
    const b = types.f16x4{ 2.0, 1.0, 0.0, 0.0 };
    const expected = types.u16x4{ 0xffff, 0, 0, 0xffff };
    try common.testIntrinsic(.{ .func = vclt_f16, .expected = expected, .args = .{ a, b } });
}

/// Vector compare absolute less than or equal
pub inline fn vcale_f64(a: types.f64x1, b: types.f64x1) types.u64x1 {
    const comparison = @abs(a) <= @abs(b);
    return @select(u64, comparison, @as(types.u64x1, @splat(0xffffffffffffffff)), @as(types.u64x1, @splat(0)));
}

test vcale_f64 {
    const a = types.f64x1{-2.0};
    const b = types.f64x1{3.0};
    const expected = types.u64x1{0xffffffffffffffff};
    try common.testIntrinsic(.{ .func = vcale_f64, .expected = expected, .args = .{ a, b } });
}

/// Vector compare absolute less than
pub inline fn vcalt_f64(a: types.f64x1, b: types.f64x1) types.u64x1 {
    const comparison = @abs(a) < @abs(b);
    return @select(u64, comparison, @as(types.u64x1, @splat(0xffffffffffffffff)), @as(types.u64x1, @splat(0)));
}

test vcalt_f64 {
    const a = types.f64x1{4.0};
    const b = types.f64x1{3.0};
    const expected = types.u64x1{0};
    try common.testIntrinsic(.{ .func = vcalt_f64, .expected = expected, .args = .{ a, b } });
}

/// Vector compare >
pub inline fn vcgtq_f16(a: types.f16x8, b: types.f16x8) types.u16x8 {
    const comparison = a > b;
    return @select(u16, comparison, @as(types.u16x8, @splat(0xffff)), @as(types.u16x8, @splat(0)));
}

test vcgtq_f16 {
    const a = types.f16x8{ 1.0, 2.0, 0.0, -1.0, 5.0, 6.0, 7.0, 8.0 };
    const b = types.f16x8{ 2.0, 1.0, 0.0, 0.0, 4.0, 6.0, 8.0, 9.0 };
    var expected: types.u16x8 = undefined;
    inline for (0..8) |i| {
        expected[i] = if (a[i] > b[i]) 0xffff else 0;
    }
    try common.testIntrinsic(.{ .func = vcgtq_f16, .expected = expected, .args = .{ a, b } });
}

/// Vector compare <=
pub inline fn vcleq_f16(a: types.f16x8, b: types.f16x8) types.u16x8 {
    const comparison = a <= b;
    return @select(u16, comparison, @as(types.u16x8, @splat(0xffff)), @as(types.u16x8, @splat(0)));
}

test vcleq_f16 {
    const a = types.f16x8{ 1.0, 2.0, 0.0, -1.0, 5.0, 6.0, 7.0, 8.0 };
    const b = types.f16x8{ 2.0, 1.0, 0.0, 0.0, 4.0, 6.0, 8.0, 9.0 };
    var expected: types.u16x8 = undefined;
    inline for (0..8) |i| {
        expected[i] = if (a[i] <= b[i]) 0xffff else 0;
    }
    try common.testIntrinsic(.{ .func = vcleq_f16, .expected = expected, .args = .{ a, b } });
}

/// Vector compare <
pub inline fn vcltq_f16(a: types.f16x8, b: types.f16x8) types.u16x8 {
    const comparison = a < b;
    return @select(u16, comparison, @as(types.u16x8, @splat(0xffff)), @as(types.u16x8, @splat(0)));
}

test vcltq_f16 {
    const a = types.f16x8{ 1.0, 2.0, 0.0, -1.0, 5.0, 6.0, 7.0, 8.0 };
    const b = types.f16x8{ 2.0, 1.0, 0.0, 0.0, 4.0, 6.0, 8.0, 9.0 };
    var expected: types.u16x8 = undefined;
    inline for (0..8) |i| {
        expected[i] = if (a[i] < b[i]) 0xffff else 0;
    }
    try common.testIntrinsic(.{ .func = vcltq_f16, .expected = expected, .args = .{ a, b } });
}

/// Vector compare against zero >=
pub inline fn vcgez_f16(a: types.f16x4) types.u16x4 {
    const comparison = a >= @as(types.f16x4, @splat(0.0));
    return @select(u16, comparison, @as(types.u16x4, @splat(0xffff)), @as(types.u16x4, @splat(0)));
}

test vcgez_f16 {
    const a = types.f16x4{ 1.0, -2.0, 0.0, 3.5 };
    var expected: types.u16x4 = undefined;
    inline for (0..4) |i| {
        expected[i] = if (a[i] >= 0.0) 0xffff else 0;
    }
    try common.testIntrinsic(.{ .func = vcgez_f16, .expected = expected, .args = .{a} });
}

/// Vector compare against zero >=
pub inline fn vcgezq_f16(a: types.f16x8) types.u16x8 {
    const comparison = a >= @as(types.f16x8, @splat(0.0));
    return @select(u16, comparison, @as(types.u16x8, @splat(0xffff)), @as(types.u16x8, @splat(0)));
}

test vcgezq_f16 {
    const a = types.f16x8{ 1.0, -2.0, 0.0, 3.5, -4.0, 5.0, -6.0, 0.0 };
    var expected: types.u16x8 = undefined;
    inline for (0..8) |i| {
        expected[i] = if (a[i] >= 0.0) 0xffff else 0;
    }
    try common.testIntrinsic(.{ .func = vcgezq_f16, .expected = expected, .args = .{a} });
}

/// Vector compare against zero >
pub inline fn vcgtz_f16(a: types.f16x4) types.u16x4 {
    const comparison = a > @as(types.f16x4, @splat(0.0));
    return @select(u16, comparison, @as(types.u16x4, @splat(0xffff)), @as(types.u16x4, @splat(0)));
}

test vcgtz_f16 {
    const a = types.f16x4{ 1.0, -2.0, 0.0, 3.5 };
    var expected: types.u16x4 = undefined;
    inline for (0..4) |i| {
        expected[i] = if (a[i] > 0.0) 0xffff else 0;
    }
    try common.testIntrinsic(.{ .func = vcgtz_f16, .expected = expected, .args = .{a} });
}

/// Vector compare against zero >
pub inline fn vcgtzq_f16(a: types.f16x8) types.u16x8 {
    const comparison = a > @as(types.f16x8, @splat(0.0));
    return @select(u16, comparison, @as(types.u16x8, @splat(0xffff)), @as(types.u16x8, @splat(0)));
}

test vcgtzq_f16 {
    const a = types.f16x8{ 1.0, -2.0, 0.0, 3.5, -4.0, 5.0, -6.0, 0.0 };
    var expected: types.u16x8 = undefined;
    inline for (0..8) |i| {
        expected[i] = if (a[i] > 0.0) 0xffff else 0;
    }
    try common.testIntrinsic(.{ .func = vcgtzq_f16, .expected = expected, .args = .{a} });
}

/// Vector compare against zero <=
pub inline fn vclez_f16(a: types.f16x4) types.u16x4 {
    const comparison = a <= @as(types.f16x4, @splat(0.0));
    return @select(u16, comparison, @as(types.u16x4, @splat(0xffff)), @as(types.u16x4, @splat(0)));
}

test vclez_f16 {
    const a = types.f16x4{ 1.0, -2.0, 0.0, 3.5 };
    var expected: types.u16x4 = undefined;
    inline for (0..4) |i| {
        expected[i] = if (a[i] <= 0.0) 0xffff else 0;
    }
    try common.testIntrinsic(.{ .func = vclez_f16, .expected = expected, .args = .{a} });
}

/// Vector compare against zero <=
pub inline fn vclezq_f16(a: types.f16x8) types.u16x8 {
    const comparison = a <= @as(types.f16x8, @splat(0.0));
    return @select(u16, comparison, @as(types.u16x8, @splat(0xffff)), @as(types.u16x8, @splat(0)));
}

test vclezq_f16 {
    const a = types.f16x8{ 1.0, -2.0, 0.0, 3.5, -4.0, 5.0, -6.0, 0.0 };
    var expected: types.u16x8 = undefined;
    inline for (0..8) |i| {
        expected[i] = if (a[i] <= 0.0) 0xffff else 0;
    }
    try common.testIntrinsic(.{ .func = vclezq_f16, .expected = expected, .args = .{a} });
}

/// Vector compare against zero <
pub inline fn vcltz_f16(a: types.f16x4) types.u16x4 {
    const comparison = a < @as(types.f16x4, @splat(0.0));
    return @select(u16, comparison, @as(types.u16x4, @splat(0xffff)), @as(types.u16x4, @splat(0)));
}

test vcltz_f16 {
    const a = types.f16x4{ 1.0, -2.0, 0.0, 3.5 };
    var expected: types.u16x4 = undefined;
    inline for (0..4) |i| {
        expected[i] = if (a[i] < 0.0) 0xffff else 0;
    }
    try common.testIntrinsic(.{ .func = vcltz_f16, .expected = expected, .args = .{a} });
}

/// Vector compare against zero <
pub inline fn vcltzq_f16(a: types.f16x8) types.u16x8 {
    const comparison = a < @as(types.f16x8, @splat(0.0));
    return @select(u16, comparison, @as(types.u16x8, @splat(0xffff)), @as(types.u16x8, @splat(0)));
}

test vcltzq_f16 {
    const a = types.f16x8{ 1.0, -2.0, 0.0, 3.5, -4.0, 5.0, -6.0, 0.0 };
    var expected: types.u16x8 = undefined;
    inline for (0..8) |i| {
        expected[i] = if (a[i] < 0.0) 0xffff else 0;
    }
    try common.testIntrinsic(.{ .func = vcltzq_f16, .expected = expected, .args = .{a} });
}

/// Scalar test bitwise: returns all-ones if (a & b) != 0, else 0
pub inline fn vtstd_s64(a: i64, b: i64) u64 {
    return if ((a & b) != 0) 0xffffffffffffffff else 0;
}

test vtstd_s64 {
    const a: i64 = 0x55;
    const b: i64 = 0x01;
    const expected: u64 = 0xffffffffffffffff;
    try common.testIntrinsic(.{ .func = vtstd_s64, .expected = expected, .args = .{ a, b } });
}

/// Scalar test bitwise: returns all-ones if (a & b) != 0, else 0
pub inline fn vtstd_u64(a: u64, b: u64) u64 {
    return if ((a & b) != 0) 0xffffffffffffffff else 0;
}

test vtstd_u64 {
    const a: u64 = 0x55;
    const b: u64 = 0x01;
    const expected: u64 = 0xffffffffffffffff;
    try common.testIntrinsic(.{ .func = vtstd_u64, .expected = expected, .args = .{ a, b } });
}
