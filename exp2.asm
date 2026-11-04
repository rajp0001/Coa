.MODEL SMALL
.DATA
msg DB 0DH, 0AH, "---------- OF DF IF TF SF ZF -- AF -- PF -- CF $"
new1 DB 0DH, 0AH, "$"
flag DW ?

.CODE
start:
    MOV AX, @DATA
    MOV DS, AX

    MOV DX, OFFSET msg
    MOV AH, 09H
    INT 21H

    MOV DX, OFFSET new1
    MOV AH, 09H
    INT 21H

    CLI
    STC
    STD

    PUSHF
    POP BX
    MOV flag, BX
    MOV CX, 16
    MOV BX, 8000H    ; 1000 0000 0000 0000

loops:
    MOV AX, flag
    AND AX, BX
    JZ zero
    MOV DL, 31H
    MOV AH, 02H
    INT 21H
    JMP space

zero:
    MOV DL, 30H
    MOV AH, 02H
    INT 21H

space:
    MOV DL, ' '
    MOV AH, 02H
    INT 21H

    MOV AH, 02H
    INT 21H

    ROR BX, 1
    LOOP loops

    MOV AH, 4CH
    INT 21H

END start