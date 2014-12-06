//Jesse Osiecki

`timescale 1ns / 1ps

module comparator(
	input FlagN,
	FlagV,
	FlagC,
	bool0,
	output comparison
	);
	
	assign comparison = ( (~bool0 & (FlagN ^ FlagV)) | (bool0 & (~FlagC)) ) ? 1 : 0;
	//assign comparison = bool0 ? (~FlagC) : (FlagN ^ FlagV);
endmodule
