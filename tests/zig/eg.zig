const std = @import("std");

const WIDTH: usize = 4;
const HEIGHT: usize = 4;

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

inline fn vecLen(T: anytype) usize {
    const type_info = comptime @typeInfo(T);

    comptime std.debug.assert(type_info == .Vector);
    return type_info.Vector.len;
}

inline fn join(
    a: anytype,
    b: anytype,
) @Vector(
    vecLen(@TypeOf(a)) + vecLen(@TypeOf(b)),
    std.meta.Child(@TypeOf(a, b)),
) {
    const Child = std.meta.Child(@TypeOf(a));
    const a_len = vecLen(@TypeOf(a));
    const b_len = vecLen(@TypeOf(b));

    return @shuffle(
        Child,
        a,
        b,
        @as([a_len]i32, std.simd.iota(i32, a_len)) ++ @as([b_len]i32, ~std.simd.iota(i32, b_len)),
    );
}

inline fn vget_lane_f32(vec: f32x2, index: u32) f32 {
    return vec[index];
}

inline fn vzip1_f32(a: f32x2, b: f32x2) f32x2 {
    // Interleave the first elements of a and b
    return .{
        vget_lane_f32(a, 0),
        vget_lane_f32(b, 0),
    };
}

inline fn vzip2_f32(a: f32x2, b: f32x2) f32x2 {
    // Interleave the second elements of a and b
    return .{
        vget_lane_f32(a, 1),
        vget_lane_f32(b, 1),
    };
}

inline fn vtrnq_f32(a: f32x4, b: f32x4) [2]f32x4 {
    // Interleave the lower halves of a and b
    const a_low = vget_low_f32(a); // Extract the lower 2 elements of a
    const b_low = vget_low_f32(b); // Extract the lower 2 elements of b
    const ab_low = vzip1_f32(a_low, b_low); // Interleave the lower halves

    // Interleave the upper halves of a and b
    const a_high = vget_high_f32(a); // Extract the upper 2 elements of a
    const b_high = vget_high_f32(b); // Extract the upper 2 elements of b
    const ab_high = vzip1_f32(a_high, b_high); // Interleave the upper halves

    // Combine into two new 128-bit vectors
    const result0 = vcombine_f32(ab_low, ab_high); // Interleaved lowerues
    const result1 = vcombine_f32(vzip2_f32(a_low, b_low), vzip2_f32(a_high, b_high)); // Interleaved upperues

    return .{ result0, result1 };
}

inline fn vrev64q_f32(a: f32x4) f32x4 {
    return @shuffle(f32, a, undefined, f32x4{ 1, 0, 3, 2 });
}

inline fn vcombine_f32(a: f32x2, b: f32x2) f32x4 {
    return join(a, b);
}

inline fn vget_low_f32(a: f32x4) f32x2 {
    return @shuffle(f32, a, undefined, f32x2{ 0, 1 });
}

inline fn vget_high_f32(a: f32x4) f32x2 {
    return @shuffle(f32, a, undefined, f32x2{ 2, 3 });
}

inline fn vtrn2q_f32(a: f32x4, b: f32x4) f32x4 {
    return @shuffle(f32, a, b, i32x4{ 1, ~@as(i32, 1), 3, ~@as(i32, 3) });
}

pub inline fn vtrn1q_f32(a: f32x4, b: f32x4) f32x4 {
    return @shuffle(f32, a, b, i32x4{ 0, ~@as(i32, 0), 2, ~@as(i32, 2) });
}

inline fn vld1q_f32(mem_addr: [*]const f32) f32x4 {
    return .{ mem_addr[0], mem_addr[1], mem_addr[2], mem_addr[3] };
}

inline fn vst1q_f32(mem_addr: [*]f32, vec: f32x4) void {
    const a: [4]f32 = vec;
    mem_addr[0..4].* = a;
}

inline fn vmlaq_f32(a: f32x4, b: f32x4, c: f32x4) f32x4 {
    return a + (b * c);
}

inline fn vdupq_n_f32(scalar: f32) f32x4 {
    return @splat(scalar);
}

