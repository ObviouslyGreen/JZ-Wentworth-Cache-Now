import lc3b_types::*;

/*
 * Top level for MP3
 */
module mp3
(
    input clk,

    /* Memory signals */
    /*input pmem_resp,
    input lc3b_mem_data pmem_rdata,
    output pmem_read,
    output pmem_write,
    output lc3b_word pmem_address,
    output lc3b_mem_data pmem_wdata*/

    input mem_resp,
    input lc3b_word mem_rdata,
    output logic mem_read,
    output logic mem_write,
    output lc3b_mem_wmask mem_byte_enable,
    output lc3b_word mem_address,
    output lc3b_word mem_wdata,
    input instr_resp,
    input lc3b_word instr_rdata,
    output logic instr_read,
    output logic instr_write,
    output lc3b_mem_wmask instr_mem_byte_enable,
    output lc3b_word instr_address,
    output lc3b_word instr_wdata
);


assign instr_wdata = 0;
assign instr_write = 1'b0;
assign instr_read = 1'b1;
assign instr_mem_byte_enable = 2'b11;

/* declare internal signals */
/*logic load_pc;
logic load_ir;
logic load_regfile;
logic load_mar;
logic load_mdr;
logic load_cc;
logic regfile_filter_enable;
logic stb_filter_enable;
logic [1:0] pcmux_sel;
logic storemux_sel;
logic destmux_sel;
logic [1:0] alumux_sel;
logic [1:0] regfilemux_sel;
logic [1:0] marmux_sel;
logic mdrmux_sel;
logic offsetaddermux_sel;
logic offset6mux_sel;*/
lc3b_aluop aluop;
lc3b_opcode opcode;
logic branch_enable;
logic d_enable;
logic imm_enable;
logic jsr_enable;
/*
logic ld_cache;
logic ld_dirty0;
logic ld_dirty1;
logic ld_lru;
logic dirtymux_sel;
logic writecachemux_sel;
logic data0mux_sel;
logic data1mux_sel;
logic hit;
logic curr_way;
logic lru_out;
logic dirty0_out;
logic dirty1_out;
lc3b_c_tag pmem_tag;
logic cache_resp;
lc3b_word cache_rdata;
logic cache_read;
logic cache_write;
lc3b_word cache_address;
lc3b_word cache_wdata;*/

/* Instantiate MP 2 top level blocks here */
/*
control control_module
(
    .clk(clk),
    .opcode(opcode),
    .branch_enable(branch_enable),
    .d_enable(d_enable),
    .imm_enable(imm_enable),
    .jsr_enable(jsr_enable),
    .stb_high_enable(cache_address[0]),
    .load_pc(load_pc),
    .load_ir(load_ir),
    .load_regfile(load_regfile),
    .load_mar(load_mar),
    .load_mdr(load_mdr),
    .load_cc(load_cc),
    .regfile_filter_enable(regfile_filter_enable),
    .stb_filter_enable(stb_filter_enable),
    .pcmux_sel(pcmux_sel),
    .storemux_sel(storemux_sel),
    .destmux_sel(destmux_sel),
    .alumux_sel(alumux_sel),
    .regfilemux_sel(regfilemux_sel),
    .marmux_sel(marmux_sel),
    .mdrmux_sel(mdrmux_sel),
    .offsetaddermux_sel(offsetaddermux_sel),
    .offset6mux_sel(offset6mux_sel),
    .aluop(aluop),
    .mem_resp(cache_resp),
    .mem_read(cache_read),
    .mem_write(cache_write),
    .mem_byte_enable(mem_byte_enable)
);*/

datapath datapath_module
(
    .clk(clk),
    /*.load_pc(load_pc),
    .load_ir(load_ir),
    .load_regfile(load_regfile),
    .load_mar(load_mar),
    .load_mdr(load_mdr),
    .load_cc(load_cc),
    .regfile_filter_enable(regfile_filter_enable),
    .stb_filter_enable(stb_filter_enable),
    .pcmux_sel(pcmux_sel),
    .storemux_sel(storemux_sel),
    .destmux_sel(destmux_sel),
    .alumux_sel(alumux_sel),
    .regfilemux_sel(regfilemux_sel),
    .marmux_sel(marmux_sel),
    .mdrmux_sel(mdrmux_sel),
    .offsetaddermux_sel(offsetaddermux_sel),
    .offset6mux_sel(offset6mux_sel),*/
    .aluop(aluop),
    .opcode(opcode),
    .branch_enable(branch_enable),
    .d_enable(d_enable),
    .imm_enable(imm_enable),
    .jsr_enable(jsr_enable),
    .mem_rdata(mem_rdata),
    .mem_read(mem_read),
    .mem_write(mem_write),
    .mem_byte_enable(mem_byte_enable),
    .mem_wdata(mem_wdata),
    .mem_address(mem_address),
    .instr_rdata(instr_rdata),
    .instr_address(instr_address)
);
/*
cache_datapath cache_datapath_module
(
    .clk(clk),
    .ld_cache(ld_cache),
    .ld_dirty0(ld_dirty0),
    .ld_dirty1(ld_dirty1),
    .ld_lru(ld_lru),
    .dirtymux_sel(dirtymux_sel),
    .writecachemux_sel(writecachemux_sel),
    .data0mux_sel(data0mux_sel),
    .data1mux_sel(data1mux_sel),
    .hit(hit),
    .curr_way(curr_way),
    .lru_out(lru_out),
    .dirty0_out(dirty0_out),
    .dirty1_out(dirty1_out),
    .pmem_tag(pmem_tag),
    .mem_address(cache_address),
    .mem_wdata(cache_wdata),
    .pmem_rdata(pmem_rdata),
    .mem_byte_enable(mem_byte_enable),
    .mem_rdata(cache_rdata),
    .pmem_wdata(pmem_wdata)
);

cache_control cache_control_module
(
    .clk(clk),
    .hit(hit),
    .curr_way(curr_way),
    .lru_out(lru_out),
    .dirty0_out(dirty0_out),
    .dirty1_out(dirty1_out),
    .pmem_tag(pmem_tag),
    .ld_cache(ld_cache),
    .ld_dirty0(ld_dirty0),
    .ld_dirty1(ld_dirty1),
    .ld_lru(ld_lru),
    .dirtymux_sel(dirtymux_sel),
    .writecachemux_sel(writecachemux_sel),
    .data0mux_sel(data0mux_sel),
    .data1mux_sel(data1mux_sel),
    .mem_address(cache_address),
    .pmem_resp(pmem_resp),
    .mem_read(cache_read),
    .mem_write(cache_write),
    .pmem_address(pmem_address),
    .mem_resp(cache_resp),
    .pmem_read(pmem_read),
    .pmem_write(pmem_write)
);
*/
endmodule : mp3
