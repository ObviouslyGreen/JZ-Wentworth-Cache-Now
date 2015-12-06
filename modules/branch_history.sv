/*
 * Branch history table
 */
import lc3b_types::*;

module branch_history
(
    input clk,
    input branch_enable,
    input lc3b_p_index index,
    input lc3b_p_index br_index,
    output lc3b_p_index out,
    output lc3b_p_index br_out
);

// Data is 32 entries of the last 5 branches for PC values
logic [4:0] data [31:0] /* synthesis ramstyle = "logic" */;

/* Initialize array */
initial
begin
    for (int i = 0; i < $size(data); i++)
    begin
        data[i] = 1'b0;
    end
end

always_ff @(posedge clk)
begin
    if (branch_enable)
    begin
        data[br_index] = (data[br_index] << 1) | branch_enable;
    end
end
assign out = data[index];
assign br_out = data[br_index];

endmodule : branch_history
