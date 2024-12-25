const std = @import("std");
const builtin = @import("builtin");
const simd = std.simd;
const arch = builtin.target.cpu.arch;
const assert = std.debug.assert;
const expectEqual = std.testing.expectEqual;
const endianness = arch.endian();

/// Max bitsize for vectors on Arm/AArch64
///
/// TODO:
///       AArch64 isnt always limited to 128
///       bits if we have SVE. SVE gives us
///       a handy instruction called `cntb`
///       that we can use to determine this
///       variable, but unfortunately, that
///       would mean we have to move this
///       outside of the comptime scope.
const VEC_MAX_BITSIZE: u32 = 128;

/// AES S-Box
const AES_SBOX: [256]u8 = .{ 0x63, 0x7c, 0x77, 0x7b, 0xf2, 0x6b, 0x6f, 0xc5, 0x30, 0x01, 0x67, 0x2b, 0xfe, 0xd7, 0xab, 0x76, 0xca, 0x82, 0xc9, 0x7d, 0xfa, 0x59, 0x47, 0xf0, 0xad, 0xd4, 0xa2, 0xaf, 0x9c, 0xa4, 0x72, 0xc0, 0xb7, 0xfd, 0x93, 0x26, 0x36, 0x3f, 0xf7, 0xcc, 0x34, 0xa5, 0xe5, 0xf1, 0x71, 0xd8, 0x31, 0x15, 0x04, 0xc7, 0x23, 0xc3, 0x18, 0x96, 0x05, 0x9a, 0x07, 0x12, 0x80, 0xe2, 0xeb, 0x27, 0xb2, 0x75, 0x09, 0x83, 0x2c, 0x1a, 0x1b, 0x6e, 0x5a, 0xa0, 0x52, 0x3b, 0xd6, 0xb3, 0x29, 0xe3, 0x2f, 0x84, 0x53, 0xd1, 0x00, 0xed, 0x20, 0xfc, 0xb1, 0x5b, 0x6a, 0xcb, 0xbe, 0x39, 0x4a, 0x4c, 0x58, 0xcf, 0xd0, 0xef, 0xaa, 0xfb, 0x43, 0x4d, 0x33, 0x85, 0x45, 0xf9, 0x02, 0x7f, 0x50, 0x3c, 0x9f, 0xa8, 0x51, 0xa3, 0x40, 0x8f, 0x92, 0x9d, 0x38, 0xf5, 0xbc, 0xb6, 0xda, 0x21, 0x10, 0xff, 0xf3, 0xd2, 0xcd, 0x0c, 0x13, 0xec, 0x5f, 0x97, 0x44, 0x17, 0xc4, 0xa7, 0x7e, 0x3d, 0x64, 0x5d, 0x19, 0x73, 0x60, 0x81, 0x4f, 0xdc, 0x22, 0x2a, 0x90, 0x88, 0x46, 0xee, 0xb8, 0x14, 0xde, 0x5e, 0x0b, 0xdb, 0xe0, 0x32, 0x3a, 0x0a, 0x49, 0x06, 0x24, 0x5c, 0xc2, 0xd3, 0xac, 0x62, 0x91, 0x95, 0xe4, 0x79, 0xe7, 0xc8, 0x37, 0x6d, 0x8d, 0xd5, 0x4e, 0xa9, 0x6c, 0x56, 0xf4, 0xea, 0x65, 0x7a, 0xae, 0x08, 0xba, 0x78, 0x25, 0x2e, 0x1c, 0xa6, 0xb4, 0xc6, 0xe8, 0xdd, 0x74, 0x1f, 0x4b, 0xbd, 0x8b, 0x8a, 0x70, 0x3e, 0xb5, 0x66, 0x48, 0x03, 0xf6, 0x0e, 0x61, 0x35, 0x57, 0xb9, 0x86, 0xc1, 0x1d, 0x9e, 0xe1, 0xf8, 0x98, 0x11, 0x69, 0xd9, 0x8e, 0x94, 0x9b, 0x1e, 0x87, 0xe9, 0xce, 0x55, 0x28, 0xdf, 0x8c, 0xa1, 0x89, 0x0d, 0xbf, 0xe6, 0x42, 0x68, 0x41, 0x99, 0x2d, 0x0f, 0xb0, 0x54, 0xbb, 0x16 };

/// AES Inverse S-box
const AES_INV_SBOX: [256]u8 = .{ 0x52, 0x09, 0x6a, 0xd5, 0x30, 0x36, 0xa5, 0x38, 0xbf, 0x40, 0xa3, 0x9e, 0x81, 0xf3, 0xd7, 0xfb, 0x7c, 0xe3, 0x39, 0x82, 0x9b, 0x2f, 0xff, 0x87, 0x34, 0x8e, 0x43, 0x44, 0xc4, 0xde, 0xe9, 0xcb, 0x54, 0x7b, 0x94, 0x32, 0xa6, 0xc2, 0x23, 0x3d, 0xee, 0x4c, 0x95, 0x0b, 0x42, 0xfa, 0xc3, 0x4e, 0x08, 0x2e, 0xa1, 0x66, 0x28, 0xd9, 0x24, 0xb2, 0x76, 0x5b, 0xa2, 0x49, 0x6d, 0x8b, 0xd1, 0x25, 0x72, 0xf8, 0xf6, 0x64, 0x86, 0x68, 0x98, 0x16, 0xd4, 0xa4, 0x5c, 0xcc, 0x5d, 0x65, 0xb6, 0x92, 0x6c, 0x70, 0x48, 0x50, 0xfd, 0xed, 0xb9, 0xda, 0x5e, 0x15, 0x46, 0x57, 0xa7, 0x8d, 0x9d, 0x84, 0x90, 0xd8, 0xab, 0x00, 0x8c, 0xbc, 0xd3, 0x0a, 0xf7, 0xe4, 0x58, 0x05, 0xb8, 0xb3, 0x45, 0x06, 0xd0, 0x2c, 0x1e, 0x8f, 0xca, 0x3f, 0x0f, 0x02, 0xc1, 0xaf, 0xbd, 0x03, 0x01, 0x13, 0x8a, 0x6b, 0x3a, 0x91, 0x11, 0x41, 0x4f, 0x67, 0xdc, 0xea, 0x97, 0xf2, 0xcf, 0xce, 0xf0, 0xb4, 0xe6, 0x73, 0x96, 0xac, 0x74, 0x22, 0xe7, 0xad, 0x35, 0x85, 0xe2, 0xf9, 0x37, 0xe8, 0x1c, 0x75, 0xdf, 0x6e, 0x47, 0xf1, 0x1a, 0x71, 0x1d, 0x29, 0xc5, 0x89, 0x6f, 0xb7, 0x62, 0x0e, 0xaa, 0x18, 0xbe, 0x1b, 0xfc, 0x56, 0x3e, 0x4b, 0xc6, 0xd2, 0x79, 0x20, 0x9a, 0xdb, 0xc0, 0xfe, 0x78, 0xcd, 0x5a, 0xf4, 0x1f, 0xdd, 0xa8, 0x33, 0x88, 0x07, 0xc7, 0x31, 0xb1, 0x12, 0x10, 0x59, 0x27, 0x80, 0xec, 0x5f, 0x60, 0x51, 0x7f, 0xa9, 0x19, 0xb5, 0x4a, 0x0d, 0x2d, 0xe5, 0x7a, 0x9f, 0x93, 0xc9, 0x9c, 0xef, 0xa0, 0xe0, 0x3b, 0x4d, 0xae, 0x2a, 0xf5, 0xb0, 0xc8, 0xeb, 0xbb, 0x3c, 0x83, 0x53, 0x99, 0x61, 0x17, 0x2b, 0x04, 0x7e, 0xba, 0x77, 0xd6, 0x26, 0xe1, 0x69, 0x14, 0x63, 0x55, 0x21, 0x0c, 0x7d };

