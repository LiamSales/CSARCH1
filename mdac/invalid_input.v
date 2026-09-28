// PART 3: this combinational circuit checks the raw buttons from the user.
// It answers only: "Are two or more buttons on at the same time?"
// It does not store buttons. Its invalid output is passed to the FSM in fsm.v.
module invalid_input (
    input  wire [3:0] btn,
    output wire       invalid
);

    // Each p wire reports whether one particular pair is pressed together.
    wire p0, p1, p2, p3, p4, p5;
    // These temporary wires combine pair results before producing invalid.
    wire t0, t1, t2, t3;

    // Check all six possible pairs of the four buttons.
    and_gate g0 (btn[0], btn[1], p0);
    and_gate g1 (btn[0], btn[2], p1);
    and_gate g2 (btn[0], btn[3], p2);
    and_gate g3 (btn[1], btn[2], p3);
    and_gate g4 (btn[1], btn[3], p4);
    and_gate g5 (btn[2], btn[3], p5);

    // If any pair check is 1, the final invalid output must become 1.
    or_gate o0 (p0, p1, t0);
    or_gate o1 (p2, p3, t1);
    or_gate o2 (p4, p5, t2);
    // Combine the three groups. t3 is a separate wire so no wire has
    // multiple gate outputs driving it.
    or_gate o3 (t0, t1, t3);
    or_gate o4 (t3, t2, invalid);

endmodule

