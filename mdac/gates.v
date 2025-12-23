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


//this whole file defines how logic gates should work

// Implement AND, OR, NOT, XOR. No always blocks. Only assign

//You are not allowed to “cheat” by using high-level operators everywhere. Other modules must be built from these gates
