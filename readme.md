# ResourceLoader
A small executable that reads all the files supplied to it and outputs them as const char arrays in
a c++ compilation unit.

## Usage
`<postfix> <resource1> <resource2> ... <resourceN> <outfile>`

- `<postfix>`: The postfix to append to each constexpr char array name, e.g. `_resource`.
- `<resource1> <resource2> ... <resourceN>`: The files to be read, text files or png files.
- `<outfile>`: The `.hpp` or `.cpp` file to write the output to, can be a path to a file or just a
  filename.

Run it once with the desired header file path and once with the desired source file path, keeping
all the other arguments the same.

## Building
This can be built on windows or linux using the scripts in the `script` directory, but I have
already built it on the releases page which should work for most systems.

### Windows
You'll need any 64-bit [MinGW](https://winlibs.com/) installation with clang/LLVM support in your
path, this will give you access to the unix tools that are used in the makefile. In addition, you
will need Python3 for parallel build support - `winget install --id Python.Python.3.10`, and the
batch files assume you have pwsh.exe installed - `winget install --id Microsoft.Powershell --source
winget`.

### Linux
- Only run `sudo apt update && sudo apt upgrade` if you haven't already.
- Run `sudo apt install git g++ make`.
