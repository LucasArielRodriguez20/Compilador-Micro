#ifndef ESTRUCTURA_H
#define ESTRUCTURA_H
#include <string.h>
#include <stdio.h>
struct id{
    int valor;
    char *nombre;
}tabla[20];
int cont=0;
int argumentosEscribir=0;
int argumentosLeer=0;
int verificar(char *,int);
int cargarPalabrasReservadas(int);
void guardar(char * ,int  , int );
int valorID(char * ,int);
int verificar(char *nombre,int posiciones)
{
    
    for(int cont=0;cont<=posiciones;cont++)
    {
        if(!strcmp(tabla[cont].nombre,nombre))
            return 0;
    }
    return 1;
}

int cargarPalabrasReservadas(int posicionesExistentes)
{
    if(posicionesExistentes == 0)
    {
        tabla[0].valor=0;
        tabla[0].nombre="leer";
        tabla[1].valor=0;
        tabla[1].nombre="escribir";
        tabla[2].valor=0;
        tabla[2].nombre="inicio";
        tabla[3].valor=0;
        tabla[3].nombre="fin";
        tabla[4].valor=0;
        tabla[4].nombre="fdt";
        printf("termino la carga de PR\n");
        return 4;
    }
    return posicionesExistentes;
}

void guardar(char * nombre,int valor , int posicion)
{
    tabla[posicion].nombre=nombre;
    tabla[posicion].valor=valor;
}

int valorID(char * nombre,int posiciones)
{
    for(int cont=0;cont<=posiciones;cont++)
    {
        if(!strcmp(tabla[cont].nombre,nombre))
            return tabla[cont].valor;
    }
    return -1;
}
#endif