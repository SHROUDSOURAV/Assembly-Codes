%include "util.asm"

global _start

bits 64


section .data
    num1Prompt: db "Enter the number 1 : ", 0
    num2Prompt: db "Enter the number 2 : ", 0
    operatorPrompt: db "Enter operator (+, -, *, /) : ", 0
    errorMsg: db "Denominator cannot be 0", 0
    invalidOperator: db "Operation cannot be performed!!!", 0

section .text

    _start:
        ; show num1 input prompt
        mov rdi, num1Prompt
        call printstr
        ; take number1 input
        call readint
        mov [num1], rax
        
        ; show num2 input prompt
        mov rdi, num2Prompt
        call printstr
        ; take number2 input
        call readint
        mov [num2], rax

        ; show operator input prompt
        mov rdi, operatorPrompt
        call printstr
        ; take operator input
        mov rdi, operator
        mov rsi, 2
        call readstr

        jmp compare_operators


    compare_operators:
        ; comparing operators with +, -, *, /
        mov rdi, [operator]
        ; conversion from string to int happens during comparison
        ; we are comparing the ascii value based on the operator passed as input
        cmp rdi, 43 ; 43 = ascii value of plus  
        je addition
        cmp rdi, 45 ; 45 = ascii value of subtraction
        je subtraction
        cmp rdi, 42 ; 42 = ascii value of multiplication
        je multiplication
        cmp rdi, 47 ; 47 = ascii value of division
        je division
        jne invalid_operator

    invalid_operator:
        mov rdi, invalidOperator
        call printstr
        jmp exit_program

    addition:
        mov rax, [num1]
        mov rbx, [num2]
        add rax, rbx
        mov rdi, rax
        jmp display_result
    
 
    subtraction:
        mov rax, [num1]
        mov rbx, [num2]
        sub rax, rbx
        mov rdi, rax
        jmp display_result
    

    multiplication:
        mov rax, [num1]
        mov rbx, [num2]
        imul rax, rbx 
        mov rdi, rax
        jmp display_result


    division:
        mov rdx, 0  ; check idiv logic in maths folder to understand the logic of this line
        mov rbx, [num2] ; denominator
        cmp rbx, 0  ; exception checking if denominator is 0 
        je error_handling
        mov rax, [num1] ; numerator
        idiv rbx
        mov rdi, rax
        jmp display_result


    error_handling:
        mov rdi, errorMsg
        call printstr
        jmp exit_program

 
    display_result:
        call printint
        jmp exit_program

 
    exit_program:
        ; exit program
        call endl
        call exit0        


section .bss
    num1: resb 8
    num2: resb 8
    operator: resb 2