module top_module(
 input  clk,
 input  in,
 input  reset,
 output done);

   localparam IDLE = 0;
   localparam START = 1;
   localparam D0 = 2;
   localparam D1 = 3;
   localparam D2 = 4;
   localparam D3 = 5;
   localparam D4 = 6;
   localparam D5 = 7;
   localparam D6 = 8;
   localparam D7 = 9;
   localparam STOP = 10;

   reg [5:0] state, state_next;
   always @ (posedge clk) begin
       if (reset) state <= IDLE;
       else state <= state_next;
   end
   always @ (*) begin
       case (state)
         IDLE: state_next = in ? IDLE : START;
         START: state_next = D0;
         D0: state_next = D1;
         D1: state_next = D2;
         D2: state_next = D3;
         D3: state_next = D4;
         D4: state_next = D5;
         D5: state_next = D6;
         D6: state_next = D7;
         D7: state_next = in ? STOP : IDLE;
         STOP: state_next = in ? IDLE : START;
         default state_next = IDLE;
       endcase
   end
   assign done = (state == STOP);
endmodule



module top_module(
                  input        clk,
                  input        in,
                  input        reset,
                  output       done,
                  output [7:0] out_byte);

   localparam IDLE = 0;
   localparam START = 1;
   localparam D0 = 2;
   localparam D1 = 3;
   localparam D2 = 4;
   localparam D3 = 5;
   localparam D4 = 6;
   localparam D5 = 7;
   localparam D6 = 8;
   localparam D7 = 9;
   localparam STOP = 10;

   reg [5:0]             state, state_next;
   always @ (posedge clk) begin
       if (reset) state <= IDLE;
       else state <= state_next;
   end
   always @ (*) begin
       case (state)
         IDLE: state_next = in ? IDLE : START;
         START: state_next = D0;
         D0: state_next = D1;
         D1: state_next = D2;
         D2: state_next = D3;
         D3: state_next = D4;
         D4: state_next = D5;
         D5: state_next = D6;
         D6: state_next = D7;
         D7: state_next = in ? STOP : IDLE;
         STOP: state_next = in ? IDLE : START;
         default state_next = IDLE;
       endcase
   end
   assign done = (state == STOP);

   reg [7:0] out_reg;
   always @ (*) begin
       case (state)
         D0: out_reg[0] = in;
         D1: out_reg[1] = in;
         D2: out_reg[2] = in;
         D3: out_reg[3] = in;
         D4: out_reg[4] = in;
         D5: out_reg[5] = in;
         D6: out_reg[6] = in;
         D7: out_reg[7] = in;
       endcase
   end
   assign out_byte = done ? out_reg : 8'hzz;
endmodule



module top_module(
                  input        clk,
                  input        in,
                  input        reset,
                  output       done,
                  output [7:0] out_byte);

   localparam IDLE = 0;
   localparam START = 1;
   localparam D0 = 2;
   localparam D1 = 3;
   localparam D2 = 4;
   localparam D3 = 5;
   localparam D4 = 6;
   localparam D5 = 7;
   localparam D6 = 8;
   localparam D7 = 9;
   localparam PARITY = 10;

   reg [5:0]             state, state_next;
   always @ (posedge clk) begin
       if (reset) state <= IDLE;
       else state <= state_next;
   end
   always @ (*) begin
       case (state)
         IDLE: state_next = in ? IDLE : START;
         START: state_next = D0;
         D0: state_next = D1;
         D1: state_next = D2;
         D2: state_next = D3;
         D3: state_next = D4;
         D4: state_next = D5;
         D5: state_next = D6;
         D6: state_next = D7;
         D7: state_next = odd ? PARITY : IDLE;
         PARITY: state_next = in ? IDLE : START;
         default state_next = IDLE;
       endcase
   end
   assign done = (state == PARITY);

   reg [7:0] out_reg;
   always @ (*) begin
       case (state)
         D0: out_reg[0] = in;
         D1: out_reg[1] = in;
         D2: out_reg[2] = in;
         D3: out_reg[3] = in;
         D4: out_reg[4] = in;
         D5: out_reg[5] = in;
         D6: out_reg[6] = in;
         D7: out_reg[7] = in;
       endcase
   end
   assign out_byte = done ? out_reg : 8'hzz;

   parity U1 (clk, reset, in, odd);
endmodule
module parity(
 input  clk,
 input  reset,
 input  in,
 output odd);
   always @ (posedge clk) begin
       if (reset) odd <= 0;
       else if (in) odd <= ~odd;
   end
endmodule

