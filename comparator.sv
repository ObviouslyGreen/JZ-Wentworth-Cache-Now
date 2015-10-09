module comparator #(parameter width = 9)
(
    input clk,
    input [width-1:0] a, b,
    output logic out
);

assign out = a == b;

endmodule : comparator
