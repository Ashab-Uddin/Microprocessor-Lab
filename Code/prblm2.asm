.MODEL SMALL
.STACK 100H

.DATA   
    NUM1 DB 1
    NUM2 DB ?
    
    MSG1 DB 'Enter a number: $'
    MSG2 DB 'Output: $'   
    
    NEWLINE DB 13, 10, '$'

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
                      
    LEA DX, MSG1
    MOV AH, 9
    INT 21H
    
    MOV AH, 1
    INT 21H
    SUB AL, 48
    MOV NUM2, AL   
    
    
     ; print newline
    LEA DX, NEWLINE
    MOV AH, 9
    INT 21H
    
    LEA DX, MSG2
    MOV AH, 9
    INT 21H

PRINT_LOOP:
    MOV DL, NUM1
    ADD DL, 48
    MOV AH, 2
    INT 21H   
    
    MOV DL, ','
    MOV AH, 2
    INT 21H
    
    INC NUM1 
    MOV AL, NUM1
    CMP AL, NUM2
    JLE PRINT_LOOP      
    
    
    
    MOV AH, 4CH
    INT 21H
MAIN ENDP
END MAIN
