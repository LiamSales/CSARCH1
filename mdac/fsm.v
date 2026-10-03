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

    localparam [15:0] PASSWORD = 16'b0001_0010_0100_1000;

    wire [2:0] current_state;
    wire [2:0] next_state;

    
    reg [2:0] ns;

    // Stores four button presses.
    reg [15:0] entered_code;

    // Counts how many buttons have been entered.
    reg [2:0] button_count;

    wire digit_invalid;
    wire valid_button;
    wire enter_pressed;
    wire clear_pressed;
    wire match;

    dff dff0 (
        .clk(clk),
        .reset(reset),
        .d(next_state[0]),
        .q(current_state[0])
    );

    dff dff1 (
        .clk(clk),
        .reset(reset),
        .d(next_state[1]),
        .q(current_state[1])
    );

    dff dff2 (
        .clk(clk),
        .reset(reset),
        .d(next_state[2]),
        .q(current_state[2])
    );


 
    invalid_input u_invalid (
        .btn(btn),
        .invalid(digit_invalid)
    );

    assign valid_button = (|btn) & ~digit_invalid;

   
    assign enter_pressed = enter & ~clear;
    assign clear_pressed = clear & ~enter;

    // press 1: 0000_0000_0000_0001
    // press 2: 0000_0000_0001_0010
    // press 3: 0000_0001_0010_0100
    // press 4: 0001_0010_0100_1000

    always @(posedge clk) begin

        if (reset) begin
            entered_code <= 16'b0;
            button_count <= 3'b000;
        end

        else if (clear_pressed) begin
            entered_code <= 16'b0;
            button_count <= 3'b000;
        end

        else if (valid_button &&
                 (current_state == LOCKED || current_state == INPUT) &&
                 button_count < 4) begin

            entered_code <= {entered_code[11:0], btn};
            button_count <= button_count + 1'b1;
        end
    end


    // ------------------------------------------------------------
    // COMPARATOR
    // ------------------------------------------------------------

    // Compare the four entered buttons against the password.
    comparator u_cmp (
        .entered(entered_code),
        .expected(PASSWORD),
        .match(match)
    );


    // ------------------------------------------------------------
    // NEXT-STATE LOGIC
    // ------------------------------------------------------------

    always @* begin

        // Default: stay in the current state.
        ns = current_state;

        case (current_state)

            LOCKED: begin
                // First valid button starts the password input.
                if (valid_button)
                    ns = INPUT;
            end


            INPUT: begin

                if (clear_pressed)
                    ns = LOCKED;

                // Only allow verification after four buttons.
                else if (enter_pressed && button_count == 4)
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


            default:
                ns = LOCKED;

        endcase
    end


    // Send calculated next state to the DFFs.
    assign next_state = ns;


    // ------------------------------------------------------------
    // OUTPUTS
    // ------------------------------------------------------------

    assign locked   = (current_state == LOCKED);
    assign unlocked = (current_state == UNLOCKED);
    assign error    = (current_state == ERROR);

    assign state = current_state;

endmodule