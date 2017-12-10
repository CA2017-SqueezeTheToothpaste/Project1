module CPU
(
    clk_i, 
    rst_i,
    start_i
);

// Ports
input               clk_i;
input               rst_i;
input               start_i;

wire [31:0] instruction;
wire [31:0] inst_addr;
wire [31:0] extended;
wire [31:0] Dread1;
wire [31:0]	Add_pc_o;
wire [31:0] Mux1_o;
wire [31:0] IFID_NxtAddr;

PC PC(
    .clk_i      (clk_i),
    .rst_i      (rst_i),
    .start_i    (start_i),
    .pc_i       (MUX2.data_o),
    .stallHold_i(HD.stallHold_o),
	
	.pc_o       (inst_addr)
);

Instruction_Memory Instruction_Memory(
    .addr_i     (inst_addr), 
    
	.instr_o    ()
);


Data_Memory Data_Memory(
	.clk_i		(clk_i),
    .addr_i		(EXMEM_Reg.ALUresult_o),
    .WrData_i	(EXMEM_Reg.memWriteData_o),
    .MemWr_i	(EXMEM_Reg.memWrite_o),
    .MemRd_i	(EXMEM_Reg.memRead_o),
    .RdData_o	()
);


Adder Add_PC(
    .data1_in   (inst_addr),
    .data2_in   (32'd4),
    
	.data_o     (Add_pc_o)
);

Adder ADDER(
	.data1_in	(Shift_left3232.out_o),
	.data2_in	(IFID_NxtAddr),
	
	.data_o		()
);

Registers Registers(
    .clk_i      (clk_i),
    .RSaddr_i   (instruction[25:21]),
    .RTaddr_i   (instruction[20:16]),
    .RDaddr_i   (MEMWB_Reg.regDstAddr_o), 
    .RDdata_i   (MUX5.data_o),
    .RegWrite_i (MEMWB_Reg.writeBack_o), 
    
	.RSdata_o   (Dread1), 
    .RTdata_o   () 
);

Control  Control
(
	.Op_i		(instruction[31:26]),
   
    .ALUSrc_o	(),
	.ALUOp_o	(),
	.RegDst_o	(),
	.MemWr_o	(),
	.MemRd_o	(),
	.MemtoReg_o	(),
	.RegWr_o	(),
	.Branch_o	(),
	.Jump_o		()
);

Eq Eq
(
	.rd1_i		(Dread1),
	.rd2_i		(Registers.RTdata_o),
	
	.eq_o		()
);

MUX32 MUX1(
	.data1_i	(Add_pc_o),
	.data2_i	(ADDER.data_o),
	.select_i	(Control.Branch_o & Eq.eq_o),
	
	.data_o		(Mux1_o)
);

MUX32 MUX2(
    .data1_i    (MUX1.data_o),
    .data2_i    ({{Mux1_o[31:28]},{Shift_left2628.out_o[27:0]}}),
    .select_i   (Control.Jump_o),
    
	.data_o     ()
);

MUX5 MUX3(
    .data1_i    (IDEX_Reg.instr20_16_o),
    .data2_i    (IDEX_Reg.instr15_11_o),
    .select_i   (IDEX_Reg.regDst_o),
    
	.data_o     ()
);

MUX32 MUX4(
    .data1_i    (MUX7.data_o),
    .data2_i    (IDEX_Reg.signExtendResult_o),
    .select_i   (IDEX_Reg.ALUSrc_o),
    
	.data_o     ()
);



MUX32 MUX5(
    .data1_i    (MEMWB_Reg.ALUresult_o),
    .data2_i    (MEMWB_Reg.memReadData_o),
    .select_i   (MEMWB_Reg.memtoReg_o),
    
	.data_o     ()
);

MUX32_3 MUX6(
    .data1_i    (IDEX_Reg.reg1Data_o),
    .data2_i    (MUX5.data_o),
	.data3_i	(EXMEM_Reg.ALUresult_o),
    .select_i   (FW.ForwardA_o),
    
	.data_o     ()
);

MUX32_3 MUX7(
    .data1_i    (IDEX_Reg.reg2Data_o),
    .data2_i    (MUX5.data_o),
	.data3_i	(EXMEM_Reg.ALUresult_o),
    .select_i   (FW.ForwardB_o),
    
	.data_o     ()
);

MUX_Ctrl MUX8(
	.select_i	(HD.mux_control_o),
	.ALUSrc_i	(Control.ALUSrc_o),
	.ALUOp_i	(Control.ALUOp_o),
	.RegDst_i	(Control.RegDst_o),
	.MemWr_i	(Control.MemWr_o),
	.MemRd_i	(Control.MemRd_o),
	.MemtoReg_i	(Control.MemtoReg_o),
	.RegWr_i	(Control.RegWr_o),
	
	.ALUSrc_o	(),
	.ALUOp_o	(),
	.RegDst_o	(),
	.MemWr_o	(),
	.MemRd_o	(),
	.MemtoReg_o	(),
	.RegWr_o	()
);

Sign_Extend Sign_Extend(
    .data_i     (instruction[15:0]),
    .data_o     (extended)
);

ALU ALU(
    .data1_i    (MUX6.data_o),
    .data2_i    (MUX4.data_o),
    .ALUCtrl_i  (ALU_Control.ALUCtrl_o),
   
    .data_o     ()
);

ALU_Control ALU_Control(
    .funct_i    (IDEX_Reg.signExtendResult_o[5:0]),
    .ALUOp_i    (IDEX_Reg.ALUOp_o),
   
    .ALUCtrl_o  ()
);

IFID_Reg IFID_Reg(
    .clk_i				(clk_i),
    .stallHold_i		(HD.stallHold_o),
	.flush_i			(Control.Jump_o | (Control.Branch_o & Eq.eq_o)),
	.nextInstrAddr_i	(Add_pc_o),
    .instr_i			(Instruction_Memory.instr_o),
	
	.nextInstrAddr_o	(IFID_NxtAddr), 
    .instr_o			(instruction)
);

Shift_left3232 Shift_left3232(
	.in_i	(extended),
	.out_o	()
);

Shift_left2628 Shift_left2628(
	.in_i	(instruction[25:0]),
	.out_o	()
);


IDEX_Reg IDEX_Reg(
	.clk_i				(clk_i),
	.writeBack_i		(MUX8.RegWr_o),
	.memtoReg_i			(MUX8.MemtoReg_o),
	.memRead_i			(MUX8.MemRd_o),
	.memWrite_i			(MUX8.MemWr_o),
	.ALUSrc_i			(MUX8.ALUSrc_o),
	.ALUOp_i			(MUX8.ALUOp_o),
	.regDst_i			(MUX8.RegDst_o),
	.nextInstrAddr_i	(IFID_NxtAddr),
	.reg1Data_i			(Registers.RSdata_o),
	.reg2Data_i			(Registers.RTdata_o),
	.signExtendResult_i	(extended),
	.instr25_21_i		(instruction[25:21]),
	.instr20_16_i		(instruction[20:16]),
	.instr15_11_i		(instruction[15:11]),
	
	.writeBack_o		(),
	.memtoReg_o			(),
	.memRead_o			(),
	.memWrite_o			(),
	.ALUSrc_o			(),
	.ALUOp_o			(),
	.regDst_o			(),
	.nextInstrAddr_o	(),
	.reg1Data_o			(),
	.reg2Data_o			(),
	.signExtendResult_o	(),
	.instr25_21_o		(),
	.instr20_16_o		(),
	.instr15_11_o		()
);

EXMEM_Reg EXMEM_Reg(
	.clk_i			(clk_i),
	.writeBack_i	(IDEX_Reg.writeBack_o),
	.memtoReg_i		(IDEX_Reg.memtoReg_o),
	.memRead_i		(IDEX_Reg.memRead_o),
	.memWrite_i		(IDEX_Reg.memWrite_o),
	.ALUresult_i	(ALU.data_o),
	.memWriteData_i	(MUX7.data_o),
	.regDstAddr_i	(MUX3.data_o),
	
	.writeBack_o	(),
	.memtoReg_o		(),
	.memRead_o		(),
	.memWrite_o		(),
	.ALUresult_o	(),
	.memWriteData_o	(),
	.regDstAddr_o	()
);

MEMWB_Reg MEMWB_Reg(
	.clk_i			(clk_i),
	.writeBack_i	(EXMEM_Reg.writeBack_o),
	.memtoReg_i		(EXMEM_Reg.memtoReg_o),
	.memReadData_i	(Data_Memory.RdData_o),
	.ALUresult_i	(EXMEM_Reg.ALUresult_o),
	.regDstAddr_i	(EXMEM_Reg.regDstAddr_o),
	
	.writeBack_o	(),
	.memtoReg_o		(),
	.memReadData_o	(),
	.ALUresult_o	(),
	.regDstAddr_o	()
);

HD HD
(
	.if_id_reg_i	(instruction),
	.id_ex_regrt_i	(IDEX_Reg.instr20_16_o),
	.id_ex_memrd_i	(IDEX_Reg.memRead_o),
	
	.mux_control_o	(),
	.pc_stall_o		(),
	.stallHold_o	()
);

FW FW
(
	.IdEx_rs_i	(IDEX_Reg.instr25_21_o),
	.IdEx_rt_i	(IDEX_Reg.instr20_16_o),
	.ExMem_rd_i	(EXMEM_Reg.regDstAddr_o),
	.ExMem_Wb_i	(EXMEM_Reg.writeBack_o),
	.MemWb_rd_i	(MEMWB_Reg.regDstAddr_o),
	.MemWb_Wb_i	(MEMWB_Reg.writeBack_o),
	
	.ForwardA_o	(),
	.ForwardB_o	()
);

endmodule

