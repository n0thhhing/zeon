const std = @import("std");
const builtin = @import("builtin");

const Example = struct {
    path: []const u8,
    name: []const u8,
};

const TargetGroup = struct {
    name: []const u8,
    query: std.Target.Query,
};

const target_groups: []const TargetGroup = &.{
    .{
        .name = "native",
        .query = .{},
    },
    .{
        .name = "arm",
        .query = .{
            .cpu_arch = .arm,
            .os_tag = .linux,
            .cpu_features_add = std.Target.arm.featureSet(&.{
                .neon,
                .aes,
                .sha2,
                .crypto,
            }),
        },
    },
    .{
        .name = "aarch64",
        .query = .{
            .cpu_arch = .aarch64,
            .os_tag = .linux,
            .cpu_features_add = std.Target.aarch64.featureSet(&.{
                .neon,
                .aes,
                .sha2,
                .crypto,
            }),
        },
    },
    .{
        .name = "aarch64_be",
        .query = .{
            .cpu_arch = .aarch64_be,
            .os_tag = .linux,
            .cpu_features_add = std.Target.aarch64.featureSet(&.{
                .neon,
                .aes,
                .sha2,
                .crypto,
            }),
        },
    },
    .{
        .name = "personal",
        .query = std.Target.Query.parse(.{ .arch_os_abi = "aarch64-macos" }) catch unreachable,
    },
    .{
        .name = "personal-x86_64",
        .query = blk: {
            @setEvalBranchQuota(10000);
            break :blk std.Target.Query.parse(.{ .arch_os_abi = "x86_64-macos" }) catch unreachable;
        },
    },
};

const examples: []const Example = &.{
    .{ .path = "matrixMultiply/main.zig", .name = "matrix-multiply" },
    .{ .path = "matrixRotate/main.zig", .name = "matrix-rotate" },
    .{ .path = "matrixVerticalFlip/main.zig", .name = "matrix-vertical-flip" },
    .{ .path = "bufferToHex/main.zig", .name = "buffer-to-hex" },
    .{ .path = "mandlebrot/main.zig", .name = "mandlebrot" },
    .{ .path = "wave/main.zig", .name = "wave" },
    .{ .path = "cube/main.zig", .name = "cube" },
};

pub fn build(b: *std.Build) void {
    @setEvalBranchQuota(10000);

    const optimize = b.option(
        std.builtin.OptimizeMode,
        "optimize",
        "Optimization mode (defaults to ReleaseFast for SIMD performance)",
    ) orelse .ReleaseFast;

    const target_group = b.option(
        []const u8,
        "target-group",
        "Target group to build",
    ) orelse "native";

    const emulator = b.option(
        []const u8,
        "emulator",
        "Emulator used to run tests for non-native targets",
    );

    const force_clean = b.option(
        bool,
        "clean",
        "Force clean before building or running tests",
    ) orelse false;

    // Code generation step (runs python3 scripts/generate_api.py)
    const gen_step = b.step("gen", "Generate API surface (src/zeon.zig)");
    const gen_cmd = b.addSystemCommand(&.{ "python3", "scripts/generate_api.py" });
    gen_step.dependOn(&gen_cmd.step);

    // Fetch missing intrinsics step (runs python3 scripts/fetch_missing.py)
    const fetch_step = b.step("fetch", "Fetch and list missing ARM NEON intrinsics");
    const fetch_cmd = b.addSystemCommand(&.{ "python3", "scripts/fetch_missing.py" });
    fetch_step.dependOn(&fetch_cmd.step);

    // Clean step (purges entire .zig-cache and zig-out)
    const clean_step = b.step("clean", "Remove build artifacts and cache");
    const clean_cmd = b.addSystemCommand(&.{ "python3", "scripts/clean_cache.py", "--all" });
    clean_step.dependOn(&clean_cmd.step);

    if (force_clean) {
        const pre_clean_cmd = b.addSystemCommand(&.{ "python3", "scripts/clean_cache.py" });
        gen_cmd.step.dependOn(&pre_clean_cmd.step);
    }

    const selected_group = blk: {
        for (target_groups) |group| {
            if (std.mem.eql(u8, group.name, target_group)) {
                break :blk group;
            }
        }

        std.debug.panic(
            "unknown target group: {s}",
            .{target_group},
        );
    };

    const lib = b.addLibrary(.{
        .name = "zeon",
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/zeon.zig"),
            .target = b.resolveTargetQuery(selected_group.query),
            .optimize = optimize,
        }),
    });
    lib.step.dependOn(&gen_cmd.step);

    b.installArtifact(lib);

    const test_step = b.step("test", "Run tests");

    for (target_groups) |group| {
        if (builtin.os.tag == .macos and std.mem.eql(u8, group.name, "personal")) {
            continue;
        }
        addUnitTest(
            b,
            test_step,
            group.name,
            group.query,
            optimize,
            emulator,
            &gen_cmd.step,
        );
    }

    addExamples(b, selected_group.query, optimize, &gen_cmd.step);
}