inline fn vmovq_n_f32(scalar: f32) f32x4 {
    return vdupq_n_f32(scalar);
}

inline fn vfmaq_f32(a: f32x4, b: f32x4, c: f32x4) f32x4 {
    return a + (b * c);
}

inline fn vfmaq_laneq_f32(a: f32x4, b: f32x4, c: f32x4, comptime lane: u2) f32x4 {
    return vfmaq_f32(a, b, vdupq_n_f32(c[lane]));
}

inline fn asPtr4x4(a: *f32) [*]f32 {
    return @ptrCast(&a[4]);
}

fn printMatrix(matrix: [*]const f32, w: usize, h: usize) void {
    std.debug.print("   |", .{});

    for (0..w) |n| {
        std.debug.print("{d:>3} ", .{n + 1});
    }
    std.debug.print("\n", .{});

    var n: u8 = 0;
    while (n <= w) : (n += 1) {
        std.debug.print("---+", .{});
    }
    std.debug.print("\n", .{});
    for (0..h) |a| {
        std.debug.print("{d:>2} |", .{a + 1});

        for (0..w) |b| {
            std.debug.print("{d:>3} ", .{matrix[a * w + b]});
        }

        if (a != h - 1) {
            std.debug.print("\n   |\n", .{});
        } else {
            std.debug.print("\n", .{});
        }
    }
}

fn matmul4x4(A: [*]const f32, B: [*]const f32, C: [*]f32) void {
    // these are the columns A
    const A0 = vld1q_f32(A);
    const A1 = vld1q_f32(A + 4);
    const A2 = vld1q_f32(A + 8);
    const A3 = vld1q_f32(A + 12);

    // these are the columns B
    const B0 = vld1q_f32(B);
    const B1 = vld1q_f32(B + 4);
    const B2 = vld1q_f32(B + 8);
    const B3 = vld1q_f32(B + 12);

    // these are the columns C
    var C0 = vmovq_n_f32(0);
    var C1 = vmovq_n_f32(0);
    var C2 = vmovq_n_f32(0);
    var C3 = vmovq_n_f32(0);

    // Multiply accumulate in 4x1 blocks, i.e. each column in C
    C0 = vfmaq_laneq_f32(C0, B0, A0, 0);
    C0 = vfmaq_laneq_f32(C0, B1, A0, 1);
    C0 = vfmaq_laneq_f32(C0, B2, A0, 2);
    C0 = vfmaq_laneq_f32(C0, B3, A0, 3);
    vst1q_f32(C, C0);

    C1 = vfmaq_laneq_f32(C1, B0, A1, 0);
    C1 = vfmaq_laneq_f32(C1, B1, A1, 1);
    C1 = vfmaq_laneq_f32(C1, B2, A1, 2);
    C1 = vfmaq_laneq_f32(C1, B3, A1, 3);
    vst1q_f32(C + 4, C1);

    C2 = vfmaq_laneq_f32(C2, B0, A2, 0);
    C2 = vfmaq_laneq_f32(C2, B1, A2, 1);
    C2 = vfmaq_laneq_f32(C2, B2, A2, 2);
    C2 = vfmaq_laneq_f32(C2, B3, A2, 3);
    vst1q_f32(C + 8, C2);

    C3 = vfmaq_laneq_f32(C3, B0, A3, 0);
    C3 = vfmaq_laneq_f32(C3, B1, A3, 1);
    C3 = vfmaq_laneq_f32(C3, B2, A3, 2);
    C3 = vfmaq_laneq_f32(C3, B3, A3, 3);
    vst1q_f32(C + 12, C3);
}

