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
