%include "in-out.asm"
section .data
  directory      db   "/home/saleh/Desktop/image",0
  directory2     db  "/home/saleh/Desktop/newimage",0
  FDinput        dq  0
  FDoutput       dq  0
  FD             dq  0

  suces_get     dq  "get image succesfully",NewLine,0
  error_get     dq  "error in getting",NewLine,0
  suces_write   dq  "written succesfully",NewLine,0
  error_write   dq  "error in writing",NewLine,0
  suces_chdir   dq  "directory changed succesfully",NewLine,0
  error_chdir   dq  "error in change directory",NewLine,0
  n             dd   0
  mem           dq   0
  sizeofimage   dq   0
  id            dq   0
  endofimages   dq   0

  sys_getdents  equ 78
  sys_chdir  equ  80
  sys_getdents64 equ  217

  O_directory equ  0q0200000

  NewLine    equ  0xA
section .bss
    imagename  resb  1024
    memory     resb  1024
section .text
    global _start

memalloc:
    mov rax,9
    mov rsi,1000000
    mov rdx,0x3
    mov r10,0x22
    syscall
    ret

memfree:
    mov rax,11
    mov rsi,1000000
    mov rdi,[mem]
    syscall
    ret

createFile:                  ;rdi = file name, rsi = file permission
  mov  rax, sys_create
  mov  rsi, 0q700
  syscall
  ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

openFile:                  ;rdi = file name, rsi = file access mode
  mov  rax, sys_open
  mov  rsi, O_RDWR
  syscall
  ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

appendFile:
  mov  rax, sys_open
  mov  rsi, O_RDWR | O_APPEND
  syscall

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

writeFile:                  ;rdi = file descriptor, rsi = buffer, rdx=length
	mov  rax, sys_write
	syscall
	cmp rax,-1
	jle err
	mov rsi,suces_write
	call printString
	ret
err:
	mov rsi,error_write
	call printString
	ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

readFile:                  ;rdi = file descriptor, rsi = buffer, rdx = length
  mov  rax, sys_read
  syscall
  ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

closeFile:                  ;rdi = file descriptor
  mov  rax, sys_close
  syscall
  ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

seekFile:                  ;rdi = file descriptor, rsi = offset, rdx = whence
  mov  rax, sys_lseek
  syscall
  ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
changedir:
	mov  rax, sys_chdir
	syscall
	cmp rax,-1
	jle err1
	mov rsi,suces_chdir
	call printString
	ret
err1:
	mov rsi,error_chdir
	call printString
	ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

getdirectory:
	mov rax,sys_getdents
	syscall
	jle err2
	mov rsi,suces_get
	call printString
	ret
err2:
	mov rsi,error_get
	call printString
	ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; esm aks ha
getnames:
mov rdi,directory
mov rax,sys_open
mov rsi,O_RDONLY|O_directory
syscall
mov [FD],rax
mov rax,sys_getdents64
mov rdi,[FD]
mov rsi,memory
mov rdx,1000
syscall
ret
; tedad aks ha
getnumberofimages:
  mov bl,0
  mov r15,0
  mov rax,0
  mov r8,0
  mov r10,memory
  mov r9,1000
doo2:
  dec r9
  mov al,[r10+r9]
  cmp al,bl
  je doo2
  inc r9
  mov [endofimages],r9
doo:
  mov r12,r8
  add r8,16
  mov r13,0
  add r13w,word[r10+r8]
  add r12,r13
  mov r8,r12
  inc r15
  cmp r8,r9
  jl doo
  dec r15
  dec r15
  ret
; gereftan tak tak esm be tartib
getnextname:
  mov r11,imagename
  mov r9,-1
do:
  inc r9
  cmp r9,999
  mov byte[r11+r9],0
  jne do
  mov r8,[id]
  mov r10,memory
  ;add r8,19
  mov r12,[id]
  mov r13,0
  mov r9,0
  mov bl,0
  add r8,16
  add r13w,word[r10+r8]
  add r12,r13
do2:
  add r8,3
do1:
  mov al,[r10+r8]
  mov byte[r11+r9],al
  inc r9
  inc r8
  cmp r8,r12
  jb do1
  add r8,0
  mov [id],r8
  mov rax,1
  mov rdi,1
  mov rsi,imagename
  mov rdx,50
  syscall
  ret
  
_start:
    ;call memalloc
    ;mov r15,rax
    call readNum
    cmp rax,0
    jg bigger
    neg rax
    neg eax
bigger:
    mov [n],eax
    mov rdi,directory
    call changedir
    call  getnames
    ; r15 = numbers of pictures
    call memalloc
    mov [mem],rax
    xor rax,rax
    call getnumberofimages
pics:
    push r15
    call getnextname
    mov   rdi,directory
    call  changedir
    mov   rdi,imagename
    call  openFile
    mov   [FDinput],rax
    mov   rdi,directory2
    call  changedir
    mov   rdi,imagename
    call  createFile
    mov   [FDoutput],rax
    ;size image
    mov rax,8
    mov rdi,[FDinput]
    mov rsi,0
    mov rdx,2
    call seekFile
    
    mov rbx,rax
    mov rax,8
    mov rdi,[FDinput]
    mov rsi,0
    mov rdx,0
    call seekFile
    
    sub rbx,rax
    mov [sizeofimage],rbx
    ;file vorodi ra mikhanim
    mov   rdi, [FDinput]
    mov   rsi,[mem]
    mov   rdx,[sizeofimage]
    call  readFile
    ; az khane 128 ke pixel ha shoro mishavad shoro mikonim
    mov rcx,128
    ;mov r14,image
    mov rdi,[sizeofimage]
    ;sub rdi,8
    ; meghrade n ke az vorodi khande mishavad
    ;mov eax,dword[n]
    mov r12,[mem]
    ; hame 32 biti haye xmm1 ra mosavi n mikonim
    pxor xmm0,xmm0
    pxor xmm1,xmm1
    movd xmm0,dword[n]
    movd xmm1,dword[n]
    psllq xmm1,32
    ;vpaddd xmm1,xmm1,xmm0
    paddd xmm1,xmm0
    movdqa xmm0,xmm1
    ;vpslldq xmm0,xmm0,64
    pslldq xmm0,64
    ;vpaddd xmm1,xmm1,xmm0
    paddd xmm1,xmm0
again:
    ; jam kardan ba n
    pxor xmm0,xmm0
    movdqa xmm0,[r12+rcx]
    ;vpaddd  xmm0,xmm0,xmm1
    paddd  xmm0,xmm1
    movdqa [r12+rcx],xmm0
    add rcx,16
    cmp rcx,rdi
    jl again
    ; neveshtan file ha
    mov   rdi,[FDoutput]
    mov   rsi,[mem]
    mov   rdx,[sizeofimage]
    call  writeFile
    ;bastan file ha
    mov   rdi, [FDinput]
    call  closeFile
    mov   rdi, [FDoutput]
    call  closeFile
    ; edame ta vaqti aks ha tamam shavad
    pop r15
    dec r15
    cmp r15,0
    jne pics
    call memfree
exit:
    mov rax, 60
    mov rdi, 0
    syscall
;barname ba aks haye type BMP kar mikonad
