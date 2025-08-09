global _start       ; this tells the assembly code to start the program execution from the _start label

bits 64 ; this line tells the assembler that we are writing a 64-bit assembly program

section .data   ; section .data => stores all the initialized variables
    hello: db "Hello World"

section .text       ; assembly code is written in the section .text section
    ; _start: is basically the starting or entry point of the program
    _start:
        ; writing a assembly program to print "Hello World"
        ; to do that we need to use the write syscall
        ; the write syscall basically will tell the kernel to print the "Hello World" in the terminal
        ; for using the write syscall we need certain arguments
        ;========================================================
        ; fd = file descriptor, which is 1 for stdout
        ; buffer_variable = stores the "Hello World" string
        ; length = stores the length of the string

        mov rax, 1  ; we always pass the syscall number to rax (1 = syscall number for write)
        mov rdi, 1  ; file descriptor argument for stdout(standard output) => argument 1
        mov rsi, hello ; buffer_variable argument => argument 2
        mov rdx, 11  ; length of the string "Hello World" => argument 3
        syscall

        mov rax, 60 ; syscall number for exit
        mov rdi, 0  ; status code = 0 (args 1)
        syscall ; exit syscall called (required to prevent segmentation fault error) because with exit syscall program won't know when to exit

; assemble the code -> nasm -f elf64 <assembly code file> -o <object code file> 
; linking the file -> ld <object code file> -o <executable file>    => required to load libraries required to run a program
; executing the binary -> ./<executable file>   => execute the main binary file



; argument 1 Register = rdi
; argument 2 Register = rsi
; argument 3 Register = rdx