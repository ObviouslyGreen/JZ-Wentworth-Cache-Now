/*
 * Hazard detection unit
 */
import lc3b_types::*;

module hazard_detector
(
    input clk,
    input mem_read,
    input is_nop,
    input lc3b_reg sr1,
    input lc3b_reg sr2,
    input lc3b_reg write_reg2,
    input lc3b_reg write_reg3,
    input lc3b_opcode opcode,
    output logic bubble_enable
);

assign is_data_hazard = mem_read 
                    && (write_reg2 == sr1 
                        || write_reg2 == sr2
                        || write_reg3 == sr1
                        || write_reg3 == sr2);

always_ff @(posedge clk)
begin
    bubble_enable = 1'b0;

    if (is_data_hazard 
        || (opcode == op_br && ~is_nop)
        || opcode == op_jmp 
        || opcode == op_jsr)
        bubble_enable = 1'b1;
    else
        bubble_enable = 1'b0;
end

endmodule : hazard_detector
