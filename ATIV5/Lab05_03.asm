TITLE ALfabeto maiusculo e minusculo
.MODEL SMALL
.STACK 100h

.CODE
MAIN PROC
MOV CX,26 ;coloca 26 em cx para controlar o numero de caracteres a serem impressos
MOV DL,65 ;Move o codigo de A em ASCII para ser impresso
MOV AH,2
maiusculas:
INT 21h ;Imprime o caracter em DL
INC DL ;Incrementa DL para ir pra proxima letra
LOOP maiusculas ;efetua o loop decrescendo CX e reiciando o rotulo

MOV CX,26 ;Coloca o valor 26 em cx novamente para ir para as minusculas
MOV DL,97 ;coloca o valor de "a" em Dl para o alfabeto das minusculas
Minusculas:
INT 21h ;imprime o valor em DL
INC DL ;aumenta o valor em DL para a proxima letra
LOOP Minusculas ;efetua o loop decrescendo CX e reiciando o rotulo



;FInaliza o programa 
MOV AH,4Ch
INT 21h
MAIN ENDP
END MAIN