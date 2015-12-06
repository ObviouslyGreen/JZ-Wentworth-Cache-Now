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
lc3b_control_word ctrlword2_in;

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
lc3b_word stb_filter_out;

lc3b_word alu_reg_out;
lc3b_word data_reg_out;

lc3b_word pc_reg_out1;
lc3b_word pc_reg_out2;
lc3b_word pc_reg_out3;
lc3b_word pc_reg_out4;

lc3b_word ir_out;
lc3b_word ir_reg_out;

lc3b_reg write_reg1_out;
lc3b_reg write_reg2_out;
lc3b_reg write_reg3_out;

lc3b_word offsetadder_mux_out;
lc3b_word offsetadder_out;

lc3b_word offsetadder_reg1_out;
lc3b_word offsetadder_reg2_out;

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

lc3b_reg sr1_index_reg_out;
lc3b_reg sr2_index_reg_out;
lc3b_word forwarding_mux_a_out;
lc3b_word forwarding_mux_b_out;
logic sti_forward;
logic [1:0] forwarding_sel_a;
logic [1:0] forwarding_sel_b;


logic is_nop;
logic bubble_enable;
logic flush_enable;
logic [1:0] resp_count;

lc3b_word ir_in;
lc3b_word ir_reg_in;
lc3b_reg write_reg1_in;
lc3b_word sr1reg1_in;
lc3b_word sr2reg1_in;
lc3b_word sr2reg2_in;
lc3b_reg sr1_index_reg_in;
lc3b_reg sr2_index_reg_in;
lc3b_word gencc_in;
lc3b_word mar_reg_out;

lc3b_control_word ctrl_bubble;

lc3b_p_index predictor_index;
lc3b_p_index branch_history_out;
lc3b_p_index br_branch_history_out;
lc3b_word pc_in;
lc3b_word adj9_predict_out;
lc3b_word predicted_pc;
lc3b_word brmux_predict_out;
lc3b_word last_br_pc;
lc3b_word mispredict_pc_reg1_out;
lc3b_word mispredict_pc_reg2_out;
logic [1:0] branch_count;
logic branch_predict;
logic mispredict;
logic pred_reg1_out;
logic pred_reg2_out;
logic pred_reg3_out;

initial
begin
    ctrl_bubble = 0;
    ctrl_bubble.is_nop = 1'b1;
end


