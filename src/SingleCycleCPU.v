`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: USC
// Engineer: MAHESH BHAT KEREKODI
// 
// Create Date: 09/24/2021 02:50:29 AM
// Design Name: 
// Module Name: SingleCycleCPU
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module SingleCycleCPU(clk, reset);
input clk,reset;

wire [31:0]PC_next;            //next address accessing the Instructions
wire [31:0]PC;              //address accessing the instruction in this cycle
wire [31:0]Instruction;     //the 32 bit instruction in MIPS
wire [31:0]write_addr;      //select the Rg or Rt
wire [31:0]write_data;      //writing to the DM registers
wire [31:0]reg_data1,reg_data2; //data from DM registers
wire regdist, jump, branch, memread, memwrite, memtoreg,alusrc,regwrite;    //CPU CU signals
wire [1:0]aluop;                //for ALU control from CU
wire [3:0]alu_select;           //selecting the operation on the ALU
wire [31:0]extendedfield;       //when 16bit is extended, this is used.
wire [31:0]alusource2;   //ALU'2 32 bit input - selected from reg_data2 or extendedfield
wire [31:0]aluresult;   //result after operation in ALU
wire overflow_detect,cout;     //an extra function...currently no use in the design
wire zero;                      //=1 if result is 32'b0
wire [31:0]dm_readdata;         //read data from the Data Memory
wire [31:0]PC_4;            //PC<=PC+4;
wire [31:0]offsetadd;       // Here the offset is ready to be added to the PC+4
wire [31:0]addjump;         //PC+4 + Offset ready
wire [31:0]PC_J;            // addjump or PC_4
wire [27:0]jumpaddP;        //jumpaddress almost ready
program_counter     pc0(.clk(clk), .reset(reset), .PC_in(PC_next), .PC_out(PC));
instruction_mem     IM0(.read_add(PC), .instruction(Instruction), .reset(reset));
mux_32bit           rtrd(.ip1(Instruction[15:11]), .ip2(Instruction[20:16]), .op(write_addr), .s(regdist)); //s=1, op=ip1;
register_file       registersfile(.read_add_1(Instruction[25:21]),.read_add_2(Instruction[20:16]),
                        .write_add(write_addr),.write_data(write_data),.read_data_1(reg_data1),
                        .read_data_2(reg_data2),.reg_write(regwrite),.clk(clk),.reset(reset));
sign_extend         extenderto32(.sign_in(Instruction[15:0]), .sign_out(extendedfield));
mux_32bit           alusource(.ip1(extendedfield),.ip2(reg_data2),.op(alusource2),.s(alusrc));
alu                 mainALU(.A(reg_data1),. B(alusource2), .AINV(alu_select[3]), 
                            .BNEG(alu_select[2]), .Opr({alu_select[1],alu_select[0]}),
                            .RESULT(aluresult), .OVERFLOW(overflow_detect), .ZERO(zero), .COUT(cout));
data_memory         DataMemory(.clk(clk),.reset(reset),.add(aluresult),.write_data(reg_data2),
                       .read_data(dm_readdata),.memwrite(memwrite),.memread(memread));
mux_32bit           memout(.ip1(dm_readdata),.ip2(aluresult),.op(write_data),.s(memtoreg));
control_unit        CU(.opcode(Instruction[31:26]), .regdist(regdist), .jump(jump),
                       .branch(branch), .memread(memread), .memwrite(memwrite), 
                       .memtoreg(memtoreg), .alusrc(alusrc), .regwrite(regwrite), .aluop(aluop) );
alu_control         ALUCU(.aluop(aluop), .func(Instruction[5:0]), .alu_select(alu_select));
alu_add             pc_adder(.A(PC),.B(32'd4),.add_op(PC_4));
shift_left2_branch  sbranch(.add_in(extendedfield), .add_out(offsetadd));
alu_add             BTA_adder(.A(PC_4),.B(offsetadd),.add_op(addjump));
mux_32bit           branching(.ip1(addjump),.ip2(PC_4),.op(PC_J),.s(branch&&zero));
shift_left2_jump    sjump(.add_in(Instruction[25:0]),.add_out(jumpaddP));
mux_32bit           jumping(.ip1({PC_4[31:28],jumpaddP}),.ip2(PC_J),.op(PC_next),.s(jump));

endmodule
