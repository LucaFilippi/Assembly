TITLE Numero
.MODEL SMALL
.STACK 100h
.DATA
    MSG1 DB "Digite um caractere: $"
    SIM DB 10,13, "O caractere deigitado eh um numero.$"
    NAO DB 10,13, "O caractere digitado nao eh um numero$"
.CODE
MAIN PROC
    ;permite acesso às variaveis definidas em .DATA
    MOV AX,@DATA
    MOV DS,AX
    ;Exibe na tela a string de MSG1
    MOV AH,9
    MOV DX,OFFSET MSG1
    INT 21h
    ;Lê um caractere do teclado e salva o caractere lido em AL 
    MOV AH,1
    INT 21h
    ;Copia o caractere lido para BL
    MOV BL,AL 
    ;Compara o caractere em BL com o valor 48 (codigo ASCII do carcater "0")
    CMP BL,48
    ;Se o caractere eM BL for menor que 48, salta para o rotulo NAOENUMERO
    JB NAOENUMERO
    ;Compara o caracter em bl com o valor 57 (codigo ASCII do carcater "9")
    CMP BL,57
    ;Se o caracter em bl for maior que 57 ("9"), salta para o rotulo NAOENUMERO
    JA NAOENUMERO
    ;Se chegou at eaqui, exibe na tela que o caracter é um numero 
    MOV AH,9
    MOV DX,OFFSET SIM
    INT 21h
    ;salta para o rotulo fim 
    JMP FIM                 
    ;define o rotulo NAOENUMERO
    NAOENUMERO: 
    ;exibe na tela dizendo que o caracter não é um numero
    MOV AH,9
    MOV DX,OFFSET NAO
    INT 21h
    ;Define o rotulo FIM 
    FIM: 
    ;FInaliza o programa 
    MOV AH,4Ch
    INT 21h
    MAIN ENDP
    END MAIN

    ;Esse codigo pede para o usuario digitar um caracter qualquer do teclado, e então ele analisa se o caracter digitado é um numero ou não é um numero. 
    