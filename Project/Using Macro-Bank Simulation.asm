.MODEL SMALL
.STACK 100H

; ==================== MACRO DEFINITIONS ====================

; Macro to display a string
DISPLAY_STRING MACRO msg
    LEA DX, msg
    MOV AH, 9
    INT 21H
ENDM

; Macro to display a newline
NEWLINE MACRO
    DISPLAY_STRING NL
ENDM

; Macro to read a single character (for menu choice)
READ_CHAR MACRO
    MOV AH, 1
    INT 21H
ENDM

; Macro to read multi-digit number (returns in AX)
READ_NUMBER MACRO
    CALL READ_AMOUNT
ENDM

; Macro to print a number (from AX)
PRINT_NUMBER MACRO
    CALL PRINT_NUM
ENDM

; Macro for PIN verification
VERIFY_PIN MACRO
    LOCAL pin_correct, pin_exit
    PUSH AX
    
    DISPLAY_STRING ENTER_PIN_MSG
    READ_NUMBER
    MOV ENTERED_PIN, AX
    
    MOV AX, PIN
    CMP AX, ENTERED_PIN
    JE pin_correct
    
    NEWLINE
    DISPLAY_STRING WRONG_PIN_MSG
    JMP START
    
pin_correct:
    POP AX
ENDM

; Macro for checking if account exists
CHECK_ACCOUNT_EXISTS MACRO
    LOCAL no_account
    MOV AX, BALANCE
    CMP AX, 0
    JE no_account
    JMP no_account_exit
    
no_account:
    NEWLINE
    DISPLAY_STRING INVALID_MSG
    JMP START
    
no_account_exit:
ENDM

; Macro for checking minimum balance
CHECK_MIN_BALANCE MACRO
    LOCAL min_ok, min_error
    CMP AX, MIN_BAL
    JGE min_ok
    
min_error:
    NEWLINE
    DISPLAY_STRING MIN_BAL_MSG
    JMP CREATE_ACC
    
min_ok:
ENDM

; Macro for checking sufficient balance
CHECK_SUFFICIENT_BALANCE MACRO amount_reg, balance_reg
    LOCAL sufficient, insufficient
    CMP amount_reg, balance_reg
    JLE sufficient
    
insufficient:
    NEWLINE
    DISPLAY_STRING INSUFFICIENT
    JMP START
    
sufficient:
ENDM

; ==================== DATA SECTION ====================

.DATA
HEADING     DB '*****BANK MANAGEMENT SYSTEM*****',10,13,'$'
MENU_TITLE  DB 'MAIN MENU',10,13,'$'
OPTION1     DB '1. CREATE NEW ACCOUNT',10,13,'$'
OPTION2     DB '2. DEPOSIT MONEY',10,13,'$'
OPTION3     DB '3. WITHDRAW MONEY',10,13,'$'
OPTION4     DB '4. CHECK BALANCE',10,13,'$'
OPTION5     DB '5. TRANSFER MONEY',10,13,'$'
OPTION6     DB '6. EXIT',10,13,'$'
CHOICE_MSG  DB 'ENTER YOUR CHOICE: $'

ACC_NUM_MSG DB 'YOUR ACCOUNT NUMBER IS: $'
INIT_DEP_MSG DB 'ENTER INITIAL DEPOSIT (MIN 500): $'
DEPOSIT_MSG DB 'ENTER DEPOSIT AMOUNT: $'
WITHDRAW_MSG DB 'ENTER WITHDRAW AMOUNT: $'
BALANCE_MSG DB 'YOUR BALANCE IS: $'
NEW_BAL_MSG DB 'NEW BALANCE: $'
TRANSFER_MSG DB 'ENTER AMOUNT TO TRANSFER: $'
TO_ACC_MSG  DB 'ENTER RECEIVER ACCOUNT NUMBER: $'
TRANSFER_SUCCESS DB 'TRANSFER SUCCESSFUL!',10,13,'$'
TRANSFER_FAIL DB 'TRANSFER FAILED!',10,13,'$'

