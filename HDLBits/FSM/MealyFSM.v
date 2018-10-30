module top_module(
 input  clk,
 input  aresetn,
 input  x,
 output z);

   localparam IDLE = 0;
   localparam S1 = 1;
   localparam S10 = 2;

   reg [1:0] state, state_next;
   always @ (posedge clk, negedge aresetn) begin
       if (~aresetn) state <= IDLE;
       else state <= state_next;
   end
   always @ (*) begin
       case (state)
         IDLE : state_next = x ? S1 : IDLE;
         S1 : state_next   = x ? S1 : S10;
         S10 : state_next  = x ? S1 : IDLE;
       endcase
   end
   assign z = (state == S10) && (x == 1);
endmodule

module top_module (
  input clk,
  input aresetn,
  input x,
  output reg z
);

  // Give state names and assignments. I'm lazy, so I like to use decimal numbers.
  // It doesn't really matter what assignment is used, as long as they're unique.
  parameter S=0, S1=1, S10=2;
  reg[1:0] state, next;		// Make sure state and next are big enough to hold the state encodings.



  // Edge-triggered always block (DFFs) for state flip-flops. Asynchronous reset.
  always@(posedge clk, negedge aresetn)
    if (!aresetn)
      state <= S;
    else
      state <= next;



    // Combinational always block for state transition logic. Given the current state and inputs,
    // what should be next state be?
    // Combinational always block: Use blocking assignments.
  always@(*) begin
    case (state)
      S: next   = x ? S1 : S;
      S1: next  = x ? S1 : S10;
      S10: next = x ? S1 : S;
      default: next = 'x;
    endcase
  end



  // Combinational output logic. I used a combinational always block.
  // In a Mealy state machine, the output depends on the current state *and*
  // the inputs.
  always@(*) begin
    case (state)
      S: z = 0;
      S1: z = 0;
      S10: z = x;		// This is a Mealy state machine: The output can depend (combinational) on the input.
      default: z = 1'bx;
    endcase
  end

endmodule
