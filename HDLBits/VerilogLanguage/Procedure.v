// synthesis verilog_input_version verilog_2001
module top_module(
    input a, 
    input b,
    output wire out_assign,
    output reg out_alwaysblock
);
    assign out_assign = a&b;
    always @(*) begin
        out_alwaysblock = a&b;
    end

endmodule

// There are three types of assignments in Verilog:

// Continuous assignments (assign x = y;). Can only be used when not inside a procedure ("always block").
// Procedural blocking assignment: (x = y;). Can only be used inside a procedure.
// Procedural non-blocking assignment: (x <= y;). Can only be used inside a procedure.
// In a combinational always block, use blocking assignments. In a clocked always block, use non-blocking assignments.
// synthesis verilog_input_version verilog_2001
module top_module(
    input clk,
    input a,
    input b,
    output wire out_assign,
    output reg out_always_comb,
    output reg out_always_ff   );

    assign out_assign = a^b;
    always @(*)begin
        out_always_comb = a^b;
    end
    always @(posedge clk) begin
        out_always_ff <= a^b;
    end

endmodule

// synthesis verilog_input_version verilog_2001
module top_module(
    input a,
    input b,
    input sel_b1,
    input sel_b2,
    output wire out_assign,
    output reg out_always   ); 
    
    assign out_assign = (sel_b1&sel_b2) ? b : a;
    always @(*)begin
        if (sel_b1&sel_b2)
            out_always = b;
        else
            out_always = a;
    end
endmodule

// The following code contains incorrect behaviour that creates a latch. Fix the bugs so that you will shut off the computer only if it's really overheated, and stop driving if you've arrived at your destination or you need to refuel.
// synthesis verilog_input_version verilog_2001
module top_module (
    input      cpu_overheated,
    output reg shut_off_computer,
    input      arrived,
    input      gas_tank_empty,
    output reg keep_driving  ); //

    always @(*) begin
        if (cpu_overheated)
           shut_off_computer = 1;
        // else in always combinational block prevent latches
        else
            shut_off_computer = 0;
    end

    always @(*) begin
        if (~arrived)
           keep_driving = ~gas_tank_empty;
        // else in always combinational block prevent latches
        else
            keep_driving = 0;
    end
endmodule

// Case statements in Verilog are nearly equivalent to a sequence of if-elseif-else that compares one expression to a list of others. Its syntax and functionality differs from the switch statement in C.
// The case statement begins with case and each "case item" ends with a colon. There is no "switch".
// Each case item can execute exactly one statement. This makes the "break" used in C unnecessary. But this means that if you need more than one statement, you must use begin ... end.
// Duplicate (and partially overlapping) case items are permitted. The first one that matches is used. C does not allow duplicate case items.
// synthesis verilog_input_version verilog_2001
module top_module ( 
    input [2:0] sel, 
    input [3:0] data0,
    input [3:0] data1,
    input [3:0] data2,
    input [3:0] data3,
    input [3:0] data4,
    input [3:0] data5,
    output reg [3:0] out   );//

    always@(*) begin  // This is a combinational circuit
        case(sel)
            0: out = data0;
            1: out = data1;
            2: out = data2;
            3: out = data3;
            4: out = data4;
            5: out = data5;
            default: data = 0;
        endcase
    end
endmodule

// A priority encoder is a combinational circuit that, when given an input bit vector, outputs the position of the first 1 bit in the vector. For example, a 8-bit priority encoder given the input 8'b10010000 would output 3'd4, because bit[4] is first bit that is high.
module top_module (
    input [3:0] in,
    output reg [1:0] pos  );
    always @(*)begin
        case(in)
         4'h0: pos = 2'd0;
         4'h1: pos = 2'd0;
         4'h2: pos = 2'd1;
         4'h3: pos = 2'd0;
         4'h4: pos = 2'd2;
         4'h5: pos = 2'd0;
         4'h6: pos = 2'd1;
         4'h7: pos = 2'd0;
         4'h8: pos = 2'd3;
         4'h9: pos = 2'd0;
         4'ha: pos = 2'd1;
         4'hb: pos = 2'd0;
         4'hc: pos = 2'd2;
         4'hd: pos = 2'd0;
         4'he: pos = 2'd1;
         4'hf: pos = 2'd0;
        endcase
    end
endmodule

module top_module (
    input [7:0] in,
    output reg [2:0] pos  );
    always @(*) begin
        casez (in[7:0])
        8'bzzzzzzz1: pos = 0;
        8'bzzzzzz1z: pos = 1;
        8'bzzzzz1zz: pos = 2;
        8'bzzzz1zzz: pos = 3;
        8'bzzz1zzzz: pos = 4;
        8'bzz1zzzzz: pos = 5;
        8'bz1zzzzzz: pos = 6;
        8'b1zzzzzzz: pos = 7;   
        default pos = 0;
    endcase
    end
endmodule

// To avoid creating latches, all outputs must be assigned a value in all possible conditions. Simply having a default case is not enough. You must assign a value to all four outputs in all four cases and the default case. This can involve a lot of unnecessary typing. One easy way around this is to assign a "default value" to the outputs before the case statement:

// always @(*) begin
//     up = 1'b0; down = 1'b0; left = 1'b0; right = 1'b0;
//     case (scancode)
//         ... // Set to 1 as necessary.
//     endcase
// end
// This style of code ensures the outputs are assigned a value (of 0) in all possible cases unless the case statement overrides the assignment. This also means that a default: case item becomes unnecessary.
module top_module (
    input [15:0] scancode,
    output reg left,
    output reg down,
    output reg right,
    output reg up  ); 
    always @(*)begin
        up = 1'b0;
        down = 1'b0;
        left = 1'b0;
        right = 1'b0;
        case(scancode)
            16'he06b: left = 1'b1;
            16'he072: down = 1'b1;
            16'he074: right = 1'b1;
            16'he075: up = 1'b1;
        endcase
    end
endmodule

