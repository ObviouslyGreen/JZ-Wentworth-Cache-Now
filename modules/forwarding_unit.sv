/*
 * Data forwarding unit
 */
import lc3b_types::*;

module forwarding_unit
(
    input mem_reg_write,
    input wb_reg_write,
    input lc3b_reg sr1,
    input lc3b_reg sr2,
    input lc3b_reg write_reg2,
    input lc3b_reg write_reg3,
    output logic [1:0] sel_a,
    output logic [1:0] sel_b
);

always_comb
begin
    sel_a = 2'b00;
    sel_b = 2'b00;
    if (mem_reg_write)
    begin
        if (write_reg2 == sr1)
            sel_a = 2'b01;
        if (write_reg2 == sr2)
            sel_b = 2'b01;
    end
    if (wb_reg_write)
    begin
        if (sr1 != write_reg2 && write_reg3 == sr1)
            sel_a = 2'b10;
        if (sr2 != write_reg2 && write_reg3 == sr2)
            sel_b = 2'b10;
    end

endmodule : forwarding_unit
