`timescale 1ns/100ps

module FlipFlops_tb;

reg D, clk, rst, pst;
wire Qsimple, Qasyncrst, Qasyncpst;

FlipFlops FF_U1(
	.D(D),
	.clk(clk),
	.rst(rst),
	.pst(pst),
	.Qsimple(Qsimple),
	.Qasyncrst(Qasyncrst),
	.Qasyncpst(Qasyncpst)
	);

always #1 clk = ~clk;

initial begin
	#0
		clk = 1'b1;
		D = 1'b0;
		rst = 1'b0;
		pst = 1'b0;
	#1
		rst = 1'b1;
		pst = 1'b1;
	#2.5
		D = 1'b1;
	#5
		rst = 1'b0;
	#7.5
		pst = 1'b0;
	#10
		$finish;
end


endmodule
