`timescale 1ns/100ps

module sync_tb;
reg async_in, async_in_h2lck, bclk, rst;
wire sync_out, sync_out_h2lck;

sync U1(
	.async_in(async_in),
	.bclk(bclk),
	.rst(rst),
	.sync_out(sync_out)
	);

sync_h2lck U2(
	.async_in(async_in_h2lck),
	.bclk(bclk),
	.rst(rst),
	.sync_out(sync_out_h2lck)
	);

initial begin
	#2000 $finish;
end

initial begin
	bclk = 0;
	#10 forever #20 bclk = ~bclk;
end

initial begin
	rst = 0;
	#5 rst = 1;
	#50 rst = 0;
end

initial begin
	async_in = 0;
	#105 async_in = 1;
		 async_in_h2lck = 1;
	#15  async_in_h2lck = 0;
	#50  async_in = 0;
end

endmodule