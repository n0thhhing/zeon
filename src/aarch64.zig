const std = @import("std");
const builtin = @import("builtin");
const arch = builtin.target.cpu.arch;
const features = builtin.cpu.features;
const neon = @import("./zig-neon.zig");

pub const is_aarch64 = arch == .aarch64 or arch == .aarch64_be;

/// Checks if the current CPU is aarch64 and has the input features
pub fn hasFeatures(comptime aarch64_features: []const std.Target.aarch64.Feature) bool {
    if (!@inComptime()) @panic("Please move this into comptime, orelse it will result in an unnecessary branch");
    inline for (aarch64_features) |f| {
        const has_feature = is_aarch64 and std.Target.aarch64.featureSetHas(features, f);
        if (!has_feature) return false;
    }
    return true;
}

/// Get the vector register suffix for a given vector type
pub inline fn vectorSuffix(comptime T: type) []const u8 {
    return switch (T) {
        // 128-bit Quadword vectors
        neon.i8x16, neon.u8x16 => ".16b",
        neon.i16x8, neon.u16x8, neon.f16x8 => ".8h",
        neon.i32x4, neon.u32x4, neon.f32x4 => ".4s",
        neon.i64x2, neon.u64x2, neon.f64x2 => ".2d",
        // 64-bit Doubleword vectors
        neon.i8x8, neon.u8x8 => ".8b",
        neon.i16x4, neon.u16x4, neon.f16x4 => ".4h",
        neon.i32x2, neon.u32x2, neon.f32x2 => ".2s",
        neon.i64x1, neon.u64x1, neon.f64x1 => ".1d",
        else => @compileError("Unsupported vector type for NEON register suffix"),
    };
}

/// Performs a Endianness swap of the provided `vec`
pub inline fn byteSwap(vec: anytype) @TypeOf(vec) {
    const T = comptime @TypeOf(vec);
    comptime {
        switch (T) {
            neon.i8x16, neon.u8x16, neon.i16x8, neon.u16x8, neon.f16x8, neon.i32x4, neon.u32x4, neon.f32x4, neon.i64x2, neon.u64x2, neon.f64x2, neon.i8x8, neon.u8x8, neon.i16x4, neon.u16x4, neon.f16x4, neon.i32x2, neon.u32x2, neon.f32x2, neon.i64x1, neon.u64x1, neon.f64x1 => {},
            else => @compileError("Unsupported element type for byteswap."),
        }
    }

    const bits = comptime switch (@typeInfo(std.meta.Child(T))) {
        .Int => |i| i.bits,
        .Float => |f| f.bits,
        else => unreachable,
    };
    comptime if (bits == 8) return vec;

    const suffix = comptime switch (bits * @typeInfo(T).Vector.len) {
        64 => ".8b",
        128 => ".16b",
        else => unreachable,
    };

    return asm ("rev" ++ std.fmt.comptimePrint("{d}", .{bits}) ++ " %[result]" ++ suffix ++ ", %[input]" ++ suffix
        : [result] "=w" (-> T),
        : [input] "w" (vec),
    );
}

test {
    std.testing.refAllDecls(@This());
}