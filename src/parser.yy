%skeleton "lalr1.cc" // -*- C++ -*-
%require "3.5.1"
%defines
%define api.token.constructor
%define api.value.type variant
%define parse.assert
%code requires
{
#include "types.hh"
#include <iostream>
#include <stdio.h>
#include <fstream>
#include <sstream>
#include <string>
struct driver;
}
%param { driver& drv }
%locations
%define parse.trace
%define parse.error verbose
%code
{
#include "driver.hh"
}
%define api.token.prefix {TOK_}

//Listado de Terminales
%token  PRINT     "print"
%token  INPUT     "input"
%token  BOOL_TYPE "bool"
%token  INT_TYPE  "int"
%token  FLOAT_TYPE "float"
%token  STRING_TYPE "str"
%token  FALSE     "False"
%token  AWAIT     "await"
%token  ELSE      "else"
%token  IMPORT    "import"
%token  PASS      "pass"
%token  NONE      "None"
%token  BREAK     "break"
%token  EXCEPT    "except"
%token  IN        "in"
%token  RAISE     "raise"
%token  TRUE      "True"
%token  CLASS     "class"
%token  FINALLY   "finally"
%token  IS        "is"
%token  RETURN    "return"
%token  AND       "and"
%token  CONTINUE  "continue"
%token  FOR       "for"
%token  LAMBDA    "lambda"
%token  TRY       "try"
%token  AS        "as"
%token  DEF       "def"
%token  FROM      "from"
%token  NONLOCAL  "nonlocal"
%token  WHILE     "while"
%token  ASSERT    "assert"
%token  DEL       "del"
%token  GLOBAL    "global"
%token  NOT       "not"
%token  WITH      "with"
%token  ASYNC     "async"
%token  ELIF      "elif"
%token  IF        "if"
%token  OR        "or"
%token  YIELD     "yield"

%token <int>          NUMBER     "num"
%token <float>        NPFLOAT    "pfnum"
%token <std::string>  IDENTIFIER "id"
%token                COMMENT
%token <std::string>  STRING

%token  NEWLINE
%token  PLUS      "+"
%token  MINUS     "-"
%token  STAR      "*"
%token  SLASH     "/"
%token  LPAR      "("
%token  RPAR      ")"
%token  LSQB      "["
%token  RSQB      "]"
%token  COLON     ":"
%token  SEMI      ";"
%token  COMMA     ","
%token  VBAR      "|"
%token  AMPER     "&"
%token  LESS      "<"
%token  GREATER   ">"
%token  EQUAL     "="
%token  DOT       "."
%token  PERCENT   "%"
%token  LBRACE    "{"
%token  RBRACE    "}"
%token  TILDE     "~"
%token  CIRCUMFLEX "^"
%token  EQEQUAL   "=="
%token  NOTEQUAL  "!="
%token  LESSEQUAL "<="
%token  GREATEREQUAL ">="
%token  DOUBLESTAR   "**"
%token  PLUSEQUAL    "+="
%token  MINEEQUAL    "-="
%token  STAREQUAL    "*="
%token  SLASHEQUAL   "/="
%token  PERCENTEQUAL "%="
%token  AMPEREQUAL   "&="
%token  VBAREQUAL    "|="
%token  CIRCUMFLEXEQUAL "^="
%token  LEFTSHIFTEQUAL  "<<="
%token  RIGHTSHIFTEQUAL ">>="
%token  DOUBLESTAREQUAL "**="
%token  DOUBLESLASH     "//"
%token  DOUBLESLASHEQUAL "//="
%token  RARROW           "->"

%token  END 0 "eof"


%left PLUS MINUS
%left DOUBLESLASH
%left STAR SLASH PERCENT

// Non-terminal definitions

%type <std::string> ValuableExpression

%type <std::string> Number
%type <Number*> LiteralNumber
%type <Number*> LiteralNumberOperation

%type <std::string> String
%type <String*> LiteralString
%type <String*> LiteralStringOperation

