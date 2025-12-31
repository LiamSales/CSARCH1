//flip flop 
//now we have memory

/*The lock must remember button presses

Remembering requires state

Flip-flops require a clock

“On the rising edge of the clock, copy input D to output Q.”
*/


module dff (
    input  wire clk,
    input  wire reset,
    input  wire d,
    output reg  q
);
