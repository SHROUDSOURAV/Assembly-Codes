global _start

section .data
	var1: db "Access Granted!!!",10 	; 10 = ascii code for new line -> "\n" used here for better aligned display
	var1_len: equ $-var1


	var2: db "Access Denied!!!",10		; 10 = ascii code for new line -> "\n" used for better aligned display
	var2_len: equ $-var2

	key: db "1789-7654-0987-4532",10
	key_len: equ $-key			; +1 because $-key calculates difference in bytes so 1 is short so I incremented it

section .bss

	input: resb 100

section .text

_start:
	jmp main


main:			;input label
	mov rax, 0	;read syscall/input
	mov rdi, 0
	mov rsi, input
	mov rdx, 100
	syscall

checking:		;label for key and input value checking
	cmp rax, key_len	;rax = length of input string from syscall (main label)
	jne denied

	;cmpsb = compare string byte
	;cmpsb takes 2 registers as arguments rdi and rsi (ONLY!!!)
	;rdi = input string rsi = original key
	;cmpsb only checks first byte
	;so use repe cmpsb <----- compares each byte not only one byte 
	;iterations in repe(repeat) instruction ---> rcx register

	mov rdi, input
	mov rsi, key
	mov rcx, key_len
	repe cmpsb
	je granted
	jne denied


granted:		;access granted label
	mov rax, 1	;write syscall/print
	mov rdi, 1
	mov rsi, var1
	mov rdx, var1_len
	syscall
	jmp exit	;jump to exit label after displaying message

denied:			;access denied label
	mov rax, 1	;write syscall/print
	mov rdi, 1
	mov rsi, var2
	mov rdx, var2_len
	syscall

exit:			;program exit label
	mov rax, 60	;exit syscall/program exit
	mov rdi, 0
	syscall
