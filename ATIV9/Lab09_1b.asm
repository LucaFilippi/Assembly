TITLE  PROGRAMA EXEMPLO PARA MANIPULAÇÃO DE VETORES USANDO BX b)
.MODEL SMALL
.STACK 100h
.DATA
    VETOR DB 1, 1, 1, 2, 2, 2  ; Vetor de 6 elementos
.CODE
MAIN PROC
    ; Inicializa segmento de dados
    MOV AX, @DATA
    MOV DS, AX

    ; Chama subrotina para ler e exibir o vetor usando índice [BX]
    CALL LerEExibirVetorBXIndexado

    ; Encerramento do programa
    MOV AH, 4Ch
    INT 21h
MAIN ENDP

; Subrotina para ler e exibir o vetor usando índice [BX]
LerEExibirVetorBXIndexado PROC
    XOR DL, DL          ; Zera DL (onde os valores do vetor serão carregados)
    MOV CX, 6           ; Define o tamanho do vetor
    XOR BX, BX          ; Zera BX (índice)

LerLoopIndexado:
    MOV DL, VETOR[BX]   ; Carrega o elemento do vetor para DL
    INC BX              ; Incrementa BX para apontar ao próximo elemento
    ADD DL, 30H         ; Converte o número em ASCII
    MOV AH, 02H         ; Função para imprimir caractere
    INT 21H             ; Chama interrupção para exibir o caractere
    LOOP LerLoopIndexado ; Decrementa CX e repete até que CX seja zero
    RET
LerEExibirVetorBXIndexado ENDP

END MAIN
