import lc3b_types::*;
module control_rom
(
    input lc3b_opcode opcode,
    input imm_enable,
    input is_nop,
    output lc3b_control_word ctrl
);

always_comb
begin
    /* Default assignments */
    ctrl.opcode = opcode;
    ctrl.load_pc = 1'b0;
    ctrl.load_ir = 1'b0;
    ctrl.load_regfile = 1'b0;
    ctrl.load_mar = 1'b0;
    ctrl.load_mdr = 1'b0;
    ctrl.load_cc = 1'b0;
    ctrl.regfile_filter_enable = 1'b0;
    ctrl.stb_filter_enable = 1'b0;
    ctrl.pcmux_sel = 2'b00;
    ctrl.brmux_sel = 1'b0;
    ctrl.storemux_sel = 1'b0;
    ctrl.destmux_sel = 1'b0;
    ctrl.alumux_sel = 2'b00;
    ctrl.regfilemux_sel = 2'b00;
    ctrl.marmux_sel = 2'b00;
    ctrl.mdrmux_sel = 1'b0;
    ctrl.offsetaddermux_sel = 1'b0;
    ctrl.offset6mux_sel = 1'b0;
    ctrl.aluop = alu_add;
    ctrl.mem_read = 1'b0;
    ctrl.mem_write = 1'b0;
    ctrl.mem_byte_enable = 2'b11;

    /* Assign control signals based on opcode */
    case(opcode)
        op_add: begin
            ctrl.aluop = alu_add;
            ctrl.load_regfile = 1'b1;
            ctrl.load_cc = 1'b1;
            if (imm_enable == 1'b1)
            begin
                /* DR <= A & SEXT(IR[4:0]) */
                ctrl.alumux_sel = 2'b11;
            end
        end
        op_and: begin
            ctrl.aluop = alu_and;
            ctrl.load_regfile = 1'b1;
            ctrl.load_cc = 1'b1;
            if (imm_enable == 1'b1)
            begin
                /* DR <= A & SEXT(IR[4:0]) */
                ctrl.alumux_sel = 2'b11;
            end
        end
        op_not: begin
            ctrl.aluop = alu_not;
            ctrl.load_regfile = 1'b1;
            ctrl.load_cc = 1'b1;
        end
        op_ldr: begin
            /* calc_addr */
            ctrl.aluop = alu_add;
            ctrl.alumux_sel = 2'b01;
            ctrl.load_mar = 1'b1;

            /* MDR <= M[MAR] */
            ctrl.mdrmux_sel = 1'b1;
            ctrl.load_mdr = 1'b1;
            ctrl.mem_read = 1'b1;

            /* DR <= MDR */
            ctrl.regfilemux_sel = 2'b01;
            ctrl.load_regfile = 1'b1;
            ctrl.load_cc = 1'b1;
        end
        op_str: begin
            /* calc_addr */
            ctrl.aluop = alu_add;
            ctrl.alumux_sel = 2'b01;
            ctrl.load_mar = 1'b1;

            /* MDR <= SR */
            // PASS SR TO MDR SOMEHOW
            ctrl.storemux_sel = 1'b1;
            ctrl.load_mdr = 1'b1;

            /* M[MAR] <= MDR */
            ctrl.mem_write = 1'b1;
        end
        op_br: begin
            if (is_nop == 1'b0)
            begin
                ctrl.brmux_sel = 1'b1;
                ctrl.load_pc = 1'b1;
            end
        end
        /* ... other opcodes ... */
        default: begin
            ctrl = 0; /* Unknown opcode, set control word to zero */
        end
    endcase
end
endmodule : control_rom