%type <std::string> Boolean
%type <bool> LiteralBoolean

%type <std::string> VarOperation

%type <std::string> NormalPrintingNonTerminals

// Built-in functions

%type <String*> Input
%type <std::string> Bool
%type <std::string> Int
%type <std::string> Float
%type <std::string> Str

%printer { yyoutput << $$; } <*>;

%%
%start Last;

Last: First Expressions
{
  drv.out << "return 0;" << std::endl;
  drv.out << "}" << std::endl;
  std::ofstream out("tmp/" + drv.outputFile);
  out << drv.out.str();
  out.close();
}

First: %empty
{
  drv.out << "#include<iostream>\n";

  drv.out << "bool to_bool(const bool &b) {return b;}\n";
  drv.out << "bool to_bool(const int &i) {return i;}\n";
  drv.out << "bool to_bool(const float &f) {return f;}\n";
  drv.out << "bool to_bool(const std::string& s) {return !s.empty();}\n";

  drv.out << "int to_int(const bool &b) {return b;}\n";
  drv.out << "int to_int(const int &i) {return i;}\n";
  drv.out << "int to_int(const float &f) {return f;}\n";
  drv.out << "int to_int(const std::string& s) {return atoi(s.c_str());}\n";

  drv.out << "float to_float(const bool &b) {return b;}\n";
  drv.out << "float to_float(const int &i) {return i;}\n";
  drv.out << "float to_float(const float &f) {return f;}\n";
  drv.out << "float to_float(const std::string& s) {return atof(s.c_str());}\n";

  drv.out << "int main() {\n";
  drv.out << "std::string str;\n";
}

Expressions:
  %empty {}
  |
  Expressions PossibleExpression {}

PossibleExpression:
  Expression {}
  |
  NEWLINE {}

Expression:
  ValuableExpression {}
  |
  NonValuableExpression {}

NonValuableExpression:
  Print {}
  |
  VarDeclaration {}

ValuableExpression:
  Boolean {$$ = $1;}
  |
  Number {$$ = $1;}
  |
  String {$$ = $1;}
  |
  IDENTIFIER {$$ = $1;}
  |
  VarOperation {$$ = $1;}

// Numbers

Number:
  LiteralNumber {$$ = $1->codegen();}
  |
  Int {$$ = $1;}
  |
  Float {$$ = $1;}
//  |
//  VarInteger
//  {
//    $$ = "str";
//  }

LiteralNumber:
  NUMBER
  {
    auto num = new IntegerNumber($1);
    drv.expressions.push_back(num);
    $$ = num;
  }
  |
  NPFLOAT
  {
    auto num = new FloatNumber($1);
    drv.expressions.push_back(num);
    $$ = num;
  }
  |
  LiteralNumberOperation

LiteralNumberOperation:
  LiteralNumber PLUS LiteralNumber
  {
    auto r = add(*$1, *$3);
    drv.expressions.push_back(r);
    $$ = r;
  }
  |
  LiteralNumber MINUS LiteralNumber
  {
    auto r = sub(*$1, *$3);
    drv.expressions.push_back(r);
    $$ = r;
  }
  |
  LiteralNumber STAR LiteralNumber
  {
    auto r = mul(*$1, *$3);
    drv.expressions.push_back(r);
    $$ = r;
  }
  |
  LiteralNumber DOUBLESLASH LiteralNumber
  {
    auto r = div_floor(*$1, *$3);
    drv.expressions.push_back(r);
    $$ = r;
  }
  |
  LiteralNumber PLUS Boolean
  {
    auto num = new IntegerNumber($3=="true");
    drv.expressions.push_back(num);
    auto r = add(*$1, *num);
    drv.expressions.push_back(r);
    $$ = r;
  }
  |
  LiteralNumber MINUS Boolean
  {
    auto num = new IntegerNumber($3=="true");
    drv.expressions.push_back(num);
    auto r = sub(*$1, *num);
    drv.expressions.push_back(r);
    $$ = r;
  }
  |
  LiteralNumber STAR Boolean
  {
    auto num = new IntegerNumber($3=="true");
    drv.expressions.push_back(num);
    auto r = mul(*$1, *num);
    drv.expressions.push_back(r);
    $$ = r;
  }
  |
  LiteralNumber SLASH Boolean
  {
    auto num = new IntegerNumber($3=="true");
    drv.expressions.push_back(num);
    auto r = div(*$1, *num);
    drv.expressions.push_back(r);
    $$ = r;
  }
  |
  LiteralNumber DOUBLESLASH Boolean
  {
    auto num = new IntegerNumber($3=="true");
    drv.expressions.push_back(num);
    auto r = div_floor(*$1, *num);
    drv.expressions.push_back(r);
    $$ = r;
  }

