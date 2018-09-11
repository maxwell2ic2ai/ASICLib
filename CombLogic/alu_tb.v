`timescale 1ns/100ps

module alu_tb;

reg [7:0] a,b;
reg [2:0] opcode;
wire [7:0] out;

localparam times=5;

alu U1(
    .out(out),
    .opcode(opcode),
    .a(a),
    .b(b)
    );

initial begin
	a = {$random}%256;
	b = {$random}%256;

	opcode=3'd0;
	repeat(times) begin
		#100 a = {$random}%256;
		     b = {$random}%256;
		     opcode = opcode+1;
	end
	#100 $finish;
end
endmodule

