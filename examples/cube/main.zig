//! # 3D Spinning Cube with SIMD Vector Transformations & Z-Buffering (ARM NEON)
//!
//! A real-time 30 FPS terminal visualizer that renders a spinning 3D cube with
//! directional lighting, depth-buffering (Z-buffer), and TrueColor face shading.
//!
//! ### Technique & Vectorization:
//! - **4-Way SIMD Coordinate Transformation**:
//!   Processes 4 surface points simultaneously. Coordinates $(X, Y, Z)$ are packed across
//!   three 128-bit NEON registers (`f32x4`).
//! - **Fused Multiply-Accumulate (FMA)**:
//!   Applies the 3D rotation matrix $R = R_z(\gamma) \cdot R_y(\beta) \cdot R_x(\alpha)$
//!   using `vfmaq_f32` (Vector Fused Multiply-Accumulate). 4 points (12 spatial coordinates)
//!   are fully rotated in only 9 vector instructions without precision loss.
//! - **Vectorized Perspective Projection**:
//!   Divides 4 camera-space depths simultaneously with `vdivq_f32` and scales coordinates
//!   into 2D terminal screen space via `vfmaq_f32` and `vsubq_f32`.
//! - **Lambertian Diffuse Lighting**:
//!   Rotates face normals to compute $\max(0, \vec{N} \cdot \vec{L})$ for realistic surface shading.
//! - **Z-Buffer Hidden Surface Removal**:
//!   Maintains an in-memory depth buffer to resolve face occlusions as the cube tumbles.
//! - **Tear-Free Terminal Double-Buffering**:
//!   Renders frames into an in-memory buffer before flushing to stdout atomically at 30 FPS.

const std = @import("std");
const neon = @import("zeon");

const WIDTH: usize = 80;
const HEIGHT: usize = 40;
const LANES: usize = 4;

const FPS: u64 = 30;
const FRAME_NS: u64 = std.time.ns_per_s / FPS;
const DURATION_SECONDS: f32 = 18.0;

// Cube dimensions and perspective scaling
const CUBE_SIZE: f32 = 1.0;
const CUBE_STEP: f32 = 0.05; // Density of surface point sampling
const CAMERA_DIST: f32 = 3.5;
const CENTER_X: f32 = @as(f32, @floatFromInt(WIDTH)) / 2.0;
const CENTER_Y: f32 = @as(f32, @floatFromInt(HEIGHT)) / 2.0;
// Character aspect ratio in terminal: font is ~2x taller than wide
const SCALE_X: f32 = 42.0;
const SCALE_Y: f32 = 22.0;

/// 24-bit RGB color.
const Color = struct {
    r: u8,
    g: u8,
    b: u8,

    /// Scales the RGB color by diffuse lighting factor `light` in range [0.0, 1.0].
    pub fn lit(self: Color, light: f32) Color {
        // High ambient floor (0.60) ensures unlit faces stay vibrant and easily readable
        const factor = @max(0.60, @min(1.0, light));
        return .{
            .r = @intFromFloat(@as(f32, @floatFromInt(self.r)) * factor),
            .g = @intFromFloat(@as(f32, @floatFromInt(self.g)) * factor),
            .b = @intFromFloat(@as(f32, @floatFromInt(self.b)) * factor),
        };
    }
};

/// 6 cube face definitions with distinct characters, base colors, and normal vectors.
const Face = struct {
    char: u8,
    color: Color,
    normal: [3]f32,
};

