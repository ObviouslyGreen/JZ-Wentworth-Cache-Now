module mp3_tb;

timeunit 1ns;
timeprecision 1ns;

logic clk;
/*logic pmem_resp;
logic pmem_read;
logic pmem_write;
logic [15:0] pmem_address;
logic [127:0] pmem_rdata;
logic [127:0] pmem_wdata;*/

logic mem_resp;
logic mem_read;
logic mem_write;
logic [15:0] mem_address;
logic [15:0] mem_rdata;
logic [15:0] mem_wdata;


logic instr_resp;
logic instr_read;
logic instr_write;
logic [15:0] instr_address;
logic [15:0] instr_rdata;
logic [15:0] instr_wdata;

/* Clock generator */
initial clk = 0;
always #5 clk = ~clk;

/*mp3 dut
(
    .clk,
    .pmem_resp,
    .pmem_rdata,
    .pmem_read,
    .pmem_write,
    .pmem_address,
    .pmem_wdata
);*/

mp3 dut
(
    .clk,
    .mem_resp,
    .mem_rdata,
    .mem_read,
    .mem_write,
    .mem_address,
    .mem_wdata,
    .instr_resp,
    .instr_rdata,
    .instr_read,
    .instr_write,
    .instr_address,
    .instr_wdata
);

/*physical_memory memory
(
    .clk,
    .read(pmem_read),
    .write(pmem_write),
    .address(pmem_address),
    .wdata(pmem_wdata),
    .resp(pmem_resp),
    .rdata(pmem_rdata)
);*/


/*
 * Instruction Memory
 */


magic_memory_dp memory
(
    .clk,

    /* Instruction Memory */
    .read_a(instr_read),
    .write_a(instr_write),
    .address_a(instr_address),
    .wdata_a(instr_wdata),
    .resp_a(instr_resp),
    .rdata_a(instr_rdata),

    /* Yes */
    .read_b(mem_read),
    .write_b(mem_write),
    .address_b(mem_address),
    .wdata_b(mem_wdata),
    .resp_b(mem_resp),
    .rdata_b(mem_rdata)
);

endmodule : mp3_tb
