CC := gcc
CFLAGS := -Wall -Wno-unused-function

SRC := src
BIN := bcs24

.PHONY: all clean test

all: $(BIN)

# parser.y must be run first: bison -d emits parser.tab.h, which lexer.l includes
$(SRC)/parser.tab.c $(SRC)/parser.tab.h: $(SRC)/parser.y
	bison -d $(SRC)/parser.y -o $(SRC)/parser.tab.c

$(SRC)/lex.yy.c: $(SRC)/lexer.l $(SRC)/parser.tab.h
	flex -o $(SRC)/lex.yy.c $(SRC)/lexer.l

$(BIN): $(SRC)/parser.tab.c $(SRC)/lex.yy.c $(SRC)/main.c
	$(CC) $(CFLAGS) $(SRC)/parser.tab.c $(SRC)/lex.yy.c $(SRC)/main.c -o $(BIN)

test: $(BIN)
	@for f in tests/valid/*.bcs; do \
		echo "$$f:"; ./$(BIN) "$$f"; \
	done
	@for f in tests/invalid/*.bcs; do \
		echo "$$f:"; ./$(BIN) "$$f"; \
	done

clean:
	rm -f $(BIN) $(SRC)/parser.tab.c $(SRC)/parser.tab.h $(SRC)/lex.yy.c
