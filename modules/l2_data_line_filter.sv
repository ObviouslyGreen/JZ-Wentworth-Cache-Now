import lc3b_types::*;

/*
 * Module to determine which byte/word to write during a cache hit
 */
module l2_data_line_filter
(
    input offset,
    input lc3b_mem_data mem_wdata,
    input lc3b_pmem_data datablock,
    output lc3b_pmem_data out
);


lc3b_pmem_data data;

always_comb
begin

    data = datablock;

    if (offset)
        data[255:128] = mem_wdata;
    else
        data[127:0] = mem_wdata;

    out = data;

end

endmodule : l2_data_line_filter
