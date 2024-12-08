global _start

section .data

	x: db "hello world"

section .text

_start:
	mov rax, 1	;write syscall 
	mov rdi, 1	;file descriptor (fd) stdout
	mov rsi, x	;char *buffer/x variable
	mov rdx, 11	;length/size of x variable/string
	syscall
	
	mov rax, 60	;exit syscall
	mov rdi, 0	;return value arguement
	syscall


