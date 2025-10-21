.MODEL SMALL
.STACK 100H

.DATA
    MSG1 DB 'Enter Temperature in Celsius (0-9): $'
    MSG2 DB 0AH, 0DH, 'Temperature in Fahrenheit is: $'
    NINE DW 9
    FIVE DW 5
    
.CODE
MAIN PROC
    ; Initialize Data Segment
    MOV AX, @DATA
    MOV DS, AX
    
    ; --- User Input ---
    ; Print input prompt message
    LEA DX, MSG1
    MOV AH, 9
    INT 21H
    
    ; Read a single character from the user
    MOV AH, 1
    INT 21H
    
    ; Convert ASCII digit to a number
    SUB AL, '0' 
    MOV BL, AL      
    
    ; --- Calculation: F = (C * 9 / 5) + 32 - 1
    MOV AL, BL      
    MOV AH, 0      
    
    MUL NINE        
    
    DIV FIVE       
    
    ADD AL, 32      
    SUB AL, 1       
    
    MOV BL, AL      
    
    ; --- Display Output ---
    ; Print the result message
    LEA DX, MSG2
    MOV AH, 9
    INT 21H
    
    ; Prepare the Fahrenheit value for display
    MOV AL, BL     
    MOV AH, 0       
    AAM            
    
    ; Now AH has the tens digit and AL has the units digit
    MOV CX, AX     
    
    ; Print the tens digit
    MOV DL, AH
    ADD DL, '0'     
    MOV AH, 2
    INT 21H
    
    ; Print the units digit
    MOV DL, CL
    ADD DL, '0'     
    MOV AH, 2
    INT 21H
    
    ; --- Terminate Program ---
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN