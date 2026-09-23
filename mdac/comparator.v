// Compares two 4-bit values without using the == operator.
// Equality is built from XOR and NOT gates, then combined with AND.
module comparator (
    input  wire [3:0] entered,
    input  wire [3:0] expected,
    output wire       match
);

    wire x0, x1, x2, x3;
    wire nx0, nx1, nx2, nx3;
    wire t0, t1, t2;

    xor_gate xg0 (entered[0], expected[0], x0);
    xor_gate xg1 (entered[1], expected[1], x1);
    xor_gate xg2 (entered[2], expected[2], x2);
    xor_gate xg3 (entered[3], expected[3], x3);

    not_gate ng0 (x0, nx0);
    not_gate ng1 (x1, nx1);
    not_gate ng2 (x2, nx2);
    not_gate ng3 (x3, nx3);

    and_gate a0 (nx0, nx1, t0);
    and_gate a1 (nx2, nx3, t1);
    and_gate a2 (t0, t1, match);

endmodule

