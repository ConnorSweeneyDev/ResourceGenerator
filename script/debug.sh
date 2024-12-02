#!/bin/bash

if [ "$OS" == "Windows_NT" ]; then
  gdb -tui ./binary/windows/ResourceGenerator.exe
elif [ "$(uname)" == "Linux" ]; then
  gdb -tui ./binary/linux/ResourceGenerator.out
else
  echo "Unsupported OS"
fi
