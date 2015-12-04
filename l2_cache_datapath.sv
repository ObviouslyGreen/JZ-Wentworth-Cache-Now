import lc3b_types::*;

/*
 * Datapath for cache
 */
module l2_cache_datapath
(
    input clk,

    /* Control signals */
    input ld_cache,
    input ld_dirty0,
    input ld_dirty1,
    input ld_dirty2,
    input ld_dirty3,
    input ld_lru,
    input dirty_clean,
    input writecachemux_sel,
    input data0mux_sel,
    input data1mux_sel,
    input data2mux_sel,
    input data3mux_sel,
    output hit,
    output [1:0] curr_way,
    output [1:0] lru_out,
    output dirty0_out,
    output dirty1_out,
    output dirty2_out,
    output dirty3_out,
    output lc3b_c_l2_tag pmem_tag,

    /* Memory signals */
    input lc3b_word mem_address,
    input lc3b_mem_data mem_wdata,
    input lc3b_pmem_data pmem_rdata,
    input lc3b_mem_wmask mem_byte_enable,
    output lc3b_mem_data mem_rdata,
    output lc3b_pmem_data pmem_wdata
);


/* declare internal signals */
lc3b_c_l2_index index /* synthesis syn_maxfan = 50 */;
lc3b_c_l2_offset offset;
lc3b_c_l2_tag tag;
lc3b_pmem_data l2_data_line_filter_out;
lc3b_pmem_data data_out;
lc3b_pmem_data data0_out;
lc3b_pmem_data data1_out;
lc3b_pmem_data data2_out;
lc3b_pmem_data data3_out;
lc3b_c_l2_tag tag0_out;
lc3b_c_l2_tag tag1_out;
lc3b_c_l2_tag tag2_out;
lc3b_c_l2_tag tag3_out;
logic valid0_out;
logic valid1_out;
logic valid2_out;
logic valid3_out;
logic comparator0_out;
logic comparator1_out;
logic comparator2_out;
logic comparator3_out;
logic lddata0mux_out;
logic lddata1mux_out;
logic lddata2mux_out;
logic lddata3mux_out;
lc3b_pmem_data writecachemux_out;
logic ld_arrays_0;
logic ld_arrays_1;
logic ld_arrays_2;
logic ld_arrays_3;
logic tag_valid_0;
logic tag_valid_1;
logic tag_valid_2;
logic tag_valid_3;
logic decoder_out0;
logic decoder_out1;
logic decoder_out2;
logic decoder_out3;

/* assign internal logic */
assign ld_arrays_0 = decoder_out0 & ld_cache;
assign ld_arrays_1 = decoder_out1 & ld_cache;
assign ld_arrays_2 = decoder_out2 & ld_cache;
assign ld_arrays_3 = decoder_out3 & ld_cache;
assign tag_valid_0 = comparator0_out & valid0_out;
assign tag_valid_1 = comparator1_out & valid1_out;
assign tag_valid_2 = comparator2_out & valid2_out;
assign tag_valid_3 = comparator3_out & valid3_out;
assign hit         = tag_valid_0 | tag_valid_1 | tag_valid_2 | tag_valid_3;
assign offset      = mem_address[4:0];
assign index       = mem_address[8:5];
assign tag         = mem_address[15:9];

/**************************************
 * User modules                       *
 **************************************/
/*
 * Encoder
 */
encoder encoder
(
    .a(tag_valid_0),
    .b(tag_valid_1),
    .c(tag_valid_2),
    .d(tag_valid_3),
    .out(curr_way)
);

/*
 * Decoder
 */
decoder decoder
(
    .in(lru_out),
    .d0(decoder_out0),
    .d1(decoder_out1),
    .d2(decoder_out2),
    .d3(decoder_out3)
);

l2_data_line_filter l2_data_line_filter
(
    .offset(offset[4]),
    .mem_wdata(mem_wdata),
    .datablock(data_out),
    .out(l2_data_line_filter_out)
);

/*
 * Tag Comparator 0
 */
comparator #(.width(7)) comparator0
(
    .clk(clk),
    .a(tag),
    .b(tag0_out),
    .out(comparator0_out)
);

/*
 * Tag Comparator 1
 */
comparator #(.width(7)) comparator1
(
    .clk(clk),
    .a(tag),
    .b(tag1_out),
    .out(comparator1_out)
);

/*
 * Tag Comparator 2
 */
comparator #(.width(7)) comparator2
(
    .clk(clk),
    .a(tag),
    .b(tag2_out),
    .out(comparator2_out)
);

/*
 * Tag Comparator 3
 */
comparator #(.width(7)) comparator3
(
    .clk(clk),
    .a(tag),
    .b(tag3_out),
    .out(comparator3_out)
);


/**************************************
 * Arrays                             *
 **************************************/

/*
 * Data 0
 */
l2_array data0
(
    .clk(clk),
    .load(lddata0mux_out),
    .index(index),
    .in(writecachemux_out),
    .out(data0_out)
);

/*
 * Data 1
 */
l2_array data1
(
    .clk(clk),
    .load(lddata1mux_out),
    .index(index),
    .in(writecachemux_out),
    .out(data1_out)
);

/*
 * Data 2
 */
l2_array data2
(
    .clk(clk),
    .load(lddata2mux_out),
    .index(index),
    .in(writecachemux_out),
    .out(data2_out)
);

