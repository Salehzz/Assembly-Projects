#hex numbers
hexx={"a":10,"b":11,"c":12,"d":13,"e":14,"f":15}
#opcodes
opcodes={"0f10111100":"bsf","0f10111101":"bsr","100001":"xchg","10010":"xchg","0f110000":"xadd",
        "11000010":"ret","0f101011":"imul","000000":"add","000100":"adc","001110":"cmp","001100":"xor",
        "110100":"shr","000110":"sbb","001010":"sub",
        "100001":"test","100010":"mov","111101":"test","100000":"@",
        "001110":"cmp",
        "111101":"#","111111":"#","c3":"ret","f9":"stc","f8":"clc","fd":"std","fc":"cld","0f05":"syscall"}
#regis
regis={"011":"neg","010":"not","000":"inc","001":"dec","000":"add","010":"adc","111":"cmp","110":"xor",
        }
#2 oprand
opcode2=["0f10111100","0f10111101","100001","0f110000","0f101011","0f110000",]
#1 oprand
opcode1=["11000010","111111","111101","10010"]
#0 oprand
opcode0=["c3","f9","f8","fd","fc","0f05"]
#registers codes
regdic={"al":"0000","ax":"0000","eax":"0000","rax":"0000",
     "cl":"0001","cx":"0001","ecx":"0001","rcx":"0001",
     "dl":"0010","dx":"0010","edx":"0010","rdx":"0010",
     "bl":"0011","bx":"0011","ebx":"0011","rbx":"0011",
     "ah":"0100","sp":"0100","esp":"0100","rsp":"0100",
     "ch":"0101","bp":"0101","ebp":"0101","rbp":"0101",
     "dh":"0110","si":"0110","esi":"0110","rsi":"0110",
     "bh":"0111","di":"0111","edi":"0111","rdi":"0111",
     "r8":"1000","r8d":"1000","r8w":"1000","r8b":"1000",
     "r9":"1001","r9d":"1001","r9w":"1001","r9b":"1001",
     "r10":"1010","r10d":"1010","r10w":"1010","r10b":"1010",
     "r11":"1011","r11d":"1011","r11w":"1011","r11b":"1011",
     "r12":"1100","r12d":"1100","r12w":"1100","r12b":"1100",
     "r13":"1101","r13d":"1101","r13w":"1101","r13b":"1101",
     "r14":"1110","r14d":"1110","r14w":"1110","r14b":"1110",
     "r15":"1111","r15d":"1111","rw15":"1111","r15b":"1111"}
#registers codes
regs=["0000","0001","0010","0011","0100","0101","0110","0111","1000","1001","1010","1011","1100","1101","1110","1111"]
#ss numbers
sss={"00":"1","01":"2","10":"4","11":"8"}
#8bits registers
reg8={"0000":"al","0001":"cl","0010":"dl","0011":"bl","0100":"ah","0101":"ch","0110":"dh","0111":"bh"
    ,"1000":"r8b","1001":"r9b","1010":"r10b","1011":"r11b","1100":"r12b","1101":"r13b","1110":"r14b","1111":"r15b"}
#16bits registers
reg16={"0000":"ax","0001":"cx","0010":"dx","0011":"bx","0100":"sp","0101":"bp","0110":"si","0111":"di"
    ,"1000":"r8w","1001":"r9w","1010":"r10w","1011":"r11w","1100":"r12w","1101":"r13w","1110":"r14w","1111":"r15w"}
#32bits registers
reg32={"0000":"eax","0001":"ecx","0010":"edx","0011":"ebx","0100":"esp","0101":"ebp","0110":"esi","0111":"edi"
    ,"1000":"r8d","1001":"r9d","1010":"r10d","1011":"r11d","1100":"r12d","1101":"r13d","1110":"r14d","1111":"r15d"}
#64bits registers
reg64={"0000":"rax","0001":"rcx","0010":"rdx","0011":"rbx","0100":"rsp","0101":"rbp","0110":"rsi","0111":"rdi"
    ,"1000":"r8","1001":"r9","1010":"r10","1011":"r11","1100":"r12","1101":"r13","1110":"r14","1111":"r15"}
