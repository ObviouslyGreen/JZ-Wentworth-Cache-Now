import lc3b_types::*;

/*
 * Datapath for CPU
 */
module datapath
(
    input clk,
    input i_mem_resp,
    input d_mem_resp,
    input lc3b_word instr_rdata,
    input lc3b_word mem_rdata,
    output logic branch_enable,
    output logic d_enable,
    output logic imm_enable,
    output logic jsr_enable,
    output logic mem_read,
    output logic mem_write,
    output logic instr_read,
    output logic instr_write,
    output lc3b_word instr_wdata,
    output lc3b_word instr_address,
    output lc3b_word mem_wdata,
    output lc3b_word mem_address,
    output lc3b_mem_wmask mem_byte_enable
);

/* declare internal signals */
logic global_load;

initial
begin
    instr_read = 1'b1;
    instr_write = 1'b0;
    instr_wdata = 16'b0000000000000000;
end

lc3b_opcode opcode;
lc3b_control_word ctrlword1_in;

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

lc3b_word zext4_out;
lc3b_word sext5_out;
lc3b_word sext6_out;
lc3b_word adj6_out;
lc3b_word adj9_out;
lc3b_word adj11_out;
lc3b_word zadj8_out;

lc3b_word pcmux_out;
lc3b_word brmux_out;

lc3b_word alumux_out;
lc3b_word regfilemux_out;
lc3b_word marmux_out;


lc3b_word mdr_out;
lc3b_word alu_out;
lc3b_word regfile_filter_out;

lc3b_word aluReg_out;
lc3b_word dataReg_out;

lc3b_word pcReg_out1;
lc3b_word pcReg_out2;
lc3b_word pcReg_out3;
lc3b_word pcReg_out4;

lc3b_word ir_out;
lc3b_word irReg_out;

lc3b_reg writeReg1_out;
lc3b_reg writeReg2_out;
lc3b_reg writeReg3_out;

lc3b_word offsetadder_mux_out;
lc3b_word offsetadder_out;

lc3b_word offsetadderReg1_out;
lc3b_word offsetadderReg2_out;

lc3b_word offset6mux_out;
lc3b_word pc_plus2_out;
lc3b_word indirect_marmux_out;
lc3b_nzp gencc_out;
lc3b_nzp cc_out;

lc3b_control_word ctrl;
lc3b_control_word ctrl_dec;
lc3b_control_word ctrl_exec;
lc3b_control_word ctrl_mem;
lc3b_control_word ctrl_wb;

lc3b_reg SR1_index_reg_out;
lc3b_reg SR2_index_reg_out;
lc3b_word forwarding_mux_a_out;
lc3b_word forwarding_mux_b_out;
logic [1:0] forwarding_unit_sel;

logic is_nop;
logic bubble_enable;
logic [1:0] resp_count;

