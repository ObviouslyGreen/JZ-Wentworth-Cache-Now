import lc3b_types::*; 

module d_cache
(
    input clk,
    input ld_from_vic,
    input dirty_in,
    output logic dirty_out,
    output logic no_evict,
    input mem_read,
    input mem_write,
    input pmem_resp,
    input lc3b_mem_wmask mem_byte_enable,
    input lc3b_word mem_wdata,
    input lc3b_word mem_address,
    input lc3b_mem_data pmem_rdata,
    output logic mem_resp,
    output logic pmem_read,
    output logic pmem_write,
    output logic pmem_swap,
    output lc3b_word mem_rdata,
    output lc3b_word pmem_address,
    output lc3b_mem_data pmem_wdata,
    output lc3b_word l1_miss_counter
);

logic ld_cache;
logic ld_dirty0;
logic ld_dirty1;
logic ld_lru;
logic writecachemux_sel;
logic data0mux_sel;
logic data1mux_sel;
logic hit;
logic curr_way;
logic lru_out;
logic valid0_out;
logic valid1_out;
logic dirty0_in;
logic dirty1_in;
logic dirty0_out;
logic dirty1_out;
lc3b_c_tag pmem_tag;

initial
begin
    l1_miss_counter = 0;
end

always_ff @ (posedge clk)
begin
    if (pmem_resp)
        l1_miss_counter++;
end

d_cache_datapath cache_datapath_module
(
    .clk(clk),
    .ld_cache(ld_cache),
    .ld_dirty0(ld_dirty0),
    .ld_dirty1(ld_dirty1),
    .ld_lru(ld_lru),
    .writecachemux_sel(writecachemux_sel),
    .data0mux_sel(data0mux_sel),
    .data1mux_sel(data1mux_sel),
    .ld_from_vic(ld_from_vic),
    .dirty0_in(dirty0_in),
    .dirty1_in(dirty1_in),
    .dirty_in(dirty_in),
    .hit(hit),
    .curr_way(curr_way),
    .lru_out(lru_out),
    .valid0_out(valid0_out),
    .valid1_out(valid1_out),
    .dirty_out(dirty_out),
    .dirty0_out(dirty0_out),
    .dirty1_out(dirty1_out),
    .pmem_tag(pmem_tag),
    .mem_address(mem_address),
    .mem_wdata(mem_wdata),
    .pmem_rdata(pmem_rdata),
    .mem_byte_enable(mem_byte_enable),
    .mem_rdata(mem_rdata),
    .pmem_wdata(pmem_wdata)
);

d_cache_control cache_control_module
(
    .clk(clk),
    .hit(hit),
    .curr_way(curr_way),
    .lru_out(lru_out),
    .valid0_out(valid0_out),
    .valid1_out(valid1_out),
    .dirty0_out(dirty0_out),
    .dirty1_out(dirty1_out),
    .pmem_tag(pmem_tag),
    .ld_cache(ld_cache),
    .ld_dirty0(ld_dirty0),
    .ld_dirty1(ld_dirty1),
    .dirty0_in(dirty0_in),
    .dirty1_in(dirty1_in),
    .ld_lru(ld_lru),
    .writecachemux_sel(writecachemux_sel),
    .data0mux_sel(data0mux_sel),
    .data1mux_sel(data1mux_sel),
    .no_evict(no_evict),
    .mem_address(mem_address),
    .pmem_resp(pmem_resp),
    .mem_read(mem_read),
    .mem_write(mem_write),
    .pmem_address(pmem_address),
    .mem_resp(mem_resp),
    .pmem_read(pmem_read),
    .pmem_write(pmem_write),
    .pmem_swap(pmem_swap)
);

endmodule : d_cache
