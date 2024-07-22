@ECHO OFF

start pwsh -NoExit -Command ".\binary\windows\ResourceLoader.exe _resource assets/vertex_shader.glsl assets/lamp.png assets/background1.png output.hpp output.cpp"
