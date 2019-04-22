#include <stdlib.h>

#include "ast.h"
#include "list.h"

struct astnode *
create_struct_or_union_specifier_node(
    enum ast_struct_or_union struct_or_union,
    char *struct_or_union_specifier_identifier,
    struct astnode *struct_or_union_specifier_struct_declaration_list)
{
    struct astnode *node;
    node = (struct astnode *)malloc(sizeof(struct astnode));
    node->type = AST_STRUCT_OR_UNION_SPECIFIER;

    node->struct_or_union = struct_or_union;
    node->struct_or_union_specifier_identifier = struct_or_union_specifier_identifier;
    node->struct_or_union_specifier_struct_declaration_list = struct_or_union_specifier_struct_declaration_list;
    return node;
}

struct astnode *
create_struct_declaration_list_node(
    struct astnode *struct_declaration_list,
    struct astnode *struct_declaration)
{
    struct astnode *node;
    if (struct_declaration_list == NULL)
    {
        node = (struct astnode *)malloc(sizeof(struct astnode));
        node->type = AST_STRUCT_DECLARATOR_LIST;
        list_init(&node->struct_declaration_list);
    }

    list_prepend(&node->struct_declaration_list, struct_declaration);
    return node;
}

struct astnode *
create_struct_declaration_node(
    struct astnode *specifier_qualifier_list,
    struct astnode *declarator_list)
{
    struct astnode *node;
    node = (struct astnode *)malloc(sizeof(struct astnode));
    node->type = AST_STRUCT_DECLARATION;

    node->struct_declaration_specifier_qualifier_list = specifier_qualifier_list;
    node->struct_declaration_declarator_list = declarator_list;
    return node;
}

struct astnode *
create_specifier_qualifer_list_node(
    struct astnode *specifier_qualifier_list,
    struct astnode *specifier_qualifier)
{
    struct astnode *node;
    if (specifier_qualifier_list == NULL)
    {
        node = (struct astnode *)malloc(sizeof(struct astnode));
        node->type = AST_STRUCT_DECLARATOR_LIST;
        list_init(&node->specifier_qualifier_list);
    }

    list_prepend(&node->specifier_qualifier_list, specifier_qualifier);
    return node;
}

struct astnode *
create_struct_declarator_list_node(
    struct astnode *struct_declarator_list,
    struct astnode *struct_declarator)
{
    struct astnode *node;
    if (struct_declarator_list == NULL)
    {
        node = (struct astnode *)malloc(sizeof(struct astnode));
        node->type = AST_STRUCT_DECLARATOR_LIST;
        list_init(&node->struct_declarator_list);
    }

    list_prepend(&node->struct_declarator_list, struct_declarator);
    return node;
}

struct astnode *
create_struct_declarator_node(
    struct astnode *struct_declarator,
    struct astnode *struct_constant_expression)
{
    struct astnode *node;
    node = (struct astnode *)malloc(sizeof(struct astnode));
    node->type = AST_STRUCT_DECLARATOR;

    node->struct_declarator = struct_declarator;
    node->struct_constant_expression = struct_constant_expression;
    return node;
}

struct astnode *
create_function_declaration_statement_node(
    struct astnode *declaration_specifiers,
    struct astnode *declarator,
    struct astnode *declaration_list,
    struct astnode *compound_statement)
{
    struct astnode *node;
    node = (struct astnode *)malloc(sizeof(struct astnode));
    node->type = AST_FUNCTION_DECLARATION;

    node->function_declaration_specifiers = declaration_specifiers;
    node->function_declarator = declarator;
    node->function_declaration_list = declaration_list;
    node->function_compound_statement = compound_statement;
    return node;
}

struct astnode *
create_compound_statement_node(
    struct astnode *declaration_list,
    struct astnode *statement_list)
{
    struct astnode *node;
    node = (struct astnode *)malloc(sizeof(struct astnode));
    node->type = AST_COMPOUND_STATEMENT;

    node->compound_statement_declaration_list = declaration_list;
    node->compound_statement_statement_list = statement_list;
    return node;
}

struct astnode *create_statement_list_node(
    struct astnode *statement_list,
    struct astnode *statement)
{
    struct astnode *node;
    if (statement_list == NULL)
    {
        node = (struct astnode *)malloc(sizeof(struct astnode));
        node->type = AST_STATEMENT_LIST;
        list_init(&node->statement_list);
    }

    list_prepend(&node->statement_list, statement);
    return node;
}

struct astnode *create_labeled_statement_node(
    enum label_type label,
    struct astnode *statement,
    struct astnode *case_expression,
    char *identifier)
{
    struct astnode *node;
    node = (struct astnode *)malloc(sizeof(struct astnode));
    node->type = AST_LABELED_STATEMENT;

    node->label_type = label;
    node->labeled_statement = statement;
    node->case_expression = case_expression;
    node->label_identifier = identifier;
    return node;
}

struct astnode *create_expression_statement_node(
    struct astnode *expression)
{
    struct astnode *node;
    node = (struct astnode *)malloc(sizeof(struct astnode));
    node->type = AST_EXPRESSION_STATEMENT;

    node->expression_statement = expression;
    return node;
}

struct astnode *create_selection_statement_node(
    struct astnode *condition,
    struct astnode *statement,
    struct astnode *else_statement)
{
    struct astnode *node;
    node = (struct astnode *)malloc(sizeof(struct astnode));
    node->type = AST_CONDITIONAL_EXPRESSION;

    node->conditional_expression = condition;
    node->conditional_if_statement = statement;
    node->conditional_else_statement = else_statement;
    return node;
}

