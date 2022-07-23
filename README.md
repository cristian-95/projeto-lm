
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

- [ ] Acesso a índice M[i][j] (macro em progresso)  

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