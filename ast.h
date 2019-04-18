#ifndef __AST_H__
#define __AST_H__

#include "list.h"

/*
 * An astnode represents one of the following concepts in C: data type,
 * variable, expression, or statement.
 */

enum astnode_type
{
    AST_SPECIFIER_QUALIFIER_LIST,
    AST_STRUCT_DECLARATOR_LIST,
    AST_STRUCT_DECLARATOR,
    AST_FUNCTION_DECLARATION,
    AST_COMPOUND_STATEMENT,
    AST_STATEMENT_LIST,
    AST_LABELED_STATEMENT,
    AST_EXPRESSION_STATEMENT,
    AST_SELECTION_STATEMENT,
    AST_ITERATION_STATEMENT,
    AST_DECLARATION,
    AST_INIT_DECLARATOR_LIST,
    AST_INIT_DECLARATOR,
    AST_DECLARATOR,
    AST_POINTER,
    AST_TYPE_QUALIFIER_LIST,
    AST_PARAMTER_TYPE_LIST,
    AST_PARAMTER_LIST,
    AST_PARAMTER_DECLARATION,
    AST_DECLARATION_SPECIFIERS,
    AST_STORAGE_CLASS_SPECIFIER_NODE,
    AST_TYPE_SPECIFIER_NODE,
    AST_TYPE_QUALIFIER_NODE,
    AST_ENUM_SPECIFIER_NODE,
    AST_ENUMERATOR_NODE,
    AST_JUMP_STATEMENT,
    AST_COMPOUND_EXPRESSION,
    AST_MODIFY_EXPRESSION,
    AST_CONDITIONAL_EXPRESSION,
    AST_MULTIPLICATIVE_EXPRESSION,
    AST_BINARY_EXPRESSION,
    AST_UNARY_EXPRESSION,
    AST_COMPONENT_REFERENCE,
    AST_ARRAY_REFERENCE,
    AST_PREINCREMENT_EXPRESSION,
    AST_PREDECREMENT_EXPRESSION,
    AST_POSTINCREMENT_EXPRESSION,
    AST_POSTDECREMENT_EXPRESSION,
    AST_IDENTIFIER_TYPE,
    AST_INTEGER_TYPE,
    AST_CHARACTER_TYPE
};

enum ast_type_qualifier
{
    AST_CONST,
    AST_VOLATILE
};

enum ast_struct_or_union
{
    AST_STRUCT,
    AST_UNION
};

#define AST_NONE -1 /* Signals enum, struct, or union  */

enum ast_storage_class_specifier
{
    AST_AUTO = 0,
    AST_REGISTER,
    AST_STATIC,
    AST_EXTERN,
    AST_TYPEDEF
};

enum ast_type_specifier
{
    AST_VOID = 0,
    AST_CHAR,
    AST_SHORT,
    AST_INT,
    AST_LONG,
    AST_FLOAT,
    AST_DOUBLE,
    AST_SIGNED,
    AST_UNSIGNED
};

enum label_type
{
    AST_LABEL,
    AST_CASE_LABEL,
    AST_DEFAULT_LABEL
};

enum jump_type
{
    AST_GOTO,
    AST_CONTINUE,
    AST_BREAK,
    AST_RETURN
};

enum reference_type
{
    AST_VALUE,
    AST_REFERENCE
};

enum unary_operand
{
    AST_ADDRESS,
    AST_DEREFERENCE,
    AST_POSITIVE,
    AST_NEGATIVE,
    AST_BITWISE_NOT,
    AST_NOT
};

enum binary_operand
{
    AST_ADDITION,
    AST_SUBTRACTION,
    AST_MULTIPLICATION,
    AST_DIVISION,
    AST_MODULUS,
    AST_SHIFT_LEFT,
    AST_SHIFT_RIGHT,
    AST_LESS_THAN_OR_EQUAL,
    AST_LESS_THAN,
    AST_GREATER_THAN_OR_EQUAL,
    AST_GREATER_THAN,
    AST_EQUAL,
    AST_NOT_EQUAL,
    AST_BITWISE_AND,
    AST_BITWISE_OR,
    AST_XOR,
    AST_LOGICAL_AND,
    AST_LOGICAL_OR,
};

struct astnode
{
    enum astnode_type type;

