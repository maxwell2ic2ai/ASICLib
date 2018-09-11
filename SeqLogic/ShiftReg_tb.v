`timescale 1ns/100ps

module ShiftReg_tb;

reg Din, shift_ena, clk, rst;
wire Qout;

ShiftReg shift_U1(
	.Din(Din),
	.shift_ena(shift_ena),
	.clk(clk),
	.rst(rst),
	.Qout(Qout)
	);

always #1 clk = ~clk;
always begin
	#3.2 Din = ~Din;
	#1.8 Din = 0;
end

initial begin
	Din = 1'b0;
	shift_ena = 1'b0;
	clk = 1'b1;
	rst = 1'b1;

	#5 shift_ena = 1'b1;
	#180 rst = 1'b0;
	#200 $finish;
end

endmodule