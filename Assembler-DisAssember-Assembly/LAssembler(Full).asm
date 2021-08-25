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
  
  qword	db	"qword ptr ",0
  dword	db	"dword ptr ",0
  word		db	"word ptr ",0
  byte		db	"byte ptr ",0
  listofbytes	dq	qword,dword,word,byte,0
  sizes	dq	64,32,16,8,0
  sizesbyte	dq	10,10,9,9,0
  directory      db  "/home/saleh/Desktop/assembler",0
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
  
  sizeoffile    dq   0

  sys_getdents  equ 78
  sys_chdir  equ  80
  sys_getdents64 equ  217

  O_directory equ  0q0200000

  NewLine    equ  0xA
  
  addv		db	"000000",0
  addk		db	"add",0
  
  adcv		db	"000100",0
  adck		db	"adc",0
  
  cmpv		db	"001110",0
  cmpk		db	"cmp",0
  
  testv	db	"100001",0
  testk	db	"test"
  
  xorv		db	"001100",0
  xork		db	"xor",0
  
  shrv		db	"110100",0
  shrk		db	"shr",0
  
  shlv		db	"110100",0
  shlk		db	"shl",0
  
  sbbv		db	"000110",0
  sbbk		db	"sbb",0
  
  subv		db	"001010",0
  subk		db	"sub",0
  
  bsrv		db	"00001111101111",0
  bsrk		db	"bsr",0
  
  bsfv		db	"00001111101111",0
  bsfk		db	"bsf",0
  
  xchgv	db	"100001",0
  xchgk	db	"xchg",0
  
  testv	db	"100001",0
  testk	db	"test",0
  
  jmpv		db	"111111",0
  jmpk		db	"jmp",0
  
  movv		db	"100010",0
  movk		db	"mov",0
  
  idivv	db	"111101",0
  idivk	db	"idiv",0
  	
  imulv	db	"00001111101011",0
  imulk	db	"imul",0
  
  xaddv	db	"00001111110000",0
  xaddk	db	"xadd",0
  
  cmpv		db	"001110",0
  cmpk		db	"cmp",0
  
  stcv		db	"11111001",0
  stck		db	"stc",0
  
  clcv		db	"11111000",0
  clck		db	"clc",0
  
  stdv		db	"11111101",0
  stdk		db	"std",0
  
  cldv		db	"11111100",0
  cldk		db	"cld",0
  
  syscallv	db	"0000111100000101",0
  syscallk	db	"syscall",0
  
  retv		db	"11000011",0
  retk		db	"ret",0
  
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
  
  al		db	"al",0
  ax		db	"ax",0
  eax		db	"eax",0
  rax		db 	"rax",0
  
  cl		db	"cl",0
  cx		db	"cx",0
  ecx		db	"ecx",0
  rcx		db	"rcx",0
  
  dl		db	"dl",0
  dx		db	"dx",0
  edx		db	"edx",0
  rdx		db	"rdx",0
  
  bl 		db	"bl",0
  bx		db	"bx",0
  ebx		db	"ebx",0
  rbx		db	"rbx",0
  
  ah		db	"ah",0
  sp		db	"sp",0
  esp		db	"esp",0
  rsp		db	"rsp",0
  
  ch		db	"ch",0
  bp		db	"bp",0
  ebp		db	"ebp",0
  rbp		db	"rbp",0
  
  dh		db	"dh",0
  si		db	"si",0
  esi		db	"esi",0
  rsi		db	"rsi",0
  
  bh		db	"bh",0
  di		db	"di",0
  edi		db	"edi",0
  rdi		db	"rdi",0
  
  r8		db	"r8",0
  r8d		db	"r8d",0
  r8w		db	"r8w",0
  r8b		db	"r8b",0
  
  r9		db	"r9",0
  r9d		db	"r9d",0
  r9w		db	"r9w",0
  r9b		db	"r9b",0
  
  r10		db	"r10",0
  r10d		db	"r10d",0
  r10w		db	"r10w",0
  r10b		db	"r10b",0
  
  r11		db	"r11",0
  r11d		db	"r11d",0
  r11w		db	"r11w",0
  r11b		db	"r11b",0
  
  r12		db	"r12",0
  r12d		db	"r12d",0
  r12w		db	"r12w",0
  r12b		db	"r12b",0
  
  r13		db	"r13",0
  r13d		db	"r13d",0
  r13w		db	"r13w",0
  r13b		db	"r13b",0
  
  r14		db	"r14",0
  r14d		db	"r14d",0
  r14w		db	"r14w",0
  r14b		db	"r14b",0
  
  r15		db	"r15",0
  r15d		db	"r15d",0
  r15w		db	"r15w",0
  r15b		db	"r15b",0
  
  raxk		db	"0000",0
  rcxk		db	"0001",0
  rdxk		db	"0010",0
  rbxk		db	"0011",0
  rspk		db	"0100",0
  rbpk		db	"0101",0
  rsik		db	"0110",0
  rdik		db	"0111",0
  r8k		db	"1000",0
  r9k		db	"1001",0
  r10k		db	"1010",0
  r11k		db	"1011",0
  r12k		db	"1100",0
  r13k		db	"1101",0
  r14k		db	"1110",0
  r15k		db	"1111",0
  
  opcodeskey	dq	addk,adck,cmpk,testk,xork,shrk,shlk,sbbk,subk,bsrk,bsfk,xchgk,jmpk,movk,idivk,imulk,xaddk,stck,clck,stdk,cldk,syscallk,retk,negk,notk,inck,deck,0
  opcodesvalue	dq	addv,adcv,cmpv,testv,xorv,shrv,shlv,sbbv,subv,bsrv,bsfv,xchgv,jmpv,movv,idivv,imulv,xaddv,stcv,clcv,stdv,cldv,syscallv,retv,negv,notv,incv,decv,0
  pregkey	dq	pushk,popk,callk,0
  pregvalue	dq	pushv1,popv1,callv1
  pmemvalue	dq	pushv2,popv2,callv2
  pmem1value	dq	pushv3,popv3,callv3
  pimkey	dq	8,64
  pimvalue	dq	pim8,pim64
  itrkey	dq	addk,adck,cmpk,testk,xork,movk,subk,sbbk,shrk,shlk,0
  itrvalue	dq	addv1,adcv1,cmpv1,testv1,xorv1,movv1,subv1,sbbv1,shrv1,shlv1
  itakey	dq	addk,adck,cmpk,testk,xork,movk,subk,sbbk,0
  itavalue	dq	addv2,adcv2,cmpv2,testv2,xorv2,movv2,subv2,sbbv2
  regiskey	dq	addk,adck,cmpk,testk,xork,shrk,shlk,sbbk,subk,jmpk,movk,retk,negk,notk,inck,deck,0
  regisvalue	dq	addv3,adcv3,cmpv3,testv3,xorv3,shrv3,shlv3,sbbv3,subv3,jmpv3,movv3,retv3,negv3,notv3,incv3,decv3,0
  numbers	db	"0","1","2","3","4","5","6","7","8","9","a","b","c","d","e","f",0
		
  reg8		dq	al,cl,dl,bl,ah,ch,dh,bh,r8b,r9b,r10b,r11b,r12b,r13b,r14b,r15b,0
  reg16	dq	ax,cx,dx,bx,sp,bp,si,di,r8w,r9w,r10w,r11w,r12w,r13w,r14w,r15w,0
  reg32	dq	eax,ecx,edx,ebx,esp,ebp,esi,edi,r8d,r9d,r10d,r11d,r12d,r13d,r14d,r15d,0
  reg64	dq	rax,rcx,rdx,rbx,rsp,rbp,rsi,rdi,r8,r9,r10,r11,r12,r13,r14,r15,0
  regs		dq	al,cl,dl,bl,ah,ch,dh,bh,r8b,r9b,r10b,r11b,r12b,r13b,r14b,r15b,ax,cx,dx,bx,sp,bp,si,di,r8w,r9w,r10w,r11w,r12w,r13w,r14w,r15w,eax,ecx,edx,ebx,esp,ebp,esi,edi,r8d,r9d,r10d,r11d,r12d,r13d,r14d,r15d,rax,rcx,rdx,rbx,rsp,rbp,rsi,rdi,r8,r9,r10,r11,r12,r13,r14,r15,0
  regvalue	dq	raxk,rcxk,rdxk,rbxk,rspk,rbpk,rsik,rdik,r8k,r9k,r10k,r11k,r12k,r13k,r14k,r15k
  ss1		db	"00",0
  ss2		db	"01",0
  ss4		db	"10",0
  ss8		db	"11",0
  ssskey	dq	1,2,4,8,0
  sssvalue	dq	ss1,ss2,0,ss4,0,0,0,ss8,0
  hexxkey	db	10,11,12,13,14,15,0
  hexxvalue	db	"a","b","c","d","e","f",0
  prefix	db	"0000",0
  registersad	dq	0
  registersop	dq	0
  adsz		dq	0
  opsz		dq	0
  rex		db	"0100",0
  code_w	db	'0'
  rex_w	db	'0'
  r		db	'0'
  x		db	'0'
  b		db	'0'
  d		db	'0'
  mod		dq	0
  reg		dq	0
  rm		dq	0
  program_mod	dq	0
  ss		dq	0
  disp		dq	0
  ind		dq	0
  bas		dq	0
  bas_bool	dq	0
  imm		dq	0
  bytes	dq	0
  
  outputname	db	"610396109.txt",0
  inputname	db	"assembler.txt",0
  codeindex	dq	0
  hexcodeindex	dq	0
  outputindex	dq	0
  inputindex	dq	0
  memorypart	dq	0
  
  memoryha	dq	memory1,memory2,memory3,0
  opcode	dq	0
  
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
equlstrings:
    push rax
    push rbx
    push r8
    push r9
    push rcx
    mov rax,1
    mov rbx,0
    mov r8,[rsp+48]
    mov r9,[rsp+56]
    mov rdi,r8
    call GetStrlen
    mov r10,rdx
    mov rdi,r9
    call GetStrlen
    mov r12,rdx
    cmp r10,r12
    je equ
    mov rax,0
    jmp equend
    equ:
    cmp rbx,r10
    je equend
    mov rcx,[r8+rbx]
    cmp rcx,[r9+rbx]
    inc rbx
    je equ
    mov rax,0
    equend:
    mov [equstr],rax
    pop rcx
    pop r9
    pop r8
    pop rbx
    pop rax
    ret
    
