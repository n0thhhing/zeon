const std = @import("std");
const assert = std.debug.assert;
const expectEqual = std.testing.expectEqual;

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

inline fn VectorArray(comptime T: type, comptime length: usize) type {
    return struct {
        val: [length]T,
    };
}

pub const i8x8x2 = VectorArray(i8x8, 2);
pub const i8x16x2 = VectorArray(i8x16, 2);
pub const i16x4x2 = VectorArray(i16x4, 2);
pub const i16x8x2 = VectorArray(i16x8, 2);
pub const i32x2x2 = VectorArray(i32x2, 2);
pub const i32x4x2 = VectorArray(i32x4, 2);
pub const i64x1x2 = VectorArray(i64x1, 2);
pub const i64x2x2 = VectorArray(i64x2, 2);

pub const u8x8x2 = VectorArray(u8x8, 2);
pub const u8x16x2 = VectorArray(u8x16, 2);
pub const u16x4x2 = VectorArray(u16x4, 2);
pub const u16x8x2 = VectorArray(u16x8, 2);
pub const u32x2x2 = VectorArray(u32x2, 2);
pub const u32x4x2 = VectorArray(u32x4, 2);
pub const u64x1x2 = VectorArray(u64x1, 2);
pub const u64x2x2 = VectorArray(u64x2, 2);

pub const f16x4x2 = VectorArray(f16x4, 2);
pub const f16x8x2 = VectorArray(f16x8, 2);
pub const f32x2x2 = VectorArray(f32x2, 2);
pub const f32x4x2 = VectorArray(f32x4, 2);
pub const f64x1x2 = VectorArray(f64x1, 2);
pub const f64x2x2 = VectorArray(f64x2, 2);

pub const p8x8x2 = VectorArray(p8x8, 2);
pub const p8x16x2 = VectorArray(p8x16, 2);
pub const p16x4x2 = VectorArray(p16x4, 2);
pub const p16x8x2 = VectorArray(p16x8, 2);
pub const p64x1x2 = VectorArray(p64x1, 2);
pub const p64x2x2 = VectorArray(p64x2, 2);

pub const i8x8x3 = VectorArray(i8x8, 3);
pub const i8x16x3 = VectorArray(i8x16, 3);
pub const i16x4x3 = VectorArray(i16x4, 3);
pub const i16x8x3 = VectorArray(i16x8, 3);
pub const i32x2x3 = VectorArray(i32x2, 3);
pub const i32x4x3 = VectorArray(i32x4, 3);
pub const i64x1x3 = VectorArray(i64x1, 3);
pub const i64x2x3 = VectorArray(i64x2, 3);

pub const u8x8x3 = VectorArray(u8x8, 3);
pub const u8x16x3 = VectorArray(u8x16, 3);
pub const u16x4x3 = VectorArray(u16x4, 3);
pub const u16x8x3 = VectorArray(u16x8, 3);
pub const u32x2x3 = VectorArray(u32x2, 3);
pub const u32x4x3 = VectorArray(u32x4, 3);
pub const u64x1x3 = VectorArray(u64x1, 3);
pub const u64x2x3 = VectorArray(u64x2, 3);

pub const f16x4x3 = VectorArray(f16x4, 3);
pub const f16x8x3 = VectorArray(f16x8, 3);
pub const f32x2x3 = VectorArray(f32x2, 3);
pub const f32x4x3 = VectorArray(f32x4, 3);
pub const f64x1x3 = VectorArray(f64x1, 3);
pub const f64x2x3 = VectorArray(f64x2, 3);

pub const p8x8x3 = VectorArray(p8x8, 3);
pub const p8x16x3 = VectorArray(p8x16, 3);
pub const p16x4x3 = VectorArray(p16x4, 3);
pub const p16x8x3 = VectorArray(p16x8, 3);
pub const p64x1x3 = VectorArray(p64x1, 3);
pub const p64x2x3 = VectorArray(p64x2, 3);

pub const i8x8x4 = VectorArray(i8x8, 4);
pub const i8x16x4 = VectorArray(i8x16, 4);
pub const i16x4x4 = VectorArray(i16x4, 4);
pub const i16x8x4 = VectorArray(i16x8, 4);
pub const i32x2x4 = VectorArray(i32x2, 4);
pub const i32x4x4 = VectorArray(i32x4, 4);
pub const i64x1x4 = VectorArray(i64x1, 4);
pub const i64x2x4 = VectorArray(i64x2, 4);

pub const u8x8x4 = VectorArray(u8x8, 4);
pub const u8x16x4 = VectorArray(u8x16, 4);
pub const u16x4x4 = VectorArray(u16x4, 4);
pub const u16x8x4 = VectorArray(u16x8, 4);
pub const u32x2x4 = VectorArray(u32x2, 4);
pub const u32x4x4 = VectorArray(u32x4, 4);
pub const u64x1x4 = VectorArray(u64x1, 4);
pub const u64x2x4 = VectorArray(u64x2, 4);

pub const f16x4x4 = VectorArray(f16x4, 4);
pub const f16x8x4 = VectorArray(f16x8, 4);
pub const f32x2x4 = VectorArray(f32x2, 4);
pub const f32x4x4 = VectorArray(f32x4, 4);
pub const f64x1x4 = VectorArray(f64x1, 4);
pub const f64x2x4 = VectorArray(f64x2, 4);

pub const p8x8x4 = VectorArray(p8x8, 4);
pub const p8x16x4 = VectorArray(p8x16, 4);
pub const p16x4x4 = VectorArray(p16x4, 4);
pub const p16x8x4 = VectorArray(p16x8, 4);
pub const p64x1x4 = VectorArray(p64x1, 4);
pub const p64x2x4 = VectorArray(p64x2, 4);

inline fn PromoteVector(comptime T: type) type {
    var type_info = @typeInfo(T);
    comptime assert(type_info == .Vector);
    var child_info = @typeInfo(std.meta.Child(T));
    child_info.Int.bits *= 2;
    type_info.Vector.child = @Type(child_info);
    return @Type(type_info);
}

/// Absolute difference(wrapping) between arguments
inline fn abd(a: anytype, b: anytype) @TypeOf(a, b) {
    const T = @TypeOf(a, b);
    const Child = std.meta.Child(T);
    const type_info = @typeInfo(Child);
    if (type_info == .Int) {
        switch (type_info.Int.signedness) {
            inline .unsigned => {
                // Since unsigned numbers cannot be negative, we subtract the
                // smaller elemant from the larger in order to prevent overflows
                // when calculating the difference, saving us the trouble of
                // casting to a larger signed type when subtracting.
                const max: T = @max(a, b);
                const min: T = @min(a, b);
                return @abs(max - min);
            },
            inline .signed => {
                const P = comptime PromoteVector(T);
                return @truncate(
                    @as(
                        P,
                        @bitCast(@abs(@as(P, a) -% @as(P, b))),
                    ),
                );
            },
        }
    } else {
        // Floats dont have modular subtraction,
        // so we just assume there wont be an overflow here.
        return @abs(a - b);
    }
}

test abd {
    const i8x1 = @Vector(1, i8);
    const i8x2 = @Vector(2, i8);
    const u8x1 = @Vector(1, u8);
    const f32x1 = @Vector(1, f32);

    const a1: i8x1 = .{127};
    const b1: i8x1 = .{-1};
    try expectEqual(i8x1{-128}, abd(a1, b1));

    const a2: u8x1 = .{0};
    const b2: u8x1 = .{2};
    try expectEqual(u8x1{2}, abd(a2, b2));

    const a3: i8x1 = .{-128};
    const b3: i8x1 = .{127};
    try expectEqual(i8x1{-1}, abd(a3, b3));

    const a4: f32x1 = .{3.4028235e38};
    const b4: f32x1 = .{-1};
    try expectEqual(f32x1{std.math.floatMax(f32)}, abd(a4, b4));

    const a5: i8x1 = .{127};
    const b5: i8x1 = .{-3};
    try expectEqual(i8x1{-126}, abd(a5, b5));

    const a6: i8x2 = .{ -65, -75 };
    const b6: i8x2 = .{ 65, 75 };
    try expectEqual(i8x2{ -126, -106 }, abd(a6, b6));
}

//// Get high elements of a i8x16 vector
pub inline fn vget_high_s8(vec: i8x16) i8x8 {
    return @shuffle(
        i8,
        vec,
        undefined,
        i8x8{ 8, 9, 10, 11, 12, 13, 14, 15 },
    );
}

//// Get high elements of a i16x8 vector
pub inline fn vget_high_s16(vec: i16x8) i16x4 {
    return @shuffle(
        i16,
        vec,
        undefined,
        i16x4{ 4, 5, 6, 7 },
    );
}

//// Get high elements of a i32x4 vector
pub inline fn vget_high_s32(vec: i32x4) i32x2 {
    return @shuffle(
        i32,
        vec,
        undefined,
        i32x2{ 2, 3 },
    );
}

//// Get high elements of a i64x2 vector
pub inline fn vget_high_s64(vec: i64x2) i64x1 {
    return @shuffle(
        i64,
        vec,
        undefined,
        i64x1{1},
    );
}

