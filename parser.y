%{
#include "estructura.h"
#include <stdlib.h>
extern int yylex(void);
extern void yyerror(char*);

%}

%token INICIO FIN LEER ESCRIBIR IDENTIFICADOR CONSTANTE PARENTESISIZQ PARENTESISDER PUNTOYCOMA COMA ASIGNACION SUMA RESTA FDT 

%union{
    char *palabra;
    int num;
}

%type <num> CONSTANTE primaria expresion listaExpresiones 
%type <palabra> listaID  IDENTIFICADOR
%%

objetivo: program FDT {printf("Fin del programa");return 0;}
;

program:INICIO  listaSentencias FIN 
;

listaSentencias: sentencia listaSentencias 
| sentencia
;

sentencia:IDENTIFICADOR ASIGNACION expresion PUNTOYCOMA {cont=cargarPalabrasReservadas(cont);
                                                        if(verificar($1,cont))
                                                        {
                                                        guardar($1,$3,++cont);
                                                        printf("Se guardo con exito %d en el ID %s\n",$3,$1);
                                                        }
                                                        else
                                                        {
                                                        printf("Error el identificador %s ya esta en uso o es una palabra resevada\n",$1);
                                                        exit(0);
                                                        };
                                                        }
| LEER PARENTESISIZQ listaID PARENTESISDER PUNTOYCOMA {if(argumentosLeer>1)
                                                        {
                                                        printf("Error leer solo funciona con un solo argumento");
                                                         exit(0);
                                                        };
                                                        argumentosLeer=0;
                                                        printf("Leo el argumento %s\n",$3);
                                                        }
| ESCRIBIR PARENTESISIZQ listaExpresiones PARENTESISDER PUNTOYCOMA{if(argumentosEscribir>1)
                                                                    {
                                                                    printf("Error escribir funciona solo con un solo argumento ala vez");
                                                                    exit(0);
                                                                    };
                                                                    printf("El resultado de los argumentos en escribir es %d\n",$3);argumentosEscribir=0;
                                                                    }
;

listaID:IDENTIFICADOR {argumentosLeer++;$$=$1;}
| IDENTIFICADOR COMA listaID{argumentosLeer++;$$=$1;}
;

listaExpresiones:expresion {$$=$1;argumentosEscribir++;}
| expresion COMA listaExpresiones{argumentosEscribir++;}
;

expresion:primaria {$$=$1;}
| primaria RESTA primaria{$$=$1-$3;}
| primaria SUMA primaria{$$=$1+$3;}
;

primaria:CONSTANTE {$$=$1;}
| IDENTIFICADOR {if(!verificar($1,cont))
                {
                $$=valorID($1,cont);
                }
                else
                {
                printf("Error el identificador %s no esta declarado",$1);
                exit(0);
                };
                }
| PARENTESISIZQ expresion PARENTESISDER {$$=$2;}
;

%%

int main()
{
    yyparse();
    return 0;
}

void yyerror(char* p)
{
    fprintf(stderr, "Error semantico: %s\n",p);
}