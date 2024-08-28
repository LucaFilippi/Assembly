TITLE letra numero ou desconhecido
.MODEL SMALL
.STACK 100h
.DATA
    MSG1 DB "Digite um caractere: $"
    NUMERO DB 10,13, "O caractere digitado eh um numero.$"
    LETRA DB 10,13, "O caractere digitado eh uma letra$"
    DESC DB 10,13, "O caracter digitado eh desconhecido$"
.CODE
MAIN PROC
    ;permite acesso às variaveis definidas em .DATA
    MOV AX,@DATA
    MOV DS,AX
    ;Exibe na tela a string de MSG1
    MOV AH,9
    MOV DX,OFFSET MSG1
    INT 21h
      ;Lê um caractere do teclado e salva o caractere lido em AL 
    MOV AH,1
    INT 21h
    ;Copia o caractere lido para BL
    MOV BL,AL 
;compara o caracter salvo com 30h ("0") e se for menos salta para DESC
    CMP BL,30h
    JB DESCON 

    ;compara o caracter com 39h e se for maior salta para SEGUNDAVERIF
    CMP BL,39h
    JA SEGUNDAVERIF

    ;se chegou aqui é porque é numero
    MOV AH,9
    MOV DX,OFFSET NUMERO
    INT 21h
    ;salta para o rotulo fim 
    JMP FIM

    SEGUNDAVERIF: ;define o rotulo segudna verificação
    ;compara o caracter com 41h
    CMP BL,41h 
    JB DESCON ;se for menos que 41, pula para DESC

    ;Compara o caracter com 5Ah 
    CMP BL,5Ah 
    JBE LETRAS ; se for menor ou igual a 5Ah, pula para LETRA

    ;compara o caracter com 61h 
    CMP BL,61h 
    JB DESCON ;se for menor que 61h pula para DESC

    ;compara o caracter com 7Ah 
    CMP BL,7Ah 
    JBE LETRAS ;se for menor ou igual a 7Ah vai pular para letra 

    JA DESCON ;Se for maior que 7Ah, pula para DESC

    LETRAS: ;define o rotulo para letra
     MOV AH,9
    MOV DX,OFFSET LETRA
    INT 21h
    ;salta para o rotulo fim 
    JMP FIM

    DESCON: ;Define o rotulo para caracteres desconhecidos
     MOV AH,9
    MOV DX,OFFSET DESC
    INT 21h
    ;salta para o rotulo fim 
    JMP FIM

   ;Define o rotulo FIM 
    FIM: 
    ;FInaliza o programa 
    MOV AH,4Ch
    INT 21h
    MAIN ENDP
    END MAIN