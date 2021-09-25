`timescale 1ns / 1ps

module mux_32bit(ip1,ip2,op,s);
input [31:0]ip1;
input [31:0]ip2;
output [31:0]op;
input s;
assign op=s?ip1:ip2;

endmodule
