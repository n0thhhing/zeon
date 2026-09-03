const std = @import("std");
const builtin = @import("builtin");
const simd = std.simd;
const assert = std.debug.assert;
const expectEqual = std.testing.expectEqual;
const arch = @import("arch.zig");
const endianness = builtin.target.cpu.arch.endian();
const types = @import("types.zig");

/// Max bitsize for vectors on arch.arm/arch.aarch64
///
/// TODO: arch.aarch64 isnt always limited to 128
///       bits if we have SVE. SVE gives us
///       a handy instruction called `cntb`
///       that we can use to determine this
///       variable, but unfortunately, that
///       would mean we have to move this
///       outside of the comptime scope.
pub const VEC_MAX_BITSIZE: u32 = 128;

/// AES S-Box
pub const AES_SBOX: [256]u8 = .{ 0x63, 0x7c, 0x77, 0x7b, 0xf2, 0x6b, 0x6f, 0xc5, 0x30, 0x01, 0x67, 0x2b, 0xfe, 0xd7, 0xab, 0x76, 0xca, 0x82, 0xc9, 0x7d, 0xfa, 0x59, 0x47, 0xf0, 0xad, 0xd4, 0xa2, 0xaf, 0x9c, 0xa4, 0x72, 0xc0, 0xb7, 0xfd, 0x93, 0x26, 0x36, 0x3f, 0xf7, 0xcc, 0x34, 0xa5, 0xe5, 0xf1, 0x71, 0xd8, 0x31, 0x15, 0x04, 0xc7, 0x23, 0xc3, 0x18, 0x96, 0x05, 0x9a, 0x07, 0x12, 0x80, 0xe2, 0xeb, 0x27, 0xb2, 0x75, 0x09, 0x83, 0x2c, 0x1a, 0x1b, 0x6e, 0x5a, 0xa0, 0x52, 0x3b, 0xd6, 0xb3, 0x29, 0xe3, 0x2f, 0x84, 0x53, 0xd1, 0x00, 0xed, 0x20, 0xfc, 0xb1, 0x5b, 0x6a, 0xcb, 0xbe, 0x39, 0x4a, 0x4c, 0x58, 0xcf, 0xd0, 0xef, 0xaa, 0xfb, 0x43, 0x4d, 0x33, 0x85, 0x45, 0xf9, 0x02, 0x7f, 0x50, 0x3c, 0x9f, 0xa8, 0x51, 0xa3, 0x40, 0x8f, 0x92, 0x9d, 0x38, 0xf5, 0xbc, 0xb6, 0xda, 0x21, 0x10, 0xff, 0xf3, 0xd2, 0xcd, 0x0c, 0x13, 0xec, 0x5f, 0x97, 0x44, 0x17, 0xc4, 0xa7, 0x7e, 0x3d, 0x64, 0x5d, 0x19, 0x73, 0x60, 0x81, 0x4f, 0xdc, 0x22, 0x2a, 0x90, 0x88, 0x46, 0xee, 0xb8, 0x14, 0xde, 0x5e, 0x0b, 0xdb, 0xe0, 0x32, 0x3a, 0x0a, 0x49, 0x06, 0x24, 0x5c, 0xc2, 0xd3, 0xac, 0x62, 0x91, 0x95, 0xe4, 0x79, 0xe7, 0xc8, 0x37, 0x6d, 0x8d, 0xd5, 0x4e, 0xa9, 0x6c, 0x56, 0xf4, 0xea, 0x65, 0x7a, 0xae, 0x08, 0xba, 0x78, 0x25, 0x2e, 0x1c, 0xa6, 0xb4, 0xc6, 0xe8, 0xdd, 0x74, 0x1f, 0x4b, 0xbd, 0x8b, 0x8a, 0x70, 0x3e, 0xb5, 0x66, 0x48, 0x03, 0xf6, 0x0e, 0x61, 0x35, 0x57, 0xb9, 0x86, 0xc1, 0x1d, 0x9e, 0xe1, 0xf8, 0x98, 0x11, 0x69, 0xd9, 0x8e, 0x94, 0x9b, 0x1e, 0x87, 0xe9, 0xce, 0x55, 0x28, 0xdf, 0x8c, 0xa1, 0x89, 0x0d, 0xbf, 0xe6, 0x42, 0x68, 0x41, 0x99, 0x2d, 0x0f, 0xb0, 0x54, 0xbb, 0x16 };

