`timescale 1ns/100ps
module pattern_det_tb;

reg clk, rst;
reg [23:0] data;
wire in, moore_out, mealy_out;

assign in = data[23];

initial begin
	clk = 1'b0;
	rst = 1'b0;
	#2 rst = 1'b1;
	#30 rst = 1'b0;
	data = 20'b1100_1001_0000_1001_0100;
	#20000 $finish;
end

always #20 clk = ~clk;
always @(posedge clk)
	#2 data = {data[22:0], data[23]};

pattern_det U1(
	.in(in),
	.clk(clk),
	.rst(rst),
	.moore_out(moore_out),
	.mealy_out(mealy_out)
	);

endmodule