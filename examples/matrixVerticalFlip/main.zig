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

fn vertical_flip4x4(
    input: [*]const f32,
    output: [*]f32,
) void {
    // Load all rows into NEON registers at once
    const R0 = neon.vld1q_f32(input); // First row
    const R1 = neon.vld1q_f32(input + 4); // Second row
    const R2 = neon.vld1q_f32(input + 8); // Third row
    const R3 = neon.vld1q_f32(input + 12); // Fourth row

    // Store them in reverse order to output
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
    inline for (.{ .{ true, false }, .{ false, true }, .{ false, false } }) |opt| {
        neon.use_asm = opt[0];
        neon.use_builtins = opt[1];

        const expected: [16]f32 = .{
            13, 14, 15, 16,
            9,  10, 11, 12,
            5,  6,  7,  8,
            1,  2,  3,  4,
        };
        vertical_flip4x4(a[0..].ptr, &result);

        try std.testing.expectEqual(expected, result);
    }
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

    vertical_flip4x4(a[0..].ptr, &result);

    printMatrix(result[0..].ptr, 4, 4);
}
