TEST_FLAGS := -fqemu -freference-trace --summary all # --release=fast
TEST_TARGET := test
TEST_TARGET_FILTER ?= none

test:
	zig build $(TEST_TARGET) $(TEST_FLAGS) -Dtarget_filter=$(TEST_TARGET_FILTER)

