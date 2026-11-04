.MODEL SMALL
.STACK 100H
.DATA
    num1 DB 4      ; First operand
    num2 DB 2      ; Second operand

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; ---------- ADD ----------
    MOV AL, num1
    ADD AL, num2

    ; ---------- SUB ----------
    MOV AL, num1
    SUB AL, num2

    ; ---------- MUL ----------
    MOV AL, num1
    MOV AH, 0
    MOV BL, num2
    MUL BL
    ; Store result (for word-size MUL, result in AX)

    ; ---------- DIV ----------
    MOV AL, num1
    MOV BL, num2
    XOR DX, DX     ; Clear DX before division
    DIV BL         ; AX = AX / BX, remainder in DX

    ; ---------- AND ----------
    MOV AL, num1
    AND AL, num2

    ; ---------- OR ----------
    MOV AL, num1
    OR AL, num2

    ; ---------- XOR ----------
    MOV AL, num1
    XOR AL, num2

    ; ---------- NOT ----------
    MOV AL, num1
    NOT AL

    ; Exit program
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN