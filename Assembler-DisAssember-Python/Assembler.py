#opcodes
opcodes={"add":"000000","adc":"000100","cmp":"001110","test":"100001","xor":"001100",
          "shr":"110100","shl":"110100","sbb":"000110","sub":"001010","bsr":"00001111101111",
          "bsf":"00001111101111","xchg":"100001","test":"100001","jmp":"111111","mov":"100010",
          "idiv":"111101","imul":"00001111101011","xadd":"00001111110000","cmp":"001110",
          "stc":"11111001","clc":"11111000","std":"11111101","cld":"11111100","syscall":"0000111100000101","ret":"11000011",
          "neg":"111101","not":"111101","inc":"111111","dec":"111111"}
preg={"push":"01010","pop":"01011","call":"1111111111010"}
pmem={"push":"11111111","pop":"10001111","call":"11111111"}
pmem1={"push":"110","pop":"000","call":"010"}
pim={8:"01101010",64:"01101000"}
itr={"add":"100000","adc":"100000","cmp":"100000","test":"111101","xor":"100000",
          "shr":"110100","shl":"110100",}
itm={"add":"100000","adc":"100000","cmp":"100000","test":"111101","xor":"100000"}
ita={"add":"0000010","adc":"0001010","cmp":"0011110","test":"1010100","xor":"0011010"}
regis={"add":"000","adc":"010","cmp":"111","test":"000","xor":"110",
       "shr":"101","shl":"100",
       "neg":"011","not":"010","inc":"000","dec":"001","ret":"11000010"}
#numbers
numbers=["1","2","3","4","5","6","7","8","9","0"]
#all registers
regs=["al","ax","eax","rax",
     "cl","cx","ecx","rcx",
     "dl","dx","edx","rdx",
     "bl","bx","ebx","rbx",
     "ah","sp","esp","rsp",
     "ch","bp","ebp","rbp",
     "dh","si","esi","rsi",
     "bh","di","edi","rdi",
     "r8","r8d","r8w","r8b",
     "r9","r9d","r9w","r9b",
     "r10","r10d","r10w","r10b",
     "r11","r11d","r11w","r11b",
     "r12","r12d","r12w","r12b",
     "r13","r13d","r13w","r13b",
     "r14","r14d","r14w","r14b",
     "r15","r15d","rw15","r15b"]
#8bits registers
reg8=["al","cl","dl","bl","ah","ch","dh","bh","r8b","r9b","r10b","r11b","r12b","r13b","r14b","r15b"]
#16bits registers
reg16=["ax","cx","dx","bx","sp","bp","si","di","r8w","r9w","r10w","r11w","r12w","r13w","r14w","rw15"]
#32bits registers
reg32=["eax","ecx","edx","ebx","esp","ebp","esi","edi","r8d","r9d","r10d","r11d","r12d","r13d","r14d","r15d"]
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
#ss numbers
sss={1:"00",2:"01",4:"10",8:"11"}
#hex numbers
hexx={10:"a",11:"b",12:"c",13:"d",14:"e",15:"f"}
#global variables
prefix=""
registers_ad=[]
registers_op=[]
adsz=0
opsz=0
rex="0100"
code_w="0"
rex_w="0"
r="0"
x="0"
b="0"
opcode=""
#use d instead of s
d="0"
mod=""
reg=""
rm=""
program_mod=0
ss=""
displacement=""
disp=0
ind=""
bas=""
bas_bool=False
imm=False
bytes=0
immidiate=""
code=""
#adad 10-10
def adad(s):
     s=int(s)
     s=hex(s)
     s=str(s)
     return s
#make code
def make_code():
     global code,rm,ind,reg,bas,b,x,r,displacement,disp,rex_w,code_w,imm,immidiate,ss,bas_bool,opcode,d,mod,opsz,adsz,prefix,program_mod
     program_size()
     ad_size()
     op_size()
     if(len(rm)==4):
          b=rm[0]
          rm=rm[1:]
     if(len(ind)==4):
          x=ind[0]
          ind=ind[1:]
     if(len(reg)==4):
          r=reg[0]
          reg=reg[1:]
     if(len(bas)==4):
          b=bas[0]
          bas=bas[1:]
     if(program_mod==64):
          rex="0100"
          if(disp>0 and ind=="100" and bas=="101" and rm=="100" and mod=="00"):
               displacement+=(8-disp)*"0"
               disp=8
          if(opsz==64):
               code_w="1"
               rex_w="1"
          elif(opsz==32):
               code_w="1"
               rex_w="0"
          elif(opsz==16):
               code_w="1"
               rex_w="0"
          else:
               code_w="0"
               rex_w="0"
          if(imm):
               displacement=immidiate
          code=rex+rex_w+r+x+b+opcode+d+code_w+mod+reg+rm
          if(bas_bool):
               code+=ss+ind+bas
     else:
          if(opsz==8):
               code_w="0"
          else:
               code_w="1"
          code=opcode+d+code_w+mod+reg+rm
          if(bas_bool):
               code+=ss+ind+bas
     code=cod(code)
     pref()
     code=prefix+code+displacement
