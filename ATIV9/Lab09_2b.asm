TITLE Exemplo com DI
.MODEL SMALL
.STACK 100h
.DATA
    VETOR DB 1, 1, 1, 2, 2, 2  ; Vetor de 6 elementos
.CODE
MAIN PROC
    ; Inicializa segmento de dados
    MOV AX, @DATA
    MOV DS, AX

    ; Chama subrotina para ler e exibir o vetor usando DI
    CALL LerEExibirVetorDI

    ; Encerramento do programa
    MOV AH, 4Ch
    INT 21h
MAIN ENDP

; Subrotina para ler e exibir o vetor usando DI
LerEExibirVetorDI PROC
    XOR DL, DL          ; Zera DL (onde os valores do vetor serão carregados)
    MOV CX, 6           ; Define o tamanho do vetor
    XOR DI, DI          ; Zera DI (índice)

LerLoopDI:
    MOV DL, VETOR[DI]   ; Carrega o elemento do vetor para DL
    INC DI              ; Incrementa DI para apontar ao próximo elemento
    ADD DL, 30H         ; Converte o número em ASCII
    MOV AH, 02H         ; Função para imprimir caractere
    INT 21H             ; Chama interrupção para exibir o caractere
    LOOP LerLoopDI      ; Decrementa CX e repete até que CX seja zero
    RET
LerEExibirVetorDI ENDP

END MAIN
