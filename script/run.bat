@ECHO OFF

SET COMMAND=binary/windows/ResourceLoader.exe _resource assets/vertex_shader.glsl assets/lamp.png assets/background1.png output
IF "%1" == "-wezterm" (wezterm cli spawn --cwd %CD% pwsh -Command "./%COMMAND%.cpp && ./%COMMAND%.hpp")
IF "%1" == "" (cmd /C "start %COMMAND%.cpp && start %COMMAND%.hpp")
