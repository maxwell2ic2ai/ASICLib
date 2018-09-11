//`define 4 4
`timescale 1ns/100ps

module Comb_Logic_param_tb;

	reg [4-1:0] X, Y;
	reg [1:0] Inst;
	reg Sel;
	wire [4-1:0] sum;
	wire Cout, XEGY, Sel_out;
	wire [2*4-1:0] Prod;

Comb_Logic_param
#(
	.Dwidth(4)
)
 U1(
	.X(X),
	.Y(Y),
	.Inst(Inst),
	.Sel(Sel),
	.sum(sum),
	.Cout(Cout),
	.XEGY(XEGY),
	.Sel_out(Sel_out),
	.Prod(Prod)
);

initial
begin
	X = 4'b0101;
	Y = 4'b0010;
	Sel = 1'b1;
	Inst = 2'b00;
	#5 Inst = 2'b01;
	#5 Inst = 2'b10;
	#5 Inst = 2'b11;

	#5 X = 4'b0011;
	#5 Y = 4'b1100;
	#5 Sel = 1'b0;
	#5 Inst = 2'b00;
	#5 Inst = 2'b01;
	#5 Inst = 2'b10;
	#5 Inst = 2'b11;
	
	#10 $finish;
end

endmodule