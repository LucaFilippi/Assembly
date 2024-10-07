TITLE Binários leitura
.MODEL SMALL
.STACK 100h

.CODE
MAIN PROC
XOR BX,BX ;zera o valor do contador 
XOR AX,AX
MOV CX,16
LEITURA:
MOV AH,01h
INT 21h ;Lê o digito do teclado
CMP AL,0Dh ;compara o digito salvo em AL com 13 para ver se continua o codigo ou finaliza
JE FIM
SUB AL,'0' ;transforma o numero da tabela ascii
AND AX, 000Fh ;tranforma os valores de AX para evitar passar valores errados para BX
SHL BX,1 ;desloca os numeros de bx para a esquerda
OR BX,AX ;coloca o valor digitado pelo usuario em BX
LOOP LEITURA
FIM:
;FInaliza o programa 
MOV AH,4Ch
INT 21h
MAIN ENDP
END MAIN