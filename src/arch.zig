/// arch.zig — compile-time architecture detection helpers for zeon
///
/// Use these to write multi-platform inline-asm dispatch:
///
///   if (arch.is_aarch64) return asm (...); // AArch64 NEON
///   if (arch.is_arm32)   return asm (...); // ARM32 NEON
///   if (arch.is_ppc64)   return asm (...); // PowerPC64 AltiVec/VSX
///   if (arch.is_la64)    return asm (...); // LoongArch64 LSX
///   // else: portable fallback (auto-vectorized to WebAssembly simd128, RVV, SSE, etc.)

const builtin = @import("builtin");
const cpu_arch = builtin.cpu.arch;

pub const aarch64 = @import("arch/aarch64.zig");
pub const arm = @import("arch/arm.zig");
pub const x86_64 = @import("arch/x86_64.zig");
pub const riscv64 = @import("arch/riscv64.zig");
pub const ppc64le = @import("arch/ppc64le.zig");
pub const la64 = @import("arch/la64.zig");
pub const wasm32 = @import("arch/wasm32.zig");
pub const wasm = wasm32;

pub const is_aarch64 = cpu_arch == .aarch64 or cpu_arch == .aarch64_be;
pub const is_arm32   = cpu_arch == .arm or cpu_arch == .armeb or cpu_arch == .thumb or cpu_arch == .thumbeb;
pub const is_arm     = is_arm32;
pub const is_x86_64  = cpu_arch == .x86_64;
pub const is_riscv64 = cpu_arch == .riscv64;
pub const is_ppc64le = cpu_arch == .powerpc64le;
pub const is_ppc64   = cpu_arch == .powerpc64 or cpu_arch == .powerpc64le;
pub const is_la64    = cpu_arch == .loongarch64;
pub const is_wasm32  = cpu_arch == .wasm32;
pub const is_wasm64  = cpu_arch == .wasm64;
pub const is_wasm    = is_wasm32 or is_wasm64;

/// True on any architecture with explicit NEON/SIMD inline asm in zeon.
pub const has_explicit_simd_asm = is_aarch64 or is_arm32 or is_ppc64 or is_la64;

test {
    _ = aarch64;
    _ = arm;
    _ = x86_64;
    _ = riscv64;
    _ = ppc64le;
    _ = la64;
    _ = wasm32;
}
