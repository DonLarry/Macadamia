#ifndef DRIVER_HH
#define DRIVER_HH

#include <iostream>
#include <string>
#include <map>
#include <set>
#include "parser.tab.hh"

#define YY_DECL \
  yy::parser::symbol_type yylex (driver& drv)
YY_DECL;

struct driver
{
  enum class Type
  {
    BOOL,
    INT,
    FLOAT,
    STRING
  };
  std::vector<Expression*> expressions;
  std::map<std::string, Type> identifiers;
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

  std::string typeName(Type t)
  {
    switch (t)
    {
      case Type::BOOL:
        return "bool";
      case Type::INT:
        return "int";
      case Type::FLOAT:
        return "float";
      case Type::STRING:
        return "str";
      return "unknown";
    }
  }

  int parse(const std::string& file);
  void scan_begin();
  void scan_end();
  void deallocate_memory();
  void exit(int exit_code);

  driver();
  ~driver();
};

#endif // ! DRIVER_HH
