module top_module(
    input a,
    input b,
    input c,
    output out  ); 
    //assign out = a | b | c;
    assign out = ~(~a&~b&~c);
endmodule

module top_module(
    input a,
    input b,
    input c,
    input d,
    output out  ); 
    assign out = (~a&b&~c&~d) | (a&~b&~c&~d) | (~a&~b&~c&d) | (a&b&~c&d) | (~a&b&c&d) | (a&~b&c&d) | (~a&~b&c&~d) | (a&b&c&~d);
endmodule

// A single-output digital system with four inputs (a,b,c,d) generates a logic-1 when 2, 7, or 15 appears on the inputs, and a logic-0 when 0, 1, 4, 5, 6, 9, 10, 13, or 14 appears. The input conditions for the numbers 3, 8, 11, and 12 never occur in this system. For example, 7 corresponds to a,b,c,d being set to 0,1,1,1, respectively.
module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
); 
    assign out_sop = (~a&~b&c&~d) | (b&c&d);
    assign out_pos = b&(~b+d);
endmodule

module top_module (
    input c,
    input d,
    output [3:0] mux_in
);
    
    // After knowing how to split the truth table into four columns,
    // the rest of this question involves implementing logic functions
    // using only multiplexers (no other gates).
    // I will use the conditional operator for each 2-to-1 mux: (s ? a : b)
    assign mux_in[0] = (c ? 1 : (d ? 1 : 0));   // 2 muxes: c|d
    assign mux_in[1] = 0;                       // No muxes:  0
    assign mux_in[2] = d ? 0 : 1;               // 1 mux:    ~d
    assign mux_in[3] = c ? (d ? 1 : 0) : 0;     // 2 muxes: c&d
    
endmodule