TITLE Divisoes sucessivas
.MODEL SMALL
.STACK 100h
.DATA
  MSG1 DB "Digite o Dividendo: $"
  MSG2 DB "Digite o Divisor: $"
  MSG3 DB "Resto: $"
  MSG4 DB "Quociente: $"
  NOVALINHA DB 13,10,'$' ; Nova linha para formatação de saída

.CODE
MAIN PROC
; permite acesso as variavies de .DATA
  MOV AX, @DATA
  MOV DS, AX
  
  ; Exibe a MSG1 na tela (Digite o Dividendo)
  MOV AH, 9
  LEA DX, MSG1
  INT 21h
  
  ; Lê o Dividendo do teclado
  MOV AH, 1
  INT 21h
  SUB AL, 30h ; Converte ASCII para número
  MOV BL, AL ; Armazena o dividendo em BL
  
  ; Exibe a MSG2 na tela (Digite o Divisor)
  MOV AH, 9
  LEA DX, MSG2
  INT 21h
  
  ; Lê o Divisor do teclado
  MOV AH, 1
  INT 21h
  SUB AL, 30h ; Converte ASCII para número
  MOV DL, AL ; Armazena o divisor em DL
  
  ; Inicializa o quociente em CX
  XOR CX, CX ; Zera o CX
  
DIVISAO: ; Começa a divisão por subtração
  CMP BL, DL ; Compara o dividendo com o divisor
  JL FIM_DIVISAO ; Se BL < DL, termina o loop (resto)
  SUB BL, DL ; Subtrai o divisor do dividendo
  INC CX     ; Incrementa o quociente
  JMP DIVISAO ; Continua a subtração
  
FIM_DIVISAO:
  ; Exibe a MSG4 na tela (Quociente)
  MOV AH, 9
  LEA DX, MSG4
  INT 21h
  
  ; Converte o quociente em CX para ASCII e exibe
  ADD CX, 30h
  MOV AH, 2
  MOV DL, CL ; Exibe o quociente (CX)
  INT 21h
  
  ; Exibe nova linha
  MOV AH, 9
  LEA DX, NOVALINHA
  INT 21h
  
  ; Exibe a MSG3 na tela (Resto)
  MOV AH, 9
  LEA DX, MSG3
  INT 21h
  
  ; Converte o resto (BL) para ASCII e exibe
  ADD BL, 30h
  MOV AH, 2
  MOV DL, BL ; Exibe o resto (BL)
  INT 21h
  
  ; Exibe nova linha
  MOV AH, 9
  LEA DX, NOVALINHA
  INT 21h
  
  ; Finaliza o programa
  MOV AH, 4Ch
  INT 21h
MAIN ENDP
END MAIN
