module dff (
    input  wire clk,
    input  wire reset,
    input  wire d,
    output reg  q
);

    // ------------------------------
    // Internal wires for gate-level logic
    // ------------------------------
    wire nd, gda, gdb, gdc, gdd;

    // Example gate connections (you need to complete the feedback loop)
    and_gate gd1(d, clk, gda);      // TODO: connect this to master latch properly
    not_gate gd2(gda, gdb);         // TODO: check if this goes to slave latch

    not_gate(d, nd);                // TODO: use this inverted D correctly in your latch
    and_gate(nd, clk, gdc);         // TODO: connect to other part of the latch
    not_gate(gdc, gdd);             // TODO: complete feedback loop to hold value

    // ------------------------------
    // Clocked behavior
    // ------------------------------
    always @(posedge clk) begin
        // TODO: implement synchronous reset
        // if (reset) q <= 0;

        // TODO: assign q to the correct combination of your gate outputs
        // q should only update on rising edge of clk
        // q should hold its previous value until next clock edge
    end

    // ------------------------------
    // TODO Checklist
    // ------------------------------
    // 1. Make a master-slave latch using your gda/gdb/gdc/gdd wires
    // 2. Connect the output of the slave latch to 'q'
    // 3. Ensure q updates only on rising edge of clk
    // 4. Implement synchronous reset: q = 0 when reset is high
    // 5. Test the DFF with a simple clk and d waveform to ensure it stores value correctly
endmodule
