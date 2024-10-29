;Faça um programa que converta um número decimal para: 
;a.  HEXADECIMAL 
;b.  OCTAL 
;c.  BINÁRIO
; o criterio de parada de leitura para o numero decimal é o "ENTER"
TITLE Exercicio 3
.MODEL SMALL
.STACK 100h
.DATA
MSG1 DB "Digite um numero em Decimal $"
MSG2 DB "Seu numero em Hexadecimal $"
MSG3 DB "Seu numero em Octal $"
MSG4 DB "Seu Numero em Binario $"

.CODE 
MAIN PROC
    ; Inicializa segmento de dados
    MOV AX, @DATA
    MOV DS, AX
    ; Move 10 para BL para fazer as multiplicações
    MOV BL, 10

    CALL LERDECIMAL ;chama a subrotina que le os caracteres do teclado
    CALL IMPRIMIRHEX ; chama a subrotina que imprime o hexadecimal
    CALL PULALINHA
    CALL IMPRIMEBINARIO ;chama a subrotina que imprime em binario
    CALL PULALINHA

    ;Finaliza o programa
    MOV AH,4CH
    INT 21H
    MAIN ENDP

    PULALINHA PROC 
    MOV AH,2
    MOV DL,10
    INT 21h 
    MOV AH,2
    MOV DL,13
    INT 21h 
    RET
    PULALINHA ENDP


LERDECIMAL PROC
    XOR AX, AX       ; Limpa AX para evitar valores residuais
    XOR BX, BX       ; Limpa BX (vai armazenar o valor total)
    
LENDODECIMAL:
    ; Lê o primeiro número e salva em AL
    MOV AH, 1        ; Função 1 de INT 21h - Leitura de caractere
    INT 21h
    CMP AL, 13       ; Verifica se o caractere é Enter (ASCII 13)
    JE @SAI          ; Sai se for Enter
    
    ; Converte caractere ASCII para dígito numérico
    SUB AL, '0'      ; Converte o caractere ASCII em valor numérico
    MOV CL, AL       ; Armazena o dígito em CL

    ; Total = total * 10 + dígito
    MOV AX, BX       ; Move o total atual para AX
    MOV DX, 0        ; Limpa DX para multiplicação
    MOV BX, 10
    MUL BX           ; AX = total * 10
    ADD AX, CX       ; Adiciona o dígito lido a AX
    MOV BX, AX       ; Atualiza o total em BX
    
    JMP LENDODECIMAL ; Continua no loop para ler o próximo dígito

@SAI:
    ; Quando Enter for pressionado, o total está em BX
    RET              ; Retorna do procedimento

LERDECIMAL ENDP

IMPRIMIRHEX PROC
    PUSH BX           ; Salva BX na pilha para preservar o valor original
    MOV CX, 4         ; CX servirá como contador para 4 nibbles (16 bits)

IMPRIMINDOHEXA:
    ; Obtém o nibble mais significativo à esquerda
    MOV AX, BX        ; Copia BX para AX
    SHR AX, 12        ; Move o nibble mais à esquerda para a posição mais baixa (4 bits)
    AND AX, 0Fh       ; Isola o nibble mais à esquerda

    ; Converte o nibble para o caractere ASCII correspondente
    CMP AX, 10
    JB DIGITO         ; Salta se o valor é 0-9 (números)
    ADD AX, 37h       ; Converte para 'A'-'F' (ASCII) se o valor é >= 10
    JMP EXIBIR

DIGITO:
    ADD AX, 30h       ; Converte para '0'-'9' (ASCII)

EXIBIR:
    MOV DL, AL        ; Coloca o caractere convertido em DL
    MOV AH, 2         ; Função de exibição de caractere
    INT 21h           ; Exibe o caractere

    ; Prepara o próximo nibble
    SHL BX, 4         ; Move o próximo nibble para a posição mais significativa
    LOOP IMPRIMINDOHEXA ; Decrementa CX e repete até que todos os nibbles sejam exibidos

    POP BX            ; Restaura o valor original de BX
    RET
IMPRIMIRHEX ENDP

IMPRIMEBINARIO PROC
    PUSH BX ;Coloca bx na pilha para não se preocupar com alteração de valor
    MOV CX,16 ;contador com 16 para controlar o loop
    XOR DX,DX ;Evitar passagem de parametros errados
    TRANSFORMAEIMPRIMI:
    SHL BX,1 ;move os bits para a esquerda fazendo o mais significativo ir para o CF
    JC BIT1 ;verifica o CF e se ele existir(ter 1) vai para imprimir 1
    MOV DL,'0' ;se não pulou para a label então tem 0 em CF
    JMP EXIBIRBINARIO
    
BIT1:
    MOV DL,'1'

EXIBIRBINARIO: 
    MOV AH,2
    INT 21h

    LOOP TRANSFORMAEIMPRIMI

    POP BX 
IMPRIMEBINARIO ENDP


END MAIN