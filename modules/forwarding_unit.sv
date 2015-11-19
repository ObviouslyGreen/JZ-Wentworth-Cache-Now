/*
 * Data forwarding unit
 */
import lc3b_types::*;

module forwarding_unit
(
    input lc3b_opcode exec_opcode,
    input lc3b_opcode mem_opcode, 
    input lc3b_reg sr1,
    input lc3b_reg sr2,
    input lc3b_reg write_reg2,
    input lc3b_reg write_reg3,
    output logic [1:0] sel_a,
    output logic [1:0] sel_b
);

always_comb
begin
end

endmodule : forwarding_unit
