import lc3b_types::*;

module victim_cache
(
    input clk,
    input d_v_mem_swap,
	input no_evict,
	input l1_dirty,
	input mem_read,
	input mem_write,
	input pmem_resp,
	input lc3b_word d_mem_address,
	input lc3b_word mem_address,
	input lc3b_mem_data mem_wdata,
	input lc3b_mem_data pmem_rdata,
	output logic dirty_out,
	output logic ld_from_vic,
	output logic mem_resp,
	output logic pmem_read,
	output logic pmem_write,
    output lc3b_word pmem_address,
	output lc3b_mem_data mem_rdata,
	output lc3b_mem_data pmem_wdata
);

logic ld_cache;
logic tag_match;
logic valid;
logic miss_get;
logic ld_data_reg;

victim_cache_datapath victim_cache_datapath
(
    .clk(clk),
    .ld_data_reg(ld_data_reg),
	.ld_cache(ld_cache),
	.l1_dirty(l1_dirty),
	.miss_get(miss_get),
	.tag_match(tag_match),
	.valid(valid),
	.dirty_out(dirty_out),
	.pmem_write(pmem_write),
	.d_mem_address(d_mem_address),
	.mem_address(mem_address),
	.mem_wdata(mem_wdata),
	.pmem_rdata(pmem_rdata),
	.mem_rdata(mem_rdata),
	.pmem_wdata(pmem_wdata),
	.pmem_address(pmem_address)
);

victim_cache_control victim_cache_control
(
    .clk(clk),
    .d_v_mem_swap(d_v_mem_swap),
	.mem_read(mem_read),
	.mem_write(mem_write),
	.tag_match(tag_match),
	.valid(valid),
	.dirty(dirty_out),
	.no_evict(no_evict),
	.ld_data_reg(ld_data_reg),
	.ld_cache(ld_cache),
	.mem_resp(mem_resp),
	.ld_from_vic(ld_from_vic),
	.miss_get(miss_get),
	.pmem_resp(pmem_resp),
    .pmem_read(pmem_read),
    .pmem_write(pmem_write)
);

endmodule : victim_cache