//VarInteger:
//  // Some productions

// Strings

String:
  LiteralString {$$ = $1->codegen();}
  |
  VarStr {$$ = "str";}
  |
  Str {$$ = $1;}

LiteralString:
  STRING
  {
    auto str = new String($1.substr(1, $1.size() - 2));
    $$ = str;
  }
  |
  LiteralStringOperation

LiteralStringOperation:
  LiteralString PLUS LiteralString {$$ = add(*$1, *$3);}

VarStr:
  Input


// Booleans

Boolean:
  LiteralBoolean {$$ = ($1 ? "true" : "false");}
  |
  Bool {$$ = $1;}

LiteralBoolean:
  TRUE {$$ = true;}
  |
  FALSE {$$ = false;}


// Built-in functions

NormalPrintingNonTerminals:
  Number {$$ = $1;}
  |
  String {$$ = $1;}
  |
  IDENTIFIER {$$ = $1;}
  |
  VarOperation {$$ = $1;}

Print:
  PRINT LPAR RPAR
  {
    drv.out << "std::cout << \"\\n\";" << std::endl;
  }
  |
  PRINT LPAR NormalPrintingNonTerminals RPAR
  {
    drv.out << "std::cout<<" << $3 << "<<std::endl;" << std::endl;
  }
  |
  PRINT LPAR Boolean RPAR
  {
    drv.out << "std::cout<<" << (($3=="true")?"True":"False") << "<<std::endl;" << std::endl;
  }


InputPrompt:
  %empty {}
  |
  String
  {
    drv.out << "std::cout << " << $1 << ";" << std::endl;
  }

Input:
  INPUT LPAR InputPrompt RPAR
  {
    drv.out << "getline(std::cin, str);" << std::endl;
  }

Bool:
  BOOL_TYPE LPAR LiteralBoolean RPAR
  {
    $$ = ($3 ? "true" : "false");
  }
  |
  BOOL_TYPE LPAR LiteralNumber RPAR
  {
    bool t;
    if ($3->type == 1) // FLOAT_NUMBER
      t = atof($3->codegen().c_str());
    else
      t = atol($3->codegen().c_str());
    $$ = t ? "true" : "false";
  }
  |
  BOOL_TYPE LPAR LiteralString RPAR
  {
    $$ = $3->value.empty() ? "false" : "true";
  }
  |
  BOOL_TYPE LPAR Bool RPAR
  {
    $$ = $3;
  }
  |
  BOOL_TYPE LPAR Int RPAR
  {
    $$ = atol($3.c_str()) ? "true" : "false";
  }
  |
  BOOL_TYPE LPAR Float RPAR
  {
    $$ = atof($3.c_str()) ? "true" : "false";
  }
  |
  BOOL_TYPE LPAR Str RPAR
  {
    $$ = $3.empty() ? "false" : "true";
  }
  |
  BOOL_TYPE LPAR IDENTIFIER RPAR
  {
    auto r = drv.identifiers.find($3);
    if (r == drv.identifiers.end())
    {
      std::cerr << "NameError: name \'" << $3 << "\' is not defined" << std::endl;
      drv.exit(1);
    }
    if (r->second == driver::Type::STRING)
      $$ = "!" + $3 + ".empty()";
    else
      $$ = "((bool)" + $3 + ")";
  }

