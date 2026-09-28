
module and_gate(input wire a, input wire b, output wire y);
    // The output is 1 only when both inputs are 1.
    assign y = a & b;
endmodule

module or_gate(input wire a, input wire b, output wire y);
    // The output is 1 when either input, or both inputs, are 1.
    assign y = a | b;
endmodule

module not_gate(input wire a, output wire y);
    // Reverse the input: 0 becomes 1 and 1 becomes 0.
    assign y = ~a;
endmodule

module xor_gate(input wire a, input wire b, output wire y);
    // The output is 1 only when the two inputs are different.
    assign y = a ^ b;
endmodule
