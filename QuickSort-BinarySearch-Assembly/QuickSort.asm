%include "in-out.asm"
section .data
    len  	dq	0   
    output	db	' '
section .text
    global _start

partition:
    push rbp
    mov rbp,rsp
    mov r8,[rbp+16]
    mov r9,[rbp+24]
    mov r10,[r12+r9*8]
    lea r13,[r8-1]
    lea r14,[r8-1]
loopp:
    inc r13
    cmp r10,[r12+r13*8]
    jl na
    inc r14
    mov r15,[r12+r14*8]
    xchg r15,[r12+r13*8]
    mov [r12+r14*8],r15
na:
    cmp r13,r9
    jl loopp
    dec r14
    mov [rbp+32],r14
    pop rbp
    ret

quicksort:
    push rbp
    mov rbp,rsp
    mov r8,[rbp+16]
    mov r9,[rbp+24]
    cmp r8,r9
    jge end
rec:
    xor r14,r14
    push r14
    push r9
    push r8
    call partition
    a1:
    mov rbp,rsp
    mov rax,[rbp+16]
    push rax
    mov rax,[rbp]
    push rax
    call quicksort
    ;pop rax
    ;pop rax
    a2:
    mov rbp,rsp
    mov rax,[rbp+8]
    push rax
    mov rax,[rbp+16]
    add rax,2
    push rax
    call quicksort
    ;pop rax
    ;pop rax
    a3:
    pop rax
    pop rax
    pop rax
end:
    pop rbp
    ret 16

_start:
    mov rax,0
    call readNum
    mov [len],rax
    mov rcx,rax
array:
    mov rax,0
    call readNum
    push rax
    loop array
    mov rdi,0
    mov r8,0
    mov r9,[len]
    dec r9
    mov r12,rsp
    push r9
    push r8
    call quicksort
    mov rcx,[len]
print:
    pop rax
    call writeNum
    mov rsi,output
    call printString
    loop print
    call newLine
exit:
    mov rax, 60
    mov rdi, 0
    syscall
