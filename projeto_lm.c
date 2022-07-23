/* PROJETO FINAL DE LINGUAGENS DE MONTAGEM - 2022
 * Grupo 3: 4(A x B) retornando o maior valor da diagonal principal.
 *  GABRIEL FRANCISCO HABERMANN
 *  CRISTIAN SANTOS DE CASTRO
 *  IGNACIO ALFREDO SAVI GUALCO
 * 
 *  OBS: CODIGO COMENTADO PARA FINS DE TESTE
 */
#include<stdio.h>
#include<stdlib.h>
#include<time.h>

/* Constantes:   */

const int ESCALAR = 4;
const int L = 2;

/*  Funções externas:   */

extern int projeto_lm_nasm(int *, int *);  //  isso resolveu os warnings

/* Funções auxiliares:  */

void geraMatriz(int m[L][L]){
    int i, j, num;
    
    for (i=0; i<L; i++){
        for (j=0; j<L; j++){
            num = rand()%10+1; // gera numeros de numeros de 1 a 10
            m[i][j] = num;
        }
    }    
}

void multiplicaMatriz(int r[L][L], int A[L][L], int B[L][L]){
    int i, j, k;

    for (i=0; i<L; i++){
        for (j=0; j<L; j++){
            r[i][j] = 0;
            for (k=0; k<L; k++){
                r[i][j] = A[i][k] * B[k][j];
            }
        }
    }
}

void multiplicaMatrizComEscalar(int r[L][L]){
    int i, j;
 
    for(i=0; i<L; i++){
        for (j=0; j<L; j++){
            r[i][j] = r[i][j]*ESCALAR;
        }
    }
}

int maxDiagonal(int m[L][L]){
    int i, max=0;
    for(i=0; i<L; i++){
        if (m[i][i] > max){
            max = m[i][i];
        }
    }    
    return max;        
}

void printMatriz(int M[L][L]){
    int i, j;
    for (i=0; i<L; i++){
        for (j=0; j<L; j++){
            printf("%d\t",M[i][j]);
        }
        puts("\n");
    }
}

void zeraMatriz(int M[L][L]){
    int i, j;
    for (i=0; i<L; i++){
        for (j=0; j<L; j++){  M[i][j] = 0;  }
    }
}

int main(){
    srand(time(NULL)); // semente para funcao rand gerar numeros diferentes
    int A[L][L];
    int B[L][L];
    //int R[L][L];
    int max=0;
    //clock_t cTime;
    //clock_t asmTime;
    
    
    // Execução em C:
    // cTime = clock();
    //     geraMatriz(A);
    //     geraMatriz(B);
    
    //     printf("Matriz A:\n");
    //     printMatriz(A);    
    //     printf("Matriz B:\n");
    //     printMatriz(B);

    //     multiplicaMatriz(R,A,B);
    //     printf("Matriz R = A x B\nR:\n");
    //     printMatriz(R);
    
    //     multiplicaMatrizComEscalar(R);
    //     printf("%d * R:\n",ESCALAR);
    //     printMatriz(R);

    //     max = maxDiagonal(R);

    //     printf("Maior valor da diagonal principal [C]: %d\n\n",max);
    // cTime = clock() - cTime;

    // // zera variaveis:
    // zeraMatriz(A);
    // zeraMatriz(R);
    // max = 0;

    // Execução em Assembly:
    //asmTime = clock();
        geraMatriz(A);
        zeraMatriz(B);
        //geraMatriz(B);
        printf("Matriz A:\n");
        printMatriz(A);    
        printf("Matriz B:\n");
        printMatriz(B);
        
        
        max = (int) projeto_lm_nasm(*A,*B);        
        printf("TESTE: soma dos elementos de A = %d\n",max);
       // printf("Maior valor da diagonal principal [ASM]: %d\n",max);
       
    //asmTime = clock() - asmTime;

    // SAIDA
//    printf("Tempo de execução [ASM]: %.2f ms\n",((double)asmTime));
    //printf("Tempo de execução [C]: %.2f ms\n",((double)cTime));
    return 0;
}
