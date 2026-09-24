// Basic 1-bit storage element.
// The reset is synchronous, so the flip-flop clears only on the active clock edge.
module dff (
    input  wire clk,
    input  wire reset,
    input  wire d,
    output reg  q
);

//clk flips and flops regular intervals
//"Only do anything when clk changes from 0 → 1
    always @(posedge clk) begin


        if (reset)
            q <= 1'b0;
            // output zero
        else
            q <= d;
            // output d
    end

// so even when d changes, sometimes q doesnt change, because clock hasnt ticked
endmodule

// learn how this works, flip flop and storage