findmatchstring:
    mov r8,[rsp+8]
    mov r9,[rsp+16]
    mov r15,0
    llp:
    cmp [r9+r15*8],0
    je endfindmatch
    push [r9+r15*8]
    push r8
    call equalstrings
    pop rax
    pop rax
    cmp [equstr],1
    je endfindmatch
    inc r15
    jmp llp
    endfindmatch:
    ;r15 javabe
    mov [matchindex],r15
    ret
    
bit32_maker:
    mov rcx,0
    mov rax,[codeindex]
    opcodezero:
    cmp byte[opcode+rcx],0
    je opcodeend
    mov bl,[opcode+rcx]
    mov [code+rax],bl
    inc rcx
    inc rax
    jmp opcodezero
    opcodeend:
    mov [codeindex],rax
    ret
    
bit64_maker:
    mov rcx,0
    mov [code],"0"
    mov [code+1],"1"
    mov [code+2],"0"
    mov [code+3],"0"
    mov bl,[rex_w]
    mov [code+4],bl
    mov bl,[r]
    mov [code+5],bl
    mov bl,[x]
    mov [code+6],bl
    mov bl,[b]
    mov [code+7],bl
    mov [codeindex],8
    call bit32_maker
    ret
    
bas_bool_maker:
    mov rax,[codeindex]
    mov bl,[ss]
    mov [code+rax],bl
    mov bl,[ss+1]
    mov [code+rax+1],bl
    mov bl,[ind]
    mov [code+rax+2],bl
    mov bl,[ind+1]
    mov [code+rax+3],bl
    mov bl,[ind+2]
    mov [code+rax+4],bl
    mov bl,[bas]
    mov [code+rax+5],bl
    mov bl,[bas+1]
    mov [code+rax+6],bl
    mov bl,[bas+2]
    mov [code+rax+7],bl
    add rax,8
    mov [codeindex],rax
    ret
    
