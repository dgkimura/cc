/*
 * An astnode represents one of the following concepts in C: data type,
 * variable, expression, or statement.
 */

enum astnode_type
{
    AST_IDENTIFIER_TYPE,
    AST_INTEGER_TYPE,
    AST_CHARACTER_TYPE
};

enum operand
{
    ADD,
    SUB,
    MULT,
    MOD
};

struct astnode
{
    enum astnode_type type;

    /*
     *
     */
    union
    {
        /* OP_EXP */
        struct
        {
            struct astnode *left;
            struct astnode *right;
            enum operand operand;
        };
        struct
        {
            char *identifier;
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

struct astnode *create_integer_node(int integer);
struct astnode *create_character_node(char character);
