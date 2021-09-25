`timescale 1ns / 1ps

module instruction_mem(read_add, instruction, reset);
input reset;
input [31:0] read_add;
output [31:0] instruction;
reg [31:0]Imemory [1023:0]; //can be upto 2 power 32-1 : 0 as well
integer k;
wire [31:0] abs_read_add;
//assign abs_read_add={read_add[31:2],2'b0};
assign abs_read_add={read_add[31:2]};
assign instruction = Imemory[abs_read_add];

always@(posedge reset)
begin
		for (k=0; k<1023; k=k+1) begin
			Imemory[k] = 32'b0;
		end
		
//Hardccoding the instructions initially.
Imemory[0]=32'b000000_00001_00010_00011_00000_100100;       //RTYPE - AND  AND $3, $1, $2; 
Imemory[1]=32'b000000_00001_00010_00100_00000_100101;       //RTYPE - OR   OR  $4, $1, $2;
Imemory[2]=32'b000000_00001_00010_00101_00000_100110;       //RTYPE - NOR  NOR $5, $1, $2;  not original mips part 
Imemory[3]=32'b000000_00001_00010_00110_00000_100111;       //RTYPE - NAND NAND $6,$1, $2;  not original mips part
Imemory[4]=32'b000000_00001_00010_00111_00000_100000;       //RTYPE - ADD  ADD $7, $1, $2;  
Imemory[5]=32'b000000_00001_00010_01000_00000_100010;       //RTYPE - SUB  SUB $8, $1, $2;
Imemory[6]=32'b000000_00001_00010_01001_00000_101010;       //RTYPE - SLT  SLT $9, $1, $2;
Imemory[7]=32'b000000_00010_00001_01010_00000_101010;       //RTYPE - SLT  SLT $10, $2, $1;

Imemory[8]=32'b100011_00000_01011_00000000_00000100;       //ITYPE - LW   lw $11, 0004($0);
Imemory[9]=32'b101011_00000_01011_00000000_00000100;       //ITYPE - SW   sw $11, 0004($0);
//Imemory[10]=32'b000100_00000_00011_11111111_11110101;    //ITYPE - BEQ  beq $0, $3, go to initial position
Imemory[10]=32'b000010_00000000_00000000_00000101_00;      //JTYPE - JUMP j 80; 
Imemory[20]=32'b000100_00000_00011_11111111_1110_1011;    //ITYPE - BEQ  beq $0, $3, go to initial position
end
endmodule
