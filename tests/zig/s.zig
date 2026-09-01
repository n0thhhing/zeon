const std = @import("std");
const builtin = @import("builtin");
const simd = std.simd;
const assert = std.debug.assert;
const expectEqual = std.testing.expectEqual;
const arch = builtin.target.cpu.arch;
const features = builtin.cpu.features;
const endianness = arch.endian();

const build_options = .{
    .test_asm = false,
    .test_builtins = false,
};

const aarch64 = struct {
    pub const is_aarch64 = arch == .aarch64 or arch == .aarch64_be;

    /// Checks if the current CPU is aarch64 and has the input features
    pub fn hasFeatures(comptime aarch64_features: []const std.Target.aarch64.Feature) bool {
        if (!@inComptime()) @panic("Please move this into comptime, orelse it will result in an unnecessary branch");
        inline for (aarch64_features) |f| {
            const has_feature = aarch64.is_aarch64 and std.Target.aarch64.featureSetHas(features, f);
            if (!has_feature) return false;
        }
        return true;
    }
};

const arm = struct {
    pub const is_arm = arch == .arm or arch == .armeb or arch == .thumb;

    /// Checks if the current CPU is arm and has the input features
    pub inline fn hasFeatures(comptime arm_features: []const std.Target.arm.Feature) bool {
        if (!@inComptime()) @panic("Please move this into comptime, orelse it will result in an unnecessary branch");
        inline for (arm_features) |f| {
            const has_feature = arm.is_arm and std.Target.arm.featureSetHas(features, f);
            if (!has_feature) return false;
        }
        return true;
    }
};

const is_arm = arm.is_arm;
const is_aarch64 = aarch64.is_aarch64;

/// Max bitsize for vectors on arm/aarch64
///
/// TODO: aarch64 isnt always limited to 128
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

const has_llvm_backend = builtin.zig_backend != .stage2_llvm;

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

pub const poly8 = p8;
pub const poly16 = p16;
pub const poly64 = p64;
pub const poly128 = p128;

pub const int8x8 = u8x8;
pub const int8x16 = u8x16;
pub const int16x4 = u16x4;
pub const int16x8 = u16x8;
pub const int32x2 = u32x2;
pub const int32x4 = u32x4;
pub const int64x1 = u64x1;
pub const int64x2 = u64x2;

pub const uint8x8 = u8x8;
pub const uint8x16 = u8x16;
pub const uint16x4 = u16x4;
pub const uint16x8 = u16x8;
pub const uint32x2 = u32x2;
pub const uint32x4 = u32x4;
pub const uint64x1 = u64x1;
pub const uint64x2 = u64x2;

pub const float16x4 = f16x4;
pub const float16x8 = f16x8;
pub const float32x2 = f32x2;
pub const float32x4 = f32x4;
pub const float64x1 = f64x1;
pub const float64x2 = f64x2;

pub const poly8x8 = p8x8;
pub const poly8x16 = p8x16;
pub const poly16x4 = p16x4;
pub const poly16x8 = p16x8;
pub const poly64x1 = p64x1;
pub const poly64x2 = p64x2;

pub const int8x8x2 = u8x8x2;
pub const int8x16x2 = u8x16x2;
pub const int16x4x2 = u16x4x2;
pub const int16x8x2 = u16x8x2;
pub const int32x2x2 = u32x2x2;
pub const int32x4x2 = u32x4x2;
pub const int64x1x2 = u64x1x2;
pub const int64x2x2 = u64x2x2;

pub const uint8x8x2 = u8x8x2;
pub const uint8x16x2 = u8x16x2;
pub const uint16x4x2 = u16x4x2;
pub const uint16x8x2 = u16x8x2;
pub const uint32x2x2 = u32x2x2;
pub const uint32x4x2 = u32x4x2;
pub const uint64x1x2 = u64x1x2;
pub const uint64x2x2 = u64x2x2;

pub const float16x4x2 = f16x4x2;
pub const float16x8x2 = f16x8x2;
pub const float32x2x2 = f32x2x2;
pub const float32x4x2 = f32x4x2;
pub const float64x1x2 = f64x1x2;
pub const float64x2x2 = f64x2x2;

pub const poly8x8x2 = p8x8x2;
pub const poly8x16x2 = p8x16x2;
pub const poly16x4x2 = p16x4x2;
pub const poly16x8x2 = p16x8x2;
pub const poly64x1x2 = p64x1x2;
pub const poly64x2x2 = p64x2x2;

pub const int8x8x3 = u8x8x3;
pub const int8x16x3 = u8x16x3;
pub const int16x4x3 = u16x4x3;
pub const int16x8x3 = u16x8x3;
pub const int32x2x3 = u32x2x3;
pub const int32x4x3 = u32x4x3;
pub const int64x1x3 = u64x1x3;
pub const int64x2x3 = u64x2x3;