#make memory
def make_memory():
     global rm,mod,bas,b,disp,displacement,ind
     if(bas=="101"):
          mod="00"
          rm="100"
          displacement+=(8-disp)*"0"
          disp=8
     elif(ind=="100" and bas!="0101" and disp==0):
          mod="00"
          rm=bas
     elif(ind=="100" and bas!="0101" and disp<=2):
          mod="01"
          rm=bas
     elif(ind=="100" and bas!="0101" and disp>2):
          mod="10"
          rm=bas
     elif(disp<=2 and bas=="0101" and ind!="100"):
          rm="100"
          mod="01"
          displacement+=(2-disp)*"0"
          disp=2
     elif(disp>=3 and bas=="0101" and ind!="100"):
          rm="100"
          mod="10"
     elif(disp<=2 and bas=="0101" and ind=="100"):
          rm=bas
          mod="01"
          displacement+=(2-disp)*"0"
          disp=2
     elif(disp>=3 and bas=="0101" and ind=="100"):
          rm=bas
          mod="10"
     elif(ind!="100" and disp==0 and bas!="0101"):
          rm="100"
          mod="00"
     elif(disp<=2 and bas!="0101" and ind!="100"):
          mod="01"
          rm="100"
     elif(disp<=8 and bas!="0101" and ind!="100"):
          mod="10"
          rm="100"

#code to assembly code
def cod(s):
     code=""
     for i in range(int(len(s)/4)):
          x=0
          for j in range(4):
             x+=int(s[4*i+j])*(2**(3-j))
          if(x<10):
               code+=str(x)
          else:
               code+=hexx[x]
     return code

#adress size
def ad_size():
     global adsz , registers_ad,program_mod
     for i in registers_ad:
          if(i in reg8):
               adsz=8
          elif(i in reg16):
               adsz=16
          elif(i in reg32):
               adsz=32
          else:
               adsz=64
     if(len(registers_ad)==0):
          adsz=64
#oprand size
def op_size():
     global opsz , registers_op,program_mod
     for i in registers_op:
          if(i in reg8):
               opsz=8
          elif(i in reg16):
               opsz=16
          elif(i in reg32):
               opsz=32
          else:
               opsz=64
     if(len(registers_op)==0):
          opsz=64
#prifix
def pref():
     global prefix , rex_w , opsz , adsz
     if(opsz==16):
          prefix+="66"
     """
     if(rex_w=="1" and opsz==64):
          prefix+="66"
     """
     if(adsz==32):
          prefix+="67"
#find program mod(32 or 64)
def program_size():
     global registers_ad , registers_op , program_mod
     for i in registers_op:
          if(i[0]=="r"):
               program_mod=64
     for i in registers_ad:
          if(i[0]=="r"):
               program_mod=64
     if(program_mod==0):
          program_mod=32
#make a hex number to a displacement or immidiate data
def adad_hex(x):
     global disp
     if(x[:2]!="0x"):
          x=adad(x)
     disp=max(len(x)-2,disp)
     if(disp>2): disp=8
     elif(disp>0): disp=2
     else: disp=0
     displace=""
     z=1
     if(len(x)-2>1):
          for i in range(disp):
               if(i<len(x)-2):
                    displace+=x[len(x)-i-1-z]
                    z=-z
               else:
                    displace+="0"
     else:
          displace="0"+x[-1]
     return displace
#immidiate data
def immidiate_hex(x):
     global bytes
     if(x[:2]!="0x"):
          x=adad(x)
     disp=len(x)-2
     if(disp>4): disp=8
     elif(disp>2): disp=4
     else: disp=2
     bytes=disp
     displace=""
     z=1
     if(len(x)-2>1):
          for i in range(disp):
               if(len(x)-i-1-z>=2):
                    displace+=x[len(x)-i-1-z]
               else:
                    displace+="0"
               z=-z
     else:
          displace="0"+x[-1]
     return displace
