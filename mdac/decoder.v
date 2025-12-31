module decoder ( // one hot encoding
    input  wire [3:0] btn,
    input  wire       invalid,
    output wire       sig0,
    output wire       sig1,
    output wire       sig2,
    output wire       sig3
);

    wire valid;

    not_gate n1 (invalid, valid);

    and_gate g7  (btn[0], valid, sig0);
    and_gate g8  (btn[1], valid, sig1);
    and_gate g9  (btn[2], valid, sig2);
    and_gate g10 (btn[3], valid, sig3);

endmodule