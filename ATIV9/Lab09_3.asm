TITLE INVERTE VETOR
.MODEL SMALL
.STACK 100h
.DATA
    vetor DB 0, 1, 2, 3, 4, 5, 6  ; Vetor de 7 posições

.CODE
MAIN PROC
    ; Inicializa o segmento de dados
    MOV AX, @DATA
    MOV DS, AX

    ; Chama procedimento para ler o vetor
    CALL LerVetor

    ; Chama procedimento para inverter o vetor
    CALL InverterVetor

    ; Chama procedimento para imprimir o vetor invertido
    CALL ImprimirVetor

    ; Encerramento do programa
    MOV AH, 4Ch
    INT 21h
MAIN ENDP

; Procedimento para ler o vetor
LerVetor PROC
    XOR BX, BX           ; Inicia BX como índice
    MOV CX, 7            ; Tamanho do vetor
LerLoop:
    MOV AL, vetor[BX]    ; Lê o elemento do vetor
    ; Aqui você pode adicionar qualquer operação de leitura se necessário
    INC BX               ; Próximo índice
    LOOP LerLoop
    RET
LerVetor ENDP

; Procedimento para inverter o vetor
InverterVetor PROC
    XOR SI, SI           ; SI aponta para o primeiro elemento
    MOV DI, 6            ; DI aponta para o último elemento (índice 6)
    MOV CX, 3            ; Apenas metade do vetor precisa ser processada
InverterLoop:
    MOV AL, vetor[SI]    ; Guarda o elemento do início
    MOV BL, vetor[DI]    ; Guarda o elemento do fim
    MOV vetor[SI], BL    ; Coloca o último no lugar do primeiro
    MOV vetor[DI], AL    ; Coloca o primeiro no lugar do último
    INC SI               ; Avança para o próximo
    DEC DI               ; Regride para o anterior
    LOOP InverterLoop
    RET
InverterVetor ENDP

; Procedimento para imprimir o vetor
ImprimirVetor PROC
    XOR BX, BX           ; Reinicia BX como índice
    MOV CX, 7            ; Tamanho do vetor
ImprimirLoop:
    MOV DL, vetor[BX]    ; Lê o elemento do vetor
    ADD DL, 30h          ; Converte para caractere ASCII
    MOV AH, 02h          ; Função para imprimir caractere
    INT 21h              ; Interrupção para saída
    INC BX               ; Próximo índice
    LOOP ImprimirLoop
    RET
ImprimirVetor ENDP

END MAIN
