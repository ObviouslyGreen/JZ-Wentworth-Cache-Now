library verilog;
use verilog.vl_types.all;
entity gencc is
    port(
        \in\            : in     vl_logic_vector(15 downto 0);
        \out\           : out    vl_logic_vector(2 downto 0)
    );
end gencc;
