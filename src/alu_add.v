`timescale 1ns / 1ps

module alu_add(A,B,add_op);
input [31:0]A;
input [31:0]B;
output [31:0]add_op;
assign add_op=A+B;
endmodule
