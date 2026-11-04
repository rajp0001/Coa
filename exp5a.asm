Block Transfer
.MODEL SMALL
.DATA
    X DB 01H,02H,03H,04H,05H

.CODE
START:
    MOV AX, @DATA
    MOV DS, AX

    MOV CX, 05H
    LEA SI, X+04
    LEA DI, X+04+03

UP:
    MOV BL, [SI]
    MOV [DI], BL

    DEC SI
    DEC DI
    DEC CX

    JNZ UP

    MOV AH, 4CH
    INT 21H

END START