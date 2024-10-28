TITLE  Lab10_2
.MODEL SMALL
.STACK 100h
.DATA
MATRIZ      DB 16 DUP(?)  ; Armazenamento para matriz 4x4 de números
MSG1 DB "DIGITE A MATRIZ 4X4 APENAS COM NUMEROS DE 0 A 6$"
SOMA_MSG DB "A SOMA DOS ELEMENTOS E: $"
SOMA_RESULT DB 4 DUP('$')  ; Local para armazenar o resultado da soma em formato ASCII

.CODE 
MAIN PROC
    ; Inicializa segmento de dados
    MOV AX, @DATA
    MOV DS, AX

    ; Exibe a mensagem inicial
    MOV AH, 9
    LEA DX, MSG1
    INT 21h

    ; Chama o procedimento para ler a matriz
    CALL LEMATRIZ

    ; Chama o procedimento para imprimir a matriz
    CALL IMPRIME

    ; Chama o procedimento para somar os elementos da matriz
    CALL SOMA

    ; Chama o procedimento para imprimir a soma dos elementos
    CALL IMPRIME_SOMA

    ; Termina o programa
    MOV AH, 4Ch
    INT 21h
MAIN ENDP

; Procedimento para ler a matriz 4x4
LEMATRIZ PROC
    MOV CX, 4              ; Define CX para contar as linhas
    XOR SI, SI             ; Zera o índice da linha
LER_LINHA:
    XOR BX, BX             ; Zera o contador de colunas para cada linha
LER_COLUNA:
    ; Lê um caracter do teclado e salva em AL
    MOV AH, 1
    INT 21h
    SUB AL, 30h            ; Converte de ASCII para valor numérico
    MOV MATRIZ[SI + BX], AL ; Move o valor numérico para a matriz
    INC BX                 ; Próxima coluna
    CMP BX, 4              ; Verifica se já leu os 4 elementos da linha
    JNE LER_COLUNA         ; Se não, continua na mesma linha
    ADD SI, 4              ; Move o índice SI para a próxima linha (4 elementos)
    LOOP LER_LINHA         ; Decrementa CX e repete para a próxima linha
    RET
LEMATRIZ ENDP

; Procedimento para imprimir a matriz 4x4
IMPRIME PROC
    MOV CX, 4              ; Define CX para contar as linhas
    XOR SI, SI             ; Zera o índice de linha
IMPRIME_LINHA:
    XOR BX, BX             ; Zera o contador de colunas para cada linha
IMPRIME_COLUNA:
    MOV AL, MATRIZ[SI + BX] ; Move o elemento da matriz para AL
    ADD AL, 30h            ; Converte o número para caractere ASCII
    MOV AH, 02h            ; Função para exibir caractere
    MOV DL, AL             ; Move o caractere para DL
    INT 21h                ; Imprime o caractere

    INC BX                 ; Próxima coluna
    CMP BX, 4              ; Verifica se já imprimiu os 4 elementos da linha
    JNE IMPRIME_COLUNA     ; Se não, continua na mesma linha

    ; Pula para a próxima linha
    MOV DL, 0Dh            ; Carriage return
    MOV AH, 02h
    INT 21h

    MOV DL, 0Ah            ; Line feed
    MOV AH, 02h
    INT 21h

    ADD SI, 4              ; Move o índice SI para a próxima linha (4 elementos)
    LOOP IMPRIME_LINHA     ; Decrementa CX e repete para a próxima linha

    RET
IMPRIME ENDP

; Procedimento para somar os elementos da matriz
SOMA PROC
    MOV CX, 16             ; Total de elementos na matriz (4x4)
    XOR SI, SI             ; Zera o índice da matriz
    XOR AX, AX             ; Zera o acumulador para a soma

SOMA_LOOP:
    MOV AL, MATRIZ[SI]     ; Pega o elemento atual da matriz
    ADD AH, AL             ; Adiciona o elemento à soma em AH
    INC SI                 ; Próximo elemento da matriz
    LOOP SOMA_LOOP         ; Decrementa CX e continua

    ; Armazena a soma em SOMA_RESULT como string ASCII
    MOV AL, AH             ; Move a soma para AL
    ADD AL, 30h            ; Converte para caractere ASCII
    MOV SOMA_RESULT, AL    ; Salva em SOMA_RESULT
    RET
SOMA ENDP

; Procedimento para imprimir a soma dos elementos
IMPRIME_SOMA PROC
    ; Exibe a mensagem de soma
    MOV AH, 9
    LEA DX, SOMA_MSG
    INT 21h

    ; Converte a soma para ASCII e exibe
    MOV AL, SOMA_RESULT    ; Move a soma armazenada em SOMA_RESULT para AL
    MOV DL, AL             ; Move para DL
    MOV AH, 02h            ; Função para exibir caractere
    INT 21h                ; Imprime o caractere

    RET
IMPRIME_SOMA ENDP
END MAIN
