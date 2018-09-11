module SR(
	output Q, Qn,
	input S, R
	);

assign #1 Q = q;
assign #1 Qn = qn;

assign #10 q = ~(S&qn);
assign #10 qn = ~(R&q);

endmodule
