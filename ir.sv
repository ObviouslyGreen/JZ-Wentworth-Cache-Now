import lc3b_types::*;

/*
 * Instruction register that outputs useful signals for the CPU
 * (provided but modified)
 */
module ir
(
    input clk,
    input load,
    input lc3b_word in,
    output lc3b_opcode opcode,
    output lc3b_reg dest, src1, src2,
    output lc3b_offset4 offset4,
    output lc3b_offset5 offset5,
    output lc3b_offset6 offset6,
    output lc3b_byte trapvect8,
    output lc3b_offset9 offset9,
    output lc3b_offset11 offset11,
    output logic d_enable,
    output logic imm_enable,
    output logic jsr_enable,
    output lc3b_word out
);


lc3b_word data;

always_ff @(posedge clk)
begin
    if (load == 1)
    begin
        data = in;
    end
end

always_comb
begin
    opcode = lc3b_opcode'(data[15:12]);

    dest = data[11:9];
    src1 = data[8:6];
    src2 = data[2:0];

    offset4   = data[3:0];
    offset5   = data[4:0];
    offset6   = data[5:0];
    trapvect8 = data[7:0];
    offset9   = data[8:0];
    offset11  = data[10:0];

    d_enable   = data[4];
    imm_enable = data[5];
    jsr_enable = data[11];
    out = data;
end

endmodule : ir
