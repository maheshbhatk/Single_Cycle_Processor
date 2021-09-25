`timescale 1ns / 1ps

module data_memory(clk,reset,add,write_data,read_data,memwrite,memread);
input clk,reset,memwrite,memread;
input [31:0]add;
input [31:0]write_data;
output [31:0]read_data;
reg [31:0] DMemory [1023:0]; //can be extended to 2 power 32-1 :0
integer k;
wire [31:0] shifted_addr;
//assign shifted_addr={add[31:2],2'b0};
assign shifted_addr=add[31:2];
assign read_data = (memread) ? DMemory[add] : 32'bx;

always @(posedge clk or posedge reset)
	begin
		if (reset == 1) 
			begin
				for (k=0; k<64; k=k+1) begin
					DMemory[k] = 32'b0;
				end
			DMemory[0]=32'b0000_0000_0000_0000_0000_0000_0000_0000;
			DMemory[1]=32'b0000_0000_0000_0000_0000_0000_1010_0101;
			DMemory[2]=32'b0000_0000_0000_0000_0000_0000_0000_0001;
			DMemory[3]=32'b0000_0000_0000_0000_0000_0000_0000_0010;
			DMemory[4]=32'b0000_0000_0000_0000_0000_0000_0000_0011;
			DMemory[5]=32'b0000_0000_0000_0000_0000_0000_0000_0100;
			end
		else
			if (memwrite) DMemory[add] = write_data;
	end

endmodule
