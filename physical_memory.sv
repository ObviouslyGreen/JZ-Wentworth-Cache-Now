module physical_memory
(
    input clk,
    input read,
    input write,
    input [15:0] address,
    input [127:0] wdata,
    output logic resp,
    output logic [127:0] rdata
);

timeunit 1ns;
timeprecision 1ns;

parameter DELAY_MEM = 200;

logic [127:0] mem [0:2**($bits(address)-4)-1];
logic [11:0] internal_address;
logic ready;

/* Initialize memory contents from memory.lst file */
initial
begin
    $readmemh("memory.lst", mem);
end

assign internal_address = address[15:4];

enum int unsigned {
    idle,
    busy,
    respond
} state, next_state;

always @(posedge clk)
begin
    /* Default */
    resp = 1'b0;

    next_state = state;

    case(state)
        idle: begin
            if (read | write) begin
                next_state = busy;
                ready <= #DELAY_MEM 1;
            end
        end

        busy: begin
            if (ready == 1) begin
                if (write) begin
                    mem[internal_address] = wdata;
                end

                rdata = mem[internal_address];
                resp = 1;

                next_state = respond;
            end
        end

        respond: begin
            ready <= 0;
            next_state = idle;
        end

        default: next_state = idle;
    endcase
end

always_ff @(posedge clk)
begin : next_state_assignment
    state <= next_state;
end

endmodule : physical_memory
