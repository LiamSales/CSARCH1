module dff (
    input  wire clk,
    input  wire reset,
    input  wire d,
    output wire q
);
    
    wire nd;              
    wire dc, ndc, m, n, o, p;        
    wire m_q, m_nq;       
    wire sc, sndc;        
    wire s_q, s_nq;
    wire nclk;  

    not_gate not_d (d, nd);

    and_gate m1 (d,  clk, dc); 
    and_gate m2 (nd, clk, ndc);

    or_gate s1 (ndc, m_nq, m);
    not_gate sa (m, m_q);

    or_gate s2 (dc, m_q, n);
    not_gate sb (n, m_nq);


    not_gate nc (clk, nclk);

    // HINT 3: build SR latch using (sc, sndc) → outputs (s_q, s_nq)

    and_gate s_c(m_q, nclk, sc);
    and_gate s_ndc(m_nq, nclk, sndc);

    or_gate s3(sndc, s_nq, o);
    not_gate sc(o, s_q);

    or_gate s4(sc, s_q, p);
    not_gate sd(p, s_nq);

    // HINT 4: merge reset as extra reset to slave

    assign q = s_q;

endmodule
