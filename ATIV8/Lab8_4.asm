TITLE Hexadecimal impressão
.MODEL SMALL
.STACK 100h

.CODE
MAIN PROC
IMPRIME_HEXA:
MOV CX, 4        ; Precisamos exibir 4 dígitos
MOV BX, 9F2Ah ; numero generico, para imprimir (pode substituir por qualquer valor) 
IMPRIME_LOOP_HEX:
MOV AX, BX       ; Copia BX para AX
SHR AX, 12       ; Desloca 12 bits para a direita (para obter o nibble mais à esquerda)

; Verificar se o valor é menor que 10 (0-9)
CMP AL, 9
JBE CONVERTE_NUM_HEX

; Se for maior que 9, converte para 'A' a 'F'
ADD AL, 'A' - 10
JMP EXIBE_HEX

CONVERTE_NUM_HEX:
ADD AL, '0'      ; Converte o valor 0-9 para os caracteres '0'-'9'

EXIBE_HEX:
MOV AH, 02H      ; Função de saída de caractere (INT 21H)
MOV DL, AL       ; Coloca o caractere em DL
INT 21H          ; Exibe o caractere

SHL BX, 4        ; Desloca BX 4 bits à esquerda para processar o próximo nibble
LOOP IMPRIME_LOOP_HEX

;FINALIZA O PROGRAMA
MOV AH,4Ch
INT 21h
MAIN ENDP
END MAIN
