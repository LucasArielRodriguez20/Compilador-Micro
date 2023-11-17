%option noyywrap
%{
#include "./y.tab.h"
#include <string.h>
void verificarLongitudId(int);///tipos 
%}
CONSTANTE      [0-9]+
IDENTIFICADOR  [A-Za-z][A-Za-z0-9]*

%%
"inicio" {return INICIO;}
"fin" {return FIN;}
"leer" {return LEER;}
"escribir" {return ESCRIBIR;}
"(" {return PARENTESISIZQ;}
")" {return PARENTESISDER;}
";" {return PUNTOYCOMA;}
"," {return COMA;}
":=" {return ASIGNACION;}
"+" {return SUMA;}
"-" {return RESTA;} 
"FDT" {return FDT;}
{CONSTANTE} {yylval.num=atoi(yytext);return CONSTANTE;}
{IDENTIFICADOR} {verificarLongitudId(yyleng);yylval.palabra=strdup(yytext);return IDENTIFICADOR;}
\s|\n|\t|" " {} 
. {printf("Error el simbolo %s no pertenece al lenguaje\n",yytext);exit(0);}
%%

void verificarLongitudId(int longitudID)
{
    if(longitudID>32)
    {
        printf("Error el ID %s es demasiado largo\n",yytext);
        exit(0);
    }
}
