module pattern_det(
    input in, clk, rst,
    output reg moore_out, mealy_out
    );

reg [4:0] state, state_next;

localparam S_idle = 5'b00000;
localparam S1 = 5'b00001;
localparam S10 = 5'b00010;
localparam S100 = 5'b00100;
localparam S1001 = 5'b01000;
localparam S10010 = 5'b10000;

always @(posedge clk or posedge rst) begin
    if (rst) begin
        state <= S_idle;
    end
    else begin
        state <= state_next;
    end
end

always @(*) begin
    if (rst) begin
        state_next = S_idle;
    end
    else begin
        case(state)
            S_idle: if (in == 1) state_next = S1;
                else state_next = S_idle;
            S1: if (in == 0) state_next = S10;
                else state_next = S1;
            S10: if (in == 0) state_next = S100;
                else state_next = S1;
            S100: if (in == 1) state_next = S1001;
                else state_next = S_idle;
            S1001: if (in ==0) state_next = S10010;
                else state_next = S1;
            S10010: if (in == 0) state_next = S100;
                else state_next = S1;
            default: state_next = S_idle;
        endcase
    end
end

//Moore Machine
always @(posedge clk or posedge rst) begin
    if (rst) begin
        moore_out <= 1'b0;
    end
    else begin
//      moore_out <= (state == S10010) ? 1'b1 : 1'b0;
        case(state)
            S10010: moore_out <= 1'b1;
            default: moore_out <= 1'b0;
        endcase
    end
end

//Mealy Machine
always @(posedge clk or posedge rst) begin
    if (rst) begin
        mealy_out <= 1'b0;
    end
    else begin
        mealy_out <= (state == S1001 && in ==0) ? 1'b1 : 1'b0;
    end
end

endmodule
