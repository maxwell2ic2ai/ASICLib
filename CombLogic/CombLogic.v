// Two operants calculation
// 00 Adder
// 01 Mul
// 10 Comp
// 11 Mux

module Comb_Logic_param
	#(parameter Dwidth=4)(
	input [Dwidth-1:0] X, Y,
	input [1:0] Inst,
	input Sel, 
	output reg [Dwidth-1:0] sum, Sel_out,
	output reg Cout, XEGY,
	output reg [2*Dwidth-1:0] Prod
	);

localparam Add = 2'b00;
localparam Mul = 2'b01;
localparam Comp = 2'b10;
localparam Mux = 2'b11;

always @(*)begin
	case (Inst)
		// Full Adder
		// Si = Xi*Ci_b + Yi*Ci_b + Ci-1*Ci_b + Xi*Yi*Ci-1
		// Ci = Xi*Yi + Yi*Ci-1 + Xi*Ci-1
		Add: {Cout, sum} = X+Y;
		// Mult
		Mul: Prod = X*Y;
		// Comparator
		Comp:
		begin
			if (X >= Y) XEGY = 1'b1;
			else XEGY = 1'b0;
		end
		Mux:
			if (Sel == 1'b1) Sel_out = X;
			else Sel_out = Y;
	endcase
end

endmodule
