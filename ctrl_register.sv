/*
 * Register module (provided)
 */
import lc3b_types::*;

module ctrl_register 
(
    input clk,
    input load,
    input lc3b_control_word in,
    output lc3b_control_word out
);

lc3b_control_word data;

/* Altera device registers are 0 at power on. Specify this
 * so that Modelsim works as expected.
 */
initial
begin
    data = 1'b0;
end

always_ff @(posedge clk)
begin
    if (load)
    begin
        data = in;
    end
end

always_comb
begin
    out = data;
end

endmodule : register
