TITLE Hexadecimal leitura
.MODEL SMALL
.STACK 100h

.CODE
MAIN PROC
XOR BX, BX ; Zera BX
MOV CX,4
LEIA_HEXA:
MOV AH, 01H ; le caracter do teclado
INT 21H
CMP AL, 0DH    ; Verifica se o caractere é Enter
JE FIM ; Sai do loop se for CR

    ; Converter caractere para valor binário
 CMP AL, '0'
JB INVALIDO    ; Verifica se é menor que '0'
CMP AL, '9'
JBE CONVERTE_NUM   ; Se estiver entre '0' e '9', converte
CMP AL, 'A'
JB INVALIDO        ; Verifica se é menor que 'A'
CMP AL, 'F'
JBE CONVERTE_HEXA  ; Se estiver entre 'A' e 'F', converte

INVALIDO:
JMP LEIA_HEXA      ; Pede outro caractere se inválido

CONVERTE_NUM:
SUB AL, '0'; Converte '0' a '9' para 0 a 9
JMP DESLOCAR_BX

CONVERTE_HEXA:
SUB AL, 'A'; Converte 'A' a 'F' para 10 a 15
ADD AL, 10

DESLOCAR_BX:
SHL BX, 4 ; Desloca BX 4 casas à esquerda
AND AX,000Fh ;impede que parametros errados passem para BX
OR BX, AX ; Insere o valor convertido nos 4 bits inferiores de BX
LOOP LEIA_HEXA ; Continua o loop

FIM:
;FINALIZA O PROGRAMA
MOV AH,4Ch
INT 21h
MAIN ENDP
END MAIN
