module sync(
    input async_in, bclk, rst,
    output sync_out
    );

reg bdat1, bdat2;

always @(posedge bclk or posedge rst) begin
    if (rst) begin
        bdat1 <= 1'b0;
        bdat2 <= 1'b0;
    end
    else begin
        bdat1 <= async_in;
        bdat2 <= bdat1;
    end
end

assign sync_out = bdat2;

endmodule