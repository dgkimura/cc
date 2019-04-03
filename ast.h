#ifndef __AST_H__
#define __AST_H__

#include "list.h"

/*
 * An astnode represents one of the following concepts in C: data type,
 * variable, expression, or statement.
 */

enum astnode_type
{
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
        /* direct_declarator node */
        struct
        {
            char *direct_declarator_identifier;
            struct astnode *direct_declarator;
            struct astnode *constant_expression;
            struct astnode *parameter_type_list;
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

struct astnode * create_direct_declarator_node(
    char *direct_declarator_identifier,
    struct astnode *direct_declarator,
    struct astnode *constant_expression,
    struct astnode *parameter_type_list);

struct astnode * create_pointer_node(
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
