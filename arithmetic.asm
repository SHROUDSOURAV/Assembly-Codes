global main

section .text

main:
	mov rax, 10
	add rax, 5	;addition operation

	mov rax, 8
	sub rax, 8	;subtraction operation

	;imul for signed multiplication operation
	mov rax, 10
	imul rax, rax, 10	;imul takes 3 arguments .... first argument = storing result(destination)

	;idiv for sined division operation
	;rdx+rax values concatenate which is then divided by numerator register given by us
	; for eg -> if rdx = 3 and rax = 9 and numerator register = 5 so... 39/5 will happen...

	mov rdx, 0	;keeping rdx = 0 explanation above
	mov rax, 50	;rax register for storing numerator(mandatory!!! or compulsory!!!)
	mov rdi, 5		;rax and rdx register cannot be used for denominator purposes in signed division operation
	idiv rdi		;idiv <register> except rax,rdx divides rax i.e. idiv <regiser1> = rax/<regiser1>

exit:
	mov rax, 60
	mov rdi, 0
	syscall
