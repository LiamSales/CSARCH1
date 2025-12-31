module mdac_top (

    input  wire        clk, 
    input  wire        reset,
    input  wire [3:0]  btn,
    input  wire        enter,
    input  wire        clear,
    output wire        locked,
    output wire        unlocked,
    output wire        error,
    output wire [2:0]  state
);

endmodule