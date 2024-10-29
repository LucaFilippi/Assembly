;Faça um programa que conte quantas vogais tem em um 
;vetor nome de tamanho 20
;Exercicio adaptado para um vetor menor, mas para funcionar com qualquer vetor, 
;basta apenas alterar o vetor em .DATA e a comparação 
TITLE Exercicio 3
.MODEL SMALL
.STACK 100h
.DATA
VETOR DB 'P', 'A', 'L', 'M', 'E', 'I', 'R', 'A', 'S'
.CODE
MAIN PROC
    ; Inicializa segmento de dados
    MOV AX, @DATA
    MOV DS, AX

    XOR BX,BX ; Zera o contador de BX para poder usar para "andar" pelo vetor
    XOR DX,DX ;zera o contador de vogais

    CALL CONTAVOGAL
    CALL IMPRIMIR

    ;Finaliza o programa
    MOV AH,4CH
    INT 21H

MAIN ENDP
CONTAVOGAL PROC
    LOOPAR:
    CMP BX,9
    JE SAIR ;se chegou ao fim do vetor sai para imprimir o NUMERO DE VOGAIS
    MOV AL, VETOR[BX]
    ; Faz a verificação um por um das vogais
    CMP AL, 'A' 
    JE VOGAL
    CMP AL, 'E'
    JE VOGAL
    CMP AL, 'I'
    JE VOGAL
    CMP AL, 'O'
    JE VOGAL    
    CMP AL, 'U'
    JE VOGAL
    
    INC BX
    JMP LOOPAR ; Caso não seja nenhuma vogal, ele volta ao inicio faz as comparções novamente

    VOGAL:
    INC DL
    INC BX ;incrementa os dois contadores pois tem uma vogal e precisa andar uma casa no vetor
    JMP LOOPAR


    SAIR:
    RET

CONTAVOGAL ENDP

IMPRIMIR PROC

MOV AH,2
ADD DL,30h
INT 21h

RET
IMPRIMIR ENDP




END MAIN