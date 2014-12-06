`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Jesse Osiecki
module controller(input  [5:0] op,
						input [5:0]  funct,
                  input        flagZ,
                  output       memtoreg, memwrite,
                  output       pcsrc, alusrc,
                  output       regdst, regwrite,
                  output       jump,
						output		jal,
						output	jumpR,
                  output [4:0] alucontrol); 
				// 5 bit ALUFN for our ALU!!
				
		//constants
		localparam beq = 6'h04;
		
		wire [1:0] aluop; 		// This will be different for our ALU
		wire       branch;		// See NOTE on next slide
  
		maindec md(op, memtoreg, memwrite, branch,
             alusrc, regdst, regwrite, jump, jal, aluop);
		aludec  ad(funct, aluop, alucontrol);

		assign pcsrc = branch & (op === beq ? flagZ : ~flagZ);
		assign jumpR = (op==6'b0) && ( (funct==6'h08) || (funct==6'h03) );
		//assign jumpR = (op==6'b0) &&  (funct==6'h08);
    		// handle both beq and bne
endmodule
