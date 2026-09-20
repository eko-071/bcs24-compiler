# Tests

Test programs for Stage 1, covering the cases called out in
`docs/lexer.md` and `docs/parser.md`.

## Running

Once `parser.y` has the real grammar and `main.c` calls `yyparse()`:

```
for f in tests/valid/*.bcs; do echo "$f:"; ./bcs24 "$f"; done
for f in tests/invalid/*.bcs; do echo "$f:"; ./bcs24 "$f"; done
```

Expected: everything under `valid/` prints `Parsing Successful`, everything
under `invalid/` prints `Syntax Error`.

Until then, the lexer alone can be spot-checked with the token-printing
`main.c` — see `docs/process.md`.

## tests/valid/

| File | Exercises |
|---|---|
| `basic.bcs` | Multiple `int` decls, `+`/`*` precedence (`a + b * 2`) |
| `bool_and_relops.bcs` | `bool` type, all six relops (`< <= >= > == !=`), each in its own `if/else` |
| `nested_control.bcs` | `while` containing a nested `if/else`, `;` separating statements across a block |

## tests/invalid/

| File | Exercises | Should fail because |
|---|---|---|
| `no_bcsmain.bcs` | Missing `BcsMain` keyword | `program` requires it as the first token |
| `no_decl.bcs` | Zero `decl`s before the statement list | `declist` requires at least one `decl` |
| `missing_else.bcs` | `if` with no `else` | `else` is mandatory in the `stmt` rule |
| `empty_stmt.bcs` | `x = 1;;` | `;` is a separator, not a terminator — double `;` leaves an empty stmt |
| `chained_relop.bcs` | `a < b < c` | `expr → aexpr relop aexpr` doesn't allow chaining |
| `bad_char.bcs` | `@` in an expression | Not in the lexer's alphabet at all, it's caught by the catch-all rule, not the parser |