//Jesse Osiecki

`timescale 1ns / 1ps

module shifter #(parameter N=8)(
	input signed [N-1:0] IN,
	input [4:0] shamt,
	input left, input logical,
	output [N-1:0] OUT
    );
	 
	 assign OUT = left ? (IN << shamt) :
						(logical ? (IN >>> shamt) : (IN >> shamt)) ;


endmodule
