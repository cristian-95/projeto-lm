
# projeto-lm

- Lembre-se: **baby steps**!
- Comandos para compilar:  

```

nasm -f elf -o projeto_lm_nasm.o projeto_lm_nasm.asm

```

```

gcc -m32 -o projeto_lm.out projeto_lm.c projeto_lm_nasm.o

```

## TO-DO 

### Em um arquivo .asm: 

- [x] Retornar um numero para teste de stack-frame  

- [x] Acessar um elemento da matriz e retornar

- [x] Acesso a índice M[i][j] (macro)  

- [ ] Loops de multiplicação (indices i, j e k)

- [ ] Maior valor da diagonal (macro)

- [ ] Comentar código  

- [ ]  Traduzir para sintaxe gas


### No arquivo projeto_lm.c:

- [ ] Chamar código assembly com sintaxe gas (.s)

### Testes realizados no arquivo .asm:

Teste: acessa A[0][0] e B[0][0]
retorna a soma de todos os elementos de A[2][2]:


prototipo da função:  ```extern int projeto_lm_nasm(int *,int *);```
```
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
```

Teste: acessa um numero passado no primeiro parametro da função C
e retorna seu dobro.

prototipo da função: ```extern int projeto_lm_nasm(int);```
```
    push ebp
    mov ebp,esp  
    
    mov eax,[ebp+8]
    add eax,eax
    
    mov esp,ebp
    pop ebp
    ret
```

Teste: macro que retorna um elemento em dado indice i e j

Prototipo da função: ```extern int projeto_lm_nasm(int *,int,int,int); ```
```
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
```