/// AES Inverse S-box
pub const AES_INV_SBOX: [256]u8 = .{ 0x52, 0x09, 0x6a, 0xd5, 0x30, 0x36, 0xa5, 0x38, 0xbf, 0x40, 0xa3, 0x9e, 0x81, 0xf3, 0xd7, 0xfb, 0x7c, 0xe3, 0x39, 0x82, 0x9b, 0x2f, 0xff, 0x87, 0x34, 0x8e, 0x43, 0x44, 0xc4, 0xde, 0xe9, 0xcb, 0x54, 0x7b, 0x94, 0x32, 0xa6, 0xc2, 0x23, 0x3d, 0xee, 0x4c, 0x95, 0x0b, 0x42, 0xfa, 0xc3, 0x4e, 0x08, 0x2e, 0xa1, 0x66, 0x28, 0xd9, 0x24, 0xb2, 0x76, 0x5b, 0xa2, 0x49, 0x6d, 0x8b, 0xd1, 0x25, 0x72, 0xf8, 0xf6, 0x64, 0x86, 0x68, 0x98, 0x16, 0xd4, 0xa4, 0x5c, 0xcc, 0x5d, 0x65, 0xb6, 0x92, 0x6c, 0x70, 0x48, 0x50, 0xfd, 0xed, 0xb9, 0xda, 0x5e, 0x15, 0x46, 0x57, 0xa7, 0x8d, 0x9d, 0x84, 0x90, 0xd8, 0xab, 0x00, 0x8c, 0xbc, 0xd3, 0x0a, 0xf7, 0xe4, 0x58, 0x05, 0xb8, 0xb3, 0x45, 0x06, 0xd0, 0x2c, 0x1e, 0x8f, 0xca, 0x3f, 0x0f, 0x02, 0xc1, 0xaf, 0xbd, 0x03, 0x01, 0x13, 0x8a, 0x6b, 0x3a, 0x91, 0x11, 0x41, 0x4f, 0x67, 0xdc, 0xea, 0x97, 0xf2, 0xcf, 0xce, 0xf0, 0xb4, 0xe6, 0x73, 0x96, 0xac, 0x74, 0x22, 0xe7, 0xad, 0x35, 0x85, 0xe2, 0xf9, 0x37, 0xe8, 0x1c, 0x75, 0xdf, 0x6e, 0x47, 0xf1, 0x1a, 0x71, 0x1d, 0x29, 0xc5, 0x89, 0x6f, 0xb7, 0x62, 0x0e, 0xaa, 0x18, 0xbe, 0x1b, 0xfc, 0x56, 0x3e, 0x4b, 0xc6, 0xd2, 0x79, 0x20, 0x9a, 0xdb, 0xc0, 0xfe, 0x78, 0xcd, 0x5a, 0xf4, 0x1f, 0xdd, 0xa8, 0x33, 0x88, 0x07, 0xc7, 0x31, 0xb1, 0x12, 0x10, 0x59, 0x27, 0x80, 0xec, 0x5f, 0x60, 0x51, 0x7f, 0xa9, 0x19, 0xb5, 0x4a, 0x0d, 0x2d, 0xe5, 0x7a, 0x9f, 0x93, 0xc9, 0x9c, 0xef, 0xa0, 0xe0, 0x3b, 0x4d, 0xae, 0x2a, 0xf5, 0xb0, 0xc8, 0xeb, 0xbb, 0x3c, 0x83, 0x53, 0x99, 0x61, 0x17, 0x2b, 0x04, 0x7e, 0xba, 0x77, 0xd6, 0x26, 0xe1, 0x69, 0x14, 0x63, 0x55, 0x21, 0x0c, 0x7d };

/// Table for Galois Field multiplication (GF(2^8))
pub const GF_MUL_TABLE: [256][256]u8 = blk: {
    var table: [256][256]u8 = undefined;
    @setEvalBranchQuota(1_000_000);

    for (0..256) |a| {
        for (0..256) |b| {
            var result: u8 = 0;
            var x: u8 = a;
            var y: u8 = b;
            while (y != 0) {
                result ^= (y & 1) * x;
                x = (x << 1) ^ ((x >> 7) * 0x1b);
                y >>= 1;
            }
            table[a][b] = result;
        }
    }

    break :blk table;
};

pub const has_llvm_backend = builtin.zig_backend != .stage2_llvm;

/// Basically @typeName(@TypeOf(fn)) but with the function name included;
pub inline fn fmtFn(comptime fn_name: []const u8, comptime func: std.builtin.Type.Fn) []const u8 {
    comptime var str: []const u8 = "fn " ++ fn_name ++ "(";
    inline for (func.params, 0..) |params, i| {
        const param_type = if (params.type) |T| @typeName(T) else "unknown";
        str = str ++ param_type ++ if (i == func.params.len - 1) "" else ", ";
    }
    str = str ++ ") callconv(." ++ @tagName(func.calling_convention) ++ ")" ++ if (func.return_type) |T| " " ++ @typeName(T) else "";
    return str;
}

