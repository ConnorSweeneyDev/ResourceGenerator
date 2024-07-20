@ECHO OFF

start pwsh -NoExit -Command ".\binary\windows\ResourceLoader.exe assets/vertex_shader.glsl assets/lamp.png assets/background1.png _resource output.hpp output.cpp '-s -O3 -std=c++17 -DNDEBUG -D_FORTIFY_SOURCE=2 -fstack-protector-strong' output.o"
