library verilog;
use verilog.vl_types.all;
entity data_membyte_filter is
    port(
        mem_byte_enable : in     vl_logic_vector(1 downto 0);
        mem_wdata       : in     vl_logic_vector(15 downto 0);
        datablock       : in     vl_logic_vector(127 downto 0);
        offset          : in     vl_logic_vector(3 downto 0);
        \out\           : out    vl_logic_vector(127 downto 0)
    );
end data_membyte_filter;
