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

logic [1:0] counter;

always_ff @(posedge clk)
begin
    if (mem_read || (opcode == op_br) || (opcode == op_jmp) || (opcode == op_jsr))
    begin
        bubble_enable <= 1'b1;
        counter <= 2'b00;
    end
    else
    begin
        if ((counter != 2'b11) && ((opcode == op_br) || (opcode == op_jmp) || (opcode == op_jsr)))
        begin
            counter += 1;
        end
        else if ((mem_read == 1'b0) || ((counter == 2'b11) && ((opcode == op_br) || (opcode == op_jmp) || (opcode == op_jsr))))
        begin
            bubble_enable <= 1'b0;
            counter <= 2'b00;
        end
    end
end

endmodule : hazard_detector