    /*
     *
     */
    union
    {
        /* specifier_qualifier_list node */
        struct
        {
            struct listnode *specifier_qualifier_list;
        };
        /* struct_declarator_list node */
        struct
        {
            struct listnode *struct_declarator_list;
        };
        /* struct_declarator node */
        struct
        {
            struct astnode *struct_declarator;
            struct astnode *struct_constant_expression;
        };
        /* function_definition node */
        struct
        {
            struct astnode *function_declaration_specifiers;
            struct astnode *function_declarator ;
            struct astnode *function_declaration_list;
            struct astnode *function_compound_statement;
        };
        /* compound_statement node */
        struct
        {
            struct astnode *compound_statement_declaration_list;
            struct astnode *compound_statement_statement_list;
        };
        /* statement_list node */
        struct
        {
            struct listnode *statement_list;
        };
        /* labeled_statement node */
        struct
        {
            enum label_type label_type;
            struct astnode *labeled_statement;
            struct astnode *case_expression;
            char *label_identifier;
        };
        /* expression_statement node */
        struct
        {
            struct astnode *expression_statement;
        };
        /* selection_statement node */
        struct
        {
            struct astnode *conditional_expression;
            struct astnode *conditional_if_statement;
            struct astnode *conditional_else_statement;
        };
        /* iteration_statement node */
        struct
        {
            struct astnode *expression1;
            struct astnode *expression2;
            struct astnode *expression3;
            struct astnode *iteration_statement;
        };
        /* declaration_list node */
        struct
        {
            struct listnode *declaration_list;
        };
        /* declaration node */
        struct
        {
            struct astnode *declaration_specifiers;
            struct astnode *declaration_declarators;
        };
        /* init_declarator_list node */
        struct
        {
            struct listnode *init_declarator_list;
        };
        /* init_declarator node */
        struct
        {
            struct astnode *init_declarator_declarator;
            struct astnode *init_declarator_initializer;
        };
        /* declarator node */
        struct
        {
            char *direct_declarator_identifier;
            struct astnode *direct_declarator;
            struct astnode *constant_expression;
            struct astnode *parameter_type_list;
            struct astnode *declarator_pointer;
        };
        /* pointer node */
        struct
        {
            struct astnode *pointer_type_qualifier_list;
            struct astnode *pointer;
        };
        /* type_qualifier_list node */
        struct
        {
            struct listnode *type_qualifier_list;
        };
        /* parameter_type_list node */
        struct
        {
            struct astnode *parameters;
            char va_op;
        };
        /* parameter_list node */
        struct
        {
            struct listnode *parameter_list;
        };
        /* parameter_declaration node */
        struct
        {
            struct astnode *parameter_specifier;
            struct astnode *parameter_declarator;
        };
        /* declaration_specifiers node */
        struct
        {
            struct listnode *declaration_specifiers_list;
        };
        /* storage_class_specifier node */
        struct
        {
            enum ast_storage_class_specifier storage_class_specifier_enum;
        };
        /* type_specifier node */
        struct
        {
            enum ast_type_specifier type_specifier_enum;
            struct astnode *type_specifier_node;
        };
        /* type_qualifier node */
        struct
        {
            enum ast_type_qualifier type_qualifier_enum;
        };
        /* enum_specifier node */
        struct
        {
            char *enum_specifier_identifier;
            struct astnode *enumerator_list;
        };
        /* enumerator node */
        struct
        {
            struct astnode *next;
            char *enumerator_identifier;
            struct astnode *enumerator_value;
        };
        /* jump statement */
        struct
        {
            char *label;
            struct astnode *return_expression;
            enum jump_type jumptype;
        };
        /* compound expression */
        struct
        {
            struct astnode *first_expression;
            struct astnode *second_expression;
        };
        /* modify expression */
        struct
        {
            struct astnode *modify_identifier;
            struct astnode *assignment_expression;
        };
        /* conditional expression */
        struct
        {
            struct astnode *condition;
            struct astnode *then_value;
            struct astnode *else_value;
        };
        /* binary expression */
        struct
        {
            struct astnode *left_expression;
            struct astnode *right_expression;
            enum binary_operand binaryop;
        };
        /* unary expression */
        struct
        {
            struct astnode *cast_expression;
            enum unary_operand unaryop;
        };
        /* postfix expression */
        struct
        {
            struct astnode *postfix_expression;
            struct astnode *expression;
            char *identifier;
            enum reference_type reftype;
        };
        /* constant */
        struct
        {
            union
            {
                int integer_constant;
                char character_constant;
                float floatacter_constant;
            };
        };
    };
};

struct astnode *create_specifier_qualifer_list_node(
    struct astnode *specifier_qualifier_list,
    struct astnode *specifier_qualifier);

