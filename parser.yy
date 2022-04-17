%skeleton "lalr1.cc" // -*- C++ -*-
%require "3.5.1"
%defines
%define api.token.constructor
%define api.value.type variant
%define parse.assert
%code requires
{
  #include "types.hh"
  #include <string>
  #include <stdio.h>
  class driver;
}
%param { driver& drv }
%locations
%define parse.trace
%define parse.error verbose
%code
{
#include "driver.hh"
#include <iostream>
}
%define api.token.prefix {TOK_}

//Listado de Terminales
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

//Listado de No Terminales
/* %type Expressions */
%type <Expression*> Expression
%type <Number*> Operation
%type <Number*> Number
/* %type Operator */
/* %type Space */

%printer { yyoutput << $$; } <*>;

%%
%start Expressions;

Expressions:
  %empty
|
  Expressions PossibleExpression
;

PossibleExpression:
  Expression
|
  NEWLINE
;

Expression:
  Operation
  {
    std::cout << "Expression -> Operation (";
    $1->printValue();
    std::cout << ")\n";
  }
;

Operation:
  Number
|
  Operation PLUS Number {$$ = $1 + $3;}
|
  Operation MINUS Number {$$ = $1 - $3;}
|
  Operation STAR Number {$$ = $1 * $3;}
|
  Operation SLASH Number {$$ = $1 / $3;}
;

Number :
  NUMBER
  {
    $$ = new IntegerNumber($1);
    std::cout << "Number -> NUMBER (" << $1 << ")\n";
  }
|
NPFLOAT
  {
    $$ = new FloatNumber($1);
    std::cout << "Number -> NPFLOAT (" << $1 << ")\n";
  }
;
%%

void yy::parser::error(const location_type& location, const std::string& error)
{
  std::cout << error << std::endl;
}