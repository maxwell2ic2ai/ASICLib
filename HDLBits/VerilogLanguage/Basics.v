// simple wire
module top_module( input in, output out );
    assign out = in;
    // Note that wires are directional, so "assign in = out" is not equivalent. 
endmodule

// not gate
module top_module(
    input in,
    output out
);    
    assign out = ~in;  
endmodule

// and gate
module top_module( 
    input a, 
    input b, 
    output out );
    assign out = a&b;
endmodule

// xnor gate
module top_module( 
    input a, 
    input b, 
    output out );
    assign out = ~(a^b);
endmodule