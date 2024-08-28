TITLE Eco
.MODEL SMALL
.CODE
MAIN PROC 
   ;Exibe o caracter "?" na tela
   MOV AH,2
   MOV DL,'?'
   INT 21h
   ;Lê um caracter do teclado e salva o mesmo em AL
   MOV AH,1
   INT 21h
   ;copia o caracter lido para BL
   MOV BL,AL
   ;exibe o caracter line feed
   MOV AH,2
   MOV DL,10 ; O codigo ASC do caracter line feed é 10 (0Ah)
   INT 21h
      ; Exibe o caracter carriage return (Move o cursor para a linha seguinte) 
    MOV AH,2
    MOV DL,13 ; O codigo ASC do caracter Carriage Return é 13 (0Dh)
    INT 21h 


   ; exibe o caracter lido (Salvo em BL) 
   MOV AH,2
   MOV DL,BL
   INT 21h

;Finaliza o programa
   MOV AH,4Ch
   INT 21h
 MAIN ENDP
 END MAIN