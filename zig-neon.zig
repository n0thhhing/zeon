const std = @import("std");
const assert = std.debug.assert;
const expectEqual = std.testing.expectEqual;

const p8 = u8;
const p16 = u16;
const p64 = u64;
const p128 = u128;

const i8x8 = @Vector(8, i8);
const i8x16 = @Vector(16, i8);
const i16x4 = @Vector(4, i16);
const i16x8 = @Vector(8, i16);
const i32x2 = @Vector(2, i32);
const i32x4 = @Vector(4, i32);
const i64x1 = @Vector(1, i64);
const i64x2 = @Vector(2, i64);

const u8x8 = @Vector(8, u8);
const u8x16 = @Vector(16, u8);
const u16x4 = @Vector(4, u16);
const u16x8 = @Vector(8, u16);
const u32x2 = @Vector(2, u32);
const u32x4 = @Vector(4, u32);
const u64x1 = @Vector(1, u64);
const u64x2 = @Vector(2, u64);

const f16x4 = @Vector(4, f16);
const f16x8 = @Vector(8, f16);
const f32x2 = @Vector(2, f32);
const f32x4 = @Vector(4, f32);
const f64x1 = @Vector(1, f64);
const f64x2 = @Vector(2, f64);

const p8x8 = @Vector(8, p8);
const p8x16 = @Vector(16, p8);
const p16x4 = @Vector(4, p16);
const p16x8 = @Vector(8, p16);
const p64x1 = @Vector(1, p64);
const p64x2 = @Vector(2, p64);

inline fn VectorArray(comptime T: type, comptime length: usize) type {
    return struct {
        val: [length]T,
    };
}

const i8x8x2 = VectorArray(i8x8, 2);
const i8x16x2 = VectorArray(i8x16, 2);
const i16x4x2 = VectorArray(i16x4, 2);
const i16x8x2 = VectorArray(i16x8, 2);
const i32x2x2 = VectorArray(i32x2, 2);
const i32x4x2 = VectorArray(i32x4, 2);
const i64x1x2 = VectorArray(i64x1, 2);
const i64x2x2 = VectorArray(i64x2, 2);

const u8x8x2 = VectorArray(u8x8, 2);
const u8x16x2 = VectorArray(u8x16, 2);
const u16x4x2 = VectorArray(u16x4, 2);
const u16x8x2 = VectorArray(u16x8, 2);
const u32x2x2 = VectorArray(u32x2, 2);
const u32x4x2 = VectorArray(u32x4, 2);
const u64x1x2 = VectorArray(u64x1, 2);
const u64x2x2 = VectorArray(u64x2, 2);

const f16x4x2 = VectorArray(f16x4, 2);
const f16x8x2 = VectorArray(f16x8, 2);
const f32x2x2 = VectorArray(f32x2, 2);
const f32x4x2 = VectorArray(f32x4, 2);
const f64x1x2 = VectorArray(f64x1, 2);
const f64x2x2 = VectorArray(f64x2, 2);

const p8x8x2 = VectorArray(p8x8, 2);
const p8x16x2 = VectorArray(p8x16, 2);
const p16x4x2 = VectorArray(p16x4, 2);
const p16x8x2 = VectorArray(p16x8, 2);
const p64x1x2 = VectorArray(p64x1, 2);
const p64x2x2 = VectorArray(p64x2, 2);

const i8x8x3 = VectorArray(i8x8, 3);
const i8x16x3 = VectorArray(i8x16, 3);
const i16x4x3 = VectorArray(i16x4, 3);
const i16x8x3 = VectorArray(i16x8, 3);
const i32x2x3 = VectorArray(i32x2, 3);
const i32x4x3 = VectorArray(i32x4, 3);
const i64x1x3 = VectorArray(i64x1, 3);
const i64x2x3 = VectorArray(i64x2, 3);

const u8x8x3 = VectorArray(u8x8, 3);
const u8x16x3 = VectorArray(u8x16, 3);
const u16x4x3 = VectorArray(u16x4, 3);
const u16x8x3 = VectorArray(u16x8, 3);
const u32x2x3 = VectorArray(u32x2, 3);
const u32x4x3 = VectorArray(u32x4, 3);
const u64x1x3 = VectorArray(u64x1, 3);
const u64x2x3 = VectorArray(u64x2, 3);

