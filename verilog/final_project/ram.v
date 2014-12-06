`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//Jesse Osiecki

module imem 
	(input [31:0] pc,
	output [31:0] instr
	);
   
   
   reg [31 : 0] mem [255 : 0];   // The actual registers where data is stored
   
	initial $readmemh("imem_values.txt",mem, 0,127);
   
   assign instr = mem[pc[11:2]];    // Memory read: read all the time, no clock involved
   
endmodule


