;Faça uma busca em uma matriz 4X4 (DW) e retorne o seu maior valor e 
;seu menor valor.
TITLE EXERCICIO 2
.MODEL SMALL
.STACK 0100h 
.DATA 
MATRIZ DW 1, 2, 3, 4
       DW   5, 6, 7,7
       DW  7, 2, 1, 9
       DW   3, 9, 7, 2
MAIOR DB 0
MENOR DB 0FFh 
.CODE 
MAIN PROC 
    ; Permite acesso as variaveis em .DATA
    MOV AX, @DATA
    MOV DS, AX

    CALL PERCORREMATRIZ

    MOV AH, 2
    MOV DL, MAIOR
    ADD DL, 30h
    INT 21h 
     
    MOV AH, 2
    MOV DL, MENOR
    ADD DL, 30h
    INT 21h
; FINALIZA O PROGRAMA
    MOV AH, 4Ch
    INT 21h

MAIN ENDP 

PERCORREMATRIZ PROC
;empilha os registradores para evitar perder conetudo
PUSH AX
PUSH BX
PUSH CX
PUSH DX
PUSH SI 

; zera os registradores
XOR AX, AX 
XOR BX, BX
XOR CX, CX 
XOR DX, DX
XOR SI, SI

ANALISAMATRIZ:
MOV AX, MATRIZ [BX+SI] ;Adiciona o elemento em AX
CMP AL, MAIOR ; faz a primeira comparação, do numero em AX com o maior numero atual
JA NOVOMAIOR ; se maior, substitui para o maio numero
CMP AL, MENOR ; faz a segunda comparação, do numero em AX com o menor numero atual
JB NOVOMENOR ; se menor, substitui para o menor numero
PROXELEMEN: 
CMP SI, 32 ; compara com a ultima linha (24) para ter certeza que nn teremos ero
JE SAI
CMP BX, 6 ; compara com a ultima coluna, se for a ultima, vai pra proxima linha 
JE PROXLINHA
ADD BX, 2
JMP ANALISAMATRIZ
PROXLINHA: 
XOR BX, BX
ADD SI, 8
JMP ANALISAMATRIZ
NOVOMAIOR: 
MOV MAIOR, AL
JMP PROXELEMEN
NOVOMENOR: 
MOV MENOR, AL
JMP PROXELEMEN

SAI: 
POP SI
POP DX
POP CX
POP BX
POP AX

RET
PERCORREMATRIZ ENDP
END MAIN