%include "in-out.asm"
section .data
  equstr	  dq  0
  matchindex	  dq  0
  partnum	dq	0
  ind100	db	"100",0
  bas101	db	"101",0
  bas0101	db	"0101",0
  rm100	db	"100",0
  mydisplacement	dq	0
  ismemory	dq	0
  avaliyadovomi	dq	0
  string1	dq	0
  string2	dq	0
  sizes	dq	64,32,16,8,0
  sizesbyte	dq	10,10,9,9,0
  directory      db  "/home/saleh/Desktop/assembler",0
  FDinput        dq  0
  FDoutput       dq  0
  FD             dq  0
  hastag	dq	"#"
  new		dq	0xA
   
  NewLine    equ 	0xA
  
  suces_get     dq  "get image succesfully",NewLine,0
  error_get     dq  "error in getting",NewLine,0
  suces_write   dq  "written succesfully",NewLine,0
  error_write   dq  "error in writing",NewLine,0
  suces_chdir   dq  "directory changed succesfully",NewLine,0
  error_chdir   dq  "error in change directory",NewLine,0
  
  sizeoffile    dq   0

  sys_getdents  equ 78
  sys_chdir  equ  80
  sys_getdents64 equ  217

  O_directory equ  0q0200000

  
  
  
  stcv		dq	"f9",0
  stck		dq	"stc",0
  
  clcv		dq	"f8",0
  clck		dq	"clc",0
  
  stdv		dq	"fd",0
  stdk		dq	"std",0
  
  cldv		dq	"fc",0
  cldk		dq	"cld",0
  
  syscallv	dq	"0f05",0
  syscallk	dq	"syscall",0
  
  retv		dq	"c3",0
  retk		dq	"ret",0
  
  leavev	dq	"c9",0
  leavek	dq	"leave",0
  
  negk		db	"neg",0
  negv		db	"111101",0
  
  notk		db	"not",0
  notv		db	"111101",0
  
  inck		db	"inc",0
  incv		db	"111111",0
  
  deck		db	"dec",0
  decv		db	"111111",0
  
  pushk	db	"push",0
  pushv1	db	"01010",0
  popk 	db	"pop",0
  popv1	db	"01011",0
  callk	db	"call",0
  callv1	db	"1111111111010",0
  pushv2	db	"11111111",0
  popv2	db	"10001111",0
  callv2	db	"11111111",0
  pushv3	db	"110",0
  popv3	db	"000",0
  callv3	db	"010",0
  
  pim8		db	"01101010",0
  pim64	db	"01101000",0
  
  addv1	db	"100000",0
  adcv1	db	"100000",0
  cmpv1	db	"100000",0
  testv1	db	"111101",0
  xorv1	db	"100000",0
  movv1	db	"110001",0
  subv1	db	"100000",0
  sbbv1	db	"100000",0
  shrv1	db	"110000",0
  shlv1	db	"110000",0
  
  addv2	db	"0000010",0
  adcv2	db	"0001010",0
  cmpv2	db	"0011110",0
  testv2	db	"1010100",0
  xorv2	db	"0011010",0
  movv2	db	"1011",0
  subv2	db	"001011",0
  sbbv2	db	"000111",0
  
  addv3	db	"000",0
  adcv3	db	"010",0
  cmpv3	db	"111",0
  testv3	db	"000",0
  xorv3	db	"110",0
  movv3	db	"000",0
  shrv3	db	"101",0
  shlv3	db	"100",0
  sbbv3	db	"011",0
  subv3	db	"101",0
  jmpv3	db	"100",0
  negv3	db	"011",0
  notv3	db	"010",0
  incv3	db	"000",0
  decv3	db	"001",0
  retv3	db	"11000010",0
  
  opcodeszero	dq	"stc","clc","std","cld","syscall","ret","leave",0
  opcodeszerov	dq	"f9","f8","fd","fc","0f05","c3","c9",0
  
  
  outputname	db	"610396109_dis.txt",0
  inputname	db	"input_dis.txt",0
  codeindex	dq	0
  hexcodeindex	dq	0
  outputindex	dq	0
  inputindex	dq	0
  memorypart	dq	0
  
  
section .bss
    part1		resb	32
    part2		resb	32
    part3		resb	32
    
    memory1		resb	32
    memory2		resb	32
    memory3		resb	32
    
    zarb1		resb	32
    zarb2		resb	32
    zarb3		resb	32
    zarb4		resb	32
    
    displacement	resb	32
    immidiate		resb	32
    code		resb	32
    hexcode		resb	32
    
    adadhexnew		resb	32
    
    input	     	resb	4096
    output		resb	4096
section .text
    global _start


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

findmatchstring:
    mov r15,0
    llp:
    mov r8,qword[opcodeszerov+r15*8]
    cmp r8,0
    je endfindmatch
    mov rbx,[part1]
    
    equ:
    cmp rbx,r8
    je endfindmatch
    inc r15
    jmp llp
    endfindmatch:
    mov [matchindex],r15
    ret


make_output:
    call findmatchstring
    mov rax,[matchindex]

    mov r12,[outputindex]
    cmp rax,7
    je nooutput
    mov r8,[opcodeszero+rax*8]
    mov rax,0
    tryy:
    mov [output+r12*8],r8
    inc r12
    jmp makeoutputend
    nooutput:
    mov rax,[hastag]
    mov qword[output+r12*8],rax
    inc r12
    makeoutputend:
    mov rax,[new]
    mov qword[output+r12*8],rax
    inc r12
    mov [outputindex],r12
    ret

_start:
    
    mov   rdi,directory
    call  changedir
    mov   rdi,inputname
    call  openFile
    mov   [FDinput],rax
    ;mov   rdi,directory
    ;call  changedir
    mov   rdi,outputname
    call  createFile
    mov   [FDoutput],rax
    
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
    mov [sizeoffile],rbx
    ;file vorodi ra mikhanim
    mov   rdi,[FDinput]
    mov   rsi,input
    mov   rdx,[sizeoffile]
    call  readFile
    ; az khane rax
    
    mov rcx,0
    
again:
    mov rcx,31
    makezero:
    mov byte[part1+rcx],0
    loop makezero
    
    mov r12,[inputindex]
    cmp r12,[sizeoffile]
    
    jge endofagain
    mov rax,0
    mov rbx,0
    
    inneragain:
    mov bl,byte[input+r12]
    
    cmp bl,0xA
    je endofline
    
    
    mov [part1+rax],bl
    inc r12
    inc rax
    jmp inneragain
    
    
    endofline:
    mov rax,0
    inc r12
    
    ;mov rsi,part1
    ;call printString
    ;call newLine
    
    mov [inputindex],r12
    
    call make_output
    
    jmp again
    
    endofagain:
    mov r11,0
    myout:
    mov rbx,[output+r11*8]
    mov [FD],rbx
    mov rdi,FD
    call GetStrlen
    
    ;neveshtan file ha
    mov   rdi,[FDoutput]
    mov   rsi,FD
    ;mov   rdx,[outputindex]
    push r11
    call  writeFile
    pop r11
    inc r11
    cmp r11,[outputindex]
    jne myout
        
    ;bastan file ha
    mov   rdi, [FDinput]
    call  closeFile
    mov   rdi, [FDoutput]
    call  closeFile
    
exit:
    mov rax, 60
    mov rdi, 0
    syscall
