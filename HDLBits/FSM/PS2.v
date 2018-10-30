module top_module (
 input       clk,
 input [7:0] in,
 input       reset,
 output      done);

   localparam BYTE1 = 1;
   localparam BYTE2 = 2;
   localparam BYTE3 = 3;
   localparam DONE = 0;

   reg [1:0] state, state_next;
   always @ (posedge clk, posedge reset) begin
       if (reset) state <= BYTE1;
       else state <= state_next;
   end
   always @ (*) begin
       case (state)
         BYTE1: state_next = in[3] ? BYTE2 : BYTE1;
         BYTE2: state_next = BYTE3;
         BYTE3: state_next = DONE;
         DONE : state_next = in[3] ? BYTE2 : BYTE1;
       endcase
   end
   assign done = (state == DONE);
endmodule


module top_module (
                   input         clk,
                   input [7:0]   in,
                   input         reset,
                   output [23:0] out_bytes,
                   output        done);

   localparam BYTE1 = 1;
   localparam BYTE2 = 2;
   localparam BYTE3 = 3;
   localparam DONE = 0;

   reg [1:0]                   state, state_next;
   always @ (posedge clk, posedge reset) begin
       if (reset) state <= BYTE1;
       else state <= state_next;
   end
   always @ (*) begin
       case (state)
         BYTE1: state_next = in[3] ? BYTE2 : BYTE1;
         BYTE2: state_next = BYTE3;
         BYTE3: state_next = DONE;
         DONE : state_next = in[3] ? BYTE2 : BYTE1;
       endcase
   end
   assign done = (state == DONE);

   reg [23:0] out_reg;
   always @ (*) begin
       case (state)
         BYTE1: out_reg[23:16] = in;
         BYTE2: out_reg[15:8]  = in;
         BYTE3: out_reg[7:0]   = in;
       endcase
   end
   assign out_bytes = (state == DONE) ? out_reg : 24'hzzzzzz;
endmodule
