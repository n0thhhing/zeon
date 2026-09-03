//! # Matrix Vertical Flip 4x4 (ARM NEON)
//!
//! Demonstrates inverting the rows of a 4x4 matrix using vector load/store instructions.
//!
//! ### Technique:
//! - Loads 4 contiguous rows into four 128-bit vector registers (`vld1q_f32`).
//! - Stores the rows in inverted order (`vst1q_f32`) into the destination buffer.

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

/// Flips the rows of a 4x4 matrix vertically (row 0 <-> row 3, row 1 <-> row 2).
export fn vertical_flip4x4(
    input: [*]const f32,
    output: [*]f32,
) void {
    // Load all rows into NEON registers at once
    const R0 = neon.vld1q_f32(input); // Row 0
    const R1 = neon.vld1q_f32(input + 4); // Row 1
    const R2 = neon.vld1q_f32(input + 8); // Row 2
    const R3 = neon.vld1q_f32(input + 12); // Row 3

    // Store in reverse vertical row order
    neon.vst1q_f32(output, R3);
    neon.vst1q_f32(output + 4, R2);
    neon.vst1q_f32(output + 8, R1);
    neon.vst1q_f32(output + 12, R0);
}

test vertical_flip4x4 {
    const a: [16]f32 = .{
        1,  2,  3,  4,
        5,  6,  7,  8,
        9,  10, 11, 12,
        13, 14, 15, 16,
    };

    var result: [16]f32 = undefined;
    const expected: [16]f32 = .{
        13, 14, 15, 16,
        9,  10, 11, 12,
        5,  6,  7,  8,
        1,  2,  3,  4,
    };
    vertical_flip4x4(a[0..].ptr, &result);
    try std.testing.expectEqual(expected, result);
}

pub fn main() void {
    std.debug.print("Matrix Vertical Flip:\n", .{});
    const a: [16]f32 = .{
        1.0,  2.0,  3.0,  4.0,
        5.0,  6.0,  7.0,  8.0,
        9.0,  10.0, 11.0, 12.0,
        13.0, 14.0, 15.0, 16.0,
    };

    var result: [16]f32 = undefined;

    vertical_flip4x4(&a, &result);

    printMatrix(result[0..].ptr, 4, 4);
}
