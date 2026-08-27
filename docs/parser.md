# Parser

Bison checks if tokens from Flex form a valid Bcs24 program.

```
tokens -> Bison (src/parser.y) -> Parsing Successful | Syntax Error
```

Stage 1 only, no AST or type checks.

## Grammar

```
program  -> BcsMain { declist stmtlist }
declist  -> declist decl | decl
decl     -> type id ;
type     -> int | bool
stmtlist -> stmtlist ; stmt | stmt
stmt     -> id = aexpr | if (expr) {stmtlist} else {stmtlist} | while (expr) {stmtlist}
expr     -> aexpr relop aexpr | aexpr
aexpr    -> aexpr + aexpr | term
term     -> term * factor | factor
factor   -> id | num
relop    -> < | > | <= | >= | == | !=
```

`BcsMain -> BCSMAIN`, `+ -> PLUS`, etc, see `docs/lexer.md` for more details.

## Examples

Valid:

```
BcsMain { int x; x = 10 }
BcsMain { int x; int y; x = 1; y = x + 2 * 3 }
```

Invalid -> `Syntax Error`:

```
BcsMain { x = 1 }                  // no decl
BcsMain { int x; if (x<1) {x=1} }  // else required
BcsMain { int x; x = 1;; y = 2 }   // empty stmt
```

## Output

Exactly:

```
Parsing Successful
Syntax Error
```

- Read `argv[1]` into `yyin`
- `yyparse()==0` -> `Parsing Successful`, else `Syntax Error` on stdout
- No line numbers

## Wiring

`lexer.l` includes `parser.tab.h` from `bison -d`. Build order: `bison -d` -> `flex` -> `gcc`. See `Makefile`.

## Error handling

Lex catch-all and `yyerror` both print `Syntax Error`.

## Testing

Cover `decl`, `a+b`, `a*b`, `a+b*c`, all six relops inside `if`/`while`, `;` as separator, plus missing `BcsMain`, braces, `else`, empty lists.

```
./bcs24 tests/valid/foo.bcs   -> Parsing Successful
./bcs24 tests/invalid/bar.bcs -> Syntax Error
```

Do not build AST or symbol table yet.
