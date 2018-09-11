`define PLUS 3'd0
`define MINUS 3'd1
`define BAND 3'd2
`define BOR 3'd3
`define BINV 3'd4

module alu(
	output reg [7:0] out,
	input [2:0] opcode,
	input [7:0] a,b
	);

always @(opcode, a, b) begin
	case(opcode)
		`PLUS: out = a+b;
		`MINUS: out = a-b;
		`BAND: out = a&b;
		`BOR: out = a|b;
		`BINV: out = ~out;
		default: out = 8'hx;
	endcase
end

endmodule