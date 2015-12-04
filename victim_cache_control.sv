module victim_cache_control
(
    /* Input and output port declarations */
	input clk,

	input d_v_mem_swap,
	input mem_read,
	input mem_write,
	input tag_match,
	input tag_match_reg_out,
	input valid,
	input valid_reg_out,
	input dirty,
	input no_evict,
	output logic ld_cache,
	output logic mem_resp,
	output logic ld_from_vic,
	output logic miss_get,
    
    input pmem_resp,
    output logic pmem_read,
    output logic pmem_write
);

enum int unsigned {
    /* List of states */
	idle_check,
	phys_mem_write,
	phys_mem_read
} state, next_state;

always_comb
begin : state_actions
    /* Default output assignments */
	ld_cache = 1'b0;
	ld_from_vic = 1'b0;
	miss_get = 1'b0;
	pmem_read = 1'b0;
	pmem_write = 1'b0;
	mem_resp = 1'b0;
	 
    /* Actions for each state */
	case(state)
        idle_check: 
        begin
			/*if (mem_write && tag_match) 
			begin
				ld_cache= 1;
				mem_resp = 1;
			end*/
			if (d_v_mem_swap)
			begin
				if (valid)
				begin
					if (tag_match)
					begin
						ld_from_vic = 1;
						ld_cache = 1;
						mem_resp = 1;
					end
					
					else
					begin
						if (~dirty)
							ld_cache = 1;
					end
				end
				else
					ld_cache = 1;
			end
			else if (mem_read && no_evict && tag_match && valid)
			begin
				ld_from_vic = 1;
				mem_resp = 1;
			end
			/*else if (mem_read && valid_reg_out && tag_match_reg_out && ~no_evict) 
			begin
			   	ld_from_vic = 1;
				mem_resp = 1;
			end*/
		  end
		  
		phys_mem_write: 
		begin
			pmem_write = 1;
			if (pmem_resp) 
			begin
				ld_cache= 1;
			end
		end
		  
		phys_mem_read: 
		begin
			pmem_read = 1;
			miss_get = 1;
			if (pmem_resp) 
			begin
			   mem_resp = 1;
			end
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
        idle_check: 
        begin
			/*if (mem_write && ~tag_match)
				next_state = phys_mem_write;
			else if (mem_read && (~tag_match || ~valid) && no_evict)
				next_state = phys_mem_read;
			else if (mem_read && (~valid_reg_out || ~tag_match_reg_out))
				next_state = phys_mem_read;*/
			if (d_v_mem_swap && (~tag_match) && valid)
			begin
				if (dirty)
					next_state = phys_mem_write;
				else
					next_state = phys_mem_read;
			end
			else if (d_v_mem_swap && (~valid))
				next_state = phys_mem_read;
			else if (mem_read && (~tag_match || ~valid) && no_evict)
				next_state = phys_mem_read;
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
				next_state = idle_check;
			else
				next_state = phys_mem_read;
		end
        default: next_state = idle_check;
    endcase
end

always_ff @(posedge clk)
begin: next_state_assignment
    /* Assignment of next state on clock edge */
	state <= next_state;
end

endmodule : victim_cache_control
