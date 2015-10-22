import lc3b_types::*;

/*
 * Datapath for CPU
 */
module datapath
(
    input clk,

    /* control signals */
    input load_pc,
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
    input lc3b_aluop aluop,
    output lc3b_opcode opcode,
    output logic branch_enable,
    output logic d_enable,
    output logic imm_enable,
    output logic jsr_enable,

    /* declare more ports here */
    input lc3b_word mem_rdata,
    output lc3b_word mem_wdata,
    output lc3b_word mem_address
);


/* declare internal signals */
lc3b_reg sr1;
lc3b_reg sr2;
lc3b_reg dest;
lc3b_reg storemux_out;
lc3b_reg destmux_out;
lc3b_word sr1_out;
lc3b_word sr2_out;
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
lc3b_word alumux_out;
lc3b_word regfilemux_out;
lc3b_word marmux_out;
lc3b_word mdrmux_out;
lc3b_word offsetadder_mux_out;

lc3b_word alu_out1;
lc3b_word alu_out2;
lc3b_word dataReg_out;

lc3b_word pc_out1;
lc3b_word pc_out2;
lc3b_word pc_out3;
lc3b_word pc_out4;

lc3b_word offsetadder_out;
lc3b_word offset6mux_out;
lc3b_word pc_plus2_out;
lc3b_nzp gencc_out;
lc3b_nzp cc_out;


/**************************************
 * User modules                       *
 **************************************/

/*
 * IR
 */
ir ir_module
(
    .clk(clk),
    .load(load_ir),
    .in(mem_wdata),
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
    .jsr_enable(jsr_enable)
);

/*
 * ALU
 */
alu alu_module
(
    .aluop(aluop),
    .a(stb_filter_out),
    .b(alumux_out),
    .f(alu_out1)
);

/*
 * Regfile
 */
regfile regfile_module
(
    .clk(clk),
    .load(load_regfile),
    .in(regfile_filter_out),
    .src_a(storemux_out[2:0]),
    .src_b(sr2),
    .dest(destmux_out),
    .reg_a(sr1_out),
    .reg_b(sr2_out)
);

/*
 * SEXT5
 */
sext #(.width(5)) sext5
(
    .in(offset5),
    .out(sext5_out)
);

/*
 * SEXT6
 */
sext #(.width(6)) sext6
(
    .in(offset6),
    .out(sext6_out)
);

/*
 * ADJ6
 */
adj #(.width(6)) adj6
(
    .in(offset6),
    .out(adj6_out)
);

/*
 * ADJ9
 */
adj #(.width(9)) adj9
(
    .in(offset9),
    .out(adj9_out)
);

/*
 * ADJ11
 */
adj #(.width(11)) adj11
(
    .in(offset11),
    .out(adj11_out)
);

/*
 * ZADJ8
 */
zadj #(.width(8)) zadj8
(
    .in(trapvect8),
    .out(zadj8_out)
);

/*
 * Regfile filter
 */
regfile_filter regfile_filter_module
(
    .filter_enable(regfile_filter_enable),
    .high_byte_enable(mem_address[0]),
    .in(regfilemux_out),
    .out(regfile_filter_out)
);

/*
 * STB filter
 */
stb_filter stb_filter_module
(
    .filter_enable(stb_filter_enable),
    .high_byte_enable(mem_address[0]),
    .in(sr1_out),
    .out(stb_filter_out)
);

/*
 * Shift zext
 */
zext #(.width(4)) shift_zext
(
    .in(offset4),
    .out(zext4_out)
);

/*
 * Offset adder
 */
adder offset_adder
(
    .a(offsetadder_mux_out),
    .b(pc_out),
    .out(offsetadder_out)
);

/*
 * PC plus 2
 */
plus2 plus2_module
(
    .in(pc_out),
    .out(pc_plus2_out)
);


/*
 * CCComp
 */
