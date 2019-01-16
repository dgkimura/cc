enum op
{
    OP_GE
};

enum type
{
    VALUE,
    OPERATOR
};

struct constant
{
    int value;
};

struct binaryop
{
    struct node *rhs;
    struct node *lhs;
};

struct node
{
    enum type type;

    union
    {
        struct constant constant;
        struct binaryop binaryop;
    };
};

struct node *create_const_node(const int value);

struct node *create_binaryop_node(enum op op, struct node *lhs, struct node *rhs);
