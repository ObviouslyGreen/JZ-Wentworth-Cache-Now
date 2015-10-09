library verilog;
use verilog.vl_types.all;
entity nzp_comparator is
    port(
        nzp             : in     vl_logic_vector(2 downto 0);
        ir_nzp          : in     vl_logic_vector(2 downto 0);
        branch_enable   : out    vl_logic
    );
end nzp_comparator;
