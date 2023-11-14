%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>
extern char *yytext;
extern int yyleng;
extern int yylex(void);
extern void yyerror(char*);

int tablaReservada(char*);

typedef struct id{
    int valor;
    char *nombre;
}tablaSimbolos[30];

%}

%token INICIO FIN LEER ESCRIBIR IDENTIFICADOR CONSTANTE PARENTESISIZQ PARENTESISDER PUNTOYCOMA COMA ASIGNACION SUMA RESTA FDT 

%union{
    char *palabra;
    int num;
    int exp;
    id elemento;
}

%type <elemento> IDENTIFICADOR 
%type <num> CONSTANTE
%type <exp> expresion listaExpresiones primaria
%%

objetivo: program FDT {printf("Fin del programa");return 0;}
;

program:INICIO  listaSentencias FIN 
;

listaSentencias: sentencia listaSentencias 
| sentencia
;

sentencia:IDENTIFICADOR ASIGNACION expresion PUNTOYCOMA {printf("el identificador %s se le asigna el valor %d\n"),$1.nombre,$3;}
| LEER PARENTESISIZQ listaID PARENTESISDER PUNTOYCOMA {printf("leer\n");}
| ESCRIBIR PARENTESISIZQ listaExpresiones PARENTESISDER PUNTOYCOMA{printf("el resultado de la operacion es %d\n",$3);}
;

listaID:IDENTIFICADOR
| IDENTIFICADOR COMA listaID
;

listaExpresiones:expresion {$$=$1;}
| expresion COMA listaExpresiones
;

expresion:primaria {$$=$1;}
| primaria RESTA primaria{$$=$1-$3;}
| primaria SUMA primaria{$$=$1+$3;}
;

primaria:CONSTANTE {printf("constante %d\n",$1);$$=$1;}
| IDENTIFICADOR {$$=$1.valor;}
| PARENTESISIZQ expresion PARENTESISDER {$$=$2;}
;

%%

int main(){
    yyparse();
    return 0;
}

void yyerror(char* p){
    while(*p)
    {
      printf("%c",*p);
      p++; 
    }   
}

int tablaReservada(char*palabra)
{
    if(!strcmp(palabra,"leer")||!strcmp(palabra,"escribir")||
    !strcmp(palabra,"fin")||!strcmp(palabra,"inicio"))
        return 0;
    return 1; 
}