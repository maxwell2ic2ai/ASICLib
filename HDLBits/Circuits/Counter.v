module top_module(
    input clk,
    input reset,
    output reg [3:0] q);
    
    always @(posedge clk)
        if (reset)
            q <= 4'b0;
        else
            q <= q+1;       // Because q is 4 bits, it rolls over from 15 -> 0.
        // If you want a counter that counts a range different from 0 to (2^n)-1, 
        // then you need to add another rule to reset q to 0 when roll-over should occur.
endmodule

module top_module (
    input clk,
    input reset,        // Synchronous active-high reset
    output [3:0] q);
    always @(posedge clk)begin
        if (reset)
            q <= 4'b0;
        else if (q == 9)
            q <= 4'b0;
        else
            q <= q+1;
    end
endmodule

module top_module (
    input clk,
    input reset,
    output [3:0] q);
    always @(posedge clk)begin
        if (reset)
            q <= 1;
        else if (q == 10)
            q <= 1;
        else
            q <= q+1;
    end
endmodule

module top_module (
    input clk,
    input slowena,
    input reset,
    output [3:0] q);
    always @(posedge clk)begin
        if (reset)
            q <= 0;
        else if (~slowena)
            q <= q;
        else if (q == 9)
            q <= 0;
        else
            q <= q+1;
    end
endmodule

module top_module (
    input clk,
    input reset,
    input enable,
    output [3:0] Q,
    output c_enable,
    output c_load,
    output [3:0] c_d
); //
    assign c_enable = enable;
    assign c_d = 4'd1;
    assign c_load = (reset||(Q==4'd12)) ? 1 : 0;

    count4 the_counter (clk, c_enable, c_load, c_d, Q );

endmodule

module top_module (
    input clk,
    input reset,
    output OneHertz,
    output [2:0] c_enable
); //
    wire [3:0] Q0, Q1, Q2;
    assign c_enable[0] = 1;
    assign c_enable[1] = (Q0==4'b1001) ? 1 : 0;
    assign c_enable[2] = (Q1==4'b1001) ? 1 : 0;
    bcdcount counter0 (clk, reset, c_enable[0], Q0);
    bcdcount counter1 (clk, reset, c_enable[1], Q1);
    bcdcount counter2 (clk, reset, c_enable[2], Q2);
    assign OneHertz = (Q2==4'b1001) ? 1 : 0;
endmodule
