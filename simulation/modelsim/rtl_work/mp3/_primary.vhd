library verilog;
use verilog.vl_types.all;
entity mp3 is
    port(
        clk             : in     vl_logic;
        mem_resp        : in     vl_logic;
        mem_rdata       : in     vl_logic_vector(15 downto 0);
        mem_read        : out    vl_logic;
        mem_write       : out    vl_logic;
        mem_byte_enable : out    vl_logic_vector(1 downto 0);
        mem_address     : out    vl_logic_vector(15 downto 0);
        mem_wdata       : out    vl_logic_vector(15 downto 0);
        instr_resp      : in     vl_logic;
        instr_rdata     : in     vl_logic_vector(15 downto 0);
        instr_read      : out    vl_logic;
        instr_write     : out    vl_logic;
        instr_mem_byte_enable: out    vl_logic_vector(1 downto 0);
        instr_address   : out    vl_logic_vector(15 downto 0);
        instr_wdata     : out    vl_logic_vector(15 downto 0)
    );
end mp3;