always_comb
begin
    mem_read = ctrl_mem.mem_read | ((ctrl_mem.opcode == op_sti) & (resp_count == 2'b00));
    mem_write = ctrl_mem.mem_write | ((ctrl_mem.opcode == op_sti) & (resp_count == 2'b10));
    is_nop = (ir_out == 16'b0);
    ctrlword1_in = bubble_enable ? 16'b0 : ctrl;
    if(ctrl_mem.opcode == op_stb)
        mem_byte_enable = (mem_address[0]) ? 2'b10 : 2'b01;
    else
        mem_byte_enable = ctrl_mem.mem_byte_enable;
    if (ctrl_mem.indirect_enable)
        global_load = (resp_count == 2'b10);
    else
        global_load = i_mem_resp & (d_mem_resp | ~(ctrl_mem.mem_read | ctrl_mem.mem_write));
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
    .load(global_load && bubble_enable),
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
    .jsr_enable(jsr_enable),
    .d_enable(d_enable),
    .stb_high_enable(mem_address[0]),
    .is_nop(is_nop),
    .ctrl(ctrl)
);

/*
 * ALU
 */
alu alu_module
(
    .aluop(ctrl_exec.aluop),
    .a(forwarding_mux_a_out),
    .b(forwarding_mux_b_out),
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
    .filter_enable(ctrl_mem.stb_filter_enable),
    .high_byte_enable(mem_address[0]),
    .in(sr2reg2_out),               //changed to trans reg
    .out(mem_wdata)
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


/*
 * 2-bit Counter
 */
up_counter mem_resp_counter
(
    .clk(clk),
    .enable(ctrl_mem.indirect_enable & d_mem_resp),
    .reset(global_load),
    .count(resp_count)
);

/*
 * Hazard detection unit
 */
hazard_detector hazard_detection_unit
(
    .clk(clk),
    .mem_read(mem_read),
    .opcode(opcode),
    .bubble_enable(bubble_enable)
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
    .load(global_load && bubble_enable),
    .in(brmux_out),
    .out(instr_address)
);

/*
 * MAR
 */
register mar
(
    .clk(clk),
    .load((global_load & ctrl_exec.load_mar) | resp_count == 2'b01),
    .in(marmux_out),
    .out(mem_address)
);

/*
 * MDR
 */
register mdr
(
    .clk(clk),
    .load(global_load & ctrl_mem.load_mdr),
    .in(mem_rdata),
    .out(mdr_out)
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
    .in(ctrlword1_in),
    .out(ctrl_exec)
);

ctrl_register ctrlword2
(
    .clk(clk),
    .load(global_load),
    .in(ctrl_exec),
    .out(ctrl_mem)
    //.read(),
    //.write()
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
    .out(sr2reg2_out)
);

register offsetadderReg1
(
    .clk(clk),
    .load(global_load),
    .in(offsetadder_out),
    .out(offsetadderReg1_out)
);

register offsetadderReg2
(
    .clk(clk),
    .load(global_load),
    .in(offsetadderReg1_out),
    .out(offsetadderReg2_out)
);

register #(.width(3)) SR1_index_reg
(
    .clk(clk),
    .load(global_load),
    .in(sr1),
    .out(SR1_index_reg_out)
);

register #(.width(3)) SR2_index_reg
(
    .clk(clk),
    .load(global_load),
    .in(sr2),
    .out(SR2_index_reg_out)
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
    .sel(ctrl_mem.pcmux_sel),
    .a(pc_plus2_out),
    .b(offsetadderReg1_out),      //changes for trans reg
    .c(sr1reg2_out),            //changed to trans reg
    .d(mem_rdata),
    .f(pcmux_out)
);

/*
 * Branch mux
 */
mux2 br_mux
(
    .sel((ctrl_mem.brmux_sel) & branch_enable),
    .a(pcmux_out),
    .b(offsetadderReg1_out),
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
    .b(mdr_out),
    .c(offsetadderReg2_out), //changes for trans reg
    .d(pcReg_out4),            //changed to trans reg
    .f(regfilemux_out)
);

/*
 * MAR mux
 */
mux4 mar_mux
(
    .sel(ctrl_exec.marmux_sel),
    .a(indirect_marmux_out),           //changed for trans reg
    .b(pcReg_out2),                //changed for trans reg
    .c(regfile_filter_out),
    .d(zadj8_out),            //changed for trans reg
    .f(marmux_out)
);

/*
 * Indirect MAR mux
 */
mux2 indirect_mar_mux
(
    .sel((resp_count == 2'b01)),
    .a(alu_out),
    .b(mem_rdata),
    .f(indirect_marmux_out)
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

mux4 forwarding_mux_a
(
    .sel(forwarding_unit_sel),
    .a(sr1reg1_out),
    .b(aluReg_out),
    .c(regfile_filter_out),
    .d(16'b0),
    .f(forwarding_mux_a_out)
);


mux4 forwarding_mux_b
(
    .sel(forwarding_unit_sel),
    .a(alumux_out),
    .b(aluReg_out),
    .c(regfile_filter_out),
    .d(16'b0),
    .f(forwarding_mux_b_out)
);

endmodule : datapath
