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
    .pc_i       (),
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
	.data1_in	(),
	.data2_in	(),
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

MUX32 MUX1(
	.data1_i	(ADD.data_o),
	.data2_i	(Add_pc_o),
	.select_i	(Control.Branch_o & Eq.eq_o),
	.data_o		(Mux1_o)
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

MUX_Ctrl MUX_Ctrl(
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

Eq Eq
(
	.rd1_i		(),
	.rd2_i		(),
	.eq_o		()
);

MUX5 MUX_RegDst(
    .data1_i    (instruction[20:16]),
    .data2_i    (instruction[15:11]),
    .select_i   (reg_dst),
    .data_o     (write_register)
);

MUX32 MUX_ALUSrc(
    .data1_i    (),
    .data2_i    (extended),
    .select_i   (ALUSrc),
    .data_o     (ALUinput2)
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



IDEX_Reg IDEX_Reg (
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
	.writeBack_o,
	.memtoReg_o,
	.memRead_o,
	.memWrite_o,
	.ALUSrc_o,
	.ALUOp_o,
	.regDst_o,
	.nextInstrAddr_o,
	.reg1Data_o,
	.reg2Data_o,
	.signExtendResult_o	(),
	.instr25_21_o,
	.instr20_16_o,
	.instr15_11_oq
);

Pipe_Reg EX_MEM(
	.wb_i		(),
	.m_i		(),
	.pc_i		(),
	.rd1_i		(),
	.rd2_i		(),
	.inst_i		(),
	.wb_o		(),
	.m_o		(),
	.pc_o		(),
	.rd1_o		(),
	.rd2_o		(),
	.inst_o		()
	);

Pipe_Reg MEM_WB(
	.wb_i		(),
	.pc_i		(),
	.rd1_i		(),
	.rd2_i		(),
	.inst_i		(),
	.wb_o		(),
	.pc_o		(),
	.rd1_o		(),
	.rd2_o		(),
	.inst_o		()
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

endmodule

