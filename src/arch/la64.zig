const std = @import("std");
const builtin = @import("builtin");
const cpu_arch = builtin.target.cpu.arch;
const features = builtin.cpu.features;

pub const is_la64 = cpu_arch == .loongarch64;

/// Checks if the current CPU has the specified LoongArch features.
pub inline fn hasFeatures(comptime la_features: []const std.Target.loongarch.Feature) bool {
    if (!@inComptime()) @panic("Please move this into comptime");
    if (!is_la64) return false;
    inline for (la_features) |f| {
        if (!std.Target.loongarch.featureSetHas(features, f)) return false;
    }
    return true;
}

/// LSX — LoongArch SIMD Extension (128-bit). Enables vsadd.b, vsll.b, vshuf.b, etc.
pub const has_lsx = hasFeatures(&.{.lsx});
/// LASX — LoongArch Advanced SIMD Extension (256-bit).
pub const has_lasx = hasFeatures(&.{.lasx});

test "la64 feature checks are consistent with the target" {
    const ok = comptime hasFeatures(&.{});
    if (is_la64) {
        try std.testing.expect(ok);
    } else {
        try std.testing.expect(!ok);
    }
}

test {
    std.testing.refAllDecls(@This());
}
