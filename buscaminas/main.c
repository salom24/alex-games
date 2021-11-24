#include "funciones.h"

int main(int argc, const char * argv[])
{
    //Intro
    {
        system("clear"); //”clear” para entornos UNIX
        printf("###########################################################################\n");
        printf("###########################################################################\n");
        printf("###                                                                     ###\n");
        printf("###      ###  #  #  ###   ###  ###   #   #  ##### #   #  ###   ###      ###\n");
        printf("###      #  # #  # #     #    #   # # # # #   #   ##  # #   # #         ###\n");
        printf("###      ###  #  #  ##  #     ##### #  #  #   #   # # # #####  ##       ###\n");
        printf("###      #  # #  #    #  #    #   # #     #   #   #  ## #   #    #      ###\n");
        printf("###      ###   ##  ###    ### #   # #     # ##### #   # #   # ###       ###\n");
        printf("###                                                                     ###\n");
        printf("###########################################################################\n");
        printf("###########################################################################\n");
        getchar();
    }
    
    
    //Iniciando variables
    short  minas , fin;
    short t1 , t2 ;
    float prob;
    
    
    //Eleccion de nivel (Da tamaño de tablero y nº aproximado de minas)
    short l;
    system("clear"); //”clear” para entornos UNIX
    printf("Elige un nivel!\n");
    printf("1 ... Facil\n");
    printf("2 ... Medio \n");
    printf("3 ... Dificil\n");
    printf("4 ... Personalizado\n");
    do { scanf("%hd",&l);} while (l<1 || l>4);
    
    switch(l){
        case 1:{
            t1=5;
            t2=5;
            prob=0.1;
            break;
        }
        case 2:{
            t1=7;
            t2=10;
            prob=0.15;
            break;
        }
        case 3:{
            t1=10;
            t2=20;
            prob=0.2;
            break;
        }
        case 4:{
            printf("\nNumero de filas ... ");
            scanf("%hd",&t1);
            printf("\nNumero de columnas ... ");
            scanf("%hd",&t2);
            do {
                printf("\nNumero aprox. de minas ... ");
                scanf("%hd",&l);
                prob=(float)l/(t1*t2);
                if (l>t1*t2)
                    printf("Demasiadas minas! vuelve a introducirlo");
                else if (l>t1*t2/4){
                    printf("Has introducido muchas minas!\n Estas seguro? (S/N)\n");
                    if(getchar()!='S' && getchar()!='s')
                        l=t1*t2+1;
                }
            } while (l>t1*t2);
            break;
        }
            
    }
    
    //Inicializacion de la matriz
    char tablero[2][t1][t2];
    
    
    //Algoritmo del juego
    do{
        
        do{ inittablero(t1, t2, tablero, &minas, &fin, prob); } while (minas<3);
        
        cuadricula(t1, t2, tablero, minas);
        
        do {
            
            l = entrada(t1, t2, tablero, fin);
            cuadricula(t1, t2, tablero, minas);
            
        } while ( l != _EXPLOSION && l != _GANADO);
        
        if(l==_GANADO) printf("\nENHORABUENA!!! HAS GANADO! :D");
        if(l==_EXPLOSION) printf("\nOooh... Has perdido, otra vez sera!");
        
        printf("\n\n Jugar otra vez?\n1 --> SI\n2 --> NO\n");
        do { scanf("%hd",&l); } while (l!=1 && l!=2);
        
    } while (l==1);
    
    return 0;
}
