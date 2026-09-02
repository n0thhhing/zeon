const std = @import("std");
const builtin = @import("builtin");
const cpu_arch = builtin.target.cpu.arch;
const features = builtin.cpu.features;

pub const is_wasm32 = cpu_arch == .wasm32;
pub const is_wasm64 = cpu_arch == .wasm64;
pub const is_wasm = is_wasm32 or is_wasm64;

/// Checks if the current CPU has the specified WebAssembly features.
pub inline fn hasFeatures(comptime wasm_features: []const std.Target.wasm.Feature) bool {
    if (!@inComptime()) @panic("Please move this into comptime");
    if (!is_wasm) return false;
    inline for (wasm_features) |f| {
        if (!std.Target.wasm.featureSetHas(features, f)) return false;
    }
    return true;
}

/// WebAssembly 128-bit SIMD extension (i8x16, i16x8, i32x4, i64x2, f32x4, f64x2).
pub const has_simd128 = hasFeatures(&.{.simd128});
/// Relaxed SIMD extension for higher throughput.
pub const has_relaxed_simd = hasFeatures(&.{.relaxed_simd});
/// Bulk memory operations.
pub const has_bulk_memory = hasFeatures(&.{.bulk_memory});
/// Non-trapping float-to-int conversion.
pub const has_nontrapping_fptoint = hasFeatures(&.{.nontrapping_fptoint});

test "wasm feature checks are consistent with the target" {
    const ok = comptime hasFeatures(&.{});
    if (is_wasm) {
        try std.testing.expect(ok);
    } else {
        try std.testing.expect(!ok);
    }
}

test {
    std.testing.refAllDecls(@This());
}
