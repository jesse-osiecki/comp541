`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Jesse Osiecki
module maindec(input  [5:0] op,
               output       memtoreg, memwrite, branch, alusrc,
               output       regdst, regwrite, jump, jal,
               output [1:0] aluop);		// different for our ALU

  reg [9:0] controls;

  assign {regwrite, regdst, alusrc,
          branch, memwrite, memtoreg, jump, jal, 
			 aluop} = controls;

  always @(*)
    case(op)
      6'h00: controls <= 10'b110_00000_00; //Rtype
      6'h23: controls <= 10'b101_00100_01; //LW
      6'h2b: controls <= 10'b001_01000_01; //SW
      6'h04: controls <= 10'b000_10000_10; //BEQ
		6'h05: controls <= 10'b000_10000_10; //BNE
      6'h08: controls <= 10'b101_00000_01; //ADDI
		6'h0a: controls <= 10'b101_00000_11; //SLTI
      6'h02: controls <= 10'b000_00010_00; //J
		6'h03: controls <= 10'b100_00011_00; //JAL
      default:   controls <= 10'b0xx_00000_xx; //TIP: put controls for NOP here!
    endcase
endmodule
