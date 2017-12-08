module HD
(
	if_id_reg_i,
	id_ex_regrt_i,
	id_ex_memrd_i,
	mux_control_o,
	pc_stall_o,
	stallHold_o
);

input	[31:0]	if_id_reg_i;
input	[4:0]	id_ex_regrt_i;
input	id_ex_memrd_i;
output	mux_control_o;
output	pc_stall_o;
output	stallHold_o;

reg	stallHold;
reg	pc_stall;
reg	mux_control;

always @(*) begin
	stallHold = 1'b0;
	pc_stall = 1'b0;
	mux_control = 1'b0;
	
	if(id_ex_memrd_i && ((id_ex_regrt_i == if_id_reg_i[25:21]) || (id_ex_regrt_i == if_id_reg_i[20:16]))) begin
	stallHold = 1'b1;
	pc_stall = 1'b1;
	mux_control = 1'b1;
	end
end

assign	stallHold_o = stallHold;
assign	pc_stall_o = pc_stall;
assign	mux_control_o = mux_control;

endmodule
