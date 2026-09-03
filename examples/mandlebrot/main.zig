//! # Mandelbrot Set Renderer (ARM NEON)
//!
//! Renders an ASCII visualization of the Mandelbrot fractal using 4-way SIMD parallelism.
//!
//! ### Technique:
//! - Computes complex iterations `z = z² + c` for 4 adjacent coordinate pixels simultaneously.
//! - Uses vector multiplications (`vmulq_f32`), additions (`vaddq_f32`), and subtractions (`vsubq_f32`).
//! - Tracks lane divergence using vector greater-than comparison (`vcgtq_f32`) against escape radius (4.0).
//! - Accumulates per-lane iteration counts without branch mispredictions using bitwise masks.
//! - Early-exits the iteration loop once all 4 lanes have escaped (`@reduce(.Or, mask) == 0`).

const std = @import("std");
const neon = @import("zeon");

const Vec4 = neon.f32x4;
const UVec4 = neon.u32x4;

const WIDTH = 80;
const HEIGHT = 40;
const MAX_ITER = 1000;

/// Evaluates escape-time iterations for 4 complex coordinates `cr_arr + ci*i` simultaneously.
/// Returns a vector of iteration counts (up to `max_iter`) for each lane.
///
/// ### Mathematical Formulation:
/// Given complex variable `Z = zr + i*zi` and constant coordinate `C = cr + i*ci`:
///   `Z_{n+1} = Z_n² + C`
/// Expanding into real and imaginary components:
///   `zr_{n+1} = zr² - zi² + cr`
///   `zi_{n+1} = 2 * zr * zi + ci`
///
/// A point is proven to escape to infinity if its squared magnitude exceeds 4.0:
///   `|Z|² = zr² + zi² > 4.0`
///
/// ### Branchless SIMD Tracking:
/// SIMD operates in lockstep on 4 lanes. If some lanes escape before others, we cannot
/// branch out individually without splitting the vector. Instead:
/// - `vcgtq_f32(4.0, mag2)` yields an active mask (`0xFFFFFFFF` if `|Z|² < 4.0`, else `0`).
/// - Masking with `1` (`mask & @as(UVec4, @splat(1))`) adds 1 to active lanes and 0 to escaped lanes.
/// - When `@reduce(.Or, mask) == 0`, all 4 lanes have escaped and we early-exit the loop.
fn mandelbrotIterations(
    cr_arr: *const [4]f32,
    ci: f32,
    max_iter: u32,
) UVec4 {
    // Load 4 real coordinates from cr_arr into a 128-bit vector register
    const cr: Vec4 = neon.vld1q_f32(cr_arr);
    // Broadcast imaginary coordinate ci across all 4 vector lanes
    const ci_vec: Vec4 = neon.vmovq_n_f32(ci);
    // Broadcast the escape radius threshold (4.0) across all 4 vector lanes
    const four: Vec4 = neon.vmovq_n_f32(4.0);

    // Initial value for Z_0 = 0 + 0i for each coordinate lane
    var zr: Vec4 = neon.vmovq_n_f32(0.0);
    var zi: Vec4 = neon.vmovq_n_f32(0.0);

    // Track completed iteration counts for each lane (initialized to 0)
    var iter_counts: UVec4 = @splat(0);
    const ones: UVec4 = @splat(1);

    for (0..max_iter) |_| {
        // Step 1: Compute zr² and zi²
        const zr2 = neon.vmulq_f32(zr, zr);
        const zi2 = neon.vmulq_f32(zi, zi);

        // Step 2: Calculate squared magnitude: |Z|² = zr² + zi²
        const mag2 = neon.vaddq_f32(zr2, zi2);

        // Step 3: Divergence Test (4.0 > |Z|²)
        // vcgtq_f32 returns 0xFFFFFFFF for lanes where 4.0 > mag2 (not escaped),
        // and 0x00000000 for lanes where mag2 >= 4.0 (escaped).
        const mask = neon.vcgtq_f32(four, mag2);

        // Step 4: Early Exit Check
        // If all bits in the mask across all 4 lanes are 0, every lane has escaped.
        if (@reduce(.Or, mask) == 0) {
            break;
        }

        // Step 5: Branchless Counter Update
        // Bitwise AND with 1 converts 0xFFFFFFFF into +1 and 0x00000000 into +0.
        // Lanes that have escaped stop incrementing their iteration count.
        iter_counts += mask & ones;

        // Step 6: Compute new imaginary component: zi = 2*zr*zi + ci
        const zr_zi = neon.vmulq_f32(zr, zi);
        const two_zr_zi = neon.vaddq_f32(zr_zi, zr_zi);
        zi = neon.vaddq_f32(two_zr_zi, ci_vec);

        // Step 7: Compute new real component: zr = zr² - zi² + cr
        const zr2_minus_zi2 = neon.vsubq_f32(zr2, zi2);
        zr = neon.vaddq_f32(zr2_minus_zi2, cr);
    }

    return iter_counts;
}

