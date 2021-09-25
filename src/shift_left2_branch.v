`timescale 1ns / 1ps

module shift_left2_branch(add_in, add_out);
input [31:0] add_in;
output [31:0] add_out;
assign add_out[31:0]={add_in[29:0],2'b00};
endmodule
