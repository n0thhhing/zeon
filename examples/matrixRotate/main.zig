const std = @import("std");
const neon = @import("zeon");

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
fn matrot4x4(
    input: [*]const f32,
    output: [*]f32,
    comptime n: usize,
    comptime dir: RotationDir,
) void {
    // Early optimization for special cases
    if (n % 2 == 0) {
        return horizontal_flip4x4(input, output);
    }

    const direction = if (n % 3 == 0) dir.flip() else dir;

    // Load the 4x4 block of the matrix
    const R0 = neon.vld1q_f32(input); // Row 0
    const R1 = neon.vld1q_f32(input + 4); // Row 1
    const R2 = neon.vld1q_f32(input + 8); // Row 2
    const R3 = neon.vld1q_f32(input + 12); // Row 3

    // Transpose the 4x4 matrix
    var T0: [2]neon.f32x4 = undefined;
    var T1: [2]neon.f32x4 = undefined;

    if (direction == .CW) {
        T0 = neon.vtrnq_f32(R1, R0);
        T1 = neon.vtrnq_f32(R3, R2);
    } else {
        T0 = neon.vtrnq_f32(R0, R1);
        T1 = neon.vtrnq_f32(R2, R3);
    }

    const TT0 = neon.vcombine_f32(neon.vget_low_f32(T0[0]), neon.vget_low_f32(T1[0])); // First row of transposed matrix
    const TT1 = neon.vcombine_f32(neon.vget_low_f32(T0[1]), neon.vget_low_f32(T1[1])); // Second row
    const TT2 = neon.vcombine_f32(neon.vget_high_f32(T0[0]), neon.vget_high_f32(T1[0])); // Third row
    const TT3 = neon.vcombine_f32(neon.vget_high_f32(T0[1]), neon.vget_high_f32(T1[1])); // Fourth row

    var rotated0: neon.f32x4 = undefined;
    var rotated1: neon.f32x4 = undefined;
    var rotated2: neon.f32x4 = undefined;
    var rotated3: neon.f32x4 = undefined;

    // Rotate the transposed matrix based on direction
    if (direction == RotationDir.CW) {
        // Clockwise rotation
        rotated0 = neon.vcombine_f32(neon.vget_high_f32(TT3), neon.vget_low_f32(TT3));
        rotated1 = neon.vcombine_f32(neon.vget_high_f32(TT2), neon.vget_low_f32(TT2));
        rotated2 = neon.vcombine_f32(neon.vget_high_f32(TT1), neon.vget_low_f32(TT1));
        rotated3 = neon.vcombine_f32(neon.vget_high_f32(TT0), neon.vget_low_f32(TT0));
    } else {
        // Counterclockwise rotation
        rotated0 = neon.vcombine_f32(neon.vget_low_f32(TT0), neon.vget_high_f32(TT0));
        rotated1 = neon.vcombine_f32(neon.vget_low_f32(TT1), neon.vget_high_f32(TT1));
        rotated2 = neon.vcombine_f32(neon.vget_low_f32(TT2), neon.vget_high_f32(TT2));
        rotated3 = neon.vcombine_f32(neon.vget_low_f32(TT3), neon.vget_high_f32(TT3));
    }

    // Store the rotated 4x4 matrix into the output
    neon.vst1q_f32(output + 12, rotated0);
    neon.vst1q_f32(output + 8, rotated1);
    neon.vst1q_f32(output + 4, rotated2);
    neon.vst1q_f32(output, rotated3);
}

fn horizontal_flip4x4(
    input: [*]const f32,
    output: [*]f32,
) void {
    // Load each row of the 4x4 matrix into NEON registers
    const R0 = neon.vld1q_f32(input); // Row 0
    const R1 = neon.vld1q_f32(input + 4); // Row 1
    const R2 = neon.vld1q_f32(input + 8); // Row 2
    const R3 = neon.vld1q_f32(input + 12); // Row 3

    // Reverse elements in each row using vrev64q
    const flipped0 = neon.vrev64q_f32(R0);
    const flipped1 = neon.vrev64q_f32(R1);
    const flipped2 = neon.vrev64q_f32(R2);
    const flipped3 = neon.vrev64q_f32(R3);

    // Swap the high and low halves of the vectors
    const final0 = neon.vcombine_f32(neon.vget_high_f32(flipped0), neon.vget_low_f32(flipped0));
    const final1 = neon.vcombine_f32(neon.vget_high_f32(flipped1), neon.vget_low_f32(flipped1));
    const final2 = neon.vcombine_f32(neon.vget_high_f32(flipped2), neon.vget_low_f32(flipped2));
    const final3 = neon.vcombine_f32(neon.vget_high_f32(flipped3), neon.vget_low_f32(flipped3));

    // Store the flipped rows into the output
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
