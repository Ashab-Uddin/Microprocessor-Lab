.MODEL SMALL
.STACK 100H

.DATA
    STR1 DB 'Enter a number (0-9): $'
    STR2 DB  'Result: $'
    STR3 DB  'Remainder: $'
    STR4 DB 0DH,0AH,'The number is Even: $' 
    STR5 DB 0DH,0AH,'The number is Odd: $'
    

.CODE
MAIN PROC
    ; Initialize DS
    MOV AX, @DATA
    MOV DS, AX

    ; Print input prompt
    MOV DX, OFFSET STR1
    MOV AH, 9
    INT 21H

    ; Read one character
    MOV AH, 1
    INT 21H           

    SUB AL, 30H      
    MOV BL, AL        

    ; Divide number by 2
    MOV AL, BL
    MOV AH, 0
    MOV DL, 2
    DIV DL           

    MOV CH, AL        
    MOV CL, AH  
    
    ;PRINT NEWLINE
    MOV AH,2
    MOV DL,13
    INT 21H
    MOV DL,10
    INT 21H        

    ; Print "Result mesg: "
    MOV DX, OFFSET STR2
    MOV AH, 9
    INT 21H

    ; Print result digit
    MOV AL, CH
    ADD AL, '0'
    MOV DL, AL
    MOV AH, 2
    INT 21H
    
    ;PRINT NEWLINE
    MOV AH,2
    MOV DL,13
    INT 21H
    MOV DL,10
    INT 21H

    ; Print "Remainder mesg: "
    MOV DX, OFFSET STR3
    MOV AH, 9
    INT 21H

    ; Print remainder digit
    MOV AL, CL
    ADD AL, '0'
    MOV DL, AL
    MOV AH, 2
    INT 21H  
    
    CMP CL,0
    JE EVEN
    JNE ODD
    
    EVEN:
    LEA DX,STR4
    MOV AH,9
    INT 21H
    JMP BLANK
    
    ODD:
    LEA DX, STR5
    MOV AH,9
    INT 21H
    BLANK:
           
   ; Print result digit
    MOV AL, BL
    ADD AL, '0'
    MOV DL, AL
    MOV AH, 2
    INT 21H        
    
    

    ; Exit
    MOV AH, 4CH
    INT 21H
MAIN ENDP
END MAIN
