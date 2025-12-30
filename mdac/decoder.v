module comparator (
    input  wire [3:0] entered,
    output wire       match
);

    wire x0, x1, x2, x3;
    wire nx0, nx1, nx2, nx3;
    wire a1, a2;

    xor_gate g0 (entered[0], 1'b0, x0);
    xor_gate g1 (entered[1], 1'b1, x1);
    xor_gate g2 (entered[2], 1'b1, x2);
    xor_gate g3 (entered[3], 1'b1, x3);

    not_gate n0 (x0, nx0);
    not_gate n1 (x1, nx1);
    not_gate n2 (x2, nx2);
    not_gate n3 (x3, nx3);

    and_gate a_1 (nx0, nx1, a1);
    and_gate a_2 (nx2, nx3, a2);
    and_gate a_3 (a1,  a2,  match);

endmodule
