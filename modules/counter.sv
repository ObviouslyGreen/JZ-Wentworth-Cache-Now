/*
 * Up counter
 */
module up_counter
(
    input clk,
    input enable,
    output logic [1:0] count
);

logic last_enable;

initial
begin
    count = 0;
    last_enable = 0;
end

always_ff @(negedge clk)
begin
    if (count == 2'b10)
        count = 0;
    else if (enable)
        count++;
    last_enable <= enable;
end

endmodule : up_counter