/// Table for Galois Field multiplication (GF(2^8))
const GF_MUL_TABLE: [256][256]u8 = blk: {
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

/// Specifies if we should use inline assembly. Note that this will take
/// priority over use_builtins when it can. Also, if your current target
/// isnt AArch/Arm, inline assembly wont be used even if this is enabled.
pub var use_asm = true;

/// Specifies if we should use llvm builtins. If your current target
/// isnt AArch/Arm, builtins wont be used even if this is enabled.
pub var use_builtins = blk: {
    if (builtin.zig_backend != .stage2_llvm)
        break :blk false
    else
        break :blk true;
};

const is_arm = arch == .arm or arch == .armeb;
const is_aarch64 = arch == .aarch64 or arch == .aarch64_be;

const Arm = struct {
    pub const has_neon = is_arm and std.Target.arm.featureSetHas(builtin.cpu.features, .neon);
    pub const has_aes = is_arm and std.Target.arm.featureSetHas(builtin.cpu.features, .aes);
    pub const has_sha2 = is_arm and std.Target.arm.featureSetHas(builtin.cpu.features, .sha2);
    pub const has_crc = is_arm and std.Target.arm.featureSetHas(builtin.cpu.features, .crc);
    pub const has_dotprod = is_arm and std.Target.arm.featureSetHas(builtin.cpu.features, .dotprod);
    pub const has_v7 = is_arm and std.Target.arm.featureSetHas(builtin.cpu.features, .has_v7);
    pub const has_v8 = is_arm and std.Target.arm.featureSetHas(builtin.cpu.features, .has_v8);
    pub const has_i8mm = is_arm and std.Target.arm.featureSetHas(builtin.cpu.features, .i8mm);
};

const AArch64 = struct {
    pub const has_neon = is_aarch64 and std.Target.aarch64.featureSetHas(builtin.cpu.features, .neon);
    pub const has_aes = is_aarch64 and std.Target.aarch64.featureSetHas(builtin.cpu.features, .aes);
    pub const has_rdm = is_aarch64 and std.Target.aarch64.featureSetHas(builtin.cpu.features, .rdm);
    pub const has_sha2 = is_aarch64 and std.Target.aarch64.featureSetHas(builtin.cpu.features, .sha2);
    pub const has_sha3 = is_aarch64 and std.Target.aarch64.featureSetHas(builtin.cpu.features, .sha3);
    pub const has_dotprod = is_aarch64 and std.Target.aarch64.featureSetHas(builtin.cpu.features, .dotprod);
    pub const has_i8mm = is_aarch64 and std.Target.aarch64.featureSetHas(builtin.cpu.features, .i8mm);
    pub const has_sm4 = is_aarch64 and std.Target.aarch64.featureSetHas(builtin.cpu.features, .sm4);
    pub const has_crypto = is_aarch64 and std.Target.aarch64.featureSetHas(builtin.cpu.features, .crypto);
    pub const has_sve = is_aarch64 and std.Target.aarch64.featureSetHas(builtin.cpu.features, .sve);
};

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

pub const i8x8x2 = struct { i8x8, i8x8 };
pub const i8x16x2 = struct { i8x16, i8x16 };
pub const i16x4x2 = struct { i16x4, i16x4 };
pub const i16x8x2 = struct { i16x8, i16x8 };
pub const i32x2x2 = struct { i32x2, i32x2 };
pub const i32x4x2 = struct { i32x4, i32x4 };
pub const i64x1x2 = struct { i64x1, i64x1 };
pub const i64x2x2 = struct { i64x2, i64x2 };

pub const u8x8x2 = struct { u8x8, u8x8 };
pub const u8x16x2 = struct { u8x16, u8x16 };
pub const u16x4x2 = struct { u16x4, u16x4 };
pub const u16x8x2 = struct { u16x8, u16x8 };
pub const u32x2x2 = struct { u32x2, u32x2 };
pub const u32x4x2 = struct { u32x4, u32x4 };
pub const u64x1x2 = struct { u64x1, u64x1 };
pub const u64x2x2 = struct { u64x2, u64x2 };

pub const f16x4x2 = struct { f16x4, f16x4 };
pub const f16x8x2 = struct { f16x8, f16x8 };
pub const f32x2x2 = struct { f32x2, f32x2 };
pub const f32x4x2 = struct { f32x4, f32x4 };
pub const f64x1x2 = struct { f64x1, f64x1 };
pub const f64x2x2 = struct { f64x2, f64x2 };

pub const p8x8x2 = struct { p8x8, p8x8 };
pub const p8x16x2 = struct { p8x16, p8x16 };
pub const p16x4x2 = struct { p16x4, p16x4 };
pub const p16x8x2 = struct { p16x8, p16x8 };
pub const p64x1x2 = struct { p64x1, p64x1 };
pub const p64x2x2 = struct { p64x2, p64x2 };

pub const i8x8x3 = struct { i8x8, i8x8, i8x8 };
pub const i8x16x3 = struct { i8x16, i8x16, i8x16 };
pub const i16x4x3 = struct { i16x4, i16x4, i16x4 };
pub const i16x8x3 = struct { i16x8, i16x8, i16x8 };
pub const i32x2x3 = struct { i32x2, i32x2, i32x2 };
pub const i32x4x3 = struct { i32x4, i32x4, i32x4 };
pub const i64x1x3 = struct { i64x1, i64x1, i64x1 };
pub const i64x2x3 = struct { i64x2, i64x2, i64x2 };

pub const u8x8x3 = struct { u8x8, u8x8, u8x8 };
pub const u8x16x3 = struct { u8x16, u8x16, u8x16 };
pub const u16x4x3 = struct { u16x4, u16x4, u16x4 };
pub const u16x8x3 = struct { u16x8, u16x8, u16x8 };
pub const u32x2x3 = struct { u32x2, u32x2, u32x2 };
pub const u32x4x3 = struct { u32x4, u32x4, u32x4 };
pub const u64x1x3 = struct { u64x1, u64x1, u64x1 };
pub const u64x2x3 = struct { u64x2, u64x2, u64x2 };

pub const f16x4x3 = struct { f16x4, f16x4, f16x4 };
pub const f16x8x3 = struct { f16x8, f16x8, f16x8 };
pub const f32x2x3 = struct { f32x2, f32x2, f32x2 };
pub const f32x4x3 = struct { f32x4, f32x4, f32x4 };
pub const f64x1x3 = struct { f64x1, f64x1, f64x1 };
pub const f64x2x3 = struct { f64x2, f64x2, f64x2 };

pub const p8x8x3 = struct { p8x8, p8x8, p8x8 };
pub const p8x16x3 = struct { p8x16, p8x16, p8x16 };
pub const p16x4x3 = struct { p16x4, p16x4, p16x4 };
pub const p16x8x3 = struct { p16x8, p16x8, p16x8 };
pub const p64x1x3 = struct { p64x1, p64x1, p64x1 };
pub const p64x2x3 = struct { p64x2, p64x2, p64x2 };

pub const i8x8x4 = struct { i8x8, i8x8, i8x8, i8x8 };
pub const i8x16x4 = struct { i8x16, i8x16, i8x16, i8x16 };
pub const i16x4x4 = struct { i16x4, i16x4, i16x4, i16x4 };
pub const i16x8x4 = struct { i16x8, i16x8, i16x8, i16x8 };
pub const i32x2x4 = struct { i32x2, i32x2, i32x2, i32x2 };
pub const i32x4x4 = struct { i32x4, i32x4, i32x4, i32x4 };
pub const i64x1x4 = struct { i64x1, i64x1, i64x1, i64x1 };
pub const i64x2x4 = struct { i64x2, i64x2, i64x2, i64x2 };

pub const u8x8x4 = struct { u8x8, u8x8, u8x8, u8x8 };
pub const u8x16x4 = struct { u8x16, u8x16, u8x16, u8x16 };
pub const u16x4x4 = struct { u16x4, u16x4, u16x4, u16x4 };
pub const u16x8x4 = struct { u16x8, u16x8, u16x8, u16x8 };
pub const u32x2x4 = struct { u32x2, u32x2, u32x2, u32x2 };
pub const u32x4x4 = struct { u32x4, u32x4, u32x4, u32x4 };
pub const u64x1x4 = struct { u64x1, u64x1, u64x1, u64x1 };
pub const u64x2x4 = struct { u64x2, u64x2, u64x2, u64x2 };

pub const f16x4x4 = struct { f16x4, f16x4, f16x4, f16x4 };
pub const f16x8x4 = struct { f16x8, f16x8, f16x8, f16x8 };
pub const f32x2x4 = struct { f32x2, f32x2, f32x2, f32x2 };
pub const f32x4x4 = struct { f32x4, f32x4, f32x4, f32x4 };
pub const f64x1x4 = struct { f64x1, f64x1, f64x1, f64x1 };
pub const f64x2x4 = struct { f64x2, f64x2, f64x2, f64x2 };

pub const p8x8x4 = struct { p8x8, p8x8, p8x8, p8x8 };
pub const p8x16x4 = struct { p8x16, p8x16, p8x16, p8x16 };
pub const p16x4x4 = struct { p16x4, p16x4, p16x4, p16x4 };
pub const p16x8x4 = struct { p16x8, p16x8, p16x8, p16x8 };
pub const p64x1x4 = struct { p64x1, p64x1, p64x1, p64x1 };
pub const p64x2x4 = struct { p64x2, p64x2, p64x2, p64x2 };

/// Helps test builtins and inline assembly
fn testIntrinsic(func: anytype, expected: anytype, args: anytype) !void {
    if (is_aarch64 or is_arm) {
        inline for (.{ .{ true, false }, .{ false, true }, .{ false, false } }) |opt| {
            use_asm = opt[0];
            use_builtins = opt[1];
            const result = @call(.auto, func, args);
            try expectEqual(expected, result);
        }
        use_asm = true;
        use_builtins = true;
    } else {
        const result = @call(.auto, func, args);
        try expectEqual(expected, result);
    }
}

/// Gets the length of a vector
inline fn vecLen(v: anytype) usize {
    const T = @TypeOf(v);
    const type_info = @typeInfo(T);

    comptime assert(type_info == .Vector);
    return type_info.Vector.len;
}

/// Joins two vectors. This is a just calling
/// std.join, but with force inline
inline fn join(
    a: anytype,
    b: anytype,
) @Vector(
    vecLen(a) + vecLen(b),
    std.meta.Child(@TypeOf(a, b)),
) {
    const Child = std.meta.Child(@TypeOf(a));
    const a_len = vecLen(a);
    const b_len = vecLen(a);

    return @shuffle(
        Child,
        a,
        b,
        @as([a_len]i32, simd.iota(i32, a_len)) ++ @as([b_len]i32, ~simd.iota(i32, b_len)),
    );
}

/// Promotes the Child type of the vector `T`
/// e.g. PromoteVector(i8x8) -> i16x8
inline fn PromoteVector(comptime T: type) type {
    var type_info = @typeInfo(T);

    comptime assert(type_info == .Vector);
    var child_info = @typeInfo(std.meta.Child(T));

    child_info.Int.bits *= 2;
    type_info.Vector.child = @Type(child_info);
    return @Type(type_info);
}

/// Checks if the bitsize of `T` exceeds the maximum
/// bitsize for Vectors(128 on AArch/Arm)
///
/// TODO: Technically were targeting more than
///       just AArch/Arm, so if we have support
///       for larger vectors on the current cpu
///       we use that instead to avoid unnecessarily
///       splitting vectors.
fn toLarge(comptime T: type) bool {
    const Child = std.meta.Child(T);
    const bit_size = @typeInfo(Child).Int.bits * @typeInfo(T).Vector.len;
    return bit_size > VEC_MAX_BITSIZE;
}

/// Absolute difference between arguments
///
/// TODO:
///       If we are using AArch/Arm, then we can
///       dynamically build an instruction based
///       on the current cpu, that way we can
///       reduce at least some of the repetitiveness.
inline fn abd(a: anytype, b: anytype) @TypeOf(a, b) {
    const T = @TypeOf(a, b);
    const Child = std.meta.Child(T);
    const type_info = @typeInfo(Child);
    if (type_info == .Int) {
        switch (type_info.Int.signedness) {
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
                comptime var P = PromoteVector(T);
                // If the promoted vectors bitsize exceeds `VEC_MAX_BITSIZE`,
                // then we need to split `a` and `b` in half to ensure it
                // doesnt fall back to whatever zig does if we dont support
                // the 128 bit max. Note that since this function is inline,
                // zig probably wont have the chance to optimize it when we
                // do exceed the max vector size, so it'd be more favorable
                // if we optimize it ourselves.
                if (comptime toLarge(P)) {
                    const vector_half = @typeInfo(T).Vector.len / 2;
                    const V = @Vector(vector_half, Child);
                    P = comptime PromoteVector(V);

                    const a_hi = @shuffle(
                        Child,
                        a,
                        undefined,
                        simd.iota(Child, vector_half) + @as(V, @splat(vector_half)),
                    );
                    const a_lo = @shuffle(
                        Child,
                        a,
                        undefined,
                        simd.iota(Child, vector_half),
                    );
                    const b_hi = @shuffle(
                        Child,
                        b,
                        undefined,
                        simd.iota(Child, vector_half) + @as(V, @splat(vector_half)),
                    );
                    const b_lo = @shuffle(
                        Child,
                        b,
                        undefined,
                        simd.iota(Child, vector_half),
                    );

                    const hi_abd: V = @truncate(@as(P, @bitCast(@abs(@as(P, a_hi) -% @as(P, b_hi)))));
                    const low_abd: V = @truncate(@as(P, @bitCast(@abs(@as(P, a_lo) -% @as(P, b_lo)))));
                    return join(low_abd, hi_abd);
                } else {
                    return @truncate(@as(P, @bitCast(@abs(@as(P, a) -% @as(P, b)))));
                }
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

/// Get high elements of a i8x16 vector
pub inline fn vget_high_s8(vec: i8x16) i8x8 {
    return @shuffle(
        i8,
        vec,
        undefined,
        i8x8{ 8, 9, 10, 11, 12, 13, 14, 15 },
    );
}

test vget_high_s8 {
    const v: i8x16 = .{ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 };
    const expected: i8x8 = .{ 8, 9, 10, 11, 12, 13, 14, 15 };

    try expectEqual(expected, vget_high_s8(v));
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
        p8,
        vec,
        undefined,
        p8x8{ 8, 9, 10, 11, 12, 13, 14, 15 },
    );
}

/// Get high elements of a u16x8 vector
pub inline fn vget_high_p16(vec: p16x8) p16x4 {
    return @shuffle(
        p16,
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
    if (use_asm and AArch64.has_neon) {
        switch (endianness) {
            inline .little => {
                return asm volatile ("smull %[ret].8h, %[a].8b, %[b].8b"
                    : [ret] "=w" (-> i16x8),
                    : [a] "w" (a),
                      [b] "w" (b),
                );
            },
            inline .big => {
                return @byteSwap(
                    @shuffle(
                        i16,
                        asm volatile ("smull %[ret].8h, %[a].8b, %[b].8b"
                            : [ret] "=w" (-> i16x8),
                            : [a] "w" (a),
                              [b] "w" (b),
                        ),
                        undefined,
                        i16x8{ 7, 6, 5, 4, 3, 2, 1, 0 },
                    ),
                );
            },
        }
    } else if (use_asm and Arm.has_neon) {
        return asm volatile ("vmull.s8 %[ret], %[a], %[b]"
            : [ret] "=w" (-> i16x8),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else if (use_builtins and AArch64.has_neon) {
        return struct {
            extern fn @"llvm.aarch64.neon.smull.v8i16"(i8x8, i8x8) i16x8;
        }.@"llvm.aarch64.neon.smull.v8i16"(a, b);
    } else if (use_builtins and Arm.has_neon) {
        return struct {
            extern fn @"llvm.arm.neon.vmulls.v8i16"(i8x8, i8x8) i16x8;
        }.@"llvm.arm.neon.vmulls.v8i16"(a, b);
    } else {
        return @as(i16x8, a) * @as(i16x8, b);
    }
}

test vmull_s8 {
    const a: i8x8 = .{ 0, 0, 0, 0, 0, 0, 0, 127 };
    const b: i8x8 = @splat(2);
    try testIntrinsic(vmull_s8, i16x8{ 0, 0, 0, 0, 0, 0, 0, 254 }, .{ a, b });
}

/// Signed multiply long
pub inline fn vmull_s16(a: i16x4, b: i16x4) i32x4 {
    if (use_asm and AArch64.has_neon) {
        switch (endianness) {
            inline .little => {
                return asm volatile ("smull %[ret].4s, %[a].4h, v1.4h"
                    : [ret] "=w" (-> i32x4),
                    : [a] "w" (a),
                      [b] "w" (b),
                );
            },
            inline .big => {
                return @byteSwap(
                    @shuffle(
                        i32,
                        asm volatile ("smull %[ret].4s, %[a].4h, %[b].4h"
                            : [ret] "=w" (-> i32x4),
                            : [a] "w" (a),
                              [b] "w" (b),
                        ),
                        undefined,
                        i32x4{ 3, 2, 1, 0 },
                    ),
                );
            },
        }
    } else if (use_asm and Arm.has_neon) {
        return asm volatile ("vmull.s16 %[ret], %[a], %[b]"
            : [ret] "=w" (-> i32x4),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else if (use_builtins and AArch64.has_neon) {
        return struct {
            extern fn @"llvm.aarch64.neon.smull.v4i32"(i16x4, i16x4) i32x4;
        }.@"llvm.aarch64.neon.smull.v4i32"(a, b);
    } else if (use_builtins and Arm.has_neon) {
        return struct {
            extern fn @"llvm.arm.neon.vmulls.v4i32"(i16x4, i16x4) i32x4;
        }.@"llvm.arm.neon.vmulls.v4i32"(a, b);
    } else {
        return @as(i32x4, a) * @as(i32x4, b);
    }
}

test vmull_s16 {
    const a: i16x4 = .{ 0, -1, -2, -3 };
    const b: i16x4 = @splat(5);

    try testIntrinsic(vmull_s16, i32x4{ 0, -1 * 5, -2 * 5, -3 * 5 }, .{ a, b });
}

/// Signed multiply long
pub inline fn vmull_s32(a: i32x2, b: i32x2) i64x2 {
    if (use_asm and AArch64.has_neon) {
        switch (endianness) {
            .little => {
                return asm volatile ("smull %[ret].2d, %[a].2s, %[b].2s"
                    : [ret] "=w" (-> i64x2),
                    : [a] "w" (a),
                      [b] "w" (b),
                );
            },
            inline .big => {
                return @byteSwap(
                    @shuffle(
                        i64,
                        asm volatile ("smull %[ret].2d, %[a].2s, %[b].2s"
                            : [ret] "=w" (-> i64x2),
                            : [a] "w" (a),
                              [b] "w" (b),
                        ),
                        undefined,
                        i64x2{ 1, 0 },
                    ),
                );
            },
        }
    } else if (use_asm and Arm.has_neon) {
        return asm volatile ("vmull.s32 %[ret], %[a], %[b]"
            : [ret] "=w" (-> i64x2),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else if (use_builtins and AArch64.has_neon) {
        return struct {
            extern fn @"llvm.aarch64.neon.smull.v2i64"(i32x2, i32x2) i64x2;
        }.@"llvm.aarch64.neon.smull.v2i64"(a, b);
    } else if (use_builtins and Arm.has_neon) {
        return struct {
            extern fn @"llvm.arm.neon.vmulls.v2i64"(i32x2, i32x2) i64x2;
        }.@"llvm.arm.neon.vmulls.v2i64"(a, b);
    } else {
        return @as(i64x2, a) * @as(i64x2, b);
    }
}

test vmull_s32 {
    const a: i32x2 = .{ 0, -1 };
    const b: i32x2 = @splat(5);

    try testIntrinsic(vmull_s32, i32x2{ 0, -5 }, .{ a, b });
}

/// Unsigned multiply long
pub inline fn vmull_u8(a: u8x8, b: u8x8) u16x8 {
    if (use_asm and AArch64.has_neon) {
        switch (endianness) {
            inline .little => {
                return asm volatile ("umull %[ret].8h, %[a].8b, %[b].8b"
                    : [ret] "=w" (-> u16x8),
                    : [a] "w" (a),
                      [b] "w" (b),
                );
            },
            inline .big => {
                return @byteSwap(
                    @shuffle(
                        u16,
                        asm volatile ("umull %[ret].8h, %[a].8b, %[b].8b"
                            : [ret] "=w" (-> u16x8),
                            : [a] "w" (a),
                              [b] "w" (b),
                        ),
                        undefined,
                        u16x8{ 7, 6, 5, 4, 3, 2, 1, 0 },
                    ),
                );
            },
        }
    } else if (use_asm and Arm.has_neon) {
        return asm volatile ("vmull.u8 %[ret], %[a], %[b]"
            : [ret] "=w" (-> u16x8),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else if (use_builtins and AArch64.has_neon) {
        return struct {
            extern fn @"llvm.aarch64.neon.umull.v8i16"(u8x8, u8x8) u16x8;
        }.@"llvm.aarch64.neon.umull.v8i16"(a, b);
    } else if (use_builtins and Arm.has_neon) {
        return struct {
            extern fn @"llvm.arm.neon.vmullu.v8i16"(u8x8, u8x8) u16x8;
        }.@"llvm.arm.neon.vmullu.v8i16"(a, b);
    } else {
        return @as(u16x8, a) * @as(u16x8, b);
    }
}

test vmull_u8 {
    const a: u8x8 = .{ 0, 1, 2, 3, 4, 5, 6, 7 };
    const b: u8x8 = @splat(5);

    try testIntrinsic(vmull_u8, u16x8{ 0, 1 * 5, 2 * 5, 3 * 5, 4 * 5, 5 * 5, 6 * 5, 7 * 5 }, .{ a, b });
}

/// Unsigned multiply long
pub inline fn vmull_u16(a: u16x4, b: u16x4) u32x4 {
    if (use_asm and AArch64.has_neon) {
        switch (endianness) {
            inline .little => {
                return asm volatile ("umull %[ret].4s, %[a].4h, v1.4h"
                    : [ret] "=w" (-> u32x4),
                    : [a] "w" (a),
                      [b] "w" (b),
                );
            },
            inline .big => {
                return @byteSwap(
                    @shuffle(
                        u32,
                        asm volatile ("umull %[ret].4s, %[a].4h, %[b].4h"
                            : [ret] "=w" (-> u32x4),
                            : [a] "w" (a),
                              [b] "w" (b),
                        ),
                        undefined,
                        u32x4{ 3, 2, 1, 0 },
                    ),
                );
            },
        }
    } else if (use_asm and Arm.has_neon) {
        return asm volatile ("vmull.u16 %[ret], %[a], %[b]"
            : [ret] "=w" (-> u32x4),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else if (use_builtins and AArch64.has_neon) {
        return struct {
            extern fn @"llvm.aarch64.neon.umull.v4i32"(u16x4, u16x4) u32x4;
        }.@"llvm.aarch64.neon.umull.v4i32"(a, b);
    } else if (use_builtins and Arm.has_neon) {
        return struct {
            extern fn @"llvm.arm.neon.vmullu.v4i32"(u16x4, u16x4) u32x4;
        }.@"llvm.arm.neon.vmullu.v4i32"(a, b);
    } else {
        return @as(u32x4, a) * @as(u32x4, b);
    }
}

test vmull_u16 {
    const a: u16x4 = .{ 0, 1, 2, 3 };
    const b: u16x4 = @splat(5);

    try testIntrinsic(vmull_u16, u32x4{ 0, 1 * 5, 2 * 5, 3 * 5 }, .{ a, b });
}

/// Unsigned multiply long
pub inline fn vmull_u32(a: u32x2, b: u32x2) u64x2 {
    if (use_asm and AArch64.has_neon) {
        switch (endianness) {
            .little => {
                return asm volatile ("umull %[ret].2d, %[a].2s, %[b].2s"
                    : [ret] "=w" (-> u64x2),
                    : [a] "w" (a),
                      [b] "w" (b),
                );
            },
            inline .big => {
                return @byteSwap(
                    @shuffle(
                        u64,
                        asm volatile ("umull %[ret].2d, %[a].2s, %[b].2s"
                            : [ret] "=w" (-> u64x2),
                            : [a] "w" (a),
                              [b] "w" (b),
                        ),
                        undefined,
                        u64x2{ 1, 0 },
                    ),
                );
            },
        }
    } else if (use_asm and Arm.has_neon) {
        return asm volatile ("vmull.u32 %[ret], %[a], %[b]"
            : [ret] "=w" (-> u64x2),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else if (use_builtins and AArch64.has_neon) {
        return struct {
            extern fn @"llvm.aarch64.neon.umull.v2i64"(u32x2, u32x2) u64x2;
        }.@"llvm.aarch64.neon.umull.v2i64"(a, b);
    } else if (use_builtins and Arm.has_neon) {
        return struct {
            extern fn @"llvm.arm.neon.vmullu.v2i64"(u32x2, u32x2) u64x2;
        }.@"llvm.arm.neon.vmullu.v2i64"(a, b);
    } else {
        return @as(u64x2, a) * @as(u64x2, b);
    }
}

test vmull_u32 {
    const a: u32x2 = .{ 0, 1 };
    const b: u32x2 = @splat(5);

    try testIntrinsic(vmull_u32, u64x2{ 0, 1 * 5 }, .{ a, b });
}

/// Signed multiply long
pub inline fn vmull_high_s8(a: i8x16, b: i8x16) i16x8 {
    return vmull_s8(vget_high_s8(a), vget_high_s8(b));
}

test vmull_high_s8 {
    const a: i8x16 = .{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 127 };
    const b: i8x16 = @splat(2);

    try testIntrinsic(vmull_high_s8, i16x8{ 0, 0, 0, 0, 0, 0, 0, 254 }, .{ a, b });
}

/// Signed multiply long
pub inline fn vmull_high_s16(a: i16x8, b: i16x8) i32x4 {
    return vmull_s16(vget_high_s16(a), vget_high_s16(b));
}

test vmull_high_s16 {
    const a: i16x8 = .{ 0, 0, 0, 0, 0, -1, -2, -3 };
    const b: i16x8 = @splat(5);

    try testIntrinsic(vmull_high_s16, i32x4{ 0, -1 * 5, -2 * 5, -3 * 5 }, .{ a, b });
}

/// Signed multiply long
pub inline fn vmull_high_s32(a: i32x4, b: i32x4) i64x2 {
    return vmull_s32(vget_high_s32(a), vget_high_s32(b));
}

test vmull_high_s32 {
    const a: i32x4 = .{ 0, -1, -2, -3 };
    const b: i32x4 = @splat(5);

    try testIntrinsic(vmull_high_s32, i64x2{ -2 * 5, -3 * 5 }, .{ a, b });
}

/// Unsigned multiply long
pub inline fn vmull_high_u8(a: u8x16, b: u8x16) u16x8 {
    return vmull_u8(vget_high_u8(a), vget_high_u8(b));
}

test vmull_high_u8 {
    const a: u8x16 = .{ 0, 0, 0, 0, 0, 0, 0, 127, 0, 0, 0, 0, 0, 0, 0, 127 };
    const b: u8x16 = @splat(2);

    try testIntrinsic(vmull_high_u8, u16x8{ 0, 0, 0, 0, 0, 0, 0, 254 }, .{ a, b });
}

/// Unsigned multiply long
pub inline fn vmull_high_u16(a: u16x8, b: u16x8) u32x4 {
    return vmull_u16(vget_high_u16(a), vget_high_u16(b));
}

test vmull_high_u16 {
    const a: u16x8 = .{ 0, 1, 2, 3, 0, 1, 2, 3 };
    const b: u16x8 = @splat(5);

    try testIntrinsic(vmull_high_u16, u32x4{ 0, 1 * 5, 2 * 5, 3 * 5 }, .{ a, b });
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
    if (use_asm and AArch64.has_neon) {
        return asm volatile ("sabd %[ret].8b, %[a].8b, %[b].8b"
            : [ret] "=w" (-> i8x8),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else if (use_asm and Arm.has_neon) {
        return asm volatile ("vabd.s8 %[ret], %[a], %[b]"
            : [ret] "=w" (-> i8x8),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else if (use_builtins and AArch64.has_neon) {
        return struct {
            extern fn @"llvm.aarch64.neon.sabd.v8i8"(i8x8, i8x8) i8x8;
        }.@"llvm.aarch64.neon.sabd.v8i8"(a, b);
    } else if (use_builtins and Arm.has_neon) {
        return struct {
            extern fn @"llvm.arm.neon.vabds.v8i8"(i8x8, i8x8) i8x8;
        }.@"llvm.arm.neon.vabds.v8i8"(a, b);
    } else {
        return abd(a, b);
    }
}

test vabd_s8 {
    const a: i8x8 = .{ 1, 2, 3, 4, 5, 6, 7, 8 };
    const b: i8x8 = .{ 16, 15, 14, 13, 12, 11, 10, 9 };

    const expected: i8x8 = .{ 15, 13, 11, 9, 7, 5, 3, 1 };

    try testIntrinsic(vabd_s8, expected, .{ a, b });
}

/// Absolute difference between two i16x4 vectors
pub inline fn vabd_s16(a: i16x4, b: i16x4) i16x4 {
    if (use_asm and AArch64.has_neon) {
        return asm volatile ("sabd %[ret].4h, %[a].4h, %[b].4h"
            : [ret] "=w" (-> i16x4),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else if (use_asm and Arm.has_neon) {
        return asm volatile ("vabd.s16 %[ret], %[a], %[b]"
            : [ret] "=w" (-> i16x4),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else if (use_builtins and AArch64.has_neon) {
        return struct {
            extern fn @"llvm.aarch64.neon.sabd.v4i16"(i16x4, i16x4) i16x4;
        }.@"llvm.aarch64.neon.sabd.v4i16"(a, b);
    } else if (use_builtins and Arm.has_neon) {
        return struct {
            extern fn @"llvm.arm.neon.vabds.v4i16"(i16x4, i16x4) i16x4;
        }.@"llvm.arm.neon.vabds.v4i16"(a, b);
    } else {
        return abd(a, b);
    }
}

test vabd_s16 {
    const a: i16x4 = .{ 1, 2, 3, 4 };
    const b: i16x4 = .{ 16, 15, 14, 13 };

    const expected: i16x4 = .{ 15, 13, 11, 9 };

    try testIntrinsic(vabd_s16, expected, .{ a, b });
}

/// Absolute difference between two i32x2 vectors
pub inline fn vabd_s32(a: i32x2, b: i32x2) i32x2 {
    if (use_asm and AArch64.has_neon) {
        return asm volatile ("sabd %[ret].2s, %[a].2s, %[b].2s"
            : [ret] "=w" (-> i32x2),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else if (use_asm and Arm.has_neon) {
        return asm volatile ("vabd.s32 %[ret], %[a], %[b]"
            : [ret] "=w" (-> i32x2),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else if (use_builtins and AArch64.has_neon) {
        return struct {
            extern fn @"llvm.aarch64.neon.sabd.v2i32"(i32x2, i32x2) i32x2;
        }.@"llvm.aarch64.neon.sabd.v2i32"(a, b);
    } else if (use_builtins and Arm.has_neon) {
        return struct {
            extern fn @"llvm.arm.neon.vabds.v2i32"(i32x2, i32x2) i32x2;
        }.@"llvm.arm.neon.vabds.v2i32"(a, b);
    } else {
        return abd(a, b);
    }
}

test vabd_s32 {
    const a: i32x2 = .{ 1, 2 };
    const b: i32x2 = .{ 16, 15 };

    const expected: i32x2 = .{ 15, 13 };

    try testIntrinsic(vabd_s32, expected, .{ a, b });
}

/// Absolute difference between two u8x8 vectors
pub inline fn vabd_u8(a: u8x8, b: u8x8) u8x8 {
    if (use_asm and AArch64.has_neon) {
        return asm volatile ("uabd %[ret].8b, %[a].8b, %[b].8b"
            : [ret] "=w" (-> u8x8),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else if (use_asm and Arm.has_neon) {
        return asm volatile ("vabd.u8 %[ret], %[a], %[b]"
            : [ret] "=w" (-> u8x8),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else if (use_builtins and AArch64.has_neon) {
        return struct {
            extern fn @"llvm.aarch64.neon.uabd.v8i8"(u8x8, u8x8) u8x8;
        }.@"llvm.aarch64.neon.uabd.v8i8"(a, b);
    } else if (use_builtins and Arm.has_neon) {
        return struct {
            extern fn @"llvm.arm.neon.vabdu.v8i8"(u8x8, u8x8) u8x8;
        }.@"llvm.arm.neon.vabdu.v8i8"(a, b);
    } else {
        return abd(a, b);
    }
}

test vabd_u8 {
    const a: u8x8 = .{ 1, 2, 3, 4, 5, 6, 7, 8 };
    const b: u8x8 = .{ 16, 15, 14, 13, 12, 11, 10, 9 };
    const expected: u8x8 = .{ 15, 13, 11, 9, 7, 5, 3, 1 };
    try testIntrinsic(vabd_u8, expected, .{ a, b });

    const a2: u8x8 = .{ 10, 10, 10, 10, 10, 10, 10, 10 };
    const b2: u8x8 = .{ 10, 10, 10, 10, 10, 10, 10, 10 };
    const expected2: u8x8 = .{ 0, 0, 0, 0, 0, 0, 0, 0 };
    try testIntrinsic(vabd_u8, expected2, .{ a2, b2 });

    const a3: u8x8 = .{ 16, 15, 14, 13, 12, 11, 10, 9 };
    const b3: u8x8 = .{ 1, 2, 3, 4, 5, 6, 7, 8 };
    const expected3: u8x8 = .{ 15, 13, 11, 9, 7, 5, 3, 1 };
    try testIntrinsic(vabd_u8, expected3, .{ a3, b3 });

    const a4: u8x8 = .{ 0, 255, 128, 64, 32, 16, 8, 4 };
    const b4: u8x8 = .{ 255, 0, 64, 128, 16, 32, 4, 8 };
    const expected4: u8x8 = .{ 255, 255, 64, 64, 16, 16, 4, 4 };
    try testIntrinsic(vabd_u8, expected4, .{ a4, b4 });

    const a5: u8x8 = .{ 0, 0, 0, 0, 0, 0, 0, 0 };
    const b5: u8x8 = .{ 0, 0, 0, 0, 0, 0, 0, 0 };
    const expected5: u8x8 = .{ 0, 0, 0, 0, 0, 0, 0, 0 };
    try testIntrinsic(vabd_u8, expected5, .{ a5, b5 });
}

/// Absolute difference between two u16x4 vectors
pub inline fn vabd_u16(a: u16x4, b: u16x4) u16x4 {
    if (use_asm and AArch64.has_neon) {
        return asm volatile ("uabd %[ret].4h, %[a].4h, %[b].4h"
            : [ret] "=w" (-> u16x4),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else if (use_asm and Arm.has_neon) {
        return asm volatile ("vabd.u16 %[ret], %[a], %[b]"
            : [ret] "=w" (-> u16x4),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else if (use_builtins and AArch64.has_neon) {
        return struct {
            extern fn @"llvm.aarch64.neon.uabd.v4i16"(u16x4, u16x4) u16x4;
        }.@"llvm.aarch64.neon.uabd.v4i16"(a, b);
    } else if (use_builtins and Arm.has_neon) {
        return struct {
            extern fn @"llvm.arm.neon.vabdu.v4i16"(u16x4, u16x4) u16x4;
        }.@"llvm.arm.neon.vabdu.v4i16"(a, b);
    } else {
        return abd(a, b);
    }
}

test vabd_u16 {
    const a: u16x4 = .{ 1, 2, 3, 4 };
    const b: u16x4 = .{ 16, 15, 14, 13 };

    const expected: u16x4 = .{ 15, 13, 11, 9 };

    try testIntrinsic(vabd_u16, expected, .{ a, b });
}

/// Absolute difference between two u32x2 vectors
pub inline fn vabd_u32(a: u32x2, b: u32x2) u32x2 {
    if (use_asm and AArch64.has_neon) {
        return asm volatile ("uabd %[ret].2s, %[a].2s, %[b].2s"
            : [ret] "=w" (-> u32x2),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else if (use_asm and Arm.has_neon) {
        return asm volatile ("vabd.u32 %[ret], %[a], %[b]"
            : [ret] "=w" (-> u32x2),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else if (use_builtins and AArch64.has_neon) {
        return struct {
            extern fn @"llvm.aarch64.neon.uabd.v2i32"(u32x2, u32x2) u32x2;
        }.@"llvm.aarch64.neon.uabd.v2i32"(a, b);
    } else if (use_builtins and Arm.has_neon) {
        return struct {
            extern fn @"llvm.arm.neon.vabdu.v2i32"(u32x2, u32x2) u32x2;
        }.@"llvm.arm.neon.vabdu.v2i32"(a, b);
    } else {
        return abd(a, b);
    }
}

test vabd_u32 {
    const a: u32x2 = .{ 1, 2 };
    const b: u32x2 = .{ 16, 15 };

    const expected: u32x2 = .{ 15, 13 };

    try testIntrinsic(vabd_u32, expected, .{ a, b });
}

/// Absolute difference between two f32x2 vectors
pub inline fn vabd_f32(a: f32x2, b: f32x2) f32x2 {
    if (use_asm and AArch64.has_neon) {
        return asm volatile ("fabd %[ret].2s, %[a].2s, %[b].2s"
            : [ret] "=w" (-> f32x2),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else if (use_asm and Arm.has_neon) {
        return asm volatile ("vabd.f32 %[ret], %[a], %[b]"
            : [ret] "=w" (-> f32x2),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else if (use_builtins and AArch64.has_neon) {
        return struct {
            extern fn @"llvm.aarch64.neon.fabd.v2f32"(f32x2, f32x2) f32x2;
        }.@"llvm.aarch64.neon.fabd.v2f32"(a, b);
    } else if (use_builtins and Arm.has_neon) {
        return struct {
            extern fn @"llvm.arm.neon.vabds.v2f32"(f32x2, f32x2) f32x2;
        }.@"llvm.arm.neon.vabds.v2f32"(a, b);
    } else {
        return abd(a, b);
    }
}

test vabd_f32 {
    const a: f32x2 = .{ 0.00, 0.00 };
    const b: f32x2 = .{ 0.19, 0.15 };

    const expected: f32x2 = .{ @abs(0.00 - 0.19), @abs(0.00 - 0.15) };

    try testIntrinsic(vabd_f32, expected, .{ a, b });
}

/// Absolute difference between two f64x1 vectors
pub inline fn vabd_f64(a: f64x1, b: f64x1) f64x1 {
    if (use_asm and AArch64.has_neon) {
        return asm volatile ("fabd d0, d0, d1"
            : [ret] "={d0}" (-> f64x1),
            : [a] "{d0}" (a),
              [b] "{d1}" (b),
        );
    } else if (use_builtins and AArch64.has_neon) {
        return struct {
            extern fn @"llvm.aarch64.neon.fabd.v1f64"(f64x1, f64x1) f64x1;
        }.@"llvm.aarch64.neon.fabd.v1f64"(a, b);
    } else {
        return abd(a, b);
    }
}

test vabd_f64 {
    const a: f64x1 = .{0.01};
    const b: f64x1 = .{0.16};

    const expected: f64x1 = .{0.15};

    try expectEqual(expected, vabd_f64(a, b));
}

/// signed absolute difference and accumulate (128-bit)
pub inline fn vabdq_s8(a: i8x16, b: i8x16) i8x16 {
    if (use_asm and AArch64.has_neon) {
        return asm volatile ("sabd %[ret].16b, %[a].16b, %[b].16b"
            : [ret] "=w" (-> i8x16),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else if (use_asm and Arm.has_neon) {
        return asm volatile ("vabd.s8 %[ret], %[a], %[b]"
            : [ret] "=w" (-> i8x16),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else if (use_builtins and AArch64.has_neon) {
        return struct {
            extern fn @"llvm.aarch64.neon.sabd.v16i8"(i8x16, i8x16) i8x16;
        }.@"llvm.aarch64.neon.sabd.v16i8"(a, b);
    } else if (use_builtins and Arm.has_neon) {
        return struct {
            extern fn @"llvm.arm.neon.vabds.v16i8"(i8x16, i8x16) i8x16;
        }.@"llvm.arm.neon.vabds.v16i8"(a, b);
    } else {
        return abd(a, b);
    }
}

test vabdq_s8 {
    const a: i8x16 = .{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 };
    const b: i8x16 = .{ 16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1 };

    const expected: i8x16 = .{ 15, 13, 11, 9, 7, 5, 3, 1, 1, 3, 5, 7, 9, 11, 13, 15 };

    try testIntrinsic(vabdq_s8, expected, .{ a, b });
}

/// signed absolute difference and accumulate (128-bit)
pub inline fn vabdq_s16(a: i16x8, b: i16x8) i16x8 {
    if (use_asm and AArch64.has_neon) {
        return asm volatile ("sabd %[ret].8h, %[a].8h, %[b].8h"
            : [ret] "=w" (-> i16x8),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else if (use_asm and Arm.has_neon) {
        return asm volatile ("vabd.s16 %[ret], %[a], %[b]"
            : [ret] "=w" (-> i16x8),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else if (use_builtins and AArch64.has_neon) {
        return struct {
            extern fn @"llvm.aarch64.neon.sabd.v8i16"(i16x8, i16x8) i16x8;
        }.@"llvm.aarch64.neon.sabd.v8i16"(a, b);
    } else if (use_builtins and Arm.has_neon) {
        return struct {
            extern fn @"llvm.arm.neon.vabds.v8i16"(i16x8, i16x8) i16x8;
        }.@"llvm.arm.neon.vabds.v8i16"(a, b);
    } else {
        return abd(a, b);
    }
}

test vabdq_s16 {
    const a: i16x8 = .{ 1, 2, 3, 4, 5, 6, 7, 8 };
    const b: i16x8 = .{ 16, 15, 14, 13, 12, 11, 10, 9 };

    const expected: i16x8 = .{ 15, 13, 11, 9, 7, 5, 3, 1 };

    try testIntrinsic(vabdq_s16, expected, .{ a, b });
}

/// signed absolute difference and accumulate (128-bit)
pub inline fn vabdq_s32(a: i32x4, b: i32x4) i32x4 {
    if (use_asm and AArch64.has_neon) {
        return asm volatile ("sabd %[ret].4s, %[a].4s, %[b].4s"
            : [ret] "=w" (-> i32x4),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else if (use_asm and Arm.has_neon) {
        return asm volatile ("vabd.s32 %[ret], %[a], %[b]"
            : [ret] "=w" (-> i32x4),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else if (use_builtins and AArch64.has_neon) {
        return struct {
            extern fn @"llvm.aarch64.neon.sabd.v4i32"(i32x4, i32x4) i32x4;
        }.@"llvm.aarch64.neon.sabd.v4i32"(a, b);
    } else if (use_builtins and Arm.has_neon) {
        return struct {
            extern fn @"llvm.arm.neon.vabds.v4i32"(i32x4, i32x4) i32x4;
        }.@"llvm.arm.neon.vabds.v4i32"(a, b);
    } else {
        return abd(a, b);
    }
}

test vabdq_s32 {
    const a: i32x4 = .{ 1, 2, 3, 4 };
    const b: i32x4 = .{ 16, 15, 14, 13 };

    const expected: i32x4 = .{ 15, 13, 11, 9 };

    try testIntrinsic(vabdq_s32, expected, .{ a, b });
}

/// signed absolute difference and accumulate (128-bit)
pub inline fn vabdq_u8(a: u8x16, b: u8x16) u8x16 {
    if (use_asm and AArch64.has_neon) {
        return asm volatile ("uabd %[ret].16b, %[a].16b, %[b].16b"
            : [ret] "=w" (-> u8x16),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else if (use_asm and Arm.has_neon) {
        return asm volatile ("vabd.u8 %[ret], %[a], %[b]"
            : [ret] "=w" (-> u8x16),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else if (use_builtins and AArch64.has_neon) {
        return struct {
            extern fn @"llvm.aarch64.neon.uabd.v16i8"(u8x16, u8x16) u8x16;
        }.@"llvm.aarch64.neon.uabd.v16i8"(a, b);
    } else if (use_builtins and Arm.has_neon) {
        return struct {
            extern fn @"llvm.arm.neon.vabdu.v16i8"(u8x16, u8x16) u8x16;
        }.@"llvm.arm.neon.vabdu.v16i8"(a, b);
    } else {
        return abd(a, b);
    }
}

test vabdq_u8 {
    const a: u8x16 = .{ 1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8 };
    const b: u8x16 = .{ 16, 15, 14, 13, 12, 11, 10, 9, 16, 15, 14, 13, 12, 11, 10, 9 };
    const expected: u8x16 = .{ 15, 13, 11, 9, 7, 5, 3, 1, 15, 13, 11, 9, 7, 5, 3, 1 };
    try testIntrinsic(vabdq_u8, expected, .{ a, b });

    const a2: u8x16 = .{ 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 };
    const b2: u8x16 = .{ 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 };
    const expected2: u8x16 = .{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
    try testIntrinsic(vabdq_u8, expected2, .{ a2, b2 });

    const a3: u8x16 = .{ 16, 15, 14, 13, 12, 11, 10, 9, 16, 15, 14, 13, 12, 11, 10, 9 };
    const b3: u8x16 = .{ 1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8 };
    const expected3: u8x16 = .{ 15, 13, 11, 9, 7, 5, 3, 1, 15, 13, 11, 9, 7, 5, 3, 1 };
    try testIntrinsic(vabdq_u8, expected3, .{ a3, b3 });

    const a4: u8x16 = .{ 0, 255, 128, 64, 32, 16, 8, 4, 0, 255, 128, 64, 32, 16, 8, 4 };
    const b4: u8x16 = .{ 255, 0, 64, 128, 16, 32, 4, 8, 255, 0, 64, 128, 16, 32, 4, 8 };
    const expected4: u8x16 = .{ 255, 255, 64, 64, 16, 16, 4, 4, 255, 255, 64, 64, 16, 16, 4, 4 };
    try testIntrinsic(vabdq_u8, expected4, .{ a4, b4 });

    const a5: u8x16 = .{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
    const b5: u8x16 = .{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
    const expected5: u8x16 = .{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
    try testIntrinsic(vabdq_u8, expected5, .{ a5, b5 });
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
    if (use_asm and AArch64.has_neon) {
        return asm volatile ("uabd %[ret].4s, %[a].4s, %[b].4s"
            : [ret] "=w" (-> u32x4),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else if (use_asm and Arm.has_neon) {
        return asm volatile ("vabd.u32 %[ret], %[a], %[b]"
            : [ret] "=w" (-> u32x4),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else if (use_builtins and AArch64.has_neon) {
        return struct {
            extern fn @"llvm.aarch64.neon.uabd.v4i32"(u32x4, u32x4) u32x4;
        }.@"llvm.aarch64.neon.uabd.v4i32"(a, b);
    } else if (use_builtins and Arm.has_neon) {
        return struct {
            extern fn @"llvm.arm.neon.vabdu.v4i32"(u32x4, u32x4) u32x4;
        }.@"llvm.arm.neon.vabdu.v4i32"(a, b);
    } else {
        return abd(a, b);
    }
}

test vabdq_u32 {
    const a: u32x4 = .{ 1, 2, 1, 2 };
    const b: u32x4 = .{ 16, 15, 16, 15 };

    const expected: u32x4 = .{ 15, 13, 15, 13 };

    try testIntrinsic(vabdq_u32, expected, .{ a, b });
}

/// signed absolute difference and accumulate (128-bit)
pub inline fn vabdq_f32(a: f32x4, b: f32x4) f32x4 {
    if (use_asm and AArch64.has_neon) {
        return asm volatile ("fabd %[ret].4s, %[a].4s, %[b].4s"
            : [ret] "=w" (-> f32x4),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else if (use_asm and Arm.has_neon) {
        return asm volatile ("vabd.f32 %[ret], %[a], %[b]"
            : [ret] "=w" (-> f32x4),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else if (use_builtins and AArch64.has_neon) {
        return struct {
            extern fn @"llvm.aarch64.neon.fabd.v4f32"(f32x4, f32x4) f32x4;
        }.@"llvm.aarch64.neon.fabd.v4f32"(a, b);
    } else if (use_builtins and Arm.has_neon) {
        return struct {
            extern fn @"llvm.arm.neon.vabds.v4f32"(f32x4, f32x4) f32x4;
        }.@"llvm.arm.neon.vabds.v4f32"(a, b);
    } else {
        return abd(a, b);
    }
}

test vabdq_f32 {
    const a: f32x4 = .{ 0.00, 0.00, 0.00, 0.00 };
    const b: f32x4 = .{ 0.19, 0.15, 0.19, 0.15 };

    const expected: f32x4 = .{ @abs(0.00 - 0.19), @abs(0.00 - 0.15), @abs(0.00 - 0.19), @abs(0.00 - 0.15) };

    use_asm = false;
    use_builtins = false;

    try expectEqual(expected, vabdq_f32(a, b));
}

/// signed absolute difference and accumulate (128-bit)
pub inline fn vabdq_f64(a: f64x2, b: f64x2) f64x2 {
    if (use_asm and AArch64.has_neon) {
        return asm volatile ("fabd %[ret].2d, %[a].2d, %[b].2d"
            : [ret] "=w" (-> f64x2),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else if (use_builtins and AArch64.has_neon) {
        return struct {
            extern fn @"llvm.aarch64.neon.fabd.v2f64"(f64x2, f64x2) f64x2;
        }.@"llvm.aarch64.neon.fabd.v2f64"(a, b);
    } else {
        return abd(a, b);
    }
}

test vabdq_f64 {
    const a: f64x2 = .{ 0.01, 0.01 };
    const b: f64x2 = .{ 0.16, 0.16 };

    const expected: f64x2 = .{ 0.15, 0.15 };

    use_asm = false;
    use_builtins = false;
    
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
    const sum: i32x4 = a +% b;
    return @truncate(vshrq_n_s32(sum, 16));
}

/// Add returning High Narrow
pub inline fn vaddhn_s64(a: i64x2, b: i64x2) i32x2 {
    const sum: i64x2 = a +% b;
    return @truncate(vshrq_n_s64(sum, 32));
}

/// Add returning High Narrow
pub inline fn vaddhn_u16(a: u16x8, b: u16x8) u8x8 {
    const sum: u16x8 = a +% b;
    return @truncate(vshrq_n_u16(sum, 8));
}

/// Add returning High Narrow
pub inline fn vaddhn_u32(a: u32x4, b: u32x4) u16x4 {
    const sum: u32x4 = a +% b;
    return @truncate(vshrq_n_u32(sum, 16));
}

/// Add returning High Narrow
pub inline fn vaddhn_u64(a: u64x2, b: u64x2) u32x2 {
    const sum: u64x2 = a +% b;
    return @truncate(vshrq_n_u64(sum, 32));
}

/// Add returning High Narrow (high half)
pub inline fn vaddhn_high_s16(a: i8x8, b: i16x8, c: i16x8) i8x16 {
    return join(
        a,
        vaddhn_s16(b, c),
    );
}

test vaddhn_high_s16 {
    const a: i8x8 = @splat(42);
    const b: i16x8 = .{ (0 << 8) + 1, (1 << 8) + 1, (2 << 8) + 1, (3 << 8) + 1, (4 << 8) + 1, (5 << 8) + 1, (6 << 8) + 1, (7 << 8) + 1 };
    const expected: i8x16 = .{ 42, 42, 42, 42, 42, 42, 42, 42, 0, 2, 4, 6, 8, 10, 12, 14 };

    try expectEqual(expected, vaddhn_high_s16(a, b, b));
}

/// Add returning High Narrow (high half)
pub inline fn vaddhn_high_s32(a: i16x4, b: i32x4, c: i32x4) i16x8 {
    return join(
        a,
        vaddhn_s32(b, c),
    );
}

/// Add returning High Narrow (high half)
pub inline fn vaddhn_high_s64(a: i32x2, b: i64x2, c: i64x2) i32x4 {
    return join(
        a,
        vaddhn_s64(b, c),
    );
}

/// Add returning High Narrow (high half)
pub inline fn vaddhn_high_u16(a: u8x8, b: u16x8, c: u16x8) u8x16 {
    return join(
        a,
        vaddhn_u16(b, c),
    );
}

test vaddhn_high_u16 {
    const a: u8x8 = @splat(42);
    const b: u16x8 = .{ (0 << 8) + 1, (1 << 8) + 1, (2 << 8) + 1, (3 << 8) + 1, (4 << 8) + 1, (5 << 8) + 1, (6 << 8) + 1, (7 << 8) + 1 };
    const expected: u8x16 = .{ 42, 42, 42, 42, 42, 42, 42, 42, 0, 2, 4, 6, 8, 10, 12, 14 };

    try expectEqual(expected, vaddhn_high_u16(a, b, b));
}

/// Add returning High Narrow (high half)
pub inline fn vaddhn_high_u32(a: u16x4, b: u32x4, c: u32x4) u16x8 {
    return join(
        a,
        vaddhn_u32(b, c),
    );
}

/// Add returning High Narrow (high half)
pub inline fn vaddhn_high_u64(a: u32x2, b: u64x2, c: u64x2) u32x4 {
    return join(
        a,
        vaddhn_u64(b, c),
    );
}

/// Signed Add Long
pub inline fn vaddl_s8(a: i8x8, b: i8x8) i16x8 {
    return vmovl_s8(a) + vmovl_s8(b);
}

/// Signed Add Long
pub inline fn vaddl_s16(a: i16x4, b: i16x4) i32x4 {
    return vmovl_s16(a) + vmovl_s16(b);
}

/// Signed Add Long
pub inline fn vaddl_s32(a: i32x2, b: i32x2) i64x2 {
    return vmovl_s32(a) + vmovl_s32(b);
}

/// Unsigned Add Long
pub inline fn vaddl_u8(a: u8x8, b: u8x8) u16x8 {
    return vmovl_u8(a) + vmovl_u8(b);
}

/// Unsigned Add Long
pub inline fn vaddl_u16(a: u16x4, b: u16x4) u32x4 {
    return vmovl_u16(a) + vmovl_u16(b);
}

/// Unsigned Add Long
pub inline fn vaddl_u32(a: u32x2, b: u32x2) u64x2 {
    return vmovl_u32(a) + vmovl_u32(b);
}

///	Signed Add Long (high half)
pub inline fn vaddl_high_s8(a: i8x16, b: i8x16) i16x8 {
    return vmovl_high_s8(a) + vmovl_high_s8(b);
}

///	Signed Add Long (high half)
pub inline fn vaddl_high_s16(a: i16x8, b: i16x8) i32x4 {
    return vmovl_high_s16(a) + vmovl_high_s16(b);
}

///	Signed Add Long (high half)
pub inline fn vaddl_high_s32(a: i32x4, b: i32x4) i64x2 {
    return vmovl_high_s32(a) + vmovl_high_s32(b);
}

///	Unsigned Add Long (high half)
pub inline fn vaddl_high_u8(a: u8x16, b: u8x16) u16x8 {
    return vmovl_high_u8(a) + vmovl_high_u8(b);
}

///	Unsigned Add Long (high half)
pub inline fn vaddl_high_u16(a: u16x8, b: u16x8) u32x4 {
    return vmovl_high_u16(a) + vmovl_high_u16(b);
}

///	Unsigned Add Long (high half)
pub inline fn vaddl_high_u32(a: u32x4, b: u32x4) u64x2 {
    return vmovl_high_u32(a) + vmovl_high_u32(b);
}

/// Signed Add Wide
pub inline fn vaddw_s8(a: i16x8, b: i8x8) i16x8 {
    return a +% vmovl_s8(b);
}

test vaddw_s8 {
    const a1: i16x8 = .{ 1000, 2000, 3000, 4000, -5000, -6000, -7000, -8000 };
    const b1: i8x8 = .{ 10, 20, -30, -40, 50, 60, -70, 80 };
    const expected1: i16x8 = .{ 1010, 2020, 2970, 3960, -4950, -5940, -7070, -7920 };

    try expectEqual(expected1, vaddw_s8(a1, b1));

    const a2 = @Vector(8, i16){ 32760, -32760, 1000, -1000, 2000, -2000, 0, -32768 };
    const b2 = @Vector(8, i8){ 10, -10, 120, -120, 127, -128, 0, 1 };
    const expected2: i16x8 = .{
        -32766, // Overflow wraps around to negative
        32766, // Underflow wraps around to positive
        1120, // Normal addition
        -1120, // Normal subtraction
        2127, // Normal addition
        -2128, // Normal subtraction
        0, // No change
        -32767, // Wraps around to next higher value
    };

    try expectEqual(expected2, vaddw_s8(a2, b2));
}

/// Signed Add Wide (high half)
pub inline fn vaddw_high_s8(a: i16x8, b: i8x16) i16x8 {
    return a +% vmovl_high_s8(b);
}

test vaddw_high_s8 {
    const a: i16x8 = .{ 32760, -32760, 1000, -1000, 2000, -2000, 0, -32768 };
    const b: i8x16 = .{ 1, 2, 3, 4, 5, 6, 7, 8, 10, -10, 120, -120, 127, -128, 0, 1 };
    const expected: i16x8 = .{ -32766, 32766, 1120, -1120, 2127, -2128, 0, -32767 };

    try expectEqual(expected, vaddw_high_s8(a, b));
}

/// Signed Add Wide (high half)
pub inline fn vaddw_high_s16(a: i32x4, b: i16x8) i32x4 {
    return a +% vmovl_high_s16(b);
}

/// Signed Add Wide (high half)
pub inline fn vaddw_high_s32(a: i64x2, b: i32x4) i64x2 {
    return a +% vmovl_high_s32(b);
}

/// Unsigned Add Wide (high half)
pub inline fn vaddw_high_u8(a: u16x8, b: u8x16) u16x8 {
    return a +% vmovl_high_s8(b);
}

/// Unsigned Add Wide (high half)
pub inline fn vaddw_high_u16(a: u32x4, b: u16x8) u32x4 {
    return a +% vmovl_high_u16(b);
}

/// Unsigned Add Wide (high half)
pub inline fn vaddw_high_u32(a: u64x2, b: u32x4) u64x2 {
    return a +% vmovl_high_u32(b);
}

/// Signed Add Wide
pub inline fn vaddw_s16(a: i32x4, b: i16x4) i32x4 {
    return a +% vmovl_s16(b);
}

/// Signed Add Wide
pub inline fn vaddw_s32(a: i64x2, b: i32x2) i64x2 {
    return a +% vmovl_s32(b);
}

/// Unsigned Add Wide
pub inline fn vaddw_u8(a: u16x8, b: u8x8) u16x8 {
    return a +% vmovl_u8(b);
}

/// Unsigned Add Wide
pub inline fn vaddw_u16(a: u32x4, b: u16x4) u32x4 {
    return a +% vmovl_u16(b);
}

/// Unsigned Add Wide
pub inline fn vaddw_u32(a: u64x2, b: u32x2) u64x2 {
    return a +% vmovl_u32(b);
}

/// AES single round decryption
pub inline fn vaesdq_u8(data: u8x16, key: u8x16) u8x16 {
    if (use_asm and AArch64.has_aes) {
        return asm volatile ("aesd v0.16b, v1.16b"
            : [ret] "={v0}" (-> u8x16),
            : [a] "{v0}" (data),
              [b] "{v1}" (key),
        );
    } else if (use_builtins and AArch64.has_crypto) {
        return struct {
            extern fn @"llvm.aarch64.crypto.aesd"(u8x16, u8x16) u8x16;
        }.@"llvm.aarch64.crypto.aesd"(data, key);
    } else {
        return AESShiftRows(AESSubBytes(data ^ key, AES_INV_SBOX), true);
    }
}

test vaesdq_u8 {
    const state: u8x16 = .{ 0x69, 0xc4, 0xe0, 0xd8, 0x6a, 0x7b, 0x04, 0x30, 0xd8, 0xcd, 0xb7, 0x80, 0x70, 0xb4, 0xc5, 0x5a };
    const key: u8x16 = .{ 0x2b, 0x7e, 0x15, 0x16, 0x28, 0xae, 0xd2, 0xa6, 0xab, 0xf7, 0x97, 0x75, 0x46, 0x10, 0x3b, 0x2f };
    const expected: u8x16 = .{ 246, 29, 84, 53, 246, 192, 12, 119, 143, 181, 119, 63, 36, 162, 74, 236 };

    try testIntrinsic(vaesdq_u8, expected, .{ state, key });
}

/// AES single round encryption
pub inline fn vaeseq_u8(data: u8x16, key: u8x16) u8x16 {
    if (use_asm and AArch64.has_aes) {
        return asm volatile ("aese v0.16b, v1.16b"
            : [ret] "={v0}" (-> u8x16),
            : [a] "{v0}" (data),
              [b] "{v1}" (key),
        );
    } else if (use_builtins and AArch64.has_crypto) {
        return struct {
            extern fn @"llvm.aarch64.crypto.aese"(u8x16, u8x16) u8x16;
        }.@"llvm.aarch64.crypto.aese"(data, key);
    } else {
        return AESShiftRows(AESSubBytes(data ^ key, AES_SBOX), false);
    }
}

fn AESSubBytes(op: u8x16, comptime box: [256]u8) u8x16 {
    var out: u8x16 = @splat(0);
    inline for (0..16) |i| {
        out[i] = box[op[i]];
    }
    return out;
}

/// Perform AES ShiftRows transformation. If `inverse`
/// is `true`, perform inverse ShiftRows.
fn AESShiftRows(data: u8x16, comptime inverse: bool) u8x16 {
    const shift_pattern = if (inverse)
        // Inverse ShiftRows pattern
        u8x16{ 0, 13, 10, 7, 4, 1, 14, 11, 8, 5, 2, 15, 12, 9, 6, 3 }
    else
        // Regular ShiftRows pattern
        u8x16{ 0, 5, 10, 15, 4, 9, 14, 3, 8, 13, 2, 7, 12, 1, 6, 11 };

    return u8x16{
        data[shift_pattern[0]],  data[shift_pattern[1]],  data[shift_pattern[2]],  data[shift_pattern[3]],
        data[shift_pattern[4]],  data[shift_pattern[5]],  data[shift_pattern[6]],  data[shift_pattern[7]],
        data[shift_pattern[8]],  data[shift_pattern[9]],  data[shift_pattern[10]], data[shift_pattern[11]],
        data[shift_pattern[12]], data[shift_pattern[13]], data[shift_pattern[14]], data[shift_pattern[15]],
    };
}

test vaeseq_u8 {
    const state = u8x16{ 0x32, 0x43, 0xf6, 0xa8, 0x88, 0x5a, 0x30, 0x8d, 0x31, 0x31, 0x98, 0xa2, 0xe0, 0x37, 0x07, 0x34 };
    const key = u8x16{ 0x2b, 0x7e, 0x15, 0x16, 0x28, 0xae, 0xd2, 0xa6, 0xab, 0xf7, 0xcf, 0xfb, 0x73, 0x73, 0x73, 0x73 };

    const expected = u8x16{ 212, 191, 91, 160, 224, 180, 146, 174, 184, 27, 17, 241, 220, 39, 152, 203 };
    try testIntrinsic(vaeseq_u8, expected, .{ state, key });
}

/// AES inverse mix columns
pub inline fn vaesimcq_u8(data: u8x16) u8x16 {
    if (use_asm and AArch64.has_aes) {
        return asm volatile ("aesimc v0.16b, v1.16b"
            : [ret] "={v0}" (-> u8x16),
            : [a] "{v1}" (data),
        );
    } else if (use_builtins and AArch64.has_crypto) {
        return struct {
            extern fn @"llvm.aarch64.crypto.aesimc"(u8x16) u8x16;
        }.@"llvm.aarch64.crypto.aesimc"(data);
    } else {
        return AESMixColumns(data, true);
    }
}

test vaesimcq_u8 {
    const input = u8x16{ 0xdb, 0x13, 0x53, 0x45, 0xf2, 0x0a, 0x22, 0x5c, 0x01, 0x23, 0x45, 0x67, 0x89, 0xab, 0xcd, 0xef };
    const expected = u8x16{ 50, 164, 29, 85, 174, 195, 105, 130, 78, 228, 10, 160, 198, 108, 130, 40 };

    try testIntrinsic(vaesimcq_u8, expected, .{input});
}

/// AES mix columns
pub inline fn vaesmcq_u8(data: u8x16) u8x16 {
    if (use_asm and AArch64.has_aes) {
        return asm volatile ("aesmc v0.16b, v1.16b"
            : [ret] "={v0}" (-> u8x16),
            : [a] "{v1}" (data),
        );
    } else if (use_builtins and AArch64.has_crypto) {
        return struct {
            extern fn @"llvm.aarch64.crypto.aesmc"(u8x16) u8x16;
        }.@"llvm.aarch64.crypto.aesmc"(data);
    } else {
        return AESMixColumns(data, false);
    }
}

/// Perform AES MixColumns transformation. If `inverse`
/// is `true`, perform the inverse MixColumns.
fn AESMixColumns(state: u8x16, comptime inverse: bool) u8x16 {
    var result: u8x16 = undefined;
    const mix = if (inverse)
        // Inverse MixColumns matrix
        @Vector(4, u8){ 0x0e, 0x0b, 0x0d, 0x09 }
    else
        // Regular MixColumns matrix
        @Vector(4, u8){ 0x02, 0x03, 0x01, 0x01 };

    mixColumn(state, mix, 0, &result);
    mixColumn(state, mix, 4, &result);
    mixColumn(state, mix, 8, &result);
    mixColumn(state, mix, 12, &result);

    return result;
}

/// Mix a single AES column using the given MixColumns matrix.
fn mixColumn(
    state: u8x16,
    mix: @Vector(4, u8),
    offset: usize,
    result: *u8x16,
) void {
    result.*[offset + 0] = gfMult(state[offset + 0], mix[0]) ^ gfMult(state[offset + 1], mix[1]) ^ gfMult(state[offset + 2], mix[2]) ^ gfMult(state[offset + 3], mix[3]);
    result.*[offset + 1] = gfMult(state[offset + 0], mix[3]) ^ gfMult(state[offset + 1], mix[0]) ^ gfMult(state[offset + 2], mix[1]) ^ gfMult(state[offset + 3], mix[2]);
    result.*[offset + 2] = gfMult(state[offset + 0], mix[2]) ^ gfMult(state[offset + 1], mix[3]) ^ gfMult(state[offset + 2], mix[0]) ^ gfMult(state[offset + 3], mix[1]);
    result.*[offset + 3] = gfMult(state[offset + 0], mix[1]) ^ gfMult(state[offset + 1], mix[2]) ^ gfMult(state[offset + 2], mix[3]) ^ gfMult(state[offset + 3], mix[0]);
}

/// Multiply two bytes in the AES finite field GF(2^8).
inline fn gfMult(a: u8, b: u8) u8 {
    return GF_MUL_TABLE[a][b];
}

test vaesmcq_u8 {
    const input = u8x16{ 0xdb, 0x13, 0x53, 0x45, 0xf2, 0x0a, 0x22, 0x5c, 0x01, 0x23, 0x45, 0x67, 0x89, 0xab, 0xcd, 0xef };
    const expected = u8x16{ 142, 77, 161, 188, 159, 220, 88, 157, 69, 239, 1, 171, 205, 103, 137, 35 };

    try testIntrinsic(vaesmcq_u8, expected, .{input});
}

//// Vector bitwise and
pub inline fn vand_s8(a: i8x8, b: i8x8) i8x8 {
    if (use_asm and AArch64.has_neon) {
        return asm volatile ("and v0.8b, v1.8b, v2.8b"
            : [ret] "={v0}" (-> i8x8),
            : [a] "{v1}" (a),
              [b] "{v2}" (b),
        );
    } else if (use_asm and Arm.has_neon) {
        return asm volatile ("vand d0, d1, d2"
            : [ret] "={d0}" (-> i8x8),
            : [a] "{d1}" (a),
              [b] "{d2}" (b),
        );
    } else {
        return a & b;
    }
}

test vand_s8 {
    const a: i8x8 = .{ 0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07 };
    const b: i8x8 = .{ 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F };
    const expected: i8x8 = .{ 0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07 };

    try testIntrinsic(vand_s8, expected, .{ a, b });
}

/// Vector bitwise and
pub inline fn vand_s16(a: i16x4, b: i16x4) i16x4 {
    if (use_asm and AArch64.has_neon) {
        return asm volatile ("and v0.8b, v1.8b, v2.8b"
            : [ret] "={v0}" (-> i16x4),
            : [a] "{v1}" (a),
              [b] "{v2}" (b),
        );
    } else if (use_asm and Arm.has_neon) {
        return asm volatile ("vand d0, d1, d2"
            : [ret] "={d0}" (-> i16x4),
            : [a] "{d1}" (a),
              [b] "{d2}" (b),
        );
    } else {
        return a & b;
    }
}

test vand_s16 {
    const a: i16x4 = .{ 0x00, 0x01, 0x02, 0x03 };
    const b: i16x4 = .{ 0x0F, 0x0F, 0x0F, 0x0F };
    const expected: i16x4 = .{ 0x00, 0x01, 0x02, 0x03 };

    try testIntrinsic(vand_s16, expected, .{ a, b });
}

/// Vector bitwise and
pub inline fn vand_s32(a: i32x2, b: i32x2) i32x2 {
    if (use_asm and AArch64.has_neon) {
        return asm volatile ("and v0.8b, v1.8b, v2.8b"
            : [ret] "={v0}" (-> i32x2),
            : [a] "{v1}" (a),
              [b] "{v2}" (b),
        );
    } else if (use_asm and Arm.has_neon) {
        return asm volatile ("vand d0, d1, d2"
            : [ret] "={d0}" (-> i32x2),
            : [a] "{d1}" (a),
              [b] "{d2}" (b),
        );
    } else {
        return a & b;
    }
}

test vand_s32 {
    const a: i32x2 = .{ 0x00, 0x01 };
    const b: i32x2 = .{ 0x0F, 0x0F };
    const expected: i32x2 = .{ 0x00, 0x01 };

    try testIntrinsic(vand_s32, expected, .{ a, b });
}

/// Vector bitwise and
pub inline fn vand_s64(a: i64x1, b: i64x1) i64x1 {
    if (use_asm and AArch64.has_neon) {
        return asm volatile ("and v0.8b, v1.8b, v2.8b"
            : [ret] "={v0}" (-> i64x1),
            : [a] "{v1}" (a),
              [b] "{v2}" (b),
        );
    } else if (use_asm and Arm.has_neon) {
        return asm volatile ("vand d0, d1, d2"
            : [ret] "={d0}" (-> i64x1),
            : [a] "{d1}" (a),
              [b] "{d2}" (b),
        );
    } else {
        return a & b;
    }
}

test vand_s64 {
    const a: i64x1 = .{0x00};
    const b: i64x1 = .{0x0F};
    const expected: i64x1 = .{0x00};

    try testIntrinsic(vand_s64, expected, .{ a, b });
}

/// Vector bitwise and
pub inline fn vand_u8(a: u8x8, b: u8x8) u8x8 {
    if (use_asm and AArch64.has_neon) {
        return asm volatile ("and v0.8b, v1.8b, v2.8b"
            : [ret] "={v0}" (-> u8x8),
            : [a] "{v1}" (a),
              [b] "{v2}" (b),
        );
    } else if (use_asm and Arm.has_neon) {
        return asm volatile ("vand d0, d1, d2"
            : [ret] "={d0}" (-> u8x8),
            : [a] "{d1}" (a),
              [b] "{d2}" (b),
        );
    } else {
        return a & b;
    }
}

test vand_u8 {
    const a: u8x8 = .{ 0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07 };
    const b: u8x8 = .{ 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F };
    const expected: u8x8 = .{ 0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07 };

    try testIntrinsic(vand_u8, expected, .{ a, b });
}

/// Vector bitwise and
pub inline fn vand_u16(a: i16x4, b: i16x4) u16x4 {
    if (use_asm and AArch64.has_neon) {
        return asm volatile ("and v0.8b, v1.8b, v2.8b"
            : [ret] "={v0}" (-> u16x4),
            : [a] "{v1}" (a),
              [b] "{v2}" (b),
        );
    } else if (use_asm and Arm.has_neon) {
        return asm volatile ("vand d0, d1, d2"
            : [ret] "={d0}" (-> u16x4),
            : [a] "{d1}" (a),
              [b] "{d2}" (b),
        );
    } else {
        return a & b;
    }
}

test vand_u16 {
    const a: u16x4 = .{ 0x00, 0x01, 0x02, 0x03 };
    const b: u16x4 = .{ 0x0F, 0x0F, 0x0F, 0x0F };
    const expected: u16x4 = .{ 0x00, 0x01, 0x02, 0x03 };

    try testIntrinsic(vand_u16, expected, .{ a, b });
}

/// Vector bitwise and
pub inline fn vand_u32(a: u32x2, b: u32x2) u32x2 {
    if (use_asm and AArch64.has_neon) {
        return asm volatile ("and v0.8b, v1.8b, v2.8b"
            : [ret] "={v0}" (-> u32x2),
            : [a] "{v1}" (a),
              [b] "{v2}" (b),
        );
    } else if (use_asm and Arm.has_neon) {
        return asm volatile ("vand d0, d1, d2"
            : [ret] "={d0}" (-> u32x2),
            : [a] "{d1}" (a),
              [b] "{d2}" (b),
        );
    } else {
        return a & b;
    }
}

test vand_u32 {
    const a: u32x2 = .{ 0x00, 0x01 };
    const b: u32x2 = .{ 0x0F, 0x0F };
    const expected: u32x2 = .{ 0x00, 0x01 };

    try testIntrinsic(vand_u32, expected, .{ a, b });
}

/// Vector bitwise and
pub inline fn vand_u64(a: u64x1, b: u64x1) u64x1 {
    if (use_asm and AArch64.has_neon) {
        return asm volatile ("and v0.8b, v1.8b, v2.8b"
            : [ret] "={v0}" (-> u64x1),
            : [a] "{v1}" (a),
              [b] "{v2}" (b),
        );
    } else if (use_asm and Arm.has_neon) {
        return asm volatile ("vand d0, d1, d2"
            : [ret] "={d0}" (-> u64x1),
            : [a] "{d1}" (a),
              [b] "{d2}" (b),
        );
    } else {
        return a & b;
    }
}

test vand_u64 {
    const a: u64x1 = .{0x00};
    const b: u64x1 = .{0x0F};
    const expected: u64x1 = .{0x00};

    try testIntrinsic(vand_u64, expected, .{ a, b });
}

/// Vector bitwise and
pub inline fn vandq_s8(a: i8x16, b: i8x16) i8x16 {
    if (use_asm and AArch64.has_neon) {
        return asm volatile ("and v0.16b, v1.16b, v2.16b"
            : [ret] "={v0}" (-> i8x16),
            : [a] "{v1}" (a),
              [b] "{v2}" (b),
        );
    } else if (use_asm and Arm.has_neon) {
        return asm volatile ("vand q0, q1, q2"
            : [ret] "={q0}" (-> i8x16),
            : [a] "{q1}" (a),
              [b] "{q2}" (b),
        );
    } else {
        return a & b;
    }
}

test vandq_s8 {
    const a: i8x16 = .{ 0x00, 0x01, 0x02, 0x03, 0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x00, 0x01, 0x02, 0x03 };
    const b: i8x16 = .{ 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F };
    const expected: i8x16 = .{ 0x00, 0x01, 0x02, 0x03, 0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x00, 0x01, 0x02, 0x03 };

    try testIntrinsic(vandq_s8, expected, .{ a, b });
}

/// Vector bitwise and
pub inline fn vandq_s16(a: i16x8, b: i16x8) i16x8 {
    if (use_asm and AArch64.has_neon) {
        return asm volatile ("and v0.16b, v1.16b, v2.16b"
            : [ret] "={v0}" (-> i16x8),
            : [a] "{v1}" (a),
              [b] "{v2}" (b),
        );
    } else if (use_asm and Arm.has_neon) {
        return asm volatile ("vand q0, q1, q2"
            : [ret] "={q0}" (-> i16x8),
            : [a] "{q1}" (a),
              [b] "{q2}" (b),
        );
    } else {
        return a & b;
    }
}

test vandq_s16 {
    const a: i16x8 = .{ 0x00, 0x01, 0x02, 0x03, 0x00, 0x01, 0x02, 0x03 };
    const b: i16x8 = .{ 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F };
    const expected: i16x8 = .{ 0x00, 0x01, 0x02, 0x03, 0x00, 0x01, 0x02, 0x03 };

    try testIntrinsic(vandq_s16, expected, .{ a, b });
}

/// Vector bitwise and
pub inline fn vandq_s32(a: i32x4, b: i32x4) i32x4 {
    if (use_asm and AArch64.has_neon) {
        return asm volatile ("and v0.16b, v1.16b, v2.16b"
            : [ret] "={v0}" (-> i32x4),
            : [a] "{v1}" (a),
              [b] "{v2}" (b),
        );
    } else if (use_asm and Arm.has_neon) {
        return asm volatile ("vand q0, q1, q2"
            : [ret] "={q0}" (-> i32x4),
            : [a] "{q1}" (a),
              [b] "{q2}" (b),
        );
    } else {
        return a & b;
    }
}

test vandq_s32 {
    const a: i32x4 = .{ 0x00, 0x01, 0x00, 0x01 };
    const b: i32x4 = .{ 0x0F, 0x0F, 0x0F, 0x0F };
    const expected: i32x4 = .{ 0x00, 0x01, 0x00, 0x01 };

    try testIntrinsic(vandq_s32, expected, .{ a, b });
}

/// Vector bitwise and
pub inline fn vandq_s64(a: i64x2, b: i64x2) i64x2 {
    if (use_asm and AArch64.has_neon) {
        return asm volatile ("and v0.16b, v1.16b, v2.16b"
            : [ret] "={v0}" (-> i64x2),
            : [a] "{v1}" (a),
              [b] "{v2}" (b),
        );
    } else if (use_asm and Arm.has_neon) {
        return asm volatile ("vand q0, q1, q2"
            : [ret] "={q0}" (-> i64x2),
            : [a] "{q1}" (a),
              [b] "{q2}" (b),
        );
    } else {
        return a & b;
    }
}

test vandq_s64 {
    const a: i64x2 = .{ 0x00, 0x00 };
    const b: i64x2 = .{ 0x0F, 0x0F };
    const expected: i64x2 = .{ 0x00, 0x00 };

    try testIntrinsic(vandq_s64, expected, .{ a, b });
}

/// Vector bitwise and
pub inline fn vandq_u8(a: u8x16, b: u8x16) u8x16 {
    if (use_asm and AArch64.has_neon) {
        return asm volatile ("and v0.16b, v1.16b, v2.16b"
            : [ret] "={v0}" (-> u8x16),
            : [a] "{v1}" (a),
              [b] "{v2}" (b),
        );
    } else if (use_asm and Arm.has_neon) {
        return asm volatile ("vand q0, q1, q2"
            : [ret] "={q0}" (-> u8x16),
            : [a] "{q1}" (a),
              [b] "{q2}" (b),
        );
    } else {
        return a & b;
    }
}

test vandq_u8 {
    const a: u8x16 = .{ 0x00, 0x01, 0x02, 0x03, 0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x00, 0x01, 0x02, 0x03 };
    const b: u8x16 = .{ 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F };
    const expected: u8x16 = .{ 0x00, 0x01, 0x02, 0x03, 0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x00, 0x01, 0x02, 0x03 };

    try testIntrinsic(vandq_u8, expected, .{ a, b });
}

/// Vector bitwise and
pub inline fn vandq_u16(a: i16x8, b: i16x8) u16x8 {
    if (use_asm and AArch64.has_neon) {
        return asm volatile ("and v0.16b, v1.16b, v2.16b"
            : [ret] "={v0}" (-> u16x8),
            : [a] "{v1}" (a),
              [b] "{v2}" (b),
        );
    } else if (use_asm and Arm.has_neon) {
        return asm volatile ("vand q0, q1, q2"
            : [ret] "={q0}" (-> u16x8),
            : [a] "{q1}" (a),
              [b] "{q2}" (b),
        );
    } else {
        return a & b;
    }
}

test vandq_u16 {
    const a: u16x8 = .{ 0x00, 0x01, 0x02, 0x03, 0x00, 0x01, 0x02, 0x03 };
    const b: u16x8 = .{ 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F };
    const expected: u16x8 = .{ 0x00, 0x01, 0x02, 0x03, 0x00, 0x01, 0x02, 0x03 };

    try testIntrinsic(vandq_u16, expected, .{ a, b });
}

/// Vector bitwise and
pub inline fn vandq_u32(a: u32x4, b: u32x4) u32x4 {
    if (use_asm and AArch64.has_neon) {
        return asm volatile ("and v0.16b, v1.16b, v2.16b"
            : [ret] "={v0}" (-> u32x4),
            : [a] "{v1}" (a),
              [b] "{v2}" (b),
        );
    } else if (use_asm and Arm.has_neon) {
        return asm volatile ("vand q0, q1, q2"
            : [ret] "={q0}" (-> u32x4),
            : [a] "{q1}" (a),
              [b] "{q2}" (b),
        );
    } else {
        return a & b;
    }
}

test vandq_u32 {
    const a: u32x4 = .{ 0x00, 0x01, 0x00, 0x01 };
    const b: u32x4 = .{ 0x0F, 0x0F, 0x0F, 0x0F };
    const expected: u32x4 = .{ 0x00, 0x01, 0x00, 0x01 };

    try testIntrinsic(vandq_u32, expected, .{ a, b });
}

/// Vector bitwise and
pub inline fn vandq_u64(a: u64x2, b: u64x2) u64x2 {
    if (use_asm and AArch64.has_neon) {
        return asm volatile ("and v0.16b, v1.16b, v2.16b"
            : [ret] "={v0}" (-> u64x2),
            : [a] "{v1}" (a),
              [b] "{v2}" (b),
        );
    } else if (use_asm and Arm.has_neon) {
        return asm volatile ("vand q0, q1, q2"
            : [ret] "={q0}" (-> u64x2),
            : [a] "{q1}" (a),
              [b] "{q2}" (b),
        );
    } else {
        return a & b;
    }
}

test vandq_u64 {
    const a: u64x2 = .{ 0x00, 0x00 };
    const b: u64x2 = .{ 0x0F, 0x0F };
    const expected: u64x2 = .{ 0x00, 0x00 };

    try testIntrinsic(vandq_u64, expected, .{ a, b });
}

/// Vector bitwise bit clear
pub inline fn vbic_s8(a: i8x8, b: i8x8) i8x8 {
    return a & ~b;
}

/// Vector bitwise bit clear
pub inline fn vbic_s16(a: i16x4, b: i16x4) i16x4 {
    return a & ~b;
}

/// Vector bitwise bit clear
pub inline fn vbic_s32(a: i32x2, b: i32x2) i32x2 {
    return a & ~b;
}

/// Vector bitwise bit clear
pub inline fn vbic_s64(a: i64x1, b: i64x1) i64x1 {
    return a & ~b;
}

/// Vector bitwise bit clear
pub inline fn vbic_u8(a: u8x8, b: u8x8) u8x8 {
    return a & ~b;
}

/// Vector bitwise bit clear
pub inline fn vbic_u16(a: u16x4, b: u16x4) u16x4 {
    return a & ~b;
}

/// Vector bitwise bit clear
pub inline fn vbic_u32(a: u32x2, b: u32x2) u32x2 {
    return a & ~b;
}

/// Vector bitwise bit clear
pub inline fn vbic_u64(a: u64x1, b: u64x1) u64x1 {
    return a & ~b;
}

/// Vector bitwise bit clear
pub inline fn vbicq_s8(a: i8x16, b: i8x16) i8x16 {
    return a & ~b;
}

/// Vector bitwise bit clear
pub inline fn vbicq_s16(a: i16x8, b: i16x8) i16x8 {
    return a & ~b;
}

/// Vector bitwise bit clear
pub inline fn vbicq_s32(a: i32x4, b: i32x4) i32x4 {
    return a & ~b;
}

/// Vector bitwise bit clear
pub inline fn vbicq_s64(a: i64x2, b: i64x2) i64x2 {
    return a & ~b;
}

/// Vector bitwise bit clear
pub inline fn vbicq_u8(a: u8x16, b: u8x16) u8x16 {
    return a & ~b;
}

/// Vector bitwise bit clear
pub inline fn vbicq_u16(a: u16x8, b: u16x8) u16x8 {
    return a & ~b;
}

/// Vector bitwise bit clear
pub inline fn vbicq_u32(a: u32x4, b: u32x4) u32x4 {
    return a & ~b;
}

/// Vector bitwise bit clear
pub inline fn vbicq_u64(a: u64x2, b: u64x2) u64x2 {
    return a & ~b;
}

/// Bitwise Select
pub inline fn vbsl_s8(a: i8x8, b: i8x8, c: i8x8) i8x8 {
    return (a & b) | (~a & c);
}

test vbsl_s8 {
    const a: i8x8 = .{ std.math.maxInt(i8), 1, std.math.maxInt(i8), 2, std.math.maxInt(i8), 0, std.math.maxInt(i8), 0 };
    const b: i8x8 = .{ std.math.maxInt(i8), std.math.maxInt(i8), std.math.maxInt(i8), std.math.maxInt(i8), std.math.maxInt(i8), std.math.maxInt(i8), std.math.maxInt(i8), std.math.maxInt(i8) };
    const c: i8x8 = .{ std.math.minInt(i8), std.math.minInt(i8), std.math.minInt(i8), std.math.minInt(i8), std.math.minInt(i8), std.math.minInt(i8), std.math.minInt(i8), std.math.minInt(i8) };
    const expected: i8x8 = .{ -1, -127, -1, -126, -1, -128, -1, -128 };

    try expectEqual(expected, vbsl_s8(a, b, c));
}

/// Bitwise Select
pub inline fn vbsl_s16(a: i16x4, b: i16x4, c: i16x4) i16x4 {
    return (a & b) | (~a & c);
}

/// Bitwise Select
pub inline fn vbsl_s32(a: i32x2, b: i32x2, c: i32x2) i32x2 {
    return (a & b) | (~a & c);
}

/// Bitwise Select
pub inline fn vbsl_s64(a: i64x1, b: i64x1, c: i64x1) i64x1 {
    return (a & b) | (~a & c);
}

/// Bitwise Select
pub inline fn vbsl_u8(a: u8x8, b: u8x8, c: u8x8) u8x8 {
    return (a & b) | (~a & c);
}

test vbsl_u8 {
    const a: u8x8 = .{ std.math.maxInt(u8), 1, std.math.maxInt(u8), 2, std.math.maxInt(u8), 0, std.math.maxInt(u8), 0 };
    const b: u8x8 = .{ std.math.maxInt(u8), std.math.maxInt(u8), std.math.maxInt(u8), std.math.maxInt(u8), std.math.maxInt(u8), std.math.maxInt(u8), std.math.maxInt(u8), std.math.maxInt(u8) };
    const c: u8x8 = .{ std.math.minInt(u8), std.math.minInt(u8), std.math.minInt(u8), std.math.minInt(u8), std.math.minInt(u8), std.math.minInt(u8), std.math.minInt(u8), std.math.minInt(u8) };
    const expected: u8x8 = .{ std.math.maxInt(u8), 1, std.math.maxInt(u8), 2, std.math.maxInt(u8), std.math.minInt(u8), std.math.maxInt(u8), std.math.minInt(u8) };

    try expectEqual(expected, vbsl_u8(a, b, c));
}

/// Bitwise Select
pub inline fn vbsl_u16(a: u16x4, b: u16x4, c: u16x4) u16x4 {
    return (a & b) | (~a & c);
}

test vbsl_u16 {
    const a: u16x4 = .{ std.math.maxInt(u16), 1, std.math.maxInt(u16), 2 };
    const b: u16x4 = .{ std.math.maxInt(u16), std.math.maxInt(u16), std.math.maxInt(u16), std.math.maxInt(u16) };
    const c: u16x4 = .{ std.math.minInt(u16), std.math.minInt(u16), std.math.minInt(u16), std.math.minInt(u16) };
    const expected: u16x4 = .{ std.math.maxInt(u16), 1, std.math.maxInt(u16), 2 };

    try expectEqual(expected, vbsl_u16(a, b, c));
}

/// Bitwise Select
pub inline fn vbsl_u32(a: u32x2, b: u32x2, c: u32x2) u32x2 {
    return (a & b) | (~a & c);
}

/// Bitwise Select
pub inline fn vbsl_u64(a: i64x1, b: i64x1, c: i64x1) i64x1 {
    return (a & b) | (~a & c);
}

/// Bitwise Select
pub inline fn vbsl_f32(a: f32x2, b: f32x2, c: f32x2) f32x2 {
    return (a & b) | (~a & c);
}

/// Bitwise Select
pub inline fn vbsl_p8(a: p8x8, b: p8x8, c: p8x8) p8x8 {
    return (a & b) | (~a & c);
}

/// Bitwise Select
pub inline fn vbsl_p16(a: p16x4, b: p16x4, c: p16x4) p16x4 {
    return (a & b) | (~a & c);
}

/// Bitwise Select
pub inline fn vbslq_s8(a: i8x16, b: i8x16, c: i8x16) i8x16 {
    return (a & b) | (~a & c);
}

/// Bitwise Select
pub inline fn vbslq_s16(a: i16x8, b: i16x8, c: i16x8) i16x8 {
    return (a & b) | (~a & c);
}

/// Bitwise Select
pub inline fn vbslq_s32(a: i32x4, b: i32x4, c: i32x4) i32x4 {
    return (a & b) | (~a & c);
}

/// Bitwise Select
pub inline fn vbslq_s64(a: i64x2, b: i64x2, c: i64x2) i64x2 {
    return (a & b) | (~a & c);
}

/// Bitwise Select
pub inline fn vbslq_u8(a: u8x16, b: u8x16, c: u8x16) u8x16 {
    return (a & b) | (~a & c);
}

/// Bitwise Select
pub inline fn vbslq_u16(a: u16x8, b: u16x8, c: u16x8) u16x8 {
    return (a & b) | (~a & c);
}

/// Bitwise Select
pub inline fn vbslq_u32(a: u32x4, b: u32x4, c: u32x4) u32x4 {
    return (a & b) | (~a & c);
}

/// Bitwise Select
pub inline fn vbslq_u64(a: i64x2, b: i64x2, c: i64x2) i64x2 {
    return (a & b) | (~a & c);
}

/// Bitwise Select
pub inline fn vbslq_f32(a: f32x4, b: f32x4, c: f32x4) f32x4 {
    return (a & b) | (~a & c);
}

/// Bitwise Select
pub inline fn vbslq_f64(a: f64x2, b: f64x2, c: f64x2) f64x2 {
    return (a & b) | (~a & c);
}

/// Bitwise Select
pub inline fn vbslq_p8(a: p8x16, b: p8x16, c: p8x16) p8x16 {
    return (a & b) | (~a & c);
}

/// Bitwise Select
pub inline fn vbslq_p16(a: p16x8, b: p16x8, c: p16x8) p16x8 {
    return (a & b) | (~a & c);
}

/// Floating-point absolute compare greater than or equal
pub inline fn vcage_f32(a: f32x2, b: f32x2) u32x2 {
    if (use_asm and AArch64.has_neon) {
        return asm volatile ("facge v0.2s, v1.2s, v2.2s"
            : [ret] "={v0}" (-> u32x2),
            : [a] "{v1}" (a),
              [b] "{v2}" (b),
        );
    } else if (use_asm and Arm.has_neon) {
        return asm volatile ("vacge.f32 d0, d0, d1"
            : [ret] "={d0}" (-> u32x2),
            : [a] "{d0}" (a),
              [b] "{d1}" (b),
        );
    } else if (use_builtins and AArch64.has_neon) {
        return struct {
            extern fn @"llvm.aarch64.neon.facge.v2i32.v2f32"(f32x2, f32x2) u32x2;
        }.@"llvm.aarch64.neon.facge.v2i32.v2f32"(a, b);
    } else if (use_builtins and Arm.has_neon) {
        return struct {
            extern fn @"llvm.arm.neon.vacge.v2i32.v2f32"(f32x2, f32x2) u32x2;
        }.@"llvm.arm.neon.vacge.v2i32.v2f32"(a, b);
    } else {
        const abs_a: f32x2 = @bitCast(@as(u32x2, @bitCast(a)) & @as(u32x2, @splat(0x7fffffff)));
        const abs_b: f32x2 = @bitCast(@as(u32x2, @bitCast(b)) & @as(u32x2, @splat(0x7fffffff)));

        const comparison = abs_a >= abs_b;

        return @select(u32, comparison, @as(u32x2, @splat(0xffffffff)), @as(u32x2, @splat(0x00000000)));
    }
}

test vcage_f32 {
    const a = f32x2{ 1.0, -2.0 };
    const b = f32x2{ 1.5, 2.0 };

    // Expected: absolute(1.0) >= absolute(1.5) -> false -> 0x00000000
    //           absolute(-2.0) >= absolute(2.0) -> true -> 0xffffffff
    const expected = u32x2{ 0x00000000, 0xffffffff };
    try testIntrinsic(vcage_f32, expected, .{ a, b });
}

/// Floating-point absolute compare greater than or equal
pub inline fn vcageq_f32(a: f32x4, b: f32x4) u32x4 {
    if (use_asm and AArch64.has_neon) {
        return asm volatile ("facge v0.4s, v1.4s, v2.4s"
            : [ret] "={v0}" (-> u32x4),
            : [a] "{v1}" (a),
              [b] "{v2}" (b),
        );
    } else if (use_asm and Arm.has_neon) {
        return asm volatile ("vacge.f32 q0, q0, q1"
            : [ret] "={q0}" (-> u32x4),
            : [a] "{q0}" (a),
              [b] "{q1}" (b),
        );
    } else if (use_builtins and AArch64.has_neon) {
        return struct {
            extern fn @"llvm.aarch64.neon.facge.v4i32.v4f32"(f32x4, f32x4) u32x4;
        }.@"llvm.aarch64.neon.facge.v4i32.v4f32"(a, b);
    } else if (use_builtins and Arm.has_neon) {
        return struct {
            extern fn @"llvm.arm.neon.vacge.v4i32.v4f32"(f32x4, f32x4) u32x4;
        }.@"llvm.arm.neon.vacge.v4i32.v4f32"(a, b);
    } else {
        const abs_a: f32x4 = @bitCast(@as(u32x4, @bitCast(a)) & @as(u32x4, @splat(0x7fffffff)));
        const abs_b: f32x4 = @bitCast(@as(u32x4, @bitCast(b)) & @as(u32x4, @splat(0x7fffffff)));

        const comparison = abs_a >= abs_b;

        return @select(u32, comparison, @as(u32x4, @splat(0xffffffff)), @as(u32x4, @splat(0x00000000)));
    }
}

test vcageq_f32 {
    const a = f32x4{ 1.0, -2.0, 3.0, -4.0 };
    const b = f32x4{ 1.5, 2.0, -2.5, 4.0 };

    // Expected: absolute(1.0) >= absolute(1.5) -> false -> 0x00000000
    //           absolute(-2.0) >= absolute(2.0) -> true -> 0xffffffff
    //           absolute(3.0) >= absolute(-2.5) -> true -> 0xffffffff
    //           absolute(-4.0) >= absolute(4.0) -> true -> 0xffffffff
    const expected = u32x4{ 0x00000000, 0xffffffff, 0xffffffff, 0xffffffff };
    try testIntrinsic(vcageq_f32, expected, .{ a, b });
}

/// Floating-point absolute compare greater than or equal
pub inline fn vcageq_f64(a: f64x2, b: f64x2) u64x2 {
    if (use_asm and AArch64.has_neon) {
        return asm volatile ("facge v0.2d, v1.2d, v2.2d"
            : [ret] "={v0}" (-> u64x2),
            : [a] "{v1}" (a),
              [b] "{v2}" (b),
        );
    } else if (use_builtins and AArch64.has_neon) {
        return struct {
            extern fn @"llvm.aarch64.neon.facge.v2i64.v2f64"(f64x2, f64x2) u64x2;
        }.@"llvm.aarch64.neon.facge.v2i64.v2f64"(a, b);
    } else {
        const abs_mask: u64x2 = @splat(0x7fffffffffffffff);

        const abs_a: f64x2 = @bitCast(@as(u64x2, @bitCast(a)) & abs_mask);
        const abs_b: f64x2 = @bitCast(@as(u64x2, @bitCast(b)) & abs_mask);

        const comparison = abs_a >= abs_b;

        return @select(u64, comparison, @as(u64x2, @splat(0xffffffffffffffff)), @as(u64x2, @splat(0x0000000000000000)));
    }
}

test vcageq_f64 {
    const a = f64x2{ 1.0, -4.0 };
    const b = f64x2{ 1.5, 3.0 };

    // Expected: absolute(1.0) >= absolute(1.5) -> false -> 0x0000000000000000
    //           absolute(-4.0) >= absolute(3.0) -> true -> 0xffffffffffffffff
    const expected = u64x2{ 0x0000000000000000, 0xffffffffffffffff };
    try testIntrinsic(vcageq_f64, expected, .{ a, b });
}

/// Floating-point absolute compare greater than
pub inline fn vcagt_f32(a: f32x2, b: f32x2) u32x2 {
    if (use_asm and AArch64.has_neon) {
        return asm volatile ("facgt v0.2s, v1.2s, v2.2s"
            : [ret] "={v0}" (-> u32x2),
            : [a] "{v1}" (a),
              [b] "{v2}" (b),
        );
    } else if (use_asm and Arm.has_neon) {
        return asm volatile ("vacgt.f32 d0, d0, d1"
            : [ret] "={d0}" (-> u32x2),
            : [a] "{d0}" (a),
              [b] "{d1}" (b),
        );
    } else if (use_builtins and AArch64.has_neon) {
        return struct {
            extern fn @"llvm.aarch64.neon.facgt.v2i32.v2f32"(f32x2, f32x2) u32x2;
        }.@"llvm.aarch64.neon.facgt.v2i32.v2f32"(a, b);
    } else if (use_builtins and Arm.has_neon) {
        return struct {
            extern fn @"llvm.arm.neon.vacgt.v2i32.v2f32"(f32x2, f32x2) u32x2;
        }.@"llvm.arm.neon.vacgt.v2i32.v2f32"(a, b);
    } else {
        const abs_a: f32x2 = @abs(a);
        const abs_b: f32x2 = @abs(b);

        const comparison = abs_a > abs_b;

        return @select(u32, comparison, @as(u32x2, @splat(0xffffffff)), @as(u32x2, @splat(0x00000000)));
    }
}

test vcagt_f32 {
    const a = f32x2{ -1.2, 0.0 };
    const b = f32x2{ -1.1, 0.0 };

    const expected = u32x2{ 0xffffffff, 0x00000000 };
    try testIntrinsic(vcagt_f32, expected, .{ a, b });
}

/// Shift right
pub inline fn vshrq_n_s8(a: i8x16, n: u8) i8x16 {
    return @as(u8x16, @bitCast(a)) >> @as(u8x16, @splat(n));
}

/// Shift right
pub inline fn vshrq_n_s16(a: i16x8, n: u16) i16x8 {
    return @as(u16x8, @bitCast(a)) >> @as(u16x8, @splat(n));
}

/// Shift right
pub inline fn vshrq_n_s32(a: i32x4, n: u32) i32x4 {
    return @as(u32x4, @bitCast(a)) >> @as(u32x4, @splat(n));
}

/// Shift right
pub inline fn vshrq_n_s64(a: u64x2, n: u64) i64x2 {
    return a >> @as(u64x2, @splat(n));
}

/// Shift right
pub inline fn vshrq_n_u8(a: u8x16, n: u8) u8x16 {
    return a >> @as(u8x16, @splat(n));
}

/// Shift right
pub inline fn vshrq_n_u16(a: u16x8, n: u16) u16x8 {
    return a >> @as(u16x8, @splat(n));
}

/// Shift right
pub inline fn vshrq_n_u32(a: u32x4, n: u32) u32x4 {
    return a >> @as(u32x4, @splat(n));
}

/// Shift right
pub inline fn vshrq_n_u64(a: u64x2, n: u64) u64x2 {
    return a >> @as(u64x2, @splat(n));
}
