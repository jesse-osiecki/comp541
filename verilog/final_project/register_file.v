`timescale 1ns / 1ps

module register_file #(
   parameter Abits = 5,        // Number of bits in address
   parameter Dbits = 32,        // Number of bits in data
   parameter Nloc = 32         // Number of memory locations
)(
   input clock,
   input RegWrite = 0,                   // WriteEnable:  if wr==1, data is written into mem	
   input [Abits-1 : 0] ReadAddr1 = 0,   // Address for specifying memory location
	input [Abits-1 : 0] ReadAddr2 = 0,
	input [Abits-1 : 0] WriteAddr = 0,
   input [Dbits-1 : 0] WriteData = 0,    // Data for writing into memory (if wr==1)
   output [Dbits-1 : 0] ReadData1,
	output [Dbits-1 : 0] ReadData2  // Data read from memory (all the time)
   );
   
   reg [Dbits-1 : 0] register_file [Nloc-1 : 0];   // The actual registers where data is stored
	
	
   always @(posedge clock)     // Memory write: only when wr==1, and only at posedge clock
      if(RegWrite)
         register_file[WriteAddr] <= WriteData;

   
   assign ReadData1 = (ReadAddr1 == 0)? 0 : register_file[ReadAddr1];    // Memory read: read all the time, no clock involved
	assign ReadData2 = (ReadAddr2 == 0)? 0 : register_file[ReadAddr2];    // Memory read: read all the time, no clock involved

   
endmodule
