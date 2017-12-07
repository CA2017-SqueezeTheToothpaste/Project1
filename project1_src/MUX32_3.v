module MUX32_3
(
	data1_i,
	data2_i,
	data3_i,
	select_i,
	data_o
);

input  [31:0]	data1_i;
input  [31:0]	data2_i;
input  [31:0]	data3_i;
input  [1:0]	select_i;
output [31:0]	data_o;
reg [31:0]	tmp;

always @(*) begin
	case(select_i)
		2'b00:	tmp = data1_i;
		2'b01:	tmp = data2_i;
		2'b10:	tmp = data3_i;
	endcase
end
assign data_o = tmp;
endmodule
