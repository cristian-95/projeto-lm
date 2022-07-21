;*********************************************************
; PROJETO FINAL DE LINGUAGENS DE MONTAGEM - 2022
; Grupo 3: 4(A x B) retornando o maior valor da diagonal principal.
;  GABRIEL FRANCISCO HABERMANN
;  CRISTIAN SANTOS DE CASTRO
;  IGNACIO ALFREDO SAVI GUALCO
;**********************************************************

    SECTION .text
    global projeto_lm_nasm


;; teste primario para retornar apenas o tamanho da matriz multiplicado por 2:


projeto_lm_nasm:
        push ebp
        mov ebp,esp
        mov eax,[ebp+8]
        add eax,eax
        mov esp,ebp
        pop ebp
        ret
        ; estrutura copiada do exemplo sum.asm da AULA 8