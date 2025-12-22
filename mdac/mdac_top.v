module mdac_top (

    //Inside this module, you are allowed to place other modules.

    input  wire        clk, // input pin named clk, where time enters
    input  wire        reset,
    input  wire [3:0]  btn, //this is a bus(multiple wires); Four separate button wires bundled together.
    input  wire        enter,
    input  wire        clear,
    output wire        locked,
    output wire        unlocked,
    output wire        error,
    output wire [2:0]  state // 3 wires used for debugging
);
    // TODO: internal wires go here
            //we will declare wires that connect submodules.
            //work on everything else first then piece together here
    //  Do NOT implement logic yet. This is your system boundary
    // this is a physical block with pins

endmodule