global _start

bits 64

; NOTE : input includes newline so if key matches the original key still Access denied
; run the program using echo -n <userKey> | ./license_check

section .data

    inputPrompt: db "Enter the key : ",10
    promptLen: equ $ - inputPrompt
    access: db "Access Granted!!!", 10  ; 10 = ASCII code for newline
    access_length: equ $ - access
    denied: db "Access Denied!!!", 10   ; 10 = ASCII code for newline
    denied_length: equ $ - denied
    access_key: db "1789-7654-0987-4532"
    access_key_length: equ $ - access_key

section .text

    _start:
        jmp input_prompt
    
    input_prompt:
        ; display input prompt message
        mov rax, 1
        mov rdi, 1
        mov rsi, inputPrompt
        mov rdx, promptLen
        syscall

    input:
        ; taking input 
        mov rax, 0
        mov rdi, 0
        mov rsi, key
        mov rdx, 64
        syscall
        mov rbx, rax    ; store entered input key length in rbx register

    compare_key:
        ; check license key
        cmp rbx, access_key_length  ; cmp instruction only works with integers .... so for string we need to use cmpsb
        jne access_denied
        ; to compare two strings we need to use cmpsb
        ; cmpsb checks 2 registers during comparson => rdi and rsi registers
        ; cmpsb only compares the first byte of the string
        ; we original key i.e the key we are comparing with needs to be in rsi register
        ; the input key i.e our key which we are comparing with the original key needs to be in rdi register
        mov rsi, access_key
        mov rdi, key    ; after comparsion of each byte the new string is loaded leaving of the compared byte
        mov rcx, access_key_length  ; repeat performing repe cmpsb for rcx amount of iterations since rcx is used for looping
        repe cmpsb  ; repe cmpsb basically means to repeat the comparison of bytes between rsi and rdi
        je access_granted
        jne access_denied

    access_granted:
        ; display access granted message
        mov rax, 1
        mov rdi, 1
        mov rsi, access
        mov rdx, access_length
        syscall
        jmp exit_program

    access_denied:
        ; display access denied message
        mov rax, 1
        mov rdi, 1
        mov rsi, denied
        mov rdx, denied_length
        syscall
        jmp exit_program
    
    exit_program:
        ; exit the program
        mov rax, 60
        mov rdi, 0
        syscall

section .bss
    
    key: resb 64    ; reserving 64 bytes