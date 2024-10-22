TITLE Helloworld com subrotinas
.MODEL SMALL
.STACK 100h ;determina o tamanho do pilha
.DATA
hello DB "hello world $" ;define a variavel hello contendo a string
.CODE 
MAIN PROC 
    ; Permite acesso às variaveis definidas em .DATA
MOV AX,@DATA
MOV DS,AX 

CALL HelloWorld


; Finaliza o programa 
MOV AH,4Ch
INT 21h
MAIN ENDP


HelloWorld PROC 
    MOV AH,9 ; chama a função que imprime na tela
LEA DX, hello  
; seria a mesma coisa que usar :
;MOV DX,OFFSET hello ; coloca a string em DX    
;teste pode ser feito retirando o ";" como comentario.
INT 21h ;executa a função imprimindo helloworld na tela
RET 
HelloWorld ENDP
END MAIN