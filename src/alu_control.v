`timescale 1ns / 1ps

module alu_control (aluop, func, alu_select);
input [1:0]aluop;
input [5:0]func;
output reg [4:0] alu_select;  //AINV,BINV,MuxSelects 2;

always@(aluop or func)
begin    if (aluop==2'b10) begin
                case(func)
                        6'b100000: alu_select=4'b0010;  //add
                        6'b100010: alu_select=4'b0110;  //sub
                        6'b100100: alu_select=4'b0000;  //AND
                        6'b100101: alu_select=4'b0001;  //OR
                        6'b100110: alu_select=4'b1100;  //NOR
                        6'b100111: alu_select=4'b1101;  //NAND
                        6'b101010: alu_select=4'b0111;  //SLT
                        default: alu_select=4'b0000;
                endcase
                end
          else begin
                if(aluop==2'b00)    alu_select=4'b0010;     //add for LW,SW
                else if (aluop==2'b01) alu_select=4'b0110;  //sub for Beg
               end        
end
endmodule
