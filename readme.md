# ResourceLoader
A small executable that reads all the files supplied to it and outputs them as constexpr char arrays
in a c++ header file.

## Usage
`<resource1> <resource2> ... <resourceN> <postfix> <outfile>`

- `<resource1> <resource2> ... <resourceN>`: The files to be read.
- `<postfix>`: The postfix to append to each constexpr char array, e.g. `_resource`.
- `<outfile>`: The file to write the output to, can be a path to a file or just a filename.

## Building
This can be built on windows or linux using the scripts in the `script` directory, but I have
already built it on the releases page which should work for most systems. Mac coming soon.
