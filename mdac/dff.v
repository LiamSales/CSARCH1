// PART 2: unlike the gates in gates.v, this component remembers one bit.
// In the FSM, three copies store the three bits of current_state.
// d is the value waiting to be stored; q is the value currently remembered.
module dff (
    input  wire clk,
    input  wire reset,
    input  wire d,
    output reg  q
);

    // Run this block only on the clock's rising edge (0 -> 1).
    // A change to d by itself does not change q; q waits for that edge.
    always @(posedge clk) begin
        // Synchronous reset: reset clears q only at a rising clock edge.
        if (reset)
            q <= 1'b0;
        else
            // Otherwise remember the data input until the next rising edge.
            q <= d;
    end
endmodule