pref:
    mov rax,0
    cmp [opsz],16
    jne notopsz16f
    mov [hexcode],"6"
    mov [hexcode+1],"6"
    add rax,2
    notopsz16f:
    cmp [adsz],32
    jne endpref
    mov [hexcode+rax],"6"
    mov [hexcode+rax+1],"7"
    add rax,2
    endpref:
    mov [hexcodeindex],rax
    ret
    
cod:
    mov rcx,0
    mov r9,[hexcodeindex]
    forstart:
    cmp [code+rcx],0
    je endforstart
    mov r8,0
    mov rbx,0
    mov bl,[code+rcx]
    sub bl,48
    imul bl,8
    add r8,rbx
    mov rbx,0
    inc rcx
    mov bl,[code+rcx]
    sub bl,48
    imul bl,4
    add r8,rbx
    mov rbx,0
    inc rcx
    mov bl,[code+rcx]
    sub bl,48
    imul bl,2
    add r8,rbx
    mov rbx,0
    inc rcx
    mov bl,[code+rcx]
    sub bl,48
    add r8,rbx
    mov bl,[numbers+r8]
    mov [hexcode+r9],bl
    inc r9
    jmp forstart
    endforstart:
    mov rcx,0
    forstart1:
    cmp [mydisplacement+rcx],0
    je endforstart1
    mov bl,[mydisplacement+rcx]
    inc rcx
    mov [hexcode+r9],bl
    inc r9
    endforstart1:
    mov [hexcodeindex],r9
    ret
    
