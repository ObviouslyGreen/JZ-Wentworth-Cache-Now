import lc3b_types::*; 

module arbiter
(
    input l2_mem_resp,
    input i_pmem_read,
    input i_pmem_write, 
    input d_pmem_read, 
    input d_pmem_write, 
    input lc3b_mem_data i_pmem_wdata, 
    input lc3b_word i_pmem_address, 
    input lc3b_mem_data d_pmem_wdata, 
    input lc3b_word d_pmem_address,  
    input lc3b_mem_data l2_mem_rdata_in,
    output logic i_pmem_resp,
    output logic d_pmem_resp,
    output logic l2_mem_read, 
    output logic l2_mem_write,
    output lc3b_word l2_mem_address,
    output lc3b_mem_data l2_mem_rdata_out,
    output lc3b_mem_data l2_mem_wdata
);

logic arbiter_sel;

always_comb
begin
    l2_mem_rdata_out = l2_mem_rdata_in;
end

arbiter_datapath arbiter_datapath
(
    .arbiter_sel(arbiter_sel),
    .i_pmem_read(i_pmem_read),
    .i_pmem_write(i_pmem_write), 
    .d_pmem_read(d_pmem_read), 
    .d_pmem_write(d_pmem_write), 
    .i_pmem_wdata(i_pmem_wdata), 
    .i_pmem_address(i_pmem_address), 
    .d_pmem_wdata(d_pmem_wdata), 
    .d_pmem_address(d_pmem_address), 
    .l2_mem_read(l2_mem_read), 
    .l2_mem_write(l2_mem_write), 
    .l2_mem_wdata(l2_mem_wdata),
    .l2_mem_address(l2_mem_address)
);

arbiter_control arbiter_control
(
    .clk(clk),
    .i_pmem_read(i_pmem_read),
    .d_pmem_read(d_pmem_read),
    .d_pmem_write(d_pmem_write),
    .l2_mem_resp(l2_mem_resp),
    .i_pmem_resp(i_pmem_resp),
    .d_pmem_resp(d_pmem_resp),
    .arbiter_sel(arbiter_sel)
);

endmodule : arbiter