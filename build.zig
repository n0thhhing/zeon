const std = @import("std");
const builtin = @import("builtin");

const Example = struct {
    path: []const u8,
    name: []const u8,
};

const TargetGroup = struct {
    name: []const u8,
    queries: []const std.Target.Query,
};

const Options = struct {
    target: std.Build.ResolvedTarget,
    optimize: std.builtin.OptimizeMode,
    no_llvm: bool,
    emulator: ?[]const u8,
};

const examples: []const Example = &.{
    .{ .path = "matrixMultiply/main.zig", .name = "matrix-multiply" },
    .{ .path = "matrixRotate/main.zig", .name = "matrix-rotate" },
    .{ .path = "matrixVerticalFlip/main.zig", .name = "matrix-vertical-flip" },
    .{ .path = "bufferToHex/main.zig", .name = "buffer-to-hex" },
    .{ .path = "mandlebrot/main.zig", .name = "mandlebrot" },
};

const arm_target_features = std.Target.arm.featureSet(&.{
    .neon, .aes, .sha2, .crc, .dotprod, .has_v7, .has_v8, .i8mm,
});

const aarch64_target_features = std.Target.aarch64.featureSet(&.{
    .neon, .aes, .rdm, .sha2, .sha3, .dotprod, .i8mm, .sm4, .crypto, .fullfp16,
});

// TODO: Add support for armeb, thumb, thumbeb, and aarch64_32
const target_groups = [_]TargetGroup{
    .{
        .name = "native",
        .queries = &.{.{}},
    },
    .{
        .name = "arm",
        .queries = &.{.{
            .cpu_arch = .arm,
            .os_tag = .linux,
            .cpu_features_add = arm_target_features,
        }},
    },
    .{
        .name = "aarch64",
        .queries = &.{.{
            .cpu_arch = .aarch64,
            .os_tag = .linux,
            .cpu_features_add = aarch64_target_features,
        }},
    },
    .{
        .name = "aarch64_be",
        .queries = &.{.{
            .cpu_arch = .aarch64_be,
            .os_tag = .linux,
            .cpu_features_add = aarch64_target_features,
        }},
    },
    .{
        .name = "personal",
        .queries = &.{
            .{ .cpu_arch = .aarch64, .os_tag = .macos, .cpu_features_add = aarch64_target_features },
            .{ .cpu_arch = .x86_64, .os_tag = .macos },
        },
    },
};

pub fn build(b: *std.Build) void {
    const optimize = b.standardOptimizeOption(.{ .preferred_optimize_mode = .ReleaseFast });

    const no_llvm = b.option(bool, "no-llvm", "Disable LLVM") orelse false;
    const emulator = b.option([]const u8, "emulator", "Emulator command for cross-compiled tests (e.g., orb, qemu-aarch64)");

    const run_step = b.step("run", "Run all examples natively");
    const test_step = b.step("test", "Run unit tests for all target matrices");

    const native_target = b.standardTargetOptions(.{});
    const module = createZeonModule(b, .{
        .target = native_target,
        .optimize = optimize,
        .no_llvm = no_llvm,
        .emulator = emulator,
    });

    inline for (examples) |example| {
        addExample(b, example.name, example.path, module, run_step, test_step, .{
            .target = native_target,
            .optimize = optimize,
            .no_llvm = no_llvm,
            .emulator = null,
        });
    }

    for (target_groups) |t| {
        const group_test_step = b.step(b.fmt("test-{s}", .{t.name}), b.fmt("Run unit tests strictly for the {s} target group", .{t.name}));
        test_step.dependOn(group_test_step);

        for (t.queries) |query| {
            var opt: Options = .{
                .target = b.resolveTargetQuery(query),
                .optimize = optimize,
                .no_llvm = false,
                .emulator = emulator,
            };
            addUnitTest(b, b.path("src/zeon.zig"), false, group_test_step, opt);

            const arch = query.cpu_arch;
            if (arch != null and arch == .aarch64 and arch != .aarch64_be and arch != .arm and arch != .armeb and arch != .thumb) {
                opt.no_llvm = true;
                addUnitTest(b, b.path("src/zeon.zig"), false, group_test_step, opt);
            }
        }
    }
}

fn createZeonModule(b: *std.Build, options: Options) *std.Build.Module {
    const opts = b.addOptions();
    opts.addOption(bool, "use_llvm", !options.no_llvm);
    const m = b.addModule("zeon", .{
        .root_source_file = b.path("src/zeon.zig"),
        .target = options.target,
        .optimize = options.optimize,
    });
    m.addOptions("config", opts);
    return m;
}

fn addExample(
    b: *std.Build,
    comptime name: []const u8,
    comptime path: []const u8,
    module: *std.Build.Module,
    run_step: *std.Build.Step,
    test_step: *std.Build.Step,
    options: Options,
) void {
    const example = b.addExecutable(.{
        .name = name,
        .root_module = b.createModule(.{
            .root_source_file = b.path("examples/" ++ path),
            .target = options.target,
            .optimize = options.optimize,
        }),
    });

    b.installArtifact(example);
    example.root_module.addImport("zeon", module);

    const run_cmd = b.addRunArtifact(example);
    run_cmd.step.dependOn(b.getInstallStep());
    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    const example_run_step = b.step("run-" ++ name, "Run the `" ++ name ++ "` example");
    const example_test_step = b.step("test-" ++ name, "Run unit tests for " ++ name);

    run_step.dependOn(&run_cmd.step);
    example_run_step.dependOn(&run_cmd.step);

    addUnitTest(b, b.path("examples/" ++ path), true, example_test_step, options);
    test_step.dependOn(example_test_step);
}

fn addUnitTest(
    b: *std.Build,
    path: std.Build.LazyPath,
    is_example: bool,
    test_step: *std.Build.Step,
    options: Options,
) void {
    const opts = b.addOptions();
    opts.addOption(bool, "use_llvm", !options.no_llvm);

    const unit_tests = b.addTest(.{
        .root_module = b.createModule(.{
            .root_source_file = path,
            .target = options.target,
            .optimize = options.optimize,
        }),
    });
    unit_tests.root_module.addOptions("config", opts);

    if (is_example) {
        unit_tests.root_module.addImport("zeon", createZeonModule(b, options));
    }

    // Determine if we can run it natively without an emulator
    const is_native = builtin.os.tag == options.target.result.os.tag and builtin.cpu.arch == options.target.result.cpu.arch;
    const is_rosetta = builtin.os.tag == .macos and options.target.result.os.tag == .macos and options.target.result.cpu.arch == .x86_64;
    const can_run_natively = is_native or is_rosetta;

    var run_tests: *std.Build.Step.Run = undefined;

    if (can_run_natively) {
        run_tests = b.addRunArtifact(unit_tests);
    } else if (options.emulator) |emu| {
        run_tests = b.addSystemCommand(&.{emu});
        run_tests.addArtifactArg(unit_tests);
    } else {
        // Can't run it (cross-compiled without an emulator), just compile it to verify it builds
        test_step.dependOn(&unit_tests.step);
        return;
    }

    if (b.args) |args| {
        run_tests.addArgs(args);
    }

    test_step.dependOn(&run_tests.step);
}
