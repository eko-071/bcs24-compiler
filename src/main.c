#include <stdio.h>
#include "parser.tab.h"

extern FILE *yyin;
extern int yylex(void);
extern YYSTYPE yylval;

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

    int tok;
    while ((tok = yylex()) != 0) {
        printf("token %d", tok);
        if (tok == ID)  printf(" (id=%s)", yylval.id);
        if (tok == NUM) printf(" (num=%d)", yylval.num);
        printf("\n");
    }

    return 0;
}