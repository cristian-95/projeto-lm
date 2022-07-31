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
extern int projeto_lm_nasm(int *,int *,int *,int,int);

/* Funções auxiliares:  */

void geraMatriz(int m[L][L]){
    int i, j, num;
    
    for (i=0; i<L; i++){
        for (j=0; j<L; j++){
            num = i+j+1;
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
                r[i][j] += A[i][k] * B[k][j];
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

int maxDiagonal(int M[L][L]){
    int i, max=0;
    for(i=0; i<L; i++){
        if (M[i][i] > max){
            max = M[i][i];
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
    int R[L][L];
    int max=0;
    clock_t cTime;
    clock_t asmTime;
    
    geraMatriz(A);
    geraMatriz(B);
    zeraMatriz(R);
    
    printf("Matriz A:\n");
    printMatriz(A);    
    printf("Matriz B:\n");
    printMatriz(B);
    
    /* Execução em C: */
    cTime = clock();
        multiplicaMatriz(R,A,B);
        multiplicaMatrizComEscalar(R);
        max = maxDiagonal(R);
    cTime = clock() - cTime;
    
    printf("Matriz R:\n");
    printMatriz(R);
    printf("Maior valor da diagonal principal [C]: %d\n\n",max);

    /* Zera variaveis: */
    max = 0;
    zeraMatriz(R);
    printf("\n***********\nMatriz R zerada:\n");
    printMatriz(R);
    
    /* Execução em Assembly: */
    asmTime = clock();
        max = projeto_lm_nasm(*A,*B,*R,L,ESCALAR);                
    asmTime = clock() - asmTime;

    printf("Matriz R:\n");
    printMatriz(R);
    printf("Maior valor da diagonal principal [ASM]: %d\n",max);       

    printf("Tempo de execução [C]: %.3f ms\n",((double)cTime));
    printf("Tempo de execução [ASM]: %.3f ms\n",((double)asmTime));
    return 0;
}