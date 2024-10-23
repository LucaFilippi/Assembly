TITLE Batalha Naval
.MODEL SMALL
.STACK 100h ;determina o tamanho do pilha
.DATA
    DESISTIR DB "Voce desistiu do jogo, obrigado por jogar! $"
    MSG1 DB "Este eh o tabuleiro do jogo: $"
    VITORIA DB "Parabens voce venceu!! $"
    ACERTO DB "Voce acertou uma embarcacao inimiga! Continue tentando. $"
    BOMBABARCO DB "X $"
    ERRO DB "Voce errou, tente novamente! $"
    BOMBAERRO DB "?$"
    TABULEIRO DW 20 DUP(20 DUP('*'))



.CODE 
MAIN PROC 
    ; Permite acesso às variaveis definidas em .DATA
MOV AX,@DATA
MOV DS,AX 

