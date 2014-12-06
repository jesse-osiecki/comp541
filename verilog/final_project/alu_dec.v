`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Jesse Osiecki
module aludec(input      [5:0] funct,
              input      [1:0] aluop,
              output reg [4:0] alucontrol); // 5 bits for our ALU!!

  always @(*)
    case(aluop)
      2'b01: alucontrol <= 5'b0xx01; // add
      2'b10: alucontrol <= 5'b1xx01; // sub
		2'b11: alucontrol <= 5'b1x011; // lt
      default: 
			case(funct)          // RTYPE
          6'b100000: alucontrol <= 5'b0xx01; // add
			 6'b110000: alucontrol <= 5'b0xx01; // addu
          6'b100010: alucontrol <= 5'b1xx01; // sub
			 6'b100011: alucontrol <= 5'b1xx01; // subu
          6'b100100: alucontrol <= 5'bx0000; // and
          6'b100101: alucontrol <= 5'bx0100; // or
          6'b101010: alucontrol <= 5'b1x011; // slt
			 6'b101011: alucontrol <= 5'b1x111; // sltu
			 6'b001000: alucontrol <= 5'b0xx01; // jr
			 6'b000000: alucontrol <= 5'bx0010; // sll
			 6'b000010: alucontrol <= 5'bx1010; // srl
			 6'b100000: alucontrol <= 5'b0xx01; // add
          6'b100111: alucontrol <= 5'bx1100; // nor                        
			default:   alucontrol <= 5'bxxxxx; // NOOP
        endcase
    endcase
endmodule
