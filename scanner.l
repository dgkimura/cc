%{
#include <stdio.h>
#include "parser.h"

extern int yylex();
%}

%option noyywrap

%%

[ \t\n]         ;
[0-9]+          { yylval.ival = atoi(yytext); return integer_constant; }
[a-zA-Z]+       { yylval.sval = yytext; return identifier; }

"->"            { return POINTER_OP; }
"++"            { return INCREMENT_OP; }
"--"            { return DECREMENT_OP; }
";"             { return ';'; }

%%
