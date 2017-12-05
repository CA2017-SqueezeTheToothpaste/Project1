module IFID_Reg 
(
    clk_i,
    stallHold_i,	//for the 1 stall cycle needed due to lw and immediate access to associated registers -> need to hold register value
	flush_i,		//for taken brench stall -> need to clean register value
	nextInstrAddr_i,
    instr_i,
	nextInstrAddr_o, 
    instr_o
);

// Ports
input               clk_i;
input               stallHold_i;
input				flush_i;
input   [31:0]      nextInstrAddr_i;
input	[31:0]		instr_i;
output  [31:0]      nextInstrAddr_o; 
output  [31:0]      instr_o;

// Register File
reg     [31:0]      nextInstrAddr;
reg		[31:0]		instr;

// Read Data      
assign  nextInstrAddr_o = nextInstrAddr;
assign  instr_o = instr;

// Write Data   
always@(posedge clk_i) begin
	if (stallHold_i) begin 
		//do exactly nothing to maintain original value
	end
	else if (flush_i) begin
		//clean all data to stall
		nextInstrAddr <= 32'h00000000; 
		instr <= 32'h00000000;
	end
	else begin
		//default is to save input to pipeline register
		nextInstrAddr <= nextInstrAddr_i;
		instr <= instr_i;
	end
end
   
endmodule 
