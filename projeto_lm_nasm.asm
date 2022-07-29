;*********************************************************
; PROJETO FINAL DE LINGUAGENS DE MONTAGEM - 2022
; Grupo 3: 4(A x B) retornando o maior valor da diagonal principal.
;   GABRIEL FRANCISCO HABERMANN
;   CRISTIAN SANTOS DE CASTRO
;   IGNACIO ALFREDO SAVI GUALCO
;
;**********************************************************

INT_SIZE  equ 4
%define     M   DWORD[ebp+8]
%define     I   DWORD[ebp+12]
%define     J   DWORD[ebp+16]
%define     L   DWORD[ebp+20]


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
    mov ecx, %3
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

    acessa_matriz M, I, J

    mov esp,ebp
    pop ebp
    ret