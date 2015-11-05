import lc3b_types::*;

/*
 * Datapath for CPU
 */
module datapath
(
    input clk,

    /* control signals */
   /* input load_pc,
    input load_ir,
    input load_regfile,
    input load_mar,
    input load_mdr,
    input load_cc,
    input regfile_filter_enable,
    input stb_filter_enable,
    input [1:0] pcmux_sel,
    input storemux_sel,
    input destmux_sel,
    input [1:0] alumux_sel,
    input [1:0] regfilemux_sel,
    input [1:0] marmux_sel,
    input mdrmux_sel,
    input offsetaddermux_sel,
    input offset6mux_sel,
    input lc3b_aluop aluop,*/
    output lc3b_opcode opcode,
    output logic branch_enable,
    output logic d_enable,
    output logic imm_enable,
    output logic jsr_enable,

    /* declare more ports here */
    input lc3b_word mem_rdata,
    output logic mem_read,
    output logic mem_write,
    output lc3b_mem_wmask mem_byte_enable,
    output lc3b_word mem_wdata,
    output lc3b_word mem_address,
    input lc3b_word instr_rdata,
    output lc3b_word instr_address
);

/* declare internal signals */
logic global_load;

initial
begin
    global_load = 1'b1;
end

lc3b_reg sr1;
lc3b_reg sr2;
lc3b_reg dest;
lc3b_reg storemux_out;
lc3b_reg destmux_out;

lc3b_word sr1_out;
lc3b_word sr1reg1_out;
lc3b_word sr1reg2_out;

lc3b_word sr2_out;
lc3b_word sr2reg1_out;
lc3b_word sr2reg2_out;

lc3b_offset4 offset4;
lc3b_offset5 offset5;
lc3b_offset6 offset6;
lc3b_byte trapvect8;
lc3b_offset9 offset9;
lc3b_offset11 offset11;
lc3b_word sext5_out;
lc3b_word sext6_out;
lc3b_word adj6_out;
lc3b_word adj9_out;
lc3b_word adj11_out;
lc3b_word zadj8_out;
lc3b_word regfile_filter_out;
lc3b_word stb_filter_out;
lc3b_word zext4_out;
lc3b_word pcmux_out;
lc3b_word brmux_out;
lc3b_word alumux_out;
lc3b_word regfilemux_out;
lc3b_word marmux_out;

lc3b_word mdrmux_out;
lc3b_word mdr_out;

lc3b_word alu_out;
lc3b_word aluReg_out;
lc3b_word dataReg_out;

lc3b_word pc_out;
lc3b_word pcReg_out1;
lc3b_word pcReg_out2;
lc3b_word pcReg_out3;
lc3b_word pcReg_out4;

lc3b_word ir_out;
lc3b_word irReg_out;
lc3b_word irReg1_out;

lc3b_reg writeReg1_out;
lc3b_reg writeReg2_out;
lc3b_reg writeReg3_out;

lc3b_word offsetadder_mux_out;
lc3b_word offsetadder_out;
lc3b_word offsetadderReg_out;

lc3b_word textreg_out;

lc3b_word offset6mux_out;
lc3b_word pc_plus2_out;
lc3b_nzp gencc_out;
lc3b_nzp cc_out;

lc3b_word mem_data_reg_out;

lc3b_control_word ctrl;
lc3b_control_word ctrl_dec;
lc3b_control_word ctrl_exec;
lc3b_control_word ctrl_mem;
lc3b_control_word ctrl_wb;

logic ctrl_register_mem_write;
logic ctrl_register_mem_read;
logic is_nop;

