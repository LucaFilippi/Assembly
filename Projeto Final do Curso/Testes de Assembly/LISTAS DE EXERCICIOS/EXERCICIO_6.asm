;Faça um programa que calcule a soma dos 8 elementos de 
;um vetor
TITLE Exercicio 6
.MODEL SMALL
.STACK 100h
.DATA
VETOR DB 0, 1, 2, 0, 0, 1, 0, 1
.CODE
MAIN PROC
    ; Inicializa segmento de dados
    MOV AX, @DATA
    MOV DS, AX

    XOR BX,BX ;Zera o registrador para percorrer os elementos do vetor
    MOV CX,8 ; inicializa o contador com 8 pois são 8 elementos
    XOR AX,AX ;Garante que o registrador esteja zerado para não ter problemas

    CALL SOMAR
    CALL IMPRIMIRSOMA



    ;Finaliza o programa
    MOV AH,4CH
    INT 21H

MAIN ENDP
SOMA PROC

SOMAR:
    MOV AL, VETOR[BX]
    ADD AH,AL 
    INC BX
    LOOP SOMAR
    RET
SOMA ENDP

IMPRIMIRSOMA PROC

    MOV DL,AH
    ADD DL,30h
    MOV AH,2
    INT 21h
    RET
IMPRIMIRSOMA ENDP



END MAIN