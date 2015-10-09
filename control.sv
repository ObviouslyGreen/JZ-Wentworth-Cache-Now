import lc3b_types::*; /* Import types defined in lc3b_types.sv */

module control
(
    /* Input and output port declarations */
    input clk,

    /* Datapath controls */
    input lc3b_opcode opcode,
    input branch_enable,
    input d_enable,
    input imm_enable,
    input jsr_enable,
    input stb_high_enable,
    output logic load_pc,
    output logic load_ir,
    output logic load_regfile,
    output logic load_mar,
    output logic load_mdr,
    output logic load_cc,
    output logic regfile_filter_enable,
    output logic stb_filter_enable,
    output logic [1:0] pcmux_sel,
    output logic storemux_sel,
    output logic destmux_sel,
    output logic [1:0] alumux_sel,
    output logic [1:0] regfilemux_sel,
    output logic [1:0] marmux_sel,
    output logic mdrmux_sel,
    output logic offsetaddermux_sel,
    output logic offset6mux_sel,
    output lc3b_aluop aluop,

    /* Memory signals */
    input mem_resp,
    output logic mem_read,
    output logic mem_write,
    output lc3b_mem_wmask mem_byte_enable
);

enum int unsigned {
    /* List of states */
    fetch1,
    fetch2,
    fetch3,
    decode,
    s_add,
    s_and,
    s_not,
    br,
    br_taken,
    calc_addr,
    ldr1,
    ldr2,
    ldb1,
    ldb2,
    ldb3,
    ldi1,
    ldi2,
    ldi3,
    ldi4,
    str1,
    str2,
    stb1,
    stb2, 
    stb3,
    sti1,
    sti2,
    sti3,
    sti4,
    jmp_ret,
    jmp_sub1,
    jmp_sub2,
    shf,
    lea,
    trap1,
    trap2,
    trap3, 
    trap4
} state, next_state;

