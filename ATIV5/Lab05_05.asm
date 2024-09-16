TITLE calculadora 5 numeors
.MODEL SMALL
.STACK 100h

.DATA 
MSG1 DB "Digite o numero a ser somado $"
MSG2 DB "A soma dos numeros eh igual a: $"
.CODE
MAIN PROC
; Permite acesso às variaveis definidas em .DATA
MOV AX,@DATA
MOV DS,AX

MOV CX,5 ;determina o numero de vezes que pode somar 
MOV BL,0 ; determina BL para 0 para poder efetuar as operações


SOMA:
;Exibe a MSG1 na tela
MOV AH,9
LEA DX,MSG1
INT 21h
;Lê o numero e salva em AL
MOV AH,1
INT 21h
SUB AL, '0'
;soma o numero em BL para ir armazenando o resultado
ADD BL,AL

;exibe o caracter line feed
MOV AH,2
MOV DL,10       ; O codigo ASC do caracter line feed é 10 (0Ah)
INT 21h
LOOP SOMA

;Exibe o conteúdo de MSG2
MOV AH,9
LEA DX,MSG2
INT 21h

; Converte o resultado para ASCII
ADD BL,'0'
MOV DL,BL
MOV AH,2
INT 21h

;Finaliza o programa
MOV AH,4Ch
INT 21h
MAIN ENDP
 END MAIN