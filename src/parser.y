%{
#include <stdio.h>

int yylex(void);
void yyerror(const char *s);
%}

%union {
    int  num;
    char *id;
}

%token BCSMAIN IF ELSE WHILE INT BOOL
%token <id>  ID
%token <num> NUM
%token PLUS MULT ASSIGN
%token LT GT LE GE EQ NE
%token LBRACE RBRACE LPAREN RPAREN SEMICOLON

%%

/* placeholder start rule — real grammar (program -> declist stmtlist etc.)
   goes here once the lexer is verified */
start
    : /* empty */
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Syntax Error\n");
}
