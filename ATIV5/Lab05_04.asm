TITLE Alfabeto maiúsculo e minúsculo
.MODEL SMALL    
.STACK 100h     
.CODE
MAIN PROC
MOV AH,2      
MOV DL,'a'    ; Coloca o caractere 'a' em DL, que será impresso primeiro
MOV CX,26    ; Carrega o contador CX com 26 (número de letras no alfabeto)
MOV BH,4      ; BH vai contar até 4, para inserir uma nova linha após cada 4 letras

LETRA:
INT 21h       ; Imprime o caracter em DL
MOV BL,DL     ; Armazena a letra atual (DL) em BL
MOV DL,20h    ; Coloca o código ASCII 20h (espaço) em DL
INT 21h       ; Chama a interrupção 21h para imprimir o espaço
MOV DL,BL     ; Restaura a letra atual para DL, que foi temporariamente armazenada em BL
INC DL        ; Incrementa DL para a próxima letra
DEC BH        ; Decrementa BH, contando quantas letras já foram impressas
JNZ SALTA     ; Se BH não for zero, salta para a label SALTA para continuar imprimindo
MOV BL,DL     ; Armazena a próxima letra em BL 
MOV DL,10     ; Coloca o código ASCII 10h (nova linha) em DL
INT 21h       ; Chama a interrupção 21h para imprimir a nova linha
MOV BH,4      ; Reinicia BH com 4 para contar mais 4 letras

SALTA:
LOOP LETRA    ; Decrementa CX e repete o loop se CX não for zero (26 letras ao todo)

; Finaliza o programa
 MOV AH,4Ch 
INT 21h       
MAIN ENDP
END MAIN
