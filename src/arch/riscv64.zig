const std = @import("std");
const builtin = @import("builtin");
const cpu_arch = builtin.target.cpu.arch;
const features = builtin.cpu.features;

pub const is_riscv64 = cpu_arch == .riscv64;

/// Checks if the current CPU has the specified RISC-V features.
pub inline fn hasFeatures(comptime rv_features: []const std.Target.riscv.Feature) bool {
    if (!@inComptime()) @panic("Please move this into comptime");
    if (!is_riscv64) return false;
    inline for (rv_features) |f| {
        if (!std.Target.riscv.featureSetHas(features, f)) return false;
    }
    return true;
}

/// RISC-V Vector Extension (V) — enables RVV auto-vectorization.
pub const has_v = hasFeatures(&.{.v});
/// Zvbc — carryless multiply (vmul.vv, vclmul). Required for vmull_p64.
pub const has_zvbc = hasFeatures(&.{.zvbc});

test "riscv64 feature checks are consistent with the target" {
    const ok = comptime hasFeatures(&.{});
    if (is_riscv64) {
        try std.testing.expect(ok);
    } else {
        try std.testing.expect(!ok);
    }
}

test {
    std.testing.refAllDecls(@This());
}
