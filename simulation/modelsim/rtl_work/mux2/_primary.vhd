library verilog;
use verilog.vl_types.all;
entity mux2 is
    generic(
        width           : integer := 16
    );
    port(
        sel             : in     vl_logic;
        a               : in     vl_logic_vector;
        b               : in     vl_logic_vector;
        f               : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of width : constant is 1;
end mux2;
