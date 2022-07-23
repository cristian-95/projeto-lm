;*********************************************************
; PROJETO FINAL DE LINGUAGENS DE MONTAGEM - 2022
; Grupo 3: 4(A x B) retornando o maior valor da diagonal principal.
;  GABRIEL FRANCISCO HABERMANN
;  CRISTIAN SANTOS DE CASTRO
;  IGNACIO ALFREDO SAVI GUALCO
;        
;     ATENÇÃO:
;     EVITE USAR O REGISTRADOR EBX PARA ARMAZENAR NADA 
;     DA PILHA [EBP] ISSO PARECE CAUSAR SEGMENTATION FAULT
;
;**********************************************************

INT_SIZE  equ 4
;%define     M   DWORD[ebp+8]
;%define     I   DWORD[ebp+12]
;%define     J   DWORD[ebp+16]
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
    mov edx, %1     ; matriz
    mov eax, %2     ; i
    mov ecx, %3     ; j
    mul L           ; eax: i*d
    add eax, ecx    ; eax: (i*d)+j
    mov ecx, INT_SIZE ;  4
    mul ecx         ; eax: ((i*d)+j)*4
    xchg ecx,eax
    mov edx, [edx+ecx]
%endmacro

projeto_lm_nasm:

    push ebp
    mov ebp,esp

    mov edx, [ebp+8]    ; &matriz
    mov eax, [ebp+12]   ; i
    mov ecx, [ebp+16]   ; j
    
    acessa_matriz edx, eax, ecx

    mov eax,edx
    
    mov esp,ebp
    pop ebp
    ret