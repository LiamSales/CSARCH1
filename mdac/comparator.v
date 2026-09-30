// PART 5: this combinational circuit asks whether entered equals expected.
// fsm.v sends the saved entered_code and PASSWORD here, then uses match
// SELF EXPLANATORY
module comparator (
    input  wire [15:0] entered,
    input  wire [15:0] expected,
    output wire       match
);

    wire [15:0] bit_matches;
    wire [7:0] matches_8;
    wire [3:0] matches_4;
    wire [1:0] matches_2;

    genvar bit_index;
    generate
        for (bit_index = 0; bit_index < 16; bit_index = bit_index + 1) begin : compare_bits
            wire mismatch;
            xor_gate compare_gate (entered[bit_index], expected[bit_index], mismatch);
            not_gate equal_gate (mismatch, bit_matches[bit_index]);
        end
    endgenerate

    genvar group8;
    generate
        for (group8 = 0; group8 < 8; group8 = group8 + 1) begin : combine_8
            and_gate combine_gate (bit_matches[group8 * 2], bit_matches[group8 * 2 + 1], matches_8[group8]);
        end
    endgenerate

    genvar group4;
    generate
        for (group4 = 0; group4 < 4; group4 = group4 + 1) begin : combine_4
            and_gate combine_gate (matches_8[group4 * 2], matches_8[group4 * 2 + 1], matches_4[group4]);
        end
    endgenerate

    genvar group2;
    generate
        for (group2 = 0; group2 < 2; group2 = group2 + 1) begin : combine_2
            and_gate combine_gate (matches_4[group2 * 2], matches_4[group2 * 2 + 1], matches_2[group2]);
        end
    endgenerate

    and_gate combine_final (matches_2[0], matches_2[1], match);

endmodule

//Does the entered code equal the expected password?

//uses xor

