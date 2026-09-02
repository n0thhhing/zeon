const std = @import("std");
const builtin = @import("builtin");
const cpu_arch = builtin.target.cpu.arch;
const features = builtin.cpu.features;

pub const is_x86_64 = cpu_arch == .x86_64;

/// Checks if the current CPU has the specified x86_64 features.
pub inline fn hasFeatures(comptime x86_features: []const std.Target.x86.Feature) bool {
    if (!@inComptime()) @panic("Please move this into comptime");
    if (!is_x86_64) return false;
    inline for (x86_features) |f| {
        if (!std.Target.x86.featureSetHas(features, f)) return false;
    }
    return true;
}

/// SSE2 baseline — guaranteed on all x86_64 targets.
pub const has_sse2 = hasFeatures(&.{.sse2});
/// SSE4.1 — needed for integer min/max across all types.
pub const has_sse41 = hasFeatures(&.{.sse4_1});
/// PCLMULQDQ — carryless multiplication for cryptography.
pub const has_pclmul = hasFeatures(&.{.pclmul});
/// AES-NI — hardware AES encryption/decryption acceleration.
pub const has_aes = hasFeatures(&.{.aes});
/// AVX2 — 256-bit integer SIMD.
pub const has_avx2 = hasFeatures(&.{.avx2});
/// AVX-512F — 512-bit foundation.
pub const has_avx512f = hasFeatures(&.{.avx512f});

test "x86_64 feature checks are consistent with the target" {
    const ok = comptime hasFeatures(&.{});
    if (is_x86_64) {
        try std.testing.expect(ok);
    } else {
        try std.testing.expect(!ok);
    }
}

test {
    std.testing.refAllDecls(@This());
}
