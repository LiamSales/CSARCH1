module fsm (
    input  wire        clk,
    input  wire        reset,   // synchronous reset
    input  wire [3:0]  btn,    // 4 buttons, one-hot
    input  wire        enter,   // confirm input
    input  wire        clear,   // clear input
    output wire [2:0]  state,  // current FSM state for debug
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


    wire digit_invalid;
    invalid_input u_invalid (
        .btn(btn),
        .invalid(digit_invalid)
    );

    wire invalid_input;
    assign invalid_input =
           digit_invalid
        | (enter & (|btn))   // enter + any digit
        | (clear & (|btn))   // clear + any digit
        | (enter & clear);   // enter + clear pressed

    wire enter_pressed = enter & ~invalid_input;
    wire clear_pressed = clear & ~invalid_input;
    wire digit_valid   = (|btn) & ~invalid_input;


    reg [3:0] entered_code;
    localparam [3:0] PASSWORD = 4'b1010;  // example password

    always @(posedge clk) begin
        if (reset)
            entered_code <= 4'b0000;
        else if (clear_pressed)
            entered_code <= 4'b0000;
        else if (digit_valid & enter_pressed)
            entered_code <= btn;  // store the latest button pressed
    end

    wire match;
    assign match = (entered_code == PASSWORD);

    reg [2:0] ns;
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

    assign locked   = (current_state == LOCKED);
    assign unlocked = (current_state == UNLOCKED);
    assign error    = (current_state == ERROR);
    assign state    = current_state;

endmodule
