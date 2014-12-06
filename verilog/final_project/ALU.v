//Jesse Osiecki

`timescale 1ns / 1ps
 module ALU #(parameter N=32)(
	input [N-1:0] A,
	input [N-1:0] B,
	output [N-1:0] R,
	input [4:0] ALUfn,
	output FlagZ
    );
	
	assign {subtract, bool1, bool0, shft, math} = ALUfn[4:0];
	
	wire [N-1:0] addsubResult, shiftResult, logicalResult;
	wire comparisonResult, FlagN, FlagC, FlagV;
	
	add_sub #(N) AS(A, B, subtract, addsubResult, FlagN, FlagC, FlagV);
	shifter #(N) S(B, A[4:0], ~bool1, bool0 , shiftResult);
	logical #(N) L(A, B, { bool1, bool0}, logicalResult);
	comparator C(FlagN, FlagV, FlagC, bool0, comparisonResult);
	
	assign R = (~shft & math)? (addsubResult) :
					(shft & ~math) ? (shiftResult):
					(~shft & ~math) ? (logicalResult) :(comparisonResult) ;
	
	assign FlagZ = (~| R);

endmodule
