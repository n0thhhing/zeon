TEST_FLAGS := -fqemu -freference-trace --summary all
RUN_FLAGS :=
TEST_TARGET_FILTER ?= none

ifndef DEBUG
    TEST_FLAGS += --release=fast
    RUN_FLAGS += --release=fast
endif

.PHONY: test
test:
	zig build test $(TEST_FLAGS) -Dtarget-filter="$(TEST_TARGET_FILTER)"

.PHONY: examples
examples:
	zig build run $(RUN_FLAGS)