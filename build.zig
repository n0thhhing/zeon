const std = @import("std");

// TODO: Figure out how to test armeb
const test_targets = [_]std.Target.Query{
    .{},
    std.Target.Query{
        .cpu_arch = .arm,
        .os_tag = .linux,
        .cpu_features_add = blk: {
            var enabled_features = std.Target.Cpu.Feature.Set.empty;
            enabled_features.addFeature(@intFromEnum(std.Target.arm.Feature.neon));
            enabled_features.addFeature(@intFromEnum(std.Target.arm.Feature.aes));
            enabled_features.addFeature(@intFromEnum(std.Target.arm.Feature.sha2));
            enabled_features.addFeature(@intFromEnum(std.Target.arm.Feature.crc));
            enabled_features.addFeature(@intFromEnum(std.Target.arm.Feature.dotprod));
            enabled_features.addFeature(@intFromEnum(std.Target.arm.Feature.has_v7));
            enabled_features.addFeature(@intFromEnum(std.Target.arm.Feature.has_v8));
            enabled_features.addFeature(@intFromEnum(std.Target.arm.Feature.i8mm));
            break :blk enabled_features;
        },
    },
    // std.Target.Query{
    //     .cpu_arch = .armeb,
    //     .os_tag = .linux,
    //     .cpu_features_add = blk: {
    //         var enabled_features = std.Target.Cpu.Feature.Set.empty;
    //         enabled_features.addFeature(@intFromEnum(std.Target.arm.Feature.neon));
    //         enabled_features.addFeature(@intFromEnum(std.Target.arm.Feature.aes));
    //         enabled_features.addFeature(@intFromEnum(std.Target.arm.Feature.sha2));
    //         enabled_features.addFeature(@intFromEnum(std.Target.arm.Feature.crc));
    //         enabled_features.addFeature(@intFromEnum(std.Target.arm.Feature.dotprod));
    //         enabled_features.addFeature(@intFromEnum(std.Target.arm.Feature.has_v7));
    //         enabled_features.addFeature(@intFromEnum(std.Target.arm.Feature.has_v8));
    //         enabled_features.addFeature(@intFromEnum(std.Target.arm.Feature.i8mm));
    //         break :blk enabled_features;
    //     },
    // },
    std.Target.Query{
        .cpu_arch = .arm,
        .os_tag = .linux,
        .cpu_features_sub = blk: {
            var disabled_features = std.Target.Cpu.Feature.Set.empty;
            disabled_features.addFeature(@intFromEnum(std.Target.arm.Feature.neon));
            disabled_features.addFeature(@intFromEnum(std.Target.arm.Feature.aes));
            disabled_features.addFeature(@intFromEnum(std.Target.arm.Feature.sha2));
            disabled_features.addFeature(@intFromEnum(std.Target.arm.Feature.crc));
            disabled_features.addFeature(@intFromEnum(std.Target.arm.Feature.dotprod));
            disabled_features.addFeature(@intFromEnum(std.Target.arm.Feature.has_v7));
            disabled_features.addFeature(@intFromEnum(std.Target.arm.Feature.has_v8));
            disabled_features.addFeature(@intFromEnum(std.Target.arm.Feature.i8mm));
            break :blk disabled_features;
        },
    },
    // std.Target.Query{
    //     .cpu_arch = .armeb,
    //     .os_tag = .linux,
    //     .cpu_features_sub = blk: {
    //         var disabled_features = std.Target.Cpu.Feature.Set.empty;
    //         disabled_features.addFeature(@intFromEnum(std.Target.arm.Feature.neon));
    //         disabled_features.addFeature(@intFromEnum(std.Target.arm.Feature.aes));
    //         disabled_features.addFeature(@intFromEnum(std.Target.arm.Feature.sha2));
    //         disabled_features.addFeature(@intFromEnum(std.Target.arm.Feature.crc));
    //         disabled_features.addFeature(@intFromEnum(std.Target.arm.Feature.dotprod));
    //         disabled_features.addFeature(@intFromEnum(std.Target.arm.Feature.has_v7));
    //         disabled_features.addFeature(@intFromEnum(std.Target.arm.Feature.has_v8));
    //         disabled_features.addFeature(@intFromEnum(std.Target.arm.Feature.i8mm));
    //         break :blk disabled_features;
    //     },
    // },
    std.Target.Query{
        .cpu_arch = .aarch64,
        .os_tag = .linux,
        .cpu_features_sub = blk: {
            var disabled_features = std.Target.Cpu.Feature.Set.empty;
            disabled_features.addFeature(@intFromEnum(std.Target.aarch64.Feature.neon));
            disabled_features.addFeature(@intFromEnum(std.Target.aarch64.Feature.aes));
            disabled_features.addFeature(@intFromEnum(std.Target.aarch64.Feature.rdm));
            disabled_features.addFeature(@intFromEnum(std.Target.aarch64.Feature.sha2));
            disabled_features.addFeature(@intFromEnum(std.Target.aarch64.Feature.sha3));
            disabled_features.addFeature(@intFromEnum(std.Target.aarch64.Feature.dotprod));
            disabled_features.addFeature(@intFromEnum(std.Target.aarch64.Feature.i8mm));
            disabled_features.addFeature(@intFromEnum(std.Target.aarch64.Feature.sm4));
            disabled_features.addFeature(@intFromEnum(std.Target.aarch64.Feature.crypto));
            disabled_features.addFeature(@intFromEnum(std.Target.aarch64.Feature.sve));
            break :blk disabled_features;
        },
    },
    std.Target.Query{
        .cpu_arch = .aarch64_be,
        .os_tag = .linux,
        .cpu_features_sub = blk: {
            var disabled_features = std.Target.Cpu.Feature.Set.empty;
            disabled_features.addFeature(@intFromEnum(std.Target.aarch64.Feature.neon));
            disabled_features.addFeature(@intFromEnum(std.Target.aarch64.Feature.aes));
            disabled_features.addFeature(@intFromEnum(std.Target.aarch64.Feature.rdm));
            disabled_features.addFeature(@intFromEnum(std.Target.aarch64.Feature.sha2));
            disabled_features.addFeature(@intFromEnum(std.Target.aarch64.Feature.sha3));
            disabled_features.addFeature(@intFromEnum(std.Target.aarch64.Feature.dotprod));
            disabled_features.addFeature(@intFromEnum(std.Target.aarch64.Feature.i8mm));
            disabled_features.addFeature(@intFromEnum(std.Target.aarch64.Feature.sm4));
            disabled_features.addFeature(@intFromEnum(std.Target.aarch64.Feature.crypto));
            disabled_features.addFeature(@intFromEnum(std.Target.aarch64.Feature.sve));
            break :blk disabled_features;
        },
    },
    std.Target.Query{
        .cpu_arch = .aarch64_be,
        .os_tag = .linux,
        .cpu_features_add = blk: {
            var enabled_features = std.Target.Cpu.Feature.Set.empty;
            enabled_features.addFeature(@intFromEnum(std.Target.aarch64.Feature.neon));
            enabled_features.addFeature(@intFromEnum(std.Target.aarch64.Feature.aes));
            enabled_features.addFeature(@intFromEnum(std.Target.aarch64.Feature.rdm));
            enabled_features.addFeature(@intFromEnum(std.Target.aarch64.Feature.sha2));
            enabled_features.addFeature(@intFromEnum(std.Target.aarch64.Feature.sha3));
            enabled_features.addFeature(@intFromEnum(std.Target.aarch64.Feature.dotprod));
            enabled_features.addFeature(@intFromEnum(std.Target.aarch64.Feature.i8mm));
            enabled_features.addFeature(@intFromEnum(std.Target.aarch64.Feature.sm4));
            enabled_features.addFeature(@intFromEnum(std.Target.aarch64.Feature.crypto));
            enabled_features.addFeature(@intFromEnum(std.Target.aarch64.Feature.sve));
            break :blk enabled_features;
        },
    },
    std.Target.Query{
        .cpu_arch = .aarch64,
        .os_tag = .linux,
        .cpu_features_add = blk: {
            var enabled_features = std.Target.Cpu.Feature.Set.empty;
            enabled_features.addFeature(@intFromEnum(std.Target.aarch64.Feature.neon));
            enabled_features.addFeature(@intFromEnum(std.Target.aarch64.Feature.aes));
            enabled_features.addFeature(@intFromEnum(std.Target.aarch64.Feature.rdm));
            enabled_features.addFeature(@intFromEnum(std.Target.aarch64.Feature.sha2));
            enabled_features.addFeature(@intFromEnum(std.Target.aarch64.Feature.sha3));
            enabled_features.addFeature(@intFromEnum(std.Target.aarch64.Feature.dotprod));
            enabled_features.addFeature(@intFromEnum(std.Target.aarch64.Feature.i8mm));
            enabled_features.addFeature(@intFromEnum(std.Target.aarch64.Feature.sm4));
            enabled_features.addFeature(@intFromEnum(std.Target.aarch64.Feature.crypto));
            enabled_features.addFeature(@intFromEnum(std.Target.aarch64.Feature.sve));
            break :blk enabled_features;
        },
    },
    std.Target.Query{
        .cpu_arch = .x86,
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
    for (test_targets) |t| {
        const unit_tests = b.addTest(.{
            .root_source_file = mod.root_source_file.?,
            .target = b.resolveTargetQuery(t),
            .optimize = optimize,
        });

        const run_unit_tests = b.addRunArtifact(unit_tests);
        test_step.dependOn(&run_unit_tests.step);
    }
}