make_memory:
    push bas
    push bas101
    call equalstrings
    pop rax
    pop rax
    cmp [equstr],1
    jne no1
    mov mod,ss1
    mov rm,rm100
    mov rcx,[disp]
    for1:
    cmp rcx,8
    je endofmakememory
    mov [displacement+rcx],"0"
    inc rcx
    jmp for1
    no1:
    push ind
    push ind100
    call equalstrings
    pop rax
    pop rax
    mov r8,[equstr]
    push bas
    push bas0101
    call equalstrings
    pop rax
    pop rax
    mov r9,[equstr]
    mov rax,1
    and rax,r8
    mov r10,r9
    neg r10
    inc r10
    and rax,r10
    cmp rax,1
    jne no4
    cmp [disp],0
    jne no2
    mov mod,ss1
    mov rm,bas
    jmp endofmakememory
    no2:
    cmp [disp],2
    jg no3
    mov mod,ss2
    mov rm,bas
    jmp endofmakememory
    no3:
    mov mod,ss4
    mov rm,bas
    jmp endofmakememory
    no4:
    mov r10,r8
    nog r10
    inc r10
    and r10,r9
    cmp r10,1
    jne no6
    cmp [disp],2
    jg no5
    mov rm,rm100
    mov mod,ss2
    mov rcx,[disp]
    disp2:
    cmp rcx,2
    jge endofmakememory
    mov [displacement+rcx],"0"
    inc rcx
    jmp disp2
    no5:
    mov rm,rm100
    mov mod,ss4
    jmp endofmakememory
    no6:
    mov rax,r8
    and rax,r9
    cmp rax,1
    jne no8
    cmp [disp],2
    jg no7
    mov rm,bas
    mov mod,ss2
    mov rcx,[disp]
    disptwo:
    cmp rcx,2
    jge endofmakememory
    mov [displacement+rcx],"0"
    inc rcx
    jmp disptwo
    no7:
    mov rm,bas
    mov mod,ss4
    jmp endofmakememory
    no8:
    neg r8
    inc r8
    neg r9
    inc r9
    and r8,r9
    cmp r8,1
    jne endofmakememory
    cmp [disp],0
    jne no9
    mov rm,rm100
    mov mod,ss1
    jmp endofmakememory
    no9:
    cmp [disp],2
    jg no10
    mov mod,ss2
    mov rm,rm100
    no10:
    cmp [disp],8
    jg endofmakememory
    mov mod,ss4
    mov rm,rm100
    endofmakememory:
    ret
    