/// Matrix multiplication using 4x4 submatrices and NEON intrinsics.
/// Computes C = A * B where:
///   - A is an (n x k) matrix,
///   - B is a (k x m) matrix,
///   - C is an (n x m) matrix.
fn matmul(
    A: [*]const f32, // Pointer to matrix A (row-major order)
    B: [*]const f32, // Pointer to matrix B (row-major order)
    C: [*]f32, // Pointer to output matrix C (row-major order)
    comptime n: usize, // Rows in A and C
    comptime m: usize, // Columns in B and C
    comptime k: usize, // Columns in A and rows in B
) void {
    var A_idx: usize = undefined;
    var B_idx: usize = undefined;
    var C_idx: usize = undefined;

    // Temporary registers for 4x4 submatrices
    var A0: f32x4 = undefined;
    var A1: f32x4 = undefined;
    var A2: f32x4 = undefined;
    var A3: f32x4 = undefined;

    var B0: f32x4 = undefined;
    var B1: f32x4 = undefined;
    var B2: f32x4 = undefined;
    var B3: f32x4 = undefined;

    var C0: f32x4 = undefined;
    var C1: f32x4 = undefined;
    var C2: f32x4 = undefined;
    var C3: f32x4 = undefined;

    // Process 4x4 submatrices
    comptime var i_idx: usize = 0;
    inline while (i_idx < n) : (i_idx += 4) {
        comptime var j_idx: usize = 0;
        inline while (j_idx < m) : (j_idx += 4) {
            // Zero accumulators for the 4x4 block of matrix C
            C0 = vmovq_n_f32(0);
            C1 = vmovq_n_f32(0);
            C2 = vmovq_n_f32(0);
            C3 = vmovq_n_f32(0);

            comptime var k_idx: usize = 0;
            inline while (k_idx < k) : (k_idx += 4) {
                A_idx = i_idx + n * k_idx;
                B_idx = k * j_idx + k_idx;

                // Load 4 rows of A
                A0 = vld1q_f32(A + A_idx);
                A1 = vld1q_f32(A + A_idx + k);
                A2 = vld1q_f32(A + A_idx + 2 * k);
                A3 = vld1q_f32(A + A_idx + 3 * k);

                // Load 4 rows of B
                B0 = vld1q_f32(B + B_idx);
                B1 = vld1q_f32(B + B_idx + k);
                B2 = vld1q_f32(B + B_idx + 2 * k);
                B3 = vld1q_f32(B + B_idx + 3 * k);

                // Load and multiply-accumulate columns of B with rows of A
                C0 = vfmaq_laneq_f32(C0, B0, A0, 0);
                C0 = vfmaq_laneq_f32(C0, B1, A0, 1);
                C0 = vfmaq_laneq_f32(C0, B2, A0, 2);
                C0 = vfmaq_laneq_f32(C0, B3, A0, 3);

                C1 = vfmaq_laneq_f32(C1, B0, A1, 0);
                C1 = vfmaq_laneq_f32(C1, B1, A1, 1);
                C1 = vfmaq_laneq_f32(C1, B2, A1, 2);
                C1 = vfmaq_laneq_f32(C1, B3, A1, 3);

                C2 = vfmaq_laneq_f32(C2, B0, A2, 0);
                C2 = vfmaq_laneq_f32(C2, B1, A2, 1);
                C2 = vfmaq_laneq_f32(C2, B2, A2, 2);
                C2 = vfmaq_laneq_f32(C2, B3, A2, 3);

                C3 = vfmaq_laneq_f32(C3, B0, A3, 0);
                C3 = vfmaq_laneq_f32(C3, B1, A3, 1);
                C3 = vfmaq_laneq_f32(C3, B2, A3, 2);
                C3 = vfmaq_laneq_f32(C3, B3, A3, 3);
            }

            // Store the 4x4 block of matrix C in reverse row order
            C_idx = (n * i_idx) + j_idx;
            vst1q_f32(C + C_idx, C0);
            vst1q_f32(C + C_idx + n, C1);
            vst1q_f32(C + C_idx + 2 * n, C2);
            vst1q_f32(C + C_idx + 3 * n, C3);
        }
    }
}

const RotationDir = enum {
    CW, // Clockwise rotation
    CCW, // Counterclockwise rotation

    pub inline fn flip(self: RotationDir) RotationDir {
        switch (self) {
            .CW => return .CCW,
            .CCW => return .CW,
        }
    }
};

