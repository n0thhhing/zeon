TEST_FLAGS := -fqemu -freference-trace --summary all
RUN_FLAGS :=

ifndef DEBUG
    TEST_FLAGS += --release=fast
    RUN_FLAGS += --release=fast
endif

.PHONY: fetch
fetch:
	python3 scripts/fetch_missing.py

.PHONY: _gen
_gen:
	python3 scripts/generate_api.py

.PHONY: test
test: _gen
	zig build test $(TEST_FLAGS)

.PHONY: examples
examples: _gen
	zig build run $(RUN_FLAGS) -Drelease=true

.PHONY: clean
clean:
	rm -rf .zig-cache zig-out