pub fn main(init: std.process.Init) !void {
    var buffer: [4096]u8 = undefined;

    var stdout_impl =
        std.Io.File.stdout().writer(
            init.io,
            &buffer,
        );

    const stdout = &stdout_impl.interface;

    // Mandelbrot coordinate scaling.
    const scale_r =
        3.5 / @as(f32, @floatFromInt(WIDTH));

    const scale_i =
        2.0 / @as(f32, @floatFromInt(HEIGHT));

    for (0..HEIGHT) |y| {
        const ci =
            @as(f32, @floatFromInt(y)) *
            scale_i -
            1.0;

        var x: usize = 0;

        while (x < WIDTH) : (x += 4) {
            // Four adjacent pixels.
            const cr_arr: [4]f32 = .{
                @as(f32, @floatFromInt(x)) *
                    scale_r -
                    2.5,

                @as(f32, @floatFromInt(x + 1)) *
                    scale_r -
                    2.5,

                @as(f32, @floatFromInt(x + 2)) *
                    scale_r -
                    2.5,

                @as(f32, @floatFromInt(x + 3)) *
                    scale_r -
                    2.5,
            };

            const iter_counts =
                mandelbrotIterations(
                    &cr_arr,
                    ci,
                    MAX_ITER,
                );

            // Render each SIMD lane.
            inline for (0..4) |i| {
                if (x + i < WIDTH) {
                    const count =
                        iter_counts[i];

                    if (count == MAX_ITER) {
                        try stdout.writeAll("#");
                    } else if (count > MAX_ITER / 2) {
                        try stdout.writeAll("*");
                    } else if (count > MAX_ITER / 4) {
                        try stdout.writeAll(".");
                    } else {
                        try stdout.writeAll(" ");
                    }
                }
            }
        }

        try stdout.writeAll("\n");
    }

    try stdout.flush();
}

test "mandelbrot vector computes four lanes" {
    const cr: [4]f32 = .{
        -2.0,
        -1.0,
        0.0,
        1.0,
    };

    const result =
        mandelbrotIterations(
            &cr,
            0.0,
            100,
        );

    // -2 + 0i escapes immediately.
    try std.testing.expect(result[0] < 100);

    // -1 + 0i is inside the set.
    try std.testing.expectEqual(
        @as(u32, 100),
        result[1],
    );

    // 0 + 0i is inside the set.
    try std.testing.expectEqual(
        @as(u32, 100),
        result[2],
    );

    // 1 + 0i eventually escapes.
    try std.testing.expect(result[3] < 100);
}

test "mandelbrot origin stays inside" {
    const cr: [4]f32 = .{
        0.0,
        0.0,
        0.0,
        0.0,
    };

    const result =
        mandelbrotIterations(
            &cr,
            0.0,
            1000,
        );

    inline for (0..4) |i| {
        try std.testing.expectEqual(
            @as(u32, 1000),
            result[i],
        );
    }
}

test "mandelbrot known exterior points escape" {
    const cr: [4]f32 = .{
        4.0,
        -4.0,
        3.0,
        -3.0,
    };

    const result =
        mandelbrotIterations(
            &cr,
            0.0,
            1000,
        );

    inline for (0..4) |i| {
        try std.testing.expectEqual(
            @as(u32, 1),
            result[i],
        );
    }
}

test "mandelbrot known interior points remain bounded" {
    const cr: [4]f32 = .{
        -1.0,
        -0.5,
        0.0,
        -0.125,
    };

    const result =
        mandelbrotIterations(
            &cr,
            0.0,
            1000,
        );

    inline for (0..4) |i| {
        try std.testing.expectEqual(
            @as(u32, 1000),
            result[i],
        );
    }
}

test "mandelbrot vector lanes are independent" {
    const cr: [4]f32 = .{
        0.0,
        2.0,
        0.0,
        2.0,
    };

    const result =
        mandelbrotIterations(
            &cr,
            0.0,
            100,
        );

    // Lanes 0 and 2 are identical.
    try std.testing.expectEqual(
        result[0],
        result[2],
    );

    // Lanes 1 and 3 are identical.
    try std.testing.expectEqual(
        result[1],
        result[3],
    );

    // Interior and exterior lanes must differ.
    try std.testing.expect(
        result[0] != result[1],
    );
}

test "mandelbrot identical lanes produce identical results" {
    const cr: [4]f32 = .{
        -0.75,
        -0.75,
        -0.75,
        -0.75,
    };

    const result =
        mandelbrotIterations(
            &cr,
            0.1,
            500,
        );

    inline for (1..4) |i| {
        try std.testing.expectEqual(
            result[0],
            result[i],
        );
    }
}

test "mandelbrot max iteration is respected" {
    const cr: [4]f32 = .{
        0.0,
        0.0,
        0.0,
        0.0,
    };

    const result =
        mandelbrotIterations(
            &cr,
            0.0,
            7,
        );

    inline for (0..4) |i| {
        try std.testing.expectEqual(
            @as(u32, 7),
            result[i],
        );
    }
}

test "mandelbrot escape happens consistently across max iterations" {
    const cr: [4]f32 = .{
        2.0,
        2.0,
        2.0,
        2.0,
    };

    const result_10 =
        mandelbrotIterations(
            &cr,
            0.0,
            10,
        );

    const result_100 =
        mandelbrotIterations(
            &cr,
            0.0,
            100,
        );

    inline for (0..4) |i| {
        // The point escapes immediately, so increasing MAX_ITER
        // shouldn't suddenly make it take many iterations.
        try std.testing.expect(
            result_10[i] < 10,
        );

        try std.testing.expect(
            result_100[i] < 100,
        );
    }
}

test "mandelbrot SIMD arithmetic uses four lanes" {
    const cr: [4]f32 = .{
        -2.5,
        -1.5,
        -0.5,
        0.5,
    };

    const result =
        mandelbrotIterations(
            &cr,
            0.25,
            250,
        );

    // Make sure the SIMD result produced a valid iteration count
    // for every lane.
    inline for (0..4) |i| {
        try std.testing.expect(
            result[i] <= 250,
        );
    }
}
