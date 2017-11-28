module ALU_Control 
(
    funct_i,
    ALUOp_i,
    ALUCtrl_o
);
input  [5:0]funct_i;
input  [1:0]ALUOp_i;
output reg [2:0]ALUCtrl_o;
    localparam ADD       = 6'b100000;
    localparam SUB       = 6'b100010;
    localparam AND       = 6'b100100;
    localparam OR        = 6'b100101;
    localparam MUL       = 6'b011000;
	localparam typeI 	 = 2'b00;
	localparam typeR 	 = 2'b10;
	
	
	always @(*)begin
		case (ALUOp_i)
			typeI: begin
			ALUCtrl_o = 3'b010;
			end
			typeR: begin
				case(funct_i)
					ADD: ALUCtrl_o = 3'b010;
					SUB: ALUCtrl_o = 3'b110;
					AND: ALUCtrl_o = 3'b000;
					OR : ALUCtrl_o = 3'b001;
					MUL: ALUCtrl_o = 3'b111;
				endcase
			end
			default: begin
				ALUCtrl_o = 3'b100;
			end
		endcase
	end
endmodule
