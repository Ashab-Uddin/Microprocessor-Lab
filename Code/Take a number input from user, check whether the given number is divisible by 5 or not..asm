.MODEL SMALL
.STACK 100H

.DATA
    STR1 DB 'Enter a number (0-9): $'
    STR2 DB 0DH,0AH,'The number is divisible by 5.$'
    STR3 DB 0DH,0AH,'The number is NOT divisible by 5.$'

.CODE
MAIN PROC
    ; Initialize DS
    MOV AX, @DATA
    MOV DS, AX

    ; Ask for input
    MOV DX, OFFSET STR1
    MOV AH, 9
    INT 21H

    ; Read one character (digit)
    MOV AH, 1
    INT 21H
    SUB AL, 30H        ; Convert ASCII to number 0–9

    ; Divide the number by 5
    MOV AH, 0
    MOV BL, 5
    DIV BL             ; AL = quotient, AH = remainder

    ; Check remainder
    CMP AH, 0
    JE DIVISIBLE
    JNE NOT_DIVISIBLE

DIVISIBLE:
    MOV DX, OFFSET STR2
    MOV AH, 9
    INT 21H
    JMP EXIT

NOT_DIVISIBLE:
    MOV DX, OFFSET STR3
    MOV AH, 9
    INT 21H

EXIT:
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN
