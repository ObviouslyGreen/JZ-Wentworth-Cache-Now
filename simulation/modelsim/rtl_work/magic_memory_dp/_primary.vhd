library verilog;
use verilog.vl_types.all;
entity magic_memory_dp is
    port(
        clk             : in     vl_logic;
        read_a          : in     vl_logic;
        write_a         : in     vl_logic;
        wmask_a         : in     vl_logic_vector(1 downto 0);
        address_a       : in     vl_logic_vector(15 downto 0);
        wdata_a         : in     vl_logic_vector(15 downto 0);
        resp_a          : out    vl_logic;
        rdata_a         : out    vl_logic_vector(15 downto 0);
        read_b          : in     vl_logic;
        write_b         : in     vl_logic;
        wmask_b         : in     vl_logic_vector(1 downto 0);
        address_b       : in     vl_logic_vector(15 downto 0);
        wdata_b         : in     vl_logic_vector(15 downto 0);
        resp_b          : out    vl_logic;
        rdata_b         : out    vl_logic_vector(15 downto 0)
    );
end magic_memory_dp;
