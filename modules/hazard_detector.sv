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
    input lc3b_reg write_reg1,
    input lc3b_opcode opcode,
    output lc3b_word bubble_count,
    output logic bubble_enable
);

logic is_data_hazard;

assign is_data_hazard = mem_read 
                    && (write_reg1 == sr1 
                        || write_reg1 == sr2)
                    && opcode != op_jmp
                    && opcode != op_jsr
                    && opcode != op_trap;
initial
begin
    bubble_count = 16'b0;
end

always_comb
begin
    bubble_enable = 1'b0;

    if (is_data_hazard)
        bubble_enable = 1'b1;
    else
        bubble_enable = 1'b0;
end

always @ (posedge clk)
begin
    if(is_data_hazard)
        bubble_count++;
end

endmodule : hazard_detector
