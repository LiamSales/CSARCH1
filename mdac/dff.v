module dff (
    input  wire clk,     // clock (your "pendulum")
    input  wire reset,   // synchronous reset
    input  wire d,
    output wire q
);

    wire nd;                // ~D
    wire dc, ndc;           // master latch enables
    wire m, n;              // master internal OR outputs
    wire m_q, m_nq;         // master latch outputs

    wire nclk;              // inverted clock for slave
    wire sc, sndc;          // slave latch enables
    wire s, t;              // slave internal OR outputs
    wire s_q, s_nq;         // slave latch outputs


    not_gate not_d (d, nd);


    and_gate m_set  (d,   clk, dc);   // S = D & clk
    and_gate m_reset(nd,  clk, ndc);  // R = ~D & clk


    or_gate  m_or1 (ndc, m_nq, m);
    not_gate m_not1(m, m_q);

    or_gate  m_or2 (dc, m_q, n);
    not_gate m_not2(n, m_nq);


    not_gate clk_inv(clk, nclk);      // invert clock
    and_gate s_set  (m_q, nclk, sc);      // S_slave = master Q & ~clk
    or_gate  s_reset_temp (m_nq, reset, sndc); // R_slave = master Qn OR reset
    and_gate s_reset(sndc, nclk, sndc); // AND with ~clk

    or_gate s_or1 (sndc, s_nq, s);
    not_gate s_not1(s, s_q);

    or_gate s_or2 (sc, s_q, t);
    not_gate s_not2(t, s_nq);

    assign q = s_q;

endmodule
