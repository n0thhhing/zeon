TEST_FLAGS := -fqemu -freference-trace --summary all
RUN_FLAGS :=

ifndef DEBUG
    TEST_FLAGS += --release=fast
    RUN_FLAGS += --release=fast
endif

.PHONY: test
test:
	zig build test $(TEST_FLAGS)

.PHONY: examples
examples:
	zig build run $(RUN_FLAGS) -Drelease=true

.PHONY: clean
clean:
	rm -rf .zig-cache zig-out
