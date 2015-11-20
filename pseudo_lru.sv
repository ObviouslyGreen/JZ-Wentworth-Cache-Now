import lc3b_types::*;

module pseudo_lru
(
    input clk,
    input write,
	input lc3b_c_l2_index index,
	input [1:0] in,
    output logic [1:0] out
);

logic [2:0] data [15:0] /* synthesis ramstyle = "logic" */;

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
    	if (in == 2'b00)
    		data[index][2:1] = 2'b00;
    	else if (in == 2'b01)
    		data[index][2:1] = 2'b01;
    	else if (in == 2'b10)
    	begin
    		data[index][2] = 1;
    		data[index][0] = 0;
    	end
    	else if (in == 2'b11)
    	begin
    		data[index][2] = 1;
    		data[index][0] = 1;
    	end
    end
end

always_comb
begin
	if (data[index][2])
	begin
		if (data[index][1])
			out = 2'b00;
		else
			out = 2'b01;
	end
	else
	begin
		if (data[index][0])
			out = 2'b10;
		else
			out = 2'b11;
	end
end

endmodule : pseudo_lru