import lc3b_types::*;

module eviction_write_buffer
(
    input clk,
    input pmem_resp,
    input l2_pmem_read,
    input l2_pmem_write,
    input lc3b_word l2_pmem_waddress,
    input lc3b_word l2_pmem_raddress,
    input lc3b_pmem_data l2_pmem_wdata,
    output lc3b_word pmem_address,
    output lc3b_pmem_data pmem_wdata,
    output logic ready,
    output logic pmem_write
);

lc3b_word ewb_addr_buff_out;
logic ld_buff;

ewb_datapath ewb_datapath
(
    .clk(clk),
  	.l2_pmem_waddress(l2_pmem_waddress),
  	.l2_pmem_raddress(l2_pmem_raddress),
  	.l2_pmem_wdata(l2_pmem_wdata),
  	.ld_buff(ld_buff),
  	.ewb_addr_buff_out(ewb_addr_buff_out),
  	.pmem_wdata(pmem_wdata)
);

ewb_control ewb_control
(
    .clk(clk),
    .l2_pmem_write(l2_pmem_write),
	.pmem_resp(pmem_resp),
	.ewb_addr_buff_out(ewb_addr_buff_out),
	.l2_pmem_address(l2_pmem_raddress),
	.ready(ready), 
	.ld_buff(ld_buff), 
	.pmem_write(pmem_write),
	.pmem_address(pmem_address)
);

endmodule : eviction_write_buffer
