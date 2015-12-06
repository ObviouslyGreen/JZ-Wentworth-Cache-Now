import lc3b_types::*;

/*
 * Top level for MP3
 */
module mp3
(
    input clk,

    /* Memory signals */
    input pmem_resp,
    input lc3b_pmem_data pmem_rdata,
    output pmem_read,
    output pmem_write,
    output lc3b_word pmem_address,
    output lc3b_pmem_data pmem_wdata

    /*input mem_resp,
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
    output lc3b_word instr_wdata*/
);

/*
assign i_mem_wdata = 0;
assign i_mem_write = 1'b0;
assign i_mem_read = 1'b1;
assign i_mem_mem_byte_enable = 2'b11;*/

/* declare internal signals */
logic branch_enable;
logic d_enable;
logic imm_enable;
logic jsr_enable;

logic i_pmem_read;
logic i_pmem_write;
logic i_mem_read;
logic i_mem_write;
logic i_mem_resp;
logic i_pmem_resp;
lc3b_mem_wmask i_mem_byte_enable;
lc3b_word i_mem_address;
lc3b_word i_mem_rdata;
lc3b_word i_mem_wdata;
lc3b_word i_pmem_address;
lc3b_mem_data i_pmem_wdata;

logic d_pmem_read;
logic d_pmem_write;
logic d_mem_read;
logic d_mem_write;
logic d_mem_resp;
logic d_pmem_resp;
lc3b_mem_wmask d_mem_byte_enable;
lc3b_word d_mem_address;
lc3b_word d_mem_rdata;
lc3b_word d_mem_wdata;
lc3b_word d_pmem_address;
lc3b_mem_data d_pmem_wdata;

logic l2_mem_resp;
logic l2_mem_read;
logic l2_mem_write;
lc3b_word l2_mem_address;
lc3b_mem_data l2_mem_rdata_in;
lc3b_mem_data l2_mem_rdata_out;
lc3b_mem_data l2_mem_wdata;

lc3b_mem_data arbiter_rdata_out;

lc3b_word i_miss_counter;
lc3b_word d_miss_counter;
lc3b_word l2_miss_counter;


/* Instantiate MP 3 top level blocks here */
datapath datapath_module
(
    .clk(clk),
    .i_mem_resp(i_mem_resp),
    .d_mem_resp(d_mem_resp),
    .instr_rdata(i_mem_rdata),
    .i_miss_counter(i_miss_counter),
    .d_miss_counter(d_miss_counter),
    .l2_miss_counter(l2_miss_counter),
    .mem_rdata(d_mem_rdata),
    .branch_enable(branch_enable),
    .d_enable(d_enable),
    .imm_enable(imm_enable),
    .jsr_enable(jsr_enable),
    .mem_read(d_mem_read),
    .mem_write(d_mem_write),
    .instr_read(i_mem_read),
    .instr_write(i_mem_write),
    .instr_wdata(i_mem_wdata),
    .instr_address(i_mem_address),
    .mem_wdata(d_mem_wdata),
    .mem_address(d_mem_address),
    .mem_byte_enable(d_mem_byte_enable)
);

l1_cache i_cache
(
    .clk(clk),
    .mem_read(i_mem_read),
    .mem_write(i_mem_write),
    .pmem_resp(i_pmem_resp),
    .mem_byte_enable(i_mem_byte_enable),
    .mem_wdata(i_mem_wdata),
    .mem_address(i_mem_address),
    .pmem_rdata(arbiter_rdata_out),
    .mem_resp(i_mem_resp),
    .pmem_read(i_pmem_read),
    .pmem_write(i_pmem_write),
    .mem_rdata(i_mem_rdata),
    .pmem_address(i_pmem_address),
    .pmem_wdata(i_pmem_wdata),
    .l1_miss_counter(i_miss_counter)
);

l1_cache d_cache
(
    .clk(clk),
    .mem_read(d_mem_read),
    .mem_write(d_mem_write),
    .pmem_resp(d_pmem_resp),
    .mem_byte_enable(d_mem_byte_enable),
    .mem_wdata(d_mem_wdata),
    .mem_address(d_mem_address),
    .pmem_rdata(arbiter_rdata_out),
    .mem_resp(d_mem_resp),
    .pmem_read(d_pmem_read),
    .pmem_write(d_pmem_write),
    .mem_rdata(d_mem_rdata),
    .pmem_address(d_pmem_address),
    .pmem_wdata(d_pmem_wdata),
    .l1_miss_counter(d_miss_counter)
);

l2_cache l2_cache
(
    .clk(clk),
    .mem_read(l2_mem_read),
    .mem_write(l2_mem_write),
    .pmem_resp(pmem_resp),
    .mem_byte_enable(2'b00),
    .mem_wdata(l2_mem_wdata),
    .mem_address(l2_mem_address),
    .pmem_rdata(pmem_rdata),
    .mem_resp(l2_mem_resp),
    .pmem_read(pmem_read),
    .pmem_write(pmem_write),
    .mem_rdata(l2_mem_rdata_in),
    .pmem_address(pmem_address),
    .pmem_wdata(pmem_wdata),
    .l2_miss_counter(l2_miss_counter)

);

arbiter arbiter
(
    .clk(clk),
    .l2_mem_resp(l2_mem_resp),
    .i_pmem_read(i_pmem_read),
    .i_pmem_write(i_pmem_write),
    .d_pmem_read(d_pmem_read),
    .d_pmem_write(d_pmem_write),
    .i_pmem_wdata(i_pmem_wdata),
    .i_pmem_address(i_pmem_address),
    .d_pmem_wdata(d_pmem_wdata),
    .d_pmem_address(d_pmem_address),
    .l2_mem_rdata_in(l2_mem_rdata_in),
    .i_pmem_resp(i_pmem_resp),
    .d_pmem_resp(d_pmem_resp),
    .l2_mem_read(l2_mem_read),
    .l2_mem_write(l2_mem_write),
    .l2_mem_address(l2_mem_address),
    .l2_mem_rdata_out(arbiter_rdata_out),
    .l2_mem_wdata(l2_mem_wdata)
);

//l2_cache

endmodule : mp3