struct astnode *create_struct_declarator_list_node(
    struct astnode *struct_declarator_list,
    struct astnode *struct_declarator);

struct astnode *create_struct_declarator_node(
    struct astnode *struct_declarator,
    struct astnode *struct_constant_expression);

struct astnode *create_function_declaration_statement_node(
    struct astnode *function_declaration_specifiers,
    struct astnode *function_declarator,
    struct astnode *function_declaration_list,
    struct astnode *function_compound_statement);

struct astnode *create_compound_statement_node(
    struct astnode *declaration_list,
    struct astnode *statement_list);

struct astnode *create_statement_list_node(
    struct astnode *statement_list,
    struct astnode *statement);

struct astnode *create_labeled_statement_node(
    enum label_type label,
    struct astnode *statement,
    struct astnode *case_expression,
    char *identifier);

struct astnode *create_expression_statement_node(
    struct astnode *expression);

struct astnode *create_selection_statement_node(
    struct astnode *condition,
    struct astnode *statement,
    struct astnode *else_statement);

struct astnode *create_iteration_statement_node(
    struct astnode *expression1,
    struct astnode *expression2,
    struct astnode *expression3,
    struct astnode *iteration_statement);

struct astnode *create_declaration_list_node(
    struct astnode *declaration_list,
    struct astnode *declaration);

struct astnode *create_declaration_node(
    struct astnode *declaration_specifiers,
    struct astnode *declaration_declarators);

struct astnode *create_init_declarator_list_node(
    struct astnode *init_declarator_list,
    struct astnode *declarator);

struct astnode *create_init_declarator_node(
    struct astnode *declarator,
    struct astnode *initilizer);

struct astnode *create_declarator_node(
    char *direct_declarator_identifier,
    struct astnode *direct_declarator,
    struct astnode *constant_expression,
    struct astnode *parameter_type_list);

struct astnode *create_pointer_node(
    struct astnode *poitner_type_qualifier_list,
    struct astnode *pointer);

struct astnode *create_type_qualifier_list_node(
    struct astnode *type_qualifier_list,
    struct astnode *type_qualifier);

struct astnode * create_parameter_type_list_node(
    struct astnode *parameter_list, char va_op);

struct astnode *create_parameter_list_node(
    struct astnode *parameter_list,
    struct astnode *parameter_declaration);

struct astnode *create_parameter_declaration_node(
    struct astnode *parameter_specifier,
    struct astnode *parameter_declarator);

struct astnode *create_declaration_secifiers_node(
    struct astnode *declaration_specifier,
    struct astnode *specifier);

struct astnode *create_storage_class_specifier_node(
    enum ast_storage_class_specifier storage_class_specifier_enum);

struct astnode *create_type_specifier_node(
    enum ast_type_specifier type_specifier_enum,
    struct astnode *type_specifier_node);

struct astnode *create_type_qualifier_node(
    enum ast_type_qualifier type_qualifier_enum);

struct astnode *create_enum_specifier_node(
    char *enum_specifier_identifier,
    struct astnode *enumerator_list);

struct astnode *create_enumerator_node(
    char *enumerator_identifier,
    struct astnode *enumerator_value);

struct astnode *create_jump_statement_node(
    enum jump_type jumptype,
    struct astnode *return_expression); 

struct astnode *create_compound_expression_node(
    struct astnode *first_expression,
    struct astnode *second_expression);

struct astnode *create_modify_expression_node(
    struct astnode *modify_identifier,
    struct astnode *assignment_expression);

struct astnode *create_conditional_expression_node(
    struct astnode *condition,
    struct astnode *then_value,
    struct astnode *else_value);

struct astnode *create_binary_expression_node(
    struct astnode *left_expression,
    struct astnode *right_expression,
    enum binary_operand binaryop);

struct astnode *create_unary_expression_node(
    struct astnode *cast_expression);

struct astnode *create_array_reference_node(
    struct astnode *postfix_expression,
    struct astnode *expression);

struct astnode *create_component_reference_node(
    struct astnode *postfix_expression,
    char *identifier,
    enum reference_type reftype);

struct astnode *create_preincrement_node(
    struct astnode *expression);

struct astnode *create_predecrement_node(
    struct astnode *expression);

struct astnode *create_postincrement_node(
    struct astnode *expression);

struct astnode *create_postdecrement_node(
    struct astnode *expression);

struct astnode *create_identifier_node(
    char *identifier);

struct astnode *create_integer_node(
    int integer);

struct astnode *create_character_node(
    char character);

#endif
