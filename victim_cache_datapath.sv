import lc3b_types::*;

/*
 * Datapath for cache
 */
module victim_cache_datapath
(
    input clk,

    /* Control signals */
    input ld_data_reg,
    input ld_cache,
    input l1_dirty,
    input miss_get,
    output logic tag_match,
    output logic valid,
    output logic dirty_out,

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
logic comparator0_out;
logic comparator1_out;
logic comparator2_out;
logic comparator3_out;
lc3b_mem_data datareg_out;

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

assign tag_match = comparator0_out || comparator1_out || 
                    comparator2_out || comparator3_out; 
assign tag = mem_address[15:4];
assign load_mem_tag = d_mem_address[15:4];
assign pmem_wdata = datareg_out;


/**************************************
 * User modules                       *
 **************************************/

/*
 * Tag Comparator 0
 */
comparator #(.width(12)) comparator0
(
    .clk(clk),
    .a(load_mem_tag),
    .b(tag0_out),
    .out(comparator0_out)
);

/*
 * Tag Comparator 1
 */
comparator #(.width(12)) comparator1
(
    .clk(clk),
    .a(load_mem_tag),
    .b(tag1_out),
    .out(comparator1_out)
);

/*
 * Tag Comparator 1
 */
comparator #(.width(12)) comparator2
(
    .clk(clk),
    .a(load_mem_tag),
    .b(tag2_out),
    .out(comparator2_out)
);

/*
 * Tag Comparator 1
 */
comparator #(.width(12)) comparator3
(
    .clk(clk),
    .a(load_mem_tag),
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
 * Arrays                             *
 **************************************/
/*
 * data in reg
 */
register_neg #(.width(128)) data_reg
(
    .clk(clk),
    .load(ld_cache),
    .in(data_out),
    .out(datareg_out)
);

/*
 * Data 
 */
victim_array #(.width(128)) data
(
    .clk(clk),
    .load(ld_cache),
    .index(indexmux_out),
    .in(mem_wdata),
    .out(data_out)
);

/*
 * Tag 
 */
victim_tag_array tag_array
(
    .clk(clk),
    .load(ld_cache),
    .index(indexmux_out),
    .in(tag),
    .out(tag_out),
    .data0(tag0_out),
    .data1(tag1_out),
    .data2(tag2_out),
    .data3(tag3_out)
);

/*
 * Valid 
 */
victim_array #(.width(1)) valid_array
(
    .clk(clk),
    .load(ld_cache),
    .index(indexmux_out),
    .in(1'b1),
    .out(valid)
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
    .a(data_out),
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
