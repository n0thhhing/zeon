TEST_FLAGS := -fqemu -freference-trace --summary all # --release=fast
TEST_TARGET := test

test:
	zig build $(TEST_TARGET) $(TEST_FLAGS)
