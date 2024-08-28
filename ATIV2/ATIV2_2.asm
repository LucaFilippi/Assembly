TITLE soma de numeros
.MODEL SMALL
.DATA
    ; define as variaveis de mensagem a serem exibidas
    MSG1 DB "Digite o primeiro numero (de 0 a 9): $"
    MSG2 DB "Digite o segundo numero (de 0 a 9): $"
    MSG3 DB "A soma dos numeros é: $"

.CODE
MAIN PROC
    ; Permite acesso às variaveis definidas em .DATA
         MOV AX,@DATA
         MOV DS,AX

    ;Exibe a MSG1 na tela
         MOV AH,9
         LEA DX,MSG1
         INT 21h

    ;Lê o primeiro numero e salva em AL
         MOV AH,1
         INT 21h
         SUB AL, '0'

    ;copia o numero lido para BL
         MOV BL,AL

    ;exibe o caracter line feed
         MOV AH,2
         MOV DL,10       ; O codigo ASC do caracter line feed é 10 (0Ah)
         INT 21h


    ;Exibe o conteúdo de MSG2
         MOV AH,9
         LEA DX,MSG2
         INT 21h

    ;Lê o segundo numero e soma os dois numeros lidos
         MOV AH,1
         INT 21h
         SUB AL, '0'
         ADD BL,AL

    ;exibe o caracter line feed
         MOV AH,2
         MOV DL,10       ; O codigo ASC do caracter line feed é 10 (0Ah)
         INT 21h

    ;Exibe o conteúdo de MSG3
         MOV AH,9
         LEA DX,MSG3
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