always_comb
begin : state_actions
    /* Default output assignments */
    load_pc = 1'b0;
    load_ir = 1'b0;
    load_regfile = 1'b0;
    load_mar = 1'b0;
    load_mdr = 1'b0;
    load_cc = 1'b0;
    regfile_filter_enable = 1'b0;
    stb_filter_enable = 1'b0;
    pcmux_sel = 2'b00;
    storemux_sel = 0;
    destmux_sel = 0;
    alumux_sel = 2'b00;
    regfilemux_sel = 2'b00;
    marmux_sel = 2'b00;
    mdrmux_sel = 1'b0;
    offsetaddermux_sel = 1'b0;
    offset6mux_sel = 1'b0;
    aluop = alu_add;
    mem_read = 1'b0;
    mem_write = 1'b0;
    mem_byte_enable = 2'b11;

    /* Actions for each state */
    case (state)
        fetch1: begin
            /* MAR <= PC */
            marmux_sel = 2'b01;
            load_mar = 1;

            /* PC <= PC + 2 */
            pcmux_sel = 2'b00;
            load_pc = 1;
        end

        fetch2: begin
            /* Read memory */
            mem_read = 1;
            mdrmux_sel = 1;
            load_mdr = 1;
        end

        fetch3: begin
            /* Load IR */
            load_ir = 1;
        end

        decode: /* Do nothing */;

        s_add: begin
            /* DR <= SRA + SRB */
            aluop = alu_add;
            load_regfile = 1;
            load_cc = 1;
            if (imm_enable == 1) begin
                /* DR <= A + SEXT(IR[4:0]) */
                alumux_sel = 2'b10;
            end
        end

        s_and: begin
            /* DR <= A & B */
            aluop = alu_and;
            load_regfile = 1;
            load_cc = 1;
            if (imm_enable == 1) begin
                /* DR <= A & SEXT(IR[4:0]) */
                alumux_sel = 2'b11;
            end
        end

        s_not: begin
            /* DR <= NOT(A) */
            aluop = alu_not;
            load_regfile = 1;
            load_cc = 1;
        end

        br: /* Do nothing */;

        br_taken: begin
            /* PC <= PC + SEXT(IR[8:0] << 1) */
            pcmux_sel = 2'b01;
            load_pc = 1;
        end

        calc_addr: begin
            /* MAR <= A + SEXT(IR[5:0] << 1) */
            alumux_sel = 2'b01;
            aluop = alu_add;
            load_mar = 1;
        end

        ldr1: begin
            /* MDR <= M[MAR] */
            mdrmux_sel = 1;
            load_mdr = 1;
            mem_read = 1;
        end

        ldr2: begin
            /* DR <= MDR */
            regfilemux_sel = 2'b01;
            load_regfile = 1;
            load_cc = 1;
        end

        ldb1: begin
            /* MAR <= A + SEXT(IR[5:0]) */
            offset6mux_sel = 1;
            alumux_sel = 2'b01;
            aluop = alu_add;
            load_mar = 1;
        end

        ldb2: begin
            /* MDR <= M[MAR] */
            mdrmux_sel = 1;
            load_mdr = 1;
            mem_read = 1;
        end

        ldb3: begin
            /* DR <= ZEXT(MDR[7:0]) */
            regfilemux_sel = 2'b01;
            regfile_filter_enable = 1;
            load_regfile = 1;
            load_cc = 1;
        end

        ldi1: begin
            /* MDR <= M[MAR] */
            mdrmux_sel = 1;
            load_mdr = 1;
            mem_read = 1;
        end

        ldi2: begin
            /* MAR <= MDR */
            marmux_sel = 2'b10;
            load_mar = 1;
            regfilemux_sel = 2'b01;
        end

        ldi3: begin
            /* MDR <= M[MAR] */
            mdrmux_sel = 1;
            load_mdr = 1;
            mem_read = 1;
        end

        ldi4: begin
            /* DR <= MDR */
            regfilemux_sel = 2'b01;
            load_cc = 1;
            load_regfile = 1;
        end

        str1: begin
            /* MDR <= SR */
            storemux_sel = 1;
            aluop = alu_pass;
            load_mdr = 1;
        end

        str2: begin
            /* M[MAR] <= MDR */
            mem_write = 1;
        end

        stb1: begin
            /* MAR <= A + SEXT(IR[5:0]) */
            offset6mux_sel = 1;
            alumux_sel = 2'b01;
            aluop = alu_add;
            load_mar = 1;
        end

        stb2: begin
            /* MDR <= SR */
            storemux_sel = 1;
            stb_filter_enable = 1;
            aluop = alu_pass;
            load_mdr = 1;
        end

        stb3: begin
            /* M[MAR] <= MDR[15:8] | MDR[7:0] */
            mem_byte_enable = (stb_high_enable) ? 2'b10 : 2'b01;
            mem_write = 1;
        end

        sti1: begin
            /* MDR <= M[MAR] */
            mdrmux_sel = 1;
            load_mdr = 1;
            mem_read = 1;
        end

        sti2: begin
            /* MAR <= MDR */
            marmux_sel = 2'b10;
            load_mar = 1;
            regfilemux_sel = 2'b01;
        end

        sti3: begin
            /* MDR <= SR */
            storemux_sel = 1;
            aluop = alu_pass;
            load_mdr = 1;
        end

        sti4: begin
            /* M[MAR] <= MDR */
            mem_write = 1;
        end

        jmp_ret: begin
            /* PC <= A */
            pcmux_sel = 2'b10;
            load_pc = 1;
        end

        jmp_sub1: begin
            /* R7 <= PC+ */
            destmux_sel = 1;
            regfilemux_sel = 2'b11;
            load_regfile = 1'b1;
        end

        jmp_sub2: begin
            if (jsr_enable) begin
                /* PC <= PC + (SEXT(IR[10:0]) << 1) */
                offsetaddermux_sel = 1'b1;
                pcmux_sel = 2'b01;
            end else begin
                /* PC <= A */
                storemux_sel = 0;
                pcmux_sel = 2'b10;
            end
            load_pc = 1'b1;
        end

        shf: begin
            alumux_sel = 2'b11;

            if (d_enable == 0) begin
                /* DR <= SR << IR[3:0] */
                aluop = alu_sll;
            end else begin 
                if (imm_enable == 0) begin
                    /* DR <= SR >> IR[3:0], 0 */
                    aluop = alu_srl;
                end
                else begin
                    /* DR <= SR >> IR[3:0], SR[15] */
                    aluop = alu_sra;
                end
            end

            load_cc = 1;
            load_regfile = 1;
        end

        lea: begin
            /* DR <= PC + (SEXT(IR[8:0]) << 1) */
            regfilemux_sel = 2'b10;
            load_regfile = 1;
        end

        trap1: begin
            /* R7 <= PC+ */
            destmux_sel = 1;
            regfilemux_sel = 2'b11;
            load_regfile = 1;
        end

        trap2: begin
            /* MAR <= ZEXT(trapvect8 << 1) */
            marmux_sel = 2'b11;
            load_mar = 1;
        end

        trap3: begin
            /* MDR <= M[MAR] */
            mdrmux_sel = 1;
            load_mdr = 1;
            mem_read = 1;
        end

        trap4: begin
            regfilemux_sel = 2'b01;
            pcmux_sel = 2'b11;
            load_pc = 1;
        end

        default: /* Do nothing */;

    endcase