const FACES = [6]Face{
    // Front face (+Z): Bright Electric Cyan
    .{ .char = '#', .color = .{ .r = 30, .g = 240, .b = 255 }, .normal = .{ 0.0, 0.0, 1.0 } },
    // Back face (-Z): Bright Sky Blue
    .{ .char = '$', .color = .{ .r = 80, .g = 160, .b = 255 }, .normal = .{ 0.0, 0.0, -1.0 } },
    // Right face (+X): Bright Lime Green
    .{ .char = '%', .color = .{ .r = 80, .g = 255, .b = 100 }, .normal = .{ 1.0, 0.0, 0.0 } },
    // Left face (-X): Bright Orange
    .{ .char = '@', .color = .{ .r = 255, .g = 160, .b = 40 }, .normal = .{ -1.0, 0.0, 0.0 } },
    // Top face (+Y): Bright Magenta / Pink
    .{ .char = '=', .color = .{ .r = 255, .g = 100, .b = 220 }, .normal = .{ 0.0, 1.0, 0.0 } },
    // Bottom face (-Y): Bright Electric Purple
    .{ .char = '+', .color = .{ .r = 200, .g = 120, .b = 255 }, .normal = .{ 0.0, -1.0, 0.0 } },
};

/// 3x3 single-precision rotation matrix.
pub const Mat3 = struct {
    m: [3][3]f32,

    /// Constructs a rotation matrix from Euler angles (A = pitch, B = yaw, C = roll)
    /// representing R = R_z(C) * R_y(B) * R_x(A).
    pub fn fromEuler(a: f32, b: f32, c: f32) Mat3 {
        const sin_a = @sin(a);
        const cos_a = @cos(a);
        const sin_b = @sin(b);
        const cos_b = @cos(b);
        const sin_c = @sin(c);
        const cos_c = @cos(c);

        return .{
            .m = .{
                .{
                    cos_b * cos_c,
                    sin_a * sin_b * cos_c - cos_a * sin_c,
                    cos_a * sin_b * cos_c + sin_a * sin_c,
                },
                .{
                    cos_b * sin_c,
                    sin_a * sin_b * sin_c + cos_a * cos_c,
                    cos_a * sin_b * sin_c - sin_a * cos_c,
                },
                .{
                    -sin_b,
                    sin_a * cos_b,
                    cos_a * cos_b,
                },
            },
        };
    }

    /// Transforms a single 3D vector by the rotation matrix: v_out = M * v_in.
    pub fn transform(self: Mat3, v: [3]f32) [3]f32 {
        return .{
            self.m[0][0] * v[0] + self.m[0][1] * v[1] + self.m[0][2] * v[2],
            self.m[1][0] * v[0] + self.m[1][1] * v[1] + self.m[1][2] * v[2],
            self.m[2][0] * v[0] + self.m[2][1] * v[1] + self.m[2][2] * v[2],
        };
    }
};

/// Appends a raw byte slice into the frame buffer.
fn push(bytes: []u8, at: *usize, s: []const u8) !void {
    if (at.* + s.len > bytes.len) return error.FrameBufferFull;
    @memcpy(bytes[at.* .. at.* + s.len], s);
    at.* += s.len;
}

/// Formats and appends a string into the frame buffer.
fn pushFmt(bytes: []u8, at: *usize, comptime fmt: []const u8, args: anytype) !void {
    const out = std.fmt.bufPrint(bytes[at.*..], fmt, args) catch return error.FrameBufferFull;
    at.* += out.len;
}

