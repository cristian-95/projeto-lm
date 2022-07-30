;*******************************************************
; PROJETO FINAL DE LINGUAGENS DE MONTAGEM - 2022
; Grupo 3: 4(A x B) retornando o maior valor da diagonal principal.
;   GABRIEL FRANCISCO HABERMANN
;   CRISTIAN SANTOS DE CASTRO
;   IGNACIO ALFREDO SAVI GUALCO
;
;*******************************************************

;** PARAMETROS E VARIAVEIS: ****************************
%define     I	DWORD[ebp-4]
%define     J	DWORD[ebp-8]
%define     K	DWORD[ebp-12]

%define     A   DWORD[ebp+8]
%define     B   DWORD[ebp+12]
%define     R   DWORD[ebp+16]
%define     L   DWORD[ebp+20]
%define     ESCALAR   DWORD[ebp+24]

;** CONSTANTES: ****************************************
INT_SIZE  equ 4

    SECTION .text
    global projeto_lm_nasm

;** macro: calcula_indice *******************
;*  parametros:
;*        1 endereço da matriz, indice [0][0]
;*        2 i
;*        3 j
;* armazena a soma para acessar o endereço &matriz[i][j] em eax

%macro acessa_matriz 3
    mov eax,%2      ; i
    
    mul L           ; i*d
    mov ebx, %3     ; j
    add eax,ebx     ; (i*d)+j
    mov ebx,INT_SIZE
    mul ebx         ; (((i*d)+j)*4)
    
    mov ebx,%1     ; &matriz
    add ebx,eax    ; ebx aponta para indice[i][j] da matriz
    mov eax,[ebx]  ; move o CONTEUDO apontado por ebx para eax    
    ; fim da macro:  eax = conteudo de M[I][J] 
    ;                ebx = endereço de M[I][J]
%endmacro

;** procedure: projeto_lm_nasm ****************
;*  mapeamento dos registradores: (provisório)
;*      eax, ebx → uso em macros, atualização de matrizes
;*      ecx → contador loops i j e k
;*      edx, edi → geral
;*      esi → &matriz
projeto_lm_nasm:

    push ebp
    mov ebp,esp
    sub esp, dword 12 ; espaço para variaveis i, j e k
    push ebx
    push ecx
	push edx
	push esi
	push edi

    mov I, dword 0                              ; inicializa I = 0
    for_i_body:               
        mov J, dword 0                          ; inicializa J = 0
        for_j_body:            
            mov K, dword 0                      ; inicializa K = 0
            xor edi,edi                         ; zera acumulador edi 
            for_k_body:
                
                ; acessa A[I][K]:
                mov esi, A                      ; esi = &A 
                acessa_matriz  esi, I, K
                mov  edx, eax                   ; edx = A[I][K]
                
                ; acessa B[K][J]:
                mov esi, B                      ; esi = &B
                acessa_matriz  esi, K, J
                ; note que o elemento em B[K][J] já esta em eax
                mul edx                         ; eax = A[I][K] * B[K][J]
                add edi, eax                    ; edi += A[I][K] * B[K][J]
            for_k_cond:
                mov ecx, K    
                cmp ecx, L                     ; compara K e L 
                jle for_j_cond  
            matriz_update:
                mov esi, R                      ; esi = &A 
                acessa_matriz esi, I, J
                ; multiplica por 4 antes de armazenar na matriz:
                mov eax, ESCALAR                ; eax = ESCALAR
                mul edi                         ; eax *= edi (acumulador)
                mov [ebx], eax                  ; armazena eax em R[I][J], apontado por ebx
                inc K               
                jmp for_k_body
        for_j_cond:
            mov ecx, J        
            cmp ecx, L                          ; compara J e L 
            jle for_i_cond
            inc J
            jmp for_j_body
    for_i_cond:
        mov ecx, I    
        cmp ecx, L                               ; compara I e L 
        jle max_diagonal
        inc I
        jmp for_i_body


max_diagonal:
    mov eax, dword -1




;******** FIM *******

	pop edi	
	pop esi
	pop edx
    pop ecx
    pop ebx    

    mov esp,ebp
    pop ebp
    ret