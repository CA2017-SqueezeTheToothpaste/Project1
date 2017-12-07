module Control
(
	Op_i,
    ALUSrc_o,
	ALUOp_o,
	RegDst_o,
	MemWr_o,
	MemRd_o,
	MemtoReg_o,
	RegWr_o,
	Branch_o,
	Jump_o
);

input	[5:0]	Op_i;
output	reg ALUSrc_o, RegDst_o, MemWr_o, MemRd_o, MemtoReg_o, RegWr_o, Branch_o, Jump_o;
output	reg [1:0]	ALUOp_o;

always @(*) 
	begin
	case(Op_i)
	6'b000000:begin //add, sub, mult, and, or (R-types)
		RegDst_o = 1'b1;
		ALUSrc_o = 1'b0;
		MemtoReg_o = 1'b0;
		RegWr_o = 1'b1;
		MemWr_o = 1'b0;
		MemRd_o = 1'b0;
		Branch_o = 1'b0;
		Jump_o = 1'b0;
		ALUOp_o = 2'b00;	//R-tyoe
		end
	6'b001000:begin //addi
		RegDst_o = 1'b0;
		ALUSrc_o = 1'b1;
		MemtoReg_o = 1'b0;
		RegWr_o = 1'b1;
		MemWr_o = 1'b0;
		MemRd_o = 1'b0;
		Branch_o = 1'b0;
		Jump_o = 1'b0;
		ALUOp_o = 2'b01;	// add
		end
	6'b100011:begin //lw
		RegDst_o = 1'b0;
		ALUSrc_o = 1'b1;
		MemtoReg_o = 1'b1;
		RegWr_o = 1'b1;
		MemWr_o = 1'b0;
		MemRd_o = 1'b1;
		Branch_o = 1'b0;
		Jump_o = 1'b0;
		ALUOp_o = 2'b01;
	end
	6'b101011:begin //sw
		RegDst_o = 1'b0; // x
		ALUSrc_o = 1'b1;
		MemtoReg_o = 1'b0; // x
		RegWr_o = 1'b0;
		MemWr_o = 1'b1;
		MemRd_o = 1'b0;
		Branch_o = 1'b0;
		Jump_o = 1'b0;
		ALUOp_o = 2'b01;
	end
	6'b000100:begin //beq
		RegDst_o = 1'b0; // x
		ALUSrc_o = 1'b0;
		MemtoReg_o = 1'b0; // x
		RegWr_o = 1'b0;
		MemWr_o = 1'b0;
		MemRd_o = 1'b0;
		Branch_o = 1'b1;
		Jump_o = 1'b0;
		ALUOp_o = 2'b10;	// subtract
	end
	6'b000010:begin //jump
		RegDst_o = 1'b0; // x
		ALUSrc_o = 1'b0; // x
		MemtoReg_o = 1'b0; // x
		RegWr_o = 1'b0;
		MemWr_o = 1'b0;
		MemRd_o = 1'b0;
		Branch_o = 1'b0;
		Jump_o = 1'b1;
		ALUOp_o = 2'b01;	// x
	end
	endcase
end
endmodule
