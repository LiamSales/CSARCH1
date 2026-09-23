// Converts a valid button vector into one-hot control signals.
// If the input is invalid, all outputs remain low.
module decoder (
    input  wire [3:0] btn,
    input  wire       invalid,
    output wire       sig0,
    output wire       sig1,
    output wire       sig2,
    output wire       sig3
);

    wire valid;

    not_gate n0 (invalid, valid);

    and_gate a0 (btn[0], valid, sig0);
    and_gate a1 (btn[1], valid, sig1);
    and_gate a2 (btn[2], valid, sig2);
    and_gate a3 (btn[3], valid, sig3);

endmodule
