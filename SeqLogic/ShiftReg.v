module ShiftReg(
	input Din, shift_ena, clk, rst,
	output Qout
	);

reg [4:0] Qreg;

always @(posedge clk or posedge rst) begin
	if (rst) begin
		Qreg <= 5'b0;	// reset
	end
	else begin
		Qreg[0] <= (shift_ena == 1'b1)? Din     : Qreg[0];
		Qreg[1] <= (shift_ena == 1'b1)? Qreg[0] : Qreg[1];
		Qreg[2] <= (shift_ena == 1'b1)? Qreg[1] : Qreg[2];
		Qreg[3] <= (shift_ena == 1'b1)? Qreg[2] : Qreg[3];
		Qreg[4] <= (shift_ena == 1'b1)? Qreg[3] : Qreg[4];		
	end
end

assign Qout = Qreg[4];

endmodule