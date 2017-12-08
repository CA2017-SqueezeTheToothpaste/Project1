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

input	[4:0]	IdEx_rs_i;
input	[4:0]	IdEx_rt_i;
input	[4:0]	ExMem_rd_i;
input			ExMem_Wb_i;
input	[4:0]	MemWb_rd_i;
input			MemWb_Wb_i;
output 	[1:0]	ForwardA_o;
output 	[1:0]	ForwardB_o;

reg	[1:0]	ForwardA;
reg	[1:0]	ForwardB;

assign ForwardA_o = ForwardA;
assign ForwardB_o = ForwardB;


always @(*) begin
	ForwardA = 2'b00;
	ForwardB = 2'b00;
	if(ExMem_Wb_i && (ExMem_rd_i != 5'b00000) && (ExMem_rd_i == IdEx_rs_i))begin
		ForwardA = 2'b10;
	end
	if(ExMem_Wb_i && (ExMem_rd_i != 5'b00000) && (ExMem_rd_i == IdEx_rt_i))begin
		ForwardB = 2'b10;
	end
	if(MemWb_Wb_i && (MemWb_rd_i != 5'b00000) && (ExMem_rd_i != IdEx_rs_i) && (MemWb_rd_i == IdEx_rs_i))begin
		ForwardA = 2'b01;
	end
	if(MemWb_Wb_i && (MemWb_rd_i != 5'b00000) && (ExMem_rd_i != IdEx_rt_i) && (MemWb_rd_i == IdEx_rt_i))begin
		ForwardB = 2'b01;
	end
end

endmodule
