ifdef OS
	RM = del /Q
	ECHO = @echo
else
	RM = rm -f
	ECHO = echo
endif

BIN =  compilador.exe
OBJ = y.tab.o lex.yy.o 
CC = gcc
CFLAGS = -std=c18
LFLAGS = -lm


$(BIN): $(OBJ)	
	$(CC) $(OBJ) -o $(BIN) $(CFLAGS) $(LFLAGS)

test: $(BIN) 
	$(ECHO) Programa micro valido:
	$(BIN) < ./testcases/programaOK.txt
	$(ECHO) -------------------------------------------------------------------------------
	$(ECHO) Programa micro con identificador sin declarar:
	$(BIN) < ./testcases/programaIdentificadorNoDeclarado.txt
	$(ECHO) -------------------------------------------------------------------------------
	$(ECHO)  Programa micro con identificador con longitud mayor a 32:
	$(BIN) < ./testcases/programaIdentificadorMayorA32.txt
	$(ECHO) -------------------------------------------------------------------------------
	$(ECHO) Programa micro con simbolos no reconocidos:
	$(BIN) < ./testcases/programaSimboloNoReconocido.txt
	$(ECHO) -------------------------------------------------------------------------------
	$(ECHO) Programa micro con asignacion de una variable ya asignada:
	$(BIN) < ./testcases/programaIdentificadorYaDeclarado.txt
	$(ECHO) -------------------------------------------------------------------------------
	$(ECHO) Programa micro leer identificador que es palabra reservada Error bison:
	$(BIN) <  ./testcases/programaIdentificadorEsPalabraReservada.txt 
	$(ECHO) -------------------------------------------------------------------------------
	$(ECHO) Programa micro sentencia sin punto y coma Error bison:
	$(BIN) < ./testcases/programaSentenciaSinPuntoYComa.txt
	$(ECHO) -------------------------------------------------------------------------------
	$(ECHO) Programa micro leer una contstante Error bison:
	$(BIN) < ./testcases/programaLeerConstante.txt

all: $(BIN)

y.tab.c:
	bison -dy parser.y

lex.yy.c:
	flex Scanner.l

y.tab.o:lex.yy.c y.tab.c estructura.h
	$(CC) -c y.tab.c lex.yy.c $(CFLAGS)

clean:
	$(RM) *.o  *.exe lex.yy.c y.tab.c y.tab.h