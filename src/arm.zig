const std = @import("std");
const builtin = @import("builtin");
const arch = builtin.target.cpu.arch;
const features = builtin.cpu.features;

pub const is_arm = arch == .arm or arch == .armeb;

/// Checks if the current CPU is arm and has the input features
pub inline fn hasFeatures(comptime arm_features: []const std.Target.arm.Feature) bool {
    if (!@inComptime()) @panic("Please move this into comptime, orelse it will result in an unnecessary branch");
    inline for (arm_features) |f| {
        const has_feature = is_arm and std.Target.arm.featureSetHas(features, f);
        if (!has_feature) return false;
    }
    return true;
}