always_comb
begin
    mem_byte_enable = ctrl_mem.mem_byte_enable;
    is_nop = (ir_out == 16'b0);
end
/**************************************
 * User modules                       *
 **************************************/

/*
 * IR
 */
ir ir_module
(
    .clk(clk),
    .load(1'b1),
    .in(instr_rdata),
    .opcode(opcode),
    .dest(dest),
    .src1(sr1),
    .src2(sr2),
    .offset4(offset4),
    .offset5(offset5),
    .offset6(offset6),
    .trapvect8(trapvect8),
    .offset9(offset9),
    .offset11(offset11),
    .d_enable(d_enable),
    .imm_enable(imm_enable),
    .jsr_enable(jsr_enable),
    .out(ir_out)
);

/*
 * Control ROM
 */

control_rom control_rom_module
(
    .opcode(opcode),
    .imm_enable(imm_enable),
    .is_nop(is_nop),
    .ctrl(ctrl)
);

/*
 * ALU
 */
alu alu_module
(
    .aluop(ctrl_exec.aluop),
    .a(stb_filter_out),
    .b(alumux_out),
    .f(alu_out)
);

/*
 * Regfile
 */
regfile regfile_module
(
    .clk(clk),
    .load(ctrl_wb.load_regfile),
    .in(regfile_filter_out),
    .src_a(sr1),
    .src_b(storemux_out),
    .dest(writeReg3_out),           //changed to trans reg
    .reg_a(sr1_out),
    .reg_b(sr2_out)
);

/*
 * SEXT5
 */
sext #(.width(5)) sext5
(
    .in(irReg_out[4:0]),        //offset5
    .out(sext5_out)
);

/*
 * SEXT6
 */
sext #(.width(6)) sext6
(
    .in(irReg_out[5:0]),        //offset6
    .out(sext6_out)
);

/*
 * ADJ6
 */
adj #(.width(6)) adj6
(
    .in(irReg_out[5:0]),        //offset6
    .out(adj6_out)
);

/*
 * ADJ9
 */
adj #(.width(9)) adj9
(
    .in(irReg_out[8:0]),        //offset9
    .out(adj9_out)
);

/*
 * ADJ11
 */
adj #(.width(11)) adj11
(
    .in(irReg_out[10:0]),       //offset11
    .out(adj11_out)
);

/*
 * ZADJ8
 */
zadj #(.width(8)) zadj8
(
    .in(irReg_out[7:0]),        //trapvect8
    .out(zadj8_out)
);

/*
 * Regfile filter
 */
regfile_filter regfile_filter_module
(
    .filter_enable(ctrl_wb.regfile_filter_enable),
    .high_byte_enable(mem_address[0]),
    .in(regfilemux_out),
    .out(regfile_filter_out)
);

/*
 * STB filter
 */
stb_filter stb_filter_module
(
    .filter_enable(ctrl_exec.stb_filter_enable),
    .high_byte_enable(mem_address[0]),
    .in(sr1reg1_out),               //changed to trans reg
    .out(stb_filter_out)
);

/*
 * Shift zext
 */
zext #(.width(4)) shift_zext
(
    .in(irReg_out[3:0]),        //offset4
    .out(zext4_out)
);

/*
 * Offset adder
 */
adder offset_adder
(
    .a(offsetadder_mux_out),
    .b(pcReg_out2),
    .out(offsetadder_out)
);

/*
 * PC plus 2
 */
plus2 plus2_module
(
    .in(instr_address),
    .out(pc_plus2_out)
);


/*
 * CCComp
 */
nzp_comparator cccomp
(
    .nzp(cc_out),
    .ir_nzp(writeReg2_out),
    .branch_enable(branch_enable)
);

/*
 * GenCC
 */
gencc gencc_module
(
    .in(regfile_filter_out),
    .out(gencc_out)
);


/**************************************
 * Registers                          *
 **************************************/

/*
 * PC
 */
register pc
(
    .clk(clk),
    .load(1'b1),
    .in(brmux_out),
    .out(instr_address)
);

/*
 * MAR
 */
register mar
(
    .clk(clk),
    .load(ctrl_exec.load_mar),
    .in(marmux_out),
    .out(mem_address)
);

/*
 * MDR
 */
register mdr
(
    .clk(clk),
    .load(ctrl_mem.load_mdr),
    .in(mem_rdata),
    .out(mem_data_reg_out)
);

/*
 * CC
 */
register #(.width(3)) cc
(
    .clk(clk),
    .load(ctrl_wb.load_cc),
    .in(gencc_out),
    .out(cc_out)
);


/**************************************
 * TRANSITION Registers               *
 **************************************/

register pcReg1
(
    .clk(clk),
    .load(global_load),
    .in(pc_plus2_out),
    .out(pcReg_out1)
);

register pcReg2
(
    .clk(clk),
    .load(global_load),                       
    .in(pcReg_out1),
    .out(pcReg_out2)
);
register pcReg3
(
    .clk(clk),
    .load(global_load),
    .in(pcReg_out2),
    .out(pcReg_out3)
);
register pcReg4
(
    .clk(clk),
    .load(global_load),
    .in(pcReg_out3),
    .out(pcReg_out4)
);

register aluReg
(
    .clk(clk),
    .load(global_load),
    .in(alu_out),
    .out(aluReg_out)
);

register dataReg
(
    .clk(clk),
    .load(global_load),
    .in(aluReg_out),
    .out(dataReg_out)
);

ctrl_register ctrlword1
(
    .clk(clk),
    .load(global_load),
    .in(ctrl),
    .out(ctrl_exec)
);

ctrl_register_mem ctrlword2
(
    .clk(clk),
    .load(global_load),
    .in(ctrl_exec),
    .out(ctrl_mem),
    .read(mem_read),
    .write(mem_write)
);

ctrl_register ctrlword3
(
    .clk(clk),
    .load(global_load),
    .in(ctrl_mem),
    .out(ctrl_wb)
);

register irReg
(
    .clk(clk),
    .load(global_load),
    .in(ir_out),
    .out(irReg_out)
);

register #(.width(3)) writeReg1
(
    .clk(clk),
    .load(global_load),
    .in(destmux_out),
    .out(writeReg1_out)
);

register #(.width(3)) writeReg2
(
    .clk(clk),
    .load(global_load),
    .in(writeReg1_out),
    .out(writeReg2_out)
);

register #(.width(3)) writeReg3
(
    .clk(clk),
    .load(global_load),
    .in(writeReg2_out),
    .out(writeReg3_out)
);

register SR1Reg1
(
    .clk(clk),
    .load(global_load),
    .in(sr1_out),
    .out(sr1reg1_out)
);

register SR1Reg2
(
    .clk(clk),
    .load(global_load),
    .in(sr1reg1_out),
    .out(sr1reg2_out)
);

register SR2Reg1
(
    .clk(clk),
    .load(global_load),
    .in(sr2_out),
    .out(sr2reg1_out)
);

register SR2Reg2
(
    .clk(clk),
    .load(global_load),
    .in(sr2reg1_out),
    .out(mem_wdata)
);

register offsetadderReg
(
    .clk(clk),
    .load(global_load),
    .in(offsetadder_out),
    .out(offsetadderReg_out)
);

/**************************************
 * Multiplexers                       *
 **************************************/

/*
 * Store mux
 */
mux2 #(.width(3)) store_mux
(
    .sel(ctrl.storemux_sel),
    .a(sr2),
    .b(dest),
    .f(storemux_out)
);

/*
 * Dest mux
 */
mux2 #(.width(3)) dest_mux
(
    .sel(ctrl.destmux_sel),
    .a(dest),
    .b(3'b111),
    .f(destmux_out)
);

/*
 * PC mux
 */
mux4 pc_mux
(
    .sel(ctrl_wb.pcmux_sel),
    .a(pc_plus2_out),
    .b(offsetadderReg_out),      //changes for trans reg
    .c(sr1reg2_out),            //changed to trans reg
    .d(regfile_filter_out),
    .f(pcmux_out)
);

/*
 * Branch mux
 */
mux2 br_mux
(
    .sel((ctrl_mem.brmux_sel) & branch_enable),
    .a(pcmux_out), 
    .b(offsetadderReg_out),
    .f(brmux_out)
);

/*
 * ALU mux
 */
mux4 alu_mux
(
    .sel(ctrl_exec.alumux_sel),
    .a(sr2reg1_out),         //changed for trans reg
    .b(offset6mux_out),
    .c(sext5_out),
    .d(zext4_out),
    .f(alumux_out)
);

/*
 * Regfile mux
 */
mux4 regfile_mux
(
    .sel(ctrl_wb.regfilemux_sel),
    .a(dataReg_out),       //changes for trans reg
    .b(mem_data_reg_out),
    .c(offsetadderReg_out), //changes for trans reg
    .d(pcReg_out4),            //changed to trans reg
    .f(regfilemux_out)
);

/*
 * MAR mux
 */
mux4 mar_mux
(
    .sel(ctrl_exec.marmux_sel),
    .a(alu_out),           //changed for trans reg
    .b(pcReg_out2),                //changed for trans reg
    .c(regfile_filter_out),
    .d(zadj8_out),            //changed for trans reg
    .f(marmux_out)
);

/*
 * Offset adder mux
 */
mux2 offset_adder_mux
(
    .sel(ctrl_exec.offsetaddermux_sel),
    .a(adj9_out),
    .b(adj11_out),
    .f(offsetadder_mux_out)
);

/*
 * Offset6 mux
 */
mux2 offset6_mux
(
    .sel(ctrl_exec.offset6mux_sel),
    .a(adj6_out),
    .b(sext6_out),
    .f(offset6mux_out)
);


endmodule : datapath
