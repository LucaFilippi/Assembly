.MODEL SMALL
.STACK 100h
.DATA
    VETOR DB '*', '*', '*', '*', '*', '*', '*'  ; Vetor de 7 elementos inicialmente preenchido com '*'
    MENSAGEM DB 10,13, 'Digite um numero:   $'      ; Mensagem para solicitar número do usuário
.CODE
MAIN PROC
    ; Inicializa o segmento de dados
    MOV AX, @DATA
    MOV DS, AX

    ; Chama subrotina para ler o vetor (usuário preenche o vetor)
    CALL LerVetor

    ; Chama subrotina para inverter o vetor
    CALL InverterVetor

    ; Chama subrotina para imprimir o vetor invertido
    CALL ImprimirVetor

    ; Encerramento do programa
    MOV AH, 4Ch
    INT 21h
MAIN ENDP

; Subrotina para ler o vetor (preenchido pelo usuário)
LerVetor PROC
    XOR BX, BX           ; Inicia BX como índice
    MOV CX, 7            ; Tamanho do vetor
LerLoop:
    ; Exibe a mensagem para o usuário
    LEA DX, MENSAGEM     ; Carrega o endereço da mensagem
    MOV AH, 09h          ; Função para exibir string
    INT 21h              ; Interrupção para saída

    ; Lê o número do usuário
    MOV AH, 01h          ; Função para ler caractere
    INT 21h              ; Interrupção para entrada
    SUB AL, 30h          ; Converte caractere ASCII para número
    MOV VETOR[BX], AL    ; Armazena o número no vetor

    INC BX               ; Incrementa o índice do vetor
    LOOP LerLoop         ; Decrementa CX e repete até que CX seja zero
    RET
LerVetor ENDP

; Subrotina para inverter o vetor
InverterVetor PROC
    XOR SI, SI           ; SI aponta para o primeiro elemento
    MOV DI, 6            ; DI aponta para o último elemento (índice 6)
    MOV CX, 3            ; Apenas metade do vetor precisa ser processada
InverterLoop:
    MOV AL, VETOR[SI]    ; Guarda o elemento do início em AL
    MOV BL, VETOR[DI]    ; Guarda o elemento do fim em BL
    MOV VETOR[SI], BL    ; Coloca o último no lugar do primeiro
    MOV VETOR[DI], AL    ; Coloca o primeiro no lugar do último
    INC SI               ; Avança para o próximo elemento no início
    DEC DI               ; Retrocede para o anterior no final
    LOOP InverterLoop    ; Decrementa CX e repete até que CX seja zero
    RET
InverterVetor ENDP

; Subrotina para imprimir o vetor
ImprimirVetor PROC
    XOR BX, BX           ; Reinicia BX como índice
    MOV CX, 7            ; Tamanho do vetor
ImprimirLoop:
    MOV DL, VETOR[BX]    ; Lê o elemento do vetor e armazena em DL
    ADD DL, 30h          ; Converte para caractere ASCII
    MOV AH, 02h          ; Função para imprimir caractere
    INT 21h              ; Chama interrupção para saída
    INC BX               ; Incrementa o índice do vetor
    LOOP ImprimirLoop    ; Decrementa CX e repete até que CX seja zero
    RET
ImprimirVetor ENDP

END MAIN