#variables
program_mod=0
rex_w="0"
r="0"
x="0"
b="0"
code_w="0"
d="0"
opcode=""
mod=""
reg=""
rm=""
bas=""
ind=""
ss=""
displacement=""
adsz=0
opsz=0
memory=""
code=""
tartib=True
bas_bool=False
prefix_66=False
prefix_67=False
#make numbers
def make_hex(x):
    global disp
    disp=len(x)
    displace=""
    z=1
    for i in range(disp):
        displace=x[i+z]+displace
        z=-z
    displace="0x"+displace
    return displace
#tashkhis bas
def bass():
    global bas_bool,bass,ss,ind,bas,s,x,b,r,adsz,opsz,mod
    if(rm=="0100" and mod!="11"):
        bas_bool=True
    else:
        return 0
    x1=make_binary(s[0])+make_binary(s[1])
    s=s[2:]
    ss=x1[:2]
    ss=sss[ss]
    ind=x1[2:5]
    bas=x1[5:]
    ind=x+ind
    bas=b+bas
    if(adsz==8):
        ind=reg8[ind]
        bas=reg8[bas]
    elif(adsz==16):
        ind=reg16[ind]
        bas=reg16[bas]
    elif(adsz==32):
        ind=reg32[ind]
        bas=reg32[bas]
    else:
        ind=reg64[ind]
        bas=reg64[bas]
    return 1
#make code
def make_code():
    global memory,reg,rm,displacement,opcode,code,d,opsz,adsz,tartib
    code=""
    if(opcode in opcode1):
        if(opcodes[opcode]=="#"):
            opcode=regis[reg[1:]]
        else:
            opcode=opcodes[opcode]
        code+=opcode
        code+=" "
        make_memory()
        if(mod=="11"):
            code+=rm
        else:
            code+=memory
    elif(opcode in opcode2):
        if(opcodes[opcode]=="@"):
            opcode = regis[reg[1:]]
        else:
            opcode=opcodes[opcode]
        if(opsz==8):
            reg=reg8[reg]
        elif(opsz==16):
            reg=reg16[reg]
        elif(opsz==32):
            reg=reg32[reg]
        else:
            reg=reg64[reg]
        code+=opcode
        code+=" "
        make_memory()
        if(mod=="11"):
            if(tartib):
                code+=rm
                code+=","
                code+=reg
            else:
                code+=reg
                code+=","
                code+=rm
        else:
            if(not tartib):
                code+=reg
                code+=","
                code+=memory
            elif(d=="1"):
                code+=reg
                code+=","
                code+=memory
            elif(d=="0"):
                code+=memory
                code+=","
                code+=reg
#make memory
def make_memory():
    global mod,bas_bool,bas,ind,ss,rm,displacement,memory,opsz,adsz
    if(not bas_bool):
        if(opsz==8):
            rm=reg8[rm]
        elif(opsz==16):
            rm=reg16[rm]
        elif(opsz==32):
            rm=reg32[rm]
        else:
            rm=reg64[rm]
    if(mod!="11"):
        if(opsz==8):
            memory+="BYTE PTR "
        elif(opsz==16):
            memory+="WORD PTR "
        elif(opsz==32):
            memory+="DWORD PTR "
        elif(opsz==64):
            memory+="QWORD PTR "
    if((mod=="01" or mod=="10") and not bas_bool):
        memory+="["
        memory+=rm
        if(displacement!="" and displacement[2:]!="" and displacement[2:]!=8*"0" and displacement[2:]!=2*"0"):
            memory+="+"
            memory+=displacement
        memory+="]"
    elif((mod=="01" or mod=="10") and bas_bool):
        memory+="["
        memory+=bas
        if(regdic[ind]!="0100"):
            memory+="+"
            memory+=ind
            if(ss!="1"):
                memory+="*"
                memory+=ss
        if(displacement!="" and displacement[2:]!="" and displacement[2:]!=8*"0" and displacement[2:]!=2*"0"):
            memory+="+"
            memory+=displacement
        memory+="]"
    elif(mod=="00" and not bas_bool):
        memory+="["
        memory+=rm
        memory+="]"
    elif(mod=="00" and bas_bool):
        memory+="["
        if(regdic[bas]!="0101"):
            memory+=bas
        if(regdic[bas]!="0101" and regdic[ind]!="0100"):
            memory+="+"
        if(regdic[ind]!="0100"):
            memory+=ind
            if(ss!="1"):
                memory+="*"
                memory+=ss
        if((regdic[ind]!="0100" or regdic[bas]!="0101") and displacement!="" and displacement[2:]!=""
           and displacement[2:]!=8*"0" and displacement[2:]!=2*"0"):
            memory+="+"
        if(displacement!="" and displacement[2:]!="" and displacement[2:]!=8*"0" and displacement[2:]!=2*"0"):
            memory+=displacement
        memory+="]"
    return 1
