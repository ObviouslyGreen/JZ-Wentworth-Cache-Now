module gen_prediction
(
    input [1:0] branch_count,
    output logic branch_predict
);

always_comb
begin
    if (branch_count == 2'b00 || branch_count == 2'b01)
        branch_predict = 1'b0;
    else
        branch_predict = 1'b1;
end

endmodule : gen_prediction
