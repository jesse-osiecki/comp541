`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//Jesse Osiecki
//MIPS
module mips(input clk, reset,
            output [31:0] pc,
            input  [31:0] instr,
            output        memwrite,
            output [31:0] dataaddr,
				output [31:0] writedata,
            input  [31:0] readdata);

  wire        memtoreg, branch, pcsrc, alusrc, regdst, regwrite, jump, jal, jumpR, do_shift;
  wire [4:0]  ALUFN;
  wire flagZ;
  wire [5:0]op;
  wire [5:0] funct;
  assign funct = instr[5:0];
  assign op = instr[31:26];
  assign do_shift = (funct==6'h00 || funct==6'h02) & op==6'b000000;
  
  controller c(op, funct, flagZ,
               memtoreg, memwrite, pcsrc, 
               alusrc, regdst, regwrite, jump, jal, jumpR,	
               ALUFN);
  datapath dp(clk, reset, memtoreg, pcsrc,
              alusrc, regdst, regwrite, jump, jal, jumpR,
              ALUFN, flagZ, pc, instr,
              dataaddr, writedata, readdata, do_shift);
endmodule