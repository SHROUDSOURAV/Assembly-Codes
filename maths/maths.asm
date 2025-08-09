global main

bits 64

section .text

    main:
        mov rax, 2  
        add rax, 3  ; adding 3 to rax register i.e rax = rax + 3

        mov rax, 2
        sub rax, 2  ; subtracting 2 from rax register i.e rax = rax - 2

        mov rax, 6
        imul rbx, rax, 2  ; multiplying 2 with rax register
                          ; we need to store the result in a register that is why it requires 3 arguments
                          ; rax multiplied by 2 and result stored in rbx register
        
        
        ; idiv has certain conditions 
        ; idiv requires us to store the numerator in rax register so we need to store the numerator in rax register beforehand
        ; the denominator can be stored in any register except for rax and rdx register
        ; make sure to set rdx = 0 because during division the numerator becomes rax + rdx (concatenates and forms numerator)
        ; so if rax = 1 rdx = 1 => so numerator = 11(rax + rdx)
        mov rdx, 0  ; rdx = 0 done because of the above reasonse
        mov rax, 100
        mov rbx, 2
        idiv rbx    ; basically means rax divided by rbx i.e 100(rax)-> numerator / 2(rbx)-> denominator
                    ; the idiv result is stored in rax register
        
    exit_program:
        ; exit system call label
        mov rax, 60
        mov rdi, 0
        syscall



        