/// Transforms 4 3D points simultaneously using ARM NEON FMA instructions,
/// computes perspective projection, and writes valid pixels to the Z-buffer.
///
/// ### SIMD Transformation Math:
/// Given 4 points packed as vectors `vx = [x0, x1, x2, x3]`, `vy`, and `vz`:
/// 1. Rotation via Fused Multiply-Accumulate:
///    `rx = R[0][0]*vx + R[0][1]*vy + R[0][2]*vz`
///    `ry = R[1][0]*vx + R[1][1]*vy + R[1][2]*vz`
///    `rz = R[2][0]*vx + R[2][1]*vy + R[2][2]*vz`
///    Using `vfmaq_f32`, each row is computed in 3 cycles with single-rounding precision.
/// 2. Perspective Projection:
///    `z_cam = rz + CAMERA_DIST`
///    `inv_z = 1.0 / z_cam` (via `vdivq_f32`)
///    `xp = CENTER_X + rx * (inv_z * SCALE_X)` (via `vfmaq_f32`)
///    `yp = CENTER_Y - ry * (inv_z * SCALE_Y)` (via `vsubq_f32` & `vmulq_f32`)
pub fn projectAndRasterize4(
    px: [LANES]f32,
    py: [LANES]f32,
    pz: [LANES]f32,
    rot: Mat3,
    char: u8,
    color: Color,
    zbuffer: *[HEIGHT][WIDTH]f32,
    char_buffer: *[HEIGHT][WIDTH]u8,
    color_buffer: *[HEIGHT][WIDTH]Color,
) void {
    // Step 1: Load 4 points into NEON vector registers
    const vx = neon.vld1q_f32(&px);
    const vy = neon.vld1q_f32(&py);
    const vz = neon.vld1q_f32(&pz);

    // Broadcast rotation matrix coefficients into vector registers
    const r00 = neon.vmovq_n_f32(rot.m[0][0]);
    const r01 = neon.vmovq_n_f32(rot.m[0][1]);
    const r02 = neon.vmovq_n_f32(rot.m[0][2]);

    const r10 = neon.vmovq_n_f32(rot.m[1][0]);
    const r11 = neon.vmovq_n_f32(rot.m[1][1]);
    const r12 = neon.vmovq_n_f32(rot.m[1][2]);

    const r20 = neon.vmovq_n_f32(rot.m[2][0]);
    const r21 = neon.vmovq_n_f32(rot.m[2][1]);
    const r22 = neon.vmovq_n_f32(rot.m[2][2]);

    // Step 2: 3D vector rotation with Fused Multiply-Accumulate
    // Rotate X coordinates: rx = r00*vx + r01*vy + r02*vz
    var rx = neon.vmulq_f32(vx, r00);
    rx = neon.vfmaq_f32(rx, vy, r01);
    rx = neon.vfmaq_f32(rx, vz, r02);

    // Rotate Y coordinates: ry = r10*vx + r11*vy + r12*vz
    var ry = neon.vmulq_f32(vx, r10);
    ry = neon.vfmaq_f32(ry, vy, r11);
    ry = neon.vfmaq_f32(ry, vz, r12);

    // Rotate Z coordinates: rz = r20*vx + r21*vy + r22*vz
    var rz = neon.vmulq_f32(vx, r20);
    rz = neon.vfmaq_f32(rz, vy, r21);
    rz = neon.vfmaq_f32(rz, vz, r22);

    // Step 3: Vectorized perspective projection
    // Camera distance offset
    const z_cam = neon.vaddq_f32(rz, neon.vmovq_n_f32(CAMERA_DIST));
    // Depth reciprocal: inv_z = 1.0 / z_cam
    const inv_z = neon.vdivq_f32(neon.vmovq_n_f32(1.0), z_cam);

    // Screen X: xp = CENTER_X + rx * (inv_z * SCALE_X)
    const scale_x_vec = neon.vmulq_n_f32(inv_z, SCALE_X);
    const xp = neon.vfmaq_f32(neon.vmovq_n_f32(CENTER_X), rx, scale_x_vec);

    // Screen Y: yp = CENTER_Y - ry * (inv_z * SCALE_Y)
    const scale_y_vec = neon.vmulq_n_f32(inv_z, SCALE_Y);
    const yp = neon.vsubq_f32(neon.vmovq_n_f32(CENTER_Y), neon.vmulq_f32(ry, scale_y_vec));

    // Store projected vector registers back to arrays for rasterization
    var out_xp: [LANES]f32 = undefined;
    var out_yp: [LANES]f32 = undefined;
    var out_iz: [LANES]f32 = undefined;

    neon.vst1q_f32(&out_xp, xp);
    neon.vst1q_f32(&out_yp, yp);
    neon.vst1q_f32(&out_iz, inv_z);

    // Step 4: Z-buffer depth test and pixel scatter
    inline for (0..LANES) |lane| {
        const ix: isize = @intFromFloat(out_xp[lane]);
        const iy: isize = @intFromFloat(out_yp[lane]);

        if (ix >= 0 and ix < WIDTH and iy >= 0 and iy < HEIGHT) {
            const ux: usize = @intCast(ix);
            const uy: usize = @intCast(iy);
            const iz = out_iz[lane];

            // If this point is closer than the current depth at (ux, uy), update
            if (iz > zbuffer[uy][ux]) {
                zbuffer[uy][ux] = iz;
                char_buffer[uy][ux] = char;
                color_buffer[uy][ux] = color;
            }
        }
    }
}

