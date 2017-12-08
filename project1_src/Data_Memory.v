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
reg	[7:0]	memory	[0:31];
reg [31:0]	tmp;

wire	[4:0]	addr;

assign addr = addr_i[4:0];
assign RdData_o = tmp;

wire	[7:0]	m0,m1,m2,m3,m4,m5,m6,m7,m8,m9,m10,m11;

assign m0 = memory[0];
assign m1 = memory[1];
assign m2 = memory[2];
assign m3 = memory[3];
assign m4 = memory[4];
assign m5 = memory[5];
assign m6 = memory[6];
assign m7 = memory[7];
assign m8 = memory[8];
assign m9 = memory[9];
assign m10 = memory[10];
assign m11 = memory[11];

always @(MemWr_i | MemRd_i) begin
	if (MemWr_i == 1) begin
		memory[addr] = WrData_i[7:0];
		memory[addr+5'b00001] = WrData_i[15:8];
		memory[addr+5'b00010] = WrData_i[23:16];
		memory[addr+5'b00011] = WrData_i[31:24];
	end
	else begin
		if (MemRd_i == 1) begin
			tmp[7:0] = memory[addr];
			tmp[15:8] = memory[addr+5'b00001];
			tmp[23:16] = memory[addr+5'b00010];
			tmp[31:24] = memory[addr+5'b00011];
		end
	end
end
endmodule
