library verilog;
use verilog.vl_types.all;
entity reg_latch is
    generic(
        width           : integer := 16
    );
    port(
        clk             : in     vl_logic;
        load            : in     vl_logic;
        \in\            : in     vl_logic_vector;
        \out\           : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of width : constant is 1;
end reg_latch;
