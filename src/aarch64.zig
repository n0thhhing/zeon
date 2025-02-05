const std = @import("std");
const builtin = @import("builtin");
const arch = builtin.target.cpu.arch;
const features = builtin.cpu.features;
const neon = @import("./zeon.zig");

pub const is_aarch64 = arch == .aarch64 or arch == .aarch64_be;

/// Checks if the current CPU is aarch64 and has the input features
pub fn hasFeatures(comptime aarch64_features: []const std.Target.aarch64.Feature) bool {
    if (!@inComptime()) @panic("Please move this into comptime, orelse it will result in an unnecessary branch");
    inline for (aarch64_features) |f| {
        const has_feature = is_aarch64 and std.Target.aarch64.featureSetHas(features, f);
        if (!has_feature) return false;
    }
    return true;
}