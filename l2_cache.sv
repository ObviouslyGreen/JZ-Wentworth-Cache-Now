import lc3b_types::*; 

module l2_cache
(
    input clk,
    input ewb_ready,
    input mem_read,
    input mem_write,
    input pmem_resp,
    input lc3b_mem_wmask mem_byte_enable,
    input lc3b_mem_data mem_wdata,
    input lc3b_word mem_address,
    input lc3b_pmem_data pmem_rdata,
    output logic mem_resp,
    output logic pmem_read,
    output logic pmem_write,
    output lc3b_mem_data mem_rdata,
    output lc3b_word pmem_address,
    output lc3b_word pmem_waddress,
    output lc3b_pmem_data pmem_wdata
);

logic ld_cache;
logic ld_dirty0;
logic ld_dirty1;
logic ld_dirty2;
logic ld_dirty3;
logic ld_lru;
logic dirty_clean;
logic writecachemux_sel;
logic data0mux_sel;
logic data1mux_sel;
logic data2mux_sel;
logic data3mux_sel;
logic hit;
logic [1:0] curr_way;
logic [1:0] lru_out;
logic dirty0_out;
logic dirty1_out;
logic dirty2_out;
logic dirty3_out;
lc3b_c_l2_tag pmem_tag;

l2_cache_datapath l2_cache_datapath
(
    .clk(clk),
    .ld_cache(ld_cache),
    .ld_dirty0(ld_dirty0),
    .ld_dirty1(ld_dirty1),
    .ld_dirty2(ld_dirty2),
    .ld_dirty3(ld_dirty3),
    .ld_lru(ld_lru),
    .dirty_clean(dirty_clean),
    .writecachemux_sel(writecachemux_sel),
    .data0mux_sel(data0mux_sel),
    .data1mux_sel(data1mux_sel),
    .data2mux_sel(data2mux_sel),
    .data3mux_sel(data3mux_sel),
    .hit(hit),
    .curr_way(curr_way),
    .lru_out(lru_out),
    .dirty0_out(dirty0_out),
    .dirty1_out(dirty1_out),
    .dirty2_out(dirty2_out),
    .dirty3_out(dirty3_out),
    .pmem_tag(pmem_tag),
    .mem_address(mem_address),
    .mem_wdata(mem_wdata),
    .pmem_rdata(pmem_rdata),
    .mem_byte_enable(mem_byte_enable),
    .mem_rdata(mem_rdata),
    .pmem_wdata(pmem_wdata)
);

l2_cache_control l2_cache_control
(
    .clk(clk),
    .ewb_ready(ewb_ready),
    .hit(hit),
    .curr_way(curr_way),
    .lru_out(lru_out),
    .dirty0_out(dirty0_out),
    .dirty1_out(dirty1_out),
    .dirty3_out(dirty2_out),
    .dirty2_out(dirty3_out),
    .pmem_tag(pmem_tag),
    .ld_cache(ld_cache),
    .ld_dirty0(ld_dirty0),
    .ld_dirty1(ld_dirty1),
    .ld_dirty2(ld_dirty2),
    .ld_dirty3(ld_dirty3),
    .ld_lru(ld_lru),
    .dirty_clean(dirty_clean),
    .writecachemux_sel(writecachemux_sel),
    .data0mux_sel(data0mux_sel),
    .data1mux_sel(data1mux_sel),
    .data2mux_sel(data2mux_sel),
    .data3mux_sel(data3mux_sel),
    .mem_address(mem_address),
    .pmem_resp(pmem_resp),
    .mem_read(mem_read),
    .mem_write(mem_write),
    .pmem_address(pmem_address),
    .pmem_waddress(pmem_waddress),
    .mem_resp(mem_resp),
    .pmem_read(pmem_read),
    .pmem_write(pmem_write)
);

endmodule : l2_cache
