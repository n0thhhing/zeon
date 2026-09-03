//! # Matrix Multiplication 4x4 (ARM NEON)
//!
//! Demonstrates computing a 4x4 single-precision floating-point matrix multiplication
//! using ARM NEON vector intrinsics.
//!
//! ### Technique:
//! - Loads 4x4 matrix blocks into NEON 128-bit registers (`vld1q_f32`).
//! - Uses `vfmaq_laneq_f32` (Vector Fused Multiply-Accumulate by lane) to compute
//!   column-by-lane scalar products in parallel without intermediate rounding.
//! - Stores the accumulated 4x4 result matrix with `vst1q_f32`.
//!
//! Based on the ARM NEON Programmer's Guide matrix multiplication example:
//! https://developer.arm.com/documentation/102467/0201/Example---matrix-multiplication

const std = @import("std");
const neon = @import("zeon");

/// Formats and prints a `w` x `h` matrix to standard debug output in a tabular grid.
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
    std.debug.print("\n", .{});
}

/// Multiplies two 4x4 matrices `A` and `B` stored in column-major order:
/// `C = A * B`
///
/// ### Mathematical Formulation:
/// In column-major layout, each vector register `a0..a3` holds a full 4-element column of matrix A:
///   `a0 = A[:, 0]`, `a1 = A[:, 1]`, `a2 = A[:, 2]`, `a3 = A[:, 3]`
///
/// Matrix multiplication can be written as computing each column of C as a linear combination
/// of the columns of A, weighted by the entries in column j of B:
///   `C[:, j] = B[0, j] * A[:, 0] + B[1, j] * A[:, 1] + B[2, j] * A[:, 2] + B[3, j] * A[:, 3]`
///
/// ### Why this is optimal for ARM NEON:
/// Rather than computing dot products of rows and columns (which require expensive horizontal
/// additions across vector lanes), this formulation broadcasts individual scalar lanes of B's
/// columns across vector registers of A's columns. Using NEON's `vfmaq_laneq_f32`, each step
/// executes 4 fused multiply-accumulates in a single instruction cycle with zero transposition overhead.
fn matmul4x4(a: [*]const f32, b: [*]const f32, c: [*]f32) void {
    // Step 1: Vector Load Matrix A Columns
    // Each 128-bit NEON Q-register holds 4 x 32-bit floats.
    // In column-major format, contiguous memory addresses represent vertical columns:
    // a0 = [ A[0,0], A[1,0], A[2,0], A[3,0] ]^T (Column 0)
    // a1 = [ A[0,1], A[1,1], A[2,1], A[3,1] ]^T (Column 1)
    // a2 = [ A[0,2], A[1,2], A[2,2], A[3,2] ]^T (Column 2)
    // a3 = [ A[0,3], A[1,3], A[2,3], A[3,3] ]^T (Column 3)
    const a0 = neon.vld1q_f32(a);
    const a1 = neon.vld1q_f32(a + 4);
    const a2 = neon.vld1q_f32(a + 8);
    const a3 = neon.vld1q_f32(a + 12);

    // Step 2: Vector Load Matrix B Columns
    // Similarly, load the 4 columns of B into vector registers.
    // b0 contains column 0: [ B[0,0], B[1,0], B[2,0], B[3,0] ]^T
    // b1 contains column 1: [ B[0,1], B[1,1], B[2,1], B[3,1] ]^T
    // b2 contains column 2: [ B[0,2], B[1,2], B[2,2], B[3,2] ]^T
    // b3 contains column 3: [ B[0,3], B[1,3], B[2,3], B[3,3] ]^T
    const b0 = neon.vld1q_f32(b);
    const b1 = neon.vld1q_f32(b + 4);
    const b2 = neon.vld1q_f32(b + 8);
    const b3 = neon.vld1q_f32(b + 12);

    // Step 3: Initialize Result Column Accumulators
    // Clear four 128-bit vector registers to 0.0. Each will accumulate one full
    // column of output matrix C.
    var c0 = neon.vmovq_n_f32(0);
    var c1 = neon.vmovq_n_f32(0);
    var c2 = neon.vmovq_n_f32(0);
    var c3 = neon.vmovq_n_f32(0);

    // Step 4: Compute Output Column 0 (C[:, 0])
    // vfmaq_laneq_f32(acc, vec, lane_source, lane_idx):
    //   Computes: acc = acc + (vec * lane_source[lane_idx])
    //
    // Notice how lane_idx indexes into a0..a3 to extract scalar B weights,
    // which scale the corresponding column vectors of A.
    // Fused Multiply-Accumulate (FMA) performs multiplication and addition with
    // a single rounding step at the end, preventing intermediate loss of precision.
    c0 = neon.vfmaq_laneq_f32(c0, a0, b0, 0); // c0 += A[:,0] * B[0,0]
    c0 = neon.vfmaq_laneq_f32(c0, a1, b0, 1); // c0 += A[:,1] * B[1,0]
    c0 = neon.vfmaq_laneq_f32(c0, a2, b0, 2); // c0 += A[:,2] * B[2,0]
    c0 = neon.vfmaq_laneq_f32(c0, a3, b0, 3); // c0 += A[:,3] * B[3,0]
    neon.vst1q_f32(c, c0); // Write completed Column 0 back to memory

    // Step 5: Compute Output Column 1 (C[:, 1])
    c1 = neon.vfmaq_laneq_f32(c1, a0, b1, 0); // c1 += A[:,0] * B[0,1]
    c1 = neon.vfmaq_laneq_f32(c1, a1, b1, 1); // c1 += A[:,1] * B[1,1]
    c1 = neon.vfmaq_laneq_f32(c1, a2, b1, 2); // c1 += A[:,2] * B[2,1]
    c1 = neon.vfmaq_laneq_f32(c1, a3, b1, 3); // c1 += A[:,3] * B[3,1]
    neon.vst1q_f32(c + 4, c1); // Write completed Column 1 back to memory

    // Step 6: Compute Output Column 2 (C[:, 2])
    c2 = neon.vfmaq_laneq_f32(c2, a0, b2, 0); // c2 += A[:,0] * B[0,2]
    c2 = neon.vfmaq_laneq_f32(c2, a1, b2, 1); // c2 += A[:,1] * B[1,2]
    c2 = neon.vfmaq_laneq_f32(c2, a2, b2, 2); // c2 += A[:,2] * B[2,2]
    c2 = neon.vfmaq_laneq_f32(c2, a3, b2, 3); // c2 += A[:,3] * B[3,2]
    neon.vst1q_f32(c + 8, c2); // Write completed Column 2 back to memory

    // Step 7: Compute Output Column 3 (C[:, 3])
    c3 = neon.vfmaq_laneq_f32(c3, a0, b3, 0); // c3 += A[:,0] * B[0,3]
    c3 = neon.vfmaq_laneq_f32(c3, a1, b3, 1); // c3 += A[:,1] * B[1,3]
    c3 = neon.vfmaq_laneq_f32(c3, a2, b3, 2); // c3 += A[:,2] * B[2,3]
    c3 = neon.vfmaq_laneq_f32(c3, a3, b3, 3); // c3 += A[:,3] * B[3,3]
    neon.vst1q_f32(c + 12, c3); // Write completed Column 3 back to memory
}

