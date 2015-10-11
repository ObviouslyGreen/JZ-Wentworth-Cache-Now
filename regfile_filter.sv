import lc3b_types::*;

/*
 * Module to determine which byte of data to load to regfile
 */
module regfile_filter
(
    input filter_enable,
    input high_byte_enable,
    input lc3b_word in,
    output lc3b_word out
);


always_comb
begin
    if (filter_enable)
        out = (high_byte_enable) ? $unsigned({in[15:8]}) : $unsigned({in[7:0]});
    else
        out = in;
end

endmodule : regfile_filter