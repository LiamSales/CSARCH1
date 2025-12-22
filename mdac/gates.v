module and_gate(input a, input b, output y);
    assign y = a & b;
endmodule

module or_gate(input a, input b, output y);
    assign y = a | b;
endmodule

module not_gate(input a, output y);
    assign y = ~a;
endmodule

module xor_gate(input a, input b, output y);
    assign y = a ^ b;
endmodule

// Implement AND, OR, NOT, XOR. No always blocks. Only assign