test matmul4x4 {
    const a: [16]f32 = .{
        1.0,  2.0,  3.0,  4.0,
        5.0,  6.0,  7.0,  8.0,
        9.0,  10.0, 11.0, 12.0,
        13.0, 14.0, 15.0, 16.0,
    };

    const b: [16]f32 = .{
        16.0, 15.0, 14.0, 13.0,
        12.0, 11.0, 10.0, 9.0,
        8.0,  7.0,  6.0,  5.0,
        4.0,  3.0,  2.0,  1.0,
    };

    var result: [16]f32 = undefined;

    const expected: [16]f32 = .{
        80,  70,  60,  50,
        240, 214, 188, 162,
        400, 358, 316, 274,
        560, 502, 444, 386,
    };

    matmul4x4(a[0..].ptr, b[0..].ptr, &result);

    try std.testing.expectEqual(expected, result);
}

pub fn main() void {
    std.debug.print("Matrix Multiply:\n", .{});
    const a: [16]f32 = .{
        1.0,  2.0,  3.0,  4.0,
        5.0,  6.0,  7.0,  8.0,
        9.0,  10.0, 11.0, 12.0,
        13.0, 14.0, 15.0, 16.0,
    };

    const b: [16]f32 = .{
        16.0, 15.0, 14.0, 13.0,
        12.0, 11.0, 10.0, 9.0,
        8.0,  7.0,  6.0,  5.0,
        4.0,  3.0,  2.0,  1.0,
    };

    var result: [16]f32 = undefined;

    matmul4x4(a[0..].ptr, b[0..].ptr, &result);

    printMatrix(result[0..].ptr, 4, 4);
}
