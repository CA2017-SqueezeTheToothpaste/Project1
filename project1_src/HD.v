module HD
(
	instr_11_25_i,
	instr_16_20_i,
	id_ex_memrd_i,
	mux_control_o,
	pc_stall_o,
	stallHold_o
);

input	instr_11_25_i;
input	instr_16_20_i;
input	id_ex_memrd_i;
output	mux_control_o;
output	pc_stall_o;
output	stallHold_o;