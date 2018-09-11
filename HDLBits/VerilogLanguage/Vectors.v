// vector basics
module top_module(
    input [2:0] vec, 
    output [2:0] outv,
    output o2,
    output o1,
    output o0
);
    
    assign outv = vec;

    // This is ok too: assign {o2, o1, o0} = vec;
    assign o0 = vec[0];
    assign o1 = vec[1];
    assign o2 = vec[2];
    
endmodule

// vector part selection
module top_module (
    input [15:0] in,
    output [7:0] out_hi,
    output [7:0] out_lo
);
    
    assign out_hi = in[15:8];
    assign out_lo = in[7:0];
    
    // Concatenation operator also works: assign {out_hi, out_lo} = in;
    
endmodule

// bitwise operation
module top_module(
    input [2:0] a, 
    input [2:0] b, 
    output [2:0] out_or_bitwise,
    output out_or_logical,
    output [5:0] out_not
);
    
    assign out_or_bitwise = a | b;
    assign out_or_logical = a || b;

    assign out_not[2:0] = ~a;   // Part-select on left side is o.
    assign out_not[5:3] = ~b;   //Assigning to [5:3] does not conflict with [2:0]
    // assign out_not = {~b, ~a};
    
endmodule

module top_module( 
    input [3:0] in,
    output out_and,
    output out_or,
    output out_xor
);
    assign out_and = &in;
    assign out_or = |in;
    assign out_xor = ^in;

endmodule

// vector concatenation operation
module top_module (
    input [7:0] in,
    output [7:0] out
);
    
    assign {out[0],out[1],out[2],out[3],out[4],out[5],out[6],out[7]} = in;
    
    /*
    // I know you're dying to know how to use a loop to do this:

    // Create a combinational always block. This creates combinational logic that computes the same result
    // as sequential code. for-loops describe circuit *behaviour*, not *structure*, so they can only be used 
    // inside procedural blocks (e.g., always block).
    // The circuit created (wires and gates) does NOT do any iteration: It only produces the same result
    // AS IF the iteration occurred. In reality, a logic synthesizer will do the iteration at compile time to
    // figure out what circuit to produce. (In contrast, a Verilog simulator will execute the loop sequentially
    // during simulation.)
    always @(*) begin   
        for (int i=0; i<8; i++) // int is a SystemVerilog type. Use integer for pure Verilog.
            out[i] = in[8-i-1];
    end


    // It is also possible to do this with a generate-for loop. Generate loops look like procedural for loops,
    // but are quite different in concept, and not easy to understand. Generate loops are used to make instantiations
    // of "things" (Unlike procedural loops, it doesn't describe actions). These "things" are assign statements,
    // module instantiations, net/variable declarations, and procedural blocks (things you can create when NOT inside 
    // a procedure). Generate loops (and genvars) are evaluated entirely at compile time. You can think of generate
    // blocks as a form of preprocessing to generate more code, which is then run though the logic synthesizer.
    // In the example below, the generate-for loop first creates 8 assign statements at compile time, which is then
    // synthesized.
    // Note that because of its intended usage (generating code at compile time), there are some restrictions
    // on how you use them. Examples: 1. Quartus requires a generate-for loop to have a named begin-end block
    // attached (in this example, named "my_block_name"). 2. Inside the loop body, genvars are read only.
    generate
        genvar i;
        for (i=0; i<8; i = i+1) begin: my_block_name
            assign out[i] = in[8-i-1];
        end
    endgenerate
    */
    
endmodule

module top_module (
    input [7:0] in,
    output [31:0] out
);

    // Concatenate two things together:
    // 1: {in[7]} repeated 24 times (24 bits)
    // 2: in[7:0] (8 bits)
    assign out = { {24{in[7]}}, in };
    
endmodule

module top_module (
    input a, b, c, d, e,
    output [24:0] out
);

    wire [24:0] top, bottom;
    assign top    = { {5{a}}, {5{b}}, {5{c}}, {5{d}}, {5{e}} };
    assign bottom = {5{a,b,c,d,e}};
    assign out = ~top ^ bottom; // Bitwise XNOR

    // This could be done on one line:
    // assign out = ~{ {5{a}}, {5{b}}, {5{c}}, {5{d}}, {5{e}} } ^ {5{a,b,c,d,e}};
    
endmodule
