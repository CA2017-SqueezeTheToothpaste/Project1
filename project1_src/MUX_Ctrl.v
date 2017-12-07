module MUX_Ctrl
(
	select_i,
	ALUSrc_i,
	ALUOp_i,
	RegDst_i,
	MemWr_i,
	MemRd_i,
	MemtoReg_i,
	RegWr_i,
	ALUSrc_o,
	ALUOp_o,
	RegDst_o,
	MemWr_o,
	MemRd_o,
	MemtoReg_o,
	RegWr_o
);

input	select_i;
input	ALUSrc_i, RegDst_i, MemWr_i, MemRd_i, MemtoReg_i, RegWr_i;
input	[1:0]	ALUOp_i;
output	ALUSrc_o, RegDst_o, MemWr_o, MemRd_o, MemtoReg_o, RegWr_o;
output	[1:0]	ALUOp_o;

assign ALUSrc_o = select_i ? 1'b0 : ALUSrc_i ;
assign RegDst_o = select_i ? 1'b0 : RegDst_i ;
assign MemWr_o = select_i ? 1'b0 : MemWr_i ;
assign MemRd_o = select_i ? 1'b0 : MemRd_i;
assign MemtoReg_o = select_i ? 1'b0 : MemtoReg_i ;
assign RegWr_o = select_i ? 1'b0 : RegWr_i ;
assign ALUOp_o = select_i ? 2'b00 : ALUOp_i ;
endmodule
