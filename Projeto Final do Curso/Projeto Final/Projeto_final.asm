TITLE Batalha Naval
.MODEL SMALL
.STACK 100h ;determina o tamanho do pilha
.DATA
    TABULEIRO DW 20 DUP(20 DUP('*'))
    JOGADAS DB 


.CODE 
MAIN PROC 
    ; Permite acesso às variaveis definidas em .DATA
MOV AX,@DATA
MOV DS,AX 

