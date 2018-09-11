`timescale 1ns/100ps

module fdiv_tb;

reg fin, rst;
wire fout;

fdiv #(
	.Ndiv(4)
	)
U1 (
	.fin(fin),
	.rst(rst),
	.fout(fout)
	);

initial begin
	rst = 1'b1;
	fin = 1'b0;
	#20 rst = 1'b0;
	#500 $finish; 
end

always #5 fin = ~fin;

endmodule