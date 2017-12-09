module Data_Memory
(
	clk_i,
    addr_i,
    WrData_i,
    MemWr_i,
    MemRd_i,
    RdData_o
);

// Interface
input	clk_i;
input   [31:0]	addr_i, WrData_i;
input	MemRd_i, MemWr_i;
output	[31:0]	RdData_o;

// Instruction memory
reg	[7:0]	memory	[0:31];
reg [31:0]	tmp;

wire	[4:0]	addr;

assign addr = addr_i[4:0];
assign RdData_o = tmp;

always @(addr_i or MemRd_i) begin
	if (MemRd_i) begin
		tmp[7:0] = memory[addr];
		tmp[15:8] = memory[addr+5'b00001];
		tmp[23:16] = memory[addr+5'b00010];
		tmp[31:24] = memory[addr+5'b00011];
	end
end

always @(posedge clk_i) begin
	if (MemWr_i) begin
		memory[addr] = WrData_i[7:0];
		memory[addr+5'b00001] = WrData_i[15:8];
		memory[addr+5'b00010] = WrData_i[23:16];
		memory[addr+5'b00011] = WrData_i[31:24];
	end
	
end


endmodule