const f16x4x3 = VectorArray(f16x4, 3);
const f16x8x3 = VectorArray(f16x8, 3);
const f32x2x3 = VectorArray(f32x2, 3);
const f32x4x3 = VectorArray(f32x4, 3);
const f64x1x3 = VectorArray(f64x1, 3);
const f64x2x3 = VectorArray(f64x2, 3);

const p8x8x3 = VectorArray(p8x8, 3);
const p8x16x3 = VectorArray(p8x16, 3);
const p16x4x3 = VectorArray(p16x4, 3);
const p16x8x3 = VectorArray(p16x8, 3);
const p64x1x3 = VectorArray(p64x1, 3);
const p64x2x3 = VectorArray(p64x2, 3);

const i8x8x4 = VectorArray(i8x8, 4);
const i8x16x4 = VectorArray(i8x16, 4);
const i16x4x4 = VectorArray(i16x4, 4);
const i16x8x4 = VectorArray(i16x8, 4);
const i32x2x4 = VectorArray(i32x2, 4);
const i32x4x4 = VectorArray(i32x4, 4);
const i64x1x4 = VectorArray(i64x1, 4);
const i64x2x4 = VectorArray(i64x2, 4);

const u8x8x4 = VectorArray(u8x8, 4);
const u8x16x4 = VectorArray(u8x16, 4);
const u16x4x4 = VectorArray(u16x4, 4);
const u16x8x4 = VectorArray(u16x8, 4);
const u32x2x4 = VectorArray(u32x2, 4);
const u32x4x4 = VectorArray(u32x4, 4);
const u64x1x4 = VectorArray(u64x1, 4);
const u64x2x4 = VectorArray(u64x2, 4);

const f16x4x4 = VectorArray(f16x4, 4);
const f16x8x4 = VectorArray(f16x8, 4);
const f32x2x4 = VectorArray(f32x2, 4);
const f32x4x4 = VectorArray(f32x4, 4);
const f64x1x4 = VectorArray(f64x1, 4);
const f64x2x4 = VectorArray(f64x2, 4);

const p8x8x4 = VectorArray(p8x8, 4);
const p8x16x4 = VectorArray(p8x16, 4);
const p16x4x4 = VectorArray(p16x4, 4);
const p16x8x4 = VectorArray(p16x8, 4);
const p64x1x4 = VectorArray(p64x1, 4);
const p64x2x4 = VectorArray(p64x2, 4);

inline fn PromoteInt(comptime T: type) type {
    var type_info = @typeInfo(T);
    var child_info = @typeInfo(std.meta.Child(T));
    child_info.Int.bits *= 2;
    type_info.Vector.child = @Type(child_info);
    return @Type(type_info);
}

