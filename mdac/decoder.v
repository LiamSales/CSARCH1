// PART 4: this module gates each raw button with the valid signal.
// It produces four separate button wires for later logic.
// IMPORTANT: fsm.v currently does not instantiate this module, so these
// outputs are not part of the live circuit yet. The FSM reads btn directly.
module decoder (
    input  wire [3:0] btn,
    input  wire       invalid,
    output wire       sig0,
    output wire       sig1,
    output wire       sig2,
    output wire       sig3
);

    wire valid; // 1 means the raw button combination may pass through.

    // invalid=1 becomes valid=0; invalid=0 becomes valid=1.
    not_gate n0 (invalid, valid);

    // Pass each button only when the complete button combination is valid.
    and_gate a0 (btn[0], valid, sig0);
    and_gate a1 (btn[1], valid, sig1);
    and_gate a2 (btn[2], valid, sig2);
    and_gate a3 (btn[3], valid, sig3);

endmodule

//decoder makes 4 separate signals (4 buttons), the decoder allows only when valid 
//exists for the assignment but is not currently being used by the top-level design.