#memory to code(if its memory and return 1 else return 0)
def memory(s):
     global opsz,bas_bool,displacement,ss,adsz,ind,bas,registers_op,registers_ad,disp
     # size of data in address
     if(s[:10]=="qword ptr "):
          s=s[10:]
          opsz=64
     if(s[:10]=="dword ptr "):
          s=s[10:]
          opsz=32
     if(s[:9]=="word ptr "):
          s=s[9:]
          opsz=16
     if(s[:9]=="byte ptr "):
          s=s[9:]
          opsz=8
     #adress
     if(s[0]=="[" and s[-1]=="]"):
          bas_bool=True
          disp=0
          displacement=""
          s=s[1:len(s)-1]
          s=s.split("+")
          b=False
          if(s[len(s)-1][:2]=="0x" or s[len(s)-1][0] in numbers):
               b=True
               displacement=adad_hex(s[len(s)-1])
          if(len(s)==1 and b):
               adsz=64
               ss=sss[1]
               ind="100"
               bas="101"
          elif(len(s)==1 and not b):
               x=s[0].split("*")
               registers_ad.append(x[0])
               if(len(x)==1):
                    ss=sss[1]
                    ind="100"
                    bas=regdic[s[0]]
                    if(regdic[x[0]]!="0100"):
                         bas_bool=False
               else:
                    ss=sss[int(x[1])]
                    ind=regdic[x[0]]
                    bas="101"
          elif(len(s)==2 and b):
               x=s[0].split("*")
               registers_ad.append(s[0])
               if(len(x)==1):
                    if(regdic[x[0]]!="0100"):
                         bas_bool=False
                    ss=sss[1]
                    ind="100"
                    bas=regdic[s[0]]
               else:
                    ss=sss[int(x[1])]
                    ind=regdic[x[0]]
                    bas="101"
          else:
               x=s[0].split("*")
               y=s[1].split("*")
               registers_ad.append(x[0])
               registers_ad.append(y[0])
               if(len(x)==1 and len(y)==1):
                    if(regdic[y[0]]=="0100"):
                         bas=regdic[y[0]]
                         ind=regdic[x[0]]
                         ss=sss[1]
                    else:
                         bas=regdic[x[0]]
                         ind=regdic[y[0]]
                         ss=sss[1]
               else:
                    if(len(y)==1):
                         ss=sss[1]
                    else:
                         ss=sss[int(y[1])]
                    ind=regdic[y[0]]
                    bas=regdic[x[0]]
          return 1
     else:
          return 0
#input is like this ( add rax,rbx )
s=input()
s = s.lower()
for i in range(len(s)):
     if(s[i] == ' '):
          break
s1=[]
if(i==len(s)-1):
     s1.append(s)
else:
     s1.append(s[:i])
s = s[i+1:]
if(s!=""):
     s=s.split(",")
     s1.extend(s)
s=s1
#model haye mokhtalef input baraye tavabe ba 3 vorodi
if(len(s)==3):
     opcode=opcodes[s[0]]
     if(s[1] in regs and s[2] in regs):
          registers_op.append(s[1])
          registers_op.append(s[2])
          d="0"
          mod="11"
          reg=regdic[s[2]]
          rm=regdic[s[1]]
     elif(memory(s[1]) and s[2] in regs):
          d="0"
          registers_op.append(s[2])
          make_memory()
          reg=regdic[s[2]]
     elif(s[1] in regs and memory(s[2])):
          d="1"
          registers_op.append(s[1])
          make_memory()
          reg=regdic[s[1]]
     else:
          imm=True
          d="1"
          immidiate=immidiate_hex(s[2])
          if(s[1] in regs):
               registers_op.append(s[1])
               if(regdic[s[1]]=="1000"):
                    opcode=ita[s[0]]
                    reg=""
                    rm=""
                    mod=""
                    d=""
               else:
                    opcode=itr[s[0]]
                    if(bytes*4!=16 and bytes*4!=32):
                         d="1"
                    else:
                         d="0"
                    mod="11"
                    reg=regis[s[0]]
                    rm=regdic[s[1]]
          else:
               opcode=itm[s[0]]
               if(bytes*4!=16 and bytes*4!=32):
                    d="1"
               else:
                    d="0"
               reg=regis[s[0]]
               memory(s[1])
               make_memory()
     make_code()
elif(len(s)==1):
     code=opcodes[s[0]]
     code=cod(code)
elif(len(s)==2 and s[0]!="ret"):
     if(s[0] == "push" or s[0] == "pop" or s[0] == "call"):
          if(s[1] in regs):
               registers_op.append(s[1])
               make_code()
               reg = regdic[s[1]]
               if(program_mod == 64):
                    code = "0100"+rex_w+"00"+reg[0]
               code += preg[s[0]]+reg[1:]
               code = cod(code)
          elif(memory(s[1])):
               make_memory()
               make_code()
               if(program_mod == 64):
                    code = rex+rex_w+r+x+b
               code = pmem[s[0]]+mod+pmem1[s[0]]+rm
               code = cod(code)
          else:
               displacement = immidiate_hex(s[1])
               if(bytes>2):
                    displacement += (8-bytes)*"0"
                    bytes = 16
               if(s[0] != "call"):
                    code += pim[bytes*4]
               else:
                    code += "11101000"
               code = cod(code)
               code +=displacement
     else:
          d="1"
          opcode=opcodes[s[0]]
          if(s[1] in regs):
               registers_op.append(s[1])
               mod="11"
               rm=regdic[s[1]]
          elif(memory(s[1])):
               make_memory()
          reg=regis[s[0]]
          make_code()
elif(s[0]=="ret"):
     opcode=regis[s[0]]
     displacement=adad_hex(s[1])
     if(disp<4):
          displacement+=(4-disp)*"0"
     disp=4
     code=opcode
     code=cod(code)
     code+=displacement
print(code)