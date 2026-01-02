// State = multiple D flip-flops working together
// Before we decide transitions, we must decide:
// “How is state physically stored?”

/*

Create the state register
3 DFFs
updated on the clock
reset to LOCKED
No logic yet.

Expose state as an output
So you can see it in GTKWave.


*/


module fsm (
    input  wire        clk,
    input  wire        reset,
    output wire [2:0]  state
);
    
    localparam LOCKED   = 3'b000;
    localparam INPUT    = 3'b001;
    localparam VERIFY   = 3'b010;
    localparam ERROR    = 3'b011;
    localparam UNLOCKED = 3'b100;

    //not a variable in the sense that the machine HAS it, just a label for the pattern
    //the state register will hold that

    // TODO:
    // - Create a 3-bit register to hold current state
    // - Use three instances of dff
    // - On reset, state must become LOCKED

    // - Connect internal state register to output port

endmodule