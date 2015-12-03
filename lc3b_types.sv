/*
 * Custom typedefs for project (provided but modified)
 */
package lc3b_types;

typedef logic [255:0] lc3b_pmem_data;
typedef logic [127:0] lc3b_mem_data;
typedef logic [15:0] lc3b_word;
typedef logic [7:0] lc3b_byte;

typedef logic [10:0] lc3b_offset11;
typedef logic [8:0] lc3b_offset9;
typedef logic [5:0] lc3b_offset6;
typedef logic [4:0] lc3b_offset5;
typedef logic [3:0] lc3b_offset4;
typedef logic [2:0] lc3b_offset3;
typedef logic [2:0] lc3b_lc3x;

typedef logic [2:0] lc3b_reg;
typedef logic [2:0] lc3b_nzp;
typedef logic [1:0] lc3b_mem_wmask;

typedef logic [3:0] lc3b_c_l2_index;
typedef logic [4:0] lc3b_c_l2_offset;
typedef logic [6:0] lc3b_c_l2_tag;
typedef logic [2:0] lc3b_c_index;
typedef logic [3:0] lc3b_c_offset;
typedef logic [8:0] lc3b_c_tag;

typedef enum bit [3:0] {
    op_add  = 4'b0001,
    //  op_div = 4'b0001            bits [4:3] = 01
    //  op_mult = 4'b0001                      = 10
    //  op_sub = 4'b0001                       = 11
    op_and  = 4'b0101,
    //  op_or = 4'b0101                        = 01
    //  op_xor = 4'b0101                       = 10
    op_br   = 4'b0000,
    op_jmp  = 4'b1100,   /* also RET */
    op_jsr  = 4'b0100,   /* also JSRR */
    op_ldb  = 4'b0010,
    op_ldi  = 4'b1010,
    op_ldr  = 4'b0110,
    op_lea  = 4'b1110,
    op_not  = 4'b1001,
    op_rti  = 4'b1000,
    op_shf  = 4'b1101,
    op_stb  = 4'b0011,
    op_sti  = 4'b1011,
    op_str  = 4'b0111,
    op_trap = 4'b1111
} lc3b_opcode;

typedef enum bit [3:0] {
    alu_add,
    alu_sub,
    alu_mult,
    alu_div,
    alu_and,
    alu_or,
    alu_xor,
    alu_not,
    alu_pass,
    alu_sll,
    alu_srl,
    alu_sra
} lc3b_aluop;

typedef struct packed {
    lc3b_opcode opcode;
    lc3b_aluop aluop;
    logic load_pc;
    logic load_ir;
    logic load_regfile;
    logic load_mar;
    logic load_mdr;
    logic load_cc;
    logic regfile_filter_enable;
    logic stb_filter_enable;
    logic [1:0] pcmux_sel;
    logic brmux_sel;
    logic storemux_sel;
    logic destmux_sel;
    logic [1:0] alumux_sel;
    logic [1:0] regfilemux_sel;
    logic [1:0] marmux_sel;
    logic mdrmux_sel;
    logic offsetaddermux_sel;
    logic offset6mux_sel;    
    logic mem_read;
    logic mem_write;
    logic indirect_enable;
    logic is_nop;
    lc3b_mem_wmask mem_byte_enable;
    logic imm_enable;
} lc3b_control_word;

endpackage : lc3b_types
