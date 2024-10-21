TITLE Exemplo com SI
.MODEL SMALL
.STACK 100h
.DATA
    VETOR DB 1, 1, 1, 2, 2, 2  ; Vetor de 6 elementos
.CODE
MAIN PROC
    ; Inicializa segmento de dados
    MOV AX, @DATA
    MOV DS, AX

    ; Chama subrotina para ler e exibir o vetor usando SI
    CALL LerEExibirVetorSI

    ; Encerramento do programa
    MOV AH, 4Ch
    INT 21h
MAIN ENDP

; Subrotina para ler e exibir o vetor usando SI
LerEExibirVetorSI PROC
    XOR DL, DL          ; Zera DL (onde os valores do vetor serão carregados)
    MOV CX, 6           ; Define o tamanho do vetor
    LEA SI, VETOR       ; Carrega o endereço do vetor no registrador SI

LerLoopSI:
    MOV DL, [SI]        ; Carrega o elemento apontado por SI para DL
    INC SI              ; Incrementa SI para apontar ao próximo elemento
    ADD DL, 30H         ; Converte o número em ASCII
    MOV AH, 02H         ; Função para imprimir caractere
    INT 21H             ; Chama interrupção para exibir o caractere
    LOOP LerLoopSI      ; Decrementa CX e repete até que CX seja zero
    RET
LerEExibirVetorSI ENDP

END MAIN