//// Get high elements of a f16x8 vector
pub inline fn vget_high_f16(vec: f16x8) f16x4 {
    return @shuffle(
        f16,
        vec,
        undefined,
        f16x4{ 4, 5, 6, 7 },
    );
}

//// Get high elements of a f32x4 vector
pub inline fn vget_high_f32(vec: f32x4) f32x2 {
    return @shuffle(
        f32,
        vec,
        undefined,
        f32x2{ 2, 3 },
    );
}

//// Get high elements of a f64x2 vector
pub inline fn vget_high_f64(vec: f64x2) f64x1 {
    return @shuffle(
        f64,
        vec,
        undefined,
        f64x1{1},
    );
}

//// Get high elements of a u8x16 vector
pub inline fn vget_high_u8(vec: u8x16) u8x8 {
    return @shuffle(
        u8,
        vec,
        undefined,
        u8x8{ 8, 9, 10, 11, 12, 13, 14, 15 },
    );
}

//// Get high elements of a u16x8 vector
pub inline fn vget_high_u16(vec: u16x8) u16x4 {
    return @shuffle(
        u16,
        vec,
        undefined,
        u16x4{ 4, 5, 6, 7 },
    );
}

//// Get high elements of a u32x4 vector
pub inline fn vget_high_u32(vec: u32x4) u32x2 {
    return @shuffle(
        u32,
        vec,
        undefined,
        u32x2{ 2, 3 },
    );
}

//// Get high elements of a u64x2 vector
pub inline fn vget_high_u64(vec: u64x2) u64x1 {
    return @shuffle(
        u64,
        vec,
        undefined,
        u64x1{1},
    );
}

//// Get high elements of a p8x16 vector
pub inline fn vget_high_p8(vec: p8x16) p8x8 {
    return @shuffle(
        u8,
        vec,
        undefined,
        p8x8{ 8, 9, 10, 11, 12, 13, 14, 15 },
    );
}

//// Get high elements of a u16x8 vector
pub inline fn vget_high_p16(vec: p16x8) p16x4 {
    return @shuffle(
        u16,
        vec,
        undefined,
        p16x4{ 4, 5, 6, 7 },
    );
}

/// Get low elements of a i8x16 vector
pub inline fn vget_low_s8(vec: i8x16) i8x8 {
    return @shuffle(
        i8,
        vec,
        undefined,
        i8x8{ 0, 1, 2, 3, 4, 5, 6, 7 },
    );
}

/// Get low elements of a i16x4 vector
pub inline fn vget_low_s16(vec: i16x8) i16x4 {
    return @shuffle(
        i16,
        vec,
        undefined,
        i16x4{ 0, 1, 2, 3 },
    );
}

/// Get low elements of a i32x4 vector
pub inline fn vget_low_s32(vec: i32x4) i32x2 {
    return @shuffle(
        i32,
        vec,
        undefined,
        i32x2{ 0, 1 },
    );
}

/// Get low elements of a i64x2 vector
pub inline fn vget_low_s64(vec: i64x2) i64x1 {
    return @shuffle(
        i64,
        vec,
        undefined,
        i64x1{0},
    );
}

/// Get low elements of a u8x16 vector
pub inline fn vget_low_u8(vec: u8x16) u8x8 {
    return @shuffle(
        u8,
        vec,
        undefined,
        u8x8{ 0, 1, 2, 3, 4, 5, 6, 7 },
    );
}

/// Get low elements of a u16x8 vector
pub inline fn vget_low_u16(vec: u16x8) u16x4 {
    return @shuffle(
        u16,
        vec,
        undefined,
        u16x4{ 0, 1, 2, 3 },
    );
}

/// Get low elements of a u32x4 vector
pub inline fn vget_low_u32(vec: u32x4) u32x2 {
    return @shuffle(
        u32,
        vec,
        undefined,
        u32x2{ 0, 1 },
    );
}

/// Get low elements of a u64x2 vector
pub inline fn vget_low_u64(vec: u64x2) u64x1 {
    return @shuffle(
        u64,
        vec,
        undefined,
        u64x1{0},
    );
}

/// Get low elements of a p8x16 vector
pub inline fn vget_low_p8(vec: p8x16) p8x8 {
    return @shuffle(
        p8,
        vec,
        undefined,
        p8x8{ 0, 1, 2, 3, 4, 5, 6, 7 },
    );
}

/// Get low elements of a p16x8 vector
pub inline fn vget_low_p16(vec: p16x8) p16x4 {
    return @shuffle(
        p16,
        vec,
        undefined,
        p16x4{ 0, 1, 2, 3 },
    );
}

/// Vector long move
pub inline fn vmovl_s8(a: i8x8) i16x8 {
    return @intCast(a);
}

test vmovl_s8 {
    const v: i8x8 = .{ 0, -1, -2, -3, -4, -5, -6, -7 };
    try expectEqual(i16x8{ 0, -1, -2, -3, -4, -5, -6, -7 }, vmovl_s8(v));
}

/// Vector long move
pub inline fn vmovl_s16(a: i16x4) i32x4 {
    return @intCast(a);
}

test vmovl_s16 {
    const v: i16x4 = .{ 0, -1, -2, -3 };
    try expectEqual(@as(i32x4, .{ 0, -1, -2, -3 }), vmovl_s16(v));
}

/// Vector long move
pub inline fn vmovl_s32(a: i32x2) i64x2 {
    return @intCast(a);
}

test vmovl_s32 {
    const v: i32x2 = .{ 0, -1 };
    try expectEqual(@as(i32x2, .{ 0, -1 }), vmovl_s32(v));
}

/// Vector long move
pub inline fn vmovl_u8(a: u8x8) u16x8 {
    return @intCast(a);
}

test vmovl_u8 {
    const v: u8x8 = .{ 0, 1, 2, 3, 4, 5, 6, 7 };
    try expectEqual(@as(u16x8, .{ 0, 1, 2, 3, 4, 5, 6, 7 }), vmovl_u8(v));
}

/// Vector long move
pub inline fn vmovl_u16(a: u16x4) u32x4 {
    return @intCast(a);
}

test vmovl_u16 {
    const v: u16x4 = .{ 0, 1, 2, 3 };
    try expectEqual(@as(u32x4, .{ 0, 1, 2, 3 }), vmovl_u16(v));
}

/// Vector long move
pub inline fn vmovl_u32(a: u32x2) u64x2 {
    return @intCast(a);
}

test vmovl_u32 {
    const v: u32x2 = .{ 0, 1 };
    try expectEqual(@as(u32x2, .{ 0, 1 }), vmovl_u32(v));
}

/// Vector long move
pub inline fn vmovl_high_s8(a: i8x16) i16x8 {
    return vmovl_s8(vget_high_s8(a));
}

test vmovl_high_s8 {
    const v: i8x16 = .{ 0, -1, -2, -3, -4, -5, -6, -7, 0, -1, -2, -3, -4, -5, -6, -7 };
    try expectEqual(i16x8{ 0, -1, -2, -3, -4, -5, -6, -7 }, vmovl_high_s8(v));
}

/// Vector long move
pub inline fn vmovl_high_s16(a: i16x8) i32x4 {
    return vmovl_s16(vget_high_s16(a));
}

test vmovl_high_s16 {
    const v: i16x8 = .{ 0, -1, -2, -3, 0, -1, -2, -3 };
    try expectEqual(@as(i32x4, .{ 0, -1, -2, -3 }), vmovl_high_s16(v));
}

/// Vector long move
pub inline fn vmovl_high_s32(a: i32x4) i64x2 {
    return vmovl_s32(vget_high_s32(a));
}

test vmovl_high_s32 {
    const v: i32x4 = .{ 0, -1, 0, -1 };
    try expectEqual(@as(i32x2, .{ 0, -1 }), vmovl_high_s32(v));
}

/// Vector long move
pub inline fn vmovl_high_u8(a: u8x16) u16x8 {
    return vmovl_u8(vget_high_u8(a));
}

test vmovl_high_u8 {
    const v: u8x16 = .{ 0, 1, 2, 3, 4, 5, 6, 7, 0, 1, 2, 3, 4, 5, 6, 7 };
    try expectEqual(@as(u16x8, .{ 0, 1, 2, 3, 4, 5, 6, 7 }), vmovl_high_u8(v));
}

/// Vector long move
pub inline fn vmovl_high_u16(a: u16x8) u32x4 {
    return vmovl_u16(vget_high_u16(a));
}

test vmovl_high_u16 {
    const v: u16x8 = .{ 0, 1, 2, 3, 0, 1, 2, 3 };
    try expectEqual(@as(u32x4, .{ 0, 1, 2, 3 }), vmovl_high_u16(v));
}

/// Vector long move
pub inline fn vmovl_high_u32(a: u32x4) u64x2 {
    return vmovl_u32(vget_high_u32(a));
}

test vmovl_high_u32 {
    const v: u32x4 = .{ 0, 1, 0, 1 };
    try expectEqual(@as(u32x2, .{ 0, 1 }), vmovl_high_u32(v));
}

/// Signed multiply long
pub inline fn vmull_s8(a: i8x8, b: i8x8) i16x8 {
    return @as(i16x8, a) * @as(i16x8, b);
}

