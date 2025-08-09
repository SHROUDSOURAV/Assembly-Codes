; writing assembly program to create a table
%include "util.asm" ; this file contains inbuilt functions ; we can use this .asm file to read intgers entered as input and .etc.
global _start

bits 64


section .data
    inputPrompt: db "Enter the number : ",0     ; 0 = null byte to differentiate or work as a breakpoint for separate strings

section .text

    _start:
        ; display input message prompt to user
        mov rdi, inputPrompt
        call printstr   ; calling printstr function to print the input prompt message

        ; take number as input from the user
        call readint    ; returns input number in rax register
        mov [inputNumber], rax     ; store the input number in a variable
            
        ; [inputNumber] instead of inputNumber because
        ; inputNumber is basically a memory address but [inputNumber] means store the value where inputNumber(the memory address) points to 
        ; mov inputNumber, rax basically copies the rax value and overwrites the memory address of the inputNumber which is IMPORTANT!!! 
    
        mov rbx, 1
    
    table_calc:
        mov rcx, [inputNumber]  ; same logic as above ... we are moving value not memory address that is why [] in square brackets
        imul rcx, rbx  ; rcx = rcx x rbx 
        mov rdi, rcx    ; printint requires to pass value to rdi register
        call printint
        call endl   ; prints newline
    
    loop:
        add rbx, 1
        cmp rbx, 11 
        jne table_calc
        call exit0  ; exit the program


section .bss
    inputNumber: resb 8
