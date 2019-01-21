%{
#include <stdio.h>
#include "parser.h"

extern int yylex();
%}

%option noyywrap

%%

[ \t\n]         ;
"auto"          { return AUTO; }
"char"          { return CHAR; }
"const"         { return CONST; }
"double"        { return DOUBLE; }
"extern"        { return EXTERN; }
"float"         { return FLOAT; }
"int"           { return INT; }
"long"          { return LONG; }
"register"      { return REGISTER; }
"short"         { return SHORT; }
"signed"        { return SIGNED; }
"static"        { return STATIC; }
"typedef"       { return TYPEDEF; }
"unsigned"      { return UNSIGNED; }
"void"          { return VOID; }
"volatile"      { return VOLATILE; }

[a-zA-Z]+       { return IDENTIFIER; }

"..."           { return VA_OP; }
";"             { return ';'; }
"{"             { return '{'; }
"}"             { return '}'; }
"("             { return '('; }
")"             { return ')'; }
"="             { return '='; }
","             { return ','; }
"*"             { return '*'; }

%%
