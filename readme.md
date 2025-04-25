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

# How to Build
This project is optimized to be built on Windows with MSVC.

1. Ensure that you have [MSVC](https://visualstudio.microsoft.com/downloads/) installed.
2. Ensure that you have CMake installed, you can run `winget install Kitware.CMake` if you don't.
3. Ensure that you have LLVM installed, you can run `winget install LLVM.LLVM` and put the install location in your
   environment variables if you don't (for language server and clang-format support).
4. Execute `script/build.sh` followed by `script/run.sh`.

# How to Update Dependencies
All dependencies are vendored and stored in the `external` directory. Version information for dependencies can be found
in `external/version_info.txt`.

### STB
1. Download [stb_image.h](https://github.com/nothings/stb/blob/master/stb_image.h) as a raw file.
2. Put the file in `external/stb/include/stb`.
