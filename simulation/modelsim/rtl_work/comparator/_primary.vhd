library verilog;
use verilog.vl_types.all;
entity comparator is
    generic(
        width           : integer := 9
    );
    port(
        clk             : in     vl_logic;
        a               : in     vl_logic_vector;
        b               : in     vl_logic_vector;
        \out\           : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of width : constant is 1;
end comparator;
