@ECHO OFF

SET COMMAND=pwsh -Command "./binary/windows/ResourceGenerator.exe _resource assets/vertex_shader.glsl assets/lamp.png assets/background1.png output.cpp && ./binary/windows/ResourceGenerator.exe _resource assets/vertex_shader.glsl assets/lamp.png assets/background1.png output.hpp"
IF "%1" == "-wezterm" (wezterm cli spawn --cwd %CD% %COMMAND%)
IF "%1" == "" (START %COMMAND%)
