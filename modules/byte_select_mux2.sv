import lc3b_types::*;

/*
 * 2-input mux that selects which byte to output based on offset
 */
module byte_select_mux2
(
    input sel0, sel1,
    input lc3b_c_offset offset,
    input lc3b_mem_data a, b,
    output lc3b_word f,
    output lc3b_mem_data selected_data
);


lc3b_mem_data data;

always_comb
begin
    if (sel0 == 1'b1)
    begin
        selected_data = a;
    end
    else if (sel1 == 1'b1)
    begin
        selected_data = b;
    end
    else
    begin
        selected_data = a;
    end

    data = selected_data;

    case (offset[3:1])
        3'b000:
            f = data[15:0];
        3'b001:
            f = data[31:16];
        3'b010:
            f = data[47:32];
        3'b011:
            f = data[63:48];
        3'b100:
            f = data[79:64];
        3'b101:
            f = data[95:80];
        3'b110:
            f = data[111:96];
        3'b111:
            f = data[127:112];
    endcase
end

endmodule : byte_select_mux2
