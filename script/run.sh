#!/bin/bash

ARGUMENTS="_text _image asset/vertex.glsl asset/background.png output"
OUTPUT=$(find . -name "ResourceGenerator.exe")
$OUTPUT $ARGUMENTS.hpp && $OUTPUT $ARGUMENTS.cpp
