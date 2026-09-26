//for simulation, pretend to be a user

`timescale 1ns/1ps

module tb_mdac;

    reg        clk;
    reg        reset;
    reg [3:0]  btn;
    reg        enter;
    reg        clear;

    wire       locked;
    wire       unlocked;
    wire       error;
    wire [2:0] state;

    mdac_top dut (
        .clk(clk),
        .reset(reset),
        .btn(btn),
        .enter(enter),
        .clear(clear),
        .locked(locked),
        .unlocked(unlocked),
        .error(error),
        .state(state)
    );

    // 10 ns clock period.
    always #5 clk = ~clk;

    initial begin
        $dumpfile("mdac.vcd");
        $dumpvars(0, tb_mdac);

        clk   = 1'b0;
        reset = 1'b1;
        btn   = 4'b0000;
        enter = 1'b0;
        clear = 1'b0;

        // Leave reset active for a few cycles.
        repeat (3) @(posedge clk);
        reset = 1'b0;

        // Test 1: valid code entry = 0001.
        btn   = 4'b0001;
        enter = 1'b1;
        @(posedge clk);
        enter = 1'b0;
        btn   = 4'b0000;
        repeat (2) @(posedge clk);

        // Test 2: invalid multi-button press.
        btn   = 4'b0011;
        enter = 1'b1;
        @(posedge clk);
        enter = 1'b0;
        btn   = 4'b0000;
        repeat (2) @(posedge clk);

        // Test 3: clear command from unlocked/error states.
        btn   = 4'b0001;
        enter = 1'b1;
        @(posedge clk);
        enter = 1'b0;
        btn   = 4'b0000;
        repeat (3) @(posedge clk);

        clear = 1'b1;
        @(posedge clk);
        clear = 1'b0;

        repeat (3) @(posedge clk);
        $finish;
    end

endmodule
