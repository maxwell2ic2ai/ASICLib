module sync_h2lck(
    input async_in, bclk, rst,
    output sync_out
    );

reg q1, q2, q3;
wire async_rst;

assign async_rst = !async_in && sync_out;

always @(posedge async_in or posedge async_rst) begin
    if (async_rst) begin
        q1 <= 1'b0;
    end
    else begin
        q1 <= 1'b1;
    end
end

always @(posedge bclk or posedge rst) begin
    if (rst) begin
        q2 <= 1'b0;
        q3 <= 1'b0;
    end
    else begin
        q2 <= q1;
        q3 <= q2;
    end
end

assign sync_out = q3;

endmodule