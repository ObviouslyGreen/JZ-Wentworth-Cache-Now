library verilog;
use verilog.vl_types.all;
entity \array\ is
    generic(
        width           : integer := 128
    );
    port(
        clk             : in     vl_logic;
        load            : in     vl_logic;
        index           : in     vl_logic_vector(2 downto 0);
        \in\            : in     vl_logic_vector;
        \out\           : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of width : constant is 1;
end \array\;
