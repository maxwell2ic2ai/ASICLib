// Half adder
module top_module( 
    input a, b,
    output cout, sum );
    assign sum = a+b;
    assign cout = a&b;
endmodule

// Full adder
module top_module( 
    input a, b, cin,
    output cout, sum );
    assign sum = a^b^cin;
    assign cout = (a&b) | (a&cin) | (b&cin);
endmodule

// Ripple full adder
module top_module( 
    input [2:0] a, b,
    input cin,
    output [2:0] cout,
    output [2:0] sum );
    add1 U1(a[0], b[0], cin, sum[0], cout[0]);
    genvar i;
    generate
        for (i=1; i<3; i++)begin:label
            add1 U_add(a[i], b[i], cout[i-1], sum[i], cout[i]);
        end
    endgenerate
endmodule
module add1 ( input a, input b, input cin,   output sum, output cout );
    assign sum = a^b^cin;
    assign cout = (a&b)|(a&cin)|(b&cin);
endmodule

module top_module (
    input [3:0] x,
    input [3:0] y,
    output [4:0] sum
);

    // This circuit is a 4-bit ripple-carry adder with carry-out.
    assign sum = x+y;   // Verilog addition automatically produces the carry-out bit.

    // Verilog quirk: Even though the value of (x+y) includes the carry-out, (x+y) is still considered to be a 4-bit number (The max width of the two operands).
    // This is correct:
    // assign sum = (x+y);
    // But this is incorrect:
    // assign sum = {x+y};  // Concatenation operator: This discards the carry-out
endmodule

// A signed overflow occurs when adding two positive numbers produces a negative result, or adding two negative numbers produces a positive result. There are several methods to detect overflow: It could be computed by comparing the signs of the input and output numbers, or derived from the carry-out of bit n and n-1.
module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
); //
 
    assign s = a+b;
    assign overflow = (a[7]&b[7]&~s[7]) | (~a[7]&~b[7]&s[7]);
endmodule

module top_module (
    input [99:0] a,
    input [99:0] b,
    input cin,
    output cout,
    output [99:0] sum
);

    // The concatenation {cout, sum} is a 101-bit vector.
    assign {cout, sum} = a+b+cin;

endmodule

module top_module( 
    input [15:0] a, b,
    input cin,
    output cout,
    output [15:0] sum );
    reg cout_temp[3:0];
    bcd_fadd U1(a[3:0], b[3:0], cin, cout_temp[0], sum[3:0]);
    genvar i;
    generate
        for (i=1; i<4; i++)begin:label
            // Select starting at index "i*4", then select a total width of 4 bits with increasing (+:) index number.
            bcd_fadd U_add(a[i*4 +: 4], b[i*4 +: 4], cout_temp[i-1], cout_temp[i], sum[i*4 +: 4]);
        end
    endgenerate
    assign cout = cout_temp[3];
endmodule