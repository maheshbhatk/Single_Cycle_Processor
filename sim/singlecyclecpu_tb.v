`timescale 1ns / 1ps


module singlecyclecpu_tb(   );

reg clk,reset;
SingleCycleCPU dut(clk, reset);

initial
begin
clk=0;
reset=0;
#1 reset=1;
#10 reset=0;
#200 $finish;
end
always
 #5 clk=~clk;

endmodule
