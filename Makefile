.PHONY: test test-docker check-all-asm \
        check-asm-aarch64 check-asm-arm \
        check-asm-x86_64 check-asm-riscv64 \
        check-asm-ppc64le check-asm-la64 \
        check-asm-wasm32 \
        examples clean

# Default: run unit tests + all ASM verifications
test: check-all-asm
	zig build test --summary all

# Run the ultimate 9-architecture test matrix securely via Docker Alpine + QEMU
test-docker:
	docker run --rm -v $$(pwd):/app -w /app alpine:edge sh -c "apk add zig qemu-aarch64 qemu-x86_64 qemu-arm qemu-riscv64 qemu-ppc64le qemu-loongarch64 wasmtime >/dev/null 2>&1 && zig build test-all-archs -fwasmtime --summary all"

# Verify every supported target
check-all-asm: \
	check-asm-aarch64 \
	check-asm-arm \
	check-asm-x86_64 \
	check-asm-riscv64 \
	check-asm-ppc64le \
	check-asm-la64 \
	check-asm-wasm32

_gen:
	mkdir -p tests/asm_verification
	python3 scripts/generate_asm_tests.py

# ─── AArch64 (primary — explicit asm for all NEON intrinsics) ───────────────
check-asm-aarch64: _gen
	zig build-obj \
		--dep zeon \
		-Mroot=tests/asm_verification/check_all_asm.zig \
		-Mzeon=src/zeon.zig \
		-O ReleaseFast \
		-target aarch64-linux \
		-mcpu=generic+aes \
		-femit-asm=tests/asm_verification/check_all_asm_aarch64.s
	python3 scripts/verify_all_asm.py \
		--target aarch64-linux \
		--asm   tests/asm_verification/check_all_asm_aarch64.s

# ─── ARM32 / armhf (explicit NEON asm) ─────────────────────────────────────
check-asm-arm: _gen
	zig build-obj \
		--dep zeon \
		-Mroot=tests/asm_verification/check_all_asm.zig \
		-Mzeon=src/zeon.zig \
		-O ReleaseFast \
		-target arm-linux-gnueabihf \
		-mcpu=generic+neon+crypto \
		-femit-asm=tests/asm_verification/check_all_asm_arm.s
	python3 scripts/verify_all_asm.py \
		--target arm-linux-gnueabihf \
		--asm   tests/asm_verification/check_all_asm_arm.s

# ─── x86_64 (portable fallbacks → SSE4.2 auto-vectorized) ──────────────────
check-asm-x86_64: _gen
	zig build-obj \
		--dep zeon \
		-Mroot=tests/asm_verification/check_all_asm.zig \
		-Mzeon=src/zeon.zig \
		-O ReleaseFast \
		-target x86_64-linux \
		-mcpu=x86_64_v2 \
		-femit-asm=tests/asm_verification/check_all_asm_x86_64.s
	python3 scripts/verify_all_asm.py \
		--target x86_64-linux \
		--asm   tests/asm_verification/check_all_asm_x86_64.s

# ─── RISC-V 64 with Vector Extension (RVV) ──────────────────────────────────
check-asm-riscv64: _gen
	zig build-obj \
		--dep zeon \
		-Mroot=tests/asm_verification/check_all_asm.zig \
		-Mzeon=src/zeon.zig \
		-O ReleaseFast \
		-target riscv64-linux \
		-mcpu=generic_rv64+v \
		-femit-asm=tests/asm_verification/check_all_asm_riscv64.s
	python3 scripts/verify_all_asm.py \
		--target riscv64-linux \
		--asm   tests/asm_verification/check_all_asm_riscv64.s

# ─── PowerPC64le (AltiVec / VSX) ────────────────────────────────────────────
check-asm-ppc64le: _gen
	zig build-obj \
		--dep zeon \
		-Mroot=tests/asm_verification/check_all_asm.zig \
		-Mzeon=src/zeon.zig \
		-O ReleaseFast \
		-target powerpc64le-linux \
		-mcpu=pwr9 \
		-femit-asm=tests/asm_verification/check_all_asm_ppc64le.s
	python3 scripts/verify_all_asm.py \
		--target powerpc64le-linux \
		--asm   tests/asm_verification/check_all_asm_ppc64le.s

# ─── LoongArch64 (LSX / LASX SIMD) ─────────────────────────────────────────
check-asm-la64: _gen
	zig build-obj \
		--dep zeon \
		-Mroot=tests/asm_verification/check_all_asm.zig \
		-Mzeon=src/zeon.zig \
		-O ReleaseFast \
		-target loongarch64-linux \
		-mcpu=generic_la64+lsx \
		-femit-asm=tests/asm_verification/check_all_asm_la64.s
	python3 scripts/verify_all_asm.py \
		--target loongarch64-linux \
		--asm   tests/asm_verification/check_all_asm_la64.s

# ─── WebAssembly 32 (simd128 / relaxed-simd) ───────────────────────────────
check-asm-wasm32: _gen
	zig build-obj \
		--dep zeon \
		-Mroot=tests/asm_verification/check_all_asm.zig \
		-Mzeon=src/zeon.zig \
		-O ReleaseFast \
		-target wasm32-wasi \
		-mcpu=generic+simd128 \
		-femit-asm=tests/asm_verification/check_all_asm_wasm32.s
	python3 scripts/verify_all_asm.py \
		--target wasm32-wasi \
		--asm   tests/asm_verification/check_all_asm_wasm32.s

examples:
	zig build run

clean:
	rm -rf zig-cache zig-out tests/asm_verification
