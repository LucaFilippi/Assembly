TITLE EXERCICIO 1
.MODEL SMALL
.STACK 100h        ; Determina o tamanho da pilha
.DATA
VETOR DB 'A','L','P','I','A','U','A','E','R','A','H','A','L','P','I','A','U','A','E','R'
RESULTADO DB '0', '$' ; Armazenará o número convertido para ASCII
MENSAGEM DB 'Quantidade de letras A: $'
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    XOR BX, BX       ; Zera o índice do vetor
    XOR CX, CX       ; Zera o contador de letras 'A'

    CALL ANDAVET     ; Chama a sub-rotina que percorre o vetor
    CALL IMPRIMERESULTADO ; Exibe o resultado

    ; Finaliza o programa
    MOV AH, 4Ch
    INT 21h
MAIN ENDP

ANDAVET PROC
    MOVEVET:
        MOV AL, VETOR[BX]  ; Carrega o valor do vetor em AL
        CMP AL, 'A'        ; Compara se é a letra 'A'
        JNE NAOA           ; Se não for 'A', pula
        CALL CONTAA        ; Se for 'A', incrementa o contador
    NAOA:
        INC BX             ; Incrementa o índice do vetor
        CMP BX, 20         ; Compara se chegou ao final do vetor (20 elementos)
        JNE MOVEVET        ; Se não chegou, continua
    RET
ANDAVET ENDP

CONTAA PROC
    INC CX                 ; Incrementa o contador de letras 'A'
    RET
CONTAA ENDP

IMPRIMERESULTADO PROC
    MOV AH, 9               ; Função de imprimir string
    LEA DX, MENSAGEM        ; Carrega o endereço da mensagem
    INT 21h

    ; Conversão do valor de CX para ASCII
    MOV AX, CX              ; Move o valor de CX para AX
    ADD AL, '0'             ; Converte o número de 0-9 em seu valor ASCII
    MOV RESULTADO, AL       ; Armazena o caractere ASCII no resultado
    LEA DX, RESULTADO       ; Carrega o endereço do resultado
    MOV AH, 9               ; Chama a função de impressão de string
    INT 21h
    RET
IMPRIMERESULTADO ENDP

END MAIN