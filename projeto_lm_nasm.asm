;*******************************************************
; PROJETO FINAL DE LINGUAGENS DE MONTAGEM - 2022
; Grupo 3: 4(A i B) retornando o maior valor da diagonal principal.
;   GABRIEL FRANCISCO HABERMANN
;   CRISTIAN SANTOS DE CASTRO
;   IGNACIO ALFREDO SAVI GUALCO
;
;*******************************************************

    SECTION .data

;** PARAMETROS E VARIAVEIS: ****************************
%define     i	DWORD[ebp-4]
%define     j	DWORD[ebp-8]
%define     k	DWORD[ebp-12]

%define     A   DWORD[ebp+8]
%define     B   DWORD[ebp+12]
%define     R   DWORD[ebp+16]
%define     L   DWORD[ebp+20]
%define     ESCALAR   DWORD[ebp+24]

;sum:    DW  0

;** CONSTANTES: ****************************************
INT_SIZE  equ 4

    SECTION .text
    global projeto_lm_nasm

;** macro: acessa_matriz *******************
;*  Parametros:
;*        1 endereço da matriz, indice [0][0]
;*        2 i
;*        3 j
;*  Registradores:
;*        eax receberá o conteudo em matriz[i][j]
;*        ebx receberá o endereço de matriz[i][j]
%macro acessa_matriz 3
    mov eax,%2      ; i
    mul L           ; i*d
    mov ebx, %3     ; j
    add eax,ebx     ; (i*d)+j
    mov ebx,INT_SIZE; 4
    mul ebx         ; eax = (((i*d)+j)*4)
    
    mov ebx,%1      ; &matriz
    add ebx,eax     ; ebx aponta para indice[i][j] da matriz
    mov eax,[ebx]   ; move o CONTEÚDO apontado por ebx para eax 
;******************** fim da macro:  eax = conteudo de M[i][j] 
;********************                ebx = endereço de M[i][j]
%endmacro

;** macro: calcula_i_j *******************
;*  Parametros:
;*        1 i
;*        2 j
;*  Registradores:
;*        eax receberá o endereço de matriz[i][j]
%macro calcula_indice 2
    mov eax,%1      ; i
    mul L           ; i*d
    mov ebx, %2     ; j
    add eax, ebx    ; (i*d)+j
    mov ebx,INT_SIZE; 4
    mul ebx         ; eax = (((i*d)+j)*4)
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
    sub esp, 12 ; espaço para variaveis i, j e k
    push ebx

    mov i,  0                              ; inicializa i = 0
    for_i_body:               
        mov j,  0                          ; inicializa j = 0
        for_j_body:            
            mov k,  0                      ; inicializa k = 0
            xor edi,edi
            for_k_body:
                
                ; acessa A[i][k]:
                mov esi, A                      ; esi = &A 
                acessa_matriz  esi, i, k
                mov  edx, eax                   ; edx = A[i][k]
                push edx                        ; é necessario empilhar edi neste ponto senão ele kera apos a chamada da macro
                ; acessa B[k][j]:
                mov esi, B                      ; esi = &B      
                acessa_matriz  esi, k, j
                ; note que o elemento em B[k][j] já esta em eax
                pop edx                         ; é necessario desempilhar edi neste ponto pois ele kera apos a chamada da macro
                mul edx                        ; eax = A[i][k] * B[k][j]
                add edi, eax

            for_k_cond:
                mov ecx, k    
                cmp ecx, L                     ; compara k e L 
                jge for_j_end
                inc k               
                jmp for_k_body

        for_j_end:
            ; ABAIXO TRECHO QUE MULTIPLICA POR 4    
            ;mov eax, edi
            ;mov eax, ESCALAR
            ;imul edi
            ;mov edi, eax
            mov esi, R
            calcula_indice i, j
            mov [esi+eax], edi
            
        for_j_cond:
            mov ecx, j        
            cmp ecx, L                          ; compara j e L 
            jge for_i_cond
            inc j
            jmp for_j_body
    for_i_cond:
        mov ecx, i    
        cmp ecx, L                               ; compara i e L 
        jge max_diagonal
        inc i
        jmp for_i_body



max_diagonal:
            xor eax,eax
  
   
    

fim:
;******** FIM *******
    pop ebx 
    mov esp,ebp
    pop ebp
    ret