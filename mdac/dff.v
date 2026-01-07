module dff (
    input  wire clk, //pendulum
    input  wire reset,
    input  wire d,
    output reg  q
); // this stores exactly bit

    wire nd, gda, gdb, gdc, gdd, gm1, gm2, ;

    and_gate gd1(d, clk, gda);      // TODO: connect this to master latch properly (flip)
    not_gate gd2(gda, gdb);         // TODO: check if this goes to slave latch (flop)

    not_gate nd1(d, nd);                // TODO: use this inverted D correctly in your latch
    and_gate gd3(nd, clk, gdc);         // TODO: connect to other part of the latch
    not_gate gd4(gdc, gdd);             // TODO: complete feedback loop to hold value

    and_gate m1(gdb,gm1,);
    not_gate ma();
    and_gate m2(gdd,gm2,gm1);
    not_gate mb();

    //on paper figure out how to nand this ^



    always @(posedge clk) begin
        // TODO: implement synchronous reset
        // if (reset) q <= 0;

        // TODO: assign q to the correct combination of your gate outputs
        // q should only update on rising edge of clk
        // q should hold its previous value until next clock edge
    end

    // 1. Make a master-slave latch using your gda/gdb/gdc/gdd wires
    // 2. Connect the output of the slave latch to 'q'
    // 3. Ensure q updates only on rising edge of clk
    // 4. Implement synchronous reset: q = 0 when reset is high
    // 5. Test the DFF with a simple clk and d waveform to ensure it stores value correctly
endmodule
