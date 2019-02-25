/*
 * An astnode represents one of the following concepts in C: data type,
 * variable, expression, or statement.
 */

enum astnode_type
{
    AST_MULTIPLICATIVE_EXPRESSION,
    AST_UNARY_CAST_EXPRESSION,
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

struct astnode *create_binary_expression_node(
    struct astnode *left_expression,
    struct astnode *right_expression,
    enum binary_operand binaryop,
    enum astnode_type nodetype);

struct astnode *create_unary_expression_node(
    struct astnode *cast_expression,
    enum unary_operand unaryop);

struct astnode *create_array_reference_node(
    struct astnode *postfix_expression,
    struct astnode *expression);

struct astnode *create_component_reference_node(
    struct astnode *postfix_expression,
    char *identifier,
    enum reference_type reftype);

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
