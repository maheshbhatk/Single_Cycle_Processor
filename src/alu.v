`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: USC
// Engineer: MAHESH BHAT KEREKODI
// 
// Create Date: 09/24/2021 01:14:27 AM
// Design Name: 
// Module Name: alu
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

module alu_1_bit (A, B, CIN, LESS, AINV, BINV, Opr, RESULT, COUT, ADD_R);

input A, B, CIN, LESS, AINV, BINV;
input [1:0] Opr;
output RESULT, ADD_R, COUT;

reg RESULT, COUT, ADD_R;
         
always @(*) 
  
	  begin  : combinational_logic 
	  reg RESULT_AND, RESULT_OR, RESULT_ADD_SUB, RESULT_SLT;
	  reg Am, Bm; // Am is the A at the output of the mux controlled by AINV; Similarly Bm
  
		Am = AINV ? 	~A : A	;  	
		Bm = BINV ? 	~B : B	;	

		
		RESULT_AND = 	Am & Bm	;
		RESULT_OR  = 	Am | Bm ;
		ADD_R = (Am ^ Bm ^ CIN) | (Am&Bm&CIN)	;
		RESULT_ADD_SUB = ADD_R;
		RESULT_SLT = LESS;
		COUT   = ((Am & Bm) | (Bm & CIN) | (CIN & Am))      ;
		
		case (Opr)
				0	: // 2'b00 Logical AND Function
				  	begin
					RESULT = RESULT_AND; 
				  	end
				1	: // 2'b01 Logical OR Function
				  	begin
					RESULT = RESULT_OR; 
				  	end 
				2	: // 2'b10 Arithmatic addition or subtract depending on the value of BINV
					begin        
					 RESULT = RESULT_ADD_SUB;
					end
				3	: // 2'b11 for the SLT A, B instruction ( if A < B, RESULT =1)
					begin
					 RESULT = RESULT_SLT;
					end
						
		  endcase
	   end 
endmodule //alu_1_bit

//-------------------------------------------------------------------------------

module alu(A, B, AINV, BNEG, Opr, RESULT, OVERFLOW, ZERO, COUT);

input [31:0] A, B;
input  AINV, BNEG;
input [1:0] Opr;

output[31:0] RESULT;
output OVERFLOW, ZERO, COUT;

wire COUT1, COUT2, COUT3, COUT4, COUT5,COUT6,COUT7,COUT8,COUT9,COUT10,COUT11,COUT12,COUT13,COUT14,COUT15,COUT16,
    COUT17,COUT18,COUT19,COUT20,COUT21,COUT22,COUT23,COUT24,COUT25,COUT26,
    COUT27,COUT28,COUT29,COUT30,COUT31,COUT32;
wire BINV, SET, LESS_0,CIN;
wire [31:0] ADD_R;

assign BINV = BNEG;
assign CIN = BNEG;

assign COUT = COUT32;
assign OVERFLOW = COUT32 ^ COUT31; 
assign SET = ADD_R[31];
assign LESS_0 =  OVERFLOW ? ~ SET : SET;
assign ZERO = (RESULT==0)?1:0;  

// module alu_1_bit (A, B, CIN, LESS, AINV, BINV, Opr, RESULT, COUT, ADD_R);
alu_1_bit alu0 (A[0], B[0], CIN, LESS_0, AINV, BINV, Opr, RESULT[0], COUT1, ADD_R[0]); 
alu_1_bit alu1 (A[1], B[1], COUT1, 1'b0, AINV, BINV, Opr, RESULT[1], COUT2, ADD_R[1]);
alu_1_bit alu2 (A[2], B[2], COUT2, 1'b0, AINV, BINV, Opr, RESULT[2], COUT3, ADD_R[2]);
alu_1_bit alu3 (A[3], B[3], COUT3, 1'b0, AINV, BINV, Opr, RESULT[3], COUT4, ADD_R[3]);
alu_1_bit alu4 (A[4], B[4], COUT4, 1'b0, AINV, BINV, Opr, RESULT[4], COUT5, ADD_R[4]);
alu_1_bit alu5 (A[5], B[5], COUT5, 1'b0, AINV, BINV, Opr, RESULT[5], COUT6, ADD_R[5]);
alu_1_bit alu6 (A[6], B[6], COUT6, 1'b0, AINV, BINV, Opr, RESULT[6], COUT7, ADD_R[6]);
alu_1_bit alu7 (A[7], B[7], COUT7, 1'b0, AINV, BINV, Opr, RESULT[7], COUT8, ADD_R[7]);
alu_1_bit alu8 (A[8], B[8], COUT8, 1'b0, AINV, BINV, Opr, RESULT[8], COUT9, ADD_R[8]);
alu_1_bit alu9 (A[9], B[9], COUT9, 1'b0, AINV, BINV, Opr, RESULT[9], COUT10, ADD_R[9]);

alu_1_bit alu10 (A[10], B[10], COUT10, 1'b0, AINV, BINV, Opr, RESULT[10], COUT11, ADD_R[10]);  
alu_1_bit alu11 (A[11], B[11], COUT11, 1'b0, AINV, BINV, Opr, RESULT[11], COUT12, ADD_R[11]); 
alu_1_bit alu12 (A[12], B[12], COUT12, 1'b0, AINV, BINV, Opr, RESULT[12], COUT13, ADD_R[12]); 
alu_1_bit alu13 (A[13], B[13], COUT13, 1'b0, AINV, BINV, Opr, RESULT[13], COUT14, ADD_R[13]); 
alu_1_bit alu14 (A[14], B[14], COUT14, 1'b0, AINV, BINV, Opr, RESULT[14], COUT15, ADD_R[14]); 
alu_1_bit alu15 (A[15], B[15], COUT15, 1'b0, AINV, BINV, Opr, RESULT[15], COUT16, ADD_R[15]); 
alu_1_bit alu16 (A[16], B[16], COUT16, 1'b0, AINV, BINV, Opr, RESULT[16], COUT17, ADD_R[16]);  
alu_1_bit alu17 (A[17], B[17], COUT17, 1'b0, AINV, BINV, Opr, RESULT[17], COUT18, ADD_R[17]); 
alu_1_bit alu18 (A[18], B[18], COUT18, 1'b0, AINV, BINV, Opr, RESULT[18], COUT19, ADD_R[18]); 
alu_1_bit alu19 (A[19], B[19], COUT19, 1'b0, AINV, BINV, Opr, RESULT[19], COUT20, ADD_R[19]); 

alu_1_bit alu20 (A[20], B[20], COUT20, 1'b0, AINV, BINV, Opr, RESULT[20], COUT21, ADD_R[20]); 
alu_1_bit alu21 (A[21], B[21], COUT21, 1'b0, AINV, BINV, Opr, RESULT[21], COUT22, ADD_R[21]); 
alu_1_bit alu22 (A[22], B[22], COUT22, 1'b0, AINV, BINV, Opr, RESULT[22], COUT23, ADD_R[22]); 
alu_1_bit alu23 (A[23], B[23], COUT23, 1'b0, AINV, BINV, Opr, RESULT[23], COUT24, ADD_R[23]); 
alu_1_bit alu24 (A[24], B[24], COUT24, 1'b0, AINV, BINV, Opr, RESULT[24], COUT25, ADD_R[24]); 
alu_1_bit alu25 (A[25], B[25], COUT25, 1'b0, AINV, BINV, Opr, RESULT[25], COUT26, ADD_R[25]); 
alu_1_bit alu26 (A[26], B[26], COUT26, 1'b0, AINV, BINV, Opr, RESULT[26], COUT27, ADD_R[26]);  
alu_1_bit alu27 (A[27], B[27], COUT27, 1'b0, AINV, BINV, Opr, RESULT[27], COUT28, ADD_R[27]); 
alu_1_bit alu28 (A[28], B[28], COUT28, 1'b0, AINV, BINV, Opr, RESULT[28], COUT29, ADD_R[28]); 
alu_1_bit alu29 (A[29], B[29], COUT29, 1'b0, AINV, BINV, Opr, RESULT[29], COUT30, ADD_R[29]); 

alu_1_bit alu30 (A[30], B[30], COUT30, 1'b0, AINV, BINV, Opr, RESULT[30], COUT31, ADD_R[30]);
alu_1_bit alu31 (A[31], B[31], COUT31, 1'b0, AINV, BINV, Opr, RESULT[31], COUT32, ADD_R[31]);
      
endmodule
