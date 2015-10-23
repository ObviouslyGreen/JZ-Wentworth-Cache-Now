library verilog;
use verilog.vl_types.all;
library work;
entity datapath is
    port(
        clk             : in     vl_logic;
        aluop           : in     work.lc3b_types.lc3b_aluop;
        opcode          : out    work.lc3b_types.lc3b_opcode;
        branch_enable   : out    vl_logic;
        d_enable        : out    vl_logic;
        imm_enable      : out    vl_logic;
        jsr_enable      : out    vl_logic;
        mem_rdata       : in     vl_logic_vector(15 downto 0);
        mem_read        : out    vl_logic;
        mem_write       : out    vl_logic;
        mem_byte_enable : out    vl_logic_vector(1 downto 0);
        mem_wdata       : out    vl_logic_vector(15 downto 0);
        mem_address     : out    vl_logic_vector(15 downto 0);
        instr_rdata     : in     vl_logic_vector(15 downto 0);
        instr_address   : out    vl_logic_vector(15 downto 0)
    );
end datapath;
