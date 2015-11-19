/*
 * Data forwarding unit
 */
import lc3b_types::*;

module forwarding_unit
(
    input lc3b_reg SR1_index_reg_out,
    input lc3b_reg SR2_index_reg_out,
    input lc3b_reg writeReg2_out,
    input lc3b_reg writeReg3_out,
    output logic [1:0] forwarding_unit_sel
);

always_comb
begin
    // TODO
end

endmodule : forwarding_unit
