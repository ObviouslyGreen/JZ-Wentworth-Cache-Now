import lc3b_types::*;

module stb_filter
(
    input filter_enable,
    input high_byte_enable,
    input lc3b_word in,
    output lc3b_word out
);

always_comb
begin
    if (filter_enable)
        out = (high_byte_enable) ? {in[7:0], 8'h00} : $unsigned({in});
    else
        out = in;
end

endmodule : stb_filter