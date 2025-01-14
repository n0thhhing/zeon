const std = @import("std");
const builtin = @import("builtin");
const simd = std.simd;
const assert = std.debug.assert;
const expectEqual = std.testing.expectEqual;
const arch = builtin.target.cpu.arch;
const features = builtin.cpu.features;
const endianness = arch.endian();

const aarch64 = @import("./aarch64.zig");
const arm = @import("./arm.zig");

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

/// Specifies if we should use inline assembly. Note that this will take
/// priority over use_builtins when it can. Also, if your current target
/// isnt AArch/arm, inline assembly wont be used even if this is enabled.
pub var use_asm = true;

/// Specifies if we should use llvm builtins. If your current target
/// isnt AArch/arm, builtins wont be used even if this is enabled.
pub var use_builtins = blk: {
    if (builtin.zig_backend != .stage2_llvm)
        break :blk false
    else
        break :blk true;
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

/// Basically @typeName(@TypeOf(fn)) but with the function name included;
inline fn fmtFn(comptime fn_name: []const u8, comptime func: std.builtin.Type.Fn) []const u8 {
    comptime var str: []const u8 = "fn " ++ fn_name ++ "(";
    inline for (func.params, 0..) |params, i| {
        const param_type = if (params.type != null) @typeName(params.type.?) else "unknown";
        str = str ++ param_type ++ if (i == func.params.len - 1) "" else ", ";
    }
    str = str ++ ") callconv(." ++ @tagName(func.calling_convention) ++ ")" ++ if (func.return_type != null) " " ++ @typeName(func.return_type.?) else "";
    return str;
}

test fmtFn {
    try std.testing.expectEqualStrings("fn fmtFn([]const u8, builtin.Type.Fn) callconv(.Inline) []const u8", fmtFn("fmtFn", @typeInfo(@TypeOf(fmtFn)).Fn));
}

/// Helps test builtins and inline assembly
fn testIntrinsic(comptime fn_name: []const u8, func: anytype, expected: anytype, args: anytype) !void {
    const arch_features = blk: {
        if (is_aarch64) {
            break :blk .{
                .neon = comptime aarch64.hasFeatures(&.{.neon}),
                .aes = comptime aarch64.hasFeatures(&.{.aes}),
                .rdm = comptime aarch64.hasFeatures(&.{.rdm}),
                .sha2 = comptime aarch64.hasFeatures(&.{.sha2}),
                .sha3 = comptime aarch64.hasFeatures(&.{.sha3}),
                .dotprod = comptime aarch64.hasFeatures(&.{.dotprod}),
                .i8mm = comptime aarch64.hasFeatures(&.{.i8mm}),
                .sm4 = comptime aarch64.hasFeatures(&.{.sm4}),
                .crypto = comptime aarch64.hasFeatures(&.{.crypto}),
                .sve = comptime aarch64.hasFeatures(&.{.sve}),
            };
        } else if (is_arm) {
            break :blk .{
                .neon = comptime arm.hasFeatures(&.{.neon}),
                .aes = comptime arm.hasFeatures(&.{.aes}),
                .sha2 = comptime arm.hasFeatures(&.{.sha2}),
                .crc = comptime arm.hasFeatures(&.{.crc}),
                .dotprod = comptime arm.hasFeatures(&.{.dotprod}),
                .v7 = comptime arm.hasFeatures(&.{.has_v7}),
                .v8 = comptime arm.hasFeatures(&.{.has_v8}),
                .i8mm = comptime arm.hasFeatures(&.{.i8mm}),
            };
        } else {
            break :blk .{};
        }
    };

    if (is_aarch64 or is_arm) {
        inline for (.{ .{ true, false }, .{ false, true }, .{ false, false } }) |opts| {
            const asm_opt = opts[0];
            const builtin_opt = opts[1];

            // Skip LLVM-specific tests if not using LLVM as a backend
            if (opts[1] and builtin.zig_backend != .stage2_llvm) {
                std.once(struct {
                    pub fn cb() void {
                        @compileLog("Skipping LLVM builtin tests: Non-LLVM backend detected.");
                    }
                }.cb);
                continue;
            }

            use_asm = asm_opt;
            use_builtins = builtin_opt;

            const result = @call(.auto, func, args);
            expectEqual(expected, result) catch |err| {
                printError(fn_name, func, expected, result, args, arch_features);
                return err;
            };
        }

        use_asm = true;
        use_builtins = true;
    } else {
        const result = @call(.auto, func, args);
        try expectEqual(expected, result);
    }
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
        \\    Use Asm: {}
        \\    Use Builtins: {}
        \\
        \\
    ;

    std.debug.print(fmt_str, .{
        fmtFn(fn_name, @typeInfo(T).Fn),
        args,
        expected,
        result,
        @tagName(arch),
        std.fmt.comptimePrint("{any}", .{arch_features}),
        @tagName(endianness),
        use_asm,
        use_builtins,
    });
}

inline fn numToString(comptime n: usize) []const u8 {
    return std.fmt.comptimePrint("{d}", .{n});
}

test numToString {
    try std.testing.expectEqualStrings("5", numToString(5));
}

/// Gets the length of a vector
inline fn vecLen(comptime T: anytype) usize {
    const type_info = @typeInfo(T);

    comptime assert(type_info == .Vector);
    return type_info.Vector.len;
}

test vecLen {
    try expectEqual(8, vecLen(u8x8));
}

/// Joins two vectors
inline fn join(
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
    const a: i8x8 = @splat(0);
    const b: i8x8 = @splat(1);
    const expected: i8x16 = .{ 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1 };

    try expectEqual(expected, join(a, b));
}

/// Promotes the Child type of the vector `T`
inline fn PromoteVector(comptime T: type) type {
    var type_info = @typeInfo(T);

    comptime assert(type_info == .Vector);
    var child_info = @typeInfo(std.meta.Child(T));
    switch (child_info) {
        .Int => child_info.Int.bits *= 2,
        else => child_info.Float.bits *= 2,
    }
    type_info.Vector.child = @Type(child_info);
    return @Type(type_info);
}

test PromoteVector {
    try expectEqual(i16x8, comptime PromoteVector(i8x8));
}

/// Checks if the bitsize of `T` exceeds the maximum
/// bitsize for Vectors(128 on AArch/arm)
///
/// TODO: Technically were targeting more than
///       just AArch/arm, so if we have support
///       for larger vectors on the current cpu
///       we use that instead to avoid unnecessarily
///       splitting vectors.
inline fn toLarge(comptime T: type) bool {
    const Child = std.meta.Child(T);
    const bit_size = @typeInfo(Child).Int.bits * @typeInfo(T).Vector.len;
    return bit_size > VEC_MAX_BITSIZE;
}

test toLarge {
    try expectEqual(true, toLarge(@Vector(17, u8)));
    try expectEqual(false, toLarge(@Vector(16, u8)));
}

/// Absolute difference between arguments
///
/// TODO: If we are using AArch/arm, then we can
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

    {
        const a: i8x1 = .{127};
        const b: i8x1 = .{-1};
        try expectEqual(i8x1{-128}, abd(a, b));
    }
    {
        const a: u8x1 = .{0};
        const b: u8x1 = .{2};
        try expectEqual(u8x1{2}, abd(a, b));
    }
    {
        const a: i8x1 = .{-128};
        const b: i8x1 = .{127};
        try expectEqual(i8x1{-1}, abd(a, b));
    }
    {
        const a: f32x1 = .{3.4028235e38};
        const b: f32x1 = .{-1};
        try expectEqual(f32x1{std.math.floatMax(f32)}, abd(a, b));
    }
    {
        const a: i8x1 = .{127};
        const b: i8x1 = .{-3};
        try expectEqual(i8x1{-126}, abd(a, b));
    }
    {
        const a: i8x2 = .{ -65, -75 };
        const b: i8x2 = .{ 65, 75 };
        try expectEqual(i8x2{ -126, -106 }, abd(a, b));
    }
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

test vget_high_s16 {
    const v: i16x8 = .{ 0, 1, 2, 3, 4, 5, 6, 7 };
    const expected: i16x4 = .{ 4, 5, 6, 7 };

    try expectEqual(expected, vget_high_s16(v));
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

test vget_high_s32 {
    const v: i32x4 = .{ 0, 1, 2, 3 };
    const expected: i32x2 = .{ 2, 3 };

    try expectEqual(expected, vget_high_s32(v));
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

test vget_high_s64 {
    const v: i64x2 = .{ 0, 1 };
    const expected: i64x1 = .{1};

    try expectEqual(expected, vget_high_s64(v));
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

test vget_high_f16 {
    const v: f16x8 = .{ 0, 1, 2, 3, 4, 5, 6, 7 };
    const expected: f16x4 = .{ 4, 5, 6, 7 };

    try expectEqual(expected, vget_high_f16(v));
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

test vget_high_f32 {
    const v: f32x4 = .{ 0, 1, 2, 3 };
    const expected: f32x2 = .{ 2, 3 };

    try expectEqual(expected, vget_high_f32(v));
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

test vget_high_f64 {
    const v: f64x2 = .{ 0, 1 };
    const expected: f64x1 = .{1};

    try expectEqual(expected, vget_high_f64(v));
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

test vget_high_u8 {
    const v: u8x16 = .{ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 };
    const expected: u8x8 = .{ 8, 9, 10, 11, 12, 13, 14, 15 };

    try expectEqual(expected, vget_high_u8(v));
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

test vget_high_u16 {
    const v: u16x8 = .{ 0, 1, 2, 3, 4, 5, 6, 7 };
    const expected: u16x4 = .{ 4, 5, 6, 7 };

    try expectEqual(expected, vget_high_u16(v));
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

test vget_high_u32 {
    const v: u32x4 = .{ 0, 1, 2, 3 };
    const expected: u32x2 = .{ 2, 3 };

    try expectEqual(expected, vget_high_u32(v));
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

test vget_high_u64 {
    const v: u64x2 = .{ 0, 1 };
    const expected: u64x1 = .{1};

    try expectEqual(expected, vget_high_u64(v));
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

test vget_high_p8 {
    const v: p8x16 = .{ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 };
    const expected: p8x8 = .{ 8, 9, 10, 11, 12, 13, 14, 15 };

    try expectEqual(expected, vget_high_p8(v));
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

test vget_high_p16 {
    const v: p16x8 = .{ 0, 1, 2, 3, 4, 5, 6, 7 };
    const expected: p16x4 = .{ 4, 5, 6, 7 };

    try expectEqual(expected, vget_high_p16(v));
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

/// Get low elements of a f16x8 vector
pub inline fn vget_low_f16(vec: f16x8) f16x4 {
    return @shuffle(
        f16,
        vec,
        undefined,
        f16x4{ 0, 1, 2, 3 },
    );
}

/// Get low elements of a f32x4 vector
pub inline fn vget_low_f32(vec: f32x4) f32x2 {
    return @shuffle(
        f32,
        vec,
        undefined,
        f32x2{ 0, 1 },
    );
}

/// Get low elements of a f64x2 vector
pub inline fn vget_low_f64(vec: f64x2) f64x1 {
    return @shuffle(
        f64,
        vec,
        undefined,
        f64x1{0},
    );
}

/// Vector long move
pub inline fn vmovl_s8(a: i8x8) i16x8 {
    // This would compile down to sshll v0.8h, v0.8b, #0
    // in aarch64 and vmov d16, r0, r1; vmovl.s8 q8, d16;
    // vmov r0, r1, d16; vmov r2, r3, d17; in arm(would be
    // the same if we do use inline assembly), but it still
    // has the same result, therefore we wont need inline
    // assembly here.
    return @as(i16x8, a);
}

test vmovl_s8 {
    const v: i8x8 = .{ 0, -1, -2, -3, -4, -5, -6, -7 };

    try expectEqual(i16x8{ 0, -1, -2, -3, -4, -5, -6, -7 }, vmovl_s8(v));
}

/// Vector long move
pub inline fn vmovl_s16(a: i16x4) i32x4 {
    return @as(i32x4, a);
}

test vmovl_s16 {
    const v: i16x4 = .{ 0, -1, -2, -3 };
    try expectEqual(@as(i32x4, .{ 0, -1, -2, -3 }), vmovl_s16(v));
}

/// Vector long move
pub inline fn vmovl_s32(a: i32x2) i64x2 {
    return @as(i64x2, a);
}

test vmovl_s32 {
    const v: i32x2 = .{ 0, -1 };
    try expectEqual(@as(i32x2, .{ 0, -1 }), vmovl_s32(v));
}

/// Vector long move
pub inline fn vmovl_u8(a: u8x8) u16x8 {
    return @as(u16x8, a);
}

test vmovl_u8 {
    const v: u8x8 = .{ 0, 1, 2, 3, 4, 5, 6, 7 };
    try expectEqual(@as(u16x8, .{ 0, 1, 2, 3, 4, 5, 6, 7 }), vmovl_u8(v));
}

/// Vector long move
pub inline fn vmovl_u16(a: u16x4) u32x4 {
    return @as(u32x4, a);
}

test vmovl_u16 {
    const v: u16x4 = .{ 0, 1, 2, 3 };
    try expectEqual(@as(u32x4, .{ 0, 1, 2, 3 }), vmovl_u16(v));
}

/// Vector long move
pub inline fn vmovl_u32(a: u32x2) u64x2 {
    return @as(u64x2, a);
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
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        switch (endianness) {
            inline .little => {
                return asm ("smull %[ret].8h, %[a].8b, %[b].8b"
                    : [ret] "=w" (-> i16x8),
                    : [a] "w" (a),
                      [b] "w" (b),
                );
            },
            inline .big => {
                return asm (
                    \\ smull %[ret].8h, %[a].8b, %[b].8b
                    \\ rev16 %[ret].16b, %[ret].16b
                    \\ rev64 %[ret].8h, %[ret].8h
                    \\ ext   %[ret].16b, %[ret].16b, %[ret].16b, #8
                    : [ret] "=w" (-> i16x8),
                    : [a] "w" (a),
                      [b] "w" (b),
                );
            },
        }
    } else if (use_asm and comptime arm.hasFeatures(&.{.neon})) {
        return asm ("vmull.s8 %[ret], %[a], %[b]"
            : [ret] "=w" (-> i16x8),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else if (use_builtins and comptime aarch64.hasFeatures(&.{.neon})) {
        return struct {
            extern fn @"llvm.aarch64.neon.smull.v8i16"(i8x8, i8x8) i16x8;
        }.@"llvm.aarch64.neon.smull.v8i16"(a, b);
    } else if (use_builtins and comptime arm.hasFeatures(&.{.neon})) {
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
    try testIntrinsic("vmull_s8", vmull_s8, i16x8{ 0, 0, 0, 0, 0, 0, 0, 254 }, .{ a, b });
}

/// Signed multiply long
pub inline fn vmull_s16(a: i16x4, b: i16x4) i32x4 {
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        switch (endianness) {
            inline .little => {
                return asm volatile ("smull %[ret].4s, %[a].4h, %[b].4h"
                    : [ret] "=w" (-> i32x4),
                    : [a] "w" (a),
                      [b] "w" (b),
                );
            },
            inline .big => {
                return asm (
                    \\ smull %[ret].4s, %[a].4h, %[b].4h
                    \\ rev32 %[ret].16b, %[ret].16b
                    \\ rev64 %[ret].4s, %[ret].4s
                    \\ ext   %[ret].16b, %[ret].16b, %[ret].16b, #8
                    : [ret] "=w" (-> i32x4),
                    : [a] "w" (a),
                      [b] "w" (b),
                );
            },
        }
    } else if (use_asm and comptime arm.hasFeatures(&.{.neon})) {
        return asm ("vmull.s16 %[ret], %[a], %[b]"
            : [ret] "=w" (-> i32x4),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else if (use_builtins and comptime aarch64.hasFeatures(&.{.neon})) {
        return struct {
            extern fn @"llvm.aarch64.neon.smull.v4i32"(i16x4, i16x4) i32x4;
        }.@"llvm.aarch64.neon.smull.v4i32"(a, b);
    } else if (use_builtins and comptime arm.hasFeatures(&.{.neon})) {
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

    try testIntrinsic("vmull_s16", vmull_s16, i32x4{ 0, -1 * 5, -2 * 5, -3 * 5 }, .{ a, b });
}

/// Signed multiply long
pub inline fn vmull_s32(a: i32x2, b: i32x2) i64x2 {
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        switch (endianness) {
            inline .little => {
                return asm ("smull %[ret].2d, %[a].2s, %[b].2s"
                    : [ret] "=w" (-> i64x2),
                    : [a] "w" (a),
                      [b] "w" (b),
                );
            },
            inline .big => {
                return asm (
                    \\ smull %[ret].2d, %[a].2s, %[b].2s
                    \\ rev64 %[ret].16b, %[ret].16b
                    \\ ext   %[ret].16b, %[ret].16b, %[ret].16b, #8
                    : [ret] "=w" (-> i64x2),
                    : [a] "w" (a),
                      [b] "w" (b),
                );
            },
        }
    } else if (use_asm and comptime arm.hasFeatures(&.{.neon})) {
        return asm ("vmull.s32 %[ret], %[a], %[b]"
            : [ret] "=w" (-> i64x2),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else if (use_builtins and comptime aarch64.hasFeatures(&.{.neon})) {
        return struct {
            extern fn @"llvm.aarch64.neon.smull.v2i64"(i32x2, i32x2) i64x2;
        }.@"llvm.aarch64.neon.smull.v2i64"(a, b);
    } else if (use_builtins and comptime arm.hasFeatures(&.{.neon})) {
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

    try testIntrinsic("vmull_s32", vmull_s32, i32x2{ 0, -5 }, .{ a, b });
}

/// Unsigned multiply long
pub inline fn vmull_u8(a: u8x8, b: u8x8) u16x8 {
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        switch (endianness) {
            inline .little => {
                return asm ("umull %[ret].8h, %[a].8b, %[b].8b"
                    : [ret] "=w" (-> u16x8),
                    : [a] "w" (a),
                      [b] "w" (b),
                );
            },
            inline .big => {
                return asm (
                    \\ umull %[ret].8h, %[a].8b, %[b].8b
                    \\ rev16 %[ret].16b, %[ret].16b
                    \\ rev64 %[ret].8h, %[ret].8h
                    \\ ext   %[ret].16b, %[ret].16b, %[ret].16b, #8
                    : [ret] "=w" (-> u16x8),
                    : [a] "w" (a),
                      [b] "w" (b),
                );
            },
        }
    } else if (use_asm and comptime arm.hasFeatures(&.{.neon})) {
        return asm ("vmull.u8 %[ret], %[a], %[b]"
            : [ret] "=w" (-> u16x8),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else if (use_builtins and comptime aarch64.hasFeatures(&.{.neon})) {
        return struct {
            extern fn @"llvm.aarch64.neon.umull.v8i16"(u8x8, u8x8) u16x8;
        }.@"llvm.aarch64.neon.umull.v8i16"(a, b);
    } else if (use_builtins and comptime arm.hasFeatures(&.{.neon})) {
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

    try testIntrinsic("vmull_u8", vmull_u8, u16x8{ 0, 1 * 5, 2 * 5, 3 * 5, 4 * 5, 5 * 5, 6 * 5, 7 * 5 }, .{ a, b });
}

/// Unsigned multiply long
pub inline fn vmull_u16(a: u16x4, b: u16x4) u32x4 {
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        switch (endianness) {
            inline .little => {
                return asm ("umull %[ret].4s, %[a].4h, %[b].4h"
                    : [ret] "=w" (-> u32x4),
                    : [a] "w" (a),
                      [b] "w" (b),
                );
            },
            inline .big => {
                return asm (
                    \\ umull %[ret].4s, %[a].4h, %[b].4h
                    \\ rev32 %[ret].16b, %[ret].16b
                    \\ rev64 %[ret].4s, %[ret].4s
                    \\ ext   %[ret].16b, %[ret].16b, %[ret].16b, #8
                    : [ret] "=w" (-> u32x4),
                    : [a] "w" (a),
                      [b] "w" (b),
                );
            },
        }
    } else if (use_asm and comptime arm.hasFeatures(&.{.neon})) {
        return asm ("vmull.u16 %[ret], %[a], %[b]"
            : [ret] "=w" (-> u32x4),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else if (use_builtins and comptime aarch64.hasFeatures(&.{.neon})) {
        return struct {
            extern fn @"llvm.aarch64.neon.umull.v4i32"(u16x4, u16x4) u32x4;
        }.@"llvm.aarch64.neon.umull.v4i32"(a, b);
    } else if (use_builtins and comptime arm.hasFeatures(&.{.neon})) {
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

    try testIntrinsic("vmull_u16", vmull_u16, u32x4{ 0, 1 * 5, 2 * 5, 3 * 5 }, .{ a, b });
}

/// Unsigned multiply long
pub inline fn vmull_u32(a: u32x2, b: u32x2) u64x2 {
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        switch (endianness) {
            inline .little => {
                return asm ("umull %[ret].2d, %[a].2s, %[b].2s"
                    : [ret] "=w" (-> u64x2),
                    : [a] "w" (a),
                      [b] "w" (b),
                );
            },
            inline .big => {
                return asm (
                    \\ umull %[ret].2d, %[a].2s, %[b].2s
                    \\ rev64 %[ret].16b, %[ret].16b
                    \\ ext   %[ret].16b, %[ret].16b, %[ret].16b, #8
                    : [ret] "=w" (-> u64x2),
                    : [a] "w" (a),
                      [b] "w" (b),
                );
            },
        }
    } else if (use_asm and comptime arm.hasFeatures(&.{.neon})) {
        return asm ("vmull.u32 %[ret], %[a], %[b]"
            : [ret] "=w" (-> u64x2),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else if (use_builtins and comptime aarch64.hasFeatures(&.{.neon})) {
        return struct {
            extern fn @"llvm.aarch64.neon.umull.v2i64"(u32x2, u32x2) u64x2;
        }.@"llvm.aarch64.neon.umull.v2i64"(a, b);
    } else if (use_builtins and comptime arm.hasFeatures(&.{.neon})) {
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

    try testIntrinsic("vmull_u32", vmull_u32, u64x2{ 0, 1 * 5 }, .{ a, b });
}

/// Signed multiply long
pub inline fn vmull_high_s8(a: i8x16, b: i8x16) i16x8 {
    return vmull_s8(vget_high_s8(a), vget_high_s8(b));
}

test vmull_high_s8 {
    const a: i8x16 = .{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 127 };
    const b: i8x16 = @splat(2);

    try testIntrinsic("vmull_high_s8", vmull_high_s8, i16x8{ 0, 0, 0, 0, 0, 0, 0, 254 }, .{ a, b });
}

/// Signed multiply long
pub inline fn vmull_high_s16(a: i16x8, b: i16x8) i32x4 {
    return vmull_s16(vget_high_s16(a), vget_high_s16(b));
}

test vmull_high_s16 {
    const a: i16x8 = .{ 0, 0, 0, 0, 0, -1, -2, -3 };
    const b: i16x8 = @splat(5);

    try testIntrinsic("vmull_high_s16", vmull_high_s16, i32x4{ 0, -1 * 5, -2 * 5, -3 * 5 }, .{ a, b });
}

/// Signed multiply long
pub inline fn vmull_high_s32(a: i32x4, b: i32x4) i64x2 {
    return vmull_s32(vget_high_s32(a), vget_high_s32(b));
}

test vmull_high_s32 {
    const a: i32x4 = .{ 0, -1, -2, -3 };
    const b: i32x4 = @splat(5);

    try testIntrinsic("vmull_high_s32", vmull_high_s32, i64x2{ -2 * 5, -3 * 5 }, .{ a, b });
}

/// Unsigned multiply long
pub inline fn vmull_high_u8(a: u8x16, b: u8x16) u16x8 {
    return vmull_u8(vget_high_u8(a), vget_high_u8(b));
}

test vmull_high_u8 {
    const a: u8x16 = .{ 0, 0, 0, 0, 0, 0, 0, 127, 0, 0, 0, 0, 0, 0, 0, 127 };
    const b: u8x16 = @splat(2);

    try testIntrinsic("vmull_high_u8", vmull_high_u8, u16x8{ 0, 0, 0, 0, 0, 0, 0, 254 }, .{ a, b });
}

/// Unsigned multiply long
pub inline fn vmull_high_u16(a: u16x8, b: u16x8) u32x4 {
    return vmull_u16(vget_high_u16(a), vget_high_u16(b));
}

test vmull_high_u16 {
    const a: u16x8 = .{ 0, 1, 2, 3, 0, 1, 2, 3 };
    const b: u16x8 = @splat(5);

    try testIntrinsic("vmull_high_u16", vmull_high_u16, u32x4{ 0, 1 * 5, 2 * 5, 3 * 5 }, .{ a, b });
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
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        return asm ("sabd %[ret].8b, %[a].8b, %[b].8b"
            : [ret] "=w" (-> i8x8),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else if (use_asm and comptime arm.hasFeatures(&.{.neon})) {
        return asm ("vabd.s8 %[ret], %[a], %[b]"
            : [ret] "=w" (-> i8x8),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else if (use_builtins and comptime aarch64.hasFeatures(&.{.neon})) {
        return struct {
            extern fn @"llvm.aarch64.neon.sabd.v8i8"(i8x8, i8x8) i8x8;
        }.@"llvm.aarch64.neon.sabd.v8i8"(a, b);
    } else if (use_builtins and comptime arm.hasFeatures(&.{.neon})) {
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

    try testIntrinsic("vabd_s8", vabd_s8, expected, .{ a, b });
}

/// Absolute difference between two i16x4 vectors
pub inline fn vabd_s16(a: i16x4, b: i16x4) i16x4 {
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        return asm ("sabd %[ret].4h, %[a].4h, %[b].4h"
            : [ret] "=w" (-> i16x4),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else if (use_asm and comptime arm.hasFeatures(&.{.neon})) {
        return asm ("vabd.s16 %[ret], %[a], %[b]"
            : [ret] "=w" (-> i16x4),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else if (use_builtins and comptime aarch64.hasFeatures(&.{.neon})) {
        return struct {
            extern fn @"llvm.aarch64.neon.sabd.v4i16"(i16x4, i16x4) i16x4;
        }.@"llvm.aarch64.neon.sabd.v4i16"(a, b);
    } else if (use_builtins and comptime arm.hasFeatures(&.{.neon})) {
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

    try testIntrinsic("vabd_s16", vabd_s16, expected, .{ a, b });
}

/// Absolute difference between two i32x2 vectors
pub inline fn vabd_s32(a: i32x2, b: i32x2) i32x2 {
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        return asm ("sabd %[ret].2s, %[a].2s, %[b].2s"
            : [ret] "=w" (-> i32x2),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else if (use_asm and comptime arm.hasFeatures(&.{.neon})) {
        return asm ("vabd.s32 %[ret], %[a], %[b]"
            : [ret] "=w" (-> i32x2),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else if (use_builtins and comptime aarch64.hasFeatures(&.{.neon})) {
        return struct {
            extern fn @"llvm.aarch64.neon.sabd.v2i32"(i32x2, i32x2) i32x2;
        }.@"llvm.aarch64.neon.sabd.v2i32"(a, b);
    } else if (use_builtins and comptime arm.hasFeatures(&.{.neon})) {
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

    try testIntrinsic("vabd_s32", vabd_s32, expected, .{ a, b });
}

/// Absolute difference between two u8x8 vectors
pub inline fn vabd_u8(a: u8x8, b: u8x8) u8x8 {
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        return asm ("uabd %[ret].8b, %[a].8b, %[b].8b"
            : [ret] "=w" (-> u8x8),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else if (use_asm and comptime arm.hasFeatures(&.{.neon})) {
        return asm ("vabd.u8 %[ret], %[a], %[b]"
            : [ret] "=w" (-> u8x8),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else if (use_builtins and comptime aarch64.hasFeatures(&.{.neon})) {
        return struct {
            extern fn @"llvm.aarch64.neon.uabd.v8i8"(u8x8, u8x8) u8x8;
        }.@"llvm.aarch64.neon.uabd.v8i8"(a, b);
    } else if (use_builtins and comptime arm.hasFeatures(&.{.neon})) {
        return struct {
            extern fn @"llvm.arm.neon.vabdu.v8i8"(u8x8, u8x8) u8x8;
        }.@"llvm.arm.neon.vabdu.v8i8"(a, b);
    } else {
        return abd(a, b);
    }
}

test vabd_u8 {
    {
        const a: u8x8 = .{ 1, 2, 3, 4, 5, 6, 7, 8 };
        const b: u8x8 = .{ 16, 15, 14, 13, 12, 11, 10, 9 };
        const expected: u8x8 = .{ 15, 13, 11, 9, 7, 5, 3, 1 };

        try testIntrinsic("vabd_u8", vabd_u8, expected, .{ a, b });
    }
    {
        const a: u8x8 = .{ 10, 10, 10, 10, 10, 10, 10, 10 };
        const b: u8x8 = .{ 10, 10, 10, 10, 10, 10, 10, 10 };
        const expected: u8x8 = .{ 0, 0, 0, 0, 0, 0, 0, 0 };

        try testIntrinsic("vabd_u8", vabd_u8, expected, .{ a, b });
    }
    {
        const a: u8x8 = .{ 16, 15, 14, 13, 12, 11, 10, 9 };
        const b: u8x8 = .{ 1, 2, 3, 4, 5, 6, 7, 8 };
        const expected: u8x8 = .{ 15, 13, 11, 9, 7, 5, 3, 1 };

        try testIntrinsic("vabd_u8", vabd_u8, expected, .{ a, b });
    }
    {
        const a: u8x8 = .{ 0, 255, 128, 64, 32, 16, 8, 4 };
        const b: u8x8 = .{ 255, 0, 64, 128, 16, 32, 4, 8 };
        const expected: u8x8 = .{ 255, 255, 64, 64, 16, 16, 4, 4 };

        try testIntrinsic("vabd_u8", vabd_u8, expected, .{ a, b });
    }
    {
        const a: u8x8 = .{ 0, 0, 0, 0, 0, 0, 0, 0 };
        const b: u8x8 = .{ 0, 0, 0, 0, 0, 0, 0, 0 };
        const expected: u8x8 = .{ 0, 0, 0, 0, 0, 0, 0, 0 };

        try testIntrinsic("vabd_u8", vabd_u8, expected, .{ a, b });
    }
}

/// Absolute difference between two u16x4 vectors
pub inline fn vabd_u16(a: u16x4, b: u16x4) u16x4 {
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        return asm ("uabd %[ret].4h, %[a].4h, %[b].4h"
            : [ret] "=w" (-> u16x4),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else if (use_asm and comptime arm.hasFeatures(&.{.neon})) {
        return asm ("vabd.u16 %[ret], %[a], %[b]"
            : [ret] "=w" (-> u16x4),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else if (use_builtins and comptime aarch64.hasFeatures(&.{.neon})) {
        return struct {
            extern fn @"llvm.aarch64.neon.uabd.v4i16"(u16x4, u16x4) u16x4;
        }.@"llvm.aarch64.neon.uabd.v4i16"(a, b);
    } else if (use_builtins and comptime arm.hasFeatures(&.{.neon})) {
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

    try testIntrinsic("vabd_u16", vabd_u16, expected, .{ a, b });
}

/// Absolute difference between two u32x2 vectors
pub inline fn vabd_u32(a: u32x2, b: u32x2) u32x2 {
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        return asm ("uabd %[ret].2s, %[a].2s, %[b].2s"
            : [ret] "=w" (-> u32x2),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else if (use_asm and comptime arm.hasFeatures(&.{.neon})) {
        return asm ("vabd.u32 %[ret], %[a], %[b]"
            : [ret] "=w" (-> u32x2),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else if (use_builtins and comptime aarch64.hasFeatures(&.{.neon})) {
        return struct {
            extern fn @"llvm.aarch64.neon.uabd.v2i32"(u32x2, u32x2) u32x2;
        }.@"llvm.aarch64.neon.uabd.v2i32"(a, b);
    } else if (use_builtins and comptime arm.hasFeatures(&.{.neon})) {
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

    try testIntrinsic("vabd_u32", vabd_u32, expected, .{ a, b });
}

/// Absolute difference between two f32x2 vectors
pub inline fn vabd_f32(a: f32x2, b: f32x2) f32x2 {
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        return asm ("fabd %[ret].2s, %[a].2s, %[b].2s"
            : [ret] "=w" (-> f32x2),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else if (use_asm and comptime arm.hasFeatures(&.{.neon})) {
        return asm ("vabd.f32 %[ret], %[a], %[b]"
            : [ret] "=w" (-> f32x2),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else if (use_builtins and comptime aarch64.hasFeatures(&.{.neon})) {
        return struct {
            extern fn @"llvm.aarch64.neon.fabd.v2f32"(f32x2, f32x2) f32x2;
        }.@"llvm.aarch64.neon.fabd.v2f32"(a, b);
    } else if (use_builtins and comptime arm.hasFeatures(&.{.neon})) {
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

    try testIntrinsic("vabd_f32", vabd_f32, expected, .{ a, b });
}

/// Absolute difference between two f64x1 vectors
pub inline fn vabd_f64(a: f64x1, b: f64x1) f64x1 {
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        return asm ("fabd d0, d0, d1"
            : [ret] "=w" (-> f64x1),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else if (use_builtins and comptime aarch64.hasFeatures(&.{.neon})) {
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
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        return asm ("sabd %[ret].16b, %[a].16b, %[b].16b"
            : [ret] "=w" (-> i8x16),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else if (use_asm and comptime arm.hasFeatures(&.{.neon})) {
        return asm ("vabd.s8 %[ret], %[a], %[b]"
            : [ret] "=w" (-> i8x16),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else if (use_builtins and comptime aarch64.hasFeatures(&.{.neon})) {
        return struct {
            extern fn @"llvm.aarch64.neon.sabd.v16i8"(i8x16, i8x16) i8x16;
        }.@"llvm.aarch64.neon.sabd.v16i8"(a, b);
    } else if (use_builtins and comptime arm.hasFeatures(&.{.neon})) {
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

    try testIntrinsic("vabdq_s8", vabdq_s8, expected, .{ a, b });
}

/// signed absolute difference and accumulate (128-bit)
pub inline fn vabdq_s16(a: i16x8, b: i16x8) i16x8 {
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        return asm ("sabd %[ret].8h, %[a].8h, %[b].8h"
            : [ret] "=w" (-> i16x8),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else if (use_asm and comptime arm.hasFeatures(&.{.neon})) {
        return asm ("vabd.s16 %[ret], %[a], %[b]"
            : [ret] "=w" (-> i16x8),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else if (use_builtins and comptime aarch64.hasFeatures(&.{.neon})) {
        return struct {
            extern fn @"llvm.aarch64.neon.sabd.v8i16"(i16x8, i16x8) i16x8;
        }.@"llvm.aarch64.neon.sabd.v8i16"(a, b);
    } else if (use_builtins and comptime arm.hasFeatures(&.{.neon})) {
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

    try testIntrinsic("vabdq_s16", vabdq_s16, expected, .{ a, b });
}

/// signed absolute difference and accumulate (128-bit)
pub inline fn vabdq_s32(a: i32x4, b: i32x4) i32x4 {
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        return asm ("sabd %[ret].4s, %[a].4s, %[b].4s"
            : [ret] "=w" (-> i32x4),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else if (use_asm and comptime arm.hasFeatures(&.{.neon})) {
        return asm ("vabd.s32 %[ret], %[a], %[b]"
            : [ret] "=w" (-> i32x4),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else if (use_builtins and comptime aarch64.hasFeatures(&.{.neon})) {
        return struct {
            extern fn @"llvm.aarch64.neon.sabd.v4i32"(i32x4, i32x4) i32x4;
        }.@"llvm.aarch64.neon.sabd.v4i32"(a, b);
    } else if (use_builtins and comptime arm.hasFeatures(&.{.neon})) {
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

    try testIntrinsic("vabdq_s32", vabdq_s32, expected, .{ a, b });
}

/// signed absolute difference and accumulate (128-bit)
pub inline fn vabdq_u8(a: u8x16, b: u8x16) u8x16 {
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        return asm ("uabd %[ret].16b, %[a].16b, %[b].16b"
            : [ret] "=w" (-> u8x16),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else if (use_asm and comptime arm.hasFeatures(&.{.neon})) {
        return asm ("vabd.u8 %[ret], %[a], %[b]"
            : [ret] "=w" (-> u8x16),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else if (use_builtins and comptime aarch64.hasFeatures(&.{.neon})) {
        return struct {
            extern fn @"llvm.aarch64.neon.uabd.v16i8"(u8x16, u8x16) u8x16;
        }.@"llvm.aarch64.neon.uabd.v16i8"(a, b);
    } else if (use_builtins and comptime arm.hasFeatures(&.{.neon})) {
        return struct {
            extern fn @"llvm.arm.neon.vabdu.v16i8"(u8x16, u8x16) u8x16;
        }.@"llvm.arm.neon.vabdu.v16i8"(a, b);
    } else {
        return abd(a, b);
    }
}

test vabdq_u8 {
    {
        const a: u8x16 = .{ 1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8 };
        const b: u8x16 = .{ 16, 15, 14, 13, 12, 11, 10, 9, 16, 15, 14, 13, 12, 11, 10, 9 };
        const expected: u8x16 = .{ 15, 13, 11, 9, 7, 5, 3, 1, 15, 13, 11, 9, 7, 5, 3, 1 };

        try testIntrinsic("vabdq_u8", vabdq_u8, expected, .{ a, b });
    }
    {
        const a: u8x16 = .{ 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 };
        const b: u8x16 = .{ 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 };
        const expected: u8x16 = .{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };

        try testIntrinsic("vabdq_u8", vabdq_u8, expected, .{ a, b });
    }
    {
        const a: u8x16 = .{ 16, 15, 14, 13, 12, 11, 10, 9, 16, 15, 14, 13, 12, 11, 10, 9 };
        const b: u8x16 = .{ 1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8 };
        const expected: u8x16 = .{ 15, 13, 11, 9, 7, 5, 3, 1, 15, 13, 11, 9, 7, 5, 3, 1 };

        try testIntrinsic("vabdq_u8", vabdq_u8, expected, .{ a, b });
    }
    {
        const a: u8x16 = .{ 0, 255, 128, 64, 32, 16, 8, 4, 0, 255, 128, 64, 32, 16, 8, 4 };
        const b: u8x16 = .{ 255, 0, 64, 128, 16, 32, 4, 8, 255, 0, 64, 128, 16, 32, 4, 8 };
        const expected: u8x16 = .{ 255, 255, 64, 64, 16, 16, 4, 4, 255, 255, 64, 64, 16, 16, 4, 4 };

        try testIntrinsic("vabdq_u8", vabdq_u8, expected, .{ a, b });
    }
    {
        const a: u8x16 = .{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
        const b: u8x16 = .{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
        const expected: u8x16 = .{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };

        try testIntrinsic("vabdq_u8", vabdq_u8, expected, .{ a, b });
    }
}

/// signed absolute difference and accumulate (128-bit)
pub inline fn vabdq_u16(a: u16x8, b: u16x8) u16x8 {
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        return asm ("uabd %[ret].8h, %[a].8h, %[b].8h"
            : [ret] "=w" (-> u16x8),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else if (use_asm and comptime arm.hasFeatures(&.{.neon})) {
        return asm ("vabd.u16 %[ret], %[a], %[b]"
            : [ret] "=w" (-> u16x8),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else if (use_builtins and comptime aarch64.hasFeatures(&.{.neon})) {
        return struct {
            extern fn @"llvm.aarch64.neon.uabd.v8i16"(u16x8, u16x8) u16x8;
        }.@"llvm.aarch64.neon.uabd.v8i16"(a, b);
    } else if (use_builtins and comptime arm.hasFeatures(&.{.neon})) {
        return struct {
            extern fn @"llvm.arm.neon.vabdu.v8i16"(u16x8, u16x8) u16x8;
        }.@"llvm.arm.neon.vabdu.v8i16"(a, b);
    } else {
        return abd(a, b);
    }
}

test vabdq_u16 {
    const a: u16x8 = .{ 1, 2, 3, 4, 1, 2, 3, 4 };
    const b: u16x8 = .{ 16, 15, 14, 13, 16, 15, 14, 13 };

    const expected: u16x8 = .{ 15, 13, 11, 9, 15, 13, 11, 9 };

    try testIntrinsic("vabdq_u16", vabdq_u16, expected, .{ a, b });
}

/// signed absolute difference and accumulate (128-bit)
pub inline fn vabdq_u32(a: u32x4, b: u32x4) u32x4 {
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        return asm ("uabd %[ret].4s, %[a].4s, %[b].4s"
            : [ret] "=w" (-> u32x4),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else if (use_asm and comptime arm.hasFeatures(&.{.neon})) {
        return asm ("vabd.u32 %[ret], %[a], %[b]"
            : [ret] "=w" (-> u32x4),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else if (use_builtins and comptime aarch64.hasFeatures(&.{.neon})) {
        return struct {
            extern fn @"llvm.aarch64.neon.uabd.v4i32"(u32x4, u32x4) u32x4;
        }.@"llvm.aarch64.neon.uabd.v4i32"(a, b);
    } else if (use_builtins and comptime arm.hasFeatures(&.{.neon})) {
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

    try testIntrinsic("vabdq_u32", vabdq_u32, expected, .{ a, b });
}

/// signed absolute difference and accumulate (128-bit)
pub inline fn vabdq_f32(a: f32x4, b: f32x4) f32x4 {
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        return asm ("fabd %[ret].4s, %[a].4s, %[b].4s"
            : [ret] "=w" (-> f32x4),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else if (use_asm and comptime arm.hasFeatures(&.{.neon})) {
        return asm ("vabd.f32 %[ret], %[a], %[b]"
            : [ret] "=w" (-> f32x4),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else if (use_builtins and comptime aarch64.hasFeatures(&.{.neon})) {
        return struct {
            extern fn @"llvm.aarch64.neon.fabd.v4f32"(f32x4, f32x4) f32x4;
        }.@"llvm.aarch64.neon.fabd.v4f32"(a, b);
    } else if (use_builtins and comptime arm.hasFeatures(&.{.neon})) {
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
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        return asm ("fabd %[ret].2d, %[a].2d, %[b].2d"
            : [ret] "=w" (-> f64x2),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else if (use_builtins and comptime aarch64.hasFeatures(&.{.neon})) {
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
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        switch (endianness) {
            inline .little => {
                return asm ("sqdmull %[ret].4s, %[a].4h, %[b].4h"
                    : [ret] "=w" (-> i32x4),
                    : [a] "w" (a),
                      [b] "w" (b),
                );
            },
            inline .big => {
                return asm (
                    \\ sqdmull %[ret].4s, %[a].4h, %[b].4h
                    \\ rev32   %[ret].16b, %[ret].16b
                    \\ rev64   %[ret].4s, %[ret].4s
                    \\ ext     %[ret].16b, %[ret].16b, %[ret].16b, #8
                    : [ret] "=w" (-> i32x4),
                    : [a] "w" (a),
                      [b] "w" (b),
                );
            },
        }
    } else if (use_asm and comptime arm.hasFeatures(&.{.neon})) {
        return asm ("vqdmull.s16 %[ret], %[a], %[b]"
            : [ret] "=w" (-> i32x4),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else if (use_builtins and comptime aarch64.hasFeatures(&.{.neon})) {
        return struct {
            extern fn @"llvm.aarch64.neon.sqdmull.v4i32"(i16x4, i16x4) i32x4;
        }.@"llvm.aarch64.neon.sqdmull.v4i32"(a, b);
    } else if (use_builtins and comptime arm.hasFeatures(&.{.neon})) {
        return struct {
            extern fn @"llvm.arm.neon.vqdmull.v4i32"(i16x4, i16x4) i32x4;
        }.@"llvm.arm.neon.vqdmull.v4i32"(a, b);
    } else {
        const product = vmull_s16(a, b);
        return product *| @as(i32x4, @splat(2));
    }
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

    try testIntrinsic("vqdmull_s16", vqdmull_s16, expected, .{ a, b });

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
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        switch (endianness) {
            inline .little => {
                return asm ("sqdmull %[ret].2d, %[a].2s, %[b].2s"
                    : [ret] "=w" (-> i64x2),
                    : [a] "w" (a),
                      [b] "w" (b),
                );
            },
            inline .big => {
                return asm (
                    \\ sqdmull %[ret].2d, %[a].2s, %[b].2s
                    \\ rev64   %[ret].16b, %[ret].16b
                    \\ ext     %[ret].16b, %[ret].16b, %[ret].16b, #8
                    : [ret] "=w" (-> i64x2),
                    : [a] "w" (a),
                      [b] "w" (b),
                );
            },
        }
    } else if (use_asm and comptime arm.hasFeatures(&.{.neon})) {
        return asm ("vqdmull.s32 %[ret], %[a], %[b]"
            : [ret] "=w" (-> i64x2),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else if (use_builtins and comptime aarch64.hasFeatures(&.{.neon})) {
        return struct {
            extern fn @"llvm.aarch64.neon.sqdmull.v2i64"(i32x2, i32x2) i64x2;
        }.@"llvm.aarch64.neon.sqdmull.v2i64"(a, b);
    } else if (use_builtins and comptime arm.hasFeatures(&.{.neon})) {
        return struct {
            extern fn @"llvm.arm.neon.vqdmull.v2i64"(i32x2, i32x2) i64x2;
        }.@"llvm.arm.neon.vqdmull.v2i64"(a, b);
    } else {
        const product = vmull_s32(a, b);
        return product *| @as(i64x2, @splat(2));
    }
}

test vqdmull_s32 {
    const a: i32x2 = .{ 6477777, -782282872 };
    const b: i32x2 = .{ 5, 5 };

    const expected: i64x2 = .{
        64777770, // 6477777 * 5 * 2
        -7822828720, // -782282872 * 5 * 2
    };

    try testIntrinsic("vqdmull_s32", vqdmull_s32, expected, .{ a, b });

    const a_sat: i32x2 = .{ std.math.maxInt(i32), std.math.maxInt(i32) };
    const b_sat: i32x2 = .{ std.math.maxInt(i32), std.math.minInt(i32) };

    const expected_sat: i64x2 = .{
        9223372028264841218,
        -9223372032559808512,
    };

    try testIntrinsic("vqdmull_s32", vqdmull_s32, expected_sat, .{ a_sat, b_sat });
}

/// Signed saturating doubling multiply long
pub inline fn vqdmullh_s16(a: i16, b: i16) i32 {
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        return asm (
            \\ fmov    s0, %[a:w]
            \\ fmov    s1, %[b:w]
            \\ sqdmull v0.4s, v0.4h, v1.4h
            \\ fmov    %[ret:w], s0
            : [ret] "=r" (-> i32),
            : [a] "r" (a),
              [b] "r" (b),
            : "s0", "s1", "v0", "v1"
        );
    } else if (use_builtins and comptime aarch64.hasFeatures(&.{.neon})) {
        return struct {
            extern fn @"llvm.aarch64.neon.sqdmull.v4i32"(i16x4, i16x4) i32x4;
        }.@"llvm.aarch64.neon.sqdmull.v4i32"(@splat(a), @splat(b))[0];
    } else {
        return (@as(i32, a) *| @as(i32, b)) *| 2;
    }
}

test vqdmullh_s16 {
    const a: i16 = std.math.maxInt(i16);
    const b: i16 = 20;
    const expected: i32 = 1310680;

    try testIntrinsic("vqdmullh_s16", vqdmullh_s16, expected, .{ a, b });
}

/// Signed saturating doubling multiply long
pub inline fn vqdmulls_s32(a: i32, b: i32) i64 {
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        return asm (
            \\ fmov    s0, %[a:w]
            \\ fmov    s1, %[b:w]
            \\ sqdmull d0, s0, s1
            \\ fmov    %[ret], d0
            : [ret] "=r" (-> i64),
            : [a] "r" (a),
              [b] "r" (b),
            : "s0", "s1", "d0"
        );
    } else if (use_builtins and comptime aarch64.hasFeatures(&.{.neon})) {
        return struct {
            extern fn @"llvm.aarch64.neon.sqdmulls.scalar"(i32, i32) i64;
        }.@"llvm.aarch64.neon.sqdmulls.scalar"(a, b);
    } else {
        return (@as(i64, a) *| @as(i64, b)) *| 2;
    }
}

test vqdmulls_s32 {
    const a: i32 = std.math.maxInt(i32);
    const b: i32 = 20;
    const expected: i64 = 85899345880;

    try testIntrinsic("vqdmulls_s32", vqdmulls_s32, expected, .{ a, b });
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

/// Floating-point add across vector
pub inline fn vaddv_f32(a: f32x2) f32 {
    return @reduce(.Add, a);
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
pub inline fn vaddvq_s64(a: i64x2) i64 {
    return @reduce(.Add, a);
}

test vaddvq_s64 {
    const a: i64x2 = .{ 1, 1 };
    const expected: i64 = 2;

    try expectEqual(expected, vaddvq_s64(a));
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

/// Unsigned Add Long across Vector
pub inline fn vaddvq_u64(a: u64x2) u64 {
    return @reduce(.Add, a);
}

test vaddvq_u64 {
    const a: u64x2 = .{ 1, 1 };
    const expected: u64 = 2;

    try expectEqual(expected, vaddvq_u64(a));
}

/// Unsigned Add Long across Vector
pub inline fn vaddvq_f32(a: f32x4) f32 {
    return @reduce(.Add, a);
}

/// Unsigned Add Long across Vector
pub inline fn vaddvq_f64(a: f64x2) f64 {
    return @reduce(.Add, a);
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
    {
        const acc: i8x8 = .{ 10, 20, 30, 40, 50, 60, 70, 80 };

        const a: i8x8 = .{ -5, -15, -25, -35, -45, -55, -65, -75 };
        const b: i8x8 = .{ 5, 15, 25, 35, 45, 55, 65, 75 };
        const expected: i8x8 = .{ 20, 50, 80, 110, -116, -86, -56, -26 };

        try expectEqual(expected, vaba_s8(acc, a, b));
    }
    {
        const acc: i8x8 = .{ 0, 0, 0, 0, 0, 0, 0, 0 };

        const a: i8x8 = .{ -5, -15, -25, -35, -45, -55, -65, -75 };
        const b: i8x8 = .{ 5, 15, 25, 35, 45, 55, 65, 75 };
        const expected: i8x8 = .{ 10, 30, 50, 70, 90, 110, -126, -106 };

        try expectEqual(expected, vaba_s8(acc, a, b));
    }
    {
        const acc: i8x8 = .{ 100, 110, 120, 127, -128, -100, -50, 0 };
        const a: i8x8 = .{ -5, -15, -25, -35, -45, -55, -65, -75 };

        const expected: i8x8 = acc;

        try expectEqual(expected, vaba_s8(acc, a, a));
    }
    {
        const acc: i8x8 = .{ -10, 10, -20, 20, -30, 30, -40, 40 };
        const a: i8x8 = .{ -128, -64, -32, -16, 16, 32, 64, 127 };
        const b: i8x8 = .{ 127, 63, 32, 16, -16, -32, -64, -128 };

        const expected: i8x8 = .{ -11, -119, 44, 52, 2, 94, 88, 39 };

        try expectEqual(expected, vaba_s8(acc, a, b));
    }
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

/// Unsigned Absolute difference and Accumulate Long
pub inline fn vabal_s16(acc: i32x4, a: i16x4, b: i16x4) i16x4 {
    return vabdl_s16(a, b) +% acc;
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
    {
        const a: u8x8 = .{ 1, 2, 3, 4, 5, 6, 7, 8 };
        const b: u8x8 = .{ 16, 15, 14, 13, 12, 11, 10, 9 };
        const expected: u16x8 = .{ 15, 13, 11, 9, 7, 5, 3, 1 };

        try expectEqual(expected, vabdl_u8(a, b));
    }
    {
        const a: u8x8 = .{ 10, 10, 10, 10, 10, 10, 10, 10 };
        const b: u8x8 = .{ 10, 10, 10, 10, 10, 10, 10, 10 };
        const expected: u16x8 = .{ 0, 0, 0, 0, 0, 0, 0, 0 };

        try expectEqual(expected, vabdl_u8(a, b));
    }
    {
        const a: u8x8 = .{ 16, 15, 14, 13, 12, 11, 10, 9 };
        const b: u8x8 = .{ 1, 2, 3, 4, 5, 6, 7, 8 };
        const expected: u16x8 = .{ 15, 13, 11, 9, 7, 5, 3, 1 };

        try expectEqual(expected, vabd_u8(a, b));
    }
    {
        const a: u8x8 = .{ 0, 255, 128, 64, 32, 16, 8, 4 };
        const b: u8x8 = .{ 255, 0, 64, 128, 16, 32, 4, 8 };
        const expected: u16x8 = .{ 255, 255, 64, 64, 16, 16, 4, 4 };

        try expectEqual(expected, vabd_u8(a, b));
    }
    {
        const a: u8x8 = .{ 0, 0, 0, 0, 0, 0, 0, 0 };
        const b: u8x8 = .{ 0, 0, 0, 0, 0, 0, 0, 0 };
        const expected: u16x8 = .{ 0, 0, 0, 0, 0, 0, 0, 0 };

        try expectEqual(expected, vabdl_u8(a, b));
    }
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
pub inline fn vabs_s64(a: i64x1) i64x1 {
    return @bitCast(@abs(a));
}

/// Absolute value (wrapping)
pub inline fn vabs_f32(a: f32x2) f32x2 {
    return @bitCast(@abs(a));
}

/// Absolute value (wrapping)
pub inline fn vabs_f64(a: f64x1) f64x1 {
    return @bitCast(@abs(a));
}

/// Absolute value (wrapping)
pub inline fn vabsd_s64(a: i64) i64 {
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
pub inline fn vadd_f64(a: f64x2, b: f64x2) f64x2 {
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
pub inline fn vadd_p8(a: p8x8, b: p8x8) p8x8 {
    return a +% b;
}

/// Vector add (wrapping)
pub inline fn vadd_p16(a: p16x4, b: p16x4) p16x4 {
    return a +% b;
}

/// Vector add (wrapping)
pub inline fn vadd_p64(a: p64x1, b: p64x1) p64x1 {
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
pub inline fn vaddq_f32(a: f32x4, b: f32x4) f32x4 {
    return a +% b;
}

/// Vector add (wrapping)
pub inline fn vaddq_f64(a: f64x2, b: f64x2) f64x2 {
    return a + b;
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

/// Bitwise exclusive OR
pub inline fn vaddq_p8(a: p8x16, b: p8x16) p8x16 {
    return a ^ b;
}

/// Bitwise exclusive OR
pub inline fn vaddq_p16(a: p16x8, b: p16x8) p16x8 {
    return a ^ b;
}

/// Bitwise exclusive OR
pub inline fn vaddq_p64(a: p64x2, b: p64x2) p64x2 {
    return a ^ b;
}

/// Bitwise exclusive OR
pub inline fn vaddq_p128(a: p128, b: p128) p128 {
    return a ^ b;
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
    {
        const a: i16x8 = .{ 256, 512, 1024, 2048, 4096, 8192, 16384, 32767 };
        const b: i16x8 = .{ 128, 256, 512, 1024, 2048, 4096, 8192, 32767 };
        const expected: i8x8 = .{ 1, 3, 6, 12, 24, 48, 96, -1 }; // -1 due to wrapping

        try expectEqual(expected, vaddhn_s16(a, b));
    }
    {
        const a: i16x8 = .{ -256, -512, -1024, -2048, -4096, -8192, -16384, -32768 };
        const b: i16x8 = .{ -128, -256, -512, -1024, -2048, -4096, -8192, -32768 };
        const expected: i8x8 = .{ -2, -3, -6, -12, -24, -48, -96, 0 };

        try expectEqual(expected, vaddhn_s16(a, b));
    }
    {
        const a: i16x8 = .{ 0, 0, 0, 0, 0, 0, 0, 0 };
        const b: i16x8 = .{ 0, 0, 0, 0, 0, 0, 0, 0 };
        const expected: i8x8 = .{ 0, 0, 0, 0, 0, 0, 0, 0 };

        try expectEqual(expected, vaddhn_s16(a, b));
    }
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

/// Signed Add Long (high half)
pub inline fn vaddl_high_s8(a: i8x16, b: i8x16) i16x8 {
    return vmovl_high_s8(a) + vmovl_high_s8(b);
}

/// Signed Add Long (high half)
pub inline fn vaddl_high_s16(a: i16x8, b: i16x8) i32x4 {
    return vmovl_high_s16(a) + vmovl_high_s16(b);
}

/// Signed Add Long (high half)
pub inline fn vaddl_high_s32(a: i32x4, b: i32x4) i64x2 {
    return vmovl_high_s32(a) + vmovl_high_s32(b);
}

/// Unsigned Add Long (high half)
pub inline fn vaddl_high_u8(a: u8x16, b: u8x16) u16x8 {
    return vmovl_high_u8(a) + vmovl_high_u8(b);
}

/// Unsigned Add Long (high half)
pub inline fn vaddl_high_u16(a: u16x8, b: u16x8) u32x4 {
    return vmovl_high_u16(a) + vmovl_high_u16(b);
}

/// Unsigned Add Long (high half)
pub inline fn vaddl_high_u32(a: u32x4, b: u32x4) u64x2 {
    return vmovl_high_u32(a) + vmovl_high_u32(b);
}

/// Signed Add Wide
pub inline fn vaddw_s8(a: i16x8, b: i8x8) i16x8 {
    return a +% vmovl_s8(b);
}

test vaddw_s8 {
    {
        const a: i16x8 = .{ 1000, 2000, 3000, 4000, -5000, -6000, -7000, -8000 };
        const b: i8x8 = .{ 10, 20, -30, -40, 50, 60, -70, 80 };
        const expected: i16x8 = .{ 1010, 2020, 2970, 3960, -4950, -5940, -7070, -7920 };

        try expectEqual(expected, vaddw_s8(a, b));
    }
    {
        const a = @Vector(8, i16){ 32760, -32760, 1000, -1000, 2000, -2000, 0, -32768 };
        const b = @Vector(8, i8){ 10, -10, 120, -120, 127, -128, 0, 1 };
        const expected: i16x8 = .{
            -32766, // Overflow wraps around to negative
            32766, // Underflow wraps around to positive
            1120, // Normal addition
            -1120, // Normal subtraction
            2127, // Normal addition
            -2128, // Normal subtraction
            0, // No change
            -32767, // Wraps around to next higher value
        };

        try expectEqual(expected, vaddw_s8(a, b));
    }
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
    if (use_asm and comptime aarch64.hasFeatures(&.{.aes})) {
        var result = data;
        asm ("aesd %[ret].16b, %[key].16b"
            : [ret] "+w" (result),
            : [key] "w" (key),
        );
        return result;
    } else if (use_builtins and comptime aarch64.hasFeatures(&.{.aes})) {
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

    try testIntrinsic("vaesdq_u8", vaesdq_u8, expected, .{ state, key });
}

/// AES single round encryption
pub inline fn vaeseq_u8(data: u8x16, key: u8x16) u8x16 {
    if (use_asm and comptime aarch64.hasFeatures(&.{.aes})) {
        var result = data;
        asm ("aese %[ret].16b, %[key].16b"
            : [ret] "+w" (result),
            : [key] "w" (key),
        );
        return result;
    } else if (use_builtins and comptime aarch64.hasFeatures(&.{.aes})) {
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

    try testIntrinsic("vaeseq_u8", vaeseq_u8, expected, .{ state, key });
}

/// AES inverse mix columns
pub inline fn vaesimcq_u8(data: u8x16) u8x16 {
    if (use_asm and comptime aarch64.hasFeatures(&.{.aes})) {
        return asm ("aesimc %[ret].16b, %[data].16b"
            : [ret] "=w" (-> u8x16),
            : [data] "w" (data),
        );
    } else if (use_builtins and comptime aarch64.hasFeatures(&.{.aes})) {
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

    try testIntrinsic("vaesimcq_u8", vaesimcq_u8, expected, .{input});
}

/// AES mix columns
pub inline fn vaesmcq_u8(data: u8x16) u8x16 {
    if (use_asm and comptime aarch64.hasFeatures(&.{.aes})) {
        return asm ("aesmc %[ret].16b, %[data].16b"
            : [ret] "=w" (-> u8x16),
            : [data] "w" (data),
        );
    } else if (use_builtins and comptime aarch64.hasFeatures(&.{.aes})) {
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

    try testIntrinsic("vaesmcq_u8", vaesmcq_u8, expected, .{input});
}

//// Vector bitwise and
pub inline fn vand_s8(a: i8x8, b: i8x8) i8x8 {
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        return asm ("and %[ret].8b, %[a].8b, %[b].8b"
            : [ret] "=w" (-> i8x8),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else if (use_asm and comptime arm.hasFeatures(&.{.neon})) {
        return asm ("vand %[ret], %[a], %[b]"
            : [ret] "=w" (-> i8x8),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else {
        return a & b;
    }
}

test vand_s8 {
    const a: i8x8 = .{ 0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07 };
    const b: i8x8 = .{ 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F };
    const expected: i8x8 = .{ 0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07 };

    try testIntrinsic("vand_s8", vand_s8, expected, .{ a, b });
}

/// Vector bitwise and
pub inline fn vand_s16(a: i16x4, b: i16x4) i16x4 {
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        return asm ("and %[ret].8b, %[a].8b, %[b].8b"
            : [ret] "=w" (-> i16x4),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else if (use_asm and comptime arm.hasFeatures(&.{.neon})) {
        return asm ("vand %[ret], %[a], %[b]"
            : [ret] "=w" (-> i16x4),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else {
        return a & b;
    }
}

test vand_s16 {
    const a: i16x4 = .{ 0x00, 0x01, 0x02, 0x03 };
    const b: i16x4 = .{ 0x0F, 0x0F, 0x0F, 0x0F };
    const expected: i16x4 = .{ 0x00, 0x01, 0x02, 0x03 };

    try testIntrinsic("vand_s16", vand_s16, expected, .{ a, b });
}

/// Vector bitwise and
pub inline fn vand_s32(a: i32x2, b: i32x2) i32x2 {
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        return asm ("and %[ret].8b, %[a].8b, %[b].8b"
            : [ret] "=w" (-> i32x2),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else if (use_asm and comptime arm.hasFeatures(&.{.neon})) {
        return asm ("vand %[ret], %[a], %[b]"
            : [ret] "=w" (-> i32x2),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else {
        return a & b;
    }
}

test vand_s32 {
    const a: i32x2 = .{ 0x00, 0x01 };
    const b: i32x2 = .{ 0x0F, 0x0F };
    const expected: i32x2 = .{ 0x00, 0x01 };

    try testIntrinsic("vand_s32", vand_s32, expected, .{ a, b });
}

/// Vector bitwise and
pub inline fn vand_s64(a: i64x1, b: i64x1) i64x1 {
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        return asm ("and %[ret].8b, %[a].8b, %[b].8b"
            : [ret] "=w" (-> i64x1),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else if (use_asm and comptime arm.hasFeatures(&.{.neon})) {
        return asm ("vand %[ret], %[a], %[b]"
            : [ret] "=w" (-> i64x1),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else {
        return a & b;
    }
}

test vand_s64 {
    const a: i64x1 = .{0xFF};
    const b: i64x1 = .{0x0F};
    const expected: i64x1 = .{0x0F};

    try testIntrinsic("vand_s64", vand_s64, expected, .{ a, b });
}

/// Vector bitwise and
pub inline fn vand_u8(a: u8x8, b: u8x8) u8x8 {
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        return asm ("and %[ret].8b, %[a].8b, %[b].8b"
            : [ret] "=w" (-> u8x8),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else if (use_asm and comptime arm.hasFeatures(&.{.neon})) {
        return asm ("vand %[ret], %[a], %[b]"
            : [ret] "=w" (-> u8x8),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else {
        return a & b;
    }
}

test vand_u8 {
    const a: u8x8 = .{ 0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07 };
    const b: u8x8 = .{ 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F };
    const expected: u8x8 = .{ 0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07 };

    try testIntrinsic("vand_u8", vand_u8, expected, .{ a, b });
}

/// Vector bitwise and
pub inline fn vand_u16(a: i16x4, b: i16x4) u16x4 {
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        return asm ("and %[ret].8b, %[a].8b, %[b].8b"
            : [ret] "=w" (-> u16x4),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else if (use_asm and comptime arm.hasFeatures(&.{.neon})) {
        return asm ("vand %[ret], %[a], %[b]"
            : [ret] "=w" (-> u16x4),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else {
        return a & b;
    }
}

test vand_u16 {
    const a: u16x4 = .{ 0x00, 0x01, 0x02, 0x03 };
    const b: u16x4 = .{ 0x0F, 0x0F, 0x0F, 0x0F };
    const expected: u16x4 = .{ 0x00, 0x01, 0x02, 0x03 };

    try testIntrinsic("vand_u16", vand_u16, expected, .{ a, b });
}

/// Vector bitwise and
pub inline fn vand_u32(a: u32x2, b: u32x2) u32x2 {
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        return asm ("and %[ret].8b, %[a].8b, %[b].8b"
            : [ret] "=w" (-> u32x2),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else if (use_asm and comptime arm.hasFeatures(&.{.neon})) {
        return asm ("vand %[ret], %[a], %[b]"
            : [ret] "=w" (-> u32x2),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else {
        return a & b;
    }
}

test vand_u32 {
    const a: u32x2 = .{ 0x00, 0x01 };
    const b: u32x2 = .{ 0x0F, 0x0F };
    const expected: u32x2 = .{ 0x00, 0x01 };

    try testIntrinsic("vand_u32", vand_u32, expected, .{ a, b });
}

/// Vector bitwise and
pub inline fn vand_u64(a: u64x1, b: u64x1) u64x1 {
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        return asm ("and %[ret].8b, %[a].8b, %[b].8b"
            : [ret] "=w" (-> u64x1),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else if (use_asm and comptime arm.hasFeatures(&.{.neon})) {
        return asm ("vand %[ret], %[a], %[b]"
            : [ret] "=w" (-> u64x1),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else {
        return a & b;
    }
}

test vand_u64 {
    const a: u64x1 = .{0x00};
    const b: u64x1 = .{0x0F};
    const expected: u64x1 = .{0x00};

    try testIntrinsic("vand_u64", vand_u64, expected, .{ a, b });
}

/// Vector bitwise and
pub inline fn vandq_s8(a: i8x16, b: i8x16) i8x16 {
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        return asm ("and %[ret].16b, %[a].16b, %[b].16b"
            : [ret] "=w" (-> i8x16),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else if (use_asm and comptime arm.hasFeatures(&.{.neon})) {
        return asm ("vand %[ret], %[a], %[b]"
            : [ret] "=w" (-> i8x16),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else {
        return a & b;
    }
}

test vandq_s8 {
    const a: i8x16 = .{ 0x00, 0x01, 0x02, 0x03, 0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x00, 0x01, 0x02, 0x03 };
    const b: i8x16 = .{ 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F };
    const expected: i8x16 = .{ 0x00, 0x01, 0x02, 0x03, 0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x00, 0x01, 0x02, 0x03 };

    try testIntrinsic("vandq_s8", vandq_s8, expected, .{ a, b });
}

/// Vector bitwise and
pub inline fn vandq_s16(a: i16x8, b: i16x8) i16x8 {
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        return asm ("and %[ret].16b, %[a].16b, %[b].16b"
            : [ret] "=w" (-> i16x8),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else if (use_asm and comptime arm.hasFeatures(&.{.neon})) {
        return asm ("vand %[ret], %[a], %[b]"
            : [ret] "=w" (-> i16x8),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else {
        return a & b;
    }
}

test vandq_s16 {
    const a: i16x8 = .{ 0x00, 0x01, 0x02, 0x03, 0x00, 0x01, 0x02, 0x03 };
    const b: i16x8 = .{ 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F };
    const expected: i16x8 = .{ 0x00, 0x01, 0x02, 0x03, 0x00, 0x01, 0x02, 0x03 };

    try testIntrinsic("vandq_s16", vandq_s16, expected, .{ a, b });
}

/// Vector bitwise and
pub inline fn vandq_s32(a: i32x4, b: i32x4) i32x4 {
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        return asm ("and %[ret].16b, %[a].16b, %[b].16b"
            : [ret] "=w" (-> i32x4),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else if (use_asm and comptime arm.hasFeatures(&.{.neon})) {
        return asm ("vand %[ret], %[a], %[b]"
            : [ret] "=w" (-> i32x4),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else {
        return a & b;
    }
}

test vandq_s32 {
    const a: i32x4 = .{ 0x00, 0x01, 0x00, 0x01 };
    const b: i32x4 = .{ 0x0F, 0x0F, 0x0F, 0x0F };
    const expected: i32x4 = .{ 0x00, 0x01, 0x00, 0x01 };

    try testIntrinsic("vandq_s32", vandq_s32, expected, .{ a, b });
}

/// Vector bitwise and
pub inline fn vandq_s64(a: i64x2, b: i64x2) i64x2 {
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        return asm ("and %[ret].16b, %[a].16b, %[b].16b"
            : [ret] "=w" (-> i64x2),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else if (use_asm and comptime arm.hasFeatures(&.{.neon})) {
        return asm ("vand %[ret], %[a], %[b]"
            : [ret] "=w" (-> i64x2),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else {
        return a & b;
    }
}

test vandq_s64 {
    const a: i64x2 = .{ 0x00, 0x00 };
    const b: i64x2 = .{ 0x0F, 0x0F };
    const expected: i64x2 = .{ 0x00, 0x00 };

    try testIntrinsic("vandq_s64", vandq_s64, expected, .{ a, b });
}

/// Vector bitwise and
pub inline fn vandq_u8(a: u8x16, b: u8x16) u8x16 {
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        return asm ("and %[ret].16b, %[a].16b, %[b].16b"
            : [ret] "=w" (-> u8x16),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else if (use_asm and comptime arm.hasFeatures(&.{.neon})) {
        return asm ("vand %[ret], %[a], %[b]"
            : [ret] "=w" (-> u8x16),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else {
        return a & b;
    }
}

test vandq_u8 {
    const a: u8x16 = .{ 0x00, 0x01, 0x02, 0x03, 0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x00, 0x01, 0x02, 0x03 };
    const b: u8x16 = .{ 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F };
    const expected: u8x16 = .{ 0x00, 0x01, 0x02, 0x03, 0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x00, 0x01, 0x02, 0x03 };

    try testIntrinsic("vandq_u8", vandq_u8, expected, .{ a, b });
}

/// Vector bitwise and
pub inline fn vandq_u16(a: i16x8, b: i16x8) u16x8 {
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        return asm ("and %[ret].16b, %[a].16b, %[b].16b"
            : [ret] "=w" (-> u16x8),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else if (use_asm and comptime arm.hasFeatures(&.{.neon})) {
        return asm ("vand %[ret], %[a], %[b]"
            : [ret] "=w" (-> u16x8),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else {
        return a & b;
    }
}

test vandq_u16 {
    const a: u16x8 = .{ 0x00, 0x01, 0x02, 0x03, 0x00, 0x01, 0x02, 0x03 };
    const b: u16x8 = .{ 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F };
    const expected: u16x8 = .{ 0x00, 0x01, 0x02, 0x03, 0x00, 0x01, 0x02, 0x03 };

    try testIntrinsic("vandq_u16", vandq_u16, expected, .{ a, b });
}

/// Vector bitwise and
pub inline fn vandq_u32(a: u32x4, b: u32x4) u32x4 {
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        return asm ("and %[ret].16b, %[a].16b, %[b].16b"
            : [ret] "=w" (-> u32x4),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else if (use_asm and comptime arm.hasFeatures(&.{.neon})) {
        return asm ("vand %[ret], %[a], %[b]"
            : [ret] "=w" (-> u32x4),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else {
        return a & b;
    }
}

test vandq_u32 {
    const a: u32x4 = .{ 0x00, 0x01, 0x00, 0x01 };
    const b: u32x4 = .{ 0x0F, 0x0F, 0x0F, 0x0F };
    const expected: u32x4 = .{ 0x00, 0x01, 0x00, 0x01 };

    try testIntrinsic("vandq_u32", vandq_u32, expected, .{ a, b });
}

/// Vector bitwise and
pub inline fn vandq_u64(a: u64x2, b: u64x2) u64x2 {
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        return asm ("and %[ret].16b, %[a].16b, %[b].16b"
            : [ret] "=w" (-> u64x2),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else if (use_asm and comptime arm.hasFeatures(&.{.neon})) {
        return asm ("vand %[ret], %[a], %[b]"
            : [ret] "=w" (-> u64x2),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else {
        return a & b;
    }
}

test vandq_u64 {
    const a: u64x2 = .{ 0x00, 0x00 };
    const b: u64x2 = .{ 0x0F, 0x0F };
    const expected: u64x2 = .{ 0x00, 0x00 };

    try testIntrinsic("vandq_u64", vandq_u64, expected, .{ a, b });
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
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        var result = a;
        asm ("bsl %[ret].8b, %[b].8b, %[c].8b"
            : [ret] "+w" (result),
            : [b] "w" (b),
              [c] "w" (c),
        );
        return result;
    } else {
        return c ^ ((c ^ b) & a);
    }
}

test vbsl_s8 {
    const a: i8x8 = .{ -1, -1, -1, -1, 0, 0, 0, 0 };
    const b: i8x8 = .{ std.math.maxInt(i8), std.math.maxInt(i8), std.math.maxInt(i8), std.math.maxInt(i8), std.math.maxInt(i8), std.math.maxInt(i8), std.math.maxInt(i8), std.math.maxInt(i8) };
    const c: i8x8 = .{ std.math.minInt(i8), std.math.minInt(i8), std.math.minInt(i8), std.math.minInt(i8), std.math.minInt(i8), std.math.minInt(i8), std.math.minInt(i8), std.math.minInt(i8) };
    const expected: i8x8 = .{ std.math.maxInt(i8), std.math.maxInt(i8), std.math.maxInt(i8), std.math.maxInt(i8), std.math.minInt(i8), std.math.minInt(i8), std.math.minInt(i8), std.math.minInt(i8) };

    try testIntrinsic("vbsl_s8", vbsl_s8, expected, .{ a, b, c });
}

/// Bitwise Select
pub inline fn vbsl_s16(a: i16x4, b: i16x4, c: i16x4) i16x4 {
    return c ^ ((c ^ b) & a);
}

/// Bitwise Select
pub inline fn vbsl_s32(a: i32x2, b: i32x2, c: i32x2) i32x2 {
    return c ^ ((c ^ b) & a);
}

/// Bitwise Select
pub inline fn vbsl_s64(a: i64x1, b: i64x1, c: i64x1) i64x1 {
    return c ^ ((c ^ b) & a);
}

/// Bitwise Select
pub inline fn vbsl_u8(a: u8x8, b: u8x8, c: u8x8) u8x8 {
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        var result = a;
        asm ("bsl %[ret].8b, %[b].8b, %[c].8b"
            : [ret] "+w" (result),
            : [b] "w" (b),
              [c] "w" (c),
        );
        return result;
    } else {
        return c ^ ((c ^ b) & a);
    }
}

test vbsl_u8 {
    const a: u8x8 = .{ std.math.maxInt(u8), 0, std.math.maxInt(u8), 2, std.math.maxInt(u8), 0, std.math.maxInt(u8), 0 };
    const b: u8x8 = .{ std.math.maxInt(u8), std.math.maxInt(u8), std.math.maxInt(u8), std.math.maxInt(u8), std.math.maxInt(u8), std.math.maxInt(u8), std.math.maxInt(u8), std.math.maxInt(u8) };
    const c: u8x8 = .{ std.math.minInt(u8), std.math.minInt(u8), std.math.minInt(u8), std.math.minInt(u8), std.math.minInt(u8), std.math.minInt(u8), std.math.minInt(u8), std.math.minInt(u8) };
    const expected: u8x8 = .{ std.math.maxInt(u8), 0, std.math.maxInt(u8), 2, std.math.maxInt(u8), std.math.minInt(u8), std.math.maxInt(u8), std.math.minInt(u8) };

    try testIntrinsic("vbsl_u8", vbsl_u8, expected, .{ a, b, c });
}

/// Bitwise Select
pub inline fn vbsl_u16(a: u16x4, b: u16x4, c: u16x4) u16x4 {
    return c ^ ((c ^ b) & a);
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
    return c ^ ((c ^ b) & a);
}

/// Bitwise Select
pub inline fn vbsl_u64(a: i64x1, b: i64x1, c: i64x1) i64x1 {
    return c ^ ((c ^ b) & a);
}

/// Bitwise Select
/// TODO: Once zig implements bitwise operations on vector
///       of floats, we can just do c ^ ((c ^ b) & a).
pub inline fn vbsl_f32(a: f32x2, b: f32x2, c: f32x2) f32x2 {
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        var result = a;
        asm ("bsl %[ret].8b, %[b].8b, %[c].8b"
            : [ret] "+w" (result),
            : [b] "w" (b),
              [c] "w" (c),
        );
        return result;
    } else {
        return @bitCast(@as(u32x2, @bitCast(c)) ^ ((@as(u32x2, @bitCast(c)) ^ @as(u32x2, @bitCast(b))) & @as(u32x2, @bitCast(a))));
    }
}

test vbsl_f32 {
    const a: f32x2 = .{ std.math.floatMax(f32), 0 };
    const b: f32x2 = .{ 5, 5 };
    const c: f32x2 = .{ std.math.floatMin(f32), std.math.floatMin(f32) };
    const expected: f32x2 = .{ 5, std.math.floatMin(f32) };

    try testIntrinsic("vbsl_f32", vbsl_f32, expected, .{ a, b, c });
}

/// Bitwise Select
/// TODO: Once zig implements bitwise operations on vector
///       of floats, we can just do c ^ ((c ^ b) & a).
pub inline fn vbsl_f64(a: f64x1, b: f64x1, c: f64x1) f64x1 {
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        var result = a;
        asm ("bsl %[ret].8b, %[b].8b, %[c].8b"
            : [ret] "+w" (result),
            : [b] "w" (b),
              [c] "w" (c),
        );
        return result;
    } else {
        return @bitCast(@as(u64x1, @bitCast(c)) ^ ((@as(u64x1, @bitCast(c)) ^ @as(u64x1, @bitCast(b))) & @as(u64x1, @bitCast(a))));
    }
}

test vbsl_f64 {
    const a: f64x1 = .{std.math.floatMax(f64)};
    const b: f64x1 = .{5};
    const c: f64x1 = .{std.math.floatMin(f64)};
    const expected: f64x1 = .{5};

    try expectEqual(expected, vbsl_f64(a, b, c));
}

/// Bitwise Select
pub inline fn vbsl_p8(a: p8x8, b: p8x8, c: p8x8) p8x8 {
    return c ^ ((c ^ b) & a);
}

/// Bitwise Select
pub inline fn vbsl_p64(a: p64x1, b: p64x1, c: p64x1) p64x1 {
    return c ^ ((c ^ b) & a);
}

/// Bitwise Select
pub inline fn vbsl_p16(a: p16x4, b: p16x4, c: p16x4) p16x4 {
    return c ^ ((c ^ b) & a);
}

/// Bitwise Select
pub inline fn vbslq_s8(a: i8x16, b: i8x16, c: i8x16) i8x16 {
    return c ^ ((c ^ b) & a);
}

/// Bitwise Select
pub inline fn vbslq_s16(a: i16x8, b: i16x8, c: i16x8) i16x8 {
    return c ^ ((c ^ b) & a);
}

/// Bitwise Select
pub inline fn vbslq_s32(a: i32x4, b: i32x4, c: i32x4) i32x4 {
    return c ^ ((c ^ b) & a);
}

/// Bitwise Select
pub inline fn vbslq_s64(a: i64x2, b: i64x2, c: i64x2) i64x2 {
    return c ^ ((c ^ b) & a);
}

/// Bitwise Select
pub inline fn vbslq_u8(a: u8x16, b: u8x16, c: u8x16) u8x16 {
    return c ^ ((c ^ b) & a);
}

/// Bitwise Select
pub inline fn vbslq_u16(a: u16x8, b: u16x8, c: u16x8) u16x8 {
    return c ^ ((c ^ b) & a);
}

/// Bitwise Select
pub inline fn vbslq_u32(a: u32x4, b: u32x4, c: u32x4) u32x4 {
    return c ^ ((c ^ b) & a);
}

/// Bitwise Select
pub inline fn vbslq_u64(a: i64x2, b: i64x2, c: i64x2) i64x2 {
    return c ^ ((c ^ b) & a);
}

/// Bitwise Select
pub inline fn vbslq_f32(a: f32x4, b: f32x4, c: f32x4) f32x4 {
    return c ^ ((c ^ b) & a);
}

/// Bitwise Select
pub inline fn vbslq_f64(a: f64x2, b: f64x2, c: f64x2) f64x2 {
    return c ^ ((c ^ b) & a);
}

/// Bitwise Select
pub inline fn vbslq_p8(a: p8x16, b: p8x16, c: p8x16) p8x16 {
    return c ^ ((c ^ b) & a);
}

/// Bitwise Select
pub inline fn vbslq_p16(a: p16x8, b: p16x8, c: p16x8) p16x8 {
    return c ^ ((c ^ b) & a);
}

/// Bitwise Select
pub inline fn vbslq_p64(a: p64x2, b: p64x2, c: p64x2) p64x2 {
    return c ^ ((c ^ b) & a);
}

/// Bit clear and exclusive OR
pub inline fn vbcaxq_s8(a: i8x16, b: i8x16, c: i8x16) i8x16 {
    if (use_asm and comptime aarch64.hasFeatures(&.{ .neon, .sha3 })) {
        return asm ("bcax %[ret].16b, %[a].16b, %[b].16b, %[c].16b"
            : [ret] "=w" (-> i8x16),
            : [a] "w" (a),
              [b] "w" (b),
              [c] "w" (c),
        );
    } else if (use_builtins and comptime aarch64.hasFeatures(&.{ .neon, .sha3 })) {
        return struct {
            extern fn @"llvm.aarch64.crypto.bcaxs.v16i8"(i8x16, i8x16, i8x16) i8x16;
        }.@"llvm.aarch64.crypto.bcaxs.v16i8"(a, b, c);
    } else {
        return a ^ (b & ~c);
    }
}

test vbcaxq_s8 {
    const a: i8x16 = .{ 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0 };
    const b: i8x16 = .{ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 };
    const c: i8x16 = .{ 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 };
    const expected: i8x16 = .{ 1, 0, 3, 2, 5, 4, 7, 6, 9, 8, 11, 10, 13, 12, 15, 14 };

    try testIntrinsic("vbcaxq_s8", vbcaxq_s8, expected, .{ a, b, c });
}

/// Bit clear and exclusive OR
pub inline fn vbcaxq_s16(a: i16x8, b: i16x8, c: i16x8) i16x8 {
    if (use_asm and comptime aarch64.hasFeatures(&.{ .neon, .sha3 })) {
        return asm ("bcax %[ret].16b, %[a].16b, %[b].16b, %[c].16b"
            : [ret] "=w" (-> i16x8),
            : [a] "w" (a),
              [b] "w" (b),
              [c] "w" (c),
        );
    } else if (use_builtins and comptime aarch64.hasFeatures(&.{ .neon, .sha3 })) {
        return struct {
            extern fn @"llvm.aarch64.crypto.bcaxs.v8i16"(i16x8, i16x8, i16x8) i16x8;
        }.@"llvm.aarch64.crypto.bcaxs.v8i16"(a, b, c);
    } else {
        return a ^ (b & ~c);
    }
}

test vbcaxq_s16 {
    const a: i16x8 = .{ 1, 0, 1, 0, 1, 0, 1, 0 };
    const b: i16x8 = .{ 0, 1, 2, 3, 4, 5, 6, 7 };
    const c: i16x8 = .{ 1, 1, 1, 1, 1, 1, 1, 1 };
    const expected: i16x8 = .{ 1, 0, 3, 2, 5, 4, 7, 6 };

    try testIntrinsic("vbcaxq_s16", vbcaxq_s16, expected, .{ a, b, c });
}

/// Bit clear and exclusive OR
pub inline fn vbcaxq_s32(a: i32x4, b: i32x4, c: i32x4) i32x4 {
    if (use_asm and comptime aarch64.hasFeatures(&.{ .neon, .sha3 })) {
        return asm ("bcax %[ret].16b, %[a].16b, %[b].16b, %[c].16b"
            : [ret] "=w" (-> i32x4),
            : [a] "w" (a),
              [b] "w" (b),
              [c] "w" (c),
        );
    } else if (use_builtins and comptime aarch64.hasFeatures(&.{ .neon, .sha3 })) {
        return struct {
            extern fn @"llvm.aarch64.crypto.bcaxs.v4i32"(i32x4, i32x4, i32x4) i32x4;
        }.@"llvm.aarch64.crypto.bcaxs.v4i32"(a, b, c);
    } else {
        return a ^ (b & ~c);
    }
}

test vbcaxq_s32 {
    const a: i32x4 = .{ 1, 0, 1, 0 };
    const b: i32x4 = .{ 0, 1, 2, 3 };
    const c: i32x4 = .{ 1, 1, 1, 1 };
    const expected: i32x4 = .{ 1, 0, 3, 2 };

    try testIntrinsic("vbcaxq_s32", vbcaxq_s32, expected, .{ a, b, c });
}

/// Bit clear and exclusive OR
pub inline fn vbcaxq_s64(a: i64x2, b: i64x2, c: i64x2) i64x2 {
    if (use_asm and comptime aarch64.hasFeatures(&.{ .neon, .sha3 })) {
        return asm ("bcax %[ret].16b, %[a].16b, %[b].16b, %[c].16b"
            : [ret] "=w" (-> i64x2),
            : [a] "w" (a),
              [b] "w" (b),
              [c] "w" (c),
        );
    } else if (use_builtins and comptime aarch64.hasFeatures(&.{ .neon, .sha3 })) {
        return struct {
            extern fn @"llvm.aarch64.crypto.bcaxs.v2i64"(i64x2, i64x2, i64x2) i64x2;
        }.@"llvm.aarch64.crypto.bcaxs.v2i64"(a, b, c);
    } else {
        return a ^ (b & ~c);
    }
}

test vbcaxq_s64 {
    const a: i64x2 = .{ 1, 0 };
    const b: i64x2 = .{ 0, 1 };
    const c: i64x2 = .{ 1, 1 };
    const expected: i64x2 = .{ 1, 0 };

    try testIntrinsic("vbcaxq_s64", vbcaxq_s64, expected, .{ a, b, c });
}

/// Floating-point absolute compare greater than or equal
pub inline fn vcage_f32(a: f32x2, b: f32x2) u32x2 {
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        return asm ("facge %[ret].2s, %[a].2s, %[b].2s"
            : [ret] "=w" (-> u32x2),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else if (use_asm and comptime arm.hasFeatures(&.{.neon})) {
        return asm ("vacge.f32 %[ret], %[a], %[b]"
            : [ret] "=w" (-> u32x2),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else if (use_builtins and comptime aarch64.hasFeatures(&.{.neon})) {
        return struct {
            extern fn @"llvm.aarch64.neon.facge.v2i32.v2f32"(f32x2, f32x2) u32x2;
        }.@"llvm.aarch64.neon.facge.v2i32.v2f32"(a, b);
    } else if (use_builtins and comptime arm.hasFeatures(&.{.neon})) {
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
    const expected = u32x2{ 0x00000000, 0xffffffff };

    try testIntrinsic("vcage_f32", vcage_f32, expected, .{ a, b });
}

/// Floating-point absolute compare greater than or equal
pub inline fn vcageq_f32(a: f32x4, b: f32x4) u32x4 {
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        return asm ("facge %[ret].4s, %[a].4s, %[b].4s"
            : [ret] "=w" (-> u32x4),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else if (use_asm and comptime arm.hasFeatures(&.{.neon})) {
        return asm ("vacge.f32 %[ret], %[a], %[b]"
            : [ret] "=w" (-> u32x4),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else if (use_builtins and comptime aarch64.hasFeatures(&.{.neon})) {
        return struct {
            extern fn @"llvm.aarch64.neon.facge.v4i32.v4f32"(f32x4, f32x4) u32x4;
        }.@"llvm.aarch64.neon.facge.v4i32.v4f32"(a, b);
    } else if (use_builtins and comptime arm.hasFeatures(&.{.neon})) {
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
    const expected = u32x4{ 0x00000000, 0xffffffff, 0xffffffff, 0xffffffff };

    try testIntrinsic("vcageq_f32", vcageq_f32, expected, .{ a, b });
}

/// Floating-point absolute compare greater than or equal
pub inline fn vcageq_f64(a: f64x2, b: f64x2) u64x2 {
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        return asm ("facge %[ret].2d, %[a].2d, %[b].2d"
            : [ret] "=w" (-> u64x2),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else if (use_builtins and comptime aarch64.hasFeatures(&.{.neon})) {
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
    const expected = u64x2{ 0x0000000000000000, 0xffffffffffffffff };

    try testIntrinsic("vcageq_f64", vcageq_f64, expected, .{ a, b });
}

/// Floating-point absolute compare greater than
pub inline fn vcagt_f32(a: f32x2, b: f32x2) u32x2 {
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        return asm ("facgt %[ret].2s, %[a].2s, %[b].2s"
            : [ret] "=w" (-> u32x2),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else if (use_asm and comptime arm.hasFeatures(&.{.neon})) {
        return asm ("vacgt.f32 %[ret], %[a], %[b]"
            : [ret] "=w" (-> u32x2),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else if (use_builtins and comptime aarch64.hasFeatures(&.{.neon})) {
        return struct {
            extern fn @"llvm.aarch64.neon.facgt.v2i32.v2f32"(f32x2, f32x2) u32x2;
        }.@"llvm.aarch64.neon.facgt.v2i32.v2f32"(a, b);
    } else if (use_builtins and comptime arm.hasFeatures(&.{.neon})) {
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

    try testIntrinsic("vcagt_f32", vcagt_f32, expected, .{ a, b });
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

/// Unsigned Move vector element to general-purpose register
pub inline fn vget_lane_p8(vec: p8x8, comptime lane: usize) p8 {
    comptime assert(lane < 8);
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        switch (endianness) {
            inline .little => {
                return asm ("umov %[ret:w], %[vec].b[%[lane]]"
                    : [ret] "=r" (-> u8),
                    : [vec] "w" (vec),
                      [lane] "i" (lane),
                );
            },
            inline .big => {
                return asm (
                    \\ rev64 %[vec].8b, %[vec].8b
                    \\ umov  %[ret:w], %[vec].b[%[lane]]
                    : [ret] "=r" (-> p8),
                    : [vec] "w" (vec),
                      [lane] "i" (lane),
                );
            },
        }
    } else if (use_asm and comptime arm.hasFeatures(&.{.neon})) {
        return asm ("vmov.u8 %[ret], %[vec][ " ++ numToString(lane) ++ "]"
            : [ret] "=r" (-> p8),
            : [vec] "w" (vec),
        );
    } else {
        return vec[lane];
    }
}

test vget_lane_p8 {
    const v: p8x8 = .{ 0, 1, 2, 3, 4, 5, 6, 7 };
    const lane: usize = 6;
    const expected: p8 = 6;

    try testIntrinsic("vget_lane_p8", vget_lane_p8, expected, .{ v, lane });
}

/// Unsigned Move vector element to general-purpose register
pub inline fn vget_lane_p16(vec: p16x4, comptime lane: usize) p16 {
    comptime assert(lane < 4);
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        switch (endianness) {
            inline .little => {
                return asm ("umov %[ret:w], %[vec].h[%[lane]]"
                    : [ret] "=r" (-> p16),
                    : [vec] "w" (vec),
                      [lane] "i" (lane),
                );
            },
            inline .big => {
                return asm (
                    \\ rev64 %[vec].4h, %[vec].4h
                    \\ umov  %[ret:w], %[vec].h[%[lane]]
                    : [ret] "=r" (-> p16),
                    : [vec] "w" (vec),
                      [lane] "i" (lane),
                );
            },
        }
    } else if (use_asm and comptime arm.hasFeatures(&.{.neon})) {
        return asm ("vmov.u16 %[ret], %[vec][ " ++ numToString(lane) ++ "]"
            : [ret] "=r" (-> p16),
            : [vec] "w" (vec),
        );
    } else {
        return vec[lane];
    }
}

test vget_lane_p16 {
    const v: p16x4 = .{ 0, 1, 2, 3 };
    const lane: usize = 2;
    const expected: p16 = 2;

    try testIntrinsic("vget_lane_p16", vget_lane_p16, expected, .{ v, lane });
}

/// Unsigned Move vector element to general-purpose register
pub inline fn vget_lane_p64(vec: p64x1, comptime lane: usize) p64 {
    comptime assert(lane < 1);
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        return asm ("umov %[ret], %[vec].d[%[lane]]"
            : [ret] "=r" (-> p64),
            : [vec] "w" (vec),
              [lane] "i" (lane),
        );
    } else if (use_asm and comptime arm.hasFeatures(&.{.neon})) {
        return asm (
            \\ vmov.32 r0, %[vec][0]
            \\ vmov.32 r1, %[vec][1]
            : [ret] "={r0}" (-> p64),
            : [vec] "w" (vec),
            : "r1"
        );
    } else {
        return vec[lane];
    }
}

test vget_lane_p64 {
    const v: p64x1 = .{std.math.maxInt(p64)};
    const lane: usize = 0;
    const expected: p64 = std.math.maxInt(p64);

    try testIntrinsic("vget_lane_p64", vget_lane_p64, expected, .{ v, lane });
}

/// Signed Move vector element to general-purpose register
pub inline fn vget_lane_s8(vec: i8x8, comptime lane: usize) i8 {
    comptime assert(lane < 8);
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        switch (endianness) {
            inline .little => {
                return asm ("smov %[ret:w], %[vec].b[%[lane]]"
                    : [ret] "=r" (-> i8),
                    : [vec] "w" (vec),
                      [lane] "i" (lane),
                );
            },
            inline .big => {
                return asm (
                    \\ rev64 %[vec].8b, %[vec].8b
                    \\ umov %[ret:w], %[vec].b[%[lane]]
                    : [ret] "=r" (-> i8),
                    : [vec] "w" (vec),
                      [lane] "i" (lane),
                );
            },
        }
    } else if (use_asm and comptime arm.hasFeatures(&.{.neon})) {
        return asm ("vmov.s8 %[ret], %[vec][ " ++ numToString(lane) ++ "]"
            : [ret] "=r" (-> i8),
            : [vec] "w" (vec),
        );
    } else {
        return vec[lane];
    }
}

test vget_lane_s8 {
    const v: i8x8 = .{ 0, 1, 2, 3, 4, 5, 6, 7 };
    const lane: usize = 5;
    const expected: i8 = 5;

    try testIntrinsic("vget_lane_s8", vget_lane_s8, expected, .{ v, lane });
}

/// Signed Move vector element to general-purpose register
pub inline fn vget_lane_s16(vec: i16x4, comptime lane: usize) i16 {
    comptime assert(lane < 4);
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        switch (endianness) {
            inline .little => {
                return asm ("smov %[ret:w], %[vec].h[%[lane]]"
                    : [ret] "=r" (-> i16),
                    : [vec] "w" (vec),
                      [lane] "i" (lane),
                );
            },
            inline .big => {
                return asm (
                    \\ rev64 %[vec].4h, %[vec].4h
                    \\ umov %[ret:w], %[vec].h[%[lane]]
                    : [ret] "=r" (-> i16),
                    : [vec] "w" (vec),
                      [lane] "i" (lane),
                );
            },
        }
    } else if (use_asm and comptime arm.hasFeatures(&.{.neon})) {
        return asm ("vmov.s16 %[ret], %[vec][ " ++ numToString(lane) ++ "]"
            : [ret] "=r" (-> i16),
            : [vec] "w" (vec),
        );
    } else {
        return vec[lane];
    }
}

test vget_lane_s16 {
    const v: i16x4 = .{ 0, 1, 2, 3 };
    const lane: usize = 2;
    const expected: i16 = 2;

    try testIntrinsic("vget_lane_s16", vget_lane_s16, expected, .{ v, lane });
}

/// Signed Move vector element to general-purpose register
pub inline fn vget_lane_s32(vec: i32x2, comptime lane: usize) i32 {
    comptime assert(lane < 2);
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        switch (endianness) {
            inline .little => {
                return asm ("mov %[ret:w], %[vec].s[%[lane]]"
                    : [ret] "=r" (-> i32),
                    : [vec] "w" (vec),
                      [lane] "i" (lane),
                );
            },
            inline .big => {
                return asm (
                    \\ rev64 %[vec].2s, %[vec].2s
                    \\ mov %[ret:w], %[vec].s[%[lane]]
                    : [ret] "=r" (-> i32),
                    : [vec] "w" (vec),
                      [lane] "i" (lane),
                );
            },
        }
    } else if (use_asm and comptime arm.hasFeatures(&.{.neon})) {
        return asm ("vmov.32 %[ret], %[vec][ " ++ numToString(lane) ++ "]"
            : [ret] "=r" (-> i32),
            : [vec] "w" (vec),
        );
    } else {
        return vec[lane];
    }
}

test vget_lane_s32 {
    const v: i32x2 = .{ 0, 1 };
    const lane: usize = 0;
    const expected: i32 = 0;

    try testIntrinsic("vget_lane_s32", vget_lane_s32, expected, .{ v, lane });
}

/// Signed Move vector element to general-purpose register
pub inline fn vget_lane_s64(vec: i64x1, comptime lane: usize) i64 {
    comptime assert(lane < 1);
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        return asm ("fmov %[ret], %[vec:d]"
            : [ret] "=r" (-> i64),
            : [vec] "w" (vec),
        );
    } else if (use_asm and comptime arm.hasFeatures(&.{.neon})) {
        return asm (
            \\ vmov.32 r0, %[vec][0]
            \\ vmov.32 r1, %[vec][1]
            : [ret] "={r0}" (-> i64),
            : [vec] "w" (vec),
            : "r0"
        );
    } else {
        return vec[lane];
    }
}

test vget_lane_s64 {
    const v: i64x1 = .{std.math.maxInt(i64)};
    const lane: usize = 0;
    const expected: i64 = std.math.maxInt(i64);

    try testIntrinsic("vget_lane_s64", vget_lane_s64, expected, .{ v, lane });
}

/// Unigned Move vector element to general-purpose register
pub inline fn vget_lane_u8(vec: u8x8, comptime lane: usize) u8 {
    comptime assert(lane < 8);
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        switch (endianness) {
            inline .little => {
                return asm ("umov %[ret:w], %[vec].b[%[lane]]"
                    : [ret] "=r" (-> u8),
                    : [vec] "w" (vec),
                      [lane] "i" (lane),
                );
            },
            inline .big => {
                return asm (
                    \\ rev64 %[vec].8b, %[vec].8b
                    \\ umov %[ret:w], %[vec].b[%[lane]]
                    : [ret] "=r" (-> u8),
                    : [vec] "w" (vec),
                      [lane] "i" (lane),
                );
            },
        }
    } else if (use_asm and comptime arm.hasFeatures(&.{.neon})) {
        return asm ("vmov.u8 %[ret], %[vec][ " ++ numToString(lane) ++ "]"
            : [ret] "=r" (-> u8),
            : [vec] "w" (vec),
        );
    } else {
        return vec[lane];
    }
}

test vget_lane_u8 {
    const v: u8x8 = .{ 0, 1, 2, 3, 4, 5, 6, 7 };
    const lane: usize = 5;
    const expected: u8 = 5;

    try testIntrinsic("vget_lane_u8", vget_lane_u8, expected, .{ v, lane });
}

/// Unigned Move vector element to general-purpose register
pub inline fn vget_lane_u16(vec: u16x4, comptime lane: usize) u16 {
    comptime assert(lane < 4);
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        switch (endianness) {
            inline .little => {
                return asm ("umov %[ret:w], %[vec].h[%[lane]]"
                    : [ret] "=r" (-> u16),
                    : [vec] "w" (vec),
                      [lane] "i" (lane),
                );
            },
            inline .big => {
                return asm (
                    \\ rev64 %[vec].4h, %[vec].4h
                    \\ umov %[ret:w], %[vec].h[%[lane]]
                    : [ret] "=r" (-> u16),
                    : [vec] "w" (vec),
                      [lane] "i" (lane),
                );
            },
        }
    } else if (use_asm and comptime arm.hasFeatures(&.{.neon})) {
        return asm ("vmov.u16 %[ret], %[vec][ " ++ numToString(lane) ++ "]"
            : [ret] "=r" (-> u16),
            : [vec] "w" (vec),
        );
    } else {
        return vec[lane];
    }
}

test vget_lane_u16 {
    const v: u16x4 = .{ 0, 1, 2, 3 };
    const lane: usize = 2;
    const expected: u16 = 2;

    try testIntrinsic("vget_lane_u16", vget_lane_u16, expected, .{ v, lane });
}

/// Unigned Move vector element to general-purpose register
pub inline fn vget_lane_u32(vec: u32x2, comptime lane: usize) u32 {
    comptime assert(lane < 2);
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        switch (endianness) {
            inline .little => {
                return asm ("umov %[ret:w], %[vec].s[%[lane]]"
                    : [ret] "=r" (-> u32),
                    : [vec] "w" (vec),
                      [lane] "i" (lane),
                );
            },
            inline .big => {
                return asm (
                    \\ rev64 %[vec].2s, %[vec].2s
                    \\ umov %[ret:w], %[vec].s[%[lane]]
                    : [ret] "=r" (-> u32),
                    : [vec] "w" (vec),
                      [lane] "i" (lane),
                );
            },
        }
    } else if (use_asm and comptime arm.hasFeatures(&.{.neon})) {
        return asm ("vmov.32 %[ret], %[vec][" ++ numToString(lane) ++ "]"
            : [ret] "=r" (-> u32),
            : [vec] "w" (vec),
        );
    } else {
        return vec[lane];
    }
}

test vget_lane_u32 {
    const v: u32x2 = .{ 0, 1 };
    const lane: usize = 0;
    const expected: u32 = 0;

    try testIntrinsic("vget_lane_u32", vget_lane_u32, expected, .{ v, lane });
}

/// Unigned Move vector element to general-purpose register
pub inline fn vget_lane_u64(vec: u64x1, comptime lane: usize) u64 {
    comptime assert(lane < 1);
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        return asm ("umov %[ret], %[vec].d[%[lane]]"
            : [ret] "=r" (-> u64),
            : [vec] "w" (vec),
              [lane] "i" (lane),
        );
    } else if (use_asm and comptime arm.hasFeatures(&.{.neon})) {
        return asm (
            \\ vmov.32 r0, %[vec][0]
            \\ vmov.32 r1, %[vec][1]
            : [ret] "={r0}" (-> u64),
            : [vec] "w" (vec),
            : "r1"
        );
    } else {
        return vec[lane];
    }
}

test vget_lane_u64 {
    const v: u64x1 = .{std.math.maxInt(u64)};
    const lane: usize = 0;
    const expected: u64 = std.math.maxInt(u64);

    try testIntrinsic("vget_lane_u64", vget_lane_u64, expected, .{ v, lane });
}

/// Duplicate vector element to vector or scalar (for floating-point)
pub inline fn vget_lane_f32(vec: f32x2, comptime lane: usize) f32 {
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        switch (endianness) {
            inline .little => {
                return asm ("mov %[ret:s], %[vec].s[%[lane]]"
                    : [ret] "=w" (-> f32),
                    : [vec] "w" (vec),
                      [lane] "i" (lane),
                );
            },
            inline .big => {
                return asm (
                    \\ rev64 %[vec].2s, %[vec].2s
                    \\ mov   %[ret:s], %[vec].s[%[lane]]
                    : [ret] "=w" (-> f32),
                    : [vec] "w" (vec),
                      [lane] "i" (lane),
                );
            },
        }
    } else if (use_asm and comptime arm.hasFeatures(&.{.neon})) {
        return asm volatile ("vmov.f32 %[ret], %[vec][ " ++ numToString(lane) ++ "]"
            : [ret] "=r" (-> f32),
            : [vec] "w" (vec),
        );
    } else {
        comptime assert(lane < 2);
        return vec[lane];
    }
}

test vget_lane_f32 {
    const v: f32x2 = .{ 5, 1 };
    const lane: usize = 0;
    const expected: f32 = 5;

    try testIntrinsic("vget_lane_f32", vget_lane_f32, expected, .{ v, lane });
}

/// Floating-point Move vector element to general-purpose register
pub inline fn vget_lane_f64(vec: f64x1, comptime lane: usize) f64 {
    comptime assert(lane < 1);
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        return asm ("mov %[ret:d], %[vec].d[0]"
            : [ret] "=w" (-> f64),
            : [vec] "w" (vec),
        );
    } else {
        return vec[lane];
    }
}

test vget_lane_f64 {
    const v: f64x1 = .{std.math.floatMax(f64)};
    const lane: usize = 0;
    const expected: f64 = std.math.floatMax(f64);

    try testIntrinsic("vget_lane_f64", vget_lane_f64, expected, .{ v, lane });
}

/// Load multiple single-element structures to one, two, three, or four registers
pub inline fn vld1q_u8(mem_addr: [*]const u8) u8x16 {
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        return asm ("ld1 {%[ret].16b}, [%[addr]]"
            : [ret] "=w" (-> u8x16),
            : [addr] "r" (mem_addr),
        );
    } else if (use_asm and comptime arm.hasFeatures(&.{ .neon, .has_v7 })) {
        return asm ("vld1.8 {%[ret]}, [%[addr]]"
            : [ret] "=w" (-> u8x16),
            : [addr] "r" (mem_addr),
        );
    } else if (use_builtins and comptime arm.hasFeatures(&.{ .neon, .has_v7 })) {
        return struct {
            extern fn @"llvm.arm.neon.vld1.v16i8.p0i8"([*]const u8, i32) u8x16;
        }.@"llvm.arm.neon.vld1.v16i8.p0i8"(mem_addr, @alignOf(u8));
    } else {
        return .{ mem_addr[0], mem_addr[1], mem_addr[2], mem_addr[3], mem_addr[4], mem_addr[5], mem_addr[6], mem_addr[7], mem_addr[8], mem_addr[9], mem_addr[10], mem_addr[11], mem_addr[12], mem_addr[13], mem_addr[14], mem_addr[15] };
    }
}

test vld1q_u8 {
    const addr = ([16]u8{ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, std.math.maxInt(u8) })[0..].ptr;
    const expected: u8x16 = .{ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, std.math.maxInt(u8) };

    try testIntrinsic("vld1q_u8", vld1q_u8, expected, .{addr});
}

/// Load multiple single-element structures to one, two, three, or four registers
pub inline fn vld1q_u16(mem_addr: [*]const u16) u16x8 {
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        switch (endianness) {
            inline .little => {
                return asm ("ld1 {%[ret].8h}, [%[addr]]"
                    : [ret] "=w" (-> u16x8),
                    : [addr] "r" (mem_addr),
                );
            },
            inline .big => {
                return asm (
                    \\ ld1   {%[ret].8h}, [%[addr]]
                    \\ rev16 %[ret].16b, %[ret].16b
                    : [ret] "=w" (-> u16x8),
                    : [addr] "r" (mem_addr),
                );
            },
        }
    } else if (use_asm and comptime arm.hasFeatures(&.{ .neon, .has_v7 })) {
        return asm ("vld1.16 {%[ret]}, [%[addr]]"
            : [ret] "=w" (-> u16x8),
            : [addr] "r" (mem_addr),
        );
    } else if (use_builtins and comptime arm.hasFeatures(&.{ .neon, .has_v7 })) {
        return struct {
            extern fn @"llvm.arm.neon.vld1.v8i16.p0i8"([*]const u16, i32) u16x8;
        }.@"llvm.arm.neon.vld1.v8i16.p0i8"(mem_addr, @alignOf(u16));
    } else {
        return .{ mem_addr[0], mem_addr[1], mem_addr[2], mem_addr[3], mem_addr[4], mem_addr[5], mem_addr[6], mem_addr[7] };
    }
}

test vld1q_u16 {
    const addr = ([8]u16{ 0, 1, 2, 3, 4, 5, 6, std.math.maxInt(u16) })[0..].ptr;
    const expected: u16x8 = .{ 0, 1, 2, 3, 4, 5, 6, std.math.maxInt(u16) };

    try testIntrinsic("vld1q_u16", vld1q_u16, expected, .{addr});
}

/// Load multiple single-element structures to one, two, three, or four registers
pub inline fn vld1q_u32(mem_addr: [*]const u32) u32x4 {
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        switch (endianness) {
            inline .little => {
                return asm ("ld1 {%[ret].4s}, [%[addr]]"
                    : [ret] "=w" (-> u32x4),
                    : [addr] "r" (mem_addr),
                );
            },
            inline .big => {
                return asm (
                    \\ ld1   {%[ret].4s}, [%[addr]]
                    \\ rev32 %[ret].16b, %[ret].16b
                    : [ret] "=w" (-> u32x4),
                    : [addr] "r" (mem_addr),
                );
            },
        }
    } else if (use_asm and comptime arm.hasFeatures(&.{ .neon, .has_v7 })) {
        return asm ("vld1.32 {%[ret]}, [%[addr]]"
            : [ret] "=w" (-> u32x4),
            : [addr] "r" (mem_addr),
        );
    } else if (use_builtins and comptime arm.hasFeatures(&.{ .neon, .has_v7 })) {
        return struct {
            extern fn @"llvm.arm.neon.vld1.v4i32.p0i8"([*]const u32, i32) u32x4;
        }.@"llvm.arm.neon.vld1.v4i32.p0i8"(mem_addr, @alignOf(u32));
    } else {
        return .{ mem_addr[0], mem_addr[1], mem_addr[2], mem_addr[3] };
    }
}

test vld1q_u32 {
    const addr = ([4]u32{ 0, 1, 2, std.math.maxInt(u32) })[0..].ptr;
    const expected: u32x4 = .{ 0, 1, 2, std.math.maxInt(u32) };

    try testIntrinsic("vld1q_u32", vld1q_u32, expected, .{addr});
}

/// Load multiple single-element structures to one, two, three, or four registers
pub inline fn vld1q_u64(mem_addr: [*]const u64) u64x2 {
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        switch (endianness) {
            inline .little => {
                return asm ("ld1 {%[ret].2d}, [%[addr]]"
                    : [ret] "=w" (-> u64x2),
                    : [addr] "r" (mem_addr),
                );
            },
            inline .big => {
                return asm (
                    \\ ld1   {%[ret].2d}, [%[addr]]
                    \\ rev64 %[ret].16b, %[ret].16b
                    : [ret] "=w" (-> u64x2),
                    : [addr] "r" (mem_addr),
                );
            },
        }
    } else if (use_asm and comptime arm.hasFeatures(&.{ .neon, .has_v7 })) {
        return asm ("vld1.64 {%[ret]}, [%[addr]]"
            : [ret] "=w" (-> u64x2),
            : [addr] "r" (mem_addr),
        );
    } else if (use_builtins and comptime arm.hasFeatures(&.{ .neon, .has_v7 })) {
        return struct {
            extern fn @"llvm.arm.neon.vld1.v2i64.p0i8"([*]const u64, i32) u64x2;
        }.@"llvm.arm.neon.vld1.v2i64.p0i8"(mem_addr, @alignOf(u64));
    } else {
        return .{ mem_addr[0], mem_addr[1] };
    }
}

test vld1q_u64 {
    const addr = ([2]u64{ 0, std.math.maxInt(u64) })[0..].ptr;
    const expected: u64x2 = .{ 0, std.math.maxInt(u64) };

    try testIntrinsic("vld1q_u64", vld1q_u64, expected, .{addr});
}

/// Load multiple single-element structures to one, two, three, or four registers
pub inline fn vld1q_i8(mem_addr: [*]const i8) i8x16 {
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        return asm ("ld1 {%[ret].16b}, [%[addr]]"
            : [ret] "=w" (-> i8x16),
            : [addr] "r" (mem_addr),
        );
    } else if (use_asm and comptime arm.hasFeatures(&.{ .neon, .has_v7 })) {
        return asm ("vld1.8 {%[ret]}, [%[addr]]"
            : [ret] "=w" (-> i8x16),
            : [addr] "r" (mem_addr),
        );
    } else if (use_builtins and comptime arm.hasFeatures(&.{ .neon, .has_v7 })) {
        return struct {
            extern fn @"llvm.arm.neon.vld1.v16i8.p0i8"([*]const i8, i32) i8x16;
        }.@"llvm.arm.neon.vld1.v16i8.p0i8"(mem_addr, @alignOf(i8));
    } else {
        return .{ mem_addr[0], mem_addr[1], mem_addr[2], mem_addr[3], mem_addr[4], mem_addr[5], mem_addr[6], mem_addr[7], mem_addr[8], mem_addr[9], mem_addr[10], mem_addr[11], mem_addr[12], mem_addr[13], mem_addr[14], mem_addr[15] };
    }
}

test vld1q_i8 {
    const addr = ([16]i8{ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, std.math.maxInt(i8) })[0..].ptr;
    const expected: i8x16 = .{ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, std.math.maxInt(i8) };

    try testIntrinsic("vld1q_i8", vld1q_i8, expected, .{addr});
}

/// Load multiple single-element structures to one, two, three, or four registers
pub inline fn vld1q_i16(mem_addr: [*]const i16) i16x8 {
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        switch (endianness) {
            inline .little => {
                return asm ("ld1 {%[ret].8h}, [%[addr]]"
                    : [ret] "=w" (-> i16x8),
                    : [addr] "r" (mem_addr),
                );
            },
            inline .big => {
                return asm (
                    \\ ld1 {%[ret].8h}, [%[addr]]
                    \\ rev16 %[ret].16b, %[ret].16b
                    : [ret] "=w" (-> i16x8),
                    : [addr] "r" (mem_addr),
                );
            },
        }
    } else if (use_asm and comptime arm.hasFeatures(&.{ .neon, .has_v7 })) {
        return asm ("vld1.16 {%[ret]}, [%[addr]]"
            : [ret] "=w" (-> i16x8),
            : [addr] "r" (mem_addr),
        );
    } else if (use_builtins and comptime arm.hasFeatures(&.{ .neon, .has_v7 })) {
        return struct {
            extern fn @"llvm.arm.neon.vld1.v8i16.p0i8"([*]const i16, i32) i16x8;
        }.@"llvm.arm.neon.vld1.v8i16.p0i8"(mem_addr, @alignOf(i16));
    } else {
        return .{ mem_addr[0], mem_addr[1], mem_addr[2], mem_addr[3], mem_addr[4], mem_addr[5], mem_addr[6], mem_addr[7] };
    }
}

test vld1q_i16 {
    const addr = ([8]i16{ 0, 1, 2, 3, 4, 5, 6, std.math.maxInt(i16) })[0..].ptr;
    const expected: i16x8 = .{ 0, 1, 2, 3, 4, 5, 6, std.math.maxInt(i16) };

    try testIntrinsic("vld1q_i16", vld1q_i16, expected, .{addr});
}

/// Load multiple single-element structures to one, two, three, or four registers
pub inline fn vld1q_i32(mem_addr: [*]const i32) i32x4 {
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        switch (endianness) {
            inline .little => {
                return asm ("ld1 {%[ret].4s}, [%[addr]]"
                    : [ret] "=w" (-> i32x4),
                    : [addr] "r" (mem_addr),
                );
            },
            inline .big => {
                return asm (
                    \\ ld1   {%[ret].4s}, [%[addr]]
                    \\ rev32 %[ret].16b, %[ret].16b
                    : [ret] "=w" (-> i32x4),
                    : [addr] "r" (mem_addr),
                );
            },
        }
    } else if (use_asm and comptime arm.hasFeatures(&.{ .neon, .has_v7 })) {
        return asm ("vld1.32 {%[ret]}, [%[addr]]"
            : [ret] "=w" (-> i32x4),
            : [addr] "r" (mem_addr),
        );
    } else if (use_builtins and comptime arm.hasFeatures(&.{ .neon, .has_v7 })) {
        return struct {
            extern fn @"llvm.arm.neon.vld1.v4i32.p0i8"([*]const i32, i32) i32x4;
        }.@"llvm.arm.neon.vld1.v4i32.p0i8"(mem_addr, @alignOf(i32));
    } else {
        return .{ mem_addr[0], mem_addr[1], mem_addr[2], mem_addr[3] };
    }
}

test vld1q_i32 {
    const addr = ([4]i32{ 0, 1, 2, std.math.maxInt(i32) })[0..].ptr;
    const expected: i32x4 = .{ 0, 1, 2, std.math.maxInt(i32) };

    try testIntrinsic("vld1q_i32", vld1q_i32, expected, .{addr});
}

/// Load multiple single-element structures to one, two, three, or four registers
pub inline fn vld1q_i64(mem_addr: [*]const i64) i64x2 {
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        switch (endianness) {
            inline .little => {
                return asm ("ld1 {%[ret].2d}, [%[addr]]"
                    : [ret] "=w" (-> i64x2),
                    : [addr] "r" (mem_addr),
                );
            },
            inline .big => {
                return asm (
                    \\ ld1   {%[ret].2d}, [%[addr]]
                    \\ rev64 %[ret].16b, %[ret].16b
                    : [ret] "=w" (-> i64x2),
                    : [addr] "r" (mem_addr),
                );
            },
        }
    } else if (use_asm and comptime arm.hasFeatures(&.{ .neon, .has_v7 })) {
        return asm ("vld1.64 {%[ret]}, [%[addr]]"
            : [ret] "=w" (-> i64x2),
            : [addr] "r" (mem_addr),
        );
    } else if (use_builtins and comptime arm.hasFeatures(&.{ .neon, .has_v7 })) {
        return struct {
            extern fn @"llvm.arm.neon.vld1.v2i64.p0i8"([*]const i64, i32) i64x2;
        }.@"llvm.arm.neon.vld1.v2i64.p0i8"(mem_addr, @alignOf(i64));
    } else {
        return .{ mem_addr[0], mem_addr[1] };
    }
}

test vld1q_i64 {
    const addr = ([2]i64{ 0, std.math.maxInt(i64) })[0..].ptr;
    const expected: i64x2 = .{ 0, std.math.maxInt(i64) };

    try testIntrinsic("vld1q_i64", vld1q_i64, expected, .{addr});
}

/// Load multiple single-element structures to one, two, three, or four registers
pub inline fn vld1q_f32(mem_addr: [*]const f32) f32x4 {
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        switch (endianness) {
            inline .little => {
                return asm ("ld1 {%[ret].4s}, [%[addr]]"
                    : [ret] "=w" (-> f32x4),
                    : [addr] "r" (mem_addr),
                );
            },
            inline .big => {
                return asm (
                    \\ ld1   {%[ret].4s}, [%[addr]]
                    \\ rev32 %[ret].16b, %[ret].16b
                    : [ret] "=w" (-> f32x4),
                    : [addr] "r" (mem_addr),
                );
            },
        }
    } else if (use_asm and comptime arm.hasFeatures(&.{ .neon, .has_v7 })) {
        return asm ("vld1.32 {%[ret]}, [%[addr]]"
            : [ret] "=w" (-> f32x4),
            : [addr] "r" (mem_addr),
        );
    } else if (use_builtins and comptime arm.hasFeatures(&.{ .neon, .has_v7 })) {
        return struct {
            extern fn @"llvm.arm.neon.vld1.v4f32.p0i8"([*]const f32, i32) f32x4;
        }.@"llvm.arm.neon.vld1.v4f32.p0i8"(mem_addr, @alignOf(f32));
    } else {
        return .{ mem_addr[0], mem_addr[1], mem_addr[2], mem_addr[3] };
    }
}

test vld1q_f32 {
    const addr = ([4]f32{ 0, 1, 2, std.math.floatMax(f32) })[0..].ptr;
    const expected: f32x4 = .{ 0, 1, 2, std.math.floatMax(f32) };

    try testIntrinsic("vld1q_f32", vld1q_f32, expected, .{addr});
}

/// Load multiple single-element structures to one, two, three, or four registers
pub inline fn vld1q_f64(mem_addr: [*]const f64) f64x2 {
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        switch (endianness) {
            inline .little => {
                return asm ("ld1 {%[ret].2d}, [%[addr]]"
                    : [ret] "=w" (-> f64x2),
                    : [addr] "r" (mem_addr),
                );
            },
            inline .big => {
                return asm (
                    \\ ld1   {%[ret].2d}, [%[addr]]
                    \\ rev64 %[ret].16b, %[ret].16b
                    : [ret] "=w" (-> f64x2),
                    : [addr] "r" (mem_addr),
                );
            },
        }
    } else if (use_asm and comptime arm.hasFeatures(&.{ .neon, .has_v7 })) {
        return asm ("vld1.64 {%[ret]}, [%[addr]]"
            : [ret] "=w" (-> f64x2),
            : [addr] "r" (mem_addr),
        );
    } else if (use_builtins and comptime arm.hasFeatures(&.{ .neon, .has_v7 })) {
        return struct {
            extern fn @"llvm.arm.neon.vld1.v2f64.p0i8"([*]const f64, i32) f64x2;
        }.@"llvm.arm.neon.vld1.v2f64.p0i8"(mem_addr, @alignOf(f64));
    } else {
        return .{ mem_addr[0], mem_addr[1] };
    }
}

test vld1q_f64 {
    const addr = ([2]f64{ 0, std.math.floatMax(f64) })[0..].ptr;
    const expected: f64x2 = .{ 0, std.math.floatMax(f64) };

    try testIntrinsic("vld1q_f64", vld1q_f64, expected, .{addr});
}

/// Multiply-add to accumulator
pub inline fn vmlaq_s8(a: i8x16, b: i8x16, c: i8x16) i8x16 {
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        var result = a;
        asm ("mla %[ret].16b, %[b].16b, %[c].16b"
            : [ret] "+w" (result),
            : [b] "w" (b),
              [c] "w" (c),
        );
        return result;
    } else if (use_asm and comptime arm.hasFeatures(&.{.neon})) {
        var result = a;
        asm ("vmla.i8 %[ret], %[b], %[c]"
            : [ret] "+w" (result),
            : [b] "w" (b),
              [c] "w" (c),
        );
        return result;
    } else {
        return a +% (b *% c);
    }
}

test vmlaq_s8 {
    {
        const a: i8x16 = .{ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 };
        const b: i8x16 = .{ 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2 };
        const c: i8x16 = .{ 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3 };
        const expected: i8x16 = .{ 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21 };

        try testIntrinsic("vmlaq_s8", vmlaq_s8, expected, .{ a, b, c });
    }
    {
        const a: i8x16 = .{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 127 };
        const b: i8x16 = .{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 };
        const c: i8x16 = .{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2 };
        const expected: i8x16 = .{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -127 };

        try testIntrinsic("vmlaq_s8", vmlaq_s8, expected, .{ a, b, c });
    }
}

/// Multiply-add to accumulator
pub inline fn vmlaq_s16(a: i16x8, b: i16x8, c: i16x8) i16x8 {
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        var result: i16x8 = a;
        switch (endianness) {
            .little => {
                asm ("mla %[ret].8h, %[b].8h, %[c].8h"
                    : [ret] "+w" (result),
                    : [b] "w" (b),
                      [c] "w" (c),
                );
            },
            .big => {
                asm (
                    \\ rev16 %[ret].16b, %[ret].16b
                    \\ rev16 %[b].16b, %[b].16b
                    \\ rev16 %[c].16b, %[c].16b
                    \\ mla   %[ret].8h, %[c].8h, %[b].8h
                    \\ rev16 %[ret].16b, %[ret].16b
                    : [ret] "+w" (result),
                    : [b] "w" (b),
                      [c] "w" (c),
                );
            },
        }
        return result;
    } else if (use_asm and comptime arm.hasFeatures(&.{.neon})) {
        var result = a;
        asm ("vmla.i16 %[ret], %[b], %[c]"
            : [ret] "+w" (result),
            : [b] "w" (b),
              [c] "w" (c),
        );
        return result;
    } else {
        return a +% (b *% c);
    }
}

test vmlaq_s16 {
    const a: i16x8 = .{ 0, 1, 2, 3, 4, 5, 6, 7 };
    const b: i16x8 = .{ 2, 2, 2, 2, 2, 2, 2, 2 };
    const c: i16x8 = .{ 3, 3, 3, 3, 3, 3, 3, 3 };
    const expected: i16x8 = .{ 6, 7, 8, 9, 10, 11, 12, 13 };

    try testIntrinsic("vmlaq_s16", vmlaq_s16, expected, .{ a, b, c });
}

/// Multiply-add to accumulator
pub inline fn vmlaq_s32(a: i32x4, b: i32x4, c: i32x4) i32x4 {
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        var result: i32x4 = a;
        switch (endianness) {
            .little => {
                asm ("mla %[ret].4s, %[b].4s, %[c].4s"
                    : [ret] "+w" (result),
                    : [b] "w" (b),
                      [c] "w" (c),
                );
            },
            .big => {
                asm (
                    \\ rev32 %[ret].16b, %[ret].16b
                    \\ rev32 %[b].16b, %[b].16b
                    \\ rev32 %[c].16b, %[c].16b
                    \\ mla   %[ret].4s, %[c].4s, %[b].4s
                    \\ rev32 %[ret].16b, %[ret].16b
                    : [ret] "+w" (result),
                    : [b] "w" (b),
                      [c] "w" (c),
                );
            },
        }
        return result;
    } else if (use_asm and comptime arm.hasFeatures(&.{.neon})) {
        var result = a;
        asm ("vmla.i32 %[ret], %[b], %[c]"
            : [ret] "+w" (result),
            : [b] "w" (b),
              [c] "w" (c),
        );
        return result;
    } else {
        return a +% (b *% c);
    }
}

test vmlaq_s32 {
    const a: i32x4 = .{ 0, 1, 2, 3 };
    const b: i32x4 = .{ 2, 2, 2, 2 };
    const c: i32x4 = .{ 3, 3, 3, 3 };
    const expected: i32x4 = .{ 6, 7, 8, 9 };

    try testIntrinsic("vmlaq_s32", vmlaq_s32, expected, .{ a, b, c });
}

/// Multiply-add to accumulator
pub inline fn vmlaq_u8(a: u8x16, b: u8x16, c: u8x16) u8x16 {
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        var result = a;
        asm ("mla %[ret].16b, %[b].16b, %[c].16b"
            : [ret] "+w" (result),
            : [b] "w" (b),
              [c] "w" (c),
        );
        return result;
    } else if (use_asm and comptime arm.hasFeatures(&.{.neon})) {
        var result = a;
        asm ("vmla.u8 %[ret], %[b], %[c]"
            : [ret] "+w" (result),
            : [b] "w" (b),
              [c] "w" (c),
        );
        return result;
    } else {
        return a +% (b *% c);
    }
}

test vmlaq_u8 {
    {
        const a: u8x16 = .{ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 };
        const b: u8x16 = .{ 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2 };
        const c: u8x16 = .{ 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3 };
        const expected: u8x16 = .{ 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21 };

        try testIntrinsic("vmlaq_u8", vmlaq_u8, expected, .{ a, b, c });
    }
    {
        const a: u8x16 = .{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 255 };
        const b: u8x16 = .{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 };
        const c: u8x16 = .{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2 };
        const expected: u8x16 = .{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 };

        try testIntrinsic("vmlaq_u8", vmlaq_u8, expected, .{ a, b, c });
    }
}

/// Multiply-add to accumulator
pub inline fn vmlaq_u16(a: u16x8, b: u16x8, c: u16x8) u16x8 {
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        var result: u16x8 = a;
        switch (endianness) {
            .little => {
                asm ("mla %[ret].8h, %[b].8h, %[c].8h"
                    : [ret] "+w" (result),
                    : [b] "w" (b),
                      [c] "w" (c),
                );
            },
            .big => {
                asm (
                    \\ rev16 %[ret].16b, %[ret].16b
                    \\ rev16 %[b].16b, %[b].16b
                    \\ rev16 %[c].16b, %[c].16b
                    \\ mla   %[ret].8h, %[c].8h, %[b].8h
                    \\ rev16 %[ret].16b, %[ret].16b
                    : [ret] "+w" (result),
                    : [b] "w" (b),
                      [c] "w" (c),
                );
            },
        }
        return result;
    } else if (use_asm and comptime arm.hasFeatures(&.{.neon})) {
        var result = a;
        asm ("vmla.u16 %[ret], %[b], %[c]"
            : [ret] "+w" (result),
            : [b] "w" (b),
              [c] "w" (c),
        );
        return result;
    } else {
        return a +% (b *% c);
    }
}

test vmlaq_u16 {
    const a: u16x8 = .{ 0, 1, 2, 3, 4, 5, 6, 7 };
    const b: u16x8 = .{ 2, 2, 2, 2, 2, 2, 2, 2 };
    const c: u16x8 = .{ 3, 3, 3, 3, 3, 3, 3, 3 };
    const expected: u16x8 = .{ 6, 7, 8, 9, 10, 11, 12, 13 };

    try testIntrinsic("vmlaq_u16", vmlaq_u16, expected, .{ a, b, c });
}

/// Multiply-add to accumulator
pub inline fn vmlaq_u32(a: u32x4, b: u32x4, c: u32x4) u32x4 {
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        var result: u32x4 = a;
        switch (endianness) {
            .little => {
                asm ("mla %[ret].4s, %[b].4s, %[c].4s"
                    : [ret] "+w" (result),
                    : [b] "w" (b),
                      [c] "w" (c),
                );
            },
            .big => {
                asm (
                    \\ rev32 %[ret].16b, %[ret].16b
                    \\ rev32 %[b].16b, %[b].16b
                    \\ rev32 %[c].16b, %[c].16b
                    \\ mla   %[ret].4s, %[c].4s, %[b].4s
                    \\ rev32 %[ret].16b, %[ret].16b
                    : [ret] "+w" (result),
                    : [b] "w" (b),
                      [c] "w" (c),
                );
            },
        }
        return result;
    } else if (use_asm and comptime arm.hasFeatures(&.{.neon})) {
        var result = a;
        asm ("vmla.u32 %[ret], %[b], %[c]"
            : [ret] "+w" (result),
            : [b] "w" (b),
              [c] "w" (c),
        );
        return result;
    } else {
        return a +% (b *% c);
    }
}

test vmlaq_u32 {
    const a: u32x4 = .{ 0, 1, 2, 3 };
    const b: u32x4 = .{ 2, 2, 2, 2 };
    const c: u32x4 = .{ 3, 3, 3, 3 };
    const expected: u32x4 = .{ 6, 7, 8, 9 };

    try testIntrinsic("vmlaq_u32", vmlaq_u32, expected, .{ a, b, c });
}

/// Multiply-add to accumulator
pub inline fn vmlaq_f32(a: f32x4, b: f32x4, c: f32x4) f32x4 {
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        var result: f32x4 = a;
        switch (endianness) {
            .little => {
                result = a;
                asm ("fmla %[ret].4s, %[b].4s, %[c].4s"
                    : [ret] "+w" (result),
                    : [b] "w" (b),
                      [c] "w" (c),
                );
            },
            .big => {
                asm (
                    \\ rev32 %[ret].16b, %[ret].16b
                    \\ rev32 %[b].16b, %[b].16b
                    \\ rev32 %[c].16b, %[c].16b
                    \\ fmla  %[ret].4s, %[b].4s, %[c].4s
                    \\ rev32 %[ret].16b, %[ret].16b
                    : [ret] "+w" (result),
                    : [b] "w" (b),
                      [c] "w" (c),
                );
            },
        }

        return result;
    } else if (use_asm and comptime arm.hasFeatures(&.{.neon})) {
        var result = a;
        asm ("vmla.f32 %[ret], %[b], %[c]"
            : [ret] "+w" (result),
            : [b] "w" (b),
              [c] "w" (c),
        );
        return result;
    } else {
        return a + (b * c);
    }
}

test vmlaq_f32 {
    const a: f32x4 = .{ 0, 1, 2, 3 };
    const b: f32x4 = .{ 2, 2, 2, 2 };
    const c: f32x4 = .{ 3, 3, 3, 3 };
    const expected: f32x4 = .{ 6, 7, 8, 9 };

    try testIntrinsic("vmlaq_f32", vmlaq_f32, expected, .{ a, b, c });
}

/// Multiply-add to accumulator
pub inline fn vmlaq_f64(a: f64x2, b: f64x2, c: f64x2) f64x2 {
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        var result: f64x2 = a;
        switch (endianness) {
            .little => {
                asm ("fmla %[ret].2d, %[b].2d, %[c].2d"
                    : [ret] "+w" (result),
                    : [b] "w" (b),
                      [c] "w" (c),
                );
            },
            .big => {
                asm (
                    \\ rev64 %[ret].16b, %[ret].16b
                    \\ rev64 %[b].16b, %[b].16b
                    \\ rev64 %[c].16b, %[c].16b
                    \\ fmla  %[ret].2d, %[b].2d, %[c].2d
                    \\ rev64 %[ret].16b, %[ret].16b
                    : [ret] "+w" (result),
                    : [b] "w" (b),
                      [c] "w" (c),
                );
            },
        }

        return result;
    } else {
        return a + (b * c);
    }
}

test vmlaq_f64 {
    const a: f64x2 = .{ 0, 1 };
    const b: f64x2 = .{ 2, 2 };
    const c: f64x2 = .{ 3, 3 };
    const expected: f64x2 = .{ 6, 7 };

    try testIntrinsic("vmlaq_f64", vmlaq_f64, expected, .{ a, b, c });
}

/// Duplicate vector element to vector or scalar
pub inline fn vdupq_n_u8(scalar: u8) u8x16 {
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        return asm ("dup %[ret].16b, %[scalar:w]"
            : [ret] "=w" (-> u8x16),
            : [scalar] "r" (scalar),
        );
    } else if (use_asm and comptime arm.hasFeatures(&.{.neon})) {
        return asm ("vdup.8 %[ret], %[scalar]"
            : [ret] "=w" (-> u8x16),
            : [scalar] "r" (scalar),
        );
    } else {
        return @splat(scalar);
    }
}

test vdupq_n_u8 {
    try testIntrinsic("vdupq_n_u8", vdupq_n_u8, u8x16{ 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5 }, .{5});
    try testIntrinsic("vdupq_n_u8", vdupq_n_u8, u8x16{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }, .{0});
    try testIntrinsic("vdupq_n_u8", vdupq_n_u8, u8x16{ std.math.maxInt(u8), std.math.maxInt(u8), std.math.maxInt(u8), std.math.maxInt(u8), std.math.maxInt(u8), std.math.maxInt(u8), std.math.maxInt(u8), std.math.maxInt(u8), std.math.maxInt(u8), std.math.maxInt(u8), std.math.maxInt(u8), std.math.maxInt(u8), std.math.maxInt(u8), std.math.maxInt(u8), std.math.maxInt(u8), std.math.maxInt(u8) }, .{std.math.maxInt(u8)});
}

/// Duplicate vector element to vector or scalar
pub inline fn vdupq_n_u16(scalar: u16) u16x8 {
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        switch (endianness) {
            .little => {
                return asm ("dup %[ret].8h, %[scalar:w]"
                    : [ret] "=w" (-> u16x8),
                    : [scalar] "r" (scalar),
                );
            },
            .big => {
                return asm (
                    \\ dup   %[ret].8h, %[scalar:w]
                    \\ rev16 %[ret].16b, %[ret].16b
                    : [ret] "=w" (-> u16x8),
                    : [scalar] "r" (scalar),
                );
            },
        }
    } else if (use_asm and comptime arm.hasFeatures(&.{.neon})) {
        return asm ("vdup.16 %[ret], %[scalar]"
            : [ret] "=w" (-> u16x8),
            : [scalar] "r" (scalar),
        );
    } else {
        return @splat(scalar);
    }
}

test vdupq_n_u16 {
    try testIntrinsic("vdupq_n_u16", vdupq_n_u16, u16x8{ 5, 5, 5, 5, 5, 5, 5, 5 }, .{5});
    try testIntrinsic("vdupq_n_u16", vdupq_n_u16, u16x8{ 0, 0, 0, 0, 0, 0, 0, 0 }, .{0});
    try testIntrinsic("vdupq_n_u16", vdupq_n_u16, u16x8{ std.math.maxInt(u16), std.math.maxInt(u16), std.math.maxInt(u16), std.math.maxInt(u16), std.math.maxInt(u16), std.math.maxInt(u16), std.math.maxInt(u16), std.math.maxInt(u16) }, .{std.math.maxInt(u16)});
}

/// Duplicate vector element to vector or scalar
pub inline fn vdupq_n_u32(scalar: u32) u32x4 {
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        switch (endianness) {
            .little => {
                return asm ("dup %[ret].4s, %[scalar:w]"
                    : [ret] "=w" (-> u32x4),
                    : [scalar] "r" (scalar),
                );
            },
            .big => {
                return asm (
                    \\ dup   %[ret].4s, %[scalar:w]
                    \\ rev32 %[ret].16b, %[ret].16b
                    : [ret] "=w" (-> u32x4),
                    : [scalar] "r" (scalar),
                );
            },
        }
    } else if (use_asm and comptime arm.hasFeatures(&.{.neon})) {
        return asm ("vdup.32 %[ret], %[scalar]"
            : [ret] "=w" (-> u32x4),
            : [scalar] "r" (scalar),
        );
    } else {
        return @splat(scalar);
    }
}

test vdupq_n_u32 {
    try testIntrinsic("vdupq_n_u32", vdupq_n_u32, u32x4{ 5, 5, 5, 5 }, .{5});
    try testIntrinsic("vdupq_n_u32", vdupq_n_u32, u32x4{ 0, 0, 0, 0 }, .{0});
    try testIntrinsic("vdupq_n_u32", vdupq_n_u32, u32x4{ std.math.maxInt(u32), std.math.maxInt(u32), std.math.maxInt(u32), std.math.maxInt(u32) }, .{std.math.maxInt(u32)});
}

/// Duplicate vector element to vector or scalar
pub inline fn vdupq_n_s8(scalar: i8) i8x16 {
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        return asm ("dup %[ret].16b, %[scalar:w]"
            : [ret] "=w" (-> i8x16),
            : [scalar] "r" (scalar),
        );
    } else if (use_asm and comptime arm.hasFeatures(&.{.neon})) {
        return asm ("vdup.8 %[ret], %[scalar]"
            : [ret] "=w" (-> i8x16),
            : [scalar] "r" (scalar),
        );
    } else {
        return @splat(scalar);
    }
}

test vdupq_n_s8 {
    try testIntrinsic("vdupq_n_s8", vdupq_n_s8, i8x16{ 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5 }, .{5});
    try testIntrinsic("vdupq_n_s8", vdupq_n_s8, i8x16{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }, .{0});
    try testIntrinsic("vdupq_n_s8", vdupq_n_s8, i8x16{ std.math.maxInt(i8), std.math.maxInt(i8), std.math.maxInt(i8), std.math.maxInt(i8), std.math.maxInt(i8), std.math.maxInt(i8), std.math.maxInt(i8), std.math.maxInt(i8), std.math.maxInt(i8), std.math.maxInt(i8), std.math.maxInt(i8), std.math.maxInt(i8), std.math.maxInt(i8), std.math.maxInt(i8), std.math.maxInt(i8), std.math.maxInt(i8) }, .{std.math.maxInt(i8)});
}

/// Duplicate vector element to vector or scalar
pub inline fn vdupq_n_s16(scalar: i16) i16x8 {
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        switch (endianness) {
            .little => {
                return asm ("dup %[ret].8h, %[scalar:w]"
                    : [ret] "=w" (-> i16x8),
                    : [scalar] "r" (scalar),
                );
            },
            .big => {
                return asm (
                    \\ dup   %[ret].8h, %[scalar:w]
                    \\ rev16 %[ret].16b, %[ret].16b
                    : [ret] "=w" (-> i16x8),
                    : [scalar] "r" (scalar),
                );
            },
        }
    } else if (use_asm and comptime arm.hasFeatures(&.{.neon})) {
        return asm ("vdup.16 %[ret], %[scalar]"
            : [ret] "=w" (-> i16x8),
            : [scalar] "r" (scalar),
        );
    } else {
        return @splat(scalar);
    }
}

test vdupq_n_s16 {
    try testIntrinsic("vdupq_n_s16", vdupq_n_s16, i16x8{ 5, 5, 5, 5, 5, 5, 5, 5 }, .{5});
    try testIntrinsic("vdupq_n_s16", vdupq_n_s16, i16x8{ 0, 0, 0, 0, 0, 0, 0, 0 }, .{0});
    try testIntrinsic("vdupq_n_s16", vdupq_n_s16, i16x8{ std.math.maxInt(i16), std.math.maxInt(i16), std.math.maxInt(i16), std.math.maxInt(i16), std.math.maxInt(i16), std.math.maxInt(i16), std.math.maxInt(i16), std.math.maxInt(i16) }, .{std.math.maxInt(i16)});
}

/// Duplicate vector element to vector or scalar
pub inline fn vdupq_n_s32(scalar: i32) i32x4 {
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        switch (endianness) {
            .little => {
                return asm ("dup %[ret].4s, %[scalar:w]"
                    : [ret] "=w" (-> i32x4),
                    : [scalar] "r" (scalar),
                );
            },
            .big => {
                return asm (
                    \\ dup   %[ret].4s, %[scalar:w]
                    \\ rev32 %[ret].16b, %[ret].16b
                    : [ret] "=w" (-> i32x4),
                    : [scalar] "r" (scalar),
                );
            },
        }
    } else if (use_asm and comptime arm.hasFeatures(&.{.neon})) {
        return asm ("vdup.32 %[ret], %[scalar]"
            : [ret] "=w" (-> i32x4),
            : [scalar] "r" (scalar),
        );
    } else {
        return @splat(scalar);
    }
}

test vdupq_n_s32 {
    try testIntrinsic("vdupq_n_s32", vdupq_n_s32, i32x4{ 5, 5, 5, 5 }, .{5});
    try testIntrinsic("vdupq_n_s32", vdupq_n_s32, i32x4{ 0, 0, 0, 0 }, .{0});
    try testIntrinsic("vdupq_n_s32", vdupq_n_s32, i32x4{ std.math.maxInt(i32), std.math.maxInt(i32), std.math.maxInt(i32), std.math.maxInt(i32) }, .{std.math.maxInt(i32)});
}

/// Duplicate vector element to vector or scalar
pub inline fn vdupq_n_p8(scalar: p8) p8x16 {
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        return asm ("dup %[ret].16b, %[scalar:w]"
            : [ret] "=w" (-> p8x16),
            : [scalar] "r" (scalar),
        );
    } else if (use_asm and comptime arm.hasFeatures(&.{.neon})) {
        return asm ("vdup.8 %[ret], %[scalar]"
            : [ret] "=w" (-> p8x16),
            : [scalar] "r" (scalar),
        );
    } else {
        return @splat(scalar);
    }
}

test vdupq_n_p8 {
    try testIntrinsic("vdupq_n_p8", vdupq_n_p8, p8x16{ 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5 }, .{5});
    try testIntrinsic("vdupq_n_p8", vdupq_n_p8, p8x16{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }, .{0});
    try testIntrinsic("vdupq_n_p8", vdupq_n_p8, p8x16{ std.math.maxInt(p8), std.math.maxInt(p8), std.math.maxInt(p8), std.math.maxInt(p8), std.math.maxInt(p8), std.math.maxInt(p8), std.math.maxInt(p8), std.math.maxInt(p8), std.math.maxInt(p8), std.math.maxInt(p8), std.math.maxInt(p8), std.math.maxInt(p8), std.math.maxInt(p8), std.math.maxInt(p8), std.math.maxInt(p8), std.math.maxInt(p8) }, .{std.math.maxInt(p8)});
}

/// Duplicate vector element to vector or scalar
pub inline fn vdupq_n_p16(scalar: p16) p16x8 {
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        switch (endianness) {
            .little => {
                return asm ("dup %[ret].8h, %[scalar:w]"
                    : [ret] "=w" (-> p16x8),
                    : [scalar] "r" (scalar),
                );
            },
            .big => {
                return asm (
                    \\ dup   %[ret].8h, %[scalar:w]
                    \\ rev16 %[ret].16b, %[ret].16b
                    : [ret] "=w" (-> p16x8),
                    : [scalar] "r" (scalar),
                );
            },
        }
    } else if (use_asm and comptime arm.hasFeatures(&.{.neon})) {
        return asm ("vdup.16 %[ret], %[scalar]"
            : [ret] "=w" (-> p16x8),
            : [scalar] "r" (scalar),
        );
    } else {
        return @splat(scalar);
    }
}

test vdupq_n_p16 {
    try testIntrinsic("vdupq_n_p16", vdupq_n_p16, p16x8{ 5, 5, 5, 5, 5, 5, 5, 5 }, .{5});
    try testIntrinsic("vdupq_n_p16", vdupq_n_p16, p16x8{ 0, 0, 0, 0, 0, 0, 0, 0 }, .{0});
    try testIntrinsic("vdupq_n_p16", vdupq_n_p16, p16x8{ std.math.maxInt(p16), std.math.maxInt(p16), std.math.maxInt(p16), std.math.maxInt(p16), std.math.maxInt(p16), std.math.maxInt(p16), std.math.maxInt(p16), std.math.maxInt(p16) }, .{std.math.maxInt(p16)});
}

/// Duplicate vector element to vector or scalar
pub inline fn vdupq_n_f16(scalar: f16) f16x8 {
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        switch (endianness) {
            .little => {
                return asm ("dup %[ret].8h, %[scalar:w]"
                    : [ret] "=w" (-> f16x8),
                    : [scalar] "r" (scalar),
                );
            },
            .big => {
                return asm (
                    \\ dup   %[ret].8h, %[scalar:w]
                    \\ rev16 %[ret].16b, %[ret].16b
                    : [ret] "=w" (-> f16x8),
                    : [scalar] "r" (scalar),
                );
            },
        }
    } else if (use_asm and comptime arm.hasFeatures(&.{.neon})) {
        return @bitCast(asm ("vdup.16 %[ret], %[scalar]"
            : [ret] "=w" (-> u16x8),
            : [scalar] "r" (scalar),
        ));
    } else {
        return @splat(scalar);
    }
}

test vdupq_n_f16 {
    try testIntrinsic("vdupq_n_f16", vdupq_n_f16, f16x8{ 5, 5, 5, 5, 5, 5, 5, 5 }, .{5});
    try testIntrinsic("vdupq_n_f16", vdupq_n_f16, f16x8{ 0, 0, 0, 0, 0, 0, 0, 0 }, .{0});
    try testIntrinsic("vdupq_n_f16", vdupq_n_f16, f16x8{ std.math.floatMax(f16), std.math.floatMax(f16), std.math.floatMax(f16), std.math.floatMax(f16), std.math.floatMax(f16), std.math.floatMax(f16), std.math.floatMax(f16), std.math.floatMax(f16) }, .{std.math.floatMax(f16)});
}

/// Duplicate vector element to vector or scalar
pub inline fn vdupq_n_f32(scalar: f32) f32x4 {
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        switch (endianness) {
            .little => {
                return asm ("dup %[ret].4s, %[scalar:w]"
                    : [ret] "=w" (-> f32x4),
                    : [scalar] "r" (scalar),
                );
            },
            .big => {
                return asm (
                    \\ dup   %[ret].4s, %[scalar:w]
                    \\ rev32 %[ret].16b, %[ret].16b
                    : [ret] "=w" (-> f32x4),
                    : [scalar] "r" (scalar),
                );
            },
        }
    } else if (use_asm and comptime arm.hasFeatures(&.{.neon})) {
        return asm ("vdup.32 %[ret], %[scalar]"
            : [ret] "=w" (-> f32x4),
            : [scalar] "r" (scalar),
        );
    } else {
        return @splat(scalar);
    }
}

test vdupq_n_f32 {
    try testIntrinsic("vdupq_n_f32", vdupq_n_f32, f32x4{ 5, 5, 5, 5 }, .{5});
    try testIntrinsic("vdupq_n_f32", vdupq_n_f32, f32x4{ 0, 0, 0, 0 }, .{0});
    try testIntrinsic("vdupq_n_f32", vdupq_n_f32, f32x4{ std.math.floatMax(f32), std.math.floatMax(f32), std.math.floatMax(f32), std.math.floatMax(f32) }, .{std.math.floatMax(f32)});
}

/// Duplicate vector element to vector or scalar
pub inline fn vdupq_n_f64(scalar: f64) f64x2 {
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        switch (endianness) {
            .little => {
                return asm ("dup %[ret].2d, %[scalar]"
                    : [ret] "=w" (-> f64x2),
                    : [scalar] "r" (scalar),
                );
            },
            .big => {
                return asm (
                    \\ dup   %[ret].2d, %[scalar]
                    \\ rev64 %[ret].16b, %[ret].16b
                    : [ret] "=w" (-> f64x2),
                    : [scalar] "r" (scalar),
                );
            },
        }
    } else {
        return @splat(scalar);
    }
}

test vdupq_n_f64 {
    try testIntrinsic("vdupq_n_f64", vdupq_n_f64, f64x2{ 5, 5 }, .{5});
    try testIntrinsic("vdupq_n_f64", vdupq_n_f64, f64x2{ 0, 0 }, .{0});
    try testIntrinsic("vdupq_n_f64", vdupq_n_f64, f64x2{ std.math.floatMax(f64), std.math.floatMax(f64) }, .{std.math.floatMax(f64)});
}

/// Zip vectors
pub inline fn vzip1_s8(a: i8x8, b: i8x8) i8x8 {
    return @shuffle(i8, a, b, i8x8{ 0, ~@as(i8, 0), 1, ~@as(i8, 1), 2, ~@as(i8, 2), 3, ~@as(i8, 3) });
}

test vzip1_s8 {
    const a: i8x8 = .{ 0, 2, 4, 6, 8, 10, 12, 14 };
    const b: i8x8 = .{ 1, 3, 5, 7, 9, 11, 13, 15 };
    const expected: i8x8 = .{ 0, 1, 2, 3, 4, 5, 6, 7 };

    try testIntrinsic("vzip1_s8", vzip1_s8, expected, .{ a, b });
}

/// Zip vectors
pub inline fn vzip1_s16(a: i16x4, b: i16x4) i16x4 {
    return @shuffle(i16, a, b, i16x4{ 0, ~@as(i16, 0), 1, ~@as(i16, 1) });
}

test vzip1_s16 {
    const a: i16x4 = .{ 0, 2, 4, 6 };
    const b: i16x4 = .{ 1, 3, 5, 7 };
    const expected: i16x4 = .{ 0, 1, 2, 3 };

    try testIntrinsic("vzip1_s16", vzip1_s16, expected, .{ a, b });
}

/// Zip vectors
pub inline fn vzip1_s32(a: i32x2, b: i32x2) i32x2 {
    return @shuffle(i32, a, b, i32x2{ 0, ~@as(i32, 0) });
}

test vzip1_s32 {
    const a: i32x2 = .{ 0, 2 };
    const b: i32x2 = .{ 1, 3 };
    const expected: i32x2 = .{ 0, 1 };

    try testIntrinsic("vzip1_s32", vzip1_s32, expected, .{ a, b });
}

/// Zip vectors
pub inline fn vzip1_u8(a: u8x8, b: u8x8) u8x8 {
    return @shuffle(u8, a, b, i8x8{ 0, ~@as(i8, 0), 1, ~@as(i8, 1), 2, ~@as(i8, 2), 3, ~@as(i8, 3) });
}

test vzip1_u8 {
    const a: u8x8 = .{ 0, 2, 4, 6, 8, 10, 12, 14 };
    const b: u8x8 = .{ 1, 3, 5, 7, 9, 11, 13, 15 };
    const expected: u8x8 = .{ 0, 1, 2, 3, 4, 5, 6, 7 };

    try testIntrinsic("vzip1_u8", vzip1_u8, expected, .{ a, b });
}

/// Zip vectors
pub inline fn vzip1_u16(a: u16x4, b: u16x4) u16x4 {
    return @shuffle(u16, a, b, i16x4{ 0, ~@as(i16, 0), 1, ~@as(i16, 1) });
}

test vzip1_u16 {
    const a: u16x4 = .{ 0, 2, 4, 6 };
    const b: u16x4 = .{ 1, 3, 5, 7 };
    const expected: u16x4 = .{ 0, 1, 2, 3 };

    try testIntrinsic("vzip1_u16", vzip1_u16, expected, .{ a, b });
}

/// Zip vectors
pub inline fn vzip1_u32(a: u32x2, b: u32x2) u32x2 {
    return @shuffle(u32, a, b, i32x2{ 0, ~@as(i32, 0) });
}

test vzip1_u32 {
    const a: u32x2 = .{ 0, 2 };
    const b: u32x2 = .{ 1, 3 };
    const expected: u32x2 = .{ 0, 1 };

    try testIntrinsic("vzip1_u32", vzip1_u32, expected, .{ a, b });
}

/// Zip vectors
pub inline fn vzip1_f32(a: f32x2, b: f32x2) f32x2 {
    return @shuffle(f32, a, b, i32x2{ 0, ~@as(i32, 0) });
}

test vzip1_f32 {
    const a: f32x2 = .{ 0, 2 };
    const b: f32x2 = .{ 1, 3 };
    const expected: f32x2 = .{ 0, 1 };

    try testIntrinsic("vzip1_f32", vzip1_f32, expected, .{ a, b });
}

/// Zip vectors
pub inline fn vzip2_s8(a: i8x8, b: i8x8) i8x8 {
    return @shuffle(i8, a, b, i8x8{ 4, ~@as(i8, 4), 5, ~@as(i8, 5), 6, ~@as(i8, 6), 7, ~@as(i8, 7) });
}

test vzip2_s8 {
    const a: i8x8 = .{ 0, 16, 16, 18, 16, 18, 20, 22 };
    const b: i8x8 = .{ 1, 17, 17, 19, 17, 19, 21, 23 };
    const expected: i8x8 = .{ 16, 17, 18, 19, 20, 21, 22, 23 };

    try testIntrinsic("vzip2_s8", vzip2_s8, expected, .{ a, b });
}

/// Zip vectors
pub inline fn vzip2_s16(a: i16x4, b: i16x4) i16x4 {
    return @shuffle(i16, a, b, i16x4{ 2, ~@as(i16, 2), 3, ~@as(i16, 3) });
}

test vzip2_s16 {
    const a: i16x4 = .{ 0, 16, 16, 18 };
    const b: i16x4 = .{ 1, 17, 17, 19 };
    const expected: i16x4 = .{ 16, 17, 18, 19 };

    try testIntrinsic("vzip2_s16", vzip2_s16, expected, .{ a, b });
}

/// Zip vectors
pub inline fn vzip2_s32(a: i32x2, b: i32x2) i32x2 {
    return @shuffle(i32, a, b, i32x2{ 1, ~@as(i32, 1) });
}

test vzip2_s32 {
    const a: i32x2 = .{ 0, 16 };
    const b: i32x2 = .{ 1, 17 };
    const expected: i32x2 = .{ 16, 17 };

    try testIntrinsic("vzip2_s32", vzip2_s32, expected, .{ a, b });
}

/// Zip vectors
pub inline fn vzip2_u8(a: u8x8, b: u8x8) u8x8 {
    return @shuffle(u8, a, b, i8x8{ 4, ~@as(i8, 4), 5, ~@as(i8, 5), 6, ~@as(i8, 6), 7, ~@as(i8, 7) });
}

test vzip2_u8 {
    const a: u8x8 = .{ 0, 16, 16, 18, 16, 18, 20, 22 };
    const b: u8x8 = .{ 1, 17, 17, 19, 17, 19, 21, 23 };
    const expected: u8x8 = .{ 16, 17, 18, 19, 20, 21, 22, 23 };

    try testIntrinsic("vzip2_u8", vzip2_u8, expected, .{ a, b });
}

/// Zip vectors
pub inline fn vzip2_u16(a: u16x4, b: u16x4) u16x4 {
    return @shuffle(u16, a, b, i16x4{ 2, ~@as(i16, 2), 3, ~@as(i16, 3) });
}

test vzip2_u16 {
    const a: u16x4 = .{ 0, 16, 16, 18 };
    const b: u16x4 = .{ 1, 17, 17, 19 };
    const expected: u16x4 = .{ 16, 17, 18, 19 };

    try testIntrinsic("vzip2_u16", vzip2_u16, expected, .{ a, b });
}

/// Zip vectors
pub inline fn vzip2_u32(a: u32x2, b: u32x2) u32x2 {
    return @shuffle(u32, a, b, i32x2{ 1, ~@as(i32, 1) });
}

test vzip2_u32 {
    const a: u32x2 = .{ 0, 16 };
    const b: u32x2 = .{ 1, 17 };
    const expected: u32x2 = .{ 16, 17 };

    try testIntrinsic("vzip2_u32", vzip2_u32, expected, .{ a, b });
}

/// Zip vectors
pub inline fn vzip2_f32(a: f32x2, b: f32x2) f32x2 {
    return @shuffle(f32, a, b, i32x2{ 1, ~@as(i32, 1) });
}

test vzip2_f32 {
    const a: f32x2 = .{ 0, 16 };
    const b: f32x2 = .{ 1, 17 };
    const expected: f32x2 = .{ 16, 17 };

    try testIntrinsic("vzip2_f32", vzip2_f32, expected, .{ a, b });
}

/// Transpose vectors
pub inline fn vtrn1q_s8(a: i8x16, b: i8x16) i8x16 {
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        return asm ("trn1 %[ret].16b, %[a].16b, %[b].16b"
            : [ret] "=w" (-> i8x16),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else {
        return @shuffle(i8, a, b, i8x16{ 0, ~@as(i8, 0), 2, ~@as(i8, 2), 4, ~@as(i8, 4), 6, ~@as(i8, 6), 8, ~@as(i8, 8), 10, ~@as(i8, 10), 12, ~@as(i8, 12), 14, ~@as(i8, 14) });
    }
}

test vtrn1q_s8 {
    const a: i8x16 = .{ 0, 2, 2, 6, 2, 10, 6, 14, 2, 18, 6, 22, 10, 26, 14, 30 };
    const b: i8x16 = .{ 1, 3, 3, 7, 3, 1, 7, 15, 3, 19, 7, 23, 1, 27, 15, 31 };
    const expected: i8x16 = .{ 0, 1, 2, 3, 2, 3, 6, 7, 2, 3, 6, 7, 10, 1, 14, 15 };

    try testIntrinsic("vtrn1q_s8", vtrn1q_s8, expected, .{ a, b });
}

/// Transpose vectors
pub inline fn vtrn1q_s16(a: i16x8, b: i16x8) i16x8 {
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        return asm ("trn1 %[ret].8h, %[a].8h, %[b].8h"
            : [ret] "=w" (-> i16x8),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else {
        return @shuffle(i16, a, b, i16x8{ 0, ~@as(i16, 0), 2, ~@as(i16, 2), 4, ~@as(i16, 4), 6, ~@as(i16, 6) });
    }
}

test vtrn1q_s16 {
    const a: i16x8 = .{ 0, 2, 2, 6, 2, 10, 6, 14 };
    const b: i16x8 = .{ 1, 3, 3, 7, 3, 1, 7, 15 };
    const expected: i16x8 = .{ 0, 1, 2, 3, 2, 3, 6, 7 };

    try testIntrinsic("vtrn1q_s16", vtrn1q_s16, expected, .{ a, b });
}

/// Transpose vectors
pub inline fn vtrn1q_s32(a: i32x4, b: i32x4) i32x4 {
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        return asm ("trn1 %[ret].4s, %[a].4s, %[b].4s"
            : [ret] "=w" (-> i32x4),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else {
        return @shuffle(i32, a, b, i32x4{ 0, ~@as(i32, 0), 2, ~@as(i32, 2) });
    }
}

test vtrn1q_s32 {
    const a: i32x4 = .{ 0, 2, 2, 6 };
    const b: i32x4 = .{ 1, 3, 3, 7 };
    const expected: i32x4 = .{ 0, 1, 2, 3 };

    try testIntrinsic("vtrn1q_s32", vtrn1q_s32, expected, .{ a, b });
}

/// Transpose vectors
pub inline fn vtrn1q_s64(a: i64x2, b: i64x2) i64x2 {
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        return asm ("trn1 %[ret].2d, %[a].2d, %[b].2d"
            : [ret] "=w" (-> i64x2),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else {
        return @shuffle(i64, a, b, i64x2{ 0, ~@as(i64, 0) });
    }
}

test vtrn1q_s64 {
    const a: i64x2 = .{ 0, 2 };
    const b: i64x2 = .{ 1, 3 };
    const expected: i64x2 = .{ 0, 1 };

    try testIntrinsic("vtrn1q_s64", vtrn1q_s64, expected, .{ a, b });
}

/// Transpose vectors
pub inline fn vtrn1q_u8(a: u8x16, b: u8x16) u8x16 {
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        return asm ("trn1 %[ret].16b, %[a].16b, %[b].16b"
            : [ret] "=w" (-> u8x16),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else {
        return @shuffle(u8, a, b, i8x16{ 0, ~@as(i8, 0), 2, ~@as(i8, 2), 4, ~@as(i8, 4), 6, ~@as(i8, 6), 8, ~@as(i8, 8), 10, ~@as(i8, 10), 12, ~@as(i8, 12), 14, ~@as(i8, 14) });
    }
}

test vtrn1q_u8 {
    const a: u8x16 = .{ 0, 2, 2, 6, 2, 10, 6, 14, 2, 18, 6, 22, 10, 26, 14, 30 };
    const b: u8x16 = .{ 1, 3, 3, 7, 3, 1, 7, 15, 3, 19, 7, 23, 1, 27, 15, 31 };
    const expected: u8x16 = .{ 0, 1, 2, 3, 2, 3, 6, 7, 2, 3, 6, 7, 10, 1, 14, 15 };

    try testIntrinsic("vtrn1q_u8", vtrn1q_u8, expected, .{ a, b });
}

/// Transpose vectors
pub inline fn vtrn1q_u16(a: u16x8, b: u16x8) u16x8 {
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        return asm ("trn1 %[ret].8h, %[a].8h, %[b].8h"
            : [ret] "=w" (-> u16x8),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else {
        return @shuffle(u16, a, b, i16x8{ 0, ~@as(i16, 0), 2, ~@as(i16, 2), 4, ~@as(i16, 4), 6, ~@as(i16, 6) });
    }
}

test vtrn1q_u16 {
    const a: u16x8 = .{ 0, 2, 2, 6, 2, 10, 6, 14 };
    const b: u16x8 = .{ 1, 3, 3, 7, 3, 1, 7, 15 };
    const expected: u16x8 = .{ 0, 1, 2, 3, 2, 3, 6, 7 };

    try testIntrinsic("vtrn1q_u16", vtrn1q_u16, expected, .{ a, b });
}

/// Transpose vectors
pub inline fn vtrn1q_u32(a: u32x4, b: u32x4) u32x4 {
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        return asm ("trn1 %[ret].4s, %[a].4s, %[b].4s"
            : [ret] "=w" (-> u32x4),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else {
        return @shuffle(u32, a, b, i32x4{ 0, ~@as(i32, 0), 2, ~@as(i32, 2) });
    }
}

test vtrn1q_u32 {
    const a: u32x4 = .{ 0, 2, 2, 6 };
    const b: u32x4 = .{ 1, 3, 3, 7 };
    const expected: u32x4 = .{ 0, 1, 2, 3 };

    try testIntrinsic("vtrn1q_u32", vtrn1q_u32, expected, .{ a, b });
}

/// Transpose vectors
pub inline fn vtrn1q_u64(a: u64x2, b: u64x2) u64x2 {
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        return asm ("trn1 %[ret].2d, %[a].2d, %[b].2d"
            : [ret] "=w" (-> u64x2),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else {
        return @shuffle(u64, a, b, i64x2{ 0, ~@as(i64, 0) });
    }
}

test vtrn1q_u64 {
    const a: u64x2 = .{ 0, 2 };
    const b: u64x2 = .{ 1, 3 };
    const expected: u64x2 = .{ 0, 1 };

    try testIntrinsic("vtrn1q_u64", vtrn1q_u64, expected, .{ a, b });
}

/// Transpose vectors
pub inline fn vtrn1q_f32(a: f32x4, b: f32x4) f32x4 {
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        return asm ("trn1 %[ret].4s, %[a].4s, %[b].4s"
            : [ret] "=w" (-> f32x4),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else {
        return @shuffle(f32, a, b, i32x4{ 0, ~@as(i32, 0), 2, ~@as(i32, 2) });
    }
}

test vtrn1q_f32 {
    const a: f32x4 = .{ 0, 2, 2, 6 };
    const b: f32x4 = .{ 1, 3, 3, 7 };
    const expected: f32x4 = .{ 0, 1, 2, 3 };

    try testIntrinsic("vtrn1q_f32", vtrn1q_f32, expected, .{ a, b });
}

/// Transpose vectors
pub inline fn vtrn1q_f64(a: f64x2, b: f64x2) f64x2 {
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        return asm ("trn1 %[ret].2d, %[a].2d, %[b].2d"
            : [ret] "=w" (-> f64x2),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else {
        return @shuffle(f64, a, b, i64x2{ 0, ~@as(i64, 0) });
    }
}

test vtrn1q_f64 {
    const a: f64x2 = .{ 0, 2 };
    const b: f64x2 = .{ 1, 3 };
    const expected: f64x2 = .{ 0, 1 };

    try testIntrinsic("vtrn1q_f64", vtrn1q_f64, expected, .{ a, b });
}

/// Transpose vectors
pub inline fn vtrn2q_s8(a: i8x16, b: i8x16) i8x16 {
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        return asm ("trn2 %[ret].16b, %[a].16b, %[b].16b"
            : [ret] "=w" (-> i8x16),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else {
        return @shuffle(i8, a, b, i8x16{ 1, ~@as(i8, 1), 3, ~@as(i8, 3), 5, ~@as(i8, 5), 7, ~@as(i8, 7), 9, ~@as(i8, 9), 11, ~@as(i8, 11), 13, ~@as(i8, 13), 15, ~@as(i8, 15) });
    }
}

test vtrn2q_s8 {
    const a: i8x16 = .{ 0, 2, 2, 6, 2, 10, 6, 14, 2, 18, 6, 22, 10, 26, 14, 30 };
    const b: i8x16 = .{ 1, 3, 3, 7, 3, 1, 7, 15, 3, 19, 7, 23, 1, 27, 15, 31 };
    const expected: i8x16 = .{ 2, 3, 6, 7, 10, 1, 14, 15, 18, 19, 22, 23, 26, 27, 30, 31 };

    try testIntrinsic("vtrn2q_s8", vtrn2q_s8, expected, .{ a, b });
}

/// Transpose vectors
pub inline fn vtrn2q_s16(a: i16x8, b: i16x8) i16x8 {
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        return asm ("trn2 %[ret].8h, %[a].8h, %[b].8h"
            : [ret] "=w" (-> i16x8),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else {
        return @shuffle(i16, a, b, i16x8{ 1, ~@as(i16, 1), 3, ~@as(i16, 3), 5, ~@as(i16, 5), 7, ~@as(i16, 7) });
    }
}

test vtrn2q_s16 {
    const a: i16x8 = .{ 0, 2, 2, 6, 2, 10, 6, 14 };
    const b: i16x8 = .{ 1, 3, 3, 7, 3, 1, 7, 15 };
    const expected: i16x8 = .{ 2, 3, 6, 7, 10, 1, 14, 15 };

    try testIntrinsic("vtrn2q_s16", vtrn2q_s16, expected, .{ a, b });
}

/// Transpose vectors
pub inline fn vtrn2q_s32(a: i32x4, b: i32x4) i32x4 {
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        return asm ("trn2 %[ret].4s, %[a].4s, %[b].4s"
            : [ret] "=w" (-> i32x4),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else {
        return @shuffle(i32, a, b, i32x4{ 1, ~@as(i32, 1), 3, ~@as(i32, 3) });
    }
}

test vtrn2q_s32 {
    const a: i32x4 = .{ 0, 2, 2, 6 };
    const b: i32x4 = .{ 1, 3, 3, 7 };
    const expected: i32x4 = .{ 2, 3, 6, 7 };

    try testIntrinsic("vtrn2q_s32", vtrn2q_s32, expected, .{ a, b });
}

/// Transpose vectors
pub inline fn vtrn2q_s64(a: i64x2, b: i64x2) i64x2 {
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        return asm ("trn2 %[ret].2d, %[a].2d, %[b].2d"
            : [ret] "=w" (-> i64x2),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else {
        return @shuffle(i64, a, b, i64x2{ 1, ~@as(i64, 1) });
    }
}

test vtrn2q_s64 {
    const a: i64x2 = .{ 0, 2 };
    const b: i64x2 = .{ 1, 3 };
    const expected: i64x2 = .{ 2, 3 };

    try testIntrinsic("vtrn2q_s64", vtrn2q_s64, expected, .{ a, b });
}

/// Transpose vectors
pub inline fn vtrn2q_u8(a: u8x16, b: u8x16) u8x16 {
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        return asm ("trn2 %[ret].16b, %[a].16b, %[b].16b"
            : [ret] "=w" (-> u8x16),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else {
        return @shuffle(u8, a, b, i8x16{ 1, ~@as(i8, 1), 3, ~@as(i8, 3), 5, ~@as(i8, 5), 7, ~@as(i8, 7), 9, ~@as(i8, 9), 11, ~@as(i8, 11), 13, ~@as(i8, 13), 15, ~@as(i8, 15) });
    }
}

test vtrn2q_u8 {
    const a: u8x16 = .{ 0, 2, 2, 6, 2, 10, 6, 14, 2, 18, 6, 22, 10, 26, 14, 30 };
    const b: u8x16 = .{ 1, 3, 3, 7, 3, 1, 7, 15, 3, 19, 7, 23, 1, 27, 15, 31 };
    const expected: u8x16 = .{ 2, 3, 6, 7, 10, 1, 14, 15, 18, 19, 22, 23, 26, 27, 30, 31 };

    try testIntrinsic("vtrn2q_u8", vtrn2q_u8, expected, .{ a, b });
}

/// Transpose vectors
pub inline fn vtrn2q_u16(a: u16x8, b: u16x8) u16x8 {
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        return asm ("trn2 %[ret].8h, %[a].8h, %[b].8h"
            : [ret] "=w" (-> u16x8),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else {
        return @shuffle(u16, a, b, i16x8{ 1, ~@as(i16, 1), 3, ~@as(i16, 3), 5, ~@as(i16, 5), 7, ~@as(i16, 7) });
    }
}

test vtrn2q_u16 {
    const a: u16x8 = .{ 0, 2, 2, 6, 2, 10, 6, 14 };
    const b: u16x8 = .{ 1, 3, 3, 7, 3, 1, 7, 15 };
    const expected: u16x8 = .{ 2, 3, 6, 7, 10, 1, 14, 15 };

    try testIntrinsic("vtrn2q_u16", vtrn2q_u16, expected, .{ a, b });
}

/// Transpose vectors
pub inline fn vtrn2q_u32(a: u32x4, b: u32x4) u32x4 {
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        return asm ("trn2 %[ret].4s, %[a].4s, %[b].4s"
            : [ret] "=w" (-> u32x4),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else {
        return @shuffle(u32, a, b, i32x4{ 1, ~@as(i32, 1), 3, ~@as(i32, 3) });
    }
}

test vtrn2q_u32 {
    const a: u32x4 = .{ 0, 2, 2, 6 };
    const b: u32x4 = .{ 1, 3, 3, 7 };
    const expected: u32x4 = .{ 2, 3, 6, 7 };

    try testIntrinsic("vtrn2q_u32", vtrn2q_u32, expected, .{ a, b });
}

/// Transpose vectors
pub inline fn vtrn2q_u64(a: u64x2, b: u64x2) u64x2 {
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        return asm ("trn2 %[ret].2d, %[a].2d, %[b].2d"
            : [ret] "=w" (-> u64x2),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else {
        return @shuffle(u64, a, b, i64x2{ 1, ~@as(i64, 1) });
    }
}

test vtrn2q_u64 {
    const a: u64x2 = .{ 0, 2 };
    const b: u64x2 = .{ 1, 3 };
    const expected: u64x2 = .{ 2, 3 };

    try testIntrinsic("vtrn2q_u64", vtrn2q_u64, expected, .{ a, b });
}

/// Transpose vectors
pub inline fn vtrn2q_f32(a: f32x4, b: f32x4) f32x4 {
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        return asm ("trn2 %[ret].4s, %[a].4s, %[b].4s"
            : [ret] "=w" (-> f32x4),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else {
        return @shuffle(f32, a, b, i32x4{ 1, ~@as(i32, 1), 3, ~@as(i32, 3) });
    }
}

test vtrn2q_f32 {
    const a: f32x4 = .{ 0, 2, 2, 6 };
    const b: f32x4 = .{ 1, 3, 3, 7 };
    const expected: f32x4 = .{ 2, 3, 6, 7 };

    try testIntrinsic("vtrn2q_f32", vtrn2q_f32, expected, .{ a, b });
}

/// Transpose vectors
pub inline fn vtrn2q_f64(a: f64x2, b: f64x2) f64x2 {
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        return asm ("trn2 %[ret].2d, %[a].2d, %[b].2d"
            : [ret] "=w" (-> f64x2),
            : [a] "w" (a),
              [b] "w" (b),
        );
    } else {
        return @shuffle(f64, a, b, i64x2{ 1, ~@as(i64, 1) });
    }
}

test vtrn2q_f64 {
    const a: f64x2 = .{ 0, 2 };
    const b: f64x2 = .{ 1, 3 };
    const expected: f64x2 = .{ 2, 3 };

    try testIntrinsic("vtrn2q_f64", vtrn2q_f64, expected, .{ a, b });
}

/// Transpose elements
pub inline fn vtrnq_s8(a: i8x16, b: i8x16) i8x16x2 {
    const a1: i8x16 = vtrn1q_s8(a, b);
    const b1: i8x16 = vtrn2q_s8(a, b);
    return .{ a1, b1 };
}

test vtrnq_s8 {
    const a: i8x16 = .{ 0, 2, 2, 6, 2, 10, 6, 14, 2, 18, 6, 22, 10, 26, 14, 30 };
    const b: i8x16 = .{ 1, 3, 3, 7, 3, 1, 7, 15, 3, 19, 7, 23, 1, 27, 15, 31 };
    const expected: i8x16x2 = .{ .{ 0, 1, 2, 3, 2, 3, 6, 7, 2, 3, 6, 7, 10, 1, 14, 15 }, .{ 2, 3, 6, 7, 10, 1, 14, 15, 18, 19, 22, 23, 26, 27, 30, 31 } };

    try testIntrinsic("vtrnq_s8", vtrnq_s8, expected, .{ a, b });
}

/// Transpose elements
pub inline fn vtrnq_s16(a: i16x8, b: i16x8) i16x8x2 {
    const a1: i16x8 = vtrn1q_s16(a, b);
    const b1: i16x8 = vtrn2q_s16(a, b);
    return .{ a1, b1 };
}

test vtrnq_s16 {
    const a: i16x8 = .{ 0, 2, 2, 6, 2, 10, 6, 14 };
    const b: i16x8 = .{ 1, 3, 3, 7, 3, 1, 7, 15 };
    const expected: i16x8x2 = .{ .{ 0, 1, 2, 3, 2, 3, 6, 7 }, .{ 2, 3, 6, 7, 10, 1, 14, 15 } };

    try testIntrinsic("vtrnq_s16", vtrnq_s16, expected, .{ a, b });
}

/// Transpose elements
pub inline fn vtrnq_s32(a: i32x4, b: i32x4) i32x4x2 {
    const a1: i32x4 = vtrn1q_s32(a, b);
    const b1: i32x4 = vtrn2q_s32(a, b);
    return .{ a1, b1 };
}

test vtrnq_s32 {
    const a: i32x4 = .{ 0, 2, 2, 6 };
    const b: i32x4 = .{ 1, 3, 3, 7 };
    const expected: i32x4x2 = .{ .{ 0, 1, 2, 3 }, .{ 2, 3, 6, 7 } };

    try testIntrinsic("vtrnq_s32", vtrnq_s32, expected, .{ a, b });
}

/// Transpose elements
pub inline fn vtrnq_u8(a: u8x16, b: u8x16) u8x16x2 {
    const a1: u8x16 = vtrn1q_u8(a, b);
    const b1: u8x16 = vtrn2q_u8(a, b);
    return .{ a1, b1 };
}

test vtrnq_u8 {
    const a: u8x16 = .{ 0, 2, 2, 6, 2, 10, 6, 14, 2, 18, 6, 22, 10, 26, 14, 30 };
    const b: u8x16 = .{ 1, 3, 3, 7, 3, 1, 7, 15, 3, 19, 7, 23, 1, 27, 15, 31 };
    const expected: u8x16x2 = .{ .{ 0, 1, 2, 3, 2, 3, 6, 7, 2, 3, 6, 7, 10, 1, 14, 15 }, .{ 2, 3, 6, 7, 10, 1, 14, 15, 18, 19, 22, 23, 26, 27, 30, 31 } };

    try testIntrinsic("vtrnq_u8", vtrnq_u8, expected, .{ a, b });
}

/// Transpose elements
pub inline fn vtrnq_u16(a: u16x8, b: u16x8) u16x8x2 {
    const a1: u16x8 = vtrn1q_u16(a, b);
    const b1: u16x8 = vtrn2q_u16(a, b);
    return .{ a1, b1 };
}

test vtrnq_u16 {
    const a: u16x8 = .{ 0, 2, 2, 6, 2, 10, 6, 14 };
    const b: u16x8 = .{ 1, 3, 3, 7, 3, 1, 7, 15 };
    const expected: u16x8x2 = .{ .{ 0, 1, 2, 3, 2, 3, 6, 7 }, .{ 2, 3, 6, 7, 10, 1, 14, 15 } };

    try testIntrinsic("vtrnq_u16", vtrnq_u16, expected, .{ a, b });
}

/// Transpose elements
pub inline fn vtrnq_u32(a: u32x4, b: u32x4) u32x4x2 {
    const a1: u32x4 = vtrn1q_u32(a, b);
    const b1: u32x4 = vtrn2q_u32(a, b);
    return .{ a1, b1 };
}

test vtrnq_u32 {
    const a: u32x4 = .{ 0, 2, 2, 6 };
    const b: u32x4 = .{ 1, 3, 3, 7 };
    const expected: u32x4x2 = .{ .{ 0, 1, 2, 3 }, .{ 2, 3, 6, 7 } };

    try testIntrinsic("vtrnq_u32", vtrnq_u32, expected, .{ a, b });
}

/// Transpose elements
pub inline fn vtrnq_f32(a: f32x4, b: f32x4) f32x4x2 {
    const a1: f32x4 = vtrn1q_f32(a, b);
    const b1: f32x4 = vtrn2q_f32(a, b);
    return .{ a1, b1 };
}

test vtrnq_f32 {
    const a: f32x4 = .{ 0, 2, 2, 6 };
    const b: f32x4 = .{ 1, 3, 3, 7 };
    const expected: f32x4x2 = .{ .{ 0, 1, 2, 3 }, .{ 2, 3, 6, 7 } };

    try testIntrinsic("vtrnq_f32", vtrnq_f32, expected, .{ a, b });
}

/// Transpose elements
pub inline fn vtrnq_p8(a: p8x16, b: p8x16) p8x16x2 {
    const a1: p8x16 = vtrn1q_u8(a, b);
    const b1: p8x16 = vtrn2q_u8(a, b);
    return .{ a1, b1 };
}

test vtrnq_p8 {
    const a: p8x16 = .{ 0, 2, 2, 6, 2, 10, 6, 14, 2, 18, 6, 22, 10, 26, 14, 30 };
    const b: p8x16 = .{ 1, 3, 3, 7, 3, 1, 7, 15, 3, 19, 7, 23, 1, 27, 15, 31 };
    const expected: p8x16x2 = .{ .{ 0, 1, 2, 3, 2, 3, 6, 7, 2, 3, 6, 7, 10, 1, 14, 15 }, .{ 2, 3, 6, 7, 10, 1, 14, 15, 18, 19, 22, 23, 26, 27, 30, 31 } };

    try testIntrinsic("vtrnq_p8", vtrnq_p8, expected, .{ a, b });
}

/// Transpose elements
pub inline fn vtrnq_p16(a: p16x8, b: p16x8) p16x8x2 {
    const a1: p16x8 = vtrn1q_u16(a, b);
    const b1: p16x8 = vtrn2q_u16(a, b);
    return .{ a1, b1 };
}

test vtrnq_p16 {
    const a: p16x8 = .{ 0, 2, 2, 6, 2, 10, 6, 14 };
    const b: p16x8 = .{ 1, 3, 3, 7, 3, 1, 7, 15 };
    const expected: p16x8x2 = .{ .{ 0, 1, 2, 3, 2, 3, 6, 7 }, .{ 2, 3, 6, 7, 10, 1, 14, 15 } };

    try testIntrinsic("vtrnq_p16", vtrnq_p16, expected, .{ a, b });
}

/// Reversing vector elements (swap endianness)
pub inline fn vrev64q_s8(a: i8x16) i8x16 {
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        return asm ("rev64 %[ret].16b, %[a].16b"
            : [ret] "=w" (-> i8x16),
            : [a] "w" (a),
        );
    } else if (use_asm and comptime arm.hasFeatures(&.{.neon})) {
        return asm ("vrev64.8 %[ret], %[a]"
            : [ret] "=w" (-> i8x16),
            : [a] "w" (a),
        );
    } else {
        return @shuffle(i8, a, undefined, i8x16{ 7, 6, 5, 4, 3, 2, 1, 0, 15, 14, 13, 12, 11, 10, 9, 8 });
    }
}

test vrev64q_s8 {
    const a: i8x16 = .{ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 };
    const expected: i8x16 = .{ 7, 6, 5, 4, 3, 2, 1, 0, 15, 14, 13, 12, 11, 10, 9, 8 };

    try testIntrinsic("vrev64q_s8", vrev64q_s8, expected, .{a});
}

/// Reversing vector elements (swap endianness)
pub inline fn vrev64q_s16(a: i16x8) i16x8 {
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        return asm ("rev64 %[ret].8h, %[a].8h"
            : [ret] "=w" (-> i16x8),
            : [a] "w" (a),
        );
    } else if (use_asm and comptime arm.hasFeatures(&.{.neon})) {
        return asm ("vrev64.16 %[ret], %[a]"
            : [ret] "=w" (-> i16x8),
            : [a] "w" (a),
        );
    } else {
        return @shuffle(i16, a, undefined, i16x8{ 3, 2, 1, 0, 7, 6, 5, 4 });
    }
}

test vrev64q_s16 {
    const a: i16x8 = .{ 0, 1, 2, 3, 4, 5, 6, 7 };
    const expected: i16x8 = .{ 3, 2, 1, 0, 7, 6, 5, 4 };

    try testIntrinsic("vrev64q_s16", vrev64q_s16, expected, .{a});
}

/// Reversing vector elements (swap endianness)
pub inline fn vrev64q_s32(a: i32x4) i32x4 {
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        return asm ("rev64 %[ret].4s, %[a].4s"
            : [ret] "=w" (-> i32x4),
            : [a] "w" (a),
        );
    } else if (use_asm and comptime arm.hasFeatures(&.{.neon})) {
        return asm ("vrev64.32 %[ret], %[a]"
            : [ret] "=w" (-> i32x4),
            : [a] "w" (a),
        );
    } else {
        return @shuffle(i32, a, undefined, i32x4{ 1, 0, 3, 2 });
    }
}

test vrev64q_s32 {
    const a: i32x4 = .{ 0, 1, 2, 3 };
    const expected: i32x4 = .{ 1, 0, 3, 2 };

    try testIntrinsic("vrev64q_s32", vrev64q_s32, expected, .{a});
}

/// Reversing vector elements (swap endianness)
pub inline fn vrev64q_u8(a: u8x16) u8x16 {
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        return asm ("rev64 %[ret].16b, %[a].16b"
            : [ret] "=w" (-> u8x16),
            : [a] "w" (a),
        );
    } else if (use_asm and comptime arm.hasFeatures(&.{.neon})) {
        return asm ("vrev64.8 %[ret], %[a]"
            : [ret] "=w" (-> u8x16),
            : [a] "w" (a),
        );
    } else {
        return @shuffle(u8, a, undefined, u8x16{ 7, 6, 5, 4, 3, 2, 1, 0, 15, 14, 13, 12, 11, 10, 9, 8 });
    }
}

test vrev64q_u8 {
    const a: u8x16 = .{ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 };
    const expected: u8x16 = .{ 7, 6, 5, 4, 3, 2, 1, 0, 15, 14, 13, 12, 11, 10, 9, 8 };

    try testIntrinsic("vrev64q_u8", vrev64q_u8, expected, .{a});
}

/// Reversing vector elements (swap endianness)
pub inline fn vrev64q_u16(a: u16x8) u16x8 {
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        return asm ("rev64 %[ret].8h, %[a].8h"
            : [ret] "=w" (-> u16x8),
            : [a] "w" (a),
        );
    } else if (use_asm and comptime arm.hasFeatures(&.{.neon})) {
        return asm ("vrev64.16 %[ret], %[a]"
            : [ret] "=w" (-> u16x8),
            : [a] "w" (a),
        );
    } else {
        return @shuffle(u16, a, undefined, u16x8{ 3, 2, 1, 0, 7, 6, 5, 4 });
    }
}

test vrev64q_u16 {
    const a: u16x8 = .{ 0, 1, 2, 3, 4, 5, 6, 7 };
    const expected: u16x8 = .{ 3, 2, 1, 0, 7, 6, 5, 4 };

    try testIntrinsic("vrev64q_u16", vrev64q_u16, expected, .{a});
}

/// Reversing vector elements (swap endianness)
pub inline fn vrev64q_u32(a: u32x4) u32x4 {
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        return asm ("rev64 %[ret].4s, %[a].4s"
            : [ret] "=w" (-> u32x4),
            : [a] "w" (a),
        );
    } else if (use_asm and comptime arm.hasFeatures(&.{.neon})) {
        return asm ("vrev64.32 %[ret], %[a]"
            : [ret] "=w" (-> u32x4),
            : [a] "w" (a),
        );
    } else {
        return @shuffle(u32, a, undefined, u32x4{ 1, 0, 3, 2 });
    }
}

test vrev64q_u32 {
    const a: u32x4 = .{ 0, 1, 2, 3 };
    const expected: u32x4 = .{ 1, 0, 3, 2 };

    try testIntrinsic("vrev64q_u32", vrev64q_u32, expected, .{a});
}

/// Reversing vector elements (swap endianness)
pub inline fn vrev64q_p8(a: p8x16) p8x16 {
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        return asm ("rev64 %[ret].16b, %[a].16b"
            : [ret] "=w" (-> p8x16),
            : [a] "w" (a),
        );
    } else if (use_asm and comptime arm.hasFeatures(&.{.neon})) {
        return asm ("vrev64.8 %[ret], %[a]"
            : [ret] "=w" (-> p8x16),
            : [a] "w" (a),
        );
    } else {
        return @shuffle(p8, a, undefined, p8x16{ 7, 6, 5, 4, 3, 2, 1, 0, 15, 14, 13, 12, 11, 10, 9, 8 });
    }
}

test vrev64q_p8 {
    const a: p8x16 = .{ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 };
    const expected: p8x16 = .{ 7, 6, 5, 4, 3, 2, 1, 0, 15, 14, 13, 12, 11, 10, 9, 8 };

    try testIntrinsic("vrev64q_p8", vrev64q_p8, expected, .{a});
}

/// Reversing vector elements (swap endianness)
pub inline fn vrev64q_p16(a: p16x8) p16x8 {
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        return asm ("rev64 %[ret].8h, %[a].8h"
            : [ret] "=w" (-> p16x8),
            : [a] "w" (a),
        );
    } else if (use_asm and comptime arm.hasFeatures(&.{.neon})) {
        return asm ("vrev64.16 %[ret], %[a]"
            : [ret] "=w" (-> p16x8),
            : [a] "w" (a),
        );
    } else {
        return @shuffle(p16, a, undefined, p16x8{ 3, 2, 1, 0, 7, 6, 5, 4 });
    }
}

test vrev64q_p16 {
    const a: p16x8 = .{ 0, 1, 2, 3, 4, 5, 6, 7 };
    const expected: p16x8 = .{ 3, 2, 1, 0, 7, 6, 5, 4 };

    try testIntrinsic("vrev64q_p16", vrev64q_p16, expected, .{a});
}

/// Reversing vector elements (swap endianness)
pub inline fn vrev64q_f32(a: f32x4) f32x4 {
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        return asm ("rev64 %[ret].4s, %[a].4s"
            : [ret] "=w" (-> f32x4),
            : [a] "w" (a),
        );
    } else if (use_asm and comptime arm.hasFeatures(&.{.neon})) {
        return asm ("vrev64.32 %[ret], %[a]"
            : [ret] "=w" (-> f32x4),
            : [a] "w" (a),
        );
    } else {
        return @shuffle(f32, a, undefined, f32x4{ 1, 0, 3, 2 });
    }
}

test vrev64q_f32 {
    const a: f32x4 = .{ 0, 1, 2, 3 };
    const expected: f32x4 = .{ 1, 0, 3, 2 };

    try testIntrinsic("vrev64q_f32", vrev64q_f32, expected, .{a});
}

/// Multiply-add to accumulator
pub inline fn vfmaq_f16(a: f16x8, b: f16x8, c: f16x8) f16x8 {
    if (use_asm and comptime aarch64.hasFeatures(&.{ .neon, .fullfp16 })) {
        var result: f16x8 = a;
        switch (endianness) {
            .little => {
                result = a;
                asm ("fmla %[ret].8h, %[b].8h, %[c].8h"
                    : [ret] "+w" (result),
                    : [b] "w" (b),
                      [c] "w" (c),
                );
            },
            .big => {
                asm (
                    \\ rev16 %[ret].16b, %[ret].16b
                    \\ rev16 %[b].16b, %[b].16b
                    \\ rev16 %[c].16b, %[c].16b
                    \\ fmla  %[ret].8h, %[b].8h, %[c].8h
                    \\ rev16 %[ret].16b, %[ret].16b
                    : [ret] "+w" (result),
                    : [b] "w" (b),
                      [c] "w" (c),
                );
            },
        }

        return result;
    } else {
        return a + (b * c);
    }
}

test vfmaq_f16 {
    const a: f16x8 = .{ 0, 1, 2, 3, 4, 5, 6, 7 };
    const b: f16x8 = .{ 2, 2, 2, 2, 2, 2, 2, 2 };
    const c: f16x8 = .{ 3, 3, 3, 3, 3, 3, 3, 3 };
    const expected: f16x8 = .{ 6, 7, 8, 9, 10, 11, 12, 13 };

    try testIntrinsic("vfmaq_f16", vfmaq_f16, expected, .{ a, b, c });
}

/// Multiply-add to accumulator
pub inline fn vfmaq_f32(a: f32x4, b: f32x4, c: f32x4) f32x4 {
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        var result: f32x4 = a;
        switch (endianness) {
            .little => {
                result = a;
                asm ("fmla %[ret].4s, %[b].4s, %[c].4s"
                    : [ret] "+w" (result),
                    : [b] "w" (b),
                      [c] "w" (c),
                );
            },
            .big => {
                asm (
                    \\ rev32 %[ret].16b, %[ret].16b
                    \\ rev32 %[b].16b, %[b].16b
                    \\ rev32 %[c].16b, %[c].16b
                    \\ fmla  %[ret].4s, %[b].4s, %[c].4s
                    \\ rev32 %[ret].16b, %[ret].16b
                    : [ret] "+w" (result),
                    : [b] "w" (b),
                      [c] "w" (c),
                );
            },
        }

        return result;
    } else if (use_asm and comptime arm.hasFeatures(&.{.neon})) {
        var result = a;
        asm ("vmla.f32 %[ret], %[b], %[c]"
            : [ret] "+w" (result),
            : [b] "w" (b),
              [c] "w" (c),
        );
        return result;
    } else {
        return a + (b * c);
    }
}

test vfmaq_f32 {
    const a: f32x4 = .{ 0, 1, 2, 3 };
    const b: f32x4 = .{ 2, 2, 2, 2 };
    const c: f32x4 = .{ 3, 3, 3, 3 };
    const expected: f32x4 = .{ 6, 7, 8, 9 };

    try testIntrinsic("vfmaq_f32", vfmaq_f32, expected, .{ a, b, c });
}

/// Multiply-add to accumulator
pub inline fn vfmaq_f64(a: f64x2, b: f64x2, c: f64x2) f64x2 {
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        var result: f64x2 = a;
        switch (endianness) {
            .little => {
                asm ("fmla %[ret].2d, %[b].2d, %[c].2d"
                    : [ret] "+w" (result),
                    : [b] "w" (b),
                      [c] "w" (c),
                );
            },
            .big => {
                asm (
                    \\ rev64 %[ret].16b, %[ret].16b
                    \\ rev64 %[b].16b, %[b].16b
                    \\ rev64 %[c].16b, %[c].16b
                    \\ fmla  %[ret].2d, %[b].2d, %[c].2d
                    \\ rev64 %[ret].16b, %[ret].16b
                    : [ret] "+w" (result),
                    : [b] "w" (b),
                      [c] "w" (c),
                );
            },
        }

        return result;
    } else {
        return a + (b * c);
    }
}

test vfmaq_f64 {
    const a: f64x2 = .{ 0, 1 };
    const b: f64x2 = .{ 2, 2 };
    const c: f64x2 = .{ 3, 3 };
    const expected: f64x2 = .{ 6, 7 };

    try testIntrinsic("vfmaq_f64", vfmaq_f64, expected, .{ a, b, c });
}

/// Multiply-add to accumulator
pub inline fn vfmaq_laneq_f16(a: f16x8, b: f16x8, c: f16x8, comptime lane: usize) f16x8 {
    comptime assert(lane < 8);
    if (use_asm and comptime aarch64.hasFeatures(&.{ .neon, .fullfp16 })) {
        var result: f16x8 = a;
        switch (endianness) {
            .little => {
                result = a;
                asm ("fmla %[ret].8h, %[b].8h, %[c].h[%[lane]]"
                    : [ret] "+w" (result),
                    : [b] "w" (b),
                      [c] "w" (c),
                      [lane] "i" (lane),
                );
            },
            .big => {
                asm (
                    \\ rev16 %[ret].16b, %[ret].16b
                    \\ rev16 %[b].16b, %[b].16b
                    \\ rev16 %[c].16b, %[c].16b
                    \\ fmla  %[ret].8h, %[b].8h, %[c].8h[%[lane]]
                    \\ rev16 %[ret].16b, %[ret].16b
                    : [ret] "+w" (result),
                    : [b] "w" (b),
                      [c] "w" (c),
                      [lane] "i" (lane),
                );
            },
        }

        return result;
    } else {
        return vfmaq_f16(a, b, vdupq_n_f16(c[lane]));
    }
}

test vfmaq_laneq_f16 {
    const a: f16x8 = .{ 0, 1, 2, 3, 4, 5, 6, 7 };
    const b: f16x8 = .{ 2, 2, 2, 2, 2, 2, 2, 2 };
    const c: f16x8 = .{ 3, 0, 0, 0, 0, 0, 0, 0 };
    const lane: usize = 0;
    const expected: f16x8 = .{ 6, 7, 8, 9, 10, 11, 12, 13 };

    try testIntrinsic("vfmaq_laneq_f16", vfmaq_laneq_f16, expected, .{ a, b, c, lane });
}

/// Multiply-add to accumulator
pub inline fn vfmaq_laneq_f32(a: f32x4, b: f32x4, c: f32x4, comptime lane: usize) f32x4 {
    comptime assert(lane < 4);
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        var result: f32x4 = a;
        switch (endianness) {
            .little => {
                result = a;
                asm ("fmla %[ret].4s, %[b].4s, %[c].s[%[lane]]"
                    : [ret] "+w" (result),
                    : [b] "w" (b),
                      [c] "w" (c),
                      [lane] "i" (lane),
                );
            },
            .big => {
                asm (
                    \\ rev32 %[ret].16b, %[ret].16b
                    \\ rev32 %[b].16b, %[b].16b
                    \\ rev32 %[c].16b, %[c].16b
                    \\ fmla  %[ret].4s, %[b].4s, %[c].s[%[lane]]
                    \\ rev32 %[ret].16b, %[ret].16b
                    : [ret] "+w" (result),
                    : [b] "w" (b),
                      [c] "w" (c),
                      [lane] "i" (lane),
                );
            },
        }

        return result;
    } else {
        return vfmaq_f32(a, b, vdupq_n_f32(c[lane]));
    }
}

test vfmaq_laneq_f32 {
    const a: f32x4 = .{ 0, 1, 2, 3 };
    const b: f32x4 = .{ 2, 2, 2, 2 };
    const c: f32x4 = .{ 3, 0, 0, 0 };
    const lane: usize = 0;
    const expected: f32x4 = .{ 6, 7, 8, 9 };

    try testIntrinsic("vfmaq_laneq_f32", vfmaq_laneq_f32, expected, .{ a, b, c, lane });
}

/// Multiply-add to accumulator
pub inline fn vfmaq_laneq_f64(a: f64x2, b: f64x2, c: f64x2, comptime lane: usize) f64x2 {
    comptime assert(lane < 2);
    if (use_asm and comptime aarch64.hasFeatures(&.{.neon})) {
        var result: f64x2 = a;
        switch (endianness) {
            .little => {
                asm ("fmla %[ret].2d, %[b].2d, %[c].d[%[lane]]"
                    : [ret] "+w" (result),
                    : [b] "w" (b),
                      [c] "w" (c),
                      [lane] "i" (lane),
                );
            },
            .big => {
                asm (
                    \\ rev64 %[ret].16b, %[ret].16b
                    \\ rev64 %[b].16b, %[b].16b
                    \\ rev64 %[c].16b, %[c].16b
                    \\ fmla  %[ret].2d, %[b].2d, %[c].d[%[lane]]
                    \\ rev64 %[ret].16b, %[ret].16b
                    : [ret] "+w" (result),
                    : [b] "w" (b),
                      [c] "w" (c),
                      [lane] "i" (lane),
                );
            },
        }

        return result;
    } else {
        return vfmaq_f64(a, b, vdupq_n_f64(c[lane]));
    }
}

test vfmaq_laneq_f64 {
    const a: f64x2 = .{ 0, 1 };
    const b: f64x2 = .{ 2, 2 };
    const c: f64x2 = .{ 3, 0 };
    const lane: usize = 0;
    const expected: f64x2 = .{ 6, 7 };

    try testIntrinsic("vfmaq_laneq_f64", vfmaq_laneq_f64, expected, .{ a, b, c, lane });
}

test {
    std.testing.refAllDecls(@This());
}
