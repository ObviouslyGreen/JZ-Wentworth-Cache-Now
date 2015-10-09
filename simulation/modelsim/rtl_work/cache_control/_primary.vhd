library verilog;
use verilog.vl_types.all;
entity cache_control is
    port(
        clk             : in     vl_logic;
        hit             : in     vl_logic;
        curr_way        : in     vl_logic;
        lru_out         : in     vl_logic;
        dirty0_out      : in     vl_logic;
        dirty1_out      : in     vl_logic;
        pmem_tag        : in     vl_logic_vector(8 downto 0);
        ld_cache        : out    vl_logic;
        ld_dirty0       : out    vl_logic;
        ld_dirty1       : out    vl_logic;
        ld_lru          : out    vl_logic;
        dirtymux_sel    : out    vl_logic;
        writecachemux_sel: out    vl_logic;
        data0mux_sel    : out    vl_logic;
        data1mux_sel    : out    vl_logic;
        mem_address     : in     vl_logic_vector(15 downto 0);
        pmem_resp       : in     vl_logic;
        mem_read        : in     vl_logic;
        mem_write       : in     vl_logic;
        pmem_address    : out    vl_logic_vector(15 downto 0);
        mem_resp        : out    vl_logic;
        pmem_read       : out    vl_logic;
        pmem_write      : out    vl_logic
    );
end cache_control;
