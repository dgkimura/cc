%{

/* Prologue */

#include <stdio.h>

#include "ast.h"

extern int yylex(); extern int yyparse();
void yyerror(const char *s);

struct node *create_variable_node(const char *value);
struct node *create_const_node(const int value);

struct node *create_binaryop_node(enum op op, struct node *lhs, struct node *rhs);
%}

/* Bison Declarations */

%union
{
    int ival;
    char *sval;
    struct node *nptr;
}

%token <ival> integer_constant
%token <sval> identifier

%left POINTER_OP
      INCREMENT_OP
      DECREMENT_OP

%type <nptr> postfix_expression
             primary_expression
             constant

%%

/* Gammar Rules */

postfix_expression:
    primary_expression
    {
        printf("bison found primary_expression\n");
    }
    /* TODO: postfix_expression '[' expression ']' */
    /* TODO: postfix_expression '(' argument_expression_list ')' */
    | postfix_expression '.' identifier
    {
        printf("bison found postfix_expression.%s\n", $3);
    }
    | postfix_expression POINTER_OP identifier
    {
        printf("bison found postfix_expression->%s\n", $3);
    }
    | postfix_expression INCREMENT_OP
    {
        printf("bison found postfix_expression++\n");
    }
    | postfix_expression DECREMENT_OP
    {
        printf("bison found postfix_expression--\n");
    };

primary_expression:
    identifier
    {
        $$ = create_variable_node($1);
    }
    | constant
    /* TODO string */
    /* TODO '(' expression ')' */
    ;

constant:
    integer_constant
    {
        $$ = create_const_node($1);
    };

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
create_variable_node(const char *value)
{
    printf("bison found an identifier: %s\n", value);

    struct node *n = malloc(sizeof(struct node));
    /* TODO: construct variable node */
    return n;
}

struct node *
create_const_node(const int value)
{
    printf("bison found an int: %d\n", value);

    struct node *n = malloc(sizeof(struct node));

    n->type = VALUE;
    n->constant.value = value;
    return n;
}

void
yyerror(const char *s)
{
  fprintf(stderr, "error: %s\n", s);
}