test vmull_s8 {
    const a: i8x8 = .{ 0, 0, 0, 0, 0, 0, 0, 127 };
    const b: i8x8 = @splat(2);

    try expectEqual(i16x8{ 0, 0, 0, 0, 0, 0, 0, 254 }, vmull_s8(a, b));
}

/// Signed multiply long
pub inline fn vmull_s16(a: i16x4, b: i16x4) i32x4 {
    return @as(i32x4, a) * @as(i32x4, b);
}

test vmull_s16 {
    const a: i16x4 = .{ 0, -1, -2, -3 };
    const b: i16x4 = @splat(5);

    try expectEqual(i32x4{ 0, -1 * 5, -2 * 5, -3 * 5 }, vmull_s16(a, b));
}

/// Signed multiply long
pub inline fn vmull_s32(a: i32x2, b: i32x2) i64x2 {
    return @as(i64x2, a) * @as(i64x2, b);
}

test vmull_s32 {
    const a: i32x2 = .{ 0, -1 };
    const b: i32x2 = @splat(5);

    try expectEqual(i32x2{ 0, -1 * 5 }, vmull_s32(a, b));
}

/// Unsigned multiply long
pub inline fn vmull_u8(a: u8x8, b: u8x8) u16x8 {
    return @as(u16x8, a) * @as(u16x8, b);
}

test vmull_u8 {
    const a: u8x8 = .{ 0, 1, 2, 3, 4, 5, 6, 7 };
    const b: u8x8 = @splat(5);

    try expectEqual(u16x8{ 0, 1 * 5, 2 * 5, 3 * 5, 4 * 5, 5 * 5, 6 * 5, 7 * 5 }, vmull_u8(a, b));
}

/// Unsigned multiply long
pub inline fn vmull_u16(a: u16x4, b: u16x4) u32x4 {
    return @as(u32x4, a) * @as(u32x4, b);
}

test vmull_u16 {
    const a: u16x4 = .{ 0, 1, 2, 3 };
    const b: u16x4 = @splat(5);

    try expectEqual(u32x4{ 0, 1 * 5, 2 * 5, 3 * 5 }, vmull_u16(a, b));
}

/// Unsigned multiply long
pub inline fn vmull_u32(a: u32x2, b: u32x2) u64x2 {
    return @as(u64x2, a) * @as(u64x2, b);
}

test vmull_u32 {
    const a: u32x2 = .{ 0, 1 };
    const b: u32x2 = @splat(5);

    try expectEqual(u64x2{ 0, 1 * 5 }, vmull_u32(a, b));
}

/// Signed multiply long
pub inline fn vmull_high_s8(a: i8x16, b: i8x16) i16x8 {
    return vmull_s8(vget_high_s8(a), vget_high_s8(b));
}

test vmull_high_s8 {
    const a: i8x16 = .{ 0, 0, 0, 0, 0, 0, 0, 127, 0, 0, 0, 0, 0, 0, 0, 127 };
    const b: i8x16 = @splat(2);

    try expectEqual(i16x8{ 0, 0, 0, 0, 0, 0, 0, 254 }, vmull_high_s8(a, b));
}

/// Signed multiply long
pub inline fn vmull_high_s16(a: i16x8, b: i16x8) i32x4 {
    return vmull_s16(vget_high_s16(a), vget_high_s16(b));
}

test vmull_high_s16 {
    const a: i16x8 = .{ 0, -1, -2, -3, 0, -1, -2, -3 };
    const b: i16x8 = @splat(5);

    try expectEqual(i32x4{ 0, -1 * 5, -2 * 5, -3 * 5 }, vmull_high_s16(a, b));
}

/// Signed multiply long
pub inline fn vmull_high_s32(a: i32x4, b: i32x4) i64x2 {
    return vmull_s32(vget_high_s32(a), vget_high_s32(b));
}

test vmull_high_s32 {
    const a: i32x4 = .{ 0, -1, -2, -3 };
    const b: i32x4 = @splat(5);

    try expectEqual(i64x2{ -2 * 5, -3 * 5 }, vmull_high_s32(a, b));
}

/// Unsigned multiply long
pub inline fn vmull_high_u8(a: u8x16, b: u8x16) u16x8 {
    return vmull_s8(vget_high_u8(a), vget_high_s8(b));
}

test vmull_high_u8 {
    const a: u8x16 = .{ 0, 0, 0, 0, 0, 0, 0, 127, 0, 0, 0, 0, 0, 0, 0, 127 };
    const b: u8x16 = @splat(2);

    try expectEqual(u16x8{ 0, 0, 0, 0, 0, 0, 0, 254 }, vmull_high_u8(a, b));
}

/// Unsigned multiply long
pub inline fn vmull_high_u16(a: u16x8, b: u16x8) u32x4 {
    return vmull_u16(vget_high_u16(a), vget_high_u16(b));
}

test vmull_high_u16 {
    const a: u16x8 = .{ 0, 1, 2, 3, 0, 1, 2, 3 };
    const b: u16x8 = @splat(5);

    try expectEqual(u32x4{ 0, 1 * 5, 2 * 5, 3 * 5 }, vmull_high_u16(a, b));
}

/// Unsigned multiply long
pub inline fn vmull_high_u32(a: u32x4, b: u32x4) u64x2 {
    return vmull_u32(vget_high_u32(a), vget_high_u32(b));
}

test vmull_high_u32 {
    const a: u32x4 = .{ 0, 1, 2, 3 };
    const b: u32x4 = @splat(5);

    try expectEqual(u32x2{ 2 * 5, 3 * 5 }, vmull_high_u32(a, b));
}

/// Absolute difference between two i8x8 vectors
pub inline fn vabd_s8(a: i8x8, b: i8x8) i8x8 {
    return abd(a, b);
}

test vabd_s8 {
    const a: i8x8 = .{ 1, 2, 3, 4, 5, 6, 7, 8 };
    const b: i8x8 = .{ 16, 15, 14, 13, 12, 11, 10, 9 };

    const expected: i8x8 = .{ 15, 13, 11, 9, 7, 5, 3, 1 };

    try expectEqual(expected, vabd_s8(a, b));
}

/// Absolute difference between two i16x4 vectors
pub inline fn vabd_s16(a: i16x4, b: i16x4) i16x4 {
    return abd(a, b);
}

test vabd_s16 {
    const a: i16x4 = .{ 1, 2, 3, 4 };
    const b: i16x4 = .{ 16, 15, 14, 13 };

    const expected: i16x4 = .{ 15, 13, 11, 9 };

    try expectEqual(expected, vabd_s16(a, b));
}

/// Absolute difference between two i32x2 vectors
pub inline fn vabd_s32(a: i32x2, b: i32x2) i32x2 {
    return abd(a, b);
}

test vabd_s32 {
    const a: i32x2 = .{ 1, 2 };
    const b: i32x2 = .{ 16, 15 };

    const expected: i32x2 = .{ 15, 13 };

    try expectEqual(expected, vabd_s32(a, b));
}

/// Absolute difference between two u8x8 vectors
pub inline fn vabd_u8(a: u8x8, b: u8x8) u8x8 {
    return abd(a, b);
}

test vabd_u8 {
    const a: u8x8 = .{ 1, 2, 3, 4, 5, 6, 7, 8 };
    const b: u8x8 = .{ 16, 15, 14, 13, 12, 11, 10, 9 };
    const expected: u8x8 = .{ 15, 13, 11, 9, 7, 5, 3, 1 };
    try expectEqual(expected, vabd_u8(a, b));

    const a2: u8x8 = .{ 10, 10, 10, 10, 10, 10, 10, 10 };
    const b2: u8x8 = .{ 10, 10, 10, 10, 10, 10, 10, 10 };
    const expected2: u8x8 = .{ 0, 0, 0, 0, 0, 0, 0, 0 };
    try expectEqual(expected2, vabd_u8(a2, b2));

    const a3: u8x8 = .{ 16, 15, 14, 13, 12, 11, 10, 9 };
    const b3: u8x8 = .{ 1, 2, 3, 4, 5, 6, 7, 8 };
    const expected3: u8x8 = .{ 15, 13, 11, 9, 7, 5, 3, 1 };
    try expectEqual(expected3, vabd_u8(a3, b3));

    const a4: u8x8 = .{ 0, 255, 128, 64, 32, 16, 8, 4 };
    const b4: u8x8 = .{ 255, 0, 64, 128, 16, 32, 4, 8 };
    const expected4: u8x8 = .{ 255, 255, 64, 64, 16, 16, 4, 4 };
    try expectEqual(expected4, vabd_u8(a4, b4));

    const a5: u8x8 = .{ 0, 0, 0, 0, 0, 0, 0, 0 };
    const b5: u8x8 = .{ 0, 0, 0, 0, 0, 0, 0, 0 };
    const expected5: u8x8 = .{ 0, 0, 0, 0, 0, 0, 0, 0 };
    try expectEqual(expected5, vabd_u8(a5, b5));
}

/// Absolute difference between two u16x4 vectors
pub inline fn vabd_u16(a: u16x4, b: u16x4) u16x4 {
    return abd(a, b);
}

