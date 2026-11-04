Block Exchange
.MODEL SMALL
.DATA
block1 DB 01h, 02h, 03h, 04h, 05h
block2 DB 11h, 12h, 13h, 14h, 15h

.CODE
START:
    MOV AX, @DATA
    MOV DS, AX

    MOV CX, 05h          ; Number of bytes to exchange
    LEA SI, block1       ; Source block 1
    LEA DI, block2       ; Source block 2

EXCHANGE_LOOP:
    MOV AL, [SI]         ; Load byte from block1
    MOV BL, [DI]         ; Load byte from block2

    MOV [SI], BL         ; Store block2's byte into block1
    MOV [DI], AL         ; Store block1's byte into block2

    INC SI
    INC DI
    DEC CX
    JNZ EXCHANGE_LOOP

    MOV AH, 4CH
    INT 21H

END START