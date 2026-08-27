# Bcs24 Language Specification

Spec for Bcs24 from the PDF. If it is not here, we probably should not add it.

## Program

```
program -> BcsMain { declist stmtlist }
```

- `BcsMain`, then `{`, then decls, then stmts, then `}`
- Whitespace outside tokens does not matter
- At least one decl and one stmt required

Sample that should pass:

```c
BcsMain
{
int sum; int i; int n;
n=10;
i=1; sum=0;
while(i<n)
{sum=sum+i; i=i+1};
sum=sum*10
}
```

`stmtlist ; stmt` is a separator, not a terminator.

## Declarations

```
declist -> declist decl | decl
decl    -> type id ;
type    -> int | bool
```

- One `id` per decl, trailing `;`
- Only `int` and `bool`

Also, Stage 1 does not check if an `id` was declared. `BcsMain { int x; y = 1 }` is still valid.

## Statements

```
stmtlist -> stmtlist ; stmt | stmt
stmt     -> id = aexpr | if (expr) {stmtlist} else {stmtlist} | while (expr) {stmtlist}
```

- `id = aexpr` e.g. `x = a + b * c`
- `else` is required
- `;` separates stmts: `x=1; y=2` ok, `x=1` ok, `x=1;` not ok alone

## Expressions

```
expr  -> aexpr relop aexpr | aexpr
aexpr -> aexpr + aexpr | term
term  -> term * factor | factor
factor -> id | num
relop -> < | > | <= | >= | == | !=
```

- `*` binds tighter than `+` via `term`
- `a + b < c * 2` is `aexpr relop aexpr`, no chaining like `a < b < c`

## Lexical

```
letter -> [a-zA-Z]
digit  -> [0-9]
id     -> letter (letter|digit)*
num    -> digit+
```

| Class | Example | Note |
|-------|---------|------|
| `id` | `x`, `sum1` | Must start with letter |
| `num` | `0`, `10` | Unsigned, leading zeros ok |
| Keyword | `BcsMain` `if` `else` `while` `int` `bool` | Case-sensitive |
| Operator | `+ * = < > <= >= == !=` | `! =` in PDF is `!=` |
| Delimiter | `{ } ( ) ;` | |

