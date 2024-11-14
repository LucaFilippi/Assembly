.MODEL SMALL
.DATA
resultado DB ?   ; Resultado final do número aleatório (1, 2 ou 3)

.CODE
; Procedimento principal apenas para demonstração
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    CALL RANDOM          ; Chama o procedimento RANDOM
    ; O número gerado estará em `resultado`
    
    MOV AH,2 
    MOV DL, RESULTADO
    ADD DL,30h
    INT 21h
    ; Para fins de teste, pare aqui
    MOV AH, 4CH          ; Finaliza o programa
    INT 21H
MAIN ENDP

; Procedimento RANDOM
; Gera um número aleatório entre 1 e 3 usando a função de hora do DOS
RANDOM PROC
    ; Obtém a hora atual
    MOV AH, 2Ch          ; Função 2Ch: Retorna a hora
    INT 21H              ; Chama o DOS
    ; DH contém os segundos, DL contém os centésimos de segundo

    ; Usar os centésimos de segundo como base pseudoaleatória
    MOV AX, DX           ; Copia DX (segundos e centésimos) para AX
    MOV CX, 3            ; Divisor para o número aleatório
    XOR DX, DX           ; Garante que DX esteja limpo para a divisão
    DIV CX               ; Divide AX por 3
    ADD DL, 1            ; Incrementa o resto (DL) para obter (1, 2 ou 3)

    ; Salva o resultado
    MOV resultado, DL    ; Armazena o número final (1 a 3)
    RET
RANDOM ENDP

END MAIN
