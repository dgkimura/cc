#include <stdio.h>

#include "parser.h"

extern FILE *yyin;
extern int yyparse();

int main(int argc, char *argv[])
{
    if (argc > 0)
    {
        FILE *f = fopen(argv[1], "r");
        yyin = f;
    }

    yyparse();
    return 0;
}
