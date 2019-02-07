enum type
{
    VALUE,
    OPERATOR
};

struct astnode
{
    enum type type;

    union
    {
        void *data;
        struct astnode *children;
    };
};

struct astnode *create_node();
