;*********************************************************
; PROJETO FINAL DE LINGUAGENS DE MONTAGEM - 2022
; Grupo 3: 4(A x B) retornando o maior valor da diagonal principal.
;  GABRIEL FRANCISCO HABERMANN
;  CRISTIAN SANTOS DE CASTRO
;  IGNACIO ALFREDO SAVI GUALCO
;
;**********************************************************

INT_SIZE  equ 4
%define     M   DWORD[ebp+8]
%define     I   DWORD[ebp+12]
%define     J   DWORD[ebp+16]
%define     L   DWORD[ebp+20] ;; quarto parametro da função → funciona


    SECTION .text
    global projeto_lm_nasm


;; Teste acesso a indice [i][j] via macro
;; prototipo da função: extern int projeto_lm_nasm(int *,int,int);
;; passando os parametros para a macro acessa na mesma ordem 
;; dos parametros da função C + um para retorno
;;  1 endereço da matriz, indice [0][0]
;;  2 indice i
;;  3 indice j
;;  indice [i][j] = ((i*d)+j)*4
%macro acessa_matriz 3
   mov edx, %1      ; &matriz
    mov eax, %2     ; i
    mov ecx, %3     ; j
    mul L           ; i*d
    add eax,ecx     ; (i*d)+j
    mov ecx, INT_SIZE
    mul ecx         ; (((i*d)+j)*4)
    mov ecx, %1     ; ecx aponta para  indice[0][0] da matriz
    add ecx, eax    ; ecx aponta para indice[i][j] da matriz
    mov eax, [ecx]  ; move o CONTEUDO apontado por ecx para eax    
%endmacro

projeto_lm_nasm:

    push ebp
    mov ebp,esp

    acessa_matriz M, I, J

    mov esp,ebp
    pop ebp
    ret