adad_hex:
    mov r8,[rsp+8]
    mov rdi,r8
    call GetStrlen
    sub rdx,2
    cmp rdx,[disp]
    jng rdxlower
    mov [disp],rdx
    rdxlower:
    cmp [disp],0
    jg disp1
    mov [disp],0
    jmp enddif
    disp1:
    cmp [disp],2
    jg disp2
    mov [disp],2
    jmp enddif
    disp2:
    mov [disp],8
    enddif:
    mov rax,2
    mov [adadhexnew],"0"
    mov [adadhexnew+1],"x"
    mov rcx,rdx
    adadsazi:
    cmp rcx,1
    jng adadsaziend
    mov bl,[r8+rcx]
    mov [adadhexnew+rax],bl
    add rcx,-2
    add rax,2
    jmp adadsazi
    adadsaziend:
    inc rdx
    mov rax,3
    mov rcx,rdx
    adadssazi:
    cmp rcx,1
    jng adadssaziend
    mov bl,[r8+rcx]
    mov [adadhexnew+rax],bl
    add rcx,-2
    add rax,2
    jmp adadssazi
    adadssaziend:
    ret
    
immidiate_hex:
    mov r8,[rsp+8]
    mov rdi,r8
    call GetStrlen
    sub rdx,2
    cmp [disp],0
    jg disp11
    mov [disp],0
    jmp enddif1
    disp11:
    cmp [disp],2
    jg disp21
    mov [disp],2
    jmp enddif1
    disp21:
    mov [disp],8
    enddif1:
    mov rax,2
    mov [adadhexnew],"0"
    mov [adadhexnew+1],"x"
    mov rcx,rdx
    adadsazi1:
    cmp rcx,1
    jng adadsaziend1
    mov bl,[r8+rcx]
    mov [adadhexnew+rax],bl
    add rcx,-2
    add rax,2
    jmp adadsazi1
    adadsaziend1:
    inc rdx
    mov rax,3
    mov rcx,rdx
    adadssazi1:
    cmp rcx,1
    jng adadssaziend1
    mov bl,[r8+rcx]
    mov [adadhexnew+rax],bl
    add rcx,-2
    add rax,2
    jmp adadssazi1
    adadssaziend1:
    ret
    
    
qesmataval:
    push rax
    push rbx
    push r8
    push r9
    push rcx
    mov rax,1
    mov rbx,0
    mov r8,[rsp+8]
    mov r9,[rsp+16]
    mov rdi,r8
    call GetStrlen
    mov r10,rdx
    mov rdi,r9
    call GetStrlen
    mov r12,rdx
    cmp r10,r12
    jng equ
    mov rax,0
    jmp equend
    equ:
    cmp rbx,r10
    je equend
    mov rcx,[r8+rbx]
    cmp rcx,[r9+rbx]
    inc rbx
    je equ
    mov rax,0
    equend:
    mov [equstr],rax
    pop rcx
    pop r9
    pop r8
    pop rbx
    pop rax
    ret
    
