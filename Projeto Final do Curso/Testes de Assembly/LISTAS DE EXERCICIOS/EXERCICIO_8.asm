;Faça um programa que percorra um vetor de 10 posições e 
;conte quantos números pares e ímpares o vetor possui.
TITLE Exercicio 8
.MODEL SMALL
.STACK 100h
.DATA
VETOR DB 0, 1, 2, 3, 4, 5, 6, 7, 8, 9
MSGIMPAR DB 10,13,"Impares: $"
MSGPAR DB 10,13,"Pares: $"
.CODE
MAIN PROC
    ; Inicializa segmento de dados
    MOV AX, @DATA
    MOV DS, AX

    ; Zera os registradores e coloca 10 no contador para percorrer as posições
    XOR BX, BX            ; BX será o índice do vetor
    XOR SI, SI            ; SI será o contador de pares
    XOR DI, DI            ; DI será o contador de ímpares
    MOV CX, 10            ; Número de elementos no vetor

    CALL VERIFICAPAR
    CALL IMPRIMIR

    ; Finaliza o programa
    MOV AH, 4CH
    INT 21H
MAIN ENDP

VERIFICAPAR PROC
    ; Percorre o vetor e conta números pares e ímpares
ANDAVETOR:
    MOV AL, VETOR[BX]     ; Carrega o elemento do vetor em AL
    TEST AL, 1            ; Verifica o bit menos significativo (paridade)
    JNZ CONTA_IMPAR       ; Se for ímpar, pula para contagem de ímpares

    ; Contagem de números pares
    INC SI
    JMP PROX_ELEMENTO

CONTA_IMPAR:
    ; Contagem de números ímpares
    INC DI

PROX_ELEMENTO:
    INC BX                ; Incrementa o índice do vetor
    LOOP ANDAVETOR        ; Repete até o vetor ser totalmente percorrido
    RET
VERIFICAPAR ENDP

IMPRIMIR PROC
    ; Imprime a contagem de ímpares
    MOV AH, 09H
    LEA DX, MSGIMPAR      ; Mostra a mensagem "Impares: "
    INT 21H

    MOV AX, DI            ; Carrega o contador de ímpares em AL
    ADD AL, 30H           ; Converte para ASCII
    MOV DL, AL
    MOV AH, 02H
    INT 21H

    ; Imprime a contagem de pares
    MOV AH, 09H
    LEA DX, MSGPAR        ; Mostra a mensagem "Pares: "
    INT 21H

    MOV AX, SI            ; Carrega o contador de pares em AL
    ADD AL, 30H           ; Converte para ASCII
    MOV DL, AL
    MOV AH, 02H
    INT 21H

    RET
IMPRIMIR ENDP

END MAIN
