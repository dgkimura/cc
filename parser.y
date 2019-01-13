%{

/* Prologue */

#include <stdio.h>

#include "ast.h"

extern int yylex(); extern int yyparse();
void yyerror(const char *s);

struct node *create_const_node(const int value);

struct node *create_binaryop_node(enum op op, struct node *lhs, struct node *rhs);
%}

/* Bison Declarations */

%union
{
    int ival;
    struct node *nptr;
}

%token <ival> NUMBER

%left GE

%type <nptr> statement expression

%%

/* Gammar Rules */

statement:
    | expression ';'
    {
        $$ = $1;
    }
    ;

expression:
    | expression GE expression
    {
        $$ = create_binaryop_node(OP_GE, $1, $3);
    }
    | NUMBER
    {
        $$ = create_const_node($1);
    }
    ;
%%

/* Epilogue */

struct node *
create_binaryop_node(enum op op, struct node *lhs, struct node *rhs)
{
    printf("bison found expr: %d [%d] %d\n", lhs->constant.value, op, rhs->constant.value);
    struct node *n = malloc(sizeof(struct node));
    n->type = OPERATOR;
    n->binaryop.lhs = lhs;
    n->binaryop.rhs = rhs;

    return n;
}

struct node *
create_const_node(const int value)
{
    printf("bison found an int: %d\n", value);

    struct node *n = malloc(sizeof(struct node));

    n->type = CONSTANT;
    n->constant.value = value;
    return n;
}

void
yyerror(const char *s)
{
  fprintf(stderr, "error: %s\n", s);
}
