#!/bin/bash

./binary/linux/ResourceGenerator.out _resource assets/vertex_shader.glsl assets/lamp.png assets/background1.png output.cpp && ./binary/linux/ResourceGenerator.out _resource assets/vertex_shader.glsl assets/lamp.png assets/background1.png output.hpp
