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

/*Keywords*/
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
NPFLOAT         {DIGIT}+("."{DIGIT}+)?
IDENTIFIER      ({CHARACTER}|"_")({CHARACTER}|{DIGIT}|"_")*
COMMENTS        #[^\n]*
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
PORCENT           [%]
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

{COMMENTS}        {}
{NUMBER}          {return yy::parser::make_NUMBER(strtol(yytext, NULL, 10), loc);}
{NPFLOAT}         {return yy::parser::make_NPFLOAT(strtol(yytext, NULL, 10), loc);}

{FALSE}           {return yy::parser::make_FALSE(yytext, loc);}    
{AWAIT}           {return yy::parser::make_AWAIT(yytext, loc);}    
{ELSE}            {return yy::parser::make_ELSE(yytext, loc);}      
{IMPORT}          {return yy::parser::make_IMPORT(yytext, loc);}   
{PASS}            {return yy::parser::make_PASS(yytext, loc);}
{NONE}            {return yy::parser::make_NONE(yytext, loc);}     
{BREAK}           {return yy::parser::make_BREAK(yytext, loc);}     
{EXCEPT}          {return yy::parser::make_EXCEPT(yytext, loc);}    
{IN}              {return yy::parser::make_IN(yytext, loc);}    
{RAISE}           {return yy::parser::make_RAISE(yytext, loc);}
{TRUE}            {return yy::parser::make_TRUE(yytext, loc);}    
{CLASS}           {return yy::parser::make_CLASS(yytext, loc);}    
{FINALLY}         {return yy::parser::make_FINALLY(yytext, loc);}    
{IS}              {return yy::parser::make_IS(yytext, loc);}      
{RETURN}          {return yy::parser::make_RETURN(yytext, loc);}
{AND}             {return yy::parser::make_AND(yytext, loc);}     
{CONTINUE}        {return yy::parser::make_CONTINUE(yytext, loc);}  
{FOR}             {return yy::parser::make_FOR(yytext, loc);}      
{LAMBDA}          {return yy::parser::make_LAMBDA(yytext, loc);}   
{TRY}             {return yy::parser::make_TRY(yytext, loc);}
{AS}              {return yy::parser::make_AS(yytext, loc);}       
{DEF}             {return yy::parser::make_DEF(yytext, loc);}
{FROM}            {return yy::parser::make_FROM(yytext, loc);}
{NONLOCAL}        {return yy::parser::make_NONLOCAL(yytext, loc);}
{WHILE}           {return yy::parser::make_WHILE(yytext, loc);}
{ASSERT}          {return yy::parser::make_ASSERT(yytext, loc);} 
{DEL}             {return yy::parser::make_DEL(yytext, loc);}
{GLOBAL}          {return yy::parser::make_GLOBAL(yytext, loc);}
{NOT}             {return yy::parser::make_NOT(yytext, loc);}
{WITH}            {return yy::parser::make_WITH(yytext, loc);}
{ASYNC}           {return yy::parser::make_ASYNC(yytext, loc);}
{ELIF}            {return yy::parser::make_ELIF(yytext, loc);}
{IF}              {return yy::parser::make_IF(yytext, loc);}
{OR}              {return yy::parser::make_OR(yytext, loc);}
{YIELD}           {return yy::parser::make_YIELD(yytext, loc);}

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
{PORCENT}         {return yy::parser::make_PORCENT(loc);}
{LBRACE}          {return yy::parser::make_LBRACE(loc);}
{RBRACE}          {return yy::parser::make_RBRACE(loc);}
{TILDE}           {return yy::parser::make_TILDE(loc);}
{CIRCUMFLEX}      {return yy::parser::make_CIRCUMFLEX(loc);}
{EQEQUAL}         {return yy::parser::make_EQEQUAL(yytext, loc);}
{NOTEQUAL}        {return yy::parser::make_NOTEQUAL(yytext, loc);}
{LESSEQUAL}       {return yy::parser::make_LESSEQUAL(yytext, loc);}
{GREATEREQUAL}    {return yy::parser::make_GREATEREQUAL(yytext, loc);}
{DOUBLESTAR}      {return yy::parser::make_DOUBLESTAR(yytext, loc);}
{PLUSEQUAL}       {return yy::parser::make_PLUSEQUAL(yytext, loc);}
{MINEEQUAL}       {return yy::parser::make_MINEEQUAL(yytext, loc);}
{STAREQUAL}       {return yy::parser::make_STAREQUAL(yytext, loc);}
{SLASHEQUAL}      {return yy::parser::make_SLASHEQUAL(yytext, loc);}
{PERCENTEQUAL}    {return yy::parser::make_PERCENTEQUAL(yytext, loc);}
{AMPEREQUAL}      {return yy::parser::make_AMPEREQUAL(yytext, loc);}
{VBAREQUAL}       {return yy::parser::make_VBAREQUAL(yytext, loc);}
{CIRCUMFLEXEQUAL} {return yy::parser::make_CIRCUMFLEXEQUAL(yytext, loc);}
{LEFTSHIFTEQUAL}  {return yy::parser::make_LEFTSHIFTEQUAL(yytext,loc);}
{RIGHTSHIFTEQUAL} {return yy::parser::make_RIGHTSHIFTEQUAL(yytext,loc);}
{DOUBLESTAREQUAL} {return yy::parser::make_DOUBLESTAREQUAL(yytext,loc);}
{DOUBLESLASH}     {return yy::parser::make_DOUBLESLASH(yytext,loc);}
{DOUBLESLASHEQUAL} {return yy::parser::make_DOUBLESLASHEQUAL(yytext,loc);}
{RARROW}          {return yy::parser::make_RARROW(yytext,loc);}

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