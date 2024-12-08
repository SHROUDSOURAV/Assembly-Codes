global _start

section .data	;declared/initialized variables section

	dis: db "Enter your name : "
	len1: equ $-dis		;$-dis (dis = 'enter your name' variable) and $-dis = calculates length of dis string variable

section .text	;assembly code section

_start:
	mov rax, 1	;write syscall
	mov rdi, 1 	;stdout argument 1 (fd = file descriptor)
	mov rsi, dis	;variable argument 2	(char *buffer)
	mov rdx, len1	;length argument 3	(size/length of string)
	syscall

input:
	mov rax, 0	;read syscall
	mov rdi, 0	;stdin argument 1	(fd = file descriptor)
	mov rsi, str	;variable argument 2 (char *buffer)
	mov rdx, 50	;length argument 3 (size/length of string)
	syscall		;syscall always returns some values which is present in rax register(here the length of user input string)
	mov rcx, rax	;storing length of str present in rax to rcx since we dont know user input string length

print:
	mov rax, 1
	mov rdi, 1
	mov rsi, str
	mov rdx, rcx
	syscall

exit:
	mov rax, 60	;exit syscall
	mov rdi, 0 	;return value arguement 1
	syscall

section .bss	;user input/unknown input variables section

	str: resb 50 	;resb = resever bytes, 50 = size of the reservation(i.e 50 bytes) (i.e str variable will store bytes only)
