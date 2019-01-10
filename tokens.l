%{
#include <stdio.h>
#include "parser.h"

extern int yylex();
%}

%option noyywrap

%%

[ \t\n]         ;
[0-9]+\.[0-9]+  { yylval.fval = atof(yytext); return FLOAT; }
[0-9]+          { yylval.ival = atoi(yytext); return INT; }
[a-zA-Z0-9]+    { yylval.sval = strdup(yytext); return STRING; }

%%
