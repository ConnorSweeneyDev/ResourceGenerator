#!/bin/bash

OUTPUT=$(find . -name "ResourceGenerator.exe")
ARGUMENTS="_text _image asset/vertex.glsl asset/background.png output"

$OUTPUT $ARGUMENTS.hpp && $OUTPUT $ARGUMENTS.cpp
