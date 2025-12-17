.MODEL SMALL
.STACK 100H

.DATA
    NUM DB ?
    ARRAY DB 10 DUP(?)
    SUM DB 0  
    MSG1 DB 'Enter number: $'
    MSG2 DB 'Enter Elements: $'
    MSG3 DB 'Sum = $'
    NEWLINE DB 10,13,'$'       
    
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
    MOV NUM, AL    
    
    
    
    LEA DX, NEWLINE
    MOV AH, 9
    INT 21H

    LEA DX, MSG2
    MOV AH, 9
    INT 21H 
          
          
    MOV CL, NUM       
    MOV SI, 0

INPUT_LOOP: 
    LEA DX, NEWLINE
    MOV AH, 9
    INT 21H 
    
    MOV AH, 1
    INT 21H
    SUB AL, 48
    MOV ARRAY[SI], AL
    INC SI  
               
    DEC CL
    CMP CL, 0
    JA INPUT_LOOP
      
      
      
    ; Calculate sum
    MOV CL, NUM      
    MOV SI, 0
    MOV AL, 0
    
SUM_LOOP:
    MOV AL, ARRAY[SI]
    ADD SUM, AL
    INC SI 
    
    DEC CL
    CMP CL, 0
    JA SUM_LOOP 
    
    

    LEA DX, NEWLINE
    MOV AH, 9
    INT 21H

    LEA DX, MSG3
    MOV AH, 9
    INT 21H     
                 
    MOV DL, SUM
    ADD DL, 48
    MOV AH, 2
    INT 21H             

    MOV AH, 4CH
    INT 21H
MAIN ENDP
END MAIN
