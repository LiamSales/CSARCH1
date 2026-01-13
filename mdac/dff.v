module dff (
    input  wire clk, //pendulum
    input  wire reset,
    input  wire d,
    output reg  q, // should be a q'
);

 // this stores exactly bit
// this uses the master slave

//“On the clock edge, store D. Otherwise, remember the old value.”
//No illegal states, On every clock tick, become next_state[i], which will be implemented in fsm module

//we make 2 sr latches
//Master	clk = 1	Captures D
//Slave	clk = 0	Outputs stored value

wire nd, dc, ndc, d1, d2;

not_gate notd (d,nd);
and_gate dandc (d,clk,dc);
and_gate ndandc (nd,clk,ndc);
not_gate l1 (dc, d1);
not_gate l2 (ndc, d2);



//take time to study this

//learn difference between dff and srff