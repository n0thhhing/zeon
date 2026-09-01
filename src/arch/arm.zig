const std = @import("std");
const builtin = @import("builtin");
const arch = builtin.target.cpu.arch;
const features = builtin.cpu.features;

pub const is_arm = arch == .arm or arch == .armeb or arch == .thumb or arch == .thumbeb;

/// Checks if the current CPU is ARM 32-bit and has the specified features
pub inline fn hasFeatures(comptime arm_features: []const std.Target.arm.Feature) bool {
    if (!@inComptime()) @panic("Please move this into comptime");
    if (!is_arm) return false;
    inline for (arm_features) |f| {
        if (!std.Target.arm.featureSetHas(features, f)) return false;
    }
    return true;
}

test {
    std.testing.refAllDecls(@This());
}