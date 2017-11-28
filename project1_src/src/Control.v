module Control
(
    Op_i,
    RegDst_o,
    ALUOp_o,
    ALUSrc_o,
    RegWrite_o 
);
	input [5:0] Op_i;
	output reg RegDst_o;
	output reg [1:0]ALUOp_o;
	output reg ALUSrc_o;
	output reg RegWrite_o;
	always @(*) begin
	  case (Op_i)
	    6'b000000: begin
		RegDst_o   = 1'b1;
		ALUOp_o    = 2'b10;
		ALUSrc_o   = 1'b0;
		RegWrite_o = 1'b1; 
	    end
  	    default:  begin
		RegDst_o   = 1'b0;
		ALUOp_o    = 2'b00;
		ALUSrc_o   = 1'b1;
		RegWrite_o = 1'b1;
	     end
	   endcase
	end
endmodule
