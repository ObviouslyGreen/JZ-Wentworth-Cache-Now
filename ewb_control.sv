import lc3b_types::*; 

module ewb_control(
    /* Input and output port declarations */
	input clk,

    input l2_pmem_dirty_evict,
	input l2_pmem_write,
	input pmem_resp,
	input lc3b_word ewb_addr_buff_out,
	input lc3b_word l2_pmem_address,
    output logic empty,
	output logic ready, 
	output logic ld_buff, 
	output logic pmem_write, 
	output lc3b_word pmem_address
);

enum int unsigned {
    /* List of states */
    idle,
    in_queue,
    phys_mem_write
} state, next_state;

always_comb
begin : state_actions
    /* Default output assignments */
    empty = 1'b0;
    ready = 1'b0;
    ld_buff = 1'b0;
    pmem_address = l2_pmem_address;
    pmem_write = 1'b0;
	 
    /* Actions for each state */
	case(state)
    	idle: 
    	begin
            empty = 1'b1;
    		ready = 1'b1;
    	end

        in_queue: 
        begin
            ready = 1'b1;
            ld_buff = 1'b1;
        end

    	phys_mem_write:
    	begin
    		pmem_write = 1'b1;
    		pmem_address = ewb_addr_buff_out;
    	end

        default: 
        	/* Do nothing */;
    endcase
end

always_comb
begin : next_state_logic
    /* Next state information and conditions (if any)
     * for transitioning between states */
	next_state = state;
	
    case(state)
    	idle: 
    	begin
    		if (l2_pmem_dirty_evict)
    			next_state = in_queue;
    	end

        in_queue: 
        begin
            if (l2_pmem_write)
                next_state = phys_mem_write;
        end

    	phys_mem_write:
    	begin
    		if (pmem_resp)
    			next_state = idle;
    	end

        default: next_state = idle;
    endcase
end

always_ff @(posedge clk)
begin: next_state_assignment
    /* Assignment of next state on clock edge */
	state <= next_state;
end

endmodule : ewb_control
