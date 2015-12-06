import lc3b_types::*; 

module i_cache
(
    input clk,
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
    output lc3b_word mem_rdata,
    output lc3b_word pmem_address,
    output lc3b_mem_data pmem_wdata,
    output lc3b_word l1_miss_counter
);

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
initial
begin
    l1_miss_counter = 0;
end

always_ff @ (posedge clk)
begin
    if (pmem_resp)
        l1_miss_counter++;
end


i_cache_datapath cache_datapath_module
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
    .mem_address(mem_address),
    .mem_wdata(mem_wdata),
    .pmem_rdata(pmem_rdata),
    .mem_byte_enable(mem_byte_enable),
    .mem_rdata(mem_rdata),
    .pmem_wdata(pmem_wdata)
);

i_cache_control cache_control_module
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
    .mem_address(mem_address),
    .pmem_resp(pmem_resp),
    .mem_read(mem_read),
    .mem_write(mem_write),
    .pmem_address(pmem_address),
    .mem_resp(mem_resp),
    .pmem_read(pmem_read),
    .pmem_write(pmem_write)
);

endmodule : i_cache
