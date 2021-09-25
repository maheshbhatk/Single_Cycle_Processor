`timescale 1ns / 1ps

module control_unit(opcode, regdist, jump, branch, memread, memwrite, memtoreg,alusrc,regwrite, aluop );
input [5:0] opcode;
output reg regdist, jump, branch, memread, memwrite, memtoreg, alusrc, regwrite;
output reg [1:0]aluop;

always@(opcode)
begin
    case (opcode)
    6'b000_000:  begin                                  //R- TYPE instructions
        regdist=1; jump=0; branch=0; memread=0;
        memwrite=0; memtoreg=0; alusrc=0; regwrite=1;
        aluop=2'b10;
                 end
    6'b100_011:  begin                                  //LW instruction - LOAD
        regdist=0; jump=0; branch=0; memread=1;
        memwrite=0; memtoreg=1; alusrc=1; regwrite=1;
        aluop=2'b00;
                 end
    6'b101_011:  begin                                  //SW instruction - STORE
        regdist=0; jump=0; branch=0; memread=0;
        memwrite=1; memtoreg=0; alusrc=1; regwrite=0;
        aluop=2'b00;
                 end
    6'b000_100:  begin                                  //BEQ instruction - Branch if equal
        regdist=0; jump=0; branch=1; memread=0;
        memwrite=0; memtoreg=0; alusrc=0; regwrite=0;
        aluop=2'b01;
                 end
    6'b000_010:  begin                                  //JUMP instruction - j target address
        regdist=0; jump=1; branch=0; memread=0;
        memwrite=0; memtoreg=0; alusrc=0; regwrite=0;
        aluop=2'b00;
                 end
    default:     begin
        regdist=0; jump=0; branch=0; memread=0;
        memwrite=0; memtoreg=0; alusrc=0; regwrite=0;
        aluop=2'b00;
                 end
    endcase  
end
endmodule
