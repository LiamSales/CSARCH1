

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

    // Toggle the clock every 5 ns, giving a full period of 10 ns.
    always #5 clk = ~clk;

    initial begin
        // Optional waveform output; open mdac.vcd with GTKWave to inspect it.
        $dumpfile("mdac.vcd");
        $dumpvars(0, tb_mdac);

        clk   = 1'b0;
        reset = 1'b1;
        btn   = 4'b0000;
        enter = 1'b0;
        clear = 1'b0;

        // Initialize all inputs, then hold synchronous reset through clock edges.
        repeat (3) @(posedge clk);
        reset = 1'b0;

        // Apply one valid button together with enter. This starts the FSM's
        // transition from LOCKED to INPUT; the current FSM stores a code only
        // when the same kind of submission happens while already in INPUT.
        btn   = 4'b0001;
        enter = 1'b1;
        @(posedge clk);
        enter = 1'b0;
        btn   = 4'b0000;
        repeat (2) @(posedge clk);

        // Apply two buttons together. invalid_input.v should report invalid,
        // so enter_pressed is false and this must not submit a code.
        btn   = 4'b0011;
        enter = 1'b1;
        @(posedge clk);
        enter = 1'b0;
        btn   = 4'b0000;
        repeat (2) @(posedge clk);

        // Submit the one-button password while in INPUT. The stored code is
        // compared with PASSWORD; VERIFY then chooses UNLOCKED or ERROR.
        btn   = 4'b0001;
        enter = 1'b1;
        @(posedge clk);
        enter = 1'b0;
        btn   = 4'b0000;
        repeat (3) @(posedge clk);

        // Clear returns ERROR or UNLOCKED to LOCKED.
        clear = 1'b1;
        @(posedge clk);
        clear = 1'b0;

        // End the simulation. Note: this testbench prints a waveform but does
        // not yet contain assertions that automatically pass/fail each test.
        repeat (3) @(posedge clk);
        $finish;
    end

endmodule
