#include "driver.hh"
#include "parser.tab.hh"
#include <sstream>
#include <fstream>
#include <iostream>

driver::driver()
  : out(* new std::stringstream(std::ios_base::out)), trace_parsing(false), trace_scanning(false)
{}

int driver::parse(const std::string& f)
{
  file = f;
  outputFile = f.empty() ? "out.cpp" : f.substr(0, f.find_last_of('.')) + ".cpp";
  location.initialize(&file);
  scan_begin();
  yy::parser parser(*this);
  parser.set_debug_level(trace_parsing);
  result = parser.parse();
  scan_end();
  return result;
}

void driver::deallocate_memory()
{
  delete &out;
  for (auto e : expressions)
    delete e;
}

void driver::exit(int exit_code)
{
  deallocate_memory();
  std::exit(exit_code);
}

driver::~driver()
{
  deallocate_memory();
}
