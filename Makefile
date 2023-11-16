BIN =  compilador.exe
OBJ = y.tab.o lex.yy.o 
CC = gcc
CFLAGS = -std=c18
LFLAGS = -lm
RM = rm -f
$(BIN): $(OBJ)	
	$(CC) $(OBJ) -o $(BIN) $(CFLAGS) $(LFLAGS)

test: $(BIN)
	./$(BIN) < programa.txt

all: $(BIN)

y.tab.c:
	bison -dy parser.y

lex.yy.c:
	flex Scanner.l

y.tab.o:lex.yy.c y.tab.c estructura.h
	$(CC) -c y.tab.c lex.yy.c $(CFLAGS)

clean:
	rm -rf *.o  *.exe lex.yy.c y.tab.c y.tab.h