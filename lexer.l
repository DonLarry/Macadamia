%{ // -*- C++ -*-
# include <cerrno>
# include <stdio.h>
# include <string>
# include "driver.hh"
# include "parser.tab.hh"
# undef yywrap
# define yywrap() 1
static yy::location loc;
%}

%option noyywrap nounput batch debug noinput
%option outfile="lexer.cpp"

DIGIT      [0-9]
CHARACTER  [a-zA-ZñÑ]
NUMBER     {DIGIT}+("."{DIGIT}+)?
IDENTIFIER {CHARACTER}({CHARACTER}|{DIGIT}|"_")*
DELIMITER  [\t\r\f" "]

%%
{NUMBER}     {return yy::parser::make_NUMBER(strtol(yytext, NULL, 10), loc);}
{IDENTIFIER} {return yy::parser::make_IDENTIFIER(yytext, loc);}
"+"          {return yy::parser::make_PLUS(loc);}
"-"          {return yy::parser::make_MINUS(loc);}
"*"          {return yy::parser::make_STAR(loc);}
"/"          {return yy::parser::make_SLASH(loc);}
{DELIMITER}  {}
.            {std::cerr << "LEXICAL ERROR " << yytext << std::endl;}
<<EOF>>      {return yy::parser::make_END(loc);}
%%

void driver::scan_begin()
{
  yy_flex_debug = trace_scanning;
  if (file.empty() || file=="-")
  {
    yyin = stdin;
    return;
  }
  if (access(file.c_str(), F_OK) == -1)
  {
    std::cerr << "cannot open " << file << ": " << strerror (errno) << std::endl;
    exit(EXIT_FAILURE);
  }
  yyin = fopen(file.c_str(), "r");
}

void driver::scan_end()
{
  fclose(yyin);
}