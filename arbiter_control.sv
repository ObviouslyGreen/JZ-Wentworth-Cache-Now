module arbiter_control
(
    input clk,
    input i_pmem_read,
    input d_pmem_read,
    input d_pmem_write,
    input l2_mem_resp,
    output logic i_pmem_resp,
    output logic d_pmem_resp,
    output logic arbiter_sel
);

enum int unsigned {
    /* List of states */
    idle,
    icache_miss_fetched,
    dcache_miss_fetched
} state, next_state;

always_comb
begin : state_actions
    /* Default output assignments */
    i_pmem_resp = 0;
    d_pmem_resp = 0;
    arbiter_sel = 0;

    /* Actions for each state */
    case(state)
        idle:
        begin
            if (d_pmem_read)
            begin
                arbiter_sel = 1;
            end
            else if (i_pmem_read)
            begin
                arbiter_sel = 0;
            end
            else if (d_pmem_write)
            begin
                arbiter_sel = 1;
            end
        end

        icache_miss_fetched:
        begin
            i_pmem_resp = 1;
        end

        dcache_miss_fetched:
        begin
            d_pmem_resp = 1;
        end

    endcase
end

always_comb
begin : next_state_resp_logic
    next_state = state;
    case(state)
        idle:
        begin
            if ((d_pmem_read == 1 || d_pmem_write == 1) && l2_mem_resp)
                next_state = dcache_miss_fetched;
            else if (i_pmem_read && l2_mem_resp)
                next_state = icache_miss_fetched;
        end

        icache_miss_fetched:
        begin
            next_state = idle;
        end

        dcache_miss_fetched:
        begin
            next_state = idle;
        end

        default:
        begin
            next_state = idle;
        end

    endcase
end

always_ff @(posedge clk)
begin: next_state_assignment
    /* Assignment of next state on clock edge */
    state <= next_state;
end

endmodule : arbiter_control
