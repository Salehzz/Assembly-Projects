%include "in-out.asm"

section .data
    inputsize	dq	0
    index	dq	0
    javab	dq	0

section .bss
    input	resb	1024

section .text
    global _start

get_input:
    mov rax,0
    mov rdi,0
    mov rsi,input
    mov rdx,1024
    syscall
    dec rax
    mov [inputsize],rax
    ret

readnum:
   push   rcx
   push   rbx
   push   rdx
   mov r12,[index]
   mov    bl,0
   mov    rdx, 0
first:
   xor    rax, rax
   mov    al,[input+r12]
   cmp    al,'/'
   je send1
   cmp    al,'*'
   je send1
   cmp    al,'+'
   je ragain
   cmp    al, '-'
   je manfi
   jmp sagain
manfi:
   mov    bl,1
ragain:
   inc r12
   xor    rax, rax
   mov    al,[input+r12]
   cmp    al,'/'
   je rend
   cmp    al,'*'
   je rend
   cmp    al,'+'
   je rend
   cmp    al, '-'
   je rend
sagain:
   cmp    al, NL
   je     rend
   cmp    al, ' ' ;Space
   je     rend
   sub    rax, 0x30
   imul   rdx, 10
   add    rdx,  rax
   xor    rax, rax
   jmp ragain
rend:
   mov [index],r12
   mov    rax, rdx 
   cmp    bl, 0
   je     send
   neg    rax
   jmp send
send1:
   inc r12
   mov [index],r12
send:  
   pop    rdx
   pop    rbx
   pop    rcx
   ret


taqsim:
    mov r14,1
    mov r15,1
    mov r9,r8
    mov r13,0
    cmp r9,0
    je taqend
    jg smaller
    mov r14,0
    neg r9
smaller:
    cmp r10,0
    je taqend
    jg bigger
    mov r15,0
    neg r10
bigger:
    cmp r9,r10
    jg taqend
    inc r13
    sub r10,r9
    jmp bigger
taqend:
    cmp r14,1
    je mosbat
    neg r13
mosbat:
    cmp r15,1
    je mosbat1
    neg r13
mosbat1:
    ret


zarb:
    mov r14,1
    mov r9,r8
    mov r13,0
    mov rcx,r9
    cmp rcx,0
    je zend
    jg nots
    mov r14,0
    neg rcx
nots:
    add r13,r10
    loop nots
    cmp r14,1
    je zend
    neg r13
zend:
    ret


calculator:
    mov r12,1
    mov rax,-123456789123456789
    cmp r9,rax
    je na
    cmp r10,rax
    je na
    mov rax,'/'
    cmp r9,rax
    jne zarbb
    call taqsim
    jmp calend
zarbb:
    mov rax,'*'
    cmp r9,rax
    jne na
    call zarb
    jmp calend
na:
    mov r12,0
calend:
    ret


_start:
    mov rdi,0
    mov rax,0
    mov rsi,0
    mov rdx,0
    mov rbx,0
    mov rcx,0
    mov r8,0
    mov r9,0
    mov r10,0
    mov r11,0
    mov r13,0
    mov r14,0
    mov r15,0
    mov [inputsize],rax
    mov [index],rax
    call get_input
    mov al,[input]
    cmp al,'$'
    je exit
    mov rax,-123456789123456789
    push rax
    push rax
    mov rax,0
    mov al,[input]
    sub rax,0x30
    cmp rax,0
    jge khandanadad
    mov rax,[javab]
    push rax
khandanadad:
    mov rax,[inputsize]
    mov rbx,[index]
    cmp rbx,rax
    jge tamam
    mov rax,0
    call readnum
    push rax
    pop r8
    pop r9
    pop r10
    call calculator
    cmp r12,1
    je bale
    push r10
    push r9
    push r8
    jmp khandanadad
bale:
    push r13
    jmp khandanadad
tamam:
    mov r8,0
    mov rbx,-123456789123456789
endofstring:
    mov rax,0
    pop rax
    cmp rax,rbx
    je endd
    add r8,rax
    jmp endofstring
endd:
    pop rax
    mov [javab],r8
    mov rax,r8
    call writeNum
    call newLine
    jmp _start
exit:
    mov rax,60
    mov rbx,0
    syscall
