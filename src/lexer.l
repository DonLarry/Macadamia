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

/*Keywords*/
PRINT           "print"
INPUT           "input"
BOOL_CAST       "bool"
INT_CAST        "int"
FLOAT_CAST      "float"
STRING_CAST     "str"
FALSE           "False"
AWAIT           "await"
ELSE            "else"
IMPORT          "import"
PASS            "pass"
NONE            "None"
BREAK           "break"
EXCEPT          "except"
IN              "in"
RAISE           "raise"
TRUE            "True"
CLASS           "class"
FINALLY         "finally"
IS              "is"
RETURN          "return"
AND             "and"
CONTINUE        "continue"
FOR             "for"
LAMBDA          "lambda"
TRY             "try"
AS              "as"
DEF             "def"
FROM            "from"
NONLOCAL        "nonlocal"
WHILE           "while"
ASSERT          "assert"
DEL             "del"
GLOBAL          "global"
NOT             "not"
WITH            "with"
ASYNC           "async"
ELIF            "elif"
IF              "if"
OR              "or"
YIELD           "yield"

DIGIT [0-9]
CHARACTER [a-zA-ZñÑ]

NUMBER          {DIGIT}+
NPFLOAT         {DIGIT}+"."{DIGIT}*
IDENTIFIER      ({CHARACTER}|"_")({CHARACTER}|{DIGIT}|"_")*
COMMENT        #[^\n]*
STRING          \"[^\n"]*\"

/*Operadores, delimitadores*/
WHITESPACE        [ \r]*
NEWLINE           [\n]
PLUS              [+]
MINUS             [-]
STAR              [*]
SLASH             [/]
LPAR              [(]
RPAR              [)]
LSQB              "["
RSQB              "]"
COLON             [:]
SEMI              ";"
COMMA             [,]
VBAR              [|]
AMPER             [&]
LESS              "<"
GREATER           ">"
EQUAL             [=]
DOT               [.]
PERCENT           [%]
LBRACE            "{"
RBRACE            "}"
TILDE             [~]
CIRCUMFLEX        "^"
EQEQUAL           "=="
NOTEQUAL          "!="
LESSEQUAL         "<="
GREATEREQUAL      ">="
DOUBLESTAR        "**"
PLUSEQUAL         "+="
MINEEQUAL         "-="
STAREQUAL         "*="
SLASHEQUAL        "/="
PERCENTEQUAL      "%="
AMPEREQUAL        "&="
VBAREQUAL         "|="
CIRCUMFLEXEQUAL   "^="
LEFTSHIFTEQUAL    "<<="
RIGHTSHIFTEQUAL   ">>="
DOUBLESTAREQUAL   "**="
DOUBLESLASH       "//"
DOUBLESLASHEQUAL  "//="
RARROW            "->"


%%

{COMMENT}         {}
{NUMBER}          {return yy::parser::make_NUMBER(strtol(yytext, NULL, 10), loc);}
{NPFLOAT}         {return yy::parser::make_NPFLOAT(std::stof(yytext), loc);}

{PRINT}           {return yy::parser::make_PRINT(loc);}
{INPUT}           {return yy::parser::make_INPUT(loc);}
{BOOL_CAST}       {return yy::parser::make_BOOL_CAST(loc);}
{INT_CAST}        {return yy::parser::make_INT_CAST(loc);}
{FLOAT_CAST}      {return yy::parser::make_FLOAT_CAST(loc);}
{STRING_CAST}     {return yy::parser::make_STRING_CAST(loc);}
{FALSE}           {return yy::parser::make_FALSE(loc);}
{AWAIT}           {return yy::parser::make_AWAIT(loc);}
{ELSE}            {return yy::parser::make_ELSE(loc);}
{IMPORT}          {return yy::parser::make_IMPORT(loc);}
{PASS}            {return yy::parser::make_PASS(loc);}
{NONE}            {return yy::parser::make_NONE(loc);}
{BREAK}           {return yy::parser::make_BREAK(loc);}
{EXCEPT}          {return yy::parser::make_EXCEPT(loc);}
{IN}              {return yy::parser::make_IN(loc);}
{RAISE}           {return yy::parser::make_RAISE(loc);}
{TRUE}            {return yy::parser::make_TRUE(loc);}
{CLASS}           {return yy::parser::make_CLASS(loc);}
{FINALLY}         {return yy::parser::make_FINALLY(loc);}
{IS}              {return yy::parser::make_IS(loc);}
{RETURN}          {return yy::parser::make_RETURN(loc);}
{AND}             {return yy::parser::make_AND(loc);}
{CONTINUE}        {return yy::parser::make_CONTINUE(loc);}
{FOR}             {return yy::parser::make_FOR(loc);}
{LAMBDA}          {return yy::parser::make_LAMBDA(loc);}
{TRY}             {return yy::parser::make_TRY(loc);}
{AS}              {return yy::parser::make_AS(loc);}
{DEF}             {return yy::parser::make_DEF(loc);}
{FROM}            {return yy::parser::make_FROM(loc);}
{NONLOCAL}        {return yy::parser::make_NONLOCAL(loc);}
{WHILE}           {return yy::parser::make_WHILE(loc);}
{ASSERT}          {return yy::parser::make_ASSERT(loc);} 
{DEL}             {return yy::parser::make_DEL(loc);}
{GLOBAL}          {return yy::parser::make_GLOBAL(loc);}
{NOT}             {return yy::parser::make_NOT(loc);}
{WITH}            {return yy::parser::make_WITH(loc);}
{ASYNC}           {return yy::parser::make_ASYNC(loc);}
{ELIF}            {return yy::parser::make_ELIF(loc);}
{IF}              {return yy::parser::make_IF(loc);}
{OR}              {return yy::parser::make_OR(loc);}
{YIELD}           {return yy::parser::make_YIELD(loc);}

