module dff (
    input  wire clk,     // clock (your "pendulum")
    input  wire reset,   // synchronous reset
    input  wire d,
    output wire q        // q is driven by gates, not always-block
);
    
    wire nd;              
    wire dc, ndc, m, n;        
    wire m_q, m_nq;       // master latch outputs
    wire sc, sndc;        // slave enable signals (clk inverted)
    wire s_q, s_nq;       // slave latch outputs

    not_gate not_d (d, nd);

    // --------------------------------------------------
    // MASTER LATCH (transparent when clk = 1)
    // --------------------------------------------------
    and_gate m1 (d,  clk, dc);     // TODO: confirm this is master "S"
    and_gate m2 (nd, clk, ndc);    // TODO: confirm this is master "R"

// TODO 1: First OR must be (R , m_nq) not (S , R)
// TODO 2: Second OR must be (S , m_q)
// TODO 3: Ensure both outputs depend on each other

// TODO replace s1 with:  or_gate (ndc, m_nq, ...) – this builds Q = ~(R | Q̅)

// TODO replace s2 with:  or_gate (dc, m_q, ...) – this builds Q̅ = ~(S | Q)

    or_gate s1 (dc,ndc, m);
    not_gate sa (m, m_q);
    or_gate s2 (ndc, m_q, n);
    not_gate sb (n, m_nq);

    // --------------------------------------------------
    // SLAVE LATCH (transparent when clk = 0)
    // --------------------------------------------------
    // TODO: invert clk
    // sc   = m_q   & ~clk
    // sndc = m_nq  & ~clk

    // TODO: build second SR latch here
    // TODO: outputs should be s_q and s_nq

    // --------------------------------------------------
    // OUTPUT
    // --------------------------------------------------
    assign q = s_q;

    // --------------------------------------------------
    // TODO CHECKLIST
    // --------------------------------------------------
    // 1. Build master SR latch using dc / ndc
    // 2. Invert clk for slave latch enable
    // 3. Build slave SR latch using master outputs
    // 4. Ensure only ONE latch is transparent at a time
    // 5. Add reset by forcing s_q = 0 safely
    // 6. Simulate: D changes while clk high -> no immediate Q change
    // 7. Verify: Q updates only on rising edge
endmodule
