# Usage
This program is specifically designed as a helper to my
[SimpleGameEngine](https://github.com/ConnorSweeneyDev/SimpleGameEngine), and is not intended to be portable for other
projects.

`./ResourceGenerator.[exe|out] <text_postfix> <png_postfix> <resource1> <resource2> ... <resourceN> <outfile>`

- `<text_postfix>`: The postfix to append to each text resource name, e.g. `"_text"`.
- `<png_postfix>`: The postfix to append to each png resource name, e.g. `"_png"`.
- `<resource1> <resource2> ... <resourceN>`: The files to be read, glsl files or png files.
- `<outfile>`: The `.hpp` or `.cpp` file to write the output to, can be a path to a file or just a filename.

Run it once with the desired header file path and once with the desired source file path, keeping all the other
arguments the same.

# Building and Executing
This project is optimized to be built with the following targets in mind:
- Windows 11 MinGW 64-bit GCC 14.2.0
- Ubuntu 18.04 GLIBC Version 2.27

Version information for dependencies can be found in `external/version_info.txt`.

On both Windows and Linux any libraries used are all statically linked.

After following the platform specific instructions below you can execute `script/build.sh` followed by `script/run.sh`
from the root of the project to build and run the project.

### Windows
Do the following to ensure your environment is set up correctly:
- Download a 64-bit [MinGW](https://winlibs.com/) distribution with Clang/LLVM support and put the `[DISTRIBUTION]/bin`
  directory in your path.
- Install GNUMake by running `winget install ezwinports.make`.
- Ensure that you have `[GIT_INSTALLATION]/bin` in your path.

### Linux
- Only run `sudo apt update && sudo apt upgrade` if you haven't already.
- Run `sudo apt install git g++ make`.

# Updating stb_image
Go to the stb_image.h [file](https://github.com/nothings/stb/blob/master/stb_image.h) and download it as a raw file,
then replace the file in `external/include/stb` directory with that file.
