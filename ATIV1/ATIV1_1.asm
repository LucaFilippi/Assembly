TITLE mensagens 
.MODEL SMALL
.DATA 
 ; Define as variáveis
    MSG1 DB "ola professor.$"
    MSG2 DB 10,13,"Mensagem 2.$"
.CODE
MAIN PROC 
    ; Permite o acesso às variáveis definidas em .DATA
     MOV AX,@DATA
    MOV DS,AX

    ;Exibe a String MSG1 na tela 
    MOV AH,9
    LEA DX,MSG1
    INT 21h
    ;Exibe a String MSG2 na tela
    MOV AH,9
    LEA DX,MSG2
    INT 21h
    ;Finaliza o programa
    MOV AH,4ch
    INT 21h
    MAIN ENDP
    END MAIN