SUCCESS_MSG DB 'OPERATION SUCCESSFUL!',10,13,'$'
ACC_CREATED DB 'ACCOUNT CREATED!',10,13,'$'
INSUFFICIENT DB 'INSUFFICIENT BALANCE!',10,13,'$'
INVALID_MSG DB 'INVALID! TRY AGAIN.',10,13,'$'
MIN_BAL_MSG DB 'MINIMUM 500 REQUIRED!',10,13,'$'
THANK_MSG   DB 'THANK YOU!',10,13,'$'

PIN_MSG       DB 'SET YOUR 4-DIGIT PIN: $'
ENTER_PIN_MSG DB 'ENTER YOUR PIN: $'
WRONG_PIN_MSG DB 'WRONG PIN!',10,13,'$'

PIN          DW 0
ENTERED_PIN  DW 0

NL          DB 10,13,'$'

ACC_NUMBER  DW 100
BALANCE     DW 0
AMOUNT      DW 0
TEMP        DW 0
MIN_BAL     DW 500

; For transfer
RECEIVER_ACC1 DW 1001
RECEIVER_BAL1 DW 2000

; ==================== CODE SECTION ====================

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

START: 
    ; Display main menu using macros
    DISPLAY_STRING HEADING
    NEWLINE
    DISPLAY_STRING MENU_TITLE
    DISPLAY_STRING OPTION1
    DISPLAY_STRING OPTION2
    DISPLAY_STRING OPTION3
    DISPLAY_STRING OPTION4
    DISPLAY_STRING OPTION5
    DISPLAY_STRING OPTION6
    NEWLINE
    DISPLAY_STRING CHOICE_MSG
    
    ; Read menu choice
    READ_CHAR
    
    ; Process menu choice
    CMP AL, '1'
    JE CREATE_ACC
    CMP AL, '2'
    JE DEPOSIT
    CMP AL, '3'
    JE WITHDRAW
    CMP AL, '4'
    JE CHECK_BAL
    CMP AL, '5'
    JE TRANSFER_MONEY
    CMP AL, '6'
    JE EXIT_PROG
    JMP INVALID

CREATE_ACC:
    NEWLINE
    DISPLAY_STRING ACC_NUM_MSG
    
    ; Display account number
    MOV AX, ACC_NUMBER
    PRINT_NUMBER
    INC ACC_NUMBER
    
    NEWLINE
    DISPLAY_STRING PIN_MSG
    READ_NUMBER
    MOV PIN, AX
    
    NEWLINE
    DISPLAY_STRING INIT_DEP_MSG
    READ_NUMBER
    MOV AMOUNT, AX
    
    ; Check minimum balance using macro
    CHECK_MIN_BALANCE
    
    MOV BALANCE, AX
    
    NEWLINE
    DISPLAY_STRING ACC_CREATED
    
    JMP START

DEPOSIT:
    NEWLINE
    
    ; Check if account exists
    CHECK_ACCOUNT_EXISTS
    
    DISPLAY_STRING DEPOSIT_MSG
    READ_NUMBER
    MOV AMOUNT, AX
    
    CMP AX, 0
    JLE INVALID_AMT
    
    ; Verify PIN using macro
    VERIFY_PIN
    
    ; Process deposit
    ADD BALANCE, AX
    
    NEWLINE
    DISPLAY_STRING SUCCESS_MSG
    DISPLAY_STRING NEW_BAL_MSG
    
    MOV AX, BALANCE
    PRINT_NUMBER
    NEWLINE
    
    JMP START

WITHDRAW:
    NEWLINE
    
    ; Check if account exists
    CHECK_ACCOUNT_EXISTS
    
    DISPLAY_STRING WITHDRAW_MSG
    READ_NUMBER
    MOV AMOUNT, AX
    
    CMP AX, 0
    JLE INVALID_AMT
    
    MOV BX, BALANCE
    
    ; Check sufficient balance using macro
    CHECK_SUFFICIENT_BALANCE AX, BX
    
    ; Verify PIN using macro
    VERIFY_PIN
    
    ; Process withdrawal
    SUB BX, AX
    MOV BALANCE, BX
    
    NEWLINE
    DISPLAY_STRING SUCCESS_MSG
    DISPLAY_STRING NEW_BAL_MSG
    
    MOV AX, BALANCE
    PRINT_NUMBER
    NEWLINE
    
    JMP START

