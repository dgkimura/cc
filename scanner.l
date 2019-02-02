%{
#include <stdio.h>
#include "parser.h"

extern int yylex();
%}

%option noyywrap

%%

[ \t\n]         ;
"auto"          { return AUTO; }
"break"         { return BREAK; }
"enum"          { return ENUM; }
"case"          { return CASE; }
"char"          { return CHAR; }
"const"         { return CONST; }
"continue"      { return CONTINUE; }
"default"       { return DEFAULT; }
"do"            { return DO; }
"double"        { return DOUBLE; }
"else"          { return ELSE; }
"extern"        { return EXTERN; }
"float"         { return FLOAT; }
"for"           { return FOR; }
"goto"          { return GOTO; }
"if"            { return IF; }
"int"           { return INT; }
"long"          { return LONG; }
"register"      { return REGISTER; }
"return"        { return RETURN; }
"short"         { return SHORT; }
"signed"        { return SIGNED; }
"static"        { return STATIC; }
"struct"        { return STRUCT; }
"switch"        { return SWITCH; }
"typedef"       { return TYPEDEF; }
"union"         { return UNION; }
"unsigned"      { return UNSIGNED; }
"void"          { return VOID; }
"volatile"      { return VOLATILE; }
"while"         { return WHILE; }

[_a-zA-Z]+      { return IDENTIFIER; }
[1-9]+[0-9]*    { return INTEGER; }
'.'             { return CHARACTER_CONSTANT; }

"..."           { return VA_OP; }
"=="            { return EQ; }
"!="            { return NE; }
"<="            { return LE; }
">="            { return GE; }
"<<"            { return LSHIFT; }
">>"            { return RSHIFT; }
"*="            { return MULT_ASSIGN; }
"/="            { return DIV_ASSIGN; }
"%="            { return MOD_ASSIGN; }
"+="            { return ADD_ASSIGN; }
"-="            { return MINUS_ASSIGN; }
"<<="           { return LSHIFT_ASSIGN; }
">>="           { return RSIHFT_ASSIGN; }
"&="            { return AND_ASSIGN; }
"^="            { return XOR_ASSIGN; }
"|="            { return OR_ASSIGN; }
"++"            { return INCREMENT; }
"--"            { return DECREMENT; }
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
">"             { return '>'; }
"<"             { return '<'; }
"!"             { return '!'; }
"~"             { return '~'; }
"?"             { return '?'; }
":"             { return ':'; }

%%
