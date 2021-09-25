# Single_Cycle_Processor

# Designing a Single Cycle CPU in Verilog #

Before the concept of Pipelining is learnt, this helps in understanding the various units available and integration of it.

![alt text](https://github.com/maheshbhatk/Single_Cycle_Processor/blob/main/images/schematic.jpg)
This is the MIPS Processor which has been emulated in the code. \
(Taken from Computer Organization and Design by David A Patterson and John L Hennessy.) \
MIPS (Microprocessor without Interlocked Pipelined Stages) is a RISC based ISA. 

Here, 32-bit one is build in Verilog. 

Features coded:

* All are 32 bit wide instructions.

* MIPS has 32 32bit wide General Purpose Register(GPR).

* R type instructions, I Type instructions and J Type instructions are possible.

* R Type - AND, OR, NAND, NOR, ADD, SUB, SLT. 

* I Type - Lw, SW, BEQ.

* J Type - J.

____________________________________________________________________________________________________________________________________________________________


Instruction   | OpCode
------------- | -------------
R Type  | 000 000
I Type - LW  | 100 011
I Type - SW  | 101 011
I Type - BEQ | 000 100
J Type - J   | 000 010

For R Type:

Function Field |   ALU Code   | Operation
-------------- | -------------| ---------
100100 | 0000  | AND
100101  | 0001 |OR
100110  | 1100  |NOR
100111  | 1101  | NAND
100000  | 0010  | ADD
100010  | 0110  | SUB
101010  | 0111  | SLT


#### Hardcoding the instructions initially 
The below functions were checked and found to be correct.

Imemory[0]=32'b000000_00001_00010_00011_00000_100100;    

*RTYPE - AND  AND $3, $1, $2;*

Imemory[1]=32'b000000_00001_00010_00100_00000_100101;     

*RTYPE - OR   OR  $4, $1, $2;*

Imemory[2]=32'b000000_00001_00010_00101_00000_100110;      

*RTYPE - NOR  NOR $5, $1, $2;  not part of original mips instruction*

Imemory[3]=32'b000000_00001_00010_00110_00000_100111;       

*RTYPE - NAND NAND $6,$1, $2;  not part of original mips instruction*

Imemory[4]=32'b000000_00001_00010_00111_00000_100000;     

*RTYPE - ADD  ADD $7, $1, $2;*  

Imemory[5]=32'b000000_00001_00010_01000_00000_100010;   

*RTYPE - SUB  SUB $8, $1, $2;*

Imemory[6]=32'b000000_00001_00010_01001_00000_101010;    

*RTYPE - SLT  SLT $9, $1, $2;*

Imemory[7]=32'b000000_00010_00001_01010_00000_101010;    

*RTYPE - SLT  SLT $10, $2, $1;*

Imemory[8]=32'b100011_00000_01011_00000000_00000100;    

*ITYPE - LW   lw $11, 0004($0);*

Imemory[9]=32'b101011_00000_01011_00000000_00000100;    

*ITYPE - SW   sw $11, 0004($0);*

Imemory[10]=32'b000010_00000000_00000000_00000101_00; 

*JTYPE - JUMP j 80;* 

Imemory[20]=32'b000100_00000_00011_11111111_1110_1011;  

*ITYPE - BEQ  beq $0, $3, go to initial position*


WAVEFORM of the Testbench:
![alt text](https://github.com/maheshbhatk/Single_Cycle_Processor/blob/main/images/waveform.jpg)
