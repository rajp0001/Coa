
.MODEL SMALL
.STACK 100H

.DATA
    msg1 DB 'Enter first BCD number (00-99): $'
    msg2 DB 0DH, 0AH, 'Enter second BCD number (00-99): $'
    msg3 DB 0DH, 0AH, 'Sum is: $'

    res DB 4 DUP('$')
    temp DB ?

.CODE

MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; Read first BCD number
    LEA DX, msg1
    CALL PRINT

    CALL READ_BCD
    MOV BH, AL

    ; Read second BCD number
    LEA DX, msg2
    CALL PRINT

    CALL READ_BCD

    ; Add two BCD numbers
    ADD AL, BH
    DAA

    ; Check carry
    JNC NO_CARRY

    MOV res, '1'
    LEA DI, res+1
    JMP CONVERT

NO_CARRY:
    LEA DI, res

CONVERT:
    MOV BL, AL
    MOV CL, 4

    ; Convert tens digit
    SHR AL, CL
    AND AL, 0FH
    ADD AL, '0'
    MOV [DI], AL

    ; Convert units digit
    MOV AL, BL
    AND AL, 0FH
    ADD AL, '0'
    MOV [DI+1], AL

    MOV BYTE PTR [DI+2], '$'

    ; Display result
    LEA DX, msg3
    CALL PRINT

    LEA DX, res
    CALL PRINT

    ; Exit program
    MOV AH, 4CH
    INT 21H

MAIN ENDP

; Print string
PRINT PROC
    MOV AH, 09H
    INT 21H
    RET
PRINT ENDP

; Read two ASCII digits and convert to packed BCD
READ_BCD PROC

    ; Read first digit
    MOV AH, 01H
    INT 21H
    SUB AL, '0'
    MOV BL, AL

    MOV CL, 4
    SHL BL, CL

    ; Read second digit
    MOV AH, 01H
    INT 21H
    SUB AL, '0'

    OR AL, BL
    MOV temp, AL

    ; Consume Enter key
    MOV AH, 01H
    INT 21H

    MOV AL, temp
    RET

READ_BCD ENDP

END MAIN
