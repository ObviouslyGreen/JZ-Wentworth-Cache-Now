import lc3b_types::*;

module branch_predictors
(
    input clk,
    input load,
    input branch_enable,
    input lc3b_word index,
    output logic [1:0] branch_count
);

// Data is 2^16 entries of 2 bit counters
logic [1:0] data [15:0] /* synthesis ramstyle = "logic" */;
assign branch_count = data[index];

/* Initialize array */
initial
begin
    for (int i = 0; i < $size(data); i++)
    begin
        // Intialize everything to weakly taken
        data[i] = 2'b10;
    end
end

always_ff @(posedge clk)
begin
    if (load == 1)
    begin
        case (branch_count)
            2'b00:
            begin
                if (branch_enable)
                    data[index] = 2'b01;
            end
            2'b01:
            begin
                if (branch_enable)
                    data[index] = 2'b10;
                else
                    data[index] = 2'b00;
            end
            2'b10:
            begin
                if (branch_enable)
                    data[index] = 2'b11;
                else
                    data[index] = 2'b01;
            end
            2'b11:
            begin
                if (~branch_enable)
                    data[index] = 2'b10;
            end
        endcase
    end
end

endmodule : branch_predictors
