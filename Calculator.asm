%include "util.asm" 
global _start


section .data

	dis1: db "Enter number 1 : ",0
	dis2: db "Enter number 2 : ",0
	dis3: db "Enter operator (+,-,*,/): ",0
	dis4: db "Operation cannot be Performed!!!",0
	error_message: db "Operation cannot be Performed!!!",0
	denominator: db "Denominator cannot be 0",10,0

section .bss

	num1: resb 8	;number1 value
	num2: resb 8	;number2 value
	operator: resb 8	;operator input variable

section .text

_start:
	mov rdi, dis1		;printstr [args1 ---> rdi]
	call printstr		;print dis1
	call readint		;input num1 value stored in rax
	mov [num1], rax		;copy value of rax to empty storage where num1 which is a memory address itself is pointing

	mov rdi, dis2		;printstr [args2 ---> rdi]
	call printstr		;print dis2
	call readint		;input num2 value
	mov [num2], rax		;copy value of rax to empty storage where num2 which is a memory address itslef is pointing

	mov rdi, dis3
	call printstr		;print dis3 message
	mov rdi, operator	;readstr args1 --> rdi = pass address of *buff string(operator variable)
	mov rsi, 2		;readstr args2 --> length of operator variable required
	call readstr

checking:
	mov rdi, [operator]	;moves value pointed by the [operator] address to rdi
	cmp rdi, 43		;43 = ascii value of "+" operator
	je addition
	cmp rdi, 45		;45 = ascii value of "-" operator
	je subtraction
	cmp rdi, 42		;42 = ascii value of "*" operator
	je multiplication
	cmp rdi, 47 	 	;47 = ascii value of "/" operator
	je division

exception:
	mov rdi, error_message
	call printstr
	call endl
	call exit0

addition:
	mov rdi, [num1]
	add rdi, [num2]
	call display

subtraction:
	mov rdi, [num1]
	sub rdi, [num2]
	call display

multiplication:
	mov rdi, [num1]
	imul rdi, [num2]
	call display

division:

	;in division rdx + rax concatenate and then divided so rdx should be set to 0
	;num1 will be taken in rax and divided by rdi
	;idiv rdi = (rdx+rax)/rdi

	mov rdx, 0
	mov rax, [num1]
	mov rdi, [num2]

	cmp rdi, 0	;exception handling checking if denominator == 0
	je handling

	idiv rdi
	mov rdi, rax
	call display

handling:
	mov rdi, denominator
	call printstr
	call endl
	call exit0

display:
	call printint
	call endl
	call exit0