#opsz
def op_size():
    global program_mod,opsz,code_w,rex_w,prefix_66
    if(program_mod==32):
        if(code_w=="1"):
            if(prefix_66):
                opsz=16
            else:
                opsz=32
        elif(code_w=="0"):
            opsz=8
        else:
            opsz=program_mod
    else:
        if(code_w=="1" and rex_w=="1" and not prefix_66):
            opsz=64
        elif(code_w=="1" and rex_w=="0" and not prefix_66):
            opsz=32
        elif(code_w=="1" and rex_w=="0" and prefix_66):
            opsz=16
        elif(code_w=="0" and rex_w=="0" and not prefix_66):
            opsz=8
        else:
            opsz=program_mod
def opr_size():
    global rex_w,prefix_66,opsz,program_mod
    if(rex_w=="0" and prefix_66):
        opsz=16
    elif(rex_w=="1" and not prefix_66):
        opsz=64
    elif(rex_w=="0" and not prefix_66):
        opsz=32
    else:
        opsz=program_mod
#adsz
def ad_size():
    global adsz,program_mod,prefix_67
    if(program_mod==64 and prefix_67):
        adsz=32
    elif(program_mod==64 and not prefix_67):
        adsz=64
    elif(program_mod==32 and prefix_67):
        adsz=32
    elif(program_mod==32 and not prefix_67):
        adsz=16
#a hex string to a binary string
def make_binary(s):
    global hexx
    s1=""
    if(s>="0" and s<="9"):
        x=int(s)
    else:
        x=hexx[s]
    for i in range(4):
        s1=str(x%2)+s1
        x=int(x/2)
    return s1
s=input()
if((len(s)==2 or len(s)==4) and s in opcode0):
    code=opcodes[s]
else:
    if(s[:2]=="66"):
        s=s[2:]
        prefix_66=True
    if(s[:2]=="67"):
        s=s[2:]
        prefix_67=True
    if(s[0]=="4"):
        program_mod=64
    else:
        program_mod=32
    if(program_mod==64):
        s1=make_binary(s[1])
        rex_w=s1[0]
        r=s1[1]
        x=s1[2]
        b=s1[3]
        s=s[2:]
    x1=make_binary(s[0])+make_binary(s[1])
    if(x1[:5] in opcode1 and len(s)==2):
        opcode=x1[:5]
        code+=opcodes[opcode]
        reg=r+x1[5:]
        if(prefix_66):
            opsz=16
        else:
            opsz=32
        if(opsz==16):
            reg=reg16[reg]
            rm="ax"
        elif(opsz==32):
            reg=reg32[reg]
            rm="eax"
        code+=" "
        code+=reg
        code+=","
        code+=rm
    else:
        if(s[:2]=="0f"):
            opcode="0f"
            s=s[2:]
        x1=make_binary(s[0])+make_binary(s[1])
        if((opcode+x1) in opcode2):
            opcode+=x1
            d=""
            code_w=""
            tartib=False
        else:
            opcode+=x1[:6]
            d=x1[6]
            code_w=x1[7]
        s=s[2:]
        x1=make_binary(s[0])+make_binary(s[1])
        mod=x1[:2]
        reg=x1[2:5]
        rm=x1[5:]
        s=s[2:]
        reg=r+reg
        if(tartib):
            op_size()
        else:
            opr_size()
        ad_size()
        rm=b+rm
        bass()
        if(s!=""):
            displacement=make_hex(s)
        make_code()
print(code)