test vabd_u16 {
    const a: u16x4 = .{ 1, 2, 3, 4 };
    const b: u16x4 = .{ 16, 15, 14, 13 };

    const expected: u16x4 = .{ 15, 13, 11, 9 };

    try expectEqual(expected, vabd_u16(a, b));
}

/// Absolute difference between two u32x2 vectors
pub inline fn vabd_u32(a: u32x2, b: u32x2) u32x2 {
    return abd(a, b);
}

test vabd_u32 {
    const a: u32x2 = .{ 1, 2 };
    const b: u32x2 = .{ 16, 15 };

    const expected: u32x2 = .{ 15, 13 };

    try expectEqual(expected, vabd_u32(a, b));
}

/// Absolute difference between two f32x2 vectors
pub inline fn vabd_f32(a: f32x2, b: f32x2) f32x2 {
    return abd(a, b);
}

test vabd_f32 {
    const a: f32x2 = .{ 0.00, 0.00 };
    const b: f32x2 = .{ 0.19, 0.15 };

    const expected: f32x2 = .{ @abs(0.00 - 0.19), @abs(0.00 - 0.15) };

    try expectEqual(expected, vabd_f32(a, b));
}

/// Absolute difference between two f64x1 vectors
pub inline fn vabd_f64(a: f64x1, b: f64x1) f64x1 {
    return abd(a, b);
}

test vabd_f64 {
    const a: f64x1 = .{0.01};
    const b: f64x1 = .{0.16};

    const expected: f64x1 = .{0.15};

    try expectEqual(expected, vabd_f64(a, b));
}

/// signed absolute difference and accumulate (128-bit)
pub inline fn vabdq_s8(a: i8x16, b: i8x16) i8x16 {
    return abd(a, b);
}

test vabdq_s8 {
    const a: i8x16 = .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 };
    const b: i8x16 = .{ 16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1 };

    const expected: i8x16 = .{ 15, 13, 11, 9, 7, 5, 3, 1, 1, 3, 5, 7, 9, 11, 13, 15 };

    try expectEqual(expected, vabdq_s8(a, b));
}

/// signed absolute difference and accumulate (128-bit)
pub inline fn vabdq_s16(a: i16x8, b: i16x8) i16x8 {
    return abd(a, b);
}

test vabdq_s16 {
    const a: i16x8 = .{ 1, 2, 3, 4, 5, 6, 7, 8 };
    const b: i16x8 = .{ 16, 15, 14, 13, 12, 11, 10, 9 };

    const expected: i16x8 = .{ 15, 13, 11, 9, 7, 5, 3, 1 };

    try expectEqual(expected, vabdq_s16(a, b));
}

/// signed absolute difference and accumulate (128-bit)
pub inline fn vabdq_s32(a: i32x4, b: i32x4) i32x4 {
    return abd(a, b);
}

test vabdq_s32 {
    const a: i32x4 = .{ 1, 2, 3, 4 };
    const b: i32x4 = .{ 16, 15, 14, 13 };

    const expected: i32x4 = .{ 15, 13, 11, 9 };

    try expectEqual(expected, vabdq_s32(a, b));
}

/// signed absolute difference and accumulate (128-bit)
pub inline fn vabdq_u8(a: u8x16, b: u8x16) u8x16 {
    return abd(a, b);
}

