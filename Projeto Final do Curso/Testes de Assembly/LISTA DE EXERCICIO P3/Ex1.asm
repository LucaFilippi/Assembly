; Em um vetor de números armazenado na memória, conte quantas 
;ocorrências de números maiores que 15 e imprima essa mensagem no 
;terminal.
TITLE EXERCICIO 1
.MODEL SMALL
.STACK 0100h
.DATA
VETOR DB 10, 15, 30, 35, 40, 50, 1, 8
TAMANHO DB 8
MSG DB "A quantidade de numeros maior que 15 é: $"
MAIORES15 DB 0
.CODE 
MAIN PROC 
    ; inicializa as variaveis definidas em .DATA
    MOV AX, @DATA 
    MOV DS, AX
    ; Chama o procedimento que irá percorrer o vetor e verificar maiores que 15
    CALL PERCORREVETOR
    ; imprime a msg 1 para ficar uma melhor interface do usuario
    MOV AH, 9
    MOV DX ,OFFSET MSG
    INT 21h 
    ; imprime o numero de numeros maiores que 15 que tem no vetor
    MOV AH,2 
    MOV DL, MAIORES15 
    ADD DL, 30h
    INT 21h

; Finaliza o programa
MOV AH, 4Ch
INT 21h
MAIN ENDP
PERCORREVETOR PROC
;Empilha o conteúdo dos registradaores para evitar problemas
PUSH CX
PUSH BX
PUSH AX
PUSH DX

;Zera os registradores
XOR AX,AX
XOR BX,BX 
XOR CX,CX
XOR DX,DX

;Atribui o tamanho do vetor em CX para servir de contador
MOV CL, TAMANHO

CONTAMAIS15: 
MOV AL, VETOR[BX] ; Coloca em ax o elemento do vetor representado pelo numero em bx
INC BX ; incrementa bx para ir para o proximo elemento
CMP AX, 15 ; compara com 15 
JA MAIOR15 ; se maior que 15, vai para a label que incriementa no contador
LOOP CONTAMAIS15 ; caso contrario, reinicia o loop indo para o proximo elemento
JMP SAI ; finaliza o procedimento 
MAIOR15:
INC DX ; incrementa o contador e ja volta para o loop para verificar os outros elementos
LOOP CONTAMAIS15
SAI: 
MOV MAIORES15, DL ; coloca o valor adiquirido em uma variavel para não perder o valor
; desempilha todos os valores dos registraodres
POP DX
POP AX
POP BX
POP CX
RET
PERCORREVETOR ENDP
END MAIN