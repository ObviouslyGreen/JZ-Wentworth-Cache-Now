/*
 * NZP comparator to set branch enable
 */
module nzp_comparator
(
    input [2:0] nzp, ir_nzp,
    input enable,
    output logic branch_enable
);


logic [2:0] result;

always_comb
begin
    result = nzp & ir_nzp | ((nzp == 3'b000) & (ir_nzp == 3'b111));
    if (result && enable)
        branch_enable = 1'b1;
    else
        branch_enable = 1'b0;
end

endmodule : nzp_comparator
