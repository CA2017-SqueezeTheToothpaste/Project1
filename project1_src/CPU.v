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

wire reg_dst, ALUSrc, reg_write;
wire [31:0] instruction;
wire [31:0] inst_addr, inst;
wire [31:0] extended;
wire [31:0] ALUinput2;
wire [31:0] Dread1;
wire [31:0] write_data;
wire [31:0]	Add_pc_o;
wire [31:0] Mux1_o;
wire [31:0] IFID_NxtAddr;
wire [4:0] 	write_register;
wire [2:0] 	Alu_ctr;
wire [1:0] 	AluOp;

PC PC(
    .clk_i      (clk_i),
    .rst_i      (rst_i),
    .start_i    (start_i),
    .pc_i       (MUX2.data_o),
    
	.pc_o       (inst_addr)
);

Instruction_Memory Instruction_Memory(
    .addr_i     (inst_addr), 
    
	.instr_o    ()
);

Adder Add_PC(
    .data1_in   (inst_addr),
    .data2_in   (32'd4),
    
	.data_o     (Add_pc_o)
);

Adder ADD(
	.data1_in	(Shift_left3232.out_o),
	.data2_in	(IFID_NxtAddr),
	
	.data_o		(MUX1.data1_i),
);

Registers Registers(
    .clk_i      (clk_i),
    .RSaddr_i   (instruction[25:21]),
    .RTaddr_i   (instruction[20:16]),
    .RDaddr_i   (write_register), 
    .RDdata_i   (write_data),
    .RegWrite_i (reg_write), 
    
	.RSdata_o   (Dread1), 
    .RTdata_o   (MUX_ALUSrc.data1_i) 
);

Control  Control
(
	.Op_i		(instructionp[31:26]),
   
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
	.rd1_i		(),
	.rd2_i		(),
	
	.eq_o		()
);

MUX32 MUX1(
	.data1_i	(ADD.data_o),
	.data2_i	(Add_pc_o),
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
    .data1_i    (),
    .data2_i    (IDEX_Reg.signExtendResult_o),
    .select_i   (ALUSrc),
    
	.data_o     (ALUinput2)
);

MUX32 MUX5(
    .data1_i    (),
    .data2_i    (),
    .select_i   (),
    
	.data_o     ()
);

MUX32_3 MUX6(
    .data1_i    (IDEX_Reg.reg2Data_o),
    .data2_i    (),
	.data3_i	(),
    .select_i   (),
    
	.data_o     ()
);

MUX32_3 MUX7(
    .data1_i    (IDEX_Reg.reg2Data_o),
    .data2_i    (),
	.data3_i	(),
    .select_i   (),
    
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
    .data1_i    (Dread1),
    .data2_i    (ALUinput2),
    .ALUCtrl_i  (Alu_ctr),
   
    .data_o     (write_data),
    .Zero_o     ()
);

ALU_Control ALU_Control(
    .funct_i    (instruction[5:0]),
    .ALUOp_i    (AluOp),
   
    .ALUCtrl_o  (Alu_ctr)
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
	.writeBack_i		(),
	.memtoReg_i			(),
	.memRead_i			(),
	.memWrite_i			(),
	.ALUSrc_i			(),
	.ALUOp_i			(),
	.regDst_i			(),
	.nextInstrAddr_i	(IFID_NxtAddr),
	.reg1Data_i			(),
	.reg2Data_i			(),
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
	.instr15_11_oq		()
);

EXMEM_Reg EXMEM_Reg(
	.clk_i			(clk_i),
	.writeBack_i	(),
	.memtoReg_i		(),
	.memRead_i		(),
	.memWrite_i		(),
	.ALUresult_i	(),
	.memWriteData_i	(),
	.regDstAddr_i	(),
	
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
	.writeBack_i	(),
	.memtoReg_i		(),
	.memReadData_i	(),
	.ALUresult_i	(),
	.regDstAddr_i	(),
	
	.writeBack_o	(),
	.memtoReg_o		(),
	.memReadData_o	(),
	.ALUresult_o	(),
	.regDstAddr_o	()
);

HD HD
(
	.if_id_reg_i	(),
	.id_ex_regrt_i	(),
	.id_ex_memrd_i	(),
	
	.mux_control_o	(),
	.pc_stall_o		(),
	.stallHold_o	()
);

FW FW
(
	.IdEx_rs_i	(),
	.IdEx_rt_i	(),
	.ExMem_rd_i	(),
	.ExMem_Wb_i	(),
	.MemWb_rd_i	(),
	.MemWb_Wb_i	(),
	
	.ForwardA_o	(),
	.ForwardB_o	()
);

endmodule

