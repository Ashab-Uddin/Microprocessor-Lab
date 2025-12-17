.MODEL SMALL
.STACK 100H
.DATA
A DB "lOOP CONCEPT $"
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
             
    ;Print the loop concept message         
    MOV AH,9
    LEA DX,A
    INT 21H
    
    ;Print newline
    MOV AH,2
    MOV DL,10
    INT 21H
    MOV DL,13
    INT 21H
    
    
    ;LOOP CONCEPT START(Print the alphabet A-Z)
    MOV CX,26
    MOV AH,2
    MOV DL, 'A'
    
    LEVEL1:
    INT 21H
    INC DL
    LOOP LEVEL1
    
    EXIT:
    MOV AH,4CH
    INT 21H
    MAIN ENDP
END MAIN
    
    