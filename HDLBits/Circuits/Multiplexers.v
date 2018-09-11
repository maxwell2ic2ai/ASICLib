module top_module( 
    input a, b, sel,
    output out ); 
    assign out = sel ? a : b;
endmodule

module top_module( 
    input [15:0] a, b, c, d, e, f, g, h, i,
    input [3:0] sel,
    output [15:0] out );
    always @(*)begin
        case(sel)
            0: out = a;
            1: out = b;
            2: out = c;
            3: out = d;
            4: out = e;
            5: out = f;
            6: out = g;
            7: out = h;
            8: out = i;
            default: out = 16'hffff;
        endcase
    end
endmodule

// Vector indices can be variable, as long as the synthesizer can figure out that the width of the bits being selected is constant. In particular, selecting one bit out of a vector using a variable index will work.
module top_module (
    input [255:0] in,
    input [7:0] sel,
    output  out
);
    // Select one bit from vector in[]. The bit being selected can be variable.
    assign out = in[sel];   
endmodule

module top_module (
    input [1023:0] in,
    input [7:0] sel,
    output [3:0] out
);

    // We can't part-select multiple bits without an error, but we can select one bit at a time,
    // four times, then concatenate them together.
    assign out = {in[sel*4+3], in[sel*4+2], in[sel*4+1], in[sel*4+0]};
    // Vector indices can be variable, as long as the synthesizer can figure out that the width of the bits being selected is constant. It's not always good at this. An error saying "... is not a constant" means it couldn't prove that the select width is constant. In particular, in[ sel*4+3 : sel*4 ] does not work.

    // Alternatively, "indexed vector part select" works better, but has an unfamiliar syntax:
    // assign out = in[sel*4 +: 4];     // Select starting at index "sel*4", then select a total width of 4 bits with increasing (+:) index number.
    // assign out = in[sel*4+3 -: 4];   // Select starting at index "sel*4+3", then select a total width of 4 bits with decreasing (-:) index number.
    // Note: The width (4 in this case) must be constant.

endmodule

