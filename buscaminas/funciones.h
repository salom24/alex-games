//Añado librerias

#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <ctype.h>
#include <string.h>


//Macros
#define _MOSTRAR 1
#define _TABLERO 0

#define _GANADO 1
#define _EXPLOSION 2
#define _CONTINUA 0


//Ahora los prototipos

void cuadricula(short fil /*filas*/,
                short col /*columnas*/,
                char tablero[2][fil][col] /*matriz tablero*/,
                short minas /*numero de minas*/);

void ceros(short fil /*filas*/ ,
           short col /*columnas*/ ,
           short f /*numero de fila*/ ,
           short c /*numero de columna*/,
           char tablero[2][fil][col] /*matriz tablero*/);

void inittablero(short fil /*filas*/,
                 short col /*columnas*/,
                 char tablero[2][fil][col] /*matriz tablero*/,
                 short * minas /*numero de minas*/,
                 short * fin /*fin del fuego*/,
                 float prob /*probabilidad de minas*/);

short entrada(short fil /*filas*/,
              short col /*columnas*/,
              char tablero[2][fil][col] /*matriz tablero*/,
              short fin /*fin del fuego*/);

