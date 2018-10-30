module top_module(
                  input  clk,
                  input  areset, // Asynchronous reset to state B
                  input  in,
                  output out);//

   localparam A=0, B=1;
   reg                   state, next_state;

   always @(*) begin    // This is a combinational always block
      case (state)
        (A): begin
           out = 0;
           if (in == 1) next_state = A;
           else next_state = B;
        end
        (B): begin
           out = 1;
           if (in == 1) next_state = B;
           else next_state = A;
        end
      endcase
   end

   always @(posedge clk, posedge areset) begin    // This is a sequential always block
      if (areset) state <= B;
      else state <= next_state;// State flip-flops with asynchronous reset
   end

   // Output logic
   // assign out = (state == ...);

endmodule


module top_module (
  input clk,
  input in,
  input areset,
  output out
);

  // Give state names and assignments. I'm lazy, so I like to use decimal numbers.
  // It doesn't really matter what assignment is used, as long as they're unique.
  parameter A=0, B=1;
  reg state;		// Ensure state and next are big enough to hold the state encoding.
  reg next;


    // A finite state machine is usually coded in three parts:
    //   State transition logic
    //   State flip-flops
    //   Output logic
    // It is sometimes possible to combine one or more of these blobs of code
    // together, but be careful: Some blobs are combinational circuits, while some
    // are clocked (DFFs).


    // Combinational always block for state transition logic. Given the current state and inputs,
    // what should be next state be?
    // Combinational always block: Use blocking assignments.
    always@(*) begin
    case (state)
      A: next = in ? A : B;
      B: next = in ? B : A;
    endcase
    end



    // Edge-triggered always block (DFFs) for state flip-flops. Asynchronous reset.
    always @(posedge clk, posedge areset) begin
    if (areset) state <= B;		// Reset to state B
        else state <= next;			// Otherwise, cause the state to transition
  end



  // Combinational output logic. In this problem, an assign statement is the simplest.
  // In more complex circuits, a combinational always block may be more suitable.
  assign out = (state==B);


endmodule



module top_module (
                   input  clk,
                   input  j,
                   input  k,
                   input  areset,
                   output out
                   );
   parameter A=0, B=1;
   reg                    state;
   reg                    next;

   always_comb begin
      case (state)
        A: next = j ? B : A;
        B: next = k ? A : B;
      endcase
   end

   always @(posedge clk, posedge areset) begin
      if (areset) state <= A;
      else state <= next;
   end

   assign out = (state==B);


endmodule


module top_module(
 input        in,
 input [1:0]  state,
 output [1:0] next_state,
 output       out);

   localparam A = 0;
   localparam B = 1;
   localparam C = 2;
   localparam D = 3;

   always @ (*) begin
       case (state)
         (A): next_state = in ? B : A;
         (B): next_state = in ? B : C;
         (C): next_state = in ? D : A;
         (D): next_state = in ? B : C;
       endcase
   end
   assign out = (state == D);
endmodule
