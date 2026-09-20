%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "parser.tab.h"
%}

%%

"BcsMain"   { return BCSMAIN; }
"if"        { return IF; }
"else"      { return ELSE; }
"while"     { return WHILE; }
"int"       { return INT; }
"bool"      { return BOOL; }

"<="        { return LE; }
">="        { return GE; }
"=="        { return EQ; }
"!="        { return NE; }
"<"         { return LT; }
">"         { return GT; }

"+"         { return PLUS; }
"*"         { return MULT; }
"="         { return ASSIGN; }

"{"         { return LBRACE; }
"}"         { return RBRACE; }
"("         { return LPAREN; }
")"         { return RPAREN; }
";"         { return SEMICOLON; }

[a-zA-Z][a-zA-Z0-9]*   { yylval.id = strdup(yytext); return ID; }
[0-9]+                 { yylval.num = atoi(yytext); return NUM; }

[ \t\n\r]+  { /* skip whitespace, no line tracking needed */ }

.           { printf("Syntax Error\n"); exit(0); }

%%

int yywrap(void) { return 1; }
