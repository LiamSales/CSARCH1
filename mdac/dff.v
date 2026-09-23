// Basic 1-bit storage element.
// The reset is synchronous, so the flip-flop clears only on the active clock edge.
module dff (
    input  wire clk,
    input  wire reset,
    input  wire d,
    output reg  q
);

    always @(posedge clk) begin
        if (reset)
            q <= 1'b0;
        else
            q <= d;
    end

endmodule

