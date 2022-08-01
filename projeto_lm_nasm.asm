;*******************************************************
; PROJETO FINAL DE LINGUAGENS DE MONTAGEM - 2022
; Grupo 3: 4(A X B) retornando o maior valor da diagonal principal.
;   GABRIEL FRANCISCO HABERMANN
;   CRISTIAN SANTOS DE CASTRO
;   IGNACIO ALFREDO SAVI GUALCO
;
;*******************************************************

    SECTION .data

;****** PARAMETROS E VARIAVEIS:
%define     i	       DWORD[ebp-4]
%define     j	       DWORD[ebp-8]
%define     k          DWORD[ebp-12]

%define     A          DWORD[ebp+8]
%define     B          DWORD[ebp+12]
%define     R          DWORD[ebp+16]
%define     L          DWORD[ebp+20]
%define     ESCALAR    DWORD[ebp+24]

;****** CONSTANTES:
%define     INT_SIZE   DWORD[ebp-16]

    SECTION .text

    global projeto_lm_nasm

;****** MACRO: acessa_matriz *******************
;*  Parametros:
;*        1 = endereço da matriz, indice [0][0]
;*        2 = i
;*        3 = j
%macro acessa_matriz 3
    mov eax,%2      ; i
    mul L           ; i*d
    mov ebx, %3     ; j
    add eax, ebx    ; (i*d)+j
    mul INT_SIZE    ; ((i*d)+j)*4
    
    mov ebx,%1      ; ebx = &matriz
    
    add ebx, eax    ; ebx = &matriz[i][j]
    mov eax,[ebx]   ; eax = *matriz[i][j]
%endmacro

;****** PROCEDURE: projeto_lm_nasm ****************
;*  Mapeamento dos registradores: (provisório)
;*      eax, ebx → uso em macros, atualização de matrizes
;*      ecx → contador loops i j e k
;*      edx → geral
;*      edi → acumulador para multiplicação das matrizes
;*      esi → geral
projeto_lm_nasm:
    push ebp
    mov ebp,esp
    sub esp, 16         ; espaço para variaveis i, j e k e a constante INT_SIZE
    push ebx
    mov INT_SIZE,4
    
    mov i, 0                                     ; inicializa i = 0
    for_i_begin:               
        mov ecx, i    
        cmp ecx, L                               ; compara i e L 
        jge max_diagonal
        mov j, 0                                 ; inicializa j = 0
        for_j_begin:            
            mov ecx, j        
            cmp ecx, L                           ; compara j e L 
            jge for_i_end

            mov k, 0                             ; inicializa k = 0
            mov edi,0                            ; zera o acumulador antes de adentrar o loop k
            for_k:
                mov ecx, k    
                cmp ecx, L                       ; compara k e L 
                jge for_j_end

                acessa_matriz  A, i, k          ; eax = A[i][k]
                mov  edx, eax                   ; edx = A[i][k]
                push edx                        ; é necessario empilhar edx neste ponto pois ele zera apos a chamada da macro
                
                acessa_matriz  B, k, j          ; eax = B[k][j]
                pop edx                         ; é necessario desempilhar edx neste ponto pois ele zera apos a chamada da macro
                mul edx                         ; eax = A[i][k] * B[k][j]
                add edi, eax

                inc k
                jmp for_k

        for_j_end:
        ; Multiplica por ESCALAR antes de armazenar na matriz: 
            mov eax, ESCALAR
            mul edi
            xchg edi, eax                       ; edi = 4* soma de A[i][k] * B[k][j] onde  i e j sao fixos
            acessa_matriz R, i, j
            mov [ebx], edi                      ; armazena o resultado na matriz
            
            inc j
            jmp for_j_begin

    for_i_end:
        inc i
        jmp for_i_begin
max_diagonal:
  
fim:
;******** FIM *******
    pop ebx 
    mov esp,ebp
    pop ebp
    ret