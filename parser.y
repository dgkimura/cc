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
%token IDENTIFIER INTEGER CHARACTER_CONSTANT
%token VA_OP
%token IF ELSE SWITCH FOR DO WHILE GOTO CONTINUE BREAK RETURN CASE DEFAULT
%token AND OR EQ NE LE GE LSHIFT RSHIFT
%token MULT_ASSIGN DIV_ASSIGN MOD_ASSIGN ADD_ASSIGN MINUS_ASSIGN LSHIFT_ASSIGN RSIHFT_ASSIGN AND_ASSIGN XOR_ASSIGN OR_ASSIGN POINTER
%token INCREMENT DECREMENT
%token STRUCT UNION ENUM

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
    VOID | CHAR | SHORT | INT | LONG | FLOAT | DOUBLE | SIGNED | UNSIGNED | struct_or_union_specifier | enum_specifier
    ;

type_qualifier:
    CONST | VOLATILE
    ;

struct_or_union_specifier:
    struct_or_union IDENTIFIER '{' struct_declaration_list '}' |
    struct_or_union '{' struct_declaration_list '}' |
    struct_or_union IDENTIFIER
    ;

struct_or_union:
    STRUCT | UNION
    ;

struct_declaration_list:
    struct_declaration |
    struct_declaration_list struct_declaration
    ;

init_declarator_list:
    init_declarator |
    init_declarator_list ',' init_declarator
    ;

init_declarator:
    declarator |
    declarator '=' initializer
    ;

struct_declaration:
    specifier_qualifier_list struct_declarator_list ';'
    ;

specifier_qualifier_list:
    type_qualifier specifier_qualifier_list |
    type_qualifier |
    type_specifier specifier_qualifier_list |
    type_specifier |
    ;

struct_declarator_list:
    struct_declarator |
    struct_declarator_list ',' struct_declarator
    ;

struct_declarator:
    declarator |
    declarator ':' constant_expression |
    ':' constant_expression
    ;

enum_specifier:
    ENUM IDENTIFIER '{' enumerator_list '}' |
    ENUM IDENTIFIER
    ;

enumerator_list:
    enumerator |
    enumerator_list ',' enumerator
    ;

enumerator:
    IDENTIFIER |
    IDENTIFIER '=' constant_expression
    ;

declarator:
    direct_declarator |
    pointer direct_declarator
    ;

direct_declarator:
    IDENTIFIER |
    direct_declarator '[' constant_expression ']' |
    direct_declarator '(' ')' |
    direct_declarator '(' parameter_type_list ')'
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
    labeled_statement |
    expression_statement |
    compound_statement |
    selection_statement |
    iteration_statement |
    jump_statement
    ;

labeled_statement:
     IDENTIFIER ':' statement |
     CASE constant_expression ':' statement |
     DEFAULT ':' statement
     ;

expression_statement:
    ';' |
    expression ';'
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

jump_statement:
    GOTO IDENTIFIER |
    CONTINUE ';' |
    BREAK ';' |
    RETURN ';' |
    RETURN expression ';'
    ;

expression:
    assignment_expression |
    expression ',' assignment_expression
    ;

assignment_expression:
    conditional_expression |
    unary_expression assignment_operator assignment_expression
    ;

assignment_operator:
    '=' | MULT_ASSIGN | DIV_ASSIGN | MOD_ASSIGN | ADD_ASSIGN | MINUS_ASSIGN | LSHIFT_ASSIGN | RSIHFT_ASSIGN | AND_ASSIGN | XOR_ASSIGN | OR_ASSIGN
    ;

conditional_expression:
    logical_or_expression |
    logical_or_expression '?' expression ':' conditional_expression
    ;

constant_expression:
    conditional_expression
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
    postfix_expression |
    INCREMENT unary_expression |
    DECREMENT unary_expression |
    unary_operator cast_expression
    ;

unary_operator:
    '&' | '*' | '+' | '-' | '~' | '!'

postfix_expression:
    primary_expression |
    postfix_expression '[' expression ']' |
    postfix_expression '.' IDENTIFIER |
    postfix_expression POINTER IDENTIFIER |
    postfix_expression INCREMENT |
    postfix_expression DECREMENT
    ;

primary_expression:
    IDENTIFIER |
    constant
    ;

constant:
    INTEGER |
    CHARACTER_CONSTANT

%%

/* Epilogue */

#include <stdlib.h>

void
yyerror(const char *s)
{
    fprintf(stderr, "error: %s\n", s);
    exit(1);
}