fn addUnitTest(
    b: *std.Build,
    test_step: *std.Build.Step,
    group_name: []const u8,
    target_query: std.Target.Query,
    optimize: std.builtin.OptimizeMode,
    emulator: ?[]const u8,
    gen_step: *std.Build.Step,
) void {
    const target = b.resolveTargetQuery(target_query);

    // Workaround for upstream Zig 0.16.0 bug:
    // When compiling large SIMD modules on macOS with ReleaseFast/ReleaseSafe,
    // Zig's self-hosted Mach-O linker fails to parse the LLVM-generated object file,
    // falling back to TBD parsing and emitting: `failed to parse TBD file: NotLibStub`.
    // We fall back to Debug for macOS until this is resolved upstream.
    const is_macos = target.result.os.tag == .macos;
    const test_optimize = if (is_macos and optimize != .Debug) .Debug else optimize;

    const root_module = b.createModule(.{
        .root_source_file = b.path("src/zeon.zig"),
        .target = target,
        .optimize = test_optimize,
    });
    const unit_tests = b.addTest(.{
        .root_module = root_module,
    });
    unit_tests.step.dependOn(gen_step);

    const run_tests_name = b.fmt("test-{s}", .{group_name});
    const run_tests_step = b.step(
        run_tests_name,
        b.fmt("Run {s} tests", .{group_name}),
    );

    test_step.dependOn(run_tests_step);

    // On macOS, Zig 0.16.0 has an upstream self-hosted Mach-O linker bug on aarch64
    // when linking very large SIMD test suites (NotLibStub / AccessDenied).
    // On macOS Apple Silicon, x86_64-macos tests run natively via Rosetta with full fidelity.
    const is_macos_host = builtin.os.tag == .macos;
    const is_native =
        builtin.os.tag == target.result.os.tag and
        builtin.cpu.arch == target.result.cpu.arch;
    const is_aarch64_macos = is_macos_host and target.result.cpu.arch == .aarch64;
    if (is_native and !is_aarch64_macos and !is_macos_host) {
        const run = b.addRunArtifact(unit_tests);
        run_tests_step.dependOn(&run.step);
        return;
    }

    if (emulator) |emu| {
        const run = b.addSystemCommand(&.{emu});
        run.addArtifactArg(unit_tests);
        run_tests_step.dependOn(&run.step);
        return;
    }

    // Compile tests for non-native targets when no emulator is available.
    run_tests_step.dependOn(&unit_tests.step);
}

fn addExamples(
    b: *std.Build,
    query: std.Target.Query,
    optimize: std.builtin.OptimizeMode,
    gen_step: *std.Build.Step,
) void {
    const target = b.resolveTargetQuery(query);

    const examples_step = b.step(
        "examples",
        "Build all examples",
    );

    const example_opt = b.option(
        []const u8,
        "example",
        "Example to run with 'zig build run' (defaults to wave)",
    ) orelse "wave";

    const main_run_step = b.step("run", "Run an example (defaults to wave, or pass -Dexample=<name>)");
    const run_all_step = b.step("run-all", "Run all examples sequentially");

    var last_run_step: ?*std.Build.Step = null;

    for (examples) |example| {
        const example_path = b.pathJoin(&.{
            "examples",
            example.path,
        });

        const zeon_module = b.createModule(.{
            .root_source_file = b.path("src/zeon.zig"),
            .target = target,
            .optimize = optimize,
        });

        const exe = b.addExecutable(.{
            .name = example.name,
            .root_module = b.createModule(.{
                .root_source_file = b.path(example_path),
                .target = target,
                .optimize = optimize,
                .imports = &.{
                    .{
                        .name = "zeon",
                        .module = zeon_module,
                    },
                },
            }),
        });
        exe.step.dependOn(gen_step);

        b.installArtifact(exe);
        examples_step.dependOn(&exe.step);

        const run_step_name = b.fmt("run-{s}", .{example.name});
        const run_step = b.step(
            run_step_name,
            b.fmt("Run {s}", .{example.name}),
        );

        const run = b.addRunArtifact(exe);
        run_step.dependOn(&run.step);

        if (std.mem.eql(u8, example.name, example_opt)) {
            main_run_step.dependOn(&run.step);
        }

        const run_all_artifact = b.addRunArtifact(exe);
        if (last_run_step) |prev| {
            run_all_artifact.step.dependOn(prev);
        }
        last_run_step = &run_all_artifact.step;
        run_all_step.dependOn(&run_all_artifact.step);

        if (b.args) |args| {
            run.addArgs(args);
        }
    }
}
