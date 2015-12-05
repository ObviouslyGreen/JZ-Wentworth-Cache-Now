/*
 * Branch history table
 */
import lc3b_types::*;

module branch_history
(
    input clk,
    input load,
    input lc3b_offset9 index,
    input branch_enable,
    output lc3b_word out
);

// Data is 2^9 entries of the last 16 branches for PC values
logic [15:0] data [8:0] /* synthesis ramstyle = "logic" */;

/* Initialize array */
initial
begin
    for (int i = 0; i < $size(data); i++)
    begin
        data[i] = 16'b0;
    end
end

always_ff @(posedge clk)
begin
    if (load == 1)
    begin
        data[index] = data[index] << 1 | branch_enable;
    end
end
assign out = data[index];

endmodule : branch_history
