;Escreva um procedimento em assembly que lê um caractere do teclado e
;exibe na linha seguinte a quantidade de bits 1 existentes no codigo ASCII do
;caractere lido, O registrador que contém o caractere lido tem que ser zerado
;apos a verificaçao
TITLE Exercicio 1 P2 2023 ;prova dos anos anteriores
.MODEL SMALL
.STACK 100h
.DATA 
MSG DB "ESCREVA UM CARACTER: $"
NUM_BITS DB "Quantidade de bits 1: $"

.CODE
MAIN PROC
    ; Inicializa segmento de dados
    MOV AX, @DATA
    MOV DS, AX
    ; Zerar todos os registradores para evitar problemas
    XOR AX, AX
    XOR CX, CX
    XOR DX, DX
    XOR BX, BX

    ; Exibe mensagem
    MOV DX, OFFSET MSG
    MOV AH, 09h
    INT 21h

    CALL LER

    ; Finaliza o programa
    MOV AH, 4CH
    INT 21H
MAIN ENDP

LER PROC
    MOV AH, 1
    INT 21h ; Lê o caractere e salva em AL
    PUSH AX ;EMPILHA O VALOR DE AX PARA EVITAR PERDA DE VALOR DE AL
    ; Exibir um Enter
    MOV AH, 2
    MOV DL, 10
    INT 21h 
    MOV DL, 13
    INT 21h
    
    MOV CX, 8  ; Inicializa CX com 8 (número de bits)
    XOR BX, BX  ; Zera BX para contar os bits 1
    POP AX ;RETORNA O VALOR EMPILHADO 

LOOPAR:
    SHR AL, 1   ; Desloca AL para a direita
    JC BIT1     ; Se o bit menos significativo é 1, vai para BIT1
    JMP CONTAR  ; Se não, continua

BIT1:
    INC BX      ; Incrementa a contagem de bits 1

CONTAR:
    LOOP LOOPAR  ; Continua o loop até que CX chegue a 0

    ; Exibir a quantidade de bits 1
    ; Mensagem antes da contagem
    MOV DX, OFFSET NUM_BITS
    MOV AH, 09h
    INT 21h

    ; Converte o número de bits 1 (BX) para ASCII e exibe
    MOV AX, BX   ; Move a contagem de bits 1 para AX
    CALL IMPRIME_NUMERO  ; Chama o procedimento para imprimir o número

    ; Zera AL antes de sair do procedimento
    XOR AL, AL

    RET
LER ENDP

IMPRIME_NUMERO PROC
    ; A função assume que o número a ser impresso está em AX
    ; Converte para ASCII e exibe
    MOV CX, 0   ; Zera CX para contar os dígitos
    MOV DX, 0   ; Zera DX para usar como temporário

    MOV BX, 10  ; Base decimal

CONVERTE:
    XOR DX, DX  ; Zera DX antes da divisão
    DIV BX       ; Divide AX por 10, quociente em AX, resto em DX
    PUSH DX      ; Empilha o dígito (resto)
    INC CX       ; Aumenta o contador de dígitos
    TEST AX, AX  ; Testa se AX é zero
    JNZ CONVERTE ; Se não for zero, continua a conversão

IMPRIME:
    POP DX       ; Desempilha o dígito
    ADD DL, 30h  ; Converte para ASCII
    MOV AH, 2    ; Função para exibir caractere
    INT 21h      ; Exibe o dígito
    LOOP IMPRIME ; Continua até imprimir todos os dígitos

    RET
IMPRIME_NUMERO ENDP

END MAIN
