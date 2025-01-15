TEST_FLAGS := -fqemu -freference-trace --summary all # --release=fast
TEST_TARGET_FILTER ?= none

.PHONY: test
test:
	zig build test $(TEST_FLAGS) -Dtarget-filter="$(TEST_TARGET_FILTER)"

.PHONY: examples
examples:
	zig build run --release=fast

