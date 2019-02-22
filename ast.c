#include <stdlib.h>

#include "ast.h"

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
