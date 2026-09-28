// PART 5: this combinational circuit asks whether entered equals expected.
// fsm.v sends the saved entered_code and PASSWORD here, then uses match
// to choose UNLOCKED or ERROR. This circuit does not remember either value.
module comparator (
    input  wire [3:0] entered,
    input  wire [3:0] expected,
    output wire       match
);

    // XOR is 1 for different bits. Each x wire reports a mismatch.
    wire x0, x1, x2, x3;
    // NOT reverses each mismatch: nx is 1 when that bit matches.
    wire nx0, nx1, nx2, nx3;
    // Temporary wires combine the four individual bit-match results.
    wire t0, t1, t2;

    // Compare corresponding bit positions in the two 4-bit values.
    xor_gate xg0 (entered[0], expected[0], x0);
    xor_gate xg1 (entered[1], expected[1], x1);
    xor_gate xg2 (entered[2], expected[2], x2);
    xor_gate xg3 (entered[3], expected[3], x3);

    // Turn each mismatch result into an equality result.
    not_gate ng0 (x0, nx0);
    not_gate ng1 (x1, nx1);
    not_gate ng2 (x2, nx2);
    not_gate ng3 (x3, nx3);

    // All four bits must match, so AND the four equality results together.
    and_gate a0 (nx0, nx1, t0);
    and_gate a1 (nx2, nx3, t1);
    and_gate a2 (t0, t1, match);

endmodule

//Does the entered code equal the expected password?

//uses xor

