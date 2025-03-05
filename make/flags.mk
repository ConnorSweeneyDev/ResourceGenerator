CXX := g++
ifeq ($(DEBUG), 1)
  CXX_FLAGS := -ggdb3 -Og -MD -MP -std=c++17 -DDEBUG -D_FORTIFY_SOURCE=2 -fno-common -fstack-protector-strong
else
  CXX_FLAGS := -s -O3 -std=c++17 -DNDEBUG -fno-common -fstack-protector-strong
endif

WARNINGS := -Wall -Wextra -Wpedantic -Wconversion -Wshadow -Wcast-qual -Wcast-align -Wfloat-equal -Wlogical-op -Wduplicated-cond -Wshift-overflow=2 -Wformat=2
INCLUDES := -Iprogram/include
SYSTEM_INCLUDES := -isystemexternal/include -isystemexternal/include/stb
ifeq ($(UNAME), Windows)
  LIBRARIES := -static -lgcc -lstdc++ -lssp
else ifeq ($(UNAME), Linux)
  LIBRARIES := -static -ldl -lm -lc -lgcc -lstdc++ -Wl,-rpath,'$$ORIGIN'
endif
