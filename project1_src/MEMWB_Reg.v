module MEMWB_Reg 
(
	clk_i,
	writeBack_i,
	memtoReg_i,
	memReadData_i,
	ALUresult_i,
	regDstAddr_i,
	
	writeBack_o,
	memtoReg_o,
	memReadData_o,
	ALUresult_o,
	regDstAddr_o
);

// Ports
input				clk_i;
input				writeBack_i;
input				memtoReg_i;
input	[31:0]		memReadData_i;
input	[31:0]		ALUresult_i;
input	[4:0]		regDstAddr_i;

output				writeBack_o;
output				memtoReg_o;
output	[31:0]		memReadData_o;
output	[31:0]		ALUresult_o;
output	[4:0]		regDstAddr_o;

// Register File

reg				writeBack;
reg				memtoReg;
reg	[31:0]		memReadData;
reg	[31:0]		ALUresult;
reg	[4:0]		regDstAddr;

// Read Data	  

assign writeBack_o = writeBack;
assign memtoReg_o = memtoReg;
assign memReadData_o = memReadData;
assign ALUresult_o = ALUresult;
assign regDstAddr_o = regDstAddr;

// Write Data   
always@(posedge clk_i) begin
	
	writeBack <= writeBack_i;
	memtoReg <= memtoReg_i;
	memReadData <= memReadData_i;
	ALUresult <= ALUresult_i;
	regDstAddr <= regDstAddr_i;
	
end
   
endmodule 
