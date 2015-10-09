library verilog;
use verilog.vl_types.all;
entity byte_select_mux2 is
    port(
        sel0            : in     vl_logic;
        sel1            : in     vl_logic;
        offset          : in     vl_logic_vector(3 downto 0);
        a               : in     vl_logic_vector(127 downto 0);
        b               : in     vl_logic_vector(127 downto 0);
        f               : out    vl_logic_vector(15 downto 0);
        selected_data   : out    vl_logic_vector(127 downto 0)
    );
end byte_select_mux2;
