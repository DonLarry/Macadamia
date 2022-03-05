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

//Listadode Terminales
%token PLUS "+"
%token MINUS "-"
%token STAR "*"
%token SLASH "/"
%token <std::string> IDENTIFIER "id"
%token <float> NUMBER "num"
%token END 0 "eof"

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