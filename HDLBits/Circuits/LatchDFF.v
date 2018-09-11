module top_module(
    input clk,
    input d,
    output reg q);
    
    // Use non-blocking assignment for edge-triggered always blocks
    always @(posedge clk)
        q <= d;

    // Undefined simulation behaviour can occur if there is more than one edge-triggered
    // always block and blocking assignment is used. Which always block is simulated first?
    
endmodule

module top_module (
    input clk,
    input reset,            // Synchronous reset
    input [7:0] d,
    output [7:0] q
);
    always @(posedge clk)begin
        if (reset)
            q <= 8'b0;
        else
            q <= d;
    end
endmodule

// Create 8 D flip-flops with active high synchronous reset. The flip-flops must be reset to 0x34 rather than zero. All DFFs should be triggered by the negative edge of clk.
module top_module (
    input clk,
    input reset,
    input [7:0] d,
    output [7:0] q
);
    always @(negedge clk)begin
        if (reset)
            q <= 8'h34;
        else
            q <= d;
    end
endmodule

module top_module(
    input clk,
    input [7:0] d,
    input areset,
    output reg [7:0] q);
    
    // The only difference in code compared to synchronous reset is in the sensitivity list.
    always @(posedge clk, posedge areset)
        if (areset)
            q <= 0;
        else
            q <= d;


    // In Verilog, the sensitivity list looks strange. The FF's reset is sensitive to the
    // *level* of areset, so why does using "posedge areset" work?
    // To see why it works, consider the truth table for all events that change the input 
    // signals, assuming clk and areset do not switch at precisely the same time:
    
    //  clk     areset      output
    //   x       0->1       q <= 0; (because areset = 1)
    //   x       1->0       no change (always block not triggered)
    //  0->1       0        q <= d; (not resetting)
    //  0->1       1        q <= 0; (still resetting, q was 0 before too)
    //  1->0       x        no change (always block not triggered)
    
endmodule

// Latches are level-sensitive (not edge-sensitive) circuits, so in an always block, they use level-sensitive sensitivity lists.
// However, they are still sequential elements, so should use non-blocking assignments.
// A D-latch acts like a wire (or non-inverting buffer) when enabled, and preserves the current value when disabled.
module top_module (
    input d, 
    input ena,
    output q);
    always @(*)begin
        if (ena)
            q <= d;
    end
endmodule

module top_module (
    input clk,
    input L,
    input r_in,
    input q_in,
    output reg Q);
    always @(posedge clk)begin
        Q <= L ? r_in : q_in;
    end
endmodule

// A JK flip-flop has the below truth table. Implement a JK flip-flop with only a D-type flip-flop and gates. Note: Qold is the output of the D flip-flop before the positive clock edge.

// J   K   Q
// 0   0   Qold
// 0   1   0
// 1   0   1
// 1   1   ~Qold
module top_module (
    input clk,
    input j,
    input k,
    output Q); 
    always @(posedge clk)begin
        Q <= j^k ? j : (j&k ? ~Q : Q);
    end
endmodule

