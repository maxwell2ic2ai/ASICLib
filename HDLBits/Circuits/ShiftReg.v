module top_module(
    input clk,
    input areset,  // async active-high reset to zero
    input load,
    input ena,
    input [3:0] data,
    output reg [3:0] q); 
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            q <= 4'h0;
        end
        else if (load) begin
            q <= data;
        end
        else if (ena) begin
            q <= {1'b0, q[3:1]};
        end
    end
endmodule

module top_module(
    input clk,
    input load,
    input [1:0] ena,
    input [99:0] data,
    output reg [99:0] q); 
    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end
        else begin
            case (ena)
             2'b01: q <= {q[0], q[99:1]};
             2'b10: q <= {q[98:0], q[99]};
             default: q <= q;
            endcase
        end
    end
endmodule

// A 5-bit number 11000 arithmetic right-shifted by 1 is 11100, while a logical right shift would produce 01100.
// Similarly, a 5-bit number 01000 arithmetic right-shifted by 1 is 00100, and a logical right shift would produce the same result, because the original number was non-negative.
module top_module(
    input clk,
    input load,
    input ena,
    input [1:0] amount,
    input [63:0] data,
    output reg [63:0] q); 
    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end
        else begin
            case (amount)
             2'b00: q <= {q[62:0], q[0]};
             2'b01: q <= {q[55:0], {8{q[0]}}};
             2'b10: q <= {q[63], q[63:1]};
             2'b11: q <= {{8{q[63]}}, q[63:8]};
            endcase
        end
    end
endmodule

// A linear feedback shift register is a shift register usually with a few XOR gates to produce the next state of the shift register. A Galois LFSR is one particular arrangement where bit positions with a "tap" are XORed with the output bit to produce its next value, while bit positions without a tap shift. If the taps positions are carefully chosen, the LFSR can be made to be "maximum-length". A maximum-length LFSR of n bits cycles through 2n-1 states before repeating (the all-zero state is never reached).
module top_module(
    input            clk,
    input            reset, // Active-high synchronous reset to 5'h1
    output reg [4:0] q
                  );
always @(posedge clk)begin
    if (reset) q <= 5'b0;
    else q[4:0] <= {1'b0^q[0], q[4], q[3]^q[0], q[2], q[1]};
end
endmodule // top_module

module top_module (
	input [2:0]  SW, // R
	input [1:0]  KEY, // L and clk
	output [2:0] LEDR
                   );
always @(posedge KEY[0])begin
    if (KEY[1]) LEDR <= SW;
    else LEDR <= {LEDR[2]^LEDR[1], LEDR[0], LEDR[2]};
end
endmodule // top_module

module top_module(
    input         clk,
    input         reset, // Active-high synchronous reset to 32'h1
    output [31:0] q);

always @(posedge clk)begin
    if (reset) q <= 32'h1;
    else q[31:0] <= (q>>1) ^ ({32{q[0]}} & 32'h80200003);
end
endmodule // top_module

module top_module (
    input clk,
    input resetn,   // synchronous reset
    input in,
    output out);
    reg [3:0] cnt;
always @(posedge clk)begin
    if (~resetn) cnt <= 4'h0;
    else cnt <= {cnt[3:0], in};
end
    assign out = cnt[3];

endmodule


module top_module (
    input [3:0] SW,
    input [3:0] KEY,
    output [3:0] LEDR
                   );
    MUXDFF U1 (KEY[0], KEY[1], KEY[2], KEY[3], SW, LEDR);
endmodule

module MUXDFF (
 input            clk,
 input            E,
 input            L,
 input            w,
 input [3:0]      R,
 output reg [3:0] Q
               );
always @(posedge clk)begin
  if(L) Q <= R;
    else if(E) Q <= {w, Q[3:1]};
end
endmodule

module top_module (
    input  clk,
    input  enable,
    input  S,
    input  A, B, C,
    output Z 
                   );
    reg [7:0] Q;
always @(posedge clk)begin
    if (enable) Q <= {Q[6:0], S};
    else Q <= Q;
end
always @(*)begin

	// Create a 8-to-1 mux that chooses one of the bits of q based on the three-bit number {A,B,C}:
	// There are many other ways you could write a 8-to-1 mux
	// (e.g., combinational always block -> case statement with 8 cases).
	// assign Z = q[ {A, B, C} ];
case ({A, B, C})
  3'b000: Z = Q[0];
  3'b001: Z = Q[1];
  3'b010: Z = Q[2];
  3'b011: Z = Q[3];
  3'b100: Z = Q[4];
  3'b101: Z = Q[5];
  3'b110: Z = Q[6];
  3'b111: Z = Q[7];
endcase
end
endmodule
