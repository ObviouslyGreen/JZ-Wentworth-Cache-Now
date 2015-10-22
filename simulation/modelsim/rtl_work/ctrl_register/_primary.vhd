library verilog;
use verilog.vl_types.all;
library work;
entity ctrl_register is
    port(
        clk             : in     vl_logic;
        load            : in     vl_logic;
        \in\            : in     work.lc3b_types.lc3b_control_word;
        \out\           : out    work.lc3b_types.lc3b_control_word
    );
end ctrl_register;
