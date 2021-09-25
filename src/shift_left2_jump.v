`timescale 1ns / 1ps

module shift_left2_jump(add_in,add_out);
input [25:0] add_in;
output [27:0] add_out;
assign add_out[27:0]={add_in[25:0],2'b00};
endmodule
