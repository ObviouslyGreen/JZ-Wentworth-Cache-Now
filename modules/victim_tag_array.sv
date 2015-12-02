import lc3b_types::*;

module victim_tag_array 
(
    input clk,
    input load,
    input lc3b_c_vic_index index,
    input lc3b_c_vic_tag in,
    output lc3b_c_vic_tag out,
	output lc3b_c_vic_tag data0,
	output lc3b_c_vic_tag data1,
	output lc3b_c_vic_tag data2,
	output lc3b_c_vic_tag data3
);

logic [11:0] data [3:0];

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
    if (write == 1)
    begin
        data[index] = datain;
    end
end

assign dataout = data[index];
assign data0 = data[0];
assign data1 = data[1];
assign data2 = data[2];
assign data3 = data[3];


endmodule : victim_tag_array