module mp2_tb;

timeunit 1ns;
timeprecision 1ns;

logic clk;
logic pmem_resp;
logic pmem_read;
logic pmem_write;
logic [15:0] pmem_address;
logic [127:0] pmem_rdata;
logic [127:0] pmem_wdata;

/* Clock generator */
initial clk = 0;
always #5 clk = ~clk;

mp2 dut
(
    .clk,
    .pmem_resp,
    .pmem_rdata,
    .pmem_read,
    .pmem_write,
    .pmem_address,
    .pmem_wdata
);

physical_memory memory
(
    .clk,
    .read(pmem_read),
    .write(pmem_write),
    .address(pmem_address),
    .wdata(pmem_wdata),
    .resp(pmem_resp),
    .rdata(pmem_rdata)
);

endmodule : mp2_tb
