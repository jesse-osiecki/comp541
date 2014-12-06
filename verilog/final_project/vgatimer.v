//`timescale 1ns / 1ps
//`include "display10x4.v"
`include "display640x480.v"
module vgatimer(
	input clk,
	output hsync,
	output vsync,
	output activevideo,
	output [`xbits-1:0] x,
	output [`ybits-1:0] y
    );
	
	//these lines allow you to count at every 2 and 4 clock tick
	
	reg [1:0] clk_count = 0;
	always @(posedge clk)
		clk_count <= clk_count + 2'b01;
	assign Every2ndTick = (clk_count[0] == 1'b1);
	assign Every4thTick = (clk_count[1:0] == 2'b11);
	
	
	//instantiate xy counter using appropriate clock tick counter
	//xycounter xy(clk, 1'b1, x, y); //100 MHz
	//xycounter xy(clk, Every2ndTick, x, y); //50
	
	xycounter #(`WholeLine, `WholeFrame) xy(clk, Every4thTick, x, y); //25 Mhz
	
	//generate the monitor signals
	assign hsync = (x>=`hSyncStart && x<=`hSyncEnd) ? !`hSyncPolarity : `hSyncPolarity;
	assign vsync = (y>=`vSyncStart && y<=`vSyncEnd) ? !`vSyncPolarity : `vSyncPolarity;
	assign activevideo = (x>=`hVisible || y>=`vVisible) ? 1'b0 : 1'b1 ;

endmodule