test fmtFn {
    try std.testing.expectEqualStrings("fn fmtFn([]const u8, builtin.Type.Fn) callconv(.inline) []const u8", fmtFn("fmtFn", @typeInfo(@TypeOf(fmtFn)).@"fn"));
}

/// Helps test builtins and inline assembly
//
/// If `result_ptr` is specified as anything other than null,
/// `testIntrinsic` will not use the return value of the function
/// being tested. Instead, it will use the provided `result_ptr`.
/// This is useful for testing functions that store their result
/// directly in one of the provided arguments (e.g., in-place modifications).
pub fn testIntrinsic(
    comptime fn_name: []const u8,
    func: anytype,
    expected: anytype,
    args: anytype,
    result_ptr: anytype,
) !void {
    const arch_features = blk: {
        if (arch.is_aarch64) {
            break :blk .{
                .neon = comptime arch.aarch64.hasFeatures(&.{.neon}),
                .aes = comptime arch.aarch64.hasFeatures(&.{.aes}),
                .rdm = comptime arch.aarch64.hasFeatures(&.{.rdm}),
                .sha2 = comptime arch.aarch64.hasFeatures(&.{.sha2}),
                .sha3 = comptime arch.aarch64.hasFeatures(&.{.sha3}),
                .dotprod = comptime arch.aarch64.hasFeatures(&.{.dotprod}),
                .i8mm = comptime arch.aarch64.hasFeatures(&.{.i8mm}),
                .sm4 = comptime arch.aarch64.hasFeatures(&.{.sm4}),
                .crypto = comptime arch.aarch64.hasFeatures(&.{.crypto}),
                .sve = comptime arch.aarch64.hasFeatures(&.{.sve}),
                .sme = comptime arch.aarch64.hasFeatures(&.{.sme}),
                .fullfp16 = comptime arch.aarch64.hasFeatures(&.{.fullfp16}),
            };
        } else if (arch.is_arm) {
            break :blk .{
                .neon = comptime arch.arm.hasFeatures(&.{.neon}),
                .aes = comptime arch.arm.hasFeatures(&.{.aes}),
                .sha2 = comptime arch.arm.hasFeatures(&.{.sha2}),
                .crc = comptime arch.arm.hasFeatures(&.{.crc}),
                .dotprod = comptime arch.arm.hasFeatures(&.{.dotprod}),
                .v7 = comptime arch.arm.hasFeatures(&.{.has_v7}),
                .v8 = comptime arch.arm.hasFeatures(&.{.has_v8}),
                .i8mm = comptime arch.arm.hasFeatures(&.{.i8mm}),
            };
        } else {
            break :blk .{};
        }
    };

    const ptr_info = @typeInfo(@TypeOf(result_ptr));
    const result = blk: {
        const result = @call(.auto, func, args);
        if (ptr_info != .null) {
            assert(ptr_info == .pointer);
            break :blk result_ptr.*;
        } else {
            break :blk result;
        }
    };

    expectEqual(expected, result) catch |err| {
        printError(fn_name, func, expected, result, args, arch_features);
        return err;
    };
}

/// Prints detailed error messages when a test fails
fn printError(
    comptime fn_name: []const u8,
    func: anytype,
    expected: anytype,
    result: anytype,
    args: anytype,
    arch_features: anytype,
) void {
    const T = @TypeOf(func);
    const fmt_str =
        \\Function: {s}({any})
        \\    Expected: {any}
        \\    Actual: {any}
        \\    Arch: {s}
        \\    Features: {s}
        \\    Endianness: {s}
        \\
        \\
    ;

    std.debug.print(fmt_str, .{
        fmtFn(fn_name, @typeInfo(T).@"fn"),
        args,
        expected,
        result,
        @tagName(builtin.target.cpu.arch),
        std.fmt.comptimePrint("{any}", .{arch_features}),
        @tagName(endianness),
    });
}

/// Prints the string representation of the input `n` to the result
pub inline fn numToString(comptime n: usize) []const u8 {
    return std.fmt.comptimePrint("{d}", .{n});
}

test numToString {
    try std.testing.expectEqualStrings("5", numToString(5));
}

/// Gets the length of a vector
pub inline fn vecLen(comptime T: anytype) usize {
    const type_info = @typeInfo(T);

    comptime assert(type_info == .vector);
    return type_info.vector.len;
}

test vecLen {
    try expectEqual(8, vecLen(types.u8x8));
}

