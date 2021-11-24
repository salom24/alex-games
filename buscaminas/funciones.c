#include "funciones.h"

//Funcion que pinta el tablero
void cuadricula(short fil , short col , char tablero[2][fil][col] , short minas){
    
    system("clear"); //”clear” para entornos UNIX
    short i , j , n;
    
    time_t tiempo = time(0);
    struct tm *tlocal = localtime(&tiempo);
    char time[128];
    strftime(time,128,"%d/%m/%y %H:%M",tlocal);
    
    //Cabecera y hora
    printf("+-----------------------+\n");
    printf("|  B U S C A M I N A S  |      %s\n",time);
    printf("+-----------------------+\n\n");
    
    for (i=0 , n = 0 ;i<fil;i++)
        for (j=0;j<col;j++)
            if (tablero[_MOSTRAR][i][j]=='M') n++;
    
    //Minas y marcadas
    printf("NUMERO DE MINAS  .........   %hd\n",minas);
    printf("MINAS INTRODUCIDAS  ......   %hd\n",n);
    
    //Cuadricula
    for(i=0;i<fil;i++){
        if (i==0){
            for(n=1;n<=col;n++){
                if(n==1) printf("   %2hd  ",n);
                else printf("%2hd  ",n);
            }
            printf("\n");
            for(j=0;j<col;j++){
                if (j==0) printf("  +---+");
                else printf("---+");
            }
            printf("\n");
        }
        for(j=0;j<col;j++){
            if (j==0) printf("%2d| %c |",i+1,tablero[_MOSTRAR][i][j]);
            else printf(" %c |",tablero[_MOSTRAR][i][j]);
        }
        printf("\n");
        for(j=0;j<col;j++){
            if (j==0) printf("  +---+");
            else printf("---+");
        }
        printf("\n");
    }
}

//Funcion que levanta las casillas alrededor de un cero
void ceros(short fil , short col , short f , short c , char tablero[2][fil][col]){
    short nf , nc;
    if(tablero[_MOSTRAR][f][c]=='0'){
        tablero[_MOSTRAR][f][c]='_';
        for (nf=(f==0?f:f-1); nf<=(f==(fil-1)?f:f+1);nf++)
            for (nc=(c==0?c:c-1);nc<=(c==(col-1)?c:c+1);nc++){
                if(tablero[_MOSTRAR][nf][nc]!='_') tablero[_MOSTRAR][nf][nc]=tablero[_TABLERO][nf][nc];
                if(tablero[_MOSTRAR][nf][nc]=='0') ceros(fil, col, nf, nc , tablero);
            }
    }
    return;
}

//Funcion que inicia las minas y valores del tablero
void inittablero(short fil , short col , char tablero[2][fil][col] , short * minas , short * fin , float prob){
    
    srand((int)time(NULL));
    short f , c , nf , nc;
    char contador;
    
    for (f=0;f<fil;f++)
        for(c=0;c<col;c++)
            tablero[_MOSTRAR][f][c]=' ';
    
    
    // Introduciendo aleatoriamente las minas
    
    for (f=0 , *minas = 0 , *fin = 0 ;f<fil;f++){
        for(c=0;c<col;c++){
            if ((float)rand()/RAND_MAX<prob){
                tablero[_TABLERO][f][c]='*';
                (*minas)++;
            }
            else {
                tablero[_TABLERO][f][c]='0';
                (*fin)++;
            }
        }
    }
    
    // Contando minas alrededor de cada casilla
    
    for(f=0;f<fil;f++){
        for(c=0;c<col;c++){
            if (tablero[_TABLERO][f][c]!='*'){
                for (nf=(f==0?f:f-1), contador ='0'; nf<=(f==(fil-1)?f:f+1);nf++)
                    for (nc=(c==0?c:c-1);nc<=(c==(col-1)?c:c+1);nc++)
                        if(tablero[_TABLERO][nf][nc]=='*')
                            contador++;
                tablero[_TABLERO][f][c] = contador;
            }
        }
    }
}

//Funcion que opera con la entrada del jugador
short entrada(short fil , short col , char tablero[2][fil][col] , short fin){
    
    short i , j , fin2;
    char entrada[10];
    
    //Primero da opcion de marcar mina o levantar casilla
    printf("Marcar mina (M) o introducir fila para levantar:\n");
    do { scanf("\n%s",entrada);} while ((isdigit(entrada[0]))?(atoi(entrada)<1 || atoi(entrada)>fil) : (entrada[0]!='M'&&entrada[0]!='m'));
    
    //Si se decide marcar mina...
    if(entrada[0]=='M' || entrada[0]=='m'){
        
        printf("Introducir fila :\n");
        do { scanf("%hd",&i);} while (i<1 || i>fil);
        i--;
        printf("Introducir columna:\n");
        do { scanf("%hd",&j);} while (j<1 || j>col);
        j--;
        tablero[_MOSTRAR][i][j]='M';
        return _CONTINUA;
        
        //Si se decide levantar casilla...
    } else {
        
        i=atoi(entrada);
        i--;
        printf("Introducir columna:\n");
        do { scanf("%hd",&j);} while (j<1 || j>col);
        j--;
        if(tablero[_TABLERO][i][j]!='*'){
            
            tablero[_MOSTRAR][i][j]=tablero[_TABLERO][i][j];
            ceros(fil, col, i, j, tablero);
            for (i=0 , fin2 = 0 ;i<fil;i++)
                for(j=0;j<col;j++)
                    if (tablero[_MOSTRAR][i][j]!=' ' && tablero[_MOSTRAR][i][j]!='M' && tablero[_TABLERO][i][j]!='*')fin2++;
            if (fin==fin2) return _GANADO;
            else return _CONTINUA;
            
        } else {
            
            for (i=0;i<fil;i++)
                for(j=0;j<col;j++)
                    tablero[_MOSTRAR][i][j]=tablero[_TABLERO][i][j];
            return _EXPLOSION;
        }
    }
}
