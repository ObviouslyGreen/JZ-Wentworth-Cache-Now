import lc3b_types::*;

/*
 * Control signals and state machine for the cache
 */
module d_cache_control
(
    input clk,

    /* Datapath signals */
    input hit,
    input curr_way,
    input lru_out,
    input valid0_out,
    input valid1_out,
    input dirty0_out,
    input dirty1_out,
    input lc3b_c_tag pmem_tag,
    output logic ld_cache,
    output logic ld_dirty0,
    output logic ld_dirty1,
    output logic dirty0_in,
    output logic dirty1_in,
    output logic ld_lru,
    output logic writecachemux_sel,
    output logic data0mux_sel,
    output logic data1mux_sel,
    output logic no_evict,

    /* Memory signals */
    input lc3b_word mem_address,
    input pmem_resp,
    input mem_read,
    input mem_write,
    output lc3b_word pmem_address,
    output logic mem_resp,
    output logic pmem_read,
    output logic pmem_write,
    output logic pmem_swap
);


enum int unsigned {
    /* List of states */
    idle_rw_cache,
    no_evict_phys_mem_read,
    phys_mem_swap
} state, next_state;

always_comb
begin: state_actions

    /* Default output assignments */
    ld_cache = 1'b0;
    ld_dirty0 = 1'b0;
    ld_dirty1 = 1'b0;
    dirty0_in = 1'b0;
    dirty1_in = 1'b0;
    ld_lru = 1'b0;
    writecachemux_sel = 1'b0;
    data0mux_sel = 1'b0;
    data1mux_sel = 1'b0;
    no_evict = 1'b0;
    mem_resp = 1'b0;
    pmem_read = 1'b0;
    pmem_write = 1'b0;
    pmem_swap = 1'b0;
    pmem_address = mem_address;

    /* Actions for each state */
    case (state)
        idle_rw_cache:
        begin
            if (hit)
            begin
                ld_lru = 1'b1;
                mem_resp = 1'b1;

                if (mem_write)
                begin
                    writecachemux_sel = 1'b1;

                    if (curr_way)
                    begin
                        data1mux_sel = 1'b1;
                        ld_dirty1 = 1'b1;
                        dirty1_in = 1'b1;
                    end
                    else
                    begin
                        data0mux_sel = 1'b1;
                        ld_dirty0 = 1'b1;
                        dirty0_in = 1'b1;
                    end
                end
            end
        end

        no_evict_phys_mem_read:
        begin
            ld_cache = 1'b1;
            pmem_read = 1'b1;
            no_evict = 1'b1;
        end

        phys_mem_swap:
        begin
            pmem_address = {pmem_tag, mem_address[6:4], 4'b0000};
            ld_cache = 1'b1;
            pmem_swap = 1'b1;
        end 

        default:
            /* nothing */;
    endcase
end

always_comb
begin: next_state_logic
    /* Next state information and conditions (if any)
     * for transitioning between states */

     next_state = state;
     case (state)
        idle_rw_cache:
        begin
            if ((mem_read || mem_write) && (~hit))
            begin
                if (lru_out)
                begin
                    if (valid1_out)
                        next_state = phys_mem_swap;
                    else
                        next_state = no_evict_phys_mem_read;
                end
                else
                begin
                    if (valid0_out)
                        next_state = phys_mem_swap;
                    else
                        next_state = no_evict_phys_mem_read;
                end
            end
            else
                next_state = idle_rw_cache;
        end

        no_evict_phys_mem_read:
        begin
            if (pmem_resp)
                next_state = idle_rw_cache;
            else
                next_state = no_evict_phys_mem_read;
		end

        phys_mem_swap:
        begin
            if (pmem_resp)
                next_state = idle_rw_cache;
            else
                next_state = phys_mem_swap;
        end
        default:
            /* nothing */;
     endcase
 end

always_ff @ (posedge clk)
begin: next_state_assignment
    /* Assignment of next state on clock edge */
    state <= next_state;
end

endmodule : d_cache_control
