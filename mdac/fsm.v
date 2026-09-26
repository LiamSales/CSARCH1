// Finite-state machine for the MDAC lock controller.
// The FSM is a Moore machine: outputs depend only on the current state.

//Decide what the lock should do
//This is the brain of the project.


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
    reg  [2:0] ns;
    reg  [3:0] entered_code;

    wire digit_invalid;
    wire valid_button;
    wire enter_pressed;
    wire clear_pressed;
    wire match;

    // State register built from the synchronous D flip-flops in dff.v.
    dff dff0 (.clk(clk), .reset(reset), .d(next_state[0]), .q(current_state[0]));
    dff dff1 (.clk(clk), .reset(reset), .d(next_state[1]), .q(current_state[1]));
    dff dff2 (.clk(clk), .reset(reset), .d(next_state[2]), .q(current_state[2]));

    // Input validation: reject combinations with more than one pressed button.
    invalid_input u_invalid (
        .btn(btn),
        .invalid(digit_invalid)
    );

    assign valid_button = (|btn) & ~digit_invalid;
    assign enter_pressed = enter & valid_button & ~clear;
    assign clear_pressed = clear & ~enter;

    // Store a valid key entry before verification.
    always @(posedge clk) begin
        if (reset)
            entered_code <= 4'b0000;
        else if (clear_pressed)
            entered_code <= 4'b0000;
        else if (current_state == INPUT && enter_pressed)
            entered_code <= btn;
    end

    // Compare with the password using explicit gate-level logic.
    comparator u_cmp (
        .entered(entered_code),
        .expected(PASSWORD),
        .match(match)
    );

    // Next-state logic for the FSM.
    always @* begin
        ns = current_state;

        case (current_state)
            LOCKED: begin
                if (enter_pressed)
                    ns = INPUT;
            end

            INPUT: begin
                if (clear_pressed)
                    ns = LOCKED;
                else if (enter_pressed)
                    ns = VERIFY;
            end

            VERIFY: begin
                if (match)
                    ns = UNLOCKED;
                else
                    ns = ERROR;
            end

            ERROR: begin
                if (clear_pressed)
                    ns = LOCKED;
            end

            UNLOCKED: begin
                if (clear_pressed)
                    ns = LOCKED;
            end

            default: ns = LOCKED;
        endcase
    end

    assign next_state = ns;

    // Moore outputs derived only from the current FSM state.
    assign locked   = (current_state == LOCKED);
    assign unlocked = (current_state == UNLOCKED);
    assign error    = (current_state == ERROR);
    assign state    = current_state;

endmodule

//lock behavior