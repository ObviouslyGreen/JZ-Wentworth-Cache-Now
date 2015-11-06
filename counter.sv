/*
 * N-bit up counter
 */
module up_counter #(parameter width = 2)
(
    input clk,
    input enable,
    input reset,
    output logic [width-1:0] count
);

initial
begin
    count = 0;
end

always_ff @(posedge clk)
begin
    if (count == 2'b10)
        count = 0;
    else if (enable)
        count++;
end

endmodule : up_counter
