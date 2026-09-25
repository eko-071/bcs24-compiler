# Toolchain

```
source text --(Flex: src/lexer.l)--> tokens --(Bison: src/parser.y)--> Parsing Successful | Syntax Error
```

Flex turns the source text into tokens, Bison checks if those tokens form a valid Bcs24 program.

Build order:

```
bison -d src/parser.y -o src/parser.tab.c   # also emits src/parser.tab.h
flex -o src/lex.yy.c src/lexer.l
gcc src/parser.tab.c src/lex.yy.c src/main.c -o bcs24
```

`Makefile` stuff:

```
make          # bison -> flex -> gcc, -> ./bcs24
make clean    # rm -f bcs24 src/parser.tab.* src/lex.yy.c
make test     # ./bcs24 tests/valid/*.bcs + ./bcs24 tests/invalid/*.bcs
```

`parser.y` has to go first since it's the one declaring the tokens. Bison generates `parser.tab.h` from that, and `lexer.l` includes it so both sides agree on the token numbers.

In `lexer.l`, keywords get matched before identifiers, and stuff like `<=` and `==` before their single-char versions, so they don't get misread as something else. Any character the lexer doesn't recognize, or any program that just doesn't parse, both print `Syntax Error`.