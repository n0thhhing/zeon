TEST_FLAGS := -fqemu -freference-trace --summary all # --release=fast
TEST_TARGET_FILTER ?= none

test:
	zig build test $(TEST_FLAGS) -Dtarget-filter="$(TEST_TARGET_FILTER)"

