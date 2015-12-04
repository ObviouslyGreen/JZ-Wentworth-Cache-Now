import lc3b_types::*;

module branch_history
(
    input clk,
    input load,
    input lc3b_offset5 index,
    input lc3b_word in,
    output lc3b_word out
);

// Data is 2^5 entries of branch pc values
logic [15:0] data [4:0] /* synthesis ramstyle = "logic" */;

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
        data[index] = in;
    end
end
assign out = data[index];

endmodule : branch_history
