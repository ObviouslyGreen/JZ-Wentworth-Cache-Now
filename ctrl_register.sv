/*
 * Register module (provided)
 */
import lc3b_types::*;

module ctrl_register 
(
    input clk,
    input load,
    input lc3b_control_word in,
    output lc3b_control_word out
);

lc3b_control_word ctrl;

/* Altera device registers are 0 at power on. Specify this
 * so that Modelsim works as expected.
 */
initial
begin
    ctrl.opcode = op_add;
    ctrl.load_pc = 1'b0;
    ctrl.load_ir = 1'b0;
    ctrl.load_regfile = 1'b0;
    ctrl.load_mar = 1'b0;
    ctrl.load_mdr = 1'b0;
    ctrl.load_cc = 1'b0;
    ctrl.regfile_filter_enable = 1'b0;
    ctrl.stb_filter_enable = 1'b0;
    ctrl.pcmux_sel = 2'b00;
    ctrl.storemux_sel = 0;
    ctrl.destmux_sel = 0;
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
end

always_ff @(posedge clk)
begin
    if (load)
    begin
        ctrl = in;
    end
end

always_comb
begin
    out = ctrl;
end

endmodule : ctrl_register
