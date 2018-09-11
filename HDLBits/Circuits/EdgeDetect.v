// For each bit in an 8-bit vector, detect when the input signal changes from 0 in one clock cycle to 1 the next (similar to positive edge detection). The output bit should be set the cycle after a 0 to 1 transition occurs.
module top_module (
    input clk,
    input [7:0] in,
    output [7:0] pedge
);
    reg [7:0] in_reg1, in_reg2;
    always @(posedge clk)begin
        in_reg1 <= in;
        in_reg2 <= in_reg1;
    end
    assign pedge = ~in_reg2&in_reg1;
endmodule

module top_module (
    input clk,
    input [7:0] in,
    output [7:0] anyedge
);
    reg [7:0] in_reg1;
    always @(posedge clk)begin
        in_reg1 <= in;
        anyedge <= in^in_reg1;
    end
endmodule

// For each bit in a 32-bit vector, capture when the input signal changes from 1 in one clock cycle to 0 the next. "Capture" means that the output will remain 1 until the register is reset (synchronous reset). The output bit should be set the cycle after a 1 to 0 transition occurs. If reset occurs in the same cycle as when an output bit would be set to 1, reset has precedence.
module top_module (
    input clk,
    input reset,
    input [31:0] in,
    output [31:0] out
);
    reg [31:0] in_reg1;
    always @(posedge clk)begin
        in_reg1 <= in;
        if (reset)begin
            out <= 0;
        end
        else begin
            out <= (~in&in_reg1) | out;
        end
    end
endmodule
