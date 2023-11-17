#ifndef ESTRUCTURA_H
#define ESTRUCTURA_H
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
struct id{
    int valor;
    char *nombre;
}tabla[20];
int cont=0;
int existeID(char *,int);
int cargarPalabrasReservadas();
void guardar(char * ,int  , int );
int valorID(int posicion);

int existeID(char *nombre,int posiciones)
{
    for(int i=0;i<=posiciones;i++)
    {
        if(!strcmp(tabla[i].nombre,nombre))
            return i;
    }
    return 0;
}

int cargarPalabrasReservadas()
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
    return 4;
}

void guardar(char * nombre,int valor , int posicion)
{
    tabla[posicion].nombre=nombre;
    tabla[posicion].valor=valor;
}

int valorID(int posicion)
{
    return tabla[posicion].valor;
}
#endif