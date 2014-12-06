//Jesse Osiecki

`timescale 1ns / 1ps

module add_sub #(parameter N=8)(
    input [N-1:0] A,
    input [N-1:0] B,
    input Subtract,
    output [N-1:0] Result,
	 output FlagN, FlagC, FlagV
    );
	
	wire[N-1:0] ToBornottoB;
	
	assign ToBornottoB = (Subtract) ? ~B :B;
	adder #(N) add(A, ToBornottoB, Subtract, Result, FlagN, FlagC, FlagV);

endmodule
