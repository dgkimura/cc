enum astnode_type
{
    CONSTANT_NODETYPE
};

struct astnode
{
    enum astnode_type type;

    /*
     *
     */
    union
    {
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

struct astnode *create_node();
