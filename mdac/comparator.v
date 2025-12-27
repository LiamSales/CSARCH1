// --------------------------------------------------
// comparator.v
//
// Purpose:
// Compares the entered input pattern against a
// fixed, hard-coded access pattern.
//
// Outputs HIGH when patterns match exactly.
//
// PURELY COMBINATIONAL.
// --------------------------------------------------

module comparator (
    input  wire [N-1:0] entered,   // entered pattern (from FSM/registers)
    output wire         match       // HIGH when pattern matches
);

    // --------------------------------------------------
    // Parameters (optional, but recommended)
    // --------------------------------------------------
    // TODO:
    // - Decide how many bits the access pattern has
    // - Define N accordingly (e.g., 2, 3, or 4 bits)

    // --------------------------------------------------
    // Internal wires
    // --------------------------------------------------
    // TODO:
    // - Wires for XOR results (bit-by-bit comparison)
    // - Wires for inverted XORs (bit matches)
    // - Wires for intermediate AND results

    // --------------------------------------------------
    // Gate instantiations
    // --------------------------------------------------
    // TODO:
    // 1. Hard-code the expected pattern using constants
    // 2. XOR each entered bit with its expected value
    // 3. Invert XOR outputs (match = XNOR behavior)
    // 4. AND all match bits together
    // 5. Drive 'match' from the final AND output
    //
    // RULES:
    // - Use xor_gate, not_gate, and and_gate only
    // - No behavioral logic
    // - No == operator
    // - No assign-based comparisons

endmodule
