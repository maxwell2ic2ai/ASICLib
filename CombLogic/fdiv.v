module fdiv
	#(parameter Ndiv = 2)(
	input fin, rst,
	output reg fout	
	);

reg [7:0] cnt;

always @(posedge fin or posedge rst) begin
	if (rst) begin
//		fout <= 1'b0;
		cnt <= 8'b0;
	end
	else if (cnt == Ndiv) begin
		cnt <= 8'b0;
//		fout <= ~fout;
	end
	else cnt <= cnt+1;
end

always @(posedge fin or posedge rst) begin
	if (rst) begin
		fout <= 1'b0;
	end
	else if (cnt == Ndiv) begin
		fout <= ~fout;
	end
end

endmodule