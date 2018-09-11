module top_module (
    input in,
    output out);
    assign out = in;
endmodule
module top_module (
    output out);
    assign out = 1'b0;
endmodule
module top_module (
    input in1,
    input in2,
    output out);
    assign out = ~(in1|in2);
endmodule
module top_module( 
    input a, b,
    output out_and,
    output out_or,
    output out_xor,
    output out_nand,
    output out_nor,
    output out_xnor,
    output out_anotb
);
    assign out_and = a&b;
    assign out_or = a|b;
    assign out_xor = a^b;
    assign out_nand = ~(a&b);
    assign out_nor = ~(a|b);
    assign out_xnor = ~(a^b);
    assign out_anotb = a&~b;
endmodule
module top_module ( 
    input p1a, p1b, p1c, p1d,
    output p1y,
    input p2a, p2b, p2c, p2d,
    output p2y );
    assign p1y = ~(p1a&p1b&p1c&p1d);
    assign p2y = ~(p2a&p2b&p2c&p2d);
endmodule
module top_module( 
    input x3,
    input x2,
    input x1,  // three inputs
    output f   // one output
);
    assign f = (x3&~x2&x1)|(~x3&x2)|(x2&x1);
endmodule
module top_module ( input [1:0] A, input [1:0] B, output z ); 
    assign z = (A == B) ? 1'b1 : 1'b0;
endmodule

module top_module (input x, input y, output z);
    wire z1, z2, z3, z4;
    mod_A IA1 (x, y, z1);
    mod_B IB1 (x, y, z2);
    mod_A IA2 (x, y, z3);
    mod_B IB2 (x, y, z3);
    assign z = (z1|z2) ^ (z3&z4);
endmodule

module mod_A (input x, input y, output z);
    assign z = (x^y)&x;
endmodule
module mod_B ( input x, input y, output z );
    assign z = ~(x^y);
endmodule

module top_module (
    input ring,
    input vibrate_mode,
    output ringer,       // Make sound
    output motor         // Vibrate
);
    // always @(*)begin
    //     ringer = 0;
    //     motor = 0;
    //     if (ring)
    //         if (vibrate_mode)
    //             motor = 1;
    //         else
    //             ringer = 1;
    // end
    // When should ringer be on? When (phone is ringing) and (phone is not in vibrate mode)
    assign ringer = ring & ~vibrate_mode;
    
    // When should motor be on? When (phone is ringing) and (phone is in vibrate mode)
    assign motor = ring & vibrate_mode;
endmodule

module top_module (
    input too_cold,
    input too_hot,
    input mode,
    input fan_on,
    output heater,
    output aircon,
    output fan
); 
    assign heater = too_cold & mode;
    assign aircon = too_hot & ~mode;
    assign fan = heater | aircon | fan_on;
endmodule

module top_module( 
    input [99:0] in,
    output [98:0] out_both,
    output [99:1] out_any,
    output [99:0] out_different );
    assign out_both[98:0] = in[99:1] & in[98:0];
    assign out_any[99:1] = in[99:1] | in[98:0];
    assign out_different[99:0] = in[99:0] ^ {in[0], in[99:1]};
endmodule

