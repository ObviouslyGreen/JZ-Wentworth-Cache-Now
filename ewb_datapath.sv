import lc3b_types::*;

module ewb_datapath
(
    input clk,
    input lc3b_word l2_pmem_waddress,
    input lc3b_word l2_pmem_raddress,
    input lc3b_pmem_data l2_pmem_wdata,
    input ld_buff,
    output lc3b_word ewb_addr_buff_out,
    output lc3b_pmem_data pmem_wdata
);


register #(.width(256)) ewb_data_buff
(
    .clk(clk),
    .load(ld_buff),
    .in(l2_pmem_wdata),
    .out(pmem_wdata)
);


register #(.width(256)) ewb_addr_buff
(
    .clk(clk),
    .load(ld_buff),
    .in(l2_pmem_waddress),
    .out(ewb_addr_buff_out)
);
endmodule : ewb_datapath
