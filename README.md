# Bcs24 Compiler

A compiler interpretation for the Bcs24 language developed as a course project for CS3002E: Compiler Design.

The compiler is implemented in C using Flex and Bison.


## Stages

| Stage | Scope | Due |
|-------|-------|-----|
| 1 | Lex + parse | 25 Sep 2026, 10 PM |
| 2 | Semantics + TAC | 15 Oct 2026, 10 PM |

## Pipeline

```
Bcs24 source -> Flex -> tokens -> Bison -> Parsing Successful / Syntax Error -> (Stage 2) AST -> TAC
```

## Language

`BcsMain { declist stmtlist }`, decls first (`int`/`bool`), stmts `id = aexpr` `if` `while` with `;`, exprs `+` `*` and `< > <= >= == !=`.

See [Language Specification](docs/language.md) for more details.

## Structure

```
bcs24-compiler/
├── docs/
├── src/
├── tests/
└── examples/
```

## Build

```bash
make          # -> ./bcs24
```

## Usage

```bash
./bcs24 program.bcs
# -> Parsing Successful
# -> Syntax Error
```

File path is the only arg, output is exactly one of those strings.

## Docs

- `language.md` - grammar and tokens
- `lexer.md` - token set and ordering
- `parser.md` - grammar and output contract
