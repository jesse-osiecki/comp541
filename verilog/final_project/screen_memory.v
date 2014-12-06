`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Jesse Osiecki
//your screen size is 640x480 pixels, and if you decide on each character being 16x16
//pixels, then each row will have 40 characters, and there will be 30 rows. So, your screen memory will need to
//have at least 1200 locations.

module screen_memory(
   input clock,
   input wr,                   // WriteEnable:  if wr==1, data is written into mem
   input [10 : 0] addr,   // Address for specifying memory location
   input [7 : 0] din,    // Data for writing into memory (if wr==1)
   output [7: 0] dout   // Data read from memory (all the time)
   );
   
   
   reg [7 : 0] mem [1199 : 0];   // The actual registers where data is stored
	
	initial $readmemh("smem_values.txt", mem, 0,1199);
   
   always @(posedge clock)     // Memory write: only when wr==1, and only at posedge clock
      if(wr)
         mem[addr] <= din;
   
   assign dout[7:0] = mem[addr];    // Memory read: read all the time, no clock involved
   
endmodule