
const std = @import("std");

const test_targets = [_]std.Target.Query{
    std.Target.Query{},
    std.Target.Query{
        .cpu_arch = .arm,
        .os_tag = .linux,
    },
    std.Target.Query{
        .cpu_arch = .arm,
        .os_tag = .linux,
        .cpu_features_sub = blk: {
            var disabled_features = std.Target.Cpu.Feature.Set.empty;
            disabled_features.addFeature(@intFromEnum(std.Target.arm.Feature.neon));
            break :blk disabled_features;
        }
    },
    std.Target.Query{
        .cpu_arch = .aarch64,
        .os_tag = .linux,
    },
    std.Target.Query{
        .cpu_arch = .x86_64,
        .os_tag = .linux,
    },
};

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{ .preferred_optimize_mode = .ReleaseFast });

    const mod = b.addModule("zig-neon", .{
        .root_source_file = b.path("src/zig-neon.zig"),
        .target = target,
        .optimize = optimize,
    });

    const test_step = b.step("test", "Run unit tests");
    for (test_targets) |_|{//t| {
        const unit_tests = b.addTest(.{
            .root_source_file = mod.root_source_file.?,
            .target = target,// b.resolveTargetQuery(t),
            .optimize = optimize,
        });

        const run_unit_tests = b.addRunArtifact(unit_tests);
        test_step.dependOn(&run_unit_tests.step);
    }
}
