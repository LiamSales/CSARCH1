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

    // --------------------------
    // TODO: NEXT STATE LOGIC (COMBINATIONAL)
    // --------------------------
    // 1. Create a reg [2:0] ns to hold next_state temporarily
    // 2. Use always @* block to calculate ns from current_state + inputs
    // 3. Implement state transitions:
    //      LOCKED  -> INPUT when enter pressed
    //      INPUT   -> VERIFY when enter pressed, LOCKED if clear pressed
    //      VERIFY  -> UNLOCKED if correct input, ERROR if incorrect
    //      ERROR   -> LOCKED if clear pressed
    //      UNLOCKED-> LOCKED if clear pressed
    // 4. Map ns to next_state
    // 5. Use btn inputs or comparison logic when verifying input sequence





    // --------------------------
    // TODO: OUTPUT LOGIC (MOORE)
    // --------------------------
    // 1. Assign locked = 1 if current_state == LOCKED
    // 2. Assign unlocked = 1 if current_state == UNLOCKED
    // 3. Assign error = 1 if current_state == ERROR
    // 4. Assign state = current_state (for debugging)

    // --------------------------
    // TODO: VERIFICATION LOGIC
    // --------------------------
    // 1. Design combinational logic to compare entered sequence with password
    // 2. Output a signal (correct/incorrect) to the FSM
    // 3. Feed this signal into the next_state logic for VERIFY state

    // --------------------------
    // TODO: INPUT DECODER
    // --------------------------
    // 1. Convert one-hot btn input to internal signals
    // 2. Detect invalid inputs (more than one button pressed)
    // 3. Send valid input signals to FSM and verification logic

    // --------------------------
    // TODO: TESTBENCH
    // --------------------------
    // 1. Simulate FSM with clk and reset
    // 2. Test all possible transitions (LOCKED->INPUT->VERIFY->UNLOCKED->LOCKED)
    // 3. Test error handling and clear input
    // 4. Display waveforms in GTKWave to verify

endmodule
