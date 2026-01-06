module fsm (
    input  wire        clk,
    input  wire        reset, // synchronous reset: sets the FSM to the initial state (LOCKED)
    output wire [2:0]  state
);

    localparam LOCKED   = 3'b000;
    localparam INPUT    = 3'b001;
    localparam VERIFY   = 3'b010;
    localparam ERROR    = 3'b011;
    localparam UNLOCKED = 3'b100;

    wire [2:0] current_state; 
    wire [2:0] next_state;  

    // This defines two 3-bit wires in your FSM, each bit is a D flip flop
    // They are not memory by themselves—they are like pipes for electricity/signals in digital hardware.

    // Moore machine
    // we made 3 dffs(check file), and integrate these with the wire, 3 because thats the minimum bits for 5 states


    dff dff0(.clk(clk), .reset(reset), .d(next_state[0]), .q(current_state[0]));
    dff dff1(.clk(clk), .reset(reset), .d(next_state[1]), .q(current_state[1]));
    dff dff2(.clk(clk), .reset(reset), .d(next_state[2]), .q(current_state[2]));

    // learn how to complete next part of the code
endmodule
