import lc3b_types::*;

/*
 * Datapath for cache
 */
module d_cache_datapath
(
    input clk,

    /* Control signals */
    input ld_cache,
    input ld_dirty0,
    input ld_dirty1,
    input ld_lru,
    input writecachemux_sel,
    input data0mux_sel,
    input data1mux_sel,
    input ld_from_vic,
    input dirty0_in,
    input dirty1_in,
    input dirty_in,
    output logic hit,
    output logic curr_way,
    output logic lru_out,
    output logic valid0_out,
    output logic valid1_out,
    output logic dirty_out,
    output logic dirty0_out,
    output logic dirty1_out,
    output lc3b_c_tag pmem_tag,

    /* Memory signals */
    input lc3b_word mem_address,
    input lc3b_word mem_wdata,
    input lc3b_mem_data pmem_rdata,
    input lc3b_mem_wmask mem_byte_enable,
    output lc3b_word mem_rdata,
    output lc3b_mem_data pmem_wdata
);


/* declare internal signals */
lc3b_c_index index;
lc3b_c_offset offset;
lc3b_c_tag tag;
lc3b_mem_data curr_datablock;
lc3b_mem_data datamembytefilter_out;
lc3b_mem_data data0_out;
lc3b_mem_data data1_out;
lc3b_c_tag tag0_out;
lc3b_c_tag tag1_out;
logic comparator0_out;
logic comparator1_out;
logic dirtymux_out;
logic lddata0mux_out;
logic lddata1mux_out;
lc3b_mem_data writecachemux_out;
logic lru_in;
logic ld_arrays_0;
logic ld_arrays_1;
logic ld_data0_wh;
logic ld_data1_wh;
logic tag_valid_0;
logic tag_valid_1;

/* assign internal logic */
assign ld_arrays_0 = ~lru_out & ld_cache;
assign ld_arrays_1 = lru_out & ld_cache;
assign tag_valid_0 = comparator0_out & valid0_out;
assign tag_valid_1 = comparator1_out & valid1_out;
assign lru_in      = ~(~tag_valid_0 & tag_valid_1);
assign hit         = tag_valid_0 | tag_valid_1;
assign offset      = mem_address[3:0];
assign index       = mem_address[6:4];
assign tag         = mem_address[15:7];
assign curr_way    = ~lru_in;

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
 * Data byte select mux
 */
byte_select_mux2 byte_select_mux_module
(
    .sel0(comparator0_out),
    .sel1(comparator1_out),
    .offset(offset),
    .a(data0_out),
    .b(data1_out),
    .f(mem_rdata),
    .selected_data(curr_datablock)
);

/*
 * Data membyte filter
 */
data_membyte_filter data_membyte_filter_module
(
    .mem_byte_enable(mem_byte_enable),
    .mem_wdata(mem_wdata),
    .datablock(curr_datablock),
    .offset(offset),
    .out(datamembytefilter_out)
);


/**************************************
 * Arrays                             *
 **************************************/

/*
 * Data 0
 */
array data0
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
array data1
(
    .clk(clk),
    .load(lddata1mux_out),
    .index(index),
    .in(writecachemux_out),
    .out(data1_out)
);

/*
 * Tag 0
 */
array #(.width(9)) tag0
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
array #(.width(9)) tag1
(
    .clk(clk),
    .load(ld_arrays_1),
    .index(index),
    .in(tag),
    .out(tag1_out)
);

/*
 * Valid 0
 */
array #(.width(1)) valid0
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
array #(.width(1)) valid1
(
    .clk(clk),
    .load(ld_arrays_1),
    .index(index),
    .in(1'b1),
    .out(valid1_out)
);

logic dirty0mux_out;
logic dirty1mux_out;
logic lru_reg_out;
/*
 * Dirty 0
 */
array #(.width(1)) dirty0
(
    .clk(clk),
    .load(ld_dirty0 || (ld_from_vic && ld_arrays_0)),
    .index(index),
    .in(dirty0mux_out),
    .out(dirty0_out)
);

/*
 * Dirty 1
 */
array #(.width(1)) dirty1
(
    .clk(clk),
    .load(ld_dirty1 || (ld_from_vic && ld_arrays_1)),
    .index(index),
    .in(dirty1mux_out),
    .out(dirty1_out)
);

/*
 * LRU
 */
array #(.width(1)) lru
(
    .clk(clk),
    .load(ld_lru),
    .index(index),
    .in(lru_in),
    .out(lru_out)
);

register #(.width(1)) lru_reg
(
    .clk(clk),
    .load(ld_cache),
    .in(lru_out),
    .out(lru_reg_out)
);
/**************************************
 * Multiplexers                       *
 **************************************/

/*
 * Write cache mux
 */
mux2 #(.width(128)) writecache_mux
(
    .sel(writecachemux_sel),
    .a(pmem_rdata),
    .b(datamembytefilter_out),
    .f(writecachemux_out)
);

/*
 * Write mem mux
 */
mux2 #(.width(128)) writemem_mux
(
    .sel(lru_out),
    .a(data0_out),
    .b(data1_out),
    .f(pmem_wdata)
);

/*
 * Write dirty0 mux
 */
mux2 #(.width(1)) writedirty0_mux
(
    .sel(ld_from_vic),
    .a(dirty0_in),
    .b(dirty_in),
    .f(dirty0mux_out)
);

/*
 * Write dirty1 mux
 */
mux2 #(.width(1)) writedirty1_mux
(
    .sel(ld_from_vic),
    .a(dirty1_in),
    .b(dirty_in),
    .f(dirty1mux_out)
);

/*
 * dirty in for victim cache mux
 */
mux2 #(.width(1)) dirtyout_mux
(
    .sel(lru_reg_out),
    .a(dirty0_out),
    .b(dirty1_out),
    .f(dirty_out)
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
 * Pmem tag mux
 */
mux2 #(.width(9)) pmemtag_mux
(
    .sel(lru_out),
    .a(tag0_out),
    .b(tag1_out),
    .f(pmem_tag)
);

endmodule : d_cache_datapath
