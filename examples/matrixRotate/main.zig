//! # Matrix Rotation 4x4 (ARM NEON)
//!
//! Demonstrates 90-degree clockwise (CW) and counterclockwise (CCW) rotations
//! of 4x4 single-precision floating-point matrices using NEON intrinsics.
//!
//! ### Technique:
//! - Loads matrix rows into 128-bit vector registers with `vld1q_f32`.
//! - Transposes elements using vector transpose intrinsics (`vtrnq_f32`).
//! - Combines low and high vector halves using `vcombine_f32` to finalize transposed rows.
//! - Swaps or reverses rows depending on rotation direction (CW vs CCW) or flip symmetry.

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
/// Rotates a 4x4 single-precision floating-point matrix by `n * 90` degrees in `dir` direction.
///
/// ### Mathematical Foundation:
/// A 90-degree 2D matrix rotation is equivalent to a matrix transpose combined with reflection:
/// - **Clockwise 90°**: `Rotate_CW(M) = ReverseRows(Transpose(M))`
/// - **Counter-Clockwise 90°**: `Rotate_CCW(M) = ReverseCols(Transpose(M))`
/// - **180° Rotation (`n % 2 == 0`)**: Equivalent to flipping horizontally and vertically,
///   which can be accelerated directly without full transposition.
fn matrot4x4(
    input: [*]const f32,
    output: [*]f32,
    comptime n: usize,
    comptime dir: RotationDir,
) void {
    // Fast path: A 180-degree rotation (n is even) does not require a full 2D transpose.
    if (n % 2 == 0) {
        return horizontal_flip4x4(input, output);
    }

    // 270-degree rotation (3 x 90°) in one direction is equivalent to 90° in the reverse direction.
    const direction = if (n % 3 == 0) dir.flip() else dir;

    // Step 1: Load Rows of 4x4 Matrix into 128-bit NEON Registers
    // R0 = [ m00, m01, m02, m03 ] (Row 0)
    // R1 = [ m10, m11, m12, m13 ] (Row 1)
    // R2 = [ m20, m21, m22, m23 ] (Row 2)
    // R3 = [ m30, m31, m32, m33 ] (Row 3)
    const R0 = neon.vld1q_f32(input);
    const R1 = neon.vld1q_f32(input + 4);
    const R2 = neon.vld1q_f32(input + 8);
    const R3 = neon.vld1q_f32(input + 12);

    // Step 2: 2x2 Sub-block Transposition using vtrnq_f32
    // vtrnq_f32 transposes alternating 32-bit elements across a pair of vectors:
    // T0[0] = [ R1[0], R0[0], R1[2], R0[2] ]
    // T0[1] = [ R1[1], R0[1], R1[3], R0[3] ]
    // T1[0] = [ R3[0], R2[0], R3[2], R2[2] ]
    // T1[1] = [ R3[1], R2[1], R3[3], R2[3] ]
    var T0: [2]neon.f32x4 = undefined;
    var T1: [2]neon.f32x4 = undefined;

    if (direction == .CW) {
        T0 = neon.vtrnq_f32(R1, R0);
        T1 = neon.vtrnq_f32(R3, R2);
    } else {
        T0 = neon.vtrnq_f32(R0, R1);
        T1 = neon.vtrnq_f32(R2, R3);
    }

    // Step 3: Combine 64-bit Halves to Complete Full 4x4 Transposition
    // Stitches lower 64 bits (vget_low_f32) and upper 64 bits (vget_high_f32)
    // using vcombine_f32 into complete transposed 4-element rows TT0..TT3.
    const TT0 = neon.vcombine_f32(neon.vget_low_f32(T0[0]), neon.vget_low_f32(T1[0]));
    const TT1 = neon.vcombine_f32(neon.vget_low_f32(T0[1]), neon.vget_low_f32(T1[1]));
    const TT2 = neon.vcombine_f32(neon.vget_high_f32(T0[0]), neon.vget_high_f32(T1[0]));
    const TT3 = neon.vcombine_f32(neon.vget_high_f32(T0[1]), neon.vget_high_f32(T1[1]));

    var rotated0: neon.f32x4 = undefined;
    var rotated1: neon.f32x4 = undefined;
    var rotated2: neon.f32x4 = undefined;
    var rotated3: neon.f32x4 = undefined;

    // Step 4: Permute / Reverse Vector Halves for Final Rotation
    if (direction == RotationDir.CW) {
        // Clockwise: Reflect columns by swapping high and low 64-bit vector halves
        rotated0 = neon.vcombine_f32(neon.vget_high_f32(TT3), neon.vget_low_f32(TT3));
        rotated1 = neon.vcombine_f32(neon.vget_high_f32(TT2), neon.vget_low_f32(TT2));
        rotated2 = neon.vcombine_f32(neon.vget_high_f32(TT1), neon.vget_low_f32(TT1));
        rotated3 = neon.vcombine_f32(neon.vget_high_f32(TT0), neon.vget_low_f32(TT0));
    } else {
        // Counter-Clockwise: Combine in inverse lane ordering
        rotated0 = neon.vcombine_f32(neon.vget_low_f32(TT0), neon.vget_high_f32(TT0));
        rotated1 = neon.vcombine_f32(neon.vget_low_f32(TT1), neon.vget_high_f32(TT1));
        rotated2 = neon.vcombine_f32(neon.vget_low_f32(TT2), neon.vget_high_f32(TT2));
        rotated3 = neon.vcombine_f32(neon.vget_low_f32(TT3), neon.vget_high_f32(TT3));
    }

    // Step 5: Store Rotated Rows into Destination Memory
    neon.vst1q_f32(output + 12, rotated0);
    neon.vst1q_f32(output + 8, rotated1);
    neon.vst1q_f32(output + 4, rotated2);
    neon.vst1q_f32(output, rotated3);
}

