%{
#include "estructura.h"
#include <stdlib.h>
#include <string.h>
#include <stdio.h>
extern int yylex(void);
extern void yyerror(char*);

%}

%token INICIO FIN LEER ESCRIBIR IDENTIFICADOR CONSTANTE PARENTESISIZQ PARENTESISDER PUNTOYCOMA COMA ASIGNACION SUMA RESTA FDT 

%union{
    char *palabra;
    int num;
}

%type <num> CONSTANTE primaria expresion
%type <palabra> listaID  IDENTIFICADOR listaExpresiones
%%

objetivo: program FDT {printf("Fin del programa\n");return 0;}
;

program:INICIO  listaSentencias FIN
;

listaSentencias: sentencia listaSentencias 
| sentencia
;

sentencia:IDENTIFICADOR ASIGNACION expresion PUNTOYCOMA {if(!existeID($1,cont))
                                                        {
                                                        guardar($1,$3,++cont);
                                                        printf("Se guardo con exito %d en el ID %s\n",$3,$1);
                                                        }
							                            else{
							                            printf("Error el identificador %s ya esta en uso o es una palabra resevada\n",$1);
            						                    exit(0);
							                            };
                                                        }
| LEER PARENTESISIZQ listaID PARENTESISDER PUNTOYCOMA {printf("Leo los identificadores %s\n",$3);
                                                      }
| ESCRIBIR PARENTESISIZQ listaExpresiones PARENTESISDER PUNTOYCOMA{printf("El resultado de los argumentos en escribir es %s\n",$3);
                                                                  }
;

listaID:IDENTIFICADOR {$$=$1;}
| IDENTIFICADOR COMA listaID{$$=strcat(strcat($1,","),$3);}
;

listaExpresiones:expresion {char aux[10];
		                    sprintf(aux, "%d", $1);
		                    $$=aux;}
| expresion COMA listaExpresiones{char aux[10];
		                          sprintf(aux, "%d", $1);
			                      char *aux2 = aux;
			                      $$=strcat(strcat(aux2,","),$3);}
;

expresion:primaria {$$=$1;}
| primaria RESTA primaria{$$=$1-$3;}
| primaria SUMA primaria{$$=$1+$3;}
;

primaria:CONSTANTE {$$=$1;}
| IDENTIFICADOR {int aux = existeID($1,cont);
		        if(aux)
                {
                $$=valorID(aux);
                }
                else
                {
                printf("Error el identificador %s no esta declarado\n",$1);
                exit(0);
                };
                }
| PARENTESISIZQ expresion PARENTESISDER {$$=$2;}
;

%%

int main()
{
    cont = cargarPalabrasReservadas();
    yyparse();
    return 0;
}

void yyerror(char* p)
{
    fprintf(stderr, "Error en parser: %s\n",p);
}