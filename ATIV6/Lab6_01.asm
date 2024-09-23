'TITLE contar e colocar asteriscos
.MODEL SMALL
.STACK 100h

.CODE
MAIN PROC

MOV CX, 0 ;inicializa CX como zero para evitar erros
Ler: ; Lê o caracter na tela
MOV AH,1
INT 21h
CMP AL, 13 ;Compara com o carater de enter em ASCII
JE imprimir ;se for igual a 13, pula para imprimir os asteriscos
ADD CX, 1 ;se não for, adiciona 1 no BX servindo de contador
JMP Ler

imprimir: ;imprime numero de * igual ao numero de CX
MOV AH,2 
MOV DL,'*'
INT 21h
LOOP imprimir

Finalizar:
;FInaliza o programa 
MOV AH,4Ch
INT 21h
MAIN ENDP
END MAIN'