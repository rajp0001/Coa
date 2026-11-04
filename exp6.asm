.MODEL SMALL
.DATA
    strr DB "liril"
    len EQU $-strr
    rstr DB 20 DUP(0)

    msg1 DB 10,13,"it is a palindrome $"
    msg2 DB 10,13,"it is not a palindrome $"

.CODE
START:
    MOV AX, @DATA
    MOV DS, AX
    MOV ES, AX

    MOV SI, OFFSET strr
    MOV DI, OFFSET rstr
    ADD DI, len-1

    MOV CX, len

BACK:
    MOV AL, [SI]
    MOV [DI], AL
    INC SI
    DEC DI
    LOOP BACK

    MOV SI, OFFSET strr
    MOV DI, OFFSET rstr
    MOV CX, len

    CLD
    REPE CMPSB
    JNE DOWN

    LEA DX, msg1
    JMP DOWN1

DOWN:
    LEA DX, msg2

DOWN1:
    MOV AH, 09H
    INT 21H

    MOV AH, 4CH
    INT 21H

END START