/*
 * Data 3
 */
l2_array data3
(
    .clk(clk),
    .load(lddata3mux_out),
    .index(index),
    .in(writecachemux_out),
    .out(data3_out)
);

/*
 * Tag 0
 */
l2_array #(.width(7)) tag0
(
    .clk(clk),
    .load(ld_arrays_0),
    .index(index),
    .in(tag),
    .out(tag0_out)
);

/*
 * Tag 1
 */
l2_array #(.width(7)) tag1
(
    .clk(clk),
    .load(ld_arrays_1),
    .index(index),
    .in(tag),
    .out(tag1_out)
);

/*
 * Tag 2
 */
l2_array #(.width(7)) tag2
(
    .clk(clk),
    .load(ld_arrays_2),
    .index(index),
    .in(tag),
    .out(tag2_out)
);

/*
 * Tag 3
 */
l2_array #(.width(7)) tag3
(
    .clk(clk),
    .load(ld_arrays_3),
    .index(index),
    .in(tag),
    .out(tag3_out)
);

/*
 * Valid 0
 */
l2_array #(.width(1)) valid0
(
    .clk(clk),
    .load(ld_arrays_0),
    .index(index),
    .in(1'b1),
    .out(valid0_out)
);

/*
 * Valid 1
 */
l2_array #(.width(1)) valid1
(
    .clk(clk),
    .load(ld_arrays_1),
    .index(index),
    .in(1'b1),
    .out(valid1_out)
);

/*
 * Valid 2
 */
l2_array #(.width(1)) valid2
(
    .clk(clk),
    .load(ld_arrays_2),
    .index(index),
    .in(1'b1),
    .out(valid2_out)
);

/*
 * Valid 3
 */
l2_array #(.width(1)) valid3
(
    .clk(clk),
    .load(ld_arrays_3),
    .index(index),
    .in(1'b1),
    .out(valid3_out)
);

/*
 * Dirty 0
 */
l2_array #(.width(1)) dirty0
(
    .clk(clk),
    .load(ld_dirty0),
    .index(index),
    .in(dirty_clean),
    .out(dirty0_out)
);

/*
 * Dirty 1
 */
l2_array #(.width(1)) dirty1
(
    .clk(clk),
    .load(ld_dirty1),
    .index(index),
    .in(dirty_clean),
    .out(dirty1_out)
);

/*
 * Dirty 2
 */
l2_array #(.width(1)) dirty2
(
    .clk(clk),
    .load(ld_dirty2),
    .index(index),
    .in(dirty_clean),
    .out(dirty2_out)
);

/*
 * Dirty 3
 */
l2_array #(.width(1)) dirty3
(
    .clk(clk),
    .load(ld_dirty3),
    .index(index),
    .in(dirty_clean),
    .out(dirty3_out)
);

/*
 * LRU
 */
pseudo_lru lru
(
    .clk(clk),
    .write(ld_lru),
    .index(index),
    .in(curr_way),
    .out(lru_out)
);


/**************************************
 * Multiplexers                       *
 **************************************/
 /*
 * Write cache mux
 */
mux2 #(.width(256)) writecache_mux
(
    .sel(writecachemux_sel),
    .a(pmem_rdata),
    .b(l2_data_line_filter_out),
    .f(writecachemux_out)
);

/*
 * Load data 0 mux
 */
mux2 #(.width(1)) lddata0_mux
(
    .sel(data0mux_sel),
    .a(ld_arrays_0),
    .b(1'b1),
    .f(lddata0mux_out)
);

/*
 * Load data 1 mux
 */
mux2 #(.width(1)) lddata1_mux
(
    .sel(data1mux_sel),
    .a(ld_arrays_1),
    .b(1'b1),
    .f(lddata1mux_out)
);

/*
 * Load data 2 mux
 */
mux2 #(.width(1)) lddata2_mux
(
    .sel(data2mux_sel),
    .a(ld_arrays_2),
    .b(1'b1),
    .f(lddata2mux_out)
);

/*
 * Load data 3 mux
 */
mux2 #(.width(1)) lddata3_mux
(
    .sel(data3mux_sel),
    .a(ld_arrays_3),
    .b(1'b1),
    .f(lddata3mux_out)
);

/*
 * Pmem wdata mux
 */
mux4 #(.width(256)) write_data_mux
(
    .sel(lru_out),
    .a(data0_out),
    .b(data1_out),
    .c(data2_out),
    .d(data3_out),
    .f(pmem_wdata)
);

/*
 * Read way mux
 */
mux4 #(.width(256)) read_way_data_mux
(
    .sel(curr_way),
    .a(data0_out),
    .b(data1_out),
    .c(data2_out),
    .d(data3_out),
    .f(data_out)
);

/*
 * Mem rdata mux
 */
mux2 #(.width(128)) read_data_mux
(
    .sel(offset[4]),
    .a(data_out[127:0]),
    .b(data_out[255:128]),
    .f(mem_rdata)
);


/*
 * Pmem tag mux
 */
mux4 #(.width(7)) pmemtag_mux
(
    .sel(lru_out),
    .a(tag0_out),
    .b(tag1_out),
    .c(tag2_out),
    .d(tag3_out),
    .f(pmem_tag)
);

endmodule : l2_cache_datapath
