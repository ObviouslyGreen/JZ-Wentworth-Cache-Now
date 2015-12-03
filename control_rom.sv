import lc3b_types::*;
module control_rom
(
    input lc3b_opcode opcode,
    input lc3b_lc3x lc3x_check,
    input imm_enable,
    input jsr_enable,
    input d_enable,
    input stb_high_enable,
    input is_nop,
    input flush_enable,
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
    ctrl.indirect_enable = 1'b0;
    ctrl.mem_byte_enable = 2'b11;
    ctrl.is_nop = is_nop;
    ctrl.imm_enable = 1'b0;

    if (~flush_enable)
    begin
        /* Assign control signals based on opcode */
        case(opcode)
            op_add:
            begin
                if (lc3x_check == 2'b00)            //addition
                begin
                    ctrl.aluop = alu_add;
                    if (imm_enable == 1'b1)
                    begin
                        /* DR <= A & SEXT(IR[4:0]) */
                        ctrl.alumux_sel = 2'b10;
                        ctrl.imm_enable = 1'b1;
                    end
                end
                /*LC-3X instructions do not need immediate*/
                else if (lc3x_check == 2'b01)       //division
                begin
                    ctrl.aluop = alu_div;
                end
                
                else if (lc3x_check == 2'b10)       //multiplication
                begin
                    ctrl.aluop = alu_mult;
                end
                
                else if (lc3x_check == 2'b11)       //subtraction
                begin
                    ctrl.aluop = alu_sub;
                end
                ctrl.load_regfile = 1'b1;
                ctrl.load_cc = 1'b1;        
            end

            op_and:
            begin
                if (lc3x_check == 2'b00)            //AND
                    ctrl.aluop = alu_and;
                    if (imm_enable == 1'b1)
                    begin
                        /* DR <= A & SEXT(IR[4:0]) */
                        ctrl.alumux_sel = 2'b10;
                        ctrl.imm_enable = 1'b1;
                    end
                end
                else if (lc3x_check == 2'b01)       //OR
                begin
                    ctrl.aluop = alu_or;
                end

                else if (lc3x_check == 2'b10)       //XOR
                begin
                    ctrl.aluop = alu_xor;
                end
                ctrl.load_regfile = 1'b1;
                ctrl.load_cc = 1'b1;
               
            end

            op_not:
            begin
                ctrl.aluop = alu_not;
                ctrl.load_regfile = 1'b1;
                ctrl.load_cc = 1'b1;
            end

            op_ldr:
            begin
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

            op_str:
            begin
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

            op_br:
            begin
                if (is_nop == 1'b0)
                begin
                    ctrl.brmux_sel = 1'b1;
                    ctrl.load_pc = 1'b1;
                end
            end
            op_jsr:

            begin
                /* R7 <= PC+ */
                ctrl.destmux_sel = 1;
                ctrl.regfilemux_sel = 2'b11;
                ctrl.load_regfile = 1'b1;

                /* PC <= PC + (SEXT(IR[10:0]) << 1) */
                if(jsr_enable)
                begin
                    ctrl.offsetaddermux_sel = 1'b1;
                    ctrl.pcmux_sel = 2'b01;
                end
                else
                begin
                    ctrl.storemux_sel = 0;
                    ctrl.pcmux_sel = 2'b10;
                end
                ctrl.load_pc = 1'b1;
            end

            op_jmp:
            begin
                ctrl.pcmux_sel = 2'b10;
                ctrl.load_pc = 1'b1;
            end

            op_ldb:
            begin
                /* calc_addr */
                ctrl.aluop = alu_add;
                ctrl.alumux_sel = 2'b01;
                ctrl.load_mar = 1'b1;

                /* MDR <= M[MAR] */
                ctrl.mdrmux_sel = 1'b1;
                ctrl.load_mdr = 1'b1;
                ctrl.mem_read = 1'b1;
                ctrl.offset6mux_sel = 1'b1;

                /* DR <= ZEXT(MDR[7:0]) */
                ctrl.regfilemux_sel = 2'b01;
                ctrl.regfile_filter_enable = 1'b1;
                ctrl.load_regfile = 1'b1;
                ctrl.load_cc = 1'b1;
            end

            op_stb:
            begin
                /* calc_addr */
                ctrl.aluop = alu_add;
                ctrl.alumux_sel = 2'b01;
                ctrl.load_mar = 1'b1;

                /* MDR <= SR */
                ctrl.storemux_sel = 1'b1;
                ctrl.stb_filter_enable = 1'b1;
                ctrl.load_mdr = 1'b1;
                ctrl.offset6mux_sel = 1'b1;

                /* M[MAR] <= MDR */
                ctrl.mem_byte_enable = (stb_high_enable) ? 2'b10 : 2'b01;
                ctrl.mem_write = 1'b1;
            end

            op_ldi:
            begin
                ctrl.indirect_enable = 1'b1;

                /* calc_addr */
                ctrl.aluop = alu_add;
                ctrl.alumux_sel = 2'b01;
                ctrl.load_mar = 1'b1;

                /* MAR <= MDR <= M[MAR] */
                ctrl.mdrmux_sel = 1'b1;
                ctrl.load_mdr = 1'b1;
                ctrl.mem_read = 1'b1;

                /* DR <= MDR */
                ctrl.regfilemux_sel = 2'b01;
                ctrl.load_cc = 1'b1;
                ctrl.load_regfile = 1'b1;
            end

            op_sti:
            begin
                ctrl.indirect_enable = 1'b1;

                /* calc_addr */
                ctrl.aluop = alu_add;
                ctrl.alumux_sel = 2'b01;
                ctrl.load_mar = 1'b1;

                /* MAR <= MDR <= M[MAR] */
                ctrl.mdrmux_sel = 1'b1;
                ctrl.load_mdr = 1'b1;
                ctrl.mem_read = 1'b1;

                /* MDR <= SR */
                ctrl.storemux_sel = 1'b1;

                /* M[MAR] <= MDR */
            end

            op_lea:
            begin
                /* DR <= PC + (SEXT(IR[8:0]) << 1) */
                ctrl.regfilemux_sel = 2'b10;
                ctrl.load_regfile = 1'b1;
                ctrl.load_cc = 1'b1;
            end

            op_shf:
            begin
                ctrl.alumux_sel = 2'b11;

                if (d_enable == 0)
                begin
                    /* DR <= SR << IR[3:0] */
                    ctrl.aluop = alu_sll;
                end
                else
                begin
                    if (imm_enable == 0)
                    begin
                        /* DR <= SR >> IR[3:0], 0 */
                        ctrl.aluop = alu_srl;
                        ctrl.imm_enable = 1'b1;
                    end
                    else
                    begin
                        /* DR <= SR >> IR[3:0], SR[15] */
                        ctrl.aluop = alu_sra;
                        ctrl.imm_enable = 1'b1;
                    end
                end

                ctrl.load_cc = 1'b1;
                ctrl.load_regfile = 1'b1;
            end

            op_trap:
            begin
                /* R7 <= PC+ */
                ctrl.destmux_sel = 1'b1;
                ctrl.regfilemux_sel = 2'b11;
                ctrl.load_regfile = 1'b1;

                /* MAR <= ZEXT(trapvect8 << 1) */
                ctrl.marmux_sel = 2'b11;
                ctrl.load_mar = 1'b1;

                /* MDR <= M[MAR] */
                ctrl.mdrmux_sel = 1'b1;
                ctrl.load_mdr = 1'b1;
                ctrl.mem_read = 1'b1;

                /* PC <= MDR */
                ctrl.pcmux_sel = 2'b11;
                ctrl.load_pc = 1'b1;
            end

            default:
            begin
                ctrl = 0; /* Unknown opcode, set control word to zero */
            end
        endcase
    end
    else
    begin
        ctrl = 0;
        ctrl.is_nop = 1'b1;
    end
end
endmodule : control_rom
