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

%type <node> iteration_statement declaration_list declaration init_declarator_list init_declarator initializer declarator direct_declarator pointer type_qualifier_list parameter_type_list parameter_list parameter_declaration declaration_specifiers storage_class_specifier type_specifier type_qualifier enum_specifier enumerator_list enumerator constant_expression jump_statement expression assignment_expression conditional_expression logical_or_expression logical_and_expression inclusive_or_expression exclusive_or_expression and_expression equality_expression relational_expression shift_expression additive_expression multiplicative_expression cast_expression unary_expression postfix_expression primary_expression constant
%type <integer> INTEGER
%type <string> IDENTIFIER
%type <character> CHARACTER_CONSTANT
%type <enumerator> struct_or_union;

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
    declaration_specifiers ';' { $$ = create_declaration_node($1, NULL); } |
    declaration_specifiers init_declarator_list ';' { $$ = create_declaration_node($1, $2); }
    ;

declaration_list:
    declaration { $$ = create_declaration_list_node(NULL, $1); } |
    declaration_list declaration { $$ = create_declaration_list_node($1, $2); }
    ;

declaration_specifiers:
    storage_class_specifier { $$ = create_declaration_secifiers_node(NULL, $1); } |
    storage_class_specifier declaration_specifiers { $$ = create_declaration_secifiers_node($2, $1); } |
    type_specifier { $$ = create_declaration_secifiers_node(NULL, $1); } |
    type_specifier declaration_specifiers { $$ = create_declaration_secifiers_node($2, $1); } |
    type_qualifier { $$ = create_declaration_secifiers_node(NULL, $1); } |
    type_qualifier declaration_specifiers { $$ = create_declaration_secifiers_node($2, $1); }
    ;

storage_class_specifier:
    AUTO { $$ = create_storage_class_specifier_node(AST_AUTO); } |
    REGISTER { $$ = create_storage_class_specifier_node(AST_REGISTER); } |
    STATIC { $$ = create_storage_class_specifier_node(AST_STATIC); } |
    EXTERN { $$ = create_storage_class_specifier_node(AST_EXTERN); } |
    TYPEDEF { $$ = create_storage_class_specifier_node(AST_TYPEDEF); }
    ;

type_specifier:
    VOID { $$ = create_type_specifier_node(AST_VOID, NULL); } |
    CHAR { $$ = create_type_specifier_node(AST_CHAR, NULL); } |
    SHORT { $$ = create_type_specifier_node(AST_SHORT, NULL); } |
    INT { $$ = create_type_specifier_node(AST_INT, NULL); } |
    LONG { $$ = create_type_specifier_node(AST_LONG, NULL); } |
    FLOAT { $$ = create_type_specifier_node(AST_FLOAT, NULL); } |
    DOUBLE { $$ = create_type_specifier_node(AST_DOUBLE, NULL); } |
    SIGNED { $$ = create_type_specifier_node(AST_SIGNED, NULL); } |
    UNSIGNED { $$ = create_type_specifier_node(AST_UNSIGNED, NULL); } |
    struct_or_union_specifier { $$ = create_type_specifier_node(AST_NONE, NULL/*FIXME: $1*/); } |
    enum_specifier
    ;

type_qualifier:
    CONST { $$ = create_type_qualifier_node(AST_CONST); } |
    VOLATILE { $$ = create_type_qualifier_node(AST_VOLATILE); }
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
    init_declarator { $$ = create_init_declarator_list_node(NULL, $1); } |
    init_declarator_list ',' init_declarator { $$ = create_init_declarator_list_node($1, $3); }
    ;

init_declarator:
    declarator { $$ = create_init_declarator_node($1, NULL); } |
    declarator '=' initializer { $$ = create_init_declarator_node($1, $3); }
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
    pointer direct_declarator { $2->declarator_pointer = $1; }
    ;

direct_declarator:
    IDENTIFIER { $$ = create_declarator_node($1, NULL, NULL, NULL); } |
    direct_declarator '[' constant_expression ']' { $$ = create_declarator_node(NULL, $1, $3, NULL); } |
    direct_declarator '(' ')' { $$ = create_declarator_node(NULL, $1, NULL, NULL); } |
    direct_declarator '(' parameter_type_list ')' { $$ = create_declarator_node(NULL, $1, NULL, $3); }
    ;

pointer:
    '*' { $$ = create_pointer_node(NULL, NULL); } |
    '*' type_qualifier_list { $$ = create_pointer_node($2, NULL); } |
    '*' pointer { $$ = create_pointer_node(NULL, $2); } |
    '*' type_qualifier_list pointer { $$ = create_pointer_node($2, $3); }
    ;

type_qualifier_list:
    type_qualifier { $$ = create_type_qualifier_list_node(NULL, $1); } |
    type_qualifier_list type_qualifier { $$ = create_type_qualifier_list_node($1, $2); }
    ;

parameter_type_list:
    parameter_list  { $$ = create_parameter_type_list_node($1, 'n'); }|
    parameter_list ',' VA_OP { $$ = create_parameter_type_list_node($1, 'y'); }
    ;

parameter_list:
    parameter_declaration { $$ = create_parameter_list_node(NULL, $1); } |
    parameter_list ',' parameter_declaration { $$ = create_parameter_list_node($1, $3); }
    ;

parameter_declaration:
    declaration_specifiers declarator { $$ = create_parameter_declaration_node($1, $2); } |
    declaration_specifiers { $$ = create_parameter_declaration_node($1, NULL); }
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
    WHILE '(' expression ')' statement { $$ = create_iteration_statement_node(NULL, $3, NULL, /*FIXME:$5*/NULL); } |
    DO statement WHILE '(' expression')' ';' { $$ = create_iteration_statement_node(NULL, /*FIXME:$2*/NULL, NULL, $5); } |
    FOR '(' ';' ';' ')' statement { $$ = create_iteration_statement_node(NULL, NULL, NULL, /*FIXME:$6*/NULL); } |
    FOR '(' expression ';' ';' ')' statement { $$ = create_iteration_statement_node($3, NULL, NULL, /*FIXME:$7*/NULL); } |
    FOR '(' expression ';' expression ';' ')' statement { $$ = create_iteration_statement_node($3, $5, NULL, /*FIXME:$8*/NULL); } |
    FOR '(' expression ';' expression ';' expression ')' statement { $$ = create_iteration_statement_node($3, $5, $7, /*FIXME:$9*/NULL); } |
    FOR '(' ';' expression ';' ')' statement { $$ = create_iteration_statement_node(NULL, $4, NULL, /*FIXME:$7*/NULL); } |
    FOR '(' ';' expression ';' expression ')' statement { $$ = create_iteration_statement_node(NULL, $4, $6, /*FIXME:$8*/NULL); } |
    FOR '(' ';' ';' expression ')' statement { $$ = create_iteration_statement_node(NULL, NULL, $5, /*FIXME:$7*/NULL); }
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
