.MODEL SMALL
.STACK 100H
.DATA
MSG DB 3
MSG1 DB ?
.CODE

MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    
    MOV AH,2
    ADD MSG,48
    MOV DL,MSG
    INT 21H   
    
    ;NEWLINE
    MOV AH,2
    MOV DL,13
    INT 21H
    MOV DL,10
    INT 21H 
    
    ;store a value in msg1
    MOV AH,1
    INT 21H
    MOV MSG1,AL
    
    ;PRINT NEWLINE
    MOV AH,2
    MOV DL,13
    INT 21H
    MOV DL,10
    INT 21H
    
    ;DISPLAY
    MOV AH,2
    MOV DL,MSG1
    INT 21H  
    
    EXIT:
    MOV AH,4CH
    INT 21H
    
    
    MAIN ENDP
END MAIN