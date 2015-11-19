/*
 * Hazard detection unit
 */
import lc3b_types::*;

module hazard_detector
(
    input clk,
    input mem_read,
    input lc3b_opcode opcode,
    output logic bubble_enable
);

always_ff @(posedge clk)
begin
    if (mem_read || (opcode == op_br) || (opcode == op_jmp) || (opcode == op_jsr))
        bubble_enable <= 1'b1;
    else
        bubble_enable <= 1'b0;
end

endmodule : hazard_detector
