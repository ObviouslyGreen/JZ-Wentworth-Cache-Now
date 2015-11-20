/*
 * N-bit 8-length array
 */
module decoder
(
    input [1:0] in,
    output logic d0,
    output logic d1,
    output logic d2,
    output logic d3
);

always_comb
begin
    if (in == 2'b00)
    begin
        d0 = 1;
        d1 = 0;
        d2 = 0;
        d3 = 0;
    end

    else if (in == 2'b01)
    begin
        d0 = 0;
        d1 = 1;
        d2 = 0;
        d3 = 0;
    end

    else if (in == 2'b10)
    begin
        d0 = 0;
        d1 = 0;
        d2 = 1;
        d3 = 0;
    end

    else if (in == 2'b11)
    begin
        d0 = 0;
        d1 = 0;
        d2 = 0;
        d3 = 1;
    end

    else
    begin
        d0 = 0;
        d1 = 0;
        d2 = 0;
        d3 = 0;
    end
end

endmodule : decoder
