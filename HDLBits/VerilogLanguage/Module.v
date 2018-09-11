// shift register
module top_module ( input clk, input d, output q );
    wire q1, q2;
    my_dff U1(
        .clk(clk),
        .d(d),
        .q(q1)
    );
    my_dff U2(
        .clk(clk),
        .d(q1),
        .q(q2)
    );
    my_dff U3(
        .clk(clk),
        .d(q2),
        .q(q)
    );

endmodule

// shift register8
module top_module ( 
    input clk, 
    input [7:0] d, 
    input [1:0] sel, 
    output [7:0] q 
);
    wire [7:0] q1, q2, q3;

    my_dff8 U1(
        .clk(clk),
        .d(d),
        .q(q1)
    );
    my_dff8 U2(
        .clk(clk),
        .d(q1),
        .q(q2)
    );
    my_dff8 U3(
        .clk(clk),
        .d(q2),
        .q(q3)
    );

    always @(*) begin
        case(sel)
            0: q = d;
            1: q = q1;
            2: q = q2;
            3: q = q3;
        endcase
    end

endmodule

// adder1
module top_module(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);
    wire cout1;
    wire [15:0] sum1, sum2;

    add16 U1(
        .a(a[15:0]),
        .b(b[15:0]),
        .sum(sum1),
        .cin(1'b0),
        .cout(cout1)
        );
    add16 U2(
        .a(a[31:16]),
        .b(b[31:16]),
        .sum(sum2),
        .cin(cout1)
        );
    assign sum = {sum2, sum1};
endmodule

// full adder
module top_module (
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);
    wire cout1;
    wire [15:0] sum1, sum2;
    my_add16 U1(
        .a(a[15:0]),
        .b(b[15:0]),
        .sum(sum1),
        .cin(1'b0),
        .cout(cout1)
        );
    add16 U2(
        .a(a[31:16]),
        .b(b[31:16]),
        .sum(sum2),
        .cin(cout1)
        );
    assign sum = {sum2, sum1};
endmodule

module add1 ( input a, input b, input cin,   output sum, output cout );
    assign sum = a^b^cin;
    assign cout = (a&b)|(a&cin)|(b&cin);
endmodule

module my_add16 ( input[15:0] a, input[15:0] b, input cin, output[15:0] sum, output cout );
    wire [15:0] cout_temp;
    add1 U0 (a[0 ], b[0 ], cin,           sum[0 ], cout_temp[0 ]);
    add1 U1 (a[1 ], b[1 ], cout_temp[0 ], sum[1 ], cout_temp[1 ]);
    add1 U2 (a[2 ], b[2 ], cout_temp[1 ], sum[2 ], cout_temp[2 ]);
    add1 U3 (a[3 ], b[3 ], cout_temp[2 ], sum[3 ], cout_temp[3 ]);
    add1 U4 (a[4 ], b[4 ], cout_temp[3 ], sum[4 ], cout_temp[4 ]);
    add1 U5 (a[5 ], b[5 ], cout_temp[4 ], sum[5 ], cout_temp[5 ]);
    add1 U6 (a[6 ], b[6 ], cout_temp[5 ], sum[6 ], cout_temp[6 ]);
    add1 U7 (a[7 ], b[7 ], cout_temp[6 ], sum[7 ], cout_temp[7 ]);
    add1 U8 (a[8 ], b[8 ], cout_temp[7 ], sum[8 ], cout_temp[8 ]);
    add1 U9 (a[9 ], b[9 ], cout_temp[8 ], sum[9 ], cout_temp[9 ]);
    add1 U10(a[10], b[10], cout_temp[9 ], sum[10], cout_temp[10]);
    add1 U11(a[11], b[11], cout_temp[10], sum[11], cout_temp[11]);
    add1 U12(a[12], b[12], cout_temp[11], sum[12], cout_temp[12]);
    add1 U13(a[13], b[13], cout_temp[12], sum[13], cout_temp[13]);
    add1 U14(a[14], b[14], cout_temp[13], sum[14], cout_temp[14]);
    add1 U15(a[15], b[15], cout_temp[14], sum[15], cout_temp[15]);
    assign cout = cout_temp[15];
endmodule

// look-ahead adder
module top_module(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);
    wire cout_lo;
    wire [15:0] sum_lo, sum_hi0, sum_hi1, sum_hi;

    add16 U1(
        .a(a[15:0]),
        .b(b[15:0]),
        .sum(sum_lo),
        .cin(1'b0),
        .cout(cout_lo)
        );
    add16 U2(
        .a(a[31:16]),
        .b(b[31:16]),
        .sum(sum_hi0),
        .cin(1'b0)
        );
    add16 U3(
       .a(a[31:16]),
       .b(b[31:16]),
       .sum(sum_hi1),
       .cin(1'b1)
       );
    assign sum_hi = cout_lo ? sum_hi1 : sum_hi0;
    assign sum = {sum_hi, sum_lo};

endmodule

// add sub
module top_module(
    input [31:0] a,
    input [31:0] b,
    input sub,
    output [31:0] result
);
    wire cout_lo;
    wire [15:0] sum_lo, sum_hi;
    wire [31:0] sub_b;

    add16 U1(
        .a(a[15:0]),
        .b(sub_b[15:0]),
        .sum(sum_lo),
        .cin(sub),
        .cout(cout_lo)
        );
    add16 U2(
        .a(a[31:16]),
        .b(sub_b[31:16]),
        .sum(sum_hi),
        .cin(cout_lo)
        );
    assign sub_b = {32{sub}}^b;
    assign result = {sum_hi, sum_lo};
endmodule

