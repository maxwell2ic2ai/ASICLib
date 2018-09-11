module Intro_Top(
	output X, Y, Z,
	input A, B, C, D
	);

wire ab, bc, q, qn;

assign #1 Z = ~qn;

AndOr InputComb1(
	.X(ab),
	.Y(bc),
	.A(A),
	.B(B),
	.C(C)
	);

SR SRLatch1(
	.Q(q),
	.Qn(qn),
	.S(bc),
	.R(D)
	);

XorNor OutputComb1(
	.X(x),
	.Y(Y),
	.A(ab),
	.B(q),
	.C(qn)
	);

endmodule