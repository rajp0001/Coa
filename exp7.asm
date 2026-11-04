.MODEL SMALL
.STACK 100H

.DATA
menu DB 13,10,'case1. increase cursor (block)',13,10
     DB 'case2. decrease cursor (underline)',13,10
     DB 'case3. move right',13,10
     DB 'case4. move left',13,10
     DB 'case5. move up',13,10
     DB 'case6. move down',13,10
     DB 'case7. disable cursor',13,10
     DB 'Press key 1-7, any other key to exit...',13,10,'$'

.CODE

MAIN:
    MOV AX, @DATA
    MOV DS, AX

    ; Display menu
    MOV AH, 09H
    LEA DX, menu
    INT 21H

MAIN_LOOP:
    ; Wait for key press
    MOV AH, 01H
    INT 21H
    MOV BL, AL       ; Store key in BL

    ; Check cases
    CMP BL, '1'
    JE INCREASE_CURSOR

    CMP BL, '2'
    JE DECREASE_CURSOR

    CMP BL, '3'
    JE MOVE_RIGHT

    CMP BL, '4'
    JE MOVE_LEFT

    CMP BL, '5'
    JE MOVE_UP

    CMP BL, '6'
    JE MOVE_DOWN

    CMP BL, '7'
    JE HIDE_CURSOR

    JMP EXIT_PROGRAM

INCREASE_CURSOR:
    MOV AH, 01H
    MOV CH, 00H      ; Start line (top)
    MOV CL, 07H      ; End line (bottom) - block
    INT 10H
    JMP MAIN_LOOP

DECREASE_CURSOR:
    MOV AH, 01H
    MOV CH, 06H      ; Underline
    MOV CL, 07H
    INT 10H
    JMP MAIN_LOOP

MOVE_RIGHT:
    MOV AH, 03H
    MOV BH, 0
    INT 10H
    INC DL
    MOV AH, 02H
    INT 10H
    JMP MAIN_LOOP

MOVE_LEFT:
    MOV AH, 03H
    MOV BH, 0
    INT 10H
    DEC DL
    MOV AH, 02H
    INT 10H
    JMP MAIN_LOOP

MOVE_UP:
    MOV AH, 03H
    MOV BH, 0
    INT 10H
    DEC DH
    MOV AH, 02H
    INT 10H
    JMP MAIN_LOOP

MOVE_DOWN:
    MOV AH, 03H
    MOV BH, 0
    INT 10H
    INC DH
    MOV AH, 02H
    INT 10H
    JMP MAIN_LOOP

HIDE_CURSOR:
    MOV AH, 01H
    MOV CH, 26H      ; Invalid shape (hide)
    MOV CL, 07H
    INT 10H
    JMP MAIN_LOOP

EXIT_PROGRAM:
    MOV AH, 4CH
    INT 21H

END MAIN