module top_module(
 input  clk,
 input  reset,
 input  in,
 output disc,
 output flag,
 output err);

   localparam NONE = 0;
   localparam ONE = 1;
   localparam TWO = 2;
   localparam THREE = 3;
   localparam FOUR = 4;
   localparam FIVE = 5;
   localparam SIX = 6;
   localparam ERROR = 7;
   localparam DISCARD = 8;
   localparam FLAG = 9;

   reg [5:0] state, state_next;
   always @ (posedge clk) begin
       if (reset) state <= NONE;
       else state <= state_next;
   end
   always @ (*) begin
       case (state)
         NONE: state_next = in ? ONE : NONE;
         ONE : state_next = in ? TWO : NONE;
         TWO : state_next = in ? THREE : NONE;
         THREE : state_next = in ? FOUR : NONE;
         FOUR  : state_next = in ? FIVE : NONE;
         FIVE  : state_next = in ? SIX  : DISCARD;
         SIX   : state_next = in ? ERROR : FLAG;
         ERROR : state_next = in ? ERROR : NONE;
         DISCARD : state_next = in ? ONE : NONE;
         FLAG : state_next = in ? ONE : NONE;
       endcase
   end
   assign err = (state == ERROR);
   assign disc = (state == DISCARD);
   assign flag = (state == FLAG);
endmodule
