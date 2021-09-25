`timescale 1ns / 1ps

module program_counter(clk, reset, PC_in, PC_out);
input clk, reset;
input [31:0] PC_in;
output reg [31:0] PC_out;
always @ (posedge clk, posedge reset)
    begin   if(reset==1)
                PC_out<=0;
            else
                PC_out<=PC_in;
    end
endmodule