pub fn main(init: std.process.Init) !void {
    // 128 KB frame buffer for flicker-free ANSI output
    var frame: [128 * 1024]u8 = undefined;

    // Setup terminal: alternate screen, clear display, hide cursor
    var setup_len: usize = 0;
    try push(&frame, &setup_len, "\x1b[?1049h\x1b[2J\x1b[H\x1b[?25l");
    try std.Io.File.stdout().writeStreamingAll(init.io, frame[0..setup_len]);

    // Restore terminal on exit
    defer {
        var restore: [64]u8 = undefined;
        const restore_text = std.fmt.bufPrint(
            &restore,
            "\x1b[0m\x1b[?25h\x1b[?1049l\n",
            .{},
        ) catch unreachable;
        std.Io.File.stdout().writeStreamingAll(init.io, restore_text) catch {};
    }

    // Directional light vector pointing from upper-front-right: [0.577, 0.577, 0.577]
    const light_dir = [3]f32{ 0.57735, 0.57735, 0.57735 };

    var angle_a: f32 = 0.0;
    var angle_b: f32 = 0.0;
    var angle_c: f32 = 0.0;

    var frames: u64 = 0;
    const total_frames: u64 = @intFromFloat(DURATION_SECONDS * @as(f32, @floatFromInt(FPS)));

    // Depth buffer, character grid, and color grid
    var zbuffer: [HEIGHT][WIDTH]f32 = undefined;
    var char_buffer: [HEIGHT][WIDTH]u8 = undefined;
    var color_buffer: [HEIGHT][WIDTH]Color = undefined;

    while (frames < total_frames) {
        const frame_start = std.Io.Timestamp.now(init.io, .awake);

        // Clear Z-buffer and screen character grid
        for (0..HEIGHT) |y| {
            @memset(&zbuffer[y], 0.0);
            @memset(&char_buffer[y], ' ');
            @memset(&color_buffer[y], .{ .r = 0, .g = 0, .b = 0 });
        }

        // Build 3x3 rotation matrix for current tumbling angles
        const rot = Mat3.fromEuler(angle_a, angle_b, angle_c);

        // Render 6 cube faces using SIMD point batches
        for (FACES, 0..) |face, face_idx| {
            // Compute rotated normal vector for lighting and backface culling
            const rot_norm = rot.transform(face.normal);

            // Lambertian diffuse lighting: dot product with light direction
            const n_dot_l = rot_norm[0] * light_dir[0] + rot_norm[1] * light_dir[1] + rot_norm[2] * light_dir[2];
            const lit_color = face.color.lit(n_dot_l);

            // Sample points along the face plane
            var u: f32 = -CUBE_SIZE;
            while (u <= CUBE_SIZE) : (u += CUBE_STEP) {
                var v: f32 = -CUBE_SIZE;
                while (v + CUBE_STEP * 4.0 <= CUBE_SIZE) : (v += CUBE_STEP * 4.0) {
                    var px: [LANES]f32 = undefined;
                    var py: [LANES]f32 = undefined;
                    var pz: [LANES]f32 = undefined;

                    // Map (u, v) parameter space to 3D cube face coordinates
                    for (0..LANES) |lane| {
                        const step_v = v + @as(f32, @floatFromInt(lane)) * CUBE_STEP;
                        switch (face_idx) {
                            0 => { // Front (+Z)
                                px[lane] = u;
                                py[lane] = step_v;
                                pz[lane] = CUBE_SIZE;
                            },
                            1 => { // Back (-Z)
                                px[lane] = u;
                                py[lane] = step_v;
                                pz[lane] = -CUBE_SIZE;
                            },
                            2 => { // Right (+X)
                                px[lane] = CUBE_SIZE;
                                py[lane] = u;
                                pz[lane] = step_v;
                            },
                            3 => { // Left (-X)
                                px[lane] = -CUBE_SIZE;
                                py[lane] = u;
                                pz[lane] = step_v;
                            },
                            4 => { // Top (+Y)
                                px[lane] = u;
                                py[lane] = CUBE_SIZE;
                                pz[lane] = step_v;
                            },
                            5 => { // Bottom (-Y)
                                px[lane] = u;
                                py[lane] = -CUBE_SIZE;
                                pz[lane] = step_v;
                            },
                            else => unreachable,
                        }
                    }

                    // Vectorized SIMD transform, perspective divide, and Z-buffer rasterization
                    projectAndRasterize4(
                        px,
                        py,
                        pz,
                        rot,
                        face.char,
                        lit_color,
                        &zbuffer,
                        &char_buffer,
                        &color_buffer,
                    );
                }
            }
        }

        // Build ANSI screen output
        var len: usize = 0;
        // Cursor home
        try push(&frame, &len, "\x1b[H");

        var current_color: ?Color = null;

        for (0..HEIGHT) |y| {
            for (0..WIDTH) |x| {
                const ch = char_buffer[y][x];
                if (ch == ' ') {
                    if (current_color != null) {
                        try push(&frame, &len, "\x1b[0m");
                        current_color = null;
                    }
                    try push(&frame, &len, " ");
                } else {
                    const col = color_buffer[y][x];
                    // Update ANSI 24-bit TrueColor foreground if color changed
                    if (current_color == null or
                        current_color.?.r != col.r or
                        current_color.?.g != col.g or
                        current_color.?.b != col.b)
                    {
                        try pushFmt(
                            &frame,
                            &len,
                            "\x1b[1;38;2;{d};{d};{d}m",
                            .{ col.r, col.g, col.b },
                        );
                        current_color = col;
                    }
                    const ch_slice = [1]u8{ch};
                    try push(&frame, &len, &ch_slice);
                }
            }
            try push(&frame, &len, "\x1b[0m\r\n");
            current_color = null;
        }

        // Frame header info
        try pushFmt(
            &frame,
            &len,
            "\x1bframe {d:0>5}   {d}x{d} @ {d} FPS\n",
            .{ frames, WIDTH, HEIGHT, FPS },
        );

        // Atomic stdout write
        try std.Io.File.stdout().writeStreamingAll(init.io, frame[0..len]);

        // Frame pacing (target 30 FPS)
        const frame_end = std.Io.Timestamp.now(init.io, .awake);
        const elapsed_ns = frame_start.durationTo(frame_end).toNanoseconds();
        if (elapsed_ns < FRAME_NS) {
            try init.io.sleep(.fromNanoseconds(FRAME_NS - elapsed_ns), .awake);
        }

        // Rotate cube along all 3 axes at different rates
        angle_a += 0.05;
        angle_b += 0.035;
        angle_c += 0.02;
        frames += 1;
    }
}

