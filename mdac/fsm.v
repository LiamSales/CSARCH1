// You already have combinational logic (decoder, comparator)

// You now have a D flip-flop

// The missing piece is state

// State = multiple D flip-flops working together

// Before we decide transitions, we must decide:

// “How is state physically stored?”

/*

Stage 1 — Define FSM states as constants
(LOCKED, INPUT, VERIFY, ERROR, UNLOCKED)
These are 3-bit constants, not enums, not magic numbers.

Stage 2 — Create the state register
3 DFFs
updated on the clock
reset to LOCKED
No logic yet.

Stage 3 — Expose state as an output
So you can see it in GTKWave.


*/


module fsm (
    input  wire        clk,
    input  wire        reset,
    output wire [2:0]  state
);

    // ================================
    // STATE ENCODING (constants)
    // ================================
    // TODO:
    // Define 5 states using 3-bit constants:
    // LOCKED
    // INPUT
    // VERIFY
    // ERROR
    // UNLOCKED

    // ================================
    // STATE REGISTER
    // ================================
    // TODO:
    // - Create a 3-bit register to hold current state
    // - Use three instances of dff
    // - On reset, state must become LOCKED

    // ================================
    // OUTPUT CONNECTION
    // ================================
    // TODO:
    // - Connect internal state register to output port

endmodule