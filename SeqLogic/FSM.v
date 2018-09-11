parameter IDLE = 0;
parameter S1 = 1;
parameter S2 = 2;

reg [1:0] state, state_next;

always @(posedge clk or posedge rst) begin
    if (rst) begin
        state <= IDLE;
    end
    else begin
        state <= state_next;
    end
end

always @(*) begin
    if (rst) begin
        state_next = IDLE;
    end
    else begin
        case(state)
            IDLE: if (in == cond2) state_next = S2;
                else state_next = IDLE;
            S1: if (in == cond1) state_next = S2;
                else state_next = S1;
            S2: if (in == cond3) state_next = IDLE;
                else state_next = S2;
            default: state_next = IDLE;
        endcase
    end
end

always @(posedge clk or posedge rst) begin
    if (rst) begin
        out <= 1'b0;
    end
    else begin
        case(state)
            IDLE: out <= 2'b000;
            S1: out <= 2'b01;
            S2: out <= 2'b10;
        endcase
    end
end