{IDENTIFIER}      {return yy::parser::make_IDENTIFIER(yytext, loc);}
{STRING}          {return yy::parser::make_STRING(yytext, loc);}

{WHITESPACE}      {}
{NEWLINE}         {return yy::parser::make_NEWLINE(loc);}
{PLUS}            {return yy::parser::make_PLUS(loc);}
{MINUS}           {return yy::parser::make_MINUS(loc);}
{STAR}            {return yy::parser::make_STAR(loc);}
{SLASH}           {return yy::parser::make_SLASH(loc);}
{LPAR}            {return yy::parser::make_LPAR(loc);}
{RPAR}            {return yy::parser::make_RPAR(loc);}
{LSQB}            {return yy::parser::make_LSQB(loc);}
{RSQB}            {return yy::parser::make_RSQB(loc);}
{COLON}           {return yy::parser::make_COLON(loc);}
{SEMI}            {return yy::parser::make_SEMI(loc);}
{COMMA}           {return yy::parser::make_COMMA(loc);}
{VBAR}            {return yy::parser::make_VBAR(loc);}
{AMPER}           {return yy::parser::make_AMPER(loc);}
{LESS}            {return yy::parser::make_LESS(loc);}
{GREATER}         {return yy::parser::make_GREATER(loc);}
{EQUAL}           {return yy::parser::make_EQUAL(loc);}
{DOT}             {return yy::parser::make_DOT(loc);}
{PERCENT}         {return yy::parser::make_PERCENT(loc);}
{LBRACE}          {return yy::parser::make_LBRACE(loc);}
{RBRACE}          {return yy::parser::make_RBRACE(loc);}
{TILDE}           {return yy::parser::make_TILDE(loc);}
{CIRCUMFLEX}      {return yy::parser::make_CIRCUMFLEX(loc);}
{EQEQUAL}         {return yy::parser::make_EQEQUAL(loc);}
{NOTEQUAL}        {return yy::parser::make_NOTEQUAL(loc);}
{LESSEQUAL}       {return yy::parser::make_LESSEQUAL(loc);}
{GREATEREQUAL}    {return yy::parser::make_GREATEREQUAL(loc);}
{DOUBLESTAR}      {return yy::parser::make_DOUBLESTAR(loc);}
{PLUSEQUAL}       {return yy::parser::make_PLUSEQUAL(loc);}
{MINEEQUAL}       {return yy::parser::make_MINEEQUAL(loc);}
{STAREQUAL}       {return yy::parser::make_STAREQUAL(loc);}
{SLASHEQUAL}      {return yy::parser::make_SLASHEQUAL(loc);}
{PERCENTEQUAL}    {return yy::parser::make_PERCENTEQUAL(loc);}
{AMPEREQUAL}      {return yy::parser::make_AMPEREQUAL(loc);}
{VBAREQUAL}       {return yy::parser::make_VBAREQUAL(loc);}
{CIRCUMFLEXEQUAL} {return yy::parser::make_CIRCUMFLEXEQUAL(loc);}
{LEFTSHIFTEQUAL}  {return yy::parser::make_LEFTSHIFTEQUAL(loc);}
{RIGHTSHIFTEQUAL} {return yy::parser::make_RIGHTSHIFTEQUAL(loc);}
{DOUBLESTAREQUAL} {return yy::parser::make_DOUBLESTAREQUAL(loc);}
{DOUBLESLASH}     {return yy::parser::make_DOUBLESLASH(loc);}
{DOUBLESLASHEQUAL} {return yy::parser::make_DOUBLESLASHEQUAL(loc);}
{RARROW}          {return yy::parser::make_RARROW(loc);}

.                 {std::cerr << "LEXICAL ERROR " << yytext << std::endl;}
<<EOF>>           {return yy::parser::make_END(loc);}
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
