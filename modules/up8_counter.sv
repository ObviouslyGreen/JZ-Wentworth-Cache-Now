/*
 * Up counter
 */
module up8_counter
(
    input clk,
    input enable,
    output logic [2:0] count
);

initial
begin
    count = 0;
end

always_ff @(negedge clk)
begin
    if (count == 3'b111)
        count = 0;
    else if (enable)
        count++;
end

endmodule : up8_counter
