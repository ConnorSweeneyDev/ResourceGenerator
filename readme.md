# ResourceGenerator
This program is specifically designed as a helper to my
[SimpleGameEngine](https://github.com/ConnorSweeneyDev/SimpleGameEngine), and is not intended to be portable for other
projects.

### Usage
`./ResourceGenerator.[exe|out] <text_postfix> <image_postfix> <resource1> <resource2> ... <resourceN> <output>`

- `<text_postfix>`: The postfix to append to each text resource name, e.g. `_text`.
- `<image_postfix>`: The postfix to append to each image resource name, e.g. `_image`.
- `<resource1> <resource2> ... <resourceN>`: The files to be read, text files or image files.
- `<output>`: The `.hpp` or `.cpp` file to write the output to, can be a path to a file or just a filename.

Run it once with the desired header file path and once with the desired source file path, keeping all the other
arguments the same.

# Building and Executing
This project is optimized to be built with the following targets in mind:
- Windows 10/11:
  - MSVC
  - MinGW 64-bit GCC
- Ubuntu 22.04 GLIBC Version 2.35

Version information for dependencies can be found in `external/version_info.txt`.

After following the platform specific instructions below you can execute `script/build.sh` followed by `script/run.sh`
from the root of the project to build and run the project.

### Windows
Do the following to ensure your environment is set up correctly:
- Ensure that you have either [MSVC](https://visualstudio.microsoft.com/downloads/) or [MinGW](https://www.winlibs.com/)
  installed.
- Ensure that you have CMake installed, you can run `winget install Kitware.CMake` if you don't.
- Ensure that you have LLVM installed, you can run `winget install LLVM.LLVM` and put the install location in your
  environment variables if you don't (for language server and clang-format support).

### Linux
- Only run `sudo apt update && sudo apt upgrade` if you haven't already.
- Run `sudo apt install cmake llvm clang-format`.

# Updating Libraries
All libraries can be updated by replacing the existing files in the `external` directory with new ones.

### stb
Download [stb_image.h](https://github.com/nothings/stb/blob/master/stb_image.h) as a raw file, then replace the file in
`external/include/stb` directory with that.