pub const uint8x8x3 = u8x8x3;
pub const uint8x16x3 = u8x16x3;
pub const uint16x4x3 = u16x4x3;
pub const uint16x8x3 = u16x8x3;
pub const uint32x2x3 = u32x2x3;
pub const uint32x4x3 = u32x4x3;
pub const uint64x1x3 = u64x1x3;
pub const uint64x2x3 = u64x2x3;

pub const float16x4x3 = f16x4x3;
pub const float16x8x3 = f16x8x3;
pub const float32x2x3 = f32x2x3;
pub const float32x4x3 = f32x4x3;
pub const float64x1x3 = f64x1x3;
pub const float64x2x3 = f64x2x3;

pub const poly8x8x3 = p8x8x3;
pub const poly8x16x3 = p8x16x3;
pub const poly16x4x3 = p16x4x3;
pub const poly16x8x3 = p16x8x3;
pub const poly64x1x3 = p64x1x3;
pub const poly64x2x3 = p64x2x3;

pub const int8x8x4 = u8x8x4;
pub const int8x16x4 = u8x16x4;
pub const int16x4x4 = u16x4x4;
pub const int16x8x4 = u16x8x4;
pub const int32x2x4 = u32x2x4;
pub const int32x4x4 = u32x4x4;
pub const int64x1x4 = u64x1x4;
pub const int64x2x4 = u64x2x4;

pub const uint8x8x4 = u8x8x4;
pub const uint8x16x4 = u8x16x4;
pub const uint16x4x4 = u16x4x4;
pub const uint16x8x4 = u16x8x4;
pub const uint32x2x4 = u32x2x4;
pub const uint32x4x4 = u32x4x4;
pub const uint64x1x4 = u64x1x4;
pub const uint64x2x4 = u64x2x4;

pub const float16x4x4 = f16x4x4;
pub const float16x8x4 = f16x8x4;
pub const float32x2x4 = f32x2x4;
pub const float32x4x4 = f32x4x4;
pub const float64x1x4 = f64x1x4;
pub const float64x2x4 = f64x2x4;

pub const poly8x8x4 = p8x8x4;
pub const poly8x16x4 = p8x16x4;
pub const poly16x4x4 = p16x4x4;
pub const poly16x8x4 = p16x8x4;
pub const poly64x1x4 = p64x1x4;
pub const poly64x2x4 = p64x2x4;

pub const poly8_t = p8;
pub const poly16_t = p16;
pub const poly64_t = p64;
pub const poly128_t = p128;

pub const int8x8_t = u8x8;
pub const int8x16_t = u8x16;
pub const int16x4_t = u16x4;
pub const int16x8_t = u16x8;
pub const int32x2_t = u32x2;
pub const int32x4_t = u32x4;
pub const int64x1_t = u64x1;
pub const int64x2_t = u64x2;

pub const uint8x8_t = u8x8;
pub const uint8x16_t = u8x16;
pub const uint16x4_t = u16x4;
pub const uint16x8_t = u16x8;
pub const uint32x2_t = u32x2;
pub const uint32x4_t = u32x4;
pub const uint64x1_t = u64x1;
pub const uint64x2_t = u64x2;

pub const float16x4_t = f16x4;
pub const float16x8_t = f16x8;
pub const float32x2_t = f32x2;
pub const float32x4_t = f32x4;
pub const float64x1_t = f64x1;
pub const float64x2_t = f64x2;

pub const poly8x8_t = p8x8;
pub const poly8x16_t = p8x16;
pub const poly16x4_t = p16x4;
pub const poly16x8_t = p16x8;
pub const poly64x1_t = p64x1;
pub const poly64x2_t = p64x2;

pub const int8x8x2_t = u8x8x2;
pub const int8x16x2_t = u8x16x2;
pub const int16x4x2_t = u16x4x2;
pub const int16x8x2_t = u16x8x2;
pub const int32x2x2_t = u32x2x2;
pub const int32x4x2_t = u32x4x2;
pub const int64x1x2_t = u64x1x2;
pub const int64x2x2_t = u64x2x2;

pub const uint8x8x2_t = u8x8x2;
pub const uint8x16x2_t = u8x16x2;
pub const uint16x4x2_t = u16x4x2;
pub const uint16x8x2_t = u16x8x2;
pub const uint32x2x2_t = u32x2x2;
pub const uint32x4x2_t = u32x4x2;
pub const uint64x1x2_t = u64x1x2;
pub const uint64x2x2_t = u64x2x2;

pub const float16x4x2_t = f16x4x2;
pub const float16x8x2_t = f16x8x2;
pub const float32x2x2_t = f32x2x2;
pub const float32x4x2_t = f32x4x2;
pub const float64x1x2_t = f64x1x2;
pub const float64x2x2_t = f64x2x2;

