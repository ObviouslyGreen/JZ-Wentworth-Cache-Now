import lc3b_types::*;

module l2_lru
(
    input clk,
    input write,
    input lc3b_c_l2_index index,
	input [1:0] in,
    output logic [1:0] out
);

logic [1:0] lru_out0;
logic [1:0] lru_out1;
logic [1:0] lru_out2;
logic [1:0] lru_out3;
logic [1:0] lru_out4;
logic [1:0] lru_out5;
logic [1:0] lru_out6;
logic [1:0] lru_out7;
logic [1:0] lru_out8;
logic [1:0] lru_out9;
logic [1:0] lru_out10;
logic [1:0] lru_out11;
logic [1:0] lru_out12;
logic [1:0] lru_out13;
logic [1:0] lru_out14;
logic [1:0] lru_out15;

lru_stack lru_stack0
(
    .clk(clk),
	.write(write && (mem_index == 4'b0000)),
	.in(in),
	.lru(lru_out0)
);

lru_stack lru_stack1
(
    .clk(clk),
	.write(write && (mem_index == 4'b0001)),
	.in(in),
	.lru(lru_out1)
);

lru_stack lru_stack2
(
    .clk(clk),
	.write(write && (mem_index == 4'b0010)),
	.in(in),
	.lru(lru_out2)
);

lru_stack lru_stack3
(
    .clk(clk),
	.write(write && (mem_index == 4'b0011)),
	.in(in),
	.lru(lru_out3)
);

lru_stack lru_stack4
(
    .clk(clk),
	.write(write && (mem_index == 4'b0100)),
	.in(in),
	.lru(lru_out4)
);

lru_stack lru_stack5
(
    .clk(clk),
	.write(write && (mem_index == 4'b0101)),
	.in(in),
	.lru(lru_out5)
);

lru_stack lru_stack6
(
    .clk(clk),
	.write(write && (mem_index == 4'b0110)),
	.in(in),
	.lru(lru_out6)
);

lru_stack lru_stack7
(
    .clk(clk),
	.write(write && (mem_index == 4'b0111)),
	.in(in),
	.lru(lru_out7)
);

lru_stack lru_stack8
(
    .clk(clk),
	.write(write && (mem_index == 4'b1000)),
	.in(in),
	.lru(lru_out8)
);

lru_stack lru_stack9
(
    .clk(clk),
	.write(write && (mem_index == 4'b1001)),
	.in(in),
	.lru(lru_out9)
);

lru_stack lru_stack10
(
    .clk(clk),
	.write(write && (mem_index == 4'b1010)),
	.in(in),
	.lru(lru_out10)
);

lru_stack lru_stack11
(
    .clk(clk),
	.write(write && (mem_index == 4'b1011)),
	.in(in),
	.lru(lru_out11)
);
lru_stack lru_stack12
(
    .clk(clk),
	.write(write && (mem_index == 4'b1100)),
	.in(in),
	.lru(lru_out12)
);

lru_stack lru_stack13
(
    .clk(clk),
	.write(write && (mem_index == 4'b1101)),
	.in(in),
	.lru(lru_out13)
);

lru_stack lru_stack14
(
    .clk(clk),
	.write(write && (mem_index == 4'b1110)),
	.in(in),
	.lru(lru_out14)
);

lru_stack lru_stack15
(
    .clk(clk),
	.write(write && (mem_index == 4'b1111)),
	.in(in),
	.lru(lru_out15)
);

mux8 #(.width(2)) lru_mux0
(
	.sel(index[3:0]),
	.a(lru_out0),
	.b(lru_out1),
	.c(lru_out2),
	.d(lru_out3),
	.e(lru_out4),
	.f(lru_out5),
	.g(lru_out6),
	.h(lru_out7),
	.i(lru_out8),
	.j(lru_out9),
	.k(lru_out10),
	.l(lru_out11),
	.m(lru_out12),
	.n(lru_out13),
	.o(lru_out14),
	.p(lru_out15)
);

endmodule : l2_lru