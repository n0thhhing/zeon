# Zeon

ARM/ARM64 Neon intrinsics implemented in pure Zig with hardware acceleration and portable fallbacks!

## Overview

Zeon aims to provide high-performance `Neon` intrinsics for `ARM` and `ARM64` architectures, implemented with pure Zig SIMD primitives, LLVM builtins, and assembly optimizations where applicable. The library provides complete cross-architecture portability so NEON-style vector code can run on any architecture (x86_64, RISC-V, etc.) as well as in `comptime`.

## Project Structure

```
src/
├── root.zig / zeon.zig    # Main entry point, re-exporting all types and intrinsics
├── types.zig              # SIMD vector types, tuple structs, and C NEON aliases
├── common.zig             # Generic vector arithmetic, AES tables, GF(2^8) math
├── arch/
│   ├── arm.zig            # ARM 32-bit architecture & feature detection
│   └── aarch64.zig        # AArch64 architecture & feature detection
└── intrinsics/
    ├── load_store.zig     # vld1, vst1, vld2, vst2, vld3, vst3, vld4, vst4, lane/dup
    ├── arithmetic.zig     # vadd, vsub, vneg, vabs, vabd, vaba, vmul, vfma, vfms, vqadd, vqsub
    ├── bitwise.zig        # vand, vorr, veor, vbic, vmvn, vbsl, vbcax, vcnt, vclz
    ├── shift.zig          # vshl, vshr, vsra, vshrn, vqshl, vshlq_n, vshrq_n
    ├── compare.zig        # vceq, vcge, vcgt, vcle, vclt, vcage, vcagt, vmin, vmax
    ├── reduction.zig      # vaddv, vaddlv, vminv, vmaxv, vmaxnmv, vminnmv
    ├── convert.zig        # vmovl, vmovn, vcvt (float <-> int), vreinterpret
    ├── permute.zig        # vget_low, vget_high, vcombine, vget_lane, vdup, vzip, vtrn, vrev, vtbl
    └── crypto.zig         # vaese, vaesd, vaesmc, vaesimc, vmull_p8, vmull_p64
```

## Getting Started

### Requirements
- Zig `0.16.0` or later

### Installation and Usage

1. Add `zeon` to your `build.zig.zon` or clone the repository:
   ```bash
   git clone https://github.com/n0thhhing/zeon
   cd zeon
   ```

2. Run unit tests:
   ```bash
   zig build test --summary all
   ```

3. Run examples:
   ```bash
   zig build run
   ```

## Examples

Check the [examples](examples/) directory for complete usage demonstrations:
- **Matrix Multiply**: `zig build run-matrix-multiply`
- **Matrix Rotate**: `zig build run-matrix-rotate`
- **Matrix Vertical Flip**: `zig build run-matrix-vertical-flip`
- **Buffer to Hex**: `zig build run-buffer-to-hex`

## License

This project is licensed under the `MIT` License. See the [LICENSE](LICENSE) file for more information.
