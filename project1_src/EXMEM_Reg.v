module EXMEM_Reg 
(
	clk_i,
	writeBack_i,
	memtoReg_i,
	memRead_i,
	memWrite_i,
	ALUresult_i,
	memWriteData_i,
	regDstAddr_i,
	
	writeBack_o,
	memtoReg_o,
	memRead_o,
	memWrite_o,
	ALUresult_o,
	memWriteData_o,
	regDstAddr_o
);

// Ports
input				clk_i;
input				writeBack_i;
input				memtoReg_i;
input				memRead_i;
input				memWrite_i;
input	[31:0]		ALUresult_i;
input	[31:0]		memWriteData_i;
input	[4:0]		regDstAddr_i;

output				writeBack_o;
output				memtoReg_o;
output				memRead_o;
output				memWrite_o;
output	[31:0]		ALUresult_o;
output	[31:0]		memWriteData_o;
output	[4:0]		regDstAddr_o;

// Register File

reg				writeBack;
reg				memtoReg;
reg				memRead;
reg				memWrite;
reg	[31:0]		ALUresult;
reg	[31:0]		memWriteData;
reg	[4:0]		regDstAddr;

// Read Data	  

assign writeBack_o = writeBack;
assign memtoReg_o = memtoReg;
assign memRead_o = memRead;
assign memWrite_o = memWrite;
assign ALUresult_o = ALUresult;
assign memWriteData_o = memWriteData;
assign regDstAddr_o = regDstAddr;

// Write Data   
always@(posedge clk_i) begin
	
	writeBack <= writeBack_i;
	memtoReg <= memtoReg_i;
	memRead <= memRead_i;
	memWrite <= memWrite_i;
	ALUresult <= ALUresult_i;
	memWriteData <= memWriteData_i;
	regDstAddr <= regDstAddr_i;
	
end
   
endmodule 
