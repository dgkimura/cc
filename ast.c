#include <stdlib.h>

#include "ast.h"

struct astnode *
create_storage_class_specifier_node(
    enum ast_storage_class_specifier storage_class_specifier_enum)
{
    struct astnode *node;
    node = (struct astnode *)malloc(sizeof(struct astnode));
    node->type = AST_STORAGE_CLASS_SPECIFIER_NODE;
    node->storage_class_specifier_enum = storage_class_specifier_enum;
    return node;
}

struct astnode *create_type_specifier_node(
    enum ast_type_specifier type_specifier_enum,
    struct astnode *type_specifier_node)
{
    struct astnode *node;
    node = (struct astnode *)malloc(sizeof(struct astnode));
    node->type = AST_TYPE_SPECIFIER_NODE;
    node->type_specifier_enum = type_specifier_enum;
    node->type_specifier_node = type_specifier_node;
    return node;
}

struct astnode *
create_type_qualifier_node(
    enum ast_type_qualifier type_qualifier_enum)
{
    struct astnode *node;
    node = (struct astnode *)malloc(sizeof(struct astnode));
    node->type = AST_TYPE_QUALIFIER_NODE;
    node->type_qualifier_enum = type_qualifier_enum;
    return node;
}

struct astnode *
create_enum_specifier_node(
    char *enum_specifier_identifier,
    struct astnode *enumerator_list)
{
    struct astnode *node;
    node = (struct astnode *)malloc(sizeof(struct astnode));
    node->type = AST_ENUM_SPECIFIER_NODE;
    node->enum_specifier_identifier = enum_specifier_identifier;
    node->enumerator_list = enumerator_list;
    return node;
}

struct astnode *
create_enumerator_node(
    char *enumerator_identifier,
    struct astnode *enumerator_value)
{
    struct astnode *node;
    node = (struct astnode *)malloc(sizeof(struct astnode));
    node->type = AST_ENUMERATOR_NODE;
    node->enumerator_identifier = enumerator_identifier;
    node->enumerator_value = enumerator_value;
    return node;
}

struct astnode *create_jump_statement_node(
    enum jump_type jumptype,
    struct astnode *return_expression)
{
    struct astnode *node;
    node = (struct astnode *)malloc(sizeof(struct astnode));
    node->type = AST_JUMP_STATEMENT;
    node->jumptype = jumptype;
    node->return_expression = return_expression;
    return node;
}

struct astnode *
create_compound_expression_node(
    struct astnode *first_expression,
    struct astnode *second_expression)
{
    struct astnode *node;
    node = (struct astnode *)malloc(sizeof(struct astnode));
    node->type = AST_COMPOUND_EXPRESSION;
    node->first_expression = first_expression;
    node->second_expression = second_expression;
    return node;
}

struct astnode *
create_modify_expression_node(
    struct astnode *modify_identifier,
    struct astnode *assignment_expression)
{
    struct astnode *node;
    node = (struct astnode *)malloc(sizeof(struct astnode));
    node->type = AST_MODIFY_EXPRESSION;
    node->modify_identifier = modify_identifier;
    node->assignment_expression = assignment_expression;
    return node;
}

struct astnode *
create_conditional_expression_node(
    struct astnode *condition,
    struct astnode *then_value,
    struct astnode *else_value)
{
    struct astnode *node;
    node = (struct astnode *)malloc(sizeof(struct astnode));
    node->type = AST_CONDITIONAL_EXPRESSION;
    node->condition = condition;
    node->then_value = then_value;
    node->else_value = else_value;
    return node;
}

struct astnode *
create_binary_expression_node(
    struct astnode *left_expression,
    struct astnode *right_expression,
    enum binary_operand binaryop)
{
    struct astnode *node;
    node = (struct astnode *)malloc(sizeof(struct astnode));
    node->type = AST_BINARY_EXPRESSION;
    node->left_expression = left_expression;
    node->right_expression = right_expression;
    node->binaryop = binaryop;
    return node;
}

struct astnode *
create_unary_expression_node(
    struct astnode *cast_expression)
{
    struct astnode *node;
    node = (struct astnode *)malloc(sizeof(struct astnode));
    node->type = AST_UNARY_EXPRESSION;
    node->cast_expression = cast_expression;
    //node->unaryop = unaryop;
    return node;
}

struct astnode *
create_array_reference_node(
    struct astnode *postfix_expression,
    struct astnode *expression)
{
    struct astnode *node;
    node = (struct astnode *)malloc(sizeof(struct astnode));
    node->type = AST_ARRAY_REFERENCE;
    node->postfix_expression = postfix_expression;
    node->expression = expression;
    return node;
}

struct astnode *
create_component_reference_node(
    struct astnode *postfix_expression,
    char *identifier,
    enum reference_type reftype)
{
    struct astnode *node;
    node = (struct astnode *)malloc(sizeof(struct astnode));
    node->type = AST_COMPONENT_REFERENCE;
    node->postfix_expression = postfix_expression;
    node->identifier = identifier;
    node->reftype = reftype;
    return node;
}

struct astnode *
create_preincrement_node(struct astnode *expression)
{
    struct astnode *node;
    node = (struct astnode *)malloc(sizeof(struct astnode));
    node->type = AST_PREINCREMENT_EXPRESSION;
    node->expression = expression;
    return node;
}

struct astnode *
create_predecrement_node(struct astnode *expression)
{
    struct astnode *node;
    node = (struct astnode *)malloc(sizeof(struct astnode));
    node->type = AST_PREDECREMENT_EXPRESSION;
    node->expression = expression;
    return node;
}

struct astnode *
create_postincrement_node(struct astnode *expression)
{
    struct astnode *node;
    node = (struct astnode *)malloc(sizeof(struct astnode));
    node->type = AST_POSTINCREMENT_EXPRESSION;
    node->expression = expression;
    return node;
}

struct astnode *
create_postdecrement_node(struct astnode *expression)
{
    struct astnode *node;
    node = (struct astnode *)malloc(sizeof(struct astnode));
    node->type = AST_POSTDECREMENT_EXPRESSION;
    node->expression = expression;
    return node;
}

struct astnode *
create_identifier_node(char *identifier)
{
    struct astnode *node;
    node = (struct astnode *)malloc(sizeof(struct astnode));
    node->type = AST_CHARACTER_TYPE;
    node->identifier = identifier;
    return node;
}

struct astnode *
create_integer_node(int integer)
{
    struct astnode *node;
    node = (struct astnode *)malloc(sizeof(struct astnode));
    node->type = AST_INTEGER_TYPE;
    node->integer_constant = integer;
    return node;
}

struct astnode *
create_character_node(char character)
{
    struct astnode *node;
    node = (struct astnode *)malloc(sizeof(struct astnode));
    node->type = AST_CHARACTER_TYPE;
    node->character_constant = character;
    return node;
}
