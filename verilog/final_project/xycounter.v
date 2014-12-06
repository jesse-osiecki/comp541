`timescale 1ns / 1ps
module xycounter #(parameter width=4, height=3) (
	input clk,
	input on,
	output reg [$clog2(width)-1:0] x=0,
	output reg [$clog2(height)-1:0] y=0
    );
	 
	 always @(posedge clk)
		if(on)
		begin
			if (x == width-1)
			begin
					x = 0;
					if (y == height-1)
						y = 0;
					else
						y= y + 1;
			end
			else
				x= x + 1;

		end


endmodule