fn matrot4x4(
    input: [*]const f32,
    output: [*]f32,
    comptime n: usize,
    comptime dir: RotationDir,
) void {
    if (n % 2 == 0)
        return horizontal_flip4x4(input, output);

    const direction = if (n % 3 == 0) dir.flip() else dir;

    comptime var row: usize = 0;
    inline while (row < HEIGHT) : (row += 4) {
        comptime var col: usize = 0;
        inline while (col < WIDTH) : (col += 4) {
            const in_idx = row * WIDTH + col;

            // Load the 4x4 block of the matrix
            const R0 = vld1q_f32(input + in_idx);
            const R1 = vld1q_f32(input + in_idx + WIDTH);
            const R2 = vld1q_f32(input + in_idx + 2 * WIDTH);
            const R3 = vld1q_f32(input + in_idx + 3 * WIDTH);

            // Transpose the block (interleave rows and columns)
            var T0: [2]f32x4 = undefined;
            var T1: [2]f32x4 = undefined;

            if (direction == .CW) {
                T0 = vtrnq_f32(R1, R0);
                T1 = vtrnq_f32(R3, R2);
            } else {
                T0 = vtrnq_f32(R0, R1);
                T1 = vtrnq_f32(R2, R3);
            }

            const TT0 = vcombine_f32(vget_low_f32(T0[0]), vget_low_f32(T1[0]));
            const TT1 = vcombine_f32(vget_low_f32(T0[1]), vget_low_f32(T1[1]));
            const TT2 = vcombine_f32(vget_high_f32(T0[0]), vget_high_f32(T1[0]));
            const TT3 = vcombine_f32(vget_high_f32(T0[1]), vget_high_f32(T1[1]));

            // Rotate the transposed matrix depending on direction
            var rotated0: f32x4 = undefined;
            var rotated1: f32x4 = undefined;
            var rotated2: f32x4 = undefined;
            var rotated3: f32x4 = undefined;

            if (direction == RotationDir.CW) {
                // Clockwise rotation
                rotated0 = vcombine_f32(vget_high_f32(TT3), vget_low_f32(TT3));
                rotated1 = vcombine_f32(vget_high_f32(TT2), vget_low_f32(TT2));
                rotated2 = vcombine_f32(vget_high_f32(TT1), vget_low_f32(TT1));
                rotated3 = vcombine_f32(vget_high_f32(TT0), vget_low_f32(TT0));
            } else {
                // Counterclockwise rotation
                rotated0 = vcombine_f32(vget_low_f32(TT0), vget_high_f32(TT0));
                rotated1 = vcombine_f32(vget_low_f32(TT1), vget_high_f32(TT1));
                rotated2 = vcombine_f32(vget_low_f32(TT2), vget_high_f32(TT2));
                rotated3 = vcombine_f32(vget_low_f32(TT3), vget_high_f32(TT3));
            }

            // Store the rotated block in the output matrix
            const out_idx = col * HEIGHT + (HEIGHT - row - 4);
            vst1q_f32(output + out_idx, rotated3);
            vst1q_f32(output + out_idx + HEIGHT, rotated2);
            vst1q_f32(output + out_idx + 2 * HEIGHT, rotated1);
            vst1q_f32(output + out_idx + 3 * HEIGHT, rotated0);
        }
    }
}

