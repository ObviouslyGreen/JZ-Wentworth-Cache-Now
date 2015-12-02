import lc3b_types::*;

/*
 * N-bit 8-length array
 */
module victim_array #(parameter width = 256)
(
    input clk,
    input load,
    input lc3b_c_vic_index index,
    input [width-1:0] in,
    output logic [width-1:0] out
);


logic [width-1:0] data [7:0] /* synthesis ramstyle = "logic" */;

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
    if (load == 1)
    begin
        data[index] = in;
    end
end
assign out = data[index];

endmodule : victim_array
