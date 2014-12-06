`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Jesse Osiecki
module bitmap_memory(
   input clock, 
   input [11 : 0] addr,   // Address for specifying memory location
   output [7: 0] dout   // Data read from memory (all the time)
   );
      
	reg [7 : 0] mem [4095 : 0];   //  256 * 16 -1 locations so 12 bit addr, each is one pixel	
	
	initial $readmemh("bmem_values.txt", mem, 0,4095);
   
   assign dout = mem[addr];    // Memory read: read all the time, no clock involved
   
endmodule
