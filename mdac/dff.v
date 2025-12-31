//flip flop 
//now we have memory

/*The lock must remember button presses

Remembering requires state

Flip-flops require a clock

“On the rising edge of the clock, copy input D to output Q.”
*/


module dff (
    input  wire clk,     // system clock (rising-edge triggered)
    input  wire reset,   // synchronous reset
    input  wire d,       // data input (what we want to remember)
    output reg  q        // stored output (what we remember)
);

    // TODO:
    // 1. Use an always block triggered on the rising edge of clk
    // 2. If reset is asserted, force q to 0
    // 3. Otherwise, copy d into q
    //
    // RULES:
    // - Use non-blocking assignment (<=)
    // - Do NOT use combinational logic here
    // - This module represents real memory hardware

    // always @(posedge clk) begin
    //     ...
    // end

endmodule
