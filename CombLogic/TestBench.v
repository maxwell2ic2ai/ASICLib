`timescale 1ns/100ps

module TestBench;

reg Astim, Bstim, Cstim, Dstim;
wire Xwatch, Ywatch, Zwatch;

Intro_Top Top1(
	.X(Xwatch),
	.Y(Ywatch),
	.Z(Zwatch),
	.A(Astim),
	.B(Bstim),
	.C(Cstim),
	.D(Dstim)
	);

initial
begin
	#1 Astim = 1'b0;
	#1 Bstim = 1'b0;
	#1 Cstim = 1'b0;
	#50 Dstim = 1'b1;
	#50 Astim = 1'b0;
	#50 Cstim = 1'b0;
	#50 Dstim = 1'b0;
	#50 $finish;
end


endmodule