/// Inverts elements horizontally within each row of a 4x4 matrix.
///
/// ### NEON Inversion Technique:
/// 1. `vrev64q_f32` reverses 32-bit float pairs within each 64-bit half:
///    `[a, b, c, d] -> [b, a, d, c]`
/// 2. `vcombine_f32(high, low)` swaps the 64-bit halves:
///    `[b, a, d, c] -> [d, c, b, a]`
/// This reverses all 4 elements of the row in only 2 vector operations!
fn horizontal_flip4x4(
    input: [*]const f32,
    output: [*]f32,
) void {
    // Load rows
    const R0 = neon.vld1q_f32(input);
    const R1 = neon.vld1q_f32(input + 4);
    const R2 = neon.vld1q_f32(input + 8);
    const R3 = neon.vld1q_f32(input + 12);

    // Step 1: Reverse 32-bit floats within 64-bit lanes: [0, 1, 2, 3] -> [1, 0, 3, 2]
    const flipped0 = neon.vrev64q_f32(R0);
    const flipped1 = neon.vrev64q_f32(R1);
    const flipped2 = neon.vrev64q_f32(R2);
    const flipped3 = neon.vrev64q_f32(R3);

    // Step 2: Swap the upper and lower 64-bit halves: [1, 0, 3, 2] -> [3, 2, 1, 0]
    const final0 = neon.vcombine_f32(neon.vget_high_f32(flipped0), neon.vget_low_f32(flipped0));
    const final1 = neon.vcombine_f32(neon.vget_high_f32(flipped1), neon.vget_low_f32(flipped1));
    const final2 = neon.vcombine_f32(neon.vget_high_f32(flipped2), neon.vget_low_f32(flipped2));
    const final3 = neon.vcombine_f32(neon.vget_high_f32(flipped3), neon.vget_low_f32(flipped3));

    // Store the fully reversed rows into output memory
    neon.vst1q_f32(output + 12, final0);
    neon.vst1q_f32(output + 8, final1);
    neon.vst1q_f32(output + 4, final2);
    neon.vst1q_f32(output, final3);
}

test matrot4x4 {
    const a: [16]f32 = .{
        1,  2,  3,  4,
        5,  6,  7,  8,
        9,  10, 11, 12,
        13, 14, 15, 16,
    };

    var result: [16]f32 = undefined;
    {
        const expected: [16]f32 = .{
            13, 9,  5, 1,
            14, 10, 6, 2,
            15, 11, 7, 3,
            16, 12, 8, 4,
        };
        matrot4x4(a[0..].ptr, &result, 1, .CW);

        try std.testing.expectEqual(expected, result);

        matrot4x4(a[0..].ptr, &result, 3, .CCW);

        try std.testing.expectEqual(expected, result);
    }
    {
        const expected: [16]f32 = .{
            16, 15, 14, 13,
            12, 11, 10, 9,
            8,  7,  6,  5,
            4,  3,  2,  1,
        };
        matrot4x4(a[0..].ptr, &result, 2, .CW);

        try std.testing.expectEqual(expected, result);

        matrot4x4(a[0..].ptr, &result, 2, .CCW);

        try std.testing.expectEqual(expected, result);
    }
    {
        const expected: [16]f32 = .{
            4, 8, 12, 16,
            3, 7, 11, 15,
            2, 6, 10, 14,
            1, 5, 9,  13,
        };
        matrot4x4(a[0..].ptr, &result, 3, .CW);

        try std.testing.expectEqual(expected, result);

        matrot4x4(a[0..].ptr, &result, 1, .CCW);

        try std.testing.expectEqual(expected, result);
    }
}

pub fn main() void {
    std.debug.print("Matrix Rotate:\n", .{});
    const a: [16]f32 = .{
        1.0,  2.0,  3.0,  4.0,
        5.0,  6.0,  7.0,  8.0,
        9.0,  10.0, 11.0, 12.0,
        13.0, 14.0, 15.0, 16.0,
    };

    var result: [16]f32 = undefined;

    matrot4x4(a[0..].ptr, &result, 1, .CW);

    printMatrix(result[0..].ptr, 4, 4);
}
