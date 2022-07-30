;*******************************************************
; PROJETO FINAL DE LINGUAGENS DE MONTAGEM - 2022
; Grupo 3: 4(A x B) retornando o maior valor da diagonal principal.
;   GABRIEL FRANCISCO HABERMANN
;   CRISTIAN SANTOS DE CASTRO
;   IGNACIO ALFREDO SAVI GUALCO
;
;*******************************************************

;** PARAMETROS: ****************************************
;   projeto_lm_nasm(int *,int *,int *,int);
%define     A   DWORD[ebp+8]
%define     B   DWORD[ebp+12]
%define     R   DWORD[ebp+16]
%define     L   DWORD[ebp+20]

;** CONSTANTES: ****************************************
INT_SIZE  equ 4

    SECTION .text
    global projeto_lm_nasm

;** macro: acessa_matriz *******************
;*  parametros:
;*        1 endereço da matriz, indice [0][0]
;*        2 i
;*        3 j
%macro acessa_matriz 3
    mov eax,%2      ; i
    
    mul L           ; i*d
    mov ecx, %3     ; j
    add eax,ecx     ; (i*d)+j
    mov ecx,INT_SIZE
    mul ecx         ; (((i*d)+j)*4)
    
    mov ecx,%1      ; &matriz
    add ecx,eax    ; ecx aponta para indice[i][j] da matriz
    mov eax,[ecx]  ; move o CONTEUDO apontado por ecx para eax    
%endmacro

;** procedure: projeto_lm_nasm ****************
;*  mapeamento dos registradores: (provisório)
;*      eax, ecx → uso em macros, atualização de matrizes
;*      ebx → contador loop
;*      edx → 
;*      edi →  endereço de matrizes
projeto_lm_nasm:

    push ebp
    mov ebp,esp

    mov edx,0
    mov ecx,2

    acessa_matriz A, edx, ecx


;******** FIM ********
    mov esp,ebp
    pop ebp
    ret