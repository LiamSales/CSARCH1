// unlike the gates in gates.v, this component remembers one bit
// d is the value waiting to be stored; q is the value currently remembered.


//if reset is 1, q becomes 0, superceeding everything else, just to turn q to 0, absolute case
//if reset is 0, then we make q turn to d... it could be 0 too, but were following d
module dff (
    input  wire clk,
    input  wire reset,
    input  wire d,
    output reg  q
);

    always @(posedge clk) begin
        if (reset)
            q <= 1'b0;
        else
            q <= d;
    end
endmodule
