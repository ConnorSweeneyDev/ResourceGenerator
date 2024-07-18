ifneq ($(OS), Windows_NT)
  UNAME := $(shell uname -s)
endif

CXX = g++
#CXXFLAGS = -s -O3 -std=c++20 -DNDEBUG -D_FORTIFY_SOURCE=2 -fstack-protector-strong
CXXFLAGS = -g -O2 -std=c++20 -D_GLIBCXX_DEBUG -D_GLIBCXX_DEBUG_PEDANTIC -D_FORTIFY_SOURCE=2 -fstack-protector-strong

WARNINGS = -Wall -Wextra -Wpedantic -Wconversion -Wshadow -Wcast-qual -Wcast-align -Wfloat-equal -Wlogical-op -Wduplicated-cond -Wshift-overflow=2 -Wformat=2
ifeq ($(OS), Windows_NT)
  ECHO = echo -e
  LIBRARIES = -static -Wl,-Bstatic -lgcc -lstdc++ -lssp -lwinpthread -Wl,-Bdynamic
  OUTPUT = binary/windows/ResourceLoader.exe
else
  ifeq ($(UNAME), Linux)
    ECHO = echo
    OUTPUT = binary/linux/ResourceLoader.out
  endif
  #ifeq ($(UNAME), Darwin)
  #endif
endif

PROGRAM_SOURCE_DIRECTORY = program/source
BINARY_DIRECTORY = binary
OBJECTS_DIRECTORY = binary/object
WINDOWS_DIRECTORY = binary/windows
LINUX_DIRECTORY = binary/linux
CPP_SOURCES = $(wildcard $(PROGRAM_SOURCE_DIRECTORY)/*.cpp)
OBJECTS = $(patsubst $(PROGRAM_SOURCE_DIRECTORY)/%.cpp,$(OBJECTS_DIRECTORY)/%.o,$(CPP_SOURCES))

COMMANDS_DIRECTORY = compile_commands.json
FORMAT_DIRECTORY = .clang-format
STYLE = BasedOnStyle: LLVM
TAB_WIDTH = IndentWidth: 2
INITIALIZER_WIDTH = ConstructorInitializerIndentWidth: 2
CONTINUATION_WIDTH = ContinuationIndentWidth: 2
BRACES = BreakBeforeBraces: Allman
LANGUAGE = Language: Cpp
LIMIT = ColumnLimit: 100
BLOCKS = AllowShortBlocksOnASingleLine: true
FUNCTIONS = AllowShortFunctionsOnASingleLine: true
IFS = AllowShortIfStatementsOnASingleLine: true
LOOPS = AllowShortLoopsOnASingleLine: true
CASE_LABELS = AllowShortCaseLabelsOnASingleLine: true
PP_DIRECTIVES = IndentPPDirectives: BeforeHash
NAMESPACE_INDENTATION = NamespaceIndentation: All
NAMESPACE_COMMENTS = FixNamespaceComments: false
INDENT_CASE_LABELS = IndentCaseLabels: true
BREAK_TEMPLATE_DECLARATIONS = AlwaysBreakTemplateDeclarations: false

all: compile_commands clang-format directories $(OUTPUT)

compile_commands:
	@$(ECHO) "[" > $(COMMANDS_DIRECTORY)
	@for source in $(CPP_SOURCES); do $(ECHO) "\t{ \"directory\": \"$(CURDIR)\", \"command\": \"$(CXX) $(CXXFLAGS) $(WARNINGS) -c $$source -o $(OBJECTS_DIRECTORY)/$$(basename $$source .cpp).o\", \"file\": \"$$source\" },"; done >> $(COMMANDS_DIRECTORY)
	@sed -i "$$ s/,$$//" $(COMMANDS_DIRECTORY)
	@$(ECHO) "]" >> $(COMMANDS_DIRECTORY)
	@$(ECHO) "Write | $(COMMANDS_DIRECTORY)"

clang-format:
	@$(ECHO) "---\n$(STYLE)\n$(TAB_WIDTH)\n$(INITIALIZER_WIDTH)\n$(CONTINUATION_WIDTH)\n$(BRACES)\n---\n$(LANGUAGE)\n$(LIMIT)\n$(BLOCKS)\n$(FUNCTIONS)\n$(IFS)\n$(LOOPS)\n$(CASE_LABELS)\n$(PP_DIRECTIVES)\n$(NAMESPACE_INDENTATION)\n$(NAMESPACE_COMMENTS)\n$(INDENT_CASE_LABELS)\n$(BREAK_TEMPLATE_DECLARATIONS)\n..." > $(FORMAT_DIRECTORY)
	@find program -type f \( -name "*.cpp" -o -name "*.hpp" \) -print0 | xargs -0 -I{} sh -c 'clang-format -i "{}"'
	@$(ECHO) "Write | $(FORMAT_DIRECTORY)"

directories:
	@if [ ! -d "$(BINARY_DIRECTORY)" ]; then mkdir -p $(BINARY_DIRECTORY); $(ECHO) "Write | $(BINARY_DIRECTORY)"; fi
	@if [ ! -d "$(OBJECTS_DIRECTORY)" ]; then mkdir -p $(OBJECTS_DIRECTORY); $(ECHO) "Write | $(OBJECTS_DIRECTORY)"; fi
	@if [ ! -d "$(WINDOWS_DIRECTORY)" ]; then mkdir -p $(WINDOWS_DIRECTORY); $(ECHO) "Write | $(WINDOWS_DIRECTORY)"; fi
	@if [ ! -d "$(LINUX_DIRECTORY)" ]; then mkdir -p $(LINUX_DIRECTORY); $(ECHO) "Write | $(LINUX_DIRECTORY)"; fi

$(OBJECTS_DIRECTORY)/%.o: $(PROGRAM_SOURCE_DIRECTORY)/%.cpp | directories compile_commands clang-format
	@$(CXX) $(CXXFLAGS) $(WARNINGS) -c $< -o $@
	@$(ECHO) "CXX   | $< -> $@"
$(OUTPUT): $(OBJECTS)
	@$(CXX) $(CXXFLAGS) $(WARNINGS) $(OBJECTS) $(LIBRARIES) -o $(OUTPUT)
	@$(ECHO) "Link  | $(OBJECTS) -> $(OUTPUT)"

clean:
	@if [ -d "$(OBJECTS_DIRECTORY)" ]; then rm -r $(OBJECTS_DIRECTORY); fi
	@if [ -f $(OUTPUT) ]; then rm -r $(OUTPUT); fi
