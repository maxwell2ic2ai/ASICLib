module top_module(
 input  clk,
 input  areset,
 input  x,
 output z);

   localparam A = 01;
   localparam B = 10;

   reg [1:0] state, state_next;
   always @ (posedge clk, posedge areset) begin
       if (areset) state <= A;
       else state <= state_next;
   end
   always @ (*) begin
       case (state)
         A: begin
             state_next = x ? B : A;
             z = x;
         end
         B: begin
             state_next = B;
             z = ~x;
         end
       endcase
   end
endmodule
