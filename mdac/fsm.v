
module fsm (
    input  wire        clk,
    input  wire        reset,
    input  wire [3:0]  btn,
    input  wire        enter,
    input  wire        clear,
    output wire [2:0]  state,
    output wire        locked,
    output wire        unlocked,
    output wire        error
);

    localparam LOCKED   = 3'b000;
    localparam INPUT    = 3'b001;
    localparam VERIFY   = 3'b010;
    localparam ERROR    = 3'b011;
    localparam UNLOCKED = 3'b100;

    localparam [3:0] PASSWORD = 4'b0001;

    wire [2:0] current_state;
    wire [2:0] next_state;
    reg  [2:0] ns; // Temporary variable used while calculating next_state.
    reg  [3:0] entered_code; // One stored button vector, not a sequence.

    wire digit_invalid;
    wire valid_button;
    wire enter_pressed;
    wire clear_pressed;
    wire match;

    // Three dff.v instances store the three state bits.
    // Each D input gets one next_state bit; each Q output becomes one
    // current_state bit. Together they move the FSM forward at a clock edge.
    dff dff0 (.clk(clk), .reset(reset), .d(next_state[0]), .q(current_state[0]));
    dff dff1 (.clk(clk), .reset(reset), .d(next_state[1]), .q(current_state[1]));
    dff dff2 (.clk(clk), .reset(reset), .d(next_state[2]), .q(current_state[2]));

    // Ask invalid_input.v whether multiple buttons are pressed together.
    invalid_input u_invalid (
        .btn(btn),
        .invalid(digit_invalid)
    );


//we need the extra check to make sure one button is clicked
    assign valid_button = (|btn) & ~digit_invalid;
    assign enter_pressed = enter & valid_button & ~clear;
    assign clear_pressed = clear & ~enter;

    // This is a second piece of memory, separate from the state DFFs.
    // It remembers the password the user attempts

    
    always @(posedge clk) begin
        if (reset)
            entered_code <= 4'b0000;
        else if (clear_pressed)
            entered_code <= 4'b0000; //clear was pressed, also reset
        else if (current_state == INPUT && enter_pressed)
            entered_code <= btn; //If we're currently in the INPUT state AND Enter is pressed, save the button value into entered_code.
    end

    comparator u_cmp (
        .entered(entered_code),
        .expected(PASSWORD),
        .match(match)
    );

    // // Combinational next-state decision: this block calculates a destination
    // // but does not store it. The three DFFs copy it on the next rising edge.
    // always @* begin
    //     // Default: stay where we are unless a case below requests a move.
    //     ns = current_state;

    //     case (current_state)
    //         // LOCKED -> INPUT when enter_pressed is true.
    //         LOCKED: begin
    //             if (enter_pressed)
    //                 ns = INPUT;
    //         end

    //         // INPUT -> LOCKED on clear, or INPUT -> VERIFY on enter.
    //         INPUT: begin
    //             if (clear_pressed)
    //                 ns = LOCKED;
    //             else if (enter_pressed)
    //                 ns = VERIFY;
    //         end

    //         // VERIFY -> UNLOCKED for a match, otherwise -> ERROR.
    //         VERIFY: begin
    //             if (match)
    //                 ns = UNLOCKED;
    //             else
    //                 ns = ERROR;
    //         end

    //         // Both terminal result modes return to LOCKED on clear.
    //         ERROR: begin
    //             if (clear_pressed)
    //                 ns = LOCKED;
    //         end

    //         UNLOCKED: begin
    //             if (clear_pressed)
    //                 ns = LOCKED;
    //         end

    //         default: ns = LOCKED;
    //     endcase
    // end

    // // Connect the temporary decision to the D inputs of the state DFFs.
    // assign next_state = ns;

    // // Moore outputs: they describe the remembered state, not the current
    // // button press. state is also exposed for debugging in simulation.
    // assign locked   = (current_state == LOCKED);
    // assign unlocked = (current_state == UNLOCKED);
    // assign error    = (current_state == ERROR);
    // assign state    = current_state;

endmodule

//lock behavior
