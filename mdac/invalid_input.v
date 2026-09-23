// Detects illegal multi-button presses.
// A valid input should contain at most one active button bit.
module invalid_input (
    input  wire [3:0] btn,
    output wire       invalid
);

    wire p0, p1, p2, p3, p4, p5;
    wire t0, t1, t2;

    and_gate g0 (btn[0], btn[1], p0);
    and_gate g1 (btn[0], btn[2], p1);
    and_gate g2 (btn[0], btn[3], p2);
    and_gate g3 (btn[1], btn[2], p3);
    and_gate g4 (btn[1], btn[3], p4);
    and_gate g5 (btn[2], btn[3], p5);

    or_gate o0 (p0, p1, t0);
    or_gate o1 (p2, p3, t1);
    or_gate o2 (p4, p5, t2);
    or_gate o3 (t0, t1, t0);
    or_gate o4 (t0, t2, invalid);

endmodule

