`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: COMP541
// Engineer: Jesse J. Osiecki

module fulladder(
	input A,
	input B,
	input Cin,
	output Sum,
	output Cout);
	
	wire X;
	assign X = A ^ B;
	assign Sum = Cin ^ X;
	assign Cout = (Cin & X) | (A & B);
	
endmodule