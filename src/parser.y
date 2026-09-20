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

program
    : BCSMAIN LBRACE declist stmtlist RBRACE
    ;

declist
    : declist decl
    | decl
    ;

decl
    : type ID SEMICOLON
    ;

type
    : INT
    | BOOL
    ;

stmtlist
    : stmtlist SEMICOLON stmt
    | stmt
    ;

stmt
    : ID ASSIGN aexpr
    | IF LPAREN expr RPAREN LBRACE stmtlist RBRACE ELSE LBRACE stmtlist RBRACE
    | WHILE LPAREN expr RPAREN LBRACE stmtlist RBRACE
    ;

expr
    : aexpr relop aexpr
    | aexpr
    ;

aexpr
    : aexpr PLUS term
    | term
    ;

term
    : term MULT factor
    | factor
    ;

factor
    : ID
    | NUM
    ;

relop
    : LT
    | GT
    | LE
    | GE
    | EQ
    | NE
    ;

%%

void yyerror(const char *s) {
    /* main.c prints the single "Syntax Error" line based on yyparse()'s
       return value; yyerror stays silent so the output contract
       (exactly one of "Parsing Successful" / "Syntax Error") holds. */
    (void)s;
}
