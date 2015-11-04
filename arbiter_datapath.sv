import lc3b_types::*; 

module arbiter_datapath
(
	input arbiter_sel,
	input i_mem_read,
	input i_mem_write, 
	input d_mem_read, 
	input d_mem_write, 
	input lc3b_mem_data i_mem_wdata, 
	input lc3b_word i_mem_address, 
	input lc3b_mem_data d_mem_wdata, 
	input lc3b_word d_mem_address, 

	output logic l2_mem_read, 
	output logic l2_mem_write, 
	output lc3b_mem_data l2_mem_wdata,
	output lc3b_word l2_mem_address
);

mux2 #(.width(1)) mem_read_mux
(
    .sel(arbiter_sel),
    .a(i_mem_read),
    .b(d_mem_read),
    .f(l2_mem_read)
);

mux2 #(.width(1)) mem_wrte_mux
(
    .sel(arbiter_sel),
    .a(i_mem_write),
    .b(d_mem_write),
    .f(l2_mem_write)
);

mux2 #(.width(128)) mem_read_mux
(
    .sel(arbiter_sel),
    .a(i_mem_wdata),
    .b(d_mem_wdata),
    .f(l2_mem_wdata)
);

mux2 mem_address_mux
(
    .sel(arbiter_sel),
    .a(i_mem_address),
    .b(d_mem_address),
    .f(l2_mem_address)
);

endmodule : arbiter_datapath