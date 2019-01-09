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
    float fval;
    char *sval;
}

%token <ival> INT
%token <fval> FLOAT
%token <sval> STRING

%%

/* Gammar Rules */

expr:
    INT expr
    {
        printf("bison found an int: %d", $1);
    }
    | FLOAT expr
    {
        printf("bison found an float: %f", $1);
    }
    | STRING expr
    {
        printf("bison found an float: %s", $1);
    }
    | INT
    {
        printf("bison found an int: %d", $1);
    }
    | FLOAT
    {
        printf("bison found an float: %f", $1);
    }
    | STRING
    {
        printf("bison found an float: %s", $1);
    }
    ;
%%

/* Epilogue */

void
yyerror(const char *s)
{
  fprintf(stderr, "error: %s\n", s);
}
