%{
    #include <stdio.h>
    extern int yylex();
%}

%option noyywrap

%%

[ \t\n]         ;
[0-9]+\.[0-9]+  { printf("Found a float: %s\n", yytext); }
[0-9]+          { printf("Found an integer: %s\n", yytext); }
[a-zA-Z0-9]+    { printf("Found a string: %s\n", yytext); }

%%
