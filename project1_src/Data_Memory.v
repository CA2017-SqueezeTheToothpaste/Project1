module Data_Memory
(
    addr_i,
    WrData_i,
    MemWr_i,
    MemRd_i,
    RdData_o
);

// Interface
input   [31:0]	addr_i, WrData_i;
input	MemRd_i, MemWr_i;
output	[31:0]	RdData_o;

// Instruction memory
reg	[31:0]	memory	[0:7];
reg [31:0]	tmp;

reg	[2:0]	addr;
assign addr = addr_i[2:0];

always @(*) begin
	if (MemWr_i == 1) begin
		memory[addr] = WrData_i;
	end
	else begin
		if (MemRd_i == 1) begin
			tmp = memory[addr];
		end
	end
end
assign RdData_o = tmp;
endmodule
