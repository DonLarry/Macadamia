#ifndef DRIVER_HH
#define DRIVER_HH

#include <iostream>
#include <string>
#include "parser.tab.hh"

#define YY_DECL \
  yy::parser::symbol_type yylex (driver& drv)
YY_DECL;

struct driver
{
  // std::map<std::string, int> variables;
  int result;
  std::string file;
  std::stringstream& out;
  std::string outputFile;
  // Whether to generate parser debug traces.
  bool trace_parsing;
  // Whether to generate scanner debug traces.
  bool trace_scanning;
  // The token's location used by the scanner.
  yy::location location;

  int parse(const std::string& file);
  void scan_begin();
  void scan_end();

  driver();
};

#endif // ! DRIVER_HH
