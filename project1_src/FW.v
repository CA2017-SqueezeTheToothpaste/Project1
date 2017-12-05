module FW
(
	IdEx_rs_i,
	IdEx_rt_i,
	ExMem_rd_i,
	ExMem_Wb_i,
	MemWb_rd_i,
	MemWb_Wb_i,
	ForwardA_o,
	ForwardB_o
);

input	[0:4]	IdEx_rs_i;
input	[0:4]	IdEx_rt_i;
input	[0:4]	ExMem_rd_i;
input			ExMem_Wb_i;
input	[0:4]	MemWb_rd_i;
input			MemWb_Wb_i;
output 	[0:1]	ForwardA_o;
output 	[0:1]	ForwardB_o;

always @(*) begin
	assign ForwardA_o = 2'b00;
	assign ForwardB_o = 2'b00;
	if(ExMem_Wb_i && (ExMem_rd_i != 5'b00000) && (ExMem_rd_i == IdEx_rs_i))begin
		ForwardA_o = 2'b10;
	end
	if(ExMem_Wb_i && (ExMem_rd_i != 5'b00000) && (ExMem_rd_i == IdEx_rt_i))begin
		ForwardB_o = 2'b10;
	end
	if(MemWb_Wb_i && (MemWb_rd_i != 5'b00000) && (ExMem_rd_i != IdEx_rs_i) && (MemWb_rd_i == IdEx_rs_i))begin
		ForwardA_o = 2'b01;
	end
	if(MemWb_Wb_i && (MemWb_rd_i != 5'b00000) && (ExMem_rd_i != IdEx_rt_i) && (MemWb_rd_i == IdEx_rt_i))begin
		ForwardB_o = 2'b01;
	end
end

endmodule