struct astnode *create_iteration_statement_node(
    struct astnode *expression1,
    struct astnode *expression2,
    struct astnode *expression3,
    struct astnode *iteration_statement)
{
    struct astnode *node;
    node = (struct astnode *)malloc(sizeof(struct astnode));
    node->type = AST_ITERATION_STATEMENT;

    node->expression1 = expression1;
    node->expression2 = expression2;
    node->expression3 = expression3;
    node->iteration_statement = iteration_statement;
    return node;
}

struct astnode *create_declaration_list_node(
    struct astnode *declaration_list,
    struct astnode *declaration)
{
    struct astnode *node;
    if (declaration_list == NULL)
    {
        node = (struct astnode *)malloc(sizeof(struct astnode));
        node->type = AST_INIT_DECLARATOR_LIST;
        list_init(&node->declaration_list);
    }

    list_prepend(&node->declaration_list, declaration);
    return node;
}

struct astnode *
create_declaration_node(
    struct astnode *declaration_specifiers,
    struct astnode *declaration_declarators)
{
    struct astnode *node;
    node = (struct astnode *)malloc(sizeof(struct astnode));
    node->type = AST_DECLARATION;

    node->declaration_specifiers = declaration_specifiers;
    node->declaration_declarators = declaration_declarators;
    return node;
}

struct astnode *
create_init_declarator_list_node(
    struct astnode *init_declarator_list,
    struct astnode *declarator)
{
    struct astnode *node;
    if (init_declarator_list == NULL)
    {
        node = (struct astnode *)malloc(sizeof(struct astnode));
        node->type = AST_INIT_DECLARATOR_LIST;
        list_init(&node->init_declarator_list);
    }

    list_prepend(&node->init_declarator_list, declarator);
    return node;
}

struct astnode *
create_init_declarator_node(
    struct astnode *declarator,
    struct astnode *initilizer)
{
    struct astnode *node;
    node = (struct astnode *)malloc(sizeof(struct astnode));
    node->type = AST_INIT_DECLARATOR;

    node->init_declarator_declarator = declarator;
    node->init_declarator_initializer = initilizer;
    return node;
}

struct astnode *
create_declarator_node(
    char *identifier, struct astnode *direct_declarator,
    struct astnode *constant_expression, struct astnode *parameter_type_list)
{
    struct astnode *node;
    node = (struct astnode *)malloc(sizeof(struct astnode));
    node->type = AST_DECLARATOR;

    node->direct_declarator_identifier = identifier;
    node->declarator_pointer = NULL;
    node->direct_declarator = direct_declarator;
    node->constant_expression = constant_expression;
    node->parameter_type_list = parameter_type_list;
    return node;
}

struct astnode *
create_pointer_node(
    struct astnode *pointer_type_qualifier_list, struct astnode *pointer)
{
    struct astnode *node;
    node = (struct astnode *)malloc(sizeof(struct astnode));
    node->type = AST_POINTER;
    node->pointer_type_qualifier_list = pointer_type_qualifier_list;
    node->pointer = pointer;
    return node;
}

struct astnode *
create_type_qualifier_list_node(
    struct astnode *type_qualifier_list, struct astnode *type_qualifier)
{
    struct astnode *node;
    if (type_qualifier_list == NULL)
    {
        node = (struct astnode *)malloc(sizeof(struct astnode));
        node->type = AST_TYPE_QUALIFIER_LIST;
        list_init(&node->type_qualifier_list);
    }

    list_prepend(&node->type_qualifier_list, type_qualifier);
    return node;
}

struct astnode *
create_parameter_type_list_node(
    struct astnode *parameter_list, char va_op)
{
    struct astnode *node;
    node = (struct astnode *)malloc(sizeof(struct astnode));
    node->type = AST_PARAMTER_TYPE_LIST;
    node->parameters = parameter_list;
    node->va_op = va_op;
    return node;
}

struct astnode *
create_parameter_list_node(
    struct astnode *parameter_list, struct astnode *parameter_declaration)
{
    struct astnode *node;
    if (parameter_list == NULL)
    {
        node = (struct astnode *)malloc(sizeof(struct astnode));
        node->type = AST_PARAMTER_LIST;
        list_init(&node->parameter_list);
    }

    list_prepend(&node->parameter_list, parameter_declaration);
    return node;
}

struct astnode *
create_parameter_declaration_node(
    struct astnode *parameter_specifier, struct astnode *parameter_declarator)
{
    struct astnode *node;
    node = (struct astnode *)malloc(sizeof(struct astnode));
    node->type = AST_PARAMTER_DECLARATION;
    node->parameter_specifier = parameter_specifier;
    node->parameter_declarator = parameter_declarator;
    return node;
}

struct astnode *
create_declaration_secifiers_node(
    struct astnode *declaration_specifier, struct astnode *specifier)
{
    struct astnode *node;
    if (declaration_specifier == NULL)
    {
        node = (struct astnode *)malloc(sizeof(struct astnode));
        node->type = AST_DECLARATION_SPECIFIERS;
        list_init(&node->declaration_specifiers_list);
    }

    list_prepend(&node->declaration_specifiers_list, specifier);
    return node;
}

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
    struct astnode *cast_expression,
    enum unary_operand unaryop)
{
    struct astnode *node;
    node = (struct astnode *)malloc(sizeof(struct astnode));
    node->type = AST_UNARY_EXPRESSION;
    node->cast_expression = cast_expression;
    node->unaryop = unaryop;
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
