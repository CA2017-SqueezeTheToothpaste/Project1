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

assign ALUSrc_o = select_i ? ALUSrc_i : 1'b0;
assign RegDst_o = select_i ? RegDst_i : 1'b0;
assign MemWr_o = select_i ? MemWr_i : 1'b0;
assign MemRd_o = select_i ? MemRd_i : 1'b0;
assign MemtoReg_o = select_i ? MemtoReg_i : 1'b0;
assign RegWr_o = select_i ? RegWr_i : 1'b0;
assign ALUOp_o = select_i ? ALUOp_i : 2'b00;
endmodule
