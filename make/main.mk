include make/platform.mk
include make/flags.mk
include make/files.mk
include make/utility.mk

build: $(OUTPUT_FILE)
prepare: directories
utility: compile_commands clang-format
clean: delete

include make/build.mk
