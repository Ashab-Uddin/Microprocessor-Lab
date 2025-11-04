.MODEL SMALL
.STACK 100H
.DATA
N DB ?    
STR DB "Enter the number: $"
MSG DB 0DH,0AH,"Summation of squares is: $"
SUM DW 0    

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; Display prompt
    MOV DX, OFFSET STR
    MOV AH, 9
    INT 21H

    ; Read user input (single digit)
    MOV AH, 1
    INT 21H
    SUB AL, 30H
    MOV N, AL

    ; Initialize SUM = 0
    MOV AX, 0
    MOV SUM, AX

    ; Initialize counter CX = N
    MOV CL, N
    MOV CH, 0

SUM_LOOP:
    MOV AL, CL       ; current number
    MUL AL           ; AX = AL * AL = CL^2
    ADD SUM, AX      ; SUM += CL^2
    LOOP SUM_LOOP

    ; Display result message
    MOV DX, OFFSET MSG
    MOV AH, 9
    INT 21H

    ; Prepare to print result (two digits max)
    MOV AX, SUM
    MOV BL, 10
    DIV BL           ; AX / 10 ? AL = quotient (tens), AH = remainder (units)
    MOV BH, AL       ; tens digit
    MOV BL, AH       ; ones digit

    ; Print tens digit
    MOV DL, BH
    ADD DL, 30H
    MOV AH, 2
    INT 21H

    ; Print ones digit
    MOV DL, BL
    ADD DL, 30H
    MOV AH, 2
    INT 21H

    ; Exit program
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN
