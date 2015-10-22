/*
 * Dual-port magic memory
 *
 * Usage note: Avoid writing to the same address on both ports simultaneously.
 */

module magic_memory_dp
(
    input clk,

    /* Port A */
    input read_a,
    input write_a,
    input [1:0] wmask_a,
    input [15:0] address_a,
    input [15:0] wdata_a,
    output logic resp_a,
    output logic [15:0] rdata_a,

    /* Port B */
    input read_b,
    input write_b,
    input [1:0] wmask_b,
    input [15:0] address_b,
    input [15:0] wdata_b,
    output logic resp_b,
    output logic [15:0] rdata_b
);

timeunit 1ns;
timeprecision 1ns;

logic [7:0] mem [0:2**($bits(address_a))-1];
logic [15:0] internal_address_a;
logic [15:0] internal_address_b;

/* Initialize memory contents from memory.lst file */
initial
begin
    $readmemh("memory.lst", mem);
end

/* Calculate internal address */
assign internal_address_a = {address_a[15:1], 1'b0};
assign internal_address_b = {address_b[15:1], 1'b0};

/* Read */
always_comb
begin : mem_read_a
    rdata_a = {mem[internal_address_a+1], mem[internal_address_a]};
    rdata_b = {mem[internal_address_b+1], mem[internal_address_b]};
end : mem_read_a

/* Port A write */
always @(posedge clk)
begin : mem_write_a
    if (write_a)
    begin
        if (wmask_a[1])
        begin
            mem[internal_address_a+1] = wdata_a[15:8];
        end

        if (wmask_a[0])
        begin
            mem[internal_address_a] = wdata_a[7:0];
        end
    end
end : mem_write_a

/* Port B write */
always @(posedge clk)
begin : mem_write_b
    if (write_b)
    begin
        if (wmask_b[1])
        begin
            mem[internal_address_b+1] = wdata_b[15:8];
        end

        if (wmask_b[0])
        begin
            mem[internal_address_b] = wdata_b[7:0];
        end
    end
end : mem_write_b

/* Magic memory responds immediately */
assign resp_a = read_a | write_a;
assign resp_b = read_b | write_b;

endmodule : magic_memory_dp