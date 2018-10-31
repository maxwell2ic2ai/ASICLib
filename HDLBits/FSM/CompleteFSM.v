module top_module(
 input  clk,
 input  reset,
 input  data,
 output shift_ena,
 output counting,
 input  done_counting,
 output done,
 input  ack);

   localparam S     = 0;
   localparam S1    = 1;
   localparam S11   = 2;
   localparam S110  = 3;
   localparam B0    = 4;
   localparam B1    = 5;
   localparam B2    = 6;
   localparam B3    = 7;
   localparam Count = 8;
   localparam Wait  = 9;

   reg [5:0] state, state_next;
   always @ (posedge clk) begin
       if (reset) state <= S;
       else state <= state_next;
   end
   always @ (*) begin
       case (state)
         S: state_next = data ? S1 : S;
         S1: state_next = data ? S11 : S;
         S11: state_next = data ? S11 : S110;
         S110: state_next = data ? B0 : S;
         B0: state_next = B1;
         B1: state_next = B2;
         B2: state_next = B3;
         B3: state_next = Count;
         Count: state_next = done_counting ? Wait : Count;
         Wait: state_next = ack ? S : Wait;
       endcase
   end
   assign shift_ena = (state == B0) || (state == B1) || (state == B2) || (state == B3);
   assign counting = (state == Count);
   assign done = (state == Wait);
endmodule
