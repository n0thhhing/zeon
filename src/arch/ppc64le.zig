const std = @import("std");
const builtin = @import("builtin");
const cpu_arch = builtin.target.cpu.arch;
const features = builtin.cpu.features;

pub const is_ppc64le = cpu_arch == .powerpc64le;
pub const is_ppc64 = cpu_arch == .powerpc64 or cpu_arch == .powerpc64le;

/// Checks if the current CPU has the specified PowerPC features.
pub inline fn hasFeatures(comptime ppc_features: []const std.Target.powerpc.Feature) bool {
    if (!@inComptime()) @panic("Please move this into comptime");
    if (!is_ppc64) return false;
    inline for (ppc_features) |f| {
        if (!std.Target.powerpc.featureSetHas(features, f)) return false;
    }
    return true;
}

/// AltiVec/VMX — 128-bit SIMD integer operations (vaddsbs, vsubsbs, etc.)
pub const has_altivec = hasFeatures(&.{.altivec});
/// VSX — scalar and vector floating-point operations (xvcvspsxws, etc.)
pub const has_vsx = hasFeatures(&.{.vsx});
/// Power9 — newer ISA with additional SIMD improvements.
pub const has_pwr9 = hasFeatures(&.{.isa_v30_instructions});

test "ppc64le feature checks are consistent with the target" {
    const ok = comptime hasFeatures(&.{});
    if (is_ppc64) {
        try std.testing.expect(ok);
    } else {
        try std.testing.expect(!ok);
    }
}

test {
    std.testing.refAllDecls(@This());
}
