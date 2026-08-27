# Lexical Analyzer

Flex turns source text into tokens for Bison.

```
source text -> Flex (src/lexer.l) -> tokens -> Bison
```

Stage 1 only, based on `docs/language.md` and the PDF.

## Token set

Keep names the same in `lexer.l` and `parser.y`:

| Lexeme | Token | Value |
|--------|-------|-------|
| `BcsMain` `if` `else` `while` `int` `bool` | `BCSMAIN` `IF` `ELSE` `WHILE` `INT` `BOOL` | no |
| `letter (letter\|digit)*` | `ID` | lexeme |
| `digit+` | `NUM` | number |
| `+` `*` `=` | `PLUS` `MULT` `ASSIGN` | no |
| `<` `>` `<=` `>=` `==` `!=` | `LT` `GT` `LE` `GE` `EQ` `NE` | no |
| `{` `}` `(` `)` `;` | `LBRACE` `RBRACE` `LPAREN` `RPAREN` `SEMICOLON` | no |

Names are an implementation detail, just share `parser.tab.h` from `bison -d`.

## Ordering

Longest match wins, earliest wins on tie. Use this order:

- Keywords before `ID` (else `while` becomes `ID`)
- `<=` before `<` (same for `>=` `==` `!=`)
- Then single-char ops, `NUM`, `ID`, whitespace skip, catch-all for invalid

Actual regexes go in `src/lexer.l`.

## Notes

- `int count; count = 10` -> `INT ID SEMICOLON ID ASSIGN NUM`
- `yylval` for `ID`/`NUM` should be defined in `parser.y`, lexer includes `parser.tab.h`
- Skip ` [ \t\n\r]+` since we don't need line tracking
- Comments are not in the spec
- Any invalid input should end as `Syntax Error`, same as parse error

## File

`src/lexer.l`

## Testing

Check: keywords vs `integer`, relops vs `!`, `ID` `a` `a1` `1a` (last errors), `NUM` `0` `007`, invalid `@` `$` `! =`.

Once tokens look right, wiring to Bison is just connecting.
