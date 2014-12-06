`timescale 1ns / 1ps

module datapath#(
   parameter Abits = 32,        // Number of bits in address
   parameter Dbits = 32,        // Number of bits in data
   parameter Nloc = 16         // Number of memory locations
)( input clock, reset, memtoreg, pcsrc, alusrc, regdst, regwrite, jump, jal, jumpR,
	input [4:0] ALUFN,
	output FlagZ,
	output reg [31:0]pc = 32'b0,
	input [31:0]instr,
   output [31:0]aluresult,
	output [31:0]writedata,
   input [31:0]readdata,
	input do_shift
	);

	wire [4:0] writeaddr;
   wire [31:0] result, readdata1_reg, readdata2_reg, srca, srcb, signimmediate;
	
	wire [31:0] pcPlus4;
	assign pcPlus4 = pc + 32'd4;
	wire [31:0] pcBranch;
	assign pcBranch = pcPlus4 + {signimmediate[29:0], 2'b0};
	
   always @(posedge clock) pc <= jumpR || jump ? (jumpR ? result : {pcPlus4[31:28], instr[25:0], 2'b0}) : (pcsrc ? pcBranch : pcPlus4); /// WHAT NOW??
	
	assign signimmediate = { {16{instr[15]} },  instr[15:0]};
   assign writeaddr = jal ? 5'd31 : (regdst ? instr[15:11] : instr[20:16]);
	assign srca = do_shift ? { 17'b0, instr[10:6]} : readdata1_reg;
   assign srcb = alusrc ? signimmediate : readdata2_reg;
	
	ALU #(Dbits) alu(srca, srcb, aluresult, ALUFN, FlagZ);
	register_file regs(clock, regwrite, instr[25:21], instr[20:16], writeaddr, result, readdata1_reg, readdata2_reg);
	
	assign result = jal ? pcPlus4 : memtoreg ? readdata : aluresult;
	assign writedata = readdata2_reg;
	

endmodule
