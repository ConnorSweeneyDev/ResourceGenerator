#!/bin/bash

ARGUMENTS="_text _image asset/vertex.glsl asset/background.png output"
if [ "$OS" = "Windows_NT" ]; then
  OUTPUT=$(find . -name "ResourceGenerator.exe")
elif [ "$(uname)" = "Linux" ]; then
  OUTPUT=$(find . -name "ResourceGenerator")
else
  echo "Unsupported OS"
  exit 1
fi
$OUTPUT $ARGUMENTS.hpp && $OUTPUT $ARGUMENTS.cpp
