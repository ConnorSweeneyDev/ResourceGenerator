#pragma once

#include <string>
#include <vector>

inline std::string generated_out_file_name, generated_out_file_extension, generated_out_file_content, postfix;

int main(int argc, char *argv[]);
bool verify_arguments(int argc, char *argv[]);

std::string unsigned_char_to_hex(unsigned char ch);
std::vector<unsigned char> read_text_file_as_binary(const std::string &file_path);

void get_resource_file(const std::string &resource_path, std::string &resource_name, std::string &resource_extension);

void generate_cpp_png_resource(const std::string &resource_name, const int &width, const int &height,
                               const int &channels, unsigned char *data);
void generate_hpp_png_resource(const std::string &resource_name);
bool generate_png_resource(const std::string &resource_path, std::string resource_name);

void generate_cpp_text_resource(const std::string &resource_path, const std::string &resource_name);
void generate_hpp_text_resource(const std::string &resource_name);
void generate_text_resource(const std::string &resource_path, std::string resource_name);

bool generate_resource(const std::string &resource_path, const std::string &resource_name,
                       const std::string &resource_extension);
bool write_to_output_file();
