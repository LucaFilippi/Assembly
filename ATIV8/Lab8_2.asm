TITLE Binários impressão
.MODEL SMALL
.STACK 100h

.CODE
MAIN PROC
MOV CX,16 ;determina o numero maximo de caracteres que vãoi ser impressos
MOV BX,0FF0h ;escolher qual valor quer que seja impresso aqui (pode colocar o numero que desejar)
IMPRIME: 
SHL BX,1 ;Movimenta o bx para uma casa pela esquerda 
JC IMPRESSAO_1 ;verifica o valor de CF e se for 1, vai para imprime 1, caso contrario exibe o cidigo

; imprime 0
MOV AH,02h
MOV DL,'0'
INT 21h
JMP PROXIMO

IMPRESSAO_1:
MOV AH,02h
MOV DL,'1'
INT 21h

PROXIMO: 
LOOP IMPRIME

;FINALIZA O PROGRAMA
MOV AH,4Ch
INT 21h
MAIN ENDP
END MAIN