module HD
(
	if_id_reg_i,
	id_ex_regrt_i,
	id_ex_memrd_i,
	mux_control_o,
	pc_stall_o,
	stallHold_o
);

input	[0:31]	if_id_reg_i;
input	[0:4]	id_ex_regrt_i;
input	id_ex_memrd_i;
output	mux_control_o;
output	pc_stall_o;
output	stallHold_o;

always @(*) begin

	if(id_ex_memrd_i && ((id_ex_regrt_i == if_id_reg_i[21:25]) || (id_ex_regrt_i == if_id_reg_i[16:20]))) begin
	stallHold_o = 1'b1;
	pc_stall_o = 1'b1;
	mux_control_o = 1'b1;
	end
	
end

endmodule