module top_module(
 input        clk,
 input        reset,
 input        data,
 output [3:0] count,
 output       counting,
 output       done,
 input        ack);

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
   assign done = (state == Wait);
   assign counting = (state == Count);

   reg [3:0] delay;
   always @ (posedge clk) begin
       if (reset) delay <= 4'h0;
       else begin
           case (state)
             B0: delay[3] <= data;
             B1: delay[2] <= data;
             B2: delay[1] <= data;
             B3: delay[0] <= data;
           endcase
       end
   end

   reg [9:0] cnt;
   reg       done_counting;
   always @ (posedge clk) begin
       if (reset) begin
           cnt <= 10'd0;
           done_counting <= 0;
       end
       else if (counting) begin
           if (cnt == (delay+1)*1000) begin
             cnt <= 10'd0;
             done_counting <= 1;
           end
           else cnt <= cnt+1;
       end
   end

   always @ (posedge clk) begin
       if (reset) cout <= 4'h0;
       else if (counting) cout <= cnt / 1000;
   end
endmodule
