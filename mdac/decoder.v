// --------------------------------------------------
// decoder.v
//
// Purpose:
// Decodes one-hot button inputs into internal
// control signals for the MDAC system.
//
// This module is PURELY COMBINATIONAL.
// --------------------------------------------------

module decoder (
    input  wire [3:0] btn,        // one-hot button inputs
    input  wire       invalid,     // from invalid_input module
    output wire       sig0,         // control signal for button 0
    output wire       sig1,         // control signal for button 1
    output wire       sig2,         // control signal for button 2
    output wire       sig3          // control signal for button 3
);

    // --------------------------------------------------
    // Internal wires
    // --------------------------------------------------
    // TODO:
    // - Declare wires needed for NOTs of btn bits
    // - Declare wires needed for gating with invalid
    // - Declare any intermediate results

    // --------------------------------------------------
    // Gate instantiations
    // --------------------------------------------------
    // TODO:
    // 1. Invert invalid (you will need NOT invalid)
    //
    // 2. For each button:
    //    - Ensure exactly that button is active
    //    - Ensure invalid is LOW
    //
    // 3. Drive sig0–sig3 accordingly
    //
    // RULES:
    // - Use gates from gates.v only
    // - No assign statements for logic
    // - No behavioral logic
    // - Explicit structure only

endmodule