fn horizontal_flip4x4(
    input: [*]const f32,
    output: [*]f32,
) void {
    comptime var row: usize = 0;
    inline while (row < HEIGHT) : (row += 4) {
        comptime var col: usize = 0;
        inline while (col < WIDTH) : (col += 4) {
            const in_idx = row * WIDTH + col;

            // Load 4 elements from a row
            const R0 = vld1q_f32(input + in_idx);
            const R1 = vld1q_f32(input + in_idx + 1 * WIDTH);
            const R2 = vld1q_f32(input + in_idx + 2 * WIDTH);
            const R3 = vld1q_f32(input + in_idx + 3 * WIDTH);

            // Reverse the order of elements horizontally within each row
            const flipped0: f32x4 = vrev64q_f32(R0);
            const flipped1: f32x4 = vrev64q_f32(R1);
            const flipped2: f32x4 = vrev64q_f32(R2);
            const flipped3: f32x4 = vrev64q_f32(R3);

            // Store the flipped rows
            const out_idx = row * WIDTH + col;
            vst1q_f32(output + out_idx, vcombine_f32(vget_high_f32(flipped3), vget_low_f32(flipped3)));
            vst1q_f32(output + out_idx + WIDTH, vcombine_f32(vget_high_f32(flipped2), vget_low_f32(flipped2)));
            vst1q_f32(output + out_idx + 2 * WIDTH, vcombine_f32(vget_high_f32(flipped1), vget_low_f32(flipped1)));
            vst1q_f32(output + out_idx + 3 * WIDTH, vcombine_f32(vget_high_f32(flipped0), vget_low_f32(flipped0)));
        }
    }
}

fn vertical_flip4x4(
    input: [*]const f32,
    output: [*]f32,
) void {
    comptime var row: usize = 0;
    inline while (row < HEIGHT) : (row += 4) {
        comptime var col: usize = 0;
        inline while (col < WIDTH) : (col += 4) {
            const in_idx = row * WIDTH + col;

            // Load 4 rows of the matrix
            const R0 = vld1q_f32(input + in_idx + 3);
            const R1 = vld1q_f32(input + in_idx + 2 * WIDTH);
            const R2 = vld1q_f32(input + in_idx + WIDTH);
            const R3 = vld1q_f32(input + in_idx);

            // Store the rows in reverse order
            const out_idx = (HEIGHT - row - 4) * WIDTH + col;
            vst1q_f32(output + out_idx, R0);
            vst1q_f32(output + out_idx + WIDTH, R1);
            vst1q_f32(output + out_idx + 2 * WIDTH, R2);
            vst1q_f32(output + out_idx + 3 * WIDTH, R3);
        }
    }
}

pub fn main() void {
    {
        const A: [16]f32 = .{
            1.0,  2.0,  3.0,  4.0,
            5.0,  6.0,  7.0,  8.0,
            9.0,  10.0, 11.0, 12.0,
            13.0, 14.0, 15.0, 16.0,
        };

        const B: [16]f32 = .{
            16.0, 15.0, 14.0, 13.0,
            12.0, 11.0, 10.0, 9.0,
            8.0,  7.0,  6.0,  5.0,
            4.0,  3.0,  2.0,  1.0,
        };

        var result: [16]f32 = undefined;
        matmul4x4(A[0..].ptr, B[0..].ptr, &result);

        // Print result matrix
        printMatrix(result[0..].ptr, WIDTH, HEIGHT);
    }
    {
        const A: [16]f32 = .{
            1.0,  2.0,  3.0,  4.0,
            5.0,  6.0,  7.0,  8.0,
            9.0,  10.0, 11.0, 12.0,
            13.0, 14.0, 15.0, 16.0,
        };

        var result: [16]f32 = undefined;
        matrot4x4(A[0..].ptr, &result, 2, .CW);

        printMatrix(result[0..].ptr, WIDTH, HEIGHT);
    }
    {
        const A: [16]f32 = .{
            1.0,  2.0,  3.0,  4.0,
            5.0,  6.0,  7.0,  8.0,
            9.0,  10.0, 11.0, 12.0,
            13.0, 14.0, 15.0, 16.0,
        };

        var result: [16]f32 = undefined;
        horizontal_flip4x4(A[0..].ptr, &result);

        printMatrix(result[0..].ptr, WIDTH, HEIGHT);
    }
    {
        const A: [16]f32 = .{
            1.0,  2.0,  3.0,  4.0,
            5.0,  6.0,  7.0,  8.0,
            9.0,  10.0, 11.0, 12.0,
            13.0, 14.0, 15.0, 16.0,
        };

        var result: [16]f32 = undefined;
        vertical_flip4x4(A[0..].ptr, &result);

        printMatrix(result[0..].ptr, WIDTH, HEIGHT);
    }
}
