; Faça um programa que leia a diagonal principal de uma matriz 
;4X4 tamanho DB
TITLE Exercicio 2
.MODEL SMALL
.STACK 100h
.DATA
MATRIZ  DB '?', '*', '*', '*'    ; primeira linha
        DB '*', '?', '*', '*'    ; segunda linha
        DB '*', '*', '?', '*'    ; terceira linha
        DB '*', '*', '*', '?'    ; quarta linha
MSG DB  'Diagonal: $'           ; Mensagem para imprimir antes dos valores
.CODE
MAIN PROC
    ; Inicializa segmento de dados
    MOV AX, @DATA
    MOV DS, AX

    ; Exibe a mensagem "Diagonal: "
    MOV AH, 09h
    LEA DX, MSG
    INT 21h

    XOR BX, BX     ; Zera BX (para usar como contador da diagonal)
    XOR SI, SI     ; Zera SI (usado como offset na matriz)
    MOV CX, 4      ; CX controla o loop de 4 elementos (diagonal principal)

    CALL PERCORREDIAGONAL

    ; Finaliza o programa
    MOV AH, 4Ch
    INT 21h
MAIN ENDP

PERCORREDIAGONAL PROC
    LOOPAR:
        ; Calcula o offset correto da diagonal (0, 5, 10, 15)
        MOV AL, MATRIZ[SI]    ; Carrega o valor da matriz na posição SI em AL
        CALL IMPRIME          ; Chama a rotina de impressão

        ADD SI, 5             ; Incrementa SI para acessar o próximo elemento da diagonal
        LOOP LOOPAR           ; Repete até CX chegar a 0
    RET
PERCORREDIAGONAL ENDP

IMPRIME PROC
    ; Imprime o caractere armazenado em AL
    MOV DL, AL                ; Coloca o caractere em DL
    MOV AH, 02h               ; Função de impressão de caractere
    INT 21h                   ; Chama a interrupção para imprimir
    RET
IMPRIME ENDP

END MAIN
