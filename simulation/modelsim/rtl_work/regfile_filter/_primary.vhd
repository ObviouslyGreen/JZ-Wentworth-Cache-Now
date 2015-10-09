library verilog;
use verilog.vl_types.all;
entity regfile_filter is
    port(
        filter_enable   : in     vl_logic;
        high_byte_enable: in     vl_logic;
        \in\            : in     vl_logic_vector(15 downto 0);
        \out\           : out    vl_logic_vector(15 downto 0)
    );
end regfile_filter;