/// Joins two vectors
pub inline fn join(
    a: anytype,
    b: anytype,
) @Vector(
    vecLen(@TypeOf(a)) + vecLen(@TypeOf(b)),
    std.meta.Child(@TypeOf(a, b)),
) {
    const Child = std.meta.Child(@TypeOf(a));
    const a_len = comptime vecLen(@TypeOf(a));
    const b_len = comptime vecLen(@TypeOf(b));

    return @shuffle(
        Child,
        a,
        b,
        @as([a_len]i32, simd.iota(i32, a_len)) ++ @as([b_len]i32, ~simd.iota(i32, b_len)),
    );
}

test join {
    const a: types.i8x8 = @splat(0);
    const b: types.i8x8 = @splat(1);
    const expected: types.i8x16 = .{ 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1 };

    try expectEqual(expected, join(a, b));
}

/// Promotes the Child type of the vector `T`
pub inline fn PromoteVector(comptime T: type) type {
    const type_info = @typeInfo(T);
    const child_info = @typeInfo(type_info.vector.child);
    const NewChild = switch (child_info) {
        .int => |i| std.meta.Int(i.signedness, i.bits * 2),
        .float => |f| switch (f.bits) {
            16 => f32,
            32 => f64,
            64 => f128,
            else => @compileError("Unsupported float bits"),
        },
        else => @compileError("Unsupported vector child type"),
    };
    return @Vector(type_info.vector.len, NewChild);
}

test PromoteVector {
    try expectEqual(types.i16x8, comptime PromoteVector(types.i8x8));
}

/// Checks if the bitsize of `T` exceeds the maximum
/// bitsize for Vectors(128 on AArch/arch.arm)
///
/// TODO: Technically were targeting more than
///       just AArch/arch.arm, so if we have support
///       for larger vectors on the current cpu
///       we use that instead to avoid unnecessarily
///       splitting vectors.
pub inline fn toLarge(comptime T: type) bool {
    const Child = std.meta.Child(T);
    const bit_size = @typeInfo(Child).int.bits * @typeInfo(T).vector.len;
    return bit_size > VEC_MAX_BITSIZE;
}

test toLarge {
    try expectEqual(true, toLarge(@Vector(17, u8)));
    try expectEqual(false, toLarge(@Vector(16, u8)));
}

/// Absolute difference between arguments
///
/// TODO: If we are using AArch/arch.arm, then we can
///       dynamically build an instruction based
///       on the current cpu, that way we can
///       reduce at least some of the repetitiveness.
pub inline fn abdGeneric(a: anytype, b: anytype) @TypeOf(a, b) {
    const T = @TypeOf(a, b);
    const Child = std.meta.Child(T);
    const type_info = @typeInfo(Child);
    if (type_info == .int) {
        switch (type_info.int.signedness) {
            inline .unsigned => {
                // Since unsigned numbers cannot be negative, we subtract
                // the smaller elemant from the larger in order to prevent
                // overflows when calculating the difference, saving us the
                // trouble of casting to a larger signed type when subtracting.
                const max: T = @max(a, b);
                const min: T = @min(a, b);
                return @abs(max - min);
            },
            inline .signed => {
                const P = comptime PromoteVector(T);
                return @truncate(@as(P, @bitCast(@abs(@as(P, a) -% @as(P, b)))));
            },
        }
    } else {
        // Floats dont have modular subtraction,
        // so we just assume there wont be an
        // overflow here.
        return @abs(a - b);
    }
}

test abdGeneric {
    const i8x1 = @Vector(1, i8);
    const i8x2 = @Vector(2, i8);
    const u8x1 = @Vector(1, u8);
    const f32x1 = @Vector(1, f32);

    {
        const a: i8x1 = .{127};
        const b: i8x1 = .{-1};
        try expectEqual(i8x1{-128}, abdGeneric(a, b));
    }
    {
        const a: u8x1 = .{0};
        const b: u8x1 = .{2};
        try expectEqual(u8x1{2}, abdGeneric(a, b));
    }
    {
        const a: i8x1 = .{-128};
        const b: i8x1 = .{127};
        try expectEqual(i8x1{-1}, abdGeneric(a, b));
    }
    {
        const a: f32x1 = .{3.4028235e38};
        const b: f32x1 = .{-1};
        try expectEqual(f32x1{std.math.floatMax(f32)}, abdGeneric(a, b));
    }
    {
        const a: i8x1 = .{127};
        const b: i8x1 = .{-3};
        try expectEqual(i8x1{-126}, abdGeneric(a, b));
    }
    {
        const a: i8x2 = .{ -65, -75 };
        const b: i8x2 = .{ 65, 75 };
        try expectEqual(i8x2{ -126, -106 }, abdGeneric(a, b));
    }
}
