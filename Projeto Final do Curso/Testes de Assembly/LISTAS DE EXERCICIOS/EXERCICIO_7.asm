;Faça um programa que inverta um vetor (sem usar vetor 
;auxiliar)
TITLE Exercicio 7
.MODEL SMALL
.STACK 100h
.DATA
VETOR DB 0, 1, 2, 0, 0, 1, 0, 1
.CODE
MAIN PROC
    ; Inicializa segmento de dados
    MOV AX, @DATA
    MOV DS, AX

    ; Inicializa registradores
    XOR AX, AX
    XOR BX, BX
    XOR DX, DX

    ; Colocando em CX a quantidade de elementos para o loop
    MOV CX, 4  ; Apenas metade do vetor para fazer as trocas

    CALL INVERTEVETOR
    CALL IMPRIMIRVETOR

    ; Finaliza o programa
    MOV AH, 4CH
    INT 21H
MAIN ENDP 

; Procedimento para inverter o vetor sem vetor auxiliar
INVERTEVETOR PROC
    MOV BX, 0             ; BX começa no início do vetor
    MOV DI, 7             ; DI começa no final do vetor

TROCAR:
    MOV AL, VETOR[BX]     ; AL recebe o valor da posição inicial
    MOV DL, VETOR[DI]     ; DL recebe o valor da posição final

    MOV VETOR[BX], DL     ; Coloca o valor do final no início
    MOV VETOR[DI], AL     ; Coloca o valor do início no final

    INC BX                ; Move para o próximo elemento à frente
    DEC DI                ; Move para o próximo elemento atrás
    LOOP TROCAR           ; Continua até metade do vetor

    RET
INVERTEVETOR ENDP

; Procedimento para imprimir o vetor
IMPRIMIRVETOR PROC
    XOR BX, BX            ; Reinicia o valor de BX
    MOV CX, 8             ; Define o número de elementos a imprimir

IMPRIMINDO:
    MOV AL, VETOR[BX]     ; AL recebe o valor do vetor
    INC BX                ; Incrementa BX para o próximo elemento
    MOV DL, AL            ; Coloca o valor de AL em DL para impressão
    ADD DL, 30h           ; transforma o valor em ASCII
    MOV AH, 2
    INT 21h               ; Imprime o caractere
    LOOP IMPRIMINDO       ; Continua até imprimir todos os elementos

    RET
IMPRIMIRVETOR ENDP

END MAIN