/// Absolute difference(modular) between arguments
inline fn abd(a: anytype, b: anytype) @TypeOf(a, b) {
    const T = @TypeOf(a, b);
    const Child = std.meta.Child(T);
    const typeInfo = @typeInfo(Child);
    switch (typeInfo) {
        inline .Int => {
            switch (typeInfo.Int.signedness) {
                .unsigned => {
                    // Since unsigned numbers cannot be negative, we subtract the
                    // smaller elemant from the larger in order to prevent overflows
                    // when calculating the difference, saving us the trouble of
                    // casting to a larger signed type when subtracting. Because
                    // of ReleaseFast optimizations, this probably will be compacted
                    // down to one instruction(uabd v0.8b, v0.8b, v1.8b in my case),
                    // so technically @min and @max dont matter here, but zig will
                    // throw an overflow error if we simply did @abs(a - b).
                    const max: T = @max(a, b);
                    const min: T = @min(a, b);
                    return @abs(max -% min);
                },
                .signed => {
                    return @truncate(
                        @as(
                            PromoteInt(T),
                            @bitCast(
                                @abs(@as(PromoteInt(T), a) -% @as(PromoteInt(T), b)),
                            ),
                        ),
                    );
                },
            }
        },
        inline .Float => {
            // Floats dont have modular subtraction,
            // so we just assume there wont be an overflow here.
            return @abs(a - b);
        },
        else => unreachable,
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

/// Get high elements of a i8x16 vector
pub inline fn vget_high_s8(vec: i8x16) i8x8 {
    return @shuffle(
        i8,
        vec,
        undefined,
        i8x8{ 8, 9, 10, 11, 12, 13, 14, 15 },
    );
}

/// Get high elements of a i16x8 vector
pub inline fn vget_high_s16(vec: i16x8) i16x4 {
    return @shuffle(
        i16,
        vec,
        undefined,
        i16x4{ 4, 5, 6, 7 },
    );
}

/// Get high elements of a i32x4 vector
pub inline fn vget_high_s32(vec: i32x4) i32x2 {
    return @shuffle(
        i32,
        vec,
        undefined,
        i32x2{ 2, 3 },
    );
}

/// Get high elements of a i64x2 vector
pub inline fn vget_high_s64(vec: i64x2) i64x1 {
    return @shuffle(
        i64,
        vec,
        undefined,
        i64x1{1},
    );
}

/// Get high elements of a f16x8 vector
pub inline fn vget_high_f16(vec: f16x8) f16x4 {
    return @shuffle(
        f16,
        vec,
        undefined,
        f16x4{ 4, 5, 6, 7 },
    );
}

/// Get high elements of a f32x4 vector
pub inline fn vget_high_f32(vec: f32x4) f32x2 {
    return @shuffle(
        f32,
        vec,
        undefined,
        f32x2{ 2, 3 },
    );
}

/// Get high elements of a f64x2 vector
pub inline fn vget_high_f64(vec: f64x2) f64x1 {
    return @shuffle(
        f64,
        vec,
        undefined,
        f64x1{1},
    );
}

/// Get high elements of a u8x16 vector
pub inline fn vget_high_u8(vec: u8x16) u8x8 {
    return @shuffle(
        u8,
        vec,
        undefined,
        u8x8{ 8, 9, 10, 11, 12, 13, 14, 15 },
    );
}

/// Get high elements of a u16x8 vector
pub inline fn vget_high_u16(vec: u16x8) u16x4 {
    return @shuffle(
        u16,
        vec,
        undefined,
        u16x4{ 4, 5, 6, 7 },
    );
}

/// Get high elements of a u32x4 vector
pub inline fn vget_high_u32(vec: u32x4) u32x2 {
    return @shuffle(
        u32,
        vec,
        undefined,
        u32x2{ 2, 3 },
    );
}

/// Get high elements of a u64x2 vector
pub inline fn vget_high_u64(vec: u64x2) u64x1 {
    return @shuffle(
        u64,
        vec,
        undefined,
        u64x1{1},
    );
}

/// Get high elements of a p8x16 vector
pub inline fn vget_high_p8(vec: p8x16) p8x8 {
    return @shuffle(
        u8,
        vec,
        undefined,
        p8x8{ 8, 9, 10, 11, 12, 13, 14, 15 },
    );
}

/// Get high elements of a u16x8 vector
pub inline fn vget_high_p16(vec: p16x8) p16x4 {
    return @shuffle(
        u16,
        vec,
        undefined,
        p16x4{ 4, 5, 6, 7 },
    );
}

// Get low elements of a i8x16 vector
pub inline fn vget_low_s8(vec: i8x16) i8x8 {
    return @shuffle(
        i8,
        vec,
        undefined,
        i8x8{ 0, 1, 2, 3, 4, 5, 6, 7 },
    );
}

// Get low elements of a i16x4 vector
pub inline fn vget_low_s16(vec: i16x8) i16x4 {
    return @shuffle(
        i16,
        vec,
        undefined,
        i16x4{ 0, 1, 2, 3 },
    );
}

// Get low elements of a i32x4 vector
pub inline fn vget_low_s32(vec: i32x4) i32x2 {
    return @shuffle(
        i32,
        vec,
        undefined,
        i32x2{ 0, 1 },
    );
}

// Get low elements of a i64x2 vector
pub inline fn vget_low_s64(vec: i64x2) i64x1 {
    return @shuffle(
        i64,
        vec,
        undefined,
        i64x1{0},
    );
}

// Get low elements of a u8x16 vector
pub inline fn vget_low_u8(vec: u8x16) u8x8 {
    return @shuffle(
        u8,
        vec,
        undefined,
        u8x8{ 0, 1, 2, 3, 4, 5, 6, 7 },
    );
}

// Get low elements of a u16x8 vector
pub inline fn vget_low_u16(vec: u16x8) u16x4 {
    return @shuffle(
        u16,
        vec,
        undefined,
        u16x4{ 0, 1, 2, 3 },
    );
}

// Get low elements of a u32x4 vector
pub inline fn vget_low_u32(vec: u32x4) u32x2 {
    return @shuffle(
        u32,
        vec,
        undefined,
        u32x2{ 0, 1 },
    );
}

// Get low elements of a u64x2 vector
pub inline fn vget_low_u64(vec: u64x2) u64x1 {
    return @shuffle(
        u64,
        vec,
        undefined,
        u64x1{0},
    );
}

// Get low elements of a p8x16 vector
pub inline fn vget_low_p8(vec: p8x16) p8x8 {
    return @shuffle(
        p8,
        vec,
        undefined,
        p8x8{ 0, 1, 2, 3, 4, 5, 6, 7 },
    );
}

// Get low elements of a p16x8 vector
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
    const a_lo = vget_low_u8(a);
    const a_hi = vget_high_u8(a);
    const b_lo = vget_low_u8(b);
    const b_hi = vget_high_u8(b);

    const result_lo: u8x8 = @truncate(@abs(@as(i16x8, a_lo) - @as(i16x8, b_lo)));
    const result_hi: u8x8 = @truncate(@abs(@as(i16x8, a_hi) - @as(i16x8, b_hi)));

    return .{
        result_lo[0],
        result_lo[1],
        result_lo[2],
        result_lo[3],
        result_lo[4],
        result_lo[5],
        result_lo[6],
        result_lo[7],
        result_hi[0],
        result_hi[1],
        result_hi[2],
        result_hi[3],
        result_hi[4],
        result_hi[5],
        result_hi[6],
        result_hi[7],
    };
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
    const a_lo = vget_low_u16(a);
    const a_hi = vget_high_u16(a);
    const b_lo = vget_low_u16(b);
    const b_hi = vget_high_u16(b);

    const result_lo: u16x4 = @truncate(@abs(@as(i32x4, a_lo) - @as(i32x4, b_lo)));
    const result_hi: u16x4 = @truncate(@abs(@as(i32x4, a_hi) - @as(i32x4, b_hi)));

    return .{
        result_lo[0],
        result_lo[1],
        result_lo[2],
        result_lo[3],
        result_hi[0],
        result_hi[1],
        result_hi[2],
        result_hi[3],
    };
}

test vabdq_u16 {
    const a: u16x8 = .{ 1, 2, 3, 4, 1, 2, 3, 4 };
    const b: u16x8 = .{ 16, 15, 14, 13, 16, 15, 14, 13 };

    const expected: u16x8 = .{ 15, 13, 11, 9, 15, 13, 11, 9 };

    try expectEqual(expected, vabdq_u16(a, b));
}

/// signed absolute difference and accumulate (128-bit)
pub inline fn vabdq_u32(a: u32x4, b: u32x4) u32x4 {
    const a_lo = vget_low_u32(a);
    const a_hi = vget_high_u32(a);
    const b_lo = vget_low_u32(b);
    const b_hi = vget_high_u32(b);

    const result_lo: u32x2 = @truncate(@abs(@as(i64x2, a_lo) - @as(i64x2, b_lo)));
    const result_hi: u32x2 = @truncate(@abs(@as(i64x2, a_hi) - @as(i64x2, b_hi)));

    return .{
        result_lo[0],
        result_lo[1],
        result_hi[0],
        result_hi[1],
    };
}

test vabdq_u32 {
    const a: u32x4 = .{ 1, 2, 1, 2 };
    const b: u32x4 = .{ 16, 15, 16, 15 };

    const expected: u32x4 = .{ 15, 13, 15, 13 };

    try expectEqual(expected, vabdq_u32(a, b));
}

/// signed absolute difference and accumulate (128-bit)
pub inline fn vabdq_f32(a: f32x4, b: f32x4) f32x4 {
    return @abs(a - b);
}

test vabdq_f32 {
    const a: f32x4 = .{ 0.00, 0.00, 0.00, 0.00 };
    const b: f32x4 = .{ 0.19, 0.15, 0.19, 0.15 };

    const expected: f32x4 = .{ @abs(0.00 - 0.19), @abs(0.00 - 0.15), @abs(0.00 - 0.19), @abs(0.00 - 0.15) };

    try expectEqual(expected, vabdq_f32(a, b));
}

/// signed absolute difference and accumulate (128-bit)
pub inline fn vabdq_f64(a: f64x2, b: f64x2) f64x2 {
    return @abs(a - b);
}

test vabdq_f64 {
    const a: f64x2 = .{ 0.01, 0.01 };
    const b: f64x2 = .{ 0.16, 0.16 };

    const expected: f64x2 = .{ 0.15, 0.15 };

    try expectEqual(expected, vabdq_f64(a, b));
}

/// Signed Absolute difference Long
pub inline fn vabdl_s8(a: i8x8, b: i8x8) i16x8 {
    return @abs(a - b);
}

test vabdl_s8 {
    const a: i8x8 = .{ 1, 2, 3, 4, 5, 6, 7, 8 };
    const b: i8x8 = .{ 16, 15, 14, 13, 12, 11, 10, 9 };

    const expected: i16x8 = .{ 15, 13, 11, 9, 7, 5, 3, 1 };

    try expectEqual(expected, vabdl_s8(a, b));
}

/// Signed Absolute difference Long
pub inline fn vabdl_s16(a: i16x4, b: i16x4) i32x4 {
    return @abs(a - b);
}

test vabdl_s16 {
    const a: i16x4 = .{ 1, 2, 3, 4 };
    const b: i16x4 = .{ 16, 15, 14, 13 };

    const expected: i32x4 = .{ 15, 13, 11, 9 };

    try expectEqual(expected, vabdl_s16(a, b));
}

/// Signed Absolute difference Long
pub inline fn vabdl_s32(a: i32x2, b: i32x2) i64x2 {
    return @abs(a - b);
}

test vabdl_s32 {
    const a: i32x2 = .{ 1, 2 };
    const b: i32x2 = .{ 16, 15 };

    const expected: i64x2 = .{ 15, 13 };

    try expectEqual(expected, vabdl_s32(a, b));
}

/// Signed Absolute difference Long
pub inline fn vabdl_u8(a: u8x8, b: u8x8) u16x8 {
    return @bitCast(@abs(@as(i16x8, @intCast(a)) - @as(i16x8, @intCast(b))));
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

/// Signed Absolute difference Long
pub inline fn vabdl_u16(a: u16x4, b: u16x4) u32x4 {
    return @bitCast(@abs(@as(i32x4, @intCast(a)) - @as(i32x4, @intCast(b))));
}

test vabdl_u16 {
    const a: u16x4 = .{ 1, 2, 3, 4 };
    const b: u16x4 = .{ 16, 15, 14, 13 };

    const expected: u32x4 = .{ 15, 13, 11, 9 };

    try expectEqual(expected, vabdl_u16(a, b));
}

/// Signed Absolute difference Long
pub inline fn vabdl_u32(a: u32x2, b: u32x2) u64x2 {
    return @bitCast(@abs(@as(i64x2, @intCast(a)) - @as(i64x2, @intCast(b))));
}

test vabdl_u32 {
    const a: u32x2 = .{ 1, 2 };
    const b: u32x2 = .{ 16, 15 };

    const expected: u64x2 = .{ 15, 13 };

    try expectEqual(expected, vabdl_u32(a, b));
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
