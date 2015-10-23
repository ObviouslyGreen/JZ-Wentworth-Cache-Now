/*
 * Latch module
 */
module reg_latch #(parameter width = 16)
(
    input clk,
    input load,
    input [width-1:0] in,
    output logic [width-1:0] out
);


always_latch
begin
    if (load)
    begin
        out = in;
    end
end


endmodule : reg_latch
