TITLE Asterisco
.MODEL SMALL
.STACK 100h
.DATA
MSG1 DB "* $"

.CODE
MAIN PROC
;permite acesso às variaveis definidas em .DATA
MOV AX,@DATA
MOV DS,AX

MOV CX,0 ;para ter certeza que em cx não existe nenhuma informação que possa ser conflitante
; Define o rotulo de repetição para uma unica linha
EmUmaLinha:
;Exibe na tela a string de MSG1
MOV AH,9
MOV DX,OFFSET MSG1
INT 21h
ADD CX,1
CMP CX,50 ;verifica se o contador atingiu o numero desejado
JB EmUmaLinha ;faz acontecer o loop, reiniciando o rotulo

MOV CX,0
EmCadaLinha: 
MOV AH,9
MOV DX,OFFSET MSG1
INT 21h
; Exibe o caracter carriage return (Move o cursor para a linha seguinte)
MOV AH,2
MOV DL,13     ; O codigo ASC do caracter Carriage Return é 13 (0Dh)
INT 21h
;exibe o caracter line feed
MOV AH,2
MOV DL,10     ; O codigo ASC do caracter line feed é 10 (0Ah)
INT 21h
ADD CX,1 ;adiciona um no contador
CMP CX,50 ;compara para ver se chegou no limite definido de repetições
JB EmCadaLinha ;faz reiciar o loop

FIM:
;FInaliza o programa 
MOV AH,4Ch
INT 21h
MAIN ENDP
END MAIN