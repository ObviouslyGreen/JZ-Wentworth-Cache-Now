/*
 * Prediction generator
 */
module gen_prediction
(
    input [1:0] branch_count,
    input enable,
    output logic branch_predict
);

always_comb
begin
    if (enable && (branch_count == 2'b10 || branch_count == 2'b11))
        branch_predict = 1'b1;
    else
        branch_predict = 1'b0;
end

endmodule : gen_prediction
