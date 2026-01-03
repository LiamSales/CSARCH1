// Before we decide transitions, we must decide:
// “How is state physically stored?”
/*

Create the state register
3 DFFs
updated on the clock
reset to LOCKED

Expose state as an output
So you can see it in GTKWave.

*/
module fsm (
    input  wire        clk,
    input  wire        reset,
    output wire [2:0]  state
);

    // State encoding
    localparam LOCKED   = 3'b000;
    localparam INPUT    = 3'b001;
    localparam VERIFY   = 3'b010;
    localparam ERROR    = 3'b011;
    localparam UNLOCKED = 3'b100;

    //not a variable in the sense that the machine HAS it, just a label for the pattern
    //the state register will hold that

    // - Create a 3-bit register to hold current state
    // - Use three instances of dff
    // - On reset, state must become LOCKED

    //  The FSM has 3 bits of state (state[2:0])
    //  Each bit is stored in a D flip-flop (you already built dff.v)
    //  On each clock edge, the flip-flops capture the next state
    // Reset initializes all flip-flops to the LOCKED state


    // - Connect internal state register to output port

    // TODO: 1. Declare a 3-bit register for current state
    wire [2:0] current_state;

    // TODO: 2. Declare a 3-bit wire for next state
    wire [2:0] next_state;

    // TODO: 3. Instantiate 3 D flip-flops for each state bit
    // dff dff0(.clk(clk), .reset(reset), .d(next_state[0]), .q(current_state[0]));
    // dff dff1(.clk(clk), .reset(reset), .d(next_state[1]), .q(current_state[1]));
    // dff dff2(.clk(clk), .reset(reset), .d(next_state[2]), .q(current_state[2]));

    // TODO: 4. Compute next_state based on current_state and inputs
    // always @* begin
    //     case(current_state)
    //         LOCKED:    next_state = ???; // fill in transition
    //         INPUT:     next_state = ???;
    //         VERIFY:    next_state = ???;
    //         ERROR:     next_state = ???;
    //         UNLOCKED:  next_state = ???;
    //         default:   next_state = LOCKED;
    //     endcase
    // end

    // TODO: 5. Connect current_state to output
    assign state = current_state;

endmodule