end

always_comb
begin : next_state_logic
    /* Next state information and conditions (if any)
     * for transitioning between states */

     next_state = state;
     case (state)
        fetch1: begin
            next_state = fetch2;
        end

        fetch2: begin
            if (mem_resp == 0)
                next_state = fetch2;
            else
                next_state = fetch3;
        end

        fetch3: begin
            next_state = decode;
        end

        decode: begin
            case (opcode)
                op_add:
                    next_state = s_add;

                op_and:
                    next_state = s_and;

                op_br: 
                    next_state = br;

                op_ldb: 
                    next_state = ldb1;

                op_ldi: 
                    next_state = calc_addr;

                op_ldr: 
                    next_state = calc_addr;

                op_not: 
                    next_state = s_not;

                op_str: 
                    next_state = calc_addr;

                op_stb:
                    next_state = stb1;

                op_sti:
                    next_state = calc_addr;

                op_jmp: 
                    next_state = jmp_ret;

                op_jsr: 
                    next_state = jmp_sub1;

                op_shf:
                    next_state = shf;

                op_lea:
                    next_state = lea;

                op_trap:
                    next_state = trap1;

                default: /* Do nothing */;

            endcase
        end

        s_add: begin
            next_state = fetch1;
        end

        s_and: begin
            next_state = fetch1;
        end

        s_not: begin
            next_state = fetch1;
        end

        br: begin
            if (branch_enable == 1)
                next_state = br_taken;
            else
                next_state = fetch1;
        end

        br_taken: begin
            next_state = fetch1;
        end

        calc_addr: begin
            case (opcode)
                op_ldr: begin
                    next_state = ldr1;
                end

                op_ldi: begin
                    next_state = ldi1;
                end

                op_str: begin
                    next_state = str1;
                end

                op_sti: begin
                    next_state = sti1;
                end

                default: /* Do nothing */;

            endcase
        end

        ldr1: begin
            if (mem_resp == 0)
                next_state = ldr1;
            else
                next_state = ldr2;
        end

        ldr2: begin
            next_state = fetch1;
        end

        ldb1: begin
            next_state = ldb2;
        end

        ldb2: begin
            if (mem_resp == 0)
                next_state = ldb2;
            else
                next_state = ldb3;        
        end

        ldb3: begin
            next_state = fetch1;
        end

        ldi1: begin
            if (mem_resp == 0)
                next_state = ldi1;
            else
                next_state = ldi2;
        end

        ldi2: begin
            next_state = ldi3;
        end

        ldi3: begin
            if (mem_resp == 0)
                next_state = ldi3;
            else
                next_state = ldi4;
        end

        ldi4: begin
            next_state = fetch1;
        end

        str1: begin
            next_state = str2;
        end

        str2: begin
            if (mem_resp == 0)
                next_state = str2;
            else
                next_state = fetch1;
        end

        stb1: begin
            next_state = stb2;
        end

        stb2: begin
            next_state = stb3;
        end

        stb3: begin
            if (mem_resp == 0)
                next_state = stb3;
            else
                next_state = fetch1;
        end

        sti1: begin
            if (mem_resp == 0)
                next_state = sti1;
            else
                next_state = sti2;
        end

        sti2: begin
            next_state = sti3;
        end

        sti3: begin
            next_state = sti4;
        end

        sti4: begin
            if (mem_resp == 0)
                next_state = sti4;
            else
                next_state = fetch1;
        end

        jmp_ret: begin
            next_state = fetch1;
        end

        jmp_sub1: begin
            next_state = jmp_sub2;
        end

        jmp_sub2: begin
            next_state = fetch1;
        end

        shf: begin
            next_state = fetch1;
        end

        lea: begin
            next_state = fetch1;
        end

        trap1: begin
            next_state = trap2;
        end

        trap2: begin
            next_state = trap3;
        end

        trap3: begin
            if (mem_resp == 0)
                next_state = trap3;
            else
                next_state = trap4;
        end

        trap4: begin
            next_state = fetch1;
        end

        default: /* Do nothing */;

    endcase
end

always_ff @(posedge clk)
begin: next_state_assignment
    /* Assignment of next state on clock edge */
    state <= next_state;
end

endmodule : control