nzp_comparator cccomp
(
    .nzp(cc_out),
    .ir_nzp(dest),
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
register pc1
(
    .clk(clk),
    .load(load_pc),
    .in(pcmux_out),
    .out(pc_out1)
);

/*
 * MAR
 */
register mar
(
    .clk(clk),
    .load(load_mar),
    .in(marmux_out),
    .out(mem_address)
);

/*
 * MDR
 */
register mdr
(
    .clk(clk),
    .load(load_mdr),
    .in(mdrmux_out),
    .out(mem_wdata)
);

/*
 * CC
 */
register #(.width(3)) cc
(
    .clk(clk),
    .load(load_cc),
    .in(gencc_out),
    .out(cc_out)
);


/**************************************
 * TRANSITION Registers               *
 **************************************/
register pc2
(
    .clk(clk),
    .load(load_pc2),                                 //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!NEEED TO CHANGE LOAD LOGIC FOR EVERYTHING!!!!!!!!!!!!!!!!!!!!!!!!!!!
    .in(pc_out1),
    .out(pc_out2)
);
register pc3
(
    .clk(clk),
    .load(load_pc3),
    .in(pc_out2),
    .out(pc_out3)
);
register pc4
(
    .clk(clk),
    .load(load_pc4),
    .in(pc_out3),
    .out(pc_out4)
);

register alu
(
    .clk(clk),
    .load(load_alu),
    .in(alu_out1),
    .out(alu_out2)
);

register dataReg
(
    .clk(clk),
    .load(load_dataReg),
    .in(alu_out2),
    .out(dataReg_out)
);

register ctrlword1
(
    .clk(clk),
    .load(load_opcode1),
    .in(opcode),
    .out(opcode_out1)
);

register ctrlword2
(
    .clk(clk),
    .load(load_opcode2),
    .in(opcode),
    .out(opcode_out1)
);

register ctrlword3
(
    .clk(clk),
    .load(load_opcode3),
    .in(opcode),
    .out(opcode_out1)
);

//insert IR reg, destmux reg(write reg 1,2,3), SR1 reg 1 and 2, and MDR reg
/**************************************
 * Multiplexers                       *
 **************************************/

/*
 * Store mux
 */
mux2 #(.width(3)) store_mux
(
    .sel(storemux_sel),
    .a(sr1),
    .b(dest),
    .f(storemux_out)
);

/*
 * Dest mux
 */
mux2 #(.width(3)) dest_mux
(
    .sel(destmux_sel),
    .a(dest),
    .b(3'b111),
    .f(destmux_out)
);

/*
 * PC mux
 */
mux4 pc_mux
(
    .sel(pcmux_sel),
    .a(pc_plus2_out),
    .b(offsetadder_out),
    .c(sr1_out),
    .d(regfile_filter_out),
    .f(pcmux_out)
);

/*
 * ALU mux
 */
mux4 alu_mux
(
    .sel(alumux_sel),
    .a(sr2_out),
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
    .sel(regfilemux_sel),
    .a(dataReg_out),       //changes for trans reg
    .b(mem_wdata),
    .c(offsetadder_out),
    .d(pc_out4),            //changed to trans reg
    .f(regfilemux_out)
);

/*
 * MAR mux
 */
mux4 mar_mux
(
    .sel(marmux_sel),
    .a(alu_out),
    .b(pc_out),
    .c(regfile_filter_out),
    .d(zadj8_out),
    .f(marmux_out)
);

/*
 * MDR mux
 */
mux2 mdr_mux
(
    .sel(mdrmux_sel),
    .a(alu_out),
    .b(mem_rdata),
    .f(mdrmux_out)
);

/*
 * Offset adder mux
 */
mux2 offset_adder_mux
(
    .sel(offsetaddermux_sel),
    .a(adj9_out),
    .b(adj11_out),
    .f(offsetadder_mux_out)
);

/*
 * Offset6 mux
 */
mux2 offset6_mux
(
    .sel(offset6mux_sel),
    .a(adj6_out),
    .b(sext6_out),
    .f(offset6mux_out)
);


endmodule : datapath
