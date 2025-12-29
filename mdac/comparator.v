module comparator (
    input  wire [N-1:0] entered,
    output wire         match
);


    // 4 bit pattern 1110

wire x1, x2, x3, x4, xn1, xn2, xn3, xn4, xnA, xnB;
   
    // 1. Hard-code the expected pattern using constants

//how do i hardcode the constant in, also study specs why 4 buttons

xor_gate xg1 (,,x1);
xor_gate xg2 (,,x2);
xor_gate xg3 (,,x3);
xor_gate xg4 (,,x4);

not_gate nA(x1, xn1);
not_gate nB(x2, xn2);
not_gate nC(x3, xn3);
not_gate nD(x4, xn4);

and_gate gA (xn1,xn2,xnA);
and_gate gB (xn3,xn4,xnB);

and_gate comp (xnA,xnB, match);

endmodule
