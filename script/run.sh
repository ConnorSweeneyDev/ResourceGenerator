#!/bin/bash

ARGUMENTS="_text _png assets/vertex.glsl assets/lamp.png assets/background1.png output"
if [ "$OS" == "Windows_NT" ]; then
  ./binary/windows/ResourceGenerator.exe $ARGUMENTS.cpp && ./binary/windows/ResourceGenerator.exe $ARGUMENTS.hpp
elif [ "$(uname)" == "Linux" ]; then
  ./binary/linux/ResourceGenerator.out $ARGUMENTS.cpp && ./binary/linux/ResourceGenerator.out $ARGUMENTS.hpp
else
  echo "Unsupported OS"
fi
