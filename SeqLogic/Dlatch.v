module DLatch(
	input D, ena, rst, pst,
	output reg Qsimple, Qasyncrst, Qasyncpst
	);

always @(D, ena)
	if (ena == 1'b1)
		Qsimple <= D;

always @(D, ena, rst)begin
	if (rst == 1'b1)
		Qasyncrst <= 1'b0;
	else if (ena == 1'b1)
		Qasyncrst <= D;
end

always @(D, ena, rst, pst)begin
	if (rst == 1'b1)
		Qasyncpst <= 1'b0;
	else if (pst == 1'b1)
		Qasyncpst <= 1'b1;
	else if (ena == 1'b1)
		Qasyncpst <= D;
end

endmodule