module keyboard_test(
	input clk,
	input ps2_data,
	input ps2_clk,
	output [15:0] char,
	output [7:0] segments,
   output [3:0] digitselect
   );
 
	keyboard keyb(clk, ps2_clk, ps2_data, char);
   
	display4digit disp(char, clk, segments, digitselect);

endmodule

