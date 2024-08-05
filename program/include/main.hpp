#pragma once

#include <string>
#include <vector>

int main(int argc, char *argv[]);
bool verify_arguments(int argc, char *argv[], std::string &generated_out_file_name,
                      std::string &generated_out_file_extension, std::string &postfix,
                      std::string &generated_out_file_content);
std::string unsigned_char_to_hex(unsigned char ch);
std::vector<unsigned char> read_text_file_as_binary(const std::string &file_path);
void get_resource_file(std::string &resource_path, std::string &resource_name,
                       std::string &resource_extension);
void generate_cpp_png_resource(std::string &generated_out_file_content, std::string resource_name,
                               std::string postfix, int width, int height, int channels,
                               unsigned char *data);
void generate_hpp_png_resource(std::string &generated_out_file_content, std::string resource_name,
                               std::string postfix);
bool generate_png_resource(std::string &generated_out_file_content, std::string resource_path,
                           std::string resource_name, std::string postfix,
                           std::string generated_out_file_extension);
void generate_cpp_text_resource(std::string &generated_out_file_content, std::string resource_path,
                                std::string resource_name, std::string postfix);
void generate_hpp_text_resource(std::string &generated_out_file_content, std::string resource_name,
                                std::string postfix);
void generate_text_resource(std::string &generated_out_file_content, std::string resource_path,
                            std::string resource_name, std::string postfix,
                            std::string generated_out_file_extension);
bool generate_resource(std::string &generated_out_file_content, std::string resource_path,
                       std::string resource_name, std::string resource_extension,
                       std::string postfix, std::string generated_out_file_extension);
bool write_to_output_file(const std::string &generated_out_file_name,
                          const std::string &generated_out_file_content);