test vabdq_u8 {
    const a: u8x16 = .{ 1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8 };
    const b: u8x16 = .{ 16, 15, 14, 13, 12, 11, 10, 9, 16, 15, 14, 13, 12, 11, 10, 9 };
    const expected: u8x16 = .{ 15, 13, 11, 9, 7, 5, 3, 1, 15, 13, 11, 9, 7, 5, 3, 1 };
    try expectEqual(expected, vabdq_u8(a, b));

    const a2: u8x16 = .{ 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 };
    const b2: u8x16 = .{ 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 };
    const expected2: u8x16 = .{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
    try expectEqual(expected2, vabdq_u8(a2, b2));

    const a3: u8x16 = .{ 16, 15, 14, 13, 12, 11, 10, 9, 16, 15, 14, 13, 12, 11, 10, 9 };
    const b3: u8x16 = .{ 1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8 };
    const expected3: u8x16 = .{ 15, 13, 11, 9, 7, 5, 3, 1, 15, 13, 11, 9, 7, 5, 3, 1 };
    try expectEqual(expected3, vabdq_u8(a3, b3));

    const a4: u8x16 = .{ 0, 255, 128, 64, 32, 16, 8, 4, 0, 255, 128, 64, 32, 16, 8, 4 };
    const b4: u8x16 = .{ 255, 0, 64, 128, 16, 32, 4, 8, 255, 0, 64, 128, 16, 32, 4, 8 };
    const expected4: u8x16 = .{ 255, 255, 64, 64, 16, 16, 4, 4, 255, 255, 64, 64, 16, 16, 4, 4 };
    try expectEqual(expected4, vabdq_u8(a4, b4));

    const a5: u8x16 = .{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
    const b5: u8x16 = .{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
    const expected5: u8x16 = .{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
    try expectEqual(expected5, vabdq_u8(a5, b5));
}

/// signed absolute difference and accumulate (128-bit)
pub inline fn vabdq_u16(a: u16x8, b: u16x8) u16x8 {
    return abd(a, b);
}

test vabdq_u16 {
    const a: u16x8 = .{ 1, 2, 3, 4, 1, 2, 3, 4 };
    const b: u16x8 = .{ 16, 15, 14, 13, 16, 15, 14, 13 };

    const expected: u16x8 = .{ 15, 13, 11, 9, 15, 13, 11, 9 };

    try expectEqual(expected, vabdq_u16(a, b));
}

/// signed absolute difference and accumulate (128-bit)
pub inline fn vabdq_u32(a: u32x4, b: u32x4) u32x4 {
    return abd(a, b);
}

test vabdq_u32 {
    const a: u32x4 = .{ 1, 2, 1, 2 };
    const b: u32x4 = .{ 16, 15, 16, 15 };

    const expected: u32x4 = .{ 15, 13, 15, 13 };

    try expectEqual(expected, vabdq_u32(a, b));
}

/// signed absolute difference and accumulate (128-bit)
pub inline fn vabdq_f32(a: f32x4, b: f32x4) f32x4 {
    return abd(a, b);
}

test vabdq_f32 {
    const a: f32x4 = .{ 0.00, 0.00, 0.00, 0.00 };
    const b: f32x4 = .{ 0.19, 0.15, 0.19, 0.15 };

    const expected: f32x4 = .{ @abs(0.00 - 0.19), @abs(0.00 - 0.15), @abs(0.00 - 0.19), @abs(0.00 - 0.15) };

    try expectEqual(expected, vabdq_f32(a, b));
}

/// signed absolute difference and accumulate (128-bit)
pub inline fn vabdq_f64(a: f64x2, b: f64x2) f64x2 {
    return abd(a, b);
}

test vabdq_f64 {
    const a: f64x2 = .{ 0.01, 0.01 };
    const b: f64x2 = .{ 0.16, 0.16 };

    const expected: f64x2 = .{ 0.15, 0.15 };

    try expectEqual(expected, vabdq_f64(a, b));
}

/// Signed saturating doubling multiply long
pub inline fn vqdmull_s16(a: i16x4, b: i16x4) i32x4 {
    const product = vmull_s16(a, b);
    return product *| @as(i32x4, @splat(2));
}

test vqdmull_s16 {
    const a: i16x4 = .{ 16384, -16384, 12345, -12345 };
    const b: i16x4 = .{ 2, 2, -2, -2 };

    const expected: i32x4 = .{
        65536, // 16384 * 2 * 2
        -65536, // -16384 * 2 * 2
        -49380, // 12345 * -2 * 2
        49380, // -12345 * -2 * 2
    };

    try expectEqual(expected, vqdmull_s16(a, b));

    const a_sat: i16x4 = .{ std.math.maxInt(i16), std.math.maxInt(i16), std.math.maxInt(i16), std.math.minInt(i16) };
    const b_sat: i16x4 = .{ std.math.maxInt(i16), std.math.minInt(i16), std.math.maxInt(i16), std.math.maxInt(i16) };

    const expected_sat: i32x4 = .{
        2147352578,
        -2147418112,
        2147352578,
        -2147418112,
    };

    try expectEqual(expected_sat, vqdmull_s16(a_sat, b_sat));
}

/// Signed saturating doubling multiply long
pub inline fn vqdmull_s32(a: i32x2, b: i32x2) i64x2 {
    const product = vmull_s32(a, b);
    return product *| @as(i64x2, @splat(2));
}

test vqdmull_s32 {
    const a: i32x2 = .{ 6477777, -782282872 };
    const b: i32x2 = .{ 5, 5 };

    const expected: i64x2 = .{
        64777770, // 6477777 * 5 * 2
        -7822828720, // -782282872 * 5 * 2
    };

    try expectEqual(expected, vqdmull_s32(a, b));

    const a_sat: i32x2 = .{ std.math.maxInt(i32), std.math.maxInt(i32) };
    const b_sat: i32x2 = .{ std.math.maxInt(i32), std.math.minInt(i32) };

    const expected_sat: i64x2 = .{
        9223372028264841218,
        -9223372032559808512,
    };

    try expectEqual(expected_sat, vqdmull_s32(a_sat, b_sat));
}

/// Signed saturating doubling multiply long
pub inline fn vqdmullh_s16(a: i16, b: i16) i32 {
    return (@as(i32, a) *| @as(i32, b)) *| 2;
}

test vqdmullh_s16 {
    const a: i16 = std.math.maxInt(i16);
    const b: i16 = 20;

    const expected: i32 = 1310680;
    try expectEqual(expected, vqdmullh_s16(a, b));
}

/// Signed saturating doubling multiply long
pub inline fn vqdmulls_s32(a: i32, b: i32) i64 {
    return (@as(i64, a) *| @as(i64, b)) *| 2;
}

test vqdmulls_s32 {
    const a: i32 = std.math.maxInt(i32);
    const b: i32 = 20;

    const expected: i64 = 85899345880;
    try expectEqual(expected, vqdmulls_s32(a, b));
}

/// Saturating subtract
pub inline fn vqsub_s8(a: i8x8, b: i8x8) i8x8 {
    return a -| b;
}

/// Saturating subtract
pub inline fn vqsub_s16(a: i16x4, b: i16x4) i16x4 {
    return a -| b;
}

/// Saturating subtract
pub inline fn vqsub_s32(a: i32x2, b: i32x2) i32x2 {
    return a -| b;
}

/// Saturating subtract
pub inline fn vqsub_s64(a: i64x1, b: i64x1) i64x1 {
    return a -| b;
}

/// Saturating subtract
pub inline fn vqsub_u8(a: u8x8, b: u8x8) u8x8 {
    return a -| b;
}

/// Saturating subtract
pub inline fn vqsub_u16(a: u16x4, b: u16x4) u16x4 {
    return a -| b;
}

/// Saturating subtract
pub inline fn vqsub_u32(a: u32x2, b: u32x2) u32x2 {
    return a -| b;
}

/// Saturating subtract
pub inline fn vqsub_u64(a: u64x1, b: u64x1) u64x1 {
    return a -| b;
}

/// Saturating subtract
pub inline fn vqsubq_s8(a: i8x16, b: i8x16) i8x16 {
    return a -| b;
}

/// Saturating subtract
pub inline fn vqsubq_s16(a: i16x8, b: i16x8) i16x8 {
    return a -| b;
}

/// Saturating subtract
pub inline fn vqsubq_s32(a: i32x4, b: i32x4) i32x4 {
    return a -| b;
}

/// Saturating subtract
pub inline fn vqsubq_s64(a: i64x2, b: i64x2) i64x2 {
    return a -| b;
}

/// Saturating subtract
pub inline fn vqsubq_u8(a: u8x16, b: u8x16) u8x16 {
    return a -| b;
}

/// Saturating subtract
pub inline fn vqsubq_u16(a: u16x8, b: u16x8) u16x8 {
    return a -| b;
}

/// Saturating subtract
pub inline fn vqsubq_u32(a: u32x4, b: u32x4) u32x4 {
    return a -| b;
}

/// Saturating subtract
pub inline fn vqsubq_u64(a: u64x2, b: u64x2) u64x2 {
    return a -| b;
}

/// Saturating subtract
pub inline fn vqsubs_s32(a: i32, b: i32) i32 {
    return a -| b;
}

/// Saturating subtract
pub inline fn vqsubs_u32(a: u32, b: u32) u32 {
    return a -| b;
}

/// Saturating subtract
pub inline fn vqsubd_s64(a: i64, b: i64) i64 {
    return a -| b;
}

/// Saturating subtract
pub inline fn vqsubd_u64(a: u64, b: u64) u64 {
    return a -| b;
}

/// Signed Add Long across Vector
pub inline fn vaddlv_s8(a: i8x8) i16 {
    return @reduce(.Add, @as(i16x8, a));
}

test vaddlv_s8 {
    const a: i8x8 = .{ 1, 1, 1, 1, 1, 1, 1, 1 };
    const expected: i16 = 8;
    try expectEqual(expected, vaddlv_s8(a));
}

/// Signed Add Long across Vector
pub inline fn vaddlv_s16(a: i16x4) i32 {
    return @reduce(.Add, @as(i32x4, a));
}

test vaddlv_s16 {
    const a: i16x4 = .{ 1, 1, 1, 1 };
    const expected: i32 = 4;
    try expectEqual(expected, vaddlv_s16(a));
}

/// Signed Add Long across Vector
pub inline fn vaddlv_s32(a: i32x2) i64 {
    return @reduce(.Add, @as(i64x2, a));
}

test vaddlv_s32 {
    const a: i32x2 = .{ 1, 1 };
    const expected: i64 = 2;
    try expectEqual(expected, vaddlv_s32(a));
}

/// Unsigned Add Long across Vector
pub inline fn vaddlv_u8(a: u8x8) u16 {
    return @reduce(.Add, @as(u16x8, a));
}

test vaddlv_u8 {
    const a: u8x8 = .{ 1, 1, 1, 1, 1, 1, 1, 1 };
    const expected: u16 = 8;
    try expectEqual(expected, vaddlv_u8(a));
}

/// Unsigned Add Long across Vector
pub inline fn vaddlv_u16(a: u16x4) u32 {
    return @reduce(.Add, @as(u32x4, a));
}

test vaddlv_u16 {
    const a: u16x4 = .{ 1, 1, 1, 1 };
    const expected: u32 = 4;
    try expectEqual(expected, vaddlv_u16(a));
}

/// Unsigned Add Long across Vector
pub inline fn vaddlv_u32(a: u32x2) u64 {
    return @reduce(.Add, @as(u64x2, a));
}

test vaddlv_u32 {
    const a: u32x2 = .{ 1, 1 };
    const expected: u64 = 2;
    try expectEqual(expected, vaddlv_u32(a));
}

/// Signed Add Long across Vector
pub inline fn vaddlvq_s8(a: i8x16) i16 {
    return @reduce(.Add, @as(PromoteVector(i8x16), a));
}

test vaddlvq_s8 {
    const a: i8x16 = .{ 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 };
    const expected: i16 = 16;
    try expectEqual(expected, vaddlvq_s8(a));
}

/// Signed Add Long across Vector
pub inline fn vaddlvq_s16(a: i16x8) i32 {
    return @reduce(.Add, @as(PromoteVector(i16x8), a));
}

test vaddlvq_s16 {
    const a: i16x8 = .{ 1, 1, 1, 1, 1, 1, 1, 1 };
    const expected: i32 = 8;
    try expectEqual(expected, vaddlvq_s16(a));
}

/// Signed Add Long across Vector
pub inline fn vaddlvq_s32(a: i32x4) i64 {
    return @reduce(.Add, @as(PromoteVector(i32x4), a));
}

test vaddlvq_s32 {
    const a: i32x4 = .{ 1, 1, 1, 1 };
    const expected: i64 = 4;
    try expectEqual(expected, vaddlvq_s32(a));
}

/// Unsigned Add Long across Vector
pub inline fn vaddlvq_u8(a: u8x16) u16 {
    return @reduce(.Add, @as(PromoteVector(u8x16), a));
}

test vaddlvq_u8 {
    const a: u8x16 = .{ 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 };
    const expected: u16 = 16;
    try expectEqual(expected, vaddlvq_u8(a));
}

/// Unsigned Add Long across Vector
pub inline fn vaddlvq_u16(a: u16x8) u32 {
    return @reduce(.Add, @as(PromoteVector(u16x8), a));
}

test vaddlvq_u16 {
    const a: u16x8 = .{ 1, 1, 1, 1, 1, 1, 1, 1 };
    const expected: u32 = 8;
    try expectEqual(expected, vaddlvq_u16(a));
}

/// Unsigned Add Long across Vector
pub inline fn vaddlvq_u32(a: u32x4) u64 {
    return @reduce(.Add, @as(PromoteVector(u32x4), a));
}

test vaddlvq_u32 {
    const a: u32x4 = .{ 1, 1, 1, 1 };
    const expected: u64 = 4;
    try expectEqual(expected, vaddlvq_u32(a));
}

/// Signed Add Long across Vector
pub inline fn vaddv_s8(a: i8x8) i8 {
    return @reduce(.Add, a);
}

test vaddv_s8 {
    const a: i8x8 = .{ 1, 1, 1, 1, 1, 1, 1, 1 };
    const expected: i8 = 8;
    try expectEqual(expected, vaddv_s8(a));
}

/// Signed Add Long across Vector
pub inline fn vaddv_s16(a: i16x4) i16 {
    return @reduce(.Add, a);
}

test vaddv_s16 {
    const a: i16x4 = .{ 1, 1, 1, 1 };
    const expected: i16 = 4;
    try expectEqual(expected, vaddv_s16(a));
}

/// Signed Add Long across Vector
pub inline fn vaddv_s32(a: i32x2) i32 {
    return @reduce(.Add, a);
}

test vaddv_s32 {
    const a: i32x2 = .{ 1, 1 };
    const expected: i32 = 2;
    try expectEqual(expected, vaddv_s32(a));
}

/// Unsigned Add Long across Vector
pub inline fn vaddv_u8(a: u8x8) u8 {
    return @reduce(.Add, a);
}

test vaddv_u8 {
    const a: u8x8 = .{ 1, 1, 1, 1, 1, 1, 1, 1 };
    const expected: u8 = 8;
    try expectEqual(expected, vaddv_u8(a));
}

/// Unsigned Add Long across Vector
pub inline fn vaddv_u16(a: u16x4) u16 {
    return @reduce(.Add, a);
}

test vaddv_u16 {
    const a: u16x4 = .{ 1, 1, 1, 1 };
    const expected: u16 = 4;
    try expectEqual(expected, vaddv_u16(a));
}

/// Unsigned Add Long across Vector
pub inline fn vaddv_u32(a: u32x2) u32 {
    return @reduce(.Add, a);
}

test vaddv_u32 {
    const a: u32x2 = .{ 1, 1 };
    const expected: u32 = 2;
    try expectEqual(expected, vaddv_u32(a));
}

/// Signed Add Long across Vector
pub inline fn vaddvq_s8(a: i8x16) i8 {
    return @reduce(.Add, a);
}

test vaddvq_s8 {
    const a: i8x16 = .{ 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 };
    const expected: i8 = 16;
    try expectEqual(expected, vaddvq_s8(a));
}

/// Signed Add Long across Vector
pub inline fn vaddvq_s16(a: i16x8) i16 {
    return @reduce(.Add, a);
}

test vaddvq_s16 {
    const a: i16x8 = .{ 1, 1, 1, 1, 1, 1, 1, 1 };
    const expected: i16 = 8;
    try expectEqual(expected, vaddvq_s16(a));
}

/// Signed Add Long across Vector
pub inline fn vaddvq_s32(a: i32x4) i32 {
    return @reduce(.Add, a);
}

test vaddvq_s32 {
    const a: i32x4 = .{ 1, 1, 1, 1 };
    const expected: i32 = 4;
    try expectEqual(expected, vaddvq_s32(a));
}

/// Unsigned Add Long across Vector
pub inline fn vaddvq_u8(a: u8x16) u8 {
    return @reduce(.Add, a);
}

test vaddvq_u8 {
    const a: u8x16 = .{ 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 };
    const expected: u8 = 16;
    try expectEqual(expected, vaddvq_u8(a));
}

/// Unsigned Add Long across Vector
pub inline fn vaddvq_u16(a: u16x8) u16 {
    return @reduce(.Add, a);
}

test vaddvq_u16 {
    const a: u16x8 = .{ 1, 1, 1, 1, 1, 1, 1, 1 };
    const expected: u16 = 8;
    try expectEqual(expected, vaddvq_u16(a));
}

/// Unsigned Add Long across Vector
pub inline fn vaddvq_u32(a: u32x4) u32 {
    return @reduce(.Add, a);
}

test vaddvq_u32 {
    const a: u32x4 = .{ 1, 1, 1, 1 };
    const expected: u32 = 4;
    try expectEqual(expected, vaddvq_u32(a));
}

/// Floating-point maximum number across vector
pub inline fn vmaxnmv_f32(a: f32x2) f32 {
    return @reduce(.Max, a);
}

test vmaxnmv_f32 {
    const a: f32x2 = .{ 0.59, 0.5 };
    const expected: f32 = 0.59;
    try expectEqual(expected, vmaxnmv_f32(a));
}

/// Floating-point maximum number across vector
pub inline fn vmaxnmvq_f32(a: f32x4) f32 {
    return @reduce(.Max, a);
}

test vmaxnmvq_f32 {
    const a: f32x4 = .{ 0.59, 0.5, 2.5, 50.2 };
    const expected: f32 = 50.2;
    try expectEqual(expected, vmaxnmvq_f32(a));
}

/// Horizontal vector max
pub inline fn vmaxv_s8(a: i8x8) i8 {
    return @reduce(.Max, a);
}

/// Horizontal vector max
pub inline fn vmaxv_s16(a: i16x4) i16 {
    return @reduce(.Max, a);
}

/// Horizontal vector max
pub inline fn vmaxv_s32(a: i32x2) i32 {
    return @reduce(.Max, a);
}

/// Horizontal vector max
pub inline fn vmaxv_u8(a: u8x8) u8 {
    return @reduce(.Max, a);
}

/// Horizontal vector max
pub inline fn vmaxv_u16(a: u16x4) u16 {
    return @reduce(.Max, a);
}

/// Horizontal vector max
pub inline fn vmaxv_u32(a: u32x2) u32 {
    return @reduce(.Max, a);
}

/// Horizontal vector max
pub inline fn vmaxvq_s8(a: i8x16) i8 {
    return @reduce(.Max, a);
}

/// Horizontal vector max
pub inline fn vmaxvq_s16(a: i16x8) i16 {
    return @reduce(.Max, a);
}

/// Horizontal vector max
pub inline fn vmaxvq_s32(a: i32x4) i32 {
    return @reduce(.Max, a);
}

/// Horizontal vector max
pub inline fn vmaxvq_u8(a: u8x16) u8 {
    return @reduce(.Max, a);
}

/// Horizontal vector max
pub inline fn vmaxvq_u16(a: u16x8) u16 {
    return @reduce(.Max, a);
}

/// Horizontal vector max
pub inline fn vmaxvq_u32(a: u32x4) u32 {
    return @reduce(.Max, a);
}

/// Horizontal vector max
pub inline fn vmaxvq_f32(a: f32x4) f32 {
    return @reduce(.Max, a);
}

/// Horizontal vector max
pub inline fn vmaxvq_f64(a: f64x2) f64 {
    return @reduce(.Max, a);
}

/// Floating-point maximum number across vector
pub inline fn vminnmv_f32(a: f32x2) f32 {
    return @reduce(.Min, a);
}

test vminnmv_f32 {
    const a: f32x2 = .{ 0.59, 0.5 };
    const expected: f32 = 0.5;
    try expectEqual(expected, vminnmv_f32(a));
}

/// Floating-point minimum number across vector
pub inline fn vminnmvq_f32(a: f32x4) f32 {
    return @reduce(.Min, a);
}

test vminnmvq_f32 {
    const a: f32x4 = .{ 0.59, 0.5, 2.5, 50.2 };
    const expected: f32 = 0.5;
    try expectEqual(expected, vminnmvq_f32(a));
}

/// Horizontal vector min
pub inline fn vminv_s8(a: i8x8) i8 {
    return @reduce(.Min, a);
}

/// Horizontal vector min
pub inline fn vminv_s16(a: i16x4) i16 {
    return @reduce(.Min, a);
}

/// Horizontal vector min
pub inline fn vminv_s32(a: i32x2) i32 {
    return @reduce(.Min, a);
}

/// Horizontal vector min
pub inline fn vminv_u8(a: u8x8) u8 {
    return @reduce(.Min, a);
}

/// Horizontal vector min
pub inline fn vminv_u16(a: u16x4) u16 {
    return @reduce(.Min, a);
}

/// Horizontal vector min
pub inline fn vminv_u32(a: u32x2) u32 {
    return @reduce(.Min, a);
}

/// Horizontal vector min
pub inline fn vminvq_s8(a: i8x16) i8 {
    return @reduce(.Min, a);
}

/// Horizontal vector min
pub inline fn vminvq_s16(a: i16x8) i16 {
    return @reduce(.Min, a);
}

/// Horizontal vector min
pub inline fn vminvq_s32(a: i32x4) i32 {
    return @reduce(.Min, a);
}

/// Horizontal vector min
pub inline fn vminvq_u8(a: u8x16) u8 {
    return @reduce(.Min, a);
}

/// Horizontal vector min
pub inline fn vminvq_u16(a: u16x8) u16 {
    return @reduce(.Min, a);
}

/// Horizontal vector min
pub inline fn vminvq_u32(a: u32x4) u32 {
    return @reduce(.Min, a);
}

/// Horizontal vector min
pub inline fn vminvq_f32(a: f32x4) f32 {
    return @reduce(.Min, a);
}

/// Horizontal vector min
pub inline fn vminvq_f64(a: f64x2) f64 {
    return @reduce(.Min, a);
}

/// Signed Absolute difference and Accumulate
pub inline fn vaba_s8(acc: i8x8, a: i8x8, b: i8x8) i8x8 {
    return vabd_s8(a, b) +% acc;
}

test vaba_s8 {
    const acc: i8x8 = .{ 10, 20, 30, 40, 50, 60, 70, 80 };

    const a: i8x8 = .{ -5, -15, -25, -35, -45, -55, -65, -75 };
    const b: i8x8 = .{ 5, 15, 25, 35, 45, 55, 65, 75 };
    const expected: i8x8 = .{ 20, 50, 80, 110, -116, -86, -56, -26 };

    try expectEqual(expected, vaba_s8(acc, a, b));

    const acc2: i8x8 = .{ 0, 0, 0, 0, 0, 0, 0, 0 };
    const expected2: i8x8 = .{ 10, 30, 50, 70, 90, 110, -126, -106 };

    try expectEqual(expected2, vaba_s8(acc2, a, b));

    const acc3: i8x8 = .{ 100, 110, 120, 127, -128, -100, -50, 0 };
    const expected3: i8x8 = acc3;

    try expectEqual(expected3, vaba_s8(acc3, a, a));

    const acc4: i8x8 = .{ -10, 10, -20, 20, -30, 30, -40, 40 };
    const a4: i8x8 = .{ -128, -64, -32, -16, 16, 32, 64, 127 };
    const b4: i8x8 = .{ 127, 63, 32, 16, -16, -32, -64, -128 };

    const expected4: i8x8 = .{ -11, -119, 44, 52, 2, 94, 88, 39 };

    try expectEqual(expected4, vaba_s8(acc4, a4, b4));
}

/// Signed Absolute difference and Accumulate
pub inline fn vaba_s16(acc: i16x4, a: i16x4, b: i16x4) i16x4 {
    return vabd_s16(a, b) +% acc;
}

/// Signed Absolute difference and Accumulate
pub inline fn vaba_s32(acc: i32x2, a: i32x2, b: i32x2) i32x2 {
    return vabd_s32(a, b) +% acc;
}

/// Unsigned Absolute difference and Accumulate
pub inline fn vaba_u8(acc: u8x8, a: u8x8, b: u8x8) u8x8 {
    return vabd_u8(a, b) +% acc;
}

/// Unsigned Absolute difference and Accumulate
pub inline fn vaba_u16(acc: u16x4, a: u16x4, b: u16x4) u16x4 {
    return vabd_u16(a, b) +% acc;
}

/// Unsigned Absolute difference and Accumulate
pub inline fn vaba_u32(acc: u32x2, a: u32x2, b: u32x2) u32x2 {
    return vabd_u32(a, b) +% acc;
}

/// Signed Absolute difference and Accumulate
pub inline fn vabaq_s8(acc: i8x16, a: i8x16, b: i8x16) i8x16 {
    return vabdq_s8(a, b) +% acc;
}

/// Signed Absolute difference and Accumulate
pub inline fn vabaq_s16(acc: i16x8, a: i16x8, b: i16x8) i16x8 {
    return vabdq_s16(a, b) +% acc;
}

/// Signed Absolute difference and Accumulate
pub inline fn vabaq_s32(acc: i32x4, a: i32x4, b: i32x4) i32x4 {
    return vabdq_s32(a, b) +% acc;
}

/// Unsigned Absolute difference and Accumulate
pub inline fn vabaq_u8(acc: u8x16, a: u8x16, b: u8x16) u8x16 {
    return vabdq_u8(a, b) +% acc;
}

/// Unsigned Absolute difference and Accumulate
pub inline fn vabaq_u16(acc: u16x8, a: u16x8, b: u16x8) u16x8 {
    return vabdq_u16(a, b) +% acc;
}

/// Unsigned Absolute difference and Accumulate
pub inline fn vabaq_u32(acc: u32x4, a: u32x4, b: u32x4) u32x4 {
    return vabdq_u32(a, b) +% acc;
}

/// Signed Absolute difference and Accumulate Long
pub inline fn vabal_s8(acc: i16x8, a: i8x8, b: i8x8) i8x8 {
    return vabdl_s8(a, b) +% acc;
}

/// Signed Absolute difference and Accumulate Long
pub inline fn vabal_s32(acc: i64x2, a: i32x2, b: i32x2) i32x2 {
    return vabdl_s32(a, b) +% acc;
}

/// Unsigned Absolute difference and Accumulate Long
pub inline fn vabal_u8(acc: u16x8, a: u8x8, b: u8x8) u8x8 {
    return vabdl_u8(a, b) +% acc;
}

/// Unsigned Absolute difference and Accumulate Long
pub inline fn vabal_u16(acc: u32x4, a: u16x4, b: u16x4) u16x4 {
    return vabdl_u16(a, b) +% acc;
}

/// Unsigned Absolute difference and Accumulate Long
pub inline fn vabal_u32(acc: u64x2, a: u32x2, b: u32x2) u32x2 {
    return vabdl_u32(a, b) +% acc;
}

/// Signed Absolute difference and Accumulate Long
pub inline fn vabal_high_s8(acc: i16x8, a: i8x8, b: i8x8) i16x8 {
    return vabdl_high_s8(a, b) +% acc;
}

/// Signed Absolute difference and Accumulate Long
pub inline fn vabal_high_s16(acc: i32x4, a: i16x4, b: i16x4) i32x4 {
    return vabdl_high_s16(a, b) +% acc;
}

/// Signed Absolute difference and Accumulate Long
pub inline fn vabal_high_s32(acc: i64x2, a: i32x2, b: i32x2) i64x2 {
    return vabdl_high_s32(a, b) +% acc;
}

/// Unsigned Absolute difference and Accumulate Long
pub inline fn vabal_high_u8(acc: u16x8, a: u8x8, b: u8x8) u16x8 {
    return vabdl_high_u8(a, b) +% acc;
}

/// Unsigned Absolute difference and Accumulate Long
pub inline fn vabal_high_u16(acc: u32x4, a: u16x4, b: u16x4) u32x4 {
    return vabdl_high_u16(a, b) +% acc;
}

/// Unsigned Absolute difference and Accumulate Long
pub inline fn vabal_high_u32(acc: u64x2, a: u32x2, b: u32x2) u64x2 {
    return vabdl_high_u32(a, b) +% acc;
}

/// Floating-point absolute difference
pub inline fn vabdd_f64(a: f64, b: f64) f64 {
    return @abs(a - b);
}

/// Signed Absolute difference Long
pub inline fn vabdl_s8(a: i8x8, b: i8x8) i16x8 {
    return abd(a, b);
}

test vabdl_s8 {
    const a: i8x8 = .{ 1, 2, 3, 4, 5, 6, 7, 8 };
    const b: i8x8 = .{ 16, 15, 14, 13, 12, 11, 10, 9 };

    const expected: i16x8 = .{ 15, 13, 11, 9, 7, 5, 3, 1 };

    try expectEqual(expected, vabdl_s8(a, b));
}

/// Signed Absolute difference Long
pub inline fn vabdl_s16(a: i16x4, b: i16x4) i32x4 {
    return abd(a, b);
}

test vabdl_s16 {
    const a: i16x4 = .{ 1, 2, 3, 4 };
    const b: i16x4 = .{ 16, 15, 14, 13 };

    const expected: i32x4 = .{ 15, 13, 11, 9 };

    try expectEqual(expected, vabdl_s16(a, b));
}

/// Signed Absolute difference Long
pub inline fn vabdl_s32(a: i32x2, b: i32x2) i64x2 {
    return abd(a, b);
}

test vabdl_s32 {
    const a: i32x2 = .{ 1, 2 };
    const b: i32x2 = .{ 16, 15 };

    const expected: i64x2 = .{ 15, 13 };

    try expectEqual(expected, vabdl_s32(a, b));
}

/// Unsigned Absolute difference Long
pub inline fn vabdl_u8(a: u8x8, b: u8x8) u16x8 {
    return abd(a, b);
}

test vabdl_u8 {
    const a: u8x8 = .{ 1, 2, 3, 4, 5, 6, 7, 8 };
    const b: u8x8 = .{ 16, 15, 14, 13, 12, 11, 10, 9 };
    const expected: u16x8 = .{ 15, 13, 11, 9, 7, 5, 3, 1 };
    try expectEqual(expected, vabdl_u8(a, b));

    const a2: u8x8 = .{ 10, 10, 10, 10, 10, 10, 10, 10 };
    const b2: u8x8 = .{ 10, 10, 10, 10, 10, 10, 10, 10 };
    const expected2: u16x8 = .{ 0, 0, 0, 0, 0, 0, 0, 0 };
    try expectEqual(expected2, vabdl_u8(a2, b2));

    const a3: u8x8 = .{ 16, 15, 14, 13, 12, 11, 10, 9 };
    const b3: u8x8 = .{ 1, 2, 3, 4, 5, 6, 7, 8 };
    const expected3: u16x8 = .{ 15, 13, 11, 9, 7, 5, 3, 1 };
    try expectEqual(expected3, vabd_u8(a3, b3));

    const a4: u8x8 = .{ 0, 255, 128, 64, 32, 16, 8, 4 };
    const b4: u8x8 = .{ 255, 0, 64, 128, 16, 32, 4, 8 };
    const expected4: u16x8 = .{ 255, 255, 64, 64, 16, 16, 4, 4 };
    try expectEqual(expected4, vabd_u8(a4, b4));

    const a5: u8x8 = .{ 0, 0, 0, 0, 0, 0, 0, 0 };
    const b5: u8x8 = .{ 0, 0, 0, 0, 0, 0, 0, 0 };
    const expected5: u16x8 = .{ 0, 0, 0, 0, 0, 0, 0, 0 };
    try expectEqual(expected5, vabdl_u8(a5, b5));
}

/// Unsigned Absolute difference Long
pub inline fn vabdl_u16(a: u16x4, b: u16x4) u32x4 {
    return abd(a, b);
}

test vabdl_u16 {
    const a: u16x4 = .{ 1, 2, 3, 4 };
    const b: u16x4 = .{ 16, 15, 14, 13 };

    const expected: u32x4 = .{ 15, 13, 11, 9 };

    try expectEqual(expected, vabdl_u16(a, b));
}

/// Unsigned Absolute difference Long
pub inline fn vabdl_u32(a: u32x2, b: u32x2) u64x2 {
    return abd(a, b);
}

test vabdl_u32 {
    const a: u32x2 = .{ 1, 2 };
    const b: u32x2 = .{ 16, 15 };

    const expected: u64x2 = .{ 15, 13 };

    try expectEqual(expected, vabdl_u32(a, b));
}

/// Signed Absolute difference Long
pub inline fn vabdl_high_s8(a: i8x16, b: i8x16) i16x8 {
    return abd(vget_high_s8(a), vget_high_s8(b));
}

/// Signed Absolute difference Long
pub inline fn vabdl_high_s16(a: i16x8, b: i16x8) i32x4 {
    return abd(vget_high_s16(a), vget_high_s16(b));
}

/// Signed Absolute difference Long
pub inline fn vabdl_high_s32(a: i32x4, b: i32x4) i64x2 {
    return abd(vget_high_s32(a), vget_high_s32(b));
}

/// Unsigned Absolute difference Long
pub inline fn vabdl_high_u8(a: u8x16, b: u8x16) u16x8 {
    return abd(vget_high_u8(a), vget_high_u8(b));
}

/// Unsigned Absolute difference Long
pub inline fn vabdl_high_u16(a: u16x8, b: u16x8) u32x4 {
    return abd(vget_high_u16(a), vget_high_u16(b));
}

/// Unsigned Absolute difference Long
pub inline fn vabdl_high_u32(a: u32x4, b: u32x4) u64x2 {
    return abd(vget_high_u32(a), vget_high_u32(b));
}

/// Floating-point absolute difference
pub inline fn vabds_f32(a: f32, b: f32) f32 {
    return @abs(a - b);
}

/// Absolute value (wrapping)
pub inline fn vabs_s8(a: i8x8) i8x8 {
    return @bitCast(@abs(a));
}

/// Absolute value (wrapping)
pub inline fn vabs_s16(a: i16x4) i16x4 {
    return @bitCast(@abs(a));
}

/// Absolute value (wrapping)
pub inline fn vabs_s32(a: i32x2) i32x2 {
    return @bitCast(@abs(a));
}

/// Absolute value (wrapping)
pub inline fn vabs_f32(a: f32x2) f32x2 {
    return @bitCast(@abs(a));
}

/// Absolute value (wrapping)
pub inline fn vabsq_s8(a: i8x16) i8x16 {
    return @bitCast(@abs(a));
}

/// Absolute value (wrapping)
pub inline fn vabsq_s16(a: i16x8) i16x8 {
    return @bitCast(@abs(a));
}

/// Absolute value (wrapping)
pub inline fn vabsq_s32(a: i32x4) i32x4 {
    return @bitCast(@abs(a));
}

/// Absolute value (wrapping)
pub inline fn vabsq_s64(a: i64x2) i64x2 {
    return @bitCast(@abs(a));
}

/// Absolute value (wrapping)
pub inline fn vabsq_f32(a: f32x4) f32x4 {
    return @bitCast(@abs(a));
}

/// Absolute value (wrapping)
pub inline fn vabsq_f64(a: f64x2) f64x2 {
    return @bitCast(@abs(a));
}

/// Vector add (wrapping)
pub inline fn vadd_s8(a: i8x8, b: i8x8) i8x8 {
    return a +% b;
}

/// Vector add (wrapping)
pub inline fn vadd_s16(a: i16x4, b: i16x4) i16x4 {
    return a +% b;
}

/// Vector add (wrapping)
pub inline fn vadd_s32(a: i32x2, b: i32x2) i32x2 {
    return a +% b;
}

/// Vector add (wrapping)
pub inline fn vadd_s64(a: i64x1, b: i64x1) i64x1 {
    return a +% b;
}

/// Vector add (wrapping)
pub inline fn vadd_f32(a: f32x2, b: f32x2) f32x2 {
    return a +% b;
}

/// Vector add (wrapping)
pub inline fn vadd_u8(a: u8x8, b: u8x8) u8x8 {
    return a +% b;
}

/// Vector add (wrapping)
pub inline fn vadd_u16(a: u16x4, b: u16x4) u16x4 {
    return a +% b;
}

/// Vector add (wrapping)
pub inline fn vadd_u32(a: u32x2, b: u32x2) u32x2 {
    return a +% b;
}

/// Vector add (wrapping)
pub inline fn vadd_u64(a: u64x1, b: u64x1) u64x1 {
    return a +% b;
}

/// Vector add (wrapping)
pub inline fn vaddq_s8(a: i8x16, b: i8x16) i8x16 {
    return a +% b;
}

/// Vector add (wrapping)
pub inline fn vaddq_s16(a: i16x8, b: i16x8) i16x8 {
    return a +% b;
}

/// Vector add (wrapping)
pub inline fn vaddq_s32(a: i32x4, b: i32x4) i32x4 {
    return a +% b;
}

/// Vector add (wrapping)
pub inline fn vaddq_s64(a: i64x2, b: i64x2) i64x2 {
    return a +% b;
}

/// Vector add (wrapping)
pub inline fn vaddq_f32(a: f32x2, b: f32x2) f32x2 {
    return a +% b;
}

/// Vector add (wrapping)
pub inline fn vaddq_f64(a: f64x2, b: f64x2) f64x2 {
    return a +% b;
}

/// Vector add (wrapping)
pub inline fn vaddq_u8(a: u8x16, b: u8x16) u8x16 {
    return a +% b;
}

/// Vector add (wrapping)
pub inline fn vaddq_u16(a: u16x8, b: u16x8) u16x8 {
    return a +% b;
}

/// Vector add (wrapping)
pub inline fn vaddq_u32(a: u32x4, b: u32x4) u32x4 {
    return a +% b;
}

/// Vector add (wrapping)
pub inline fn vaddq_u64(a: u64x2, b: u64x2) u64x2 {
    return a +% b;
}

/// Add (wrapping)
pub inline fn vaddd_s64(a: i64, b: i64) i64 {
    return a +% b;
}

/// Add (wrapping)
pub inline fn vaddd_u64(a: u64, b: u64) u64 {
    return a +% b;
}

/// Add returning High Narrow
pub inline fn vaddhn_s16(a: i16x8, b: i16x8) i8x8 {
    const sum: i16x8 = a +% b;
    return @truncate(vshrq_n_s16(sum, 8));
}

test vaddhn_s16 {
    const a: i16x8 = .{ 256, 512, 1024, 2048, 4096, 8192, 16384, 32767 };
    const b: i16x8 = .{ 128, 256, 512, 1024, 2048, 4096, 8192, 32767 };

    const expected: i8x8 = .{ 1, 3, 6, 12, 24, 48, 96, -1 }; // -1 due to wrapping
    try expectEqual(expected, vaddhn_s16(a, b));

    const a2: i16x8 = .{ -256, -512, -1024, -2048, -4096, -8192, -16384, -32768 };
    const b2: i16x8 = .{ -128, -256, -512, -1024, -2048, -4096, -8192, -32768 };

    const expected2: i8x8 = .{ -2, -3, -6, -12, -24, -48, -96, 0 };
    try expectEqual(expected2, vaddhn_s16(a2, b2));

    const a3: i16x8 = .{ 0, 0, 0, 0, 0, 0, 0, 0 };
    const b3: i16x8 = .{ 0, 0, 0, 0, 0, 0, 0, 0 };

    const expected3: i8x8 = .{ 0, 0, 0, 0, 0, 0, 0, 0 };
    try expectEqual(expected3, vaddhn_s16(a3, b3));
}

/// Add returning High Narrow
pub inline fn vaddhn_s32(a: i32x4, b: i32x4) i16x4 {
    const sum = vaddq_s32(a, b);
    return @intCast(sum >> @as(i32x4, @splat(8)));
}

/// Add returning High Narrow
pub inline fn vaddhn_s64(a: i64x2, b: i64x2) i32x2 {
    const sum = vaddq_s64(a, b);
    return @intCast(sum >> @as(i32x4, @splat(8)));
}

/// Add returning High Narrow
pub inline fn vaddhn_u16(a: u16x8, b: u16x8) u8x8 {
    const sum = vaddq_u16(a, b);
    return @intCast(sum >> @as(u16x8, @splat(8)));
}

/// Add returning High Narrow
pub inline fn vaddhn_u32(a: u32x4, b: u32x4) u16x4 {
    const sum = vaddq_u32(a, b);
    return @intCast(sum >> @as(u32x4, @splat(8)));
}

/// Add returning High Narrow
pub inline fn vaddhn_u64(a: u64x2, b: u64x2) u32x2 {
    const sum = vaddq_u64(a, b);
    return @intCast(sum >> @as(u64x2, @splat(8)));
}

/// Shift right
pub inline fn vshrq_n_s16(a: i16x8, n: u16) i16x8 {
    return @as(u16x8, @bitCast(a)) >> @as(u16x8, @splat(n));
}
