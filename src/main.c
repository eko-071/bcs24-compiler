#include <stdio.h>
#include "parser.tab.h"

extern FILE *yyin;
extern int yyparse(void);

int main(int argc, char **argv) {
    if (argc < 2) {
        fprintf(stderr, "Usage: %s <file>\n", argv[0]);
        return 1;
    }

    yyin = fopen(argv[1], "r");
    if (!yyin) {
        perror("fopen");
        return 1;
    }

    if (yyparse() == 0) {
        printf("Parsing Successful\n");
    } else {
        printf("Syntax Error\n");
    }

    fclose(yyin);
    return 0;
}
