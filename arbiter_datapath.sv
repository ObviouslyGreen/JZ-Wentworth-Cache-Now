import lc3b_types::*; 

module arbiter_datapath
(
	input arbiter_sel,
	input i_pmem_read,
	input i_pmem_write, 
	input d_pmem_read, 
	input d_pmem_write, 
	input lc3b_mem_data i_pmem_wdata, 
	input lc3b_word i_pmem_address, 
	input lc3b_mem_data d_pmem_wdata, 
	input lc3b_word d_pmem_address, 

	output logic l2_mem_read, 
	output logic l2_mem_write, 
	output lc3b_mem_data l2_mem_wdata,
	output lc3b_word l2_mem_address
);


mux2 #(.width(1)) mem_read_mux
(
    .sel(arbiter_sel),
    .a(i_pmem_read),
    .b(d_pmem_read),
    .f(l2_mem_read)
);

mux2 #(.width(1)) mem_wrte_mux
(
    .sel(arbiter_sel),
    .a(i_pmem_write),
    .b(d_pmem_write),
    .f(l2_mem_write)
);

mux2 #(.width(128)) mem_read_mux
(
    .sel(arbiter_sel),
    .a(i_pmem_wdata),
    .b(d_pmem_wdata),
    .f(l2_mem_wdata)
);

mux2 mem_address_mux
(
    .sel(arbiter_sel),
    .a(i_pmem_address),
    .b(d_pmem_address),
    .f(l2_mem_address)
);

endmodule : arbiter_datapath