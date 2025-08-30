const std = @import("std");

const Import = struct {
    module: *std.Build.Module,
    name: []const u8,
};

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
    target_filter: []const []const u8,
    no_llvm: bool,
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
    .{
        .path = "bufferToHex/main.zig",
        .name = "buffer-to-hex",
    },
};

// TODO: Add support for armeb, thumb, thumbeb, and aarch64_32
const target_groups = [_]TargetGroup{
    .{
        .name = "native",
        .queries = &.{
            .{},
        },
    },
    .{
        .name = "arm",
        .queries = &.{
            .{
                .cpu_arch = .arm,
                .os_tag = .linux,
                .cpu_features_add = arm_target_features,
            },
        },
    },
    // .{
    //     .name = "armeb",
    //     .queries = &.{
    //         .{
    //             .cpu_arch = .armeb,
    //             .os_tag = .linux,
    //             .cpu_features_add = arm_target_features,
    //         },
    //     },
    // },
    // .{
    //     .name = "thumb",
    //     .queries = &.{
    //         .{
    //             .cpu_arch = .thumb,
    //             .os_tag = .linux,
    //             .cpu_features_add = arm_target_features,
    //         },
    //     },
    // },
    // .{
    //     .name = "thumbeb",
    //     .queries = &.{
    //         .{
    //             .cpu_arch = .thumbeb,
    //             .os_tag = .linux,
    //             .cpu_features_add = arm_target_features,
    //         },
    //     },
    // },
    .{
        .name = "aarch64",
        .queries = &.{
            .{
                .cpu_arch = .aarch64,
                .os_tag = .linux,
                .cpu_features_add = aarch64_target_features,
            },
        },
    },
    .{
        .name = "aarch64_be",
        .queries = &.{
            .{
                .cpu_arch = .aarch64_be,
                .os_tag = .linux,
                .cpu_features_add = aarch64_target_features,
            },
        },
    },
    // .{
    //     .name = "aarch64_32",
    //     .queries = &.{
    //         .{
    //             .cpu_arch = .aarch64_32,
    //             .os_tag = .linux,
    //             .cpu_features_add = aarch64_target_features,
    //         },
    //     },
    // },
    .{
        .name = "personal",
        .queries = &.{ .{
            .cpu_arch = .aarch64,
            .os_tag = .macos,
            .cpu_features_add = aarch64_target_features,
        }, .{
            .cpu_arch = .x86_64,
            .os_tag = .macos,
        } },
    },
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

    const module = b.addModule("zeon", .{
        .root_source_file = b.path("src/zeon.zig"),
        .target = target,
        .optimize = optimize,
    });

    const target_filter = b.option(
        []const []const u8,
        "target-filter",
        "Specify target groups to build (comma-separated, e.g., -Dtarget-filter=arm,aarch64)",
    ) orelse &.{};
    const no_llvm = b.option(
        bool,
        "no-llvm",
        "Disable LLVM",
    ) orelse false;

    const run_step = b.step("run", "Run all examples");
    const test_step = b.step("test", "Run unit tests");
    const opts: Options = .{
        .no_llvm = no_llvm,
        .target = target,
        .optimize = optimize,
        .target_filter = target_filter,
    };

    addTest(b, module.root_source_file.?, &.{}, &.{test_step}, opts);

    inline for (examples) |example| {
        addExample(b, example.name, example.path, module, run_step, test_step, opts);
    }
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
    const example = b.addExecutable(.{ .name = name, .root_module = b.createModule(.{
        .root_source_file = b.path("./examples/" ++ path),
        .target = options.target,
        .optimize = options.optimize,
    }) });

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
        &.{ example_test_step, test_step },
        options,
    );

    run_step.dependOn(&run_cmd.step);
    example_run_step.dependOn(&run_cmd.step);
}

fn addTest(
    b: *std.Build,
    path: std.Build.LazyPath,
    modules: []const Import,
    test_steps: []const *std.Build.Step,
    options: Options,
) void {
    var target_groups_to_build: []const TargetGroup = &target_groups;
    var arena = std.heap.ArenaAllocator.init(b.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();
    // TODO: Add better error handling
    if (options.target_filter.len > 0) {
        var list: std.ArrayList(TargetGroup) = .empty;
        defer list.deinit(alloc);
        for (target_groups) |t| {
            for (options.target_filter) |group_name| {
                if (std.mem.eql(u8, t.name, group_name)) {
                    list.append(alloc, t) catch unreachable;
                    break;
                }
            }
        }
        target_groups_to_build = list.toOwnedSlice(alloc) catch unreachable;
    }

    for (target_groups_to_build) |t| {
        for (t.queries) |query| {
            var opt: Options = .{
                .no_llvm = false,
                .target = b.resolveTargetQuery(query),
                .optimize = options.optimize,
                .target_filter = options.target_filter,
            };
            addUnitTest(b, path, modules, test_steps, opt);
            const arch = query.cpu_arch;
            if (arch != null and arch == .aarch64 and arch != .aarch64_be and arch != .arm and arch != .armeb and arch != .thumb) {
                opt.no_llvm = true;
                addUnitTest(b, path, modules, test_steps, opt);
            }
        }
    }
}

fn patchZeon(b: *std.Build, use_llvm: bool) void {
    const cwd = std.fs.cwd();
    const zeon_path = "src/zeon.zig";

    var data = cwd.readFileAlloc(b.allocator, zeon_path, 1 << 20) catch unreachable;
    defer b.allocator.free(data);

    const needle = "const has_llvm_backend =";
    if (std.mem.indexOf(u8, data, needle)) |idx| {
        const before = data[0 .. idx - 1];
        const after_start = (std.mem.indexOfScalarPos(u8, data, idx, ';') orelse return) + 1;
        const after = data[after_start..];

        const replacement = if (use_llvm)
            "const has_llvm_backend = builtin.zig_backend != .stage2_llvm;"
        else
            "const has_llvm_backend = false;";

        const new_data = std.fmt.allocPrint(b.allocator, "{s}\n{s}{s}", .{ before, replacement, after }) catch unreachable;
        defer b.allocator.free(new_data);

        cwd.writeFile(.{ .sub_path = zeon_path, .data = new_data }) catch unreachable;
    }
}

fn addUnitTest(b: *std.Build, path: std.Build.LazyPath, modules: []const Import, test_steps: []const *std.Build.Step, options: Options) void {
    patchZeon(b, !options.no_llvm);

    const unit_tests = b.addTest(.{ .root_module = b.createModule(.{
        .root_source_file = path,
        .target = options.target,
        .optimize = options.optimize,
    }) });

    for (modules) |mod| {
        unit_tests.root_module.addImport(mod.name, mod.module);
    }

    const run_tests = b.addRunArtifact(unit_tests);
    for (test_steps) |step| {
        step.dependOn(&run_tests.step);
    }
    patchZeon(b, true);
}
