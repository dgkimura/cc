enum astnode_type
{
    OP_NODETYPE,
    IDENTIFIER_NODETYPE,
    CONSTANT_NODETYPE
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