Int:
  INT_TYPE LPAR LiteralBoolean RPAR
  {
    $$ = $3 ? "1" : "0";
  }
  |
  INT_TYPE LPAR LiteralNumber RPAR
  {
    $$ = std::to_string(atol($3->codegen().c_str()));
  }
  |
  INT_TYPE LPAR LiteralString RPAR
  {
    $$ = std::to_string(atol($3->value.c_str()));
  }
  |
  INT_TYPE LPAR Bool RPAR
  {
    $$ = $3=="true" ? "1" : "0";
  }
  |
  INT_TYPE LPAR Int RPAR
  {
    $$ = $3;
  }
  |
  INT_TYPE LPAR Float RPAR
  {
    $$ = std::to_string((int)atof($3.c_str()));
  }
  |
  INT_TYPE LPAR Str RPAR
  {
    $$ = std::to_string(atol($3.c_str()));
  }
  |
  INT_TYPE LPAR IDENTIFIER RPAR
  {
    auto r = drv.identifiers.find($3);
    if (r == drv.identifiers.end())
    {
      std::cerr << "NameError: name \'" << $3 << "\' is not defined" << std::endl;
      drv.exit(1);
    }
    if (r->second == driver::Type::STRING)
      $$ = "atoi(" + $3 + ".c_str())";
    else
      $$ = "((int)" + $3 + ")";
  }
  |
  INT_TYPE LPAR VarOperation RPAR
  {
    $$ = "to_int(" + $3 + ")";
  }

Float:
  FLOAT_TYPE LPAR LiteralBoolean RPAR
  {
    $$ = $3 ? "1.0" : "0.0";
  }
  |
  FLOAT_TYPE LPAR LiteralNumber RPAR
  {
    $$ = std::to_string(atof($3->codegen().c_str()));
  }
  |
  FLOAT_TYPE LPAR LiteralString RPAR
  {
    $$ = std::to_string(atof($3->value.c_str()));
  }
  |
  FLOAT_TYPE LPAR Bool RPAR
  {
    $$ = $3=="true" ? "1.0" : "0.0";
  }
  |
  FLOAT_TYPE LPAR Int RPAR
  {
    $$ = std::to_string(atof($3.c_str()));
  }
  |
  FLOAT_TYPE LPAR Float RPAR
  {
    $$ = $3;
  }
  |
  FLOAT_TYPE LPAR Str RPAR
  {
    $$ = std::to_string(atof($3.c_str()));
  }
  |
  FLOAT_TYPE LPAR IDENTIFIER RPAR
  {
    auto r = drv.identifiers.find($3);
    if (r == drv.identifiers.end())
    {
      std::cerr << "NameError: name \'" << $3 << "\' is not defined" << std::endl;
      drv.exit(1);
    }
    if (r->second == driver::Type::STRING)
      $$ = "atof(" + $3 + ".c_str())";
    else
      $$ = "((float)" + $3 + ")";
  }
  |
  FLOAT_TYPE LPAR VarOperation RPAR
  {
    $$ = "to_float(" + $3 + ")";
  }

Str:
  STRING_TYPE LPAR LiteralBoolean RPAR
  {
    $$ = $3 ? "\"True\"" : "\"False\"";
  }
  |
  STRING_TYPE LPAR LiteralNumber RPAR
  {
    $$ = "\"" + $3->codegen() + "\"";
  }
  |
  STRING_TYPE LPAR LiteralString RPAR
  {
    $$ = $3->codegen();
  }
  |
  STRING_TYPE LPAR Bool RPAR
  {
    $$ = "\"" + $3 + "\"";
  }
  |
  STRING_TYPE LPAR Int RPAR
  {
    $$ = "\"" + $3 + "\"";
  }
  |
  STRING_TYPE LPAR Float RPAR
  {
    $$ = "\"" + $3 + "\"";
  }
  |
  STRING_TYPE LPAR Str RPAR
  {
    $$ = $3;
  }
  |
  STRING_TYPE LPAR IDENTIFIER RPAR
  {
    $$ = "std::to_string(" + $3 + ")";
  }
  |
  STRING_TYPE LPAR VarOperation RPAR
  {
    $$ = "std::to_string(" + $3 + ")";
  }

