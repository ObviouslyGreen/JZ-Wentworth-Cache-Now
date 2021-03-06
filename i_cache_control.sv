import lc3b_types::*;

/*
 * Control signals and state machine for the cache
 */
module i_cache_control
(
    input clk,

    /* Datapath signals */
    input hit,
    input curr_way,
    input lru_out,
    input dirty0_out,
    input dirty1_out,
    input lc3b_c_tag pmem_tag,
    output logic ld_cache,
    output logic ld_dirty0,
    output logic ld_dirty1,
    output logic ld_lru,
    output logic dirtymux_sel,
    output logic writecachemux_sel,
    output logic data0mux_sel,
    output logic data1mux_sel,

    /* Memory signals */
    input lc3b_word mem_address,
    input pmem_resp,
    input mem_read,
    input mem_write,
    output lc3b_word pmem_address,
    output logic mem_resp,
    output logic pmem_read,
    output logic pmem_write
);


enum int unsigned {
    /* List of states */
    idle_rw_cache,
    phys_mem_write,
    phys_mem_read
} state, next_state;

always_comb
begin: state_actions

    /* Default output assignments */
    ld_cache = 1'b0;
    ld_dirty0 = 1'b0;
    ld_dirty1 = 1'b0;
    ld_lru = 1'b0;
    dirtymux_sel = 1'b0;
    writecachemux_sel = 1'b0;
    data0mux_sel = 1'b0;
    data1mux_sel = 1'b0;
    mem_resp = 1'b0;
    pmem_read = 1'b0;
    pmem_write = 1'b0;
    pmem_address = mem_address;

    /* Actions for each state */
    case (state)
        idle_rw_cache:
        begin
           if (hit && mem_write && curr_way)
            begin
                ld_lru = 1'b1;
                mem_resp = 1'b1;
                writecachemux_sel = 1'b1;
                data1mux_sel = 1'b1;
                ld_dirty1 = 1'b1;
            end
            else if (hit && mem_write && ~curr_way)
            begin
                ld_lru = 1'b1;
                mem_resp = 1'b1;
                writecachemux_sel = 1'b1;
                data0mux_sel = 1'b1;
                ld_dirty0 = 1'b1;
            end
            else if (hit && ~mem_write)
            begin
                ld_lru = 1'b1;
                mem_resp = 1'b1;
            end
        end

        phys_mem_write:
        begin
            dirtymux_sel = 1'b0;
            if (lru_out)
            begin
                ld_dirty1 = 1'b1;
            end
            else
            begin
                ld_dirty0 = 1'b1;
            end

            pmem_address = {pmem_tag, mem_address[6:4], 4'b0000};
            pmem_write = 1'b1;
        end

        phys_mem_read:
        begin
            ld_cache = 1'b1;
            pmem_read = 1'b1;
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
            if ((mem_read | mem_write) & (~hit))
            begin
                if (lru_out)
                begin
                    if (dirty1_out)
                        next_state = phys_mem_write;
                    else
                        next_state = phys_mem_read;
                end
                else
                begin
                    if (dirty0_out)
                        next_state = phys_mem_write;
                    else
                        next_state = phys_mem_read;
                end
            end
            else
                next_state = idle_rw_cache;
        end

        phys_mem_write:
        begin
            if (pmem_resp)
                next_state = phys_mem_read;
            else
                next_state = phys_mem_write;
        end

        phys_mem_read:
        begin
            if (pmem_resp)
                next_state = idle_rw_cache;
            else
                next_state = phys_mem_read;
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

endmodule : i_cache_control
