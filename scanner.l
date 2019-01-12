%{
#include <stdio.h>
#include "parser.h"

extern int yylex();
%}

%option noyywrap

%%

[ \t\n]         ;
[0-9]+          { yylval.ival = atoi(yytext); return INTEGER; }

">="            return GE;

%%
