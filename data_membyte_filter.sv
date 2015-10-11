import lc3b_types::*;

/*
 * Module to determine which byte/word to write during a cache hit
 */

module data_membyte_filter
(
    input lc3b_mem_wmask mem_byte_enable,
    input lc3b_word mem_wdata,
    input lc3b_mem_data datablock,
    input lc3b_c_offset offset,
    output lc3b_mem_data out
);


lc3b_mem_data data;

always_comb
begin

    data = datablock;

    case (offset[3:1])
        3'b000:
        begin
            if (mem_byte_enable[0])
                data[7:0] = mem_wdata[7:0];
            if (mem_byte_enable[1])
                data[15:8] = mem_wdata[15:8];
        end
        3'b001:
        begin
            if (mem_byte_enable[0])
                data[23:16] = mem_wdata[7:0];
            if (mem_byte_enable[1])
                data[31:24] = mem_wdata[15:8];
        end
        3'b010:
        begin
            if (mem_byte_enable[0])
                data[39:32] = mem_wdata[7:0];
            if (mem_byte_enable[1])
                data[47:40] = mem_wdata[15:8];
        end
        3'b011:
        begin
            if (mem_byte_enable[0])
                data[55:48] = mem_wdata[7:0];
            if (mem_byte_enable[1])
                data[63:56] = mem_wdata[15:8];
        end
        3'b100:
        begin
            if (mem_byte_enable[0])
                data[71:64] = mem_wdata[7:0];
            if (mem_byte_enable[1])
                data[79:72] = mem_wdata[15:8];
        end
        3'b101:
        begin
            if (mem_byte_enable[0])
                data[87:80] = mem_wdata[7:0];
            if (mem_byte_enable[1])
                data[95:88] = mem_wdata[15:8];
        end
        3'b110:
        begin
            if (mem_byte_enable[0])
                data[103:96] = mem_wdata[7:0];
            if (mem_byte_enable[1])
                data[111:104] = mem_wdata[15:8];
        end
        3'b111:
        begin
            if (mem_byte_enable[0])
                data[119:112] = mem_wdata[7:0];
            if (mem_byte_enable[1])
                data[127:120] = mem_wdata[15:8];
        end
    endcase

    out = data;

end

endmodule : data_membyte_filter
