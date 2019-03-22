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

%union
{
    int integer;
    char character;
    char *string;
    struct astnode *node;
    int enumerator;
}

%type <node> enum_specifier enumerator_list enumerator constant_expression jump_statement expression assignment_expression conditional_expression logical_or_expression logical_and_expression inclusive_or_expression exclusive_or_expression and_expression equality_expression relational_expression shift_expression additive_expression multiplicative_expression cast_expression unary_expression postfix_expression primary_expression constant
%type <integer> INTEGER
%type <string> IDENTIFIER
%type <character> CHARACTER_CONSTANT
%type <enumerator> struct_or_union storage_class_specifier type_qualifier;

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
    AUTO { $$ = AST_AUTO; } | REGISTER { $$ = AST_REGISTER; } | STATIC { $$ = AST_STATIC; }| EXTERN { $$ = AST_EXTERN; } | TYPEDEF { $$ = AST_TYPEDEF; }
    ;

type_specifier:
    VOID | CHAR | SHORT | INT | LONG | FLOAT | DOUBLE | SIGNED | UNSIGNED | struct_or_union_specifier | enum_specifier
    ;

type_qualifier:
    CONST { $$ = AST_CONST; } | VOLATILE { $$ = AST_VOLATILE; }
    ;

struct_or_union_specifier:
    struct_or_union IDENTIFIER '{' struct_declaration_list '}' |
    struct_or_union '{' struct_declaration_list '}' |
    struct_or_union IDENTIFIER
    ;

struct_or_union:
    STRUCT { $$ = AST_STRUCT; } | UNION { $$ = AST_UNION; }
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
    ENUM IDENTIFIER '{' enumerator_list '}' { $$ = create_enum_specifier_node($2, $4); } |
    ENUM IDENTIFIER { $$ = create_enum_specifier_node($2, NULL); }
    ;

enumerator_list:
    enumerator |
    enumerator_list ',' enumerator { $3->next = $1; $$ = $3; }
    ;

enumerator:
    IDENTIFIER { $$ = create_enumerator_node($1, NULL); } |
    IDENTIFIER '=' constant_expression { $$ = create_enumerator_node($1, $3); }
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
    IF '(' expression ')' statement ELSE statement |
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
    GOTO IDENTIFIER { $$ = create_jump_statement_node(AST_GOTO, NULL); } |
    CONTINUE ';' { $$ = create_jump_statement_node(AST_CONTINUE, NULL); } |
    BREAK ';' { $$ = create_jump_statement_node(AST_BREAK, NULL); } |
    RETURN ';' { $$ = create_jump_statement_node(AST_RETURN, NULL); } |
    RETURN expression ';' { $$ = create_jump_statement_node(AST_RETURN, $2); }
    ;

expression:
    assignment_expression |
    expression ',' assignment_expression { $$ = create_compound_expression_node($1, $3); }
    ;

assignment_expression:
    conditional_expression |
    unary_expression assignment_operator assignment_expression { $$ = create_modify_expression_node($1, $3); /*FIXME: pass assignment_operator*/ }
    ;

assignment_operator:
    '=' | MULT_ASSIGN | DIV_ASSIGN | MOD_ASSIGN | ADD_ASSIGN | MINUS_ASSIGN | LSHIFT_ASSIGN | RSIHFT_ASSIGN | AND_ASSIGN | XOR_ASSIGN | OR_ASSIGN
    ;

conditional_expression:
    logical_or_expression |
    logical_or_expression '?' expression ':' conditional_expression { $$ =  create_conditional_expression_node($1, $3, $5);}
    ;

constant_expression:
    conditional_expression
    ;

logical_or_expression:
    logical_and_expression |
    logical_or_expression OR logical_and_expression { $$ =  create_binary_expression_node($1, $3, AST_LOGICAL_OR);}
    ;

