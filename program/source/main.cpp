#include <fstream>
#include <iomanip>
#include <iostream>
#include <sstream>
#include <vector>

#define STB_IMAGE_IMPLEMENTATION
#include "stb_image.h"

std::string unsigned_char_to_hex(unsigned char ch)
{
  std::stringstream ss;
  ss << "0x" << std::hex << std::setw(2) << std::setfill('0') << static_cast<int>(ch);
  return ss.str();
}

std::vector<unsigned char> read_text_file_as_binary(const std::string &filename)
{
  std::ifstream file(filename, std::ios::binary | std::ios::ate);
  if (!file.is_open()) { throw std::runtime_error("Could not open file"); }

  std::streamsize size = file.tellg();
  file.seekg(0, std::ios::beg);
  std::vector<unsigned char> buffer((size_t)size);

  if (!file.read((char *)buffer.data(), size)) { throw std::runtime_error("Error reading file"); }

  return buffer;
}

int main(int argc, char *argv[])
{
  if (argc < 4)
  {
    std::cout << "Usage: <postfix> <resource1> <resource2> ... <resourceN> <outhppfile> "
                 "<outcppfile>"
              << std::endl;
    return 1;
  }

  std::string generated_hpp_file_name = argv[argc - 2];
  std::string generated_cpp_file_name = argv[argc - 1];
  std::string generated_hpp_file_content =
    "// This is an autogenerated file, do not edit.\n\n#pragma once\n";
  std::string generated_cpp_file_content =
    "// This is an autogenerated file, do not edit.\n\n#include \"" +
    generated_hpp_file_name.substr(generated_hpp_file_name.find_last_of('/') + 1) + "\"\n";
  std::string postfix = argv[1];

  for (int index = 2; index < argc - 2; index++)
  {
    std::string resource_path = argv[index];
    size_t period_pos = resource_path.find_last_of('.');
    std::string resource_name = resource_path.substr(0, period_pos);
    std::string resource_extension = resource_path.substr(period_pos + 1);

    std::string resource_hpp_content;
    std::string resource_cpp_content;
    std::ifstream resource_file(resource_path);
    if (!resource_file.is_open())
    {
      std::cout << "Failed to open file: " << resource_path << std::endl;
      return 1;
    }

    if (resource_extension == "png")
    {
      int width, height, channels;
      stbi_set_flip_vertically_on_load(true);
      unsigned char *data = stbi_load(resource_path.c_str(), &width, &height, &channels, 0);
      if (data == nullptr)
      {
        std::cout << "Failed to load image: " << resource_path << std::endl;
        return 1;
      }

      resource_name = resource_name.substr(resource_name.find_last_of('/') + 1);

      resource_hpp_content += "\nextern const int " + resource_name + postfix + "_width;\n";
      resource_hpp_content += "extern const int " + resource_name + postfix + "_height;\n";
      resource_hpp_content += "extern const int " + resource_name + postfix + "_channels;\n";
      resource_hpp_content +=
        "extern const unsigned char " + resource_name + postfix + "_data[];\n";
      generated_hpp_file_content += resource_hpp_content;

      resource_cpp_content +=
        "\nconst int " + resource_name + postfix + "_width" + " = " + std::to_string(width) + ";\n";
      resource_cpp_content +=
        "const int " + resource_name + postfix + "_height" + " = " + std::to_string(height) + ";\n";
      resource_cpp_content += "const int " + resource_name + postfix + "_channels" + " = " +
                              std::to_string(channels) + ";\n";
      resource_cpp_content +=
        "const unsigned char " + resource_name + postfix + "_data" + "[] = {\n";
      size_t data_size = size_t(width * height * channels);
      for (size_t i = 0; i < data_size; i++)
      {
        resource_cpp_content += unsigned_char_to_hex(data[i]) + ", ";
        if ((i + 1) % 16 == 0) { resource_cpp_content += "\n"; }
      }
      resource_cpp_content += "};\n";
      generated_cpp_file_content += resource_cpp_content;

      stbi_image_free(data);
    }
    else
    {
      resource_name = resource_name.substr(resource_name.find_last_of('/') + 1);

      resource_hpp_content += "\nextern const char " + resource_name + postfix + "[];\n";
      generated_hpp_file_content += resource_hpp_content;

      std::vector<unsigned char> buffer = read_text_file_as_binary(resource_path);
      for (size_t i = 0; i < buffer.size(); i++)
      {
        resource_cpp_content += unsigned_char_to_hex(buffer[i]) + ", ";
        if ((i + 1) % 16 == 0) { resource_cpp_content += "\n"; }
      }
      generated_cpp_file_content += "\nconst char " + resource_name + postfix + "[] = {\n" +
                                    resource_cpp_content + "'\\0' };\n";
    }
    resource_file.close();
  }

  std::ofstream generated_hpp_file(generated_hpp_file_name);
  if (!generated_hpp_file.is_open())
  {
    std::cout << "Failed to open file: " << generated_hpp_file_name << std::endl;
    return 1;
  }
  generated_hpp_file << generated_hpp_file_content;
  generated_hpp_file.close();

  std::ofstream generated_cpp_file(generated_cpp_file_name);
  if (!generated_cpp_file.is_open())
  {
    std::cout << "Failed to open file: " << generated_cpp_file_name << std::endl;
    return 1;
  }
  generated_cpp_file << generated_cpp_file_content;
  generated_cpp_file.close();

  return 0;
}
