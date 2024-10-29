;Faça um programa que imprima a soma da diagonal principal 
;de uma matriz 3X3
; esse foi o primeiro exercicio que debugo 100% sozinho
TITLE Exercicio 5
.MODEL SMALL
.STACK 100h
.DATA
MATRIZ  DB 1, 2, 3
        DB 4, 1, 6
        DB 7, 8, 1

.CODE
MAIN PROC
    ; Inicializa segmento de dados
    MOV AX, @DATA
    MOV DS, AX
    ; Zerar os registradores para movimentar na matriz
    XOR SI,SI 
    XOR BX,BX
    XOR AX,AX
    MOV CX,3 ;move 3 ao contador pois é matirz 3x3 

    CALL SOMADIAGONAL
    CALL IMPRIMESOMA

    ;Finaliza o programa
    MOV AH,4CH
    INT 21H



MAIN ENDP

SOMADIAGONAL PROC
    PERCORRE:
    MOV AL, MATRIZ[SI+BX] ; coloca cada elemento da diagonal da matriz em AL
    ADD AH,AL ;soma ah com al para fazer a soma da diagonal
    ADD SI,3 ;adiciona para ir a linha de baixo
    ADD BX,1 ; adiciona para ir para a proxima coluna
    LOOP PERCORRE
    RET


SOMADIAGONAL ENDP

IMPRIMESOMA PROC

    MOV DL,AH ;move o resultado da soma para DL para ser impresso
    ADD DL,30h ;tranforma o numero da tabela ascii
    MOV AH,2
    INT 21h  ;imprime
RET 
IMPRIMESOMA ENDP

END MAIN