.MODEL SMALL
.STACK 100H
.DATA
N DB ?    
STR DB "Enter the number: $"
MSG DB 0DH,0AH,"Factorial is: $"
RESULT DW 1    

.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX

    ; Display prompt
    MOV DX, OFFSET STR
    MOV AH,9
    INT 21H

    ; Read user input
    MOV AH,1
    INT 21H
    SUB AL,30H
    MOV N,AL

    ; Initialize RESULT = 1
    MOV AX,1
    MOV RESULT,AX

    ; Load counter CX = N
    MOV CL,N
    MOV CH,0

FACTORIAL_LOOP:
    MOV AX, RESULT
    MUL CX          ; AX = RESULT * CX
    MOV RESULT, AX
    LOOP FACTORIAL_LOOP

    ; Print "Factorial is: "
    MOV DX, OFFSET MSG
    MOV AH,9
    INT 21H

    ; Print factorial (two digits max)
    MOV AX, RESULT
    MOV BL,10
    DIV BL          ; AX / 10, quotient in AL, remainder in AH
    MOV BH,AL       ; tens digit
    MOV BL,AH       ; units digit

    ; Print tens digit
    MOV DL,BH
    ADD DL,30H
    MOV AH,2
    INT 21H

    ; Print units digit
    MOV DL,BL
    ADD DL,30H
    MOV AH,2
    INT 21H

    ; Exit
    MOV AH,4CH
    INT 21H

MAIN ENDP
END MAIN
