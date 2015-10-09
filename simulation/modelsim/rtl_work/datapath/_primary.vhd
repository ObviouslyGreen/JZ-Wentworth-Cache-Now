library verilog;
use verilog.vl_types.all;
library work;
entity datapath is
    port(
        clk             : in     vl_logic;
        load_pc         : in     vl_logic;
        load_ir         : in     vl_logic;
        load_regfile    : in     vl_logic;
        load_mar        : in     vl_logic;
        load_mdr        : in     vl_logic;
        load_cc         : in     vl_logic;
        regfile_filter_enable: in     vl_logic;
        stb_filter_enable: in     vl_logic;
        pcmux_sel       : in     vl_logic_vector(1 downto 0);
        storemux_sel    : in     vl_logic;
        destmux_sel     : in     vl_logic;
        alumux_sel      : in     vl_logic_vector(1 downto 0);
        regfilemux_sel  : in     vl_logic_vector(1 downto 0);
        marmux_sel      : in     vl_logic_vector(1 downto 0);
        mdrmux_sel      : in     vl_logic;
        offsetaddermux_sel: in     vl_logic;
        offset6mux_sel  : in     vl_logic;
        aluop           : in     work.lc3b_types.lc3b_aluop;
        opcode          : out    work.lc3b_types.lc3b_opcode;
        branch_enable   : out    vl_logic;
        d_enable        : out    vl_logic;
        imm_enable      : out    vl_logic;
        jsr_enable      : out    vl_logic;
        mem_rdata       : in     vl_logic_vector(15 downto 0);
        mem_wdata       : out    vl_logic_vector(15 downto 0);
        mem_address     : out    vl_logic_vector(15 downto 0)
    );
end datapath;
