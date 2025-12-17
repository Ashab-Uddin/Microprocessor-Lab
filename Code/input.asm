
.MODEL SMALL
.STACK 100H
.CODE

MAIN PROC 
    ;INPUT A NUMBER
    MOV AH,1
    INT 21H
    MOV BL,AL
    
    ;print newline
    MOV AH,2
    MOV DL,13
    INT 21H
    MOV DL,10
    INT 21H
  
    
    ;INPUT ANOTHER NUMBER
    MOV AH,1
    INT 21H
    MOV BH,AL
    
    ;print newline
    MOV AH,2
    MOV DL,13
    INT 21H
    MOV DL,10
    INT 21H
  
    
    ;DISPLAY FIRST NUMBER
    
    MOV AH,2
    MOV DL,BL
    INT 21H
    
    ;print newline
    MOV AH,2
    MOV DL,13
    INT 21H
    MOV DL,10
    INT 21H
  
    
    
    ;DISPLAY SECOND VALUE
    MOV AH,2
    MOV DL,BH
    INT 21H
    
    EXIT:
    MOV AH,4CH
    INT 21H
    MAIN ENDP
END MAIN
    
    