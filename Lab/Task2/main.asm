%include "io64.inc"

section .data
    T1: dq 0.5
    T2: dq -4
    T3: dq 4
    T4: dq 12

section .text
global CMAIN
CEXTERN access1

CMAIN:
    mov rbp, rsp; for correct debugging
    
    mov rax, __float64__(0.0)
    movq xmm0, rax ;
    mov rdx, 0
    mov r8, 1
    mov r9d, 0
    call access1
    
    xor rax, rax
    ret