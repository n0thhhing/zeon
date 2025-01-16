const std = @import("std");

const Import = struct {
    module: *std.Build.Module,
    name: []const u8,
};

const Example = struct {
    path: []const u8,
    name: []const u8,
};

const examples: []const Example = &.{
    .{
        .path = "matrixMultiply/main.zig",
        .name = "matrix-multiply",
    },
    .{
        .path = "matrixRotate/main.zig",
        .name = "matrix-rotate",
    },
    .{
        .path = "matrixVerticalFlip/main.zig",
        .name = "matrix-vertical-flip",
    },
};

const test_targets = [_]std.Target.Query{
    .{},
    .{
        .cpu_arch = .arm,
        .os_tag = .linux,
        .cpu_features_add = arm_target_features,
    },
    // TODO: When 0.14.0 officially releases, we need to cover armeb
    // .{
    //     .cpu_arch = .armeb,
    //     .os_tag = .linux,
    //     .cpu_features_add = arm_target_features,
    // },
    // TODO: Figure out how to test thumb/thumbeb
    // .{
    //     .cpu_arch = .thumb,
    //     .os_tag = .linux,
    //     .cpu_features_add = arm_target_features,
    // },
    // .{
    //     .cpu_arch = .thumbeb,
    //     .os_tag = .linux,
    //     .cpu_features_add = arm_target_features,
    // },
    .{
        .cpu_arch = .aarch64,
        .os_tag = .linux,
        .cpu_features_add = aarch64_target_features,
    },
    .{
        .cpu_arch = .aarch64_be,
        .os_tag = .linux,
        .cpu_features_add = aarch64_target_features,
    },
    // Not needed until we add x86 assembly fallbacks
    // .{
    //     .cpu_arch = .x86,
    //     .os_tag = .linux,
    // },
};

const arm_target_features = std.Target.arm.featureSet(&.{
    .neon,
    .aes,
    .sha2,
    .crc,
    .dotprod,
    .has_v7,
    .has_v8,
    .i8mm,
});

const aarch64_target_features = std.Target.aarch64.featureSet(&.{
    .neon,
    .aes,
    .rdm,
    .sha2,
    .sha3,
    .dotprod,
    .i8mm,
    .sm4,
    .crypto,
    .fullfp16,
    // Messes with emulation when not using qemu
    // .sve,
});

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{ .preferred_optimize_mode = .ReleaseFast });

    const path = "src/zeon.zig";
    const module = b.addModule("zeon", .{
        .root_source_file = b.path(path),
        .target = target,
        .optimize = optimize,
    });

    const target_filter = b.option(
        []const u8,
        "target-filter",
        "Specify a target filter, e.g., -Dtarget_filter=arm,aarch64",
    ) orelse "none";

    const run_step = b.step("run", "Run all examples");
    const test_step = b.step("test", "Run unit tests");

    addTest(
        b,
        module.root_source_file.?,
        &.{},
        optimize,
        &.{test_step},
        target_filter,
    );

    inline for (examples) |example| {
        addExample(
            b,
            example.name,
            example.path,
            target,
            optimize,
            module,
            run_step,
            test_step,
            target_filter,
        );
    }
}

fn addExample(
    b: *std.Build,
    comptime name: []const u8,
    comptime path: []const u8,
    target: std.Build.ResolvedTarget,
    optimize: std.builtin.OptimizeMode,
    module: *std.Build.Module,
    run_step: *std.Build.Step,
    test_step: *std.Build.Step,
    target_filter: []const u8,
) void {
    const example = b.addExecutable(.{
        .name = name,
        .root_source_file = b.path("./examples/" ++ path),
        .target = target,
        .optimize = optimize,
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

    addTest(
        b,
        b.path("examples/" ++ path),
        &.{.{ .name = "zeon", .module = module }},
        optimize,
        &.{ example_test_step, test_step },
        target_filter,
    );

    example_run_step.dependOn(&run_cmd.step);
    run_step.dependOn(&run_cmd.step);
}

fn addTest(
    b: *std.Build,
    path: std.Build.LazyPath,
    modules: []const Import,
    optimize: std.builtin.OptimizeMode,
    test_steps: []const *std.Build.Step,
    target_filter: []const u8,
) void {
    if (std.mem.eql(u8, target_filter, "none")) {
        for (test_targets) |t| {
            addUnitTest(b, path, modules, optimize, test_steps, t);
        }
    } else {
        var filters = std.mem.splitScalar(u8, target_filter, ',');
        while (filters.next()) |unprocessed_filter| {
            const filter = std.mem.trim(u8, unprocessed_filter, " ");
            const target_group = findTargetGroup(filter);

            if (target_group == null) {
                const fmt =
                    \\Invalid filter: {s}
                    \\Valid filters: native, arm, aarch64, and aarch64_be
                ;
                std.debug.print(fmt, .{filter});
                std.process.exit(1);
            }
            for (target_group.?) |t| {
                addUnitTest(b, path, modules, optimize, test_steps, t);
            }
        }
    }
}

fn findTargetGroup(
    filter: []const u8,
) ?[]const std.Target.Query {
    if (std.mem.eql(u8, filter, "native")) return &.{test_targets[0]};
    if (std.mem.eql(u8, filter, "arm")) return &.{test_targets[1]};
    if (std.mem.eql(u8, filter, "aarch64")) return &.{test_targets[2]};
    if (std.mem.eql(u8, filter, "aarch64_be")) return &.{test_targets[3]};
    return null;
}

fn addUnitTest(
    b: *std.Build,
    path: std.Build.LazyPath,
    modules: []const Import,
    optimize: std.builtin.OptimizeMode,
    test_steps: []const *std.Build.Step,
    target: std.Target.Query,
) void {
    const unit_tests = b.addTest(.{
        .root_source_file = path,
        .target = b.resolveTargetQuery(target),
        .optimize = optimize,
    });

    for (modules) |mod| {
        unit_tests.root_module.addImport(mod.name, mod.module);
    }

    const run_tests = b.addRunArtifact(unit_tests);
    for (test_steps) |step| {
        step.dependOn(&run_tests.step);
    }
}
