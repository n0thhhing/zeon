# Zig-Neon

ARM/ARM64 Neon intrinsics implemented in pure zig as well as in assembly!

## Overview

Zig-Neon aims to provide high-performance Neon intrinsics for ARM and ARM64 architectures, implemented in both pure Zig and inline assembly. This project prioritizes portability, performance, and flexibility, ensuring compatibility across various environments.

## Status

🚧 This project is under active development(318/6116 implemented). Contributions and feedback are welcome!

## Roadmap

 - [ ] Complete inline assembly/LLVM builtin implementations.
 - [ ] Write thorough tests for all functions to ensure correctness.
 - [ ] Refactor into multiple files for better organization.
 - [ ] Eliminate repetitive patterns to improve maintainability.
 - [ ] Implement fallbacks for non-ARM architectures.


## Getting Started

### Requirements
To test and simulate ARM/ARM64 environments, QEMU user mode is required. Make sure QEMU is properly installed and configured before running tests. You'll also need Make for build and test automation.

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

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more information.

## Resources

- [rust-lang](https://dev-doc.rust-lang.org/nightly/core/arch/aarch64/index.html): Useful for function tests and reference.
- [official docs](https://developer.arm.com/architectures/instruction-sets/intrinsics/#q=): Official reference for ARM intrinsics and assembly.
- [godbolt](https://godbolt.org/z/7Ec6co4WG): Handy tool for examining and debugging assembly code.