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
%left STAR SLASH PERCENT

// Declaración de tipos de no terminales
%type <Number*> Operation
%type <Number*> Number

%printer { yyoutput << $$; } <*>;

%%
%start Last;

Last: First Expressions
{
  std::cout << "-- LAST EXECUTED --" << std::endl;
  drv.out << "return 0;" << std::endl;
  drv.out << "}" << std::endl;
  std::ofstream out("tmp/" + drv.outputFile);
  out << drv.out.str();
  out.close();
}

First: %empty
{
  std::cout << "-- FIRST EXECUTED --" << std::endl;
  drv.out << "#include<iostream>" << std::endl;
  drv.out << "int main() {" << std::endl;
}

Expressions:
  %empty { std::cout << "Expressions -> empty\n"; }
  |
  Expressions PossibleExpression { std::cout << "Expressions -> Expressions PossibleExpression\n"; }


PossibleExpression:
  Expression { std::cout << "PossibleExpression -> Expression\n"; }
  |
  NEWLINE { std::cout << "PossibleExpression -> NEWLINE\n"; }


Expression:
  Number { std::cout << "Expression -> Number\n"; }
  |
  Print { std::cout << "Expression -> Print\n"; }


Number:
  NUMBER {$$ = new IntegerNumber($1); std::cout << "Number -> NUMBER\n"; }
  |
  NPFLOAT {$$ = new FloatNumber($1); std::cout << "Number -> NPFLOAT\n"; }
  |
  Operation


Operation:
  Number PLUS Number {$$ = add(*$1, *$3); std::cout << "Operation -> Number PLUS Number\n"; }
  |
  Number MINUS Number {$$ = sub(*$1, *$3); std::cout << "Operation -> Number MINUS Number\n"; }
  |
  Number STAR Number {$$ = mul(*$1, *$3); std::cout << "Operation -> Number STAR Number\n"; }
  |
  Number SLASH Number {$$ = div(*$1, *$3); std::cout << "Operation -> Number SLASH Number\n"; }

Print:
  PRINT LPAR Number RPAR {drv.out << "std::cout<<" << *$3 << "<<std::endl;" << std::endl; std::cout << "Print -> PRINT LPAR Number RPAR\n"; }
%%

void yy::parser::error(const location_type& location, const std::string& error)
{
  std::cerr << error << std::endl;
}
