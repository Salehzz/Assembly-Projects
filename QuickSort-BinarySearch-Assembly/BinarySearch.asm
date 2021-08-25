%include "in-out.asm"

section .data
    len   dq      0
    num1  dq      0
section .bss
    input	resb	1024
section .text
    global _start

    
partition:
    mov rax,r8
    add rax,r9
    mov rcx,2
    div rcx
    mov r10,[r12+rax*8]
    mov r13,[num1]
    cmp r10,r13
    jg greater
    jb less
    mov r8,rax
    mov r9,rax
    jmp endpart
greater:
    dec rax
    mov r9,rax
    jmp endpart
less:
    inc rax
    mov r8,rax
endpart:
    ret


binarysearch:
    push rbp
    mov rbp,rsp
    mov r8,[rbp+16]
    ;mov rax,r8
    ;call writeNum
    ;call newLine
    mov r9,[rbp+24]
    ;mov rax,r9
    ;call writeNum
    ;call newLine
    pop rbp
    cmp r8,r9
    jge endd
rec:
    call partition
    push r9
    push r8
    call binarysearch
    ;leave
    pop rax
    pop rax
    ret
endd:
    mov r15,r8
    ;leave
    ret
    
_start:
    mov rax,0
    call readNum
    mov [num1],rax
    mov rax,0
    call readNum
    mov rcx,rax
    mov [len],rax
array:
    mov rax,0
    call readNum
    mov [input+rcx*8],rax
    loop array
    mov rcx,[len]
    mov rbx,1
adad:
    mov rax,[input+rbx*8]
    push rax
    inc rbx
    cmp rcx,rbx
    jge adad
    mov r12,rsp
    mov r9,[len]
    dec r9
    mov r8,0
    push r9
    push r8
    call binarysearch
    mov rcx,[num1]
    cmp rcx,[r12+r15*8]
    jne note
    inc r15
    mov rax,r15
    jmp equal
note:
    mov rax,-1
equal:
    call writeNum
    call newLine
    mov rcx,[len]
print:
    pop rax
    loop print
    pop rax
    pop rax
exit:
    mov rax, 60
    mov rdi, 0
    syscall
