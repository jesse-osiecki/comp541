module dmem(
   input clock,
   input wr,                   // WriteEnable:  if wr==1, data is written into mem
   input [31 : 0] addr,   // Address for specifying memory location
   input [31 : 0] din,    // Data for writing into memory (if wr==1)
   output [31 : 0] dout   // Data read from memory (all the time)
   );
   
   
   reg [31 : 0] mem [255: 0];   // The actual registers where data is stored
	initial $readmemh("dmem_values.txt", mem, 0,255);
   
   always @(posedge clock)     // Memory write: only when wr==1, and only at posedge clock
      if(wr)
         mem[addr[31:2]] <= din;
   
   assign dout = mem[addr[31:2]];    // Memory read: read all the time, no clock involved
   //addr[Abits-1:2]
endmodule