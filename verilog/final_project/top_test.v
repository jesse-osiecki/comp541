`timescale 1ns / 1ps
module top_test;

	// Inputs
	reg clk;
	reg reset;
	reg ps2_clk;
	reg ps2_data;
	// Outputs
	wire [2:0] red;
	wire [2:0] green;
	wire [2:1] blue;
	wire hsync;
	wire vsync;

	// Instantiate the Unit Under Test (UUT)
	top uut (
		.clk(clk), 
		.reset(reset), 
		.ps2_clk(ps2_clk), 
		.ps2_data(ps2_data), 
		.red(red), 
		.green(green), 
		.blue(blue), 
		.hsync(hsync), 
		.vsync(vsync)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 0;
		ps2_clk = 0;
		ps2_data = 0;

		// Wait 100 ns for global reset to finish
		#0;
        
		// Add stimulus here

	end
 
	initial begin
      forever
			#0.5 clk = ~clk;
   end
endmodule

