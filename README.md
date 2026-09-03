# Zeon

ARM/ARM64 Neon intrinsics implemented in pure zig as well as in assembly!

## Overview

Zeon aims to provide high-performance `Neon` intrinsics for `ARM` and `ARM64` architectures, implemented in both pure Zig and inline assembly. This project prioritizes portability, performance, and flexibility, ensuring compatibility across various environments.

## Status

🚧 This project is under active development (**2,806 / 2,735** intrinsics implemented, with 2,815+ unit tests passing). Contributions and feedback are welcome!

To view the remaining missing intrinsics, run `zig build fetch` or check [scripts/missing_intrinsics.txt](scripts/missing_intrinsics.txt).

## Target Coverage

Zeon builds and validates tests across multiple target configurations:

| Target Group | Architecture / OS | Features / Notes |
| :--- | :--- | :--- |
| `native` | Host Architecture | Native execution |
| `arm` | `arm-linux` | 32-bit ARM with `neon`, `aes`, `sha2`, `crypto` |
| `aarch64` | `aarch64-linux` | 64-bit ARM with `neon`, `aes`, `sha2`, `crypto` |
| `aarch64_be` | `aarch64_be-linux` | Big-Endian AArch64 |
| `personal-x86_64`| `x86_64-macos` | Cross-compilation validation |

## Roadmap

- [x] Refactor intrinsics into categorized modules under `src/intrinsics/` (`arithmetic`, `bitwise`, `compare`, `convert`, `crypto`, `load_store`, `permute`, `reduction`, `reinterpret`, `shift`).
- [x] Add support for Big Endian ARM/AArch64 (`aarch64_be`) and add automated tests for it.
- [ ] Complete remaining inline assembly/LLVM builtin implementations.
- [ ] Write thorough tests for all remaining functions to ensure correctness.
- [ ] Eliminate repetitive patterns to improve maintainability.
- [ ] Implement fallbacks for non-ARM architectures.
- [ ] Instruction Stripping (e.g., functions like `vget_lane_f64` should compile down to accessing the appropriate register without inserting redundant instructions).
- [ ] For Vector Load intrinsics, do not assume input length is the exact length of the output vector.
- [ ] Test against C/C++ reference implementations.
- [ ] Use fallback instead of assembly implementation when not in release.
- [ ] Improve testing harness and fuzzing.

## Notes

- Builtins take priority over assembly implementations.
- Zig optimizes inline assembly because instructions are inserted explicitly (e.g., instructions like `vld1*` requiring a separate add instruction if post-index is unavailable).
- When using `vld1*` on non-ARM architectures (or when `use_asm` and `use_builtins` are off), it assumes the underlying type fits the size of the vector.
- Some intrinsics do not use inline assembly because the pure Zig fallback is equal to or faster than assembly.

## Getting Started

### Requirements

- [Zig](https://ziglang.org/) (0.16+)
- `Python 3` (for API and intrinsic code generators)
- `QEMU user mode` (required to run tests and simulate non-native ARM/ARM64 environments)

### Usage

1. Clone the repository:
   ```bash
   git clone https://github.com/n0thhhing/zeon
   cd zeon
   ```

2. Run all tests across target groups:
   ```bash
   zig build test --summary all
   ```

   To force a clean rebuild before running tests:
   ```bash
   zig build test -Dclean --summary all
   ```

   Or run tests for a specific target group:
   ```bash
   zig build test-native
   zig build test-arm
   zig build test-aarch64
   zig build test-aarch64_be
   ```

3. Run examples:
   ```bash
   # Run a specific example
   zig build run-cube
   zig build run-wave
   zig build run-mandlebrot
   zig build run-matrix-multiply
   zig build run-matrix-rotate
   zig build run-matrix-vertical-flip
   zig build run-buffer-to-hex

   # Build all examples
   zig build examples
   ```

4. Fetch missing intrinsics:
   ```bash
   zig build fetch
   ```

5. Clean build artifacts:
   ```bash
   zig build clean
   ```

## Examples

Check out the [examples/](examples/) directory for real-world usage patterns:
- **`wave`**: Wave equation simulation using NEON vector operations.
- **`mandlebrot`**: Parallelized SIMD Mandelbrot set rendering.
- **`matrixMultiply`**: SIMD-accelerated matrix multiplication.
- **`matrixRotate`**: Fast 2D matrix rotation with NEON.
- **`matrixVerticalFlip`**: In-place SIMD row reversal.
- **`bufferToHex`**: Vectorized binary buffer to hexadecimal conversion.

## License

This project is licensed under the `MIT` License. See the [LICENSE](LICENSE) file for more information.

## Resources

- [Rust AArch64 Arch Reference](https://dev-doc.rust-lang.org/nightly/core/arch/aarch64/index.html): Useful for test cases and behavior reference.
- [Arm Intrinsics Documentation](https://developer.arm.com/architectures/instruction-sets/intrinsics/#q=): Official reference for ARM intrinsics and assembly instructions.
- [Compiler Explorer (Godbolt)](https://godbolt.org/z/7Ec6co4WG): Examining and debugging emitted assembly code.
- [LLVM Language Reference Manual](https://releases.llvm.org/10.0.0/docs/LangRef.html): Inline assembly reference.