VarDeclaration:
  IDENTIFIER COLON BOOL_TYPE EQUAL Boolean
  {
    auto r = drv.identifiers.emplace($1, driver::Type::BOOL);
    if (!r.second)
    {
      std::cerr << "Error: Variable " << $1 << " already exists." << std::endl;
      drv.exit(1);
    }
    drv.out << "bool " << $1 << " = " << $5 << ";\n";
  }
  |
  IDENTIFIER COLON INT_TYPE EQUAL LiteralNumber
  {
    auto r = drv.identifiers.emplace($1, driver::Type::INT);
    if (!r.second)
    {
      std::cerr << "Error: Variable " << $1 << " already exists." << std::endl;
      drv.exit(1);
    }
    drv.out << "int " << $1 << " = " << *$5 << ";\n";
  }
  |
  IDENTIFIER COLON INT_TYPE EQUAL Int
  {
    auto r = drv.identifiers.emplace($1, driver::Type::INT);
    if (!r.second)
    {
      std::cerr << "Error: Variable " << $1 << " already exists." << std::endl;
      drv.exit(1);
    }
    drv.out << "int " << $1 << " = " << $5 << ";\n";
  }
  |
  IDENTIFIER COLON FLOAT_TYPE EQUAL LiteralNumber
  {
    auto r = drv.identifiers.emplace($1, driver::Type::FLOAT);
    if (!r.second)
    {
      std::cerr << "Error: Variable " << $1 << " already exists." << std::endl;
      drv.exit(1);
    }
    drv.out << "float " << $1 << " = " << *$5 << ";\n";
  }
  |
  IDENTIFIER COLON FLOAT_TYPE EQUAL Float
  {
    auto r = drv.identifiers.emplace($1, driver::Type::FLOAT);
    if (!r.second)
    {
      std::cerr << "Error: Variable " << $1 << " already exists." << std::endl;
      drv.exit(1);
    }
    drv.out << "float " << $1 << " = " << $5 << ";\n";
  }
  |
  IDENTIFIER COLON STRING_TYPE EQUAL String
  {
    auto r = drv.identifiers.emplace($1, driver::Type::STRING);
    if (!r.second)
    {
      std::cerr << "Error: Variable " << $1 << " already exists." << std::endl;
      drv.exit(1);
    }
    drv.out << "std::string " << $1 << " = " << $5 << ";\n";
  }

VarOperation:
  IDENTIFIER PLUS IDENTIFIER
  {
    auto a = drv.identifiers.find($1);
    auto b = drv.identifiers.find($3);
    if (a == drv.identifiers.end())
    {
      std::cerr << "Error: Variable " << $1 << " does not exist." << std::endl;
      drv.exit(1);
    }
    if (b == drv.identifiers.end())
    {
      std::cerr << "Error: Variable " << $3 << " does not exist." << std::endl;
      drv.exit(1);
    }
    if (a->second != b->second)
    {
      if (a->second == driver::Type::STRING)
      {
        // std::cerr << "line " << @2.begin << std::endl;
        std::cerr << "TypeError: can only concatenate str (not \"" << drv.typeName(a->second) << "\") to str." << std::endl;
        drv.exit(1);
      }
      if (b->second == driver::Type::STRING)
      {
        // std::cerr << "line " << @2.begin << std::endl;
        std::cerr << "TypeError: unsupported operand type(s) for +: \'" << drv.typeName(a->second) << "\' and \'str\'" << std::endl;
        drv.exit(1);
      }
    }
    $$ = $1 + "+" + $3;
  }

%%

void yy::parser::error(const location_type& location, const std::string& error)
{
  std::cerr << error << std::endl;
}
