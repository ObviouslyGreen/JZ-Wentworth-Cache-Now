import lc3b_types::*;

/*
 * Datapath for cache
 */
module victim_cache_datapath
(
    input clk,

    /* Control signals */
    input ld_cache,
    input l1_dirty,
    input miss_get,
    output logic tag_match,
    output logic valid,
    output logic tag_match_reg_out,
    output logic valid_reg_out,
    output logic dirty_reg_out,

    /* Memory signals */
    input pmem_write,
    input lc3b_word d_mem_address,
    input lc3b_word mem_address,
    input lc3b_mem_data mem_wdata,
    input lc3b_mem_data pmem_rdata,
    output lc3b_mem_data mem_rdata,
    output lc3b_mem_data pmem_wdata,
    output lc3b_word pmem_address
);


/* declare internal signals */
lc3b_c_vic_index index;
lc3b_c_vic_index indexmux_out;
lc3b_c_vic_index lru_out;
lc3b_mem_data data_out;
lc3b_mem_data data_reg_out;
logic comparator0_out;
logic comparator1_out;
logic comparator2_out;
logic comparator3_out;
logic dirty_out;

lc3b_c_vic_tag tag;
lc3b_c_vic_tag tag_out;
lc3b_c_vic_tag tag0_out;
lc3b_c_vic_tag tag1_out;
lc3b_c_vic_tag tag2_out;
lc3b_c_vic_tag tag3_out;
lc3b_c_vic_tag load_mem_tag;

/* assign internal logic */
always_comb
begin
    if (comparator0_out)
        index = 2'b00;
    else if (comparator1_out)
        index = 2'b01;
    else if (comparator2_out)
        index = 2'b10;
    else if (comparator3_out)
        index = 2'b11;
    else
        index = 2'b00;
end

assign tag_match = comparator0_out | comparator1_out | 
                    comparator2_out | comparator3_out; 
assign tag = mem_address[15:4];
assign load_mem_tag = d_mem_address[15:4];
assign pmem_wdata = data_out;


/**************************************
 * User modules                       *
 **************************************/

/*
 * Tag Comparator 0
 */
comparator comparator0
(
    .clk(clk),
    .a(tag),
    .b(tag0_out),
    .out(comparator0_out)
);

/*
 * Tag Comparator 1
 */
comparator comparator1
(
    .clk(clk),
    .a(tag),
    .b(tag1_out),
    .out(comparator1_out)
);

/*
 * Tag Comparator 1
 */
comparator comparator2
(
    .clk(clk),
    .a(tag),
    .b(tag2_out),
    .out(comparator2_out)
);

/*
 * Tag Comparator 1
 */
comparator comparator3
(
    .clk(clk),
    .a(tag),
    .b(tag3_out),
    .out(comparator3_out)
);

/*
 * LRU
 */
lru_stack lru
(
    .clk(clk),
    .write(ld_cache),
    .index(indexmux_out),
    .out(lru_out)
);


/**************************************
 * Arrays and registers               *
 **************************************/

/*
 * Data 
 */
victim_array data
(
    .clk(clk),
    .load(ld_cache),
    .index(indexmux_out),
    .in(mem_wdata),
    .out(data_out)
);

register #(.width(128)) data_reg
(
    .clk(clk),
    .load(ld_cache),
    .in(data_out),
    .out(data_reg_out)
);

/*
 * Tag 
 */
victim_tag_array #(.width(9)) tag
(
    .clk(clk),
    .load(ld_cache),
    .index(index),
    .in(tag),
    .out(tag_out),
    .data0(tag0_out),
    .data1(tag1_out),
    .data2(tag2_out),
    .data3(tag3_out),
);

register #(.width(1)) tag_reg_buffer
(
    .clk(clk),
    .load(ld_cache),
    .in(tag_match),
    .out(tag_match_reg_out)
);

/*
 * Valid 
 */
victim_array #(.width(1)) valid
(
    .clk(clk),
    .load(ld_cache),
    .index(indexmux_out),
    .in(1'b1),
    .out(valid)
);

register #(.width(1)) valid_reg
(
    .clk(clk),
    .load(ld_cache),
    .in(valid),
    .out(valid_reg_out)
);

/*
 * Dirty 
 */
victim_array #(.width(1)) dirty
(
    .clk(clk),
    .load(ld_cache),
    .index(indexmux_out),
    .in(l1_dirty),
    .out(dirty_out)
);

register #(.width(1)) dirty_reg
(
    .clk(clk),
    .load(ld_cache),
    .in(dirty),
    .out(dirty_reg_out)
);

/**************************************
 * Multiplexers                       *
 **************************************/

/* 
 * Index mux
 */
mux2 #(.width(2)) indexmux
(
    .sel(tag_match),
    .a(lru_out),
    .b(index),
    .f(indexmux_out)
);

/*
 * mem_rdata mux
 */
mux2 #(.width(128)) mem_rdata_mux
(
    .sel(miss_get),
    .a(data_buffer_out),
    .b(pmem_rdata),
    .f(mem_rdata)
);

/*
 * pmem_address mux
 */
mux2 #(.width(16)) pmem_address_mux
(
    .sel(pmem_write),
    .a(mem_address),
    .b({tag_out, 4'b0000}),
    .f(pmem_address)
);

endmodule : victim_cache_datapath
