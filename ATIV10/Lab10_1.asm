TITLE  PROGRAMA EXEMPLO PARA MANIPULAÇÃO DE VETORES USANDO BX
.MODEL SMALL
.STACK 100h
.DATA
MATRIZ4X4   DB 1,2,3,4
            DB 4,3,2,1
            DB 5,6,7,8
            DB 8,7,6,5
.CODE 
MAIN PROC
    ; Inicializa segmento de dados
    MOV AX, @DATA
    MOV DS, AX

    XOR SI, SI   ; Zera o índice da linha
    XOR BX, BX   ; Zera o índice da coluna

    CALL LEMATRIZ

    ; Encerramento do programa
    MOV AH, 4Ch
    INT 21h
MAIN ENDP

LEMATRIZ PROC
    MOV CX, 4              ; Define CX para contar as linhas
LINHA:
    XOR BX, BX              ; Zera o contador de colunas para cada linha
COLUNA:
    MOV AL, MATRIZ4X4[SI + BX]
    CALL IMPRIME           ; Chama a rotina para imprimir o elemento
    INC BX                 ; Próxima coluna
    CMP BX, 4              ; Verifica se já imprimiu os 4 elementos da linha
    JNE COLUNA             ; Se não, continua na mesma linha
    ; Pula para a próxima linha
    MOV DL, 0Dh    ; Carriage return
    MOV AH, 02h
    INT 21h

    MOV DL, 0Ah    ; Line feed
    MOV AH, 02h
    INT 21h

    ADD SI, 4              ; Move o índice SI para a próxima linha (4 elementos)
    LOOP LINHA             ; Decrementa CX e repete para a próxima linha
    RET
LEMATRIZ ENDP

IMPRIME PROC
    ADD AL, 30h            ; Converte o número para caractere ASCII
    MOV AH, 02h
    MOV DL, AL
    INT 21h 
    RET
IMPRIME ENDP
END MAIN
