module IDEX_Reg 
(
	clk_i,
	writeBack_i,
	memtoReg_i,
	memRead_i,
	memWrite_i,
	ALUSrc_i,
	ALUOp_i,
	regDst_i,
	nextInstrAddr_i,
	reg1Data_i,
	reg2Data_i,
	signExtendResult_i,
	instr25_21_i,
	instr20_16_i,
	instr15_11_i,
	writeBack_o,
	memtoReg_o,
	memRead_o,
	memWrite_o,
	ALUSrc_o,
	ALUOp_o,
	regDst_o,
	nextInstrAddr_o,
	reg1Data_o,
	reg2Data_o,
	signExtendResult_o,
	instr25_21_o,
	instr20_16_o,
	instr15_11_o

);

// Ports
input			clk_i;
input			writeBack_i;
input			memtoReg_i;
input			memRead_i;
input			memWrite_i;
input			ALUSrc_i;
input	[1:0]		ALUOp_i;
input			regDst_i;
input	[31:0]		nextInstrAddr_i;
input	[31:0]		reg1Data_i;
input	[31:0]		reg2Data_i;
input	[31:0]		signExtendResult_i;
input	[4:0]		instr25_21_i;
input	[4:0]		instr20_16_i;
input	[4:0]		instr15_11_i;

output			writeBack_o;
output			memtoReg_o;
output			memRead_o;
output			memWrite_o;
output			ALUSrc_o;
output	[1:0]		ALUOp_o;
output			regDst_o;
output	[31:0]		nextInstrAddr_o;
output	[31:0]		reg1Data_o;
output	[31:0]		reg2Data_o;
output	[31:0]		signExtendResult_o;
output	[4:0]		instr25_21_o;
output	[4:0]		instr20_16_o;
output	[4:0]		instr15_11_o;

// Register File

reg			writeBack;
reg			memtoReg;
reg			memRead;
reg			memWrite;
reg			ALUSrc;
reg	[1:0]		ALUOp;
reg			regDst;
reg	[31:0]		nextInstrAddr;
reg	[31:0]		reg1Data;
reg	[31:0]		reg2Data;
reg	[31:0]		signExtendResult;
reg	[4:0]		instr25_21;
reg	[4:0]		instr20_16;
reg	[4:0]		instr15_11;

// Read Data	  

assign writeBack_o = writeBack;
assign memtoReg_o = memtoReg;
assign memRead_o = memRead;
assign memWrite_o = memWrite;
assign ALUSrc_o = ALUSrc;
assign ALUOp_o = ALUOp;
assign regDst_o = regDst;
assign nextInstrAddr_o = nextInstrAddr;
assign reg1Data_o = reg1Data;
assign reg2Data_o = reg2Data;
assign signExtendResult_o = signExtendResult;
assign instr25_21_o = instr25_21;
assign instr20_16_o = instr20_16;
assign instr15_11_o = instr15_11;

// Write Data   
always@(posedge clk_i) begin
	
	writeBack <= writeBack_i;
	memtoReg <= memtoReg_i;
	memRead <= memRead_i;
	memWrite <= memWrite_i;
	ALUSrc <= ALUSrc_i;
	ALUOp <= ALUOp_i;
	regDst <= regDst_i;
	nextInstrAddr <= nextInstrAddr_i;
	reg1Data <= reg1Data_i;
	reg2Data <= reg2Data_i;
	signExtendResult <= signExtendResult_i;
	instr25_21 <= instr25_21_i;
	instr20_16 <= instr20_16_i;
	instr15_11 <= instr15_11_i;
	
end
   
endmodule 