logical_and_expression:
    inclusive_or_expression |
    logical_and_expression AND inclusive_or_expression { $$ =  create_binary_expression_node($1, $3, AST_LOGICAL_AND);}
    ;

inclusive_or_expression:
    exclusive_or_expression |
    inclusive_or_expression '|' exclusive_or_expression { $$ =  create_binary_expression_node($1, $3, AST_BITWISE_OR);}
    ;

exclusive_or_expression:
    and_expression |
    exclusive_or_expression '^' and_expression { $$ =  create_binary_expression_node($1, $3, AST_XOR);}
    ;

and_expression:
    equality_expression |
    and_expression '&' equality_expression { $$ =  create_binary_expression_node($1, $3, AST_BITWISE_AND);}
    ;

equality_expression:
    relational_expression |
    equality_expression EQ relational_expression { $$ =  create_binary_expression_node($1, $3, AST_EQUAL);} |
    equality_expression NE relational_expression { $$ =  create_binary_expression_node($1, $3, AST_NOT_EQUAL);}
    ;

relational_expression:
    shift_expression |
    relational_expression '<' shift_expression { $$ =  create_binary_expression_node($1, $3, AST_LESS_THAN);} |
    relational_expression '>' shift_expression { $$ =  create_binary_expression_node($1, $3, AST_GREATER_THAN);} |
    relational_expression LE shift_expression { $$ =  create_binary_expression_node($1, $3, AST_LESS_THAN_OR_EQUAL);} |
    relational_expression GE shift_expression { $$ =  create_binary_expression_node($1, $3, AST_GREATER_THAN_OR_EQUAL);}
    ;

shift_expression:
    additive_expression |
    shift_expression LSHIFT additive_expression { $$ =  create_binary_expression_node($1, $3, AST_SHIFT_LEFT);} |
    shift_expression RSHIFT additive_expression { $$ =  create_binary_expression_node($1, $3, AST_SHIFT_RIGHT);}
    ;

additive_expression:
    multiplicative_expression |
    additive_expression '+' multiplicative_expression { $$ =  create_binary_expression_node($1, $3, AST_ADDITION);} |
    additive_expression '-' multiplicative_expression { $$ =  create_binary_expression_node($1, $3, AST_SUBTRACTION);}
    ;

multiplicative_expression:
    cast_expression |
    multiplicative_expression '*' cast_expression { $$ =  create_binary_expression_node($1, $3, AST_MULTIPLICATION);} |
    multiplicative_expression '/' cast_expression { $$ =  create_binary_expression_node($1, $3, AST_DIVISION);} |
    multiplicative_expression '%' cast_expression { $$ = create_binary_expression_node($1, $3, AST_MODULUS); }
    ;

cast_expression:
    unary_expression
    ;

unary_expression:
    postfix_expression |
    INCREMENT unary_expression { $$ = create_preincrement_node($2); } |
    DECREMENT unary_expression { $$ = create_predecrement_node($2); } |
    unary_operator cast_expression { $$ = create_unary_expression_node($2); /*FIXME: pass unary_operator*/ }
    ;

unary_operator:
    '&' | '*' | '+' | '-' | '~' | '!'

postfix_expression:
    primary_expression |
    postfix_expression '[' expression ']' { $$ = create_array_reference_node($1, $3); } |
    postfix_expression '.' IDENTIFIER { $$ = create_component_reference_node($1, $3, AST_VALUE); } |
    postfix_expression POINTER IDENTIFIER { $$ = create_component_reference_node($1, $3, AST_REFERENCE); } |
    postfix_expression INCREMENT { $$ = create_postincrement_node($1); } |
    postfix_expression DECREMENT { $$ = create_postdecrement_node($1); }
    ;

primary_expression:
    IDENTIFIER { $$ = create_identifier_node($1); } |
    constant
    ;

constant:
    INTEGER { $$ = create_integer_node($1); } |
    CHARACTER_CONSTANT { $$ = create_character_node($1); }
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
