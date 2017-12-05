module ALU_Control(
    funct_i,
    ALUOp_i,
    ALUCtrl_o
);
input	[5:0]	funct_i;
input	[1:0]	ALUOp_i;
output	reg [2:0]	ALUCtrl_o;

always @(*) begin
	if (ALUOp_i == 2'b00) begin	//R-type
		if (funct_i == 6'b100000) begin	// add
			ALUCtrl_o = 3'b000;	//add
		end
		if (funct_i == 6'b011000) begin	// mult
			ALUCtrl_o = 3'b001;	//mult
		end
		if (funct_i == 6'b100010) begin	// sub
			ALUCtrl_o = 3'b010;	//sub
		end
		if (funct_i == 6'b100100) begin	// and
			ALUCtrl_o = 3'b011;	//and
		end
		if (funct_i == 6'b100101) begin	// or
			ALUCtrl_o = 3'b100;	//or
		end
	end
	if (ALUOp_i == 2'b01) begin	//addi, lw, sw
		ALUCtrl_o = 3'b000;	// add
	end
	if (ALUOp_i == 2'b10) begin	//beq
		ALUCtrl_o = 3'b010;	// sub
	end
end

endmodule