memory:
    mov r8,[rsp+8]
    mov rax,0
    opszandaze:
    cmp [listofbytes+rax],0
    je endofopszandaze
    push r8
    push [listofbytes+rax]
    call qesmateaval
    pop r10
    pop r10
    cmp [equstr],1
    jne opszandaze
    mov opsz,[sizes+rax]
    add r8,[sizesbyte+rax]
    endofopszandaze:
    cmp [r8],"["
    jne nomemo
    inc r8
    mov [ismemory],1
    mov [bas_bool],1
    mov [disp],0
    mov rax,0
    mov rcx,0
    mov r14,0 ; b
    mov r15,1 ; tedad partha
    findplus:
    mov bl,[r8+rax]
    cmp bl,"]"
    je endofplus
    cmp bl,"+"
    je endfindplus
    mov [memory1+rcx],bl
    inc rax
    inc rcx
    jmp findplus
    endfindplus:
    inc r15
    mov rcx,0
    inc rax
    findpush1:
    mov bl,[r8+rax]
    cmp bl,"]"
    je endofplus
    cmp bl,"+"
    je endfindplus1
    mov [memory2+rcx],bl
    inc rax
    inc rcx
    jmp findplus1
    endfindpush1:
    inc r15
    mov rcx,0
    inc rax
    findplus2:
    mov bl,[r8+rax]
    cmp bl,"]"
    je endofplus
    mov [memory3+rcx],bl
    inc rax
    inc rcx
    jmp findplus2
    endofplus:
    mov [memorypart],r15
    dec r15
    mov r12,[memoryha+r15]
    cmp [r12],"0"
    jne noo1
    mov r14,1
    push r12
    call adad_hex
    pop r12
    noo1:
    
    mov r15,0
    mov [avaliyadovomi],r15
    mov rcx,0
    mov rax,0
    zarbfinder:
    mov bl,[memory1+rcx]
    cmp bl,0
    je endzarbfound
    cmp bl,"*"
    je zarbfound
    mov [zarb1+rax],bl
    inc rax
    inc rcx
    jmp zarbfinder
    zarbfound:
    mov r15,1
    inc rcx
    mov rax,0
    zarbfinder1:
    mov bl,[memory1+rcx]
    cmp bl,0
    je endzarbfound
    mov [zarb2+rax],bl
    inc rax
    inc rcx
    jmp zarbfinder1
    endzarbfound:
    
    mov rcx,0
    mov rax,0
    zarbfinder1:
    mov bl,[memory2+rcx]
    cmp bl,0
    je endzarbfound1
    cmp bl,"*"
    je zarbfound1
    mov [zarb3+rax],bl
    inc rax
    inc rcx
    jmp zarbfinder1
    zarbfound1:
    mov r15,2
    inc rcx
    mov rax,0
    zarbfinder11:
    mov bl,[memory2+rcx]
    cmp bl,0
    je endzarbfound1
    mov [zarb4+rax],bl
    inc rax
    inc rcx
    jmp zarbfinder11
    endzarbfound1:
    mov [avaliyadovomi],r15
    
    
    ;adsz
    ;programsz = 32
    push reg8
    push zarb1
    call findstringmatch
    pop rax
    pop rax
    cmp [matchindex],16
    jne adsize_16
    mov [adsz],8
    jmp adsizeend
    adsize_16:
    push reg16
    push zarb1
    call findstringmatch
    pop rax
    pop rax
    cmp [matchindex],16
    jne adsize_32:
    mov [adsz],16
    jmp adsizeend
    adsize_32:
    push reg32
    push zarb1
    call findstringmatch
    pop rax
    pop rax
    cmp [matchindex],16
    jne adsize_64
    mov [adsz],32
    jmp adsizeend
    adsize_64:
    mov [adsz],64
    jmp adsizeend
    adsizeend:
    
    cmp [memory1],"r"
    jne prog32
    mov [program_mod],64
    prog32:
    cmp [memory2],"r"
    jne prog321
    mov [program_mod],64
    prog321:
    
    cmp [memorypart],1
    jne noo3
    cmp r14,1
    jne noo2
    mov [adsz],64
    mov ss,[sss]
    mov ind,ind100
    mov bas,bas101
    jmp endmemo
    
    noo2:
    cmp r15,1
    je zarbe
    mov ss,[sss]
    mov ind,ind100
    push regs
    push memory1
    call equalstrings
    pop rax
    pop rax
    mov rax,[matchindex]
    idiv rax,4
    mov bas,[regvalue+rax]
    cmp bas,rspk
    jne endmemo
    mov bas_bool,0
    jmp endmemo
    zarbe:
    mov rbx,0
    mov bl,[zarb2]
    sub bl,49
    mov ss,[sss+rbx]
    push regs
    push memory1
    call equalstrings
    pop rax
    pop rax
    mov rax,[matchindex]
    idiv rax,4
    mov ind,[regvalue+rax]
    mov bas,bas101
    jmp endmemo
    noo3:
    cmp r14,1
    je noo4
    cmp r15,1
    jne zarbdare
    push regs
    push zarb1
    call equalstrings
    pop rax
    pop rax
    idiv rax,4
    mov r8,[regvalue+rax]
    cmp r8,rspk
    je narsp
    mov [bas_bool],0
    narsp:
    mov ss,[sss]
    mov ind,ind100
    mov bas,r8
    
    zarbdare:
    mov rbx,0
    mov bl,[zarb2]
    sub bl,49
    mov ss,[sss+rbx]
    push regs
    push zarb1
    call equalstrings
    pop rax
    pop rax
    idiv rax,4
    mov ind,[regvalue+rax]
    mov bas,bas101
    jmp endmemo
    noo4:
    cmp r15,0
    jne nooozarb
    push regs
    push zarb4
    call equlstrings
    pop rax
    pop rax
    mov rax,[matchindex]
    idiv rax,4
    mov r8,[regvalue+rax]
    cmp r8,rspk
    jne norsp1:
    mov bas,r8
    push regs
    push zarb3
    call equalstrings
    pop rax
    pop rax
    mov rax,[matchindex]
    idiv rax,4
    mov r8,[regvalue+rax]
    mov ind,r8
    mov ss,[sss]
    jmp endmemo
    norsp1:
    push regs
    push zarb1
    call equalstrings
    pop rax
    pop rax
    mov rax,[matchindex]
    idiv rax,4
    mov ind,[regvalue+rax]
    push regs
    push zarb3
    call equalstrings
    pop rax
    pop rax
    mov rax,[matchindex]
    idiv rax,4
    mov bas,[regvalue+rax]
    
    cmp r15,2
    jne norsp2
    mov ss,[sss]
    jmp endmemo
    norsp2:
    mov rbx,0
    mov bl,[zarb3]
    sub bl,49
    mov ss,[sss+rbx]
    jmp endmemo
    nooozarb:
    jmp endmemo
    nomemo:
    mov [ismemory],0
    endmemo:
    ret
    
