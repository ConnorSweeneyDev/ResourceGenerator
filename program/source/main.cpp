#include <fstream>
#include <iostream>

int main(int argc, char *argv[])
{
  if (argc < 5)
  {
    std::cout
      << "Usage: <resource1> <resource2> ... <resourceN> <postfix> <outhppfile> <outcppfile>"
      << std::endl;
    return 1;
  }

  std::string generated_hpp_file_name = argv[argc - 2];
  std::string generated_hpp_file_content =
    "// This is an auto-generated file, do not edit.\n\n#pragma once\n\n";

  std::string generated_cpp_file_name = argv[argc - 1];
  std::string include =
    generated_hpp_file_name.substr(generated_hpp_file_name.find_last_of('/') + 1)
      .substr(0, generated_hpp_file_name.find_last_of('.'));
  std::string generated_cpp_file_content =
    "// This is an auto-generated file, do not edit.\n\n#include \"" + include + "\"\n\n";

  std::string postfix = argv[argc - 3];
  for (int index = 1; index < argc - 3; index++)
  {
    std::string resource_path = argv[index];
    std::string resource_name = resource_path.substr(0, resource_path.find_last_of('.'));
    std::string resource_content;
    std::ifstream resource_file(resource_path);
    if (!resource_file.is_open())
    {
      std::cout << "Failed to open file: " << resource_path << std::endl;
      return 1;
    }
    std::string line;
    while (std::getline(resource_file, line)) { resource_content += line + "\n"; }
    resource_file.close();
    resource_name = resource_name.substr(resource_name.find_last_of('/') + 1);

    generated_hpp_file_content += "extern const char " + resource_name + postfix + "[];\n";

    generated_cpp_file_content +=
      "const char " + resource_name + postfix + "[] = R\"(\n" + resource_content + ")\";\n";
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
