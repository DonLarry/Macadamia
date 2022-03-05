#ifndef DRIVER_HH
#define DRIVER_HH

#include <string>
#include "parser.tab.hh"

#define YY_DECL \
  yy::parser::symbol_type yylex (driver& drv)
YY_DECL;

class driver
{
public:
  driver();
  // std::map<std::string, int> variables;
  int parse(const std::string& file);
  int result;
  std::string file;
  // Whether to generate parser debug traces.
  bool trace_parsing;
  void scan_begin();
  void scan_end();
  // Whether to generate scanner debug traces.
  bool trace_scanning;
  // The token's location used by the scanner.
  yy::location location;
};

#endif // ! DRIVER_HH