make_code:
    mov rdi,rm
    call GetStrlen
    cmp rdx,4
    jne norm
    mov rcx,[rm]
    mov [b],rcx
    inc rm
    norm:
    mov rdi,ind
    call GetStrlen
    cmp rdx,4
    jne noind
    mov rcx,[ind]
    mov [x],rcx
    inc ind
    noind:
    mov rdi,reg
    call GetStrlen
    cmp rdx,4
    jne noreg
    mov rcx,[reg]
    mov [r],rcx
    inc reg
    noreg:
    mov rdi,bas
    call GetStrlen
    cmp rdx,4
    jne nobas
    mov rcx,[bas]
    mov [b],rcx
    inc bas
    nobas:
    cmp program_mod,64
    jne nosixtyfour
    mov [rex],"0"
    mov [rex+1],"1"
    mov [rex+2],"0"
    mov [rex+3],"0"
    mov rax,1
    cmp disp,0
    jng noshit
    push ind
    push ind100
    call equlstrings
    pop rax
    pop rax
    cmp [equstr],0
    je noshit
    push bas
    push bas101
    call equalstrings
    pop rax
    pop rax
    cmp [equstr],0
    je noshit
    push rm
    push rm100
    call equalstrings
    pop rax
    pop rax
    cmp [equstr],0
    je noshit
    push mod
    push ss1
    call equalstrings
    pop rax
    pop rax
    cmp [equstr],0
    je noshit
    shit:
    cmp [disp],8
    je noshit
    dec [disp]
    mov [displacement+disp],"0"
    add [disp],2
    jmp shit
    noshit:
    cmp [opsz],64
    jne noopsz64
    mov [code_w],"1"
    mov [rex_w],"1"
    jmp endopsz
    noopsz64:
    cmp [opsz],32
    jne noopsz32
    mov [code_w],"1"
    mov [rex_w],"0"
    jmp endopsz
    noopsz32:
    cmp [opsz],16
    jne noopsz16
    mov [code_w],"1"
    mov [rex_w],"0"
    jmp endopsz
    noopsz16:
    mov [code_w],"0"
    mov [rex_w],"0"
    endopsz:
    mov mydisplcement,displacement
    cmp imm,true
    jne disimm
    mov mydisplacement,immidiate
    disimm:
    call bit64_maker
    jmp nothirtytwo
    nosixtyfour:
    cmp [opsz],8
    jne noopsz8
    mov [code_w],"0"
    jmp make32code
    noopsz8:
    mov [code_w],"1"
    make32code:
    call bit32_maker
    nothirtytwo:
    cmp bas_bool,true
    jne nobasbool
    ;code +=ss+ind+bas
    call bas_bool_maker
    nobasbool:
    call pref
    call cod
    ret

