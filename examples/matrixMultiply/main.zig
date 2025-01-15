const std = @import("std");
const neon = @import("neon");

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

/// see https://developer.arm.com/documentation/102467/0201/Example---matrix-multiplication
fn matmul4x4(a: [*]const f32, b: [*]const f32, c: [*]f32) void {
    // these are the columns a
    const a0 = neon.vld1q_f32(a);
    const a1 = neon.vld1q_f32(a + 4);
    const a2 = neon.vld1q_f32(a + 8);
    const a3 = neon.vld1q_f32(a + 12);

    // these are the columns b
    const b0 = neon.vld1q_f32(b);
    const b1 = neon.vld1q_f32(b + 4);
    const b2 = neon.vld1q_f32(b + 8);
    const b3 = neon.vld1q_f32(b + 12);

    // these are the columns c
    var c0 = neon.vmovq_n_f32(0);
    var c1 = neon.vmovq_n_f32(0);
    var c2 = neon.vmovq_n_f32(0);
    var c3 = neon.vmovq_n_f32(0);

    // Multiply accumulate in 4x1 blocks
    c0 = neon.vfmaq_laneq_f32(c0, b0, a0, 0);
    c0 = neon.vfmaq_laneq_f32(c0, b1, a0, 1);
    c0 = neon.vfmaq_laneq_f32(c0, b2, a0, 2);
    c0 = neon.vfmaq_laneq_f32(c0, b3, a0, 3);
    neon.vst1q_f32(c, c0);

    c1 = neon.vfmaq_laneq_f32(c1, b0, a1, 0);
    c1 = neon.vfmaq_laneq_f32(c1, b1, a1, 1);
    c1 = neon.vfmaq_laneq_f32(c1, b2, a1, 2);
    c1 = neon.vfmaq_laneq_f32(c1, b3, a1, 3);
    neon.vst1q_f32(c + 4, c1);

    c2 = neon.vfmaq_laneq_f32(c2, b0, a2, 0);
    c2 = neon.vfmaq_laneq_f32(c2, b1, a2, 1);
    c2 = neon.vfmaq_laneq_f32(c2, b2, a2, 2);
    c2 = neon.vfmaq_laneq_f32(c2, b3, a2, 3);
    neon.vst1q_f32(c + 8, c2);

    c3 = neon.vfmaq_laneq_f32(c3, b0, a3, 0);
    c3 = neon.vfmaq_laneq_f32(c3, b1, a3, 1);
    c3 = neon.vfmaq_laneq_f32(c3, b2, a3, 2);
    c3 = neon.vfmaq_laneq_f32(c3, b3, a3, 3);
    neon.vst1q_f32(c + 12, c3);
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

    inline for (.{ .{ true, false }, .{ false, true }, .{ false, false } }) |opt| {
        neon.use_asm = opt[0];
        neon.use_builtins = opt[1];
        matmul4x4(a[0..].ptr, b[0..].ptr, &result);

        try std.testing.expectEqual(expected, result);
    }
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
