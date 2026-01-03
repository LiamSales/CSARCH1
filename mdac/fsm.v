module fsm (
    input  wire        clk,   // the system clock signal, tells flip-flops "update now"
    input  wire        reset, // synchronous reset: sets the FSM to the initial state (LOCKED)
    output wire [2:0]  state  // the 3-bit output representing the current FSM state (for debug / GTKWave)
);

    // ------------------------------
    // STATE ENCODINGS (constants)
    // ------------------------------
    // These are just *labels* for patterns of bits.
    // They do NOT store anything by themselves.
    // Each state is a unique 3-bit pattern, so 3 flip-flops can hold it.
    localparam LOCKED   = 3'b000;
    localparam INPUT    = 3'b001;
    localparam VERIFY   = 3'b010;
    localparam ERROR    = 3'b011;
    localparam UNLOCKED = 3'b100;

    // ------------------------------
    // INTERNAL WIRES (state storage)
    // ------------------------------
    // This is where the FSM actually *remembers* what state it is in.
    // current_state[2:0] holds the value of the three flip-flops.
    wire [2:0] current_state; 

    // next_state[2:0] is a wire that will carry the value the FSM *should become* on the next clock tick.
    wire [2:0] next_state;  

    // ------------------------------
    // INSTANTIATE 3 D FLIP-FLOPS
    // ------------------------------
    // Each bit of the FSM has its own DFF
    // Flip-flops capture next_state on the rising edge of clk
    // If reset is high, all bits become LOCKED (3'b000)
    dff dff0(.clk(clk), .reset(reset), .d(next_state[0]), .q(current_state[0]));
    dff dff1(.clk(clk), .reset(reset), .d(next_state[1]), .q(current_state[1]));
    dff dff2(.clk(clk), .reset(reset), .d(next_state[2]), .q(current_state[2]));

    // ------------------------------
    // NEXT-STATE LOGIC (combinational)
    // ------------------------------
    // This is a *placeholder* example.
    // It decides what the next_state bits will be based on the current_state.
    // This block is combinational logic: it calculates output immediately from inputs (no clock).
    // `always @*` = "recalculate whenever any input used inside changes"
    always @* begin
        case(current_state)        // look at the current_state pattern
            LOCKED:    next_state = INPUT;     // if LOCKED, next is INPUT
            INPUT:     next_state = VERIFY;    // if INPUT, next is VERIFY
            VERIFY:    next_state = ERROR;     // if VERIFY, next is ERROR
            ERROR:     next_state = UNLOCKED;  // if ERROR, next is UNLOCKED
            UNLOCKED:  next_state = LOCKED;    // if UNLOCKED, next is LOCKED
            default:   next_state = LOCKED;    // safety fallback in case current_state is invalid
        endcase
    end
    // Note:
    // - In a real FSM, we will also consider button inputs and comparator outputs here
    // - This example ignores inputs just to show the storage structure

    // ------------------------------
    // CONNECT STATE TO OUTPUT
    // ------------------------------
    // This exposes the current state to the outside world (e.g., for debugging or waveform viewing)
    assign state = current_state;

endmodule
