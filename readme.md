# ResourceLoader
A small executable that reads all the files supplied to it and outputs them as constexpr char arrays
in a c++ compilation unit.

## Usage
`<resource1> <resource2> ... <resourceN> <postfix> <outhppfile> <outcppfile>`

- `<resource1> <resource2> ... <resourceN>`: The files to be read.
- `<postfix>`: The postfix to append to each constexpr char array name, e.g. `_resource`.
- `<outhppfile>`: The hpp file to write the output to, can be a path to a file or just a filename.
- `<outcppfile>`: The cpp file to write the output to, can be a path to a file or just a filename.

## Building
This can be built on windows or linux using the scripts in the `script` directory, but I have
already built it on the releases page which should work for most systems. Mac coming soon.
