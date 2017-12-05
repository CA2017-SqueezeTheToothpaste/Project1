module Eq
(
	rd1_i,
	rd2_i,
	eq_o
);

input	[0:31]	rd1_i;
input	[0:31]	rd2_i;
output	eq_o;

assign eq_o = (rd1_i == rd2_i) ? 1'b1 : 1'b0;

endmodule