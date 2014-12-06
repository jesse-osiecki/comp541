`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//Top level MIPS
// Jesse Osiecki
//
//////////////////////////////////////////////////////////////////////////////////
module top(
        input clk, 
		  input reset, 
		  input ps2_clk, 
		  input ps2_data,
        output [2:0] red, 
		  output [2:0] green,
        output [2:1] blue,
        output hsync,
        output vsync,
        output [7:0] segments,
			output [3:0] digitselect
			//input [15:0] kchar
        );
            clockdivider_Nexys3 clkdv(clk, clk100, clk50, clk25, clk12);
            wire [31:0]pc;
            wire [31:0]instr;
            wire [31:0]dmem_readdata;
            wire [31:0]dmem_writedata;
            wire [31:0]dmem_addr;
            wire dmem_write;
				wire [10:0] screenaddr;
				wire [7:0] charcode;
				wire [15:0] kchar;
 
        	mips mips(clk12, reset, pc, instr, dmem_write, dmem_addr, dmem_writedata, dmem_readdata);		// processor
	
			imem imem(pc[31:0], instr);	// instr memory
						// send full PC to imem
			memIO mem(clk12, dmem_write, dmem_addr, dmem_writedata, dmem_readdata, screenaddr, charcode, kchar);			// data memory
			
			displayunit disp(clk100, screenaddr, charcode, red, green, blue, hsync, vsync);

			keyboard keyb(clk100, ps2_clk, ps2_data, kchar);
         display4digit display4digit(kchar, clk100, segments, digitselect);
endmodule
