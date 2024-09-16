TITLE Asterisco dois
.MODEL SMALL
.STACK 100h
.DATA
MSG1 DB "* $"

.CODE
MAIN PROC
; Permite acesso às variaveis definidas em .DATA
MOV AX,@DATA
MOV DS,AX

MOV CX,50 ; Inicializa CX com o valor desejado de 50
; Define o rotulo de repetição para uma unica linha
EmUmaLinha:
; Exibe na tela a string de MSG1
MOV AH,9
MOV DX,OFFSET MSG1
INT 21h
LOOP EmUmaLinha ; Decrementa CX e repete até CX=0

MOV CX,50 ; Inicializa CX novamente para o segundo loop
EmCadaLinha:
MOV AH,9
MOV DX,OFFSET MSG1
INT 21h

; Exibe o caracter carriage return (Move o cursor para a linha seguinte)
MOV AH,2
MOV DL,13     ; O código ASC do caracter Carriage Return é 13
INT 21h

MOV DL,10     ; O código ASC do Line Feed é 10
INT 21h

LOOP EmCadaLinha ; Decrementa CX e repete até CX=0

; Finaliza o programa 
MOV AH,4Ch
INT 21h
MAIN ENDP
END MAIN 
