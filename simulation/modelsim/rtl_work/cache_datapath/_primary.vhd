library verilog;
use verilog.vl_types.all;
entity cache_datapath is
    port(
        clk             : in     vl_logic;
        ld_cache        : in     vl_logic;
        ld_dirty0       : in     vl_logic;
        ld_dirty1       : in     vl_logic;
        ld_lru          : in     vl_logic;
        dirtymux_sel    : in     vl_logic;
        writecachemux_sel: in     vl_logic;
        data0mux_sel    : in     vl_logic;
        data1mux_sel    : in     vl_logic;
        hit             : out    vl_logic;
        curr_way        : out    vl_logic;
        lru_out         : out    vl_logic;
        dirty0_out      : out    vl_logic;
        dirty1_out      : out    vl_logic;
        pmem_tag        : out    vl_logic_vector(8 downto 0);
        mem_address     : in     vl_logic_vector(15 downto 0);
        mem_wdata       : in     vl_logic_vector(15 downto 0);
        pmem_rdata      : in     vl_logic_vector(127 downto 0);
        mem_byte_enable : in     vl_logic_vector(1 downto 0);
        mem_rdata       : out    vl_logic_vector(15 downto 0);
        pmem_wdata      : out    vl_logic_vector(127 downto 0)
    );
end cache_datapath;
