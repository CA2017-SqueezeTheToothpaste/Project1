module Shift_left2628
(
	in_i,
	out_o
);
input	[25:0]	in_i;
output	[27:0]	out_o;

assign out_o = (in_i<<2);
endmodule