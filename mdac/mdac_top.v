// PART 7: top-level wrapper for the complete design.
// Think of this as the device's outside pins: inputs enter here, then are
// passed to fsm.v; the FSM's status signals come back out through this module.
// The actual decisions are in fsm.v, so this file mostly wires connections.
module mdac_top (
    input  wire        clk,
    input  wire        reset,
    input  wire [3:0]  btn,
    input  wire        enter,
    input  wire        clear,
    output wire        locked,
    output wire        unlocked,
    output wire        error,
    output wire [2:0] state
);

    // Create one copy of the controller and connect matching named signals.
    // For example, top-level reset is connected to the FSM's reset input.
    fsm u_fsm (
        .clk(clk),
        .reset(reset),
        .btn(btn),
        .enter(enter),
        .clear(clear),
        .state(state),
        .locked(locked),
        .unlocked(unlocked),
        .error(error)
    );

endmodule
