module Shift_left3232
(
	in_i,
	out_o
);
input	[31:0]	in_i;
output	[31:0]	out_o;

assign out_o = (in_i<<2);
endmodule