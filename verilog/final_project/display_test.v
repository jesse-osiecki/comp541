`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   22:02:18 11/16/2014
// Design Name:   displayunit
// Module Name:   /home/jesse/ownCloud/school/comp541/verilog/lab11/display_test.v
// Project Name:  lab11
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: displayunit
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module display_test;

	// Inputs
	reg clock;

	// Outputs
	wire [2:0] red;
	wire [2:0] green;
	wire [2:1] blue;
	wire hsync;
	wire vsync;

	// Instantiate the Unit Under Test (UUT)
	displayunit uut (
		.clock(clock), 
		.red(red), 
		.green(green), 
		.blue(blue), 
		.hsync(hsync), 
		.vsync(vsync)
	);

	initial begin
		// Initialize Inputs
		clock = 0;

		// Wait 100 ns for global reset to finish
		#1000;
        
		// Add stimulus here

	end
	initial begin
      #0.5 clock = 0;
      forever
         #0.5 clock = ~clock;
   end
      
endmodule

