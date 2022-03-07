%skeleton "lalr1.cc" // -*- C++ -*-
%require "3.5.1"
%defines
%define api.token.constructor
%define api.value.type variant
%define parse.assert
%code requires
{
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
%token <std::string>  FALSE     "False"
%token <std::string>  AWAIT     "await"
%token <std::string>  ELSE      "else"       
%token <std::string>  IMPORT    "import"    
%token <std::string>  PASS      "pass"
%token <std::string>  NONE      "None"       
%token <std::string>  BREAK     "break"      
%token <std::string>  EXCEPT    "except"     
%token <std::string>  IN        "in"         
%token <std::string>  RAISE     "raise"
%token <std::string>  TRUE      "True"       
%token <std::string>  CLASS     "class"      
%token <std::string>  FINALLY   "finally"    
%token <std::string>  IS        "is"         
%token <std::string>  RETURN    "return"
%token <std::string>  AND       "and"        
%token <std::string>  CONTINUE  "continue"   
%token <std::string>  FOR       "for"        
%token <std::string>  LAMBDA    "lambda"     
%token <std::string>  TRY       "try"
%token <std::string>  AS        "as"         
%token <std::string>  DEF       "def"        
%token <std::string>  FROM      "from"       
%token <std::string>  NONLOCAL  "nonlocal"   
%token <std::string>  WHILE     "while"
%token <std::string>  ASSERT    "assert"     
%token <std::string>  DEL       "del"        
%token <std::string>  GLOBAL    "global"     
%token <std::string>  NOT       "not"        
%token <std::string>  WITH      "with"
%token <std::string>  ASYNC     "async"      
%token <std::string>  ELIF      "elif"       
%token <std::string>  IF        "if"         
%token <std::string>  OR        "or"         
%token <std::string>  YIELD     "yield"

%token <float>        NUMBER    "num"
%token <std::string>  IDENTIFIER "id"
%token <std::string>  STRING 

%token                NEWLINE
%token                PLUS      "+"
%token                MINUS     "-"
%token                STAR      "*"
%token                SLASH     "/"
%token                LPAR      "("
%token                RPAR      ")"
%token                LSQB      "["
%token                RSQB      "]"		
%token                COLON     ":"
%token                SEMI      ";"
%token                COMMA     ","
%token                VBAR      "|"
%token                AMPER     "&"
%token                LESS      "<"
%token                GREATER   ">"
%token                EQUAL     "="
%token                DOT       "."
%token                PORCENT   "%"
%token                LBRACE    "{"
%token                RBRACE    "}"
%token                TILDE     "~"
%token                CIRCUMFLEX "^"
%token <std::string>  EQEQUAL   "=="
%token <std::string>  NOTEQUAL  "!="
%token <std::string>  LESSEQUAL "<="
%token <std::string>  GREATEREQUAL ">=" 
%token <std::string>  DOUBLESTAR   "**"
%token <std::string>  PLUSEQUAL    "+="
%token <std::string>  MINEEQUAL    "-="
%token <std::string>  STAREQUAL    "*="
%token <std::string>  SLASHEQUAL   "/="
%token <std::string>  PERCENTEQUAL "%="
%token <std::string>  AMPEREQUAL   "&="
%token <std::string>  VBAREQUAL    "|="
%token <std::string>  CIRCUMFLEXEQUAL "^="
%token <std::string>  LEFTSHIFTEQUAL  "<<="
%token <std::string>  RIGHTSHIFTEQUAL ">>="
%token <std::string>  DOUBLESTAREQUAL "**="
%token <std::string>  DOUBLESLASH     "//"
%token <std::string>  DOUBLESLASHEQUAL "//="
%token <std::string>  RARROW           "->"

%token                END 0 "eof"

//Listado de No Terminales
%type <float> E
%type <float> T
%type <float> F

%printer { yyoutput << $$; } <*>;

%%
%start S;

S : E;

E : E "+" T
   |E "-" T
   |T;

T : T "*" F
   |T "/" F
   |F;
   
F : "num";
%%

void yy::parser::error(const location_type& location, const std::string& error)
{
  std::cout << error << std::endl;
}