TRANSFER_MONEY:
    NEWLINE
    
    ; Check if account exists
    CHECK_ACCOUNT_EXISTS
    
    DISPLAY_STRING TO_ACC_MSG
    READ_NUMBER
    MOV TEMP, AX
    
    NEWLINE
    DISPLAY_STRING TRANSFER_MSG
    READ_NUMBER
    MOV AMOUNT, AX
    
    CMP AX, 0
    JLE TRANSFER_ERROR
    
    MOV BX, BALANCE
    
    ; Check sufficient balance using macro
    CHECK_SUFFICIENT_BALANCE AX, BX
    
    ; Check receiver account
    MOV AX, TEMP
    CMP AX, RECEIVER_ACC1
    JNE TRANSFER_ERROR
    
    ; Verify PIN using macro
    VERIFY_PIN
    
    ; Process transfer
    MOV AX, AMOUNT
    SUB BALANCE, AX
    ADD RECEIVER_BAL1, AX
    
    NEWLINE
    DISPLAY_STRING TRANSFER_SUCCESS
    DISPLAY_STRING NEW_BAL_MSG
    
    MOV AX, BALANCE
    PRINT_NUMBER
    NEWLINE
    
    JMP START

CHECK_BAL:
    NEWLINE
    
    ; Check if account exists
    CHECK_ACCOUNT_EXISTS
    
    ; Show PIN message and read PIN
    DISPLAY_STRING ENTER_PIN_MSG
    READ_NUMBER
    MOV ENTERED_PIN, AX
    
    MOV AX, PIN
    CMP AX, ENTERED_PIN
    JNE WRONG_PIN_BAL
    
    ; Show balance
    DISPLAY_STRING BALANCE_MSG
    MOV AX, BALANCE
    PRINT_NUMBER
    NEWLINE
    
    JMP START

; =============== ERROR HANDLING ===============

INVALID_AMT:
    NEWLINE
    DISPLAY_STRING INVALID_MSG
    JMP START

TRANSFER_ERROR:
    NEWLINE
    DISPLAY_STRING TRANSFER_FAIL
    JMP START

WRONG_PIN_BAL:
    NEWLINE
    DISPLAY_STRING WRONG_PIN_MSG
    JMP START

INVALID:
    NEWLINE
    DISPLAY_STRING INVALID_MSG
    JMP START

EXIT_PROG:
    NEWLINE
    DISPLAY_STRING THANK_MSG
    MOV AH, 4CH
    INT 21H

; =============== PROCEDURES ===============

; Procedure to print number (from AX)
PRINT_NUM PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX

    MOV CX, 0
    MOV BX, 10

    CMP AX, 0
    JNE CONVERT_LOOP
    MOV DL, '0'
    MOV AH, 2
    INT 21H
    JMP PRINT_DONE

CONVERT_LOOP:
    MOV DX, 0
    DIV BX
    PUSH DX
    INC CX
    CMP AX, 0
    JNE CONVERT_LOOP

PRINT_LOOP:
    POP DX
    ADD DL, '0'
    MOV AH, 2
    INT 21H
    LOOP PRINT_LOOP

PRINT_DONE:
    POP DX
    POP CX
    POP BX
    POP AX
    RET
PRINT_NUM ENDP

; Procedure to read multi-digit number (returns in AX)
READ_AMOUNT PROC
    PUSH BX
    PUSH CX
    PUSH DX
    
    MOV BX, 0
    
READ_CHAR_LOOP:
    MOV AH, 1
    INT 21H
    
    CMP AL, 13
    JE DONE_READING
    
    CMP AL, '0'
    JB DONE_READING
    CMP AL, '9'
    JA DONE_READING
    
    SUB AL, '0'
    MOV AH, 0
    
    PUSH AX
    MOV AX, BX
    MOV CX, 10
    MUL CX
    MOV BX, AX
    POP AX
    
    ADD BX, AX
    JMP READ_CHAR_LOOP
    
DONE_READING:
    MOV AX, BX
    
    POP DX
    POP CX
    POP BX
    RET
READ_AMOUNT ENDP

END MAIN