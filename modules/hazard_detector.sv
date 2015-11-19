/*
 * Hazard detection unit
 */
import lc3b_types::*;

module hazard_detector
(
    input mem_read,
    input is_nop,
    input lc3b_reg sr1,
    input lc3b_reg sr2,
    input lc3b_reg write_reg1,
    input lc3b_opcode opcode,
    output logic bubble_enable
);

logic is_data_hazard;

assign is_data_hazard = mem_read 
                    && (write_reg1 == sr1 
                        || write_reg1 == sr2);

always_comb
begin
    bubble_enable = 1'b0;

    if (is_data_hazard)
        bubble_enable = 1'b1;
    else
        bubble_enable = 1'b0;
end

endmodule : hazard_detector
