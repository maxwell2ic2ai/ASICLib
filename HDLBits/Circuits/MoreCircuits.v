module top_module(
 input          clk,
 input          load,
 input [511:0]  data,
 output [511:0] q);

   reg [511:0]  q_next;
   always @ (posedge clk) begin
      if (load) q <= data;
      else q <= q_next;
   end
   always @ (*) begin
      q_next[511:0] = {1'b0, q[511:1]} ^ {q[510:0], 1'b0};
   end
endmodule // top_module


module top_module(
 input          clk,
 input          load,
 input [511:0]  data,
 output [511:0] q);
   
   wire [511:0] q_l;
   wire [511:0] q_r;
   assign q_l = {1'b0, q[511:1]};
   assign q_r = {q[510:0], 1'b0};
   always @(posedge clk) begin
      if (load)
        q <= data;	// Load the DFFs with a value.
      else begin
         // At each clock, the DFF storing each bit position becomes the XOR of its left neighbour
         // and its right neighbour. Since the operation is the same for every
         // bit position, it can be written as a single operation on vectors.
         // The shifts are accomplished using part select and concatenation operators.

         //     left           right
         //  neighbour       neighbour
         q <= ~((~q & ~q_r) | (q_l & q & q_r));
      end
   end
endmodule
