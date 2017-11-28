module ALU
(
    data1_i,
    data2_i,
    ALUCtrl_i,
    data_o,
    Zero_o
);
input  [31:0]data1_i;
input  [31:0]data2_i;
input  [2:0]ALUCtrl_i;
output reg [31:0]data_o;
output reg [31:0]Zero_o;

	always @(*) begin
	        Zero_o = {32{1'b0}};
		case (ALUCtrl_i)
			3'b010:
		  	 data_o = data1_i + data2_i;
			3'b110:
			 data_o = data1_i - data2_i;
			3'b000:
			 data_o = data1_i & data2_i;
			3'b001:
			 data_o = data1_i | data2_i;
			3'b111:
			 data_o = data1_i * data2_i;
			default:
			 data_o = {32{1'b0}};
		endcase
	end
endmodule
