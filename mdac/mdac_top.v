
// we could skip this but it gives the impression of a complete project (sans user)

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
