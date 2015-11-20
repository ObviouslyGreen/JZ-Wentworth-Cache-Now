import lc3b_types::*;

module lru_stack
(
    input clk,
    input write,
	 input [1:0] in,
    output logic [1:0] out
);

logic [1:0] data [3:0];
logic [1:0] temp [3:0];

/* Initialize array */
initial
begin
    data[0] = 2'b11;
	data[1] = 2'b10;
	data[2] = 2'b01;
	data[3] = 2'b00;
end

always_comb
begin
    if (in == data[0])
    begin
        temp[0] = data[1];
		temp[1] = data[2];
		temp[2] = data[3];
		temp[3] = data[0];
    end
	 
	 else if (in == data[1])
    begin
        temp[0] = data[0];
		temp[1] = data[2];
		temp[2] = data[3];
		temp[3] = data[1];
    end
	 
	 else if (in == data[2])
    begin
        temp[0] = data[0];
		temp[1] = data[1];
		temp[2] = data[3];
		temp[3] = data[2];
    end
	 
	 else
    begin
        temp[0] = data[0];
		temp[1] = data[1];
		temp[2] = data[2];
		temp[3] = data[3];
    end
end

always_ff @(posedge clk)
begin
    if (write == 1)
    begin
        data[0] <= temp[0];
		data[1] <= temp[1];
		data[2] <= temp[2];
		data[3] <= temp[3];
    end
end

assign out = data[0];

endmodule : lru_stack