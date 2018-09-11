module XorNor(
	output X, Y,
	input A, B, C
	);

wire x_xor;

assign #1 X = x_xor;
assign #10 x_xor = A^B;
assign #10 Y = ~(x_xor|C);

endmodule