#include <fstream>
#include <iostream>

int main(int argc, char *argv[])
{
  if (argc < 3)
  {
    std::cout << "Usage: <resource1> <resource2> ... <resourceN> <postfix> <outfile>" << std::endl;
    return 1;
  }

  std::string generated_file_name = argv[argc - 1];
  std::string generated_file_content = "#pragma once\n\n";

  std::string postfix = argv[argc - 2];
  for (int index = 1; index < argc - 2; index++)
  {
    std::string resource_path = argv[index];
    size_t period_pos = resource_path.find_last_of('.');
    std::string resource_name = resource_path.substr(0, period_pos);

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

    generated_file_content +=
      "constexpr char " + resource_name + postfix + "[] = R\"(\n" + resource_content + ")\";\n";
  }

  std::ofstream generated_file(generated_file_name);
  if (!generated_file.is_open())
  {
    std::cout << "Failed to open file: " << generated_file_name << std::endl;
    return 1;
  }
  generated_file << generated_file_content;
  generated_file.close();

  return 0;
}
