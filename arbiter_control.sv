import lc3b_types::*; 

module arbiter_control
(
	input clk,
	input i_pmem_read,
	input d_pmem_read,
	input d_pmem_write,
	input l2_mem_resp,
	output logic i_mem_resp,
	output logic d_mem_resp,
	output logic l2_mem_read,
	output logic l2_mem_write,
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
	i_mem_resp = 0;
	d_mem_resp = 0;
	l2_mem_read = 0;
	l2_mem_write = 0;
	arbiter_sel = 0;

    /* Actions for each state */
	case(state)
		idle:
		begin
			if (d_mem_read)
			begin
				l2_mem_read = 1;
				arbiter_sel = 1;
			end
			else if (i_mem_read) 
			begin
				l2_mem_read = 1;
				arbiter_sel = 0;
			end
			else if (d_mem_write) 
			begin
				l2_mem_write = 1;
				arbiter_sel = 1;
			end
		end
		icache_miss_fetched:
		begin
			i_mem_resp = 1;
		end
		dcache_miss_fetched:
		begin
			d_mem_resp = 1;
		end
	endcase
end

always_comb
begin : next_state_resp_logic
    next_state = state;
    case(state)
    	idle:
		begin
			if ((d_mem_read == 1 || d_mem_write == 1) && l2_mem_resp)
				next_state = data_fetch;
			else if (i_mem_read && l2_mem_resp)
				next_state = instruction_fetch;
		end
		icache_miss_fetched: 
			next_state = idle;
		dcache_miss_fetched: 
			next_state = idle;
    	default:
    		next_state = idle;
    endcase
end

always_ff @(posedge clk)
begin: next_state_assignment
    /* Assignment of next state on clock edge */
    state <= next_state;
end

endmodule : arbiter_control














