# Zig-Neon

ARM/ARM64 Neon intrinsics implemented in pure zig as well as in assembly!

## Overview

Zig-Neon aims to provide high-performance `Neon` intrinsics for `ARM` and `ARM64` architectures, implemented in both pure Zig and inline assembly. This project prioritizes portability, performance, and flexibility, ensuring compatibility across various environments.

## Status

🚧 This project is under active development(430/2983 implemented). Contributions and feedback are welcome!

## Roadmap

 - [ ] Complete inline assembly/LLVM builtin implementations.
 - [ ] Write thorough tests for all functions to ensure correctness.
 - [ ] Refactor into multiple files.
 - [ ] Eliminate repetitive patterns to improve maintainability.
 - [ ] Implement fallbacks for non-ARM architectures.
 - [ ] Instruction Stripping e.g, Functions like `vget_lane_f64` should compile down to nothing more than accessing the appropriate register (e.g., s0 for vec in v0). Currently, we are explicitly inserting instructions, which prevents the compiler from optimizing them away when not needed.
 - [ ] Add support for Big Endian arm/aarch64, and add tests for it.
 - [ ] For Vector Load intrinsics, dont assume the input length is the exact length of the output vector.
 - [ ] Test against C/C++ implementation.
 - [ ] Add a better way to switch between implementations(like assembly, builtins and the fallback).
 - [ ] Use the fallback instead of assembly implementation when not in release.

## Notes
 - When using `vld1*` on non-ARM architectures(or if use_asm and use_builtins is off), it assumes the underlying type fits the size of the vector.
 - Some intrinsics wont have inline assembly because the fallback implementation is either faster or the same as the assembly implementation. If the target function does not use inline assembly, then it wont be optimized to the target neon intrinsic unless your in `ReleaseFast`.

## Getting Started

### Requirements
To test and simulate ARM/ARM64 environments, `QEMU user mode` is required. Make sure QEMU is properly installed and configured before running tests. You'll also need `Make` for build and test automation.

### Installation and Usage
1. Clone the repository:
   ```bash
   git clone https://github.com/n0thhhing/zig-neon
   cd zig-neon
   ```

3. Run tests:
   ```bash
   make
   ```

## License

This project is licensed under the `MIT` License. See the [LICENSE](LICENSE) file for more information.

## Resources

- [rust-lang](https://dev-doc.rust-lang.org/nightly/core/arch/aarch64/index.html): Useful for function tests and reference.
- [official docs](https://developer.arm.com/architectures/instruction-sets/intrinsics/#q=): Official reference for ARM intrinsics and assembly.
- [godbolt](https://godbolt.org/z/7Ec6co4WG): Handy tool for examining and debugging assembly code.
- [LLVM Language Reference Manual](https://releases.llvm.org/10.0.0/docs/LangRef.html) Helpful for using inline assembly.