make_output:
    
    makeoutputend:
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
    mov [sizeofimage],rbx
    ;file vorodi ra mikhanim
    mov   rdi,[FDinput]
    mov   rsi,[input]
    mov   rdx,[sizeoffile]
    call  readFile
    ; az khane rax
    mov rcx,0
    
again:
    mov [partnum],0
    mov rcx,31
    makezero:
    mov [opcode+rcx],0
    mov [displacement+rcx],0
    mov [immidiate+rcx],0
    mov [code+rcx],0
    mov [hexcode+rcx],0
    mov [adadhex+rcx],0
    mov [adadhexnew+rcx],0
    mov [part1+rcx],0
    mov [part2+rcx],0
    mov [part3+rcx],0
    loop makezero
    
    mov r12,[inputindex]
    cmp r12,[sizeoffile]
    
    jge endofagain
    mov rax,0
    mov rbx,0
    mov r15,1
    
    inneragain:
    mov bl,byte[input+r12]
    
    cmp bl,"\"
    je endofline
    cmp bl," "
    je endinneragain
    
    mov [part1+rax],bl
    inc r12
    inc rax
    jmp inneragain
    
    endofinneragain:
    
    inc r15
    inc r12
    mov rax,0
    inneragain1:
    mov bl,byte[input+r12]
    cmp bl,"\"
    je endofline
    cmp bl,","
    je endinneragain1
    
    mov [part2+rax],bl
    inc r12
    inc rax
    jmp inneragain1
    
    endofinneragain1:
    
    inc r15
    inc r12
    mov rax,0
    inneragain2:
    mov bl,byte[input+r12]
    cmp bl,"\"
    je endofline
    
    mov [part3+rax],bl
    inc r12
    inc rax
    jmp inneragain2
    
    endofline:
    mov [partnum],r15
    mov rax,0
    add r12,2
    mov [inputindex],r12
    
    call make_output
    
    jmp again
    
    endofagain:
    ; neveshtan file ha
    mov   rdi,[FDoutput]
    mov   rsi,[output]
    mov   rdx,[outputindex]
    call  writeFile
    
    ;bastan file ha
    mov   rdi, [FDinput]
    call  closeFile
    mov   rdi, [FDoutput]
    call  closeFile
    
exit:
    mov rax, 60
    mov rdi, 0
    syscall
