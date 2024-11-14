TITLE BATALHA NAVAL
.MODEL SMALL
.STACK 0100h
PULA_LINHA MACRO        
    PUSH AX
    PUSH DX
    MOV AH,02
    MOV DL,10
    INT 21h
    POP DX
    POP AX
ENDM
.DATA
; definindo a matriz e os enunciados do jogo
TABULEIRO DB 0, 0, 0, 1, 1, 0, 0, 1, 0, 0 
          DB 0, 0, 0, 0, 0, 0, 0, 1, 1, 0 
          DB 0, 0, 0, 0, 0, 0, 0, 1, 0, 0 
          DB 0, 1, 1, 0, 0, 0, 0, 0, 0, 0 
          DB 0, 0, 0, 0, 0, 1, 1, 1, 0, 0 
          DB 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 
          DB 1, 0, 0, 0, 0, 0, 0, 0, 0, 0 
          DB 1, 1, 0, 0, 0, 0, 0, 0, 0, 0 
          DB 1, 0, 0, 1, 1, 1, 1, 0, 0, 0 
          DB 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 

; Matriz de tiros inicializada com '0'
TIROS DB '0', '0', '0', '0', '0', '0', '0', '0', '0','0'  
      DB '0', '0', '0', '0', '0', '0', '0', '0', '0','0'  
      DB '0', '0', '0', '0', '0', '0', '0', '0', '0','0'   
      DB '0', '0', '0', '0', '0', '0', '0', '0', '0','0'  
      DB '0', '0', '0', '0', '0', '0', '0', '0', '0','0'  
      DB '0', '0', '0', '0', '0', '0', '0', '0', '0','0'  
      DB '0', '0', '0', '0', '0', '0', '0', '0', '0','0'  
      DB '0', '0', '0', '0', '0', '0', '0', '0', '0','0'  
      DB '0', '0', '0', '0', '0', '0', '0', '0', '0','0' 
      DB '0', '0', '0', '0', '0', '0', '0', '0', '0','0'   

CONT_ACERTOS DB 0
; Mensagens para o usuário
MSG_LINHA DB 10,13,'Qual linha deseja acertar? (0-9): $'
MSG_COLUNA DB 10,13,'Qual coluna deseja acertar? (0-9): $'  
MSG_FIM DB 10,13,'Voce venceu! Parabens!! $'
MSG_DESISTIU DB 10,13,'Voce desistiu, o jogo acabou.'
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    MOV ES, AX

LOOP_JOGO:
    ; Imprimir matriz de tiros
    CALL IMPRIMIR_TIROS

    ; Exibir mensagem para entrada de coluna
    MOV AH, 09h
    LEA DX, MSG_COLUNA
    INT 21h

    ; Ler entrada da linha
    MOV AH, 01h
    INT 21h
    CMP AL, 'F'             ; Verificar desistência ('F' ou 'f')
    JE DESISTIR
    CMP AL, 'f'
    JE DESISTIR
    SUB AL, '0'             ; Converte de ASCII para valor numérico
    XOR AH, AH
    MOV BX, AX              ; Armazena linha em BX

    ; Exibir mensagem para entrada de linha
    MOV AH, 09h
    LEA DX, MSG_LINHA
    INT 21h

    ; Ler entrada da coluna
    MOV AH, 01h
    INT 21h
    CMP AL, 'F'             ; Verificar desistência ('F' ou 'f')
    JE DESISTIR
    CMP AL, 'f'
    JE DESISTIR
    XOR AH, AH
    SUB AL, '0'             ; Converte de ASCII para valor numérico
    MOV CL, 10
    MUL CL                  ; Multiplica coluna (SI) por 10
    MOV SI, AX              ; Armazena coluna em SI
    PULA_LINHA

    ; Acessar o elemento da matriz usando TABULEIRO[SI+BX]
    MOV AL, TABULEIRO[SI+BX]
    CMP AL, 1
    JNE MARCAR_ERRO         ; Se não for 1, marca como erro

MARCAR_ACERTO:
    MOV TIROS[SI+BX], '*'   ; Marca o acerto como '*'
    INC CONT_ACERTOS        ; Incrementa contador de acertos
    CMP CONT_ACERTOS, 19    ; Jogo termina após 19 acertos em 10x10
    JE FIM_JOGO             ; Se 19 acertos, finaliza o jogo
    JMP LOOP_JOGO           ; Continua o jogo

MARCAR_ERRO:
    MOV TIROS[SI+BX], 'x'   ; Marca o erro como 'x'
    JMP LOOP_JOGO

FIM_JOGO:
    ; Mensagem de vitória
    MOV AH, 09h
    LEA DX, MSG_FIM
    INT 21h
    MOV AH, 4Ch
    INT 21h

DESISTIR:
    ; Mensagem de desistência
    MOV AH, 09h
    LEA DX, MSG_DESISTIU
    INT 21h
    MOV AH, 4Ch
    INT 21h

    
MAIN ENDP
IMPRIMIR_TIROS PROC
    MOV CX, 10              ; Configura para 10 linhas
    MOV SI, 0               ; Início da matriz de tiros (representa a linha)

IMPRIMIR_LINHA:
    MOV BX, 0               ; Coluna inicial de cada linha (usaremos BX para as colunas)
    MOV DX, SI              ; Guarda o valor inicial da linha para resetá-lo ao final da linha

IMPRIMIR_ELEMENTO:
    MOV AL, TIROS[SI + BX]  ; Carrega o valor da posição atual usando SI para a linha e BX para a coluna
    MOV DL, AL
    MOV AH, 02h
    INT 21h                 ; Imprime o caractere

    INC BX                  ; Próxima coluna na linha
    CMP BX, 10              ; Verifica se alcançou o final da linha
    JL IMPRIMIR_ELEMENTO    ; Continua na linha atual se não terminou

    ; Pular para a próxima linha na tela
    MOV AH, 02h
    MOV DL, 10              ; Line feed
    INT 21h
    MOV DL, 13              ; Carriage return
    INT 21h

    ADD SI, 10              ; Próxima linha (incrementa SI para a próxima linha da matriz)
    LOOP IMPRIMIR_LINHA     ; Continua até imprimir toda a matriz
    RET
IMPRIMIR_TIROS ENDP

END MAIN