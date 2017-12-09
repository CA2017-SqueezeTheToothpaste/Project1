module Registers
(
    clk_i,
    RSaddr_i,
    RTaddr_i,
    RDaddr_i, 
    RDdata_i,
    RegWrite_i, 
    RSdata_o, 
    RTdata_o 
);

// Ports
input               clk_i;
input   [4:0]       RSaddr_i;
input   [4:0]       RTaddr_i;
input   [4:0]       RDaddr_i;
input   [31:0]      RDdata_i;
input               RegWrite_i;
output	[31:0]      RSdata_o; 
output	[31:0]      RTdata_o;

// Register File
reg     [31:0]      register        [0:31];
//reg		[31:0]		RSdata;
//reg		[31:0]		RTdata;


assign	RSdata_o = (RegWrite_i && (RSaddr_i == RDaddr_i) && (RDaddr_i != 5'b0)) ? RDdata_i : register[RSaddr_i];
assign	RTdata_o = (RegWrite_i && (RTaddr_i == RDaddr_i) && (RDaddr_i != 5'b0)) ? RDdata_i : register[RTaddr_i];



always@(posedge clk_i) begin
    if(RegWrite_i && (RDaddr_i != 5'b0))
        register[RDaddr_i] = RDdata_i;
	//RSdata = register[RSaddr_i];
	//RTdata = register[RTaddr_i];
	
end

// Write then read Data   
/*
always@(posedge clk_i) begin
    if(RegWrite_i)
        register[RDaddr_i] = RDdata_i;
	#1
	RSdata = register[RSaddr_i];
	RTdata = register[RTaddr_i];

end*/


  
endmodule 
