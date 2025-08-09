global _start

bits 64 ; 64 bit registers used

section .data
    inputMsg: db "Enter your name : "
    inputMsgLen: equ $ - inputMsg   ; shortcut way to find the length of the string(inputMsg)
    helloMsg: db "Hello, "
    helloMsgLen: equ $ - helloMsg   ; shortcut way to find the length of the string(welcome message)


section .text       ; assembly code section

    _start:
        ; call is used to call the below labels, execute the label section code and return
        call inputPrompt
        call user_input
        call helloMessage
        call displayInput
        call exit_program

    inputPrompt:
        ; display user input message
        mov rax, 1
        mov rdi, 1
        mov rsi, inputMsg
        mov rdx, inputMsgLen
        syscall
        ret ; ret statement helps the call statement to return back to the point from where it was called
    
    user_input:
        ; take user input 
        mov rax, 0  ; system call for read 
        mov rdi, 0  ; fd = file descriptor (args 1) 0 = stdin (standard input)
        mov rsi, input
        mov rdx, 100
        syscall
        ; when user input is supplied and system call is done 
        ; the length of the user input is returned in the rax register we will store it in another register for future usage
        mov rcx, rax    ; storing user input length
        ret

    helloMessage:
        ; display hello message in the output screen
        mov rax, 1
        mov rdi, 1
        mov rsi, helloMsg
        mov rdx, helloMsgLen
        syscall
        ret

    displayInput:
        ; display input message in output screen
        mov rax, 1
        mov rdi, 1
        mov rsi, input
        mov rdx, rcx    ; copying user input length to rdx (check label => user_input)
        syscall
        ret

    exit_program:
        ; exit program to prevent segmentation fault errors
        mov rax, 60 ; calling exit syscall
        mov rdi, 0  ; exit status code
        syscall
        
    
section .bss    ; assembly user input variable declaration section

    input: resb 100     ; reserving(resb) 100 bytes

    
; argument 1 Register = rdi
; argument 2 Register = rsi
; argument 3 Register = rdx