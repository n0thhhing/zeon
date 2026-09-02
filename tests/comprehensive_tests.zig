const neon = @import("zeon");
const std = @import("std");

var global_buffer: [1024]u8 = undefined;


fn makeData(comptime T: type, offset: usize) T {
    switch (@typeInfo(T)) {
        .@"struct" => {
            var res: T = undefined;
            const fields = std.meta.fields(T);
            inline for (0..fields.len) |i| {
                res[i] = makeData(fields[i].type, offset + i * 10);
            }
            return res;
        },
        .vector => |v| {
            var res: T = undefined;
            const len = v.len;
            const Child = v.child;
            inline for (0..len) |i| {
                const val: usize = (i + offset) % 127;
                switch (@typeInfo(Child)) {
                    .float => res[i] = @as(Child, @floatFromInt(val)),
                    else => res[i] = @as(Child, @intCast(val)),
                }
            }
            return res;
        },
        .int => return @as(T, @intCast(offset % 127)),
        else => if (@typeInfo(T) == .int) return @as(T, @intCast(offset % 127)) else @compileError("Unsupported type for makeData"),
    }
}

fn expectEqualApprox(expected: anytype, actual: @TypeOf(expected)) !void {
    const T = @TypeOf(expected);
    switch (@typeInfo(T)) {
        .@"struct" => {
            const fields = std.meta.fields(T);
            inline for (0..fields.len) |i| {
                try expectEqualApprox(expected[i], actual[i]);
            }
            return;
        },
        .vector => |v| {
            const Child = v.child;
            const len = v.len;
            inline for (0..len) |i| {
                switch (@typeInfo(Child)) {
                    .float => {
                        if (!(std.math.isNan(expected[i]) and std.math.isNan(actual[i]))) {
                            try std.testing.expectApproxEqAbs(expected[i], actual[i], 0.0001);
                        }
                    },
                    else => try std.testing.expectEqual(expected[i], actual[i]),
                }
            }
        },
        else => return std.testing.expectEqual(expected, actual),
    }
}
test "vshr_n_s8" {
    const arg0 = comptime makeData(neon.i8x8, 0);
    const arg1: usize = 0;
    const expected = comptime neon.vshr_n_s8(arg0, arg1);
    const actual = neon.vshr_n_s8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vshr_n_s16" {
    const arg0 = comptime makeData(neon.i16x4, 0);
    const arg1: usize = 0;
    const expected = comptime neon.vshr_n_s16(arg0, arg1);
    const actual = neon.vshr_n_s16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vshr_n_s32" {
    const arg0 = comptime makeData(neon.i32x2, 0);
    const arg1: usize = 0;
    const expected = comptime neon.vshr_n_s32(arg0, arg1);
    const actual = neon.vshr_n_s32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vshr_n_s64" {
    const arg0 = comptime makeData(neon.i64x1, 0);
    const arg1: usize = 0;
    const expected = comptime neon.vshr_n_s64(arg0, arg1);
    const actual = neon.vshr_n_s64(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vshr_n_u8" {
    const arg0 = comptime makeData(neon.u8x8, 0);
    const arg1: usize = 0;
    const expected = comptime neon.vshr_n_u8(arg0, arg1);
    const actual = neon.vshr_n_u8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vshr_n_u16" {
    const arg0 = comptime makeData(neon.u16x4, 0);
    const arg1: usize = 0;
    const expected = comptime neon.vshr_n_u16(arg0, arg1);
    const actual = neon.vshr_n_u16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vshr_n_u32" {
    const arg0 = comptime makeData(neon.u32x2, 0);
    const arg1: usize = 0;
    const expected = comptime neon.vshr_n_u32(arg0, arg1);
    const actual = neon.vshr_n_u32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vshr_n_u64" {
    const arg0 = comptime makeData(neon.u64x1, 0);
    const arg1: usize = 0;
    const expected = comptime neon.vshr_n_u64(arg0, arg1);
    const actual = neon.vshr_n_u64(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vshrq_n_s8" {
    const arg0 = comptime makeData(neon.i8x16, 0);
    const arg1: usize = 0;
    const expected = comptime neon.vshrq_n_s8(arg0, arg1);
    const actual = neon.vshrq_n_s8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vshrq_n_s16" {
    const arg0 = comptime makeData(neon.i16x8, 0);
    const arg1: usize = 0;
    const expected = comptime neon.vshrq_n_s16(arg0, arg1);
    const actual = neon.vshrq_n_s16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vshrq_n_s32" {
    const arg0 = comptime makeData(neon.i32x4, 0);
    const arg1: usize = 0;
    const expected = comptime neon.vshrq_n_s32(arg0, arg1);
    const actual = neon.vshrq_n_s32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vshrq_n_s64" {
    const arg0 = comptime makeData(neon.i64x2, 0);
    const arg1: usize = 0;
    const expected = comptime neon.vshrq_n_s64(arg0, arg1);
    const actual = neon.vshrq_n_s64(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vshrq_n_u8" {
    const arg0 = comptime makeData(neon.u8x16, 0);
    const arg1: usize = 0;
    const expected = comptime neon.vshrq_n_u8(arg0, arg1);
    const actual = neon.vshrq_n_u8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vshrq_n_u16" {
    const arg0 = comptime makeData(neon.u16x8, 0);
    const arg1: usize = 0;
    const expected = comptime neon.vshrq_n_u16(arg0, arg1);
    const actual = neon.vshrq_n_u16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vshrq_n_u32" {
    const arg0 = comptime makeData(neon.u32x4, 0);
    const arg1: usize = 0;
    const expected = comptime neon.vshrq_n_u32(arg0, arg1);
    const actual = neon.vshrq_n_u32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vshrq_n_u64" {
    const arg0 = comptime makeData(neon.u64x2, 0);
    const arg1: usize = 0;
    const expected = comptime neon.vshrq_n_u64(arg0, arg1);
    const actual = neon.vshrq_n_u64(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vshl_n_s8" {
    const arg0 = comptime makeData(neon.i8x8, 0);
    const arg1: usize = 0;
    const expected = comptime neon.vshl_n_s8(arg0, arg1);
    const actual = neon.vshl_n_s8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vshl_n_s16" {
    const arg0 = comptime makeData(neon.i16x4, 0);
    const arg1: usize = 0;
    const expected = comptime neon.vshl_n_s16(arg0, arg1);
    const actual = neon.vshl_n_s16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vshl_n_s32" {
    const arg0 = comptime makeData(neon.i32x2, 0);
    const arg1: usize = 0;
    const expected = comptime neon.vshl_n_s32(arg0, arg1);
    const actual = neon.vshl_n_s32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vshl_n_s64" {
    const arg0 = comptime makeData(neon.i64x1, 0);
    const arg1: usize = 0;
    const expected = comptime neon.vshl_n_s64(arg0, arg1);
    const actual = neon.vshl_n_s64(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vshl_n_u8" {
    const arg0 = comptime makeData(neon.u8x8, 0);
    const arg1: usize = 0;
    const expected = comptime neon.vshl_n_u8(arg0, arg1);
    const actual = neon.vshl_n_u8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vshl_n_u16" {
    const arg0 = comptime makeData(neon.u16x4, 0);
    const arg1: usize = 0;
    const expected = comptime neon.vshl_n_u16(arg0, arg1);
    const actual = neon.vshl_n_u16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vshl_n_u32" {
    const arg0 = comptime makeData(neon.u32x2, 0);
    const arg1: usize = 0;
    const expected = comptime neon.vshl_n_u32(arg0, arg1);
    const actual = neon.vshl_n_u32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vshl_n_u64" {
    const arg0 = comptime makeData(neon.u64x1, 0);
    const arg1: usize = 0;
    const expected = comptime neon.vshl_n_u64(arg0, arg1);
    const actual = neon.vshl_n_u64(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vshlq_n_s8" {
    const arg0 = comptime makeData(neon.i8x16, 0);
    const arg1: usize = 0;
    const expected = comptime neon.vshlq_n_s8(arg0, arg1);
    const actual = neon.vshlq_n_s8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vshlq_n_s16" {
    const arg0 = comptime makeData(neon.i16x8, 0);
    const arg1: usize = 0;
    const expected = comptime neon.vshlq_n_s16(arg0, arg1);
    const actual = neon.vshlq_n_s16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vshlq_n_s32" {
    const arg0 = comptime makeData(neon.i32x4, 0);
    const arg1: usize = 0;
    const expected = comptime neon.vshlq_n_s32(arg0, arg1);
    const actual = neon.vshlq_n_s32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vshlq_n_s64" {
    const arg0 = comptime makeData(neon.i64x2, 0);
    const arg1: usize = 0;
    const expected = comptime neon.vshlq_n_s64(arg0, arg1);
    const actual = neon.vshlq_n_s64(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vshlq_n_u8" {
    const arg0 = comptime makeData(neon.u8x16, 0);
    const arg1: usize = 0;
    const expected = comptime neon.vshlq_n_u8(arg0, arg1);
    const actual = neon.vshlq_n_u8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vshlq_n_u16" {
    const arg0 = comptime makeData(neon.u16x8, 0);
    const arg1: usize = 0;
    const expected = comptime neon.vshlq_n_u16(arg0, arg1);
    const actual = neon.vshlq_n_u16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vshlq_n_u32" {
    const arg0 = comptime makeData(neon.u32x4, 0);
    const arg1: usize = 0;
    const expected = comptime neon.vshlq_n_u32(arg0, arg1);
    const actual = neon.vshlq_n_u32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vshlq_n_u64" {
    const arg0 = comptime makeData(neon.u64x2, 0);
    const arg1: usize = 0;
    const expected = comptime neon.vshlq_n_u64(arg0, arg1);
    const actual = neon.vshlq_n_u64(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vsra_n_s8" {
    const arg0 = comptime makeData(neon.i8x8, 0);
    const arg1 = comptime makeData(neon.i8x8, 13);
    const arg2: usize = 0;
    const expected = comptime neon.vsra_n_s8(arg0, arg1, arg2);
    const actual = neon.vsra_n_s8(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vsra_n_s16" {
    const arg0 = comptime makeData(neon.i16x4, 0);
    const arg1 = comptime makeData(neon.i16x4, 13);
    const arg2: usize = 0;
    const expected = comptime neon.vsra_n_s16(arg0, arg1, arg2);
    const actual = neon.vsra_n_s16(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vsra_n_s32" {
    const arg0 = comptime makeData(neon.i32x2, 0);
    const arg1 = comptime makeData(neon.i32x2, 13);
    const arg2: usize = 0;
    const expected = comptime neon.vsra_n_s32(arg0, arg1, arg2);
    const actual = neon.vsra_n_s32(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vsra_n_s64" {
    const arg0 = comptime makeData(neon.i64x1, 0);
    const arg1 = comptime makeData(neon.i64x1, 13);
    const arg2: usize = 0;
    const expected = comptime neon.vsra_n_s64(arg0, arg1, arg2);
    const actual = neon.vsra_n_s64(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vsra_n_u8" {
    const arg0 = comptime makeData(neon.u8x8, 0);
    const arg1 = comptime makeData(neon.u8x8, 13);
    const arg2: usize = 0;
    const expected = comptime neon.vsra_n_u8(arg0, arg1, arg2);
    const actual = neon.vsra_n_u8(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vsra_n_u16" {
    const arg0 = comptime makeData(neon.u16x4, 0);
    const arg1 = comptime makeData(neon.u16x4, 13);
    const arg2: usize = 0;
    const expected = comptime neon.vsra_n_u16(arg0, arg1, arg2);
    const actual = neon.vsra_n_u16(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vsra_n_u32" {
    const arg0 = comptime makeData(neon.u32x2, 0);
    const arg1 = comptime makeData(neon.u32x2, 13);
    const arg2: usize = 0;
    const expected = comptime neon.vsra_n_u32(arg0, arg1, arg2);
    const actual = neon.vsra_n_u32(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vsra_n_u64" {
    const arg0 = comptime makeData(neon.u64x1, 0);
    const arg1 = comptime makeData(neon.u64x1, 13);
    const arg2: usize = 0;
    const expected = comptime neon.vsra_n_u64(arg0, arg1, arg2);
    const actual = neon.vsra_n_u64(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vsraq_n_s8" {
    const arg0 = comptime makeData(neon.i8x16, 0);
    const arg1 = comptime makeData(neon.i8x16, 13);
    const arg2: usize = 0;
    const expected = comptime neon.vsraq_n_s8(arg0, arg1, arg2);
    const actual = neon.vsraq_n_s8(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vsraq_n_s16" {
    const arg0 = comptime makeData(neon.i16x8, 0);
    const arg1 = comptime makeData(neon.i16x8, 13);
    const arg2: usize = 0;
    const expected = comptime neon.vsraq_n_s16(arg0, arg1, arg2);
    const actual = neon.vsraq_n_s16(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vsraq_n_s32" {
    const arg0 = comptime makeData(neon.i32x4, 0);
    const arg1 = comptime makeData(neon.i32x4, 13);
    const arg2: usize = 0;
    const expected = comptime neon.vsraq_n_s32(arg0, arg1, arg2);
    const actual = neon.vsraq_n_s32(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vsraq_n_s64" {
    const arg0 = comptime makeData(neon.i64x2, 0);
    const arg1 = comptime makeData(neon.i64x2, 13);
    const arg2: usize = 0;
    const expected = comptime neon.vsraq_n_s64(arg0, arg1, arg2);
    const actual = neon.vsraq_n_s64(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vsraq_n_u8" {
    const arg0 = comptime makeData(neon.u8x16, 0);
    const arg1 = comptime makeData(neon.u8x16, 13);
    const arg2: usize = 0;
    const expected = comptime neon.vsraq_n_u8(arg0, arg1, arg2);
    const actual = neon.vsraq_n_u8(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vsraq_n_u16" {
    const arg0 = comptime makeData(neon.u16x8, 0);
    const arg1 = comptime makeData(neon.u16x8, 13);
    const arg2: usize = 0;
    const expected = comptime neon.vsraq_n_u16(arg0, arg1, arg2);
    const actual = neon.vsraq_n_u16(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vsraq_n_u32" {
    const arg0 = comptime makeData(neon.u32x4, 0);
    const arg1 = comptime makeData(neon.u32x4, 13);
    const arg2: usize = 0;
    const expected = comptime neon.vsraq_n_u32(arg0, arg1, arg2);
    const actual = neon.vsraq_n_u32(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vsraq_n_u64" {
    const arg0 = comptime makeData(neon.u64x2, 0);
    const arg1 = comptime makeData(neon.u64x2, 13);
    const arg2: usize = 0;
    const expected = comptime neon.vsraq_n_u64(arg0, arg1, arg2);
    const actual = neon.vsraq_n_u64(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vshrn_n_s16" {
    const arg0 = comptime makeData(neon.i16x8, 0);
    const arg1: usize = 0;
    const expected = comptime neon.vshrn_n_s16(arg0, arg1);
    const actual = neon.vshrn_n_s16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vshrn_n_s32" {
    const arg0 = comptime makeData(neon.i32x4, 0);
    const arg1: usize = 0;
    const expected = comptime neon.vshrn_n_s32(arg0, arg1);
    const actual = neon.vshrn_n_s32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vshrn_n_s64" {
    const arg0 = comptime makeData(neon.i64x2, 0);
    const arg1: usize = 0;
    const expected = comptime neon.vshrn_n_s64(arg0, arg1);
    const actual = neon.vshrn_n_s64(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vshrn_n_u16" {
    const arg0 = comptime makeData(neon.u16x8, 0);
    const arg1: usize = 0;
    const expected = comptime neon.vshrn_n_u16(arg0, arg1);
    const actual = neon.vshrn_n_u16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vshrn_n_u32" {
    const arg0 = comptime makeData(neon.u32x4, 0);
    const arg1: usize = 0;
    const expected = comptime neon.vshrn_n_u32(arg0, arg1);
    const actual = neon.vshrn_n_u32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vshrn_n_u64" {
    const arg0 = comptime makeData(neon.u64x2, 0);
    const arg1: usize = 0;
    const expected = comptime neon.vshrn_n_u64(arg0, arg1);
    const actual = neon.vshrn_n_u64(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vshl_s8" {
    const arg0 = comptime makeData(neon.i8x8, 0);
    const arg1 = comptime makeData(neon.i8x8, 13);
    _ = neon.vshl_s8(arg0, arg1);
}

test "vshl_u8" {
    const arg0 = comptime makeData(neon.u8x8, 0);
    const arg1 = comptime makeData(neon.i8x8, 13);
    _ = neon.vshl_u8(arg0, arg1);
}

test "vshlq_s8" {
    const arg0 = comptime makeData(neon.i8x16, 0);
    const arg1 = comptime makeData(neon.i8x16, 13);
    _ = neon.vshlq_s8(arg0, arg1);
}

test "vshlq_u8" {
    const arg0 = comptime makeData(neon.u8x16, 0);
    const arg1 = comptime makeData(neon.i8x16, 13);
    _ = neon.vshlq_u8(arg0, arg1);
}

test "vadd_s8" {
    const arg0 = comptime makeData(neon.i8x8, 0);
    const arg1 = comptime makeData(neon.i8x8, 13);
    const expected = comptime neon.vadd_s8(arg0, arg1);
    const actual = neon.vadd_s8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vadd_s16" {
    const arg0 = comptime makeData(neon.i16x4, 0);
    const arg1 = comptime makeData(neon.i16x4, 13);
    const expected = comptime neon.vadd_s16(arg0, arg1);
    const actual = neon.vadd_s16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vadd_s32" {
    const arg0 = comptime makeData(neon.i32x2, 0);
    const arg1 = comptime makeData(neon.i32x2, 13);
    const expected = comptime neon.vadd_s32(arg0, arg1);
    const actual = neon.vadd_s32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vadd_s64" {
    const arg0 = comptime makeData(neon.i64x1, 0);
    const arg1 = comptime makeData(neon.i64x1, 13);
    const expected = comptime neon.vadd_s64(arg0, arg1);
    const actual = neon.vadd_s64(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vadd_u8" {
    const arg0 = comptime makeData(neon.u8x8, 0);
    const arg1 = comptime makeData(neon.u8x8, 13);
    const expected = comptime neon.vadd_u8(arg0, arg1);
    const actual = neon.vadd_u8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vadd_u16" {
    const arg0 = comptime makeData(neon.u16x4, 0);
    const arg1 = comptime makeData(neon.u16x4, 13);
    const expected = comptime neon.vadd_u16(arg0, arg1);
    const actual = neon.vadd_u16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vadd_u32" {
    const arg0 = comptime makeData(neon.u32x2, 0);
    const arg1 = comptime makeData(neon.u32x2, 13);
    const expected = comptime neon.vadd_u32(arg0, arg1);
    const actual = neon.vadd_u32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vadd_u64" {
    const arg0 = comptime makeData(neon.u64x1, 0);
    const arg1 = comptime makeData(neon.u64x1, 13);
    const expected = comptime neon.vadd_u64(arg0, arg1);
    const actual = neon.vadd_u64(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vadd_f16" {
    const arg0 = comptime makeData(neon.f16x4, 0);
    const arg1 = comptime makeData(neon.f16x4, 13);
    const expected = comptime neon.vadd_f16(arg0, arg1);
    const actual = neon.vadd_f16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vadd_f32" {
    const arg0 = comptime makeData(neon.f32x2, 0);
    const arg1 = comptime makeData(neon.f32x2, 13);
    const expected = comptime neon.vadd_f32(arg0, arg1);
    const actual = neon.vadd_f32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vadd_f64" {
    const arg0 = comptime makeData(neon.f64x1, 0);
    const arg1 = comptime makeData(neon.f64x1, 13);
    const expected = comptime neon.vadd_f64(arg0, arg1);
    const actual = neon.vadd_f64(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vadd_p8" {
    const arg0 = comptime makeData(neon.p8x8, 0);
    const arg1 = comptime makeData(neon.p8x8, 13);
    const expected = comptime neon.vadd_p8(arg0, arg1);
    const actual = neon.vadd_p8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vadd_p16" {
    const arg0 = comptime makeData(neon.p16x4, 0);
    const arg1 = comptime makeData(neon.p16x4, 13);
    const expected = comptime neon.vadd_p16(arg0, arg1);
    const actual = neon.vadd_p16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vadd_p64" {
    const arg0 = comptime makeData(neon.p64x1, 0);
    const arg1 = comptime makeData(neon.p64x1, 13);
    const expected = comptime neon.vadd_p64(arg0, arg1);
    const actual = neon.vadd_p64(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vaddd_s64" {
    const arg0: i64 = 1;
    const arg1: i64 = 1;
    const expected = comptime neon.vaddd_s64(arg0, arg1);
    const actual = neon.vaddd_s64(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vaddd_u64" {
    const arg0: u64 = 1;
    const arg1: u64 = 1;
    const expected = comptime neon.vaddd_u64(arg0, arg1);
    const actual = neon.vaddd_u64(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vaddq_s8" {
    const arg0 = comptime makeData(neon.i8x16, 0);
    const arg1 = comptime makeData(neon.i8x16, 13);
    const expected = comptime neon.vaddq_s8(arg0, arg1);
    const actual = neon.vaddq_s8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vaddq_s16" {
    const arg0 = comptime makeData(neon.i16x8, 0);
    const arg1 = comptime makeData(neon.i16x8, 13);
    const expected = comptime neon.vaddq_s16(arg0, arg1);
    const actual = neon.vaddq_s16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vaddq_s32" {
    const arg0 = comptime makeData(neon.i32x4, 0);
    const arg1 = comptime makeData(neon.i32x4, 13);
    const expected = comptime neon.vaddq_s32(arg0, arg1);
    const actual = neon.vaddq_s32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vaddq_s64" {
    const arg0 = comptime makeData(neon.i64x2, 0);
    const arg1 = comptime makeData(neon.i64x2, 13);
    const expected = comptime neon.vaddq_s64(arg0, arg1);
    const actual = neon.vaddq_s64(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vaddq_u8" {
    const arg0 = comptime makeData(neon.u8x16, 0);
    const arg1 = comptime makeData(neon.u8x16, 13);
    const expected = comptime neon.vaddq_u8(arg0, arg1);
    const actual = neon.vaddq_u8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vaddq_u16" {
    const arg0 = comptime makeData(neon.u16x8, 0);
    const arg1 = comptime makeData(neon.u16x8, 13);
    const expected = comptime neon.vaddq_u16(arg0, arg1);
    const actual = neon.vaddq_u16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vaddq_u32" {
    const arg0 = comptime makeData(neon.u32x4, 0);
    const arg1 = comptime makeData(neon.u32x4, 13);
    const expected = comptime neon.vaddq_u32(arg0, arg1);
    const actual = neon.vaddq_u32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vaddq_u64" {
    const arg0 = comptime makeData(neon.u64x2, 0);
    const arg1 = comptime makeData(neon.u64x2, 13);
    const expected = comptime neon.vaddq_u64(arg0, arg1);
    const actual = neon.vaddq_u64(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vaddq_f16" {
    const arg0 = comptime makeData(neon.f16x8, 0);
    const arg1 = comptime makeData(neon.f16x8, 13);
    const expected = comptime neon.vaddq_f16(arg0, arg1);
    const actual = neon.vaddq_f16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vaddq_f32" {
    const arg0 = comptime makeData(neon.f32x4, 0);
    const arg1 = comptime makeData(neon.f32x4, 13);
    const expected = comptime neon.vaddq_f32(arg0, arg1);
    const actual = neon.vaddq_f32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vaddq_f64" {
    const arg0 = comptime makeData(neon.f64x2, 0);
    const arg1 = comptime makeData(neon.f64x2, 13);
    const expected = comptime neon.vaddq_f64(arg0, arg1);
    const actual = neon.vaddq_f64(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vaddq_p8" {
    const arg0 = comptime makeData(neon.p8x16, 0);
    const arg1 = comptime makeData(neon.p8x16, 13);
    const expected = comptime neon.vaddq_p8(arg0, arg1);
    const actual = neon.vaddq_p8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vaddq_p16" {
    const arg0 = comptime makeData(neon.p16x8, 0);
    const arg1 = comptime makeData(neon.p16x8, 13);
    const expected = comptime neon.vaddq_p16(arg0, arg1);
    const actual = neon.vaddq_p16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vaddq_p64" {
    const arg0 = comptime makeData(neon.p64x2, 0);
    const arg1 = comptime makeData(neon.p64x2, 13);
    const expected = comptime neon.vaddq_p64(arg0, arg1);
    const actual = neon.vaddq_p64(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vaddq_p128" {
    const arg0 = comptime makeData(@Vector(1, neon.p128), 0);
    const arg1 = comptime makeData(@Vector(1, neon.p128), 13);
    const expected = comptime neon.vaddq_p128(arg0, arg1);
    const actual = neon.vaddq_p128(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vsub_s8" {
    const arg0 = comptime makeData(neon.i8x8, 0);
    const arg1 = comptime makeData(neon.i8x8, 13);
    const expected = comptime neon.vsub_s8(arg0, arg1);
    const actual = neon.vsub_s8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vsub_s16" {
    const arg0 = comptime makeData(neon.i16x4, 0);
    const arg1 = comptime makeData(neon.i16x4, 13);
    const expected = comptime neon.vsub_s16(arg0, arg1);
    const actual = neon.vsub_s16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vsub_s32" {
    const arg0 = comptime makeData(neon.i32x2, 0);
    const arg1 = comptime makeData(neon.i32x2, 13);
    const expected = comptime neon.vsub_s32(arg0, arg1);
    const actual = neon.vsub_s32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vsub_s64" {
    const arg0 = comptime makeData(neon.i64x1, 0);
    const arg1 = comptime makeData(neon.i64x1, 13);
    const expected = comptime neon.vsub_s64(arg0, arg1);
    const actual = neon.vsub_s64(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vsub_u8" {
    const arg0 = comptime makeData(neon.u8x8, 0);
    const arg1 = comptime makeData(neon.u8x8, 13);
    const expected = comptime neon.vsub_u8(arg0, arg1);
    const actual = neon.vsub_u8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vsub_u16" {
    const arg0 = comptime makeData(neon.u16x4, 0);
    const arg1 = comptime makeData(neon.u16x4, 13);
    const expected = comptime neon.vsub_u16(arg0, arg1);
    const actual = neon.vsub_u16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vsub_u32" {
    const arg0 = comptime makeData(neon.u32x2, 0);
    const arg1 = comptime makeData(neon.u32x2, 13);
    const expected = comptime neon.vsub_u32(arg0, arg1);
    const actual = neon.vsub_u32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vsub_u64" {
    const arg0 = comptime makeData(neon.u64x1, 0);
    const arg1 = comptime makeData(neon.u64x1, 13);
    const expected = comptime neon.vsub_u64(arg0, arg1);
    const actual = neon.vsub_u64(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vsub_f16" {
    const arg0 = comptime makeData(neon.f16x4, 0);
    const arg1 = comptime makeData(neon.f16x4, 13);
    const expected = comptime neon.vsub_f16(arg0, arg1);
    const actual = neon.vsub_f16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vsub_f32" {
    const arg0 = comptime makeData(neon.f32x2, 0);
    const arg1 = comptime makeData(neon.f32x2, 13);
    const expected = comptime neon.vsub_f32(arg0, arg1);
    const actual = neon.vsub_f32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vsub_f64" {
    const arg0 = comptime makeData(neon.f64x1, 0);
    const arg1 = comptime makeData(neon.f64x1, 13);
    const expected = comptime neon.vsub_f64(arg0, arg1);
    const actual = neon.vsub_f64(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vsubq_s8" {
    const arg0 = comptime makeData(neon.i8x16, 0);
    const arg1 = comptime makeData(neon.i8x16, 13);
    const expected = comptime neon.vsubq_s8(arg0, arg1);
    const actual = neon.vsubq_s8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vsubq_s16" {
    const arg0 = comptime makeData(neon.i16x8, 0);
    const arg1 = comptime makeData(neon.i16x8, 13);
    const expected = comptime neon.vsubq_s16(arg0, arg1);
    const actual = neon.vsubq_s16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vsubq_s32" {
    const arg0 = comptime makeData(neon.i32x4, 0);
    const arg1 = comptime makeData(neon.i32x4, 13);
    const expected = comptime neon.vsubq_s32(arg0, arg1);
    const actual = neon.vsubq_s32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vsubq_s64" {
    const arg0 = comptime makeData(neon.i64x2, 0);
    const arg1 = comptime makeData(neon.i64x2, 13);
    const expected = comptime neon.vsubq_s64(arg0, arg1);
    const actual = neon.vsubq_s64(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vsubq_u8" {
    const arg0 = comptime makeData(neon.u8x16, 0);
    const arg1 = comptime makeData(neon.u8x16, 13);
    const expected = comptime neon.vsubq_u8(arg0, arg1);
    const actual = neon.vsubq_u8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vsubq_u16" {
    const arg0 = comptime makeData(neon.u16x8, 0);
    const arg1 = comptime makeData(neon.u16x8, 13);
    const expected = comptime neon.vsubq_u16(arg0, arg1);
    const actual = neon.vsubq_u16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vsubq_u32" {
    const arg0 = comptime makeData(neon.u32x4, 0);
    const arg1 = comptime makeData(neon.u32x4, 13);
    const expected = comptime neon.vsubq_u32(arg0, arg1);
    const actual = neon.vsubq_u32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vsubq_u64" {
    const arg0 = comptime makeData(neon.u64x2, 0);
    const arg1 = comptime makeData(neon.u64x2, 13);
    const expected = comptime neon.vsubq_u64(arg0, arg1);
    const actual = neon.vsubq_u64(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vsubq_f16" {
    const arg0 = comptime makeData(neon.f16x8, 0);
    const arg1 = comptime makeData(neon.f16x8, 13);
    const expected = comptime neon.vsubq_f16(arg0, arg1);
    const actual = neon.vsubq_f16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vsubq_f32" {
    const arg0 = comptime makeData(neon.f32x4, 0);
    const arg1 = comptime makeData(neon.f32x4, 13);
    const expected = comptime neon.vsubq_f32(arg0, arg1);
    const actual = neon.vsubq_f32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vsubq_f64" {
    const arg0 = comptime makeData(neon.f64x2, 0);
    const arg1 = comptime makeData(neon.f64x2, 13);
    const expected = comptime neon.vsubq_f64(arg0, arg1);
    const actual = neon.vsubq_f64(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vneg_s8" {
    const arg0 = comptime makeData(neon.i8x8, 0);
    const expected = comptime neon.vneg_s8(arg0);
    const actual = neon.vneg_s8(arg0);
    try expectEqualApprox(expected, actual);
}

test "vneg_s16" {
    const arg0 = comptime makeData(neon.i16x4, 0);
    const expected = comptime neon.vneg_s16(arg0);
    const actual = neon.vneg_s16(arg0);
    try expectEqualApprox(expected, actual);
}

test "vneg_s32" {
    const arg0 = comptime makeData(neon.i32x2, 0);
    const expected = comptime neon.vneg_s32(arg0);
    const actual = neon.vneg_s32(arg0);
    try expectEqualApprox(expected, actual);
}

test "vneg_s64" {
    const arg0 = comptime makeData(neon.i64x1, 0);
    const expected = comptime neon.vneg_s64(arg0);
    const actual = neon.vneg_s64(arg0);
    try expectEqualApprox(expected, actual);
}

test "vneg_f16" {
    const arg0 = comptime makeData(neon.f16x4, 0);
    const expected = comptime neon.vneg_f16(arg0);
    const actual = neon.vneg_f16(arg0);
    try expectEqualApprox(expected, actual);
}

test "vneg_f32" {
    const arg0 = comptime makeData(neon.f32x2, 0);
    const expected = comptime neon.vneg_f32(arg0);
    const actual = neon.vneg_f32(arg0);
    try expectEqualApprox(expected, actual);
}

test "vneg_f64" {
    const arg0 = comptime makeData(neon.f64x1, 0);
    const expected = comptime neon.vneg_f64(arg0);
    const actual = neon.vneg_f64(arg0);
    try expectEqualApprox(expected, actual);
}

test "vnegq_s8" {
    const arg0 = comptime makeData(neon.i8x16, 0);
    const expected = comptime neon.vnegq_s8(arg0);
    const actual = neon.vnegq_s8(arg0);
    try expectEqualApprox(expected, actual);
}

test "vnegq_s16" {
    const arg0 = comptime makeData(neon.i16x8, 0);
    const expected = comptime neon.vnegq_s16(arg0);
    const actual = neon.vnegq_s16(arg0);
    try expectEqualApprox(expected, actual);
}

test "vnegq_s32" {
    const arg0 = comptime makeData(neon.i32x4, 0);
    const expected = comptime neon.vnegq_s32(arg0);
    const actual = neon.vnegq_s32(arg0);
    try expectEqualApprox(expected, actual);
}

test "vnegq_s64" {
    const arg0 = comptime makeData(neon.i64x2, 0);
    const expected = comptime neon.vnegq_s64(arg0);
    const actual = neon.vnegq_s64(arg0);
    try expectEqualApprox(expected, actual);
}

test "vnegq_f16" {
    const arg0 = comptime makeData(neon.f16x8, 0);
    const expected = comptime neon.vnegq_f16(arg0);
    const actual = neon.vnegq_f16(arg0);
    try expectEqualApprox(expected, actual);
}

test "vnegq_f32" {
    const arg0 = comptime makeData(neon.f32x4, 0);
    const expected = comptime neon.vnegq_f32(arg0);
    const actual = neon.vnegq_f32(arg0);
    try expectEqualApprox(expected, actual);
}

test "vnegq_f64" {
    const arg0 = comptime makeData(neon.f64x2, 0);
    const expected = comptime neon.vnegq_f64(arg0);
    const actual = neon.vnegq_f64(arg0);
    try expectEqualApprox(expected, actual);
}

test "vabs_s8" {
    const arg0 = comptime makeData(neon.i8x8, 0);
    const expected = comptime neon.vabs_s8(arg0);
    const actual = neon.vabs_s8(arg0);
    try expectEqualApprox(expected, actual);
}

test "vabs_s16" {
    const arg0 = comptime makeData(neon.i16x4, 0);
    const expected = comptime neon.vabs_s16(arg0);
    const actual = neon.vabs_s16(arg0);
    try expectEqualApprox(expected, actual);
}

test "vabs_s32" {
    const arg0 = comptime makeData(neon.i32x2, 0);
    const expected = comptime neon.vabs_s32(arg0);
    const actual = neon.vabs_s32(arg0);
    try expectEqualApprox(expected, actual);
}

test "vabs_s64" {
    const arg0 = comptime makeData(neon.i64x1, 0);
    const expected = comptime neon.vabs_s64(arg0);
    const actual = neon.vabs_s64(arg0);
    try expectEqualApprox(expected, actual);
}

test "vabs_f16" {
    const arg0 = comptime makeData(neon.f16x4, 0);
    const expected = comptime neon.vabs_f16(arg0);
    const actual = neon.vabs_f16(arg0);
    try expectEqualApprox(expected, actual);
}

test "vabs_f32" {
    const arg0 = comptime makeData(neon.f32x2, 0);
    const expected = comptime neon.vabs_f32(arg0);
    const actual = neon.vabs_f32(arg0);
    try expectEqualApprox(expected, actual);
}

test "vabs_f64" {
    const arg0 = comptime makeData(neon.f64x1, 0);
    const expected = comptime neon.vabs_f64(arg0);
    const actual = neon.vabs_f64(arg0);
    try expectEqualApprox(expected, actual);
}

test "vabsd_s64" {
    const arg0: i64 = 1;
    const expected = comptime neon.vabsd_s64(arg0);
    const actual = neon.vabsd_s64(arg0);
    try expectEqualApprox(expected, actual);
}

test "vabsq_s8" {
    const arg0 = comptime makeData(neon.i8x16, 0);
    const expected = comptime neon.vabsq_s8(arg0);
    const actual = neon.vabsq_s8(arg0);
    try expectEqualApprox(expected, actual);
}

test "vabsq_s16" {
    const arg0 = comptime makeData(neon.i16x8, 0);
    const expected = comptime neon.vabsq_s16(arg0);
    const actual = neon.vabsq_s16(arg0);
    try expectEqualApprox(expected, actual);
}

test "vabsq_s32" {
    const arg0 = comptime makeData(neon.i32x4, 0);
    const expected = comptime neon.vabsq_s32(arg0);
    const actual = neon.vabsq_s32(arg0);
    try expectEqualApprox(expected, actual);
}

test "vabsq_s64" {
    const arg0 = comptime makeData(neon.i64x2, 0);
    const expected = comptime neon.vabsq_s64(arg0);
    const actual = neon.vabsq_s64(arg0);
    try expectEqualApprox(expected, actual);
}

test "vabsq_f16" {
    const arg0 = comptime makeData(neon.f16x8, 0);
    const expected = comptime neon.vabsq_f16(arg0);
    const actual = neon.vabsq_f16(arg0);
    try expectEqualApprox(expected, actual);
}

test "vabsq_f32" {
    const arg0 = comptime makeData(neon.f32x4, 0);
    const expected = comptime neon.vabsq_f32(arg0);
    const actual = neon.vabsq_f32(arg0);
    try expectEqualApprox(expected, actual);
}

test "vabsq_f64" {
    const arg0 = comptime makeData(neon.f64x2, 0);
    const expected = comptime neon.vabsq_f64(arg0);
    const actual = neon.vabsq_f64(arg0);
    try expectEqualApprox(expected, actual);
}

test "vabd_s8" {
    const arg0 = comptime makeData(neon.i8x8, 0);
    const arg1 = comptime makeData(neon.i8x8, 13);
    const expected = comptime neon.vabd_s8(arg0, arg1);
    const actual = neon.vabd_s8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vabd_s16" {
    const arg0 = comptime makeData(neon.i16x4, 0);
    const arg1 = comptime makeData(neon.i16x4, 13);
    const expected = comptime neon.vabd_s16(arg0, arg1);
    const actual = neon.vabd_s16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vabd_s32" {
    const arg0 = comptime makeData(neon.i32x2, 0);
    const arg1 = comptime makeData(neon.i32x2, 13);
    const expected = comptime neon.vabd_s32(arg0, arg1);
    const actual = neon.vabd_s32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vabd_u8" {
    const arg0 = comptime makeData(neon.u8x8, 0);
    const arg1 = comptime makeData(neon.u8x8, 13);
    const expected = comptime neon.vabd_u8(arg0, arg1);
    const actual = neon.vabd_u8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vabd_u16" {
    const arg0 = comptime makeData(neon.u16x4, 0);
    const arg1 = comptime makeData(neon.u16x4, 13);
    const expected = comptime neon.vabd_u16(arg0, arg1);
    const actual = neon.vabd_u16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vabd_u32" {
    const arg0 = comptime makeData(neon.u32x2, 0);
    const arg1 = comptime makeData(neon.u32x2, 13);
    const expected = comptime neon.vabd_u32(arg0, arg1);
    const actual = neon.vabd_u32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vabd_f16" {
    const arg0 = comptime makeData(neon.f16x4, 0);
    const arg1 = comptime makeData(neon.f16x4, 13);
    const expected = comptime neon.vabd_f16(arg0, arg1);
    const actual = neon.vabd_f16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vabd_f32" {
    const arg0 = comptime makeData(neon.f32x2, 0);
    const arg1 = comptime makeData(neon.f32x2, 13);
    const expected = comptime neon.vabd_f32(arg0, arg1);
    const actual = neon.vabd_f32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vabd_f64" {
    const arg0 = comptime makeData(neon.f64x1, 0);
    const arg1 = comptime makeData(neon.f64x1, 13);
    const expected = comptime neon.vabd_f64(arg0, arg1);
    const actual = neon.vabd_f64(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vabds_f32" {
    const arg0: f32 = 1;
    const arg1: f32 = 1;
    const expected = comptime neon.vabds_f32(arg0, arg1);
    const actual = neon.vabds_f32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vabdd_f64" {
    const arg0: f64 = 1;
    const arg1: f64 = 1;
    const expected = comptime neon.vabdd_f64(arg0, arg1);
    const actual = neon.vabdd_f64(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vabdq_s8" {
    const arg0 = comptime makeData(neon.i8x16, 0);
    const arg1 = comptime makeData(neon.i8x16, 13);
    const expected = comptime neon.vabdq_s8(arg0, arg1);
    const actual = neon.vabdq_s8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vabdq_s16" {
    const arg0 = comptime makeData(neon.i16x8, 0);
    const arg1 = comptime makeData(neon.i16x8, 13);
    const expected = comptime neon.vabdq_s16(arg0, arg1);
    const actual = neon.vabdq_s16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vabdq_s32" {
    const arg0 = comptime makeData(neon.i32x4, 0);
    const arg1 = comptime makeData(neon.i32x4, 13);
    const expected = comptime neon.vabdq_s32(arg0, arg1);
    const actual = neon.vabdq_s32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vabdq_u8" {
    const arg0 = comptime makeData(neon.u8x16, 0);
    const arg1 = comptime makeData(neon.u8x16, 13);
    const expected = comptime neon.vabdq_u8(arg0, arg1);
    const actual = neon.vabdq_u8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vabdq_u16" {
    const arg0 = comptime makeData(neon.u16x8, 0);
    const arg1 = comptime makeData(neon.u16x8, 13);
    const expected = comptime neon.vabdq_u16(arg0, arg1);
    const actual = neon.vabdq_u16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vabdq_u32" {
    const arg0 = comptime makeData(neon.u32x4, 0);
    const arg1 = comptime makeData(neon.u32x4, 13);
    const expected = comptime neon.vabdq_u32(arg0, arg1);
    const actual = neon.vabdq_u32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vabdq_f16" {
    const arg0 = comptime makeData(neon.f16x8, 0);
    const arg1 = comptime makeData(neon.f16x8, 13);
    const expected = comptime neon.vabdq_f16(arg0, arg1);
    const actual = neon.vabdq_f16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vabdq_f32" {
    const arg0 = comptime makeData(neon.f32x4, 0);
    const arg1 = comptime makeData(neon.f32x4, 13);
    const expected = comptime neon.vabdq_f32(arg0, arg1);
    const actual = neon.vabdq_f32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vabdq_f64" {
    const arg0 = comptime makeData(neon.f64x2, 0);
    const arg1 = comptime makeData(neon.f64x2, 13);
    const expected = comptime neon.vabdq_f64(arg0, arg1);
    const actual = neon.vabdq_f64(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vabdl_s8" {
    const arg0 = comptime makeData(neon.i8x8, 0);
    const arg1 = comptime makeData(neon.i8x8, 13);
    const expected = comptime neon.vabdl_s8(arg0, arg1);
    const actual = neon.vabdl_s8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vabdl_s16" {
    const arg0 = comptime makeData(neon.i16x4, 0);
    const arg1 = comptime makeData(neon.i16x4, 13);
    const expected = comptime neon.vabdl_s16(arg0, arg1);
    const actual = neon.vabdl_s16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vabdl_s32" {
    const arg0 = comptime makeData(neon.i32x2, 0);
    const arg1 = comptime makeData(neon.i32x2, 13);
    const expected = comptime neon.vabdl_s32(arg0, arg1);
    const actual = neon.vabdl_s32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vabdl_u8" {
    const arg0 = comptime makeData(neon.u8x8, 0);
    const arg1 = comptime makeData(neon.u8x8, 13);
    const expected = comptime neon.vabdl_u8(arg0, arg1);
    const actual = neon.vabdl_u8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vabdl_u16" {
    const arg0 = comptime makeData(neon.u16x4, 0);
    const arg1 = comptime makeData(neon.u16x4, 13);
    const expected = comptime neon.vabdl_u16(arg0, arg1);
    const actual = neon.vabdl_u16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vabdl_u32" {
    const arg0 = comptime makeData(neon.u32x2, 0);
    const arg1 = comptime makeData(neon.u32x2, 13);
    const expected = comptime neon.vabdl_u32(arg0, arg1);
    const actual = neon.vabdl_u32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vaba_s8" {
    const arg0 = comptime makeData(neon.i8x8, 0);
    const arg1 = comptime makeData(neon.i8x8, 13);
    const arg2 = comptime makeData(neon.i8x8, 26);
    const expected = comptime neon.vaba_s8(arg0, arg1, arg2);
    const actual = neon.vaba_s8(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vaba_s16" {
    const arg0 = comptime makeData(neon.i16x4, 0);
    const arg1 = comptime makeData(neon.i16x4, 13);
    const arg2 = comptime makeData(neon.i16x4, 26);
    const expected = comptime neon.vaba_s16(arg0, arg1, arg2);
    const actual = neon.vaba_s16(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vaba_s32" {
    const arg0 = comptime makeData(neon.i32x2, 0);
    const arg1 = comptime makeData(neon.i32x2, 13);
    const arg2 = comptime makeData(neon.i32x2, 26);
    const expected = comptime neon.vaba_s32(arg0, arg1, arg2);
    const actual = neon.vaba_s32(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vaba_u8" {
    const arg0 = comptime makeData(neon.u8x8, 0);
    const arg1 = comptime makeData(neon.u8x8, 13);
    const arg2 = comptime makeData(neon.u8x8, 26);
    const expected = comptime neon.vaba_u8(arg0, arg1, arg2);
    const actual = neon.vaba_u8(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vaba_u16" {
    const arg0 = comptime makeData(neon.u16x4, 0);
    const arg1 = comptime makeData(neon.u16x4, 13);
    const arg2 = comptime makeData(neon.u16x4, 26);
    const expected = comptime neon.vaba_u16(arg0, arg1, arg2);
    const actual = neon.vaba_u16(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vaba_u32" {
    const arg0 = comptime makeData(neon.u32x2, 0);
    const arg1 = comptime makeData(neon.u32x2, 13);
    const arg2 = comptime makeData(neon.u32x2, 26);
    const expected = comptime neon.vaba_u32(arg0, arg1, arg2);
    const actual = neon.vaba_u32(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vabaq_s8" {
    const arg0 = comptime makeData(neon.i8x16, 0);
    const arg1 = comptime makeData(neon.i8x16, 13);
    const arg2 = comptime makeData(neon.i8x16, 26);
    const expected = comptime neon.vabaq_s8(arg0, arg1, arg2);
    const actual = neon.vabaq_s8(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vabaq_s16" {
    const arg0 = comptime makeData(neon.i16x8, 0);
    const arg1 = comptime makeData(neon.i16x8, 13);
    const arg2 = comptime makeData(neon.i16x8, 26);
    const expected = comptime neon.vabaq_s16(arg0, arg1, arg2);
    const actual = neon.vabaq_s16(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vabaq_s32" {
    const arg0 = comptime makeData(neon.i32x4, 0);
    const arg1 = comptime makeData(neon.i32x4, 13);
    const arg2 = comptime makeData(neon.i32x4, 26);
    const expected = comptime neon.vabaq_s32(arg0, arg1, arg2);
    const actual = neon.vabaq_s32(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vabaq_u8" {
    const arg0 = comptime makeData(neon.u8x16, 0);
    const arg1 = comptime makeData(neon.u8x16, 13);
    const arg2 = comptime makeData(neon.u8x16, 26);
    const expected = comptime neon.vabaq_u8(arg0, arg1, arg2);
    const actual = neon.vabaq_u8(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vabaq_u16" {
    const arg0 = comptime makeData(neon.u16x8, 0);
    const arg1 = comptime makeData(neon.u16x8, 13);
    const arg2 = comptime makeData(neon.u16x8, 26);
    const expected = comptime neon.vabaq_u16(arg0, arg1, arg2);
    const actual = neon.vabaq_u16(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vabaq_u32" {
    const arg0 = comptime makeData(neon.u32x4, 0);
    const arg1 = comptime makeData(neon.u32x4, 13);
    const arg2 = comptime makeData(neon.u32x4, 26);
    const expected = comptime neon.vabaq_u32(arg0, arg1, arg2);
    const actual = neon.vabaq_u32(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vabal_s8" {
    const arg0 = comptime makeData(neon.i16x8, 0);
    const arg1 = comptime makeData(neon.i8x8, 13);
    const arg2 = comptime makeData(neon.i8x8, 26);
    const expected = comptime neon.vabal_s8(arg0, arg1, arg2);
    const actual = neon.vabal_s8(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vabal_s16" {
    const arg0 = comptime makeData(neon.i32x4, 0);
    const arg1 = comptime makeData(neon.i16x4, 13);
    const arg2 = comptime makeData(neon.i16x4, 26);
    const expected = comptime neon.vabal_s16(arg0, arg1, arg2);
    const actual = neon.vabal_s16(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vabal_s32" {
    const arg0 = comptime makeData(neon.i64x2, 0);
    const arg1 = comptime makeData(neon.i32x2, 13);
    const arg2 = comptime makeData(neon.i32x2, 26);
    const expected = comptime neon.vabal_s32(arg0, arg1, arg2);
    const actual = neon.vabal_s32(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vabal_u8" {
    const arg0 = comptime makeData(neon.u16x8, 0);
    const arg1 = comptime makeData(neon.u8x8, 13);
    const arg2 = comptime makeData(neon.u8x8, 26);
    const expected = comptime neon.vabal_u8(arg0, arg1, arg2);
    const actual = neon.vabal_u8(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vabal_u16" {
    const arg0 = comptime makeData(neon.u32x4, 0);
    const arg1 = comptime makeData(neon.u16x4, 13);
    const arg2 = comptime makeData(neon.u16x4, 26);
    const expected = comptime neon.vabal_u16(arg0, arg1, arg2);
    const actual = neon.vabal_u16(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vabal_u32" {
    const arg0 = comptime makeData(neon.u64x2, 0);
    const arg1 = comptime makeData(neon.u32x2, 13);
    const arg2 = comptime makeData(neon.u32x2, 26);
    const expected = comptime neon.vabal_u32(arg0, arg1, arg2);
    const actual = neon.vabal_u32(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vaddl_s8" {
    const arg0 = comptime makeData(neon.i8x8, 0);
    const arg1 = comptime makeData(neon.i8x8, 13);
    const expected = comptime neon.vaddl_s8(arg0, arg1);
    const actual = neon.vaddl_s8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vaddl_s16" {
    const arg0 = comptime makeData(neon.i16x4, 0);
    const arg1 = comptime makeData(neon.i16x4, 13);
    const expected = comptime neon.vaddl_s16(arg0, arg1);
    const actual = neon.vaddl_s16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vaddl_s32" {
    const arg0 = comptime makeData(neon.i32x2, 0);
    const arg1 = comptime makeData(neon.i32x2, 13);
    const expected = comptime neon.vaddl_s32(arg0, arg1);
    const actual = neon.vaddl_s32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vaddl_u8" {
    const arg0 = comptime makeData(neon.u8x8, 0);
    const arg1 = comptime makeData(neon.u8x8, 13);
    const expected = comptime neon.vaddl_u8(arg0, arg1);
    const actual = neon.vaddl_u8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vaddl_u16" {
    const arg0 = comptime makeData(neon.u16x4, 0);
    const arg1 = comptime makeData(neon.u16x4, 13);
    const expected = comptime neon.vaddl_u16(arg0, arg1);
    const actual = neon.vaddl_u16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vaddl_u32" {
    const arg0 = comptime makeData(neon.u32x2, 0);
    const arg1 = comptime makeData(neon.u32x2, 13);
    const expected = comptime neon.vaddl_u32(arg0, arg1);
    const actual = neon.vaddl_u32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vaddw_s8" {
    const arg0 = comptime makeData(neon.i16x8, 0);
    const arg1 = comptime makeData(neon.i8x8, 13);
    const expected = comptime neon.vaddw_s8(arg0, arg1);
    const actual = neon.vaddw_s8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vaddw_s16" {
    const arg0 = comptime makeData(neon.i32x4, 0);
    const arg1 = comptime makeData(neon.i16x4, 13);
    const expected = comptime neon.vaddw_s16(arg0, arg1);
    const actual = neon.vaddw_s16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vaddw_s32" {
    const arg0 = comptime makeData(neon.i64x2, 0);
    const arg1 = comptime makeData(neon.i32x2, 13);
    const expected = comptime neon.vaddw_s32(arg0, arg1);
    const actual = neon.vaddw_s32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vaddw_u8" {
    const arg0 = comptime makeData(neon.u16x8, 0);
    const arg1 = comptime makeData(neon.u8x8, 13);
    const expected = comptime neon.vaddw_u8(arg0, arg1);
    const actual = neon.vaddw_u8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vaddw_u16" {
    const arg0 = comptime makeData(neon.u32x4, 0);
    const arg1 = comptime makeData(neon.u16x4, 13);
    const expected = comptime neon.vaddw_u16(arg0, arg1);
    const actual = neon.vaddw_u16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vaddw_u32" {
    const arg0 = comptime makeData(neon.u64x2, 0);
    const arg1 = comptime makeData(neon.u32x2, 13);
    const expected = comptime neon.vaddw_u32(arg0, arg1);
    const actual = neon.vaddw_u32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vaddhn_s16" {
    const arg0 = comptime makeData(neon.i16x8, 0);
    const arg1 = comptime makeData(neon.i16x8, 13);
    const expected = comptime neon.vaddhn_s16(arg0, arg1);
    const actual = neon.vaddhn_s16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vaddhn_s32" {
    const arg0 = comptime makeData(neon.i32x4, 0);
    const arg1 = comptime makeData(neon.i32x4, 13);
    const expected = comptime neon.vaddhn_s32(arg0, arg1);
    const actual = neon.vaddhn_s32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vaddhn_s64" {
    const arg0 = comptime makeData(neon.i64x2, 0);
    const arg1 = comptime makeData(neon.i64x2, 13);
    const expected = comptime neon.vaddhn_s64(arg0, arg1);
    const actual = neon.vaddhn_s64(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vaddhn_u16" {
    const arg0 = comptime makeData(neon.u16x8, 0);
    const arg1 = comptime makeData(neon.u16x8, 13);
    const expected = comptime neon.vaddhn_u16(arg0, arg1);
    const actual = neon.vaddhn_u16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vaddhn_u32" {
    const arg0 = comptime makeData(neon.u32x4, 0);
    const arg1 = comptime makeData(neon.u32x4, 13);
    const expected = comptime neon.vaddhn_u32(arg0, arg1);
    const actual = neon.vaddhn_u32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vaddhn_u64" {
    const arg0 = comptime makeData(neon.u64x2, 0);
    const arg1 = comptime makeData(neon.u64x2, 13);
    const expected = comptime neon.vaddhn_u64(arg0, arg1);
    const actual = neon.vaddhn_u64(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vmul_s8" {
    const arg0 = comptime makeData(neon.i8x8, 0);
    const arg1 = comptime makeData(neon.i8x8, 13);
    const expected = comptime neon.vmul_s8(arg0, arg1);
    const actual = neon.vmul_s8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vmul_s16" {
    const arg0 = comptime makeData(neon.i16x4, 0);
    const arg1 = comptime makeData(neon.i16x4, 13);
    const expected = comptime neon.vmul_s16(arg0, arg1);
    const actual = neon.vmul_s16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vmul_s32" {
    const arg0 = comptime makeData(neon.i32x2, 0);
    const arg1 = comptime makeData(neon.i32x2, 13);
    const expected = comptime neon.vmul_s32(arg0, arg1);
    const actual = neon.vmul_s32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vmul_u8" {
    const arg0 = comptime makeData(neon.u8x8, 0);
    const arg1 = comptime makeData(neon.u8x8, 13);
    const expected = comptime neon.vmul_u8(arg0, arg1);
    const actual = neon.vmul_u8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vmul_u16" {
    const arg0 = comptime makeData(neon.u16x4, 0);
    const arg1 = comptime makeData(neon.u16x4, 13);
    const expected = comptime neon.vmul_u16(arg0, arg1);
    const actual = neon.vmul_u16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vmul_u32" {
    const arg0 = comptime makeData(neon.u32x2, 0);
    const arg1 = comptime makeData(neon.u32x2, 13);
    const expected = comptime neon.vmul_u32(arg0, arg1);
    const actual = neon.vmul_u32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vmul_f16" {
    const arg0 = comptime makeData(neon.f16x4, 0);
    const arg1 = comptime makeData(neon.f16x4, 13);
    const expected = comptime neon.vmul_f16(arg0, arg1);
    const actual = neon.vmul_f16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vmul_f32" {
    const arg0 = comptime makeData(neon.f32x2, 0);
    const arg1 = comptime makeData(neon.f32x2, 13);
    const expected = comptime neon.vmul_f32(arg0, arg1);
    const actual = neon.vmul_f32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vmul_f64" {
    const arg0 = comptime makeData(neon.f64x1, 0);
    const arg1 = comptime makeData(neon.f64x1, 13);
    const expected = comptime neon.vmul_f64(arg0, arg1);
    const actual = neon.vmul_f64(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vmulq_s8" {
    const arg0 = comptime makeData(neon.i8x16, 0);
    const arg1 = comptime makeData(neon.i8x16, 13);
    const expected = comptime neon.vmulq_s8(arg0, arg1);
    const actual = neon.vmulq_s8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vmulq_s16" {
    const arg0 = comptime makeData(neon.i16x8, 0);
    const arg1 = comptime makeData(neon.i16x8, 13);
    const expected = comptime neon.vmulq_s16(arg0, arg1);
    const actual = neon.vmulq_s16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vmulq_s32" {
    const arg0 = comptime makeData(neon.i32x4, 0);
    const arg1 = comptime makeData(neon.i32x4, 13);
    const expected = comptime neon.vmulq_s32(arg0, arg1);
    const actual = neon.vmulq_s32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vmulq_u8" {
    const arg0 = comptime makeData(neon.u8x16, 0);
    const arg1 = comptime makeData(neon.u8x16, 13);
    const expected = comptime neon.vmulq_u8(arg0, arg1);
    const actual = neon.vmulq_u8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vmulq_u16" {
    const arg0 = comptime makeData(neon.u16x8, 0);
    const arg1 = comptime makeData(neon.u16x8, 13);
    const expected = comptime neon.vmulq_u16(arg0, arg1);
    const actual = neon.vmulq_u16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vmulq_u32" {
    const arg0 = comptime makeData(neon.u32x4, 0);
    const arg1 = comptime makeData(neon.u32x4, 13);
    const expected = comptime neon.vmulq_u32(arg0, arg1);
    const actual = neon.vmulq_u32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vmulq_f16" {
    const arg0 = comptime makeData(neon.f16x8, 0);
    const arg1 = comptime makeData(neon.f16x8, 13);
    const expected = comptime neon.vmulq_f16(arg0, arg1);
    const actual = neon.vmulq_f16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vmulq_f32" {
    const arg0 = comptime makeData(neon.f32x4, 0);
    const arg1 = comptime makeData(neon.f32x4, 13);
    const expected = comptime neon.vmulq_f32(arg0, arg1);
    const actual = neon.vmulq_f32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vmulq_f64" {
    const arg0 = comptime makeData(neon.f64x2, 0);
    const arg1 = comptime makeData(neon.f64x2, 13);
    const expected = comptime neon.vmulq_f64(arg0, arg1);
    const actual = neon.vmulq_f64(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vmull_s8" {
    const arg0 = comptime makeData(neon.i8x8, 0);
    const arg1 = comptime makeData(neon.i8x8, 13);
    const expected = comptime neon.vmull_s8(arg0, arg1);
    const actual = neon.vmull_s8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vmull_s16" {
    const arg0 = comptime makeData(neon.i16x4, 0);
    const arg1 = comptime makeData(neon.i16x4, 13);
    const expected = comptime neon.vmull_s16(arg0, arg1);
    const actual = neon.vmull_s16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vmull_s32" {
    const arg0 = comptime makeData(neon.i32x2, 0);
    const arg1 = comptime makeData(neon.i32x2, 13);
    const expected = comptime neon.vmull_s32(arg0, arg1);
    const actual = neon.vmull_s32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vmull_u8" {
    const arg0 = comptime makeData(neon.u8x8, 0);
    const arg1 = comptime makeData(neon.u8x8, 13);
    const expected = comptime neon.vmull_u8(arg0, arg1);
    const actual = neon.vmull_u8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vmull_u16" {
    const arg0 = comptime makeData(neon.u16x4, 0);
    const arg1 = comptime makeData(neon.u16x4, 13);
    const expected = comptime neon.vmull_u16(arg0, arg1);
    const actual = neon.vmull_u16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vmull_u32" {
    const arg0 = comptime makeData(neon.u32x2, 0);
    const arg1 = comptime makeData(neon.u32x2, 13);
    const expected = comptime neon.vmull_u32(arg0, arg1);
    const actual = neon.vmull_u32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vmla_s8" {
    const arg0 = comptime makeData(neon.i8x8, 0);
    const arg1 = comptime makeData(neon.i8x8, 13);
    const arg2 = comptime makeData(neon.i8x8, 26);
    const expected = comptime neon.vmla_s8(arg0, arg1, arg2);
    const actual = neon.vmla_s8(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vmla_s16" {
    const arg0 = comptime makeData(neon.i16x4, 0);
    const arg1 = comptime makeData(neon.i16x4, 13);
    const arg2 = comptime makeData(neon.i16x4, 26);
    const expected = comptime neon.vmla_s16(arg0, arg1, arg2);
    const actual = neon.vmla_s16(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vmla_s32" {
    const arg0 = comptime makeData(neon.i32x2, 0);
    const arg1 = comptime makeData(neon.i32x2, 13);
    const arg2 = comptime makeData(neon.i32x2, 26);
    const expected = comptime neon.vmla_s32(arg0, arg1, arg2);
    const actual = neon.vmla_s32(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vmla_u8" {
    const arg0 = comptime makeData(neon.u8x8, 0);
    const arg1 = comptime makeData(neon.u8x8, 13);
    const arg2 = comptime makeData(neon.u8x8, 26);
    const expected = comptime neon.vmla_u8(arg0, arg1, arg2);
    const actual = neon.vmla_u8(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vmla_u16" {
    const arg0 = comptime makeData(neon.u16x4, 0);
    const arg1 = comptime makeData(neon.u16x4, 13);
    const arg2 = comptime makeData(neon.u16x4, 26);
    const expected = comptime neon.vmla_u16(arg0, arg1, arg2);
    const actual = neon.vmla_u16(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vmla_u32" {
    const arg0 = comptime makeData(neon.u32x2, 0);
    const arg1 = comptime makeData(neon.u32x2, 13);
    const arg2 = comptime makeData(neon.u32x2, 26);
    const expected = comptime neon.vmla_u32(arg0, arg1, arg2);
    const actual = neon.vmla_u32(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vmla_f16" {
    const arg0 = comptime makeData(neon.f16x4, 0);
    const arg1 = comptime makeData(neon.f16x4, 13);
    const arg2 = comptime makeData(neon.f16x4, 26);
    const expected = comptime neon.vmla_f16(arg0, arg1, arg2);
    const actual = neon.vmla_f16(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vmla_f32" {
    const arg0 = comptime makeData(neon.f32x2, 0);
    const arg1 = comptime makeData(neon.f32x2, 13);
    const arg2 = comptime makeData(neon.f32x2, 26);
    const expected = comptime neon.vmla_f32(arg0, arg1, arg2);
    const actual = neon.vmla_f32(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vmlaq_s8" {
    const arg0 = comptime makeData(neon.i8x16, 0);
    const arg1 = comptime makeData(neon.i8x16, 13);
    const arg2 = comptime makeData(neon.i8x16, 26);
    const expected = comptime neon.vmlaq_s8(arg0, arg1, arg2);
    const actual = neon.vmlaq_s8(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vmlaq_s16" {
    const arg0 = comptime makeData(neon.i16x8, 0);
    const arg1 = comptime makeData(neon.i16x8, 13);
    const arg2 = comptime makeData(neon.i16x8, 26);
    const expected = comptime neon.vmlaq_s16(arg0, arg1, arg2);
    const actual = neon.vmlaq_s16(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vmlaq_s32" {
    const arg0 = comptime makeData(neon.i32x4, 0);
    const arg1 = comptime makeData(neon.i32x4, 13);
    const arg2 = comptime makeData(neon.i32x4, 26);
    const expected = comptime neon.vmlaq_s32(arg0, arg1, arg2);
    const actual = neon.vmlaq_s32(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vmlaq_u8" {
    const arg0 = comptime makeData(neon.u8x16, 0);
    const arg1 = comptime makeData(neon.u8x16, 13);
    const arg2 = comptime makeData(neon.u8x16, 26);
    const expected = comptime neon.vmlaq_u8(arg0, arg1, arg2);
    const actual = neon.vmlaq_u8(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vmlaq_u16" {
    const arg0 = comptime makeData(neon.u16x8, 0);
    const arg1 = comptime makeData(neon.u16x8, 13);
    const arg2 = comptime makeData(neon.u16x8, 26);
    const expected = comptime neon.vmlaq_u16(arg0, arg1, arg2);
    const actual = neon.vmlaq_u16(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vmlaq_u32" {
    const arg0 = comptime makeData(neon.u32x4, 0);
    const arg1 = comptime makeData(neon.u32x4, 13);
    const arg2 = comptime makeData(neon.u32x4, 26);
    const expected = comptime neon.vmlaq_u32(arg0, arg1, arg2);
    const actual = neon.vmlaq_u32(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vmlaq_f16" {
    const arg0 = comptime makeData(neon.f16x8, 0);
    const arg1 = comptime makeData(neon.f16x8, 13);
    const arg2 = comptime makeData(neon.f16x8, 26);
    const expected = comptime neon.vmlaq_f16(arg0, arg1, arg2);
    const actual = neon.vmlaq_f16(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vmlaq_f32" {
    const arg0 = comptime makeData(neon.f32x4, 0);
    const arg1 = comptime makeData(neon.f32x4, 13);
    const arg2 = comptime makeData(neon.f32x4, 26);
    const expected = comptime neon.vmlaq_f32(arg0, arg1, arg2);
    const actual = neon.vmlaq_f32(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vmlaq_f64" {
    const arg0 = comptime makeData(neon.f64x2, 0);
    const arg1 = comptime makeData(neon.f64x2, 13);
    const arg2 = comptime makeData(neon.f64x2, 26);
    const expected = comptime neon.vmlaq_f64(arg0, arg1, arg2);
    const actual = neon.vmlaq_f64(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vmls_s8" {
    const arg0 = comptime makeData(neon.i8x8, 0);
    const arg1 = comptime makeData(neon.i8x8, 13);
    const arg2 = comptime makeData(neon.i8x8, 26);
    const expected = comptime neon.vmls_s8(arg0, arg1, arg2);
    const actual = neon.vmls_s8(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vmls_s16" {
    const arg0 = comptime makeData(neon.i16x4, 0);
    const arg1 = comptime makeData(neon.i16x4, 13);
    const arg2 = comptime makeData(neon.i16x4, 26);
    const expected = comptime neon.vmls_s16(arg0, arg1, arg2);
    const actual = neon.vmls_s16(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vmls_s32" {
    const arg0 = comptime makeData(neon.i32x2, 0);
    const arg1 = comptime makeData(neon.i32x2, 13);
    const arg2 = comptime makeData(neon.i32x2, 26);
    const expected = comptime neon.vmls_s32(arg0, arg1, arg2);
    const actual = neon.vmls_s32(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vmls_u8" {
    const arg0 = comptime makeData(neon.u8x8, 0);
    const arg1 = comptime makeData(neon.u8x8, 13);
    const arg2 = comptime makeData(neon.u8x8, 26);
    const expected = comptime neon.vmls_u8(arg0, arg1, arg2);
    const actual = neon.vmls_u8(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vmls_u16" {
    const arg0 = comptime makeData(neon.u16x4, 0);
    const arg1 = comptime makeData(neon.u16x4, 13);
    const arg2 = comptime makeData(neon.u16x4, 26);
    const expected = comptime neon.vmls_u16(arg0, arg1, arg2);
    const actual = neon.vmls_u16(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vmls_u32" {
    const arg0 = comptime makeData(neon.u32x2, 0);
    const arg1 = comptime makeData(neon.u32x2, 13);
    const arg2 = comptime makeData(neon.u32x2, 26);
    const expected = comptime neon.vmls_u32(arg0, arg1, arg2);
    const actual = neon.vmls_u32(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vmls_f16" {
    const arg0 = comptime makeData(neon.f16x4, 0);
    const arg1 = comptime makeData(neon.f16x4, 13);
    const arg2 = comptime makeData(neon.f16x4, 26);
    const expected = comptime neon.vmls_f16(arg0, arg1, arg2);
    const actual = neon.vmls_f16(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vmls_f32" {
    const arg0 = comptime makeData(neon.f32x2, 0);
    const arg1 = comptime makeData(neon.f32x2, 13);
    const arg2 = comptime makeData(neon.f32x2, 26);
    const expected = comptime neon.vmls_f32(arg0, arg1, arg2);
    const actual = neon.vmls_f32(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vmlsq_s8" {
    const arg0 = comptime makeData(neon.i8x16, 0);
    const arg1 = comptime makeData(neon.i8x16, 13);
    const arg2 = comptime makeData(neon.i8x16, 26);
    const expected = comptime neon.vmlsq_s8(arg0, arg1, arg2);
    const actual = neon.vmlsq_s8(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vmlsq_s16" {
    const arg0 = comptime makeData(neon.i16x8, 0);
    const arg1 = comptime makeData(neon.i16x8, 13);
    const arg2 = comptime makeData(neon.i16x8, 26);
    const expected = comptime neon.vmlsq_s16(arg0, arg1, arg2);
    const actual = neon.vmlsq_s16(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vmlsq_s32" {
    const arg0 = comptime makeData(neon.i32x4, 0);
    const arg1 = comptime makeData(neon.i32x4, 13);
    const arg2 = comptime makeData(neon.i32x4, 26);
    const expected = comptime neon.vmlsq_s32(arg0, arg1, arg2);
    const actual = neon.vmlsq_s32(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vmlsq_u8" {
    const arg0 = comptime makeData(neon.u8x16, 0);
    const arg1 = comptime makeData(neon.u8x16, 13);
    const arg2 = comptime makeData(neon.u8x16, 26);
    const expected = comptime neon.vmlsq_u8(arg0, arg1, arg2);
    const actual = neon.vmlsq_u8(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vmlsq_u16" {
    const arg0 = comptime makeData(neon.u16x8, 0);
    const arg1 = comptime makeData(neon.u16x8, 13);
    const arg2 = comptime makeData(neon.u16x8, 26);
    const expected = comptime neon.vmlsq_u16(arg0, arg1, arg2);
    const actual = neon.vmlsq_u16(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vmlsq_u32" {
    const arg0 = comptime makeData(neon.u32x4, 0);
    const arg1 = comptime makeData(neon.u32x4, 13);
    const arg2 = comptime makeData(neon.u32x4, 26);
    const expected = comptime neon.vmlsq_u32(arg0, arg1, arg2);
    const actual = neon.vmlsq_u32(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vmlsq_f16" {
    const arg0 = comptime makeData(neon.f16x8, 0);
    const arg1 = comptime makeData(neon.f16x8, 13);
    const arg2 = comptime makeData(neon.f16x8, 26);
    const expected = comptime neon.vmlsq_f16(arg0, arg1, arg2);
    const actual = neon.vmlsq_f16(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vmlsq_f32" {
    const arg0 = comptime makeData(neon.f32x4, 0);
    const arg1 = comptime makeData(neon.f32x4, 13);
    const arg2 = comptime makeData(neon.f32x4, 26);
    const expected = comptime neon.vmlsq_f32(arg0, arg1, arg2);
    const actual = neon.vmlsq_f32(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vmlsq_f64" {
    const arg0 = comptime makeData(neon.f64x2, 0);
    const arg1 = comptime makeData(neon.f64x2, 13);
    const arg2 = comptime makeData(neon.f64x2, 26);
    const expected = comptime neon.vmlsq_f64(arg0, arg1, arg2);
    const actual = neon.vmlsq_f64(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vfma_f16" {
    const arg0 = comptime makeData(neon.f16x4, 0);
    const arg1 = comptime makeData(neon.f16x4, 13);
    const arg2 = comptime makeData(neon.f16x4, 26);
    const expected = comptime neon.vfma_f16(arg0, arg1, arg2);
    const actual = neon.vfma_f16(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vfma_f32" {
    const arg0 = comptime makeData(neon.f32x2, 0);
    const arg1 = comptime makeData(neon.f32x2, 13);
    const arg2 = comptime makeData(neon.f32x2, 26);
    const expected = comptime neon.vfma_f32(arg0, arg1, arg2);
    const actual = neon.vfma_f32(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vfma_f64" {
    const arg0 = comptime makeData(neon.f64x1, 0);
    const arg1 = comptime makeData(neon.f64x1, 13);
    const arg2 = comptime makeData(neon.f64x1, 26);
    const expected = comptime neon.vfma_f64(arg0, arg1, arg2);
    const actual = neon.vfma_f64(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vfmaq_f16" {
    const arg0 = comptime makeData(neon.f16x8, 0);
    const arg1 = comptime makeData(neon.f16x8, 13);
    const arg2 = comptime makeData(neon.f16x8, 26);
    const expected = comptime neon.vfmaq_f16(arg0, arg1, arg2);
    const actual = neon.vfmaq_f16(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vfmaq_f32" {
    const arg0 = comptime makeData(neon.f32x4, 0);
    const arg1 = comptime makeData(neon.f32x4, 13);
    const arg2 = comptime makeData(neon.f32x4, 26);
    const expected = comptime neon.vfmaq_f32(arg0, arg1, arg2);
    const actual = neon.vfmaq_f32(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vfmaq_f64" {
    const arg0 = comptime makeData(neon.f64x2, 0);
    const arg1 = comptime makeData(neon.f64x2, 13);
    const arg2 = comptime makeData(neon.f64x2, 26);
    const expected = comptime neon.vfmaq_f64(arg0, arg1, arg2);
    const actual = neon.vfmaq_f64(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vfms_f16" {
    const arg0 = comptime makeData(neon.f16x4, 0);
    const arg1 = comptime makeData(neon.f16x4, 13);
    const arg2 = comptime makeData(neon.f16x4, 26);
    const expected = comptime neon.vfms_f16(arg0, arg1, arg2);
    const actual = neon.vfms_f16(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vfms_f32" {
    const arg0 = comptime makeData(neon.f32x2, 0);
    const arg1 = comptime makeData(neon.f32x2, 13);
    const arg2 = comptime makeData(neon.f32x2, 26);
    const expected = comptime neon.vfms_f32(arg0, arg1, arg2);
    const actual = neon.vfms_f32(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vfms_f64" {
    const arg0 = comptime makeData(neon.f64x1, 0);
    const arg1 = comptime makeData(neon.f64x1, 13);
    const arg2 = comptime makeData(neon.f64x1, 26);
    const expected = comptime neon.vfms_f64(arg0, arg1, arg2);
    const actual = neon.vfms_f64(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vfmsq_f16" {
    const arg0 = comptime makeData(neon.f16x8, 0);
    const arg1 = comptime makeData(neon.f16x8, 13);
    const arg2 = comptime makeData(neon.f16x8, 26);
    const expected = comptime neon.vfmsq_f16(arg0, arg1, arg2);
    const actual = neon.vfmsq_f16(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vfmsq_f32" {
    const arg0 = comptime makeData(neon.f32x4, 0);
    const arg1 = comptime makeData(neon.f32x4, 13);
    const arg2 = comptime makeData(neon.f32x4, 26);
    const expected = comptime neon.vfmsq_f32(arg0, arg1, arg2);
    const actual = neon.vfmsq_f32(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vfmsq_f64" {
    const arg0 = comptime makeData(neon.f64x2, 0);
    const arg1 = comptime makeData(neon.f64x2, 13);
    const arg2 = comptime makeData(neon.f64x2, 26);
    const expected = comptime neon.vfmsq_f64(arg0, arg1, arg2);
    const actual = neon.vfmsq_f64(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vfmaq_laneq_f16" {
    const arg0 = comptime makeData(neon.f16x8, 0);
    const arg1 = comptime makeData(neon.f16x8, 13);
    const arg2 = comptime makeData(neon.f16x8, 26);
    const arg3: usize = 0;
    const expected = comptime neon.vfmaq_laneq_f16(arg0, arg1, arg2, arg3);
    const actual = neon.vfmaq_laneq_f16(arg0, arg1, arg2, arg3);
    try expectEqualApprox(expected, actual);
}

test "vfmaq_laneq_f32" {
    const arg0 = comptime makeData(neon.f32x4, 0);
    const arg1 = comptime makeData(neon.f32x4, 13);
    const arg2 = comptime makeData(neon.f32x4, 26);
    const arg3: usize = 0;
    const expected = comptime neon.vfmaq_laneq_f32(arg0, arg1, arg2, arg3);
    const actual = neon.vfmaq_laneq_f32(arg0, arg1, arg2, arg3);
    try expectEqualApprox(expected, actual);
}

test "vfmaq_laneq_f64" {
    const arg0 = comptime makeData(neon.f64x2, 0);
    const arg1 = comptime makeData(neon.f64x2, 13);
    const arg2 = comptime makeData(neon.f64x2, 26);
    const arg3: usize = 0;
    const expected = comptime neon.vfmaq_laneq_f64(arg0, arg1, arg2, arg3);
    const actual = neon.vfmaq_laneq_f64(arg0, arg1, arg2, arg3);
    try expectEqualApprox(expected, actual);
}

test "vqadd_s8" {
    const arg0 = comptime makeData(neon.i8x8, 0);
    const arg1 = comptime makeData(neon.i8x8, 13);
    const expected = comptime neon.vqadd_s8(arg0, arg1);
    const actual = neon.vqadd_s8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vqadd_s16" {
    const arg0 = comptime makeData(neon.i16x4, 0);
    const arg1 = comptime makeData(neon.i16x4, 13);
    const expected = comptime neon.vqadd_s16(arg0, arg1);
    const actual = neon.vqadd_s16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vqadd_s32" {
    const arg0 = comptime makeData(neon.i32x2, 0);
    const arg1 = comptime makeData(neon.i32x2, 13);
    const expected = comptime neon.vqadd_s32(arg0, arg1);
    const actual = neon.vqadd_s32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vqadd_s64" {
    const arg0 = comptime makeData(neon.i64x1, 0);
    const arg1 = comptime makeData(neon.i64x1, 13);
    const expected = comptime neon.vqadd_s64(arg0, arg1);
    const actual = neon.vqadd_s64(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vqadd_u8" {
    const arg0 = comptime makeData(neon.u8x8, 0);
    const arg1 = comptime makeData(neon.u8x8, 13);
    const expected = comptime neon.vqadd_u8(arg0, arg1);
    const actual = neon.vqadd_u8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vqadd_u16" {
    const arg0 = comptime makeData(neon.u16x4, 0);
    const arg1 = comptime makeData(neon.u16x4, 13);
    const expected = comptime neon.vqadd_u16(arg0, arg1);
    const actual = neon.vqadd_u16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vqadd_u32" {
    const arg0 = comptime makeData(neon.u32x2, 0);
    const arg1 = comptime makeData(neon.u32x2, 13);
    const expected = comptime neon.vqadd_u32(arg0, arg1);
    const actual = neon.vqadd_u32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vqadd_u64" {
    const arg0 = comptime makeData(neon.u64x1, 0);
    const arg1 = comptime makeData(neon.u64x1, 13);
    const expected = comptime neon.vqadd_u64(arg0, arg1);
    const actual = neon.vqadd_u64(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vqaddq_s8" {
    const arg0 = comptime makeData(neon.i8x16, 0);
    const arg1 = comptime makeData(neon.i8x16, 13);
    const expected = comptime neon.vqaddq_s8(arg0, arg1);
    const actual = neon.vqaddq_s8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vqaddq_s16" {
    const arg0 = comptime makeData(neon.i16x8, 0);
    const arg1 = comptime makeData(neon.i16x8, 13);
    const expected = comptime neon.vqaddq_s16(arg0, arg1);
    const actual = neon.vqaddq_s16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vqaddq_s32" {
    const arg0 = comptime makeData(neon.i32x4, 0);
    const arg1 = comptime makeData(neon.i32x4, 13);
    const expected = comptime neon.vqaddq_s32(arg0, arg1);
    const actual = neon.vqaddq_s32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vqaddq_s64" {
    const arg0 = comptime makeData(neon.i64x2, 0);
    const arg1 = comptime makeData(neon.i64x2, 13);
    const expected = comptime neon.vqaddq_s64(arg0, arg1);
    const actual = neon.vqaddq_s64(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vqaddq_u8" {
    const arg0 = comptime makeData(neon.u8x16, 0);
    const arg1 = comptime makeData(neon.u8x16, 13);
    const expected = comptime neon.vqaddq_u8(arg0, arg1);
    const actual = neon.vqaddq_u8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vqaddq_u16" {
    const arg0 = comptime makeData(neon.u16x8, 0);
    const arg1 = comptime makeData(neon.u16x8, 13);
    const expected = comptime neon.vqaddq_u16(arg0, arg1);
    const actual = neon.vqaddq_u16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vqaddq_u32" {
    const arg0 = comptime makeData(neon.u32x4, 0);
    const arg1 = comptime makeData(neon.u32x4, 13);
    const expected = comptime neon.vqaddq_u32(arg0, arg1);
    const actual = neon.vqaddq_u32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vqaddq_u64" {
    const arg0 = comptime makeData(neon.u64x2, 0);
    const arg1 = comptime makeData(neon.u64x2, 13);
    const expected = comptime neon.vqaddq_u64(arg0, arg1);
    const actual = neon.vqaddq_u64(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vqsub_s8" {
    const arg0 = comptime makeData(neon.i8x8, 0);
    const arg1 = comptime makeData(neon.i8x8, 13);
    const expected = comptime neon.vqsub_s8(arg0, arg1);
    const actual = neon.vqsub_s8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vqsub_s16" {
    const arg0 = comptime makeData(neon.i16x4, 0);
    const arg1 = comptime makeData(neon.i16x4, 13);
    const expected = comptime neon.vqsub_s16(arg0, arg1);
    const actual = neon.vqsub_s16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vqsub_s32" {
    const arg0 = comptime makeData(neon.i32x2, 0);
    const arg1 = comptime makeData(neon.i32x2, 13);
    const expected = comptime neon.vqsub_s32(arg0, arg1);
    const actual = neon.vqsub_s32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vqsub_s64" {
    const arg0 = comptime makeData(neon.i64x1, 0);
    const arg1 = comptime makeData(neon.i64x1, 13);
    const expected = comptime neon.vqsub_s64(arg0, arg1);
    const actual = neon.vqsub_s64(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vqsub_u8" {
    const arg0 = comptime makeData(neon.u8x8, 0);
    const arg1 = comptime makeData(neon.u8x8, 13);
    const expected = comptime neon.vqsub_u8(arg0, arg1);
    const actual = neon.vqsub_u8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vqsub_u16" {
    const arg0 = comptime makeData(neon.u16x4, 0);
    const arg1 = comptime makeData(neon.u16x4, 13);
    const expected = comptime neon.vqsub_u16(arg0, arg1);
    const actual = neon.vqsub_u16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vqsub_u32" {
    const arg0 = comptime makeData(neon.u32x2, 0);
    const arg1 = comptime makeData(neon.u32x2, 13);
    const expected = comptime neon.vqsub_u32(arg0, arg1);
    const actual = neon.vqsub_u32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vqsub_u64" {
    const arg0 = comptime makeData(neon.u64x1, 0);
    const arg1 = comptime makeData(neon.u64x1, 13);
    const expected = comptime neon.vqsub_u64(arg0, arg1);
    const actual = neon.vqsub_u64(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vqsubq_s8" {
    const arg0 = comptime makeData(neon.i8x16, 0);
    const arg1 = comptime makeData(neon.i8x16, 13);
    const expected = comptime neon.vqsubq_s8(arg0, arg1);
    const actual = neon.vqsubq_s8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vqsubq_s16" {
    const arg0 = comptime makeData(neon.i16x8, 0);
    const arg1 = comptime makeData(neon.i16x8, 13);
    const expected = comptime neon.vqsubq_s16(arg0, arg1);
    const actual = neon.vqsubq_s16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vqsubq_s32" {
    const arg0 = comptime makeData(neon.i32x4, 0);
    const arg1 = comptime makeData(neon.i32x4, 13);
    const expected = comptime neon.vqsubq_s32(arg0, arg1);
    const actual = neon.vqsubq_s32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vqsubq_s64" {
    const arg0 = comptime makeData(neon.i64x2, 0);
    const arg1 = comptime makeData(neon.i64x2, 13);
    const expected = comptime neon.vqsubq_s64(arg0, arg1);
    const actual = neon.vqsubq_s64(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vqsubq_u8" {
    const arg0 = comptime makeData(neon.u8x16, 0);
    const arg1 = comptime makeData(neon.u8x16, 13);
    const expected = comptime neon.vqsubq_u8(arg0, arg1);
    const actual = neon.vqsubq_u8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vqsubq_u16" {
    const arg0 = comptime makeData(neon.u16x8, 0);
    const arg1 = comptime makeData(neon.u16x8, 13);
    const expected = comptime neon.vqsubq_u16(arg0, arg1);
    const actual = neon.vqsubq_u16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vqsubq_u32" {
    const arg0 = comptime makeData(neon.u32x4, 0);
    const arg1 = comptime makeData(neon.u32x4, 13);
    const expected = comptime neon.vqsubq_u32(arg0, arg1);
    const actual = neon.vqsubq_u32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vqsubq_u64" {
    const arg0 = comptime makeData(neon.u64x2, 0);
    const arg1 = comptime makeData(neon.u64x2, 13);
    const expected = comptime neon.vqsubq_u64(arg0, arg1);
    const actual = neon.vqsubq_u64(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vqsubs_s32" {
    const arg0: i32 = 1;
    const arg1: i32 = 1;
    const expected = comptime neon.vqsubs_s32(arg0, arg1);
    const actual = neon.vqsubs_s32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vqsubs_u32" {
    const arg0: u32 = 1;
    const arg1: u32 = 1;
    const expected = comptime neon.vqsubs_u32(arg0, arg1);
    const actual = neon.vqsubs_u32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vqsubd_s64" {
    const arg0: i64 = 1;
    const arg1: i64 = 1;
    const expected = comptime neon.vqsubd_s64(arg0, arg1);
    const actual = neon.vqsubd_s64(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vqsubd_u64" {
    const arg0: u64 = 1;
    const arg1: u64 = 1;
    const expected = comptime neon.vqsubd_u64(arg0, arg1);
    const actual = neon.vqsubd_u64(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vqdmull_s16" {
    const arg0 = comptime makeData(neon.i16x4, 0);
    const arg1 = comptime makeData(neon.i16x4, 13);
    const expected = comptime neon.vqdmull_s16(arg0, arg1);
    const actual = neon.vqdmull_s16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vqdmull_s32" {
    const arg0 = comptime makeData(neon.i32x2, 0);
    const arg1 = comptime makeData(neon.i32x2, 13);
    const expected = comptime neon.vqdmull_s32(arg0, arg1);
    const actual = neon.vqdmull_s32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vqdmullh_s16" {
    const arg0: i16 = 1;
    const arg1: i16 = 1;
    const expected = comptime neon.vqdmullh_s16(arg0, arg1);
    const actual = neon.vqdmullh_s16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vqdmulls_s32" {
    const arg0: i32 = 1;
    const arg1: i32 = 1;
    const expected = comptime neon.vqdmulls_s32(arg0, arg1);
    const actual = neon.vqdmulls_s32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vand_s8" {
    const arg0 = comptime makeData(neon.i8x8, 0);
    const arg1 = comptime makeData(neon.i8x8, 13);
    const expected = comptime neon.vand_s8(arg0, arg1);
    const actual = neon.vand_s8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vand_s16" {
    const arg0 = comptime makeData(neon.i16x4, 0);
    const arg1 = comptime makeData(neon.i16x4, 13);
    const expected = comptime neon.vand_s16(arg0, arg1);
    const actual = neon.vand_s16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vand_s32" {
    const arg0 = comptime makeData(neon.i32x2, 0);
    const arg1 = comptime makeData(neon.i32x2, 13);
    const expected = comptime neon.vand_s32(arg0, arg1);
    const actual = neon.vand_s32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vand_s64" {
    const arg0 = comptime makeData(neon.i64x1, 0);
    const arg1 = comptime makeData(neon.i64x1, 13);
    const expected = comptime neon.vand_s64(arg0, arg1);
    const actual = neon.vand_s64(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vand_u8" {
    const arg0 = comptime makeData(neon.u8x8, 0);
    const arg1 = comptime makeData(neon.u8x8, 13);
    const expected = comptime neon.vand_u8(arg0, arg1);
    const actual = neon.vand_u8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vand_u16" {
    const arg0 = comptime makeData(neon.u16x4, 0);
    const arg1 = comptime makeData(neon.u16x4, 13);
    const expected = comptime neon.vand_u16(arg0, arg1);
    const actual = neon.vand_u16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vand_u32" {
    const arg0 = comptime makeData(neon.u32x2, 0);
    const arg1 = comptime makeData(neon.u32x2, 13);
    const expected = comptime neon.vand_u32(arg0, arg1);
    const actual = neon.vand_u32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vand_u64" {
    const arg0 = comptime makeData(neon.u64x1, 0);
    const arg1 = comptime makeData(neon.u64x1, 13);
    const expected = comptime neon.vand_u64(arg0, arg1);
    const actual = neon.vand_u64(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vand_p8" {
    const arg0 = comptime makeData(neon.p8x8, 0);
    const arg1 = comptime makeData(neon.p8x8, 13);
    const expected = comptime neon.vand_p8(arg0, arg1);
    const actual = neon.vand_p8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vand_p16" {
    const arg0 = comptime makeData(neon.p16x4, 0);
    const arg1 = comptime makeData(neon.p16x4, 13);
    const expected = comptime neon.vand_p16(arg0, arg1);
    const actual = neon.vand_p16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vand_p64" {
    const arg0 = comptime makeData(neon.p64x1, 0);
    const arg1 = comptime makeData(neon.p64x1, 13);
    const expected = comptime neon.vand_p64(arg0, arg1);
    const actual = neon.vand_p64(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vandq_s8" {
    const arg0 = comptime makeData(neon.i8x16, 0);
    const arg1 = comptime makeData(neon.i8x16, 13);
    const expected = comptime neon.vandq_s8(arg0, arg1);
    const actual = neon.vandq_s8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vandq_s16" {
    const arg0 = comptime makeData(neon.i16x8, 0);
    const arg1 = comptime makeData(neon.i16x8, 13);
    const expected = comptime neon.vandq_s16(arg0, arg1);
    const actual = neon.vandq_s16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vandq_s32" {
    const arg0 = comptime makeData(neon.i32x4, 0);
    const arg1 = comptime makeData(neon.i32x4, 13);
    const expected = comptime neon.vandq_s32(arg0, arg1);
    const actual = neon.vandq_s32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vandq_s64" {
    const arg0 = comptime makeData(neon.i64x2, 0);
    const arg1 = comptime makeData(neon.i64x2, 13);
    const expected = comptime neon.vandq_s64(arg0, arg1);
    const actual = neon.vandq_s64(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vandq_u8" {
    const arg0 = comptime makeData(neon.u8x16, 0);
    const arg1 = comptime makeData(neon.u8x16, 13);
    const expected = comptime neon.vandq_u8(arg0, arg1);
    const actual = neon.vandq_u8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vandq_u16" {
    const arg0 = comptime makeData(neon.u16x8, 0);
    const arg1 = comptime makeData(neon.u16x8, 13);
    const expected = comptime neon.vandq_u16(arg0, arg1);
    const actual = neon.vandq_u16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vandq_u32" {
    const arg0 = comptime makeData(neon.u32x4, 0);
    const arg1 = comptime makeData(neon.u32x4, 13);
    const expected = comptime neon.vandq_u32(arg0, arg1);
    const actual = neon.vandq_u32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vandq_u64" {
    const arg0 = comptime makeData(neon.u64x2, 0);
    const arg1 = comptime makeData(neon.u64x2, 13);
    const expected = comptime neon.vandq_u64(arg0, arg1);
    const actual = neon.vandq_u64(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vandq_p8" {
    const arg0 = comptime makeData(neon.p8x16, 0);
    const arg1 = comptime makeData(neon.p8x16, 13);
    const expected = comptime neon.vandq_p8(arg0, arg1);
    const actual = neon.vandq_p8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vandq_p16" {
    const arg0 = comptime makeData(neon.p16x8, 0);
    const arg1 = comptime makeData(neon.p16x8, 13);
    const expected = comptime neon.vandq_p16(arg0, arg1);
    const actual = neon.vandq_p16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vandq_p64" {
    const arg0 = comptime makeData(neon.p64x2, 0);
    const arg1 = comptime makeData(neon.p64x2, 13);
    const expected = comptime neon.vandq_p64(arg0, arg1);
    const actual = neon.vandq_p64(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vorr_s8" {
    const arg0 = comptime makeData(neon.i8x8, 0);
    const arg1 = comptime makeData(neon.i8x8, 13);
    const expected = comptime neon.vorr_s8(arg0, arg1);
    const actual = neon.vorr_s8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vorr_s16" {
    const arg0 = comptime makeData(neon.i16x4, 0);
    const arg1 = comptime makeData(neon.i16x4, 13);
    const expected = comptime neon.vorr_s16(arg0, arg1);
    const actual = neon.vorr_s16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vorr_s32" {
    const arg0 = comptime makeData(neon.i32x2, 0);
    const arg1 = comptime makeData(neon.i32x2, 13);
    const expected = comptime neon.vorr_s32(arg0, arg1);
    const actual = neon.vorr_s32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vorr_s64" {
    const arg0 = comptime makeData(neon.i64x1, 0);
    const arg1 = comptime makeData(neon.i64x1, 13);
    const expected = comptime neon.vorr_s64(arg0, arg1);
    const actual = neon.vorr_s64(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vorr_u8" {
    const arg0 = comptime makeData(neon.u8x8, 0);
    const arg1 = comptime makeData(neon.u8x8, 13);
    const expected = comptime neon.vorr_u8(arg0, arg1);
    const actual = neon.vorr_u8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vorr_u16" {
    const arg0 = comptime makeData(neon.u16x4, 0);
    const arg1 = comptime makeData(neon.u16x4, 13);
    const expected = comptime neon.vorr_u16(arg0, arg1);
    const actual = neon.vorr_u16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vorr_u32" {
    const arg0 = comptime makeData(neon.u32x2, 0);
    const arg1 = comptime makeData(neon.u32x2, 13);
    const expected = comptime neon.vorr_u32(arg0, arg1);
    const actual = neon.vorr_u32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vorr_u64" {
    const arg0 = comptime makeData(neon.u64x1, 0);
    const arg1 = comptime makeData(neon.u64x1, 13);
    const expected = comptime neon.vorr_u64(arg0, arg1);
    const actual = neon.vorr_u64(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vorrq_s8" {
    const arg0 = comptime makeData(neon.i8x16, 0);
    const arg1 = comptime makeData(neon.i8x16, 13);
    const expected = comptime neon.vorrq_s8(arg0, arg1);
    const actual = neon.vorrq_s8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vorrq_s16" {
    const arg0 = comptime makeData(neon.i16x8, 0);
    const arg1 = comptime makeData(neon.i16x8, 13);
    const expected = comptime neon.vorrq_s16(arg0, arg1);
    const actual = neon.vorrq_s16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vorrq_s32" {
    const arg0 = comptime makeData(neon.i32x4, 0);
    const arg1 = comptime makeData(neon.i32x4, 13);
    const expected = comptime neon.vorrq_s32(arg0, arg1);
    const actual = neon.vorrq_s32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vorrq_s64" {
    const arg0 = comptime makeData(neon.i64x2, 0);
    const arg1 = comptime makeData(neon.i64x2, 13);
    const expected = comptime neon.vorrq_s64(arg0, arg1);
    const actual = neon.vorrq_s64(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vorrq_u8" {
    const arg0 = comptime makeData(neon.u8x16, 0);
    const arg1 = comptime makeData(neon.u8x16, 13);
    const expected = comptime neon.vorrq_u8(arg0, arg1);
    const actual = neon.vorrq_u8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vorrq_u16" {
    const arg0 = comptime makeData(neon.u16x8, 0);
    const arg1 = comptime makeData(neon.u16x8, 13);
    const expected = comptime neon.vorrq_u16(arg0, arg1);
    const actual = neon.vorrq_u16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vorrq_u32" {
    const arg0 = comptime makeData(neon.u32x4, 0);
    const arg1 = comptime makeData(neon.u32x4, 13);
    const expected = comptime neon.vorrq_u32(arg0, arg1);
    const actual = neon.vorrq_u32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vorrq_u64" {
    const arg0 = comptime makeData(neon.u64x2, 0);
    const arg1 = comptime makeData(neon.u64x2, 13);
    const expected = comptime neon.vorrq_u64(arg0, arg1);
    const actual = neon.vorrq_u64(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "veor_s8" {
    const arg0 = comptime makeData(neon.i8x8, 0);
    const arg1 = comptime makeData(neon.i8x8, 13);
    const expected = comptime neon.veor_s8(arg0, arg1);
    const actual = neon.veor_s8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "veor_s16" {
    const arg0 = comptime makeData(neon.i16x4, 0);
    const arg1 = comptime makeData(neon.i16x4, 13);
    const expected = comptime neon.veor_s16(arg0, arg1);
    const actual = neon.veor_s16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "veor_s32" {
    const arg0 = comptime makeData(neon.i32x2, 0);
    const arg1 = comptime makeData(neon.i32x2, 13);
    const expected = comptime neon.veor_s32(arg0, arg1);
    const actual = neon.veor_s32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "veor_s64" {
    const arg0 = comptime makeData(neon.i64x1, 0);
    const arg1 = comptime makeData(neon.i64x1, 13);
    const expected = comptime neon.veor_s64(arg0, arg1);
    const actual = neon.veor_s64(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "veor_u8" {
    const arg0 = comptime makeData(neon.u8x8, 0);
    const arg1 = comptime makeData(neon.u8x8, 13);
    const expected = comptime neon.veor_u8(arg0, arg1);
    const actual = neon.veor_u8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "veor_u16" {
    const arg0 = comptime makeData(neon.u16x4, 0);
    const arg1 = comptime makeData(neon.u16x4, 13);
    const expected = comptime neon.veor_u16(arg0, arg1);
    const actual = neon.veor_u16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "veor_u32" {
    const arg0 = comptime makeData(neon.u32x2, 0);
    const arg1 = comptime makeData(neon.u32x2, 13);
    const expected = comptime neon.veor_u32(arg0, arg1);
    const actual = neon.veor_u32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "veor_u64" {
    const arg0 = comptime makeData(neon.u64x1, 0);
    const arg1 = comptime makeData(neon.u64x1, 13);
    const expected = comptime neon.veor_u64(arg0, arg1);
    const actual = neon.veor_u64(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "veorq_s8" {
    const arg0 = comptime makeData(neon.i8x16, 0);
    const arg1 = comptime makeData(neon.i8x16, 13);
    const expected = comptime neon.veorq_s8(arg0, arg1);
    const actual = neon.veorq_s8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "veorq_s16" {
    const arg0 = comptime makeData(neon.i16x8, 0);
    const arg1 = comptime makeData(neon.i16x8, 13);
    const expected = comptime neon.veorq_s16(arg0, arg1);
    const actual = neon.veorq_s16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "veorq_s32" {
    const arg0 = comptime makeData(neon.i32x4, 0);
    const arg1 = comptime makeData(neon.i32x4, 13);
    const expected = comptime neon.veorq_s32(arg0, arg1);
    const actual = neon.veorq_s32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "veorq_s64" {
    const arg0 = comptime makeData(neon.i64x2, 0);
    const arg1 = comptime makeData(neon.i64x2, 13);
    const expected = comptime neon.veorq_s64(arg0, arg1);
    const actual = neon.veorq_s64(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "veorq_u8" {
    const arg0 = comptime makeData(neon.u8x16, 0);
    const arg1 = comptime makeData(neon.u8x16, 13);
    const expected = comptime neon.veorq_u8(arg0, arg1);
    const actual = neon.veorq_u8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "veorq_u16" {
    const arg0 = comptime makeData(neon.u16x8, 0);
    const arg1 = comptime makeData(neon.u16x8, 13);
    const expected = comptime neon.veorq_u16(arg0, arg1);
    const actual = neon.veorq_u16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "veorq_u32" {
    const arg0 = comptime makeData(neon.u32x4, 0);
    const arg1 = comptime makeData(neon.u32x4, 13);
    const expected = comptime neon.veorq_u32(arg0, arg1);
    const actual = neon.veorq_u32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "veorq_u64" {
    const arg0 = comptime makeData(neon.u64x2, 0);
    const arg1 = comptime makeData(neon.u64x2, 13);
    const expected = comptime neon.veorq_u64(arg0, arg1);
    const actual = neon.veorq_u64(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vbic_s8" {
    const arg0 = comptime makeData(neon.i8x8, 0);
    const arg1 = comptime makeData(neon.i8x8, 13);
    const expected = comptime neon.vbic_s8(arg0, arg1);
    const actual = neon.vbic_s8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vbic_s16" {
    const arg0 = comptime makeData(neon.i16x4, 0);
    const arg1 = comptime makeData(neon.i16x4, 13);
    const expected = comptime neon.vbic_s16(arg0, arg1);
    const actual = neon.vbic_s16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vbic_s32" {
    const arg0 = comptime makeData(neon.i32x2, 0);
    const arg1 = comptime makeData(neon.i32x2, 13);
    const expected = comptime neon.vbic_s32(arg0, arg1);
    const actual = neon.vbic_s32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vbic_s64" {
    const arg0 = comptime makeData(neon.i64x1, 0);
    const arg1 = comptime makeData(neon.i64x1, 13);
    const expected = comptime neon.vbic_s64(arg0, arg1);
    const actual = neon.vbic_s64(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vbic_u8" {
    const arg0 = comptime makeData(neon.u8x8, 0);
    const arg1 = comptime makeData(neon.u8x8, 13);
    const expected = comptime neon.vbic_u8(arg0, arg1);
    const actual = neon.vbic_u8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vbic_u16" {
    const arg0 = comptime makeData(neon.u16x4, 0);
    const arg1 = comptime makeData(neon.u16x4, 13);
    const expected = comptime neon.vbic_u16(arg0, arg1);
    const actual = neon.vbic_u16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vbic_u32" {
    const arg0 = comptime makeData(neon.u32x2, 0);
    const arg1 = comptime makeData(neon.u32x2, 13);
    const expected = comptime neon.vbic_u32(arg0, arg1);
    const actual = neon.vbic_u32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vbic_u64" {
    const arg0 = comptime makeData(neon.u64x1, 0);
    const arg1 = comptime makeData(neon.u64x1, 13);
    const expected = comptime neon.vbic_u64(arg0, arg1);
    const actual = neon.vbic_u64(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vbicq_s8" {
    const arg0 = comptime makeData(neon.i8x16, 0);
    const arg1 = comptime makeData(neon.i8x16, 13);
    const expected = comptime neon.vbicq_s8(arg0, arg1);
    const actual = neon.vbicq_s8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vbicq_s16" {
    const arg0 = comptime makeData(neon.i16x8, 0);
    const arg1 = comptime makeData(neon.i16x8, 13);
    const expected = comptime neon.vbicq_s16(arg0, arg1);
    const actual = neon.vbicq_s16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vbicq_s32" {
    const arg0 = comptime makeData(neon.i32x4, 0);
    const arg1 = comptime makeData(neon.i32x4, 13);
    const expected = comptime neon.vbicq_s32(arg0, arg1);
    const actual = neon.vbicq_s32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vbicq_s64" {
    const arg0 = comptime makeData(neon.i64x2, 0);
    const arg1 = comptime makeData(neon.i64x2, 13);
    const expected = comptime neon.vbicq_s64(arg0, arg1);
    const actual = neon.vbicq_s64(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vbicq_u8" {
    const arg0 = comptime makeData(neon.u8x16, 0);
    const arg1 = comptime makeData(neon.u8x16, 13);
    const expected = comptime neon.vbicq_u8(arg0, arg1);
    const actual = neon.vbicq_u8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vbicq_u16" {
    const arg0 = comptime makeData(neon.u16x8, 0);
    const arg1 = comptime makeData(neon.u16x8, 13);
    const expected = comptime neon.vbicq_u16(arg0, arg1);
    const actual = neon.vbicq_u16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vbicq_u32" {
    const arg0 = comptime makeData(neon.u32x4, 0);
    const arg1 = comptime makeData(neon.u32x4, 13);
    const expected = comptime neon.vbicq_u32(arg0, arg1);
    const actual = neon.vbicq_u32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vbicq_u64" {
    const arg0 = comptime makeData(neon.u64x2, 0);
    const arg1 = comptime makeData(neon.u64x2, 13);
    const expected = comptime neon.vbicq_u64(arg0, arg1);
    const actual = neon.vbicq_u64(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vmvn_s8" {
    const arg0 = comptime makeData(neon.i8x8, 0);
    const expected = comptime neon.vmvn_s8(arg0);
    const actual = neon.vmvn_s8(arg0);
    try expectEqualApprox(expected, actual);
}

test "vmvn_s16" {
    const arg0 = comptime makeData(neon.i16x4, 0);
    const expected = comptime neon.vmvn_s16(arg0);
    const actual = neon.vmvn_s16(arg0);
    try expectEqualApprox(expected, actual);
}

test "vmvn_s32" {
    const arg0 = comptime makeData(neon.i32x2, 0);
    const expected = comptime neon.vmvn_s32(arg0);
    const actual = neon.vmvn_s32(arg0);
    try expectEqualApprox(expected, actual);
}

test "vmvn_u8" {
    const arg0 = comptime makeData(neon.u8x8, 0);
    const expected = comptime neon.vmvn_u8(arg0);
    const actual = neon.vmvn_u8(arg0);
    try expectEqualApprox(expected, actual);
}

test "vmvn_u16" {
    const arg0 = comptime makeData(neon.u16x4, 0);
    const expected = comptime neon.vmvn_u16(arg0);
    const actual = neon.vmvn_u16(arg0);
    try expectEqualApprox(expected, actual);
}

test "vmvn_u32" {
    const arg0 = comptime makeData(neon.u32x2, 0);
    const expected = comptime neon.vmvn_u32(arg0);
    const actual = neon.vmvn_u32(arg0);
    try expectEqualApprox(expected, actual);
}

test "vmvnq_s8" {
    const arg0 = comptime makeData(neon.i8x16, 0);
    const expected = comptime neon.vmvnq_s8(arg0);
    const actual = neon.vmvnq_s8(arg0);
    try expectEqualApprox(expected, actual);
}

test "vmvnq_s16" {
    const arg0 = comptime makeData(neon.i16x8, 0);
    const expected = comptime neon.vmvnq_s16(arg0);
    const actual = neon.vmvnq_s16(arg0);
    try expectEqualApprox(expected, actual);
}

test "vmvnq_s32" {
    const arg0 = comptime makeData(neon.i32x4, 0);
    const expected = comptime neon.vmvnq_s32(arg0);
    const actual = neon.vmvnq_s32(arg0);
    try expectEqualApprox(expected, actual);
}

test "vmvnq_u8" {
    const arg0 = comptime makeData(neon.u8x16, 0);
    const expected = comptime neon.vmvnq_u8(arg0);
    const actual = neon.vmvnq_u8(arg0);
    try expectEqualApprox(expected, actual);
}

test "vmvnq_u16" {
    const arg0 = comptime makeData(neon.u16x8, 0);
    const expected = comptime neon.vmvnq_u16(arg0);
    const actual = neon.vmvnq_u16(arg0);
    try expectEqualApprox(expected, actual);
}

test "vmvnq_u32" {
    const arg0 = comptime makeData(neon.u32x4, 0);
    const expected = comptime neon.vmvnq_u32(arg0);
    const actual = neon.vmvnq_u32(arg0);
    try expectEqualApprox(expected, actual);
}

test "vbsl_s8" {
    const arg0 = comptime makeData(neon.u8x8, 0);
    const arg1 = comptime makeData(neon.i8x8, 13);
    const arg2 = comptime makeData(neon.i8x8, 26);
    const expected = comptime neon.vbsl_s8(arg0, arg1, arg2);
    const actual = neon.vbsl_s8(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vbsl_s16" {
    const arg0 = comptime makeData(neon.u16x4, 0);
    const arg1 = comptime makeData(neon.i16x4, 13);
    const arg2 = comptime makeData(neon.i16x4, 26);
    const expected = comptime neon.vbsl_s16(arg0, arg1, arg2);
    const actual = neon.vbsl_s16(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vbsl_s32" {
    const arg0 = comptime makeData(neon.u32x2, 0);
    const arg1 = comptime makeData(neon.i32x2, 13);
    const arg2 = comptime makeData(neon.i32x2, 26);
    const expected = comptime neon.vbsl_s32(arg0, arg1, arg2);
    const actual = neon.vbsl_s32(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vbsl_s64" {
    const arg0 = comptime makeData(neon.u64x1, 0);
    const arg1 = comptime makeData(neon.i64x1, 13);
    const arg2 = comptime makeData(neon.i64x1, 26);
    const expected = comptime neon.vbsl_s64(arg0, arg1, arg2);
    const actual = neon.vbsl_s64(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vbsl_u8" {
    const arg0 = comptime makeData(neon.u8x8, 0);
    const arg1 = comptime makeData(neon.u8x8, 13);
    const arg2 = comptime makeData(neon.u8x8, 26);
    const expected = comptime neon.vbsl_u8(arg0, arg1, arg2);
    const actual = neon.vbsl_u8(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vbsl_u16" {
    const arg0 = comptime makeData(neon.u16x4, 0);
    const arg1 = comptime makeData(neon.u16x4, 13);
    const arg2 = comptime makeData(neon.u16x4, 26);
    const expected = comptime neon.vbsl_u16(arg0, arg1, arg2);
    const actual = neon.vbsl_u16(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vbsl_u32" {
    const arg0 = comptime makeData(neon.u32x2, 0);
    const arg1 = comptime makeData(neon.u32x2, 13);
    const arg2 = comptime makeData(neon.u32x2, 26);
    const expected = comptime neon.vbsl_u32(arg0, arg1, arg2);
    const actual = neon.vbsl_u32(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vbsl_u64" {
    const arg0 = comptime makeData(neon.u64x1, 0);
    const arg1 = comptime makeData(neon.u64x1, 13);
    const arg2 = comptime makeData(neon.u64x1, 26);
    const expected = comptime neon.vbsl_u64(arg0, arg1, arg2);
    const actual = neon.vbsl_u64(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vbsl_f32" {
    const arg0 = comptime makeData(neon.u32x2, 0);
    const arg1 = comptime makeData(neon.f32x2, 13);
    const arg2 = comptime makeData(neon.f32x2, 26);
    const expected = comptime neon.vbsl_f32(arg0, arg1, arg2);
    const actual = neon.vbsl_f32(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vbsl_f64" {
    const arg0 = comptime makeData(neon.u64x1, 0);
    const arg1 = comptime makeData(neon.f64x1, 13);
    const arg2 = comptime makeData(neon.f64x1, 26);
    const expected = comptime neon.vbsl_f64(arg0, arg1, arg2);
    const actual = neon.vbsl_f64(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vbsl_p8" {
    const arg0 = comptime makeData(neon.u8x8, 0);
    const arg1 = comptime makeData(neon.p8x8, 13);
    const arg2 = comptime makeData(neon.p8x8, 26);
    const expected = comptime neon.vbsl_p8(arg0, arg1, arg2);
    const actual = neon.vbsl_p8(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vbsl_p16" {
    const arg0 = comptime makeData(neon.u16x4, 0);
    const arg1 = comptime makeData(neon.p16x4, 13);
    const arg2 = comptime makeData(neon.p16x4, 26);
    const expected = comptime neon.vbsl_p16(arg0, arg1, arg2);
    const actual = neon.vbsl_p16(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vbsl_p64" {
    const arg0 = comptime makeData(neon.u64x1, 0);
    const arg1 = comptime makeData(neon.p64x1, 13);
    const arg2 = comptime makeData(neon.p64x1, 26);
    const expected = comptime neon.vbsl_p64(arg0, arg1, arg2);
    const actual = neon.vbsl_p64(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vbslq_s8" {
    const arg0 = comptime makeData(neon.u8x16, 0);
    const arg1 = comptime makeData(neon.i8x16, 13);
    const arg2 = comptime makeData(neon.i8x16, 26);
    const expected = comptime neon.vbslq_s8(arg0, arg1, arg2);
    const actual = neon.vbslq_s8(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vbslq_s16" {
    const arg0 = comptime makeData(neon.u16x8, 0);
    const arg1 = comptime makeData(neon.i16x8, 13);
    const arg2 = comptime makeData(neon.i16x8, 26);
    const expected = comptime neon.vbslq_s16(arg0, arg1, arg2);
    const actual = neon.vbslq_s16(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vbslq_s32" {
    const arg0 = comptime makeData(neon.u32x4, 0);
    const arg1 = comptime makeData(neon.i32x4, 13);
    const arg2 = comptime makeData(neon.i32x4, 26);
    const expected = comptime neon.vbslq_s32(arg0, arg1, arg2);
    const actual = neon.vbslq_s32(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vbslq_s64" {
    const arg0 = comptime makeData(neon.u64x2, 0);
    const arg1 = comptime makeData(neon.i64x2, 13);
    const arg2 = comptime makeData(neon.i64x2, 26);
    const expected = comptime neon.vbslq_s64(arg0, arg1, arg2);
    const actual = neon.vbslq_s64(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vbslq_u8" {
    const arg0 = comptime makeData(neon.u8x16, 0);
    const arg1 = comptime makeData(neon.u8x16, 13);
    const arg2 = comptime makeData(neon.u8x16, 26);
    const expected = comptime neon.vbslq_u8(arg0, arg1, arg2);
    const actual = neon.vbslq_u8(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vbslq_u16" {
    const arg0 = comptime makeData(neon.u16x8, 0);
    const arg1 = comptime makeData(neon.u16x8, 13);
    const arg2 = comptime makeData(neon.u16x8, 26);
    const expected = comptime neon.vbslq_u16(arg0, arg1, arg2);
    const actual = neon.vbslq_u16(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vbslq_u32" {
    const arg0 = comptime makeData(neon.u32x4, 0);
    const arg1 = comptime makeData(neon.u32x4, 13);
    const arg2 = comptime makeData(neon.u32x4, 26);
    const expected = comptime neon.vbslq_u32(arg0, arg1, arg2);
    const actual = neon.vbslq_u32(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vbslq_u64" {
    const arg0 = comptime makeData(neon.u64x2, 0);
    const arg1 = comptime makeData(neon.u64x2, 13);
    const arg2 = comptime makeData(neon.u64x2, 26);
    const expected = comptime neon.vbslq_u64(arg0, arg1, arg2);
    const actual = neon.vbslq_u64(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vbslq_f32" {
    const arg0 = comptime makeData(neon.u32x4, 0);
    const arg1 = comptime makeData(neon.f32x4, 13);
    const arg2 = comptime makeData(neon.f32x4, 26);
    const expected = comptime neon.vbslq_f32(arg0, arg1, arg2);
    const actual = neon.vbslq_f32(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vbslq_f64" {
    const arg0 = comptime makeData(neon.u64x2, 0);
    const arg1 = comptime makeData(neon.f64x2, 13);
    const arg2 = comptime makeData(neon.f64x2, 26);
    const expected = comptime neon.vbslq_f64(arg0, arg1, arg2);
    const actual = neon.vbslq_f64(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vbslq_p8" {
    const arg0 = comptime makeData(neon.u8x16, 0);
    const arg1 = comptime makeData(neon.p8x16, 13);
    const arg2 = comptime makeData(neon.p8x16, 26);
    const expected = comptime neon.vbslq_p8(arg0, arg1, arg2);
    const actual = neon.vbslq_p8(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vbslq_p16" {
    const arg0 = comptime makeData(neon.u16x8, 0);
    const arg1 = comptime makeData(neon.p16x8, 13);
    const arg2 = comptime makeData(neon.p16x8, 26);
    const expected = comptime neon.vbslq_p16(arg0, arg1, arg2);
    const actual = neon.vbslq_p16(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vbslq_p64" {
    const arg0 = comptime makeData(neon.u64x2, 0);
    const arg1 = comptime makeData(neon.p64x2, 13);
    const arg2 = comptime makeData(neon.p64x2, 26);
    const expected = comptime neon.vbslq_p64(arg0, arg1, arg2);
    const actual = neon.vbslq_p64(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vbcaxq_s8" {
    const arg0 = comptime makeData(neon.i8x16, 0);
    const arg1 = comptime makeData(neon.i8x16, 13);
    const arg2 = comptime makeData(neon.i8x16, 26);
    const expected = comptime neon.vbcaxq_s8(arg0, arg1, arg2);
    const actual = neon.vbcaxq_s8(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vbcaxq_s16" {
    const arg0 = comptime makeData(neon.i16x8, 0);
    const arg1 = comptime makeData(neon.i16x8, 13);
    const arg2 = comptime makeData(neon.i16x8, 26);
    const expected = comptime neon.vbcaxq_s16(arg0, arg1, arg2);
    const actual = neon.vbcaxq_s16(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vbcaxq_s32" {
    const arg0 = comptime makeData(neon.i32x4, 0);
    const arg1 = comptime makeData(neon.i32x4, 13);
    const arg2 = comptime makeData(neon.i32x4, 26);
    const expected = comptime neon.vbcaxq_s32(arg0, arg1, arg2);
    const actual = neon.vbcaxq_s32(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vbcaxq_s64" {
    const arg0 = comptime makeData(neon.i64x2, 0);
    const arg1 = comptime makeData(neon.i64x2, 13);
    const arg2 = comptime makeData(neon.i64x2, 26);
    const expected = comptime neon.vbcaxq_s64(arg0, arg1, arg2);
    const actual = neon.vbcaxq_s64(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vbcaxq_u8" {
    const arg0 = comptime makeData(neon.u8x16, 0);
    const arg1 = comptime makeData(neon.u8x16, 13);
    const arg2 = comptime makeData(neon.u8x16, 26);
    const expected = comptime neon.vbcaxq_u8(arg0, arg1, arg2);
    const actual = neon.vbcaxq_u8(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vbcaxq_u16" {
    const arg0 = comptime makeData(neon.u16x8, 0);
    const arg1 = comptime makeData(neon.u16x8, 13);
    const arg2 = comptime makeData(neon.u16x8, 26);
    const expected = comptime neon.vbcaxq_u16(arg0, arg1, arg2);
    const actual = neon.vbcaxq_u16(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vbcaxq_u32" {
    const arg0 = comptime makeData(neon.u32x4, 0);
    const arg1 = comptime makeData(neon.u32x4, 13);
    const arg2 = comptime makeData(neon.u32x4, 26);
    const expected = comptime neon.vbcaxq_u32(arg0, arg1, arg2);
    const actual = neon.vbcaxq_u32(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vbcaxq_u64" {
    const arg0 = comptime makeData(neon.u64x2, 0);
    const arg1 = comptime makeData(neon.u64x2, 13);
    const arg2 = comptime makeData(neon.u64x2, 26);
    const expected = comptime neon.vbcaxq_u64(arg0, arg1, arg2);
    const actual = neon.vbcaxq_u64(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vcnt_u8" {
    const arg0 = comptime makeData(neon.u8x8, 0);
    const expected = comptime neon.vcnt_u8(arg0);
    const actual = neon.vcnt_u8(arg0);
    try expectEqualApprox(expected, actual);
}

test "vcnt_s8" {
    const arg0 = comptime makeData(neon.i8x8, 0);
    const expected = comptime neon.vcnt_s8(arg0);
    const actual = neon.vcnt_s8(arg0);
    try expectEqualApprox(expected, actual);
}

test "vcnt_p8" {
    const arg0 = comptime makeData(neon.p8x8, 0);
    const expected = comptime neon.vcnt_p8(arg0);
    const actual = neon.vcnt_p8(arg0);
    try expectEqualApprox(expected, actual);
}

test "vcntq_u8" {
    const arg0 = comptime makeData(neon.u8x16, 0);
    const expected = comptime neon.vcntq_u8(arg0);
    const actual = neon.vcntq_u8(arg0);
    try expectEqualApprox(expected, actual);
}

test "vcntq_s8" {
    const arg0 = comptime makeData(neon.i8x16, 0);
    const expected = comptime neon.vcntq_s8(arg0);
    const actual = neon.vcntq_s8(arg0);
    try expectEqualApprox(expected, actual);
}

test "vcntq_p8" {
    const arg0 = comptime makeData(neon.p8x16, 0);
    const expected = comptime neon.vcntq_p8(arg0);
    const actual = neon.vcntq_p8(arg0);
    try expectEqualApprox(expected, actual);
}

test "vclz_u8" {
    const arg0 = comptime makeData(neon.u8x8, 0);
    const expected = comptime neon.vclz_u8(arg0);
    const actual = neon.vclz_u8(arg0);
    try expectEqualApprox(expected, actual);
}

test "vclz_u16" {
    const arg0 = comptime makeData(neon.u16x4, 0);
    const expected = comptime neon.vclz_u16(arg0);
    const actual = neon.vclz_u16(arg0);
    try expectEqualApprox(expected, actual);
}

test "vclz_u32" {
    const arg0 = comptime makeData(neon.u32x2, 0);
    const expected = comptime neon.vclz_u32(arg0);
    const actual = neon.vclz_u32(arg0);
    try expectEqualApprox(expected, actual);
}

test "vclz_s8" {
    const arg0 = comptime makeData(neon.i8x8, 0);
    const expected = comptime neon.vclz_s8(arg0);
    const actual = neon.vclz_s8(arg0);
    try expectEqualApprox(expected, actual);
}

test "vclz_s16" {
    const arg0 = comptime makeData(neon.i16x4, 0);
    const expected = comptime neon.vclz_s16(arg0);
    const actual = neon.vclz_s16(arg0);
    try expectEqualApprox(expected, actual);
}

test "vclz_s32" {
    const arg0 = comptime makeData(neon.i32x2, 0);
    const expected = comptime neon.vclz_s32(arg0);
    const actual = neon.vclz_s32(arg0);
    try expectEqualApprox(expected, actual);
}

test "vclzq_u8" {
    const arg0 = comptime makeData(neon.u8x16, 0);
    const expected = comptime neon.vclzq_u8(arg0);
    const actual = neon.vclzq_u8(arg0);
    try expectEqualApprox(expected, actual);
}

test "vclzq_u16" {
    const arg0 = comptime makeData(neon.u16x8, 0);
    const expected = comptime neon.vclzq_u16(arg0);
    const actual = neon.vclzq_u16(arg0);
    try expectEqualApprox(expected, actual);
}

test "vclzq_u32" {
    const arg0 = comptime makeData(neon.u32x4, 0);
    const expected = comptime neon.vclzq_u32(arg0);
    const actual = neon.vclzq_u32(arg0);
    try expectEqualApprox(expected, actual);
}

test "vclzq_s8" {
    const arg0 = comptime makeData(neon.i8x16, 0);
    const expected = comptime neon.vclzq_s8(arg0);
    const actual = neon.vclzq_s8(arg0);
    try expectEqualApprox(expected, actual);
}

test "vclzq_s16" {
    const arg0 = comptime makeData(neon.i16x8, 0);
    const expected = comptime neon.vclzq_s16(arg0);
    const actual = neon.vclzq_s16(arg0);
    try expectEqualApprox(expected, actual);
}

test "vclzq_s32" {
    const arg0 = comptime makeData(neon.i32x4, 0);
    const expected = comptime neon.vclzq_s32(arg0);
    const actual = neon.vclzq_s32(arg0);
    try expectEqualApprox(expected, actual);
}

test "vaeseq_u8" {
    const arg0 = comptime makeData(neon.u8x16, 0);
    const arg1 = comptime makeData(neon.u8x16, 13);
    _ = neon.vaeseq_u8(arg0, arg1);
}

test "vaesdq_u8" {
    const arg0 = comptime makeData(neon.u8x16, 0);
    const arg1 = comptime makeData(neon.u8x16, 13);
    _ = neon.vaesdq_u8(arg0, arg1);
}

test "vaesmcq_u8" {
    const arg0 = comptime makeData(neon.u8x16, 0);
    _ = neon.vaesmcq_u8(arg0);
}

test "vaesimcq_u8" {
    const arg0 = comptime makeData(neon.u8x16, 0);
    _ = neon.vaesimcq_u8(arg0);
}

test "vmull_p8" {
    const arg0 = comptime makeData(neon.p8x8, 0);
    const arg1 = comptime makeData(neon.p8x8, 13);
    const expected = comptime neon.vmull_p8(arg0, arg1);
    const actual = neon.vmull_p8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vmull_p64" {
    const arg0 = comptime makeData(neon.p64, 0);
    const arg1 = comptime makeData(neon.p64, 13);
    const expected = comptime neon.vmull_p64(arg0, arg1);
    const actual = neon.vmull_p64(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vmovl_s8" {
    const arg0 = comptime makeData(neon.i8x8, 0);
    const expected = comptime neon.vmovl_s8(arg0);
    const actual = neon.vmovl_s8(arg0);
    try expectEqualApprox(expected, actual);
}

test "vmovl_s16" {
    const arg0 = comptime makeData(neon.i16x4, 0);
    const expected = comptime neon.vmovl_s16(arg0);
    const actual = neon.vmovl_s16(arg0);
    try expectEqualApprox(expected, actual);
}

test "vmovl_s32" {
    const arg0 = comptime makeData(neon.i32x2, 0);
    const expected = comptime neon.vmovl_s32(arg0);
    const actual = neon.vmovl_s32(arg0);
    try expectEqualApprox(expected, actual);
}

test "vmovl_u8" {
    const arg0 = comptime makeData(neon.u8x8, 0);
    const expected = comptime neon.vmovl_u8(arg0);
    const actual = neon.vmovl_u8(arg0);
    try expectEqualApprox(expected, actual);
}

test "vmovl_u16" {
    const arg0 = comptime makeData(neon.u16x4, 0);
    const expected = comptime neon.vmovl_u16(arg0);
    const actual = neon.vmovl_u16(arg0);
    try expectEqualApprox(expected, actual);
}

test "vmovl_u32" {
    const arg0 = comptime makeData(neon.u32x2, 0);
    const expected = comptime neon.vmovl_u32(arg0);
    const actual = neon.vmovl_u32(arg0);
    try expectEqualApprox(expected, actual);
}

test "vmovl_high_s8" {
    const arg0 = comptime makeData(neon.i8x16, 0);
    const expected = comptime neon.vmovl_high_s8(arg0);
    const actual = neon.vmovl_high_s8(arg0);
    try expectEqualApprox(expected, actual);
}

test "vmovl_high_s16" {
    const arg0 = comptime makeData(neon.i16x8, 0);
    const expected = comptime neon.vmovl_high_s16(arg0);
    const actual = neon.vmovl_high_s16(arg0);
    try expectEqualApprox(expected, actual);
}

test "vmovl_high_s32" {
    const arg0 = comptime makeData(neon.i32x4, 0);
    const expected = comptime neon.vmovl_high_s32(arg0);
    const actual = neon.vmovl_high_s32(arg0);
    try expectEqualApprox(expected, actual);
}

test "vmovl_high_u8" {
    const arg0 = comptime makeData(neon.u8x16, 0);
    const expected = comptime neon.vmovl_high_u8(arg0);
    const actual = neon.vmovl_high_u8(arg0);
    try expectEqualApprox(expected, actual);
}

test "vmovl_high_u16" {
    const arg0 = comptime makeData(neon.u16x8, 0);
    const expected = comptime neon.vmovl_high_u16(arg0);
    const actual = neon.vmovl_high_u16(arg0);
    try expectEqualApprox(expected, actual);
}

test "vmovl_high_u32" {
    const arg0 = comptime makeData(neon.u32x4, 0);
    const expected = comptime neon.vmovl_high_u32(arg0);
    const actual = neon.vmovl_high_u32(arg0);
    try expectEqualApprox(expected, actual);
}

test "vmovn_s16" {
    const arg0 = comptime makeData(neon.i16x8, 0);
    const expected = comptime neon.vmovn_s16(arg0);
    const actual = neon.vmovn_s16(arg0);
    try expectEqualApprox(expected, actual);
}

test "vmovn_s32" {
    const arg0 = comptime makeData(neon.i32x4, 0);
    const expected = comptime neon.vmovn_s32(arg0);
    const actual = neon.vmovn_s32(arg0);
    try expectEqualApprox(expected, actual);
}

test "vmovn_s64" {
    const arg0 = comptime makeData(neon.i64x2, 0);
    const expected = comptime neon.vmovn_s64(arg0);
    const actual = neon.vmovn_s64(arg0);
    try expectEqualApprox(expected, actual);
}

test "vmovn_u16" {
    const arg0 = comptime makeData(neon.u16x8, 0);
    const expected = comptime neon.vmovn_u16(arg0);
    const actual = neon.vmovn_u16(arg0);
    try expectEqualApprox(expected, actual);
}

test "vmovn_u32" {
    const arg0 = comptime makeData(neon.u32x4, 0);
    const expected = comptime neon.vmovn_u32(arg0);
    const actual = neon.vmovn_u32(arg0);
    try expectEqualApprox(expected, actual);
}

test "vmovn_u64" {
    const arg0 = comptime makeData(neon.u64x2, 0);
    const expected = comptime neon.vmovn_u64(arg0);
    const actual = neon.vmovn_u64(arg0);
    try expectEqualApprox(expected, actual);
}

test "vcvt_f32_s32" {
    const arg0 = comptime makeData(neon.i32x2, 0);
    const expected = comptime neon.vcvt_f32_s32(arg0);
    const actual = neon.vcvt_f32_s32(arg0);
    try expectEqualApprox(expected, actual);
}

test "vcvt_f32_u32" {
    const arg0 = comptime makeData(neon.u32x2, 0);
    const expected = comptime neon.vcvt_f32_u32(arg0);
    const actual = neon.vcvt_f32_u32(arg0);
    try expectEqualApprox(expected, actual);
}

test "vcvt_s32_f32" {
    const arg0 = comptime makeData(neon.f32x2, 0);
    const expected = comptime neon.vcvt_s32_f32(arg0);
    const actual = neon.vcvt_s32_f32(arg0);
    try expectEqualApprox(expected, actual);
}

test "vcvt_u32_f32" {
    const arg0 = comptime makeData(neon.f32x2, 0);
    const expected = comptime neon.vcvt_u32_f32(arg0);
    const actual = neon.vcvt_u32_f32(arg0);
    try expectEqualApprox(expected, actual);
}

test "vcvtq_f32_s32" {
    const arg0 = comptime makeData(neon.i32x4, 0);
    const expected = comptime neon.vcvtq_f32_s32(arg0);
    const actual = neon.vcvtq_f32_s32(arg0);
    try expectEqualApprox(expected, actual);
}

test "vcvtq_f32_u32" {
    const arg0 = comptime makeData(neon.u32x4, 0);
    const expected = comptime neon.vcvtq_f32_u32(arg0);
    const actual = neon.vcvtq_f32_u32(arg0);
    try expectEqualApprox(expected, actual);
}

test "vcvtq_s32_f32" {
    const arg0 = comptime makeData(neon.f32x4, 0);
    const expected = comptime neon.vcvtq_s32_f32(arg0);
    const actual = neon.vcvtq_s32_f32(arg0);
    try expectEqualApprox(expected, actual);
}

test "vcvtq_u32_f32" {
    const arg0 = comptime makeData(neon.f32x4, 0);
    const expected = comptime neon.vcvtq_u32_f32(arg0);
    const actual = neon.vcvtq_u32_f32(arg0);
    try expectEqualApprox(expected, actual);
}

test "vcvtq_f64_s64" {
    const arg0 = comptime makeData(neon.i64x2, 0);
    const expected = comptime neon.vcvtq_f64_s64(arg0);
    const actual = neon.vcvtq_f64_s64(arg0);
    try expectEqualApprox(expected, actual);
}

test "vcvtq_f64_u64" {
    const arg0 = comptime makeData(neon.u64x2, 0);
    const expected = comptime neon.vcvtq_f64_u64(arg0);
    const actual = neon.vcvtq_f64_u64(arg0);
    try expectEqualApprox(expected, actual);
}

test "vcvtq_s64_f64" {
    const arg0 = comptime makeData(neon.f64x2, 0);
    const expected = comptime neon.vcvtq_s64_f64(arg0);
    const actual = neon.vcvtq_s64_f64(arg0);
    try expectEqualApprox(expected, actual);
}

test "vcvtq_u64_f64" {
    const arg0 = comptime makeData(neon.f64x2, 0);
    const expected = comptime neon.vcvtq_u64_f64(arg0);
    const actual = neon.vcvtq_u64_f64(arg0);
    try expectEqualApprox(expected, actual);
}

test "vreinterpret_s8_u8" {
    const arg0 = comptime makeData(neon.u8x8, 0);
    const expected = comptime neon.vreinterpret_s8_u8(arg0);
    const actual = neon.vreinterpret_s8_u8(arg0);
    try expectEqualApprox(expected, actual);
}

test "vreinterpret_u8_s8" {
    const arg0 = comptime makeData(neon.i8x8, 0);
    const expected = comptime neon.vreinterpret_u8_s8(arg0);
    const actual = neon.vreinterpret_u8_s8(arg0);
    try expectEqualApprox(expected, actual);
}

test "vreinterpret_s16_u16" {
    const arg0 = comptime makeData(neon.u16x4, 0);
    const expected = comptime neon.vreinterpret_s16_u16(arg0);
    const actual = neon.vreinterpret_s16_u16(arg0);
    try expectEqualApprox(expected, actual);
}

test "vreinterpret_u16_s16" {
    const arg0 = comptime makeData(neon.i16x4, 0);
    const expected = comptime neon.vreinterpret_u16_s16(arg0);
    const actual = neon.vreinterpret_u16_s16(arg0);
    try expectEqualApprox(expected, actual);
}

test "vreinterpret_s32_u32" {
    const arg0 = comptime makeData(neon.u32x2, 0);
    const expected = comptime neon.vreinterpret_s32_u32(arg0);
    const actual = neon.vreinterpret_s32_u32(arg0);
    try expectEqualApprox(expected, actual);
}

test "vreinterpret_u32_s32" {
    const arg0 = comptime makeData(neon.i32x2, 0);
    const expected = comptime neon.vreinterpret_u32_s32(arg0);
    const actual = neon.vreinterpret_u32_s32(arg0);
    try expectEqualApprox(expected, actual);
}

test "vreinterpret_f32_s32" {
    const arg0 = comptime makeData(neon.i32x2, 0);
    const expected = comptime neon.vreinterpret_f32_s32(arg0);
    const actual = neon.vreinterpret_f32_s32(arg0);
    try expectEqualApprox(expected, actual);
}

test "vreinterpret_s32_f32" {
    const arg0 = comptime makeData(neon.f32x2, 0);
    const expected = comptime neon.vreinterpret_s32_f32(arg0);
    const actual = neon.vreinterpret_s32_f32(arg0);
    try expectEqualApprox(expected, actual);
}

test "vreinterpret_f32_u32" {
    const arg0 = comptime makeData(neon.u32x2, 0);
    const expected = comptime neon.vreinterpret_f32_u32(arg0);
    const actual = neon.vreinterpret_f32_u32(arg0);
    try expectEqualApprox(expected, actual);
}

test "vreinterpret_u32_f32" {
    const arg0 = comptime makeData(neon.f32x2, 0);
    const expected = comptime neon.vreinterpret_u32_f32(arg0);
    const actual = neon.vreinterpret_u32_f32(arg0);
    try expectEqualApprox(expected, actual);
}

test "vreinterpretq_s8_u8" {
    const arg0 = comptime makeData(neon.u8x16, 0);
    const expected = comptime neon.vreinterpretq_s8_u8(arg0);
    const actual = neon.vreinterpretq_s8_u8(arg0);
    try expectEqualApprox(expected, actual);
}

test "vreinterpretq_u8_s8" {
    const arg0 = comptime makeData(neon.i8x16, 0);
    const expected = comptime neon.vreinterpretq_u8_s8(arg0);
    const actual = neon.vreinterpretq_u8_s8(arg0);
    try expectEqualApprox(expected, actual);
}

test "vreinterpretq_s16_u16" {
    const arg0 = comptime makeData(neon.u16x8, 0);
    const expected = comptime neon.vreinterpretq_s16_u16(arg0);
    const actual = neon.vreinterpretq_s16_u16(arg0);
    try expectEqualApprox(expected, actual);
}

test "vreinterpretq_u16_s16" {
    const arg0 = comptime makeData(neon.i16x8, 0);
    const expected = comptime neon.vreinterpretq_u16_s16(arg0);
    const actual = neon.vreinterpretq_u16_s16(arg0);
    try expectEqualApprox(expected, actual);
}

test "vreinterpretq_s32_u32" {
    const arg0 = comptime makeData(neon.u32x4, 0);
    const expected = comptime neon.vreinterpretq_s32_u32(arg0);
    const actual = neon.vreinterpretq_s32_u32(arg0);
    try expectEqualApprox(expected, actual);
}

test "vreinterpretq_u32_s32" {
    const arg0 = comptime makeData(neon.i32x4, 0);
    const expected = comptime neon.vreinterpretq_u32_s32(arg0);
    const actual = neon.vreinterpretq_u32_s32(arg0);
    try expectEqualApprox(expected, actual);
}

test "vreinterpretq_s64_u64" {
    const arg0 = comptime makeData(neon.u64x2, 0);
    const expected = comptime neon.vreinterpretq_s64_u64(arg0);
    const actual = neon.vreinterpretq_s64_u64(arg0);
    try expectEqualApprox(expected, actual);
}

test "vreinterpretq_u64_s64" {
    const arg0 = comptime makeData(neon.i64x2, 0);
    const expected = comptime neon.vreinterpretq_u64_s64(arg0);
    const actual = neon.vreinterpretq_u64_s64(arg0);
    try expectEqualApprox(expected, actual);
}

test "vreinterpretq_f32_s32" {
    const arg0 = comptime makeData(neon.i32x4, 0);
    const expected = comptime neon.vreinterpretq_f32_s32(arg0);
    const actual = neon.vreinterpretq_f32_s32(arg0);
    try expectEqualApprox(expected, actual);
}

test "vreinterpretq_s32_f32" {
    const arg0 = comptime makeData(neon.f32x4, 0);
    const expected = comptime neon.vreinterpretq_s32_f32(arg0);
    const actual = neon.vreinterpretq_s32_f32(arg0);
    try expectEqualApprox(expected, actual);
}

test "vreinterpretq_f32_u32" {
    const arg0 = comptime makeData(neon.u32x4, 0);
    const expected = comptime neon.vreinterpretq_f32_u32(arg0);
    const actual = neon.vreinterpretq_f32_u32(arg0);
    try expectEqualApprox(expected, actual);
}

test "vreinterpretq_u32_f32" {
    const arg0 = comptime makeData(neon.f32x4, 0);
    const expected = comptime neon.vreinterpretq_u32_f32(arg0);
    const actual = neon.vreinterpretq_u32_f32(arg0);
    try expectEqualApprox(expected, actual);
}

test "vreinterpretq_f64_s64" {
    const arg0 = comptime makeData(neon.i64x2, 0);
    const expected = comptime neon.vreinterpretq_f64_s64(arg0);
    const actual = neon.vreinterpretq_f64_s64(arg0);
    try expectEqualApprox(expected, actual);
}

test "vreinterpretq_s64_f64" {
    const arg0 = comptime makeData(neon.f64x2, 0);
    const expected = comptime neon.vreinterpretq_s64_f64(arg0);
    const actual = neon.vreinterpretq_s64_f64(arg0);
    try expectEqualApprox(expected, actual);
}

test "vreinterpretq_f64_u64" {
    const arg0 = comptime makeData(neon.u64x2, 0);
    const expected = comptime neon.vreinterpretq_f64_u64(arg0);
    const actual = neon.vreinterpretq_f64_u64(arg0);
    try expectEqualApprox(expected, actual);
}

test "vreinterpretq_u64_f64" {
    const arg0 = comptime makeData(neon.f64x2, 0);
    const expected = comptime neon.vreinterpretq_u64_f64(arg0);
    const actual = neon.vreinterpretq_u64_f64(arg0);
    try expectEqualApprox(expected, actual);
}

test "vceq_s8" {
    const arg0 = comptime makeData(neon.i8x8, 0);
    const arg1 = comptime makeData(neon.i8x8, 13);
    const expected = comptime neon.vceq_s8(arg0, arg1);
    const actual = neon.vceq_s8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vceq_s16" {
    const arg0 = comptime makeData(neon.i16x4, 0);
    const arg1 = comptime makeData(neon.i16x4, 13);
    const expected = comptime neon.vceq_s16(arg0, arg1);
    const actual = neon.vceq_s16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vceq_s32" {
    const arg0 = comptime makeData(neon.i32x2, 0);
    const arg1 = comptime makeData(neon.i32x2, 13);
    const expected = comptime neon.vceq_s32(arg0, arg1);
    const actual = neon.vceq_s32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vceq_u8" {
    const arg0 = comptime makeData(neon.u8x8, 0);
    const arg1 = comptime makeData(neon.u8x8, 13);
    const expected = comptime neon.vceq_u8(arg0, arg1);
    const actual = neon.vceq_u8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vceq_u16" {
    const arg0 = comptime makeData(neon.u16x4, 0);
    const arg1 = comptime makeData(neon.u16x4, 13);
    const expected = comptime neon.vceq_u16(arg0, arg1);
    const actual = neon.vceq_u16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vceq_u32" {
    const arg0 = comptime makeData(neon.u32x2, 0);
    const arg1 = comptime makeData(neon.u32x2, 13);
    const expected = comptime neon.vceq_u32(arg0, arg1);
    const actual = neon.vceq_u32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vceq_f32" {
    const arg0 = comptime makeData(neon.f32x2, 0);
    const arg1 = comptime makeData(neon.f32x2, 13);
    const expected = comptime neon.vceq_f32(arg0, arg1);
    const actual = neon.vceq_f32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vceqq_s8" {
    const arg0 = comptime makeData(neon.i8x16, 0);
    const arg1 = comptime makeData(neon.i8x16, 13);
    const expected = comptime neon.vceqq_s8(arg0, arg1);
    const actual = neon.vceqq_s8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vceqq_s16" {
    const arg0 = comptime makeData(neon.i16x8, 0);
    const arg1 = comptime makeData(neon.i16x8, 13);
    const expected = comptime neon.vceqq_s16(arg0, arg1);
    const actual = neon.vceqq_s16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vceqq_s32" {
    const arg0 = comptime makeData(neon.i32x4, 0);
    const arg1 = comptime makeData(neon.i32x4, 13);
    const expected = comptime neon.vceqq_s32(arg0, arg1);
    const actual = neon.vceqq_s32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vceqq_u8" {
    const arg0 = comptime makeData(neon.u8x16, 0);
    const arg1 = comptime makeData(neon.u8x16, 13);
    const expected = comptime neon.vceqq_u8(arg0, arg1);
    const actual = neon.vceqq_u8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vceqq_u16" {
    const arg0 = comptime makeData(neon.u16x8, 0);
    const arg1 = comptime makeData(neon.u16x8, 13);
    const expected = comptime neon.vceqq_u16(arg0, arg1);
    const actual = neon.vceqq_u16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vceqq_u32" {
    const arg0 = comptime makeData(neon.u32x4, 0);
    const arg1 = comptime makeData(neon.u32x4, 13);
    const expected = comptime neon.vceqq_u32(arg0, arg1);
    const actual = neon.vceqq_u32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vceqq_f32" {
    const arg0 = comptime makeData(neon.f32x4, 0);
    const arg1 = comptime makeData(neon.f32x4, 13);
    const expected = comptime neon.vceqq_f32(arg0, arg1);
    const actual = neon.vceqq_f32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vceqq_f64" {
    const arg0 = comptime makeData(neon.f64x2, 0);
    const arg1 = comptime makeData(neon.f64x2, 13);
    const expected = comptime neon.vceqq_f64(arg0, arg1);
    const actual = neon.vceqq_f64(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vcge_s8" {
    const arg0 = comptime makeData(neon.i8x8, 0);
    const arg1 = comptime makeData(neon.i8x8, 13);
    const expected = comptime neon.vcge_s8(arg0, arg1);
    const actual = neon.vcge_s8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vcge_s16" {
    const arg0 = comptime makeData(neon.i16x4, 0);
    const arg1 = comptime makeData(neon.i16x4, 13);
    const expected = comptime neon.vcge_s16(arg0, arg1);
    const actual = neon.vcge_s16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vcge_s32" {
    const arg0 = comptime makeData(neon.i32x2, 0);
    const arg1 = comptime makeData(neon.i32x2, 13);
    const expected = comptime neon.vcge_s32(arg0, arg1);
    const actual = neon.vcge_s32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vcge_u8" {
    const arg0 = comptime makeData(neon.u8x8, 0);
    const arg1 = comptime makeData(neon.u8x8, 13);
    const expected = comptime neon.vcge_u8(arg0, arg1);
    const actual = neon.vcge_u8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vcge_u16" {
    const arg0 = comptime makeData(neon.u16x4, 0);
    const arg1 = comptime makeData(neon.u16x4, 13);
    const expected = comptime neon.vcge_u16(arg0, arg1);
    const actual = neon.vcge_u16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vcge_u32" {
    const arg0 = comptime makeData(neon.u32x2, 0);
    const arg1 = comptime makeData(neon.u32x2, 13);
    const expected = comptime neon.vcge_u32(arg0, arg1);
    const actual = neon.vcge_u32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vcge_f32" {
    const arg0 = comptime makeData(neon.f32x2, 0);
    const arg1 = comptime makeData(neon.f32x2, 13);
    const expected = comptime neon.vcge_f32(arg0, arg1);
    const actual = neon.vcge_f32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vcgeq_s8" {
    const arg0 = comptime makeData(neon.i8x16, 0);
    const arg1 = comptime makeData(neon.i8x16, 13);
    const expected = comptime neon.vcgeq_s8(arg0, arg1);
    const actual = neon.vcgeq_s8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vcgeq_s16" {
    const arg0 = comptime makeData(neon.i16x8, 0);
    const arg1 = comptime makeData(neon.i16x8, 13);
    const expected = comptime neon.vcgeq_s16(arg0, arg1);
    const actual = neon.vcgeq_s16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vcgeq_s32" {
    const arg0 = comptime makeData(neon.i32x4, 0);
    const arg1 = comptime makeData(neon.i32x4, 13);
    const expected = comptime neon.vcgeq_s32(arg0, arg1);
    const actual = neon.vcgeq_s32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vcgeq_u8" {
    const arg0 = comptime makeData(neon.u8x16, 0);
    const arg1 = comptime makeData(neon.u8x16, 13);
    const expected = comptime neon.vcgeq_u8(arg0, arg1);
    const actual = neon.vcgeq_u8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vcgeq_u16" {
    const arg0 = comptime makeData(neon.u16x8, 0);
    const arg1 = comptime makeData(neon.u16x8, 13);
    const expected = comptime neon.vcgeq_u16(arg0, arg1);
    const actual = neon.vcgeq_u16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vcgeq_u32" {
    const arg0 = comptime makeData(neon.u32x4, 0);
    const arg1 = comptime makeData(neon.u32x4, 13);
    const expected = comptime neon.vcgeq_u32(arg0, arg1);
    const actual = neon.vcgeq_u32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vcgeq_f32" {
    const arg0 = comptime makeData(neon.f32x4, 0);
    const arg1 = comptime makeData(neon.f32x4, 13);
    const expected = comptime neon.vcgeq_f32(arg0, arg1);
    const actual = neon.vcgeq_f32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vcgeq_f64" {
    const arg0 = comptime makeData(neon.f64x2, 0);
    const arg1 = comptime makeData(neon.f64x2, 13);
    const expected = comptime neon.vcgeq_f64(arg0, arg1);
    const actual = neon.vcgeq_f64(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vcgt_s8" {
    const arg0 = comptime makeData(neon.i8x8, 0);
    const arg1 = comptime makeData(neon.i8x8, 13);
    const expected = comptime neon.vcgt_s8(arg0, arg1);
    const actual = neon.vcgt_s8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vcgt_s16" {
    const arg0 = comptime makeData(neon.i16x4, 0);
    const arg1 = comptime makeData(neon.i16x4, 13);
    const expected = comptime neon.vcgt_s16(arg0, arg1);
    const actual = neon.vcgt_s16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vcgt_s32" {
    const arg0 = comptime makeData(neon.i32x2, 0);
    const arg1 = comptime makeData(neon.i32x2, 13);
    const expected = comptime neon.vcgt_s32(arg0, arg1);
    const actual = neon.vcgt_s32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vcgt_u8" {
    const arg0 = comptime makeData(neon.u8x8, 0);
    const arg1 = comptime makeData(neon.u8x8, 13);
    const expected = comptime neon.vcgt_u8(arg0, arg1);
    const actual = neon.vcgt_u8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vcgt_u16" {
    const arg0 = comptime makeData(neon.u16x4, 0);
    const arg1 = comptime makeData(neon.u16x4, 13);
    const expected = comptime neon.vcgt_u16(arg0, arg1);
    const actual = neon.vcgt_u16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vcgt_u32" {
    const arg0 = comptime makeData(neon.u32x2, 0);
    const arg1 = comptime makeData(neon.u32x2, 13);
    const expected = comptime neon.vcgt_u32(arg0, arg1);
    const actual = neon.vcgt_u32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vcgt_f32" {
    const arg0 = comptime makeData(neon.f32x2, 0);
    const arg1 = comptime makeData(neon.f32x2, 13);
    const expected = comptime neon.vcgt_f32(arg0, arg1);
    const actual = neon.vcgt_f32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vcgtq_s8" {
    const arg0 = comptime makeData(neon.i8x16, 0);
    const arg1 = comptime makeData(neon.i8x16, 13);
    const expected = comptime neon.vcgtq_s8(arg0, arg1);
    const actual = neon.vcgtq_s8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vcgtq_s16" {
    const arg0 = comptime makeData(neon.i16x8, 0);
    const arg1 = comptime makeData(neon.i16x8, 13);
    const expected = comptime neon.vcgtq_s16(arg0, arg1);
    const actual = neon.vcgtq_s16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vcgtq_s32" {
    const arg0 = comptime makeData(neon.i32x4, 0);
    const arg1 = comptime makeData(neon.i32x4, 13);
    const expected = comptime neon.vcgtq_s32(arg0, arg1);
    const actual = neon.vcgtq_s32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vcgtq_u8" {
    const arg0 = comptime makeData(neon.u8x16, 0);
    const arg1 = comptime makeData(neon.u8x16, 13);
    const expected = comptime neon.vcgtq_u8(arg0, arg1);
    const actual = neon.vcgtq_u8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vcgtq_u16" {
    const arg0 = comptime makeData(neon.u16x8, 0);
    const arg1 = comptime makeData(neon.u16x8, 13);
    const expected = comptime neon.vcgtq_u16(arg0, arg1);
    const actual = neon.vcgtq_u16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vcgtq_u32" {
    const arg0 = comptime makeData(neon.u32x4, 0);
    const arg1 = comptime makeData(neon.u32x4, 13);
    const expected = comptime neon.vcgtq_u32(arg0, arg1);
    const actual = neon.vcgtq_u32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vcgtq_f32" {
    const arg0 = comptime makeData(neon.f32x4, 0);
    const arg1 = comptime makeData(neon.f32x4, 13);
    const expected = comptime neon.vcgtq_f32(arg0, arg1);
    const actual = neon.vcgtq_f32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vcgtq_f64" {
    const arg0 = comptime makeData(neon.f64x2, 0);
    const arg1 = comptime makeData(neon.f64x2, 13);
    const expected = comptime neon.vcgtq_f64(arg0, arg1);
    const actual = neon.vcgtq_f64(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vcle_s8" {
    const arg0 = comptime makeData(neon.i8x8, 0);
    const arg1 = comptime makeData(neon.i8x8, 13);
    const expected = comptime neon.vcle_s8(arg0, arg1);
    const actual = neon.vcle_s8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vcle_s16" {
    const arg0 = comptime makeData(neon.i16x4, 0);
    const arg1 = comptime makeData(neon.i16x4, 13);
    const expected = comptime neon.vcle_s16(arg0, arg1);
    const actual = neon.vcle_s16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vcle_s32" {
    const arg0 = comptime makeData(neon.i32x2, 0);
    const arg1 = comptime makeData(neon.i32x2, 13);
    const expected = comptime neon.vcle_s32(arg0, arg1);
    const actual = neon.vcle_s32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vcle_u8" {
    const arg0 = comptime makeData(neon.u8x8, 0);
    const arg1 = comptime makeData(neon.u8x8, 13);
    const expected = comptime neon.vcle_u8(arg0, arg1);
    const actual = neon.vcle_u8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vcle_u16" {
    const arg0 = comptime makeData(neon.u16x4, 0);
    const arg1 = comptime makeData(neon.u16x4, 13);
    const expected = comptime neon.vcle_u16(arg0, arg1);
    const actual = neon.vcle_u16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vcle_u32" {
    const arg0 = comptime makeData(neon.u32x2, 0);
    const arg1 = comptime makeData(neon.u32x2, 13);
    const expected = comptime neon.vcle_u32(arg0, arg1);
    const actual = neon.vcle_u32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vcle_f32" {
    const arg0 = comptime makeData(neon.f32x2, 0);
    const arg1 = comptime makeData(neon.f32x2, 13);
    const expected = comptime neon.vcle_f32(arg0, arg1);
    const actual = neon.vcle_f32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vcleq_s8" {
    const arg0 = comptime makeData(neon.i8x16, 0);
    const arg1 = comptime makeData(neon.i8x16, 13);
    const expected = comptime neon.vcleq_s8(arg0, arg1);
    const actual = neon.vcleq_s8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vcleq_s16" {
    const arg0 = comptime makeData(neon.i16x8, 0);
    const arg1 = comptime makeData(neon.i16x8, 13);
    const expected = comptime neon.vcleq_s16(arg0, arg1);
    const actual = neon.vcleq_s16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vcleq_s32" {
    const arg0 = comptime makeData(neon.i32x4, 0);
    const arg1 = comptime makeData(neon.i32x4, 13);
    const expected = comptime neon.vcleq_s32(arg0, arg1);
    const actual = neon.vcleq_s32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vcleq_u8" {
    const arg0 = comptime makeData(neon.u8x16, 0);
    const arg1 = comptime makeData(neon.u8x16, 13);
    const expected = comptime neon.vcleq_u8(arg0, arg1);
    const actual = neon.vcleq_u8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vcleq_u16" {
    const arg0 = comptime makeData(neon.u16x8, 0);
    const arg1 = comptime makeData(neon.u16x8, 13);
    const expected = comptime neon.vcleq_u16(arg0, arg1);
    const actual = neon.vcleq_u16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vcleq_u32" {
    const arg0 = comptime makeData(neon.u32x4, 0);
    const arg1 = comptime makeData(neon.u32x4, 13);
    const expected = comptime neon.vcleq_u32(arg0, arg1);
    const actual = neon.vcleq_u32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vcleq_f32" {
    const arg0 = comptime makeData(neon.f32x4, 0);
    const arg1 = comptime makeData(neon.f32x4, 13);
    const expected = comptime neon.vcleq_f32(arg0, arg1);
    const actual = neon.vcleq_f32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vcleq_f64" {
    const arg0 = comptime makeData(neon.f64x2, 0);
    const arg1 = comptime makeData(neon.f64x2, 13);
    const expected = comptime neon.vcleq_f64(arg0, arg1);
    const actual = neon.vcleq_f64(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vclt_s8" {
    const arg0 = comptime makeData(neon.i8x8, 0);
    const arg1 = comptime makeData(neon.i8x8, 13);
    const expected = comptime neon.vclt_s8(arg0, arg1);
    const actual = neon.vclt_s8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vclt_s16" {
    const arg0 = comptime makeData(neon.i16x4, 0);
    const arg1 = comptime makeData(neon.i16x4, 13);
    const expected = comptime neon.vclt_s16(arg0, arg1);
    const actual = neon.vclt_s16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vclt_s32" {
    const arg0 = comptime makeData(neon.i32x2, 0);
    const arg1 = comptime makeData(neon.i32x2, 13);
    const expected = comptime neon.vclt_s32(arg0, arg1);
    const actual = neon.vclt_s32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vclt_u8" {
    const arg0 = comptime makeData(neon.u8x8, 0);
    const arg1 = comptime makeData(neon.u8x8, 13);
    const expected = comptime neon.vclt_u8(arg0, arg1);
    const actual = neon.vclt_u8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vclt_u16" {
    const arg0 = comptime makeData(neon.u16x4, 0);
    const arg1 = comptime makeData(neon.u16x4, 13);
    const expected = comptime neon.vclt_u16(arg0, arg1);
    const actual = neon.vclt_u16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vclt_u32" {
    const arg0 = comptime makeData(neon.u32x2, 0);
    const arg1 = comptime makeData(neon.u32x2, 13);
    const expected = comptime neon.vclt_u32(arg0, arg1);
    const actual = neon.vclt_u32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vclt_f32" {
    const arg0 = comptime makeData(neon.f32x2, 0);
    const arg1 = comptime makeData(neon.f32x2, 13);
    const expected = comptime neon.vclt_f32(arg0, arg1);
    const actual = neon.vclt_f32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vcltq_s8" {
    const arg0 = comptime makeData(neon.i8x16, 0);
    const arg1 = comptime makeData(neon.i8x16, 13);
    const expected = comptime neon.vcltq_s8(arg0, arg1);
    const actual = neon.vcltq_s8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vcltq_s16" {
    const arg0 = comptime makeData(neon.i16x8, 0);
    const arg1 = comptime makeData(neon.i16x8, 13);
    const expected = comptime neon.vcltq_s16(arg0, arg1);
    const actual = neon.vcltq_s16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vcltq_s32" {
    const arg0 = comptime makeData(neon.i32x4, 0);
    const arg1 = comptime makeData(neon.i32x4, 13);
    const expected = comptime neon.vcltq_s32(arg0, arg1);
    const actual = neon.vcltq_s32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vcltq_u8" {
    const arg0 = comptime makeData(neon.u8x16, 0);
    const arg1 = comptime makeData(neon.u8x16, 13);
    const expected = comptime neon.vcltq_u8(arg0, arg1);
    const actual = neon.vcltq_u8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vcltq_u16" {
    const arg0 = comptime makeData(neon.u16x8, 0);
    const arg1 = comptime makeData(neon.u16x8, 13);
    const expected = comptime neon.vcltq_u16(arg0, arg1);
    const actual = neon.vcltq_u16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vcltq_u32" {
    const arg0 = comptime makeData(neon.u32x4, 0);
    const arg1 = comptime makeData(neon.u32x4, 13);
    const expected = comptime neon.vcltq_u32(arg0, arg1);
    const actual = neon.vcltq_u32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vcltq_f32" {
    const arg0 = comptime makeData(neon.f32x4, 0);
    const arg1 = comptime makeData(neon.f32x4, 13);
    const expected = comptime neon.vcltq_f32(arg0, arg1);
    const actual = neon.vcltq_f32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vcltq_f64" {
    const arg0 = comptime makeData(neon.f64x2, 0);
    const arg1 = comptime makeData(neon.f64x2, 13);
    const expected = comptime neon.vcltq_f64(arg0, arg1);
    const actual = neon.vcltq_f64(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vcage_f32" {
    const arg0 = comptime makeData(neon.f32x2, 0);
    const arg1 = comptime makeData(neon.f32x2, 13);
    const expected = comptime neon.vcage_f32(arg0, arg1);
    const actual = neon.vcage_f32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vcage_f64" {
    const arg0 = comptime makeData(neon.f64x1, 0);
    const arg1 = comptime makeData(neon.f64x1, 13);
    const expected = comptime neon.vcage_f64(arg0, arg1);
    const actual = neon.vcage_f64(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vcageq_f32" {
    const arg0 = comptime makeData(neon.f32x4, 0);
    const arg1 = comptime makeData(neon.f32x4, 13);
    const expected = comptime neon.vcageq_f32(arg0, arg1);
    const actual = neon.vcageq_f32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vcageq_f64" {
    const arg0 = comptime makeData(neon.f64x2, 0);
    const arg1 = comptime makeData(neon.f64x2, 13);
    const expected = comptime neon.vcageq_f64(arg0, arg1);
    const actual = neon.vcageq_f64(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vcagt_f32" {
    const arg0 = comptime makeData(neon.f32x2, 0);
    const arg1 = comptime makeData(neon.f32x2, 13);
    const expected = comptime neon.vcagt_f32(arg0, arg1);
    const actual = neon.vcagt_f32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vcagt_f64" {
    const arg0 = comptime makeData(neon.f64x1, 0);
    const arg1 = comptime makeData(neon.f64x1, 13);
    const expected = comptime neon.vcagt_f64(arg0, arg1);
    const actual = neon.vcagt_f64(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vcagtq_f32" {
    const arg0 = comptime makeData(neon.f32x4, 0);
    const arg1 = comptime makeData(neon.f32x4, 13);
    const expected = comptime neon.vcagtq_f32(arg0, arg1);
    const actual = neon.vcagtq_f32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vcagtq_f64" {
    const arg0 = comptime makeData(neon.f64x2, 0);
    const arg1 = comptime makeData(neon.f64x2, 13);
    const expected = comptime neon.vcagtq_f64(arg0, arg1);
    const actual = neon.vcagtq_f64(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vmin_s8" {
    const arg0 = comptime makeData(neon.i8x8, 0);
    const arg1 = comptime makeData(neon.i8x8, 13);
    const expected = comptime neon.vmin_s8(arg0, arg1);
    const actual = neon.vmin_s8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vmin_s16" {
    const arg0 = comptime makeData(neon.i16x4, 0);
    const arg1 = comptime makeData(neon.i16x4, 13);
    const expected = comptime neon.vmin_s16(arg0, arg1);
    const actual = neon.vmin_s16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vmin_s32" {
    const arg0 = comptime makeData(neon.i32x2, 0);
    const arg1 = comptime makeData(neon.i32x2, 13);
    const expected = comptime neon.vmin_s32(arg0, arg1);
    const actual = neon.vmin_s32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vmin_u8" {
    const arg0 = comptime makeData(neon.u8x8, 0);
    const arg1 = comptime makeData(neon.u8x8, 13);
    const expected = comptime neon.vmin_u8(arg0, arg1);
    const actual = neon.vmin_u8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vmin_u16" {
    const arg0 = comptime makeData(neon.u16x4, 0);
    const arg1 = comptime makeData(neon.u16x4, 13);
    const expected = comptime neon.vmin_u16(arg0, arg1);
    const actual = neon.vmin_u16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vmin_u32" {
    const arg0 = comptime makeData(neon.u32x2, 0);
    const arg1 = comptime makeData(neon.u32x2, 13);
    const expected = comptime neon.vmin_u32(arg0, arg1);
    const actual = neon.vmin_u32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vmin_f16" {
    const arg0 = comptime makeData(neon.f16x4, 0);
    const arg1 = comptime makeData(neon.f16x4, 13);
    const expected = comptime neon.vmin_f16(arg0, arg1);
    const actual = neon.vmin_f16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vmin_f32" {
    const arg0 = comptime makeData(neon.f32x2, 0);
    const arg1 = comptime makeData(neon.f32x2, 13);
    const expected = comptime neon.vmin_f32(arg0, arg1);
    const actual = neon.vmin_f32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vmin_f64" {
    const arg0 = comptime makeData(neon.f64x1, 0);
    const arg1 = comptime makeData(neon.f64x1, 13);
    const expected = comptime neon.vmin_f64(arg0, arg1);
    const actual = neon.vmin_f64(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vminq_s8" {
    const arg0 = comptime makeData(neon.i8x16, 0);
    const arg1 = comptime makeData(neon.i8x16, 13);
    const expected = comptime neon.vminq_s8(arg0, arg1);
    const actual = neon.vminq_s8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vminq_s16" {
    const arg0 = comptime makeData(neon.i16x8, 0);
    const arg1 = comptime makeData(neon.i16x8, 13);
    const expected = comptime neon.vminq_s16(arg0, arg1);
    const actual = neon.vminq_s16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vminq_s32" {
    const arg0 = comptime makeData(neon.i32x4, 0);
    const arg1 = comptime makeData(neon.i32x4, 13);
    const expected = comptime neon.vminq_s32(arg0, arg1);
    const actual = neon.vminq_s32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vminq_u8" {
    const arg0 = comptime makeData(neon.u8x16, 0);
    const arg1 = comptime makeData(neon.u8x16, 13);
    const expected = comptime neon.vminq_u8(arg0, arg1);
    const actual = neon.vminq_u8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vminq_u16" {
    const arg0 = comptime makeData(neon.u16x8, 0);
    const arg1 = comptime makeData(neon.u16x8, 13);
    const expected = comptime neon.vminq_u16(arg0, arg1);
    const actual = neon.vminq_u16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vminq_u32" {
    const arg0 = comptime makeData(neon.u32x4, 0);
    const arg1 = comptime makeData(neon.u32x4, 13);
    const expected = comptime neon.vminq_u32(arg0, arg1);
    const actual = neon.vminq_u32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vminq_f16" {
    const arg0 = comptime makeData(neon.f16x8, 0);
    const arg1 = comptime makeData(neon.f16x8, 13);
    const expected = comptime neon.vminq_f16(arg0, arg1);
    const actual = neon.vminq_f16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vminq_f32" {
    const arg0 = comptime makeData(neon.f32x4, 0);
    const arg1 = comptime makeData(neon.f32x4, 13);
    const expected = comptime neon.vminq_f32(arg0, arg1);
    const actual = neon.vminq_f32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vminq_f64" {
    const arg0 = comptime makeData(neon.f64x2, 0);
    const arg1 = comptime makeData(neon.f64x2, 13);
    const expected = comptime neon.vminq_f64(arg0, arg1);
    const actual = neon.vminq_f64(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vmax_s8" {
    const arg0 = comptime makeData(neon.i8x8, 0);
    const arg1 = comptime makeData(neon.i8x8, 13);
    const expected = comptime neon.vmax_s8(arg0, arg1);
    const actual = neon.vmax_s8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vmax_s16" {
    const arg0 = comptime makeData(neon.i16x4, 0);
    const arg1 = comptime makeData(neon.i16x4, 13);
    const expected = comptime neon.vmax_s16(arg0, arg1);
    const actual = neon.vmax_s16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vmax_s32" {
    const arg0 = comptime makeData(neon.i32x2, 0);
    const arg1 = comptime makeData(neon.i32x2, 13);
    const expected = comptime neon.vmax_s32(arg0, arg1);
    const actual = neon.vmax_s32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vmax_u8" {
    const arg0 = comptime makeData(neon.u8x8, 0);
    const arg1 = comptime makeData(neon.u8x8, 13);
    const expected = comptime neon.vmax_u8(arg0, arg1);
    const actual = neon.vmax_u8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vmax_u16" {
    const arg0 = comptime makeData(neon.u16x4, 0);
    const arg1 = comptime makeData(neon.u16x4, 13);
    const expected = comptime neon.vmax_u16(arg0, arg1);
    const actual = neon.vmax_u16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vmax_u32" {
    const arg0 = comptime makeData(neon.u32x2, 0);
    const arg1 = comptime makeData(neon.u32x2, 13);
    const expected = comptime neon.vmax_u32(arg0, arg1);
    const actual = neon.vmax_u32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vmax_f16" {
    const arg0 = comptime makeData(neon.f16x4, 0);
    const arg1 = comptime makeData(neon.f16x4, 13);
    const expected = comptime neon.vmax_f16(arg0, arg1);
    const actual = neon.vmax_f16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vmax_f32" {
    const arg0 = comptime makeData(neon.f32x2, 0);
    const arg1 = comptime makeData(neon.f32x2, 13);
    const expected = comptime neon.vmax_f32(arg0, arg1);
    const actual = neon.vmax_f32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vmax_f64" {
    const arg0 = comptime makeData(neon.f64x1, 0);
    const arg1 = comptime makeData(neon.f64x1, 13);
    const expected = comptime neon.vmax_f64(arg0, arg1);
    const actual = neon.vmax_f64(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vmaxq_s8" {
    const arg0 = comptime makeData(neon.i8x16, 0);
    const arg1 = comptime makeData(neon.i8x16, 13);
    const expected = comptime neon.vmaxq_s8(arg0, arg1);
    const actual = neon.vmaxq_s8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vmaxq_s16" {
    const arg0 = comptime makeData(neon.i16x8, 0);
    const arg1 = comptime makeData(neon.i16x8, 13);
    const expected = comptime neon.vmaxq_s16(arg0, arg1);
    const actual = neon.vmaxq_s16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vmaxq_s32" {
    const arg0 = comptime makeData(neon.i32x4, 0);
    const arg1 = comptime makeData(neon.i32x4, 13);
    const expected = comptime neon.vmaxq_s32(arg0, arg1);
    const actual = neon.vmaxq_s32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vmaxq_u8" {
    const arg0 = comptime makeData(neon.u8x16, 0);
    const arg1 = comptime makeData(neon.u8x16, 13);
    const expected = comptime neon.vmaxq_u8(arg0, arg1);
    const actual = neon.vmaxq_u8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vmaxq_u16" {
    const arg0 = comptime makeData(neon.u16x8, 0);
    const arg1 = comptime makeData(neon.u16x8, 13);
    const expected = comptime neon.vmaxq_u16(arg0, arg1);
    const actual = neon.vmaxq_u16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vmaxq_u32" {
    const arg0 = comptime makeData(neon.u32x4, 0);
    const arg1 = comptime makeData(neon.u32x4, 13);
    const expected = comptime neon.vmaxq_u32(arg0, arg1);
    const actual = neon.vmaxq_u32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vmaxq_f16" {
    const arg0 = comptime makeData(neon.f16x8, 0);
    const arg1 = comptime makeData(neon.f16x8, 13);
    const expected = comptime neon.vmaxq_f16(arg0, arg1);
    const actual = neon.vmaxq_f16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vmaxq_f32" {
    const arg0 = comptime makeData(neon.f32x4, 0);
    const arg1 = comptime makeData(neon.f32x4, 13);
    const expected = comptime neon.vmaxq_f32(arg0, arg1);
    const actual = neon.vmaxq_f32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vmaxq_f64" {
    const arg0 = comptime makeData(neon.f64x2, 0);
    const arg1 = comptime makeData(neon.f64x2, 13);
    const expected = comptime neon.vmaxq_f64(arg0, arg1);
    const actual = neon.vmaxq_f64(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vget_low_s8" {
    const arg0 = comptime makeData(neon.i8x16, 0);
    const expected = comptime neon.vget_low_s8(arg0);
    const actual = neon.vget_low_s8(arg0);
    try expectEqualApprox(expected, actual);
}

test "vget_low_s16" {
    const arg0 = comptime makeData(neon.i16x8, 0);
    const expected = comptime neon.vget_low_s16(arg0);
    const actual = neon.vget_low_s16(arg0);
    try expectEqualApprox(expected, actual);
}

test "vget_low_s32" {
    const arg0 = comptime makeData(neon.i32x4, 0);
    const expected = comptime neon.vget_low_s32(arg0);
    const actual = neon.vget_low_s32(arg0);
    try expectEqualApprox(expected, actual);
}

test "vget_low_s64" {
    const arg0 = comptime makeData(neon.i64x2, 0);
    const expected = comptime neon.vget_low_s64(arg0);
    const actual = neon.vget_low_s64(arg0);
    try expectEqualApprox(expected, actual);
}

test "vget_low_u8" {
    const arg0 = comptime makeData(neon.u8x16, 0);
    const expected = comptime neon.vget_low_u8(arg0);
    const actual = neon.vget_low_u8(arg0);
    try expectEqualApprox(expected, actual);
}

test "vget_low_u16" {
    const arg0 = comptime makeData(neon.u16x8, 0);
    const expected = comptime neon.vget_low_u16(arg0);
    const actual = neon.vget_low_u16(arg0);
    try expectEqualApprox(expected, actual);
}

test "vget_low_u32" {
    const arg0 = comptime makeData(neon.u32x4, 0);
    const expected = comptime neon.vget_low_u32(arg0);
    const actual = neon.vget_low_u32(arg0);
    try expectEqualApprox(expected, actual);
}

test "vget_low_u64" {
    const arg0 = comptime makeData(neon.u64x2, 0);
    const expected = comptime neon.vget_low_u64(arg0);
    const actual = neon.vget_low_u64(arg0);
    try expectEqualApprox(expected, actual);
}

test "vget_low_f16" {
    const arg0 = comptime makeData(neon.f16x8, 0);
    const expected = comptime neon.vget_low_f16(arg0);
    const actual = neon.vget_low_f16(arg0);
    try expectEqualApprox(expected, actual);
}

test "vget_low_f32" {
    const arg0 = comptime makeData(neon.f32x4, 0);
    const expected = comptime neon.vget_low_f32(arg0);
    const actual = neon.vget_low_f32(arg0);
    try expectEqualApprox(expected, actual);
}

test "vget_low_f64" {
    const arg0 = comptime makeData(neon.f64x2, 0);
    const expected = comptime neon.vget_low_f64(arg0);
    const actual = neon.vget_low_f64(arg0);
    try expectEqualApprox(expected, actual);
}

test "vget_low_p8" {
    const arg0 = comptime makeData(neon.p8x16, 0);
    const expected = comptime neon.vget_low_p8(arg0);
    const actual = neon.vget_low_p8(arg0);
    try expectEqualApprox(expected, actual);
}

test "vget_low_p16" {
    const arg0 = comptime makeData(neon.p16x8, 0);
    const expected = comptime neon.vget_low_p16(arg0);
    const actual = neon.vget_low_p16(arg0);
    try expectEqualApprox(expected, actual);
}

test "vget_low_p64" {
    const arg0 = comptime makeData(neon.p64x2, 0);
    const expected = comptime neon.vget_low_p64(arg0);
    const actual = neon.vget_low_p64(arg0);
    try expectEqualApprox(expected, actual);
}

test "vget_high_s8" {
    const arg0 = comptime makeData(neon.i8x16, 0);
    const expected = comptime neon.vget_high_s8(arg0);
    const actual = neon.vget_high_s8(arg0);
    try expectEqualApprox(expected, actual);
}

test "vget_high_s16" {
    const arg0 = comptime makeData(neon.i16x8, 0);
    const expected = comptime neon.vget_high_s16(arg0);
    const actual = neon.vget_high_s16(arg0);
    try expectEqualApprox(expected, actual);
}

test "vget_high_s32" {
    const arg0 = comptime makeData(neon.i32x4, 0);
    const expected = comptime neon.vget_high_s32(arg0);
    const actual = neon.vget_high_s32(arg0);
    try expectEqualApprox(expected, actual);
}

test "vget_high_s64" {
    const arg0 = comptime makeData(neon.i64x2, 0);
    const expected = comptime neon.vget_high_s64(arg0);
    const actual = neon.vget_high_s64(arg0);
    try expectEqualApprox(expected, actual);
}

test "vget_high_u8" {
    const arg0 = comptime makeData(neon.u8x16, 0);
    const expected = comptime neon.vget_high_u8(arg0);
    const actual = neon.vget_high_u8(arg0);
    try expectEqualApprox(expected, actual);
}

test "vget_high_u16" {
    const arg0 = comptime makeData(neon.u16x8, 0);
    const expected = comptime neon.vget_high_u16(arg0);
    const actual = neon.vget_high_u16(arg0);
    try expectEqualApprox(expected, actual);
}

test "vget_high_u32" {
    const arg0 = comptime makeData(neon.u32x4, 0);
    const expected = comptime neon.vget_high_u32(arg0);
    const actual = neon.vget_high_u32(arg0);
    try expectEqualApprox(expected, actual);
}

test "vget_high_u64" {
    const arg0 = comptime makeData(neon.u64x2, 0);
    const expected = comptime neon.vget_high_u64(arg0);
    const actual = neon.vget_high_u64(arg0);
    try expectEqualApprox(expected, actual);
}

test "vget_high_f16" {
    const arg0 = comptime makeData(neon.f16x8, 0);
    const expected = comptime neon.vget_high_f16(arg0);
    const actual = neon.vget_high_f16(arg0);
    try expectEqualApprox(expected, actual);
}

test "vget_high_f32" {
    const arg0 = comptime makeData(neon.f32x4, 0);
    const expected = comptime neon.vget_high_f32(arg0);
    const actual = neon.vget_high_f32(arg0);
    try expectEqualApprox(expected, actual);
}

test "vget_high_f64" {
    const arg0 = comptime makeData(neon.f64x2, 0);
    const expected = comptime neon.vget_high_f64(arg0);
    const actual = neon.vget_high_f64(arg0);
    try expectEqualApprox(expected, actual);
}

test "vget_high_p8" {
    const arg0 = comptime makeData(neon.p8x16, 0);
    const expected = comptime neon.vget_high_p8(arg0);
    const actual = neon.vget_high_p8(arg0);
    try expectEqualApprox(expected, actual);
}

test "vget_high_p16" {
    const arg0 = comptime makeData(neon.p16x8, 0);
    const expected = comptime neon.vget_high_p16(arg0);
    const actual = neon.vget_high_p16(arg0);
    try expectEqualApprox(expected, actual);
}

test "vget_high_p64" {
    const arg0 = comptime makeData(neon.p64x2, 0);
    const expected = comptime neon.vget_high_p64(arg0);
    const actual = neon.vget_high_p64(arg0);
    try expectEqualApprox(expected, actual);
}

test "vcombine_s8" {
    const arg0 = comptime makeData(neon.i8x8, 0);
    const arg1 = comptime makeData(neon.i8x8, 13);
    const expected = comptime neon.vcombine_s8(arg0, arg1);
    const actual = neon.vcombine_s8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vcombine_s16" {
    const arg0 = comptime makeData(neon.i16x4, 0);
    const arg1 = comptime makeData(neon.i16x4, 13);
    const expected = comptime neon.vcombine_s16(arg0, arg1);
    const actual = neon.vcombine_s16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vcombine_s32" {
    const arg0 = comptime makeData(neon.i32x2, 0);
    const arg1 = comptime makeData(neon.i32x2, 13);
    const expected = comptime neon.vcombine_s32(arg0, arg1);
    const actual = neon.vcombine_s32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vcombine_s64" {
    const arg0 = comptime makeData(neon.i64x1, 0);
    const arg1 = comptime makeData(neon.i64x1, 13);
    const expected = comptime neon.vcombine_s64(arg0, arg1);
    const actual = neon.vcombine_s64(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vcombine_u8" {
    const arg0 = comptime makeData(neon.u8x8, 0);
    const arg1 = comptime makeData(neon.u8x8, 13);
    const expected = comptime neon.vcombine_u8(arg0, arg1);
    const actual = neon.vcombine_u8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vcombine_u16" {
    const arg0 = comptime makeData(neon.u16x4, 0);
    const arg1 = comptime makeData(neon.u16x4, 13);
    const expected = comptime neon.vcombine_u16(arg0, arg1);
    const actual = neon.vcombine_u16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vcombine_u32" {
    const arg0 = comptime makeData(neon.u32x2, 0);
    const arg1 = comptime makeData(neon.u32x2, 13);
    const expected = comptime neon.vcombine_u32(arg0, arg1);
    const actual = neon.vcombine_u32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vcombine_u64" {
    const arg0 = comptime makeData(neon.u64x1, 0);
    const arg1 = comptime makeData(neon.u64x1, 13);
    const expected = comptime neon.vcombine_u64(arg0, arg1);
    const actual = neon.vcombine_u64(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vcombine_f16" {
    const arg0 = comptime makeData(neon.f16x4, 0);
    const arg1 = comptime makeData(neon.f16x4, 13);
    const expected = comptime neon.vcombine_f16(arg0, arg1);
    const actual = neon.vcombine_f16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vcombine_f32" {
    const arg0 = comptime makeData(neon.f32x2, 0);
    const arg1 = comptime makeData(neon.f32x2, 13);
    const expected = comptime neon.vcombine_f32(arg0, arg1);
    const actual = neon.vcombine_f32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vcombine_f64" {
    const arg0 = comptime makeData(neon.f64x1, 0);
    const arg1 = comptime makeData(neon.f64x1, 13);
    const expected = comptime neon.vcombine_f64(arg0, arg1);
    const actual = neon.vcombine_f64(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vcombine_p8" {
    const arg0 = comptime makeData(neon.p8x8, 0);
    const arg1 = comptime makeData(neon.p8x8, 13);
    const expected = comptime neon.vcombine_p8(arg0, arg1);
    const actual = neon.vcombine_p8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vcombine_p16" {
    const arg0 = comptime makeData(neon.p16x4, 0);
    const arg1 = comptime makeData(neon.p16x4, 13);
    const expected = comptime neon.vcombine_p16(arg0, arg1);
    const actual = neon.vcombine_p16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vcombine_p64" {
    const arg0 = comptime makeData(neon.p64x1, 0);
    const arg1 = comptime makeData(neon.p64x1, 13);
    const expected = comptime neon.vcombine_p64(arg0, arg1);
    const actual = neon.vcombine_p64(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vget_lane_s8" {
    const arg0 = comptime makeData(neon.i8x8, 0);
    const arg1: usize = 0;
    const expected = comptime neon.vget_lane_s8(arg0, arg1);
    const actual = neon.vget_lane_s8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vget_lane_s16" {
    const arg0 = comptime makeData(neon.i16x4, 0);
    const arg1: usize = 0;
    const expected = comptime neon.vget_lane_s16(arg0, arg1);
    const actual = neon.vget_lane_s16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vget_lane_s32" {
    const arg0 = comptime makeData(neon.i32x2, 0);
    const arg1: usize = 0;
    const expected = comptime neon.vget_lane_s32(arg0, arg1);
    const actual = neon.vget_lane_s32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vget_lane_s64" {
    const arg0 = comptime makeData(neon.i64x1, 0);
    const arg1: usize = 0;
    const expected = comptime neon.vget_lane_s64(arg0, arg1);
    const actual = neon.vget_lane_s64(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vget_lane_u8" {
    const arg0 = comptime makeData(neon.u8x8, 0);
    const arg1: usize = 0;
    const expected = comptime neon.vget_lane_u8(arg0, arg1);
    const actual = neon.vget_lane_u8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vget_lane_u16" {
    const arg0 = comptime makeData(neon.u16x4, 0);
    const arg1: usize = 0;
    const expected = comptime neon.vget_lane_u16(arg0, arg1);
    const actual = neon.vget_lane_u16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vget_lane_u32" {
    const arg0 = comptime makeData(neon.u32x2, 0);
    const arg1: usize = 0;
    const expected = comptime neon.vget_lane_u32(arg0, arg1);
    const actual = neon.vget_lane_u32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vget_lane_u64" {
    const arg0 = comptime makeData(neon.u64x1, 0);
    const arg1: usize = 0;
    const expected = comptime neon.vget_lane_u64(arg0, arg1);
    const actual = neon.vget_lane_u64(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vget_lane_f16" {
    const arg0 = comptime makeData(neon.f16x4, 0);
    const arg1: usize = 0;
    const expected = comptime neon.vget_lane_f16(arg0, arg1);
    const actual = neon.vget_lane_f16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vget_lane_f32" {
    const arg0 = comptime makeData(neon.f32x2, 0);
    const arg1: usize = 0;
    const expected = comptime neon.vget_lane_f32(arg0, arg1);
    const actual = neon.vget_lane_f32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vget_lane_f64" {
    const arg0 = comptime makeData(neon.f64x1, 0);
    const arg1: usize = 0;
    const expected = comptime neon.vget_lane_f64(arg0, arg1);
    const actual = neon.vget_lane_f64(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vget_lane_p8" {
    const arg0 = comptime makeData(neon.p8x8, 0);
    const arg1: usize = 0;
    const expected = comptime neon.vget_lane_p8(arg0, arg1);
    const actual = neon.vget_lane_p8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vget_lane_p16" {
    const arg0 = comptime makeData(neon.p16x4, 0);
    const arg1: usize = 0;
    const expected = comptime neon.vget_lane_p16(arg0, arg1);
    const actual = neon.vget_lane_p16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vget_lane_p64" {
    const arg0 = comptime makeData(neon.p64x1, 0);
    const arg1: usize = 0;
    const expected = comptime neon.vget_lane_p64(arg0, arg1);
    const actual = neon.vget_lane_p64(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vgetq_lane_s8" {
    const arg0 = comptime makeData(neon.i8x16, 0);
    const arg1: usize = 0;
    const expected = comptime neon.vgetq_lane_s8(arg0, arg1);
    const actual = neon.vgetq_lane_s8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vgetq_lane_s16" {
    const arg0 = comptime makeData(neon.i16x8, 0);
    const arg1: usize = 0;
    const expected = comptime neon.vgetq_lane_s16(arg0, arg1);
    const actual = neon.vgetq_lane_s16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vgetq_lane_s32" {
    const arg0 = comptime makeData(neon.i32x4, 0);
    const arg1: usize = 0;
    const expected = comptime neon.vgetq_lane_s32(arg0, arg1);
    const actual = neon.vgetq_lane_s32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vgetq_lane_s64" {
    const arg0 = comptime makeData(neon.i64x2, 0);
    const arg1: usize = 0;
    const expected = comptime neon.vgetq_lane_s64(arg0, arg1);
    const actual = neon.vgetq_lane_s64(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vgetq_lane_u8" {
    const arg0 = comptime makeData(neon.u8x16, 0);
    const arg1: usize = 0;
    const expected = comptime neon.vgetq_lane_u8(arg0, arg1);
    const actual = neon.vgetq_lane_u8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vgetq_lane_u16" {
    const arg0 = comptime makeData(neon.u16x8, 0);
    const arg1: usize = 0;
    const expected = comptime neon.vgetq_lane_u16(arg0, arg1);
    const actual = neon.vgetq_lane_u16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vgetq_lane_u32" {
    const arg0 = comptime makeData(neon.u32x4, 0);
    const arg1: usize = 0;
    const expected = comptime neon.vgetq_lane_u32(arg0, arg1);
    const actual = neon.vgetq_lane_u32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vgetq_lane_u64" {
    const arg0 = comptime makeData(neon.u64x2, 0);
    const arg1: usize = 0;
    const expected = comptime neon.vgetq_lane_u64(arg0, arg1);
    const actual = neon.vgetq_lane_u64(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vgetq_lane_f16" {
    const arg0 = comptime makeData(neon.f16x8, 0);
    const arg1: usize = 0;
    const expected = comptime neon.vgetq_lane_f16(arg0, arg1);
    const actual = neon.vgetq_lane_f16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vgetq_lane_f32" {
    const arg0 = comptime makeData(neon.f32x4, 0);
    const arg1: usize = 0;
    const expected = comptime neon.vgetq_lane_f32(arg0, arg1);
    const actual = neon.vgetq_lane_f32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vgetq_lane_f64" {
    const arg0 = comptime makeData(neon.f64x2, 0);
    const arg1: usize = 0;
    const expected = comptime neon.vgetq_lane_f64(arg0, arg1);
    const actual = neon.vgetq_lane_f64(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vgetq_lane_p8" {
    const arg0 = comptime makeData(neon.p8x16, 0);
    const arg1: usize = 0;
    const expected = comptime neon.vgetq_lane_p8(arg0, arg1);
    const actual = neon.vgetq_lane_p8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vgetq_lane_p16" {
    const arg0 = comptime makeData(neon.p16x8, 0);
    const arg1: usize = 0;
    const expected = comptime neon.vgetq_lane_p16(arg0, arg1);
    const actual = neon.vgetq_lane_p16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vgetq_lane_p64" {
    const arg0 = comptime makeData(neon.p64x2, 0);
    const arg1: usize = 0;
    const expected = comptime neon.vgetq_lane_p64(arg0, arg1);
    const actual = neon.vgetq_lane_p64(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vset_lane_s8" {
    const arg0: i8 = 1;
    const arg1 = comptime makeData(neon.i8x8, 13);
    const arg2: usize = 0;
    const expected = comptime neon.vset_lane_s8(arg0, arg1, arg2);
    const actual = neon.vset_lane_s8(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vset_lane_s16" {
    const arg0: i16 = 1;
    const arg1 = comptime makeData(neon.i16x4, 13);
    const arg2: usize = 0;
    const expected = comptime neon.vset_lane_s16(arg0, arg1, arg2);
    const actual = neon.vset_lane_s16(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vset_lane_s32" {
    const arg0: i32 = 1;
    const arg1 = comptime makeData(neon.i32x2, 13);
    const arg2: usize = 0;
    const expected = comptime neon.vset_lane_s32(arg0, arg1, arg2);
    const actual = neon.vset_lane_s32(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vset_lane_u8" {
    const arg0: u8 = 1;
    const arg1 = comptime makeData(neon.u8x8, 13);
    const arg2: usize = 0;
    const expected = comptime neon.vset_lane_u8(arg0, arg1, arg2);
    const actual = neon.vset_lane_u8(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vset_lane_u16" {
    const arg0: u16 = 1;
    const arg1 = comptime makeData(neon.u16x4, 13);
    const arg2: usize = 0;
    const expected = comptime neon.vset_lane_u16(arg0, arg1, arg2);
    const actual = neon.vset_lane_u16(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vset_lane_u32" {
    const arg0: u32 = 1;
    const arg1 = comptime makeData(neon.u32x2, 13);
    const arg2: usize = 0;
    const expected = comptime neon.vset_lane_u32(arg0, arg1, arg2);
    const actual = neon.vset_lane_u32(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vset_lane_f32" {
    const arg0: f32 = 1;
    const arg1 = comptime makeData(neon.f32x2, 13);
    const arg2: usize = 0;
    const expected = comptime neon.vset_lane_f32(arg0, arg1, arg2);
    const actual = neon.vset_lane_f32(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vsetq_lane_s8" {
    const arg0: i8 = 1;
    const arg1 = comptime makeData(neon.i8x16, 13);
    const arg2: usize = 0;
    const expected = comptime neon.vsetq_lane_s8(arg0, arg1, arg2);
    const actual = neon.vsetq_lane_s8(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vsetq_lane_s16" {
    const arg0: i16 = 1;
    const arg1 = comptime makeData(neon.i16x8, 13);
    const arg2: usize = 0;
    const expected = comptime neon.vsetq_lane_s16(arg0, arg1, arg2);
    const actual = neon.vsetq_lane_s16(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vsetq_lane_s32" {
    const arg0: i32 = 1;
    const arg1 = comptime makeData(neon.i32x4, 13);
    const arg2: usize = 0;
    const expected = comptime neon.vsetq_lane_s32(arg0, arg1, arg2);
    const actual = neon.vsetq_lane_s32(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vsetq_lane_u8" {
    const arg0: u8 = 1;
    const arg1 = comptime makeData(neon.u8x16, 13);
    const arg2: usize = 0;
    const expected = comptime neon.vsetq_lane_u8(arg0, arg1, arg2);
    const actual = neon.vsetq_lane_u8(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vsetq_lane_u16" {
    const arg0: u16 = 1;
    const arg1 = comptime makeData(neon.u16x8, 13);
    const arg2: usize = 0;
    const expected = comptime neon.vsetq_lane_u16(arg0, arg1, arg2);
    const actual = neon.vsetq_lane_u16(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vsetq_lane_u32" {
    const arg0: u32 = 1;
    const arg1 = comptime makeData(neon.u32x4, 13);
    const arg2: usize = 0;
    const expected = comptime neon.vsetq_lane_u32(arg0, arg1, arg2);
    const actual = neon.vsetq_lane_u32(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vsetq_lane_f32" {
    const arg0: f32 = 1;
    const arg1 = comptime makeData(neon.f32x4, 13);
    const arg2: usize = 0;
    const expected = comptime neon.vsetq_lane_f32(arg0, arg1, arg2);
    const actual = neon.vsetq_lane_f32(arg0, arg1, arg2);
    try expectEqualApprox(expected, actual);
}

test "vdup_n_s8" {
    const arg0: i8 = 1;
    const expected = comptime neon.vdup_n_s8(arg0);
    const actual = neon.vdup_n_s8(arg0);
    try expectEqualApprox(expected, actual);
}

test "vdup_n_s16" {
    const arg0: i16 = 1;
    const expected = comptime neon.vdup_n_s16(arg0);
    const actual = neon.vdup_n_s16(arg0);
    try expectEqualApprox(expected, actual);
}

test "vdup_n_s32" {
    const arg0: i32 = 1;
    const expected = comptime neon.vdup_n_s32(arg0);
    const actual = neon.vdup_n_s32(arg0);
    try expectEqualApprox(expected, actual);
}

test "vdup_n_s64" {
    const arg0: i64 = 1;
    const expected = comptime neon.vdup_n_s64(arg0);
    const actual = neon.vdup_n_s64(arg0);
    try expectEqualApprox(expected, actual);
}

test "vdup_n_u8" {
    const arg0: u8 = 1;
    const expected = comptime neon.vdup_n_u8(arg0);
    const actual = neon.vdup_n_u8(arg0);
    try expectEqualApprox(expected, actual);
}

test "vdup_n_u16" {
    const arg0: u16 = 1;
    const expected = comptime neon.vdup_n_u16(arg0);
    const actual = neon.vdup_n_u16(arg0);
    try expectEqualApprox(expected, actual);
}

test "vdup_n_u32" {
    const arg0: u32 = 1;
    const expected = comptime neon.vdup_n_u32(arg0);
    const actual = neon.vdup_n_u32(arg0);
    try expectEqualApprox(expected, actual);
}

test "vdup_n_u64" {
    const arg0: u64 = 1;
    const expected = comptime neon.vdup_n_u64(arg0);
    const actual = neon.vdup_n_u64(arg0);
    try expectEqualApprox(expected, actual);
}

test "vdup_n_f16" {
    const arg0: f16 = 1;
    const expected = comptime neon.vdup_n_f16(arg0);
    const actual = neon.vdup_n_f16(arg0);
    try expectEqualApprox(expected, actual);
}

test "vdup_n_f32" {
    const arg0: f32 = 1;
    const expected = comptime neon.vdup_n_f32(arg0);
    const actual = neon.vdup_n_f32(arg0);
    try expectEqualApprox(expected, actual);
}

test "vdup_n_f64" {
    const arg0: f64 = 1;
    const expected = comptime neon.vdup_n_f64(arg0);
    const actual = neon.vdup_n_f64(arg0);
    try expectEqualApprox(expected, actual);
}

test "vdup_n_p8" {
    const arg0 = comptime makeData(neon.p8, 0);
    const expected = comptime neon.vdup_n_p8(arg0);
    const actual = neon.vdup_n_p8(arg0);
    try expectEqualApprox(expected, actual);
}

test "vdup_n_p16" {
    const arg0 = comptime makeData(neon.p16, 0);
    const expected = comptime neon.vdup_n_p16(arg0);
    const actual = neon.vdup_n_p16(arg0);
    try expectEqualApprox(expected, actual);
}

test "vdup_n_p64" {
    const arg0 = comptime makeData(neon.p64, 0);
    const expected = comptime neon.vdup_n_p64(arg0);
    const actual = neon.vdup_n_p64(arg0);
    try expectEqualApprox(expected, actual);
}

test "vdupq_n_s8" {
    const arg0: i8 = 1;
    const expected = comptime neon.vdupq_n_s8(arg0);
    const actual = neon.vdupq_n_s8(arg0);
    try expectEqualApprox(expected, actual);
}

test "vdupq_n_s16" {
    const arg0: i16 = 1;
    const expected = comptime neon.vdupq_n_s16(arg0);
    const actual = neon.vdupq_n_s16(arg0);
    try expectEqualApprox(expected, actual);
}

test "vdupq_n_s32" {
    const arg0: i32 = 1;
    const expected = comptime neon.vdupq_n_s32(arg0);
    const actual = neon.vdupq_n_s32(arg0);
    try expectEqualApprox(expected, actual);
}

test "vdupq_n_s64" {
    const arg0: i64 = 1;
    const expected = comptime neon.vdupq_n_s64(arg0);
    const actual = neon.vdupq_n_s64(arg0);
    try expectEqualApprox(expected, actual);
}

test "vdupq_n_u8" {
    const arg0: u8 = 1;
    const expected = comptime neon.vdupq_n_u8(arg0);
    const actual = neon.vdupq_n_u8(arg0);
    try expectEqualApprox(expected, actual);
}

test "vdupq_n_u16" {
    const arg0: u16 = 1;
    const expected = comptime neon.vdupq_n_u16(arg0);
    const actual = neon.vdupq_n_u16(arg0);
    try expectEqualApprox(expected, actual);
}

test "vdupq_n_u32" {
    const arg0: u32 = 1;
    const expected = comptime neon.vdupq_n_u32(arg0);
    const actual = neon.vdupq_n_u32(arg0);
    try expectEqualApprox(expected, actual);
}

test "vdupq_n_u64" {
    const arg0: u64 = 1;
    const expected = comptime neon.vdupq_n_u64(arg0);
    const actual = neon.vdupq_n_u64(arg0);
    try expectEqualApprox(expected, actual);
}

test "vdupq_n_f16" {
    const arg0: f16 = 1;
    const expected = comptime neon.vdupq_n_f16(arg0);
    const actual = neon.vdupq_n_f16(arg0);
    try expectEqualApprox(expected, actual);
}

test "vdupq_n_f32" {
    const arg0: f32 = 1;
    const expected = comptime neon.vdupq_n_f32(arg0);
    const actual = neon.vdupq_n_f32(arg0);
    try expectEqualApprox(expected, actual);
}

test "vdupq_n_f64" {
    const arg0: f64 = 1;
    const expected = comptime neon.vdupq_n_f64(arg0);
    const actual = neon.vdupq_n_f64(arg0);
    try expectEqualApprox(expected, actual);
}

test "vdupq_n_p8" {
    const arg0 = comptime makeData(neon.p8, 0);
    const expected = comptime neon.vdupq_n_p8(arg0);
    const actual = neon.vdupq_n_p8(arg0);
    try expectEqualApprox(expected, actual);
}

test "vdupq_n_p16" {
    const arg0 = comptime makeData(neon.p16, 0);
    const expected = comptime neon.vdupq_n_p16(arg0);
    const actual = neon.vdupq_n_p16(arg0);
    try expectEqualApprox(expected, actual);
}

test "vdupq_n_p64" {
    const arg0 = comptime makeData(neon.p64, 0);
    const expected = comptime neon.vdupq_n_p64(arg0);
    const actual = neon.vdupq_n_p64(arg0);
    try expectEqualApprox(expected, actual);
}

test "vmov_n_s8" {
    const arg0: i8 = 1;
    const expected = comptime neon.vmov_n_s8(arg0);
    const actual = neon.vmov_n_s8(arg0);
    try expectEqualApprox(expected, actual);
}

test "vmov_n_s16" {
    const arg0: i16 = 1;
    const expected = comptime neon.vmov_n_s16(arg0);
    const actual = neon.vmov_n_s16(arg0);
    try expectEqualApprox(expected, actual);
}

test "vmov_n_s32" {
    const arg0: i32 = 1;
    const expected = comptime neon.vmov_n_s32(arg0);
    const actual = neon.vmov_n_s32(arg0);
    try expectEqualApprox(expected, actual);
}

test "vmov_n_u8" {
    const arg0: u8 = 1;
    const expected = comptime neon.vmov_n_u8(arg0);
    const actual = neon.vmov_n_u8(arg0);
    try expectEqualApprox(expected, actual);
}

test "vmov_n_u16" {
    const arg0: u16 = 1;
    const expected = comptime neon.vmov_n_u16(arg0);
    const actual = neon.vmov_n_u16(arg0);
    try expectEqualApprox(expected, actual);
}

test "vmov_n_u32" {
    const arg0: u32 = 1;
    const expected = comptime neon.vmov_n_u32(arg0);
    const actual = neon.vmov_n_u32(arg0);
    try expectEqualApprox(expected, actual);
}

test "vmov_n_f32" {
    const arg0: f32 = 1;
    const expected = comptime neon.vmov_n_f32(arg0);
    const actual = neon.vmov_n_f32(arg0);
    try expectEqualApprox(expected, actual);
}

test "vmovq_n_s8" {
    const arg0: i8 = 1;
    const expected = comptime neon.vmovq_n_s8(arg0);
    const actual = neon.vmovq_n_s8(arg0);
    try expectEqualApprox(expected, actual);
}

test "vmovq_n_s16" {
    const arg0: i16 = 1;
    const expected = comptime neon.vmovq_n_s16(arg0);
    const actual = neon.vmovq_n_s16(arg0);
    try expectEqualApprox(expected, actual);
}

test "vmovq_n_s32" {
    const arg0: i32 = 1;
    const expected = comptime neon.vmovq_n_s32(arg0);
    const actual = neon.vmovq_n_s32(arg0);
    try expectEqualApprox(expected, actual);
}

test "vmovq_n_s64" {
    const arg0: i64 = 1;
    const expected = comptime neon.vmovq_n_s64(arg0);
    const actual = neon.vmovq_n_s64(arg0);
    try expectEqualApprox(expected, actual);
}

test "vmovq_n_u8" {
    const arg0: u8 = 1;
    const expected = comptime neon.vmovq_n_u8(arg0);
    const actual = neon.vmovq_n_u8(arg0);
    try expectEqualApprox(expected, actual);
}

test "vmovq_n_u16" {
    const arg0: u16 = 1;
    const expected = comptime neon.vmovq_n_u16(arg0);
    const actual = neon.vmovq_n_u16(arg0);
    try expectEqualApprox(expected, actual);
}

test "vmovq_n_u32" {
    const arg0: u32 = 1;
    const expected = comptime neon.vmovq_n_u32(arg0);
    const actual = neon.vmovq_n_u32(arg0);
    try expectEqualApprox(expected, actual);
}

test "vmovq_n_u64" {
    const arg0: u64 = 1;
    const expected = comptime neon.vmovq_n_u64(arg0);
    const actual = neon.vmovq_n_u64(arg0);
    try expectEqualApprox(expected, actual);
}

test "vmovq_n_f32" {
    const arg0: f32 = 1;
    const expected = comptime neon.vmovq_n_f32(arg0);
    const actual = neon.vmovq_n_f32(arg0);
    try expectEqualApprox(expected, actual);
}

test "vmovq_n_f64" {
    const arg0: f64 = 1;
    const expected = comptime neon.vmovq_n_f64(arg0);
    const actual = neon.vmovq_n_f64(arg0);
    try expectEqualApprox(expected, actual);
}

test "vmovq_n_p8" {
    const arg0 = comptime makeData(neon.p8, 0);
    const expected = comptime neon.vmovq_n_p8(arg0);
    const actual = neon.vmovq_n_p8(arg0);
    try expectEqualApprox(expected, actual);
}

test "vmovq_n_p16" {
    const arg0 = comptime makeData(neon.p16, 0);
    const expected = comptime neon.vmovq_n_p16(arg0);
    const actual = neon.vmovq_n_p16(arg0);
    try expectEqualApprox(expected, actual);
}

test "vmovq_n_p64" {
    const arg0 = comptime makeData(neon.p64, 0);
    const expected = comptime neon.vmovq_n_p64(arg0);
    const actual = neon.vmovq_n_p64(arg0);
    try expectEqualApprox(expected, actual);
}

test "vzip1_u8" {
    const arg0 = comptime makeData(neon.u8x8, 0);
    const arg1 = comptime makeData(neon.u8x8, 13);
    const expected = comptime neon.vzip1_u8(arg0, arg1);
    const actual = neon.vzip1_u8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vzip2_u8" {
    const arg0 = comptime makeData(neon.u8x8, 0);
    const arg1 = comptime makeData(neon.u8x8, 13);
    const expected = comptime neon.vzip2_u8(arg0, arg1);
    const actual = neon.vzip2_u8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vzip1_s8" {
    const arg0 = comptime makeData(neon.i8x8, 0);
    const arg1 = comptime makeData(neon.i8x8, 13);
    const expected = comptime neon.vzip1_s8(arg0, arg1);
    const actual = neon.vzip1_s8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vzip2_s8" {
    const arg0 = comptime makeData(neon.i8x8, 0);
    const arg1 = comptime makeData(neon.i8x8, 13);
    const expected = comptime neon.vzip2_s8(arg0, arg1);
    const actual = neon.vzip2_s8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vzip1_u16" {
    const arg0 = comptime makeData(neon.u16x4, 0);
    const arg1 = comptime makeData(neon.u16x4, 13);
    const expected = comptime neon.vzip1_u16(arg0, arg1);
    const actual = neon.vzip1_u16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vzip2_u16" {
    const arg0 = comptime makeData(neon.u16x4, 0);
    const arg1 = comptime makeData(neon.u16x4, 13);
    const expected = comptime neon.vzip2_u16(arg0, arg1);
    const actual = neon.vzip2_u16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vzip1_s16" {
    const arg0 = comptime makeData(neon.i16x4, 0);
    const arg1 = comptime makeData(neon.i16x4, 13);
    const expected = comptime neon.vzip1_s16(arg0, arg1);
    const actual = neon.vzip1_s16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vzip2_s16" {
    const arg0 = comptime makeData(neon.i16x4, 0);
    const arg1 = comptime makeData(neon.i16x4, 13);
    const expected = comptime neon.vzip2_s16(arg0, arg1);
    const actual = neon.vzip2_s16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vzip1_u32" {
    const arg0 = comptime makeData(neon.u32x2, 0);
    const arg1 = comptime makeData(neon.u32x2, 13);
    const expected = comptime neon.vzip1_u32(arg0, arg1);
    const actual = neon.vzip1_u32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vzip2_u32" {
    const arg0 = comptime makeData(neon.u32x2, 0);
    const arg1 = comptime makeData(neon.u32x2, 13);
    const expected = comptime neon.vzip2_u32(arg0, arg1);
    const actual = neon.vzip2_u32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vzip1_s32" {
    const arg0 = comptime makeData(neon.i32x2, 0);
    const arg1 = comptime makeData(neon.i32x2, 13);
    const expected = comptime neon.vzip1_s32(arg0, arg1);
    const actual = neon.vzip1_s32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vzip2_s32" {
    const arg0 = comptime makeData(neon.i32x2, 0);
    const arg1 = comptime makeData(neon.i32x2, 13);
    const expected = comptime neon.vzip2_s32(arg0, arg1);
    const actual = neon.vzip2_s32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vzip1_f32" {
    const arg0 = comptime makeData(neon.f32x2, 0);
    const arg1 = comptime makeData(neon.f32x2, 13);
    const expected = comptime neon.vzip1_f32(arg0, arg1);
    const actual = neon.vzip1_f32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vzip2_f32" {
    const arg0 = comptime makeData(neon.f32x2, 0);
    const arg1 = comptime makeData(neon.f32x2, 13);
    const expected = comptime neon.vzip2_f32(arg0, arg1);
    const actual = neon.vzip2_f32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vzip1q_u8" {
    const arg0 = comptime makeData(neon.u8x16, 0);
    const arg1 = comptime makeData(neon.u8x16, 13);
    const expected = comptime neon.vzip1q_u8(arg0, arg1);
    const actual = neon.vzip1q_u8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vzip2q_u8" {
    const arg0 = comptime makeData(neon.u8x16, 0);
    const arg1 = comptime makeData(neon.u8x16, 13);
    const expected = comptime neon.vzip2q_u8(arg0, arg1);
    const actual = neon.vzip2q_u8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vzip1q_s8" {
    const arg0 = comptime makeData(neon.i8x16, 0);
    const arg1 = comptime makeData(neon.i8x16, 13);
    const expected = comptime neon.vzip1q_s8(arg0, arg1);
    const actual = neon.vzip1q_s8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vzip2q_s8" {
    const arg0 = comptime makeData(neon.i8x16, 0);
    const arg1 = comptime makeData(neon.i8x16, 13);
    const expected = comptime neon.vzip2q_s8(arg0, arg1);
    const actual = neon.vzip2q_s8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vzip1q_u16" {
    const arg0 = comptime makeData(neon.u16x8, 0);
    const arg1 = comptime makeData(neon.u16x8, 13);
    const expected = comptime neon.vzip1q_u16(arg0, arg1);
    const actual = neon.vzip1q_u16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vzip2q_u16" {
    const arg0 = comptime makeData(neon.u16x8, 0);
    const arg1 = comptime makeData(neon.u16x8, 13);
    const expected = comptime neon.vzip2q_u16(arg0, arg1);
    const actual = neon.vzip2q_u16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vzip1q_s16" {
    const arg0 = comptime makeData(neon.i16x8, 0);
    const arg1 = comptime makeData(neon.i16x8, 13);
    const expected = comptime neon.vzip1q_s16(arg0, arg1);
    const actual = neon.vzip1q_s16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vzip2q_s16" {
    const arg0 = comptime makeData(neon.i16x8, 0);
    const arg1 = comptime makeData(neon.i16x8, 13);
    const expected = comptime neon.vzip2q_s16(arg0, arg1);
    const actual = neon.vzip2q_s16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vzip1q_u32" {
    const arg0 = comptime makeData(neon.u32x4, 0);
    const arg1 = comptime makeData(neon.u32x4, 13);
    const expected = comptime neon.vzip1q_u32(arg0, arg1);
    const actual = neon.vzip1q_u32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vzip2q_u32" {
    const arg0 = comptime makeData(neon.u32x4, 0);
    const arg1 = comptime makeData(neon.u32x4, 13);
    const expected = comptime neon.vzip2q_u32(arg0, arg1);
    const actual = neon.vzip2q_u32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vzip1q_s32" {
    const arg0 = comptime makeData(neon.i32x4, 0);
    const arg1 = comptime makeData(neon.i32x4, 13);
    const expected = comptime neon.vzip1q_s32(arg0, arg1);
    const actual = neon.vzip1q_s32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vzip2q_s32" {
    const arg0 = comptime makeData(neon.i32x4, 0);
    const arg1 = comptime makeData(neon.i32x4, 13);
    const expected = comptime neon.vzip2q_s32(arg0, arg1);
    const actual = neon.vzip2q_s32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vzip1q_f32" {
    const arg0 = comptime makeData(neon.f32x4, 0);
    const arg1 = comptime makeData(neon.f32x4, 13);
    const expected = comptime neon.vzip1q_f32(arg0, arg1);
    const actual = neon.vzip1q_f32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vzip2q_f32" {
    const arg0 = comptime makeData(neon.f32x4, 0);
    const arg1 = comptime makeData(neon.f32x4, 13);
    const expected = comptime neon.vzip2q_f32(arg0, arg1);
    const actual = neon.vzip2q_f32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vzip1q_u64" {
    const arg0 = comptime makeData(neon.u64x2, 0);
    const arg1 = comptime makeData(neon.u64x2, 13);
    const expected = comptime neon.vzip1q_u64(arg0, arg1);
    const actual = neon.vzip1q_u64(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vzip2q_u64" {
    const arg0 = comptime makeData(neon.u64x2, 0);
    const arg1 = comptime makeData(neon.u64x2, 13);
    const expected = comptime neon.vzip2q_u64(arg0, arg1);
    const actual = neon.vzip2q_u64(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vzip1q_s64" {
    const arg0 = comptime makeData(neon.i64x2, 0);
    const arg1 = comptime makeData(neon.i64x2, 13);
    const expected = comptime neon.vzip1q_s64(arg0, arg1);
    const actual = neon.vzip1q_s64(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vzip2q_s64" {
    const arg0 = comptime makeData(neon.i64x2, 0);
    const arg1 = comptime makeData(neon.i64x2, 13);
    const expected = comptime neon.vzip2q_s64(arg0, arg1);
    const actual = neon.vzip2q_s64(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vzip1q_f64" {
    const arg0 = comptime makeData(neon.f64x2, 0);
    const arg1 = comptime makeData(neon.f64x2, 13);
    const expected = comptime neon.vzip1q_f64(arg0, arg1);
    const actual = neon.vzip1q_f64(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vzip2q_f64" {
    const arg0 = comptime makeData(neon.f64x2, 0);
    const arg1 = comptime makeData(neon.f64x2, 13);
    const expected = comptime neon.vzip2q_f64(arg0, arg1);
    const actual = neon.vzip2q_f64(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vzipq_u8" {
    const arg0 = comptime makeData(neon.u8x16, 0);
    const arg1 = comptime makeData(neon.u8x16, 13);
    const expected = comptime neon.vzipq_u8(arg0, arg1);
    const actual = neon.vzipq_u8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vzipq_s8" {
    const arg0 = comptime makeData(neon.i8x16, 0);
    const arg1 = comptime makeData(neon.i8x16, 13);
    const expected = comptime neon.vzipq_s8(arg0, arg1);
    const actual = neon.vzipq_s8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vzipq_u16" {
    const arg0 = comptime makeData(neon.u16x8, 0);
    const arg1 = comptime makeData(neon.u16x8, 13);
    const expected = comptime neon.vzipq_u16(arg0, arg1);
    const actual = neon.vzipq_u16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vzipq_s16" {
    const arg0 = comptime makeData(neon.i16x8, 0);
    const arg1 = comptime makeData(neon.i16x8, 13);
    const expected = comptime neon.vzipq_s16(arg0, arg1);
    const actual = neon.vzipq_s16(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vzipq_u32" {
    const arg0 = comptime makeData(neon.u32x4, 0);
    const arg1 = comptime makeData(neon.u32x4, 13);
    const expected = comptime neon.vzipq_u32(arg0, arg1);
    const actual = neon.vzipq_u32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vzipq_s32" {
    const arg0 = comptime makeData(neon.i32x4, 0);
    const arg1 = comptime makeData(neon.i32x4, 13);
    const expected = comptime neon.vzipq_s32(arg0, arg1);
    const actual = neon.vzipq_s32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vzipq_u64" {
    const arg0 = comptime makeData(neon.u64x2, 0);
    const arg1 = comptime makeData(neon.u64x2, 13);
    const expected = comptime neon.vzipq_u64(arg0, arg1);
    const actual = neon.vzipq_u64(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vzipq_s64" {
    const arg0 = comptime makeData(neon.i64x2, 0);
    const arg1 = comptime makeData(neon.i64x2, 13);
    const expected = comptime neon.vzipq_s64(arg0, arg1);
    const actual = neon.vzipq_s64(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vtrn1q_s8" {
    const arg0 = comptime makeData(neon.i8x16, 0);
    const arg1 = comptime makeData(neon.i8x16, 13);
    const expected = comptime neon.vtrn1q_s8(arg0, arg1);
    const actual = neon.vtrn1q_s8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vtrn2q_s8" {
    const arg0 = comptime makeData(neon.i8x16, 0);
    const arg1 = comptime makeData(neon.i8x16, 13);
    const expected = comptime neon.vtrn2q_s8(arg0, arg1);
    const actual = neon.vtrn2q_s8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vtrn1q_u8" {
    const arg0 = comptime makeData(neon.u8x16, 0);
    const arg1 = comptime makeData(neon.u8x16, 13);
    const expected = comptime neon.vtrn1q_u8(arg0, arg1);
    const actual = neon.vtrn1q_u8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vtrn2q_u8" {
    const arg0 = comptime makeData(neon.u8x16, 0);
    const arg1 = comptime makeData(neon.u8x16, 13);
    const expected = comptime neon.vtrn2q_u8(arg0, arg1);
    const actual = neon.vtrn2q_u8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vtrn1q_f32" {
    const arg0 = comptime makeData(neon.f32x4, 0);
    const arg1 = comptime makeData(neon.f32x4, 13);
    const expected = comptime neon.vtrn1q_f32(arg0, arg1);
    const actual = neon.vtrn1q_f32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vtrn2q_f32" {
    const arg0 = comptime makeData(neon.f32x4, 0);
    const arg1 = comptime makeData(neon.f32x4, 13);
    const expected = comptime neon.vtrn2q_f32(arg0, arg1);
    const actual = neon.vtrn2q_f32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vtrnq_f32" {
    const arg0 = comptime makeData(neon.f32x4, 0);
    const arg1 = comptime makeData(neon.f32x4, 13);
    const expected = comptime neon.vtrnq_f32(arg0, arg1);
    const actual = neon.vtrnq_f32(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vtrnq_s8" {
    const arg0 = comptime makeData(neon.i8x16, 0);
    const arg1 = comptime makeData(neon.i8x16, 13);
    const expected = comptime neon.vtrnq_s8(arg0, arg1);
    const actual = neon.vtrnq_s8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vtrnq_u8" {
    const arg0 = comptime makeData(neon.u8x16, 0);
    const arg1 = comptime makeData(neon.u8x16, 13);
    const expected = comptime neon.vtrnq_u8(arg0, arg1);
    const actual = neon.vtrnq_u8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vrev64q_s8" {
    const arg0 = comptime makeData(neon.i8x16, 0);
    const expected = comptime neon.vrev64q_s8(arg0);
    const actual = neon.vrev64q_s8(arg0);
    try expectEqualApprox(expected, actual);
}

test "vrev64q_u8" {
    const arg0 = comptime makeData(neon.u8x16, 0);
    const expected = comptime neon.vrev64q_u8(arg0);
    const actual = neon.vrev64q_u8(arg0);
    try expectEqualApprox(expected, actual);
}

test "vrev64q_s16" {
    const arg0 = comptime makeData(neon.i16x8, 0);
    const expected = comptime neon.vrev64q_s16(arg0);
    const actual = neon.vrev64q_s16(arg0);
    try expectEqualApprox(expected, actual);
}

test "vrev64q_u16" {
    const arg0 = comptime makeData(neon.u16x8, 0);
    const expected = comptime neon.vrev64q_u16(arg0);
    const actual = neon.vrev64q_u16(arg0);
    try expectEqualApprox(expected, actual);
}

test "vrev64q_s32" {
    const arg0 = comptime makeData(neon.i32x4, 0);
    const expected = comptime neon.vrev64q_s32(arg0);
    const actual = neon.vrev64q_s32(arg0);
    try expectEqualApprox(expected, actual);
}

test "vrev64q_u32" {
    const arg0 = comptime makeData(neon.u32x4, 0);
    const expected = comptime neon.vrev64q_u32(arg0);
    const actual = neon.vrev64q_u32(arg0);
    try expectEqualApprox(expected, actual);
}

test "vrev64q_f32" {
    const arg0 = comptime makeData(neon.f32x4, 0);
    const expected = comptime neon.vrev64q_f32(arg0);
    const actual = neon.vrev64q_f32(arg0);
    try expectEqualApprox(expected, actual);
}

test "vqtbl1q_u8" {
    const arg0 = comptime makeData(neon.u8x16, 0);
    const arg1 = comptime makeData(neon.u8x16, 13);
    const expected = comptime neon.vqtbl1q_u8(arg0, arg1);
    const actual = neon.vqtbl1q_u8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vqtbl1q_s8" {
    const arg0 = comptime makeData(neon.i8x16, 0);
    const arg1 = comptime makeData(neon.i8x16, 13);
    const expected = comptime neon.vqtbl1q_s8(arg0, arg1);
    const actual = neon.vqtbl1q_s8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vqtbl1q_p8" {
    const arg0 = comptime makeData(neon.p8x16, 0);
    const arg1 = comptime makeData(neon.p8x16, 13);
    const expected = comptime neon.vqtbl1q_p8(arg0, arg1);
    const actual = neon.vqtbl1q_p8(arg0, arg1);
    try expectEqualApprox(expected, actual);
}

test "vld1_s8" {
    const arg0: [*]const i8 = @ptrCast(@alignCast(&global_buffer));
    _ = neon.vld1_s8(arg0);
}

test "vld1_s16" {
    const arg0: [*]const i16 = @ptrCast(@alignCast(&global_buffer));
    _ = neon.vld1_s16(arg0);
}

test "vld1_s32" {
    const arg0: [*]const i32 = @ptrCast(@alignCast(&global_buffer));
    _ = neon.vld1_s32(arg0);
}

test "vld1_s64" {
    const arg0: [*]const i64 = @ptrCast(@alignCast(&global_buffer));
    _ = neon.vld1_s64(arg0);
}

test "vld1_u8" {
    const arg0: [*]const u8 = @ptrCast(@alignCast(&global_buffer));
    _ = neon.vld1_u8(arg0);
}

test "vld1_u16" {
    const arg0: [*]const u16 = @ptrCast(@alignCast(&global_buffer));
    _ = neon.vld1_u16(arg0);
}

test "vld1_u32" {
    const arg0: [*]const u32 = @ptrCast(@alignCast(&global_buffer));
    _ = neon.vld1_u32(arg0);
}

test "vld1_u64" {
    const arg0: [*]const u64 = @ptrCast(@alignCast(&global_buffer));
    _ = neon.vld1_u64(arg0);
}

test "vld1_f16" {
    const arg0: [*]const f16 = @ptrCast(@alignCast(&global_buffer));
    _ = neon.vld1_f16(arg0);
}

test "vld1_f32" {
    const arg0: [*]const f32 = @ptrCast(@alignCast(&global_buffer));
    _ = neon.vld1_f32(arg0);
}

test "vld1_f64" {
    const arg0: [*]const f64 = @ptrCast(@alignCast(&global_buffer));
    _ = neon.vld1_f64(arg0);
}

test "vld1_p8" {
    const arg0: [*]const neon.p8 = @ptrCast(@alignCast(&global_buffer));
    _ = neon.vld1_p8(arg0);
}

test "vld1_p16" {
    const arg0: [*]const neon.p16 = @ptrCast(@alignCast(&global_buffer));
    _ = neon.vld1_p16(arg0);
}

test "vld1_p64" {
    const arg0: [*]const neon.p64 = @ptrCast(@alignCast(&global_buffer));
    _ = neon.vld1_p64(arg0);
}

test "vld1q_s8" {
    const arg0: [*]const i8 = @ptrCast(@alignCast(&global_buffer));
    _ = neon.vld1q_s8(arg0);
}

test "vld1q_s16" {
    const arg0: [*]const i16 = @ptrCast(@alignCast(&global_buffer));
    _ = neon.vld1q_s16(arg0);
}

test "vld1q_s32" {
    const arg0: [*]const i32 = @ptrCast(@alignCast(&global_buffer));
    _ = neon.vld1q_s32(arg0);
}

test "vld1q_s64" {
    const arg0: [*]const i64 = @ptrCast(@alignCast(&global_buffer));
    _ = neon.vld1q_s64(arg0);
}

test "vld1q_u8" {
    const arg0: [*]const u8 = @ptrCast(@alignCast(&global_buffer));
    _ = neon.vld1q_u8(arg0);
}

test "vld1q_u16" {
    const arg0: [*]const u16 = @ptrCast(@alignCast(&global_buffer));
    _ = neon.vld1q_u16(arg0);
}

test "vld1q_u32" {
    const arg0: [*]const u32 = @ptrCast(@alignCast(&global_buffer));
    _ = neon.vld1q_u32(arg0);
}

test "vld1q_u64" {
    const arg0: [*]const u64 = @ptrCast(@alignCast(&global_buffer));
    _ = neon.vld1q_u64(arg0);
}

test "vld1q_f16" {
    const arg0: [*]const f16 = @ptrCast(@alignCast(&global_buffer));
    _ = neon.vld1q_f16(arg0);
}

test "vld1q_f32" {
    const arg0: [*]const f32 = @ptrCast(@alignCast(&global_buffer));
    _ = neon.vld1q_f32(arg0);
}

test "vld1q_f64" {
    const arg0: [*]const f64 = @ptrCast(@alignCast(&global_buffer));
    _ = neon.vld1q_f64(arg0);
}

test "vld1q_p8" {
    const arg0: [*]const neon.p8 = @ptrCast(@alignCast(&global_buffer));
    _ = neon.vld1q_p8(arg0);
}

test "vld1q_p16" {
    const arg0: [*]const neon.p16 = @ptrCast(@alignCast(&global_buffer));
    _ = neon.vld1q_p16(arg0);
}

test "vld1q_p64" {
    const arg0: [*]const neon.p64 = @ptrCast(@alignCast(&global_buffer));
    _ = neon.vld1q_p64(arg0);
}

test "vst1_s8" {
    const arg0: [*]i8 = @ptrCast(@alignCast(&global_buffer));
    const arg1 = comptime makeData(neon.i8x8, 13);
    _ = neon.vst1_s8(arg0, arg1);
}

test "vst1_s16" {
    const arg0: [*]i16 = @ptrCast(@alignCast(&global_buffer));
    const arg1 = comptime makeData(neon.i16x4, 13);
    _ = neon.vst1_s16(arg0, arg1);
}

test "vst1_s32" {
    const arg0: [*]i32 = @ptrCast(@alignCast(&global_buffer));
    const arg1 = comptime makeData(neon.i32x2, 13);
    _ = neon.vst1_s32(arg0, arg1);
}

test "vst1_s64" {
    const arg0: [*]i64 = @ptrCast(@alignCast(&global_buffer));
    const arg1 = comptime makeData(neon.i64x1, 13);
    _ = neon.vst1_s64(arg0, arg1);
}

test "vst1_u8" {
    const arg0: [*]u8 = @ptrCast(@alignCast(&global_buffer));
    const arg1 = comptime makeData(neon.u8x8, 13);
    _ = neon.vst1_u8(arg0, arg1);
}

test "vst1_u16" {
    const arg0: [*]u16 = @ptrCast(@alignCast(&global_buffer));
    const arg1 = comptime makeData(neon.u16x4, 13);
    _ = neon.vst1_u16(arg0, arg1);
}

test "vst1_u32" {
    const arg0: [*]u32 = @ptrCast(@alignCast(&global_buffer));
    const arg1 = comptime makeData(neon.u32x2, 13);
    _ = neon.vst1_u32(arg0, arg1);
}

test "vst1_u64" {
    const arg0: [*]u64 = @ptrCast(@alignCast(&global_buffer));
    const arg1 = comptime makeData(neon.u64x1, 13);
    _ = neon.vst1_u64(arg0, arg1);
}

test "vst1_f16" {
    const arg0: [*]f16 = @ptrCast(@alignCast(&global_buffer));
    const arg1 = comptime makeData(neon.f16x4, 13);
    _ = neon.vst1_f16(arg0, arg1);
}

test "vst1_f32" {
    const arg0: [*]f32 = @ptrCast(@alignCast(&global_buffer));
    const arg1 = comptime makeData(neon.f32x2, 13);
    _ = neon.vst1_f32(arg0, arg1);
}

test "vst1_f64" {
    const arg0: [*]f64 = @ptrCast(@alignCast(&global_buffer));
    const arg1 = comptime makeData(neon.f64x1, 13);
    _ = neon.vst1_f64(arg0, arg1);
}

test "vst1_p8" {
    const arg0: [*]neon.p8 = @ptrCast(@alignCast(&global_buffer));
    const arg1 = comptime makeData(neon.p8x8, 13);
    _ = neon.vst1_p8(arg0, arg1);
}

test "vst1_p16" {
    const arg0: [*]neon.p16 = @ptrCast(@alignCast(&global_buffer));
    const arg1 = comptime makeData(neon.p16x4, 13);
    _ = neon.vst1_p16(arg0, arg1);
}

test "vst1_p64" {
    const arg0: [*]neon.p64 = @ptrCast(@alignCast(&global_buffer));
    const arg1 = comptime makeData(neon.p64x1, 13);
    _ = neon.vst1_p64(arg0, arg1);
}

test "vst1q_s8" {
    const arg0: [*]i8 = @ptrCast(@alignCast(&global_buffer));
    const arg1 = comptime makeData(neon.i8x16, 13);
    _ = neon.vst1q_s8(arg0, arg1);
}

test "vst1q_s16" {
    const arg0: [*]i16 = @ptrCast(@alignCast(&global_buffer));
    const arg1 = comptime makeData(neon.i16x8, 13);
    _ = neon.vst1q_s16(arg0, arg1);
}

test "vst1q_s32" {
    const arg0: [*]i32 = @ptrCast(@alignCast(&global_buffer));
    const arg1 = comptime makeData(neon.i32x4, 13);
    _ = neon.vst1q_s32(arg0, arg1);
}

test "vst1q_s64" {
    const arg0: [*]i64 = @ptrCast(@alignCast(&global_buffer));
    const arg1 = comptime makeData(neon.i64x2, 13);
    _ = neon.vst1q_s64(arg0, arg1);
}

test "vst1q_u8" {
    const arg0: [*]u8 = @ptrCast(@alignCast(&global_buffer));
    const arg1 = comptime makeData(neon.u8x16, 13);
    _ = neon.vst1q_u8(arg0, arg1);
}

test "vst1q_u16" {
    const arg0: [*]u16 = @ptrCast(@alignCast(&global_buffer));
    const arg1 = comptime makeData(neon.u16x8, 13);
    _ = neon.vst1q_u16(arg0, arg1);
}

test "vst1q_u32" {
    const arg0: [*]u32 = @ptrCast(@alignCast(&global_buffer));
    const arg1 = comptime makeData(neon.u32x4, 13);
    _ = neon.vst1q_u32(arg0, arg1);
}

test "vst1q_u64" {
    const arg0: [*]u64 = @ptrCast(@alignCast(&global_buffer));
    const arg1 = comptime makeData(neon.u64x2, 13);
    _ = neon.vst1q_u64(arg0, arg1);
}

test "vst1q_f16" {
    const arg0: [*]f16 = @ptrCast(@alignCast(&global_buffer));
    const arg1 = comptime makeData(neon.f16x8, 13);
    _ = neon.vst1q_f16(arg0, arg1);
}

test "vst1q_f32" {
    const arg0: [*]f32 = @ptrCast(@alignCast(&global_buffer));
    const arg1 = comptime makeData(neon.f32x4, 13);
    _ = neon.vst1q_f32(arg0, arg1);
}

test "vst1q_f64" {
    const arg0: [*]f64 = @ptrCast(@alignCast(&global_buffer));
    const arg1 = comptime makeData(neon.f64x2, 13);
    _ = neon.vst1q_f64(arg0, arg1);
}

test "vst1q_p8" {
    const arg0: [*]neon.p8 = @ptrCast(@alignCast(&global_buffer));
    const arg1 = comptime makeData(neon.p8x16, 13);
    _ = neon.vst1q_p8(arg0, arg1);
}

test "vst1q_p16" {
    const arg0: [*]neon.p16 = @ptrCast(@alignCast(&global_buffer));
    const arg1 = comptime makeData(neon.p16x8, 13);
    _ = neon.vst1q_p16(arg0, arg1);
}

test "vst1q_p64" {
    const arg0: [*]neon.p64 = @ptrCast(@alignCast(&global_buffer));
    const arg1 = comptime makeData(neon.p64x2, 13);
    _ = neon.vst1q_p64(arg0, arg1);
}

test "vst1q_p46" {
    const arg0: [*]neon.p64 = @ptrCast(@alignCast(&global_buffer));
    const arg1 = comptime makeData(neon.p64x2, 13);
    _ = neon.vst1q_p46(arg0, arg1);
}

test "vld1_lane_u8" {
    const arg0: [*]const u8 = @ptrCast(@alignCast(&global_buffer));
    const arg1 = comptime makeData(neon.u8x8, 13);
    const arg2: usize = 0;
    _ = neon.vld1_lane_u8(arg0, arg1, arg2);
}

test "vld1q_lane_u8" {
    const arg0: [*]const u8 = @ptrCast(@alignCast(&global_buffer));
    const arg1 = comptime makeData(neon.u8x16, 13);
    const arg2: usize = 0;
    _ = neon.vld1q_lane_u8(arg0, arg1, arg2);
}

test "vld1_lane_s32" {
    const arg0: [*]const i32 = @ptrCast(@alignCast(&global_buffer));
    const arg1 = comptime makeData(neon.i32x2, 13);
    const arg2: usize = 0;
    _ = neon.vld1_lane_s32(arg0, arg1, arg2);
}

test "vld1q_lane_s32" {
    const arg0: [*]const i32 = @ptrCast(@alignCast(&global_buffer));
    const arg1 = comptime makeData(neon.i32x4, 13);
    const arg2: usize = 0;
    _ = neon.vld1q_lane_s32(arg0, arg1, arg2);
}

test "vld1_lane_f32" {
    const arg0: [*]const f32 = @ptrCast(@alignCast(&global_buffer));
    const arg1 = comptime makeData(neon.f32x2, 13);
    const arg2: usize = 0;
    _ = neon.vld1_lane_f32(arg0, arg1, arg2);
}

test "vld1q_lane_f32" {
    const arg0: [*]const f32 = @ptrCast(@alignCast(&global_buffer));
    const arg1 = comptime makeData(neon.f32x4, 13);
    const arg2: usize = 0;
    _ = neon.vld1q_lane_f32(arg0, arg1, arg2);
}

test "vld1_dup_u8" {
    const arg0: [*]const u8 = @ptrCast(@alignCast(&global_buffer));
    _ = neon.vld1_dup_u8(arg0);
}

test "vld1_dup_u16" {
    const arg0: [*]const u16 = @ptrCast(@alignCast(&global_buffer));
    _ = neon.vld1_dup_u16(arg0);
}

test "vld1_dup_u32" {
    const arg0: [*]const u32 = @ptrCast(@alignCast(&global_buffer));
    _ = neon.vld1_dup_u32(arg0);
}

test "vld1_dup_u64" {
    const arg0: [*]const u64 = @ptrCast(@alignCast(&global_buffer));
    _ = neon.vld1_dup_u64(arg0);
}

test "vld1_dup_s8" {
    const arg0: [*]const i8 = @ptrCast(@alignCast(&global_buffer));
    _ = neon.vld1_dup_s8(arg0);
}

test "vld1_dup_s16" {
    const arg0: [*]const i16 = @ptrCast(@alignCast(&global_buffer));
    _ = neon.vld1_dup_s16(arg0);
}

test "vld1_dup_s32" {
    const arg0: [*]const i32 = @ptrCast(@alignCast(&global_buffer));
    _ = neon.vld1_dup_s32(arg0);
}

test "vld1_dup_s64" {
    const arg0: [*]const i64 = @ptrCast(@alignCast(&global_buffer));
    _ = neon.vld1_dup_s64(arg0);
}

test "vld1_dup_f16" {
    const arg0: [*]const f16 = @ptrCast(@alignCast(&global_buffer));
    _ = neon.vld1_dup_f16(arg0);
}

test "vld1_dup_f32" {
    const arg0: [*]const f32 = @ptrCast(@alignCast(&global_buffer));
    _ = neon.vld1_dup_f32(arg0);
}

test "vld1_dup_f64" {
    const arg0: [*]const f64 = @ptrCast(@alignCast(&global_buffer));
    _ = neon.vld1_dup_f64(arg0);
}

test "vld1_dup_p8" {
    const arg0: [*]const neon.p8 = @ptrCast(@alignCast(&global_buffer));
    _ = neon.vld1_dup_p8(arg0);
}

test "vld1_dup_p16" {
    const arg0: [*]const neon.p16 = @ptrCast(@alignCast(&global_buffer));
    _ = neon.vld1_dup_p16(arg0);
}

test "vld1_dup_p64" {
    const arg0: [*]const neon.p64 = @ptrCast(@alignCast(&global_buffer));
    _ = neon.vld1_dup_p64(arg0);
}

test "vld1q_dup_u8" {
    const arg0: [*]const u8 = @ptrCast(@alignCast(&global_buffer));
    _ = neon.vld1q_dup_u8(arg0);
}

test "vld1q_dup_u16" {
    const arg0: [*]const u16 = @ptrCast(@alignCast(&global_buffer));
    _ = neon.vld1q_dup_u16(arg0);
}

test "vld1q_dup_u32" {
    const arg0: [*]const u32 = @ptrCast(@alignCast(&global_buffer));
    _ = neon.vld1q_dup_u32(arg0);
}

test "vld1q_dup_u64" {
    const arg0: [*]const u64 = @ptrCast(@alignCast(&global_buffer));
    _ = neon.vld1q_dup_u64(arg0);
}

test "vld1q_dup_s8" {
    const arg0: [*]const i8 = @ptrCast(@alignCast(&global_buffer));
    _ = neon.vld1q_dup_s8(arg0);
}

test "vld1q_dup_s16" {
    const arg0: [*]const i16 = @ptrCast(@alignCast(&global_buffer));
    _ = neon.vld1q_dup_s16(arg0);
}

test "vld1q_dup_s32" {
    const arg0: [*]const i32 = @ptrCast(@alignCast(&global_buffer));
    _ = neon.vld1q_dup_s32(arg0);
}

test "vld1q_dup_s64" {
    const arg0: [*]const i64 = @ptrCast(@alignCast(&global_buffer));
    _ = neon.vld1q_dup_s64(arg0);
}

test "vld1q_dup_f16" {
    const arg0: [*]const f16 = @ptrCast(@alignCast(&global_buffer));
    _ = neon.vld1q_dup_f16(arg0);
}

test "vld1q_dup_f32" {
    const arg0: [*]const f32 = @ptrCast(@alignCast(&global_buffer));
    _ = neon.vld1q_dup_f32(arg0);
}

test "vld1q_dup_f64" {
    const arg0: [*]const f64 = @ptrCast(@alignCast(&global_buffer));
    _ = neon.vld1q_dup_f64(arg0);
}

test "vld1q_dup_p8" {
    const arg0: [*]const neon.p8 = @ptrCast(@alignCast(&global_buffer));
    _ = neon.vld1q_dup_p8(arg0);
}

test "vld1q_dup_p16" {
    const arg0: [*]const neon.p16 = @ptrCast(@alignCast(&global_buffer));
    _ = neon.vld1q_dup_p16(arg0);
}

test "vld1q_dup_p64" {
    const arg0: [*]const neon.p64 = @ptrCast(@alignCast(&global_buffer));
    _ = neon.vld1q_dup_p64(arg0);
}

test "vst1_lane_u8" {
    const arg0: [*]u8 = @ptrCast(@alignCast(&global_buffer));
    const arg1 = comptime makeData(neon.u8x8, 13);
    const arg2: usize = 0;
    _ = neon.vst1_lane_u8(arg0, arg1, arg2);
}

test "vst1q_lane_u8" {
    const arg0: [*]u8 = @ptrCast(@alignCast(&global_buffer));
    const arg1 = comptime makeData(neon.u8x16, 13);
    const arg2: usize = 0;
    _ = neon.vst1q_lane_u8(arg0, arg1, arg2);
}

test "vst1_lane_s32" {
    const arg0: [*]i32 = @ptrCast(@alignCast(&global_buffer));
    const arg1 = comptime makeData(neon.i32x2, 13);
    const arg2: usize = 0;
    _ = neon.vst1_lane_s32(arg0, arg1, arg2);
}

test "vst1q_lane_s32" {
    const arg0: [*]i32 = @ptrCast(@alignCast(&global_buffer));
    const arg1 = comptime makeData(neon.i32x4, 13);
    const arg2: usize = 0;
    _ = neon.vst1q_lane_s32(arg0, arg1, arg2);
}

test "vst1_lane_f32" {
    const arg0: [*]f32 = @ptrCast(@alignCast(&global_buffer));
    const arg1 = comptime makeData(neon.f32x2, 13);
    const arg2: usize = 0;
    _ = neon.vst1_lane_f32(arg0, arg1, arg2);
}

test "vst1q_lane_f32" {
    const arg0: [*]f32 = @ptrCast(@alignCast(&global_buffer));
    const arg1 = comptime makeData(neon.f32x4, 13);
    const arg2: usize = 0;
    _ = neon.vst1q_lane_f32(arg0, arg1, arg2);
}

test "vld2_u8" {
    const arg0: [*]const u8 = @ptrCast(@alignCast(&global_buffer));
    _ = neon.vld2_u8(arg0);
}

test "vld2_s8" {
    const arg0: [*]const i8 = @ptrCast(@alignCast(&global_buffer));
    _ = neon.vld2_s8(arg0);
}

test "vld2_s16" {
    const arg0: [*]const i16 = @ptrCast(@alignCast(&global_buffer));
    _ = neon.vld2_s16(arg0);
}

test "vld2_u16" {
    const arg0: [*]const u16 = @ptrCast(@alignCast(&global_buffer));
    _ = neon.vld2_u16(arg0);
}

test "vld2_s32" {
    const arg0: [*]const i32 = @ptrCast(@alignCast(&global_buffer));
    _ = neon.vld2_s32(arg0);
}

test "vld2_u32" {
    const arg0: [*]const u32 = @ptrCast(@alignCast(&global_buffer));
    _ = neon.vld2_u32(arg0);
}

test "vld2_f32" {
    const arg0: [*]const f32 = @ptrCast(@alignCast(&global_buffer));
    _ = neon.vld2_f32(arg0);
}

test "vld2q_u8" {
    const arg0: [*]const u8 = @ptrCast(@alignCast(&global_buffer));
    _ = neon.vld2q_u8(arg0);
}

test "vld2q_s8" {
    const arg0: [*]const i8 = @ptrCast(@alignCast(&global_buffer));
    _ = neon.vld2q_s8(arg0);
}

test "vld2q_s16" {
    const arg0: [*]const i16 = @ptrCast(@alignCast(&global_buffer));
    _ = neon.vld2q_s16(arg0);
}

test "vld2q_u16" {
    const arg0: [*]const u16 = @ptrCast(@alignCast(&global_buffer));
    _ = neon.vld2q_u16(arg0);
}

test "vld2q_s32" {
    const arg0: [*]const i32 = @ptrCast(@alignCast(&global_buffer));
    _ = neon.vld2q_s32(arg0);
}

test "vld2q_u32" {
    const arg0: [*]const u32 = @ptrCast(@alignCast(&global_buffer));
    _ = neon.vld2q_u32(arg0);
}

test "vld2q_f32" {
    const arg0: [*]const f32 = @ptrCast(@alignCast(&global_buffer));
    _ = neon.vld2q_f32(arg0);
}

test "vst2_u8" {
    const arg0: [*]u8 = @ptrCast(@alignCast(&global_buffer));
    const arg1 = comptime makeData(neon.types.u8x8x2, 13);
    _ = neon.vst2_u8(arg0, arg1);
}

test "vst2_s8" {
    const arg0: [*]i8 = @ptrCast(@alignCast(&global_buffer));
    const arg1 = comptime makeData(neon.types.i8x8x2, 13);
    _ = neon.vst2_s8(arg0, arg1);
}

test "vst2_s16" {
    const arg0: [*]i16 = @ptrCast(@alignCast(&global_buffer));
    const arg1 = comptime makeData(neon.types.i16x4x2, 13);
    _ = neon.vst2_s16(arg0, arg1);
}

test "vst2_u16" {
    const arg0: [*]u16 = @ptrCast(@alignCast(&global_buffer));
    const arg1 = comptime makeData(neon.types.u16x4x2, 13);
    _ = neon.vst2_u16(arg0, arg1);
}

test "vst2_s32" {
    const arg0: [*]i32 = @ptrCast(@alignCast(&global_buffer));
    const arg1 = comptime makeData(neon.types.i32x2x2, 13);
    _ = neon.vst2_s32(arg0, arg1);
}

test "vst2_u32" {
    const arg0: [*]u32 = @ptrCast(@alignCast(&global_buffer));
    const arg1 = comptime makeData(neon.types.u32x2x2, 13);
    _ = neon.vst2_u32(arg0, arg1);
}

test "vst2_f32" {
    const arg0: [*]f32 = @ptrCast(@alignCast(&global_buffer));
    const arg1 = comptime makeData(neon.types.f32x2x2, 13);
    _ = neon.vst2_f32(arg0, arg1);
}

test "vst2q_u8" {
    const arg0: [*]u8 = @ptrCast(@alignCast(&global_buffer));
    const arg1 = comptime makeData(neon.types.u8x16x2, 13);
    _ = neon.vst2q_u8(arg0, arg1);
}

test "vst2q_s8" {
    const arg0: [*]i8 = @ptrCast(@alignCast(&global_buffer));
    const arg1 = comptime makeData(neon.types.i8x16x2, 13);
    _ = neon.vst2q_s8(arg0, arg1);
}

test "vst2q_s16" {
    const arg0: [*]i16 = @ptrCast(@alignCast(&global_buffer));
    const arg1 = comptime makeData(neon.types.i16x8x2, 13);
    _ = neon.vst2q_s16(arg0, arg1);
}

test "vst2q_u16" {
    const arg0: [*]u16 = @ptrCast(@alignCast(&global_buffer));
    const arg1 = comptime makeData(neon.types.u16x8x2, 13);
    _ = neon.vst2q_u16(arg0, arg1);
}

test "vst2q_s32" {
    const arg0: [*]i32 = @ptrCast(@alignCast(&global_buffer));
    const arg1 = comptime makeData(neon.types.i32x4x2, 13);
    _ = neon.vst2q_s32(arg0, arg1);
}

test "vst2q_u32" {
    const arg0: [*]u32 = @ptrCast(@alignCast(&global_buffer));
    const arg1 = comptime makeData(neon.types.u32x4x2, 13);
    _ = neon.vst2q_u32(arg0, arg1);
}

test "vst2q_f32" {
    const arg0: [*]f32 = @ptrCast(@alignCast(&global_buffer));
    const arg1 = comptime makeData(neon.types.f32x4x2, 13);
    _ = neon.vst2q_f32(arg0, arg1);
}

test "vld3q_u8" {
    const arg0: [*]const u8 = @ptrCast(@alignCast(&global_buffer));
    _ = neon.vld3q_u8(arg0);
}

test "vst3q_u8" {
    const arg0: [*]u8 = @ptrCast(@alignCast(&global_buffer));
    const arg1 = comptime makeData(neon.types.u8x16x3, 13);
    _ = neon.vst3q_u8(arg0, arg1);
}

test "vld4q_u8" {
    const arg0: [*]const u8 = @ptrCast(@alignCast(&global_buffer));
    _ = neon.vld4q_u8(arg0);
}

test "vst4q_u8" {
    const arg0: [*]u8 = @ptrCast(@alignCast(&global_buffer));
    const arg1 = comptime makeData(neon.types.u8x16x4, 13);
    _ = neon.vst4q_u8(arg0, arg1);
}

test "vaddv_s8" {
    const arg0 = comptime makeData(neon.i8x8, 0);
    const expected = comptime neon.vaddv_s8(arg0);
    const actual = neon.vaddv_s8(arg0);
    try expectEqualApprox(expected, actual);
}

test "vaddv_s16" {
    const arg0 = comptime makeData(neon.i16x4, 0);
    const expected = comptime neon.vaddv_s16(arg0);
    const actual = neon.vaddv_s16(arg0);
    try expectEqualApprox(expected, actual);
}

test "vaddv_s32" {
    const arg0 = comptime makeData(neon.i32x2, 0);
    const expected = comptime neon.vaddv_s32(arg0);
    const actual = neon.vaddv_s32(arg0);
    try expectEqualApprox(expected, actual);
}

test "vaddv_u8" {
    const arg0 = comptime makeData(neon.u8x8, 0);
    const expected = comptime neon.vaddv_u8(arg0);
    const actual = neon.vaddv_u8(arg0);
    try expectEqualApprox(expected, actual);
}

test "vaddv_u16" {
    const arg0 = comptime makeData(neon.u16x4, 0);
    const expected = comptime neon.vaddv_u16(arg0);
    const actual = neon.vaddv_u16(arg0);
    try expectEqualApprox(expected, actual);
}

test "vaddv_u32" {
    const arg0 = comptime makeData(neon.u32x2, 0);
    const expected = comptime neon.vaddv_u32(arg0);
    const actual = neon.vaddv_u32(arg0);
    try expectEqualApprox(expected, actual);
}

test "vaddv_f32" {
    const arg0 = comptime makeData(neon.f32x2, 0);
    const expected = comptime neon.vaddv_f32(arg0);
    const actual = neon.vaddv_f32(arg0);
    try expectEqualApprox(expected, actual);
}

test "vaddvq_s8" {
    const arg0 = comptime makeData(neon.i8x16, 0);
    const expected = comptime neon.vaddvq_s8(arg0);
    const actual = neon.vaddvq_s8(arg0);
    try expectEqualApprox(expected, actual);
}

test "vaddvq_s16" {
    const arg0 = comptime makeData(neon.i16x8, 0);
    const expected = comptime neon.vaddvq_s16(arg0);
    const actual = neon.vaddvq_s16(arg0);
    try expectEqualApprox(expected, actual);
}

test "vaddvq_s32" {
    const arg0 = comptime makeData(neon.i32x4, 0);
    const expected = comptime neon.vaddvq_s32(arg0);
    const actual = neon.vaddvq_s32(arg0);
    try expectEqualApprox(expected, actual);
}

test "vaddvq_s64" {
    const arg0 = comptime makeData(neon.i64x2, 0);
    const expected = comptime neon.vaddvq_s64(arg0);
    const actual = neon.vaddvq_s64(arg0);
    try expectEqualApprox(expected, actual);
}

test "vaddvq_u8" {
    const arg0 = comptime makeData(neon.u8x16, 0);
    const expected = comptime neon.vaddvq_u8(arg0);
    const actual = neon.vaddvq_u8(arg0);
    try expectEqualApprox(expected, actual);
}

test "vaddvq_u16" {
    const arg0 = comptime makeData(neon.u16x8, 0);
    const expected = comptime neon.vaddvq_u16(arg0);
    const actual = neon.vaddvq_u16(arg0);
    try expectEqualApprox(expected, actual);
}

test "vaddvq_u32" {
    const arg0 = comptime makeData(neon.u32x4, 0);
    const expected = comptime neon.vaddvq_u32(arg0);
    const actual = neon.vaddvq_u32(arg0);
    try expectEqualApprox(expected, actual);
}

test "vaddvq_u64" {
    const arg0 = comptime makeData(neon.u64x2, 0);
    const expected = comptime neon.vaddvq_u64(arg0);
    const actual = neon.vaddvq_u64(arg0);
    try expectEqualApprox(expected, actual);
}

test "vaddvq_f32" {
    const arg0 = comptime makeData(neon.f32x4, 0);
    const expected = comptime neon.vaddvq_f32(arg0);
    const actual = neon.vaddvq_f32(arg0);
    try expectEqualApprox(expected, actual);
}

test "vaddvq_f64" {
    const arg0 = comptime makeData(neon.f64x2, 0);
    const expected = comptime neon.vaddvq_f64(arg0);
    const actual = neon.vaddvq_f64(arg0);
    try expectEqualApprox(expected, actual);
}

test "vaddlv_s8" {
    const arg0 = comptime makeData(neon.i8x8, 0);
    const expected = comptime neon.vaddlv_s8(arg0);
    const actual = neon.vaddlv_s8(arg0);
    try expectEqualApprox(expected, actual);
}

test "vaddlv_s16" {
    const arg0 = comptime makeData(neon.i16x4, 0);
    const expected = comptime neon.vaddlv_s16(arg0);
    const actual = neon.vaddlv_s16(arg0);
    try expectEqualApprox(expected, actual);
}

test "vaddlv_s32" {
    const arg0 = comptime makeData(neon.i32x2, 0);
    const expected = comptime neon.vaddlv_s32(arg0);
    const actual = neon.vaddlv_s32(arg0);
    try expectEqualApprox(expected, actual);
}

test "vaddlv_u8" {
    const arg0 = comptime makeData(neon.u8x8, 0);
    const expected = comptime neon.vaddlv_u8(arg0);
    const actual = neon.vaddlv_u8(arg0);
    try expectEqualApprox(expected, actual);
}

test "vaddlv_u16" {
    const arg0 = comptime makeData(neon.u16x4, 0);
    const expected = comptime neon.vaddlv_u16(arg0);
    const actual = neon.vaddlv_u16(arg0);
    try expectEqualApprox(expected, actual);
}

test "vaddlv_u32" {
    const arg0 = comptime makeData(neon.u32x2, 0);
    const expected = comptime neon.vaddlv_u32(arg0);
    const actual = neon.vaddlv_u32(arg0);
    try expectEqualApprox(expected, actual);
}

test "vaddlvq_s8" {
    const arg0 = comptime makeData(neon.i8x16, 0);
    const expected = comptime neon.vaddlvq_s8(arg0);
    const actual = neon.vaddlvq_s8(arg0);
    try expectEqualApprox(expected, actual);
}

test "vaddlvq_s16" {
    const arg0 = comptime makeData(neon.i16x8, 0);
    const expected = comptime neon.vaddlvq_s16(arg0);
    const actual = neon.vaddlvq_s16(arg0);
    try expectEqualApprox(expected, actual);
}

test "vaddlvq_s32" {
    const arg0 = comptime makeData(neon.i32x4, 0);
    const expected = comptime neon.vaddlvq_s32(arg0);
    const actual = neon.vaddlvq_s32(arg0);
    try expectEqualApprox(expected, actual);
}

test "vaddlvq_u8" {
    const arg0 = comptime makeData(neon.u8x16, 0);
    const expected = comptime neon.vaddlvq_u8(arg0);
    const actual = neon.vaddlvq_u8(arg0);
    try expectEqualApprox(expected, actual);
}

test "vaddlvq_u16" {
    const arg0 = comptime makeData(neon.u16x8, 0);
    const expected = comptime neon.vaddlvq_u16(arg0);
    const actual = neon.vaddlvq_u16(arg0);
    try expectEqualApprox(expected, actual);
}

test "vaddlvq_u32" {
    const arg0 = comptime makeData(neon.u32x4, 0);
    const expected = comptime neon.vaddlvq_u32(arg0);
    const actual = neon.vaddlvq_u32(arg0);
    try expectEqualApprox(expected, actual);
}

test "vminv_s8" {
    const arg0 = comptime makeData(neon.i8x8, 0);
    const expected = comptime neon.vminv_s8(arg0);
    const actual = neon.vminv_s8(arg0);
    try expectEqualApprox(expected, actual);
}

test "vminv_s16" {
    const arg0 = comptime makeData(neon.i16x4, 0);
    const expected = comptime neon.vminv_s16(arg0);
    const actual = neon.vminv_s16(arg0);
    try expectEqualApprox(expected, actual);
}

test "vminv_s32" {
    const arg0 = comptime makeData(neon.i32x2, 0);
    const expected = comptime neon.vminv_s32(arg0);
    const actual = neon.vminv_s32(arg0);
    try expectEqualApprox(expected, actual);
}

test "vminv_u8" {
    const arg0 = comptime makeData(neon.u8x8, 0);
    const expected = comptime neon.vminv_u8(arg0);
    const actual = neon.vminv_u8(arg0);
    try expectEqualApprox(expected, actual);
}

test "vminv_u16" {
    const arg0 = comptime makeData(neon.u16x4, 0);
    const expected = comptime neon.vminv_u16(arg0);
    const actual = neon.vminv_u16(arg0);
    try expectEqualApprox(expected, actual);
}

test "vminv_u32" {
    const arg0 = comptime makeData(neon.u32x2, 0);
    const expected = comptime neon.vminv_u32(arg0);
    const actual = neon.vminv_u32(arg0);
    try expectEqualApprox(expected, actual);
}

test "vminvq_s8" {
    const arg0 = comptime makeData(neon.i8x16, 0);
    const expected = comptime neon.vminvq_s8(arg0);
    const actual = neon.vminvq_s8(arg0);
    try expectEqualApprox(expected, actual);
}

test "vminvq_s16" {
    const arg0 = comptime makeData(neon.i16x8, 0);
    const expected = comptime neon.vminvq_s16(arg0);
    const actual = neon.vminvq_s16(arg0);
    try expectEqualApprox(expected, actual);
}

test "vminvq_s32" {
    const arg0 = comptime makeData(neon.i32x4, 0);
    const expected = comptime neon.vminvq_s32(arg0);
    const actual = neon.vminvq_s32(arg0);
    try expectEqualApprox(expected, actual);
}

test "vminvq_u8" {
    const arg0 = comptime makeData(neon.u8x16, 0);
    const expected = comptime neon.vminvq_u8(arg0);
    const actual = neon.vminvq_u8(arg0);
    try expectEqualApprox(expected, actual);
}

test "vminvq_u16" {
    const arg0 = comptime makeData(neon.u16x8, 0);
    const expected = comptime neon.vminvq_u16(arg0);
    const actual = neon.vminvq_u16(arg0);
    try expectEqualApprox(expected, actual);
}

test "vminvq_u32" {
    const arg0 = comptime makeData(neon.u32x4, 0);
    const expected = comptime neon.vminvq_u32(arg0);
    const actual = neon.vminvq_u32(arg0);
    try expectEqualApprox(expected, actual);
}

test "vminvq_f32" {
    const arg0 = comptime makeData(neon.f32x4, 0);
    const expected = comptime neon.vminvq_f32(arg0);
    const actual = neon.vminvq_f32(arg0);
    try expectEqualApprox(expected, actual);
}

test "vminvq_f64" {
    const arg0 = comptime makeData(neon.f64x2, 0);
    const expected = comptime neon.vminvq_f64(arg0);
    const actual = neon.vminvq_f64(arg0);
    try expectEqualApprox(expected, actual);
}

test "vmaxv_s8" {
    const arg0 = comptime makeData(neon.i8x8, 0);
    const expected = comptime neon.vmaxv_s8(arg0);
    const actual = neon.vmaxv_s8(arg0);
    try expectEqualApprox(expected, actual);
}

test "vmaxv_s16" {
    const arg0 = comptime makeData(neon.i16x4, 0);
    const expected = comptime neon.vmaxv_s16(arg0);
    const actual = neon.vmaxv_s16(arg0);
    try expectEqualApprox(expected, actual);
}

test "vmaxv_s32" {
    const arg0 = comptime makeData(neon.i32x2, 0);
    const expected = comptime neon.vmaxv_s32(arg0);
    const actual = neon.vmaxv_s32(arg0);
    try expectEqualApprox(expected, actual);
}

test "vmaxv_u8" {
    const arg0 = comptime makeData(neon.u8x8, 0);
    const expected = comptime neon.vmaxv_u8(arg0);
    const actual = neon.vmaxv_u8(arg0);
    try expectEqualApprox(expected, actual);
}

test "vmaxv_u16" {
    const arg0 = comptime makeData(neon.u16x4, 0);
    const expected = comptime neon.vmaxv_u16(arg0);
    const actual = neon.vmaxv_u16(arg0);
    try expectEqualApprox(expected, actual);
}

test "vmaxv_u32" {
    const arg0 = comptime makeData(neon.u32x2, 0);
    const expected = comptime neon.vmaxv_u32(arg0);
    const actual = neon.vmaxv_u32(arg0);
    try expectEqualApprox(expected, actual);
}

test "vmaxvq_s8" {
    const arg0 = comptime makeData(neon.i8x16, 0);
    const expected = comptime neon.vmaxvq_s8(arg0);
    const actual = neon.vmaxvq_s8(arg0);
    try expectEqualApprox(expected, actual);
}

test "vmaxvq_s16" {
    const arg0 = comptime makeData(neon.i16x8, 0);
    const expected = comptime neon.vmaxvq_s16(arg0);
    const actual = neon.vmaxvq_s16(arg0);
    try expectEqualApprox(expected, actual);
}

test "vmaxvq_s32" {
    const arg0 = comptime makeData(neon.i32x4, 0);
    const expected = comptime neon.vmaxvq_s32(arg0);
    const actual = neon.vmaxvq_s32(arg0);
    try expectEqualApprox(expected, actual);
}

test "vmaxvq_u8" {
    const arg0 = comptime makeData(neon.u8x16, 0);
    const expected = comptime neon.vmaxvq_u8(arg0);
    const actual = neon.vmaxvq_u8(arg0);
    try expectEqualApprox(expected, actual);
}

test "vmaxvq_u16" {
    const arg0 = comptime makeData(neon.u16x8, 0);
    const expected = comptime neon.vmaxvq_u16(arg0);
    const actual = neon.vmaxvq_u16(arg0);
    try expectEqualApprox(expected, actual);
}

test "vmaxvq_u32" {
    const arg0 = comptime makeData(neon.u32x4, 0);
    const expected = comptime neon.vmaxvq_u32(arg0);
    const actual = neon.vmaxvq_u32(arg0);
    try expectEqualApprox(expected, actual);
}

test "vmaxvq_f32" {
    const arg0 = comptime makeData(neon.f32x4, 0);
    const expected = comptime neon.vmaxvq_f32(arg0);
    const actual = neon.vmaxvq_f32(arg0);
    try expectEqualApprox(expected, actual);
}

test "vmaxvq_f64" {
    const arg0 = comptime makeData(neon.f64x2, 0);
    const expected = comptime neon.vmaxvq_f64(arg0);
    const actual = neon.vmaxvq_f64(arg0);
    try expectEqualApprox(expected, actual);
}

test "vmaxnmv_f32" {
    const arg0 = comptime makeData(neon.f32x2, 0);
    const expected = comptime neon.vmaxnmv_f32(arg0);
    const actual = neon.vmaxnmv_f32(arg0);
    try expectEqualApprox(expected, actual);
}

test "vmaxnmvq_f32" {
    const arg0 = comptime makeData(neon.f32x4, 0);
    const expected = comptime neon.vmaxnmvq_f32(arg0);
    const actual = neon.vmaxnmvq_f32(arg0);
    try expectEqualApprox(expected, actual);
}

test "vminnmv_f32" {
    const arg0 = comptime makeData(neon.f32x2, 0);
    const expected = comptime neon.vminnmv_f32(arg0);
    const actual = neon.vminnmv_f32(arg0);
    try expectEqualApprox(expected, actual);
}

test "vminnmvq_f32" {
    const arg0 = comptime makeData(neon.f32x4, 0);
    const expected = comptime neon.vminnmvq_f32(arg0);
    const actual = neon.vminnmvq_f32(arg0);
    try expectEqualApprox(expected, actual);
}

