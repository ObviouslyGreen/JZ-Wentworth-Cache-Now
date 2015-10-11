import lc3b_types::*;

/*
 * Determine NZP based on input
 */
module gencc
(
    input lc3b_word in,
    output lc3b_nzp out
);


always_comb
begin

    if (in[15] == 1'b1)
        out = 3'b100;
    else if (|in)
        out = 3'b001;
    else
        out = 3'b010;

end

endmodule : gencc
