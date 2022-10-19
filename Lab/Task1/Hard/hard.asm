;---------------------------
; original file: 
; https://github.com/eeeeagle/LLP_1/blob/main/main.asm
;---------------------------

%include "io64.inc"

global CMAIN
CEXTERN print
CEXTERN scanf
CEXTERN malloc
CEXTERN free

segment .rodata
        FORMAT_SCAN:    db "%d",0
        FORMAT_PRINT:   db "[%d] = %d",13,10,0
        SORTED_STR:     db "-------------SORTED ARRAY-------------",10,0
        
segment .data
        SIZE:    dq 0
        TEMP:    dq 0
        ARRAY:   dq 0        

segment .text
CMAIN:
       	push rbp
	mov rbp, rsp
	sub rsp, 8
        
        sub rsp, 16
        mov rdx, SIZE
        mov rcx, FORMAT_SCAN
        mov al, 0
        call scanf
        add rsp, 16

        mov rax, [SIZE]
        mov rbx, 8 
        mul rbx
        add rax, 8
        
        sub rsp, 8
        mov rcx, rax
        mov al, 0
        call malloc 
        add rsp,8
        
        mov qword[ARRAY], rax
        
	call INPUT   
                
        call SORT               
        call PRINT               

        mov rcx, qword[ARRAY]
        mov al, 0
        call free 
        add rsp,8      
	
	xor rax, rax
	ret



INPUT:        
	push rbp
	mov rbp,rsp
	sub rsp,8
        
        mov rsi, ARRAY
        mov rdi, 0      
        jmp .INPUT_2
        
    .INPUT_1:
        sub rsp, 16
        mov rdx, TEMP
        mov rcx, FORMAT_SCAN
        mov al, 0
        call scanf
        add rsp, 16

        mov rax, [TEMP]
        mov [rsi], rax
        add rsi, 8
        
        inc rdi
                      
    .INPUT_2:
        mov rcx, rdi
	cmp rcx,[SIZE]
    	jl .INPUT_1
        			
	mov rsp,rbp
        pop rbp
	ret
       



PRINT:
	push rbp
	mov rbp,rsp
        
        mov rsi, ARRAY
        mov rdi,0
        
        sub rsp, 8
        mov rcx, SORTED_STR
        mov al, 0
        call printf
        add rsp, 8
        
        jmp .PRINT_2
        
	sub rsp,8

    .PRINT_1:
        sub rsp, 24
        mov r8, [rsi]
        mov rdx, rdi
        mov rcx, FORMAT_PRINT
        mov al, 0
        call printf
        add rsp, 24
        
        add rsi,8
        inc rdi      
             
    .PRINT_2:
        mov rcx, rdi
	cmp rcx,[SIZE]
    	jl .PRINT_1

	mov rsp,rbp
	pop rbp
	ret        



SORT:
	push rbp
	mov rbp,rsp
	sub rsp,8
                
	mov r8,0 ; i = 0
        mov rsi, ARRAY
        jmp .SORT_5
        
    .SORT_1:
        mov rcx,r8 ; min_index = i
        
        mov r9,r8 ; j = i
        inc r9
        
        jmp .SORT_4
        
    .SORT_2:
        mov rax,[ARRAY+8*r9]
        mov rbx,[ARRAY+8*rcx]    
        
        cmp rax, rbx
        jge .SORT_3
        mov rcx,r9   
                                                    
    .SORT_3:
        inc r9
        
    .SORT_4:
   	cmp r9, [SIZE] ; j < size
        jl .SORT_2
        
        mov rax,[ARRAY+8*r8]                      
        mov rbx,[ARRAY+8*rcx]
        
        xchg rax, rbx
        
        mov [ARRAY+8*r8], rax                      
        mov [ARRAY+8*rcx], rbx
  
        inc r8
        
     .SORT_5:
        cmp r8, [SIZE] ; i < size
        jl .SORT_1

        mov rsp,rbp
	pop rbp
	ret