ifeq ($(OS), Windows_NT)
  UNAME := Windows
else
  UNAME := $(shell uname -s)
endif

DEBUG := 0
CXX := g++
ifeq ($(DEBUG), 1)
  CXXFLAGS := -g -O2 -std=c++17 -DDEBUG -D_FORTIFY_SOURCE=2 -fstack-protector-strong
else
  CXXFLAGS := -s -O3 -std=c++17 -DNDEBUG -D_FORTIFY_SOURCE=2 -fstack-protector-strong
endif

WARNINGS := -Wall -Wextra -Wpedantic -Wconversion -Wshadow -Wcast-qual -Wcast-align -Wfloat-equal -Wlogical-op -Wduplicated-cond -Wshift-overflow=2 -Wformat=2
INCLUDES := -Iprogram/include
SYSTEM_INCLUDES := -isystemexternal/include -isystemexternal/include/stb
LIBRARIES := -static
ifeq ($(UNAME), Windows)
  ECHO := echo -e
  TARGET_DIRECTORY := binary/windows
  OUTPUT := $(TARGET_DIRECTORY)/ResourceLoader.exe
else ifeq ($(UNAME), Linux)
  ECHO := echo
  TARGET_DIRECTORY := binary/linux
  OUTPUT := $(TARGET_DIRECTORY)/ResourceLoader.out
#else ifeq ($(UNAME), Darwin)
endif

PROGRAM_SOURCE_DIRECTORY := program/source
PROGRAM_INCLUDE_DIRECTORY := program/include
BINARY_DIRECTORY := binary
OBJECT_DIRECTORY := binary/object
CPP_SOURCE_FILES := $(wildcard $(PROGRAM_SOURCE_DIRECTORY)/*.cpp)
OBJECT_FILES := $(patsubst $(PROGRAM_SOURCE_DIRECTORY)/%.cpp,$(OBJECT_DIRECTORY)/%.o,$(CPP_SOURCE_FILES))

COMPILE_COMMANDS_FILE := compile_commands.json
CLANG_FORMAT_FILE := .clang-format
STYLE := BasedOnStyle: LLVM
TAB_WIDTH := IndentWidth: 2
INITIALIZER_WIDTH := ConstructorInitializerIndentWidth: 2
CONTINUATION_WIDTH := ContinuationIndentWidth: 2
BRACES := BreakBeforeBraces: Allman
LANGUAGE := Language: Cpp
LIMIT := ColumnLimit: 100
BLOCKS := AllowShortBlocksOnASingleLine: true
FUNCTIONS := AllowShortFunctionsOnASingleLine: true
IFS := AllowShortIfStatementsOnASingleLine: true
LOOPS := AllowShortLoopsOnASingleLine: true
CASE_LABELS := AllowShortCaseLabelsOnASingleLine: true
PP_DIRECTIVES := IndentPPDirectives: BeforeHash
NAMESPACE_INDENTATION := NamespaceIndentation: All
NAMESPACE_COMMENTS := FixNamespaceComments: false
INDENT_CASE_LABELS := IndentCaseLabels: true
BREAK_TEMPLATE_DECLARATIONS := AlwaysBreakTemplateDeclarations: false
FORMAT_FILES := $(wildcard $(PROGRAM_SOURCE_DIRECTORY)/*.cpp) $(wildcard $(PROGRAM_INCLUDE_DIRECTORY)/*.hpp)

main: directories $(OUTPUT)
external: compile_commands clang-format directories

compile_commands:
	@$(ECHO) "[" > $(COMPILE_COMMANDS_FILE)
	@for source in $(CPP_SOURCE_FILES); do $(ECHO) "\t{ \"directory\": \"$(CURDIR)\", \"command\": \"$(CXX) $(CXXFLAGS) $(WARNINGS) $(INCLUDES) $(SYSTEM_INCLUDES) -c $$source -o $(OBJECT_DIRECTORY)/$$(basename $$source .cpp).o\", \"file\": \"$$source\" },"; done >> $(COMPILE_COMMANDS_FILE)
	@sed -i "$$ s/,$$//" $(COMPILE_COMMANDS_FILE)
	@$(ECHO) "]" >> $(COMPILE_COMMANDS_FILE)
	@$(ECHO) "Write | $(COMPILE_COMMANDS_FILE)"

clang-format:
	@$(ECHO) "---\n$(STYLE)\n$(TAB_WIDTH)\n$(INITIALIZER_WIDTH)\n$(CONTINUATION_WIDTH)\n$(BRACES)\n---\n$(LANGUAGE)\n$(LIMIT)\n$(BLOCKS)\n$(FUNCTIONS)\n$(IFS)\n$(LOOPS)\n$(CASE_LABELS)\n$(PP_DIRECTIVES)\n$(NAMESPACE_INDENTATION)\n$(NAMESPACE_COMMENTS)\n$(INDENT_CASE_LABELS)\n$(BREAK_TEMPLATE_DECLARATIONS)\n..." > $(CLANG_FORMAT_FILE)
	@$(ECHO) "Write | $(CLANG_FORMAT_FILE)"
	@for file in $(FORMAT_FILES); do clang-format -i $$file; done
	@$(ECHO) "FMT   | $(FORMAT_FILES)"

directories:
	@if [ ! -d $(BINARY_DIRECTORY) ]; then mkdir -p $(BINARY_DIRECTORY); $(ECHO) "Write | $(BINARY_DIRECTORY)"; fi
	@if [ ! -d $(OBJECT_DIRECTORY) ]; then mkdir -p $(OBJECT_DIRECTORY); $(ECHO) "Write | $(OBJECT_DIRECTORY)"; fi
	@if [ ! -d $(TARGET_DIRECTORY) ]; then mkdir -p $(TARGET_DIRECTORY); $(ECHO) "Write | $(TARGET_DIRECTORY)"; fi

$(OBJECT_DIRECTORY)/%.o: $(PROGRAM_SOURCE_DIRECTORY)/%.cpp $(PROGRAM_INCLUDE_DIRECTORY)/%.hpp | directories
	@$(CXX) $(CXXFLAGS) $(WARNINGS) $(INCLUDES) $(SYSTEM_INCLUDES) -c $< -o $@
	@$(ECHO) "CXX   | $< -> $@"
$(OBJECT_DIRECTORY)/%.o: $(PROGRAM_SOURCE_DIRECTORY)/%.cpp | directories
	@$(CXX) $(CXXFLAGS) $(WARNINGS) $(INCLUDES) $(SYSTEM_INCLUDES) -c $< -o $@
	@$(ECHO) "CXX   | $< -> $@"
$(OUTPUT): $(OBJECT_FILES) | directories
	@$(CXX) $(CXXFLAGS) $(WARNINGS) $(INCLUDES) $(SYSTEM_INCLUDES) $(OBJECT_FILES) $(LIBRARIES) -o $(OUTPUT)
	@$(ECHO) "Link  | $(OBJECT_FILES) -> $(OUTPUT)"

clean:
	@if [ -d $(OBJECT_DIRECTORY) ]; then rm -r $(OBJECT_DIRECTORY); fi
	@if [ -f $(OUTPUT) ]; then rm -r $(OUTPUT); fi
