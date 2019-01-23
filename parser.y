%{

/* Prologue */

#include <stdio.h>

#include "ast.h"

extern int yylex(); extern int yyparse();
void yyerror(const char *s);

%}

/* Bison Declarations */

%token AUTO REGISTER STATIC EXTERN TYPEDEF
%token VOID CHAR SHORT INT LONG FLOAT DOUBLE SIGNED UNSIGNED
%token CONST VOLATILE
%token IDENTIFIER
%token VA_OP
%token IF ELSE SWITCH FOR DO WHILE
%token AND OR EQ NE LE GE LSHIFT RSHIFT

%start translation_unit

%%

/* Grammar Rules */

translation_unit:
    external_declaration |
    translation_unit external_declaration
    ;

external_declaration:
    function_definition |
    declaration;

function_definition:
    declarator compound_statement |
    declarator declaration_list compound_statement |
    declaration_specifiers declarator compound_statement |
    declaration_specifiers declarator declaration_list compound_statement |
    ;

declaration:
    declaration_specifiers ';' |
    declaration_specifiers init_declarator_list ';'
    ;

declaration_list:
    declaration |
    declaration_list declaration
    ;

declaration_specifiers:
    storage_class_specifier |
    storage_class_specifier declaration_specifiers |
    type_specifier |
    type_specifier declaration_specifiers |
    type_qualifier |
    type_qualifier declaration_specifiers
    ;

storage_class_specifier:
    AUTO | REGISTER | STATIC | EXTERN | TYPEDEF
    ;

type_specifier:
    VOID | CHAR | SHORT | INT | LONG | FLOAT | DOUBLE | SIGNED | UNSIGNED
    ;

type_qualifier:
    CONST | VOLATILE
    ;

init_declarator_list:
    init_declarator |
    init_declarator_list ',' init_declarator
    ;

init_declarator:
    declarator |
    declarator '=' initializer
    ;

declarator:
    direct_declarator |
    pointer direct_declarator
    ;

direct_declarator:
    IDENTIFIER |
    direct_declarator'(' ')' |
    direct_declarator'(' parameter_type_list ')'
    ;

pointer:
    '*' |
    '*' type_qualifier_list |
    '*' pointer |
    '*' type_qualifier_list pointer
    ;

type_qualifier_list:
    type_qualifier |
    type_qualifier_list type_qualifier
    ;

parameter_type_list:
    parameter_list |
    parameter_list ',' VA_OP
    ;

parameter_list:
    parameter_declaration |
    parameter_list ',' parameter_declaration
    ;

parameter_declaration:
    declaration_specifiers declarator|
    declaration_specifiers
    ;

initializer:
    assignment_expression
    ;

statement:
    expression_statement |
    compound_statement |
    selection_statement |
    iteration_statement
    ;

expression_statement:
    ';' |
    expression '';
    ;

compound_statement:
    '{' '}' |
    '{' declaration_list '}' |
    '{' declaration_list statement_list '}' |
    '{' statement_list '}'
    ;

statement_list:
    statement |
    statement_list statement
    ;

selection_statement:
    IF '(' expression ')' statement |
    IF '(' expression ')' ELSE statement |
    SWITCH '(' expression ')' statement
    ;

iteration_statement:
    WHILE '(' expression ')' statement |
    DO statement WHILE '(' expression')' ';' |
    FOR '(' ';' ';' ')' statement |
    FOR '(' expression ';' ';' ')' statement |
    FOR '(' expression ';' expression ';' ')' statement |
    FOR '(' expression ';' expression ';' expression ')' statement |
    FOR '(' ';' expression ';' ')' statement |
    FOR '(' ';' expression ';' expression ')' statement |
    FOR '(' ';' ';' expression ')' statement
    ;

expression:
    assignment_expression |
    expression ',' assignment_expression
    ;

assignment_expression:
    conditional_expression
    ;

conditional_expression:
    logical_or_expression
    ;

logical_or_expression:
    logical_and_expression |
    logical_or_expression OR logical_and_expression
    ;

logical_and_expression:
    inclusive_or_expression |
    logical_and_expression AND inclusive_or_expression
    ;

inclusive_or_expression:
    exclusive_or_expression |
    inclusive_or_expression '|' exclusive_or_expression
    ;

exclusive_or_expression:
    and_expression |
    exclusive_or_expression '^' and_expression
    ;

and_expression:
    equality_expression |
    and_expression '&' equality_expression
    ;

equality_expression:
    relational_expression |
    equality_expression EQ relational_expression |
    equality_expression NE relational_expression
    ;

relational_expression:
    shift_expression |
    relational_expression '<' shift_expression |
    relational_expression '>' shift_expression |
    relational_expression LE shift_expression |
    relational_expression GE shift_expression
    ;

shift_expression:
    additive_expression |
    shift_expression LSHIFT additive_expression |
    shift_expression RSHIFT additive_expression
    ;

additive_expression:
    multiplicative_expression |
    additive_expression '+' multiplicative_expression |
    additive_expression '-' multiplicative_expression
    ;

multiplicative_expression:
    cast_expression |
    multiplicative_expression '*' cast_expression |
    multiplicative_expression '/' cast_expression |
    multiplicative_expression '%' cast_expression
    ;

cast_expression:
    unary_expression
    ;

unary_expression:
    postfix_expression
    ;

postfix_expression:
    primary_expression
    ;

primary_expression:
    IDENTIFIER
    ;

%%

/* Epilogue */

#include <stdlib.h>

void
yyerror(const char *s)
{
    fprintf(stderr, "error: %s\n", s);
    exit(1);
}
