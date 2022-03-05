#include <stdio.h>
#include "driver.hh"

int main(int argc, char *argv[])
{
  driver drv;
  std::string file;
  for (int i=1; i<argc; ++i)
  {
    if (argv[i] == std::string("-d"))
      drv.trace_parsing = true;
    else if (argv[i] == std::string("-s"))
      drv.trace_scanning = true;
    else if (file.empty())
      file = argv[i];
    else
      std::cerr << "Usage: " << argv[0] << " [-d] [-s] file.txt" << std::endl;
  }
  std::cout << "The input is " + std::string(!drv.parse(file) ? "valid" : "invalid") << std::endl;
  return drv.result;
}