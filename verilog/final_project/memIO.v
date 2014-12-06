`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Jesse Osiecki
module memIO(
   input clock,
   input dmem_write,                   // WriteEnable:  if wr==1, data is written into mem
   input [31 : 0] dmem_addr,   // Address for specifying memory location
   input [31 : 0] dmem_writedata,    // Data for writing into memory (if wr==1)
   output [31 : 0] dmem_readdata,   // Data read from memory (all the time)
	input [10:0] screenaddr,
	output [7:0] charcode,
    input [15:0] kchar
   );
    assign dmem_readdata = (dmem_addr[14:13] === 2'b01) ? dmem_readdata_new : ( (dmem_addr[14:13] === 2'b11) ? {16'b0, kchar[15:0]} : ((dmem_addr[14:13] === 2'b10) ? charcode : 32'b0) );
    //assign dmem_readdata = (dmem_addr[14:13] == 2'b01) ? dmem_readdata_new :((dmem_addr[14:13] == 2'b10) ? charcode : 32'b0);

	wire [31:0] dmem_addr_new;
	assign dmem_addr_new = (dmem_addr[14:13] === 2'b01) ? { 19'b0, dmem_addr[12:0]} : 32'b0;
	
	wire dmem_write_new;
	wire[31:0] dmem_readdata_new;
	assign dmem_write_new = (dmem_addr[14:13] === 2'b01) ? dmem_write :  1'b0;
	
	dmem dmem(clock, dmem_write_new, dmem_addr_new, dmem_writedata, dmem_readdata_new);			// data memory
	
	wire [10:0] screenaddr_new;
	assign screenaddr_new = (dmem_addr[14:13] === 2'b10) ? dmem_addr[10:0] : screenaddr;
	//assign screenaddr_new =  screenaddr;
	
	wire smem_write;
	assign smem_write = (dmem_addr[14:13] === 2'b10) ? dmem_write: 1'b0;
	
	screen_memory smem(clock, smem_write, screenaddr_new, dmem_writedata[7:0], charcode); 
	//screen_memory smem(clock, 0, screenaddr_new, 0, charcode);//video memory
endmodule
