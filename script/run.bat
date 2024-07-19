@ECHO OFF

start pwsh -NoExit -Command ".\binary\windows\ResourceLoader.exe assets/vertex_shader.glsl assets/lamp.png assets/background1.png _resource output.hpp"
