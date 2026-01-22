module fsm (
    input  wire        clk,
    input  wire        reset, // synchronous reset: sets the FSM to the initial state (LOCKED)
    input  wire [3:0]  btn,   // 4 buttons, one-hot
    input  wire        enter,  // confirm input
    input  wire        clear,  // clear input
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

    wire [2:0] current_state;
    wire [2:0] next_state;

    dff dff0(.clk(clk), .reset(reset), .d(next_state[0]), .q(current_state[0]));
    dff dff1(.clk(clk), .reset(reset), .d(next_state[1]), .q(current_state[1]));
    dff dff2(.clk(clk), .reset(reset), .d(next_state[2]), .q(current_state[2]));


    reg [2:0] ns;

    always @* begin

        ns = current_state;

        case (current_state)

            LOCKED: begin
                if (enter)
                    ns = INPUT;
            end

            INPUT: begin
                if (clear)
                    ns = LOCKED;
                else if (enter)
                    ns = VERIFY;
            end

            VERIFY: begin
                if (match)
                    ns = UNLOCKED;
                else
                    ns = ERROR;
            end

            ERROR: begin
                if (clear)
                    ns = LOCKED;
            end

            UNLOCKED: begin
                if (clear)
                    ns = LOCKED;
            end

            default: begin
                ns = LOCKED;
            end

        endcase
    end

    assign next_state = ns;

    assign locked   = (current_state == LOCKED);
    assign unlocked = (current_state == UNLOCKED);
    assign error    = (current_state == ERROR);
    assign state = current_state;

    wire match;
    assign match = (entered_code == PASSWORD);

    wire invalid_input;
    wire enter_pressed;
    wire clear_pressed;
    wire digit_valid;

// study why invalid input is different
    assign invalid_input =
       digit_invalid
    | (enter & (|btn))
    | (clear & (|btn))
    | (enter & clear);

    assign enter_pressed = enter & ~invalid_input;
    assign clear_pressed = clear & ~invalid_input;
    assign digit_valid   = (|btn) & ~invalid_input;



    // --------------------------
    // TODO: TESTBENCH
    // --------------------------
    // 1. Simulate FSM with clk and reset
    // 2. Test all possible transitions (LOCKED->INPUT->VERIFY->UNLOCKED->LOCKED)
    // 3. Test error handling and clear input
    // 4. Display waveforms in GTKWave to verify

endmodule
