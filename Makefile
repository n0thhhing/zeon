.PHONY: test check-all-asm examples clean

test: check-all-asm
	zig build test --summary all

check-all-asm:
	mkdir -p tests/asm_verification
	python3 scripts/generate_asm_tests.py
	zig build-obj \
		--dep zeon \
		-Mroot=tests/asm_verification/check_all_asm.zig \
		-Mzeon=src/zeon.zig \
		-O ReleaseFast \
		-target aarch64-linux \
		-mcpu=generic+aes \
		-femit-asm=tests/asm_verification/check_all_asm.s
	python3 scripts/verify_all_asm.py

examples:
	zig build run

clean:
	rm -rf zig-cache zig-out check_asm.s check_aes.s check.s tests/asm_verification
