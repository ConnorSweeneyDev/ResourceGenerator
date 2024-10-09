@ECHO OFF

IF "%1" == "-wezterm" (
  SET TERM=wezterm cli spawn --cwd %CD% pwsh -Command
) ELSE (
  SET TERM=pwsh -Command
)

%TERM% "./binary/windows/ResourceLoader.exe _resource assets/vertex_shader.glsl assets/lamp.png assets/background1.png output.cpp && ./binary/windows/ResourceLoader.exe _resource assets/vertex_shader.glsl assets/lamp.png assets/background1.png output.hpp"
