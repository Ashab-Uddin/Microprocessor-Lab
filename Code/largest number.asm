.MODEL SMALL
.STACK 100H

.DATA
    STR1 DB 'Enter first number (0-9): $'
    STR2 DB 0DH,0AH, 'Enter second number (0-9): $'
    STR3 DB 0DH,0AH, 'The largest number is: $'
    STR4 DB 0DH,0AH, 'Both numbers are equal: $'
    NL   DB 0DH,0AH,'$'
    
.CODE
MAIN PROC
    ; init DS
    MOV AX, @DATA
    MOV DS, AX

    ; ----- Read first digit -----
    MOV DX, OFFSET STR1
    MOV AH, 9
    INT 21H

READ_FIRST:
    MOV AH, 1           ; read char
    INT 21H
    CMP AL, '0'
    JB  READ_FIRST      ; not a digit, read again
    CMP AL, '9'
    JA  READ_FIRST      ; not a digit, read again
    SUB AL, '0'         ; ASCII -> value 0..9
    MOV BL, AL          ; BL = first number

    ; newline
    MOV DX, OFFSET NL
    MOV AH, 9
    INT 21H

    ; ----- Read second digit -----
    MOV DX, OFFSET STR2
    MOV AH, 9
    INT 21H

READ_SECOND:
    MOV AH, 1
    INT 21H
    CMP AL, '0'
    JB  READ_SECOND
    CMP AL, '9'
    JA  READ_SECOND
    SUB AL, '0'
    MOV BH, AL          ; BH = second number

    ; newline
    MOV DX, OFFSET NL
    MOV AH, 9
    INT 21H

    ; ----- Compare and print result -----
    CMP BL, BH
    JE  EQUAL_CASE
    JG  FIRST_IS_LARGER

    ; BH is larger
    MOV DX, OFFSET STR3
    MOV AH, 9
    INT 21H

    MOV DL, BH          ; value 0..9
    ADD DL, '0'         ; to ASCII
    MOV AH, 2
    INT 21H
    JMP DONE

FIRST_IS_LARGER:
    MOV DX, OFFSET STR3
    MOV AH, 9
    INT 21H

    MOV DL, BL
    ADD DL, '0'
    MOV AH, 2
    INT 21H
    JMP DONE

EQUAL_CASE:
    MOV DX, OFFSET STR4
    MOV AH, 9
    INT 21H

    MOV DL, BL
    ADD DL, '0'
    MOV AH, 2
    INT 21H

DONE:
    ; final newline
    MOV DX, OFFSET NL
    MOV AH, 9
    INT 21H

    ; exit
    MOV AH, 4CH
    INT 21H
MAIN ENDP
END MAIN
