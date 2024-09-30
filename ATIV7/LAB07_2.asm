TITLE Multiplicações sucessivas
.MODEL SMALL
.STACK 100h
.DATA
  MSG1 DB "Digite o Multiplicando: $"
  MSG2 DB "Digite o Multiplicador: $"
  MSG3 DB "Resultado: $"
  NOVALINHA DB 13,10,'$' ; Nova linha para formatação de saída

.CODE
MAIN PROC
    ; Permite acesso às variáveis de .DATA
  MOV AX, @DATA
  MOV DS, AX
  
    ; Exibe a MSG1 na tela (Digite o Multiplicando)
  MOV AH, 9
  LEA DX, MSG1
  INT 21h
  
    ; Lê o Multiplicando do teclado
  MOV AH, 1
  INT 21h
  SUB AL, 30h ; Converte ASCII para número
  MOV BL, AL ; Armazena o multiplicando em BL

    ; Exibe a MSG2 na tela (Digite o Multiplicador)
  MOV AH, 9
  LEA DX, MSG2
  INT 21h
  
    ; Lê o Multiplicador do teclado
  MOV AH, 1
  INT 21h
  SUB AL, 30h ; Converte ASCII para número
  MOV CL, AL ; Armazena o multiplicador em CL

    ; Inicializa o acumulador para multiplicação sucessiva
  MOV AL, 0

MULTIPLICAR:
  ADD AL, BL ; Soma o multiplicando
  DEC CL     ; Decrementa o contador (multiplicador)
  CMP CL, 0
  JNZ MULTIPLICAR ; Continua se o contador não for zero

FINALIZANDO:
    ; Exibe a MSG3 na tela (Resultado)
  MOV AH, 9
  LEA DX, MSG3
  INT 21h
  
    ; Converte o resultado para ASCII
  ADD AL, 30h
  
    ; Exibe o resultado
  MOV DL, AL
  MOV AH, 2
  INT 21h

    ; Nova linha após o resultado
  MOV AH, 9
  LEA DX, NOVALINHA
  INT 21h

    ; Finaliza o programa
  MOV AH, 4Ch
  INT 21h
MAIN ENDP
END MAIN