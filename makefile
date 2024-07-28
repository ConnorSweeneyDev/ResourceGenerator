ifeq ($(OS), Windows_NT)
  UNAME := Windows
else
  UNAME := $(shell uname -s)
endif

CXX := g++
CXXFLAGS := -s -O3 -std=c++17 -DNDEBUG -D_FORTIFY_SOURCE=2 -fstack-protector-strong
#CXXFLAGS := -g -O2 -std=c++17 -D_GLIBCXX_DEBUG -D_GLIBCXX_DEBUG_PEDANTIC -D_FORTIFY_SOURCE=2 -fstack-protector-strong

WARNINGS := -Wall -Wextra -Wpedantic -Wconversion -Wshadow -Wcast-qual -Wcast-align -Wfloat-equal -Wlogical-op -Wduplicated-cond -Wshift-overflow=2 -Wformat=2
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
BINARY_DIRECTORY := binary
OBJECTS_DIRECTORY := binary/object
CPP_SOURCES := $(wildcard $(PROGRAM_SOURCE_DIRECTORY)/*.cpp)
OBJECTS := $(patsubst $(PROGRAM_SOURCE_DIRECTORY)/%.cpp,$(OBJECTS_DIRECTORY)/%.o,$(CPP_SOURCES))

COMMANDS_DIRECTORY := compile_commands.json
FORMAT_DIRECTORY := .clang-format
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
FORMAT_FILES := $(wildcard $(PROGRAM_SOURCE_DIRECTORY)/*.cpp)

main: directories $(OUTPUT)
external: compile_commands clang-format directories

compile_commands:
	@$(ECHO) "[" > $(COMMANDS_DIRECTORY)
	@for source in $(CPP_SOURCES); do $(ECHO) "\t{ \"directory\": \"$(CURDIR)\", \"command\": \"$(CXX) $(CXXFLAGS) $(WARNINGS) $(SYSTEM_INCLUDES) -c $$source -o $(OBJECTS_DIRECTORY)/$$(basename $$source .cpp).o\", \"file\": \"$$source\" },"; done >> $(COMMANDS_DIRECTORY)
	@sed -i "$$ s/,$$//" $(COMMANDS_DIRECTORY)
	@$(ECHO) "]" >> $(COMMANDS_DIRECTORY)
	@$(ECHO) "Write | $(COMMANDS_DIRECTORY)"

clang-format:
	@$(ECHO) "---\n$(STYLE)\n$(TAB_WIDTH)\n$(INITIALIZER_WIDTH)\n$(CONTINUATION_WIDTH)\n$(BRACES)\n---\n$(LANGUAGE)\n$(LIMIT)\n$(BLOCKS)\n$(FUNCTIONS)\n$(IFS)\n$(LOOPS)\n$(CASE_LABELS)\n$(PP_DIRECTIVES)\n$(NAMESPACE_INDENTATION)\n$(NAMESPACE_COMMENTS)\n$(INDENT_CASE_LABELS)\n$(BREAK_TEMPLATE_DECLARATIONS)\n..." > $(FORMAT_DIRECTORY)
	@$(ECHO) "Write | $(FORMAT_DIRECTORY)"
	@for file in $(FORMAT_FILES); do clang-format -i $$file; done
	@$(ECHO) "FMT   | $(FORMAT_FILES)"

directories:
	@if [ ! -d $(BINARY_DIRECTORY) ]; then mkdir -p $(BINARY_DIRECTORY); $(ECHO) "Write | $(BINARY_DIRECTORY)"; fi
	@if [ ! -d $(OBJECTS_DIRECTORY) ]; then mkdir -p $(OBJECTS_DIRECTORY); $(ECHO) "Write | $(OBJECTS_DIRECTORY)"; fi
	@if [ ! -d $(TARGET_DIRECTORY) ]; then mkdir -p $(TARGET_DIRECTORY); $(ECHO) "Write | $(TARGET_DIRECTORY)"; fi

$(OBJECTS_DIRECTORY)/%.o: $(PROGRAM_SOURCE_DIRECTORY)/%.cpp | directories
	@$(CXX) $(CXXFLAGS) $(WARNINGS) $(SYSTEM_INCLUDES) -c $< -o $@
	@$(ECHO) "CXX   | $< -> $@"
$(OUTPUT): $(OBJECTS)
	@$(CXX) $(CXXFLAGS) $(WARNINGS) $(SYSTEM_INCLUDES) $(OBJECTS) $(LIBRARIES) -o $(OUTPUT)
	@$(ECHO) "Link  | $(OBJECTS) -> $(OUTPUT)"

clean:
	@if [ -d $(OBJECTS_DIRECTORY) ]; then rm -r $(OBJECTS_DIRECTORY); fi
	@if [ -f $(OUTPUT) ]; then rm -r $(OUTPUT); fi
