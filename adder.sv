/*
 * N-bit adder
 * No carry out
 */
module adder #(parameter width = 16)
(
    input [width-1:0] a, b,
    output logic [width-1:0] out
);


always_comb
begin
    out = a + b;
end

endmodule : adder