;*********************************************************
; PROJETO FINAL DE LINGUAGENS DE MONTAGEM - 2022
; Grupo 3: 4(A x B) retornando o maior valor da diagonal principal.
;  GABRIEL FRANCISCO HABERMANN
;  CRISTIAN SANTOS DE CASTRO
;  IGNACIO ALFREDO SAVI GUALCO
;**********************************************************

    SECTION .text
    global projeto_lm_nasm

projeto_lm_nasm:

    push ebp
    mov ebp,esp
        
    mov   ecx, [ebp+8]      ;; ecx tem o endereço de A[0][0]
    mov   edx, [ebp+12]     ;; edx tem o endereço de B[0][0]
    mov   eax, [ecx]        ;; eax = A[0][0]
    add   eax, [ecx+4]      ;; eax += A[0][1]
    add   eax, [ecx+8]      ;; eax += A[1][0]
    add   eax, [ecx+12]     ;; eax += A[1][1]
        
    mov esp,ebp
    pop ebp
    ret