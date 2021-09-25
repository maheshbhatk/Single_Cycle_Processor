`timescale 1ns / 1ps


module register_file(read_add_1,read_add_2,write_add,write_data,read_data_1,read_data_2,reg_write,clk,reset);
input [4:0] read_add_1;
input [4:0] read_add_2;
input [4:0] write_add;
input [31:0]write_data;
output [31:0] read_data_1;
output [31:0] read_data_2;
input reg_write,clk,reset;

reg [31:0] registers [31:0];
integer k;

assign read_data_1=registers[read_add_1];
assign read_data_2=registers[read_add_2];

always@(posedge clk, posedge reset)
begin
		if (reset==1'b1)
		begin
			for (k=0; k<32; k=k+1) 
			begin
				registers[k] = 32'b0;
			end
			//initializing some regsiters to few values.
			registers[0]=32'b0000_0000_0000_0000_0000_0000_0000_0000;
			registers[1]=32'b0000_0000_0000_0000_0000_0000_1010_0101;
			registers[2]=32'b1111_1111_1111_1111_1111_1111_0101_1010;
			
		end 
		
		else if (reg_write == 1'b1) registers[write_add] = write_data; 
	end

endmodule