// Unit Tests

test "Mat3 identity transform preserves coordinates" {
    const rot = Mat3.fromEuler(0.0, 0.0, 0.0);
    const p = [3]f32{ 1.0, 2.0, 3.0 };
    const res = rot.transform(p);

    try std.testing.expectApproxEqAbs(@as(f32, 1.0), res[0], 0.0001);
    try std.testing.expectApproxEqAbs(@as(f32, 2.0), res[1], 0.0001);
    try std.testing.expectApproxEqAbs(@as(f32, 3.0), res[2], 0.0001);
}

test "Mat3 rotation around Z axis by 90 degrees rotates X to Y" {
    const pi_over_2 = std.math.pi / 2.0;
    const rot = Mat3.fromEuler(0.0, 0.0, pi_over_2);
    const p = [3]f32{ 1.0, 0.0, 0.0 };
    const res = rot.transform(p);

    try std.testing.expectApproxEqAbs(@as(f32, 0.0), res[0], 0.0001);
    try std.testing.expectApproxEqAbs(@as(f32, 1.0), res[1], 0.0001);
    try std.testing.expectApproxEqAbs(@as(f32, 0.0), res[2], 0.0001);
}

test "SIMD projectAndRasterize4 projects center point to screen center" {
    var zbuffer: [HEIGHT][WIDTH]f32 = undefined;
    var char_buffer: [HEIGHT][WIDTH]u8 = undefined;
    var color_buffer: [HEIGHT][WIDTH]Color = undefined;

    for (0..HEIGHT) |y| {
        @memset(&zbuffer[y], 0.0);
        @memset(&char_buffer[y], ' ');
        @memset(&color_buffer[y], .{ .r = 0, .g = 0, .b = 0 });
    }

    const rot = Mat3.fromEuler(0.0, 0.0, 0.0);
    const px = [4]f32{ 0.0, 0.0, 0.0, 0.0 };
    const py = [4]f32{ 0.0, 0.0, 0.0, 0.0 };
    const pz = [4]f32{ 0.0, 0.0, 0.0, 0.0 };

    projectAndRasterize4(
        px,
        py,
        pz,
        rot,
        '#',
        .{ .r = 255, .g = 255, .b = 255 },
        &zbuffer,
        &char_buffer,
        &color_buffer,
    );

    const mid_x: usize = @intFromFloat(CENTER_X);
    const mid_y: usize = @intFromFloat(CENTER_Y);

    try std.testing.expectEqual(@as(u8, '#'), char_buffer[mid_y][mid_x]);
    try std.testing.expect(zbuffer[mid_y][mid_x] > 0.0);
}

