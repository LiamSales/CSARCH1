module invalid_input (
    input  wire [3:0] btn,
    output wire       invalid
);

    wire w1, w2, w3, w4, w5, w6;
    wire wa, wb, wc, wd;

    and_gate g1 (btn[0], btn[1], w1);
    and_gate g2 (btn[0], btn[2], w2);
    and_gate g3 (btn[0], btn[3], w3);
    and_gate g4 (btn[1], btn[2], w4);
    and_gate g5 (btn[1], btn[3], w5);
    and_gate g6 (btn[2], btn[3], w6);

    or_gate o1 (w1, w2, wa);
    or_gate o2 (w3, w4, wb);
    or_gate o3 (w5, w6, wc);
    or_gate o4 (wa, wb, wd);
    or_gate o5 (wc, wd, invalid);

endmodule

