// Verilog has a ternary conditional operator ( ? : ) much like C:

// (condition ? if_true : if_false)

// This can be used to choose one of two values based on condition (a mux!) on one line, without using an if-then inside a combinational always block.

// Examples:

// (0 ? 3 : 5)     // This is 5 because the condition is false.
// (sel ? b : a)   // A 2-to-1 multiplexer between a and b selected by sel.

// always @(posedge clk)         // A T-flip-flop.
//   q <= toggle ? ~q : q;

// always @(*)                   // State transition logic for a one-input FSM
//   case (state)
//     A: next = w ? B : A;
//     B: next = w ? A : B;
//   endcase

// assign out = ena ? q : 1'bz;  // A tri-state buffer

// ((sel[1:0] == 2'h0) ? a :     // A 3-to-1 mux
//  (sel[1:0] == 2'h1) ? b :
//                       c )
module top_module (
    input [7:0] a, b, c, d,
    output [7:0] min);//
    wire [7:0] min1, min2;
    // assign intermediate_result1 = compare? true: false;
    assign min1 = (a<b) ? a : b;
    assign min2 = (c<d) ? c : d;
    assign min = (min1<min2) ? min1 : min2;

endmodule

// The reduction operators can do AND, OR, and XOR of the bits of a vector, producing one bit of output:

// & a[3:0]     // AND: a[3]&a[2]&a[1]&a[0]. Equivalent to (a[3:0] == 4'hf)
// | b[3:0]     // OR:  b[3]|b[2]|b[1]|b[0]. Equivalent to (b[3:0] != 4'h0)
// ^ c[2:0]     // XOR: c[2]^c[1]^c[0]
// These are unary operators that have only one operand (similar to the NOT operators ! and ~). You can also invert the outputs of these to create NAND, NOR, and XNOR gates, e.g., (~& d[7:0]).
// Parity checking is often used as a simple method of detecting errors when transmitting data through an imperfect channel. Create a circuit that will compute a parity bit for a 8-bit byte (which will add a 9th bit to the byte). We will use "even" parity, where the parity bit is just the XOR of all 8 data bits.
module top_module (
    input [7:0] in,
    output parity); 
    assign parity = ^in[7:0];
endmodule

module top_module( 
    input [99:0] in,
    output out_and,
    output out_or,
    output out_xor 
);
    assign out_and = &in[99:0];
    assign out_or = |in[99:0];
    assign out_xor = ^in[99:0];
endmodule

module top_module( 
    input [99:0] in,
    output [99:0] out
);
    always @(*) begin   
        for (integer i=0; i<100; i++) // int is a SystemVerilog type. Use integer for pure Verilog.
            out[i] = in[100-i-1];
    end
endmodule

module top_module (
    input [254:0] in,
    output reg [7:0] out
);

    always @(*) begin   // Combinational always block
        out = 0;
        for (int i=0;i<255;i++)
            out = out + in[i];
    end  
endmodule

// generate genvar
module top_module( 
    input [99:0] a, b,
    input cin,
    output [99:0] cout,
    output [99:0] sum );
    add1 U1(a[0], b[0], cin, sum[0], cout[0]);
    genvar i;
    generate
        for (i=1; i<100; i++)begin:instantiate // generate for loop must with begin/end and label
            add1 U_ADD(a[i], b[i], cout[i-1], sum[i], cout[i]);
        end
    endgenerate
endmodule

module add1 ( input a, input b, input cin,   output sum, output cout );
    assign sum = a^b^cin;
    assign cout = (a&b)|(a&cin)|(b&cin);
endmodule

// module top_module( 
//     input [399:0] a, b,
//     input cin,
//     output cout,
//     output [399:0] sum );
//     reg [99:0] cout_temp;
//     bcd_fadd U1(a[3:0], b[3:0], cin, sum[3:0], cout_temp[0]);
//     genvar i, j;
//     generate
//         for (i=1; i<100; i=i+1)begin:instantiate // generate for loop must with begin/end and label
//             j = 4*i;
//             add1 U_ADD(a[j+3+j], b[j+3:j], cout_temp[i-1], sum[j+3:j], cout_temp[i]);
//         end
//     endgenerate
//     assign cout = cout_temp[99];
// endmodule