test "SIMD projectAndRasterize4 occludes further points" {
    var zbuffer: [HEIGHT][WIDTH]f32 = undefined;
    var char_buffer: [HEIGHT][WIDTH]u8 = undefined;
    var color_buffer: [HEIGHT][WIDTH]Color = undefined;

    for (0..HEIGHT) |y| {
        @memset(&zbuffer[y], 0.0);
        @memset(&char_buffer[y], ' ');
        @memset(&color_buffer[y], .{ .r = 0, .g = 0, .b = 0 });
    }

    const rot = Mat3.fromEuler(0.0, 0.0, 0.0);

    // Further point: pz = 1.0 (z_cam = 4.5, inv_z = 0.222)
    projectAndRasterize4(
        [4]f32{ 0.0, 0.0, 0.0, 0.0 },
        [4]f32{ 0.0, 0.0, 0.0, 0.0 },
        [4]f32{ 1.0, 1.0, 1.0, 1.0 },
        rot,
        'F',
        .{ .r = 100, .g = 100, .b = 100 },
        &zbuffer,
        &char_buffer,
        &color_buffer,
    );

    const mid_x: usize = @intFromFloat(CENTER_X);
    const mid_y: usize = @intFromFloat(CENTER_Y);
    try std.testing.expectEqual(@as(u8, 'F'), char_buffer[mid_y][mid_x]);

    // Closer point: pz = -1.0 (z_cam = 2.5, inv_z = 0.4)
    projectAndRasterize4(
        [4]f32{ 0.0, 0.0, 0.0, 0.0 },
        [4]f32{ 0.0, 0.0, 0.0, 0.0 },
        [4]f32{ -1.0, -1.0, -1.0, -1.0 },
        rot,
        'C',
        .{ .r = 255, .g = 255, .b = 255 },
        &zbuffer,
        &char_buffer,
        &color_buffer,
    );

    // Closer point must overwrite further point in Z-buffer
    try std.testing.expectEqual(@as(u8, 'C'), char_buffer[mid_y][mid_x]);
}
