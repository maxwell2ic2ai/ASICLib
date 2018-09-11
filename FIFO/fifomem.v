module fifomem #(
    parameter DATASIZE = 8,
    parameter ADDRSIZE = 4
    )(
    output [DATASIZE-1:0] rdata,
    input  [DATASIZE-1:0] wdata,
    input  [ADDRSIZE-1:0] waddr, raddr,
    input                 wclken, wclk
    );

`ifdef VENDORRAM
// instentiation of a vendor's dual-port RAM
VENDOR_RAM MEM (
    .dout(rdata),
    .din(wdata),
    .waddr(waddr),
    .raddr(raddr),
    .wclken(wclken),
    .wclk(wclk)
    );
`else
    reg [DATASIZE-1:0] MEM [0:(1<<ADDRSIZE)-1];
    assign rdata = MEM[raddr];

    always @(posedge wclk) begin
        if (wclken) MEM[waddr] <= wdata;
    end

`endif

endmodule




