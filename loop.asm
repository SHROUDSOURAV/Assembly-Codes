%include "util.asm"	;assembly code using loop to print table of a number
global _start		;NOTE --> you can download the "util.asm" from github

;numbers cannot be taken directly in read and write operations in assembly <------ IMPORTANT!!!

section .text

_start:
	mov rdi, var1	; the util.asm file states to move *buff string to rdi and string should have null terminator(0)
	call printstr	; calls printstr function in "util.asm" and value should be stored in rdi register (args1 = rdi)
	call readint	; converts value in string to integer using "atoi" and value is stored in rax register (args1 = rax)

	mov [num], rax	; copies value of rax to the empty space where num is pointing since num is an address itself and we should not interfere with it
			;multiplication requires 2 registers (any 2)
	mov rcx, 1	;written outside loop to avoid repeatition

LOOP_TABLE:
	mov rdx, [num]
	imul rdx, rcx

	push rcx	;pushing rcx value into the stack to preserve its value so that if other function calls alter rcx value 
			;we can pop the previous rcx value from the stack without any problem
	mov rdi, rdx
	call printint	;printint (args1 = rdi)
	call endl	;newline (no args)
	pop rcx		;preserving value of rcx in stack

	add rcx, 1
	cmp rcx, 11

	jne LOOP_TABLE
	call exit0	;calls exit function and program exits


section .data

        var1: db "Enter the Number : "	        ; 0 = null byte (terminates string) shows ending point of string
                                                ; without null byte(0) the assembly might not know the ending point of the string
                                                ; 10 = ascii value for newline "\n"
section .bss

       num: resb 8                             ;for storing the value of rax in readint(since we dont know userinput value)
                                                ;8 bytes = 64 bits max value for rax register