always_comb
begin
    mem_read = ctrl_mem.mem_read
                || ((ctrl_mem.opcode == op_sti) && (ctrl_mem.indirect_enable && resp_count == 2'b00));
    mem_write = ctrl_mem.mem_write
                || ((ctrl_mem.opcode == op_sti) && (ctrl_mem.indirect_enable && resp_count == 2'b10));
    is_nop = (ir_out == 16'b0);

    if (ctrl_mem.load_regfile)
    begin
        if (ctrl_mem.mem_read)
            gencc_in = mem_rdata;
        else if (ctrl_mem.opcode == op_lea)
            gencc_in = offsetadder_reg1_out;
        else
            gencc_in = alu_reg_out;
    end
    else
    begin
        gencc_in = 16'b0;
    end

    if (bubble_enable)
        sr1reg1_in = 16'b0;
    else
        sr1reg1_in = sr1_out;

    if (bubble_enable)
        sr2reg1_in = 16'b0;
    else
        sr2reg1_in = sr2_out;

    if (forwarding_sel_b == 2'b01)
        sr2reg2_in = alu_reg_out;
    else if (forwarding_sel_b == 2'b10)
        sr2reg2_in = regfile_filter_out;
    else if (forwarding_sel_b == 2'b11)
        sr2reg2_in = offsetadder_reg1_out;
    else
        sr2reg2_in = sr2reg1_out;

    mem_wdata = sti_forward ? regfile_filter_out : stb_filter_out;

    flush_enable = mispredict
                    || ctrl_mem.opcode == op_jmp
                    || ctrl_mem.opcode == op_jsr
                    || ctrl_mem.opcode == op_trap;

    ir_in = flush_enable ? 16'b0 : instr_rdata;

    ctrlword1_in = (bubble_enable || flush_enable) ? ctrl_bubble : ctrl;
    ctrlword2_in = flush_enable ? ctrl_bubble : ctrl_exec;
    ir_reg_in = (bubble_enable || flush_enable) ? 16'b0 : ir_out;
    write_reg1_in = (bubble_enable || ctrl.mem_write)  ? 3'b000 : destmux_out;
    sr1_index_reg_in = bubble_enable ? 3'b000 : sr1;
    sr2_index_reg_in = bubble_enable ? 3'b000 : storemux_out;
    if(ctrl_mem.opcode == op_stb)
        mem_byte_enable = (mem_address[0]) ? 2'b10 : 2'b01;
    else
        mem_byte_enable = ctrl_mem.mem_byte_enable;
    if (ctrl_mem.indirect_enable)
        global_load = (resp_count == 2'b10);
    else
        global_load = i_mem_resp && (d_mem_resp || ~(ctrl_mem.mem_read || ctrl_mem.mem_write));

    predictor_index = instr_address[4:0] ^ branch_history_out;
    mispredict = (branch_enable ^ pred_reg3_out) && ctrl_mem.opcode == op_br && ~ctrl_mem.is_nop;
    if (mispredict)
        pc_in = mispredict_pc_reg2_out;
    else
        pc_in = (branch_predict && ~mispredict) ? predicted_pc : brmux_out;
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
    .load(global_load && (~bubble_enable || flush_enable)),
    .in(ir_in),
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
    .flush_enable(flush_enable || ir_out == 16'b0),
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
    .dest(write_reg3_out),           //changed to trans reg
    .reg_a(sr1_out),
    .reg_b(sr2_out)
);

/*
 * SEXT5
 */
sext #(.width(5)) sext5
(
    .in(ir_reg_out[4:0]),        //offset5
    .out(sext5_out)
);

/*
 * SEXT6
 */
sext #(.width(6)) sext6
(
    .in(ir_reg_out[5:0]),        //offset6
    .out(sext6_out)
);

/*
 * ADJ6
 */
adj #(.width(6)) adj6
(
    .in(ir_reg_out[5:0]),        //offset6
    .out(adj6_out)
);

/*
 * ADJ9
 */
adj #(.width(9)) adj9
(
    .in(ir_reg_out[8:0]),        //offset9
    .out(adj9_out)
);

/*
 * ADJ11
 */
adj #(.width(11)) adj11
(
    .in(ir_reg_out[10:0]),       //offset11
    .out(adj11_out)
);

/*
 * ZADJ8
 */
zadj #(.width(8)) zadj8
(
    .in(ir_reg_out[7:0]),        //trapvect8
    .out(zadj8_out)
);

/*
 * Regfile filter
 */
regfile_filter regfile_filter_module
(
    .filter_enable(ctrl_wb.regfile_filter_enable),
    .high_byte_enable(mar_reg_out[0]),
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
    .out(stb_filter_out)
);


/*
 * Shift zext
 */
zext #(.width(4)) shift_zext
(
    .in(ir_reg_out[3:0]),        //offset4
    .out(zext4_out)
);

/*
 * Offset adder
 */
adder offset_adder
(
    .a(offsetadder_mux_out),
    .b(pc_reg_out2),
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
    .ir_nzp(write_reg2_out),
    .enable(ctrl_mem.opcode == op_br && ~ctrl_mem.is_nop),
    .branch_enable(branch_enable)
);

/*
 * GenCC
 */
gencc gencc_module
(
    .in(gencc_in),
    .out(gencc_out)
);

/*
 * 2-bit Counter
 */
up_counter mem_resp_counter
(
    .clk(clk),
    .enable(ctrl_mem.indirect_enable && d_mem_resp),
    .count(resp_count)
);

/*
 * Hazard detection unit
 */
hazard_detector hazard_detection_unit
(
    .mem_read(ctrl_exec.mem_read),
    .is_nop(ctrl_mem.is_nop),
    .sr1(sr1),
    .sr2(storemux_out),
    .write_reg1(write_reg1_out),
    .opcode(ctrl_mem.opcode),
    .bubble_enable(bubble_enable)
);

/*
 * Data forwarding unit
 */
 forwarding_unit data_forwarding_unit
 (
    .exec_mem_write(ctrl_exec.mem_write),
    .mem_write(ctrl_mem.mem_write),
    .mem_reg_write(ctrl_mem.load_regfile),
    .mem_opcode(ctrl_mem.opcode),
    .wb_reg_write(ctrl_wb.load_regfile),
    .exec_mem_read(ctrl_exec.mem_read),
    .id_imm(ctrl.imm_enable),
    .exec_imm(ctrl_exec.imm_enable),
    .sr1(sr1),
    .sr2(storemux_out),
    .sr1_exec(sr1_index_reg_out),
    .sr2_exec(sr2_index_reg_out),
    .write_reg1(write_reg1_out),
    .write_reg2(write_reg2_out),
    .write_reg3(write_reg3_out),
    .sti_forward(sti_forward),
    .sel_a(forwarding_sel_a),
    .sel_b(forwarding_sel_b)
);

/*
 * Branch history table
 */
branch_history branch_history_table
(
    .clk(clk),
    .enable(ctrl_mem.opcode == op_br && ~ctrl_mem.is_nop),
    .branch_enable(branch_enable && ctrl_mem.opcode == op_br && ~ctrl_mem.is_nop),
    .index(instr_address[4:0]),
    .br_index(pc_reg_out4[4:0]),
    .out(branch_history_out),
    .br_out(br_branch_history_out)
);

/*
 * Branch bimodal counter table
 */
branch_predictors branch_predictor_table
(
    .clk(clk),
    .enable(ctrl_mem.opcode == op_br && ~ctrl_mem.is_nop),
    .branch_enable(branch_enable && ctrl_mem.opcode == op_br && ~ctrl_mem.is_nop),
    .index(predictor_index),
    .br_index(pc_reg_out4[4:0] ^ br_branch_history_out),
    .branch_count(branch_count)
);

/*
 * Predictor generator
 */
gen_prediction gen_prediction_module
(
    .branch_count(branch_count),
    .enable(ir_in[15:12] == op_br && ir_in != 16'b0),
    .branch_predict(branch_predict)
);

/*
 * ADJ9 for prediction
 */
adj #(.width(9)) adj9_predict
(
    .in(ir_in[8:0]),
    .out(adj9_predict_out)
);

/*
 * Offset adder for prediction
 */
adder offset_prediction_adder
(
    .a(adj9_predict_out),
    .b(pc_plus2_out),
    .out(predicted_pc)
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
    .load(global_load && (~bubble_enable || flush_enable)),
    .in(pc_in),
    .out(instr_address)
);

/*
 * MAR
 */
register mar
(
    .clk(clk),
    .load((global_load & ctrl_exec.load_mar) | (ctrl_mem.indirect_enable && resp_count == 2'b01 && d_mem_resp)),
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
    .load(ctrl_mem.load_cc),
    .in(gencc_out),
    .out(cc_out)
);

register #(.width(16)) mispredict_pc
(
    .clk(clk),
    .load(global_load && branch_predict),
    .in(pc_plus2_out),
    .out(last_br_pc)
);


/**************************************
 * TRANSITION Registers               *
 **************************************/
register mar_reg
(
    .clk(clk),
    .load(global_load),
    .in(mem_address),
    .out(mar_reg_out)
);

register pc_reg1
(
    .clk(clk),
    .load(global_load && (~bubble_enable || flush_enable)),
    .in(pc_plus2_out),
    .out(pc_reg_out1)
);

register pc_reg2
(
    .clk(clk),
    .load(global_load && (~bubble_enable || flush_enable)),
    .in(pc_reg_out1),
    .out(pc_reg_out2)
);

register pc_reg3
(
    .clk(clk),
    .load(global_load && (~bubble_enable || flush_enable)),
    .in(pc_reg_out2),
    .out(pc_reg_out3)
);

register pc_reg4
(
    .clk(clk),
    .load(global_load && (~bubble_enable || flush_enable)),
    .in(pc_reg_out3),
    .out(pc_reg_out4)
);

register alu_reg
(
    .clk(clk),
    .load(global_load),
    .in(alu_out),
    .out(alu_reg_out)
);

register data_reg
(
    .clk(clk),
    .load(global_load),
    .in(alu_reg_out),
    .out(data_reg_out)
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
    .in(ctrlword2_in),
    .out(ctrl_mem)
);

ctrl_register ctrlword3
(
    .clk(clk),
    .load(global_load),
    .in(ctrl_mem),
    .out(ctrl_wb)
);

register ir_reg
(
    .clk(clk),
    .load(global_load),
    .in(ir_reg_in),
    .out(ir_reg_out)
);

register #(.width(3)) write_reg1
(
    .clk(clk),
    .load(global_load),
    .in(write_reg1_in),
    .out(write_reg1_out)
);

register #(.width(3)) write_reg2
(
    .clk(clk),
    .load(global_load),
    .in(write_reg1_out),
    .out(write_reg2_out)
);

register #(.width(3)) write_reg3
(
    .clk(clk),
    .load(global_load),
    .in(write_reg2_out),
    .out(write_reg3_out)
);

register sr1_reg1
(
    .clk(clk),
    .load(global_load),
    .in(sr1reg1_in),
    .out(sr1reg1_out)
);

register sr1_reg2
(
    .clk(clk),
    .load(global_load),
    .in(forwarding_mux_a_out),
    .out(sr1reg2_out)
);

register sr2_reg1
(
    .clk(clk),
    .load(global_load),
    .in(sr2reg1_in),
    .out(sr2reg1_out)
);

register sr2_reg2
(
    .clk(clk),
    .load(global_load),
    .in(sr2reg2_in),
    .out(sr2reg2_out)
);

register offsetadder_reg1
(
    .clk(clk),
    .load(global_load),
    .in(offsetadder_out),
    .out(offsetadder_reg1_out)
);

register offsetadder_reg2
(
    .clk(clk),
    .load(global_load),
    .in(offsetadder_reg1_out),
    .out(offsetadder_reg2_out)
);

register #(.width(3)) sr1_index_reg
(
    .clk(clk),
    .load(global_load),
    .in(sr1_index_reg_in),
    .out(sr1_index_reg_out)
);

register #(.width(3)) sr2_index_reg
(
    .clk(clk),
    .load(global_load),
    .in(sr2_index_reg_in),
    .out(sr2_index_reg_out)
);

register #(.width(1)) br_prediction_reg1
(
    .clk(clk),
    .load(global_load && ~bubble_enable),
    .in(branch_predict),
    .out(pred_reg1_out)
);

register #(.width(1)) br_prediction_reg2
(
    .clk(clk),
    .load(global_load && ~bubble_enable),
    .in(pred_reg1_out),
    .out(pred_reg2_out)
);

register #(.width(1)) br_prediction_reg3
(
    .clk(clk),
    .load(global_load && ~bubble_enable),
    .in(pred_reg2_out),
    .out(pred_reg3_out)
);

register #(.width(16)) mispredict_pc_reg1
(
    .clk(clk),
    .load(global_load),
    .in(last_br_pc),
    .out(mispredict_pc_reg1_out)
);

register #(.width(16)) mispredict_pc_reg2
(
    .clk(clk),
    .load(global_load),
    .in(mispredict_pc_reg1_out),
    .out(mispredict_pc_reg2_out)
);


/**************************************
 * Multiplexers                       *
 **************************************/

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
 * Branch mux
 */
mux2 br_mux
(
    .sel(ctrl_mem.brmux_sel && branch_enable && mispredict && ctrl_mem.opcode == op_br && ~ctrl_mem.is_nop),
    .a(pcmux_out),
    .b(offsetadder_reg1_out),
    .f(brmux_out)
);

/*
 * Indirect MAR mux
 */
mux2 indirect_mar_mux
(
    .sel((ctrl_mem.indirect_enable && resp_count == 2'b01 && d_mem_resp)),
    .a(alu_out),
    .b(mem_rdata),
    .f(indirect_marmux_out)
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
 * PC mux
 */
mux4 pc_mux
(
    .sel(ctrl_mem.pcmux_sel),
    .a(pc_plus2_out),
    .b(offsetadder_reg1_out),      //changes for trans reg
    .c(sr1reg2_out),            //changed to trans reg
    .d(mem_rdata),
    .f(pcmux_out)
);

/*
 * Regfile mux
 */
mux4 regfile_mux
(
    .sel(ctrl_wb.regfilemux_sel),
    .a(data_reg_out),       //changes for trans reg
    .b(mdr_out),
    .c(offsetadder_reg2_out), //changes for trans reg
    .d(pc_reg_out4),            //changed to trans reg
    .f(regfilemux_out)
);

/*
 * MAR mux
 */
mux4 mar_mux
(
    .sel(ctrl_exec.marmux_sel),
    .a(indirect_marmux_out),           //changed for trans reg
    .b(pc_reg_out2),                //changed for trans reg
    .c(regfile_filter_out),
    .d(zadj8_out),            //changed for trans reg
    .f(marmux_out)
);

mux4 forwarding_mux_a
(
    .sel(forwarding_sel_a),
    .a(sr1reg1_out),
    .b(alu_reg_out),
    .c(regfile_filter_out),
    .d(offsetadder_reg1_out),
    .f(forwarding_mux_a_out)
);

mux4 forwarding_mux_b
(
    .sel(ctrl_exec.mem_write ? 2'b00 : forwarding_sel_b),
    .a(alumux_out),
    .b(alu_reg_out),
    .c(regfile_filter_out),
    .d(offsetadder_reg1_out),
    .f(forwarding_mux_b_out)
);

endmodule : datapath
