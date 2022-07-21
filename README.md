
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

- [ ] Acesso a índice M[i][j] (macro)  

- [ ] Maior valor da diagonal (macro)

- [ ] Comentar código  

- [ ]  Traduzir para sintaxe gas


### No arquivo projeto_lm.c:

- [ ] Chamar código assembly com sintaxe gas (.s)