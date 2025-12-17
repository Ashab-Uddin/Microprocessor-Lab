.MODEL SMALL
.STACK 100H

.DATA
    N1 DB 7
    N2 DB 2
    
    MSG1 DB 'Summertion: $' 
    MSG2 DB 'Subtruction: $'
    MSG3 DB 'Multiplication: $'
    MSG4 DB 'Devition: $'  
    
    NEWLINE DB 13, 10, '$' 
    
    
    
.CODE
MAIN PROC
    
    MOV AX, @DATA
    MOV DS, AX
       
       
                                      
    
    ; summetion
    MOV AL, N1
    ADD AL, N2 
    MOV BL, AL  
    
    LEA DX, MSG1
    MOV AH, 9
    INT 21H
    
    MOV DL, BL
    ADD DL, '0'
    MOV AH, 2
    INT 21H      
    
    
    ; print newline
    LEA DX, NEWLINE
    MOV AH, 9
    INT 21H
         
         
         
               
               
    ; subtruction
    MOV AL, N1
    SUB AL, N2 
    MOV BL, AL  

    LEA DX, MSG2
    MOV AH, 9
    INT 21H
    
    MOV DL, BL
    ADD DL, '0'
    MOV AH, 2
    INT 21H 
                
                
    ; print newline
    LEA DX, NEWLINE
    MOV AH, 9
    INT 21H
             
             
                
    
    ; multiplication
    MOV AL, N1
    MUL N2 
    MOV BL, AL

    LEA DX, MSG3
    MOV AH, 9
    INT 21H
               
    
    
    ; print double digit   
    MOV AH, 0           
    MOV AL, BL
    MOV BL, 10
    DIV BL
    MOV BL, AL             
    MOV BH, AH            
                              
    MOV DL, BL
    ADD DL, '0'
    MOV AH, 2
    INT 21H   
    
    MOV DL, BH
    ADD DL, '0'
    MOV AH, 2
    INT 21H  
    ;--------------------           
               
    ; print newline
    LEA DX, NEWLINE
    MOV AH, 9
    INT 21H
       
       
       
               
    
    ; devition 
    MOV AH, 0
    MOV AL, N1
    DIV N2 
    MOV BL, AL  

    LEA DX, MSG4
    MOV AH, 9
    INT 21H
    
    MOV DL, BL
    ADD DL, '0'
    MOV AH, 2
    INT 21H     
          
          
          
               
               
    
    MOV AH, 4CH
    INT 21H 

MAIN ENDP
END MAIN