pub const poly8x8x2_t = p8x8x2;
pub const poly8x16x2_t = p8x16x2;
pub const poly16x4x2_t = p16x4x2;
pub const poly16x8x2_t = p16x8x2;
pub const poly64x1x2_t = p64x1x2;
pub const poly64x2x2_t = p64x2x2;

pub const int8x8x3_t = u8x8x3;
pub const int8x16x3_t = u8x16x3;
pub const int16x4x3_t = u16x4x3;
pub const int16x8x3_t = u16x8x3;
pub const int32x2x3_t = u32x2x3;
pub const int32x4x3_t = u32x4x3;
pub const int64x1x3_t = u64x1x3;
pub const int64x2x3_t = u64x2x3;

pub const uint8x8x3_t = u8x8x3;
pub const uint8x16x3_t = u8x16x3;
pub const uint16x4x3_t = u16x4x3;
pub const uint16x8x3_t = u16x8x3;
pub const uint32x2x3_t = u32x2x3;
pub const uint32x4x3_t = u32x4x3;
pub const uint64x1x3_t = u64x1x3;
pub const uint64x2x3_t = u64x2x3;

pub const float16x4x3_t = f16x4x3;
pub const float16x8x3_t = f16x8x3;
pub const float32x2x3_t = f32x2x3;
pub const float32x4x3_t = f32x4x3;
pub const float64x1x3_t = f64x1x3;
pub const float64x2x3_t = f64x2x3;

pub const poly8x8x3_t = p8x8x3;
pub const poly8x16x3_t = p8x16x3;
pub const poly16x4x3_t = p16x4x3;
pub const poly16x8x3_t = p16x8x3;
pub const poly64x1x3_t = p64x1x3;
pub const poly64x2x3_t = p64x2x3;

pub const int8x8x4_t = u8x8x4;
pub const int8x16x4_t = u8x16x4;
pub const int16x4x4_t = u16x4x4;
pub const int16x8x4_t = u16x8x4;
pub const int32x2x4_t = u32x2x4;
pub const int32x4x4_t = u32x4x4;
pub const int64x1x4_t = u64x1x4;
pub const int64x2x4_t = u64x2x4;

pub const uint8x8x4_t = u8x8x4;
pub const uint8x16x4_t = u8x16x4;
pub const uint16x4x4_t = u16x4x4;
pub const uint16x8x4_t = u16x8x4;
pub const uint32x2x4_t = u32x2x4;
pub const uint32x4x4_t = u32x4x4;
pub const uint64x1x4_t = u64x1x4;
pub const uint64x2x4_t = u64x2x4;

pub const float16x4x4_t = f16x4x4;
pub const float16x8x4_t = f16x8x4;
pub const float32x2x4_t = f32x2x4;
pub const float32x4x4_t = f32x4x4;
pub const float64x1x4_t = f64x1x4;
pub const float64x2x4_t = f64x2x4;

pub const poly8x8x4_t = p8x8x4;
pub const poly8x16x4_t = p8x16x4;
pub const poly16x4x4_t = p16x4x4;
pub const poly16x8x4_t = p16x8x4;
pub const poly64x1x4_t = p64x1x4;
pub const poly64x2x4_t = p64x2x4;

pub const v8i8 = u8x8;
pub const v16i8 = u8x16;
pub const v4i16 = u16x4;
pub const v8i16 = u16x8;
pub const v2i32 = u32x2;
pub const v4i32 = u32x4;
pub const v1i64 = u64x1;
pub const v2i64 = u64x2;

pub const v8u8 = u8x8;
pub const v16u8 = u8x16;
pub const v4u16 = u16x4;
pub const v8u16 = u16x8;
pub const v2u32 = u32x2;
pub const v4u32 = u32x4;
pub const v1u64 = u64x1;
pub const v2u64 = u64x2;

pub const v4f16 = f16x4;
pub const v8f16 = f16x8;
pub const v2f32 = f32x2;
pub const v4f32 = f32x4;
pub const v1f64 = f64x1;
pub const v2f64 = f64x2;

pub const v8p8 = p8x8;
pub const v16p8 = p8x16;
pub const v4p16 = p16x4;
pub const v8p16 = p16x8;
pub const v1p64 = p64x1;
pub const v2p64 = p64x2;

/// Load multiple single-element structures to one, two, three, or four registers
export fn vld1q_u8(mem_addr: [*]const u8) u8x16 {
    return .{ mem_addr[0], mem_addr[1], mem_addr[2], mem_addr[3], mem_addr[4], mem_addr[5], mem_addr[6], mem_addr[7], mem_addr[8], mem_addr[9], mem_addr[10], mem_addr[11], mem_addr[12], mem_addr[13], mem_addr[14], mem_addr[15] };
}
