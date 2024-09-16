directories:
	@if [ ! -d $(BINARY_DIRECTORY) ]; then mkdir -p $(BINARY_DIRECTORY); $(ECHO) "Write | $(BINARY_DIRECTORY)"; fi
	@if [ ! -d $(OBJECT_DIRECTORY) ]; then mkdir -p $(OBJECT_DIRECTORY); $(ECHO) "Write | $(OBJECT_DIRECTORY)"; fi
	@if [ ! -d $(TARGET_PLATFORM_DIRECTORY) ]; then mkdir -p $(TARGET_PLATFORM_DIRECTORY); $(ECHO) "Write | $(TARGET_PLATFORM_DIRECTORY)"; fi

$(OBJECT_DIRECTORY)/%.o: $(PROGRAM_SOURCE_DIRECTORY)/%.cpp $(PROGRAM_INCLUDE_DIRECTORY)/%.hpp
	@$(CXX) $(CXXFLAGS) $(WARNINGS) $(INCLUDES) $(SYSTEM_INCLUDES) -c $< -o $@
	@$(ECHO) "CXX   | $< -> $@"
$(OBJECT_DIRECTORY)/%.o: $(PROGRAM_SOURCE_DIRECTORY)/%.cpp
	@$(CXX) $(CXXFLAGS) $(WARNINGS) $(INCLUDES) $(SYSTEM_INCLUDES) -c $< -o $@
	@$(ECHO) "CXX   | $< -> $@"
$(OUTPUT_FILE): $(OBJECT_FILES)
	@$(CXX) $(CXXFLAGS) $(WARNINGS) $(INCLUDES) $(SYSTEM_INCLUDES) $(OBJECT_FILES) $(LIBRARIES) -o $(OUTPUT_FILE)
	@$(ECHO) "Link  | $(OBJECT_FILES) -> $(OUTPUT_FILE)"

delete:
	@if [ -d $(OBJECT_DIRECTORY) ]; then rm -r $(OBJECT_DIRECTORY); $(ECHO) "RM    | $(OBJECT_DIRECTORY)"; fi
	@if [ -f $(OUTPUT_FILE) ]; then rm -r $(OUTPUT_FILE); $(ECHO) "RM    | $(OUTPUT_FILE)"; fi
