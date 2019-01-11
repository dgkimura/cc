%{

/* Prologue */

#include <stdio.h>

extern int yylex();
extern int yyparse();
void yyerror(const char *s);
%}

/* Bison Declarations */

%union
{
    int ival;
}

%token <ival> INTEGER

%%

/* Gammar Rules */

expr:
    INTEGER expr
    {
        printf("bison found an int: %d\n", $1);
    }
    | INTEGER
    {
        printf("bison found an int: %d\n", $1);
    }
    ;
%%

/* Epilogue */

void
yyerror(const char *s)
{
  fprintf(stderr, "error: %s\n", s);
}
