`timescale 1ns / 1ps
`include "display640x480.v"
//////////////////////////////////////////////////////////////////////////////////
// Jesse Osiecki	
module displayunit(
	input clock,
	output [10 : 0] screenaddr,
	input [7:0] charcode,
	output [2:0] red,
	output [2:0] green,
   output [2:1] blue,
   output hsync,
   output vsync
    );
	wire activevideo;
	wire [11:0] bitmapaddr;
	wire [9:0]x;
	wire [9:0]y;
	wire [9:0]x_40;
	wire [9:0]y_30;
	wire [7:0] RGB;
	
	//wire [10 : 0] screenaddr;
	//wire [7:0] charcode;
	//screen_memory smem(clock, 0, screenaddr, 0, charcode);

	assign y_30 =  y>>4;//divide by 16
    assign x_40 = x>>4;//divide by 16
	assign screenaddr = (activevideo == 1) ? (((y_30 << 5) + (y_30 << 3)) + x_40): 11'b0;
	//assign screenaddr = (activevideo == 1) ? ((y_30 *40) + x_40) : 11'b0;
	assign bitmapaddr = { charcode[3:0] , y[3:0] , x[3:0] };
	
	
	bitmap_memory bmem(clock, bitmapaddr, RGB);
	vgatimer timer(clock, hsync, vsync, activevideo, x, y);
   assign red[2:0]   = (activevideo == 1) ? RGB[7:5] : 3'b0;
   assign green[2:0] = (activevideo == 1) ? RGB[4:2] : 3'b0;
   assign blue[2:1]  = (activevideo == 1) ? RGB[1:0] : 2'b0;
	
	
	

endmodule
