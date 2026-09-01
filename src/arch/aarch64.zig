const std = @import("std");
const builtin = @import("builtin");
const arch = builtin.target.cpu.arch;
const features = builtin.cpu.features;

pub const is_aarch64 = arch == .aarch64 or arch == .aarch64_be;

/// Checks if the current CPU is AArch64 and has the specified features
pub inline fn hasFeatures(comptime aarch64_features: []const std.Target.aarch64.Feature) bool {
    if (!@inComptime()) @panic("Please move this into comptime");
    if (!is_aarch64) return false;
    inline for (aarch64_features) |f| {
        if (!std.Target.aarch64.featureSetHas(features, f)) return false;
    }
    return true;
}

test "aarch64 feature checks are consistent with the target" {
    const ok = comptime hasFeatures(&.{});
    if (is_aarch64) {
        try std.testing.expect(ok);
    } else {
        try std.testing.expect(!ok);
    }
}

test {
    std.testing.refAllDecls(@This());
}