const std = @import("std");

const Example = struct {
    name: []const u8,
    path: []const u8,
};

const examples: []const Example = &.{
    .{
        .name = "matrix-multiply",
        .path = "matrixMultiply/main.zig",
    },
    .{
        .name = "matrix-rotate",
        .path = "matrixRotate/main.zig",
    },
    .{
        .name = "matrix-vertical-flip",
        .path = "matrixVerticalFlip/main.zig",
    },
    .{
        .name = "buffer-to-hex",
        .path = "bufferToHex/main.zig",
    },
};

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{ .preferred_optimize_mode = .ReleaseFast });

    const zeon_mod = b.addModule("zeon", .{
        .root_source_file = b.path("src/zeon.zig"),
        .target = target,
        .optimize = optimize,
    });

    const test_step = b.step("test", "Run all unit tests");
    const run_step = b.step("run", "Run all examples");

    // Main library unit tests
    const zeon_tests = b.addTest(.{
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/zeon.zig"),
            .target = target,
            .optimize = optimize,
        }),
    });
    const run_zeon_tests = b.addRunArtifact(zeon_tests);
    test_step.dependOn(&run_zeon_tests.step);

    // Examples
    for (examples) |ex| {
        const ex_mod = b.createModule(.{
            .root_source_file = b.path(b.fmt("examples/{s}", .{ex.path})),
            .target = target,
            .optimize = optimize,
        });
        ex_mod.addImport("zeon", zeon_mod);

        const ex_exe = b.addExecutable(.{
            .name = ex.name,
            .root_module = ex_mod,
        });
        b.installArtifact(ex_exe);

        const run_cmd = b.addRunArtifact(ex_exe);
        run_cmd.step.dependOn(b.getInstallStep());
        if (b.args) |args| {
            run_cmd.addArgs(args);
        }

        const run_single = b.step(b.fmt("run-{s}", .{ex.name}), b.fmt("Run the `{s}` example", .{ex.name}));
        run_single.dependOn(&run_cmd.step);
        run_step.dependOn(&run_cmd.step);

        const ex_test = b.addTest(.{
            .root_module = ex_mod,
        });
        const run_ex_test = b.addRunArtifact(ex_test);
        const test_single = b.step(b.fmt("test-{s}", .{ex.name}), b.fmt("Run tests for `{s}`", .{ex.name}));
        test_single.dependOn(&run_ex_test.step);
        test_step.dependOn(&run_ex_test.step);
    }
}
