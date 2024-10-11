@ECHO OFF

SET COMMAND=pwsh -Command "gdb -tui ./binary/windows/ResourceLoader.exe"
IF "%1" == "-wezterm" (wezterm cli spawn --cwd %CD% %COMMAND%)
IF "%1" == "" (%COMMAND%)
