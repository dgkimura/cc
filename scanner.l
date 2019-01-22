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
"else"          { return ELSE; }
"extern"        { return EXTERN; }
"float"         { return FLOAT; }
"if"            { return IF; }
"int"           { return INT; }
"long"          { return LONG; }
"register"      { return REGISTER; }
"short"         { return SHORT; }
"signed"        { return SIGNED; }
"static"        { return STATIC; }
"switch"        { return SWITCH; }
"typedef"       { return TYPEDEF; }
"unsigned"      { return UNSIGNED; }
"void"          { return VOID; }
"volatile"      { return VOLATILE; }

[_a-zA-Z]+      { return IDENTIFIER; }

"..."           { return VA_OP; }
"=="            { return EQ; }
"!="            { return NE; }
"<="            { return LE; }
">="            { return GE; }
"<<"            { return LSHIFT; }
">>"            { return RSHIFT; }
"+"             { return '+'; }
"-"             { return '-'; }
";"             { return ';'; }
"{"             { return '{'; }
"}"             { return '}'; }
"("             { return '('; }
")"             { return ')'; }
"="             { return '='; }
","             { return ','; }
"*"             { return '*'; }
"|"             { return '|'; }
"^"             { return '^'; }
"&"             { return '&'; }

%%
